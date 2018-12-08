#!/usr/bin/perl

use strict;
use warnings;

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

my @grid;
for my $i ( 0 .. $max_x + 1 ) {
    $grid[$i] = ();
    for my $j ( 0 .. $max_y + 1 ) {
        my $min_dist  = -1;
        my @min_locs;
        my $loc_index = 0;
        for my $loc (@locations) {
            my $dist = calculate_manhattan_distance($i, $j, $loc);
            if ($min_dist < 0 || $dist < $min_dist) {
                $min_dist = $dist;
                @min_locs = ();
                push @min_locs, $loc_index;
            }
            elsif ($dist == $min_dist) {
                push @min_locs, $loc_index;
            }
            $loc_index++;
        }
        $grid[$i][$j] = {
            dist => $min_dist,
            locs => \@min_locs,
        };
    }
}

#for my $y ( 0 .. $max_y + 1 ) {
#    for my $x ( 0 .. $max_x + 1 ) {
#        my $g = $grid[$x][$y];
#        if (scalar @{$g->{locs}} == 1) {
#            print $g->{locs}->[0], ' ';
#        }
#        else {
#            print '. ';
#        }
#    }
#    print "\n";
#}

my @finite;
for my $i ( 0 .. $#locations ) {
    my $infinite = is_infinite($i);
    if (!$infinite) {
        push @finite, $i;
    }
}

my $max_area = 0;
for my $loc (@finite) {
    my $area = get_area($loc);
    $max_area = $area if $area > $max_area;
}
print $max_area, "\n";

sub calculate_manhattan_distance {
    my ($x, $y, $loc) = @_;
    return abs ( $x - $loc->{x} ) + abs ( $y - $loc->{y} );
};

sub is_infinite {
    my $loc = shift;

    for my $x ( $min_x .. $max_x ) {
        for my $y ( $min_y .. $max_y ) {
            next if $min_x < $x && $x < $max_x && $min_y < $y && $y < $max_y;
            my @locs_arr = @{$grid[$x][$y]->{locs}};
            my %locs = map { $_ => 1 } @locs_arr;
            return 1 if exists $locs{$loc} && (scalar @locs_arr == 1);
        }
    }

    return 0;
}

sub get_area {
    my $loc = shift;

    my $count = 0;
    for my $x ( $min_x .. $max_x ) {
        for my $y ( $min_y .. $max_y ) {
            my @locs = @{$grid[$x][$y]->{locs}};
            $count++ if (scalar @locs == 1) && ($locs[0] == $loc);
        }
    }
    return $count;
}
