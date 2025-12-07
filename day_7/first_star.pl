#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @grid = map { [split //, $_] } split /\n/, $input;
my $start_pos = 0;
if($input =~ /S/) {
    $start_pos = $-[0];
}
my $height = scalar @grid;
my $already_hit = {};
my $total = 0;

follow_beam($start_pos, 0);
print "$total \n";

sub follow_beam {
    my ($x, $y) = @_;
    my $curChar = $grid[$y]->[$x];

    while($curChar ne "^") {
        $y++;
        return if $y >= $height;
        $curChar = $grid[$y]->[$x];
    }
    unless($already_hit->{"$x $y"}) {
        $total++;
        $already_hit->{"$x $y"} = 1;
        follow_beam($x-1, $y);
        follow_beam($x+1, $y);
    }
}
