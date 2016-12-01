#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use JSON::XS;
use Scalar::Util::Numeric qw/isint/;

my $total = 0;

while (<>) {
    chomp;

    my $subtotal = 0;

    my $line = decode_json $_;
    $subtotal = find_value($line);

    $total += $subtotal;
}

print $total, "\n";

sub find_value {
    my $ref = shift;
    my $total = 0;

    my $type = ref $ref;
    if ($type eq 'ARRAY') {
        for my $val (@{$ref}) {
            $total += find_value($val);
        }
    }
    elsif ($type eq 'HASH') {
        my $has_red = 0;
        for my $key (keys %{$ref}) {
            $has_red++ if $ref->{$key} eq 'red';
        }
        if (!$has_red) {
            for my $key (keys %{$ref}) {
                $total += find_value($ref->{$key});
            }
        }
    }
    else {
        $total += $ref if isint $ref;
    }

    return $total;
}
