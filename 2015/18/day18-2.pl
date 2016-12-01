#!/usr/bin/perl

use strict;
use warnings;

my @grid;

my $ROWS = 100;
my $COLS = 100;

while (<>) {
    chomp;

    my @row = split '';
    push @grid, \@row;
}

for my $i (1..100) {
    @grid = next_grid();
}

my $num_on = 0;
for my $j (0..($ROWS-1)) {
    for my $k (0..($COLS-1)) {
        $num_on++ if $grid[$j]->[$k] eq '#';
    }
}

print $num_on, "\n";

sub next_grid {
    my @next_grid;
    for my $i (0..($ROWS-1)) {

        my @next_row;

        for my $j (0..($COLS-1)) {

            my $num_on = 0;


            if ($i > 0) {
                if ($j > 0) {
                    $num_on++ if $grid[$i-1]->[$j-1] eq '#';
                }
                $num_on++ if $grid[$i-1]->[$j] eq '#';
                if ($j < ($COLS-1)) {
                    $num_on++ if $grid[$i-1]->[$j+1] eq '#';
                }
            }
            if ($j > 0) {
                $num_on++ if $grid[$i]->[$j-1] eq '#';
            }
            if ($j < ($COLS-1)) {
                $num_on++ if $grid[$i]->[$j+1] eq '#';
            }
            if ($i < ($ROWS-1)) {
                if ($j > 0) {
                    $num_on++ if $grid[$i+1]->[$j-1] eq '#';
                }
                $num_on++ if $grid[$i+1]->[$j] eq '#';
                if ($j < ($COLS-1)) {
                    $num_on++ if $grid[$i+1]->[$j+1] eq '#';
                }
            }

            if (($i == 0 || $i == ($ROWS-1)) && ($j == 0 || $j == ($COLS-1))) {
                    push @next_row, '#';
            }
            elsif ($grid[$i]->[$j] eq '#') {
                if ($num_on == 2 || $num_on == 3) {
                    push @next_row, '#';
                }
                else {
                    push @next_row, '.';
                }
            }
            else {
                if ($num_on == 3) {
                    push @next_row, '#';
                }
                else {
                    push @next_row, '.';
                }
            }
        }
        push @next_grid, \@next_row;
    }
    return @next_grid;
}
