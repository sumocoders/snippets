# installing the needed extensions

* Download the [Studio Web Debugger](http://www.zend.com/en/products/studio/downloads).
* Create a folder on your filesystem (eg: `/Users/<username>/Zend`).
* Create subdirectories for each PHP-version you need, in my case `php-5.2.x` and `php-5.3.x`.

# correct settings in php.ini

* Edit the correct php.ini-file.
* Add the code below:

````
	# full path to the extension
	zend_extension="/Users/<username>/Zend/php-5.2.x/ZendDebugger.so"
	# only allow debug session from this computer
	zend_debugger.allow_hosts=127.0.0.1/32
	# tell the debugger to expose itself
	zend_debugger.expose_remotely=always
````

* Restart Apache
* Check in your php_info if you can find "Zend Debugger v..", if not you messed up.

# install dummy.php

* copy the dummy.php-file into your Apache's default document_root.


# install the toolbar

* Download the [Studio Browser Toolbars](http://www.zend.com/en/products/studio/downloads)
* Install it.
* Click "Extra Stuff" - "Settings".
* Check "Debug Local Copy".
* Uncheck "Break on the First Line".
* Select "Manual Settings", leave the defaults (port: 10137, ip: 127.0.0.1).


# configure Zend Studio

* Open the Preference.
* Select "PHP" - "Debug" - "Installed Debugger" - "Zend Debugger" and click "Configure".
* Check "Display debug information ...".
* Port: 10137, IP: 127.0.0.1, Timeout: 50000, Broadcast port: 20080, Dummy File Name: dummy.php

# test

* Open a project
* Open the project in a webbrowser
* Click Profile
* (Zend will ask the correct location for the file in the project)
* The profile-view should be activated, and a pie-chart should be visible.
