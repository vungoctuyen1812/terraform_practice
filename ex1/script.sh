#!/bin/bash
sudo su
yum update -y
amazon-linux-extras install nginx1 -y

# Install PHP 8.1
amazon-linux-extras enable php8.0
yum clean metadata
yum install php php-cli php-mysqlnd php-pdo php-common php-fpm -y
yum install php-gd php-mbstring php-xml php-dom php-intl php-simplexml -y
systemctl enable php-fpm
systemctl enable nginx

cp /home/ec2-user/sites.conf /etc/nginx/conf.d/ # copy config site
mv /home/ec2-user/html /var/www/ # cp content site

# Start Nginx
service nginx start
service php-fpm start