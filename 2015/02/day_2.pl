#!/usr/bin/perl

use strict;
use warnings;

my $total_wrapping_paper_needed = 0;
my $total_ribbon_needed = 0;

while (<>) {
	chomp;
	my @line = split 'x';

	# Wrapping Paper
	my $area1 = $line[0] * $line[1];
	my $area2 = $line[1] * $line[2];
	my $area3 = $line[2] * $line[0];

	my $min = $area1;
	$min = $area2 if $area2 < $min;
	$min = $area3 if $area3 < $min;

	my $wrapping_paper_needed = (2 * $area1) + (2 * $area2) + (2 * $area3) + $min;
	$total_wrapping_paper_needed += $wrapping_paper_needed;

	# Ribbon
	my @sorted = sort { $a <=> $b } @line;

	my $ribbon_needed = ($line[0] * $line[1] * $line[2]) + ($sorted[0] + $sorted[0] + $sorted[1] + $sorted[1]);
	$total_ribbon_needed += $ribbon_needed;
}

print "Total Wrapping Papper Needed:\t$total_wrapping_paper_needed\nTotal Ribbon Needed:\t$total_ribbon_needed\n";
