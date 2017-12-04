#!/usr/bin/perl

use strict;
use warnings;

while(<>) {
    chomp;
    my @chars = split //;

    my $sum = 0;
    my $size = scalar @chars;

    my $i = 1;
    while ($i < $size) {
        $sum += $chars[$i - 1] if $chars[$i - 1] eq $chars[$i];
        $i++;
    }

    $sum += $chars[$i - 1] if $chars[$i - 1] eq $chars[0];
    print $sum, "\n";
}
