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

for my $line (@$lines) {
    my $a = int $line->[0];
    my $b = int $line->[1];
    my $c = int $line->[2];

    ++$triangles if ($a + $b > $c && $a + $c > $b && $b + $c > $a);
}

print "$triangles\n";
