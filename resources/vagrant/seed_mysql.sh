#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Seed MySQL Server with our database dump file on Ubuntu 18.04 Development Server
# A bash script used to seed database via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash seed_mysql.sh" from your terminal as well.
##################

###########
## ALERT ##
###########
# Dont run this script if you don't have a LAMP installation in your server,
# first, install LAMP Stack and then run this script.
#
# If you changed root password, change it here too.

echo -e "\e[96m Logging as root to create new myapp user\e[39m"
sudo mysql --defaults-extra-file=root.cnf -e "CREATE DATABASE myapp;"
sudo mysql --defaults-extra-file=root.cnf -e "GRANT ALL PRIVILEGES ON myapp.* TO 'myapp'@'localhost' IDENTIFIED BY 'pass';"
echo -e "\e[96m Logging as reports to create our database and seed it\e[39m"

sudo mysql --defaults-extra-file=myapp.cnf -e "USE myapp;"
sudo mysql --defaults-extra-file=myapp.cnf -e "SOURCE /var/www/resources/database/migrations/dump.sql"

echo -e "\e[93m Way to go! seed_mysql.sh has been completed with no errors! Moving on!\e[39m"
