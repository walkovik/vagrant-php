#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Configure Apache on Ubuntu 18.04 Development Server
# A bash script used to configure Apache via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash configure_apache.sh" from your terminal as well.
##################

echo -e "\e[96m Adding Virtual Host for our site \e[39m"
pwd
mv myapp.ly.conf /etc/apache2/sites-available/myapp.ly.conf

echo -e "\e[96m Adding the site \e[39m"
sudo a2ensite myapp.ly.conf

echo -e "\e[96m Removing default site \e[39m"
sudo a2dissite 000-default.conf

# You may consider adding the vagrant user to the adm group
# if you plan to have access to some folders like apache logs
#sudo usermod -aG adm vagrant

# If you don't want to add vagrant to the adm group,
# you still can browse the folder with sudo su

# Restart apache server
sudo service apache2 restart

echo -e "\e[93m Way to go! configure_apache.sh has been completed with no errors! Moving on!\e[39m"