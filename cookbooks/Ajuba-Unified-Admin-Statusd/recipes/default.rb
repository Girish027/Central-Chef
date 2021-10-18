#
# Cookbook Name:: Ajuba-Unified-Admin-Statusd
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

template "/tools/config/current/statusd.conf" do
    source "statusd.conf.erb"
    owner "root"
    group "root"
    mode "0644"
    variables(
        :location        => node["Ajuba-Unified-Admin-Statusd"]["location"],
        :webserver       => node["Ajuba-Unified-Admin-Statusd"]["webserver"],
        :probeserver     => node["Ajuba-Unified-Admin-Statusd"]["probeserver"],
        :release         => node["Ajuba-Unified-Admin-Statusd"]["release"],
        :mail_host       => node["Ajuba-Unified-Admin-Statusd"]["mail_host"]
    )
end

template "#{node['Ajuba-UAC-statusd']['statusd_uac']}" do
	source 'check_tomcat_uac.erb'
	owner 'root'
	group 'root'
	mode '0755'
end

execute "statusd" do
  command "/etc/init.d/tellme_statusd restart"
end

