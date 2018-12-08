#!/usr/bin/perl

use strict;
use warnings;

use Const::Fast;
const my $DISTANCE_CUTOFF => 10_000; # 32;

my @locations;

my $min_x;
my $max_x;
my $min_y;
my $max_y;

while (<>) {
    chomp;

    if (/(.*), (.*)/) {
        my $x = int $1;
        my $y = int $2;

        push @locations, {
            x => $x,
            y => $y,
        };

        $min_x = $x if !defined $min_x || $x < $min_x;
        $max_x = $x if !defined $max_x || $x > $max_x;
        $min_y = $y if !defined $min_y || $y < $min_y;
        $max_y = $y if !defined $max_y || $y > $max_y;
    }
}

my $avg_x = int ( ( $min_x + $max_x ) / 2 );
my $avg_y = int ( ( $min_y + $max_y ) / 2 );

my $i = 0;
my $count = 0;

while (1) {
    my $begin_count = $count;
    my $min_l_x = $avg_x - $i;
    my $max_l_x = $avg_x + $i;
    for my $x ( $min_l_x .. $max_l_x ) {
        my $min_l_y = $avg_y - $i;
        my $max_l_y = $avg_y + $i;
        for my $y ( $min_l_y .. $max_l_y ) {
            next if $min_l_x < $x && $x < $max_l_x && $min_l_y < $y && $y < $max_l_y && $i != 0;
            my $total_distance = 0;
            for my $loc (@locations) {
                $total_distance += calculate_manhattan_distance($x, $y, $loc);
            }
            if ($total_distance < $DISTANCE_CUTOFF) {
                $count++;
            }
        }
    }

    last if $count == $begin_count;
    $i++;
}

print $count, "\n";

sub calculate_manhattan_distance {
    my ($x, $y, $loc) = @_;
    return abs ( $x - $loc->{x} ) + abs ( $y - $loc->{y} );
};
