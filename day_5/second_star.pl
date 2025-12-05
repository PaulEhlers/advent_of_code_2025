#!/usr/bin/env perl

use utf8;
use strict;
use warnings;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my ($fresh_text_raw, $available_test_raw) = split /\n\n/, $input;

my @ranges = ();
foreach my $fresh_range (split /\n/, $fresh_text_raw) {
    my ($from, $to) = split /\-/, $fresh_range;
    push(@ranges, [ $from, $to ]);
}
@ranges = sort { $a->[0] <=> $b->[0] } @ranges;

my @merged = ();
push(@merged, $ranges[0]);

for(my $i = 1; $i < scalar @ranges; $i++) {
    my $last = $merged[-1];
    my $current = $ranges[$i];

    my $from = $last->[0];
    my $to = $last->[1];

    my $next_from = $current->[0];
    my $next_to = $current->[1];

    if($next_from <= $to) {
        my $new_from = $next_from > $from ? $from : $next_from;
        my $new_to = $to > $next_to ? $to : $next_to;
        $last->[0] = $new_from;
        $last->[1] = $new_to;
    } else {
        push(@merged, $current);
    }
}

my $total = 0;
foreach my $elem (@merged) {
    $total += $elem->[1] - $elem->[0] + 1;
}

print $total, "\n";

