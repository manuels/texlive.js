=pod

=head1 NAME

Pedigree::Node - the base package for nodes in pedigree charts

=head1 SYNOPSIS

use Pedigree::Node;

$node = new Pedigree::Node(I<%params>);

$node->CheckAllParents();

$Id = $node->Id();

$node->SetSortOrder(-1|0|1);

$result = $node->SortOrder();

$is_numbered=$node->isNumbered();

$type = $node->Type();

$Kids = $node->Kids();

$node->GetAndSortKids();

($root, $newgen) = $node->FindRoot(I<$generation>, [I<$sort_order>]);

$x = $node->GetRelX();

$y = $node->GetRelY();

$node->SetRelX(I<$x>);

$node->SetRelX(I<$y>);

$x = $node->GetAbsX();

$y = $node->GetAbsY();

$node->SetIndexX(I<$n>);

$node->SetAbsX(I<$x>);

$node->SetAbsY(I<$y>);

$n = $node->GetIndexX();

$area = $node->SetArea();

$delta = $node->CenterKids();


$node->CalcAbsCoord(I<$x>, I<$y>);

$node->AddConsanguinicMarriages();

$node->AddTwins($ydist);

$frame = $node->SetFrame(I<$xdist>, I<$ydist>);


$node->DrawAll(I<$xdist>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>, 
	       I<@fieldsfornode>);

$node->DrawConnections();

$node->PrintAllLegends(I<$land>, I<@fields>);

$node->PrintLegend(I<$land>, I<@fields>);

=head1 DESCRIPTION

This is the basic package that defines nodes for pedigrees.
Pedigree::PersonNode(3) and Pedigree::MarriageNode(3) inherit from
this package.

=over 4

=cut

####################################################################
# Define the package                                               #
####################################################################

package Pedigree::Node;
use strict;
use Pedigree;

####################################################################
#    package variables                                             #
####################################################################

#
# The  pool: %node_by_id  keeps the relation between
# nodes and references
#

our %node_by_id;

#
# The hash %node_by_gen is a hash of hasehs.  The keys 
# are generation numbers (with zero being the root of pedigree),
# and the values are the hashes Id->node
#
our %node_by_gen;

#
# The hash %kids_by_parent_id is a hash of hashes.  The keys are 
# Ids of parents.  The hashes are $kid->1, where $kid is the kid id
# (NOT the kid node due to limitations of Perl)
#
our %kids_by_parent_id;

#
# The array @twin_sets lists all twin nodes.  Each twin node is
# a has with entries 'Type' and 'KidIds'.  They store 
# twins type (monozygotic, qzygotic or empty) and Ids of the 
# kid nodes correspondingly (KidIds is actually a hash of 
# node Ids).
#
our @twin_sets;

####################################################################
# And package methods                                              #
####################################################################

####################################################################
#    new                                                           #
####################################################################

=pod

=item B<new>(I<%params>);

Construct a new node from the given parameters.  If a node with 
the give Id exists, add new information to the node.

=cut

sub new {
    my ($class,%params)=@_;
    
    if (!exists($params{'Id'})) {
	print STDERR "Warning:  cannot create node from %params\n";
	return 0;
    }
    
    my $Id=$params{'Id'};
    my $self;
    if (exists($node_by_id{$Id})) {
	$self=$node_by_id{$Id};
    } else {
	$self={};
	bless ($self,$class);
	$node_by_id{$Id}=$self;
    }
    
    foreach my $key (keys %params) {
	$self->{$key} = $params{$key};
    }

    #
    # Calculate age at death
    #
    if (exists($self->{'DoB'}) && exists($self->{'DoD'})) {
	$self->{'AgeAtDeath'} = 'unknown';
	if (($self->{'DoB'} ne 'unknown') && 
	    ($self->{'DoD'} ne 'unknown')) {
	    my ($y1, $m1, $d1) = split /\./, $self->{'DoB'};
	    my ($y2, $m2, $d2) = split /\./, $self->{'DoD'};
	    $self->{'AgeAtDeath'} = int(($y2-$y1) + ($m2-$m1)/12
					+ ($d2-$d1)/12/30);
	}
    }
    

    #
    # Only Person Nodes are numbered in pedigrees
    #
    $self->{'Numbered'}=0;

    #
    #  The field 'Kids' is special.  This is a reference
    # to an array filled by GetAndSortKids()
    #
    if (!exists($self->{'Kids'})) {
	$self->{'Kids'}=[];
    }

    #
    # Hashes %kids_by_parent_id
    #
    if (exists($self->{'Mother'})) {
	my $parent = $self->{'Mother'};
	$kids_by_parent_id{$parent}->{$self->Id()}=1;
    }
    if (exists($self->{'Father'})) {
	my $parent = $self->{'Father'};
	$kids_by_parent_id{$parent}->{$self->Id()}=1;
    }

    #
    # Add references to the hashes
    # 

    $self->{'node_by_id'} = \%node_by_id;
    $self->{'node_by_gen'} = \%node_by_gen;
    $self->{'kids_by_parent_id'} = \%kids_by_parent_id;
    $self->{'twin_sets'} = \@twin_sets;

    #
    # Initially the nodes are sorted by age only
    #
    if (!($self->{'SortOrder'})) {
	$self->{'SortOrder'} = 0;
    }


    return $self;

}

