execute "Change ownership to root" do
 command "sudo su root"
end

log "Uninstalling JDK..." do
    level :info
end
begin
    execute "Uninstalling all versions of JDK..." do
        command "yum -y remove java"
    end
rescue Exception => e
    puts "Exception while uninstalling jdk! #{e}"
    raise e
end
log "JDK Uninstalled Successfully!!" do
    level :info
end