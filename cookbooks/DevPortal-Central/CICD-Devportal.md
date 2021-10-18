
yum install initscripts fontconfig
yum install fontconfig
rpm -Uvh policycoreutils-python-2.0.83-30.1.el6_8.i686.rpm
yum install lighttpd-fastcgi
yum install lighttpd
yum install php72-php php72-php-fpm
yum install  php72-php-pdo php72-php-mysqlnd  php72-php-gd  php72-php-xml php72-php-mbstring php72-php-process
              hp72-php-runtime php72-php-json php72-php-common php72-php-cli
			
yum remove all httpd22
		
copy source folder.


groupadd lighttpd

adduser -g lighttpd -d /var/www/html -s /sbin/nologin lighttpd


chown -R lighttpd:lighttpd /var/www/html

chown lighttpd:lighttpd /var/log/lighttpd


After Drupal has been installed and tested with clean URL disabled, add the following rules to lighty’s configuration file:

server.error-handler-404 = "/index.php";
It basically makes index.php the 404 error handler, so any request that does is not handled by a local file or directory will be sent to Drupal.

Add the following PHP code to Drupal. I just append them to the end of sites/default/settings.php.

if (strpos($_SERVER['SERVER_SOFTWARE'], 'lighttpd') !== false) {
    $_lighty_url = $base_url.$_SERVER['REQUEST_URI'];
    $_lighty_url = @parse_url($_lighty_url);

    if ($_lighty_url['path'] != '/index.php' && $_lighty_url['path'] != '/') {
        $_SERVER['QUERY_STRING'] = $_lighty_url['query'];
        parse_str($_lighty_url['query'], $_lighty_query);
        foreach ($_lighty_query as $key => $val)
            $_GET[$key] = $_REQUEST[$key] = $val;
        $_GET['q'] = $_REQUEST['q'] = substr($_lighty_url['path'], 1);
    }
}


reference :: https://www.cyberciti.biz/tips/installing-and-configuring-lighttpd-webserver-howto.html
https://www.howtoforge.com/tutorial/installing-lighttpd-with-php-5-fpm-and-mysql-on-centos-7/
https://www.howtoforge.com/tutorial/installing-lighttpd-with-php-5-fpm-and-mysql-on-centos-7/2/
http://hostingfu.com/article/running-drupal-with-clean-url-on-nginx-or-lighttpd