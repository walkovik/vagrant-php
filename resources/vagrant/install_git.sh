#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

##################
# Install Git on Ubuntu 18.04 Development Server
# A bash script used to install and configure git via Vagrant Provision,
# which should be an unattended installation.
# Script is forced to auto terminate on errors,
# if it fails, run vagrant destroy and up your box again.
#
# You can safely run "bash install_git.sh" from your terminal as well.
##################

echo -e "\e[96m Install latest GIT \e[39m"
sudo add-apt-repository -y ppa:git-core/ppa
sudo apt-get update
sudo apt-get -y install git

# My Git Configs
git config --global --add merge.ff true
git config --global push.followTags true
git config --global core.autocrlf false
git config --global push.default simple
git config --global color.ui auto
git config --global branch.autosetuprebase always
git config --global core.compression 9
git config --global credential.helper 'cache --timeout 28800'
git config --global core.filemode false
git config --global push.default current
git config --global core.editor "nano"
git config --global core.excludesfile '~/.gitignore'

git config --global alias.st status
git config --global alias.co checkout
git config --global alias.logout 'credential-cache exit'

# Clean up
sudo apt-get clean

echo -e "\e[96m Checking git version \e[39m"
git --version

echo -e "\e[93m Way to go! install_git.sh has been completed with no errors! Moving on!\e[39m"
