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

my $target = 1000;
for my $i (0 .. $target - 1) {
    my $cur_pair = $distances[$i];
    my $parent_a = find($cur_pair->{a});
    my $parent_b = find($cur_pair->{b});

    if($parent_a != $parent_b) {
        $parent->{$parent_b} = $parent_a;
    }
}

my $parent_count = {};
foreach my $id (keys %$parent) {
    my $parent_cur = find($id);
    $parent_count->{$parent_cur}++;
}

my @sorted_values = sort { int($b) <=> int($a) } values %$parent_count;
print $sorted_values[0] * $sorted_values[1] * $sorted_values[2];

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

