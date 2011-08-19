# Installing Zend Server CE

# Install

* Download Zend Server CE: [http://www.zend.com/en/products/server-ce/downloads](http://www.zend.com/en/products/server-ce/downloads).
* Install the 5.3 version.

## Post install

If you want to use stuff like pear/pecl from the commandline we need to alter our $PATH variable. If you're using [Zsh](http://www.zsh.org/) you can follow the steps below:

* Edit ~/.zshrc
* Add `/usr/local/zend` to your path and `/usr/local/zend/lib` to LD_LIBRARY_PATH
* Restart your shell.

## Make it work on port 80 instead of 10088

We don't like custom ports, so I want it to work on port 80 (like it should).

* Make sure the default apache isn't running on your system
* Stop the server if needed: `sudo /usr/local/zend/bin/zendctl.sh stop`.
* Edit `/usr/local/zend/apache2/conf/httpd.conf` and replace `Listen 10088` with `Listen 80`.
* Edit `/usr/local/zend/apache2/bin/apachectl` and change `STATUSURL="http://localhost:10088/server-status"` to `STATUSURL="http://localhost/server-status"`.
* Start the server: `sudo /usr/local/zend/bin/zendctl.sh start`.

## Enable vhosts

Because in the real world we work on multiple projects we need a way to addres these project: vhosts.

* Open `/usr/local/zend/apache2/conf/httpd.conf`.
* Uncomment `#Include conf/extra/httpd-vhosts.conf`.
* Open `/usr/local/zend/apache2/conf/extra/httpd-vhosts.conf`.
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

If you want to work with mysql from the commandline, you should symlink the socket: `sudo ln -s /usr/local/zend/mysql/tmp/mysql.sock /tmp/mysql.soc`. (see: http://www.stephenrhoades.com/?p=325)

# Managing vhosts

## Adding

Use the script [`zend_ce_new_vhost`](https://github.com/sumocoders/snippets/blob/master/development/setting_up_dev_environment/zend_ce_new_vhost): `sudo zend_ce_new_vhost <vhost> [<document_root>]`
	
Install the script:

* Download the script
* Move the script `sudo mv ~/Downloads/zend_ce_new_vhost /usr/local/bin`.
* Make it executable `sudo chmod +x /usr/local/bin/zend_ce_new_vhost`.
	