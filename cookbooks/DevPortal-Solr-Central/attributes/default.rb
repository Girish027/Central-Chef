default['Portal-Solr-Central']['JAVA']="jdk1.8"
default['Portal-Solr-Central']['tellme'] = "/var/tellme"
default['Portal-Solr-Central']['solr-home'] = "#{node['Portal-Solr-Central']['tellme']}/solr-4.6.1"
default['Portal-Solr-Central']['solr-server'] = "#{node['Portal-Solr-Central']['solr-home']}/example/solr"
default['Portal-Solr-Central']['solr-example'] = "#{node['Portal-Solr-Central']['solr-home']}/example"
default['Portal-Solr-Central']['solr-tar'] = "solr-4.6.1.tgz"
default['Portal-Solr-Central']['solr-conf'] = "conf"
default['Portal-Solr-Central']['solr-data'] = "data"
default['Portal-Solr-Central']['solr-lib'] = "lib"
default['Portal-Solr-Central']['devportal-core'] = "devportal"
default['Portal-Solr-Central']['docsportal-core'] = "docsportal"
default['Portal-Solr-Central']['devportal-core-path'] = "#{node['Portal-Solr-Central']['solr-server']}/#{node['Portal-Solr-Central']['devportal-core']}"
default['Portal-Solr-Central']['docsportal-core-path'] = "#{node['Portal-Solr-Central']['solr-server']}/#{node['Portal-Solr-Central']['docsportal-core']}"
default['Portal-Solr-Central']['devportal-template-conf'] = "#{node['Portal-Solr-Central']['solr-server']}/#{node['Portal-Solr-Central']['devportal-core']}/#{node['Portal-Solr-Central']['solr-conf']}"
default['Portal-Solr-Central']['docsportal-template-conf'] = "#{node['Portal-Solr-Central']['solr-server']}/#{node['Portal-Solr-Central']['docsportal-core']}/#{node['Portal-Solr-Central']['solr-conf']}"


#Nexus repo is correct location to store third party packes but large files(more than 130MB files) not able to  dowload the files from nexus   
# So using yum repo to store files , had discussion with CICD need JIRA-Ref ::
#https://archive.apache.org/dist/lucene/solr/4.6.1/solr-4.6.1.tgz
default['Portal-Solr-Central']['solr-pack'] = 'http://build05.pool.sv2.247-inc.net/pvt_stg/solr-4.6.1.tgz'



case node.chef_environment
when 'CENTRAL-DEV'
	
else 
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end


		





