#
# Cookbook Name:: filebeat-cs
# Recipe:: default
#
# Copyright 2018, 247.ai
#
# All rights reserved - Do Not Redistribute
#
include_recipe "filebeat-cs::stop_filebeat"
include_recipe "filebeat-cs::uninstall_filebeat"
include_recipe "filebeat-cs::install_filebeat"
include_recipe "filebeat-cs::config_filebeat"
include_recipe "filebeat-cs::create_yaml"
include_recipe "filebeat-cs::start_filebeat"