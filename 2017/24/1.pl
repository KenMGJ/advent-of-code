#!/usr/bin/perl

use strict;
use warnings;

my %comps;

while(<>) {
    chomp;

    my ($s, $t) = split '/';
    if ($s < $t) {
        $comps{$s . ',' . $t} = $s + $t;
    }
    else {
        $comps{$t . ',' . $s} = $s + $t;
    }
}

my $max_sum = 0;

my $max_length = 0;
my $max_length_sum = 0;

get_bridge(0, 0, '', 0, \%comps);
print $max_sum, "\t", $max_length, "\t", $max_length_sum, "\n";

sub get_bridge {
    my ($w, $sum, $str, $len, $c) = @_;

    my @next = grep { my ($s, $t) = split ','; 
        $s eq $w || $t eq $w
    } keys %$c;
    if (scalar @next == 0) {
        print $str, "\t", $sum, "\n";
        $max_sum = $sum if $max_sum < $sum;

        $max_length = $len if $max_length < $len;
        $max_length_sum = $sum if $max_length == $len && $max_length_sum < $sum;
        return;
    }

    for my $n (@next) {
        my %cmps = %$c;
        my $weight = delete $cmps{$n};

        my ($s, $t) = split ',', $n;
        get_bridge($s eq $w ? $t : $s, $sum + $weight, $str . $s . ',' . $t . '/', $len + 1, \%cmps);
    }
}
