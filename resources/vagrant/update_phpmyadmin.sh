#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Install Update phpMyAdmin on Ubuntu 18.04 Development Server
# A bash script used to update phpMyAdmin via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash update_phpmyadmin.sh" from your terminal as well.
##################

###########
## ALERT ##
###########
# Dont run this script if you don't have an outdated phpMyAdmin installation
# in your server, first, install phpMyAdmin, update it later with this script.
#
# Reference: https://askubuntu.com/questions/947805/how-to-upgrade-phpmyadmin-revisited

PMA_VERSION=5.0.1
cd ~
echo -e "\e[96m Updating phpMyAdmin \e[39m"

echo -e "\e[96m Downloading phpMyAdmin version $PMA_VERSION  \e[39m"
wget -c https://files.phpmyadmin.net/phpMyAdmin/$PMA_VERSION/phpMyAdmin-$PMA_VERSION-english.zip -O phpMyAdmin-$PMA_VERSION-english.zip

echo -e "\e[96m Extracting zip  \e[39m"
unzip -q -o phpMyAdmin-$PMA_VERSION-english.zip

echo -e "\e[96m Fix configs  \e[39m"
# https://stackoverflow.com/questions/34539132/updating-phpmyadmin-blowfish-secret-via-bash-shell-script-in-linux
randomBlowfishSecret=`openssl rand -base64 32`;
sed -e "s|cfg\['blowfish_secret'\] = ''|cfg['blowfish_secret'] = '$randomBlowfishSecret'|" phpMyAdmin-$PMA_VERSION-english/config.sample.inc.php > phpMyAdmin-$PMA_VERSION-english/config.inc.php

echo -e "\e[96m Backup old installation  \e[39m"
sudo mv /usr/share/phpmyadmin /usr/share/phpmyadmin.bak

echo -e "\e[96m Move new installation  \e[39m"
sudo mv phpMyAdmin-$PMA_VERSION-english /usr/share/phpmyadmin

echo -e "\e[96m Fix tmp folder  \e[39m"
sudo mkdir -p /usr/share/phpmyadmin/tmp

echo -e "\e[96m Changing folder owner \e[39m"
sudo chown -R www-data:www-data /usr/share/phpmyadmin/tmp

echo -e "\e[96m Cleanup  \e[39m"
sudo rm -rf /usr/share/phpmyadmin.bak
sudo rm -r phpMyAdmin-$PMA_VERSION-english.zip

echo -e "\e[96m phpMyAdmin updated to $PMA_VERSION  \e[39m"

echo -e "\e[93m Way to go! update_phpmyadmin.sh has been completed with no errors! Moving on!\e[39m"

