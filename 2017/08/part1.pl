#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(max);

my %registers;

my $total_max = 0;

while (<>) {
    chomp;

    my ($reg, $op, $inc, $if, $cmp_reg, $cmp, $cmp_val) = split ' ';

    $registers{$reg} = 0 if not exists $registers{$reg};
    $registers{$cmp_reg} = 0 if not exists $registers{$cmp_reg};

    my $match = 0;

    if ($cmp eq '<') {
        $match = 1 if $registers{$cmp_reg} < $cmp_val;
    } elsif ($cmp eq '>') {
        $match = 1 if $registers{$cmp_reg} > $cmp_val;
    } elsif ($cmp eq '<=') {
        $match = 1 if $registers{$cmp_reg} <= $cmp_val;
    } elsif ($cmp eq '>=') {
        $match = 1 if $registers{$cmp_reg} >= $cmp_val;
    } elsif ($cmp eq '==') {
        $match = 1 if $registers{$cmp_reg} == $cmp_val;
    } elsif ($cmp eq '!=') {
        $match = 1 if $registers{$cmp_reg} != $cmp_val;
    }

    if ($match) {
        if ($op eq 'inc') {
            $registers{$reg} += $inc;
        } else {
            $registers{$reg} -= $inc;
        }
        $total_max = $registers{$reg} if $registers{$reg} > $total_max;
    }
}

my $max = max values %registers;
print $max, "\n";
print $total_max, "\n";
