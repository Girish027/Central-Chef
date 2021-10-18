# filebeat
Filebeat packages

Sample output filebeat.yml file:
###################### Filebeat Default Configuration #########################

#================================ General =====================================
filebeat:
  config:
    prospectors:
      reload.enabled: true
      reload.period: 10s
      path: /opt/filebeat/prospector-conf/*.yml
      #/opt/filebeat/prospector-conf/*.yml

#================================ Outputs =====================================

# Configure what outputs to use when sending the data collected by the beat.
# Multiple outputs may be used.

#----------------------------- Logstash output --------------------------------
output.logstash:
  hosts: ['stable-logstash.lb-priv.sv2.247-inc.net:5093']
  worker: 1
  compression_level: 3
  loadbalance: true
  ssl:
    certificate: /usr/share/filebeat/file_beat.crt
    key: /usr/share/filebeat/file_beat.key
    verification_mode: none
#================================ Logging =====================================
logging:
  to_files: true
  files:
    path: /var/tellme/log/filebeat/
    name: filebeat.log
    rotateeverybytes: 10485760
    keepfiles: 7
    level: info

# Sets log level. The default log level is info.