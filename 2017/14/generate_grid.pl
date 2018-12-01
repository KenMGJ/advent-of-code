#!/usr/bin/perl

use strict;
use warnings;

use bigint;

use Const::Fast;

const my $key  => 'hxtvlmkl';
#const my $key  => 'flqrgnkx';
const my $SIZE => 256;

my @grid;

for my $i ( 0 .. 127 ) {
    warn $i % 10;

    my $input = "$key-$i";
    my $hash_as_string = get_hash($input);

    my $bin = '';
    for my $char ( split '', $hash_as_string ) {
        my $hex = hex $char; # . $hash_as_string );
        $bin .= sprintf("%04b", $hex);
    }

    my @row = split '', $bin;
    push @grid, \@row;
}

for my $i ( 0 .. 127 ) {
    print join('', @{$grid[$i]}), "\n";
}

sub get_hash {
    my $input = shift;

    my @lengths = split '', $input;
    @lengths = map { ord($_) } @lengths;

    push @lengths, ( 17, 31, 73, 47, 23 );

    my @list;
    for my $i ( 0 .. $SIZE - 1 ) {
        $list[$i] = $i;
    }

    my $pos  = 0;
    my $skip = 0;

    for my $round ( 1 .. 64 ) {

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
            $pos %= $SIZE;
            $skip = ($skip + 1) % $SIZE;

        }

    }

    my $hash = '';

    my $i = 0;
    while ($i < $SIZE) {

        my $val = $list[$i];
        for my $j ( 1 .. 15 ) {
            $val = $val ^ $list[$i + $j];
        }

        my $hex = sprintf("%02x", $val);
        $hash .= $hex;
        $i += 16;
    }

    return $hash;
}

sub get_indexes {
    my ($pos, $length) = @_;

    my @indexes;

    for my $i ( 0 .. $length - 1) {
        my $idx = $pos + $i;
        $idx %= $SIZE;
        push @indexes, $idx;
    }

    return @indexes;
}
