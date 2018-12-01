#!/usr/bin/perl

use strict;
use warnings;

my @offsets;

while (<>) {
    chomp;

    push @offsets, $_;
}

my $steps = 0;
my $ptr = 0;
my $end = scalar @offsets;

while ($ptr < $end) {

    my $next = $offsets[$ptr];
    $offsets[$ptr] += $next >= 3 ? -1 : 1;
    $ptr += $next;
    $steps++;
}

print "Steps: $steps\n";
