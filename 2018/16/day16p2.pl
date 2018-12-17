#!/usr/bin/perl

use strict;
use warnings;

my @inputs;

while(<>) {
    chomp;

    if ($_ =~ /^(\d+) (\d+) (\d+) (\d+)$/) {
        my @arr = ( $1, $2, $3, $4 );
        push @inputs, \@arr;
    }
}

my %ops;
$ops{"addr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] + $device->[$b];
};
$ops{"addi"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] + $b;
};
$ops{"mulr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] * $device->[$b];
};
$ops{"muli"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] * $b;
};
$ops{"banr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] & $device->[$b];
};
$ops{"bani"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] & $b;
};
$ops{"borr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] | $device->[$b];
};
$ops{"bori"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] | $b;
};
$ops{"setr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a];
};
$ops{"seti"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $a;
};
$ops{"gtir"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $a > $device->[$b] ? 1 : 0;
};
$ops{"gtri"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] > $b ? 1 : 0;
};
$ops{"gtrr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] > $device->[$b] ? 1 : 0;
};
$ops{"eqir"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $a == $device->[$b] ? 1 : 0;
};
$ops{"eqri"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] == $b ? 1 : 0;
};
$ops{"eqrr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = $device->[$a] == $device->[$b] ? 1 : 0;
};

my @operations;
push @operations, $ops{eqri};
push @operations, $ops{bori};
push @operations, $ops{addi};
push @operations, $ops{bani};
push @operations, $ops{seti};
push @operations, $ops{eqrr};
push @operations, $ops{addr};
push @operations, $ops{gtri};
push @operations, $ops{borr};
push @operations, $ops{gtir};
push @operations, $ops{setr};
push @operations, $ops{eqir};
push @operations, $ops{mulr};
push @operations, $ops{muli};
push @operations, $ops{gtrr};
push @operations, $ops{banr};

my $device = new_device();

for my $i ( 0 .. $#inputs ) {
    my @input  = @{$inputs[$i]};

    $operations[$input[0]]($device, $input[1], $input[2], $input[3]);
}

use Data::Dumper;
print Dumper \$device;

sub new_device {
    my @device;
    push @device, 0, 0, 0, 0;
    return \@device;
}

