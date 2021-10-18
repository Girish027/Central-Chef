filebeat_version = "#{node['filebeat']['version']}"
cert_path ="#{node['filebeat']['certpath']}"

execute "Change ownership to root" do
 command "sudo su root"
end

#-------------- INSTALL FILEBEAT --------------
log "Installing Filebeat..." do
    level :info
end
begin
    execute "Installing Filebeat..." do
        command "yum -y install #{filebeat_version}"
    end
rescue Exception => e
    puts "Exception while installing filebeat! #{e}"
    raise e
end
log "Filebeat installed Successfully!!" do
    level :info
end
###### Finished Installing Filebeat Successfully!!

###### Copy the Certificate and Key
log "Copying the Certificate and Key..." do
    level :info
end
begin
    template "#{cert_path}/file_beat.crt" do
        source "filebeat.crt.erb"
        owner "root"
        mode "0644"
    end

    template "#{cert_path}/file_beat.key" do
        source "filebeat.key.erb"
        owner "root"
        mode "0644"
    end
rescue Exception => e
    puts "Exception while copying Certificate and Key! #{e}"
    raise e
end
log "Certificate and Key copied Successfully!!" do
    level :info
end
