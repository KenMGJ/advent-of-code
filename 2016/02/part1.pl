#!/usr/bin/perl

use strict;
use warnings;

my $lines = [];

while (<>) {
    chomp;
    my @line = split '';
    # print join(', ', @line), "\n";
    push @$lines, \@line;
}

my $x = 1;
my $y = 1;

for my $line (@$lines) {

    for my $move (@$line) {
        if ($move eq 'U') {
            $x--;
            $x = 0 if $x < 0;
        }
        elsif ($move eq 'R') {
            $y++;
            $y = 2 if $y > 2;
        }
        elsif ($move eq 'D') {
            $x++;
            $x = 2 if $x > 2;
        }
        elsif ($move eq 'L') {
            $y--;
            $y = 0 if $y < 0;
        }
    }
    print $x * 3 + $y + 1;
}

print "\n";
