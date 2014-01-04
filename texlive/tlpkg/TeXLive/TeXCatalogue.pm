# $Id: TeXCatalogue.pm 29762 2013-04-08 20:59:28Z karl $
# TeXLive::TeXCatalogue - module for accessing the TeX Catalogue
# Copyright 2007, 2008, 2009, 2010, 2011 Norbert Preining
# This file is licensed under the GNU General Public License version 2
# or any later version.
# 
# Loads of code taken from the catalogue checking script of Robin Fairbairns.

use XML::Parser;
use XML::XPath;
use XML::XPath::XMLParser;
use Text::Unidecode;

package TeXLive::TeXCatalogue::Entry;

my $svnrev = '$Revision: 29762 $';
my $_modulerevision;
if ($svnrev =~ m/: ([0-9]+) /) {
  $_modulerevision = $1;
} else {
  $_modulerevision = "unknown";
}
sub module_revision {
  return $_modulerevision;
}

my $_parser = XML::Parser->new(
  ErrorContext => 2,
  ParseParamEnt => 1,
  NoLWP => 1
);

sub new {
  my $class = shift;
  my %params = @_;
  my $self = {
    ioref => $params{'ioref'},
    entry => defined($params{'entry'}) ? $params{'entry'} : {},
    docs => defined($params{'docs'}) ? $params{'docs'} : {},
    name => $params{'name'},
    caption => $params{'caption'},
    description => $params{'description'},
    license => $params{'license'},
    ctan => $params{'ctan'},
    texlive => $params{'texlive'},
    miktex => $params{'miktex'},
    version => $params{'version'},
  };
  bless $self, $class;
  if (defined($self->{'ioref'})) {
    $self->initialize();
  }
  return $self;
}

sub initialize {
  my $self = shift;
  # parse all the files
  my $parser = new XML::XPath->new(ioref => $self->{'ioref'}, parser => $_parser) ||
    die "Failed to parse the given ioref";
  $self->{'entry'}{'id'} = $parser->findvalue('/entry/@id');
  $self->{'entry'}{'date'} = $parser->findvalue('/entry/@datestamp');
  $self->{'entry'}{'modder'} = $parser->findvalue('/entry/@modifier');
  $self->{'name'} = $parser->findvalue("/entry/name");
  $self->{'caption'} = beautify($parser->findvalue("/entry/caption"));
  $self->{'description'} = beautify($parser->findvalue("/entry/description"));
  $self->{'license'} = $parser->findvalue('/entry/license/@type');
  $self->{'version'} = Text::Unidecode::unidecode(
                          $parser->findvalue('/entry/version/@number'));
  $self->{'ctan'} = $parser->findvalue('/entry/ctan/@path');
  if ($parser->findvalue('/entry/texlive/@location') ne "") {
    $self->{'texlive'} = $parser->findvalue('/entry/texlive/@location');
  }
  if ($parser->findvalue('/entry/miktex/@location') ne "") {
    $self->{'miktex'} = $parser->findvalue('/entry/miktex/@location');
  }
  # parse the documentation entries
  my $docset = $parser->find('/entry/documentation');
  foreach my $node ($docset->get_nodelist) {
    my $docfile = $parser->find('./@href',$node);
    # see comments at end of beautify()
    my $details = Text::Unidecode::unidecode(
        $parser->find('./@details',$node));
    my $language = $parser->find('./@language',$node);
    $self->{'docs'}{$docfile}{'available'} = 1;
    if ($details) { $self->{'docs'}{$docfile}{'details'} = $details; }
    if ($language) { $self->{'docs'}{$docfile}{'language'} = $language; }
  }
}

sub beautify {
  my ($txt) = @_;
  $txt =~ s/\n/ /g;  # make one line
  $txt =~ s/^\s+//g; # rm leading whitespace
  $txt =~ s/\s+$//g; # rm trailing whitespace
  $txt =~ s/\s\s+/ /g; # multiple spaces to one
  # transliterate to ascii: it allows the final tlpdb to be pure ascii,
  # avoiding problems since we don't control the user's terminal encoding
  return Text::Unidecode::unidecode($txt);
}

