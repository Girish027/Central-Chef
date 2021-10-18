filebeat_exec_path = "#{node['filebeat']['exec-path']}"
if File::exists?("#{filebeat_exec_path}")
    log "Attempting to Stop Filebeat..." do
        level :info
    end
    execute "Stopping Filebeat..." do
        command "#{filebeat_exec_path} stop"
    end
else
    log "Filebeat not installed. Lets install it!" do
        level :info
    end
end