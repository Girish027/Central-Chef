# Cookbook Name:: Ajuba-Unified-Admin
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "Ajuba-Unified-Admin-Service::db"

include_recipe "Ajuba-Unified-Admin-Service::uac-filebeat"



node.override['Central-tomcat8']['target'] = "#{node['Ajuba-Admin']['APP-DIR']}"
node.override['Central-tomcat8']['home'] = "#{node['Central-tomcat8']['target']}/tomcat"
node.override['Central-tomcat8']['webapps'] = "#{node['Central-tomcat8']['home']}/webapps"
node.override['Central-tomcat8']['log'] = "#{node['Central-tomcat8']['home']}/logs"
node.override['Central-tomcat8']['REDIRECT_PORT'] = 8884

include_recipe "Central-tomcat8"

#Install Java 8 if its not installed
package "#{node['Central-java8']['JAVA']}" do
  action :install
end

directory "#{node['Ajuba-Admin']['APP-DIR']}" do
	owner "tellme"
	group "tellme"
	action :create
	recursive true
end

directory "#{node['Ajuba-Admin']['APP-BUILD-DIR']}" do
	owner "tellme"
	group "tellme"
	action :create
	recursive true
end

directory "#{node['Ajuba-Admin']['APP-CONFIG-DIR']}" do
	owner "tellme"
	group "tellme"
	action :create
	recursive true
end

directory "#{node['Ajuba-Admin']['APP-LOG-DIR']}" do
	owner "tellme"
	group "tellme"
    mode 00755
	action :create
	recursive true
end

directory "#{node['Ajuba-tomcat7']['log']}" do
        owner "tellme"
        group "tellme"
        mode 00755
        action :create
        recursive true
end

template "#{node['Ajuba-Admin']['APP-CONFIG-DIR']}/ajuba-admin.properties" do
        source "ajuba-admin.properties.erb"
        owner "tellme"
        group "tellme"
        mode 0755
	variables(
		:adminOHSUrl => node['Ajuba-Admin']['APP-OHS-URL'],
		:adminAuthSingleLogin => node['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'],
		:adminAuthSingleUserName => node['Ajuba-Admin']['APP-AUTH-SINGLE-USER'],
		:adminAuthUserAttribute => node['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'],
		:adminUserAttributeAttr1 => node['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'],
		:adminUserAttributeAttr2 => node['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'],
		:adminUserAttributeAttr3 => node['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'],
    :LocaleEnv => node['Ajuba-Admin']['APP-LOCALE-ENV'],
		:phantomjsDownloadServerMode => node['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'],
		:adminAuthSSOLoginProtocol => node['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'],
		:adminAuthSSOLoginURI => node['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'],
		:serverOpenAMEnabled => node['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED']
	)
end

template "#{node['Ajuba-Admin']['APP-CONFIG-DIR']}/AppConfigs.groovy" do
        source "ajuba-admin-AppConfigs.groovy.erb"
        owner "tellme"
        group "tellme"
        mode 0755
	variables(
		:adminMysqlUrl => node['Ajuba-Admin']['APP-MYSQL-URL'],
		:adminLogPath => node['Ajuba-Admin']['APP-LOG-DIR'],
		:adminMysqlUser => node['Ajuba-Admin']['db_username'],
		:adminMysqlPassword => node['Ajuba-Admin']['db_password']
	)
end

template "#{node['Ajuba-tomcat7']['home']}/lib/log4j.properties" do
	source "log4j.properties.erb"
	owner "tellme"
        group "tellme"
        mode 0755
	variables(
		:logPath => node['Ajuba-tomcat7']['log']
	)
end


template "#{node['Ajuba-tomcat7']['home']}/bin/catalina.sh" do
        source "catalina.sh.erb"
        owner "tellme"
        group "tellme"
        mode 0755
end

remote_file "#{node['Ajuba-Admin']['APP-BUILD-DIR']}/#{node['Ajuba-Admin']['APP-WAR']}" do
        source "#{node['Ajuba-Admin']['ZIPFILE-DEPLOY']}"
	notifies :run, "execute[Deploy_war]", :immediately
	notifies :run, "execute[Remove_folder]", :immediately
        notifies :run, "execute[Start_Tomcat]", :immediately
        notifies :run, "execute[Successful_Deploy]", :immediately
end

# Kill UAC process if its running
execute "Killing UAC if running" do
	command "uac_pid=`ps aux | grep #{node['Ajuba-Admin']['tomcathome']} | grep -v grep | awk '{print $2}'`;if [ \"$uac_pid\" != \"\" ]; then `kill -9 $uac_pid`; fi"
end
  
execute "Deploy_war" do
	command "cp #{node['Ajuba-Admin']['APP-BUILD-DIR']}/#{node['Ajuba-Admin']['APP-WAR']} #{node['Ajuba-tomcat7']['webapps']}/"
	action :nothing
end

execute "Remove_folder" do
	command "rm -rf #{node['Ajuba-tomcat7']['webapps']}/ajuba-admin"
	action:nothing
end

execute "Start_Tomcat" do
        command ".#{node['Ajuba-tomcat7']['target']}/tomcat/bin/startup.sh start"
end

execute "Successful_Deploy" do
        command "echo '\t*******DONE******\t'"
        action :nothing
end