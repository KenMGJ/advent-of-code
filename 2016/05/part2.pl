#!/usr/bin/perl

use strict;
use warnings;

use Digest::MD5 qw( md5_hex );

my $door_id = 'reyedfim';
my $password_length = 8;

my $found = 0;
my $index = 0;

my $password = [];

while ($found < $password_length) {
    my $next_try = md5_hex( $door_id . $index );
    if (substr($next_try, 0, 5) eq '00000') {
        my $array_index .= substr($next_try, 5, 1);
        if ($array_index ge '0' && $array_index le '7') {
            my $next_letter .= substr($next_try, 6, 1);
            if (!defined $password->[$array_index]) {
                $password->[$array_index] = $next_letter;
                $found++;
            }
        }
    }
    $index++;    
}

print @$password, "\n";
