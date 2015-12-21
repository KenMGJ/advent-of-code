#!/usr/bin/perl

use strict;
use warnings;

use Algorithm::Combinatorics qw/combinations/;

my $weapons = {
    dagger => {
        cost   => 8,
        damage => 4,
        armor  => 0,
    },
    shortsword => {
        cost   => 10,
        damage => 5,
        armor  => 0,
    },
    warhammer  => {
        cost   => 25,
        damage => 6,
        armor  => 0,
    },
    longsword  => {
        cost   => 40,
        damage => 7,
        armor  => 0,
    },
    greataxe   => {
        cost   => 74,
        damage => 8,
        armor  => 0,
    },
};

#print "Weapons\n";
#for my $weapon (sort { $weapons->{$a}->{cost} <=> $weapons->{$b}->{cost} } keys %{$weapons}) {
#    print $weapon, ' Cost: ', $weapons->{$weapon}->{cost}, ' Damage: ', $weapons->{$weapon}->{damage}, ' Armor: ', $weapons->{$weapon}->{armor}, "\n";
#}

my $armor = {
    leather    => {
        cost   => 13,
        damage => 0,
        armor  => 1,
    },
    chainmail  => {
        cost   => 31,
        damage => 0,
        armor  => 2,
    },
    splintmail => {
        cost   => 53,
        damage => 0,
        armor  => 3,
    },
    bandedmail => {
        cost   => 75,
        damage => 0,
        armor  => 4,
    },
    platemail  => {
        cost   => 102,
        damage => 0,
        armor  => 5,
    },
};

#print "\nArmor\n";
#for my $arm (sort { $armor->{$a}->{cost} <=> $armor->{$b}->{cost} } keys %{$armor}) {
#    print $arm, ' Cost: ', $armor->{$arm}->{cost}, ' Damage: ', $armor->{$arm}->{damage}, ' Armor: ', $armor->{$arm}->{armor}, "\n";
#}

my $rings = {
    damage_1  => {
        cost   => 25,
        damage => 1,
        armor  => 0,
    },
    damage_2  => {
        cost   => 50,
        damage => 2,
        armor  => 0,
    },
    damage_3  => {
        cost   => 100,
        damage => 3,
        armor  => 0,
    },
    defense_1 => {
        cost   => 20,
        damage => 0,
        armor  => 1,
    },
    defense_2 => {
        cost   => 40,
        damage => 0,
        armor  => 2,
    },
    defense_3 => {
        cost   => 80,
        damage => 0,
        armor  => 3,
    },
};

#print "\nRings\n";
#for my $ring (sort { $rings->{$a}->{cost} <=> $rings->{$b}->{cost} } keys %{$rings}) {
#    print $ring, ' Cost: ', $rings->{$ring}->{cost}, ' Damage: ', $rings->{$ring}->{damage}, ' Armor: ', $rings->{$ring}->{armor}, "\n";
#}
#print "\n";

my $combinations = [];
for my $weapon (keys %{$weapons}) {

    my @arms = keys %{$armor};
    push @arms, 'none';
    for my $arm (@arms) {

        # Figure out rings here
        my @ring = keys %{$rings};
        push @ring, 'none', 'none';

        my $iter = combinations(\@ring, 2);
        while (my $c = $iter->next) {
            my $combo = {
                weapon => $weapon,
                arm  => $arm,
                ring1 => $c->[0],
                ring2 => $c->[1],
            };

            push @{$combinations}, $combo;
        }
    }
}

for my $combo (@{$combinations}) {
    my $cost = $weapons->{$combo->{weapon}}->{cost};
    $cost += $armor->{$combo->{arm}}->{cost} if defined $armor->{$combo->{arm}};
    $cost += $rings->{$combo->{ring1}}->{cost} if defined $rings->{$combo->{ring1}};
    $cost += $rings->{$combo->{ring2}}->{cost} if defined $rings->{$combo->{ring2}};
    $combo->{cost} = $cost;

    my $damage = $weapons->{$combo->{weapon}}->{damage};
    $damage += $armor->{$combo->{arm}}->{damage} if defined $armor->{$combo->{arm}};
    $damage += $rings->{$combo->{ring1}}->{damage} if defined $rings->{$combo->{ring1}};
    $damage += $rings->{$combo->{ring2}}->{damage} if defined $rings->{$combo->{ring2}};
    $combo->{damage} = $damage;

    my $arm = $weapons->{$combo->{weapon}}->{armor};
    $arm += $armor->{$combo->{arm}}->{armor} if defined $armor->{$combo->{arm}};
    $arm += $rings->{$combo->{ring1}}->{armor} if defined $rings->{$combo->{ring1}};
    $arm += $rings->{$combo->{ring2}}->{armor} if defined $rings->{$combo->{ring2}};
    $combo->{armor} = $arm;
}

my @combos = sort { $b->{cost} <=> $a->{cost} } @{$combinations};

#use Data::Dumper;
#print Dumper \@combos;
#exit;

for my $combo (@combos) {
    my $player = {
        name       => 'player',
        hit_points => 100,
        damage     => $combo->{damage},
        armor      => $combo->{armor},
    };

    my $boss = {
        name       => 'boss',
        hit_points => 104,
        damage     => 8,
        armor      => 1,
    };

    my $winner = battle($player, $boss);

    if ($winner->{name} eq 'boss') {
        print $combo->{cost}, "\n";
        last;
    }
}

sub battle {
    my $player = shift;
    my $boss   = shift;

    while ($player->{hit_points} > 0 && $boss->{hit_points} > 0) {
        deal_damage($player, $boss);
        last if $boss->{hit_points} <= 0;
        deal_damage($boss, $player);
    }

    return ($boss->{hit_points} <= 0) ? $player : $boss;
}

sub deal_damage {
    my $attacker = shift;
    my $defender = shift;

    my $damage = $attacker->{damage} - $defender->{armor};
    $damage = 1 if $damage < 1;

    $defender->{hit_points} -= $damage;
    # print 'The ', $attacker->{name}, " deals $damage damage; The ", $defender->{name}, ' goes down to ', $defender->{hit_points}, " hit points.\n";
}
