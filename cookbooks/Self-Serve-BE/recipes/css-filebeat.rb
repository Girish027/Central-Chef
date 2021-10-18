#Below 2 lines could be moved to attributes -> default.rb file
filebeat_exec_path = "/etc/init.d/filebeat"
filebeat_exec_path_new = "/etc/init.d/filebeatnew"

if File::exists?("#{filebeat_exec_path_new}")
    log "Attempting to Stop Renamed Filebeat and deleted it..." do
        level :info
    end
    execute "Stopping Renamed Filebeat." do
        command "#{filebeat_exec_path_new} stop"
    end
    execute "Deleting it." do
        command "mv -f #{filebeat_exec_path_new} #{filebeat_exec_path}"
    end
end

include_recipe "filebeat-cs"

#Wait for earlier filebeat to come to stable state before renaming its filename
ruby_block "Wait for earlier filebeat to come to stable state" do
    block do
        sleep 5
    end
end

#Fix to start filebeat-god process on CentOS 7.x
#If filebeat file exist, then mostly its not yet renamed. So rename and start with filebeatnew.
if !File::exists?("#{filebeat_exec_path}")
    log "Attempting to Stop Filebeat (if filebeat file exit), rename to filebeatnew, and start again..." do
        level :info
    end
    execute "Stopping Filebeat." do
        command "#{filebeat_exec_path} stop"
    end
    execute "Renaming it." do
        command "mv -v -f #{filebeat_exec_path} #{filebeat_exec_path_new}"
    end
    execute "Starting it again." do
        command "#{filebeat_exec_path_new} start"
    end
end

#Fix to start filebeat-god process on CentOS 7.x
#Make sure filebestnew is from latest copy of filebeat.
if !File::exists?("#{filebeat_exec_path_new}")
    log "Attempting to Stop Filebeat (if filebeatnew file exit), try to rename from old, and start again..." do
        level :info
    end
    execute "Stopping Filebeat." do
        command "#{filebeat_exec_path} stop"
    end
    execute "Renaming it." do
        command "mv -v -f #{filebeat_exec_path} #{filebeat_exec_path_new}"
    end
    execute "Starting it again." do
        command "#{filebeat_exec_path_new} start"
    end
end
