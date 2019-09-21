package Person;

use Exporter qw(import);	# Exporter has an array called EXPORT_OK. this line allows us to add to EXPORT_OK

#@EXPORT_OK = qw(new greet);	#qw is subroutine. we are add a subroutine that can be used outside this module
#@EXPORT = qw(test);		# DO NOT USE this as it means in main.pl u can use 'use Speak' (causes conflict with other subroutines called test())

sub new{	#arguments for subroutines are in '@_' array
	my $class = shift;	# this must be the first line  (shift out of @_)

	my $self = {	#---- $self is a ref to hash
		"name" => shift,	# shifting element out of @_ (by default shit works with @_)
		"age" => shift,
	};
	
	bless($self, $class);  # bless is a special subroutine. turns the %self hash into something that can reference subroutine as well as data 
	
	print "------- I am in new subroutine of package Person.pm\n";
	return $self;
}
sub greet {
	my ($self, $other) = @_;
	
	print "Hello $other; my name is " . $self->{"name"} . "; I am " . $self->{"age"} . " years old\n";
	
	print "------- I am greet in package Person.pm\n"
}


1;		# this means return 1
