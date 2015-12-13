#!/usr/bin/perl

use strict;
use warnings;

use List::Permutor;

my $happiness = {};

while (<>) {
    chomp;

    if ($_ =~ /^(.+) would (gain|lose) (\d+) happiness units by sitting next to (.+)\.$/) {
        $happiness->{$1}->{$4} = ($2 eq 'lose') ? -1 * $3 : int $3;
    }
}

for my $guest (keys %{$happiness}) {
    $happiness->{KenMGJ}->{$guest} = 0;
    $happiness->{$guest}->{KenMGJ} = 0;
}

my $best_score = 0;
my @best_arr;

my $perm = new List::Permutor keys %{$happiness};

while (my @set = $perm->next) {
    my $scores = 0;
    for my $i (0..scalar(@set) - 1) {
        my $h = ($i == 0) ? scalar(@set) - 1 : $i - 1;
        my $j = ($i == scalar(@set) - 1) ? 0 : $i + 1;
        $scores += $happiness->{$set[$i]}->{$set[$h]} + $happiness->{$set[$i]}->{$set[$j]};
    }

    if ($scores > $best_score) {
        $best_score = $scores;
        @best_arr = @set;
    }
}

print join(', ', @best_arr), ' : ', $best_score, "\n";
