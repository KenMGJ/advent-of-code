#!/usr/bin/perl

use strict;
use warnings;

my $replacements = [];
my $medicine;

while (<>) {
    chomp;

    if ($_ =~ /^(.+) => (.+)$/) {
        push @{$replacements}, [$1, $2];
    }
    elsif ($_ =~ /(.+)/) {
        $medicine = $1;
    }
}

my $molecules = {
    'e' => 1,
};

my $i = 0;
while (1) {
    $molecules = generate_molecules($molecules);
    $i++;
    if (defined $molecules->{$medicine}) {
        print $i, "\n";
        last;
    }
}

sub generate_molecules {
    my $molecules = shift;

    my $new_molecules = {};

    for my $molecule (keys %{$molecules}) {
        for my $rpl (@{$replacements}) {
            my $keys = all_replace_one($molecule, $rpl->[0], $rpl->[1]);
            for my $key (keys %{$keys}) {
                $new_molecules->{$key} = 1;
            }
        }
    }

    return $new_molecules;
}

sub all_replace_one {
    my $string = shift;
    my $find = shift;
    my $replace = shift;

    my $string_len = length $string;
    my $find_len = length $find;

    my $results;

    my $i = 0;
    while ($i < $string_len) {
        my $cmp = substr $string, $i, $find_len;
        if ($cmp eq $find) {
            my $result = '';
            if ($i > 0) {
                $result = substr $string, 0, $i;
            }
            $result .= $replace;
            $result .= substr $string, $i + $find_len;
            $results->{$result} = 1;
        }
        $i++;
    }

    return $results;
}
