#!/usr/bin/perl

use strict;
use warnings;

my $in_out = '1113122113';

my $length = $ARGV[0];

for my $i (1..$length) {
    $in_out = look_and_say($in_out);
}
print length($in_out), "\n";

sub look_and_say {
    my $input = shift;

    my @digits = split "", $input;

    my $prev = '';
    my $prev_count = 0;

    my $output = '';

    for my $digit (@digits) {
        if ($digit ne $prev) {
            $output .= $prev_count . $prev if $prev_count;
            $prev = $digit;
            $prev_count = 1;
        }
        else {
            $prev_count++;
        }
    }
    $output .= $prev_count . $prev;

    return $output;
}
