#
# Cookbook Name:: COBP_BE-Central
# Recipe:: default
#
# © 2017 24/7 Customer, Inc.
#
# All rights reserved - Do Not Redistribute
#
# author : ravi.b

#Install Java 8 if its not installed
#package "#{node['COBP_BE-Central']['JAVA']}" do
#	action :install
#end
#execute "yum_install_jdk1.8" do
#  command "yum install -y #{node['COBP_BE-Central']['JAVA']} --nogpg"
#end
include_recipe "COBP_BE-Central::uninstall_jdk"
include_recipe "COBP_BE-Central::install_jdk"

# Create cobp home folder
directory "#{node['COBP_BE-Central']['COBP-APP-HOME']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create Build directory to downlaod jar in
directory "#{node['COBP_BE-Central']['COBP-APP-BUILD-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create config directory
directory "#{node['COBP_BE-Central']['COBP-APP-CONFIG-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#Create logs directory
directory "#{node['COBP_BE-Central']['COBP-APP-LOG-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

#### statusd template ############################
template "#{node['COBP_BE-Central']['COBP_BE-CentralMailer']}" do
  source 'check_centralMailer.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{node['COBP_BE-Central']['COBP_BE-COBPJava']}" do
  source 'check_process_cobp.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template "#{node['COBP_BE-Central']['COBP_BE-CheckLOG']}" do
  source 'check_log_expression.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

#### statusd template ############################


# Adding application.properties
template "#{node['COBP_BE-Central']['COBP-APP-CONFIG-DIR']}/application.properties" do
        source "application.properties.erb"
        owner "tellme"
        group "tellme"
        mode 0755
        variables(
        		:cobpMysqlHost => node['COBP_BE-Central']['DB-URL'],
	        	:cobpMysqlUser => node['COBP_BE-Central']['DB-USER'],
                :cobpMysqlPassword => node['COBP_BE-Central']['DB-PASS'],
                :cobpLogbackURL => node['COBP_BE-Central']['COBP-APP-LOGBACK-URL'],
				:cobpSsoDisable => node['COBP_BE-Central']['COBP-APP-SSO-DISABLE'],
				:cobpSsoBaseUrl => node['COBP_BE-Central']['COBP-APP-SSO-BASE-URL'],
				:cobpAllowedOrigins => node['COBP_BE-Central']['COBP-APP-ALLOWED-ORIGINS'],
				:cobpMessagingComponentNames => node['COBP_BE-Central']['COBP-APP-MESSAGING-COMPONENENT-NAMES'],
				:ohsDomainName => node['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME'],
				:ohsPort => node['COBP_BE-Central']['COBP-APP-OHS-PORT'],
        :cobptoEmail => node['COBP_BE-Central']['COBP-APP-TO-EMAIL'],
        :cobpfromEmail => node['COBP_BE-Central']['COBP-APP-FROM-EMAIL'], 
        :cobpSubject => node['COBP_BE-Central']['COBP-APP-SUBJECT'],
        :cobpsmtpServer => node['COBP_BE-Central']['COBP-APP-SMTP-SERVER'],
        :cobpsmtpPort => node['COBP_BE-Central']['COBP-APP-SMTP-PORT'],
        :cobptoEmailValidationProvisionFailed => node['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED'],
        :cobpfromEmailValidationProvisionFailed => node['COBP_BE-Central']['COBP-APP-FROM-EMAIL'],
        :cobpSubjectValidationProvisionFailed => node['COBP_BE-Central']['COBP-APP-SUBJECT-VALIDATIONPROVISION-FAILED'],
        :cobpEnableAuthType => node['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'],
        :cobpBaseUrl => node['COBP_BE-Central']['COBP-APP-BASE-URL'],
        :cobpCwpUrl => node['COBP_BE-Central']['COBP-APP-CWP-URL'],
        :cobpOktaAuthorizationServiceId => node['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'],
        :cobpClientId => node['COBP_BE-Central']['COBP-APP-CLIENT-ID'],
        :cobpClientSecret => node['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'],
        :cobpOktaConnectionTimeout => node['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'],
        :cobpOktaConnectionMultiply => node['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'],
        :cobpProxyEnable => node['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'],
        :cobpProxyHost => node['COBP_BE-Central']['COBP-APP-PROXY-HOST'],
        :cobpProxyPort => node['COBP_BE-Central']['COBP-APP-PROXY-PORT'],
        :cobpProxyProtocol => node['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'],
        :coreComponentSelectionEnabled => node['COBP_BE-Central']['COBP-APP-CORE-COMPONENT_SELECTION_ENABLED'],
        :maxPayloadSize => node['COBP_BE-Central']['COBP-APP-MAX-PAYLOAD-SIZE']
	)
