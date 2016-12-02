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

my $x = 2;
my $y = 0;

my $grid = {
    0 => {
        2 => '1',
    },
    1 => {
        1 => '2',
        2 => '3',
        3 => '4',
    },
    2 => {
        0 => '5',
        1 => '6',
        2 => '7',
        3 => '8',
        4 => '9',
    },
    3 => {
        1 => 'A',
        2 => 'B',
        3 => 'C',
    },
    4 => {
        2 => 'D',
    },
};

for my $line (@$lines) {

    for my $move (@$line) {
        if ($move eq 'U') {
            $x--;

            if ($y == 0 || $y == 4) {
                $x = 2 if $x < 2;
            }
            elsif ($y == 1 || $y == 3) {
                $x = 1 if $x < 1;
            }
            else {
                $x = 0 if $x < 0;
            }
        }
        elsif ($move eq 'R') {
            $y++;

            if ($x == 0 || $x == 4) {
                $y = 2 if $y > 2;
            }
            elsif ($x == 1 || $x == 3) {
                $y = 3 if $y > 3;
            }
            else {
                $y = 4 if $y > 4;
            }
        }
        elsif ($move eq 'D') {
            $x++;

            if ($y == 0 || $y == 4) {
                $x = 2 if $x > 2;
            }
            elsif ($y == 1 || $y == 3) {
                $x = 3 if $x > 3;
            }
            else {
                $x = 4 if $x > 4;
            }
        }
        elsif ($move eq 'L') {
            $y--;
            if ($x == 0 || $x == 4) {
                $y = 2 if $y < 2;
            }
            elsif ($x == 1 || $x == 3) {
                $y = 1 if $y < 1;
            }
            else {
                $y = 0 if $y < 0;
            }
        }
    }
    print $grid->{$x}->{$y};
}

print "\n";
