#!/usr/bin/perl

use strict;
use warnings;

use Const::Fast;

const my %lookup => (
    0 => 0,
    1 => 1,
    2 => 1,
    3 => 2,
    4 => 1,
    5 => 2,
    6 => 2,
    7 => 3,
    8 => 1,
    9 => 2,
    a => 2,
    b => 3,
    c => 2,
    d => 3,
    e => 3,
    f => 4,
);

const my $key  => 'hxtvlmkl';
const my $SIZE => 256;

my $used = 0;

for my $i ( 0 .. 127 ) {
    my $input = "$key-$i";
    my $hash  = get_hash($input);
    $used += get_bits($hash);
}

print $used, "\n";

sub get_bits {
    my $hash = shift;

    my $used = 0;

    my @chars = split '', $hash;
    for my $char (@chars) {
        $used += $lookup{$char};
    }

    return $used;
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
