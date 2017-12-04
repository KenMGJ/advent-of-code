#!/usr/bin/perl

use strict;
use warnings;

use Array::Split qw( split_into );

while(<>) {
    chomp;
    my @chars = split //;

    my @arrayrefs = split_into(2, @chars);

    my @array0 = @{$arrayrefs[0]};
    my @array1 = @{$arrayrefs[1]};

    my $size = scalar @array0;

    my $sum = 0;

    my $i = 0;
    while ($i < $size) {
        $sum += $array0[$i] if $array0[$i] eq $array1[$i];
        $i++;
    }

    $i = 0;
    while ($i < $size) {
        $sum += $array1[$i] if $array0[$i] eq $array1[$i];
        $i++;
    }

    print $sum, "\n";
}
