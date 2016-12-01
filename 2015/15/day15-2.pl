#!/usr/bin/perl

use strict;
use warnings;

my $ingredients = {};

while (<>) {
    chomp;

    if ($_ =~ /^(.+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)$/) {
        $ingredients->{$1} = {
            capacity   => int $2,
            durability => int $3,
            flavor     => int $4,
            texture    => int $5,
            calories   => int $6,
        };
    }
}

my $ADD_TO = 100;
my $ingredient_count = scalar keys %{$ingredients};

my $score = 0;

for my $i (add_to($ADD_TO, $ingredient_count)) {
    my @scores = split ',', $i;
    my $recipe = {};
    my $j = 0;

    for my $k (keys %{$ingredients}) {
        $recipe->{$k} = $scores[$j];
        $j++;
    }

    my $recipe_score = calc_score($recipe);
    $score = $recipe_score if $score < $recipe_score;
}

print $score, "\n";

sub calc_score {
    my $recipe = shift;

    my $capacity = 0;
    my $durability = 0;
    my $flavor = 0;
    my $texture = 0;
    my $calories = 0;

    for my $ingredient (keys %{$ingredients}) {
        $capacity   += $ingredients->{$ingredient}->{capacity} * $recipe->{$ingredient};
        $durability += $ingredients->{$ingredient}->{durability} * $recipe->{$ingredient};
        $flavor     += $ingredients->{$ingredient}->{flavor} * $recipe->{$ingredient};
        $texture    += $ingredients->{$ingredient}->{texture} * $recipe->{$ingredient};
        $calories   += $ingredients->{$ingredient}->{calories} * $recipe->{$ingredient};
    }

    $capacity   = 0 if $capacity < 0;
    $durability = 0 if $durability < 0;
    $flavor     = 0 if $flavor < 0;
    $texture    = 0 if $texture < 0;

    return ($calories == 500) ? $capacity * $durability * $flavor * $texture : 0;
}

sub add_to {
    my $total = shift;
    my $num = shift;

    my @return;

    if ($num == 1) {
        push @return, $total;
    }
    else {
        for my $i (1..($total - $num + 1)) {
            for my $j (add_to($total - $i, $num - 1)) {
                push @return, $i . ',' . $j;
            }
        }
    }

    return @return;
}
