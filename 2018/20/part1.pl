#!/usr/bin/perl

use strict;
use warnings;

my @input;
my $rooms = {};

while (<>) {
    chomp;
    @input = split '';

    last;
}

# ^ENWWW(NEEE|SSE(EE|N))$

my $first_node;
my $current_node;

process_array(0);
use Data::Dumper;
# print Dumper $first_node;
print Dumper $current_node;

sub process_array {
    my $idx = shift;

    while (1) {
        my $cur = $input[$idx];
        if ($cur eq '^') {
            $idx++;
        }
        elsif ($cur eq '$' || $cur eq ')') {
            return $idx;
        } 
        elsif ($cur eq '(') {
            my $end = process_array($idx + 1);
            for my $i ($idx + 1 .. $end - 1) {
                print $input[$i];
            }
            print "\n";
            return $end + 1;

            last;
        }
        else {
            my $node = new_node($cur);
            $first_node = $node if !defined $first_node;
            push @{$current_node->{children}}, $node if defined $current_node;
            $current_node = $node;
            $idx++;
        }
    }
}

sub process_node {
    my $dir = shift;
}

sub new_node {
    my $dir = shift;
    return {
        direction => $dir,
        children  => [],
    };
}