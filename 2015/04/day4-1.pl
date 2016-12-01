#!/usr/bin/perl

use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

my $i = 1;

while (1) {
    my $input = $ARGV[0] . $i;
    my $hash = md5_hex($input);

    if ($hash =~ /^00000/) {
        print $input, "\t", $hash, "\t", $i, "\n";
        last;
    }
    $i++;
}
