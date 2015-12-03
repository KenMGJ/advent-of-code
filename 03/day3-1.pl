#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
	chomp;
    my @directions = split "";

    my %houses;

    my $coord = "0,0";
    $houses{$coord} += 1;

    for my $dir (@directions) {
        my ($x, $y) = split ',', $coord;

        if ($dir eq '^') {
            $y++;
        } elsif ($dir eq '>') {
            $x++;
        } elsif ($dir eq 'v') {
            $y--;
        } elsif ($dir eq '<') {
            $x--;
        }

        $coord = "$x,$y";
        $houses{$coord} += 1;
    }

    print "Houses delivered to: ", (scalar keys %houses), "\n";
}
