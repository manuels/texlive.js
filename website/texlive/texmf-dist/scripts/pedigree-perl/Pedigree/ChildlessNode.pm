=pod

=head1 NAME

Pedigree::ChildlessNode - an abortion in a pedigree

=head1 SYNOPSIS

use Pedigree::ChildlessNode;

$node = new Pedigree::ChildlessNode(I<%params>);

$node->DrawNode(I<$xidst>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

$node->PrintLegend(I<$land>, I<@fields>);


=head1 DESCRIPTION

This package contains data about a "childlessness" node.  This node
is not numbered in pedigree.

=over 4

=cut



####################################################################
# Define the package                                               #
####################################################################

package Pedigree::ChildlessNode;
use Pedigree;
use strict;
our @ISA=('Pedigree::PersonNode');

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
    # These nodes are NOT numbered in pedigrees
    #

    $self->{'Numbered'}=0;

    return $self;

}


####################################################################
#    DrawNode                                                      #
####################################################################

=pod

=item B<DrawNode>(I<$xdist>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

Output the command to draw this node.  The parameters are
distances between the nodes (in cm) and fields for abovetext (not used
here).  We only print the Comment field below the node, and draw this
node higher than other nodes.

=cut

sub DrawNode {
    my $self=shift;
    my ($xdist, $ydist, $belowtextfont, $abovetextfont, @fieldsfornode) = @_;
    my $result = '\rput('.($xdist*$self->GetAbsX()).", ".
	($ydist*($self->GetAbsY()+0.6)).'){\pstChildless[';
    my @opts=('belowtextrp=t');
    if ($self->{'Comment'}) {
	push @opts,
	'belowtext={'."$belowtextfont ".$self->{'Comment'}.'}';
    }
    if ($self->Type() eq 'infertile') {
	push @opts, 'infertile';
    }
    if (scalar @opts) {
	$result .= join(', ',@opts);
    }
    $result .= ']{'.$self->Id()."}}\n";
    return $result;
}

####################################################################
#    PrintLegend                                                   #
####################################################################

=pod

=item B<PrintLegend>(I<$lang>, I<@fields>);

This subroutine does nothing since childlessness has no legend.

=cut

sub PrintLegend {

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

pedigree(1),  Pedigree(3)


=head1  AUTHOR

Boris Veytsman, Leila Akhmadeeva, 2007



=cut

1;
