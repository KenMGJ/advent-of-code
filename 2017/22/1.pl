#!/usr/bin/perl

use strict;
use warnings;

my $iter = 10_000_000;

my @rows;

while(<>) {
    chomp;

    my @row = split '';
    push @rows, \@row;
}

my $length = scalar @rows;
my $mid = $length / 2 - 0.5;

my %map;

for my $i ( 0 .. $length - 1) {
    for my $j ( 0 .. $length - 1) {
        my $idx = get_idx($i, $j, $mid, -1);
        $map{$idx} = $rows[$i][$j];
    }
}

my $cx = 0;
my $cy = 0;
my $dir = 'U';

my $hash_count = 0;

my $i = 0;
while ($i < $iter) {

    my $idx = get_idx($cx, $cy, 0, 1);
    $map{$idx} = '.' if !exists $map{$idx};

    my $node = $map{$idx};

    if ($node eq '#') {
        # Turn right
        $dir = $dir eq 'U' ? 'R' : $dir eq 'R' ? 'D' : $dir eq 'D' ? 'L' : 'U';
        $map{$idx} = '.';
    }
    else {
        # Turn left
        $dir = $dir eq 'U' ? 'L' : $dir eq 'L' ? 'D' : $dir eq 'D' ? 'R' : 'U';
        $map{$idx} = '#';
        $hash_count += 1;
    }

    if ($dir eq 'U') {
        $cx += 1;
    }
    elsif ($dir eq 'R') {
        $cy += 1;
    }
    elsif ($dir eq 'D') {
        $cx -= 1;
    }
    elsif ($dir eq 'L') {
        $cy -= 1;
    }

    $i += 1;
}

# print_map();
print "Infected: ", $hash_count, "\n";

sub print_map {

    my $minx = 0;
    my $maxx = 0;
    my $miny = 0;
    my $maxy = 0;

    for my $key (keys %map) {
        my ($x, $y) = split ',', $key;
        $minx = $x if $x < $minx;
        $maxx = $x if $x > $maxx;
        $miny = $y if $y < $miny;
        $maxy = $y if $y > $maxy;
    }

    for (my $i = $maxx; $i >= $minx; $i-- ) {
        for my $j ( $miny .. $maxy ) {
            my $idx = get_idx($i, $j, 0, 1);
            $map{$idx} = '.' if !exists $map{$idx};
            my $val = $map{$idx};
            print $val;
        }
        print "\n";
    }
}

sub get_idx {
    my ($x, $y, $mid, $fact) = @_;
    return ($fact * ($x - $mid)) . ',' . ($y - $mid);
}
