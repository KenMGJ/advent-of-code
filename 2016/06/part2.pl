#!/usr/bin/perl

use strict;
use warnings;

my $lines = [];

my $messages = [];

while (<>) {
    chomp;
    my @line = split '';

    my $i = 0;
    for my $char (@line) {
        if (!defined $messages->[$i]) {
            $messages->[$i] = {};
        }
        if (!defined $messages->[$i]->{$char}) {
            $messages->[$i]->{$char} = 0;
        }

        $messages->[$i]->{$char} += 1;

        $i++;
    }
}

for my $message (@$messages) {
    my %mess = %$message;
    for my $letter (sort { $mess{$a} <=> $mess{$b} } keys %mess) {
        print $letter;
        last;
    }
}
print "\n";
