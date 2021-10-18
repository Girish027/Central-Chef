#
# Cookbook Name:: COBP_BE-Central
# Recipe:: default
#
# © 2017 24/7 Customer, Inc.
#
# All rights reserved - Do Not Redistribute
#
# author : ravi.b

# Create cobp home folder
directory "#{node['COBP_FE-Central']['COBP-APP-HOME']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

# Create cobp logs folder
directory "#{node['COBP_FE-Central']['COBP-LOG-DIR']}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

isNodeInstalled= false
ruby_block "Check if node is installed" do
 block do
    isInstalled=`if type node &> /dev/null ; then   echo true; fi`
    puts isInstalled;
    # type(isInstalled);
    if isInstalled.empty?
      isNodeInstalled = false
    else
      isNodeInstalled = true
    end
  end
end

#Adding restart script
template "#{node['COBP_FE-Central']['COBP-APP-HOME']}/restartCOBP.sh" do
        source "restartCOBP.sh.erb"
        owner "tellme"
        group "tellme"
        mode 0755
end

# Create cobp bin folder
directory "#{node['COBP_FE-Central']['COBP-APP-BIN-DIR']}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

#Check process CSS running
template "#{node['COBP_FE-Central']['COBP_FE-CentralJava']}" do
  source 'check_process_css.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

# Adding cobp_fe_log_cleanup.sh
template "#{node['COBP_FE-Central']['COBP-APP-CLEANUP-SCRIPT-URL']}" do
        source "cobp_fe_log_cleanup.sh.erb"
        owner "tellme"
        group "tellme"
        mode 0755
        variables(
        		:cobpLogArchiveDir => node['COBP_FE-Central']['COBP-APP-LOG-ARCHIVE-DIR']
	)
end

# Download Node if not installed
remote_file "#{node['COBP_FE-Central']['COBP-USR-LOCAL']}/#{node['COBP_FE-Central']['COBP-NODE-TAR']}" do
    source "#{node['COBP_FE-Central']['COBP-NODE-DURL']}"
    only_if { ! isNodeInstalled }
end

execute "Installing NodeJS" do
  cwd node['COBP_FE-Central']['COBP-USR-LOCAL']
  command "tar --strip-components 1 -xzf #{node['COBP_FE-Central']['COBP-NODE-TAR']} && rm -rf #{node['COBP_FE-Central']['COBP-NODE-TAR']}"
  only_if { ! isNodeInstalled }
end


# Kill cobp process if its running
execute "Killing COBP if running" do
  command "cobp_pid=`ps aux | grep node | grep -v grep | awk '{print $2}'`;if [ \"$cobp_pid\" != \"\" ]; then `kill -9 $cobp_pid`; fi"
end

# Remove old cobp-fe tar
execute "Remove old cobp tar" do
  command "rm -rf #{node['COBP_FE-Central']['COBP-APP-HOME']}/#{node['COBP_FE-Central']['COBP-APP-TAR']} #{node['COBP_FE-Central']['COBP-APP-BUILD-DIR']}"
end

#Download tar from the nexus
remote_file "#{node['COBP_FE-Central']['COBP-APP-HOME']}/#{node['COBP_FE-Central']['COBP-APP-TAR']}" do
        source "#{node['COBP_FE-Central']['WAR-REPO']}"
end

# Extract from tar
execute "Extract cobp tar" do
  cwd node['COBP_FE-Central']['COBP-APP-HOME']
  command "tar -xzf #{node['COBP_FE-Central']['COBP-APP-TAR']}"
end

# Set SSO URL
execute "Setting SSO URL" do
  cwd node['COBP_FE-Central']['COBP-APP-BUILD-DIR']
  command "sed -i \"s/https:\\/\\/sso.central-dev.lb-priv.sv2.247-inc.net\\/auth/#{node['COBP_FE-Central']['COBP-FE-SSO-URL']}/g\" \"server.js\" "
end

# Adding application.config.json
template "#{node['COBP_FE-Central']['COBP-APP-BUILD-DIR']}/application.config.json" do
        source "application.config.json.erb"
        owner "tellme"
        group "tellme"
        mode 0755
        variables(
            :cobpOktaUrl => node['COBP_FE-Central']['OKTA-URL'],
            :cobpOktaIssuer => node['COBP_FE-Central']['OKTA-ISSUER'],
            :cobpOktaClientId => node['COBP_FE-Central']['OKTA-CLIENT-ID'],
            :cobpOktaLoginRedirectUri => node['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'],
            :cobpOktaScopes => node['COBP_FE-Central']['OKTA-SCOPES']
  )
end



execute "Starting COBP Service" do
  cwd node['COBP_FE-Central']['COBP-APP-BUILD-DIR']
  command "nohup npm start > #{node['COBP_FE-Central']['COBP-LOG-DIR']}/console.log 2>&1 &"
end


## NGINX #####

#Install NGINX
package "nginx" do
  action :install
end

template "/etc/nginx/conf.d/default.conf" do
  source "default.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  owner "root"
  group "root"
  mode "0644"
end

template "/etc/logrotate.d/nginx" do
  source "nginx.erb"
  owner "root"
  group "root"
  mode "0644"
end

#Setting up Statusd Alerts
template "#{node['COBP_FE-Central']['CONF-FILE']}" do
  source 'statusd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

statusd_checks_array = Array.new

#checks added for CSS BE process should be removed when moving to separate host
statusd_checks_array.push('')
statusd_checks_array.push('statusd.plugin.check_process_css = [check_process_css][][5][5][default_check][$HOSTADDRESS$]')


ruby_block "append new checks" do
  block do
      final_array = statusd_checks_array
      fyle = File.open("#{node['COBP_FE-Central']['CONF-FILE']}","a")
      final_array.each do |element|
          fyle.puts element   
      end
      fyle.close
  end   
end

execute "statusd restart" do
  command "/etc/init.d/tellme_statusd restart"
end


#start NGINX service
service "nginx" do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :restart]
end


# Kill cobp process if its running
execute "Killing COBP if running" do
  command "cobp_pid=`ps aux | grep node | grep -v grep | awk '{print $2}'`;if [ \"$cobp_pid\" != \"\" ]; then `kill -9 $cobp_pid`; fi"
end


execute "Starting COBP Service" do
  cwd node['COBP_FE-Central']['COBP-APP-BUILD-DIR']
  command "nohup npm start > #{node['COBP_FE-Central']['COBP-LOG-DIR']}/console.log 2>&1 &"
end