#!/usr/bin/perl

use strict;
use warnings;

my $mfcsam_results = {
    children    => 3,
    cats        => 7,
    samoyeds    => 2,
    pomeranians => 3,
    akitas      => 0,
    vizslas     => 0,
    goldfish    => 5,
    trees       => 3,
    cars        => 2,
    perfumes    => 1,
};

my @aunt_sue;

while (<>) {
    chomp;

    if ($_ =~ /^Sue (\d+): (.+): (\d+), (.+): (\d+), (.+): (\d+)$/) {
        push @aunt_sue, {
            num => int $1,
            $2  => int $3,
            $4  => int $5,
            $6  => int $7,
        };
    }
}

for my $key (keys %{$mfcsam_results}) {
    my @real_aunt_sue;
    for my $sue (@aunt_sue) {
        if (!defined $sue->{$key}) {
            push @real_aunt_sue, $sue;
        }
        elsif ($key eq 'cats' && ($sue->{cats} > $mfcsam_results->{cats})) {
            push @real_aunt_sue, $sue;
        }
        elsif ($key eq 'trees' && ($sue->{trees} > $mfcsam_results->{trees})) {
            push @real_aunt_sue, $sue;
        }
        elsif ($key eq 'goldfish' && ($sue->{goldfish} < $mfcsam_results->{goldfish})) {
            push @real_aunt_sue, $sue;
        }
        elsif ($key eq 'pomeranians' && ($sue->{pomeranians} < $mfcsam_results->{pomeranians})) {
            push @real_aunt_sue, $sue;
        }
        elsif ($key ne 'cats' && $key ne 'trees' && $key ne 'goldfish' && $key ne 'pomeranians' && $sue->{$key} == $mfcsam_results->{$key}) {
            push @real_aunt_sue, $sue;
        }
    }
    @aunt_sue = @real_aunt_sue;
}

use Data::Dumper;
print Dumper \@aunt_sue;
