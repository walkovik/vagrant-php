#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Install XDebug on Ubuntu 18.04 Development Server
# A bash script used to install and configure xdebug via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash install_xdebug.sh" from your terminal as well.
##################

echo -e "\e[96m Installing XDebug \e[39m"
sudo pecl channel-update pecl.php.net
sudo pecl install xdebug

echo -e "\e[96m Manually adding XDebug config lines to php.ini \e[39m"
echo "[xdebug]" | sudo tee -a /etc/php/7.4/apache2/php.ini
echo "zend_extension=\"/usr/lib/php/20190902/xdebug.so\"" | sudo tee -a /etc/php/7.4/apache2/php.ini
echo "xdebug.remote_enable=1" | sudo tee -a /etc/php/7.4/apache2/php.ini
echo "xdebug.remote_host=192.168.30.1" | sudo tee -a /etc/php/7.4/apache2/php.ini
echo "xdebug.remote_port=9000" | sudo tee -a /etc/php/7.4/apache2/php.ini
echo "xdebug.remote_connect_back=on" | sudo tee -a /etc/php/7.4/apache2/php.ini
echo "xdebug.remote_autostart=1" | sudo tee -a /etc/php/7.4/apache2/php.ini

# Restart apache server
sudo service apache2 restart

echo -e "\e[93m Way to go! install_xdebug.sh has been completed with no errors! Moving on!\e[39m"
