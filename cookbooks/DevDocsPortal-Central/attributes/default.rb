default['DevDocsPortal-Central']['tellme'] = "/var/tellme"
default['DevDocsPortal-Central']['DevDocsPortal-Install-path'] = "/var/www/html"
default['DevDocsPortal-Central']['DevDocsPortal-SOURCE'] = "#{node['DevDocsPortal-Central']['tellme']}/devportal-binary-bundle-CentOS-6-x86_64"
default['DevDocsPortal-Central']['DevDocsPortal-TAR'] = "devportal-binary-bundle-CentOS-6-x86_64.tar.gz"
default['DevDocsPortal-Central']['DevDocsPortal-TAR-LOCATION'] = "nexus-location"

case node.chef_environment
when 'CENTRAL-DEV'
	
else 
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end


		





