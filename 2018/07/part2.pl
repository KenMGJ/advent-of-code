#!/usr/bin/perl

use strict;
use warnings;

use Const::Fast;

const my $BASE_TIME => 60;
const my $ELF_COUNT => 5;

my @elves;
for my $elf ( 1 .. $ELF_COUNT ) {
    push @elves, 0;
}

my %queue;
my %completed;
my %running;

while (<>) {
    if (/Step (.) must be finished before step (.) can begin./) {
        $queue{$1}       = [] if !exists $queue{$1};
        $queue{$2}       = [] if !exists $queue{$2};
        push @{$queue{$2}}, $1;
    }
}

my $time = 0;

while (scalar keys %queue || scalar keys %running) {
    for my $i ( 0 .. $#elves ) {
        if ($elves[$i]) {
            $running{$elves[$i]}--;

            if ($running{$elves[$i]} == 0) {
                delete $running{$elves[$i]};
                complete_step($elves[$i]);
                $elves[$i] = 0;
            }
        }
    }
    for my $i ( 0 .. $#elves ) {
        if (!$elves[$i]) {
            my $next = get_next();
            if ($next) {
                $elves[$i] = $next;
                $running{$next} = get_run_time($next);
            }
        }
    }

    $time++;
}

print $time - 1, "\n";

sub get_next {
    my @sorted_steps = sort keys %queue;

    my $next = 0;
    for my $step (@sorted_steps) {
        my @deps = @{$queue{$step}};
        if (!scalar @deps || all_deps_are_completed(\@deps)) {
            $next = $step;
            last; 
        }
    }

    remove_from_queue($next) if $next;
    return $next;
}

sub remove_from_queue {
    my $step = shift;
    delete $queue{$step};
}

sub complete_step {
    my $step = shift;
    $completed{$step} = 1;
}

sub all_deps_are_completed {
    my $deps = shift;

    my $all = 1;
    for my $dep (@{$deps}) {
        $all = 0 if !exists $completed{$dep};
    }
    return $all;
}

sub get_run_time {
    my $step = shift;
    return $BASE_TIME + (ord $step) - 64;
}
