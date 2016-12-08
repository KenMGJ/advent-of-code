#!/usr/bin/perl

use strict;
use warnings;

my $matches = 0;

while (<>) {
    chomp;

    my $has_abba = 0;
    my @matches;
    if (@matches = ( $_ =~ m/\[(\w+)\]/g)) {
        for my $match (@matches) {
            if (has_abba($match)) {
                $has_abba = 1;
                last;
            }
        }
    }
    next if $has_abba;

    my $new_string = $_;
    for my $match (@matches) {
        $new_string =~ s/(\[${match}\])+?/ /g;
    }

    my $ok = 0;
    my $found_here = '';
    for my $part (split ' ', $new_string) {
        if (my $found = has_abba($part)) {
                $found_here = $found;
                $ok = 1;
                $matches++;
                next;
        }
    }
    print $ok, ' ', join('|',@matches), ' ', $found_here, ' ', $_, "\t", $new_string, "\n";
}

print $matches, "\n";

sub has_abba {
    my $string = shift;

    my $i = 0;
    while ($i + 4 <= length($string)) {
        my @chars = split '', substr($string, $i, 4);
        if ($chars[0] ne $chars[1] && $chars[0] eq $chars[3] && $chars[1] eq $chars[2]) {
            return substr($string, $i, 4);
        }

        $i++;
    }

    return 0;
}
