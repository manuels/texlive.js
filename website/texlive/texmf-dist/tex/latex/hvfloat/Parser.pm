=pod

=head1 NAME

Pedigree::Parser - parser for the input file

=head1 SYNOPSIS

use Pedigree::Parser;

$parser = new Pedigree::Parser(I{$inputline>, I<$lang>)

$parser->Parse($inputline);


=head1 DESCRIPTION

This package parses input for the pedigree library and is used to
define nodes.

=over 4

=cut

####################################################################
# Define the package                                               #
####################################################################

package Pedigree::Parser;
use strict;

####################################################################
#    package variables                                             #
####################################################################

#
# %fields_to_convert:  the hash of fields that contain limited 
# number of values and the default value for such field
#

my %fields_to_convert = (
        'Sex'=>'unknown', 
        'Proband'=>0,
        'Condition'=>'normal',
        'Type' => ''
);


####################################################################
# And package methods                                              #
####################################################################

####################################################################
#    new                                                           #
####################################################################

=pod

=item B<new>(I<$inputline>, I<$lang>);

Construct a new parser from the pipe-separated line at input

=cut

sub new {
    my ($class,$inputline,$lang)=@_;
    my $self={};

    #
    # The hash $self->{fields} is the main stored data structure.  
    # The key is the field, the value is the number of the field 
    # in the input lines. 
    #
    my %fieldnames=%{$lang->GetFieldNames()};
    chomp $inputline;
    $inputline =~ s/^\s+//;
    $inputline =~ s/\s+$//;
    my @input = split /\s*\|\s*/, $inputline;
    for (my $i=0;  $i<scalar @input; $i++) {
	my $name=$input[$i];
	if (exists $fieldnames{$name}) {
	    my $field=$fieldnames{$name};
	    $self->{fields}->{$field}=$i;
	} else {
	    print STDERR "Warning:  unknown field $name\n";
	}
    }

    if ($main::DEBUG) {
	print STDERR "Field names:\n";
	foreach my $key (keys %fieldnames) {
	    my $field=$fieldnames{$key};
	    my $pos=$self->{fields}->{$field};
	    print STDERR "\t$key\t$field\t$pos\n";
	}
    }

    #
    # The hash $self->{values} contains values for  fields
    # with closed sets of values.
    #
    my %values=%{$lang->GetValues()};
    $self->{values}=\%values;

    if ($main::DEBUG) {
	print STDERR "Field values:\n";
	foreach my $key (keys %values) {
	    my $value=$values{$key};
	    print STDERR "\t$key\t$value\n";
	}
    }


    #
    # The hash $self->{special_names} contains special values
    # for the 'Name' field
    #
    my %special=%{$lang->GetSpecialNames()};
    $self->{'special_names'}=\%special;

    if ($main::DEBUG) {
	print STDERR "Special names:\n";
	foreach my $key (keys %special) {
	    my $value=$special{$key};
	    print STDERR "\t$key\t$value\n";
	}
    }

    if ($main::DEBUG) {
	print STDERR "Special fields:\n";
	foreach my $key (keys %fields_to_convert) {
	    my $value=$fields_to_convert{$key};
	    print STDERR "\t$key\t$value\n";
	}
    }

    bless ($self,$class);
    return $self;
}


####################################################################
#    Parse                                                         #
####################################################################

=pod

=item B<Parse>(I<$inputline>);

Take a line of comma-separated values;  return a reference to a 
hash of parsed values

=cut

sub Parse  {
    my ($self,$inputline)=@_;
    chomp $inputline;
    $inputline =~ s/^\s+//;
    $inputline =~ s/\s+$//;
    my @input = split /\s*\|\s*/, $inputline;
    if ($main::DEBUG) {
	print STDERR "Parsing line:$inputline\n";
    }

    my %result;

    foreach my $field (keys %{$self->{fields}})  {
	my $i=$self->{fields}->{$field};
	my $value=$input[$i];
	#
	# Special fields...
	#
	if (exists $self->{values}->{$value}) {
	    $value=$self->{values}->{$value};
	}
	if (exists $fields_to_convert{$field}) {
	    if (length($value) == 0 ) {
		$value=$fields_to_convert{$field};
	    }
	}
	#
	#  Dropping empty fields
	#
	if (length($value) == 0 ) {
	    next;
	}

	#
	# Converting Name field
	#
	if (($field eq 'Name') && ($value =~ /^\#/)) {
	    foreach my $regexp (keys %{$self->{'special_names'}}) {
		my $name=$self->{'special_names'}->{$regexp};
		$value =~ s/^(\#$regexp.*)/\#$name/i;
	    }
	}

	#
	# And finishing
	#
	$result{$field}=$value;
	if ($main::DEBUG) {
	    print STDERR "\t$field\t$value\n";
	}
    }

    return \%result;

}

####################################################################
#    THE END                                                       #
####################################################################

=pod

=back

=head1 ENVIRONMENT

The calling program should define B<$main::DEBUG> and set it to 0
or 1.

=head1 SEE ALSO

pedigree(1), Pedigree(3)

=head1  AUTHOR

Boris Veytsman, Leila Akhmadeeva, 2006, 2007



=cut

1;

