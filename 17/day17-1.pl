#!/usr/bin/perl

use strict;
use warnings;

my @containers;

use Algorithm::Combinatorics qw/combinations/;

while (<>) {
    chomp;

    push @containers, $_;
}

my $CAPACITY = 150;

my $ways = [];

for my $i (1..(scalar @containers)) {
    my $iter = combinations(\@containers, $i);
    while (my $c = $iter->next) {
        my $sum = 0;
        for my $v (@{$c}) {
            $sum += $v;
        }
        push $ways, $c if $sum == $CAPACITY;
    }
}

print scalar @{$ways}, "\n";
