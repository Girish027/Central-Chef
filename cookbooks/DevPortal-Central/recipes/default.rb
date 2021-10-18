# #
# # Cookbook Name:: DevPortal-Central
# # Recipe:: default
# #
# # © 2017 24/7 Customer, Inc.
# #
# # All rights reserved - Do Not Redistribute
# #
# # author : rajasekhar

# isDevportalInstalled= false
# ruby_block "Check if deveportal installed is installed" do
#  block do
#     isInstalled=`if [ -d "#{node['DevPortal-Central']['DevP-Install-path']}" ]; then echo true; fi`
#     puts isInstalled;
#     # type(isInstalled);
#     if isInstalled.empty?
#       isDevportalInstalled = false
#     else
#       isDevportalInstalled = true
#     end
#   end
# end

# #Remove developer installation path 
# execute "Creating directory for taking  back of previous installation path  " do 
# 	command " mkdir $(date +%d-%m-%Y-%H-%M-%S)"
# 	only_if {  isDevportalInstalled }
# end

# #Remove developer installation path 
# execute "removing directory and files from portal instalation path" do 
# 	command "mv  #{node['DevPortal-Central']['DevP-Install-path']} #{node['DevPortal-Central']['DevP-Install-path']}-$(date +%d-%m-%Y-%H-%M-%S)"
# 	only_if {  isDevportalInstalled }
# end

# #Remove developer installation path 
# execute "removing developer source path" do 
#     command "rm -rf  #{node['DevPortal-Central']['DevP-SOURCE']}"
# end

# #Remove developer installation path 
# execute "removing developer tar if exists" do 
#     command "rm -rf  #{node['DevPortal-Central']['tellme']}/#{node['DevPortal-Central']['DevP-TAR']}"
# end

# Download jar from the nexus
# remote_file "#{node['DevPortal-Central']['tellme']}/#{node['DevPortal-Central']['DevP-TAR']}" do
#        source "#{node['DevPortal-Central']['DevP-TAR-LOCATION']}"
# end




# # Extract Devportal-binary-bundle-CentOS-6-x86_64 
# execute "Extract devportal-binary-bundle-CentOS-6-x86_64 tar" do
#   cwd node['DevPortal-Central']['tellme']
#   command "tar -xvf  #{node['DevPortal-Central']['DevP-TAR']}"
# end


# # change permission for install-from-rpm-bundle.sh
# execute "change permission for install-from-rpm-bundle.sh" do
#   cwd node['DevPortal-Central']['DevP-SOURCE']
#   command "chmod 755 install-from-rpm-bundle.sh"
# end

# # install-devportal-from-rpm-bundle.sh
# execute "install-devportal-from-rpm-bundle.sh" do
#  cwd node['DevPortal-Central']['DevP-SOURCE']
#  command "echo -e 'n\n#{node['DevPortal-Central']['DevP-Install-path']}\n \napigee\n'|  sudo ./install-from-rpm-bundle.sh" 
# end