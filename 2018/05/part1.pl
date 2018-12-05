#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    my @letters = split '', $_;

    use Data::Dumper;

    my @stack;
    for my $l ( @letters ) {
        if (scalar @stack == 0) {
            push @stack, $l;
        }
        else {
        
            my $a = ord $l;

            my $polar;
            if (65 <= $a && $a <= 90) {
                $polar = $a + 32;
            }
            elsif (97 <= $a && $a <= 122) {
                $polar = $a - 32;
            }

            my $b = ord $stack[$#stack];
            if ($b == $polar) {
                pop @stack;
            }
            else {
                push @stack, $l;
            }
        }
    }

    print scalar @stack, "\n";

}

