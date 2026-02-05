#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @points = map { [split /\,/, $_] } split /\n/, $input;
my $biggest_area = 0;
for(my $i = 0; $i < scalar @points; $i++) {
	my @point_a = @{$points[$i]};
	for(my $j = $i+1; $j < scalar @points; $j++) {
		my @point_b = @{$points[$j]};

		my $area = (abs($point_a[0]-$point_b[0])+1)*(abs($point_a[1]-$point_b[1])+1);
		if($area > $biggest_area) {
			$biggest_area = $area;
		}
	}
}


print $biggest_area, "\n";