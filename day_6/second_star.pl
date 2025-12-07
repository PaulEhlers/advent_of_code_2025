#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my @lines_raw = split/\n/, $input;
my $operation_line = $lines_raw[-1];
my @start_indexes = ();
my @operations = ();
while ($operation_line =~ /(\*|\+)/g) {
    push(@start_indexes, $-[0]);
    push(@operations, $1);
}

my $longest_line = 0;
foreach my $line (@lines_raw) {
    my $len = length($line) - 1;
    if($len > $longest_line) {
        $longest_line = $len
    }
}
push(@start_indexes, $longest_line);

my @new_lines = ();
foreach my $line (@lines_raw) {
    my $len = length($line) - 1;
    my $diff = $longest_line - $len;
    $line = $line . (' ' x $diff);
    push(@new_lines, $line);
}
@lines_raw = @new_lines;

my $height = (scalar @lines_raw) - 1;
my @grid = map { [ split //, $_ ] } @lines_raw;
my $total = 0;
for(my $i = 0; $i < scalar @operations; $i++) {
    my $operation = $operations[$i];
    my $is_mult = $operation eq "*";
    my $index = $start_indexes[$i];
    my $next_index = $start_indexes[$i+1];
    my $is_last = $i == scalar @operations - 1;
    $is_last ? $next_index++ : $next_index--;

    my $cur = $is_mult ? 1 : 0;
    for(my $j = $index; $j < $next_index; $j++) {
        my $number = '';
        for(my $k = 0; $k < $height; $k++) {
            my $charAt = $grid[$k]->[$j];
            $number = $number . $charAt;
        }
        $cur = $is_mult ? $cur * $number : $cur + $number;
    }
    $total += $cur;
}

print "$total \n";