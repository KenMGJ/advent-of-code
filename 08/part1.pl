#!/usr/bin/perl

use strict;
use warnings;

my $width = 50;
my $height = 6;

my $screen = [];

for my $i (0 .. ($width - 1)) {
    $screen->[$i] = [];
    for my $j (0 .. ($height - 1)) {
        $screen->[$i]->[$j] = 0;
    }
}

while (<>) {
    if ($_ =~ /^rect (\d+)x(\d+)$/) {
        draw_rect($1, $2);
    }
    elsif ($_ =~ /^rotate column x=(\d+) by (\d+)$/) {
        rotate_column($1, $2);
    }
    elsif ($_ =~ /^rotate row y=(\d+) by (\d+)$/) {
        rotate_row($1, $2);
    }
}

print_screen();
print count_lit(), "\n";

sub count_lit {
    my $lit = 0;
    for my $i (0 .. ($width - 1)) {
        for my $j (0 .. ($height - 1)) {
            if ($screen->[$i]->[$j] == 1) {
                $lit++;
            }
        }
    }
    return $lit;

}


sub draw_rect {
    my $x = shift;
    my $y = shift;

    for my $i (0 .. ($x - 1)) {
        for my $j (0 .. ($y - 1)) {
            $screen->[$i]->[$j] = 1;
        }
    }
}

sub rotate_row {
    my $row = shift;
    my $pixels = shift;

    my $row_values = [];
    for my $i (0 .. ($width - 1)) {
        $row_values->[$i] = $screen->[$i]->[$row];
    }

    for my $i (1 .. $pixels) {
        my $value = pop @$row_values;
        unshift @$row_values, $value;
    }

    for my $i (0 .. ($width - 1)) {
        $screen->[$i]->[$row] = $row_values->[$i];
    }
}

sub rotate_column {
    my $column = shift;
    my $pixels = shift;

    my $column_values = [];
    for my $i (0 .. ($height - 1)) {
        $column_values->[$i] = $screen->[$column]->[$i];
    }

    for my $i (1 .. $pixels) {
        my $value = pop @$column_values;
        unshift @$column_values, $value;
    }

    for my $i (0 .. ($height - 1)) {
        $screen->[$column]->[$i] = $column_values->[$i];
    }
}

sub print_screen {
    print "\n";
    for my $j (0 .. ($height - 1)) {
        for my $i (0 .. ($width - 1)) {
            if ($screen->[$i]->[$j]) {
                print '#';
            }
            else {
                print '.';
            }
        }
        print "\n";
    }
    print "\n";
}
