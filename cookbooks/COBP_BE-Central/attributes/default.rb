override['filebeat']['group.name'] = "cs"
override['filebeat']['app.name'] = "cobp-be"
override['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/cobp/logs/application.log", "/var/tellme/cobp/logs/archived/application*"],
            "document_type": "cobpbe-app"
    },
    {
            "paths": ["/var/tellme/cobp/logs/console.log", "/var/tellme/cobp/logs/archived/console*"],
            "document_type": "cobpbe-con-app"
    }
]';

default['COBP_BE-Central']['JAVA']="jdk1.8"
default['COBP_BE-Central']['COBP-APP-HOME'] = "/var/tellme/cobp"
default['COBP_BE-Central']['COBP-APP-BUILD-DIR'] = "#{node['COBP_BE-Central']['COBP-APP-HOME']}/build"
default['COBP_BE-Central']['COBP-APP-BIN-DIR'] = "#{node['COBP_BE-Central']['COBP-APP-HOME']}/bin"
default['COBP_BE-Central']['COBP-APP-CONFIG-DIR'] = "#{node['COBP_BE-Central']['COBP-APP-HOME']}/conf"
default['COBP_BE-Central']['COBP-APP-LOG-DIR'] = "#{node['COBP_BE-Central']['COBP-APP-HOME']}/logs"
default['COBP_BE-Central']['COBP-APP-LOG-ARCHIVE-DIR'] = "#{node['COBP_BE-Central']['COBP-APP-LOG-DIR']}/archived"
default['COBP_BE-Central']['COBP-APP-LOGBACK-URL'] = "#{node['COBP_BE-Central']['COBP-APP-CONFIG-DIR']}/logback.xml"
default['COBP_BE-Central']['COBP-APP-CLEANUP-SCRIPT-URL'] = "#{node['COBP_BE-Central']['COBP-APP-BIN-DIR']}/cobp_be_log_cleanup.sh"
default['COBP_BE-Central']['COBP-APP-WAR'] = 'cobp.jar'
default['COBP_BE-Central']['CONF-FILE']  = "/tools/config/current/statusd.conf"
default['COBP_BE-Central']['CHECK-PROCESS-JAVA']  = "cobp"
default['COBP_BE-Central']['COBP-APP-ALLOWED-ORIGINS'] = "*"
default['COBP_BE-Central']['COBP-APP-MESSAGING-COMPONENENT-NAMES'] = "messagingForChat,messagingForAIVA"
default['COBP_BE-Central']['COBP-APP-TO-EMAIL']='shailesh.agrawal@247.ai'
default['COBP_BE-Central']['COBP-APP-SUBJECT']='Tag package for the client'
default['COBP_BE-Central']['COBP-APP-SMTP-SERVER']='localhost'
default['COBP_BE-Central']['COBP-APP-SUBJECT-VALIDATIONPROVISION-FAILED']='Provisioning Failed'
default['COBP_BE-Central']['COBP-APP-SMTP-PORT']='9090'
default['COBP_BE-Central']['COBP-APP-CORE-COMPONENT_SELECTION_ENABLED'] = "false"
default['COBP_BE-Central']['COBP_BE-CentralMailer']  = "/usr/local/statusd/libexec/check_spiritMailer"
default['COBP_BE-Central']['COBP_BE-COBPJava']  = "/usr/local/statusd/libexec/check_process_cobp"
default['COBP_BE-Central']['COBP_BE-CheckLOG']  = "/usr/local/statusd/libexec/check_log_expression"
default['COBP_BE-Central']['COBP-APP-CACHE-TTL'] = "3600"
default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
default['COBP_BE-Central']['COBP-APP-MAX-PAYLOAD-SIZE'] = "2048"

