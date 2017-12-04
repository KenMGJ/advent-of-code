#!/usr/bin/perl

use strict;
use warnings;

use POSIX qw{ floor };

my $direction = 'R';
my $step_level = 1;
my $steps_remaining = 2;

my $x;
my $y;

my $idx;

my $grid;

while (<>) {
    chomp;
    my $node_count = $_;

    $direction = 'R';
    $step_level = 1;
    $steps_remaining = 2;

    $idx = floor(sqrt($node_count));
    my $size = $idx * 2 + 1;
    $grid = [];

    for my $i ( 1 .. $size ) {
        my @row;
        for my $j (1 .. $size ) {
            push @row, undef;
        }
        push @$grid, \@row;
    }

    $x = $idx;
    $y = $idx - 1;

    for my $i ( 1 .. $node_count ) {
        my $val = next_node();
        if ($val > $node_count) {
            print "VAL: $val\n";
            last;
        }

    }
}

sub next_node {

    if ($steps_remaining == 0) {
        if ($direction eq 'R') {
            $direction = 'U';
        }
        elsif ($direction eq 'U') {
            $direction = 'L';
        }
        elsif ($direction eq 'L') {
            $direction = 'D';
        }
        elsif ($direction eq 'D') {
            $direction = 'R';
        }

        $step_level++ if ($direction eq 'L' || $direction eq 'R');
        $steps_remaining = $step_level;
    }

    $y++ if $direction eq 'R';
    $x++ if $direction eq 'U';
    $y-- if $direction eq 'L';
    $x-- if $direction eq 'D';

    $steps_remaining--;

    my $value;
    if ($x == $idx && $y == $idx) {
        $value = 1;
    }
    else {
        $value += $grid->[$x-1][$y-1] if defined $grid->[$x-1][$y-1];
        $value += $grid->[$x-1][$y] if defined $grid->[$x-1][$y];
        $value += $grid->[$x-1][$y+1] if defined $grid->[$x-1][$y+1];
        $value += $grid->[$x][$y-1] if defined $grid->[$x][$y-1];
        $value += $grid->[$x][$y+1] if defined $grid->[$x][$y+1];
        $value += $grid->[$x+1][$y-1] if defined $grid->[$x+1][$y-1];
        $value += $grid->[$x+1][$y] if defined $grid->[$x+1][$y];
        $value += $grid->[$x+1][$y+1] if defined $grid->[$x+1][$y+1];
    }
    

    $grid->[$x][$y] = $value;
    return $value;
}
