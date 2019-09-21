use strict;  # to force use of 'my' with variables
use warnings; # turns on vebose error output
use Data::Dumper;
use Getopt::Std;
use XML::Simple;
use DBI;
use lib 'C:\Users\SJG\eclipse-workspace\tutorial3'; ## must do this to user Speak module. this will add this dir to @INC array
#use Speak;		
use Speak qw(test greet);		## this will allow us to call test() without Speak::
use Person;
use File::Copy;

$|=1;		#sets off output buffering (to cause immediate buffering)'

use LWP::Simple;   #LWP stands for "Library for WWW in Perl"

sub main() 
{
	#----- docs here: https://perldoc.perl.org/
	#Speak::test();		# u must use this if u only use 'use Speak'
	test();		# from Speak module  
	greet();	# from Speak module
	
	#------------------------------ OO programming
	my $person1 = new Person("Jon", 45);
	$person1->greet("mike");
	
	my $person2 = new Person("Mike", 55);
	$person2->greet("Jon");

=pod	
	#--------------------------- system admin commands
	if (copy('<file_from>', '<file_to>')) {		#---- can also use 'move' instead of 'copy'
		print "one file copied \n";
	} 	
	
	unlink('logo2.png');	#unlink will delete the file. its a built-in subroutine. not part of File::Copy

	#------------ executing system commands. use back ticks `` (not single qoutes)
	'dir c:\'

	my $command = 'dir';
	my @output = `$command`;
	print "----- output from command dir:\n" . join('',@output);
=cut

	#-------------- arrays vs hashes
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

        #while (my ($key, $value) = each %$months_ref) { #--- have to cast ref to hash
        while (my ($key, $value) = each %{$months_ref}) { #--- have to cast ref to hash
                print "4 - $key - $value\n";
        }
			
	#---------- get content for a website. REMOVE '##' to test code
	##print "downloading....\n";
	
	#print get("https://www.google.com/");
	#print getstore("https://www.google.com/", "home.html");
	##my $code = getstore("https://www.google.com/", "C:\\tutorial\\perl\\home.html");
	##print "code is:  $code \n";
	
	##if ($code == 200){
		##print "success\n";
	##}
	##else{
		##print "failed\n";
	##}
	
	##print "finished\n";
	
	#------------------------- check if a file exists
	if (-f 'C:\\tutorial\\perl\\home.html'){
		print "found file\n"
	}else
	{
		print "file not found\n"
	}
	
	#------ use variable for file
	my $file = 'C:\tutorial\perl\home.html';
	if (-f $file){
		print "found file: $file\n"
	}else
	{
		print "file not found: $file\n"
	}
	
	#--------------- arrays of files
	my @files = ('C:\tutorial\perl\home.html','C:\tutorial\perl\home2.html' );
	foreach my $file2(@files){
		if (-f $file2){
			print "found file: $file2\n"
		}else{
			print "file not found: $file2\n"
		}
	}
	#---- arrays of valid/invalid email addresses. find the valid ones
	#valid email: alphanumeric@aplanumeric.alphanumeric char
	my @emails = (
		'john@xxx.xom',
		'hello',
		'@aaaa.com',
		'aaaa@sss.com',
		'qqq@sss'
	);
	
	for my $email(@emails){
		if ($email =~ /(\w+\@\w+\.\w+)/){
			print "valid email: $1\n"
		}else {
			print "not valid email: $email\n"
		}
	}
	
	#----------------------reading files and searching for text using regular expressions
	my $file3 = 'C:\tutorial\perl\notes.txt';
	#open(INPUT,$file3);  #INPUt is a file handle and it is a var but doesn't need to be declared with 'my'
	#die; # this terminates the program
		
	open(INPUT,$file3) or die "Input file $file3 not found\n";  # without '\n' it gives you the line number it died on'

	print "----------------------\n";
	while (my $line = <INPUT>){   # read a line at the time
		if ($line =~ /can/){ # means if line matches 'can'.
			print $line  # only print if line contains 'can'
		}
	}
	print "-----------------------\n";
	
	close (INPUT);

	#------------------------ create a file
	#my $output = ">output.txt";   # '>' tells perl to create the file as opposed to open it.
	#open(OUTPUT, $output) or die ("can't create $output\n");
	#-- instead of puting '>' before filename, contacenate it to only filename (without ">")
	my $output = "output.txt";  
	open(OUTPUT, ">".$output) or die ("can't create $output\n");
	print OUTPUT "hello\n";
	
	close OUTPUT;
	
	#---------------- open input file, read line, search and replace text and write to output file
	my $file4 = 'C:\tutorial\perl\notes.txt';
	open(INPUT,$file4) or die "Input file $file4 not found\n";  # without '\n' it gives you the line number it died on'

	my $output2 = "output2.txt";  
	open(OUTPUT, ">".$output2) or die ("can't create $output2\n");

	print "----------------------\n";
	while (my $line2 = <INPUT>){   # read a line at the time
		if ($line2 =~ /\bcan\b/){ # means if line matches 'can'. '\b means find 'can' on its own (no space or . around it)
			print $line2; # only print if line contains 'can'
			$line2 =~ s/can/CAN/ig; # replace 'can' with 'CAN', case insensitive and globally
			print OUTPUT $line2  # only print if line contains 'can'
		}
	}
	print "-----------------------\n";
	
	close (INPUT);
	close OUTPUT;
	
	#------------------------- match wild characters. '.' means anyy char
	my $file5 = 'C:\tutorial\perl\notes.txt';
	open(INPUT,$file5) or die "Input file $file5 not found\n";  # without '\n' it gives you the line number it died on'

	print "----------------------\n";
	while (my $line = <INPUT>){   # read a line at the time
		if ($line =~ /c.n/){ # '.' means any character
			print $line  # only print if line contains 'can'
		}
	}
	print "-----------------------\n";
	
	close (INPUT);

	#----------------------------- use groups to just get the texts that matches
	my $file6 = 'C:\tutorial\perl\notes.txt';
	open(INPUT,$file6) or die "Input file $file6 not found\n";  # without '\n' it gives you the line number it died on'

	print "----------------------\n";
	while (my $line = <INPUT>){   # read a line at the time
		if ($line =~ /(c.n.)(use)/){ # '() around 'c.n.' means put the matched text in a group that can be access by $1, $2,.. 
			print "first match: '$1'  second match: '$2'\n";  # only print the texts that matched (lines with 'can' and 'use')
		}
	}
	print "-----------------------\n";
	
	close (INPUT);

	#------------------------------------------ quatifiers (*, *? ,..etc)
	my $file7 = 'C:\tutorial\perl\notes.txt';
	open(INPUT,$file7) or die "Input file $file7 not found\n";  # without '\n' it gives you the line number it died on'

	print "----------------------\n";
	while (my $line = <INPUT>){   # read a line at the time
		if ($line =~ /(c.n.*n)/){ # greedy: '.*' mean match any chars but as many as possible (stop at last 'n'). you get: 'can use: main(){}  or  main'
		#if ($line =~ /(c.n.*?n)/){ # not greedy: '.*?' mean match any chars but as little as possible (stop at first 'n'). you get: 'can use: main'
			print "first match: '$1'\n";  # only print the texts that matched (lines with 'can' and 'use')
		}
	}
	print "-----------------------\n";
	
	close (INPUT);
	
	#------------------------- more regular expressions
	# \d : matches any digit
	# \s:  matches space
	# \S:  matches non-space
	# \w:  matches alphanumeric including space
	
	my $text= ' I am 117 years old tomorrow';
	my $text2= ' Iam117yearsold_tomorrow.';
	#if ($text =~ /(\d*)/ ) { # does't find a match as it matches zero or more and because string doesn't start with a digit, it won't find a match.
	#if ($text =~ /(\d+)/ ) { # matches '117': '+' is the same as '*' but it matches 1 or more.
	#if ($text =~ /(am\s\d+)/ ) { # matches 'am 117' . \s also matches a single tab, space
	#if ($text =~ /(y\S*)/ ) { # matches 'years' 
	if ($text2 =~ /(y\w*)/ ) { # matches alphanumeric: 'Iam117yearsold_tomorrow' without '.'
	
		print "first match: '$1'\n";
	}
		
	#------------------------------------------ numeric quatifiers ()
	# * means zero or more of the proceeding char as many as possible (greedy). can't use on its one')
	# + means 1 or more of the proceeding char as many as possible
	# *? means zero or more of the proceeding char as few as possible (not greedy)
	# +? means 1 or more of the proceeding char as few as possible (not greedy)
	# {3,6} means at least 3 and at most 6
	
	my $text3= 'DE$75883';
	my $text4= 'DE$75883';
	my $text5= 'The code for this device is GP8765.';
	#if ($text3 =~ /(DE.....)/ ) { # matches 5 of any char':  i.e 'DE75883'
	#if ($text3 =~ /(DE\d\d\d\d\d)/ ) { # matches 5 of any digit':  i.e 'DE75883'
	#if ($text3 =~ /(DE\d{5})/ ) { # matches 5 of precedding char':  i.e 'DE75883'
	#if ($text3 =~ /(DE\d{5})/ ) { # matches 5 of precedding char':  i.e 'DE75883'
	#if ($text3 =~ /(DE\d{3,4})/ ) { # matches max 4 digits only:  i.e 'DE7588'
	#if ($text3 =~ /(DE\d{7,})/ ) { # matches 7 or more:  i.e '' (nothing because string only has 5 digits)
	#if ($text4 =~ /(DE\$\d{3,})/ ) { # matches 3 or more:  i.e 'DE75883'. u have to escape the '$'
	if ($text4 =~ /(DE\$\d{3,})/ ) { # matches 3 or more:  i.e 'DE75883'. u have to escape the '$'
		print "first match: '$1'\n";
	}
	
	#if ($text5 =~ /(\w\w\d{4})/ ) {  # matches any alphnumeric followed by 4 digits
	#	print "code is: '$1'\n";

	#if ($text5 =~ /(is\s(.+?)\.)/ ) {   # any text after 'is ' and before last '.' (defined in second bracket)
	#	print "code is: '$2'\n";  # Note: usng $2. this matches "is device is GP8765" which is NOT CORRECT. we want text after second 'is

	if ($text5 =~ /(is\s(\S+?)\.)/ ) {   # any non-space char after 'is ' and before last '.' (defined in second bracket)
		print "code is: '$2'\n";  # this matches "is device is GP8765"
	}
	else{
		print "code not found";
	}	


#---------------------- arrays and hashes
print "----------- array and hashes\n";

my @fruits2; # define an array.
#my @fruits = ("apple","banana", "oranges");  # initialize an array
my @fruits = qw(apple banana oranges);  # same as above line
$fruits[3] = "kiwi";  # this will add 'kiwi' to array
print $fruits[0] . "\n";


#------------ iterate through array
print "-------- iterate through array\n";
foreach my $fruit(@fruits) {
	print "$fruit\n";
}

my $fruits_ref = \@fruits;	# this is a ref to array fruit
print $fruits_ref->[0] . "\n";   # with references you have to use '->'

#------------ iterate through array using ref
print "--------- iterate through array using ref\n";
foreach my $fruit(@$fruits_ref) {   # use '@' to cast a ref to an array.
	print "$fruit\n";
}

my %months = (    # this is a hashe (use % instead of @)
	"John" => 1,  # 'John' is the key
	"Feb" => 2,
	);

$months{"Mor"} = 3;		# to add a new entry to hash
print $months{"John"} . "\n";

my $months_ref = \%months;    # defining a reference to hash
print $months_ref->{"John"} . "\n";


#---------- iterate through hash
print "--------- iterate through hash\n";
while (my ($key, $value) = each %months) {
	print "$key - $value\n";
}

#---------- iterate through hash
print "-------- iterate through hash using ref\n";
#while (my ($key, $value) = each %$months_ref) {    # use '%' to cast ref back to hash
while (my ($key, $value) = each %{$months_ref}) {   # or put ref name in {}. works as above statement
	print "$key - $value\n";
}

#-------------------- reading .csv files
my $input = "test.txt";
unless (open(INPUT, $input)) {
	die "file not found";
}

<INPUT>;	# to get rif of title
print "-------- print file content\n";
#while (<INPUT>) {
#	print $_;   # lines are read into $_ which is an internal variable
#}

my $count = 0;
my @lines;	#array to store the lines

while (my $line = <INPUT>) {	# this is more specific 
	#print $line;
	chomp $line;   #remove end of line char
	#my @values = split (',', $line) ;  #read file into array split by ','
	#my @values = split (/,/ , $line) ;  #This is the same as above but using regexp
	my @values = split (/\s*,\s*/ , $line) ;  #to strip spaces arounf ','
	#print $values[1] . "\n";
	#print join ("|", @values); 	#re-join using another seperator
	#print Dumper(@values);		# print different elements of array
	#$lines[$count] = $line;		#this is like push: perl creates elements in arrays if they don't exists
	$count++;

	#push @lines, $line;  # this will add the whole line with all colums stuck together	
	push @lines, \@values;	# this will add a ref to location of @values to @lines 
							# every element in @lines is an array of columns (not stuck together)
}

print "--------------- print line\n";
foreach my $line(@lines) {		# $line is a reference to array @lines
	#print $line . "\n";
	print Dumper ($line);
	print "name: " . $line->[0] . "\n";	# we need '->' here to derefrence the value
}
print "count: $count \n";
close INPUT;

print $lines[0][0] . "\n";	# to get one specific column out of @lines (no need for '->' here)

#---------------------- array of arrays
print "-------------- array of arrays\n";
my @animals3 = ('dog','cat','rabbit');
my @fruits3 = ('apple','banana','orange');
my $temp = \@animals3;		# $temp is a ref: this is like converting array to a single value (all columns contaconated into 1 line)

my @values;
#push @values, @animals3;		# this adds columns of array @animals3 to array @values
#push @values, @fruits3;		# this adds columns of array fruits to array @values
#print Dumper(@values);

push @values, \@animals3;	# this adds a ref (location to another array) to @values which represents the whole line
push @values, \@fruits3;	# this adds a ref to @values which represents the whole line

print Dumper(@values);

#----------------- hashes (key and values). they have no order
print "---------- hashes\n";
my %months2 = (
	"Jan" => 1,
	Dec => 12,			# no need for quotes. converts to strings automatically
	"Mar" => 3,
	"Jun" => 6,
	);

	print $months2{Dec} . "\n";
	print $months2{"Dec"} . "\n";		#works with or without quotes
	
my %days = (
	1 => "Monday",
	2 => "Tuesday",
	3 => "Wed",
	);
	
	print $days{1} . "\n";
	
	#------------ iterate through hash
	print "---iterate through hash";
	my @months2_array = keys(%months2);	#get the keys for a hash'
	
	for my $month(@months2_array) {   # foreach also works
		my $value = $months2{$month}; # $months here refers to hash. we use '$' because we want single value
		print $value . "\n";
	}
	
	#----------------- another way of iterating
	while( my( $key, $value) = each %days) { # need '()' around variables if more than one declared
		print "key: $key: value: $value" . "\n";
	}
	
	#----------------- another example
	my %foods = (			#'define and initialise a hash'
		"cats" => "cheese",
		"dogs" => "meet",
		"bird" => "seeds",
	);
	
	while( my ($key, $value) = each %foods){  # '($key, $value)' is an array
		print ("key: $key: value: $value\n");
	};
	
	#-------------- another way to iterate hashes
	my @animals4 = keys %foods;   #  or 'keys (%foods)'
	#foreach my $key(@animals4) {	# 'for' also work instead of foreach
	foreach my $key(sort keys (%foods)) {   # no need to declare an array first. hashes are not sorted by default
		my $value = $foods{$key};
		print "$key = $value\n";
	}
	print Dumper(@animals4);
	
	#------------------------------------------- store a hash in an array
	print "------------- more hashes/arrays\n";
	my %hash = (			#'define and initialise a hash'
		"cats" => "meet",
		"birds" => "seeds",
		"fish" => "worms",
	);
	my (@test, @test2);
	push @test, %hash;		#to store a hash in an array in format (which is useless): 
				#$VAR1 = 'fish';
				#$VAR2 = 'worms';
				#$VAR3 = 'cats';
				#$VAR4 = 'meet';
				#$VAR5 = 'birds';
				#$VAR6 = 'seeds';
	print Dumper(@test);
	
	push @test2, \%hash;		#this will store references to hash in the array in this format:
				#$VAR1 = {
          					#'cats' => 'meet',
          					#'birds' => 'seeds',
          					#'fish' => 'worms'
        				#};
	
	@test2[1] = \%hash;		#another way of pushing into hash
	print Dumper(@test2);
	print $test2[0]{"birds"} . "\n";  # '[0]' means get the first element of array which is the hash so we can use a key to get its value
	print $test2[1]{"birds"} . "\n";  # This and above will give 'seeds
	
	#---------------- store .csv file in array of hashes
	my $input2 = "test.txt";
	unless (open(INPUT, $input2)) {
		die "file not found";
	}
	my $title = <INPUT>;	# to get the title
	chomp $title;
	my ($name_t, $payment_t, $date_t) = split (/\s*,\s*/ , $title) ; #read col titles into vars
	my (@lines2, @lines3);	#arrays to store the lines
	
	while (my $line = <INPUT>) {	# this is more specific 
		chomp $line;   #remove end of line char
		#print "$line\n";
		my @values = split (/\s*,\s*/ , $line) ;  #to strip spaces around ','
		push @lines2, \@values;	# this will add a ref to location of @values to @lines 
								# every element in @lines is an array of columns (not stuck together)

		#define a hash and store its ref in array
		my ($name, $payment, $date) = split (/\s*,\s*/ , $line) ;  #

		my %values_ref2 = (		## better technique in example below
			#"Name" => $name,
			$name_t => $name,	#instead of hard coding, we use the vars we set from title
			$payment_t => $payment,
			$date_t => $date,
		);
		push @lines3, \%values_ref2;	#this pushes reference to above hash to array
	};
	
	close INPUT;
	
	print "-------- .csv file in array of arrays\n";
	foreach my $line(@lines2) {		# $line is a reference to array @lines
		print Dumper ($line);		#this displays the array like the following (its a view of the .csv file)
		#$VAR1 = [
		#          'Isaac Newton',
		#          '99.10',
		#          '15051999'
		#        ];
		#$VAR1 = [
		#          'Albert Einstein',
		#          '13.20',
		#          '11062012'
		#        ];

		print "name: " . $line->[0] . "\n";	# we need '->[]' here to derefrence the value
	}

	print "-------- .csv file in array of hash references\n";
	my $payment_total = 0.0;
	
	foreach my $line(@lines3) {		# $line is a reference to array @lines
		print Dumper ${line};		#this displays the array like the following
			#$VAR1 = {
			#          'Date' => '15051999',
			#          'Name' => 'Isaac Newton',
			#          'Payment' => '99.10'
			#        };
			#$VAR1 = {
			#          'Payment' => '13.20',
			#          'Date' => '11062012',
			#          'Name' => 'Albert Einstein'
			#        };

		print $payment_t . ": " . $line->{$payment_t} . "\n";	# we need '->{}' here to derefrence the value
		
		$payment_total += $line->{$payment_t};
		print $payment_total ."\n";
	}

	print "test of no need for def-ref: " . $lines3[0]{$payment_t} . "\n"; # here we don't need the '->' to de-reference it if we use an index
	
	#------------------------- data validation. Use column headings in a loop (best technique)
	print "--------------------- .csv file validation tests\n";
	my $input3 = "test2.txt";
	unless (open(INPUT, $input3)) {
		die "file not found";
	}
	my $title3 = <INPUT>;	# to get the title
	chomp $title3;
	my @headings = split (/\s*,\s*/ , $title3) ; #read col titles into an array

	my @lines4;	#arrays to store the lines
	
	LINE: while (my $line = <INPUT>) {	# LINE is a lable. used with 'next'
		chomp $line;   #remove end of line char
		$line =~ /\S+/ or next;		# skip blank lines: match non blank line. if blank go to next line
		print "$line\n";

		$line =~ s/^\s*//;		#'^' match the begining of the line. It means replace leading spaces with nothing (remove them)
		$line =~ s/\s*$//;		#'$' means end of line. '\s*$' means remove trailing spaces
		$line =~ s/^\s*|\s*$//;		# '|' means 'or'. remove either leading or trailing spaces (not good. we have to remove both of them)
		$line =~ s/^\s*|\s*$//g;		# 'g' means do the substitution as many as possible which means it will remove leading and trailing spaces.
		$line =~ s/\?|aprox\.|\$//g;		# to remove '?' or 'aprox.'	or '$'
		#$line =~ s/\?|aprox\.\s*|\$//g;	# as above but this line specificly also removes spaces after 'aprox.' . although above line also removes them (not sure how).
					
		my @values4 = split (/\s*,\s*/ , $line) ;
		#if (scalar(@values4) < 3) {   # scalar gets the number of elements in arrasy
		if (@values4 < 3) {   # works without the scalar because we are comparing arrasy with a number
			print "----- Invalid line: $line\n";	#check for missing columns
			next;	# can also use 'next LINE'
		}
		foreach my $value(@values4){	## check foro empty columns
			#if ($value eq "") {
			if (length($value) == 0) {		#same as above
				print "------- Invalid line: $line\n";
				next LINE; 	# Go back to start of loop to skip this invalid line
			}
		}

		my %values_ref4 ;
		for(my $i=0; $i<@headings; $i++){
			my $heading = $headings[$i];
			my $value = $values4[$i];
			print "heading: $heading   value: $value\n";
			$values_ref4{$heading} = $value;
		}		

		push @lines4, \%values_ref4;	#this pushes reference to hash to array
		
	};
	
	close INPUT;
	my $totalPayment = 0;
	
	foreach my $line(@lines4) {		# $line is a reference to array @lines
		print Dumper ${line};		#this displays the array like the following
			#$VAR1 = {
			#          'Date' => '15051999',
			#          'Name' => 'Isaac Newton',
			#          'Payment' => '99.10'
			#        };
			#$VAR1 = {
			#          'Payment' => '13.20',
			#          'Date' => '11062012',
			#          'Name' => 'Albert Einstein'
			#        };

		print "Payment: " . $line->{"Payment"} . "\n";	# we need '->{}' here to derefrence the value
		$totalPayment += $line->{"Payment"};
	}

	print "total: $totalPayment\n";
	
	#---------------------------- web scraper - remove ### for testing
	
	print "downloading....\n";

	#------- load a webpage and then look for a title/description in the content	
	#----- somewhere in the content there is a line like the following. match the description and extract it.
	# '<meta name="description" content="At Guardian, we share one Vision – to create value for our customers and society, and to constantly innovate to improve the value we create." />';

=pod        # remove pod/cut to test the below code
	my $content = get("https://www.guardian.com/en");
	unless(defined($content)) {
		die "unreachable URL";
	}
	###print $content;
=cut

	#--------------- use '=pod'   and  '=cut'  for multi line comments
=pod
	// is used as default quotes for regexp and u can't use any double quotes or spalshes in between because it will be interpreted.
	instead of using // for regexp, use '' to stop interpreting special chars which will happen if u use ""
	anything between '' will not be interpreted
	to tell perl that text between '' has a regexp, u have to put an 'm' at the start
	 can also use pipe chars as quote chars but have to put 'm' before them ('m||')
=cut

=pod        # remove pod/cut to test the below code
	if ($content =~ m'<meta name="description" content="(.+?)" />'i) { #---'(.+?' means multiple of any char. '$' make it not greedy (just match once) )
		print "Match found: $1\n";  # $1 is the text matched in group '(.+?)'
	}
	else {
		print "Match not found\n/";
	}
	
	while ($content =~ m|class="([^"']*?)"|sig){ # 's' mean treat new line char as just another char, 'i' means case independent,
		###print "matches found: $1\n";   # remove comment
	} 
	#----------------- put all matches into an array  
	my @classes = $content =~ m|class="([^"']*?)"|ig;   # matches any char except "' after 'class="'
	if (@classes == 0) {
		print "No matches found";
	}
	else {
		foreach my $class(@classes){
			###print "class from array: $class\n"; # example: "modal-inline-background"
		}
	}
	
	print "finished\n";
=cut
	
	#--------------------------------------------- character classes
	# [0-9]  any number
	# [A-Z]  any uppercase letter
	# [A-Za-z_0-9]  specify alternatives just by listing them.
	# [\=\%]	simply specify alternatives. back slash any char that might have special meaning
	# [^0-9T\s]   match anything EXCEP the specified chars
	
	my $content2 = "The 39 steps - a GREAT book - Colours_15 ==%== ABBCCCCABCA";
	#if ($content2 =~ /(\d+)/) {  # matches 39. \d means any digits between 0 to 9
	#if ($content2 =~ /([0-9]+)/) {  # matches 39. [] is a char class. [0-9] means any char between 0 and 9
	#if ($content2 =~ /([A-Z]{2,})/) {  # matches GREAT. [A_Z]{2,} means uppercase, at least 2 chars
	#if ($content2 =~ /(C[A-Za-z_0-9]{2,})/) {  # matches Colours_15.
	#if ($content2 =~ /([\=\%]{2,})/) {  # matches ==%==. 
	#if ($content2 =~ /([ABC]{3,})/) {  # matches ABBCCCCABCA. 
		if ($content2 =~ /([^0-9T\s]{5,}+)/) {  # matches steps. [^] means exclude any char following ^
			print "matched $1\n";
	}
	else {
		print "Not match\/";
	}
	
	#------------------------------- command line argument processing
	print Dumper(@ARGV);
	#print $ARGV[0] . "\n";
	my %opts;		# hash to store the arguments
	getopts('af:cd:', \%opts);	# 'a, f and c' are the flags passed on command line . ':' means -f is supposed to get an argument
								# a and c are optional argument. their values will be 1
	print "opts = " . Dumper(%opts);
	
	my $input_file = $opts{'f'};
	#print "file: $input_file";
	
	#---------------------------------- check parameters
	if (!checkusage()) {
		usage();
	}
	if (!checkusage2("Hello", 7)) {	# passing params
		usage();
	}
	if (!checkusage3(\%opts)) {	# passing ref to hash
		usage();
	}

	my $opts_ref = \%opts;
	print "--------- opts_f: " . $opts{"f"} . "  ref: " . $opts_ref->{"f"} . "\n";
	
	my $input_dir = $opts{"d"};
	my @files2 = get_files($input_dir);
	print "files2: " . Dumper(\@files2);
	##process_files(\@files2, $input_dir);  //remove commect to test process_files
	
	#---------------------------------------------------- database handling
=pod		#-- need to install DBD-mysql before testing
	print "---------------- connect to db";
	my $dbh = DBI->connect("dbi:mysql:mydb", "user", "password");	# have to install DBD-mysql driver
	unless(defined($dbh)) {
		die "---- cannot connect to database\n";
	}
	#-------------------- insert into table
	my $sth = $dbh->prepare('insert into bands (name) values (?)');	#'?' is called place holder
	unless ($sth){
		die "Error preparing SQL\n";
	}
	
	$dbh->do('delete from bands') or die "Can't clean bands table\n";
	
	unless ($sth->execute("band1")){
		die "error executing";
	}
	
	print $sth->{'mysql_insertid'};  #UniqueId of the table
	
	$sth->finish();
	
	#--------------------- read from table
	my $sth2 = $dbh->prepare('select Id, Band from bands');
	$sth2->execute();
	while (my $row = $sth2->fetchrow_hasref()){
		my $band_id = $row->{"id"};
		my $band_name = row->{"Name"};
		print "$band_id   $band_name";
	}
	
	##$dbh->disconnect();

=cut

=pod #---------------- perl one liners. Type the following on command line and it works
perl -e "print \"hello world\""  # -e means execute on command
perl -p -e "s/\bme\b/ZORG/gi" test.txt   # -p means loop through the file line by line
perl -pe "s/\bme\b/ZORG/gi" test.txt   # 'e' must be after -p
perl -i.org -pe "s/\bme\b/ZORG/gi" test.txt   # '-i.org' means copyy the original file to .org and change the file replacing the text

=cut

	#----------------------------- end of main
}

