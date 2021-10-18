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

case node.chef_environment
when 'QA'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfs/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
default['Ajuba-OHS']['APP-MYSQL-URL'] = 'host298.assist.pool.sv2.247-inc.net:3306/ohs_prod'
default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'host298.assist.pool.sv2.247-inc.net:3306/ohs_prod'
default['Central-tomcat8']['port'] = 80
default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 100
default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
default['Central-tomcat8']['ssl_port'] = 8444
default['Central-tomcat8']['ajp_port'] = 8010
default['Central-tomcat8']['shutdown_port'] = 8006
default['Ajuba-OHS']['AJUBA-DEFAULT-LICENCE-NAME'] = "default_client_licence"
default['Ajuba-OHS']['AJUBA-ADMIN-PERMISSIONS'] = ["uac.admin"]
default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]

# QA env
when 'assistqacore2'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
default['Ajuba-OHS']['APP-MYSQL-URL'] = 'host183.assist.pool.sv2.247-inc.net:3306/ohs_qacore2'
default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'host183.assist.pool.sv2.247-inc.net:3306/ohs_qacore2'
default['Central-tomcat8']['port'] = 8080
default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 100
default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
default['Central-tomcat8']['ssl_port'] = 8444
default['Central-tomcat8']['ajp_port'] = 8010
default['Central-tomcat8']['shutdown_port'] = 8006
default['Ajuba-OHS']['AJUBA-DEFAULT-LICENCE-NAME'] = "default_client_licence"
default['Ajuba-OHS']['AJUBA-ADMIN-PERMISSIONS'] = ["uac.admin"]
default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]

# Stable env
when 'assistqacore3'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
default['Ajuba-OHS']['APP-MYSQL-URL'] = 'qa-assist05.db.shared.int.sv2.247-inc.net:3306/ohs_stable2'
default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'qa-assist05.db.shared.int.sv2.247-inc.net:3306/ohs_stable2'
default['Central-tomcat8']['port'] = 8080
default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 100
default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
default['Central-tomcat8']['ssl_port'] = 8444
default['Central-tomcat8']['ajp_port'] = 8010
default['Central-tomcat8']['shutdown_port'] = 8006
default['Ajuba-OHS']['AJUBA-DEFAULT-LICENCE-NAME'] = "default_client_licence"
default['Ajuba-OHS']['AJUBA-ADMIN-PERMISSIONS'] = ["uac.admin"]
default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]

# Dev env
when 'assistqacore'
  override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-OHS']['OHS-ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/org-hierarchy-service/promoted/org-hierarchy-service-promoted.war'
default['Ajuba-OHS']['APP-MYSQL-URL'] ='write.config-db.qacore1.assist.int.lb-priv.sv2.247-inc.net:3306/ohs_stable2'
default['Ajuba-OHS']['APP-MYSQL-URL-READ'] = 'write.config-db.qacore1.assist.int.lb-priv.sv2.247-inc.net:3306/ohs_stable2'
default['Central-tomcat8']['port'] = 8080
default['Ajuba-OHS']['VERSIONING-CACHE-SIZE'] = 10
default['Ajuba-OHS']['VERSIONING-BATCH-SIZE'] = 100
default['Central-tomcat8']['JAVAOPTS'] = "-Dgrails.env=production"
default['Central-tomcat8']['ssl_port'] = 8444
default['Central-tomcat8']['ajp_port'] = 8010
default['Central-tomcat8']['shutdown_port'] = 8006
default['Ajuba-OHS']['AJUBA-DEFAULT-LICENCE-NAME'] = "default_client_licence"
default['Ajuba-OHS']['AJUBA-ADMIN-PERMISSIONS'] = ["uac.admin"]
default['Ajuba-OHS']['AJUBA-INSIGHTS_PERMISSIONS'] = ["insights.reports.conversion-sum","insights.reports.transaction","insights.reports.orders","insights.reports.agent-disposition","insights.reports.transcript","insights.reports.transfer-summary","insights.reports.chat-transfer","insights.reports.customer-survey","insights.reports.chat-util","insights.reports.chat-funnel","insights.reports.new-report","insights.reports.service-level","insights.reports.transfer-details","insights.reports.chat-cancelled"]


else
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
