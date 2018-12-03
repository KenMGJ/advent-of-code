#!/usr/bin/perl

use strict;
use warnings;

my $file_name     = $ARGV[0];
my $c64_file_name = $ARGV[1] || 'input';
my $start_line    = $ARGV[2] || 0;
my $end_line      = $ARGV[3] || 1_000_000;

my $i = 10;

# print "$i open 8,8,8,\"\@0:$c64_file_name,w,s\"\n" if $start_line <= $i;
print "open 8,8,8,\"\@0:$c64_file_name,w,s\"\n" if $start_line <= $i;
$i += 10;

open (my $file, '<', $file_name) or die "Cannot open file: $!";

while (<$file>) {
    chomp;

    # print "$i print#8,\"$_\"\n" if $start_line <= $i && $i <= $end_line;
    print "print#8,\"$_\"\n" if $start_line <= $i && $i <= $end_line;
    $i += 10;
}

# print "$i close 8\n" if $i <= $end_line;
print "close 8\n" if $i <= $end_line;

close($file) || warn "close failed: $!";
