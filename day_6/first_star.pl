#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;
$input =~ s/\n\s+/\n/g;
$input =~ s/\s+\n/\n/g;
$input =~ s/ +/ /g;
$input =~ s/^\s//g;

my @lines = ();
foreach my $line (split/\n/, $input) {
    push(@lines, [split /\s+/, $line]);
}

my $total = 0;
my @operations = @{$lines[-1]};
my $length = scalar @operations;
for my $i (0 .. $length - 1) {
    my $operation = $operations[$i];
    my $cur;
    if($operation eq "*") {
        $cur = 1;
    } else {
        $cur = 0;
    }
    for my $j (0 .. scalar @lines - 2) {
        my $number = $lines[$j]->[$i];
        if($operation eq "*") {
            $cur *= $number;
        } else {
            $cur += $number;
        }
    }
    $total += $cur;
}

print "$total \n";