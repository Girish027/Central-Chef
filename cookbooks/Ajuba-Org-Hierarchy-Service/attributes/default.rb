override['filebeat']['group.name'] = "cs"
override['filebeat']['app.name'] = "ohs"
override['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/OHS/logs/ohsLogFile.log*"],
            "document_type": "ohs-app"
    },
    {
            "paths": ["/var/tellme/OHS/tomcat/logs/localhost*"],
            "document_type": "ohs-localhost-app"
    },
    {
            "paths": ["/var/tellme/OHS/tomcat/logs/catalina*"],
            "document_type": "ohs-catalina-app"
    },
    {
            "paths": ["/var/tellme/OHS/tomcat/logs/stacktrace*"],
            "document_type": "ohs-stacktrace-app"
    }
]';

#war file deploy##
default['Ajuba-OHS']['OHS-APP-DIR'] = '/var/tellme/OHS'
default['Ajuba-OHS']['OHS-APP-BUILD-DIR'] = "#{node['Ajuba-OHS']['OHS-APP-DIR']}/build"
default['Ajuba-OHS']['OHS-APP-CONFIG-DIR'] = "#{node['Ajuba-OHS']['OHS-APP-DIR']}/conf"
default['Ajuba-OHS']['OHS-APP-LOG-DIR'] = "#{node['Ajuba-OHS']['OHS-APP-DIR']}/logs"
default['Ajuba-OHS']['OHS-APP-WAR'] = 'org-hierarchy-service.war'
default['Central-tomcat8']['target'] = "#{node['Ajuba-OHS']['OHS-APP-DIR']}"
default['Central-tomcat8']['home'] = "#{node['Central-tomcat8']['target']}/tomcat"
default['Central-tomcat8']['webapps'] = "#{node['Central-tomcat8']['home']}/webapps"
default['Central-tomcat8']['config_dir'] = "#{node['Central-tomcat8']['home']}/conf"
default['Central-tomcat8']['log'] = "#{node['Central-tomcat8']['home']}/logs"
default['Ajuba-OHS']['AJUBA-DEFAULT-LICENCE-NAME'] = "default_client_licence"
default['Ajuba-OHS']['AJUBA-ADMIN-PERMISSIONS'] = ["uac.admin"]
default['Central-java8']['JAVA'] = "jdk1.8"

case node.chef_environment
when '_default','Ajuba-Dev'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'host82.pxassist.pool.sv2.247-inc.net:3306/ohs_dev'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'host82.pxassist.pool.sv2.247-inc.net:3306/ohs_dev'
  default['Central-tomcat8']['port'] = "8080"
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

# Stable env
when 'assistqacore3'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'qa-assist05.db.shared.int.sv2.247-inc.net:3306/ohs_stable2'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'qa-assist05.db.shared.int.sv2.247-inc.net:3306/ohs_stable2'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['AJUBA-SERVER-URL'] = 'http://qa-assist24.app.shared.int.sv2.247-inc.net:8080'
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

# Dev env
when 'assistqacore'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'host82.pxassist.pool.sv2.247-inc.net:3306/ohs_qacore'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'host82.pxassist.pool.sv2.247-inc.net:3306/ohs_qacore'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['AJUBA-SERVER-URL'] = 'http://host0216.dev.sv2.247-inc.net:8080'
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

# QA env
when 'assistqacore2'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'host183.assist.pool.sv2.247-inc.net:3306/ohs_qacore2'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'host183.assist.pool.sv2.247-inc.net:3306/ohs_qacore2'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['AJUBA-SERVER-URL'] = 'http://host0160.dev.sv2.247-inc.net:8080'
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

when 'Ajuba-QA'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'host298.assist.pool.sv2.247-inc.net:3306/'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'host298.assist.pool.sv2.247-inc.net:3306/'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

when 'Ajuba-Stage-SV1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'write.config-db.insights.stg.lb-priv.sv1.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'read.config-db.insights.stg.lb-priv.sv1.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

when 'Ajuba-Stage-VA1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'write.config-db.insights.stg.lb-priv.va1.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'read.config-db.insights.stg.lb-priv.va1.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

when 'Ajuba-Prod-SV1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'write.config-db.insights.lb-priv.sv1.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'read.config-db.insights.lb-priv.sv1.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 4096

when 'Ajuba-Prod-VA1'
  override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'write.config-db.insights.lb-priv.va1.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'read.config-db.insights.lb-priv.va1.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 4096

when 'OHS-Sandbox'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'dev-uac01.db.shared.int.sv2.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'dev-uac01.db.shared.int.sv2.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 2000
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['AJUBA-SERVER-URL'] = 'http://dev-uac01.app.shared.int.sv2.247-inc.net:8080'
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

when 'CENTRAL-STABLE'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'stable-centralsvcs01.db.shared.int.sv2.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'stable-centralsvcs02.db.shared.int.sv2.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 100
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['AJUBA-SERVER-URL'] = 'http://ohs.cenralsvcs.app.shared.int.lb-priv.sv2.247-inc.net'
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

when 'CENTRAL-DOCKER'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
  default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
  default['Ajuba-OHS']['APP-MYSQL-URL'] = 'cob-central01.db.shared.int.sv2.247-inc.net:3306/org_hierarchy_service'
  default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'cob-central01.db.shared.int.sv2.247-inc.net:3306/org_hierarchy_service'
  default['Central-tomcat8']['port'] = 8080
  default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
  default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 100
  default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
  default['Central-tomcat8']['ssl_port'] = 8444
  default['Central-tomcat8']['ajp_port'] = 8010
  default['Central-tomcat8']['shutdown_port'] = 8006
  default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]
  default['Ajuba-OHS']['AJUBA-SERVER-URL'] = 'http://cob-central01.app.shared.int.sv2.247-inc.net:8080'
  default['Ajuba-OHS']['APP-JVM-MEMORY'] = 2048

else
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
