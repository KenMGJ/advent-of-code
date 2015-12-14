#!/usr/bin/perl

use strict;
use warnings;

my $SECONDS = 2503;

my $deer_info = {};

while (<>) {
    chomp;

    if ($_ =~ /^(.+) can fly (\d+) .* for (\d+) seconds, but then must rest for (\d+) seconds.$/) {
        $deer_info->{$1} = {
            fly => {
                speed    => int $2,
                duration => int $3,
            },
            rest => int $4,
        };
    }
}

my $leaderboard = {};
for my $deer (keys %{$deer_info}) {
    $leaderboard->{$deer} = 0;
}

for my $i (1..$SECONDS) {
    my $results = {};
    for my $deer (keys %{$deer_info}) {
        $results->{$deer} = calc_flight($deer, $i);
    }
    my $lead = calc_lead($results);

    for my $deer (keys %{$lead}) {
        $leaderboard->{$deer} += 1;
    }
}

use Data::Dumper;
print Dumper $leaderboard;

sub calc_flight {
    my $deer = shift;
    my $duration = shift;

    my $i = 0;

    my $distance = 0;
    my $resting = 0;

    while ($i < $duration) {
        for my $j (0 .. ($deer_info->{$deer}->{fly}->{duration} - 1)) {
            $resting = 0;
            $distance += $deer_info->{$deer}->{fly}->{speed};
            $i++;
            last if $i == $duration;
        }
        last if $i == $duration;
        for my $j (0 .. ($deer_info->{$deer}->{rest} - 1)) {
            $resting = 1;
            $i++;
            last if $i == $duration;
        }
    }

    return {
        distance => $distance,
        resting  => $resting,
    };
}

sub calc_lead {
    my $distances = shift;

    my $max_distance = 0;

    for my $deer (keys %{$distances}) {
        my $distance = $distances->{$deer}->{distance};
        $max_distance = $distance if $distance > $max_distance;
    }

    my $results = {};

    for my $deer (keys %{$distances}) {
        if ($distances->{$deer}->{distance} == $max_distance) {
            $results->{$deer} = $max_distance;
        }
    }

    return $results;
}
