/**
 * Share a link with image on netlog
 * 
 * use	<a href="#" class="shareNetlog"
 * 			data-url="<full-url>"
 * 			data-title="<title>"
 * 			data-description="<message>"
 * 			data-thumb="<full-url-to-image>"
 * 			data-tags="<tags-comma-seperated>"
 * 		>
 * 			Share on Netlog
 * 		</a>
 * 
 * @author	Tijs Verkoyen <tijs@sumocoders.be>
 */
$('.shareNetlog').live('click', function(evt) 
{
	// prevent default
	evt.preventDefault();
	
	// grab element
	var element = $(this);
	
	// build url
	var url = 'http://www.netlog.com/go/manage/links/view=save&origin=external';
	url += '&url='+ element.data('url');
	url += '&title='+ element.data('title');
	url += '&description='+ element.data('description');
	url += '&thumb='+ element.data('image');
	url += '&tags='+ element.data('tags');
	url += '&referer='+ document.location;

	// set url
	$(this).attr('href', url).attr('target', '_blank');
});
		