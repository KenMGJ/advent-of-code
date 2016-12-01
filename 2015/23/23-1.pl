#!/usr/bin/perl

use strict;
use warnings;

my $registers = {
    a => 0,
    b => 0,
};

my @instructions;

while (<>) {
    chomp;
    my @instr = split / /;
    push @instructions, \@instr;
}

#use Data::Dumper;
#print Dumper \@instructions;

my $i = 0;
my $size = scalar @instructions;

while ($i >= 0 && $i < $size) {
    my $ins = $instructions[$i]->[0];

    if ($ins eq 'hlf') {
        $registers->{$instructions[$i]->[1]} /= 2;
        $i++;
    }
    elsif ($ins eq 'tpl') {
        $registers->{$instructions[$i]->[1]} *= 3;
        $i++;
    }
    elsif ($ins eq 'inc') {
        $registers->{$instructions[$i]->[1]}++;
        $i++;
    }
    elsif ($ins eq 'jmp') {
        $i = $i + $instructions[$i]->[1];
    }
    elsif ($ins eq 'jie') {
        my $reg  = substr $instructions[$i]->[1], 0, 1;
        my $val = $registers->{$reg};
        if ($val % 2 == 0) {
            $i = $i + $instructions[$i]->[2];
        }
        else {
            $i++;
        }
    }
    elsif ($ins eq 'jio') {
        my $reg  = substr $instructions[$i]->[1], 0, 1;
        my $val = $registers->{$reg};
        if ($val == 1) {
            $i = $i + $instructions[$i]->[2];
        }
        else {
            $i++;
        }
    }
}

print 'Register a: ', $registers->{a}, "\nRegister b: ", $registers->{b}, "\n";
