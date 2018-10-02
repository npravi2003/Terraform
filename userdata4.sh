#!/bin/bash
yum install httpd -y
echo "<h1>This is Webserver4</h1>">/var/www/html/index.html
service httpd start
chkconfig httpd on

