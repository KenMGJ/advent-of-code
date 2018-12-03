#!/usr/bin/perl

use strict;
use warnings;

my $file_name  = $ARGV[0];
my $start_line = $ARGV[1] || 0;
my $end_line   = $ARGV[2] || 1_000_000;

my $i = 10;

print "$i open 8,8,8,\"\@0:input,w,s\"\n" if $start_line <= $i;
$i += 10;

open (my $file, '<', $file_name) or die "Cannot open file: $!";

while (<$file>) {
    chomp;

    print "$i print#8,\"$_\"\n" if $start_line <= $i && $i <= $end_line;
    $i += 10;
}

print "$i close 8\n" if $i <= $end_line;

close($file) || warn "close failed: $!";
