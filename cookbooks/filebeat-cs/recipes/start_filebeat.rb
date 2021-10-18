filebeat_exec_path = "#{node['filebeat']['exec-path']}"
ruby_block 'Start filebeat' do
    block do
        if !File::exists?("#{filebeat_exec_path}")
            Chef::Log.info("Filebeat not installed. Please configure your Cookbook properly!")
        end
    end
end
begin
    Chef::Log.info("Attempting to Start Filebeat...")
    execute "Starting Filebeat..." do
        command "#{filebeat_exec_path} start"
    end
    Chef::Log.info("Started Filebeat Successfully...")
rescue Exception => e
    puts "Exception while Starting filebeat!! #{e}"
    raise e
end