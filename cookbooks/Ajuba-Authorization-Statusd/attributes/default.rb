default['Ajuba-Authorization-Statusd']['conf_dir'] = "/var/tellme"
default['Ajuba-Authorization-Statusd']['statusd_conf_path'] = "/tools/config/current"
default['Ajuba-Authorization-Statusd']['statusd_auth_process'] = "/usr/local/statusd/libexec/check_auth_process"

puts "Chef Environment is --> #{node.chef_environment}"
case node.chef_environment

when '_default', 'Ajuba-Dev'
        default['Ajuba-Authorization-Statusd']['location'] = "sv2"
        default['Ajuba-Authorization-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Authorization-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Authorization-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Authorization-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Authorization-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'Ajuba-QA'
        default['Ajuba-Authorization-Statusd']['location'] = "sv2"
        default['Ajuba-Authorization-Statusd']['webserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Authorization-Statusd']['probeserver'] = "probe.backside.sv2.tellme.com"
        default['Ajuba-Authorization-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Authorization-Statusd']['mail_host'] = "mail.backside.sv2.tellme.com"
        default['Ajuba-Authorization-Statusd']['ntp_server'] = "ntp01.backside.sv2.tellme.com"

when 'Ajuba-Stage-SV1' 
        default['Ajuba-Authorization-Statusd']['location'] = "sv1"
        default['Ajuba-Authorization-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Authorization-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"

when 'Ajuba-Stage-VA1'
        default['Ajuba-Authorization-Statusd']['location'] = "va1"
        default['Ajuba-Authorization-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Authorization-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"

when 'Ajuba-Prod-SV1' 
        default['Ajuba-Authorization-Statusd']['location'] = "sv1"
        default['Ajuba-Authorization-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Authorization-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"

when 'Ajuba-Prod-VA1'
        default['Ajuba-Authorization-Statusd']['location'] = "va1"
        default['Ajuba-Authorization-Statusd']['webserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['probeserver'] = "probe.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['release'] = "statusd-20140507T2140"
        default['Ajuba-Authorization-Statusd']['mail_host'] = "mail.private.va1.tellme.com"
        default['Ajuba-Authorization-Statusd']['ntp_server'] = "ntp01.private.va1.tellme.com"
end


