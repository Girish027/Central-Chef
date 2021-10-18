cert_path ="#{node['filebeat']['certpath']}"
logLocation ="#{node['filebeat']['loglocations']}"
yml_file = "#{node['filebeat']['yml']}"
filebeat_logging_path = "#{node['logging']['files']['path']}";
filebeat_logging_filename = "#{node['logging']['files']['filename']}"
filebeat_propector_path = "#{node['prospector']['logpath']}"
filebeat_propector_dir = "#{node['filebeat']['prospector-conf-directory']}"

#-------------- CREATE THE DIRECTORY FOR LOGGGING  ----------------------------
log "Creating the Directory for Filebeats logs..." do
  level :info
end
begin
  directory "#{filebeat_logging_path}" do
    owner 'root'
    group 'root'
    mode '0755'
    action :create
  end
rescue Exception => e
  puts "Exception while creating the filebeat logs directory! #{e}"
  raise e
end
log "Directory for Filebeat logs created Successfully!!" do
  level :info
end
#------------------------------------------------------------------------------

#------------- CREATE THE LOG FILE --------------------------------------------
file "#{filebeat_logging_path}#{filebeat_logging_filename}" do
  owner "root"
  mode  "0755"
end

#------------- COPY THE FILEBEAT MAIN YAML FILE -------------------------------
log "Copying the Main YML File..." do
  level :info
end
begin
  template "#{yml_file}" do
      source "filebeat_main.yml.erb"
      owner "root"
      group "root"
      mode "0755"
  end
rescue Exception => e
  puts "Exception while copying the Main YML file: #{yml_file}! #{e}"
  raise e
end
log "Main YML:#{yml_file} copied Successfully!!" do
  level :info
end
#------------------------------------------------------------------------------

#------------ CONFIGURE THE OUTPUT CONFIGS IN THE MAIN YAML FILE -----------------
log "Configuring output.logstash in the Main YML file!!" do
  level :info
end
begin
  ruby_block "insert_line_output-logstash" do
    _matchWord  = "output.logstash:"
    _hosts  = "#{node['filebeat']['logstash']['host']}"
    _worker  = "#{node['logstash']['worker']}"
    _compression_level  = "#{node['logstash']['compression_level']}"
    _loadbalance   = "#{node['logstash']['loadbalance']}"
    _certificate   = "#{cert_path}/file_beat.crt"
    _key = "#{cert_path}/file_beat.key"
    _verification_mode  = "#{node['logstash']['verification_mode']}"
    _indent = "  "

    block do
      file = Chef::Util::FileEdit.new("#{yml_file}")
      file.insert_line_after_match(/#{Regexp.escape(_matchWord)}/, "#{_indent}hosts: ['#{_hosts}']\n#{_indent}worker: #{_worker}\n#{_indent}compression_level: #{_compression_level}\n#{_indent}loadbalance: #{_loadbalance}\n#{_indent}ssl:\n#{_indent}#{_indent}certificate: #{_certificate}\n#{_indent}#{_indent}key: #{_key}\n#{_indent}#{_indent}verification_mode: #{_verification_mode}") 
      file.write_file
    end
  end
rescue Exception => e
  puts "Exception while inserting output.logstash config in the Main YML file! #{e}"
  raise e
end
log "Successfully configured output.logstash config in the Main YML file!!" do
  level :info
end
#-------------------------------------------------------------------------------

#------------ MODIFY THE LOGGING CONFIGS IN THE MAIN YAML FILE -----------------
log "Configuring Filebeat Logging in the Main YML file!!" do
  level :info
end
begin
  ruby_block "insert_line_logging" do
    _matchWord  = "logging:"
    _to_files  = "#{node['logging']['to_files']}"
    # _files  = "files"
    _path  = "#{node['logging']['files']['path']}"
    _name   = "#{node['logging']['files']['filename']}"
    _rotateeverybytes = "#{node['logging']['files']['rotateeverybytes']}"
    _keepfiles = "#{node['logging']['files']['keepfiles']}"
    _level  = "#{node['logging']['level']}"
    _indent = "  "

    block do
      file = Chef::Util::FileEdit.new("#{yml_file}")
      file.insert_line_after_match(/#{Regexp.escape(_matchWord)}/, "#{_indent}to_files: #{_to_files}\n#{_indent}files: \n#{_indent}#{_indent}path: #{_path}\n#{_indent}#{_indent}name: #{_name}\n#{_indent}#{_indent}rotateeverybytes: #{_rotateeverybytes}\n#{_indent}#{_indent}keepfiles: #{_keepfiles}\n#{_indent}#{_indent}level: #{_level}")
      file.write_file
    end
  end
rescue Exception => e
  puts "Exception while configuring Filebeat Logging in the Main YML file! #{e}"
  raise e
end
log "Successfully configured Filebeat Logging in the Main YML file!!" do
  level :info
end
#-------------------------------------------------------------------------------

#------------ CREATE THE DIR FROM WHERE PROSPECTOR CONFIGS HAVE TO BE LOOKED UP
log "Creating the Directory for Filebeat Prospectors..." do
  level :info
end
begin
  directory "#{filebeat_propector_dir}" do
    owner 'root'
    group 'root'
    mode '0755'
    recursive true
    action :create
  end
rescue Exception => e
  puts "Exception while creating directory for Filebeat Prospectors! #{e}"
  raise e
end
log "Directory for Filebeat Prospectors created Successfully!!" do
  level :info
end
#------------------------------------------------------------------------------