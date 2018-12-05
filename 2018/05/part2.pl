#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    my $input = $_;
    my @letters_input = split '', $_;

    my %letter_list;
    for my $l ( @letters_input ) {
        my $a = ord $l;
        $letter_list{$l} = 1 if (65 <= $a && $a <= 90);
    }

    my $min = 1_000_000_000;

    for my $key (sort keys %letter_list) {

        my $alt = chr ((ord $key) + 32);

        my $new_input = $input;
        $new_input =~ s/$key//g;
        $new_input =~ s/$alt//g;

        my @letters = split '', $new_input;

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

        my $length = scalar @stack;
        if ($min > $length) {
            $min = $length;
        }
        # print $key, "\t", join('', @stack), "\t", scalar @stack, "\n";
    }

    print $min, "\n";
}

