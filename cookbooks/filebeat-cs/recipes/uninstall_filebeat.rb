execute "Change ownership to root" do
 command "sudo su root"
end

log "Un-linking the Platinum Filebeat installation..." do
    level :info
end
begin
    link '/usr/local/filebeat' do
        action :delete
        only_if 'test -L /usr/local/filebeat'
    end
rescue Exception => e
    puts "Exception while unlinking Platinum installation of filebeat! #{e}"
    #Dont raise e. Continue with running other recipe
end
log "Platinum installation of Filebeat Uninstalled Successfully!!" do
    level :info
end

log "Uninstalling Filebeat..." do
    level :info
end
begin
    execute "Uninstalling all versions of Filebeat..." do
        command "yum -y remove filebeat*"
    end
rescue Exception => e
    puts "Exception while uninstalling filebeat! #{e}"
    raise e
end
log "Filebeat Uninstalled Successfully!!" do
    level :info
end