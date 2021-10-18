#
# Cookbook Name:: Mailer-Service-Central
# Recipe:: default
#
# © 2018 24/7 Customer, Inc.
#
# All rights reserved - Do Not Redistribute
#
# author : ravi.b



#Download jar from the nexus
remote_file "#{node['Mailer-Service-Central']['Tellme-HOME']}/#{node['Mailer-Service-Central']['Mailer-ZIP']}" do
        source "#{node['Mailer-Service-Central']['Mailer-ZIP-URL']}"
        only_if { !Dir.exists?("#{node['Mailer-Service-Central']['Mailer-HOME']}") }
end


#Download Mailer from the Github
execute "Extract  Mailer from the Github" do
    cwd "#{node['Mailer-Service-Central']['Tellme-HOME']}"
    command "tar -zxvf #{node['Mailer-Service-Central']['Mailer-ZIP']} && chmod -R 755 #{node['Mailer-Service-Central']['Mailer-HOME']} && chown -R tellme:tellme #{node['Mailer-Service-Central']['Mailer-HOME']}"
    only_if { !Dir.exists?("#{node['Mailer-Service-Central']['Mailer-HOME']}") }
end



#Kill Mailer
execute "Kill  Mailer " do
    command "spiritMailer_pid=`ps aux | grep spiritMailer | grep -v grep | awk '{print $2}'`;if [ \"$spiritMailer_pid\" != \"\" ]; then `kill -9 $spiritMailer_pid`; fi"
    only_if { !Dir.exists?("#{node['Mailer-Service-Central']['Mailer-HOME']}") }
end

#Start Mailer service
execute "Starting Mailer Service" do
  cwd "#{node['Mailer-Service-Central']['Mailer-BIN-DIR']}"
  command "nohup ./spiritMailer start > #{node['Mailer-Service-Central']['Mailer-HOME']}/console.log 2>&1 &"
end

