#!/usr/bin/perl

use strict;
use warnings;

my $lines = [];

my $sum = 0;

while (<>) {
    chomp;

    if ($_ =~ /(.*)-(\d+)\[(.{5})\]/) {
        print $1, "\t", $2, "\t", $3, "\t";

        my %counts;

        for my $c (split //, $1) {
            next if $c eq '-';
            if (defined $counts{$c}) {
                $counts{$c}++;
            }
            else {
                $counts{$c} = 1;
            }
        }

        my $i = 0;
        my $code = '';
        for my $c (sort {$counts{$b} <=> $counts{$a} || $a cmp $b} keys %counts) {
            $code .= $c;
            $i++;
            last if $i == 5;
        }

        print $code, "\n";

        if ($3 eq $code) {
            $sum += $2;
            print "ok\n";
        }
        else {
            print "no\n";
        }
    }
}

print $sum, "\n";
