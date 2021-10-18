##################################################################
#### Default Filebeat Confs
###########################################################################
default['filebeat']['version'] ='filebeat-5.6.5  --nogpgcheck'
default['filebeat']['group.name'] = 'defaultGroupname' ### Assign "defaultGroupname" to this variable when testing in local mode
default['filebeat']['app.name'] = 'defaultAppname' ### Assign "defaultAppname" to this variable when testing in local mode
default['filebeat']['certpath'] = "/usr/share/filebeat"
default['filebeat']['yml'] = "/etc/filebeat/filebeat.yml"
default['filebeat']['prospector-conf-directory'] = "/opt/filebeat/prospector-conf"
default['filebeat']['prospector-path'] = "/opt/filebeat/prospector-conf/*.yml"
default['filebeat']['exec-path'] = "/etc/init.d/filebeat"

default['filebeat']['logstash']['host'] = "stable-logstash.lb-priv.sv2.247-inc.net:5093"
##################################################################
#### Default Logstash
###########################################################################
default['logstash']['worker']= "1"
default['logstash']['compression_level']= "3"
default['logstash']['loadbalance']= "true"
#default['logstash']['ssl']['certificate']=
#default['logstash']['ssl']['key']=
default['logstash']['verification_mode']= "none"

####################################################
#### Default Prospector Conf
####################################################
default['prospector']['document_type']="document_type"
default['prospector']['type']="log"
default['prospector']['encoding']="plain"
default['prospector']['exclude_line'] =[]
default['prospector']['include_line'] =[]
default['prospector']['exclude_flies'] =[]
default['prospector']['close_inactive']="1m"
default['prospector']['pattern'] ="^\[[0-9]{4}"
default['prospector']['negate']="true"
default['prospector']['match']="after"
default['prospector']['max_lines']="2000"
default['prospector']['timeouts']="5s"

######################################################################################
#### Default Logging Conf
#######################################################################
default['logging']['to_files']=true;
default['logging']['files']['path']='/var/tellme/log/filebeat/';
default['logging']['files']['filename']='filebeat.log'
default['logging']['files']['rotateeverybytes']=10485760
default['logging']['files']['keepfiles']=7
default['logging']['level']="info";
##################### Uncomment the below only when testing in Local mode
default['filebeat']['filebeat.prospector.config.map'] = '[
    {
            "paths": ["/var/tellme/assist/logs/app/logfile.log"],
            "document_type": "logfile"
    },
    {
            "paths": ["/var/tellme/assist/logs/app/errorLogfile.log"],
            "document_type": "errorlogfile"
    },
    {
            "paths": ["/var/tellme/assist/logs/app/tellme_assist_app.log"],
            "close_inactive": "1h",
            "document_type": "tellme_logfile"
    },
    {
            "paths": ["/var/tellme/assist/logs/app/tellme_assist_app.err"],
            "close_inactive": "1h",
            "document_type": "tellme_errorlogfile"
    },
    {
            "paths": ["/var/tellme/assist/logs/app/healthCheckerLogfile.log"],
            "close_inactive": "1h",
            "document_type": "healthcheckerfile"
    },
    {
            "paths": ["/var/tellme/assist/logs/ftp/logfile.log", "/var/tellme/assist/logs/ftp/tellme_assist_ftp.err", "/var/tellme/assist/logs/ftp/tellme_assist_ftp.log"],
            "close_inactive": "1h",
            "document_type": "ftplogs"
    }
]';