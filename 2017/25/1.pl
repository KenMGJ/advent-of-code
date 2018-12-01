#!/usr/bin/perl

use strict;
use warnings;

# Perform a diagnostic checksum after 6 steps.

# In state A:
#  If the current value is 0:
#    - Write the value 1.
#    - Move one slot to the right.
#    - Continue with state B.
#  If the current value is 1:
#    - Write the value 0.
#    - Move one slot to the left.
#    - Continue with state B.

#In state B:
#  If the current value is 0:
#    - Write the value 1.
#    - Move one slot to the left.
#    - Continue with state A.
#  If the current value is 1:
#    - Write the value 1.
#    - Move one slot to the right.
#    - Continue with state A.

my $state;
my $steps;

my %blueprint;

while(<>) {
    chomp;

    if (/Begin in state ([A-Z]).  Perform a diagnostic checksum after (\d+) steps./) {
        $state = $1;
        $steps = $2;
    }

    if (/In state ([A-Z]): If the current value is (\d+): - Write the value (\d+).  - Move one slot to the (left|right).  - Continue with state ([A-Z]).  If the current value is (\d+): - Write the value (\d+).  - Move one slot to the (left|right).  - Continue with state ([A-Z])./) {
        $blueprint{$1} = {
            $2 => [ $3, $4, $5 ],
            $6 => [ $7, $8, $9 ],
        };
    }
}

my %tape;
$tape{0} = 0;

my $index = 0;

for my $i ( 1 .. $steps ) {

    my $blue = $blueprint{$state}->{$tape{$index}};
    $tape{$index} = $blue->[0];

    if ($blue->[1] eq 'left') {
        $index -= 1;
        $tape{$index} = 0 if !exists $tape{$index};
    }
    else {
        $index += 1;
        $tape{$index} = 0 if !exists $tape{$index};
    }

    $state = $blue->[2];

}

my $checksum = 0;
for my $key (sort keys %tape) {
    $checksum += $tape{$key};
}

print $checksum, "\n";
