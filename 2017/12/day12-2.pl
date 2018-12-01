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
my $count = 0;

while (scalar %registry) {

    my $conn;
    if ( exists $registry{'0'} ) {
        $conn = '0';
    } else {
        $conn = (keys %registry)[0];
    }

    get_connections($conn);
    $count++;

    warn scalar keys %registry, "\t", scalar keys %seen, "\n";
    delete @registry{keys %seen};
}

print $count, "\n";

sub get_connections {
    my $conn = shift;

    $seen{$conn} = 1;
    
    my @unseen_connections = grep { !exists $seen{$_} } @{$registry{$conn}};
    for my $unseen (@unseen_connections) {
        get_connections($unseen);
    }   
}
