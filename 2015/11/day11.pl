#!/usr/bin/perl

use strict;
use warnings;

my $A = ord 'a';
my $Y = ord 'y';
my $Z = ord 'z';

my $password = $ARGV[0];

do {
    $password = increment($password);
}
while (!is_secure($password));

print $password, "\n";

sub is_secure {
    my $arg = shift;
    my @digits = split '', $arg;
    my @numbs = map(ord, @digits);

    my $has_straight = 0;
    my $straight_start = 0;
    my $i = 0;

    while ($i < length($arg) - 3) {
        my $num1 = $numbs[$i];
        my $num2 = $numbs[$i+1];
        my $num3 = $numbs[$i+2];

        if ($num1 == $num3 - 2 && $num2 == $num3 - 1) {
            $has_straight = 1;
            $straight_start = $i;
            last;
        }
        $i++;
    }

    return 0 if !$has_straight;

    my $has_invalid_letters = 0;
    for my $digit (@digits) {
        if ($digit eq 'i' || $digit eq 'o' || $digit eq 'l') {
            $has_invalid_letters = 1;
            last;
        }
    }

    return 0 if $has_invalid_letters;

    $i = 0;
    my $found = 0;
    my $repeated_letter = '';
    while ($i < (length($arg) - 1)) {
        if (($digits[$i] eq $digits[$i+1]) && ($digits[$i] ne $repeated_letter)) {
            if ($found == 0) {
                $found = 1;
                $repeated_letter = $digits[$i];
                $i = $i + 2;
                next;
            }
            else {
                $found = 2;
                last;
            }
        }
        else {
            $i++;
        }
    }

    return ($found == 2) ? 1 : 0;
}

sub increment {
    my $arg = shift;
    my @digits = reverse split '', $arg;
    # print join(', ', @digits), "\n";
    
    my @result;
    my $carry = 1;

    for my $digit (@digits) {
        if ($carry) {
            my $add_one = add_one($digit);
            $digit = $add_one->{digit};
            $carry = $add_one->{carry};
        }
        push @result, $digit;
    }

    return reverse @digits;
}

sub add_one {
    my $digit = shift;

    my $new_digit = ord($digit) + 1;
    my $carry = 0;

    if ($new_digit > $Z) {
        $new_digit = $A;
        $carry = 1;
    }
    return { digit => chr $new_digit, carry => $carry };
}