case node.chef_environment
when 'CENTRAL-DEV'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='harsh.sama@247.ai'
	default['COBP_BE-Central']['COBP-APP-CC']='harsh.sama@247.ai ,subhasish.c@247.ai , ravi.b@247.ai'
	default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding-dev@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='https://central-dev.lb-priv.sv2.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://dev-client-prov01.db.shared.int.sv2.247-inc.net:3306/cobp?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/commit/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central-dev.lb-priv.sv2.247-inc.net'
	default['COBP_BE-Central']['location']      = "sv2"
    default['COBP_BE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.write.central-app.qacore2.int.lb-priv.sv2.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.oktapreview.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "auseahswukBL6I2Ns0h7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oacso99t094i77Jq0h7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "GUx6vCwKabA0-u2i0pD8SrAJ2d5VlpLbVRsaoVCZ"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.sv2.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00gWBbmp4xq5t19gTdF6TlTRHM7CJI0RkaOaZ_ZVzo"

when 'CENTRAL-QA'
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='harsh.sama@247.ai'
	default['COBP_BE-Central']['COBP-APP-CC']='harsh.sama@247.ai ,subhasish.c@247.ai , ravi.b@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding-qa@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='http://central-qa.lb-priv.sv2.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://qa-client-prov01.db.shared.int.sv2.247-inc.net:3306/cobp?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/qa/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='true'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central-qa.lb-priv.sv2.247-inc.net'
	default['COBP_BE-Central']['location']      = "sv2"
    default['COBP_BE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.write.central-app.qacore3.int.lb-priv.sv2.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.oktapreview.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "auseahswukBL6I2Ns0h7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oacso99t094i77Jq0h7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "GUx6vCwKabA0-u2i0pD8SrAJ2d5VlpLbVRsaoVCZ"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.sv2.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00gWBbmp4xq5t19gTdF6TlTRHM7CJI0RkaOaZ_ZVzo"

when 'CENTRAL-PSR'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='harsh.sama@247.ai'
	default['COBP_BE-Central']['COBP-APP-CC']='harsh.sama@247.ai ,subhasish.c@247.ai , ravi.b@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding-psr@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='http://central-qa.lb-priv.sv2.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://psr-client-prov01.db.shared.int.sv2.247-inc.net:3306/cobp?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/psr/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central-qa.lb-priv.sv2.247-inc.net'
	default['COBP_BE-Central']['location']      = "sv2"
    default['COBP_BE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.write.central-app.qacore3.int.lb-priv.sv2.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "aus4cot0qqJWQJD8z2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.sv2.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00gWBbmp4xq5t19gTdF6TlTRHM7CJI0RkaOaZ_ZVzo"

when 'CENTRAL-STABLE'
	override['logstash']['hosts']= "stable-logstash.lb-priv.sv2.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='harsh.sama@247.ai'
    default['COBP_BE-Central']['COBP-APP-CC']='harsh.sama@247.ai ,subhasish.c@247.ai , ravi.b@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding-stable@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='http://central-qa.lb-priv.sv2.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://stable-client-prov01.db.shared.int.sv2.247-inc.net:3306/cobp?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stable-env/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central-qa.lb-priv.sv2.247-inc.net'
	default['COBP_BE-Central']['location']      = "sv2"
    default['COBP_BE-Central']['webserver']     = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.backside.sv2.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.backside.sv2.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.backside.sv2.tellme.com"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.write.central-app.qacore3.int.lb-priv.sv2.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.oktapreview.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "auseahswukBL6I2Ns0h7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oacso99t094i77Jq0h7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "GUx6vCwKabA0-u2i0pD8SrAJ2d5VlpLbVRsaoVCZ"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.sv2.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00gWBbmp4xq5t19gTdF6TlTRHM7CJI0RkaOaZ_ZVzo"

when 'CENTRAL-SV1-STAGE'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-CC']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding-stage@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='https://central-stage.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://client-prov.db.stg.lb-priv.sv1.247-inc.net:3306/client_on_board?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central-stage.247-inc.net'
	default['COBP_BE-Central']['location']      = "sv1"
    default['COBP_BE-Central']['webserver']     = "probe.private.sv1.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.private.sv1.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.private.sv1.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.private.sv1.tellme.com"
	default['COBP_BE-Central']['COBP-APP-ALLOWED-ORIGINS'] = "https://staging-client-prov.247-inc.net,https://client-prov.web.stg.lb-pub.sv1.247-inc.net,http://client-prov01.web.shared.stg.sv1.247-inc.net,http://client-prov02.web.shared.stg.sv1.247-inc.net"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.central-app.staging.wip.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "aus4cot0qqJWQJD8z2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.sv1.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00aVrQjYf1P6puk3Fe9atbOj5QX0ejtLtvn3rRFBgh"

 when 'CENTRAL-VA1-STAGE'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-CC']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding-stage@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='https://central-stage.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://client-prov.db.stg.lb-priv.va1.247-inc.net:3306/client_on_board?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/stage/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central-stage.247-inc.net'
	default['COBP_BE-Central']['location']      = "va1"
    default['COBP_BE-Central']['webserver']     = "probe.private.va1.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.private.va1.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.private.va1.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.private.va1.tellme.com"
	default['COBP_BE-Central']['COBP-APP-ALLOWED-ORIGINS'] = "https://staging-client-prov.247-inc.net,https://client-prov.web.stg.lb-pub.va1.247-inc.net,http://client-prov01.web.shared.stg.va1.247-inc.net,http://client-prov02.web.shared.stg.va1.247-inc.net"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.central-app.staging.wip.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "aus4cot0qqJWQJD8z2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.va1.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00aVrQjYf1P6puk3Fe9atbOj5QX0ejtLtvn3rRFBgh"

 when 'CENTRAL-SV1-PROD'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.sv1.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-CC']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='https://central.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://client-prov.db.lb-priv.sv1.247-inc.net:3306/client_on_board?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central.247-inc.net'
	default['COBP_BE-Central']['location']      = "sv1"
    default['COBP_BE-Central']['webserver']     = "probe.private.sv1.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.private.sv1.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.private.sv1.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.private.sv1.tellme.com"
	default['COBP_BE-Central']['COBP-APP-ALLOWED-ORIGINS'] = "https://client-prov.247-inc.net,https://client-prov.web.lb-pub.sv1.247-inc.net,http://client-prov01.web.shared.sv1.247-inc.net,http://client-prov02.web.shared.sv1.247-inc.net"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.central-app.wip.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "aus4cot0qqJWQJD8z2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.sv1.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00aVrQjYf1P6puk3Fe9atbOj5QX0ejtLtvn3rRFBgh"

 when 'CENTRAL-VA1-PROD'
	override['logstash']['hosts']= "logstash.logpool.lb-priv.va1.247-inc.net:5120"
	default['COBP_BE-Central']['COBP-APP-TO-EMAIL-VALIDATIONPROVISION-FAILED']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-CC']='central-team@247.ai'
    default['COBP_BE-Central']['COBP-APP-SLA_BREACH_FLAG']='true'
	default['COBP_BE-Central']['COBP-APP-FROM-EMAIL']='clientonboarding@247.ai'
    default['COBP_BE-Central']['COBP-APP-CWP-URL']='https://central.247-inc.net/cwp/api/client/add'
	default['COBP_BE-Central']['DB-URL']='jdbc:mysql://client-prov.db.lb-priv.va1.247-inc.net:3306/client_on_board?useSSL=false'
	default['COBP_BE-Central']['WAR-REPO'] = 'http://nexus.cicd.sv2.247-inc.net/nexus/repository/prod/com/tfsc/ilabs/cobp-be/promoted/cobp-be-promoted.jar'
	default['COBP_BE-Central']['DB-USER']='centraladmin'
	default['COBP_BE-Central']['DB-PASS']='central@247'
	default['COBP_BE-Central']['COBP-APP-SSO-DISABLE']='false'
	default['COBP_BE-Central']['COBP-APP-SSO-BASE-URL']='https://sso.central.247-inc.net'
	default['COBP_BE-Central']['location']      = "va1"
    default['COBP_BE-Central']['webserver']     = "probe.private.va1.tellme.com"
    default['COBP_BE-Central']['probeserver']   = "probe.private.va1.tellme.com"
    default['COBP_BE-Central']['release']       = "statusd-20171023T2140"
    default['COBP_BE-Central']['mail_host']     = "mail.private.va1.tellme.com"
    default['COBP_BE-Central']['ntp_server']    = "ntp01.private.va1.tellme.com"
	default['COBP_BE-Central']['COBP-APP-ALLOWED-ORIGINS'] = "https://client-prov.247-inc.net,https://client-prov.web.lb-pub.va1.247-inc.net,http://client-prov01.web.shared.va1.247-inc.net,http://client-prov02.web.shared.va1.247-inc.net"
	default['COBP_BE-Central']['COBP-APP-OHS-DOMAIN-NAME']    = "orginfo.central-app.wip.247-inc.net"
	default['COBP_BE-Central']['COBP-ENABLE-AUTH-TYPE'] = "okta"
    default['COBP_BE-Central']['COBP-APP-BASE-URL'] = "https://sso-247-inc.okta.com/"
    default['COBP_BE-Central']['COBP-APP-OKTA-AUTH-SERVICE-ID'] = "aus4cot0qqJWQJD8z2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-ID'] = "0oa4coo30lLH9wDdM2p7"
    default['COBP_BE-Central']['COBP-APP-CLIENT-SECRET'] = "c7ah5C-rKb80bFKwENnVHXF90eeNeUe4eqN2CcW4"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-TIMEOUT'] = "1000"
    default['COBP_BE-Central']['COBP-APP-OKTA-CONNECTION-MULTIPLY'] = "1000"
    default['COBP_BE-Central']['COBP-APP-PROXY-ENABLE'] = "true"
    default['COBP_BE-Central']['COBP-APP-PROXY-HOST'] = "proxy-grp1.lb-priv.va1.247-inc.net"
    default['COBP_BE-Central']['COBP-APP-PROXY-PORT'] = "3128"
    default['COBP_BE-Central']['COBP-APP-PROXY-PROTOCOL'] = "http"
    default['COBP_BE-Central']['COBP-APP-OKTA-API_KEY'] = "00aVrQjYf1P6puk3Fe9atbOj5QX0ejtLtvn3rRFBgh"

else
   puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
