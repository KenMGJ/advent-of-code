#!/usr/bin/perl

use strict;
use warnings;

sub new_device {
    my @device;
    push @device, 0, 0, 0, 0, 0, 0;
    return \@device;
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
    $device->[$c] = int($device->[$a]) & int($device->[$b]);
};
$ops{"bani"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = int($device->[$a]) & int($b);
};
$ops{"borr"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = int($device->[$a]) | int($device->[$b]);
};
$ops{"bori"} = sub {
    my ($device, $a, $b, $c) = @_;
    $device->[$c] = int($device->[$a]) | int($b);
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

my $device = new_device();
my $ip;

my @program;

while (<>) {
    chomp;

    if ($_ =~ /^\#ip (\d+)$/) {
        $ip = $1;
    }
    elsif ($_ =~ /^(.*) (\d+) (\d+) (\d+)/) {
        push @program, [ $1, $2, $3, $4 ];
    }
}

my $ptr = 0;
$device->[0] = 47;
my $size = scalar @program;
my $i = 0;
until ($ptr >= $size) {
    $device->[$ip] = $ptr;
    my @inst = @{$program[$ptr]};
    $ops{$inst[0]}($device, $inst[1], $inst[2], $inst[3]);
    $ptr = $device->[$ip];
    $ptr = $ptr + 1;
    print $ptr, "\t"; # , ' ', $device->[5], "\n";

    print join(', ', @{$device}), "\n";
    if ($ptr == 26 ) { # && $device->[0] != $prev) {
        # print join(', ', @{$device}), "\n";
        # last if $i++ == 3;
        $i++;
    }
    elsif ($ptr == 25) {
        last if $i == 2;
    }
}