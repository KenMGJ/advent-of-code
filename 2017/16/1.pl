#!/usr/bin/perl

use strict;
use warnings;

my $start = new_item('a');

my $prev = $start;
for my $val ( 'b' .. 'p' ) {
    my $item = new_item($val);
    $prev->{next} = $item;
    $item->{prev} = $prev;
    $item->{next} = $start;
    $prev = $item;
}
$start->{prev} = $prev;

sub new_item {
    my $val = shift;

    return {
        val  => $val,,
        next => undef,
        prev => undef,
    };
}

while (<>) {
    chomp;
    my @instructions = split ',';

    for my $inst (@instructions) {
        if ($inst =~ /^s(\d+)$/) {
            for my $i ( 1 .. $1 ) {
                $start = $start->{prev};
            }
        }
        elsif ($inst =~ /^x(\d+)\/(\d+)$/) {

            my $a = $start;
            for my $i ( 1 .. $1 ) {
                $a = $a->{next};
            }

            my $b = $start;
            for my $i ( 1 .. $2 ) {
                $b = $b->{next};
            }

            my $val = $a->{val};
            $a->{val} = $b->{val};
            $b->{val} = $val;

        } 
        elsif ($inst =~ /^p([a-p])\/([a-p])$/) {
            my @swap;

            my $ptr = $start;
            until (scalar @swap == 2) {
                push @swap, $ptr if ($ptr->{val} eq $1 || $ptr->{val} eq $2);
                $ptr = $ptr->{next};
            }

            my $val = $swap[0]->{val};
            $swap[0]->{val} = $swap[1]->{val};
            $swap[1]->{val} = $val;
        }

    }

    print_progs();
}

sub print_progs {
    my $ptr = $start;
    do {
        print $ptr->{val};
        $ptr = $ptr->{next};
    } until ( $start == $ptr );
    print "\n";
}
