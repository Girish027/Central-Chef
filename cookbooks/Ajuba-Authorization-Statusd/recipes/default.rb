#
# Cookbook Name:: Ajuba-Authorization-Statusd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "#{node['Ajuba-Authorization-Statusd']['conf_dir']}/dont_delete" do
    owner "root"
    group "root"
    mode "0755"
    action :create
end

if !::File.exists?("#{node['Ajuba-Authorization-Statusd']['conf_dir']}/dont_delete/statusd.conf.bkp")
    execute "copy conf file" do
        cwd node['Ajuba-Authorization-Statusd']['statusd_conf_path']
        command "mv statusd.conf #{node['Ajuba-Authorization-Statusd']['conf_dir']}/dont_delete/statusd.conf.bkp"
    end
end

file "#{node['Ajuba-Authorization-Statusd']['statusd_conf_path']}/statusd.conf" do
     action :delete
     owner "root"
     group "root"
     mode "0755"
end

file "#{node['Ajuba-Authorization-Statusd']['statusd_conf_path']}/statusd.conf" do
     action :create
     owner "root"
     group "root"
     mode "0755"
end

statusd_checks_array = Array.new

cookbook_file "/usr/local/statusd/libexec/check_log_expression" do
    source "check_log_expression"
    mode "0755"
    owner "root"
    group "root"
end

statusd_checks_array.push('statusd.plugin.check_auth_connection_reset = [check_log_expression][0 1 1 "java.net.SocketException: Connection reset"  gt AuthorizationConnectionReset /var/tellme/ajuba-authorization/logs/logfile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_auth_connection_refused = [check_log_expression][0 1 1 "java.net.ConnectException: Connection refused:"  gt AuthorizationConnectError /var/tellme/ajuba-authorization/logs/logfile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_auth_process = [check_auth_process][][5][5][default_check][$HOSTADDRESS$]')
statusd_checks_array.push('statusd.plugin.check_process_filebeat = [check_process][$HOSTADDRESS$ filebeat=2,2][5][5][default_check][$HOSTADDRESS$]')

ruby_block "append new checks" do
    block do
        final_array = statusd_checks_array
        original_conf_file = File.read("#{node['Ajuba-Authorization-Statusd']['conf_dir']}/dont_delete/statusd.conf.bkp")
        fyle = File.open("#{node['Ajuba-Authorization-Statusd']['statusd_conf_path']}/statusd.conf","a")
        fyle.puts original_conf_file
        final_array.each do |element|
            fyle.puts element   
        end
        fyle.close
    end   
end

template "#{node['Ajuba-Authorization-Statusd']['statusd_auth_process']}" do
  source 'check_auth_process.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

execute "convert doc" do
	command "dos2unix /usr/local/statusd/libexec/check_log_expression"
end

execute "statusd" do
  command "/etc/init.d/tellme_statusd restart"
end

