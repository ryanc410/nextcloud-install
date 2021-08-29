#!/bin/bash


########################
# VARIABLES
########################

ip=$(curl ifconfig.me.)

# Fill in below this line only

MYSQL_ROOT_PW=
MYSQL_USER=
MYSQL_USER_PW=
nextcloud_user=
ncuser_pass=

########################
# FUNCTIONS
########################

check_os()
{
    if [[ $OSTYPE != linux-gnu ]]; then
        title
        echo "Script is not compatible with your OS."
        sleep 3
        exit 1
    fi
}
pub_ip()
{
    command -v curl &>/dev/null
        if [[ $? -ne 0 ]]; then
            sudo apt install curl -y &>/dev/null
        fi
}
title()
{
    clear
    echo "#########################################"
    echo "#    Nextcloud Auto Installer Script    #"
    echo "#########################################"
    echo "
}

check_os

pub_ip

title

# Update the server
sudo apt update && sudo apt upgrade -y

# Install apache2
sudo apt install apache2 apache2-utils -y

sudo systemctl start apache2 && sudo systemctl enable apache2

# Set Web Root permissions
sudo chown www-data:www-data /var/www/html/ -R

# Create Servername.conf and enable it
sudo echo "ServerName localhost">>/etc/apache2/conf-available/servername.conf

sudo a2enconf servername.conf

sudo systemctl reload apache2

# Install Mariadb server
sudo apt install mariadb-server mariadb-client

# Start and enable mariadb server
sudo systemctl start mariadb && sudo systemctl enable mariadb

# Mysql secure installation
mysql <<BASH_QUERY
SET PASSWORD FOR root@localhost = PASSWORD('$MYSQL_ROOT_PW');
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test_%';
CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USER_PW';
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'localhost';FLUSH PRIVILEGES;
BASH_QUERY

sudo apt install php7.4 libapache2-mod-php7.4 php7.4-mysql php-common php7.4-cli php7.4-common php7.4-json php7.4-opcache php7.4-readline -y

sudo a2dismod php7.4

sudo apt install php7.4-fpm -y

sudo a2enmod proxy_fcgi setenvif

sudo a2enconf php7.4-fpm

sudo systemctl restart apache2

wget https://download.nextcloud.com/server/releases/nextcloud-22.1.0.zip

sudo apt install unzip -y

sudo unzip nextcloud-22.1.0.zip -d /var/www/

sudo chown www-data:www-data /var/www/nextcloud/ -R

sudo mysql<<_QUERY
create database nextcloud;
create user $nextcloud_user@localhost identified by '$ncuser_pass';
grant all privileges on nextcloud.* to $nextcloud_user@localhost identified by '$ncuser_pass';
flush privileges;
exit;
_QUERY

cat <<- _EOF_ >> /etc/apache2/sites-available/nextcloud.conf
<VirtualHost $ip:80>
        DocumentRoot "/var/www/nextcloud"
        ServerName $domain

        ErrorLog ${APACHE_LOG_DIR}/nextcloud.error
        CustomLog ${APACHE_LOG_DIR}/nextcloud.access combined

        <Directory /var/www/nextcloud/>
            Require all granted
            Options FollowSymlinks MultiViews
            AllowOverride All

           <IfModule mod_dav.c>
               Dav off
           </IfModule>

        SetEnv HOME /var/www/nextcloud
        SetEnv HTTP_HOME /var/www/nextcloud
        Satisfy Any

       </Directory>

</VirtualHost>
_EOF_

sudo a2ensite nextcloud.conf

sudo a2enmod rewrite headers env dir mime setenvif ssl

sudo systemctl restart apache2

sudo apt install imagemagick php-imagick libapache2-mod-php7.4 php7.4-common php7.4-mysql php7.4-fpm php7.4-gd php7.4-json php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp -y

sudo systemctl reload apache2

sudo apt install certbot python3-certbot-apache -y

sudo certbot --apache --agree-tos --redirect --staple-ocsp --email admin@$domain -d $domain

sudo sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.4/apache2/php.ini

sudo systemctl reload apache2

sudo sed -i 's/memory_limit = 128M/memory_limit = 512M/g' /etc/php/7.4/fpm/php.ini

sudo systemctl reload php7.4-fpm

sudo apt install redis-server -y

sudo systemctl start redis-server && sudo systemctl enable redis-server

sudo apt install php-redis -y

sudo phpenmod redis

sudo systemctl reload apache2

sed -i '$ d' /var/www/nextcloud/config/config.php

cat << _EOF_ >> /var/www/nextcloud/config/config.php
'memcache.distributed' => '\OC\Memcache\Redis',
'memcache.local' => '\OC\Memcache\Redis',
'memcache.locking' => '\OC\Memcache\Redis',
'redis' => array(
     'host' => 'localhost',
     'port' => 6379,
     ),
_EOF_

sudo systemctl restart apache2 php7.4-fpm

sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 1024M/g' /etc/php/7.4/fpm/php.ini

sudo systemctl restart php7.4-fpm





