(function() {

  // Example of existing files
  var item = {
      "images": [{
        "name": "image1",
        "url": 'http://placehold.it/200x200',
        "filesize": 1234
      },
      {
        "name": "image2",
        "url": 'http://placehold.it/400x400',
        "filesize": 4346
      }]
    };

  // Disable autodiscover
  Dropzone.autoDiscover = false;
  var $dropzone = $('.dropzone');
  $dropzone.dropzone({
    url: '/frontend/ajax',
    params: {
      'fork[module]': 'module',
      'fork[action]': 'action'
    },
    uploadMultiple: true,
    addRemoveLinks: true,
    // maxfiles can be set if needed
    maxfiles: 3,
    // Comma separated list of accepted file types
    acceptedFiles: 'image/*, application/pdf',
    // Set some events at init
    init: function() {
      var dropzone = this;

      // example of how to show existing items
      $.each(item.images, function(index, image) {
        console.log(image);
        var realfile = {name: image.name, size: image.filesize, accepted: true};
        dropzone.emit('addedfile', realfile);
        dropzone.emit('thumbnail', image.url);
        dropzone.emit('complete', realfile);
        // push this to the list so dropzone knows how many images are already uploaded
        dropzone.files.push(realfile);
      });

      // example to block the upload if maxfiles is reached
      dropzone.on('maxfilesexceeded', function(file) {
        dropzone.removeFile(file);
        $dropzone.find('.dz-max-files-exceeded').fadeIn('slow').delay(3000).fadeOut('slow');
      });
    }
  });

})();
