#!/usr/bin/perl

use strict;
use warnings;

my $start = new_item(0);
$start->{next} = $start;

sub new_item {
    my $val = shift;

    return {
        val  => $val,
        next => undef,
    };
}

use Const::Fast;
const my $total_times => 2017;

my $prev = $start;
my $curr = $start;

for my $i ( 1 .. $total_times ) {
    for my $j ( 1 .. 345 ) {
        $prev = $curr;
        $curr = $curr->{next};
    }

    my $next = new_item($i);
    $prev->{next} = $next;
    $next->{next} = $curr;
}

print $curr->{val}, "\n";
