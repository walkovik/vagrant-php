# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.network "private_network",
  ip: "192.168.30.10"
  config.vm.hostname = "MyApp.ly"
  config.vm.synced_folder ".", "/var/www",
    owner: "www-data", group: "www-data",
    :mount_options => ["dmode=777", "fmode=666"]

# Optional NFS. Make sure to remove other synced_folder line too
# config.vm.synced_folder ".", "/var/www/html", :nfs => { :mount_options => ["dmode=777","fmode=666"] }

# The line below changes the name of the host from "default" to your preferred name.
# These lines should be updated according to each web property.
  config.vm.define "MyApp" do |reports|
end
# Now, we change the name of the Box in the VBox App.
config.vm.provider :virtualbox do |vb|
  vb.name = "MyApp"
end

# Lets add our bash profile and aliases. This is only useful because of the aliases.
config.vm.provision "file", source: "resources/vagrant/.bash_profile", destination: ".bash_profile"
config.vm.provision "file", source: "resources/vagrant/.bash_aliases", destination: ".bash_aliases"

# Adding our db config files, needed for migrations
# We will add these file to the user folder so we can manipulate permissions there without
# interfering with vagrant synced folder permissions.
config.vm.provision "file", source: "resources/vagrant/root.cnf", destination: "root.cnf"
config.vm.provision "file", source: "resources/vagrant/myapp.cnf", destination: "myapp.cnf"
# These files should be read only.
config.vm.provision "shell", inline: <<-SHELL
  sudo su
  chown -R www-data:www-data root.cnf
  chmod 0444 root.cnf
  chown -R www-data:www-data myapp.cnf
  chmod 0444 myapp.cnf
SHELL

# We also need to include our virtual host file in our apache server
# We will configure this later in the configure_apache.sh file
config.vm.provision "file", source: "resources/vagrant/myapp.ly.conf", destination: "myapp.ly.conf"

# Run our external scripts
config.vm.provision "shell", path: "resources/vagrant/install_lamp.sh"
config.vm.provision "shell", path: "resources/vagrant/install_phpmyadmin.sh"
config.vm.provision "shell", path: "resources/vagrant/update_phpmyadmin.sh"
config.vm.provision "shell", path: "resources/vagrant/configure_apache.sh"
config.vm.provision "shell", path: "resources/vagrant/install_xdebug.sh"
config.vm.provision "shell", path: "resources/vagrant/seed_mysql.sh"

# Use the following if required.
#config.vm.provision "shell", path: "resources/vagrant/install_git.sh"
#config.vm.provision "shell", path: "resources/vagrant/install_composer.sh"
#config.vm.provision "shell", path: "resources/vagrant/custom.sh"

# Run our inline scripts, useful for cleanup.
config.vm.provision "shell", inline: <<-SHELL
    sudo su
    echo -e "\e[96m------------------------------------------------\e[39m"
    echo -e "\e[96mRunning Inline Scripts."
    echo -e "\e[96m------------------------------------------------\e[39m"
    pwd
    echo -e "\e[39m"
    # Move Ubuntu Log File
    echo Moving Ubuntu Log File
    now="$(date +'%m-%d-%Y')"
    mv /var/www/ubuntu-bionic-18.04-cloudimg-console.log /var/www/resources/logs/$now-ubuntu-console.log
SHELL

# Now, we add a custom message to the user, so he may know which url/port is going to be used
# in order to run multiple boxes at a time
  config.vm.post_up_message = "Run your website or app at http://192.168.30.10 or at http://myapp.ly"
end

