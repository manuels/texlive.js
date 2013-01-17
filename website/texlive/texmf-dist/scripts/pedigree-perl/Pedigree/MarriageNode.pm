=pod

=head1 NAME

Pedigree::MarriageNode - a marriage in a pedigree

=head1 SYNOPSIS

use Pedigree::MarriageNode;

$node = new Pedigree::MarriageNode(I<%params>);

$FSpouse = $node->FSpouse();

$MSpouse = $node->MSpouse();

$consang = $self->isConsanguinic();

$area = $node->SetArea();

$node->CalcAbsCoord(I<$x>, I<$y>);

$node->DrawNode(I<$xidst>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

$node->DrawConnections();


=head1 DESCRIPTION

This package contains data about a marriage.

=over 4

=cut



####################################################################
# Define the package                                               #
####################################################################

package Pedigree::MarriageNode;
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
    
    #
    # Normally marriage nodes are not consanguinic
    #
    if (!exists($self->{'Consanguinic'})) {
	$self->{'Consanguinic'} = 0;
    }
    
    # After we constructed the node, we want to move the kids
    # from the parent nodes to the marriage node
    
    my $selfId = $self->{'Id'};
    if (exists($self->{'FSpouse'}) && exists($self->{'MSpouse'})) {
	my $fspouse = $self->{'FSpouse'};
	my $fspouseId = $fspouse->Id();
	my $mspouse = $self->{'MSpouse'};
	my $mspouseId = $mspouse->Id();

    
	foreach my $kidId (keys %{$self->{'kids_by_parent_id'}->{$fspouseId}}) {
	    if ($main::DEBUG) {
		print STDERR "Checking kid $kidId for $selfId\n";
	    }
	    if (exists ($self->{'kids_by_parent_id'}->{$mspouseId}->{$kidId})) {
		if ($main::DEBUG) {
		    print STDERR 
			"Moving $kidId from $fspouseId and $mspouseId to ".
			"$selfId\n";
		}
		delete $self->{'kids_by_parent_id'}->{$mspouseId}->{$kidId};
		delete $self->{'kids_by_parent_id'}->{$fspouseId}->{$kidId};
		$self->{'kids_by_parent_id'}->{$selfId}->{$kidId}=1;
	    }
	}
    }

    return $self;
}


####################################################################
#    FSpouse                                                       #
####################################################################

=pod

=item B<FSpouse>();

Get female spouse of a node.

=cut

sub FSpouse {
    my $self = shift;
    return $self->{'FSpouse'};
}


####################################################################
#    MSpouse                                                       #
####################################################################

=pod

=item B<MSpouse>();

Get female spouse of a node.

=cut

sub MSpouse {
    my $self = shift;
    return $self->{'MSpouse'};
}

####################################################################
#    isConsanguinic                                                #
####################################################################

=pod

=item B<isConsanguinic>();

Check whether the node is consanguinic

=cut

sub isConsanguinic {
    my $self = shift;
    return $self->{'Consanguinic'};
}


####################################################################
#    SetArea                                                       #
####################################################################

=pod

=item B<SetArea>();

Calculate relative coordinates for all nodes, that are descendants of
the given node I<and> the spouses that form the marriage.  We create a
Pedigree::Area(3) around the given node and recursively apply the
function to all descendants. The subroutine 
returns the reference to the created area.

=cut

sub SetArea {
    my $self = shift;
    my $area = $self->SUPER::SetArea();

    #
    # Female is to the right, male is to the left unless we have
    # Sort Order set for anybody.  If it is set, the order
    # is OPPOSITE to the SortOrder
    #
    my ($left,$right) = ($self->MSpouse(), $self->FSpouse());
    if ($left->SortOrder() <=> $right->SortOrder()) {
	($left,$right) = 
	    sort {$a->SortOrder() <=> $b->SortOrder()} 	($left,$right);
    }
    my ($rightRoot,$gen) = @{$right->FindRoot(0,-1)};
    $rightRoot->SetRelY($gen);
    my $rightArea=$rightRoot->SetArea();
    $area->AddRight($rightArea);

    my ($leftRoot,$gen) = @{$left->FindRoot(0,1)};
    $leftRoot->SetRelY($gen);
    my $leftArea=$leftRoot->SetArea();
    $area->AddLeft($leftArea);
    
    $self->{'Area'}=$area;

    if ($main::DEBUG) {
	print STDERR "Setting area for marriage node ",$self->Id(),"\n";
	for (my $y=$area->GetYmin(); $y<=$area->GetYmax(); $y++) {
	    print STDERR "\t$y: ", $area->GetXmin($y), ", ",
	    $area->GetXmax($y), "\n";
	}
    }


    return $area;
}


####################################################################
#    CalcAbsCoor                                                   #
####################################################################

=pod

=item B<CalcAbsCoor>(I<$x>, $<y>);

Set the absolute coordinates of the given node, if the absolute
coordinates of the parent node are (I<$x>, I<$y>), and recursively
do this for all descendants of this node, and right and left clumps.

=cut

sub CalcAbsCoor {
    my $self=shift;
    my ($x,$y) = @_;
    $self->SUPER::CalcAbsCoor($x, $y);
    $x += $self->GetRelX();
    $y += $self->GetRelY();

    my ($FRoot,undef) = @{$self->FSpouse()->FindRoot(0)};
    $FRoot->CalcAbsCoor($x, $y);

    my ($MRoot,undef) = @{$self->MSpouse()->FindRoot(0)};
    $MRoot->CalcAbsCoor($x, $y);

    return 0;
}


####################################################################
#    DrawNode                                                      #
####################################################################

=pod

=item B<DrawNode>(I<$xdist>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

Output the command to draw this node.  The parameters are
distances between the nodes (in cm).

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
the spouses

=cut

sub DrawConnections {
    my $self = shift;
    my $xdist = shift;
    my $ydist = shift;
    my $result = $self->SUPER::DrawConnections($xdist, $ydist);
    my $Id=$self->Id();
    my $style="";
    if ($self->isConsanguinic()) {
	$style='doubleline=true, ';
    }
    foreach my $spouse ($self->FSpouse(), $self->MSpouse()) {
	if (!ref($spouse)) {
	    next;
	}
	my $sId=$spouse->Id();
	# Check whether spouse nodes are adjacent to the marriage node.
	# We do this check only for non-consanguinic unions
	if (!($self->isConsanguinic()) &&
	    (abs($self->GetIndexX() - $spouse->GetIndexX()) > 1)) {
	    my ($nodeA,$nodeB) = sort 
	    {$a->GetIndexX() <=> $b->GetIndexX()} ($spouse, $self);
	    my $IdA=$nodeA->Id();
	    my $IdB=$nodeB->Id();
	    $result .= 
		"\\ncloop[$style angleA=0, angleB=180, loopsize=".
		0.4*$ydist . ', arm=' . 0.4*$xdist . 
		']{'.$IdA.'}{'.$IdB.'}'."\n";
	} else {
	    $result .= "\\ncline[$style]{".$Id.'}{'.$sId.'}'."\n";
	}
    }
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

Boris Veytsman, Leila Akhmadeeva, 2006, 2007



=cut

1;
