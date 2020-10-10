#!/bin/bash
# Script will auto terminate on errors
set -euo pipefail
IFS=$'\n\t'

# Ubuntu 18.04+, apache2.4, php 7.x
# Run like - bash install_phpmyadmin.sh
# You should have MySQL pre-installed

echo -e "\e[96m Begin silent install phpMyAdmin \e[39m"

echo -e "\e[93m User: root, Password: root \e[39m"
# Set non-interactive mode
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/app-password-confirm password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/admin-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/mysql/app-pass password root'
sudo debconf-set-selections <<< 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'﻿

sudo apt-get -y install phpmyadmin

# Restart apache server
sudo service apache2 restart

# Clean up
sudo apt-get clean

echo -e "\e[96m phpMyAdmin installed successfully \e[39m"
echo -e "\e[93m Remember, User: root, Password: root \e[39m"

echo -e "\e[93m Way to go! install_phpmyadmin.sh has been completed with no errors! Moving on!\e[39m"
