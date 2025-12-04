#!/usr/bin/env perl

use utf8;
use strict;
use warnings;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my $grid = [];
foreach my $line (split /\n/, $input) {
    my @row = ();
    foreach my $cell (split //, $line) {
        if($cell eq "@") {
            push(@row, 1);
        } else {
            push(@row, 0);
        }
    }
    push(@$grid, \@row);
}

my $total = 0;
for(my $x = 0; $x < scalar @$grid; $x++) {
    my $row = $grid->[$x];
    for(my $y = 0; $y < scalar @$row; $y++) {
        $total++ if accessible_toilet_paper($x, $y);
    }
}

print $total;

sub accessible_toilet_paper {
    my ($x, $y) = @_;
    my $cell = $grid->[$x]->[$y];
    return 0 unless $cell;

    my $x_max = scalar @$grid;
    my $y_max = scalar @{$grid->[0]};
    my $count = 0;
    foreach my $x_off (-1 .. 1) {
        foreach my $y_off (-1 .. 1) {
            if(!$x_off && !$y_off) {
                next;
            }
            my $cur_x = $x + $x_off;
            my $cur_y = $y + $y_off;
            if($cur_x < 0 || $cur_y < 0) {
                next;
            }
            if($cur_x >= $x_max || $cur_y >= $y_max) {
                next;
            }
            $cell = $grid->[$x + $x_off]->[$y + $y_off];
            $count++ if $cell;
        }
    }

    return $count < 4 ? 1 : 0;
}