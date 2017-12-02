#!/usr/bin/perl

use strict;
use warnings;

my $lines = [];

my $sum = 0;

while (<>) {
    chomp;

    if ($_ =~ /(.*)-(\d+)\[(.{5})\]/) {
        # print $1, "\t", $2, "\t", $3, "\t";

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

        if ($3 eq $code) {
            $sum += $2;

            my $un = unencrypt($1, $2);

            if ($un eq 'northpole object storage') {
                print $2, "\n";
            }
        }
    }
}

sub unencrypt {
    my $e_name = shift;
    my $sector = shift;

    my $unencrypted = '';
    my $z = ord 'z';

    for my $c (split //, $e_name) {
        if ($c eq '-') {
            $unencrypted .= ' ';
        }
        else {
            my $char = ord $c;

            for my $i (1 .. $sector) {
                $char++;
                if ($char == $z + 1) {
                    $char = ord 'a';
                }
            }

           $unencrypted .= chr $char;
        }
    }

    return $unencrypted;
}