sub process_files{
	my ($files, $input_dir) = @_;
	print "---- in process_file: $input_dir \n" . Dumper($files);
	foreach my $file(@$files) {		# $files is a ref to an array. to get the array you have to cast it using '@'
		#process_file($file, $input_dir);		#remove comment to test manual xml processing
		process_file2($file, $input_dir);
	}
}

sub process_file{
	my ($file, $input_dir) = @_;
	print "---- Processing $file in $input_dir  \n";
	my $filepath = "$input_dir/$file";
	open(INPUTFILE, $filepath) or die "Unable to open $filepath\n";
	
	$/ = "</Feature";		# '$/' is global variable by default set to end of record seperator which is a 'new line'. we change it here 

	my $count = 0;
	while (my $chunk = <INPUTFILE>) {	#instead of reading a line at a time, we now read a chunk of lines terminated by '</Feature'
			#	<Feature Id="ExcelAddinSolverFilesIntl_1033" Cost="576952">
			#		<OptionRef Id="ExcelAddinSolverFiles"/>
			#	</Feature
		print "\n---- $count: $chunk\n";
		my ($band) = $chunk =~ m'<OptionRef Id=(.*?)/';		# this is to extract the text of OptionRef
															# band = "ExcelAddinSolverFiles"
		unless(defined($band)) {
			next;
		}
		print "----------- band: $band\n";
		my @album = $chunk =~ m'<album>(.*?)</album>'sg;		# this is to extract the text of OptionRef
																#'s' means match straddle across multiple lines
		print "----------- No. of albums: " . scalar(@album) . "\n Albums:\n" . Dumper(@album) . "\n";
		
		
		$count++;
	}
	
	close(INPUTFILE);
	$/ = "\n";		# reset the end of record seperator as it is global	
}

