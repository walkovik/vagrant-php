#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Custom scripts on Ubuntu 18.04 Development Server
# A bash script used to run some special scripts via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash custom.sh" from your terminal as well.
##################

### CUSTOM Script lines
###
### Make sure you add here only unsorted short scripts
### If you plan to make a major change in your server
### consider creating a separate file and name it accordingly.
###
### Also, make sure you will run this file as the last script
### provision for your box.

echo -e "\e[96m Running custom bash scripts lines  \e[39m"
pwd
echo -e "\e[93m Way to go! custom.sh has been completed with no errors! Moving on!\e[39m"