#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @coords = ();
my @distances = ();

foreach my $line (split /\n/, $input) {
    my ($x, $y, $z) = split /\,/,$line;
    push(@coords, { x => $x, y => $y, z => $z });
}

for(my $i = 0; $i < scalar @coords; $i++) {
    my $first = $coords[$i];
    for(my $j = $i+1; $j < scalar @coords; $j++) {
        my $second = $coords[$j];

        push(@distances, {
            a => $i,
            b => $j,
            dis => distance($first, $second),
        });
    }
}

@distances = sort { $a->{dis} <=> $b->{dis} } @distances;

my $parent = {};
foreach my $i (0 .. scalar @coords - 1) { $parent->{$i} = $i; }

my $target_unions = scalar @coords-1;
my @last_union_xes = ();
for my $i (0 .. scalar @distances) {
    last unless $target_unions;
    my $cur_pair = $distances[$i];
    my $parent_a = find($cur_pair->{a});
    my $parent_b = find($cur_pair->{b});

    if($parent_a != $parent_b) {
        $parent->{$parent_b} = $parent_a;
        @last_union_xes = ($coords[$cur_pair->{a}]->{x}, $coords[$cur_pair->{b}]->{x});
        $target_unions--;
    }
}

print $last_union_xes[0] * $last_union_xes[1], "\n";

sub find {
    my $find = shift;
    if($find == $parent->{$find}) {
        return $find;
    }
    return find($parent->{$find})
}

sub distance {
    my ($from, $to) = @_;
    return sqrt(
        ($from->{x} - $to->{x}) ** 2
        + ($from->{y} - $to->{y}) ** 2
        + ($from->{z} - $to->{z}) ** 2
    );
}