####################################################################
#    CheckAllParents                                               #
####################################################################

=pod

=item B<CheckAllParents>();

Check whether mothers and fathers of all nodes exist

=cut

sub CheckAllParents {
    my $self = shift;

    foreach my $parentId (keys %kids_by_parent_id) {
	if (!exists($node_by_id{$parentId}) ) {
	    print STDERR 
		"Node $parentId does not exist and is listed as parent for nodes";
	    foreach my $kidId (keys %{$kids_by_parent_id{$parentId}}) {
		print STDERR " ",  $kidId;
		my $kid = $node_by_id{$kidId};
		if ($kid->{'Mother'} eq $parentId) {
		    delete $kid->{'Mother'};
		}
		if ($kid->{'Father'} eq $parentId) {
		    delete $kid->{'Father'};
		}
	    }
	    print STDERR ". Deleting\n";
	    delete $kids_by_parent_id{$parentId};
	} elsif ($main::DEBUG) {
	    print STDERR "Node $parentId is OK\n";
	}
    }
    
    return 0;
}


####################################################################
#    Id                                                            #
####################################################################

=pod

=item B<Id>();

Get Id of a node.  Note that there is no way to set an Id of a node
that was already created.

=cut

sub Id {
    my $self = shift;
    return $self->{'Id'};
}

####################################################################
#    SetSortOrder                                                  #
####################################################################

=pod

=item B<SetSortOrder>(I<-1|0|1>);

Normally the sibs nodes are sorted by age.  However, if the nodes or
their descendants are connected by a marriage line, we must sort them
in the special way: all way to the left or all way to the right.  The
procedure B<SetSortOrder> sets this flag for the node or deletes it
depending on the argument.  

=cut

sub SetSortOrder {
    my $self = shift;
    my $order = shift;
    $self->{'SortOrder'}=$order;
    return $order;
}

####################################################################
#    SortOrder                                                     #
####################################################################

=pod

=item B<SortOrder>();

Normally the sibs nodes are sorted by age.  However, if the nodes or
their descendants are connected by a marriage line, we must sort them
in the special way: all way to the left or all way to the right. The
procedure B<SortOrder> checks this flag.

=cut

sub SortOrder {
    my $self = shift;
    return $self->{'SortOrder'};
}

####################################################################
#    isNumbered                                                    #
####################################################################

=pod

=item B<isNumbered>();

Check whether the node should be numbered in pedigree

=cut

sub isNumbered {
    my $self = shift;
    return $self->{'Numbered'};
}

####################################################################
#    Type                                                          #
####################################################################

=pod

=item B<Type>()

Return node type.

=cut

sub Type {
    my $self=shift;
    return $self->{'Type'};
}



####################################################################
#    Kids                                                          #
####################################################################

=pod

=item B<Kids>();

Get the reference to the array of kids

=cut

sub Kids {
    my $self = shift;
    return $self->{'Kids'};
}


####################################################################
#    GetAndSortKids                                                #
####################################################################

=pod

=item B<GetAndSortKids>();

Apply sort the array of kids for the given node

=cut

