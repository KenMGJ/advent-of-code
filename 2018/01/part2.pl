#!/usr/bin/perl

use strict;
use warnings;

my @change_list;

while(<>) {
    chomp;
    push @change_list, int $_;
}

my %frequency;

my $current_change = shift @change_list;
my $current_frequency = $current_change;

until(exists $frequency{$current_frequency}) {
    $frequency{$current_frequency} = 1;
    push @change_list, $current_change;
    $current_change = shift @change_list;
    $current_frequency += $current_change;
}

print $current_frequency, "\n";
