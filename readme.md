# MyApp
Kickstart application and environment for your projects.

## Prerequisites
### Required
- Vagrant
### Recommended
- VirtualBox
***

## Installation
#### Clone the repository into your working folder (i.e. /Volumes/Sites/)
```
git clone git@gitlab.wayox.net:util/anewproject.git YOUR_PROJECT_NAME
```
Remember to update YOUR_PROJECT_NAME with your actual project name
#### Go inside your project (i.e. /Volumes/Sites/YOUR_PROJECT_NAME)
```
cd /Volumes/Sites/YOUR_PROJECT_NAME
```
Remember to update YOUR_PROJECT_NAME with your actual project name
#### Run Vagrant to initialize your environment
```
vagrant up
```
Vagrant will initialize and will perform all required tasks to set up your virtual environment
## Customization
### VirtualBox
Make sure that you installed VirtualBox, this app and its GUI will help you with your multiple environments.
### Setting up multiple environments
If you like this solution to set up your environment but you prefer to use your app name insted of the placeholder "MyApp" or you decide to run multiple environments at a time, you need to do some changes in your files to run all those environments without any problem.
### Updating your hosts file
MacOS & Linux
```
sudo nano /etc/hosts
```
PC
```
Open [SystemRoot]\system32\drivers\etc\hosts and edit the file with your text editor with admin privileges.
```
Add the following lines at the end of the file
```
YOUR.CUSTOM.IP.ADDRESS   yourprojectname.ly

```
MacOS & Linux: Ctrl+O to save and Ctrl+X to quit nano.
PC: Save and quit your editor.

***

#### Changing your environment name, URL and updating your provision files
This must be done for each environment and obviously, the name to change must be different for each instance.
##### Go to your VAGRANTFILE and update the following lines
```
config.vm.network "private_network",
  ip: "192.168.30.10"
// Change to a different IP address (YOUR.CUSTOM.IP.ADDRESS), one IP for each vagrant instance
// Consider changing not the last part (10) but change the penultimate (30)
// Like this 
config.vm.network "private_network",
  ip: "192.168.31.10"
```
```
config.vm.hostname = "MyApp.ly"
// Change it to
config.vm.hostname = "YourProjectName.ly"
//Dont forget to use a different name for each instance
```
```
config.vm.define "MyApp" do |myapp|
// Change it to
config.vm.define "YourProjectName" do |yourprojectname|
// Dont forget to use a different name for each instance
```
```
config.vm.provider :virtualbox do |vb|
  vb.name = "MyApp"
// Change it to
config.vm.provider :virtualbox do |vb|
  vb.name = "YourProjectName"
// Dont forget to use a different name for each instance
```
```
  config.vm.post_up_message = "Run your website or app at http://192.168.30.10 or at http://myapp.ly"
// Change it to
config.vm.post_up_message = "Run your website or app at YOUR.CUSTOM.IP.ADDRESS or at http://yourprojectname.ly"
// Dont forget to use a different name and IP for each instance
```
##### Go to your resources/vagrant/myapp.ly.conf and update the following lines
```
  ServerAdmin info@myapp.ly
  ServerName myapp.ly
  ServerAlias www.myapp.ly
//Change it to
  ServerAdmin info@yourprojectname.ly
  ServerName yourprojectname.ly
  ServerAlias www.yourprojectname.ly
```
##### Go to your resources/vagrant/install_xdebug.sh and update the following lines
```
echo "xdebug.remote_host=192.168.30.1" | sudo tee -a /etc/php/7.4/apache2/php.ini
//Change it to
echo "xdebug.remote_host=YOUR.CUSTOM.IP.ADDRESS" | sudo tee -a /etc/php/7.4/apache2/php.ini
// Please note that the last 0 was removed, so change it like the example above
echo "xdebug.remote_host=192.168.31.1" | sudo tee -a /etc/php/7.4/apache2/php.ini
```
##### Regarding the file seed_mysql.sh
Please note that the file seed_mysql.sh is a dummy dump file, so you will have to make changes according to your app requirements.
### And away you go...!!! You are ready to work!