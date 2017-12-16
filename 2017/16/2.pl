#!/usr/bin/perl

use strict;
use warnings;

my $times = 42;

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

    my $n_times = 1_000_000_000;
    do {
        $n_times -= 42;
    } until ($n_times < 42);

    for my $time ( 1 .. $n_times ) {
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

        my $progs = get_progs();
        print $time, "\t", $progs, "\n";
    }
    my $progs = get_progs();
    print $progs, "\n";
}

sub get_progs {
    my $progs;
    my $ptr = $start;
    do {
        $progs .= $ptr->{val};
        $ptr = $ptr->{next};
    } until ( $start == $ptr );
    return $progs;
}
