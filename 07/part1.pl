#!/usr/bin/perl

use strict;
use warnings;

my $matches = 0;

while (<>) {
    chomp;

    my $has_abba = 0;
    my @matches;
    if (@matches = ( $_ =~ m/\[(\w+)\]/)) {
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
        $new_string =~ s/\[${match}\]/ /g;
    }

    for my $part (split ' ', $new_string) {
        if (has_abba($part)) {
                $matches++;
                next;
        }
    }

}

print $matches, "\n";

sub has_abba {
    my $string = shift;

    my $i = 0;
    while ($i + 4 <= length($string)) {
        my @chars = split '', substr($string, $i, 4);
        if ($chars[0] ne $chars[1] && $chars[0] eq $chars[3] && $chars[1] eq $chars[2]) {
            print $i, "\t", ($i + 4), "\t", join(', ', @chars), "\n";
            print substr($string, $i, $i + 4), "\n";
            return 1;
        }

        $i++;
    }

    return 0;
}
