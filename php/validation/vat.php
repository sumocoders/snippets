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
    if (
        !SpoonFilter::isAlphabetical(substr($number, 0, 2))
        || !SpoonFilter::isNumeric(substr($number, 2))
        || strlen($values['institution_vat']) < 11
        || strlen($values['institution_vat']) > 13
    ) {
        return false;
    }
    return true;
}
