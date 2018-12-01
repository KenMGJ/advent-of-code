#!/usr/bin/perl

use strict;
use warnings;

my $i = 0;
my $val;

for my $j ( 1 .. 50_000_001 ) {
    $i = ($i + 345) % $j + 1;
    $val = $j if $i == 1;
}
print $val, "\n";
