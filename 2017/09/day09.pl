#!/usr/bin/perl

use strict;
use warnings;

while (<>) {
    chomp;

    my $garbage = 0;

    my @chars = split '';

    my @stack;
    my $score = 0;
    my $level = 0;
    my $garbage_count = 0;

    my $i = 0;
    while ( $i < scalar @chars ) {

        my $curr = $chars[$i];

        if (!$garbage && $curr eq '<') {
            $garbage = 1;
        } elsif ($curr eq '>') {
            $garbage = 0;
        } elsif ($garbage && $curr eq '!') {
            $i++;
        } elsif (!$garbage && $curr eq '{') {
            push @stack, $curr;
            $level++;
        } elsif (!$garbage && $curr eq '}') {
            pop @stack;
            $score += $level;
            $level--;
        } elsif ($garbage) {
            $garbage_count++;
        }
        
        $i++;
    }

    print "Score: $score\nGarbage: $garbage_count\n";;
}
