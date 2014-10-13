<?php

/**
 * Loops all the images in the source folders in a dir and generated the thumbnails
 * @param string $dir The directory from where we need to find all the source folders
 */
function generateAllThumbnails($dir = FRONTEND_FILES_PATH)
{
    $Directory = new RecursiveDirectoryIterator($dir);
    $Iterator = new RecursiveIteratorIterator($Directory);
    $Regex = new RegexIterator(
        $Iterator,
        '/(^.+)\/source\/(.+)(?<!\.)(?<!\.gitignore)$/i',
        RecursiveRegexIterator::GET_MATCH
    );

    foreach ($Regex as $image) {
        BackendModel::generateThumbnails($image[1], $image[0]);
    }
}