sub GetAndSortKids {
    my $self=shift;
    my @kids;
    my $Id = $self->Id();
    foreach my $kidId (keys %{$self->{'kids_by_parent_id'}->{$Id}}) {
	push @kids, $self->{'node_by_id'}->{$kidId};
    }
    @kids = sort by_sibs_order @kids;
    $self->{'Kids'}=\@kids;
    if ($main::DEBUG) {
	print STDERR "Node ",$self->Id(),", Kids: ";
	foreach my $kid (@{$self->Kids()}) {
	    print STDERR $kid->Id(), " ";
	}
	print STDERR "\n";
    }
    return 0;
}

####################################################################
#    FindRoot                                                      #
####################################################################

=pod

=item B<FindRoot>(I<$generation>, [I<$sort_order>]);

Finds the root of the tree to which the current node belongs.  
Takes the current generation number and returns the root and its 
generation number.  Here generation numbers go "backwards":  the older
generations have higher numbers.  The found node is assigned sort order
I<$sort_order>.

=cut

sub FindRoot {
    my ($self,$gen,$sort)=@_;

    if (defined $sort && !($self->SortOrder())) {
	$self->SetSortOrder($sort);
    }

    # If there are no parents, I am the root
    if (!exists($self->{'Mother'}) && !exists($self->{'Father'}))  {
	my @result=($self,$gen);
	return \@result;
    }

    # If there are both parents, their union is the root
    if (exists($self->{'Mother'}) && exists($self->{'Father'}))  {
	my $motherId=$self->{'Mother'};
	my $mother=$node_by_id{$motherId};
	my $fatherId=$self->{'Father'};
	my $father=$node_by_id{$fatherId};
 
	
	my $marriageId = $fatherId."_m_".$motherId;
	my $marriage = 
	    new Pedigree::MarriageNode (
					'Id'=>$marriageId,
					'MSpouse'=>$father,
					'FSpouse'=>$mother
					);
	if (defined $sort) {
	    $marriage->SetSortOrder($sort);
	}
	my @result = ($marriage,$gen+1);
	return \@result;
    }
    
    # Ok, only one parent is there.  The search goes further

    my $parentId;
    if (exists($self->{'Mother'})) {
	$parentId=$self->{'Mother'};
    } else {
	$parentId=$self->{'Father'};
    }
    my $parent=$node_by_id{$parentId};
    return $parent->FindRoot($gen+1,$sort);
}

####################################################################
#    GetRelX                                                       #
####################################################################

=pod

=item B<GetRelX>();

Find the relative x coordinate of the node.  The coordinate is 
relative  to the precedessor or to the marriage node, which connects
this node to the proband

=cut

sub GetRelX {
    my $self = shift;
    return $self->{'RelX'};
}

####################################################################
#    GetRelY                                                       #
####################################################################

=pod

=item B<GetRelY>();

Find the relative Y coordinate of the node.  The coordinate is 
relative  to the precedessor or to the marriage node, which connects
this node to the proband.  Note that the Y axis is down.

=cut

sub GetRelY {
    my $self = shift;
    return $self->{'RelY'};
}


####################################################################
#    SetRelX                                                       #
####################################################################

=pod

=item B<SetRelX>(I<$x>);

Set the relative x coordinate of the node.  The coordinate is 
relative  to the precedessor or to the marriage node, which connects
this node to the proband.

=cut

sub SetRelX {
    my ($self, $x) = @_;
    $self->{'RelX'} = $x;
    return 0;
}

####################################################################
#    SetRelY                                                       #
####################################################################

=pod

=item B<SetRelY>(I<$y>);

Set the relative y coordinate of the node.  The coordinate is 
relative  to the precedessor or to the marriage node, which connects
this node to the proband.  Note that the Y axis is down.

=cut

sub SetRelY {
    my ($self, $y) = @_;
    $self->{'RelY'} = $y;
    return 0;
}

####################################################################
#    GetAbsX                                                       #
####################################################################

=pod

=item B<GetAbsX>();

Find the absolute x coordinate of the node. 

=cut

sub GetAbsX {
    my $self = shift;
    return $self->{'AbsX'};
}

####################################################################
#    GetAbsY                                                       #
####################################################################

=pod

