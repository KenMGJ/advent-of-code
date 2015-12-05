#!/usr/bin/perl

use strict;
use warnings;

my $good_count = 0;

while (<>) {
	chomp;

    next if !($_ =~ /[aeiou].*[aeiou].*[aeiou]/);
    next if !($_ =~ /(.)\1/);
    next if ($_ =~ /(ab|cd|pq|xy)/);

    $good_count++;
}

print "Good words: $good_count\n";
