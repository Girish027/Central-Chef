#cd secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
case node.chef_environment
when '_default'
        node.default['Ajuba-OHS']['db_username'] = "root"
        node.default['Ajuba-OHS']['db_password'] = "nimo"
        node.default['Ajuba-OHS']['db_read_username'] = "root"
        node.default['Ajuba-OHS']['db_read_password'] ="nimo"
when 'assistqacore'
       # db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag", "ohs_credentials_assistqacore2", secret)
        node.default['Ajuba-OHS']['db_username'] = "root"
        node.default['Ajuba-OHS']['db_password'] = "nimo"
        node.default['Ajuba-OHS']['db_read_username'] = "root"
        node.default['Ajuba-OHS']['db_read_password'] ="nimo"
 when 'assistqacore2', 'assistqacore3'
        node.default['Ajuba-OHS']['db_username'] = "root"
        node.default['Ajuba-OHS']['db_password'] = ""
        node.default['Ajuba-OHS']['db_read_username'] = "root"
        node.default['Ajuba-OHS']['db_read_password'] =""
when 'Ajuba-Stage-SV1'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_stage_sv1", "ohs_credentials_stage_sv1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "central@247"
when 'Ajuba-Stage-VA1'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_stage_va1", "ohs_credentials_stage_va1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "central@247"
when 'Ajuba-Prod-SV1'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_sv1", "ohs_credentials_sv1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "central@247"
when 'Ajuba-Prod-VA1'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_va1", "ohs_credentials_va1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "central@247"
when 'OHS-Sandbox'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_va1", "ohs_credentials_va1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "central@247"

when 'CENTRAL-STABLE'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_va1", "ohs_credentials_va1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "central@247"

when 'CENTRAL-DOCKER'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_va1", "ohs_credentials_va1", secret)
        node.default['Ajuba-OHS']['db_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_password'] = "Central@247"
        node.default['Ajuba-OHS']['db_read_username'] = "centraladmin"
        node.default['Ajuba-OHS']['db_read_password'] = "Central@247"

end