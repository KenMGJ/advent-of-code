#!/usr/bin/perl

use strict;
use warnings;

my $twos = 0;
my $threes = 0;

while (<>) {
    chomp;


    my @letters = split '';
    my %counts;

    for my $letter (@letters) {
        $counts{$letter} = 0 if !defined $counts{$letter};
        $counts{$letter}++;
    }

    my $two = 0;
    my $three = 0;
    for my $key (keys %counts) {
        if ($counts{$key} == 2) {
            $two = 1;
        }
        if ($counts{$key} == 3) {
            $three = 1;
        }
    }

    $twos += $two;
    $threes += $three;

}

print $twos, ' ' , $threes, ' ' , $twos * $threes, "\n";
