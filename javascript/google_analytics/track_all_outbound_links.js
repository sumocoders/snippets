// check if Google Analytics is available
if(typeof _gaq == 'object')
{
	// create a new selector for external links
	$.expr[':'].external = function(obj) {
		return (typeof obj.href != 'undefined' && !obj.href.match(/^mailto\:/) && (obj.hostname != location.hostname)); 
	};		

	// bind on all external links that don't have the class noTracking
	$('a:external:not(.noTracking)').live('click', function(evt) 
	{
		// initialize some vars
		var $this = $(this);
		var link = $this.attr('href');
		var title = $this.attr('title');
		if(typeof title == 'undefined' || title == '') title = $this.html();
		
		// track in Google Analytics
		_gaq.push(['_trackEvent', 'Outbound Links', link, title]);
	});
}