sub process_file2{
	my ($file, $input_dir) = @_;
	print "---- Processing $file in $input_dir  \n";
	my $filepath = "$input_dir/$file";
	open(INPUTFILE, $filepath) or die "Unable to open $filepath\n";
	
	undef $/;		# to read the whole of file in one chunk ('$/' is global variable by default set to end of record seperator which is a 'new line'. 

	my $content3 = <INPUTFILE>;
	close(INPUTFILE);
	print "content:\n $content3\n";
	
	my $parser = new XML::Simple;	#In perl objects are hashes. '$parser' here is called a blessed hash
	my $dom = $parser->XMLin($content3, ForceArray => 1);	# ForceArray means turn elemets into Array if if there is only one element
	print "--- dom:\n" . Dumper($dom);
	print "--- dom->Feature:\n" . Dumper($dom->{"Feature"});
	
	foreach my $feat (@{$dom->{"Feature"}}) {
		print "--- each album:\n" . Dumper ($feat->{"album"});
		my $albums = $feat->{"album"};
		foreach my $album(@$albums) {
			print "----- each album2 :\n" . Dumper($album->{"name"}->[0]) . "\n";
		}
	}

	$/ = "\n";		# reset the end of record seperator as it is global	
}


sub get_files{
	my $input_dir = shift;
	print "Input dir: $input_dir\n";
	unless(opendir(INPUTDIR, $input_dir)){
		die "\n unable to open directory $input_dir\n";
	}
	
	my @files3 = readdir(INPUTDIR);
	
	closedir(INPUTDIR);
	
	@files3 = grep(/\.xml$/, @files3);		#grep() is a built-in function. first parameter is a regexp
	
	return @files3;
	
	# note: if we don't return a value, perl will return the output of the last statement which is print (above line)
	#7; # this means return 7
}
#-------------------------------------------- 
sub checkusage {
	return 0;		# 0 means flase, 1 means true
}
#-------------------------------------------- 
sub checkusage2 {		# no need to use brackets or specify parameters
	print Dumper(@_);	# parameters are in array '@_'
	my ($greeting,$number) = @_;	#--- to read parameters into array
	print "Greeting: $greeting  number: $number\n";
	
	my $greeting2 = shift @_;	#shift removes items from start of array (pop from end of array)
	my $number2 = shift ;				#no need to specify @_
	#my $number2 = shift @_;
	print "Greeting: $greeting2  number: $number2\n";
	
	return 0;		# 0 means flase, 1 means true
}

