#!/usr/bin/perl

use strict;
use warnings;

use Memoize;
memoize('erosion_level');

my $depth;
my $target_x;
my $target_y;

while (<>) {
    chomp;

    if (/^depth: (\d+)$/) {
        $depth = int $1;
    }
    elsif (/^target: (\d+),(\d+)$/) {
        $target_x = int $1;
        $target_y = int $2;
    }
}

print 'depth: ', $depth, ' target: (', $target_x, ', ', $target_y, ")\n";

my $total_risk_level = 0;
for my $i (0 .. $target_x) {
    for my $j (0 .. $target_y) {
        $total_risk_level += erosion_level($i, $j) % 3;
    }
}

print $total_risk_level, "\n";

sub geologic_index {
    my ($x, $y) = @_;

    return 0 if ($x == 0 and $y == 0);
    return 0 if ($x == $target_x && $y == $target_y);
    return $x * 16807 if ($y == 0);
    return $y * 48271 if ($x == 0);
    return erosion_level($x - 1, $y) * erosion_level($x, $y - 1);
}

sub erosion_level {
    my ($x, $y) = @_;

    return (geologic_index($x, $y) + $depth) % 20183;
}