=pod

=head1 NAME

Pedigree - the main library for Pedigree.

=head1 SYNOPSIS

use Pedigree;

$node = Pedigree->MakeNode($params);

=head1 DESCRIPTION

This is the main package for pedigree construction.  It calls other
libraries in the Pedigree:: family

=over 4

=cut



####################################################################
# Define the package                                               #
####################################################################

package Pedigree;
use Pedigree::AbortionNode;
use Pedigree::Area;
use Pedigree::ChildlessNode;
use Pedigree::Language;
use Pedigree::MarriageNode;
use Pedigree::Node;
use Pedigree::Parser;
use Pedigree::PersonNode;
use Pedigree::TwinsNode;
use strict;

####################################################################
#    MakeNode                                                      #
####################################################################

=pod

=item B<MakeNode>(I<$params>);

Construct a new node from the given parameters.  Check what kind of node 
should we construct.

=cut

sub MakeNode {
    my ($class,$params)=@_;
    
    my $self;
    
    if ($params->{'Name'} =~ s/^\#//) {
	if ($params->{'Name'} eq 'abortion') {
	    $self=new Pedigree::AbortionNode(%{$params});
	} elsif ($params->{'Name'} eq 'childless') {
	    $self=new Pedigree::ChildlessNode(%{$params});
	} else {
	    print STDERR "Unknown special name: ", $params->{'Name'}, 
	    "\n";
	} 
    } else {
	$self=new Pedigree::PersonNode(%{$params});
    }
    return $self;

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

pedigree(1), 
Pedigree::AbortionNode(3), 
Pedigree::Area(3), 
Pedigree::ChildlessNode(3),
Pedigree::Language(3), 
Pedigree::MarriageNode(3), 
Pedigree::Node(3), 
Pedigree::Parser(3), 
Pedigree::PersonNode(3),
Pedigree::TwinsNode(3),


=head1  AUTHOR

Boris Veytsman, Leila Akhmadeeva, 2007



=cut

1;
