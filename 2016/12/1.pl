#!/usr/bin/perl

use strict;
use warnings;

my %reg;
$reg{'c'} = 1;

my @mem;

while(<>) {
    chomp;

    my @inst;

    if (/cpy (.*) (.*)/) {
        push @inst, 'cpy', $1, $2;
    }
    elsif (/inc (.*)/) {
        push @inst, 'inc', $1;
    }
    elsif (/dec (.*)/) {
        push @inst, 'dec', $1;
    }
    elsif (/jnz (.*) (.*)/) {
        push @inst, 'jnz', $1, $2;
    }

    push @mem, \@inst;
}

my $ptr = 0;

while ($ptr < scalar @mem) {
    my $inst = $mem[$ptr][0];
    my $a = $mem[$ptr][1];

    if ($inst eq 'cpy') {
        my $b = $mem[$ptr][2];
        $reg{$b} = 0 if !exists $reg{$b};

        if ($a =~ /\d+/) {
            $reg{$b} = $a;
        }
        else {
            $reg{$b} = $reg{$a};
        }
        $ptr += 1;
    }
    elsif ($inst eq 'inc') {
        $reg{$a} = 0 if !exists $reg{$a};
        $reg{$a} += 1;
        $ptr += 1;
    }
    elsif ($inst eq 'dec') {
        $reg{$a} = 0 if !exists $reg{$a};
        $reg{$a} -= 1;
        $ptr += 1;
    }
    elsif ($inst eq 'jnz') {
        my $b = $mem[$ptr][2];

        if (!($a =~ /\d+/)) {
            $reg{$a} = 0 if !exists $reg{$a};
            $a = $reg{$a};
        }

        $ptr += $a != 0 ? $b : 1;
    }
}

print $reg{'a'}, "\n";
