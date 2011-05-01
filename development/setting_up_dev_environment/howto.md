# Installing Zend Server CE (PHP 5.2 & PHP 5.3)

Because we have older projects to maintain and newer projects that can benifit from features of PHP 5.3 we need a way to switch between PHP-versions. Therefor
we install Zend Server CE (PHP 5.2)) and Zend Server CE (PHP 5.3).

# Install

* Download both version at: [http://www.zend.com/en/products/server-ce/downloads](http://www.zend.com/en/products/server-ce/downloads).
* Install the 5.2 version.
* Stop the server if needed: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Move the startup-file into it's own directory: `sudo mv /etc/zce.rc /usr/local/zend/etc`.
* Move the full install into a seperate folder: `sudo mv /usr/local/zend /usr/local/zend-5.2`.
* Install the 5.3 version.
* Stop the server if needed: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Move the startup-file into it's own directory: `sudo mv /etc/zce.rc /usr/local/zend/etc`.
* Move the full install into a seperate folder: `sudo mv /usr/local/zend /usr/local/zend-5.3`.
* Create an initial link for 5.2: sudo ln -s /usr/local/zend-5.2 /usr/local/zend
* Start the server: `sudo /usr/local/zend/bin/zendctl.sh start`.

## Post install

If you want to use stuff like pear/pecl from the commandline we need to alter our $PATH variable. If you're using [Zsh](http://www.zsh.org/) you can follow the steps below:

* Edit ~/.zshrc
* Add `/usr/local/zend` to your path and `/usr/local/zend/lib` to LD_LIBRARY_PATH
* Restart your shell.

## Make it work on port 80 instead of 10088

We don't like custom ports, so I want it to work on port 80 (like it should).

* Make sure the default apache isn't running on your system
* Stop the server if needed: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Edit `/usr/local/zend-5.2/apache2/conf/httpd.conf` and replace `Listen 10088` with `Listen 80`.
* Edit `/usr/local/zend-5.2/apache2/bin/apachectl` and change `STATUSURL="http://localhost:10088/server-status"` to `STATUSURL="http://localhost/server-status"`.
* Edit `/usr/local/zend-5.3/apache2/conf/httpd.conf` and replace `Listen 10088` with `Listen 80`.
* Edit `/usr/local/zend-5.3/apache2/bin/apachectl` and change `STATUSURL="http://localhost:10088/server-status"` to `STATUSURL="http://localhost/server-status"`.
* Start the server: `sudo /usr/local/zend/bin/zendctl.sh start`.

## Enable vhosts

Because in the real world we work on multiple projects we need a way to addres these project: vhosts.

* Open `/usr/local/zend-5.2/apache2/conf/httpd.conf`.
* Uncomment `#Include conf/extra/httpd-vhosts.conf`.
* Open `/usr/local/zend-5.2/apache2/conf/extra/httpd-vhosts.conf`.
* Uncomment `NameVirtualHost *:80`.
* Open `/usr/local/zend-5.3/apache2/conf/httpd.conf`.
* Uncomment `#Include conf/extra/httpd-vhosts.conf`.
* Open `/usr/local/zend-5.3/apache2/conf/extra/httpd-vhosts.conf`.
* Uncomment `NameVirtualHost *:80`.

When you need a new vhost follow the steps below:

* Open `/etc/hosts`
* Add a line: `127.0.0.1    <new.vhost>`.
* Open `/usr/local/zend/apache2/conf/extra/httpd-vhosts.conf`.
* Add an item like the code below:

````
<VirtualHost *:80>
	DocumentRoot "<path/to/document/root>"
	ServerName <vhost.local>
	ErrorLog "logs/forkng-local-error.log"
	CustomLog "logs/forkng-local-access.log" common
	<directory "<path/to/document/root>">
		Options Indexes FollowSymLinks
		AllowOverride all
		Order Deny,Allow
		Deny from all
		Allow from 127.0.0.1
	</directory>
</VirtualHost>
````

# Share data between versions

## Share vhosts

* Stop the server if needed: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Create a backup: `sudo cp -R /usr/local/zend-5.2/apache2/conf/extra/httpd-vhost.conf /usr/local/zend-5.2/apache2/conf/extra/httpd-vhost.conf_old`.
* Move the data of 5.3 version: `sudo mv /usr/local/zend-5.3/apache2/conf/extra/httpd-vhost.conf /usr/local/zend-5.3/apache2/conf/extra/httpd-vhost.conf_old`.
* Create a directory that will be shared between the versions: `mkdir -p ~/Zend/server/apache/conf`.
* Move the data of 5.2 to the created folder `sudo mv /usr/local/zend-5.2/apache2/conf/extra/httpd-vhosts.conf ~/Zend/server/apache/conf`.
* Create a symlink: `sudo ln -s ~/Zend/server/apache/conf/httpd-vhosts.conf /usr/local/zend-5.2/apache2/conf/extra/httpd-vhosts.conf`.
* Create a symlink: `sudo ln -s ~/Zend/server/apache/conf/httpd-vhosts.conf /usr/local/zend-5.3/apache2/conf/extra/httpd-vhosts.conf`.
* Start the server: `sudo /usr/local/zend/bin/zendctl.sh start`.

## Share MySQL-data

If you want to share databases between the version you have to follow the steps below.

* Check which users are in the wheel group: `dscl . -read /Groups/wheel GroupMembership`.
* If your username isn't listed, add it: `dscl . -append /Groups/wheel GroupMembership <username>`.

* Stop the server if needed: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Create a backup: `sudo cp -R /usr/local/zend-5.2/mysql/data /usr/local/zend-5.2/mysql/data_old`.
* Move the data of 5.3 version: `sudo mv /usr/local/zend-5.3/mysql/data /usr/local/zend-5.3/mysql/data_old`.
* Create a directory that will be shared between the versions: `mkdir -p ~/Zend/server/mysql`.
* Move the data of 5.2 to the created folder `sudo mv /user/local/zend-5.2/mysql/data ~/Zend/server/mysql/data`.
* Create a symlink: `sudo ln -s ~/Zend/server/mysql/data /user/local/zend-5.2/mysql/data`.
* Create a symlink: `sudo ln -s ~/Zend/server/mysql/data /user/local/zend-5.3/mysql/data`.
* Set correct right: `sudo chown zend:wheel ~/Zend/server/mysql/data`.
* Start the server: `sudo /usr/local/zend/bin/zendctl.sh start`.

If you want to work with mysql from the commandline, you should symlink the socket: `sudo ln -s /usr/local/zend/mysql/tmp/mysql.sock /tmp/mysql.soc`. (see: http://www.stephenrhoades.com/?p=325)


# Switching beteen versions

If you want to switch between version, follow the steps below:

* Stop the running server: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Remove the current link: `sudo rm /usr/local/zend`.
* Switch to the version you need: `sudo ln -s /usr/local/zend-5.x /usr/local/zend` (replace x with the correct version).
* Start the server: `sudo /usr/local/zend/bin/zendctl.sh start`.

Or use the script [`zend_ce_switch_version`](https://github.com/sumocoders/snippets/blob/master/development/setting_up_dev_environment/zend_ce_switch_version): `sudo zend_ce_switch_version <version>`.

Install the script:

* Download the script
* Move the script `sudo mv ~/Downloads/zend_ce_switch_version /usr/local`.
* Make it executable `sudo chmod +x /usr/local/zend_ce_switch_version`.

