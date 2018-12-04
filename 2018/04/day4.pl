#!/usr/bin/perl

use strict;
use warnings;

my @schedule;

while (<>) {
    chomp;

    # [1518-11-01 00:00] Guard #10 begins shift
    # [1518-11-01 00:05] falls asleep
    # [1518-11-01 00:25] wakes up

    if (/^\[(.*)\] Guard #(\d+) begins shift$/) {
        my $time = $1;
        my $guard = $2;
        $time =~ s/[-:\s]//g;
        push @schedule, "$time\tB\t$guard";
    }
    elsif (/^\[(.*)\] falls asleep$/) {
        my $time = $1;
        $time =~ s/[-:\s]//g;
        push @schedule, "$time\tA";
    }
    elsif (/^\[(.*)\] wakes up$/) {
        my $time = $1;
        $time =~ s/[-:\s]//g;
        push @schedule, "$time\tU";
    }
}

my $current_guard;
my $start_time;

my %sleep_map;

my @sorted_schedule = sort @schedule;
for my $entry (@sorted_schedule)  {

    my @e = split "\t", $entry;
    if ($e[1] eq 'B') {
        $current_guard = $e[2];
    }
    elsif ($e[1] eq 'A') {
        if ($e[0] =~ /^\d{8}(\d{4})$/) {
            $start_time = $1;
        }
    }
    elsif ($e[1] eq 'U') {
        if ($e[0] =~ /^\d{8}(\d{4})$/) {
            $sleep_map{$current_guard} = [] if !defined $sleep_map{$current_guard};
            for my $i ($start_time .. $1 - 1) {
                $sleep_map{$current_guard}->[$i]++;
            }
        }
    }
}

my $sleepy_guard;
my $sleep_minutes = -1;
for my $guard (keys %sleep_map) {
    my $sleep = 0;
    for my $i (0 .. 59) {
        $sleep += $sleep_map{$guard}->[$i] if defined $sleep_map{$guard}->[$i];
    }
    if ($sleep > $sleep_minutes) {
        $sleepy_guard = $guard;
        $sleep_minutes = $sleep;
    }
}

my $max_minute;
my $max_value = -1;
for my $i (0 .. 59) {
    if (defined $sleep_map{$sleepy_guard}->[$i]) {
        if ($sleep_map{$sleepy_guard}->[$i] > $max_value) {
            $max_value = $sleep_map{$sleepy_guard}->[$i];
            $max_minute = $i;
        }
    }
}

print $sleepy_guard * $max_minute, "\n";

my $minute_guard;
my $minute;
my $minute_value = -1;
for my $i (0 .. 59) {

    my $guard;
    my $value = -1;

    for my $g (keys %sleep_map) {
        if (defined $sleep_map{$g}->[$i]) {
            if ($sleep_map{$g}->[$i] > $value) {
                $value = $sleep_map{$g}->[$i] if $sleep_map{$g}->[$i] > $value;
                $guard = $g;
            }
        }
    }

    if ($value > $minute_value) {
        $minute_value = $value;
        $minute_guard = $guard;
        $minute = $i;
    }
}

print $minute_guard * $minute, "\n";