sub name {
  my $self = shift;
  if (@_) { $self->{'name'} = shift }
  return $self->{'name'};
}
sub license {
  my $self = shift;
  if (@_) { $self->{'license'} = shift }
  return $self->{'license'};
}
sub version {
  my $self = shift;
  if (@_) { $self->{'version'} = shift }
  return $self->{'version'};
}
sub caption {
  my $self = shift;
  if (@_) { $self->{'caption'} = shift }
  return $self->{'caption'};
}
sub description {
  my $self = shift;
  if (@_) { $self->{'description'} = shift }
  return $self->{'description'};
}
sub ctan {
  my $self = shift;
  if (@_) { $self->{'ctan'} = shift }
  return $self->{'ctan'};
}
sub texlive {
  my $self = shift;
  if (@_) { $self->{'texlive'} = shift }
  return $self->{'texlive'};
}
sub miktex {
  my $self = shift;
  if (@_) { $self->{'miktex'} = shift }
  return $self->{'miktex'};
}
sub docs {
  my $self = shift;
  my %newdocs = @_;
  if (@_) { $self->{'docs'} = \%newdocs }
  return $self->{'docs'};
}
sub entry {
  my $self = shift;
  my %newentry = @_;
  if (@_) { $self->{'entry'} = \%newentry }
  return $self->{'entry'};
}


################################################################
#
# TeXLive::TeXCatalogue
#
################################################################
package TeXLive::TeXCatalogue;

sub new { 
  my $class = shift;
  my %params = @_;
  my $self = {
    location => $params{'location'},
    entries => defined($params{'entries'}) ? $params{'entries'} : {},
  };
  bless $self, $class;
  if (defined($self->{'location'})) {
    $self->initialize();
    $self->quest4texlive();
  }
  return $self;
}

sub initialize {
  my $self = shift;
  # chdir to the location of the DTD file, otherwise it cannot be found
  # furthermore we have to open the xml file from a file handle otherwise
  # the catalogue.dtd is searched in a/catalogue.dtd etc, see above
  my $cwd = `pwd`;
  chomp($cwd);
  chdir($self->{'location'} . "/entries")
  || die "chdir($self->{location}/entries failed: $!";
  # parse all the files
  foreach (glob("?/*.xml")) {
    open(my $io,"<$_") or die "open($_) failed: $!";
    our $tce;
    # the XML parser die's on malformed xml entries, so we catch
    # that and continue, simply skipping the entry
    eval { $tce = TeXLive::TeXCatalogue::Entry->new( 'ioref' => $io ); };
    if ($@) {
      printf STDERR "TeXCatalogue.pm: cannot parse $_, skipping it!\n";
      close($io);
      next;
    }
    close($io);
    $self->{'entries'}{lc($tce->{'entry'}{'id'})} = $tce;
  }
  chdir($cwd) || die ("Cannot change back to $cwd: $!");
}

# Copy every catalogue $entry under the name $entry->{'texlive'}
# if it makes sense.
# 
sub quest4texlive {
  my $self = shift;

  # The catalogue has a partial mapping from catalogue entries to
  # texlive packages: $id --> $texcat->{$id}{'texlive'}
  my $texcat = $self->{'entries'};

  # Try to build the inverse mapping:
  my (%inv, %count);
  for my $id (keys %{$texcat}) {
    my $tl = $texcat->{$id}{'texlive'};
    if (defined($tl)) {
      $tl =~ s/^bin-//;
      $count{$tl}++;
      $inv{$tl} = $id;
    }
  }
  # Go through texlive names
  for my $name (keys %inv) {
    # If this name is free and there is only one corresponding catalogue
    # entry then copy the entry under this name
    if (!exists($texcat->{$name}) && $count{$name} == 1) {
      $texcat->{$name} = $texcat->{$inv{$name}};
    }
  }
}

sub location {
  my $self = shift;
  if (@_) { $self->{'location'} = shift }
  return $self->{'location'};
}

sub entries {
  my $self = shift;
  my %newentries = @_;
  if (@_) { $self->{'entries'} = \%newentries }
  return $self->{'entries'};
}

1;
__END__


=head1 NAME

TeXLive::TeXCatalogue - Accessing the TeX Catalogue

=head1 SYNOPSIS

missing

=head1 DESCRIPTION

The L<TeXLive::TeXCatalogue> module provides access to the data stored
in the TeX Catalogue.

DOCUMENTATION MISSING, SORRY!!!

=head1 AUTHORS AND COPYRIGHT

This script and its documentation were written for the TeX Live
distribution (L<http://tug.org/texlive>) and both are licensed under the
GNU General Public License Version 2 or later.

=cut

### Local Variables:
### perl-indent-level: 2
### tab-width: 2
### indent-tabs-mode: nil
### End:
# vim:set tabstop=2 expandtab: #
