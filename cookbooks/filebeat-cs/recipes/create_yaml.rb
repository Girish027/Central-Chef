require 'json'
yml_file = "#{node['filebeat']['yml']}";
filebeat_propector_dir = "#{node['filebeat']['prospector-conf-directory']}";
group_name = "#{node['filebeat']['group.name']}";
app_name = "#{node['filebeat']['app.name']}";
prospector_configs_json_string = "#{node['filebeat']['filebeat.prospector.config.map']}";

#---------------- VALIDATION -------------------
ruby_block "Check Group Name Configuration" do
  block do
    raise "ERROR: GROUP NAME NOT CONFIGURED! Please configure [filebeat][group.name] in your app" if group_name.empty?
  end
end

ruby_block "Check App Name Configuration" do
  block do
    raise "ERROR: APP NAME NOT CONFIGURED! Please configure [filebeat][app.name] in your app" if app_name.empty?
  end
end
log "Prospector Config JSON is of length: #{prospector_configs_json_string.length}" do
  level :info
end
ruby_block "Check Prospector Configuration" do
  block do
    raise "ERROR: NO PROSPECTORS CONFIGURED!" if prospector_configs_json_string.empty?
  end
end
#---------------- VALIDATION ENDS -------------------
begin
  prospector_configs = prospector_configs_json_string && prospector_configs_json_string.length >= 2 ? JSON.parse(prospector_configs_json_string) : [];
  prospector_configs.each do |item|
    _indent = "  ";
  
    #-------------------------------CHECK IF PATH IS CONFIGURED ----------------------
    if item.fetch("paths", "").empty?
      #SHOW THE MESSAGE ON THE CONSOLE
      log "ERROR IN CONFIGURED PROSPECTOR!!!! #{item} 'paths' IS A MANDATORY VALUE"  do
          level :info
      end
      #CONTINUE THE ITERATION
      next
    else
      _paths = item.fetch("paths");
      log "Paths Configured are: #{_paths}"  do
          level :info
      end
      _finalpaths = "";
      _paths.each do |path|
        _finalpaths = _finalpaths + "- " + path + "\n" + _indent + _indent + _indent;
      end
      _finalpaths = _finalpaths.rstrip;
    end
    _matchWord 	    = "filebeat.prospectors:"
    _doc_type       = !item.fetch("document_type", "").empty? ? item.fetch("document_type") : "#{node['prospector']['document_type']}";
    _type 	        = !item.fetch("type", "").empty? ? item.fetch("type") : "#{node['prospector']['type']}";
    _closeInactive 	= !item.fetch("close_inactive", "").empty? ? item.fetch("close_inactive") : "#{node['prospector']['close_inactive']}";
    _encoding  	    = !item.fetch("encoding", "").empty? ? item.fetch("encoding") : "#{node['prospector']['encoding']}";
    _exLine    	    = !item.fetch("exclude_lines", "").empty? ? item.fetch("exclude_lines") : "#{node['prospector']['exclude_lines']}";
    _inCline   	    = !item.fetch("include_lines", "").empty? ? item.fetch("include_lines") : "#{node['prospector']['include_lines']}";
    _exFiles   	    = !item.fetch("exclude_files", "").empty? ? item.fetch("exclude_files") : "#{node['prospector']['exclude_files']}";
    _pattern  	    = !item.fetch("pattern", "").empty? ? item.fetch("pattern") : "#{node['prospector']['pattern']}";
    _negate   	    = !item.fetch("negate", "").empty? ? item.fetch("negate") : "#{node['prospector']['negate']}";
    _match  	      = !item.fetch("match", "").empty? ? item.fetch("match") : "#{node['prospector']['match']}";
    _max_lines  	  = !item.fetch("max_lines", "").empty? ? item.fetch("max_lines") : "#{node['prospector']['max_lines']}";
    _timeout	      = !item.fetch("timeout", "").empty? ? item.fetch("timeout") : "#{node['prospector']['timeout']}";
    _yml_file       = "#{filebeat_propector_dir}/#{app_name}_#{_doc_type}.yml";
  
    log "Creating Document Type: #{app_name}_#{_doc_type}" do
      level :info
    end
    _doc_type       = "#{group_name}_#{_doc_type}";
    #------------- CREATE A YAML FILE USING THE TEMPLATE (DEFAULT) -------------------------------
    template "#{_yml_file}" do
      source "filebeat.yml.erb"
      owner "root"
      group "root"
      mode "0755"
    end
    #----------------------------------------------------------------------------------------------

    #------------ MODIFY THE OUTPUT CONFIGS IN THE MAIN YAML FILE -------------------------
    ruby_block 'Modify the YAML File' do
      block do
        if File::exists?("#{_yml_file}") 
          file = Chef::Util::FileEdit.new("#{_yml_file}");
          file.search_file_replace_line(/#{Regexp.escape(_matchWord)}/, "#{_indent}- type: #{_type}\n#{_indent}#{_indent}encoding: #{_encoding}\n#{_indent}#{_indent}document_type: #{_doc_type}\n#{_indent}#{_indent}exclude_lines: #{_exLine}\n#{_indent}#{_indent}include_lines: #{_inCline}\n#{_indent}#{_indent}exclude_files: #{_exFiles}\n#{_indent}#{_indent}close_inactive: #{_closeInactive}\n#{_indent}#{_indent}paths: \n#{_indent}#{_indent}#{_indent}#{_finalpaths}#{_indent}#{_indent}\n#{_indent}#{_indent}fields:\n#{_indent}#{_indent}#{_indent}type: #{_doc_type}\n#{_indent}#{_indent}multiline.pattern: #{_pattern}\n#{_indent}#{_indent}multiline.negate: #{_negate}\n#{_indent}#{_indent}multiline.match: #{_match}\n#{_indent}#{_indent}multiline.max_lines: #{_max_lines}\n#{_indent}#{_indent}multiline.timeout: #{_timeout}\n");
          file.write_file
        else
          log "YML FILE: #{_yml_file} does not exist!!"  do
              level :info
          end
          raise "ERROR: YML File Creation Failed!!"
        end
      end
      action :run
    end  
    #------------------------------------------------------------------------------
  end
rescue Exception => e
  puts "Exception while creating/configuring Prospector YMLs! #{e}"
  raise e
end