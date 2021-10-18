#
# Cookbook Name:: Self-Serve-UI
# Recipe:: default
#
# © 2017 24/7 Customer, Inc.
#
# All rights reserved - Do Not Redistribute
#
# author : sushil.kumar

env = node.chef_environment


directory "#{node['Self-Serve-UI']['CSS-APP-HOME']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

# Create css logs folder
directory "#{node['Self-Serve-UI']['CSS-LOG-DIR']}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

# Create css bin folder
directory "#{node['Self-Serve-UI']['CSS-APP-BIN-DIR']}" do
  owner "root"
  group "root"
  mode 00755
  action :create
end

# Remove old css-fe zip
execute "Remove old css zip" do
  command "rm -rf #{node['Self-Serve-UI']['CSS-APP-HOME']}/#{node['Self-Serve-UI']['CSS-APP-TAR']} #{node['Self-Serve-UI']['CSS-APP-BUILD-DIR']}"
end

#Download zip from the nexus
remote_file "#{node['Self-Serve-UI']['CSS-APP-HOME']}/#{node['Self-Serve-UI']['CSS-APP-TAR']}" do
    source "#{node['Self-Serve-UI']['WAR-REPO']}"
end


# Extract from zip
execute "Extract css zip" do
  cwd node['Self-Serve-UI']['CSS-APP-HOME']
  command "unzip -o #{node['Self-Serve-UI']['CSS-APP-TAR']}"
end


#Setting up Statusd Alerts
template "#{node['Self-Serve-UI']['CONF-FILE']}" do
  source 'statusd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end



execute "statusd restart" do
  command "/etc/init.d/tellme_statusd restart"
end


