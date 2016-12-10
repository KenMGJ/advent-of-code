#!/usr/bin/perl

use strict;
use warnings;

my $DEBUG = 0;

my $steps = [];
my $instructions = {};

while (<>) {
    chomp;

    if ( /value (\d+) goes to bot (\d+)/ ) {
        push @{$steps},  { bot => $2, value => int($1) };
    }
    elsif ( /bot (\d+) gives low to (\w+) (\d+) and high to (\w+) (\d+)/ ) {
        $instructions->{$1} = {
            low => { destination => $2, number => $3 },
            high => { destination => $4, number => $5 },
        };
    }
}

my $bot_state = {};
my $output_state = {};

for my $step (@$steps) {
    give_to_bot($step->{bot}, $step->{value});
}

my $product = $output_state->{0} * $output_state->{1} * $output_state->{2};
print $product, "\n";

sub give {
    my $instr = shift;
    my $value = shift;

    print 'give ', $instr->{'destination'}, ' ', $instr->{'number'}, ' value ', $value, "\n" if $DEBUG;

    if ($instr->{'destination'} eq 'bot') {
        give_to_bot($instr->{'number'}, $value);
    }
    else {
        give_to_output($instr->{'number'}, $value);
    }
}

sub give_to_output {
    my $output = shift;
    my $value = shift;

    print 'output ', $output, ' received value ', $value, "\n" if $DEBUG;

    if (!defined $output_state->{$output}) {
        $output_state->{$output} = $value;
    }
}

sub give_to_bot {
    my $bot = shift;
    my $value = shift;

    print 'bot ', $bot, ' received value ', $value, "\n" if $DEBUG;

    if (!defined $bot_state->{$bot}) {
        $bot_state->{$bot} = $value;
    }
    else {
        my ($low, $high);

        if ($value < $bot_state->{$bot}) {
            $low = $value;
            $high = $bot_state->{$bot};
        }
        else {
            $low = $bot_state->{$bot};
            $high = $value;
        }

        print 'bot ', $bot, ' compares ', $low, ' and ', $high, "\n"
            if ($DEBUG || ($low == 17 && $high == 61));

        give($instructions->{$bot}->{'low'}, $low);
        give($instructions->{$bot}->{'high'}, $high);

        delete $bot_state->{$bot};
    }
}
