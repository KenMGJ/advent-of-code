#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/ sum /;
use Math::Prime::Util qw/divisors/;

use Memoize;
memoize('elf_present_count');

my $TARGET = 29000000;

my $house = 1;
my $present_count = 0;

while (1) {
    $present_count = present_count($house);
    last if $present_count >= $TARGET;
    $house++;
}

print 'House ', $house, ' got ', $present_count, " presents.\n";

sub present_count {
    my $house_number = shift;

    my @divisors = divisors($house_number);
    # print join(', ', @divisors), "\n";
    @divisors = map { elf_present_count($_) } @divisors;
    # print join(', ', @divisors), "\n";

    return sum @divisors;
}

sub elf_present_count {
    my $elf = shift;
    return $elf * 10;
}
