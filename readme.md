# MyApp
Kickstart environment for your projects.

## Prerequisites
### Required
- Vagrant

### Recommended
- VirtualBox
***

## Installation
Open a terminal window and go to your folder where you will create your project (i.e. /Volumes/Sites/).
#### Clone the repository into your working folder
```
git clone git@gitlab.wayox.net:util/anewproject.git YOUR_PROJECT_NAME
```
Remember to update YOUR_PROJECT_NAME with your actual project name
#### Go inside your project (i.e. /Volumes/Sites/YOUR_PROJECT_NAME)
```
cd /Volumes/Sites/YOUR_PROJECT_NAME
```
Remember to update YOUR_PROJECT_NAME with your actual project name
#### Updating your hosts file
MacOS & Linux
In your terminal, run
```
sudo nano /etc/hosts
```
PC
```
Open [SystemRoot]\system32\drivers\etc\hosts and edit the file with your text editor with admin privileges.
```
Add the following lines at the end of this hosts file
```
192.168.30.10   myapp.ly
```
MacOS & Linux: 'Ctrl+O' then 'y' to save and 'Ctrl+X' to quit nano.
PC: Save and quit your editor.
#### Run Vagrant to initialize your environment.
```
vagrant up
```
Vagrant will initialize and will perform all required tasks to set up your virtual environment, this process takes a lot of time the first time you run it, because vagrant will download the box we are using. After the box is downloaded the first time, the process will still take some time but way less than the first time.

That's it! You should be reading something like this
```
==> MyApp: Run your website or app at http://192.168.30.10 or at http://myapp.ly
```
If don't, please refer to the troubleshoot section below.
## Customization
### VirtualBox
Make sure that you installed VirtualBox, this app and its GUI will help you with your multiple environments.
### Setting up multiple environments
If you like this solution to set up your environment but you prefer to use your app name insted of the placeholder "MyApp" or you decide to run multiple environments at a time, you need to do some changes in your files to run all of them without any problem.

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
#### Updating your hosts file
Refer to the instalation section above to access your hosts file. Add the following lines at the end of the file
```
YOUR.CUSTOM.IP.ADDRESS   yourprojectname.ly
```
Save and quit your editor.
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
echo "xdebug.remote_host=ANOTHER.CUSTOM.IP.ADDRESS" | sudo tee -a /etc/php/7.4/apache2/php.ini
// Please note that the last 0 was removed, so change it like the example below
echo "xdebug.remote_host=192.168.31.1" | sudo tee -a /etc/php/7.4/apache2/php.ini
```
##### Regarding the file seed_mysql.sh
Please note that the file seed_mysql.sh is a dummy dump file, so you will have to make changes according to your app requirements.

### And away you go...!!! You are ready to work!
Check VirtualBox app to see all your vagrant instances, each one of them is properly identified with YourProjectName.

***
## Troubleshooting

### Error 1: Brownser not showing the index page.
First, try using YOUR.CUSTOM.IP.ADDRESS instead of http://yourprojectname.ly, if it loads, then you need to flush your DNS or maybe you didnt update properly your hosts file
#### How to flush the local DNS cache
MacOSX (depending on what you’re running, try any of these)
```
sudo killall -HUP mDNSResponder
sudo discoveryutil mdnsflushcache
```
Windows
```
ipconfig /flushdns
```
Linux (depending on what you’re running, try any of these)
```
/etc/init.d/named restart
/etc/init.d/nscd restart
```

Once your DNS were flushed, try again.
### Error 2: You didn't see the custom success message indicated above.
If you didn't read that message, check where the process was halted
* If the process halted during the vagrant initialization, try rebooting your computer or reinstalling vagrant, that should fix it.
* If it halted on the provision, try commenting some of the provision lines and destroy your machine with ```vagrant destroy```, confirm with ```y``` and try to load it up again with ```vagrant up```

If the machine worked again, check the provision file that was not working and see if any of your changes broke the script.
