=pod

=head1 NAME

Pedigree::Area - Calculate the area taken by a tree or a clump

=head1 SYNOPSIS

use Pedigree::Area;

$area = new Pedigree::Area($node);

$Ymin=$area->GetYmin();

$area->SetYmin($Ymin);

$Ymax=$area->GetYmax();

$area->SetYmax($Ymax);

$Xmin=$area->GetXmin($y);

$area->SetXmin($y,$x);

$Xmax=$area->GetXmax($y);

$area->SetXmax($y,$x);

$area->AddRight($otherarea);

$area->AddLeft($otherarea);

$rootnode=$area->GetRootNode();

$area->MoveLowerLayers($x);

=head1 DESCRIPTION

The algorithm of pedigree(1) uses the notion of area:  a part of
a picture taken by a tree or a clump.  This package implements this
notion.

Each Area has B<rootnode> - the reference node for all calculations.
All distances are calculated as relative to the coordinates of the
B<rootnode>.  

The units are distances between the nodes in X and Y direction.  The 
Y axis is I<downward>:  the earlier generations have smaller Y 
coordinates.

=over 4

=cut

####################################################################
# Define the package                                               #
####################################################################

package Pedigree::Area;
use strict;


####################################################################
#    new                                                           #
####################################################################

=pod

=item B<new>(I<$rootnode>);

Construct a new area around the given rootnode

=cut

sub new {
    my ($class, $node) = @_;
    my $self={};
    #
    # Top and bottom in the Y direction
    #
    $self->{'Ymin'}=0;
    $self->{'Ymax'}=0;
    #
    # Hashes of Xmin and Xmax
    #
    $self->{'Xmin'}->{0}=0;
    $self->{'Xmax'}->{0}=0;
    $self->{'RootNode'}=$node;
    bless ($self, $class);
    return $self;
    
}

####################################################################
#    GetYmin                                                       #
####################################################################

=pod

=item B<GetYmin>();

Get the lower bound of the area.

=cut

sub GetYmin {
    my $self = shift;
    return $self->{'Ymin'};
}

####################################################################
#    SetYmin                                                       #
####################################################################

=pod

=item B<SetYmin>(I<$y>);

Set the lower bound of the area.

=cut

sub SetYmin {
    my $self = shift;
    my $y=shift;
    $self->{'Ymin'}=$y;
    return $y;
}

####################################################################
#    GetYmax                                                       #
####################################################################

=pod

=item B<GetYmax>();

Get the upper bound of the area.

=cut

sub GetYmax {
    my $self = shift;
    return $self->{'Ymax'};
}

####################################################################
#    SetYmax                                                       #
####################################################################

=pod

=item B<SetYmax>(I<$y>);

Set the upper bound of the area.

=cut

sub SetYmax {
    my $self = shift;
    my $y=shift;
    $self->{'Ymax'}=$y;
    return $y;
}

####################################################################
#    GetXmin                                                       #
####################################################################

=pod

=item B<GetXmin>(I<$y>);

Get the minimal X coordinate of the area on the level Y.

=cut

sub GetXmin {
    my $self = shift;
    my $y=shift;
    return $self->{'Xmin'}->{$y};
}

####################################################################
#    SetXmin                                                       #
####################################################################

=pod

=item B<SetXmin>(I<$y, $x>);

Set the minimal X coordinate of the area on the level Y.

=cut

sub SetXmin {
    my $self = shift;
    my $y=shift;
    my $x=shift;
    $self->{'Xmin'}->{$y}=$x;
    return $x;
}

####################################################################
#    GetXmax                                                       #
####################################################################

=pod

=item B<GetXmax>(I<$y>);

Get the maximal X coordinate of the area the the level Y.

=cut

sub GetXmax {
    my $self = shift;
    my $y=shift;
    return $self->{'Xmax'}->{$y};
}

####################################################################
#    SetXmax                                                       #
####################################################################

=pod

=item B<SetXmax>(I<$y, $x>);

Set the maximal X coordinate of the area the the level Y.

=cut

sub SetXmax {
    my $self = shift;
    my $y=shift;
    my $x=shift;
    $self->{'Xmax'}->{$y}=$x;
    return $x;
}


####################################################################
#    AddRight                                                      #
####################################################################

=pod

=item B<AddRight>(I<$otherarea>);

Add the new area I<$otherarea> to the given area at the right.  The
"other area" should have a root node that is relative to our root
node.  The relative Y of the other root node is used, the relative
X is set.

=cut

