default['Ajuba-Unified-Admin-Statusd']['conf_dir'] = "/var/tellme"
default['Ajuba-Unified-Admin-Statusd']['statusd_conf_path'] = "/tools/config/current"
default['Ajuba-UAC-statusd']['statusd_uac'] = "/usr/local/statusd/libexec/check_tomcat_uac.erb"

puts "Chef Environment is --> #{node.chef_environment}"
case node.chef_environment
when 'assistqacore', 'assistqacore2', 'assistqacore3','_default'
        default['Ajuba-Unified-Admin-Statusd']['location'] = "sv2"
        default['Ajuba-Unified-Admin-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Unified-Admin-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'Ajuba-Stage-SV1', 'Ajuba-Prod-SV1'
        default['Ajuba-Unified-Admin-Statusd']['location'] = "sv1"
        default['Ajuba-Unified-Admin-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Unified-Admin-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"

when 'Ajuba-Stage-VA1', 'Ajuba-Prod-VA1'
        default['Ajuba-Unified-Admin-Statusd']['location'] = "va1"
        default['Ajuba-Unified-Admin-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Unified-Admin-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Unified-Admin-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"
end
