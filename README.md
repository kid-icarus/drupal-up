#Drupal Up!

Provision a virtual machine to start using Drupal quickly.

##Requirements:
 * [VirtualBox](https://www.virtualbox.org)
 * [Vagrant](http://vagrantup.com)

##Installation:
 - Clone this repo.

 - `cd vagrantfile; vagrant up`
 - `echo '192.168.33.10 drupal.dev' >> /etc/hosts`

 - The box will download and provision itself. It takes a while. Enjoy
   some of your favorite beverage ヽ༼ຈل͜ຈ༽ﾉ

##Usage:
 - Access the site via navigating to http://drupal.dev/ in a browser.

 - To access the guest machine via SSH, simply navigate to `vagrantfile` and
   run `vagrant ssh`.

 - Once the box is finished being provisioned, you can modify source from
   either the guest or the host machine. The once empty 'drupal' folder shall
   no longer be empty. On the guest, this will be located at /var/www/drupal.dev

##Default Credentials:
 - SSH (just use `vagrant ssh`):
   - User: `vagrant`
   - Password: `vagrant`
   - Host: 192.168.3.11

 - MySQL:
   - User: `drupal`
   - Password: `drupalsql`
   - Database: `drupaldb`

 - Drupal:
   - User: `admin`
   - Password: `admindrupal`
