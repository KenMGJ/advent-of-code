#!/usr/bin/perl

use strict;
use warnings;

use Math::Prime::Util qw( is_prime );

my $b = 106700;
my $c = 123700;
my $h = 0;

#for (my $b = 106700; $b < $c; $b += 17) {
#    my $f = 1;
#    for (my $d = 2; $d < $b; $d++) {
#        for (my $e = 2; $e < $b; $e++) {
#            if ($d * $e == $b) {
#                $f = 0;
#            }
#        }
#        if ($f == 0) {
#            $h += 1;
#            print $h, "\n";
#        }
#    }
#}

while ($b < $c + 1) {
    $h += 1 if not is_prime($b);
    $b += 17;
}

print $h, "\n";
