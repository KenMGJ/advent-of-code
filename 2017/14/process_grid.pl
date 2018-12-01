#!/usr/bin/perl

use strict;
use warnings;

my @grid;

while (<>) {
    chomp;

    my @row = split '';
    push @grid, \@row;
}

my $groups = 0;

for my $i ( 0 .. 127 ) {
    for my $j ( 0 .. 127 ) {
        if ($grid[$i][$j] eq '1') {
            $groups++;
            find_path($i, $j);
        }
    }
}

print $groups, "\n";

sub find_path {
    my ($row, $column) = @_;

    return if ($grid[$row][$column] eq '0' || $grid[$row][$column] eq 'X');

    $grid[$row][$column] = 'X';

    # Check above
    if ($row > 0) {
        find_path($row - 1, $column);
    }

    # Check left
    if ($column > 0) {
        find_path($row, $column - 1);
    }

    # Check right
    if ($column < 127) {
        find_path($row, $column + 1);
    }

    # Check above
    if ($row < 127) {
        find_path($row + 1, $column);
    }
}
