#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;
my ($fresh_text_raw, $available_test_raw) = split /\n\n/, $input;

my @ranges = ();
foreach my $fresh_range (split /\n/, $fresh_text_raw) {
    my ($from, $to) = split /\-/, $fresh_range;
    push(@ranges, ($from, $to));
}

my $total = 0;
foreach my $available_ingredient (split /\n/, $available_test_raw) {
    for(my $i = 0; $i < scalar @ranges; $i = $i+2) {
        my ($from, $to) = ($ranges[$i], $ranges[$i+1]);
        if(int($available_ingredient) >= $from
            && int($available_ingredient) <= $to) {
                $total++;
                last;
            }
    }
}

print $total, "\n";
