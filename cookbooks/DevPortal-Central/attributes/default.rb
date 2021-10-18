default['DevPortal-Central']['tellme'] = "/var/tellme"
default['DevPortal-Central']['DevP-Install-path'] = "#{node['DevPortal-Central']['tellme']}/Developer-portal"
default['DevPortal-Central']['DevP-SOURCE'] = "#{node['DevPortal-Central']['tellme']}/devportal-binary-bundle-CentOS-6-x86_64"
default['DevPortal-Central']['DevP-TAR'] = "devportal-binary-bundle-CentOS-6-x86_64.tar.gz"
default['DevPortal-Central']['DevP-TAR-LOCATION'] = "nexus-location"

case node.chef_environment
when 'CENTRAL-DEV'
	
else 
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end


		





