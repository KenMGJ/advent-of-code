#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    my $length = 0;
    my $decompressed = '';

    my @chars = split '';

    my $i = 0;
    my $input_length = scalar @chars;

    while ($i < $input_length) {

        my $char = $chars[$i];
        if ($char ge 'A' && $char le 'Z') {
            $decompressed .= $char;
            $length += 1;
        }
        elsif ($char eq '(') {

            my $marker = '';
            until( $chars[++$i] eq ')') {
                $marker .= $chars[$i];
            }
            my ($x, $y) = split 'x', $marker;

            # print $marker, "\t", $x, "\t", $y, "\n";
            
            my $repeating = '';
            for my $j (1 .. $x) {
                $repeating .= $chars[$i + $j];
            }
            $decompressed .= ($repeating x $y);
          
            $length += ($x * $y);
            $i += $x;

        }
        $i++;

    }

    print $_, "\n", $decompressed, "\t", $length, "\n";
}
