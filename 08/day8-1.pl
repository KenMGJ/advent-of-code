#!/usr/bin/perl

use strict;
use warnings;

my $total_code = 0;
my $memory = 0;

while (<>) {
	chomp;

    my $string = $_;
    my $un_string;

    if ($string =~ /^\"(.*)"$/) {
        $un_string = $1;
    }
    $un_string =~ s/\\\\/B/g;
    $un_string =~ s/\\"/"/g;
    $un_string =~ s/\\x../D/g;

    print $string, "\t", $un_string, "\n";

    $total_code += length $string;
    $memory += length $un_string;
}

print $total_code, ' - ', $memory, ' = ', ($total_code - $memory), "\n";
