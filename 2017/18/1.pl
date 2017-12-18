#!/usr/bin/perl

use strict;
use warnings;

my @mem;
my %reg;
my $last_played = 0;

while(<>) {
    chomp;

    my @inst = split ' ';
    push @mem, \@inst;
}

my $ptr = 0;
my $size = scalar @mem;

while ($ptr < $size) {

    my $inst = $mem[$ptr];
    my $i = $inst->[0];
    my $x = $inst->[1];
    my $y = $inst->[2] || 0;

    # print $i, ' ', $x, ' ', $y, "\n";

    if ($i eq 'snd') {
        $last_played = get_value($x);
        # print "play $last_played\n";
    }
    elsif ($i eq 'set') {
        $reg{$x} = get_value($y);
    }
    elsif ($i eq 'add') {
        $reg{$x} = 0 if !exists $reg{$x};
        $reg{$x} += get_value($y);
    }
    elsif ($i eq 'mul') {
        $reg{$x} = 0 if !exists $reg{$x};
        $reg{$x} *= get_value($y);
    }
    elsif ($i eq 'mod') {
        $reg{$x} = 0 if !exists $reg{$x};
        $reg{$x} %= get_value($y);
    }
    elsif ($i eq 'rcv') {
        if ($last_played > 0) {
            print "$last_played\n";
            last;
        }
    }
    elsif ($i eq 'jgz') {
        my $val = get_value($x);
        if ($val > 0) {
            $ptr += $y;
            next;
        }
    }

    $ptr += 1;
}

sub get_value {
    my $v = shift;

    if ($v =~ /(\d)+/) {
        return $v;
    }
    else {
        if (exists $reg{$v}) {
            return $reg{$v};
        }
        else {
            $reg{$v} = 0;
            return 0;
        }
    }
}
