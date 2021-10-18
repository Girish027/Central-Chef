override['filebeat']['group.name'] = "cs"
override['filebeat']['app.name'] = "uac"
override['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/ajuba-admin/logs/adminLogFile.log*"],
            "document_type": "uac-app"
    },
    {
            "paths": ["/var/tellme/ajuba-admin/tomcat/logs/localhost*"],
            "document_type": "uac-localhost-app"
    },
    {
            "paths": ["/var/tellme/ajuba-admin/tomcat/logs/catalina*"],
            "document_type": "uac-catalina-app"
    },
    {
            "paths": ["/var/tellme/ajuba-admin/tomcat/logs/stacktrace*"],
            "document_type": "uac-stacktrace-app"
    }
]';

#war file deploy##
default['Ajuba-Admin']['APP-DIR'] = '/var/tellme/ajuba-admin'
default['Ajuba-Admin']['APP-BUILD-DIR'] = "#{node['Ajuba-Admin']['APP-DIR']}/build"
default['Ajuba-Admin']['APP-CONFIG-DIR'] = "#{node['Ajuba-Admin']['APP-DIR']}/conf"
default['Ajuba-Admin']['APP-LOG-DIR'] = "#{node['Ajuba-Admin']['APP-DIR']}/logs"
default['Ajuba-Admin']['APP-WAR'] = 'ajuba-admin.war'
default['Ajuba-Admin']['tomcathome'] = '/var/tellme/ajuba-admin/tomcat'
default['Ajuba-tomcat7']['target'] = "#{node['Ajuba-Admin']['APP-DIR']}"
default['Ajuba-tomcat7']['home'] = "#{node['Ajuba-tomcat7']['target']}/tomcat"
default['Ajuba-tomcat7']['webapps'] = "#{node['Ajuba-tomcat7']['home']}/webapps"
default['Ajuba-tomcat7']['config_dir'] = "#{node['Ajuba-tomcat7']['home']}/conf"
default['Ajuba-tomcat7']['log'] = "#{node['Ajuba-tomcat7']['home']}/logs"
default['Ajuba-Admin']['APP-LOCALE-ENV'] = 'en_US'
default['Central-java8']['JAVA'] = "jdk1.8"


case node.chef_environment
when '_default','DEV' 
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'host298.assist.pool.sv2.247-inc.net:3306/admin_console'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://localhost:8080/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'http://'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.dev.247-inc.net/sso/session/checkSession'
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007
  default['Central-tomcat8']['port'] = "8081"

# Dev env
when 'assistqacore'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'write.config-db.qacore1.assist.int.lb-priv.sv2.247-inc.net:3306/admin_console_qacore3'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://host0216.dev.sv2.247-inc.net:8080/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'http://'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.qacore1.247-inc.net/sso/session/checkSession'
  default['Central-tomcat8']['port'] = "80"
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007

# QA env
when 'assistqacore2'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'host183.assist.pool.sv2.247-inc.net:3306/admin_console_qacore2'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://host0160.dev.sv2.247-inc.net:8080/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'http://'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.qacore2.247-inc.net/sso/session/checkSession'
  default['Central-tomcat8']['port'] = "80"
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007

# Stable env
when 'assistqacore3'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'qa-assist05.db.shared.int.sv2.247-inc.net:3306/admin_console_qacore3'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://qa-assist24.app.shared.int.sv2.247-inc.net:8080/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'http://'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.qacore3.247-inc.net/sso/session/checkSession'
  default['Central-tomcat8']['port'] = "80"
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007

when 'Ajuba-Stage-SV1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'read.config-db.assist.staging.lb-priv.sv1.247-inc.net:3306/admin_console_sv1'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://orginfo.read.central-app.staging.lb-priv.sv1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'https://'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.staging.247-inc.net/sso/session/checkSession'
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007
  default['Central-tomcat8']['port'] = "8081"

when 'Ajuba-Stage-VA1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'read.config-db.assist.staging.lb-priv.va1.247-inc.net:3306/admin_console_va1'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://orginfo.read.central-app.staging.lb-priv.va1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'https://'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.staging.247-inc.net/sso/session/checkSession'
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007
  default['Central-tomcat8']['port'] = "8081"

when 'Ajuba-Prod-SV1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'read.config-db.assist.lb-priv.sv1.247-inc.net:3306/admin_console_sv1'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://orginfo.read.central-app.lb-priv.sv1.247-inc.net:80/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'vadmin@test-default'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'https://'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.247-inc.net/sso/session/checkSession'
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007
  default['Central-tomcat8']['port'] = "8081"

when 'Ajuba-Prod-VA1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'read.config-db.assist.lb-priv.va1.247-inc.net:3306/admin_console_va1'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://orginfo.read.central-app.lb-priv.va1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'vadmin@test-default'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'https://'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.247-inc.net/sso/session/checkSession'
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007
  default['Central-tomcat8']['port'] = "8081"

  # Stable env
when 'CENTRAL-STABLE'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-Admin']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/ajuba-admin/promoted/ajuba-admin-promoted.war'
  default['Ajuba-Admin']['APP-LOG-LEVEL'] = 'DEBUG'
  default['Ajuba-Admin']['APP-MYSQL-URL'] = 'stable-centralsvcs01.db.shared.int.sv2.247-inc.net:3306/admin_console'
  default['Ajuba-Admin']['APP-OHS-URL'] = 'http://ohs.cenralsvcs.app.shared.int.lb-priv.sv2.247-inc.net/org-hierarchy-service/versioning/hierarchy-service'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-LOGIN'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SINGLE-USER'] = 'opsadmin01@lnd'
  default['Ajuba-Admin']['APP-AUTH-USER-ATTRIBUTE'] = 'cn'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR1'] = 'userName'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR2'] = 'mail'
  default['Ajuba-Admin']['APP-USER-ATTRIBUTE-ATTR3'] = 'userId'
  default['Ajuba-Admin']['PHANTOMJS_DOWNLOAD_SERVER_MODE'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-PROTOCOL'] = 'https://'
  default['Ajuba-Admin']['APP-AUTH-OPENAM-SERVER-ENABLED'] = 'false'
  default['Ajuba-Admin']['APP-AUTH-SSO-LOGIN-URI'] = '.login.stablee2e.247-inc.net/sso/session/checkSession'
  default['Central-tomcat8']['port'] = "80"
  default['Ajuba-Admin']['TOMCAT-REDIRECT-PORT'] = '8445'
  default['Central-tomcat8']['ssl_port'] = 8445
  default['Central-tomcat8']['ajp_port'] = 8011
  default['Central-tomcat8']['shutdown_port'] = 8007

else
  puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
