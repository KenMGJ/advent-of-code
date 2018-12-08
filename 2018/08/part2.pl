#!/usr/bin/perl

use strict;
use warnings;

my @tree;

while (<>) {
    chomp;

    @tree = split ' ';
    last;
}

my $root = get_node();
my $value = get_value($root);
print $value, "\n";

sub get_node {

    my $node = {
        children => [],
        metadata => [],
    };

    my $child_node_count = shift @tree;
    my $metadata_count = shift @tree;

    for my $i ( 1 .. $child_node_count ) {
        push @{$node->{children}}, get_node();
    }

    for my $i ( 1 .. $metadata_count ) {
        push @{$node->{metadata}}, shift @tree;
    }

    return $node;
}

sub get_value {
    my $node = shift;

    if (!scalar @{$node->{children}}) {
        my $sum = 0;
        for my $md (@{$node->{metadata}}) {
            $sum += $md;
        }
        return $sum;
    }
    else {
        my @children = @{$node->{children}};
        my $sum = 0;
        for my $md (@{$node->{metadata}}) {
            if ($md > 0 && $md <= scalar @children) {
                $sum += get_value($children[$md - 1]);
            }
        }
        return $sum;
    }
}
