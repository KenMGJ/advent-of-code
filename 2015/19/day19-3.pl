#!/usr/bin/perl

use strict;
use warnings;

my $replacements = [
    [ 'H', 'e', ],
    [ 'O', 'e', ],
    [ 'HO', 'H', ],
    [ 'OH', 'H', ],
    [ 'HH', 'O', ],
];

my $molecule = 'HOHOHO';

my $i = 0;
while ($molecule ne 'e') {
    my $previous_molecule = $molecule;

    my $rand = get_random(scalar @{$replacements});
    $molecule = replace_one($molecule, $replacements->[$rand][0], $replacements->[$rand][1]);

    if ($previous_molecule ne $molecule) {
        $i++;
    }
    print $previous_molecule, ' ', $molecule, "\n";
}

print $i, "\n";

sub get_random {
    my $upper = shift;
    return int(rand($upper));
}

sub replace_one {
    my $molecule = shift;
    my $find = shift;
    my $replace = shift;

    #print $molecule, ' ', $find, ' ', $replace, "\n";

    my @finds = $molecule =~ /($find)/g;
    my $rand = get_random(scalar @finds) + 1;
    #print "Replace $rand\n";

    my @mols = split /$find/, $molecule;
    my $mols_size = scalar @mols;

    while ($molecule =~ /$find/g) {
        if (--$rand == 0) {
            substr($molecule, $-[0], $+[0] - $-[0], $replace);
            last;
        }
    }

    #print $molecule, ' ', $find, ' ', $replace, "\n";

    return $molecule;
}
