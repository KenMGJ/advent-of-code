#!/usr/bin/perl

use strict;
use warnings;

my %registry;

while (<>) {
    chomp;


    if (/(\d+) <-> (.*)/) {
        my @connections = split ', ', $2;
        $registry{$1} = \@connections;
    }
}

my %seen;
get_connections('0');

sub get_connections {
    my $conn = shift;

    $seen{$conn} = 1;
    
    my @unseen_connections = grep { !exists $seen{$_} } @{$registry{$conn}};
    for my $unseen (@unseen_connections) {
        get_connections($unseen);
    }   
}

print scalar keys %seen, "\n";