=item B<GetAbsY>();

Find the absolute Y coordinate of the node.  

=cut

sub GetAbsY {
    my $self = shift;
    return $self->{'AbsY'};
}

####################################################################
#    GetIndexX                                                     #
####################################################################

=pod

=item B<GetIndexX>();

Find the number of the node in the given generation.

=cut

sub GetIndexX {
    my $self = shift;
    return $self->{'IndexX'};
}



####################################################################
#    SetAbsX                                                       #
####################################################################

=pod

=item B<SetAbsX>(I<$x>);

Set the absolute x coordinate of the node.  

=cut

sub SetAbsX {
    my ($self, $x) = @_;
    $self->{'AbsX'} = $x;
    return 0;
}

####################################################################
#    SetAbsY                                                       #
####################################################################

=pod

=item B<SetAbsY>(I<$y>);

Set the absolute y coordinate of the node.  

=cut

sub SetAbsY {
    my ($self, $y) = @_;
    $self->{'AbsY'} = $y;
    return 0;
}


####################################################################
#    SetIndexX                                                     #
####################################################################

=pod

=item B<SetIndexX>(I<$n>);

Set the number of the node in the given generation.

=cut

sub SetIndexX {
    my ($self, $n) = @_;
    $self->{'IndexX'} = $n;
    return 0;
}



####################################################################
#    SetArea                                                       #
####################################################################

=pod

=item B<SetArea>();

Calculate relative coordinates for all nodes, that are descendants of 
the given node.  We create a Pedigree::Area(3) around the given node
and recursively apply the function to all descendants.  The subroutine 
returns the reference to the created area.

=cut

sub SetArea {
    my $self = shift;
    $self->GetAndSortKids();
    my $area = new Pedigree::Area ($self);
    foreach my $kid (@{$self->Kids()}) {
	my $kidarea = $kid->SetArea();
	$kid->SetRelY(-1);
	$area->AddRight($kidarea);
    }
    #
    # We want the node to be the center of siblings
    # subtrees
    #
    my $deltaX=$self->CenterKids();
    $area->MoveLowerLayers($deltaX);
    if ($main::DEBUG) {
	print STDERR "Setting area for ",$self->Id(),"\n";
	for (my $y=$area->GetYmin(); $y<=$area->GetYmax(); $y++) {
	    print STDERR "\t$y: ", $area->GetXmin($y), ", ",
	    $area->GetXmax($y), "\n";
	}
    }
    $self->{'Area'} = $area;
    return $area;
}

####################################################################
#    CenterKids                                                    #
####################################################################

=pod

=item B<CenterKids>();

Move the relative coordinates of all the kids of the given node
so the given node is centered in relation to the kids.  Returns
the shift to be applied to the Pedigree::Area(3).

=cut

sub CenterKids {
    my $self=shift;
    my $nKids=scalar @{$self->Kids()};
    if ($nKids < 2) {  # One or no kids - no need to center
	return 0;
    }
    my $x0 = $self->Kids()->[0]->GetRelX();
    my $x1 = $self->Kids()->[$nKids-1]->GetRelX();
    my $delta = -($x0+$x1)/2;
    foreach  my $kid (@{$self->Kids()}) {
	$kid->SetRelX($kid->GetRelX()+$delta);
    }
    return $delta;
}


####################################################################
#    CalcAbsCoor                                                   #
####################################################################

=pod

=item B<CalcAbsCoor>(I<$x>, $<y>);

Set the absolute coordinates of the given node, if the absolute
coordinates of the parent node are (I<$x>, I<$y>), and recursively
do this for all descendants of this node.   Additionally set up 
B<%node_by_gen>.

=cut

sub CalcAbsCoor {
    my $self=shift;
    my ($x,$y) = @_;
    $x += $self->GetRelX();
    $y += $self->GetRelY();
    #
    # Consanguinic kids may be already set
    #
    if (!exists($self->{'AbsY'}) || $self->{'AbsY'} > $y) {
	$self->SetAbsX($x);
	$self->SetAbsY($y);
	foreach my $kid (@{$self->Kids()}) {
	    $kid->CalcAbsCoor($x,$y);
	}
	$node_by_gen{$y}->{$self->Id()}= $self;
	if ($main::DEBUG) {
	    print STDERR "Abs Coords for ", $self->Id(), ": $x, $y\n";
	}
    } else {
	if ($main::DEBUG) {
	    print STDERR "Not setting abs coords for ",$self->Id(),"\n";
	}
    }

    return 0;
}


