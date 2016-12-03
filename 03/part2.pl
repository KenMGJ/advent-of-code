#!/usr/bin/perl

use strict;
use warnings;

my $lines = [];

while (<>) {
    chomp;
    my ($junk, @line) = split /\s+/;
    push @$lines, \@line;
}

my $triangles = 0;

my $i = 0;
my $line_count = scalar @$lines;

while ($i < $line_count) {

    for my $j (0 .. 2) {
        my $a = int $lines->[$i][$j];
        my $b = int $lines->[$i+1][$j];
        my $c = int $lines->[$i+2][$j];

        ++$triangles if ($a + $b > $c && $a + $c > $b && $b + $c > $a);
    }

    $i += 3;
}

print "$triangles\n";
