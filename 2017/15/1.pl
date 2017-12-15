#!/usr/bin/perl

use strict;
use warnings;

use integer;

use Const::Fast;

const my $start_a  => 699;
const my $start_b  => 124;
const my $factor_a => 16_807;
const my $factor_b => 48_271;;
const my $divisor  => 2147483647;

const my $times    => 40_000_000;

const my $zero     => 0x10000;

my $a = $start_a;
my $b = $start_b;

my $match = 0;

for my $i ( 1 .. $times ) {

    $a = ($a * $factor_a % $divisor);
    $b = ($b * $factor_b % $divisor);

    my $a_mod_0 = $a % $zero;
    my $b_mod_0 = $b % $zero;

    # printf "%032b\n%032b\n\n", $a_mod_0, $b_mod_0;

    $match++ if $a_mod_0 == $b_mod_0;  
}

print $match, "\n";
