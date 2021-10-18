#
# Cookbook Name:: tomcat8.0.50
# Attributes:: default
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

default['Central-tomcat8']['version'] = "8.0.50"
default['Central-tomcat8']['init.d']= "tellme_tomcat"
default['Central-tomcat8']['log'] = "/var/tellme/logs/tomcat"
default['Central-tomcat8']['target'] = "/var/tellme/cm-tomcat"
default['Central-tomcat8']['home'] = "#{node['Central-tomcat8']['target']}/tomcat"
default['Central-tomcat8']['START_SCRIPT'] = "#{node['Central-tomcat8']['home']}/bin/startup.sh"
default['Central-tomcat8']['bin'] = "#{node['Central-tomcat8']['home']}/bin"
default['Central-tomcat8']['STOP_SCRIPT'] = "#{node['Central-tomcat8']['home']}/bin/killContainer.sh"
default['Central-tomcat8']['webapps'] = "#{node['Central-tomcat8']['home']}/webapps"
default['Central-tomcat8']['config_dir'] = "#{node['Central-tomcat8']['home']}/conf"
default['Central-tomcat8']['user'] = "tellme"
default['Central-tomcat8']['group'] = "tellme"
default['Central-tomcat8']['port'] = 8080
default['Central-tomcat8']['ssl_port'] = 8443
default['Central-tomcat8']['ajp_port'] = 8009
default['Central-tomcat8']['shutdown_port'] = 8005
default['Central-tomcat8']['JAVAOPTS'] = ""
default['Central-tomcat8']['download_url'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/packages/platinum/tomcat/8.0.50/tomcat-8.0.50.zip"
default['Central-tomcat8']['REDIRECT_PORT'] = "8884"
default['Central-tomcat8']['SERVER_XML_DOCBASE'] = ""
default['Central-tomcat8']['SERVER_XML_PATH'] = ""