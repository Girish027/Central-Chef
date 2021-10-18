#
# Cookbook Name:: DevPortal-Central
# Recipe:: default
#
# © 2017 24/7 Customer, Inc.
#
# All rights reserved - Do Not Redistribute
#
# author : rajasekhar

# #Install Java 8 if its not installed
package "#{node['Portal-Solr-Central']['JAVA']}" do
	action :install
end

# #Download jar from the nexus
remote_file "#{node['Portal-Solr-Central']['tellme']}/#{node['Portal-Solr-Central']['solr-tar']}" do
       source "#{node['Portal-Solr-Central']['solr-pack']}"
end
# #Currently downloading from apache repo but actually we should download from [24]7 nexus repo 
# execute "Download  solr " do
# 	proxy_url = `cat /tools/config/current/gold.conf | grep proxy`
#     proxy_url = proxy_url.split("=").last
#     proxy_url = proxy_url.strip
# 	cwd node['Portal-Solr-Central']['tellme']
# 	command " curl -O --proxy #{proxy_url} #{node['Portal-Solr-Central']['SOLR-PACK']}"
# end

# Extract apache solr from tar 
execute "Extract apache solr tar" do
  cwd node['Portal-Solr-Central']['tellme']
  command "tar -xzf #{node['Portal-Solr-Central']['solr-tar']}"
end
#enabling  authuntication 
template "#{node['Portal-Solr-Central']['solr-example']}/etc/jetty.xml" do
	  source "authentication/"+'jetty.xml'
	  owner "root"
	  group "root"
	  mode 00755
end
template "#{node['Portal-Solr-Central']['solr-example']}/etc/webdefault.xml" do
	  source "authentication/"+'webdefault.xml'
	  owner "root"
	  group "root"
	  mode 00755
end
template "#{node['Portal-Solr-Central']['solr-example']}/etc/realm.properties" do
	  source "authentication/"+'realm.properties'
	  owner "root"
	  group "root"
	  mode 00755
end


puts "Initializing devportal solr core .................................."
#Create devportal solr-core
execute "Create devportal solr-core" do
 cwd node['Portal-Solr-Central']['solr-server']
 command "mkdir #{node['Portal-Solr-Central']['devportal-core']}"
end


puts "creating conf, lib , data,  directories for devportal-solr-core"
devportal_core = "#{node['Portal-Solr-Central']['devportal-core-path']}/" 
devportal_core_directories = [	"#{node['Portal-Solr-Central']['solr-conf']}", "#{node['Portal-Solr-Central']['solr-data']}",
								"#{node['Portal-Solr-Central']['solr-lib']}" ]
for directory in devportal_core_directories 
	 directory  devportal_core+directory do
		  owner 'root'
		  group 'root'
		  mode '0755'
		  action :create
	 end
end	



puts "adding all conf to location "
confs = ['elevate.xml', 'schema.xml', 'solrconfig.xml', 'solrconfig_extra.xml','solrcore.properties','stopwords.txt','synonyms.txt',  'mapping-ISOLatin1Accent.txt', 'protwords.txt' , 'schema_extra_fields.xml' , 'schema_extra_types.xml']
for conf in confs 
  templateLocation = "#{node['Portal-Solr-Central']['devportal-template-conf']}/"+conf
  template templateLocation do
	  source 'conf/'+ conf
	  owner "root"
	  group "root"
	  mode 00755
   end
end	

puts "adding all devportal core properties"
properties = ['core.properties', 'core.properties.unloaded']
for property in properties 
  templateLocation = "#{node['Portal-Solr-Central']['devportal-core-path']}/"+property
  template templateLocation do
	  source "#{node['Portal-Solr-Central']['devportal-core']}/"+property
	  owner "root"
	  group "root"
	  mode 00755
   end
end

puts "...........................finished devportal initialization "

puts "Initializing docsportal solr core .................................."
#Create docsportal solr-core
execute "Create docsportal solr-core" do
 cwd node['Portal-Solr-Central']['solr-server']
 command "mkdir #{node['Portal-Solr-Central']['docsportal-core']}"
end


puts "creating conf, lib , data,  directories for docsportal-solr-core"
devportal_core = "#{node['Portal-Solr-Central']['docsportal-core-path']}/" 
devportal_core_directories = [	"#{node['Portal-Solr-Central']['solr-conf']}", "#{node['Portal-Solr-Central']['solr-data']}",
								"#{node['Portal-Solr-Central']['solr-lib']}" ]
for directory in devportal_core_directories 
	 directory  devportal_core+directory do
		  owner 'root'
		  group 'root'
		  mode '0755'
		  action :create
	 end
end	



puts "adding all conf to location "
confs = ['elevate.xml', 'schema.xml', 'solrconfig.xml', 'solrconfig_extra.xml','solrcore.properties','stopwords.txt','synonyms.txt',  'mapping-ISOLatin1Accent.txt', 'protwords.txt' , 'schema_extra_fields.xml' , 'schema_extra_types.xml']
for conf in confs 
  templateLocation = "#{node['Portal-Solr-Central']['docsportal-template-conf']}/"+conf
  template templateLocation do
	  source 'conf/'+ conf
	  owner "root"
	  group "root"
	  mode 00755
   end
end	

puts "adding all docsportal core properties"
properties = ['core.properties', 'core.properties.unloaded']
for property in properties 
  templateLocation = "#{node['Portal-Solr-Central']['docsportal-core-path']}/"+property
  template templateLocation do
	  source "#{node['Portal-Solr-Central']['docsportal-core']}/"+property
	  owner "root"
	  group "root"
	  mode 00755
   end
end

puts "...........................finished docsportal initialization "

# #starting solar service 
execute "starting solar service" do
  cwd "#{node['Portal-Solr-Central']['solr-example']}"
  command  "nohup java -jar start.jar &"
end




