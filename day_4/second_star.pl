#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use integer;

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

my $super_total = 0;
my $total;
do {
    $total = 0;
    my @accessible_coords = ();
    for(my $x = 0; $x < scalar @$grid; $x++) {
        my $row = $grid->[$x];
        for(my $y = 0; $y < scalar @$row; $y++) {
            my $cell = $row->[$y];
            next unless $cell;
            if(accessible_toilet_paper($x, $y, $cell)) {
                $total++;
                push(@accessible_coords, [$x, $y]);
            }
        }
    }

    foreach my $coord (@accessible_coords) {
        $grid->[$coord->[0]]->[$coord->[1]] = 0;
    }

    $super_total += $total;
} while($total);

print $super_total, "\n";

sub accessible_toilet_paper {
    my ($x, $y, $cell) = @_;

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
