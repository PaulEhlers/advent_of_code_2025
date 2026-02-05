#!/usr/bin/env perl

use utf8;
use strict;
use warnings;
use Data::Dumper;
use Math::LP qw(:types);
use Math::LP::Constraint qw(:types);

my $input = do { local $/; <STDIN> };
$input =~ s/\r//g;
my @lines = split /\n/, $input;

my @machines = ();
foreach my $line (@lines) {
    $line =~ /\[([\.\#]+)\]/;
    my $machine = {
        indicator_lights => [map { $_ eq "#" ? 1 : 0 } split //, $1],
        buttons => [],
    };
    while($line =~ /\(([\d\,]+)\)/g) {
        push(@{$machine->{buttons}}, [split /\,/, $1])
    }

    $line =~ /\{([\d\,]+)\}/;
    $machine->{joltages} = [split /\,/, $1];

    push(@machines, $machine);
}

my $total = 0;
foreach my $machine (@machines) {

    my @joltages = @{$machine->{joltages}};
    my @buttons = @{$machine->{buttons}};

    my $lp = new Math::LP;

    # Create var for each button
    my @vars = ();
    for my $i (0 .. (scalar @buttons) - 1) {
        my $var = new Math::LP::Variable(name => "x$i", is_int => 1);
        push(@vars, $var);
        $lp->add_variable($vars[$i]);
    }

    # This part basically creates the linear equations e.g. 
    #[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}
    #        a    b    c     d    e     f
    # e + f = 3
    # b + f = 5
    # c + d + e = 4
    # a + b + d = 7 
    my $num_counters = scalar @joltages;
    for my $i (0 .. (scalar @joltages)-1) {
        my @lhs_coeffs;
        for my $j (0 .. (scalar @{$machine->{buttons}}) - 1) {
            my @button_presses = @{$machine->{buttons}->[$j]};
            foreach my $button_press (@button_presses) {
                if($button_press == $i) {
                    push(@lhs_coeffs, ($vars[$j], 1));
                    last;
                }
            }
        }

        my $constr = new Math::LP::Constraint(
            lhs  => make Math::LP::LinearCombination(@lhs_coeffs),
            rhs  => $joltages[$i],
            type => $EQ,
        );
        $lp->add_constraint($constr);
    }

    # This defines that the summ of all buttons should be minimal. Based on the example from above:
    # a + b + c + d + e + f = sum pressed => minimal
    my @coeffs;
    for my $var (@vars) {
        push(@coeffs, ($var, 1.0));
    }
    my $obj_fn = make Math::LP::LinearCombination(@coeffs);
    $lp->minimize_for($obj_fn);

    $lp->solve();

    $total+= $lp->optimum();
}

print "$total \n";
