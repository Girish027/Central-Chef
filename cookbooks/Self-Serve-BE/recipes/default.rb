#
# Cookbook Name:: Self-Serve-BE
# Recipe:: default
#
# © 2019 24/7 Customer, Inc.
#
# All rights reserved - Do Not Redistribute
#
# author : sunilk

include_recipe "Self-Serve-BE::uninstall_jdk"
include_recipe "Self-Serve-BE::install_jdk"
include_recipe "Self-Serve-BE::css-filebeat"

# Create self-serve-backend home folder
directory "#{node['Self-Serve-BE']['CSS-APP-HOME']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create Build directory to downlaod jar in
directory "#{node['Self-Serve-BE']['CSS-APP-BUILD-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create config directory
directory "#{node['Self-Serve-BE']['CSS-APP-CONFIG-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create logs directory
directory "#{node['Self-Serve-BE']['CSS-APP-LOG-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create archive logs directory
directory "#{node['Self-Serve-BE']['CSS-APP-LOG-ARCHIVE-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Adding property files
template "#{node['Self-Serve-BE']['CSS-APP-CONFIG-DIR']}/application.properties" do
  source "application.properties.erb"
  owner "tellme"
  group "tellme"
  mode 0755
end

# Adding logback.xml
template "#{node['Self-Serve-BE']['CSS-APP-LOGBACK-URL']}" do
  source "logback.xml.erb"
  owner "tellme"
  group "tellme"
  mode 0755
  variables(
    :logsLoc => node['Self-Serve-BE']['CSS-APP-LOG-DIR']
	)
end

#directory "#{node['Self-Serve-BE']['CSS-APP-CONFIG-DIR']}/locale" do
	#source "locale/*"
	#owner "tellme"
	#group "tellme"
	#mode 0755
	#action :create
#end


# Adding css_be_log_cleanup.sh
template "#{node['Self-Serve-BE']['CSS-APP-CLEANUP-SCRIPT-URL']}" do
  source "css_be_log_cleanup.sh.erb"
  owner "tellme"
  group "tellme"
  mode 0755
  variables(
    :cssLogArchiveDir => node['Self-Serve-BE']['CSS-APP-LOG-ARCHIVE-DIR']
	)
end

#Adding restart script
template "#{node['Self-Serve-BE']['CSS-APP-CONFIG-DIR']}/restartCSS.sh" do
  source "restartCSS.sh.erb"
  owner "tellme"
  group "tellme"
  mode 0755
end

# Kill css process if its running
execute "Killing CSS if running" do
  command "css_pid=`ps aux | grep css | grep -v grep | awk '{print $2}'`;if [ \"$css_pid\" != \"\" ]; then `kill -9 $css_pid`; fi"
end

# Remove old css jar
execute "Remove old css jar" do
  command "rm -rf #{node['Self-Serve-BE']['CSS-APP-BUILD-DIR']}/#{node['Self-Serve-BE']['CSS-APP-WAR']}"
end

#Download jar from the nexus
remote_file "#{node['Self-Serve-BE']['CSS-APP-BUILD-DIR']}/#{node['Self-Serve-BE']['CSS-APP-WAR']}" do
  source "#{node['Self-Serve-BE']['WAR-REPO']}"
end


#Start CSS service
execute "Starting CSS Service" do
	command "nohup java -jar #{node['Self-Serve-BE']['CSS-APP-BUILD-DIR']}/css.jar --spring.config.location=#{node['Self-Serve-BE']['CSS-APP-CONFIG-DIR']}/application.properties > #{node['Self-Serve-BE']['CSS-APP-LOG-DIR']}/console.log 2>&1 &"
end

template "#{node['Self-Serve-BE']['Self-Serve-BEJava']}" do
  source 'check_process_css.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{node['Self-Serve-BE']['Self-Serve-BEhttp']}" do
  source 'check_http_css.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{node['Self-Serve-BE']['Self-Serve-BE-CheckLOG']}" do
  source 'check_css_log_expression.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

#Setting up Statusd Alerts
template "#{node['Self-Serve-BE']['CONF-FILE']}" do
  source 'statusd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

statusd_checks_array = Array.new

#checks added for cobp fe process should be removed when moving to separate host
statusd_checks_array.push('')
statusd_checks_array.push('statusd.plugin.check_process_node = [check_process][$HOSTADDRESS$ node ][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_process_nginx = [check_process][$HOSTADDRESS$ nginx ][1][1][default_check][$HOSTADDRESS$][NONE]')


ruby_block "append new checks" do
  block do
      final_array = statusd_checks_array
      fyle = File.open("#{node['Self-Serve-BE']['CONF-FILE']}","a")
      final_array.each do |element|
          fyle.puts element   
      end
      fyle.close
  end   
end


execute "statusd restart" do
  command "/etc/init.d/tellme_statusd restart"
end
