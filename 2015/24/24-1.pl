#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw/combinations/;
use List::Util qw/sum product/;

my $GROUPS = 3;

my @weights;

while (<>) {
    chomp;
    push @weights, int($_);
}

my $total_weight = 0;
for my $w (@weights) {
    $total_weight += $w;
}

my $weight_per_group = $total_weight / $GROUPS;
my $number_of_presents = scalar @weights;

print "Number of presents: $number_of_presents  Total weight: $total_weight  Weight per group: $weight_per_group\n";

my @groups;

my $iter = combinations(\@weights, 6);

while (my $c = $iter->next) {
   my $sum = sum(@$c);
   push (@groups, { vals => $c, qe => product(@$c) }) if $sum == $weight_per_group;
}

my $min_qe = $groups[0]->{qe};
for my $g (@groups) {
    $min_qe = $g->{qe} if $min_qe > $g->{qe};
}

print $min_qe, "\n";
