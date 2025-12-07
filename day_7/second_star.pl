#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @grid = map { [split //, $_] } split /\n/, $input;

$input =~ /S/;
my $start_pos = $-[0];

my $height = scalar @grid;
my $already_hit = {};
my $total = 1;
my $beams = { $start_pos => 1 };
for(my $y = 1; $y < scalar @grid - 1; $y++) {
    my $next = {};
    foreach my $beam_pos (keys %$beams) {
        my $count = $beams->{$beam_pos};
        my $peek = $grid[$y+1]->[$beam_pos];
         if($peek eq "^") {
            $total += $count;
            $next->{$beam_pos-1} += $count;
            $next->{$beam_pos+1} += $count;
         } elsif($peek eq ".") {
            $next->{$beam_pos} += $count;
         }
    }
    $beams = $next;
}

print "$total \n";