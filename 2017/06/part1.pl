#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    # Store the states
    my %states;
    my $iteration = 0;

    my @banks = split "\t";
    
    my $cycle = 0;

    my $state = as_string(\@banks);
    $states{$state} = $cycle;

    print "$cycle $state\n";

    while ( 1 ) {
        $cycle++;
        $state = find_next_state(\@banks);
        print "$cycle $state\n";
        last if exists $states{$state};
        $states{$state} = $cycle;
    }

    print "Infinite Loop Detected beginning cycle $cycle\n";
    print "Loop size is ", $cycle - $states{$state}, "\n";

}

sub as_string {
    my $banks = shift;

    join(',', @$banks);
}

sub find_next_state {
    my $banks = shift;

    my $index = find_index_of_largest($banks);

    my $value = $banks->[$index];
    $banks->[$index] = 0;

    my $indexes = make_array($index + 1, scalar @$banks - 1, $value);
    for my $i (@$indexes) {
        $banks->[$i]++;
    }

    my $state = as_string($banks);
    $state;
}

sub find_index_of_largest {
    my $b = shift;
    my @banks = @$b;

    my $index = 0;
    my $val = $banks[0];

    for my $i (1 .. $#banks) {
        if ($banks[$i] > $val) {
            $index = $i;
            $val = $banks[$i];
        }
    }

    $index;
}

sub make_array {
    my ($start, $last, $times) = @_;

    my @indexes;
    my $val = $start;

    for my $i ( 1 .. $times ) {
        $val = 0 if $val > $last;
        push @indexes, $val++;
    }

    \@indexes;
}
