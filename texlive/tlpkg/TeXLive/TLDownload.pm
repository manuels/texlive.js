# $Id: TLDownload.pm 30038 2013-04-19 16:02:35Z karl $
# TeXLive::TLDownload.pm - module for abstracting the download modes
# Copyright 2009-2012 Norbert Preining
# This file is licensed under the GNU General Public License version 2
# or any later version.

package TeXLive::TLDownload;

use TeXLive::TLUtils;
use TeXLive::TLConfig;
use File::Temp qw/tempfile/;

my $svnrev = '$Revision: 30038 $';
my $_modulerevision;
if ($svnrev =~ m/: ([0-9]+) /) {
  $_modulerevision = $1;
} else {
  $_modulerevision = "unknown";
}
sub module_revision {
  return $_modulerevision;
}

my $MAX_ERRORCOUNT = 5;

# since Net::HTTP and Net::FTP are shipped by the same packages
# we only test for Net::HTTP, if that fails, let us know ;-)
our $net_lib_avail = 0;
eval { require LWP; };
if ($@) {
  debug("LWP is not available, falling back to wget.\n");
  $net_lib_avail = 0;
} else {
  require LWP::UserAgent;
  require HTTP::Status;
  $net_lib_avail = 1;
  ddebug("LWP available, doing persistent downloads.\n");
}


sub new
{
  my $class = shift;
  my $self = {};
  my $ua = LWP::UserAgent->new(
    agent => "texlive/lwp",
    # use LWP::ConnCache, and keep 1 connection open
    keep_alive => 1,
    env_proxy => 1,
    timeout => $TeXLive::TLConfig::NetworkTimeout,
  );
  $self->{'ua'} = $ua;
  $self->{'enabled'} = 1;
  $self->{'errorcount'} = 0;
  bless $self, $class;
  return $self;
}




sub enabled
{
  my $self = shift;
  return $self->{'enabled'};
}
sub disabled
{
  my $self = shift;
  return (!$self->{'enabled'});
}
sub enable
{
  my $self = shift;
  $self->{'enabled'} = 1;
  # also reset the error conter
  $self->reset_errorcount;
}
sub disable
{
  my $self = shift;
  $self->{'enabled'} = 0;
}
sub errorcount
{
  my $self = shift;
  if (@_) { $self->{'errorcount'} = shift }
  return $self->{'errorcount'};
}
sub incr_errorcount
{
  my $self = shift;
  return(++$self->{'errorcount'});
}
sub decr_errorcount
{
  my $self = shift;
  if ($self->errorcount > 0) {
    return(--$self->{'errorcount'});
  } else {
    return($self->errorcount(0));
  }
}

sub reset_errorcount {
  my $self = shift;
  $self->{'errorcount'} = 0;
}

sub get_file {
  my ($self,$url,$out,$size) = @_;
  #
  # automatically disable if error count is getting too big
  if ($self->errorcount > $MAX_ERRORCOUNT) {
    $self->disable;
  }
  # return if disabled
  return if $self->disabled;
  #
  my $realout = $out;
  my ($outfh, $outfn);
  if ($out eq "|") {
    ($outfh, $outfn) = tempfile();
    $realout = $outfn;
  }
  my $response = $self->{'ua'}->get($url, ':content_file' => $realout);
  if ($response->is_success) {
    $self->decr_errorcount;
    if ($out ne "|") {
      return 1;
    } else {
      # seek to beginning of file
      seek $outfh, 0, 0;
      return $outfh;
    }
  } else {
    tlwarn("TLDownload::get_file: response error: "
            . $response->status_line . " (for $url)\n");
    $self->incr_errorcount;
    return;
  }
}



1;
__END__


=head1 NAME

C<TeXLive::TLDownload> -- TeX Live Download abstraction module

=head1 SYNOPSIS

  use TeXLive::TLDownload;

  $TeXLive::TLDownload::net_lib_avail
  my $dl = TeXLive::TLDownload->new();
  $dl->get_file($relpath, $output [, $expected_size ]);
  if ($dl->enabled) ...
  if ($dl->disabled) ...
  $dl->enable;
  $dl->disable;
  $dl->errorcount([n]);
  $dl->incr_errorcount;
  $dl->decr_errorcount;
  $dl->reset_errorcount;

=head1 DESCRIPTION

The C<TeXLive::TLDownload> is a wrapper around the LWP modules that
allows for persistent connections and different protocols.  At load
time it checks for the existence of the LWP module(s), and sets
C<$TeXLive::TLDownload::net_lib_avail> accordingly.

=head2 Using proxies

Please see C<LWP::UserAgent> for details, in a nut shell one can
specify proxies by setting C<I<protocol>_proxy> variables.

=head2 Automatic disabling

The TLDownload module implements some automatic disabling feature. 
Every time a download did not succeed an internal counter (errorcount)
is increased, everytime it did succeed it is decreased (to a minimum of 0).
If the number of error goes above the maximal error count, the download
object will be disabled and get_file always returns undef.

In this cases the download can be reset with the reset_errorcount and
enable function.

=head1 SEE ALSO

LWP

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
