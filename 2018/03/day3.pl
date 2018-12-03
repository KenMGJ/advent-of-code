#!/usr/bin/perl

use strict;
use warnings;

my %fabric;
my @claims;
my $index = 0;

while (<>) {
    chomp;

    # #1 @ 1,3: 4x4

    if (/^#(\d+) @ (\d+),(\d+): (\d+)x(\d+)$/) {

        my $id = $1;
        my $x = $2;
        my $y = $3;
        my $w = $4;
        my $h = $5;

        my @claim = ( $id, $x, $y, $w, $h );
        push @claims, \@claim;

        for my $i ( $x .. $x + $w - 1 ) {
            for my $j ( $y .. $y + $h - 1 ) {
                my $key = "$i,$j";
                $fabric{$key} = 0 if !defined $fabric{$key};
                $fabric{$key}++;
            }
        }
    }
}

################################################################################
# part 1
################################################################################
my $count = 0;
for my $v (values %fabric) {
    $count++ if $v > 1;
}
print "part 1: $count\n";

################################################################################
# part 2
################################################################################
for my $claim (@claims) {
    my ($id, $x, $y, $w, $h) = @$claim;

    my $overlap = 0;
    for my $i ( $x .. $x + $w - 1 ) {
        for my $j ( $y .. $y + $h - 1 ) {
            my $key = "$i,$j";
            $overlap = 1 if $fabric{$key} > 1;
        }
    }
    
    if (!$overlap) {
        print "part 2: $id\n";
    }
}