sub AddRight {
    my ($self, $other) = @_;
    my $deltaY = $other->GetRootNode()->GetRelY();

    #
    # First, we calculate the intersection of two areas
    # It is between max(Y_{min,1}, Y_{min,2}+deltaY)
    # and min(Y_{max,1}, Y_{max,2}+deltaY)
    #
    my $intMin=$self->GetYmin();
    if ($other->GetYmin()+$deltaY > $intMin) {
	$intMin = $other->GetYmin()+$deltaY;
    }
    my $intMax = $self->GetYmax();
    if ($other->GetYmax()+$deltaY < $intMax) {
	$intMax=$other->GetYmax()+$deltaY;
    }

    #
    # Now we are ready to calculate relative X shift
    #
    my $deltaX=0;
    for (my $y=$intMin;  $y<=$intMax;  $y++) {
	my $x0 = $self->GetXmax($y);
	my $x1 = $other->GetXmin($y-$deltaY);
	if ($x1 + $deltaX - $x0 <1) {
	    $deltaX = 1 + $x0 - $x1;
	}
    }
    #
    # And set the relative X
    #
    $other->GetRootNode()->SetRelX($deltaX);
    
    #
    # Now we recalculate our area
    #
    for (my $y=$intMin;  $y<=$intMax;  $y++) {
	$self->SetXmax($y, $other->GetXmax($y-$deltaY) + $deltaX);
    }
    if ($other->GetYmin()+$deltaY < $self->GetYmin()) {
	for (my $y=$other->GetYmin()+$deltaY; $y<$self->GetYmin(); $y++) {
	    $self->SetXmin($y, $other->GetXmin($y-$deltaY)+$deltaX);
	    $self->SetXmax($y, $other->GetXmax($y-$deltaY)+$deltaX);
	}
	$self->SetYmin($other->GetYmin()+$deltaY);
    }
    if ($other->GetYmax()+$deltaY > $self->GetYmax()) {
	for (my $y=$self->GetYmax()+1; $y<=$other->GetYmax()+$deltaY; $y++) {
	    $self->SetXmin($y, $other->GetXmin($y-$deltaY)+$deltaX);
	    $self->SetXmax($y, $other->GetXmax($y-$deltaY)+$deltaX);
	}
	$self->SetYmax($other->GetYmax()+$deltaY);
    }
}

####################################################################
#    AddLeft                                                       #
####################################################################

=pod

=item B<AddLeft>(I<$otherarea>);

Add the new area I<$otherarea> to the given area at the left.  The
"other area" should have a root node that is relative to our root
node.  The relative Y of the other root node is used, the relative
X is set.

=cut

sub AddLeft {
    my ($self, $other) = @_;
    my $deltaY = $other->GetRootNode()->GetRelY();

    #
    # First, we calculate the intersection of two areas
    # It is between max(Y_{min,1}, Y_{min,2}+deltaY)
    # and min(Y_{max,1}, Y_{max,2}+deltaY)
    #
    my $intMin=$self->GetYmin();
    if ($other->GetYmin()+$deltaY > $intMin) {
	$intMin = $other->GetYmin()+$deltaY;
    }
    my $intMax = $self->GetYmax();
    if ($other->GetYmax()+$deltaY < $intMax) {
	$intMax=$other->GetYmax()+$deltaY;
    }

    #
    # Now we are ready to calculate relative X shift
    #
    my $deltaX=0;
    for (my $y=$intMin;  $y<=$intMax;  $y++) {
	my $x0 = $other->GetXmax($y-$deltaY);
	my $x1 = $self->GetXmin($y);
	if ($x1 + $deltaX - $x0 <1) {
	    $deltaX = 1 + $x0 - $x1;
	}
    }
    #
    # And set the relative X
    #
    $other->GetRootNode()->SetRelX(-$deltaX);
    
    #
    # Now we recalculate our area
    #
    for (my $y=$intMin;  $y<=$intMax;  $y++) {
	$self->SetXmin($y, $other->GetXmin($y-$deltaY) - $deltaX);
    }
    if ($other->GetYmin()+$deltaY < $self->GetYmin()) {
	for (my $y=$other->GetYmin()+$deltaY; $y<$self->GetYmin(); $y++) {
	    $self->SetXmin($y, $other->GetXmin($y-$deltaY)-$deltaX);
	    $self->SetXmax($y, $other->GetXmax($y-$deltaY)-$deltaX);
	}
	$self->SetYmin($other->GetYmin()+$deltaY);
    }
    if ($other->GetYmax()+$deltaY > $self->GetYmax()) {
	for (my $y=$self->GetYmax()+1; $y<=$other->GetYmax()+$deltaY; $y++) {
	    $self->SetXmin($y, $other->GetXmin($y-$deltaY)-$deltaX);
	    $self->SetXmax($y, $other->GetXmax($y-$deltaY)-$deltaX);
	}
	$self->SetYmax($other->GetYmax()+$deltaY);
    }
}

####################################################################
#    GetRootNode                                                   #
####################################################################

=pod

=item B<GetRootNode>();

Return the root node of the area.

=cut

sub GetRootNode {
    my $self = shift;
    return $self->{'RootNode'};
}

####################################################################
#    MoveLowerLayers                                               #
####################################################################

=pod

=item B<MoveLowerLayers>(I<$x>);

Shift the lower layers (>0) of the area in the X direction by I<$x>

=cut

sub MoveLowerLayers {
    my $self = shift;
    my $x=shift;
    for (my $y=-1;  $y>=$self->GetYmin; $y--) {
	$self->SetXmin($y, $self->GetXmin($y)+$x);
	$self->SetXmax($y, $self->GetXmax($y)+$x);
    }
    return 0;
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
