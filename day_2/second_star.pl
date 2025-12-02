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
        my $i = 1;
        while($i <= $length/2) {
            my $part = substr($cur,0,$i);
            if($cur =~ /^($part){2,}$/) {
                $total += $cur;
                last;
            }
            $i++;
        }
    }
}

print $total, "\n";


