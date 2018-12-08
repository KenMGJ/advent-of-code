#!/usr/bin/perl

use strict;
use warnings;

my %steps;

while (<>) {
    if (/Step (.) must be finished before step (.) can begin./) {
        $steps{$1}       = {} if !exists $steps{$1};
        $steps{$2}       = {} if !exists $steps{$2};
        $steps{$2}->{$1} = 1;
    }
}

my $next = get_next();
while (defined $next) {
    print $next;
    for my $step (keys %steps) {
        delete $steps{$step}->{$next};
    }
    delete $steps{$next};
    $next = get_next();
}


print "\n";

sub get_next {
    my @can_run_next = grep { !scalar keys $steps{$_} } sort keys %steps;
    my $next = undef;
    $next    = $can_run_next[0] if scalar @can_run_next;
    return $next;
}
