jdk_version = "#{node['Self-Serve-BE']['JAVA']}"

execute "Change ownership to root" do
 command "sudo su root"
end

log "Installing JDK..." do
    level :info
end
begin
    execute "Installing JDK..." do
        command "yum -y install #{jdk_version} --nogpg"
    end
rescue Exception => e
    puts "Exception while installing JDK! #{e}"
    raise e
end
log "JDK installed Successfully!!" do
    level :info
end