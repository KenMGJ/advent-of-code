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

my $count = 0;

next_water_move( 500, 1 );
print $count, "\n";

for my $y ($min_y .. $max_y) {
    printf('%02d ', $y);
    for my $x ($min_x .. $max_x) {
        print $grid[$y][$x];
    }
    print "\n";
}

sub next_water_move {
    my ($x, $y) = @_;
    print $y, ' ', $x, "\n";

    # move down if possible
    if ( $y < $max_y && $grid[$y + 1][$x] ne '#') {
        $grid[$y][$x] = '|';
        $count++;
        next_water_move( $x, $y + 1 );
    }

    my $will_settle = will_settle( $x, $y );
    print $will_settle, "\n";

}

sub will_settle {
    my ($x, $y) = @_;

    my $clay_on_left  = 0;
    my $clay_on_right = 0;

    for (my $i = $x - 1; $i >= $min_x; $i--) {
        if ($grid[$y][$i] eq '#') {
            $clay_on_left = 1;
            last;
        }
    }

    for (my $i = $x + 1; $i <= $max_x; $i++) {
        if ($grid[$y][$i] eq '#') {
            $clay_on_right = 1;
            last;
        }
    }

    return $clay_on_left && $clay_on_right;
}