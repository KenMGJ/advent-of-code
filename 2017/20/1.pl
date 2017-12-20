#!/usr/bin/perl

use strict;
use warnings;

my @particles;

my $part_idx = 0;

my $slow;
my $slow_no;


while(<>) {
    chomp;

    if (/p=<(.*)>, v=<(.*)>, a=<(.*)>/) {
        my ($px, $py, $pz) = split ',', $1;
        my ($vx, $vy, $vz) = split ',', $2;
        my ($ax, $ay, $az) = split ',', $3;

        my $part = {
            px => $px,
            py => $py,
            pz => $pz,
            vx => $vx,
            vy => $vy,
            vz => $vz,
            ax => $ax,
            ay => $ay,
            az => $az,
        };

        push @particles, $part;

        my $acc = abs($ax) + abs($ay) + abs($az);
        if (!defined $slow || $acc < $slow) {
            $slow = $acc;
            $slow_no = $part_idx;
        }

        $part_idx += 1;
    }
}

print 'closest: ', $slow_no, "\n";

my $z = 0;

while (1) {

    my %positions;

    # Calculate velocity
    for my $part (@particles) {
        $part->{vx} = $part->{vx} + $part->{ax};
        $part->{vy} = $part->{vy} + $part->{ay};
        $part->{vz} = $part->{vz} + $part->{az};
        $part->{px} = $part->{px} + $part->{vx};
        $part->{py} = $part->{py} + $part->{vy};
        $part->{pz} = $part->{pz} + $part->{vz};
   
        my $pos = get_position_as_string($part);
        $part->{pos} = $pos;

        $positions{$pos} = 0 if !exists $positions{$pos};
        $positions{$pos} += 1;

    }

    my $cnt = scalar @particles;
    for my $i ( 1 .. $cnt ) {
        my $part = shift @particles;
        my $many = $positions{$part->{pos}};
        push (@particles, $part) if $many == 1;
    }

    $z += 1;
    last if $z == 200;
}

print 'particles: ', scalar @particles, "\n";

sub get_position_as_string {
    my $part = shift;

    return $part->{px} . ',' . $part->{py} . ',' . $part->{pz};
}
# use Data::Dumper;
# print Dumper \@particles;
