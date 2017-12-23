#!/usr/bin/perl

use strict;
use warnings;

my @mem;

while(<>) {
    chomp;

    my @inst = split ' ';
    push @mem, \@inst;
}

my %reg;
$reg{a} = 0;
$reg{b} = 0;
$reg{c} = 0;
$reg{d} = 0;
$reg{e} = 0;
$reg{f} = 0;
$reg{g} = 0;
$reg{h} = 0;

my $ptr = 0;
my $mul_count = 0;

while ($ptr < scalar @mem) {

    my $inst = $mem[$ptr];

    my $i = $inst->[0];
    my $x = $inst->[1];
    my $y = $inst->[2];

    $y = $reg{$y} if !($y =~ /(\d)+/);

    if ($i eq 'set') {
        $reg{$x} = $y;
        $ptr += 1;
    }
    elsif ($i eq 'sub') {
        $reg{$x} -= $y;
        $ptr += 1;
    }
    elsif ($i eq 'mul') {
        $reg{$x} *= $y;
        $mul_count += 1;
        $ptr += 1;
    }
    elsif ($i eq 'jnz') {
        $x = $reg{$x} if !($x =~ /(\d)+/);
        if ($x != 0) {
            $ptr += $y if $x != 0;
        }
        else {
            $ptr += 1;
        }
    }

}

print $mul_count, "\n";
