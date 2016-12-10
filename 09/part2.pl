#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    my $length = calculate_length($_);
    print $length, "\n";
}

sub calculate_length {

    my $string = shift;
    my @chars = split '', $string;

    my $input_length = scalar @chars;
    
    my $calculated_length = 0;

    my $i = 0;
    while ($i < $input_length) {

        my $char = $chars[$i];
        if ($char ge 'A' && $char le 'Z') {
            $calculated_length += 1;
        }
        elsif ($char eq '(') {

            my $marker = '';
            until( $chars[++$i] eq ')') {
                $marker .= $chars[$i];
            }
            my ($x, $y) = split 'x', $marker;

            my $repeating = '';
            for my $j (1 .. $x) {
                $repeating .= $chars[$i + $j];
            }

            $calculated_length += (calculate_length($repeating) * $y);
            $i += $x;

        }
        $i++;
    }
    return $calculated_length;
}
