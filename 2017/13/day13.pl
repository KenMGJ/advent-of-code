#!/usr/bin/perl

use strict;
use warnings;

use Memoize;
memoize('get_scanner_location');

my %areas;

my $last_area = 0;

while (<>) {
    chomp;

    my ($area, $length) = split ': ';

    $areas{$area} = $length;
    $last_area = $area if $area > $last_area;
}

my $current_area = -1;
my $severity = 0;

while ($current_area < $last_area) {

    # Move to the next area
    $current_area++;

    if ( exists $areas{$current_area} ) {
        my $scanner_location = get_scanner_location($current_area, $areas{$current_area});
        if ($scanner_location == 0) {
            $severity += $current_area * $areas{$current_area};
        }
    }
}

print $severity, "\n";

sub get_scanner_location {
    my $position = shift;
    my $length   = shift;

    $position -= $length - 1;
    my $amplitude = 2 * ($length - 1);
    my $period = 2 * ( 2 * $length - 2 );

    return abs ((2 * $amplitude / $period) * ( abs( ($position % $period) - ($period / 2) ) - ($period / 4) ));

}
