#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    my $read_marker = 0;

    my $chars_to_read = 0;
    my $times_to_repeat = 0;

    my $output = '';
    my $buffer = '';
    my $marker = '';

    for my $char (split '') {
        if (!$read_marker && !$chars_to_read && $char eq '(') {
            $marker .= $char;
            $read_marker = 1;
        }
        elsif ($read_marker && $char eq ')') {
            $marker .= $char;
            ($chars_to_read, $times_to_repeat) = /\((\d+)x(\d+)\)/;
            $read_marker = 0;
        }
        elsif ($read_marker) {
            $marker .= $char;
        }
        else {
            if ($chars_to_read) {
                $buffer .= $char;
                $chars_to_read--;
                if (!$chars_to_read) {
                    for my $i (1 .. $times_to_repeat) {
                        $output .= $buffer;
                    }
                    $buffer = '';
                    $times_to_repeat = 0;
                    $read_marker = 0;
                }
            }
            else {
                $output .= $char;
            }
        }
    }

    print length($output), "\n";
}
