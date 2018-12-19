#!/usr/bin/perl 

my $val = 10551267;

my $sum = 0;

for my $i (1 .. $val) {
    if ($val % $i == 0) {
        $sum += $i;
    }
}

print $sum, "\n";