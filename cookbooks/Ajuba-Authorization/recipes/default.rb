#
# Cookbook Name:: Ajuba-Authorization
# Recipe@@ default
#
# Copyright 2015, [24]7
#
# All rights reserved - Do Not Redistribute
#

include_recipe "Ajuba-Authorization::authorization-filebeat"

package "#{node['Central-java8']['JAVA']}" do
	action :install
end

directory "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}" do
	owner "tellme"
	group "tellme"
        mode 00755
        action :create
        recursive true
end

directory "#{node['Ajuba-Authorization']['BUILD-CONFIG-LOCATION']}" do
	owner "tellme"
    group "tellme"
        mode 00755
        action :create
        recursive true
end

directory "#{node['Ajuba-Authorization']['BUILD-BACKUP-LOCATION']}" do
	owner "tellme"
    group "tellme"
        mode 00755
        action :create
        recursive true
end

directory "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-HOME']}" do
	owner "tellme"
    group "tellme"
        mode 00755
        action :create
        recursive true
end

directory "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-BUILD']}" do
	owner "tellme"
    group "tellme"
        mode 00755
        action :create
        recursive true
end

directory "#{node['Ajuba-Authorization']['CONFIG-APP-JETTY-HOME']}" do
	owner "tellme"
    group "tellme"
        mode 00755
        action :create
        recursive true
end

directory "#{node['Ajuba-Authorization']['LOGGER-DIRECTORY-NAME']}" do
	owner "tellme"
    group "tellme"
        mode 00755
        action :create
        recursive true
end

template "/etc/init.d/tellme_authorization" do
	source "init.erb"
	owner "tellme"
    group "tellme"
    mode 00755
	variables(
		:logPath => node['Ajuba-Authorization']['LOGGER-DIRECTORY-NAME'],
		:appDir => node['Ajuba-Authorization']['APP-BASE-DIRECTORY']
	)
end

template "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-HOME']}/config-listener.properties" do
	source "config-listener.properties.erb"
	owner "tellme"
	group "tellme"
	variables(
		:ohsRestUrl => node["Ajuba-Authorization"]["OH-REST-URL"],
		:ohsPollingInterval => node["Ajuba-Authorization"]["OH-POLLING-SEC"]
	)
end

template "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-HOME']}/jetty.properties" do
	source "jetty.properties.erb"
	owner "tellme"
	group "tellme"
	variables(
			:jettyHome => node["Ajuba-Authorization"]["APP-JETTY-HOME"],
			:jettyPort => node["Ajuba-Authorization"]["APP-JETTY-PORT"]
	)
end

template "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-HOME']}/log4j.properties" do
	source "log4j.properties.erb"
	owner "tellme"
	group "tellme"
	variables(
		:logfile => node['Ajuba-Authorization']['LOGGER-FILE'],
		:loggerDatePattern => node['Ajuba-Authorization']['LOGGER-DATEPATTERN'],
		:loggerRootLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'],
		:loggerJgroupsLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'],
		:loggerJettyLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'],
		:loggerHibernateLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE']
	)
end

template "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-HOME']}/log4j2.properties" do
	source "log4j2.properties.erb"
	owner "tellme"
	group "tellme"
	variables(
		:logfile => node['Ajuba-Authorization']['LOGGER-FILE'],
		:loggerDatePattern => node['Ajuba-Authorization']['LOGGER-DATEPATTERN'],
		:loggerRootLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'],
		:loggerJgroupsLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'],
		:loggerJettyLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'],
		:loggerHibernateLevel => node['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE']
	)
end

template "#{node['Ajuba-Authorization']['CONFIG-APP-CONFIG-BUILD']}/OHAuthLauncher.ini" do
	source "OHAuthLauncher.ini.erb"
	owner "tellme"
	group "tellme"
	variables(
			:baseAppHome => node["Ajuba-Authorization"]['APP-CONFIG-HOME'],
	)
end

execute "Unzip_Authorization" do
	command "unzip -o #{node['Ajuba-Authorization']['BUILD-BACKUP-LOCATION']}/#{node['Ajuba-Authorization']['APP-JAR']} -d #{node['Ajuba-Authorization']['BUILD-BACKUP-LOCATION']}"
	action :nothing
end

execute "Copy_Build" do
    cwd "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}"
	command "cp -r #{node['Ajuba-Authorization']['BUILD-BACKUP-LOCATION']}/oh-auth-latest/oh-auth/* ."
	action :nothing
end


execute "Copy_bin" do
	cwd "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}"
    command "rm -f build/OHAuthLauncher.ini"
	command "cp -r #{node['Ajuba-Authorization']['BUILD-CONFIG-LOCATION']}/build/* build/"
	action :nothing
end

execute "Copy_conf" do
	cwd "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}"
	command "cp -r #{node['Ajuba-Authorization']['BUILD-CONFIG-LOCATION']}/conf/* conf/"
	action :nothing
end

remote_file "#{node['Ajuba-Authorization']['BUILD-BACKUP-LOCATION']}/#{node['Ajuba-Authorization']['APP-JAR']}" do
        source "#{node['Ajuba-Authorization']['ZIPFILE-DEPLOY']}"
        notifies :run, "execute[Kill_Authorization_App]", :immediately
        notifies :run, "execute[Unzip_Authorization]", :immediately
        notifies :run, "execute[Copy_Build]", :immediately
        notifies :run, "execute[Copy_bin]", :immediately
        notifies :run, "execute[Copy_conf]", :immediately
        notifies :run, "execute[Set_App_Permission]", :immediately
        notifies :run, "execute[Start_Authorization_App]", :immediately
        notifies :run, "execute[Finally]", :immediately
end

execute "Kill_Authorization_App" do
        command "ps -ef | grep OHAuthLauncher |grep -v grep| awk '{print $2}' | xargs kill -9 "
        ignore_failure true
        only_if "ps -ef | grep OHAuthLauncher |grep -v grep"
end


execute "Start_Authorization_App" do
	user "tellme"
		cwd "#{node['Ajuba-Authorization']['APP-CONFIG-BUILD']}"
		command "nohup ./OHAuthLauncher & > #{node['Ajuba-Authorization']['NOHUP-LOG-FILE']}"
    ignore_failure true
end

execute "Set_App_Permission" do
	command "chown -R tellme:tellme #{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/*"
	action :nothing
end

execute "Finally" do
        command "echo '\t*******Authorization Deployment DONE******\t'"
        action :nothing
end