####################################################################
#    AddConsanguinicMarriages                                      #
####################################################################

=pod

=item B<AddConsanguinicMarriages>();

Check the pedigree and add consanguinic marriages to it.  Note
that this procedure must be called B<after> L<SetAbsCoor>, so 
the coordinates of all nodes are set.

=cut

#
# This is rather a hack.  Basically we think that a union is 
# consanguinic if the spouses are already set in the pedigree.
# We check all kids which are in the pedigree and add those
# who have both mother and father that list them as kids.
#

sub AddConsanguinicMarriages {
    my $self = shift;
    foreach my $gen (keys %node_by_gen) {
	foreach my $kid (values %{$node_by_gen{$gen}}) {
	    if (!exists($kid->{'Mother'}) || 
		!exists($kid->{'Father'})) {
		next;  # kid
	    }
	    my $motherId=$kid->MotherId();
	    my $fatherId=$kid->FatherId();
	    my $mother=$node_by_id{$motherId};
	    my $father=$node_by_id{$fatherId};
	    if (!exists($mother->{'AbsX'}) ||
		!exists($father->{'AbsX'})) {
		next;  # kid
	    }
	    if (exists($node_by_id{$fatherId."_m_".$motherId})) {
		next; # kid
	    }
	    #
	    # If we are here, we found a consangunic marriage!
	    #
	    if ($main::DEBUG) {
		print STDERR "Found a consanguinic marriage between ",
		"$fatherId and $motherId.  The kid is ", 
		$kid->Id(), "\n";
	    }
	    my $marriageId=$fatherId."_m_".$motherId;
	    my $marriage=
		new Pedigree::MarriageNode (
					    Id=>$marriageId,
					    'Consanguinic'=>1,
					    'FSpouse'=>$mother,
					    'MSpouse'=>$father
					    );
	    #
	    # We set up this node in the middle between father
	    # and mother
	    #
	    $marriage->SetAbsX(($father->GetAbsX()+$mother->GetAbsX())/2);
	    $marriage->SetAbsY(($father->GetAbsY()+$mother->GetAbsY())/2);
	    $node_by_gen{$marriage->GetAbsY()}->{$marriageId}= $marriage;
	    
	    #
	    # Repopulate parents' kids
	    # 
	    $mother->GetAndSortKids();
	    $father->GetAndSortKids();

	    #
	    # We would like to make the kids to belong to this marriage,
	    # but it might be wrong:  it might be in the wrong generation!
	    # Let is check it
	    if (($marriage->GetAbsY() - $kid->GetAbsY()) == 1) { 
		$marriage->GetAndSortKids();
	    } else {
		#
		# Ok, we need an additional node.  It has the same
		# abscissa as $marriage, but is one generation above kids
		#
		my $marriage1Id=$fatherId."_m1_".$motherId;
		my $marriage1 =
		    new Pedigree::MarriageNode (
						Id=>$marriage1Id,
						'Consanguinic'=>1,
						);
		$marriage1->SetAbsX($marriage->GetAbsX());
		$marriage1->SetAbsY(1+$kid->GetAbsY());
		$node_by_gen{$marriage1->GetAbsY()}->{$marriage1Id}= 
		    $marriage1;
		#
		# Now we transfer kids
		#
		$kids_by_parent_id{$marriage1Id} =
		    $kids_by_parent_id{$marriageId};
		delete $kids_by_parent_id{$marriageId};
		$kids_by_parent_id{$marriageId}->{$marriage1Id}=1;
		$marriage->GetAndSortKids();
		$marriage1->GetAndSortKids();
	    }
  	}
    }
}


####################################################################
#    AddTwins                                                      #
####################################################################

=pod

=item B<AddTwins>(I<$ydist>);

Check the pedigree and add twin nodes.  Note
that this procedure must be called B<after> L<SetAbsCoor> and
L<AddConsanguinicMarriages>.

=cut

