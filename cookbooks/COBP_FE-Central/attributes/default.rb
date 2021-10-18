override['filebeat']['group.name'] = "cs"
override['filebeat']['app.name'] = "cobp-fe"
override['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/cobp/logs/app.log"],
            "document_type": "cobpfe-app"
    },
    {
            "paths": ["/var/tellme/cobp/logs/console.log"],
            "document_type": "cobpfe-con-app"
    }
]';

default['COBP_FE-Central']['COBP-APP-HOME'] = "/var/tellme/cobp"
default['COBP_FE-Central']['COBP-APP-BUILD-DIR'] = "#{node['COBP_FE-Central']['COBP-APP-HOME']}/build"
default['COBP_FE-Central']['COBP-APP-BIN-DIR'] = "#{node['COBP_FE-Central']['COBP-APP-HOME']}/bin"
default['COBP_FE-Central']['COBP-APP-LOG-ARCHIVE-DIR'] = "#{node['COBP_FE-Central']['COBP-APP-HOME']}/logs"
default['COBP_FE-Central']['COBP-APP-TAR'] = "cobp-fe.tgz"
default['COBP_FE-Central']['COBP-USR-LOCAL'] = "/usr/local"
default['COBP_FE-Central']['COBP-NODE-DURL']="http://nexus.cicd.sv2.247-inc.net/nexus/repository/packages/nodejs/nodejs/8.11.2/node-v8.11.2-linux-x64.tar.gz"
default['COBP_FE-Central']['COBP-NODE-TAR']="node-v8.11.2.tar.gz"
default['COBP_FE-Central']['COBP-APP-CLEANUP-SCRIPT-URL'] = "#{node['COBP_FE-Central']['COBP-APP-BIN-DIR']}/cobp_fe_log_cleanup.sh"
default['COBP_FE-Central']['COBP-LOG-DIR']= "#{node['COBP_FE-Central']['COBP-APP-HOME']}/logs"
default['COBP_FE-Central']['CONF-FILE']  = "/tools/config/current/statusd.conf"
default['COBP_FE-Central']['CHECK-PROCESS-NODE']  = "node"
default['COBP_FE-Central']['CHECK-PROCESS-NGINX']  = "nginx"
default['COBP_FE-Central']['COBP_FE-CentralJava']  = "/usr/local/statusd/libexec/check_process_css"


case node.chef_environment
when 'CENTRAL-DEV'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
	default['COBP_FE-Central']['COBP-BE-URL'] = 'http://dev.api.sv2.247-inc.net/cobp-service'
	default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central-dev.lb-priv.sv2.247-inc.net\/auth'
	default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central-dev.lb-priv.sv2.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "sv2"
    default['COBP_FE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
    default['COBP_FE-Central']['OKTA-URL']     = "https://sso-247-inc.oktapreview.com/"
    default['COBP_FE-Central']['OKTA-ISSUER']    = "https://sso-247-inc.oktapreview.com/oauth2/auseahswukBL6I2Ns0h7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID']    = "0oacso99t094i77Jq0h7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET']    = "GUx6vCwKabA0-u2i0pD8SrAJ2d5VlpLbVRsaoVCZ"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI']    = "http://dev-client-prov.web.shared.int.lb-priv.sv2.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES']    = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://dev-themeroller.247-inc.net/workflow"
    

