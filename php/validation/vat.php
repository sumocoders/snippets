<?php

/*
 * Filter the input to a valid VAT number (remove spaces, dots, hyphens and slashes)
 */
function sanitizeVatNumber($number) {
    $sanitized = strtoupper(str_replace(array(' ', '/', '.', '-'), '', $number));
    return $sanitized;
}

/*
 * Check if the input is a VAT number (sanitize first)
 */
function isVatNumber($number) {
    $rules = array(
        'AT' => '/^ATU\d{8}$/', 'BE' => '/^BE[0-1]?\d{9}$/', 'BG' => '/^BG\d{9,10}$/', 'CZ' => '/^CZ\d{8,10}$/',
        'CY' => '/^CY\d{8}[A-Z]$/', 'DE' => '/^DE\d{9}$/', 'DK' => '/^DK\d{8}$/', 'EE' => '/^EE\d{9}$/',
        'EL' => '/^EL\d{9}$/', 'ES' => '/^ES([A-Z]\d{8}|\d{8}[A-Z])$/', 'FI' => '/^FI\d{8}$/',
        'FR' => '/^FR\w{2}\d{9}$/', 'GB' => '/^GB(\d{9}|\d{12}|GD\d{3}|HA\d{3})$/', 'HR' => '/HR\d{11}$/', 
        'HU' => '/^HU\d{8}$/', 'IE' => '/^IE(\d[A-Z0-9+*]\d{5}[A-Z]|\d{7}[A-Z]{1,2})$/', 'IT' => '/^IT\d{11}$/',
        'LT' => '/^LT(\d{9}|\d{12})$/', 'LU' => '/^LU\d{8}$/', 'LV' => '/^LV\d{11}$/', 'MT' => '/^MT\d{8}$/', 
        'NL' => '/^NL\d{9}B\d{2}$/', 'PL' => '/^PL\d{10}$/', 'PT' => '/^PT\d{9}$/', 'RO' => '/^RO\d{2,10}$/',
        'SE' => '/^SE\d{12}$/', 'SI' => '/^SI\d{8}$/', 'SK' => '/^SK\d{10}$/'
    );
    $countryCode = substr($number, 0, 2);
    return preg_match($rules[$countryCode], $number);
}

