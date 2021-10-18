# Cookbook Name:: Ajuba-Org-Hierarchy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute

include_recipe "Ajuba-Org-Hierarchy-Service::ohs-filebeat"

node.override['Central-tomcat8']['target'] = "#{node['Ajuba-OHS']['OHS-APP-DIR']}"
node.override['Central-tomcat8']['home'] = "#{node['Central-tomcat8']['target']}/tomcat"
node.override['Central-tomcat8']['webapps'] = "#{node['Central-tomcat8']['home']}/webapps"
node.override['Central-tomcat8']['config_dir'] = "#{node['Central-tomcat8']['home']}/conf"
node.override['Central-tomcat8']['log'] = "#{node['Central-tomcat8']['home']}/logs"

include_recipe "Central-tomcat8"
#Install Java 8 if its not installed
package "#{node['Central-java8']['JAVA']}" do
  action :install
end
include_recipe "Ajuba-Org-Hierarchy-Service::db"


directory "#{node['Ajuba-OHS']['OHS-APP-DIR']}" do
        owner "root"
        group "root"
        action :create
        recursive true
end

directory "#{node['Ajuba-OHS']['OHS-APP-BUILD-DIR']}" do
        owner "root"
        group "root"
        action :create
        recursive true
end

directory "#{node['Ajuba-OHS']['OHS-APP-CONFIG-DIR']}" do
        owner "root"
        group "root"
        action :create
        recursive true
end

directory "#{node['Ajuba-OHS']['OHS-APP-LOG-DIR']}" do
	owner "root"
	group "root"
    	mode 00755
	action :create
	recursive true
end


directory "#{node['Central-tomcat8']['log']}" do
        owner "root"
        group "root"
        mode 00755
        action :create
        recursive true
end


template "#{node['Central-tomcat8']['home']}/lib/log4j.properties" do
	source "log4j.properties.erb"
	owner "root"
        group "root"
        mode 0755
	variables(
		:logPath => node['Central-tomcat8']['log']
	)
end

template "#{node['Central-tomcat8']['home']}/bin/catalina.sh" do
        source "catalina.sh.erb"
        owner "root"
        group "root"
        mode 0755
        variables(
	        :ohsJvmMemory => node['Ajuba-OHS']['APP-JVM-MEMORY']
        )
end

template "#{node['Ajuba-OHS']['OHS-APP-CONFIG-DIR']}/OHSConfig.groovy" do
        source "ohs-OHSConfigs.groovy.erb"
        owner "root"
        group "root"
        mode 0755
        variables(
	        :ohsMysqlUrl => node['Ajuba-OHS']['APP-MYSQL-URL'],
                :ohsMysqlUrlRead => node['Ajuba-OHS']['APP-MYSQL-URL-READ'],
                :ohsMysqlUser => node['Ajuba-OHS']['db_username'],
                :ohsMysqlPassword => node['Ajuba-OHS']['db_password'],
                :ohsMysqlUserRead => node['Ajuba-OHS']['db_read_username'],
                :ohsMysqlPasswordRead => node['Ajuba-OHS']['db_read_password'],
				:versioningCacheSize => node['Ajuba-OHS']['VERSIONING-CACHE-SIZE'],
                :versioningBatchSize => node['Ajuba-OHS']['VERSIONING-BATCH-SIZE'],
                :ohsLogPath => node['Ajuba-OHS']['OHS-APP-LOG-DIR'],
				:ajubaDefaultLicenceName => node['Ajuba-OHS']['AJUBA-DEFAULT-LICENCE-NAME'],
				:adjubaAdminPermissions => node['Ajuba-OHS']['AJUBA-ADMIN-PERMISSIONS'],
				:ajubaInsightsPermissions => node['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'],
                :ohsServerName => node['Ajuba-OHS']['AJUBA-SERVER-URL']
	)
end

log 'message' do
  message 'A message add to the log.'
  level :info
end

remote_file "#{node['Ajuba-OHS']['OHS-APP-BUILD-DIR']}/#{node['Ajuba-OHS']['OHS-APP-WAR']}" do
        source "#{node['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY']}"
        notifies :run, "execute[Kill_OHS_if_running]", :immediately
        notifies :run, "execute[Deploy_OHS_war]", :immediately
        notifies :run, "execute[Remove_OHS_war]", :immediately
        notifies :run, "execute[Start_Tomcat]", :immediately
        notifies :run, "execute[Successful_Deploy]", :immediately
end

# Kill OHS process if its running
execute "Kill_OHS_if_running" do
	command "ohs_pid=`ps aux | grep #{node['Central-tomcat8']['home']} | grep -v grep | awk '{print $2}'`;if [ \"$ohs_pid\" != \"\" ]; then `kill -9 $ohs_pid`; fi"
end

execute "Remove_OHS_war" do
	command "rm -rf #{node['Central-tomcat8']['webapps']}/org-hierarchy-service"
        action :nothing
end

execute "Deploy_OHS_war" do
        command "cp #{node['Ajuba-OHS']['OHS-APP-BUILD-DIR']}/#{node['Ajuba-OHS']['OHS-APP-WAR']} #{node['Central-tomcat8']['webapps']}/"
        action :nothing
end

execute "Start_Tomcat" do
        command ".#{node['Central-tomcat8']['target']}/tomcat/bin/startup.sh start"
end

execute "Successful_Deploy" do
        command "echo '\t*******DONE******\t'"
        action :nothing
end