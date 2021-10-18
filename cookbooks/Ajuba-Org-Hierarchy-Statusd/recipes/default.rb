#
# Cookbook Name:: Ajuba-Org-Hierarchy-Statusd
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#directory "#{node['Ajuba-Org-Hierarchy-Statusd']['conf_dir']}/dont_delete" do
#    owner "root"
#    group "root"
#    mode "0755"
#    action :create
#end

if (File.exists?("#{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']}"))
    execute "Backup statusd conf file" do
        command "mv #{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']} #{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']}.bkp"
    end
end

#file "#{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']}" do
#     action :delete
#     owner "root"
#     group "root"
#     mode "0755"
#end
#
#file "#{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']}" do
#     action :create
#     owner "root"
#     group "root"
#     mode "0755"
#end

#### statusd template ############################
template "#{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']}" do
  source 'statusd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end


template "#{node['Ajuba-Org-Hierarchy-Statusd']['statusd_ohs']}" do
  source 'check_tomcat_ohs.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{node['Ajuba-Org-Hierarchy-Statusd']['statusd_uac']}" do
  source 'check_tomcat_uac.erb'
  owner 'root'
  group 'root'
  mode '0755'
end
#### statusd template ############################

statusd_checks_array = Array.new

cookbook_file "/usr/local/statusd/libexec/check_log_expression" do
    source "check_log_expression"
    mode "0755"
    owner "root"
    group "root"
end

statusd_checks_array.push('statusd.plugin.check_ohs_oom = [check_log_expression][0 1 1 "OutOfMemoryError" gt OHSOutOfMemory /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_db_lock_acquire_error = [check_log_expression][0 1 1 "com.tfsc.ilabs.core.events.reload.api.FailedToAquireLockException: could not extract ResultSet" gt OHSDBLockAcquireException /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_polling_error = [check_log_expression][0 1 1 "impl.ConfigLockManager [ERROR] - Error while polling"  gt OHSPollingError /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_db_connection_error = [check_log_expression][0 1 1 "The last packet successfully received from the server was"  gt OHSDBConnectionError /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_jdbc_exceptions = [check_log_expression][0 1 1 "Caused by: com.mysql.jdbc.exceptions"  gt OHSJDBCExceptions /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_connection_refused = [check_log_expression][0 1 1 "java.net.ConnectException: Connection refused:"  gt OHSConnectionRefused /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_connection_reset = [check_log_expression][0 1 1 "java.net.SocketException: Connection reset" gt OHSConnectionReset /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs_db_link_failure = [check_log_expression][0 1 1 "Communications link failure"  gt OHSCommunicationLinkFailure /var/tellme/OHS/logs/ohsLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_auth_service_connection_error = [check_log_expression][0 1 1 "Failed to communicate with auth service"  gt AdminAuthServiceConnectionError /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_connection_refused = [check_log_expression][0 1 1 "javax.ws.rs.ProcessingException: java.net.ConnectException: Connection refused:" gt AdminConnectionRefused /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_service_unavailable = [check_log_expression][0 1 1 "javax.ws.rs.ServiceUnavailableException: HTTP 503 Service Temporarily Unavailable" gt AdminServiceUnavailableError /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_service_connection_error = [check_log_expression][0 1 1 "Cannot contact the service http://"  gt AdminServiceConnectionError /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_request_error = [check_log_expression][0 1 1 "utils.RestClient [ERROR] - Unable to execute the get request" gt AdminGetRequestError /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_connection_reset = [check_log_expression][0 1 1 "java.net.SocketException: Connection reset" gt AdminConnectionReset /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_admin_user_invalid = [check_log_expression][0 1 1 "controllers.EntityController [ERROR] - Invalid user with id null" gt AdminInvalidUser /var/tellme/ajuba-admin/logs/adminLogFile.log sum][1][1][default_check][$HOSTADDRESS$][NONE]')
statusd_checks_array.push('statusd.plugin.check_ohs = [check_tomcat_ohs][][5][5][default_check][$HOSTADDRESS$]')
statusd_checks_array.push('statusd.plugin.check_uac = [check_tomcat_uac][][5][5][default_check][$HOSTADDRESS$]')
statusd_checks_array.push('statusd.plugin.check_process_filebeat = [check_process][$HOSTADDRESS$ filebeat=2,2][5][5][default_check][$HOSTADDRESS$]')

ruby_block "append new checks" do
    block do
        final_array = statusd_checks_array
        #original_conf_file = File.read("#{node['Ajuba-Org-Hierarchy-Statusd']['conf_dir']}/dont_delete/statusd.conf.bkp")
        fyle = File.open("#{node['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']}","a")
        #fyle.puts original_conf_file
        final_array.each do |element|
            fyle.puts element   
        end
        fyle.close
    end   
end

execute "convert doc" do
	command "dos2unix /usr/local/statusd/libexec/check_log_expression"
end

execute "statusd" do
  command "/etc/init.d/tellme_statusd restart"
end