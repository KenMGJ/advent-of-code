#!/usr/bin/perl

use strict;
use warnings;

use Const::Fast;

const my $SIZE => 256;

while (<>) {
    chomp;

    my @lengths = split ',';

    my @list;
    for my $i ( 0 .. $SIZE - 1 ) {
        $list[$i] = $i;
    }

    my $pos  = 0;
    my $skip = 0;

    for my $length (@lengths) {

        next if $length > $SIZE;

        my @indexes = get_indexes($pos, $length);

        my @values;
        for my $i (@indexes) {
            push @values, $list[$i];
        }

        for my $i (@indexes) {
            $list[$i] = pop @values;
        }

        $pos += $length + $skip;
        $pos -= $SIZE if $pos >= $SIZE;
        $skip++;

        # print join(', ', @list), "pos: $pos  skip: $skip\n";
    }

    print "Hash: ", $list[0] * $list[1], "\n";
}

sub get_indexes {
    my ($pos, $length) = @_;

    my @indexes;

    for my $i ( 0 .. $length - 1) {
        my $idx = $pos + $i;
        $idx -= $SIZE if $idx >= $SIZE;
        push @indexes, $idx;
    }

    return @indexes;
}
