#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw( max );

while (<>) {
    chomp;

    my @steps = split ',';

    my $x = 0;
    my $y = 0;
    my $z = 0;
    my $distance = max $x, $y, $z;        

    my $max_distance = 0;

    for my $step (@steps) {
        if ($step eq 'n') {
            $y++;
        } elsif ($step eq 'ne') {
            $x++;
        } elsif ($step eq 'se') {
            $x++;
            $y--;
        } elsif ($step eq 's') {
            $y--
        } elsif ($step eq 'sw') {
            $x--;
        } elsif ($step eq 'nw') {
            $x--;
            $y++;
        }
    
        $z = 0 - $x - $y;
        $distance = max $x, $y, $z;        

        $max_distance = $distance if $distance > $max_distance;
    }

    print "$distance\t$max_distance\n";
}
