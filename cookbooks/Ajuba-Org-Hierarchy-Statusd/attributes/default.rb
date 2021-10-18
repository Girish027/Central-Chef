default['Ajuba-Org-Hierarchy-Statusd']['conf_dir'] = "/var/tellme"
default['Ajuba-Org-Hierarchy-Statusd']['statusd_conf_path'] = "/tools/config/current"
default['Ajuba-Org-Hierarchy-Statusd']['statusd_ohs'] = "/usr/local/statusd/libexec/check_tomcat_ohs"
default['Ajuba-Org-Hierarchy-Statusd']['statusd_uac'] = "/usr/local/statusd/libexec/check_tomcat_uac"
default['Ajuba-Org-Hierarchy-Statusd']['CONF-FILE']  = "/tools/config/current/statusd.conf"

puts "Chef Environment is --> #{node.chef_environment}"
case node.chef_environment
when 'assistqacore'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "sv2"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'assistqacore2'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "sv2"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'assistqacore3'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "sv2"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'CENTRAL-STABLE'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "sv2"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'Ajuba-Stage-SV1'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "sv1"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.private.sv1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.private.sv1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.private.sv1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.private.sv1.tellme.com"

when 'Ajuba-Stage-VA1'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "va1"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"

when 'Ajuba-Prod-SV1'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "sv1"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.private.sv1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.private.sv1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.private.sv1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.private.sv1.tellme.com"

when 'Ajuba-Prod-VA1'
        default['Ajuba-Org-Hierarchy-Statusd']['location'] = "va1"
        default['Ajuba-Org-Hierarchy-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Org-Hierarchy-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Org-Hierarchy-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"

else
        puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end
