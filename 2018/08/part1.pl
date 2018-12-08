#!/usr/bin/perl

use strict;
use warnings;

my @tree;

while (<>) {
    chomp;

    @tree = split ' ';
    last;
}

my $sum = 0;
unpack_node();
print $sum, "\n";

sub unpack_node {

    my $child_node_count = shift @tree;
    my $metadata_count = shift @tree;

    for my $i ( 1 .. $child_node_count ) {
        unpack_node();
    }

    for my $i ( 1 .. $metadata_count ) {
        my $metadata = shift @tree;
        $sum += $metadata;
    }
}

