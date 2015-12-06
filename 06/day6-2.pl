#!/usr/bin/perl

use strict;
use warnings;

# Initialize light
my $lights = [];
for my $i (0 .. 999) {
    $lights->[$i] = [];
    for my $j (0 .. 999) {
        $lights->[$i]->[$j] = 0;
    }
}

# Read directions
while (<>) {
	chomp;

    if ($_ =~ /turn on (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/) {
        for my $i ($1 .. $3) {
            for my $j ($2 .. $4) {
                $lights->[$i]->[$j] += 1;
            }
        }
    }
    elsif ($_ =~ /toggle (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/) {
        for my $i ($1 .. $3) {
            for my $j ($2 .. $4) {
                $lights->[$i]->[$j] += 2;
            }
        }
    }
    if ($_ =~ /turn off (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/) {
        for my $i ($1 .. $3) {
            for my $j ($2 .. $4) {
                if ($lights->[$i]->[$j] != 0) {
                    $lights->[$i]->[$j] -= 1;
                }
            }
        }
    }
}

# Total brightness
my $total_brightness = 0;
for my $i (0 .. 999) {
    for my $j (0 .. 999) {
        $total_brightness += $lights->[$i]->[$j] if $lights->[$i]->[$j];
    }
}

print "Total brightness: $total_brightness\n";
