#!/usr/bin/perl

use strict;
use warnings;

my @dirs;

while (<>) {
    chomp;
    @dirs = split ', ';
}

my $turns = {
    'N' => {
        'R' => 'E',
        'L' => 'W',
    },
    'E' => {
        'R' => 'S',
        'L' => 'N',
    },
    'S' => {
        'R' => 'W',
        'L' => 'E',
    },
    'W' => {
        'R' => 'N',
        'L' => 'S',
    },
};

my $x = 0;
my $y = 0;

my $hq_x = 0;
my $hq_y = 0;

my $facing = 'N';

my $visits = {
    '0,0' => 1,   
};

my $found = 0;

for my $dir (@dirs) {

    my $turn = substr $dir, 0, 1;
    my $steps = int (substr $dir, 1);

    my $old_facing = $facing;
    $facing = $turns->{$old_facing}->{$turn};

    my $i = 0;
    while ($i < $steps) {
        if ($facing eq 'N') {
            $y++;
        }
        elsif ($facing eq 'E') {
            $x++;
        }
        elsif ($facing eq 'S') {
            $y--;
        }
        elsif ($facing eq 'W') {
            $x--;
        }

        my $coord = $x . ',' . $y;

        if (defined $visits->{$coord}) {
            $visits->{$coord}++;
        }
        else {
            $visits->{$coord} = 1;
        }

        if (!$found && $visits->{$coord} == 2) {
            $hq_x = $x;
            $hq_y = $y;
            $found = 1;
        }

        $i++;
    }
}

print "Distance: \t", (abs $x + abs $y), "\t", "Distance to first twice visited point:\t", (abs $hq_x + abs $hq_y), "\n";
