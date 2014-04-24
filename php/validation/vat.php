<?php

/*
 * Filter the input to a valid VAT number (remove spaces, dots, hyphens and slashes)
 */
function sanitizeVatNumber($number) {
    $sanitized = str_replace(array(' ', '/', '.', '-'), '', $number);
    return $sanitized;
}

/*
 * Check if the input is a VAT number (sanitize first)
 */
function isVatNumber($number) {
    return (
        SpoonFilter::isAlphabetical(substr($number, 0, 2))
        && SpoonFilter::isNumeric(substr($number, 2))
        && strlen($number) >= 11
        && strlen($number) <= 12
    );
}
