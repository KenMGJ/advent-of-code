#!/usr/bin/perl

use strict;
use warnings;

my $total = 0;

while (<>) {

    my $subtotal = 0;
    my @matches = $_ =~ /(-?\d+)/g;

    for my $match (@matches) {
        $subtotal += $match;
    }

    $total += $subtotal;
}

print $total, "\n";
