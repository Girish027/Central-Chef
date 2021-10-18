case node.chef_environment
when 'Ajuba-QA'
  default["Ajuba-Authorization"]["OH-REST-URL"] = "http://host311.assist.pool.sv2.247-inc.net:80/org-hierarchy-service/versioning/hierarchy-service"
when 'assistqacore2'
  default["Ajuba-Authorization"]["OH-REST-URL"] = "http://host0160.dev.sv2.247-inc.net:8080/org-hierarchy-service/versioning/hierarchy-service"
when 'assistqacore3'
  default["Ajuba-Authorization"]["OH-REST-URL"] = "http://qa-assist24.app.shared.int.sv2.247-inc.net:8080/org-hierarchy-service/versioning/hierarchy-service"
when 'assistqacore'
  default["Ajuba-Authorization"]["OH-REST-URL"] = "http://host0216.dev.sv2.247-inc.net:8080/org-hierarchy-service/versioning/hierarchy-service"
else
  puts "Chef Environment is --> #{node.chef_environment} -- I have no idea what to do with that!"
end