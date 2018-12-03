#!/usr/bin/perl

use strict;
use warnings;

my $i = 10;

print "$i open 8,8,8,\"\@0:input,w,s\"\n";
$i += 10;

while (<>) {
    chomp;
    print "$i print#8,\"$_\"\n";
    $i += 10;
}

print "$i close 8\n";
