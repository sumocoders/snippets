// This is just an example, change it to your specific needs
// This example is intended for images

<?php

namespace Frontend\Modules\Blog\Ajax;

use Frontend\Core\Engine\Base\AjaxAction;
use Frontend\Core\Engine\Model as FrontendModel;

class UploadImage extends AjaxAction
{
    public function execute()
    {
        $files = $_FILES['file'];
        $return = array();
        // Use a foreach because an upload can contain multiple files
        foreach($files['name'] as $index => $file) {
            $filename = md5($files['name'][$index] . time()) . '.jpeg';
            if(move_uploaded_file($files['tmp_name'][$index], FRONTEND_FILES_PATH . '/Trips/Days/Images/source/' . $filename)) {
                FrontendModel::generateThumbnails(
                    FRONTEND_FILES_PATH . '/Blog/Days/Images/',
                    FRONTEND_FILES_PATH . '/Blog/Days/Images/source/' . $filename
                );
            }
            // Optional: delete source if you're handling big files
            \SpoonFile::delete(FRONTEND_FILES_PATH . '/Trips/Days/Images/source/' . $filename);
            $return[$index] = $filename;
        }

        // return the new filenames
        $this->output(200, $return);
    }
}
