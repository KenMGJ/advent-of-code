#!/usr/bin/perl

use strict;
use warnings;

use Const::Fast;
my %next_dir;
$next_dir{D} = [ 'L', 'R' ];
$next_dir{L} = [ 'U', 'D' ];
$next_dir{U} = [ 'R', 'L' ];
$next_dir{R} = [ 'D', 'U' ];

my @grid;

while(<>) {
    chomp;

    my @row = split '';
    push @grid, \@row;
}

my $x = 0;
my $y = 0;

$y++ until ( $grid[$x][$y] eq '|' );

my $final_path = '';

go($x, $y, 'D', '');

print $final_path. "\n";

sub go {
    my ($x, $y, $d, $path) = @_;

    my $curr = $grid[$x][$y];
    return if $curr eq ' ';

    my @dirs;
    if ( $curr eq '+' ) {
        push @dirs, @{$next_dir{$d}};
    }
    else {
        push @dirs, $d;
    }

    if ( $curr =~ /[A-Z]/) {
        $path .= $curr;
        $final_path = $path if length($path) > length($final_path);
    }

    for my $dir (@dirs) {
        my $next = get_next($x, $y, $dir);
        next if !defined $next->{v} || $next->{v} eq ' ';

        go($next->{x}, $next->{y}, $dir, $path);
    }

}

sub get_next {
    my ($x, $y, $d) = @_;


    if ($d eq 'D') {
        $x++;
    } elsif ($d eq 'L') {
        $y--;
    } elsif ($d eq 'U') {
        $x--;
    } elsif ($d eq 'R') {
        $y++;
    }

    return {
        x => $x,
        y => $y,
        v => $grid[$x][$y],
    };
}
