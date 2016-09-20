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
        $files = array_map(
            function ($file) {
                $filename = md5(uniqid() . time()) . '.' . $file->getClientOriginalExtension();
                $file->move(
                    FRONTEND_FILES_PATH . '/Profiles/acquisitions/source',
                    $filename
                );
                Model::generateThumbnails(
                    FRONTEND_FILES_PATH . '/Profiles/acquisitions/',
                    FRONTEND_FILES_PATH . '/Profiles/acquisitions/source/' . $filename
                );

                return $filename;
            },
            $this->get('request')->files->all()
        );

        $this->output(self::OK, $files);
    }
}
