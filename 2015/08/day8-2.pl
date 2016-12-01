#!/usr/bin/perl

use strict;
use warnings;

use String::Escape qw/qqbackslash/;

my $total_code = 0;
my $encoded = 0;

while (<>) {
	chomp;

    my $string = $_;
    my $enc_string = qqbackslash $string;

    print $string, "\t", $enc_string, "\n";

    $total_code += length $string;
    $encoded += length $enc_string;
}

print $encoded, ' - ', $total_code, ' = ', ($encoded - $total_code), "\n";
