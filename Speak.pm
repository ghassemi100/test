package Speak;

use Exporter qw(import);	# Exporter has an array called EXPORT_OK. this line allows us to add to EXPORT_OK

@EXPORT_OK = qw(test greet);	#qw is subroutine. we are add a subroutine that can be used outside this module
#@EXPORT = qw(test);		# DO NOT USE this as it means in main.pl u can use 'use Speak' (causes conflict with other subroutines called test())
sub test{
	print "------- I am in package Speak.pm\n"
}

sub greet{
	print "------- I am greet in package Speak.pm\n"
}

1;		# this means return 1
