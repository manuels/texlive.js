=pod

=head1 NAME

Pedigree::TwinsNode - an auxillary twins node in a pedigree

=head1 SYNOPSIS

use Pedigree::TwinsNode;

$node = new Pedigree::TwinsNode(I<%params>);


$node->DrawNode(I<$xidst>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

$node->DrawConnections();


=head1 DESCRIPTION

This package contains data about a twins node.  Twins node is
a special node between the parent and the twins.

=over 4

=cut



####################################################################
# Define the package                                               #
####################################################################

package Pedigree::TwinsNode;
use Pedigree;
use strict;
our @ISA=('Pedigree::Node');


####################################################################
#    new                                                           #
####################################################################

=pod

=item B<new>(I<%params>);

Construct a new node from the given parameters.

=cut

sub new {
    my ($class,%params)=@_;
    my $self=$class->SUPER::new(%params);
    if (!ref($self)) {  # Bad node
        return 0;
    }

    bless ($self,$class);
    
    # After we constructed the node, we want to move the kids
    # from the parent node to the twins node
    
    my $selfId = $self->{'Id'};
    my $parentId = $self->{'ParentId'};
    foreach my $kidId (keys %{$self->{'KidIds'}}) {
	if ($main::DEBUG) {
	    print STDERR 
		"Moving $kidId from $parentId and to $selfId\n";
	}
	delete $self->{'kids_by_parent_id'}->{$parentId}->{$kidId};
	$self->{'kids_by_parent_id'}->{$selfId}->{$kidId}=1;
    }

    return $self;
}



####################################################################
#    DrawNode                                                      #
####################################################################

=pod

=item B<DrawNode>(I<$xdist>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

Output the command to draw this node.  The parameters are
distances between the nodes (in psunits).

=cut

sub DrawNode {
    my $self=shift;
    my ($xdist, $ydist, $belowtextfont, $abovetextfont, @fieldsfornode) = @_;
    my $result = '\rput('.($xdist*$self->GetAbsX()).", ".
	($ydist*$self->GetAbsY()).'){\pnode{'.
	$self->Id()."}}\n";
    return $result;
}

####################################################################
#    DrawConnections                                               #
####################################################################

=pod

=item B<DrawConnections>();

Draw the connections from the given node to its descendants and
the parent

=cut

sub DrawConnections {
    my $self = shift;
    my $xdist = shift;
    my $ydist = shift;
    my $Id=$self->Id();
    my $parentId = $self->{'ParentId'};
    my @kids = @{$self->Kids()};
    my $leftKid=shift @kids;
    my $leftKidId=$leftKid->Id();
    my $rightKid= pop @kids;
    my $rightKidId=$rightKid->Id();
    my @opts;
    if ($self->Type()) {
	push @opts, $self->Type();
    }
    foreach my $kid (@kids) {
	push @opts, "addtwin=".$kid->Id();
    }
    my $result = '\pstTwins[';
    if (scalar @opts) {
	$result .= join (", ",@opts);
    } 
    $result .= ']{'.$parentId.'}{'.
	$Id.'}{'.$leftKidId.'}{'.$rightKidId.'}'."\n";
    return $result;
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

Boris Veytsman, Leila Akhmadeeva, 2007



=cut

1;
