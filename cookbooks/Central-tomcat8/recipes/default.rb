#
# Cookbook Name:: tomcat7
# Recipe:: default
#
# Copyright 2011,
#
# All rights reserved - Do Not Redistribute
#

puts node['Central-tomcat8']['JAVAOPTS']

tc8ver = node["Central-tomcat8"]["version"]
tc8zip = "tomcat-8.0.50.zip"
tc8url = node['Central-tomcat8']['download_url']
tc8target = node["Central-tomcat8"]["target"]
tc8bin = node['Central-tomcat8']['bin']
tc7user = node["Central-tomcat8"]["user"]
tc7group = node["Central-tomcat8"]["group"]

directory "#{tc8target}" do
  owner "tellme"
  group "tellme"
  mode "0755"
  action :create
  recursive true
end

if !::File.directory?("#{node['Central-tomcat8']['home']}")
  # Get the tomcat binary
  remote_file "#{tc8target}/#{tc8zip}" do
      source "#{tc8url}"
      mode "0644"
    action :create
  end
  execute "unzip tomcat" do
    cwd "#{tc8target}"
    user "tellme"
    group "tellme"
    command "unzip -o #{tc8zip}"
  end

  execute "rename directory" do
    cwd "#{tc8target}"
    user "tellme"
    group "tellme"
    command "mv apache-tomcat-#{node['Central-tomcat8']['version']} tomcat"
  end
end

# # Set the symlink
# link "#{tc8target}/tomcat" do
#     to "tomcat-8.0.50"
#     link_type :symbolic
# end

if !::File.directory?("#{node['Central-tomcat8']['webapps']}")
  directory "#{node['Central-tomcat8']['webapps']}" do
    owner "tellme"
    group "tellme"
    mode "0755"
    action :create
    recursive true
  end
end

directory "#{node['Central-tomcat8']['log']}" do
  owner "tellme"
  group "tellme"
  mode "0755"
  action :create
  recursive true
end

directory "#{node['Central-tomcat8']['home']}/temp" do
  owner "tellme"
  group "tellme"
  mode "0755"
  action :create
  recursive true
end

execute "give permission to tellme user" do
  command "chown -R tellme:tellme #{node['Central-tomcat8']['log']}"
end

execute "give permission to tellme user" do
  command "chown -h tellme:tellme #{node['Central-tomcat8']['home']}"
end

execute "give permission to tellme user" do
  command "chown -h tellme:tellme #{node['Central-tomcat8']['home']}"
end

# Added below 2 sections to hide apache tomcat version being appear in default  or error page.
directory "#{node['Central-tomcat8']['home']}/lib/org/apache/catalina/util" do
  owner "tellme"
  group "tellme"
  mode "0755"
  action :create
  recursive true
end

template "#{node['Central-tomcat8']['home']}/lib/org/apache/catalina/util/ServerInfo.properties" do
  source "ServerInfo.properties.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

#add server.xml
template "#{node['Central-tomcat8']['home']}/conf/server.xml" do
  source "server.xml.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
  variables({
       :tomcat_port          => node['Central-tomcat8']['port'],
       :tomcat_ssl_port      => node['Central-tomcat8']['ssl_port'],
       :tomcat_ajp_port      => node['Central-tomcat8']['ajp_port'],
       :tomcat_shutdown_port => node['Central-tomcat8']['shutdown_port'],
       :ServerXmlDocbase     => node['Central-tomcat8']['SERVER_XML_DOCBASE'],
       :ServerXmlPath        => node['Central-tomcat8']['SERVER_XML_PATH'],
       :Redirect_Port        => node['Central-tomcat8']['REDIRECT_PORT']
    })
end

# Add the init-script
template "/etc/init.d/tomcat8-cm" do
  source "tomcat8-cm.erb"
	owner "tellme"
	group "tellme"
	mode "0755"
  variables({
       :tomcat_logs     => node['Central-tomcat8']['log'],
       :tomcat_base_dir => node['Central-tomcat8']['home']
    })
end

template "#{node['Central-tomcat8']['home']}/bin/catalina.sh" do
  source "catalina.sh.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
  variables(
{
	:JavaOpts => node['Central-tomcat8']['JAVAOPTS']
}
)
end

template "#{node['Central-tomcat8']['home']}/conf/catalina.properties" do
  source "catalina.properties.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/catalina.policy" do
  source "catalina.policy.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/context.xml" do
  source "context.xml.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/server_xml_template.xml" do
  source "server_xml_template.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/tomcat-users.xml" do
  source "tomcat-users.xml.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/web.xml" do
  source "web.xml.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/logging.properties" do
  source "logging.properties.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "#{node['Central-tomcat8']['home']}/conf/tomcat-users.xsd" do
  source "tomcat-users.xsd.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end



template "#{node['Central-tomcat8']['home']}/bin/killContainer.sh" do
  source "killContainer.sh.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
end

template "/etc/init.d/#{node['Central-tomcat8']['init.d']}" do
  source "tellme_tomcat.erb"
  owner "tellme"
  group "tellme"
  mode "0755"
  variables({
       :tomcatUser          => node['Central-tomcat8']['user'],
       :tomcatStartScript      => node['Central-tomcat8']['START_SCRIPT'],
       :tomcatStopScript      => node['Central-tomcat8']['STOP_SCRIPT']
    })
end

execute "give permission to tellme user" do
  command "chown -R tellme:tellme #{node['Central-tomcat8']['target']}"
end

execute "give permission to tellme user on tomcat bin" do
  command "chmod -R 755 #{node['Central-tomcat8']['home']}/bin"
end
