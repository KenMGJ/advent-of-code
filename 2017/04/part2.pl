#!/usr/bin/perl

use strict;
use warnings;

use Word::Anagram;
my $anagram = Word::Anagram->new;

my $total_valid = 0;

while (<>) {
    chomp;

    my @words = split ' ';

    my $anagram_found = 0;
    my $size          = scalar @words;

    my $i = 0;
    while ($i < $size - 1) {
        my $j = $i + 1;

        while ($j < $size) {

            $anagram_found = $anagram->are_anagrams($words[$i], $words[$j]);
            last if $anagram_found;

            $j++;
        }

        last if $anagram_found;
        $i++;
    }

    $total_valid++ if !$anagram_found;
}

print "Valid passphrases: $total_valid\n";
