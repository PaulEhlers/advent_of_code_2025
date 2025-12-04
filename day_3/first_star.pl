#!/usr/bin/env perl

use utf8;
use strict;
use warnings;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;
my $total = 0;
my @lines = split /\n/, $input;

foreach my $line (@lines) {
    my ($l_digit, $l_index) = get_highest_digit_range($line, 0, length($line) - 2);
    my ($r_digit, $r_index) = get_highest_digit_range($line, $l_index + 1, length($line) - 1);
    $total += $l_digit * 10 + $r_digit;
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

