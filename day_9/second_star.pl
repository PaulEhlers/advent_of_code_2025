#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @points = map { [split /\,/, $_] } split /\n/, $input;
my @pairs_area_ordered = ();
for(my $i = 0; $i < scalar @points; $i++) {
	my @red_box_first_point = @{$points[$i]};
	for(my $j = $i+1; $j < scalar @points; $j++) {
		my @red_box_second_point = @{$points[$j]};

		my $area = (abs($red_box_first_point[0]-$red_box_second_point[0])+1)
					*(abs($red_box_first_point[1]-$red_box_second_point[1])+1);

		push(@pairs_area_ordered, {
			first => \@red_box_first_point,
			second => \@red_box_second_point,
			area => $area,
		});
	}
}

@pairs_area_ordered = sort { $b->{area} <=> $a->{area} } @pairs_area_ordered;
foreach my $pair (@pairs_area_ordered) {
	my @red_box_first_point = @{$pair->{first}};
	my @red_box_second_point = @{$pair->{second}};

	if(!red_box_intersect_perimeter(\@red_box_first_point, \@red_box_second_point)) {
		print $pair->{area}, "\n";
		last;
	}
} 


sub red_box_intersect_perimeter {
	my ($red_tile_a, $red_tile_b) = @_;

	for(my $i = 0; $i < scalar @points; $i++) {
		my @perimeter_line_start = @{$points[$i]};
		my @perimeter_line_to = @{$points[($i+1) % scalar @points]};

		if(intersects($red_tile_a, $red_tile_b, \@perimeter_line_start, \@perimeter_line_to)) {
			return 1;
		}
	}
	return 0;
}

sub intersects {
	my ($red_tile_a, $red_tile_b, $line_from, $line_to) = @_;

	my ($red_min_x, $red_max_x) = min_max($red_tile_a->[0], $red_tile_b->[0]);
	my ($red_min_y, $red_max_y) = min_max($red_tile_a->[1], $red_tile_b->[1]);

	my ($line_min_x, $line_max_x) = min_max($line_from->[0], $line_to->[0]);
	my ($line_min_y, $line_max_y) = min_max($line_from->[1], $line_to->[1]);

	return $line_max_x > $red_min_x && $red_max_x > $line_min_x && $line_max_y > $red_min_y && $red_max_y > $line_min_y;
}

sub min_max {
	my ($first, $second) = @_;
	if($first > $second) {
		return ($second, $first)
	} else {
		return ($first, $second);
	}
}
