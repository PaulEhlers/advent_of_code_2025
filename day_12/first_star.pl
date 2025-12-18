#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @form_sizes = ();
while($input =~ /\d:\n(([\#\.]+\n?)+)/g) {
    my $form_size = scalar grep { $_ eq "#" } split //, $1;
    push(@form_sizes, $form_size);
}

my @grids = ();
foreach my $line (split /\n/, $input) {
    if($line =~ /(\d+)x(\d+): (.+)/) {
        push(@grids, {
            width => $1,
            length => $2,
            number_forms => [split /\s/, $3],
        });
    }
}

my $max_form_area = 3 * 3;

my $easily_possible = 0;
my $impossible = 0;
my $undetermined = 0;
foreach my $grid (@grids) {
    my $grid_area = $grid->{width} * $grid->{length};
    my $buffer_form_area = 0;
    my $minimal_area = 0;
    my $i = 0;
    foreach my $form_amount (@{$grid->{number_forms}}) {
        $buffer_form_area += $form_amount * $max_form_area;
        $minimal_area += $form_amount * $form_sizes[$i];
        $i++;
    }

    if($grid_area >= $buffer_form_area) {
        $easily_possible++;
    } elsif($grid_area < $minimal_area) {
        $impossible++;
    } else {
        $undetermined++;
    }
}

print "Easily possible: $easily_possible \n";
print "Impossible: $impossible \n";
print "Undetermined: $undetermined \n";