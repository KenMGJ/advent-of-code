#!/usr/bin/perl

use strict;
use warnings;

use Scalar::Util::Numeric qw(isint);

use Data::Dumper;

my $circuit = {};

# Read directions
while (<>) {
	chomp;

    my $instruction;

    if ($_ =~ /^(\d+) -> ([a-z]+)$/) {
        $instruction = { name => $2, value => int $1  };
    }
    elsif ($_ =~ /^([a-z]+) -> ([a-z]+)$/) {
        $instruction = { name => $2, input => [ $1 ] };
    }
    elsif ($_ =~ /^([a-z]+) (AND|OR) ([a-z]+) -> ([a-z]+)$/) {
        $instruction = { name => $4, op => $2, input => [$1, $3], };
    }
    elsif ($_ =~ /^(\d+) (AND|OR) ([a-z]+) -> ([a-z]+)$/) {
        $instruction = { name => $4, op => $2 . 'V', input => [ int $1, $3 ], };
    }
    elsif ($_ =~ /^([a-z]+) (LSHIFT|RSHIFT) (\d+) -> ([a-z]+)$/) {
        $instruction = { name => $4, op => $2, input => [ $1, int $3], };
    }
    elsif ($_ =~ /^NOT ([a-z]+) -> ([a-z]+)$/) {
        $instruction = { name => $2, op => 'NOT', input => [ $1 ], };
    }

    $circuit->{$instruction->{name}} = $instruction;
}

sub get_value {
    my $name = shift;

    my $wire = $circuit->{$name};

    if (!defined $wire->{value}) {
        if (!defined $wire->{op} ) {
            $wire->{value} = get_value($wire->{input}->[0]);
        }
        elsif($wire->{op} eq 'AND') {
            $wire->{value} = get_value($wire->{input}->[0]) & get_value($wire->{input}->[1]);
        }
        elsif($wire->{op} eq 'OR') {
            $wire->{value} = get_value($wire->{input}->[0]) | get_value($wire->{input}->[1]);
        }
        elsif($wire->{op} eq 'ANDV') {
            $wire->{value} = $wire->{input}->[0] & get_value($wire->{input}->[1]);
        }
        elsif($wire->{op} eq 'ORV') {
            $wire->{value} = $wire->{input}->[0] | get_value($wire->{input}->[1]);
        }
        elsif($wire->{op} eq 'LSHIFT') {
            $wire->{value} = get_value($wire->{input}->[0]) << $wire->{input}->[1];
        }
        elsif($wire->{op} eq 'RSHIFT') {
            $wire->{value} = get_value($wire->{input}->[0]) >> $wire->{input}->[1];
        }
        elsif($wire->{op} eq 'NOT') {
            $wire->{value} = (~get_value($wire->{input}->[0])) & 65535;
        }
    }

    return $wire->{value}
}

$circuit->{b}->{value} = 46065;
print get_value('a'), "\n";
