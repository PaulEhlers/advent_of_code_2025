#!/usr/bin/env perl

use utf8;
use strict;
use warnings;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;
my $total = 0;
my @lines = split /\n/, $input;

foreach my $line (@lines) {
    my $number = 0;
    my $l_bound = 0;
    for(my $i = 11; $i >= 0; $i--) {
        my ($l_digit, $l_index) = get_highest_digit_range($line, $l_bound, length($line) - $i - 1);
        $l_bound = $l_index + 1;
        $number += $l_digit * 10 ** $i;
    }

    $total += $number;
}

print $total, "\n";

sub get_highest_digit_range {
    my ($str, $from, $to) = @_;

    my $highest_digit = 0;
    my $highest_digit_index;
    for my $i ($from .. $to) {;
        my $cur_digit = int(substr($str,$i,1));
        if($cur_digit > $highest_digit) {
            $highest_digit = $cur_digit;
            $highest_digit_index = $i;
        }
    }

    return ($highest_digit, $highest_digit_index);
}

