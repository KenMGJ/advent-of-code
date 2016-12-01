#!/usr/bin/perl

use strict;
use warnings;

my $replacements = {};
my $molecules;

while (<>) {
    chomp;

    if ($_ =~ /^(.+) => (.+)$/) {
        push @{$replacements->{$1}}, $2;
    }
    elsif ($_ =~ /(.+)/) {
        $molecules = $1;
    }
}

my $results = {};

for my $key (keys %{$replacements}) {
    for my $val (@{$replacements->{$key}}) {
        findReplacements($key, $val);
    }
}

sub findReplacements {
    my $a = shift;
    my $b = shift;

    my $i = 0;
    my $molecules_length = length $molecules;

    while ($i < $molecules_length) {

        my $upper_limit = $i + length $a;
        $upper_limit = length $molecules_length if $upper_limit > $molecules_length;

        my $sub = substr $molecules, $i, $upper_limit - $i;
        if ($sub eq $a) {
            my $result = '';
            $result .= substr($molecules, 0, $i);
            $result .= $b;
            $result .= substr($molecules, $i + length($a));
            $results->{$result} = 1;
        }

        $i++;
    }
}

print scalar keys %{$results}, "\n";
