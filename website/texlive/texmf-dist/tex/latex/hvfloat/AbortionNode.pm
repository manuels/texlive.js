=pod

=head1 NAME

Pedigree::AbortionNode - an abortion in a pedigree

=head1 SYNOPSIS

use Pedigree::AbortionNode;

$node = new Pedigree::AbortionNode(I<%params>);

$node->DrawNode(I<$xidst>, I<$ydist>, I<$belowtextfont>, I<$abovetextfont>,
I<@fieldsfornode>);

$node->PrintLegend(I<$land>, I<@fields>);

=head1 DESCRIPTION

This package contains data about an abortion.  Abortion is like a person,
but it cannot have kids, and it is drawn differently

=over 4

=cut



####################################################################
# Define the package                                               #
####################################################################

package Pedigree::AbortionNode;
use Pedigree;
use strict;
our @ISA=('Pedigree::PersonNode');



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
	($ydist*$self->GetAbsY()).'){\pstAbortion[';
    my @opts=($self->Condition(), 
	      'belowtext={'."$belowtextfont ".$self->GetGenName().'}');
    if ($self->Type() eq 'sab') {
	push @opts, 'sab';
    }
    my @abovetext;
    if ($self->Sex() ne 'unknown') {
	push @abovetext, $self->Sex();
    }
    foreach my $field (@fieldsfornode) {
	if (($field ne 'Sex') && ($field ne 'Name')) {
	    push @abovetext, $self->{$field};
	}
    }
    if (scalar @abovetext) {
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
language I<$lang>, and excluding the fields, that have no meaning for
this node.


=cut

sub PrintLegend {
    my ($self, $lang, @fields) = @_;
    my $result = '\item['.$self->GetGenName().'] ';
    my @desc;
    foreach my $field (@fields) {
	if (exists $self->{$field} && ($field ne 'DoD') &&
	    ($field ne 'AgeAtDeath')) {
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

pedigree(1),  Pedigree(3)


=head1  AUTHOR

Boris Veytsman, Leila Akhmadeeva, 2007



=cut

1;
