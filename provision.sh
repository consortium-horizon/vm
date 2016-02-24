#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

rm -f /etc/network/interfaces.d/eth1.cfg
echo "auto eth1" >> /etc/network/interfaces.d/eth1.cfg
echo "iface eth1 inet static" >> /etc/network/interfaces.d/eth1.cfg
echo "address 192.168.35.25" >> /etc/network/interfaces.d/eth1.cfg
echo "netmask 255.255.255.0" >> /etc/network/interfaces.d/eth1.cfg
ifdown eth1 && ifup eth1

sudo aptitude update -q

# Force a blank root password for mysql
echo "mysql-server mysql-server/root_password password vanilla" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password vanilla" | debconf-set-selections

# Install mysql, nginx, php5-fpm
sudo aptitude install -q -y -f mysql-server mysql-client nginx php5-fpm

# Install commonly used php packages
sudo aptitude install -q -y -f php5-mysql php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcached php5-ming php5-ps php5-pspell php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-xcache
sudo aptitude install -q -y -f git

sudo rm /etc/nginx/sites-available/default

sudo mkdir -p /var/www/webapps/
sudo chown -R www-data:www-data /var/www
sudo chmod a+w -R /var/www
# clone the repo if it isn't already in the shared folder
git clone https://github.com/consortium-horizon/apps.git /var/www/webapps/current --branch testing
# Doesn't change anything since it's a shared folder, but do it anyway, in case shared folder doesn't work
sudo chown -R www-data:www-data /var/www
sudo chmod a+rw -R /var/www

sudo ln -s /var/www/webapps/current/conf/testing/nginx/www /etc/nginx/sites-enabled/

#delete forum if it exists in the share folder (we have to reinstall vanilla since we just spawned the vm)
rm /var/www/webapps/current/forum/conf/config.php

echo "create database vanilla" | mysql -u root -pvanilla

sudo service nginx restart
sudo service php5-fpm restart
