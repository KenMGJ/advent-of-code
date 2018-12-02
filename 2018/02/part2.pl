#!/usr/bin/perl

use strict;
use warnings;

my @words;

while (<>) {
    chomp;

    push @words, $_;
}

for my $i ( 0 .. $#words - 1) {
    for my $j ( $i + 1 .. $#words ) {
        compare($words[$i], $words[$j]);
    }
}

sub compare {
    my ($a, $b) = @_;

    my @a1 = split '', $a;
    my @b1 = split '', $b;

    my $differences = 0;
    my $idx;
    for my $i ( 0 .. $#a1 ) {
        if ($a1[$i] ne $b1[$i]) {
            $idx = $i;
            $differences++;
            last if $differences > 1;
        }
    }

    if ($differences == 1) {

        my $answer;
        for (my $i = 0; $i <= $#a1; $i++) {
            $answer .= $a1[$i] if $i != $idx;
        }

        print $answer, "\n";
        # print $a, "\t", $b, "\n";
    }
}
