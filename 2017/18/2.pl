#!/usr/bin/perl

use strict;
use warnings;

use threads;
use Thread::Queue;

my @mem;

while(<>) {
    chomp;

    my @inst = split ' ';
    push @mem, \@inst;
}

my $queue0 = Thread::Queue->new();
my $queue1 = Thread::Queue->new();

my $thr0 = threads->create(sub { run(0, $queue1, $queue0) });
my $thr1 = threads->create(sub { run(1, $queue0, $queue1) });
$thr0->join();
$thr1->join();

sub run {
    my ($id, $send, $recv) = @_;

    my %reg;
    $reg{'p'} = $id;

    my $ptr = 0;
    my $size = scalar @mem;

    my $send_count = 0;

    while ($ptr < $size) {

        my $inst = $mem[$ptr];
        my $i = $inst->[0];
        my $x = $inst->[1];
        my $y = $inst->[2] || 0;

        if ($i eq 'snd') {
            my $val = get_value($x, \%reg);
            $send->enqueue($val);
            $send_count += 1;
        }
        elsif ($i eq 'set') {
            $reg{$x} = get_value($y, \%reg);
        }
        elsif ($i eq 'add') {
            $reg{$x} = 0 if !exists $reg{$x};
            $reg{$x} += get_value($y, \%reg);
        }
        elsif ($i eq 'mul') {
            $reg{$x} = 0 if !exists $reg{$x};
            $reg{$x} *= get_value($y, \%reg);
        }
        elsif ($i eq 'mod') {
            $reg{$x} = 0 if !exists $reg{$x};
            $reg{$x} %= get_value($y, \%reg);
        }
        elsif ($i eq 'rcv') {
            if (defined(my $item = $recv->dequeue_timed(5))) {
                $reg{$x} = $item;
            }
            else {
                print $send_count, "\n" if $id == 1;
                return;
            }
        }
        elsif ($i eq 'jgz') {
            my $val = get_value($x, \%reg);
            if ($val > 0) {
                $ptr += get_value($y, \%reg);
                next;
            }
        }

        $ptr += 1;
    }
}

sub get_value {
    my ($v, $reg) = @_;

    if ($v =~ /(\d)+/) {
        return $v;
    }
    else {
        if (exists $reg->{$v}) {
            return $reg->{$v};
        }
        else {
            $reg->{$v} = 0;
            return 0;
        }
    }
}