sub AddTwins {
    my $self = shift;
    my $ydist= shift;
    #
    # First, delete all kids from $twin_sets, for which there
    # are no nodes
    #
    foreach my $set (@twin_sets) {
	foreach my $kidId (keys %{$set->{'KidIds'}}) {
	    if (!exists($node_by_id{$kidId})) {
		delete $set->{'KidIds'}->{$kidId};
		if ($main::DEBUG) {
		    print STDERR "Bad node \"$kidId\" in twin sets\n";
		}
	    }
	}
    }

    #
    # Now we are ready to check for twins
    #
    foreach my $gen (keys %node_by_gen) {
	foreach my $parentId (keys %{$node_by_gen{$gen}}) {
	    foreach my $kidId (keys %{$kids_by_parent_id{$parentId}}) {
		for (my $i=0; $i<scalar @twin_sets; $i++) {
		    if (exists $twin_sets[$i]->{'KidIds'}->{$kidId}) {
			my @kidIds = keys %{$twin_sets[$i]->{'KidIds'}};
			my $type = $twin_sets[$i]->{'Type'};
			my $twinsId = 't_'.join('_',@kidIds);
			my $twinsNode = 
			     Pedigree::TwinsNode->new (
						     'Id'=>$twinsId,
						     'Type'=>$type,
						     'ParentId'=>$parentId,
						     'KidIds'=>
						     $twin_sets[$i]->{'KidIds'}
						     );
			#
			# Change kids
			#
			my $parent = $node_by_id{$parentId};
			$parent->GetAndSortKids();
			$twinsNode->GetAndSortKids();

			#
			# Now the coordinates of the node.
			# It is centered over kids nodes and 0.24 $ydist above
			#
			my @kids = sort {$a->GetAbsX() <=>
					     $b->GetAbsX()}
			   @{$twinsNode->Kids()};
			my $leftKid=$kids[0];
			my $rightKid=$kids[scalar(@kids)-1];
			$twinsNode->SetAbsX(($leftKid->GetAbsX() +
					     $rightKid->GetAbsX())/2.0);
			$twinsNode->SetAbsY($leftKid->GetAbsY() +
					    0.2*$ydist);
			$node_by_gen{$twinsNode->GetAbsY()}->
			{$twinsId}= $twinsNode;
			
			#
			# There is no need to keep this in the twins set
			#
			splice @twin_sets, $i,1;
			last;  # twin_sets
		    }
		}
	    }
	}
    }
    return 0;
}





####################################################################
#    SetFrame                                                      #
####################################################################

=pod

=item B<SetFrame>(I<$xidst>, I<$ydist>);

Calculate the frame:  coordinates of the lower left and upper right
corners of the picture (in ps units).  As a side effect, add generation
numbers to each person node and calculate the X index of each node. 

=cut

sub SetFrame {
    my $self=shift;
    my ($xdist, $ydist) = @_;
    
    my $xmin=0;
    my $xmax=0;

    my @sorted_gens = sort {$b <=> $a}  keys %node_by_gen;
    my $ymin=$sorted_gens[(scalar @sorted_gens) -1];
    my $ymax=$sorted_gens[0];
    #
    # The names of the nodes look like I:1, V:5.  Let the
    # first number be $i, and the second one be $j.
    # IndexX is different from $j by the fact that marriage nodes
    # are not skipped.
    #
    my $i=1;
    foreach my $gen (@sorted_gens) {
	my $roman=roman_num($i);
	my @sorted_nodes = 
	    sort {$a->GetAbsX() <=> $b->GetAbsX()} values %{$node_by_gen{$gen}};
	my $num_nodes= scalar @sorted_nodes;
	if ($sorted_nodes[0]->GetAbsX()<$xmin) {
	    $xmin=$sorted_nodes[0]->GetAbsX();
	}
	if ($sorted_nodes[$num_nodes-1]->GetAbsX()>$xmax) {
	    $xmax=$sorted_nodes[$num_nodes-1]->GetAbsX();
	}
	my $j=1;
	my $indexX=1;
	foreach my $node (@sorted_nodes) {
	    $node->SetIndexX($indexX);
	    if ($main::DEBUG) {
		print STDERR "Node ", $node->Id(), ", index ",
		$node->GetIndexX(), "\n";
	    }
	    $indexX++;
	    if ($node->isNumbered()) {
		$node->SetGenName("$roman:$j");
		if ($main::DEBUG) {
		    print STDERR $node->Id(), ": ", $node->GetGenName(),
		    "\n";
		}
		$j++;
	    }
	}
	#
	# The fractional "generations" are for twin nodes
	# and consanguinic marriage nodes.  
	#
	if ($gen == int($gen)) {
	    $i++;
	}
    }
    my @result = ($xdist*($xmin-1), $ydist*($ymin-1),
		  $xdist*($xmax+1), $ydist*($ymax+1));
    return \@result;
}



