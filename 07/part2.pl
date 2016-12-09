#!/usr/bin/perl

use strict;
use warnings;

my $matches = 0;

while (<>) {
    chomp;

    my @strings = split /\[/;
    my @abas;
    my @hypernets;

    for my $string (@strings) {
        if ($string =~ /\]/) {
            my @strung = split /\]/, $string;
            push @abas, $strung[1];
            push @hypernets, $strung[0];
        }
        else {
            push @abas, $string;
        }
    }

    my @found_abas;
    for my $aba (@abas) {
        my $has_aba = has_aba($aba);
        push (@found_abas, $has_aba) if $has_aba;
    }

    my $aba_hash = {};
    for my $found_aba (@found_abas) {
        $aba_hash->{$found_aba} = 0;
        my @chars = split '', $found_aba;
        my $bab = $chars[1] . $chars[0] . $chars[1];
        for my $hypernet (@hypernets) {
            if ($hypernet =~ /${bab}/) {
                $aba_hash->{$found_aba} = 1;
            }
        }
    }

    my $found = 1;
    for my $key (keys %$aba_hash) {
        if ($aba_hash->{$key}) {
        }
        else {
            $found = 0;
            last;
        }
    }

    $matches++ if ($found);
}

print $matches, "\n";

sub has_aba {
    my $string = shift;

    my $i = 0;
    while ($i + 3 <= length($string)) {
        my @chars = split '', substr($string, $i, 3);
        if ($chars[0] eq $chars[2] && $chars[0] ne $chars[1]) {
            return substr($string, $i, 3);
        }

        $i++;
    }

    return 0;
}
