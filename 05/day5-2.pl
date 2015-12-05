#!/usr/bin/perl

use strict;
use warnings;

my $good_count = 0;

while (<>) {
	chomp;

    next if !($_ =~ /(..).*\1/);
    next if !($_ =~ /(.).\1/);

    $good_count++;
}

print "Good words: $good_count\n";
