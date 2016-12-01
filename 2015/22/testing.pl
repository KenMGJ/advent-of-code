#!/usr/bin/perl

use strict;
use warnings;

my $DEBUG = 1;

my $spells = {
    magic_missile => 53,
    drain         => 73,
    shield        => 113,
    poison        => 173,
    recharge      => 229,
};

#use Data::Dumper;
#print Dumper $spells;

my $timers = {
    shield   => 0,
    poison   => 0,
    recharge => 0,
};

my $i = 0;

my $total_mana;
my $min_mana = 1104;

my $player = {
    name       => 'Player',
    # hit_points => 50,
    hit_points => 10,
    # mana       => 500,
    mana       => 250,
    armor      => 0,
};

my $boss = {
    name       => 'Boss',
    #hit_points => 51,
    #damage     => 9,
    hit_points => 14,
    damage     => 8,
};

$total_mana = 0;
my $winner = battle($player, $boss);

if ($winner == $player) {
    print "$i Player won!\n" if $DEBUG;
    $min_mana = $total_mana if $total_mana < $min_mana;
}

print $min_mana, "\n";

sub battle {
    my $player = shift;
    my $boss  = shift;

    my $return;

    while ($player->{hit_points} > 0 && $boss->{hit_points} > 0) {
        $return = player_turn($player, $boss);
        last if $return == -1;
        last if ($player->{hit_points} <= 0 || $boss->{hit_points} <= 0);
        boss_turn($player, $boss);
    }

    return ($return == -1 || $player->{hit_points} <= 0) ? $boss : $player;
}

sub player_turn {
    my $player = shift;
    my $boss   = shift;

    print "-- Player turn --\n" if $DEBUG;
    print_status($player, $boss);

    apply_effects($player, $boss);

    my @list_of_spells = sort keys %{$spells};

    my $i = 0;
    for my $s (@list_of_spells) {
        print "$i $s ";
        $i++;
    }
    print "\n";
    my $cast = get_random(scalar @list_of_spells);

    while ($cast >= 0 && ($timers->{$list_of_spells[$cast]} || $spells->{$list_of_spells[$cast]} > $player->{mana})) {
        print 'Not enough mana to cast: ', $list_of_spells[$cast], "\n" if $DEBUG;
        splice @list_of_spells, $cast, 1;
        my $size = scalar @list_of_spells;
        $cast = ($size == 0) ? -1 : get_random($size);
    }

    return -1 if $cast < 0;

    my $spell = $list_of_spells[$cast];
    $player->{mana} -= $spells->{$spell};

    $total_mana += $spells->{$spell};
    return -1 if $total_mana > $min_mana; # short circuit long running

    if ($spell eq 'magic_missile') {
        $boss->{hit_points} -= 4;
        print 'Player casts Magic Missile; Dealing 4 damage. Boss has ', $boss->{hit_points}, " hit points.\n" if $DEBUG;
    }
    elsif ($spell eq 'drain') {
        $boss->{hit_points} -= 2;
        $player->{hit_points} += 2;
        print 'Player casts Drain, dealing 2 damage, and healing 2 hit points. Player has ', $player->{hit_points}, ' hit points. Boss has ',
            $boss->{hit_points}, " hit points.\n" if $DEBUG;
    }
    elsif ($spell eq 'shield') {
        $player->{armor} += 7;
        $timers->{shield} = 6;
        print 'Player casts Shield; increasing armor by 7. Player has ', $player->{armor}, " armor.\n" if $DEBUG;
    }
    elsif ($spell eq 'poison') {
        $timers->{poison} = 6;
        print "Player casts Poison\n" if $DEBUG;
    }
    elsif ($spell eq 'recharge') {
        $timers->{recharge} = 5;
        print "Player casts Recharge\n" if $DEBUG;
    }

    return 0;
}

sub get_random {
    my $val = shift;
    #return int(rand($val));

    $val = <STDIN>;
    chomp $val;
    return $val;
}

sub print_status {
    my $player = shift;
    my $boss   = shift;

    print 'Player has ', $player->{hit_points}, ' hit points, ', $player->{armor}, ' armor, ', $player->{mana}, " mana\n" if $DEBUG;
    print 'Boss has ', $boss->{hit_points}, " hit points\n" if $DEBUG;
}

sub apply_effects {
    my $player = shift;
    my $boss = shift;

    if ($timers->{shield} > 0) {
        $timers->{shield}--;
        print "Shield's timer is now ", $timers->{shield}, "\n" if $DEBUG;
        if ($timers->{shield} == 0) {
            $player->{armor} -= 7;
            print 'Shield wears off, decreasing armor by 7. (Armor: ', $player->{armor}, ")\n" if $DEBUG;
        }
    }

    if ($timers->{recharge} > 0) {
        $timers->{recharge}--;
        $player->{mana} += 101;
        print 'Recharge provides 101 mana; its timer is now ', $timers->{recharge}, '. (Mana: ', $player->{mana}, ")\n" if $DEBUG;
        print "Recharge wears off.\n" if $timers->{recharge} == 0 && $DEBUG;
    }

    if ($timers->{poison} > 0) {
        $timers->{poison}--;
        $boss->{hit_points} -= 3;
        print 'Poison deals 3 damage; its timer is now ', $timers->{poison}, ".\n" if $DEBUG;
        print "Poison wears off.\n" if $timers->{poison} == 0 && $DEBUG;
    }
}

sub boss_turn {
    my $player = shift;
    my $boss   = shift;

    print "-- Boss turn --\n" if $DEBUG;
    print_status($player, $boss);

    apply_effects($player, $boss);

    if ($boss->{hit_points} <= 0) {
        print "This kills the Boss\n" if $boss->{hit_points} <= 0;
        return;
    }

    my $damage = $boss->{damage} - $player->{armor};
    $damage = 1 if $damage < 1;

    $player->{hit_points} -= $damage;
    print "Boss attacks $damage damage; Player has ", $player->{hit_points}, " hit points.\n" if $DEBUG;
}
