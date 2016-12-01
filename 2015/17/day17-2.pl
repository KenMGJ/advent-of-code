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

my $ways = {};

for my $i (1..(scalar @containers)) {
    my $iter = combinations(\@containers, $i);
    while (my $c = $iter->next) {
        my $sum = 0;
        for my $v (@{$c}) {
            $sum += $v;
        }
        if ($sum == $CAPACITY) {
            my $num = scalar @{$c};
            if (!defined $ways->{$num}) {
                $ways->{$num} = 1;
            }
            else {
                $ways->{$num}++;
            }
        }
    }
}

my $min_key;

for my $key (keys %{$ways}) {
    $min_key = $key if (!defined $min_key || $min_key > $key);
}

print $ways->{$min_key}, "\n";
