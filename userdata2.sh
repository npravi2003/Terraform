#!/bin/bash
yum install httpd -y
echo "<h1>This is Webserver2</h1>">/var/www/html/index.html
service httpd start
chkconfig httpd on

