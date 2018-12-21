#!/usr/bin/perl

use strict;
use warnings;

my @grid;
my $min_x;
my $max_x;
my $min_y;
my $max_y;

while (<>) {
    chomp;

    if ($_ =~ /^x=(\d+), y=(\d+)..(\d+)$/) {

        for my $y ($2 .. $3) {
            $grid[$y] = [] if !defined $grid[$y];
            $grid[$y][$1] = '#';
        }

        $min_x = $1 if !defined $min_x || $1 < $min_x;
        $max_x = $1 if !defined $max_x || $1 > $max_x;
        $min_y = $2 if !defined $min_y || $2 < $min_y;
        $max_y = $3 if !defined $max_y || $3 > $max_y;
    }
    elsif ($_ =~ /^y=(\d+), x=(\d+)..(\d+)$/) {

        for my $x ($2 .. $3) {
            $grid[$1] = [] if !defined $grid[$1];
            $grid[$1][$x] = '#';
        }

        $min_y = $1 if !defined $min_y || $1 < $min_y;
        $max_y = $1 if !defined $max_y || $1 > $max_y;
        $min_x = $2 if !defined $min_x || $2 < $min_x;
        $max_x = $3 if !defined $max_x || $3 > $max_x;
    }
}

for my $y ($min_y .. $max_y) {
    for my $x ($min_x .. $max_x) {
        $grid[$y][$x] = '.' if !defined $grid[$y][$x];
    }
}

sub print_grid {
    for my $y ($min_y .. $max_y) {
        printf('%02d ', $y);
        for my $x ($min_x .. $max_x) {
            print $grid[$y][$x];
        }
        print "\n";
    }
}

my $drop_count = 0;

while ($drop_count < 1) {

    my $x = 500;
    my $y = 0;

    last if !can_drop_down($x, $y);
    $drop_count++;

    while (can_drop_down($x, $y)) {
        $y++;
    }

    print $y;
}


sub can_drop_down {
    my ($x, $y) = @_;
    return $y <= $max_y && $grid[$y+1][$x] eq '.';
}