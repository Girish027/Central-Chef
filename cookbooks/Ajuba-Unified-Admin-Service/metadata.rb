name             'Ajuba-Unified-Admin-Service'
maintainer       '[24]7'
maintainer_email 'central-team@247.ai'
license          'All rights reserved'
description      'Installs/Configures Ajuba-Unified-Admin-Service'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.10'

depends 'Central-tomcat8',"= 0.0.3"
depends 'filebeat-cs',"= 1.0.0"