end

#Adding restart script
template "#{node['COBP_BE-Central']['COBP-APP-CONFIG-DIR']}/restartCOBP.sh" do
  source "restartCOBP.sh.erb"
  owner "tellme"
  group "tellme"
  mode 0755
end

# Adding logback.xml
template "#{node['COBP_BE-Central']['COBP-APP-LOGBACK-URL']}" do
  source "logback.xml.erb"
  owner "tellme"
  group "tellme"
  mode 0755
  variables(
    :cobpLogsLoc => node['COBP_BE-Central']['COBP-APP-LOG-DIR']
	)
end

#Adding restart script
template "#{node['COBP_BE-Central']['COBP-APP-CONFIG-DIR']}/ehcache.xml" do
  source "ehcache.xml.erb"
  owner "tellme"
  group "tellme"
  mode 0755
  variables(
    :cachettl => node['COBP_BE-Central']['COBP-APP-CACHE-TTL']
  )
end

#Create bin directory
directory "#{node['COBP_BE-Central']['COBP-APP-BIN-DIR']}" do
	owner "tellme"
	group "tellme"
	mode 00755
	action :create
end

# Adding cobp_be_log_cleanup.sh
template "#{node['COBP_BE-Central']['COBP-APP-CLEANUP-SCRIPT-URL']}" do
  source "cobp_be_log_cleanup.sh.erb"
  owner "tellme"
  group "tellme"
  mode 0755
  variables(
    :cobpLogArchiveDir => node['COBP_BE-Central']['COBP-APP-LOG-ARCHIVE-DIR']
	)
end

# Kill cobp process if its running
execute "Killing COBP if running" do
  command "cobp_pid=`ps aux | grep cobp | grep -v grep | awk '{print $2}'`;if [ \"$cobp_pid\" != \"\" ]; then `kill -9 $cobp_pid`; fi"
end

# Remove old cobp jar
execute "Remove old cobp jar" do
  command "rm -rf #{node['COBP_BE-Central']['COBP-APP-BUILD-DIR']}/#{node['COBP_BE-Central']['COBP-APP-WAR']}"
end

#Download jar from the nexus
remote_file "#{node['COBP_BE-Central']['COBP-APP-BUILD-DIR']}/#{node['COBP_BE-Central']['COBP-APP-WAR']}" do
  source "#{node['COBP_BE-Central']['WAR-REPO']}"
end


#Start COBP service
execute "Starting COBP Service" do
	command "nohup java -jar #{node['COBP_BE-Central']['COBP-APP-BUILD-DIR']}/cobp.jar --spring.config.location=#{node['COBP_BE-Central']['COBP-APP-CONFIG-DIR']}/application.properties > #{node['COBP_BE-Central']['COBP-APP-LOG-DIR']}/console.log 2>&1 &"
end

#Setting up Statusd Alerts
template "#{node['COBP_BE-Central']['CONF-FILE']}" do
  source 'statusd.conf.erb'
  owner 'root'
  group 'root'
  mode '0644'
end

execute "statusd restart" do
  command "/etc/init.d/tellme_statusd restart"
end