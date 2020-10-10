#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Install Composer on Ubuntu 18.04 Development Server
# A bash script used to Install and Configure Composer via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash install_composer.sh" from your terminal as well.
##################

echo -e "\e[96m Downloading and installing composer (OldSchool way) \e[39m"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
# Adding composer to .bash_profile, in Vagrantfile, this file should have been already copied in place.
export PATH=~/.composer/vendor/bin:$PATH
# Fix composer folder owner.
sudo chown -R "$USER:$HOME"/.composer

echo -e "\e[96m Checking composer version \e[39m"
composer --version

echo -e "\e[93m Way to go! install_composer.sh has been completed with no errors! Moving on!\e[39m"