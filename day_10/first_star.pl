#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;
my @lines = split /\n/, $input;

my @machines = ();

foreach my $line (@lines) {
    $line =~ /\[([\.\#]+)\]/;
    my $machine = {
        indicator_lights => [map { $_ eq "#" ? 1 : 0 } split //, $1],
        buttons => [],
    };
    while($line =~ /\(([\d\,]+)\)/g) {
        push(@{$machine->{buttons}}, [split /\,/, $1])
    }

    $line =~ /\{([\d\,]+)\}/;
    $machine->{joltages} = [split /\,/, $1];

    push(@machines, $machine);
}

my $total = 0;
foreach my $machine (@machines) {

    my @indicator_lights = @{$machine->{indicator_lights}};
    my @current_lights = map { 0 } @indicator_lights;
    my @buttons = @{$machine->{buttons}};

    my @queue = ();
    push(@queue, {
        current_lights => [map { 0 } @indicator_lights],
        depth => 0,
    });

    my $fewest_presses = -1;
    while(scalar @queue) {
        my $cur = shift @queue;
        foreach my $button (@buttons) {
            my $new_comb = {
                current_lights => [map { $_ } @{$cur->{current_lights}}],
                depth => $cur->{depth} + 1
            };
            my $current_lights = $new_comb->{current_lights};
            foreach my $button_presses (@{$button}) {
                $current_lights->[$button_presses] = ($current_lights->[$button_presses] + 1) % 2;
            }
            if(equal_array($current_lights, \@indicator_lights)) {
                $fewest_presses = $new_comb->{depth};
                goto EXIT;
            }
            push(@queue, $new_comb);
        }
    }
    EXIT:
    $total += $fewest_presses;
}
print "$total \n";


sub equal_array {
    my ($a, $b) = @_;
    for(my $i = 0; $i < scalar @$a; $i++) {
        unless(int(@$a[$i]) == int(@$b[$i])) {
            return 0;
        }
    }
    return 1;
}

