#!/bin/bash
yum update -y
yum install httpd php php-mysql -y
sudo amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
cd /var/www/html
wget https://wordpress.org/wordpress-5.1.1.tar.gz
tar -xzf wordpress-5.1.1.tar.gz
cp -r wordpress/* /var/www/html/
rm -rf wordpress
rm -rf wordpress-5.1.1.tar.gz
chmod -R 755 *
chown -R apache:apache *
chkconfig httpd on
service httpd start