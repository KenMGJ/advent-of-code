#!/usr/bin/perl

use strict;
use warnings;

my $matches = 0;

while (<>) {
    chomp;

    my @strings = split /\[/;
    my @abbas;
    my @hypernets;

    for my $string (@strings) {
        if ($string =~ /\]/) {
            my @strung = split /\]/, $string;
            push @abbas, $strung[1];
            push @hypernets, $strung[0];
        }
        else {
            push @abbas, $string;
        }
    }

    my $has_abbas = 0;
    for my $hypernet (@hypernets) {
        $has_abbas += has_abba($hypernet);
    }
    next if ($has_abbas);

    for my $abba (@abbas) {
        $has_abbas += has_abba($abba);
    }
    $matches++ if ($has_abbas);

}

print $matches, "\n";

sub has_abba {
    my $string = shift;

    my $i = 0;
    while ($i + 4 <= length($string)) {
        my @chars = split '', substr($string, $i, 4);
        if ($chars[0] ne $chars[1] && $chars[0] eq $chars[3] && $chars[1] eq $chars[2]) {
            return 1;
        }

        $i++;
    }

    return 0;
}
