#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;

my $graph = {};
foreach my $line (split /\n/, $input) {
    $line =~ /([a-z]+): (.+)/;
    my $from = $1;
    my $to = [split /\s/, $2];
    $graph->{$from} = $to;
}

my $start = "svr";
my $end = "out";

my $total_paths = dfs($start, 2);
print "$total_paths \n";

my $memo = {};

sub dfs {
    my ($cur_node, $left_to_visit) = @_;

    if($cur_node eq $end)  {
        return $left_to_visit ? 0 : 1;
    }

    $left_to_visit-- if $cur_node eq "fft" || $cur_node eq "dac";

    my $memo_key = "$cur_node : $left_to_visit";
    return $memo->{$memo_key} if exists $memo->{$memo_key};

    my $sum = 0;
    foreach my $next_node(@{$graph->{$cur_node}}) {
        $sum += dfs($next_node, $left_to_visit);
    }
    $memo->{$memo_key} = $sum;
    return $sum;
}
