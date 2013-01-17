=pod

=head1 NAME

Pedigree::PersonNode - a person in a pedigree

=head1 SYNOPSIS

use Pedigree::PersonNode;

$node = new Pedigree::PersonNode(I<%params>);

$Id = $node->MotherId();
$Id = $node->FatherId();

$isProband = $node->isProband();

$sex = $node->Sex();

$DoB = $node->DoB();

$DoD = $node->DoD();

$cond = $node->Condition();

$GenName = $node->GetGenName();

$node->SetGenName(I<$name>);

$node->DrawNode(I<$xidst>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>, 
I<@fieldsfornode>);

$node->PrintLegend(I<$land>, I<@fields>);

=head1 DESCRIPTION

This package contains data about a person.

=over 4

=cut

####################################################################
# Define the package                                               #
####################################################################

package Pedigree::PersonNode;
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

    if (!ref($self)) {
	return 0;
    }

    #
    # Only Person Nodes are numbered in pedigrees
    #

    $self->{'Numbered'}=1;

    #
    # Now Twins...
    # 

    if (exists $self->{'Twins'}) {
	my $Id=$self->{'Id'};
	my $string = $self->{'Twins'};
	$string =~ s/^\s*//;
	$string =~ s/\s*$//;
	my @twinIds=($Id, split (/[\s,;]+/, $string));
	if ($main::DEBUG) {
	    print STDERR "Found twins: ", join(', ',@twinIds), "\n";
	}
	my $found=0;
	for (my $i=0; $i<scalar @{$self->{'twin_sets'}}; $i++) {
	    if (exists $self->{'twin_sets'}->[$i]->{'KidIds'}->{$Id}) {
		$found=1;
		foreach my $kidId (@twinIds) {
		    $self->{'twin_sets'}->[$i]->{'KidIds'}->{$kidId}=1;
		}
		if ($main::DEBUG) {
		    print STDERR "Added to twin set number $i\n";
		}
		last;  # twin_set
	    }
	}              
	if (!$found) { # Add twin set
	    my $set;
	    $set->{'Type'} = $self->{'Type'};
	    foreach my $kidId (@twinIds) {
		$set->{'KidIds'}->{$kidId}=1;
	    }
	    push @{$self->{'twin_sets'}}, $set;
	    if ($main::DEBUG) {
		print STDERR "Started a new twin set number ",
		scalar(@{$self->{'twin_sets'}})-1, "\n";
	    }
	}
    }

    return $self;

}


####################################################################
#    MotherId                                                      #
####################################################################

=pod

=item B<MotherId>();

Return Mother Id.

=cut

sub MotherId {
    my $self=shift;
    return $self->{'Mother'};
}

####################################################################
#    FatherId                                                      #
####################################################################

=pod

=item B<FatherId>();

Return Father Id.

=cut

sub FatherId {
    my $self=shift;
    return $self->{'Father'};
}


####################################################################
#    isProband                                                     #
####################################################################

=pod

=item B<isProband>();

Return 1 if the pesron is a Proband and zero otherwise

=cut

sub isProband {
    my $self=shift;
    if ($self->{Proband} == 1) {
	return 1;
    } else {
	return 0;
    }
}

####################################################################
#    Sex                                                           #
####################################################################

=pod

=item B<Sex>();

Get the sex of the node

=cut

sub Sex {
    my $self = shift;
    return $self->{'Sex'};
}

####################################################################
#    DoB                                                           #
####################################################################

=pod

=item B<DoB>();

Get the DoB of the node

=cut

sub DoB {
    my $self = shift;
    return $self->{'DoB'};
}

####################################################################
#    DoB                                                           #
####################################################################

=pod

=item B<DoD>();

Get the DoB of the node

=cut

sub DoD {
    my $self = shift;
    return $self->{'DoD'};
}

####################################################################
#    Condition                                                     #
####################################################################

=pod

=item B<Condition>();

Returns node conditon.

=cut

sub Condition {
    my $self=shift;
    return $self->{'Condition'};
}


####################################################################
#    GetGenName                                                    #
####################################################################

=pod

=item B<GetGenName>();

Find the generation name for the node

=cut

sub GetGenName {
    my $self = shift;
    return $self->{'GenName'};
}


####################################################################
#    SetGenName                                                    #
####################################################################

=pod

=item B<SetGenName>(I<$name>);

Set the generation name of the node

=cut

sub SetGenName {
    my ($self, $name) = @_;
    $self->{'GenName'} = $name;
    return 0;
}


####################################################################
#    DrawNode                                                      #
####################################################################

=pod

=item B<DrawNode>(I<$xdist>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

Output the command to draw this node.  The parameters are
distances between the nodes (in cm) and fields for abovetext.

=cut

sub DrawNode {
    my $self=shift;
    my ($xdist, $ydist, $belowtextfont, $abovetextfont, @fieldsfornode) = @_;
    my $result = '\rput('.($xdist*$self->GetAbsX()).", ".
	($ydist*$self->GetAbsY()).'){\pstPerson[';
    my @opts=($self->Sex(), $self->Condition(),
	      'belowtext={'."$belowtextfont ".$self->GetGenName().'}');
    if (length($self->DoD())>0) {
	push @opts, 'deceased';
    }
    if ($self->isProband()) {
	push @opts, 'proband';
    }
    if (scalar @fieldsfornode) {
	my @abovetext;
	foreach my $field (@fieldsfornode) {
	    push @abovetext, $self->{$field};
	}
	push @opts,'abovetext={'."$abovetextfont ".join('; ',@abovetext).'}';
    }
    $result .= join(', ',@opts);
    $result .= ']{'.$self->Id()."}}\n";
    return $result;
}

####################################################################
#    PrintLegend                                                   #
####################################################################

=pod

=item B<PrintLegend>(I<$lang>, I<@fields>);

Print the legend for the given node, including I<@fields> in the given
language I<$lang>.

=cut

sub PrintLegend {
    my ($self, $lang, @fields) = @_;
    my $result = '\item['.$self->GetGenName().'] ';
    my @desc;
    foreach my $field (@fields) {
	if (exists $self->{$field}) {
	    my $res = $lang->PrintField($field, $self->{$field});
	    if (length($res)>0) {
		push @desc, $res;
	    }
	}
    }
    $result .= join ("; ",@desc);
    $result .= ".\n";
    #
    # We print only the nodes, for which there is an information
    #
    if (scalar @desc) {
	return $result;
    }
    return;
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
