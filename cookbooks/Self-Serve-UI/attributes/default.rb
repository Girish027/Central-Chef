
override['filebeat']['group.name'] = "cs"
override['filebeat']['app.name'] = "css-fe"
override['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/css/logs/app.log"],
            "document_type": "cssfe-app"
    },
    {
            "paths": ["/var/tellme/css/logs/console.log"],
            "document_type": "cssfe-con-app"
    }
]';

default['Self-Serve-UI']['CSS-APP-HOME'] = "/var/tellme/css-ui"
default['Self-Serve-UI']['CSS-APP-BUILD-DIR'] = "#{node['Self-Serve-UI']['CSS-APP-HOME']}/build"
default['Self-Serve-UI']['CSS-APP-BIN-DIR'] = "#{node['Self-Serve-UI']['CSS-APP-HOME']}/bin"
default['Self-Serve-UI']['CSS-APP-LOG-ARCHIVE-DIR'] = "#{node['Self-Serve-UI']['CSS-APP-HOME']}/logs"
default['Self-Serve-UI']['CSS-APP-TAR'] = "assist-console-ui.zip"
default['Self-Serve-UI']['CSS-USR-LOCAL'] = "/usr/local"
default['Self-Serve-UI']['CSS-LOG-DIR']= "#{node['Self-Serve-UI']['CSS-APP-HOME']}/logs"
default['Self-Serve-UI']['CONF-FILE']  = "/tools/config/current/statusd.conf"
default['Self-Serve-UI']['CHECK-PROCESS-NGINX']  = "nginx"

case node.chef_environment

when 'CENTRAL-QA'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	
when 'CENTRAL-PSR'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/psr/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	
	
when 'CENTRAL-STABLE'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	
    
when 'CENTRAL-SV1-STAGE'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	
	
when 'CENTRAL-VA1-STAGE'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	
	
when 'CENTRAL-SV1-PROD'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	
	
when 'CENTRAL-VA1-PROD'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
	default['Self-Serve-UI']['WAR-REPO'] = "http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/assist-console-ui/promoted/assist-console-ui-promoted.zip"
	

    
else
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
