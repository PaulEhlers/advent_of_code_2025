#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
my @number_pairs =  split /\,/, $input;
my $total = 0;
foreach my $pair (@number_pairs) {
    my ($from, $to) = split /\-/, $pair;
    for my $cur ($from .. $to) {
        my $length = length $cur;
        if($length % 2) {
            next;
        }

        my $half_1 = substr($cur,0, $length/2);
        my $half_2 = substr($cur, $length/2);
        if($half_1 eq $half_2) {
            $total += $cur;
        }
    }
}

print $total, "\n";


