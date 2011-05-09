`wget --recursive --no-clobber --page-requisites --domains <domain> --no-parent <url to download>`
	
The options are:

* `--recursive`: download recursive.
* `--domains example.be`: don't follow links that aren't on example.be.
* `--no-parent`: don't follow links outside the given directory.
* `--page-requisites`: get all the elements (images, css, js, ...).
* `--no-clobber`: don't overwrite any existing files.
