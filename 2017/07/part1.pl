#!/usr/bin/perl

use strict;
use warnings;

use JSON::XS;

use HTTP::Request;
use LWP::UserAgent;

my @statements;
push @statements, "MATCH (n) DETACH DELETE n;";

my @relationships;

while (<>) {
    chomp;

    my @map = split ' -> ';

    if ($map[0] =~ /^(.*) \((\d+)\)/) {
        push @statements, "\"CREATE (n:Program { name: '$1', weight: $2 })\",";

        if ($#map == 1) {
            my @holding = split ', ', $map[1];

            for my $hold (@holding) {
                push @relationships, "\"MATCH (a:Program), (b:Program) WHERE a.name = '$1' AND b.name = '$hold' CREATE (a)-[r:HOLDS]->(b)\",";
            }
        }
    }
}

push @statements, @relationships; # , 'MATCH (a) WHERE NOT ()-[:HOLDING]->(a) RETURN a.name;';
print join("\n", @statements), "\n";
