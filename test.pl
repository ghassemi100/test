#!/usr/bin/perl

print "----- hello\n";

sub main{
	#my @fruits = ("XX", "YY", "ZZ");
	my @fruits = qw(XX YY ZZ);
	my %months = (
		"AA" => 1,
		"BB" => 2,
	);

	print $fruits[0]. "\n";
	print $months{"AA"} . "\n";

	my $fruits_ref = \@fruits;

	my $months_ref = \%months;
	print $fruits_ref->[0] . "\n";
	print $months_ref->{"AA"}. "\n";

	foreach my $fruit(@fruits) {
		print "1 - $fruit\n";
	}

	#foreach my $fruit(@$fruits_ref) { #--- have to cast ref to array
	foreach my $fruit(@{$fruits_ref}) { #--- have to cast ref to array
		print "2 - $fruit\n";
	}

	while (my ($key, $value) = each %months) {
		print "3 - $key - $value\n";
	}

	#while (my ($key, $value) = each %$months_ref) {
	while (my ($key, $value) = each %{$months_ref}) {
		print "4 - $key - $value\n";
	}

}

main();
