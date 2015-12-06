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
                $lights->[$i]->[$j] = 1;
            }
        }
    }
    elsif ($_ =~ /toggle (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/) {
        for my $i ($1 .. $3) {
            for my $j ($2 .. $4) {
                if ($lights->[$i]->[$j] == 1) {
                    $lights->[$i]->[$j] = 0;
                }
                else {
                    $lights->[$i]->[$j] = 1;
                }
            }
        }
    }
    if ($_ =~ /turn off (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/) {
        for my $i ($1 .. $3) {
            for my $j ($2 .. $4) {
                $lights->[$i]->[$j] = 0;
            }
        }
    }

}

# Count lights
my $light_count = 0;
for my $i (0 .. 999) {
    for my $j (0 .. 999) {
        $light_count++ if $lights->[$i]->[$j];
    }
}

print "Lights turned on: $light_count\n";
