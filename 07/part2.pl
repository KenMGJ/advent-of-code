#!/usr/bin/perl

use strict;
use warnings;

my $matches = 0;

while (<>) {
    chomp;

    my @hypernets = m/\[(\w+)\]/g;

    $_ =~ s/\[(\w+)\]/ /g;

    my @supernets = m/(\w+)/g;

    my @reverse_abas;
    for my $supernet (@supernets) {
        push @reverse_abas, get_reverse_abas($supernet);
    }

    my $found = 0;
    for my $reverse_aba (@reverse_abas) {
        for my $hypernet (@hypernets) {
            my $length = length $hypernet;
            for my $i (0 .. $length - 3) {
                if ($reverse_aba eq substr($hypernet, $i, 3)) {
                    $found = 1;
                }
            }
        }
    }
    $matches++ if ($found == 1);
}

print $matches, "\n";

sub get_reverse_abas {
    my $string = shift;
    my $length = length $string;

    my @reverse_abas;

    for my $i (0 .. $length - 3) {
        my $first = substr($string, $i, 1);
        my $second = substr($string, $i+1, 1);
        my $third = substr($string, $i+2, 1);

        if ($first eq $third && $first ne $second) {
            push @reverse_abas, ($second . $first . $second);
        }
    }

    return @reverse_abas;
}
