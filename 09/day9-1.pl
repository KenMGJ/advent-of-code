#!/usr/bin/perl

use strict;
use warnings;

my $distances = {};

while (<>) {
	chomp;

    if ($_ =~ /^(.+) to (.+) = (\d+)/) {
        $distances->{$1}->{$2} = int $3;
        $distances->{$2}->{$1} = int $3;
    }
}

my $paths_to_calculate = [];

my @visited = qw//;
my @not_visited = keys %{$distances};
get_paths(\@visited, \@not_visited);

for my $path (@{$paths_to_calculate}) {
    calculate_distance($path);
}

my $min = -1;
for my $path (@{$paths_to_calculate}) {
    if ($min == -1 || $path->{distance} < $min) {
        $min = $path->{distance};
    }
}

print $min, "\n";

sub calculate_distance {
    my $path = shift;

    my $prev = '';
    my $distance = 0;
    for my $city (@{$path->{path}}) {
        if ($prev ne '') {
            $distance += $distances->{$prev}->{$city};
        }
        $prev = $city;
    }

    $path->{distance} = $distance;
}

sub get_paths {
    my $visited_ref = shift;
    my $not_visited_ref = shift;

    my @visited = @{$visited_ref};
    my @not_visited = @{$not_visited_ref};

    if (scalar @not_visited == 0) {
        push @{$paths_to_calculate}, { path => \@visited };
    }
    else {
        for my $dest (@not_visited) {
            my @visited_loc = @visited;
            push @visited_loc, $dest;

            my @not = @not_visited;
            my $i = 0;
            for my $vis (@not) {
                last if $dest eq $vis;
                $i++;
            }
            splice @not, $i, 1;
            get_paths(\@visited_loc, \@not);
        }
    }
}
