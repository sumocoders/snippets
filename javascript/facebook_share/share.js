/**
 * Share a link with image on facebook
 * 
 * use	<a href="#" class="shareFacebook"
 * 			data-url="<full-url>"
 * 			data-title="<title>"
 * 			data-description="<message>"
 * 			data-thumb="<full-url-to-image>"
 * 			data-tags="<tags-comma-seperated>"
 * 		>
 * 			Share on Facebook
 * 		</a>
 * 
 * Make sure you have a div with id: #facebookError and a div with id: #facebookSuccess
 * 
 * @author	Tijs Verkoyen <tijs@sumocoders.be>
 */
// facebook
$('.shareFacebook').live('click', function(evt) {
	// prevent default
	evt.preventDefault();
	
	// grab element
	var element = $(this);
	
	// hide previous messages
	$('#facebookError, #facebookSuccess').slideUp();
	
	// log in
	FB.login(function(response) {
		// any response
		if(response.session) {
			// required permissions
			if(response.perms) 
			{
				// post to feed
				FB.api('/me/feed', 'post', 
					{ 
						message: element.data('description'),
						picture: element.data('image'),
						link: element.data('url'),
						name: element.data('title'),
						description: element.data('description')
					}, 
					function(response) {
						// not published
						if(!response || response.error) $('#facebookError').html('<strong>Facebook:</strong> er ging iets mis, probeer het later opnieuw.').slideDown();
						
						// published
						else
						{
							$('#facebookSuccess').html('<strong>Facebook:</strong> de link is gepubliceerd op je wall.').slideDown();
							setTimeout(function() { $('#facebookSuccess').slideUp(); }, 3000);
						}
					});
			} 
			
			// user is logged in, but did not grant any permissions
			else 
			{
				$('#facebookError').html('<strong>Facebook:</strong> om deze link te delen moet je onze applicatie voldoende rechten geven.').slideDown();
			}
		} 
		
		// user is not logged in.
		else 
		{
			$('#facebookError').html('<strong>Facebook:</strong> om deze link te delen moet je onze applicatie voldoende rechten geven.').slideDown();
		}
	}, { perms: 'publish_stream' });
});