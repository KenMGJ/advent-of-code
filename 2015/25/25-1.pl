#!/usr/bin/perl

use strict;
use warnings;

my $start = 20151125;
my $row = $ARGV[0];
my $col = $ARGV[1];

# 1  3  6 10 15 21 28
# 2  5  9 14 20 27
# 4  8 13 19 26
# 7 12 18 25
#11 17 24
#16 23
#22
#row 5
#    1 (+ 1) 2 (+ 2) 4 (+ 3) 7 (+ 4) 11
#column 3
#    1 (+ 2) 3 (+ 3) 6

my $val = find_val($row, $col);
print $val, "\n";

print calc_code($val), "\n";

sub find_val {
    my $row = shift;
    my $col = shift;

    my $val = 1;
    for my $i (2..$col) {
        $val += $i;
    }
    print $val, "\n";

    for my $j (0..($row-2)) {
        $val += ($j + $col);
    }
    print $val, "\n";

    return $val;
}

sub calc_code {
    my $i = shift;

    if ($i == 1) {
        return $start;
    }
    else {
        return ((calc_code($i - 1) * 252533) % 33554393);
    }
}
