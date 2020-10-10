#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Install LAMP on Ubuntu 18.04 Development Server
# A bash script used to install LAMP via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash install_apache.sh" from your terminal as well.
##################

echo -e "\e[96m Adding PPA  (Personal Package Archives)\e[39m"
sudo add-apt-repository -y ppa:ondrej/apache2
sudo add-apt-repository -y ppa:ondrej/php
sudo apt-get update

echo -e "\e[96m Installing apache\e[39m"
sudo apt-get -y install apache2

echo -e "\e[96m Installing php\e[39m"
sudo apt-get -y install php7.4 libapache2-mod-php7.4

echo -e "\e[96m Installing some php extensions\e[39m"
sudo apt-get -y install curl zip unzip php7.4-mysql php7.4-curl php7.4-ctype php7.4-uuid php7.4-iconv php7.4-json php7.4-mbstring php7.4-gd php7.4-intl php7.4-xml php7.4-zip php-gettext php7.4-pgsql php7.4-bcmath php7.4-redis php-dev
sudo phpenmod curl

echo -e "\e[96m Enabling some apache modules\e[39m"
sudo a2enmod rewrite
sudo a2enmod ssl
sudo a2enmod headers

echo -e "\e[96m Restarting apache server\e[39m"
sudo service apache2 restart

echo -e "\e[96m Installing MySQL Server in unattended mode\e[39m"
echo -e "\e[93m Remember these credentials \e[39m"
echo -e "\e[93m User: root, Password: root \e[39m"
echo "mysql-server-5.7 mysql-server/root_password password root" | sudo debconf-set-selections
echo "mysql-server-5.7 mysql-server/root_password_again password root" | sudo debconf-set-selections
sudo apt-get -y install mysql-server-5.7

echo -e "\e[96m Checking php version\e[39m"
php -v
echo -e "\e[96m ------------------------------------\e[39m"
php -r 'echo "PHP have been installed successfully.\n";'
echo -e "\e[96m ------------------------------------\e[39m"
echo -e "\e[96m Checking apache version\e[39m"
apachectl -v
echo -e "\e[96m Checking mysql version\e[39m"
mysql --version

# Clean up cache
sudo apt-get clean

echo -e "\e[93m Way to go! install_lamp.sh has been completed with no errors! Moving on!\e[39m"
