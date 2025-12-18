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

my $start = "you";
my $end = "out";

my $total_paths = 0;
dfs($start);
print "$total_paths \n";

sub dfs {
    my ($cur_node) = @_;
    my $next_nodes = $graph->{$cur_node};

    if($next_nodes->[0] eq $end)  {
        $total_paths++;
        return;
    }

    foreach my $next_node(@$next_nodes) {
        dfs($next_node);
    }
}

