secret = Chef::EncryptedDataBagItem.load_secret("/etc/chef/encrypted_data_bag_secret")
case node.chef_environment
when '_default','DEV'
       db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag", "ohs_credentials_dev", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = db_keys['admin_password']
when 'assistqacore'
        db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag", "ohs_credentials_assistqacore2", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = "nimo"

when 'assistqacore2', 'assistqacore3'
        db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag", "ohs_credentials_assistqacore2", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = db_keys['admin_password']
when 'Ajuba-Stage-SV1'
        db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_stage_sv1", "ohs_credentials_stage_sv1", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = db_keys['admin_password']
when 'Ajuba-Stage-VA1'
        db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_stage_va1", "ohs_credentials_stage_va1", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = db_keys['admin_password']
when 'Ajuba-Prod-SV1'
        db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_sv1", "ohs_credentials_sv1", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = db_keys['admin_password']
when 'Ajuba-Prod-VA1'
        db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_va1", "ohs_credentials_va1", secret)
        node.default['Ajuba-Admin']['db_username'] = db_keys['admin_username']
        node.default['Ajuba-Admin']['db_password'] = db_keys['admin_password']
when 'CENTRAL-STABLE'
        #db_keys = Chef::EncryptedDataBagItem.load("ajuba_databag_va1", "ohs_credentials_va1", secret)
        node.default['Ajuba-Admin']['db_username'] = "centraladmin"
        node.default['Ajuba-Admin']['db_password'] = "central@247"
end
