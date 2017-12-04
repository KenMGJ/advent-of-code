#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;
    my $node_count = $_;

    my $gen = node_gen();

    my @nodes;
    while ($node_count > 0) {
        push @nodes, $gen->{next}();
        $node_count--;
    }

    for my $node (@nodes) {
        # $node->{print}()
    }

    my $node = $nodes[-1];
    $node->{print}();
}

sub new_node {
    my ($val, $x, $y) = @_;

    return {
        val   => $val,
        x     => $x,
        y     => $y,
        print => sub {
            my $dist = abs($x) + abs($y);
            print "$val --> ( $x , $y ) => $dist\n";
        },
    };
}

sub node_gen {

    my $direction = 'R';
    my $step_level = 1;
    my $steps_remaining = 2;

    my $x = -1;
    my $y = 0;
    my $val = 0;

    return {
        next => sub {
            if ($steps_remaining == 0) {
                if ($direction eq 'R') {
                    $direction = 'U';
                }
                elsif ($direction eq 'U') {
                    $direction = 'L';
                }
                elsif ($direction eq 'L') {
                    $direction = 'D';
                }
                elsif ($direction eq 'D') {
                    $direction = 'R';
                }

                $step_level++ if ($direction eq 'L' || $direction eq 'R');
                $steps_remaining = $step_level;
            }

            $x++ if $direction eq 'R';
            $y++ if $direction eq 'U';
            $x-- if $direction eq 'L';
            $y-- if $direction eq 'D';

            $steps_remaining--;
            return new_node(++$val, $x, $y);
        }
    }
}
