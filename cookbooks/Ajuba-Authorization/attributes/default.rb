override['filebeat']['group.name'] = "cs"
override['filebeat']['app.name'] = "authsvr"
override['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/ajuba-authorization/logs/application.log"],
            "document_type": "authsvr-app"
    }
]';

#Generic attributes
default['Ajuba-Authorization']['APP-BASE-DIRECTORY'] = '/var/tellme/ajuba-authorization'
default['Ajuba-Authorization']['APP-JAR'] = 'authorization-service.jar'
default['Ajuba-Authorization']['BUILD-BACKUP-LOCATION'] = "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/backup"
default['Ajuba-Authorization']['BUILD-CONFIG-LOCATION'] = "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/config"
default['Ajuba-Authorization']['LOGGER-DIRECTORY-NAME'] = "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/logs"
default['Ajuba-Authorization']['APP-CONFIG-HOME'] = "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/conf"
default['Ajuba-Authorization']['APP-CONFIG-BUILD'] = "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/build"
default['Ajuba-Authorization']['APP-JETTY-HOME'] = "#{node['Ajuba-Authorization']['APP-BASE-DIRECTORY']}/jetty"
default['Ajuba-Authorization']['CONFIG-APP-CONFIG-HOME'] = "#{node['Ajuba-Authorization']['BUILD-CONFIG-LOCATION']}/conf"
default['Ajuba-Authorization']['CONFIG-APP-CONFIG-BUILD'] = "#{node['Ajuba-Authorization']['BUILD-CONFIG-LOCATION']}/build"
default['Ajuba-Authorization']['CONFIG-APP-JETTY-HOME'] = "#{node['Ajuba-Authorization']['BUILD-CONFIG-LOCATION']}/jetty"
default['Ajuba-Authorization']['LOGGER-FILE'] = "#{node['Ajuba-Authorization']['LOGGER-DIRECTORY-NAME']}/logfile.log"
default['Ajuba-Authorization']['NOHUP-LOG-FILE']="#{node['Ajuba-Authorization']['LOGGER-DIRECTORY-NAME']}/nohup.log"
default['Central-java8']['JAVA'] = "jdk1.8"

case node.chef_environment
when '_default','Ajuba-Dev'
override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8084
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://ohs.dev.assist.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

# Dev env
when  'assistqacore'
override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8082
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://ohs.qa.assist.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

# QA env
when  'assistqacore2'
override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8082
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://ohs.qa.assist.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

# Stable env
when  'assistqacore3'
override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8082
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://ohs.qa.assist.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1
    
when 'Ajuba-QA'
override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8084
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://ohs.qa.assist.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

when 'CENTRAL-STABLE'
override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8082
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://ohs.cenralsvcs.app.shared.int.lb-priv.sv2.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1
    
when 'Ajuba-Stage-SV1'
override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8080
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://orginfo.write.central-app.staging.lb-priv.sv1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1


when 'Ajuba-Stage-VA1'
override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8080
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://orginfo.write.central-app.staging.lb-priv.va1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

when 'Ajuba-Prod-SV1'
override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8080
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://orginfo.write.central-app.lb-priv.sv1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

when 'Ajuba-Prod-VA1'
override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
default['Ajuba-Authorization']['ZIPFILE-DEPLOY'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/authorization-service/promoted/authorization-service-promoted.zip'
default['Ajuba-Authorization']['LOGGER-DATEPATTERN'] = "yyyy-MM-dd-HH"
default['Ajuba-Authorization']['LOGGER-LEVEL-ROOT'] = "INFO, stdout, logfile"
default['Ajuba-Authorization']['APP-JETTY-PORT'] = 8080
default['Ajuba-Authorization']['LOGGER-LEVEL-JGROUPS'] = "warn"
default['Ajuba-Authorization']['LOGGER-LEVEL-JETTY'] = "error"
default['Ajuba-Authorization']['LOGGER-LEVEL-HIBERNATE'] = "error"
default["Ajuba-Authorization"]["OH-REST-URL"] = "http://orginfo.write.central-app.lb-priv.va1.247-inc.net/org-hierarchy-service/versioning/hierarchy-service"
default["Ajuba-Authorization"]["OH-POLLING-SEC"] = 1

else
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end