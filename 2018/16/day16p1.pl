#!/usr/bin/perl

use strict;
use warnings;

my @befores;
my @inputs;
my @afters;

while(<>) {
    chomp;

    if ($_ =~ /^Before: \[(\d+), (\d+), (\d+), (\d+)\]$/) {
        my @arr = ( $1, $2, $3, $4 );
        push @befores, \@arr;
    }
    elsif ($_ =~ /^(\d+) (\d+) (\d+) (\d+)$/) {
        my @arr = ( $1, $2, $3, $4 );
        push @inputs, \@arr;
    }
    elsif( $_ =~ /^After:  \[(\d+), (\d+), (\d+), (\d+)\]$/) {
        my @arr = ( $1, $2, $3, $4 );
        push @afters, \@arr;
    }

}

my %ops;
# addr - 6
$ops{"addr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] + $device->[$b];
};
# addi - 2
$ops{"addi"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] + $b;
};
# mulr - 12
$ops{"mulr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] * $device->[$b];
};
# muli - 13
$ops{"muli"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] * $b;
};
# banr - 15
$ops{"banr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] & $device->[$b];
};
# bani - 3
$ops{"bani"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] & $b;
};
# borr - 8
$ops{"borr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] | $device->[$b];
};
# bori - 1
$ops{"bori"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] | $b;
};
# setr - 10
$ops{"setr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a];
};
# seti - 4
$ops{"seti"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $a;
};
# gtir - 9
$ops{"gtir"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $a > $device->[$b] ? 1 : 0;
};
# gtri - 7
$ops{"gtri"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] > $b ? 1 : 0;
};
# gtrr - 14
$ops{"gtrr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] > $device->[$b] ? 1 : 0;
};
# eqir - 11
$ops{"eqir"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $a == $device->[$b] ? 1 : 0;
};
# eqri - 0
$ops{"eqri"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] == $b ? 1 : 0;
};
# eqrr - 5
$ops{"eqrr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] == $device->[$b] ? 1 : 0;
};

my $total_matches = 0;

for my $i ( 0 .. $#befores ) {
    my @before = @{$befores[$i]};
    my @input  = @{$inputs[$i]};
    my @afters = @{$afters[$i]};

    my $matches = 0;
    for my $key (keys %ops) {
        my $device = new_device();
        $device->[0] = $before[0];
        $device->[1] = $before[1];
        $device->[2] = $before[2];
        $device->[3] = $before[3];

        $ops{$key}( $device, $input[1], $input[2], $input[3] );

        if ($device->[0] == $afters[0] && $device->[1] == $afters[1] &&
            $device->[2] == $afters[2] && $device->[3] == $afters[3]) {
            $matches++;
        }
    }

    $total_matches++ if $matches >= 3;
}

print $total_matches, "\n";

sub new_device {
    my @device;
    push @device, 0, 0, 0, 0;
    return \@device;
}

