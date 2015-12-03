#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
	chomp;
    my @directions;

    my $i = 0;
    while ($i < length) {
        my $pair = substr $_, $i, 2;
        push @directions, $pair;
        $i += 2;
    }

    my %houses;

    my $santa_coord = "0,0";
    $houses{$santa_coord} += 1;
    print "Santa delivered to house: ($santa_coord)\n";
    
    my $robo_coord = "0,0";
    $houses{$robo_coord} += 1;
    print "Robo delivered to house: ($robo_coord)\n";

    for my $dir (@directions) {
        my ($santa_x, $santa_y) = split ',', $santa_coord;
        my ($robo_x, $robo_y) = split ',', $robo_coord;
        print "Starting: ($santa_x, $santa_y) ($robo_x, $robo_y)\n";

        my ($santa_dir, $robo_dir) = split "", $dir;
        print "Directions: Santa ($santa_dir) Robo ($robo_dir)\n";

        if ($santa_dir eq '^') {
            $santa_y++;
        } elsif ($santa_dir eq '>') {
            $santa_x++;
        } elsif ($santa_dir eq 'v') {
            $santa_y--;
        } elsif ($santa_dir eq '<') {
            $santa_x--;
        }

        $santa_coord = "$santa_x,$santa_y";
        $houses{$santa_coord} += 1;
        print "Santa delivered to house: ($santa_coord)\n";

        if ($robo_dir eq '^') {
            $robo_y++;
        } elsif ($robo_dir eq '>') {
            $robo_x++;
        } elsif ($robo_dir eq 'v') {
            $robo_y--;
        } elsif ($robo_dir eq '<') {
            $robo_x--;
        }

        $robo_coord = "$robo_x,$robo_y";
        $houses{$robo_coord} += 1;
        print "Robo delivered to house: ($robo_coord)\n";
    }

    print "Houses delivered to: ", (scalar keys %houses), "\n";
}
