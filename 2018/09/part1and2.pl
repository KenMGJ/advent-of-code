#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/ max /;

my $current_marble_number = -1;
my @players;

while (<>) {
    if (/(\d+) players; last marble is worth (\d+) points/) {
        print 'part 1: ';
        play_game($1, $2);
        print 'part 2: ';
        play_game($1, $2 * 100);
    }
}

sub play_game {
    my $number_of_players = shift;
    my $last_marble       = shift;

    @players = ( 1 .. $number_of_players );

    my %scoreboard;

    $current_marble_number = -1;

    # Keep track of this for reference
    my $first   = get_next_marble();

    # Setup the game
    my $current = $first;
    $current->{left}  = $first;
    $current->{right} = $first;

    my $next = $current;

    while ($next->{value} < $last_marble) {

        my $player = get_next_player();
        # print "[$player] ";

        $next     = get_next_marble();
        my $value = $next->{value}; 

        if ($value % 23 == 0) {
            $scoreboard{$player} = 0 if !exists $scoreboard{$player};
            $scoreboard{$player} += $value;

            for my $i ( 1 .. 7 ) {
                $current = $current->{left};
            }

            $scoreboard{$player} += $current->{value};
            my $left  = $current->{left};
            my $right = $current->{right};

            $left->{right} = $right;
            $right->{left} = $left;

            $current = $right;
        }
        else {

            my $left  = $current->{right};
            my $right = $left->{right};

            $next->{left}  = $left;
            $left->{right} = $next;
            $next->{right} = $right;
            $right->{left} = $next;

            $current = $next;
        }
    }

    my $max = max( values %scoreboard );
    print $max, "\n";
}

sub get_next_marble {
    return {
        left  => undef,
        right => undef,
        value => ++$current_marble_number,
    };
}

sub get_next_player {
    my $player  = shift @players;
    push @players, $player;
    return $player;
}

# sub print_state {
#    my $p = $first;
#    do {
#        print '(' if $p == $current;
#         print $p->{value};
#        #print ')' if $p == $current;
#        print ' ';
#        $p = $p->{right};
#    } until ($p == $first);
#    print "\n";
#
#    print "\nScores\n======\n";
#    for my $key (sort keys %scoreboard) {
#        print $key, ' ', $scoreboard{$key}, "\n";
#    }
#    print "\n";
#}
