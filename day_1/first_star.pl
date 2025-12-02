#!/usr/bin/env perl

use utf8;
use strict;
use warnings;

my $input = do { local $/; <STDIN> };
my $count_zeroes = 0;
my $start_dial = 50;

while ($input =~ /(L|R)(\d+)/g) {
    my ($dir, $val) = ($1, $2);
    my $is_minus = $dir eq "R" ? 1 : 0;
    $start_dial = $is_minus ? $start_dial - $val : $start_dial + $val;
    $start_dial = $start_dial % 100;

    $count_zeroes += 1 unless $start_dial;
}

print $count_zeroes, "\n";