#-------------------------------------------- 
sub checkusage3 {		# no need to use brackets or specify parameters
	
	my $opts_ref = shift;		# we get the ref to hash
	print "opts_ref in sub: " . $opts_ref->{"f"} . "\n";
	my $a = $opts_ref->{"a"};		# option 'a' is optional so no need to refer to it here
	my $c = $opts_ref->{"c"};		# option 'c' is mandatory
	my $f = $opts_ref->{"f"};		# option 'f' is mandatory
	
	unless (defined($c) and defined($f)) {
		print "must specify -c and -f parameters\n";
		return 0;
	}

	unless($f =~ /\.xml$/){		# filename must end with .xml
		print "file must have the extension .xml\n";
		return 0;
	}
	
	return 1;		# 0 means flase, 1 means true
}

#----------------------------------------------
sub usage {
	print "-------- Incorrect options\n";
	#print <<USAGE;			#can just print it instead of seting $help
	my $help = <<USAGE;		# example of multi line string. start with <<XXXX and end with XXXX (i.e USAGE)
	
usage: perl main.pl <options>
	-f <file name>	Specify filename to pass
	-a 	turn off error checking

example usage:
	perl main.pl -f <file name> -a

USAGE

	#die $help
	#exit();	# can just exist
	print $help;
}

#---------------------- call main sub (could be any name)
main();
