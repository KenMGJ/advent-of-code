#!/usr/bin/perl

use strict;
use warnings;

my $total_valid = 0;

while (<>) {
    chomp;

    my @words = split ' ';

    my %passwords;
    for my $word (@words) {
        $passwords{$word} = 0 if !defined $passwords{$word};
        $passwords{$word}++;
    }

    my $appears_count = 0;
    for my $password (keys %passwords) {
        $appears_count++ if $passwords{$password} > 1;
    }

    $total_valid++ if $appears_count == 0;
}

print "Valid passphrases: $total_valid\n";