####################################################################
#    DrawConnections                                               #
####################################################################

=pod

=item B<DrawConnections>();

Draw the connections from the given node to its descendants

=cut

sub DrawConnections {
    my $self = shift;
    my $xdist = shift;
    my $ydist = shift;
    my $result;
    my $Id=$self->Id;
    foreach my $kid (@{$self->Kids()}) {
	my $kidId = $kid->Id();
	$result .= '\pstDescent{'.$Id.'}{'.$kidId.'}'."\n";
    }
    return $result;
}





####################################################################
#    DrawAll                                                       #
####################################################################

=pod

=item B<DrawAll>(I<$xdist>, I<$ydist>, I<$belowtextfont>, 
		 I<$abovetextfont>, I<@fieldsfornode>);

Draw all nodes and connections in the form suitable for
pspicture

=cut

sub DrawAll {
    my ($self, $xdist, $ydist, $belowtextfont,
	$abovetextfont, @fieldsfornode) = @_;

    #
    # Commands to draw nodes
    # 
    my $nodes;  
    
    #
    # Commands to draw connections
    #
    my $connections;


    foreach my $gen (keys %node_by_gen) {
	foreach my $node (values %{$node_by_gen{$gen}}) {
	    #
	    #  We draw only the nodes, who belong to the right
	    # generation (consanguinity may lead to duplicate nodes
	    #
	    #
	    if ($node->GetAbsY() <=> $gen) {
		delete $node_by_gen{$gen}->{$node->Id()};
		next;
	    }

	    $nodes .= $node->DrawNode($xdist, $ydist, 
				      $belowtextfont, $abovetextfont,
				      @fieldsfornode);
	    $connections .=$node->DrawConnections($xdist, $ydist);
	}
    }
    return $nodes.$connections;
}

####################################################################
#    PrintAllLegends                                               #
####################################################################

=pod

=item B<PrintAllLegends>(I<$lang>, I<@fields>);

Print legend for all the nodes.  The first parameter is the
language, the other is the fields to be included in the legend.

=cut

sub PrintAllLegends {
    my ($self, $lang, @fields) = @_;

    my $result="\n\\begin{description}\n";

    foreach my $gen (sort {$b <=> $a} keys(%node_by_gen)) {
	foreach my $node 
	    (sort {$a->GetIndexX() <=> $b->GetIndexX()}
	     values(%{$node_by_gen{$gen}})) {
	    $result .= $node->PrintLegend($lang,@fields);
	}
    }

    $result .= "\\end{description}\n";

    return $result;
}


####################################################################
#    PrintLegend                                                   #
####################################################################

=pod

=item B<PrintLegend>(I<$lang>, I<@fields>);

This subroutine does nothing:  a generic node has no legend.  It
is overriden by Pedigree::PersonNode(3) and Pedigree::AbortionNode(3).

=cut

sub PrintLegend {

    return;
}




####################################################################
#    by_sibs_order                                                 #
####################################################################

#
# Internal procedure for sorting kids
#

sub by_sibs_order {
    #
    # We compare sort order, and if it is the same, DoB
    #
    return ($a->SortOrder() <=> $b->SortOrder()) ||
	($a->DoB() cmp $b->DoB());
}

####################################################################
#    roman_num                                                     #
####################################################################

#
# Internal procedure for roman numerals
#

sub roman_num {
    my $i=shift;
    my @nums=qw(0 I II III IV V VI VII VIII IX X XI XII XIII XIV XV 
		XVI XVII XVIII XIX XX XXI XXII XXIII XXIV);
    return $nums[$i];
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