when 'CENTRAL-QA'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
	default['COBP_FE-Central']['COBP-BE-URL'] = 'http://qa.api.sv2.247-inc.net/cobp-service'
	default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central-qa.lb-priv.sv2.247-inc.net\/auth'
	default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central-qa.lb-priv.sv2.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "sv2"
    default['COBP_FE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.oktapreview.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.oktapreview.com/oauth2/auseahswukBL6I2Ns0h7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oacso99t094i77Jq0h7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "GUx6vCwKabA0-u2i0pD8SrAJ2d5VlpLbVRsaoVCZ"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "http://qa-client-prov.web.shared.int.lb-priv.sv2.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://qa-themeroller.247-inc.net/workflow"
    
when 'CENTRAL-PSR'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/psr/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
	default['COBP_FE-Central']['COBP-BE-URL'] = 'http://psr.api.sv2.247-inc.net/cobp-service'
	default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central-qa.lb-priv.sv2.247-inc.net\/auth'
	default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central-qa.lb-priv.sv2.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "sv2"
    default['COBP_FE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.okta.com/oauth2/aus4cot0qqJWQJD8z2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "http://psr-client-prov.web.shared.int.lb-priv.sv2.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://stable-themeroller.247-inc.net/workflow"
    

when 'CENTRAL-STABLE'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
	default['COBP_FE-Central']['COBP-BE-URL'] = 'http://stable-client-prov.app.shared.int.lb-priv.sv2.247-inc.net/cobp-service'
	default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central-qa.lb-priv.sv2.247-inc.net\/auth'
	default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central-qa.lb-priv.sv2.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "sv2"
    default['COBP_FE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.oktapreview.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.oktapreview.com/oauth2/auseahswukBL6I2Ns0h7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oacso99t094i77Jq0h7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "GUx6vCwKabA0-u2i0pD8SrAJ2d5VlpLbVRsaoVCZ"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "http://stable-client-prov.web.shared.int.lb-priv.sv2.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://stable-themeroller.247-inc.net/workflow"

when 'CENTRAL-SV1-STAGE'
    override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
    default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
    default['COBP_FE-Central']['COBP-BE-URL'] = 'http://client-prov.app.stg.lb-priv.sv1.247-inc.net/cobp-service'
    default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central-stage.247-inc.net\/auth'
    default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central-stage.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "sv1"
    default['COBP_FE-Central']['webserver']     = "probe.private.sv1.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.private.sv1.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.private.sv1.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.private.sv1.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.okta.com/oauth2/aus4cot0qqJWQJD8z2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "https://staging-client-prov.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://staging-palette.247-inc.net/workflow"

 when 'CENTRAL-VA1-STAGE'
    override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
    default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
    default['COBP_FE-Central']['COBP-BE-URL'] = 'http://client-prov.app.stg.lb-priv.va1.247-inc.net/cobp-service'
    default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central-stage.247-inc.net\/auth'
    default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central-stage.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "va1"
    default['COBP_FE-Central']['webserver']     = "probe.private.va1.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.private.va1.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.private.va1.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.private.va1.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.okta.com/oauth2/aus4cot0qqJWQJD8z2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "https://staging-client-prov.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://staging-palette.247-inc.net/workflow"

 when 'CENTRAL-SV1-PROD'
    override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
    default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
    default['COBP_FE-Central']['COBP-BE-URL'] = 'http://client-prov.app.lb-priv.sv1.247-inc.net/cobp-service'
    default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central.247-inc.net\/auth'
    default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "sv1"
    default['COBP_FE-Central']['webserver']     = "probe.private.sv1.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.private.sv1.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.private.sv1.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.private.sv1.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.okta.com/oauth2/aus4cot0qqJWQJD8z2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "https://client-prov.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://palette.247-inc.net/workflow"

 when 'CENTRAL-VA1-PROD'
    override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
    default['COBP_FE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/cobp-fe/promoted/cobp-fe-promoted.tgz'
    default['COBP_FE-Central']['COBP-BE-URL'] = 'http://client-prov.app.lb-priv.va1.247-inc.net/cobp-service'
    default['COBP_FE-Central']['COBP-FE-SSO-URL'] = 'https:\/\/sso.central.247-inc.net\/auth'
    default['COBP_FE-Central']['LOGOUT-URL'] = 'https://sso.central.247-inc.net/auth/UI/Logout'
    default['COBP_FE-Central']['location']      = "va1"
    default['COBP_FE-Central']['webserver']     = "probe.private.va1.tellme.com"
    default['COBP_FE-Central']['probeserver']   = "probe.private.va1.tellme.com"
    default['COBP_FE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_FE-Central']['mail_host']     = "mail.private.va1.tellme.com"
    default['COBP_FE-Central']['ntp_server']    = "ntp01.private.va1.tellme.com"
    default['COBP_FE-Central']['OKTA-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_FE-Central']['OKTA-ISSUER'] = "https://sso-247-inc.okta.com/oauth2/aus4cot0qqJWQJD8z2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_FE-Central']['OKTA-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_FE-Central']['OKTA-LOGIN-REDIRECT-URI'] = "https://client-prov.247-inc.net/clients"
    default['COBP_FE-Central']['OKTA-SCOPES'] = "openid profile email"
    default['COBP_FE-Central']['COMPONENT_SELECT_ALL']    = "true"
    default['COBP_FE-Central']['SELF-SERVE_URL']    = "https://palette.247-inc.net/workflow"

else
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
