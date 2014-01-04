# $Id: TLConfig.pm 29883 2013-04-13 05:32:44Z preining $
# TeXLive::TLConfig.pm - module exporting configuration values
# Copyright 2007-2013 Norbert Preining
# This file is licensed under the GNU General Public License version 2
# or any later version.

package TeXLive::TLConfig;

my $svnrev = '$Revision: 29883 $';
my $_modulerevision;
if ($svnrev =~ m/: ([0-9]+) /) {
  $_modulerevision = $1;
} else {
  $_modulerevision = "unknown";
}
sub module_revision {
  return $_modulerevision;
}

BEGIN {
  use Exporter ();
  use vars qw( @ISA @EXPORT_OK @EXPORT );
  @ISA = qw(Exporter);
  @EXPORT_OK = qw(
    $ReleaseYear
    @MetaCategories
    @NormalCategories
    @Categories
    $MetaCategoriesRegexp
    $CategoriesRegexp
    $DefaultCategory
    $DefaultContainerFormat
    $DefaultContainerExtension
    $InfraLocation
    $DatabaseName
    $PackageBackupDir 
    $BlockSize
    $Archive
    $TeXLiveServerURL
    $TeXLiveServerPath
    $TeXLiveURL
    @CriticalPackagesList
    $CriticalPackagesRegexp
    $WindowsMainMenuName
    $RelocPrefix
    $RelocTree
    %TLPDBOptions
    %TLPDBSettings
    %TLPDBConfigs
    $NetworkTimeout
  );
  @EXPORT = @EXPORT_OK;
}

# the year of our release, will be used in the location of the
# network packages, and in menu names, and other places.
$ReleaseYear = 2013;

# users can upgrade from this year to the current year; maybe a spread
# of more than one year will be useful at some point, but not now.
# $MinRelease = $ReleaseYear - 1;

# users can NOT upgrade due to internal changes, force a full installation
$MinRelease = $ReleaseYear;

# Meta Categories do not ship files, but only call for other packages.
our @MetaCategories = qw/Collection Scheme/;
our $MetaCategoriesRegexp = '(Collection|Scheme)';
#
# Normal Categories contain actial files and do not depend on other things.
our @NormalCategories = qw/Package TLCore ConTeXt/;
#
# list of all Categories
our @Categories = (@MetaCategories, @NormalCategories);

# repeat, as a regexp.
our $CategoriesRegexp = '(Collection|Scheme|Package|TLCore|ConTeXt)';

our $DefaultCategory = "Package";

# location of various infra files (texlive.tlpdb, .tlpobj etc)
# relative to a root (e.g., the Master/, or the installation path)
our $InfraLocation = "tlpkg";
our $DatabaseName = "texlive.tlpdb";

# location of backups in default autobackup setting (under tlpkg)
our $PackageBackupDir = "$InfraLocation/backups";

our $BlockSize = 4096;

our $Archive = "archive";
our $TeXLiveServerURL = "http://mirror.ctan.org";
# from 2009 on we try to put them all into tlnet directly without any
# release year since we hope that we can switch over to 2010 on the fly
# our $TeXLiveServerPath = "systems/texlive/tlnet/$ReleaseYear";
our $TeXLiveServerPath = "systems/texlive/tlnet";
our $TeXLiveURL = "$TeXLiveServerURL/$TeXLiveServerPath";

# Relocatable packages.
our $RelocTree = "texmf-dist";
our $RelocPrefix = "RELOC";

our @CriticalPackagesList = qw/texlive.infra/;
our $CriticalPackagesRegexp = '^(texlive\.infra)';
if ($^O =~ /^MSWin(32|64)$/i) {
  push (@CriticalPackagesList, "tlperl.win32");
  $CriticalPackagesRegexp = '^(texlive\.infra|tlperl\.win32$)';
}

# the way we package things on the web
our $DefaultContainerFormat = "xz";
our $DefaultContainerExtension = "tar.$DefaultContainerFormat";

# archive (not user) settings.
our %TLPDBConfigs = (
  "container_split_src_files" => 1,
  "container_split_doc_files" => 1,
  "container_format" => $DefaultContainerFormat,
  "minrelease" => $MinRelease,
  "release" => $ReleaseYear,
);

# definition of the option strings and their value types 
# possible types are:
# - u: url
# - b: boolean, saved as 0/1
# - p: path (local path)
# - n: natural number
#      it allows n:[a]..[b]
#         if a is empty start at -infty
#         if b is empty end at +infty
#      so "n:.." is equivalent to "n"

# $TLPDBOptions{"option"}->[0] --> type
#                        ->[1] --> default value
#                        ->[2] --> tlmgr name
#                        ->[3] --> tlmgr description
# the "option" is the value in the TLPDB

our %TLPDBOptions = (
  "autobackup" =>
    [ "n:-1..", 1, "autobackup",
      "Number of backups to keep" ],
  "backupdir" =>
    [ "p", $PackageBackupDir, "backupdir",
      "Directory for backups" ],
  "create_formats" =>
    [ "b", 1, "formats",  
      "Create formats on installation" ],
  "desktop_integration" =>
    [ "b", 1, "desktop_integration",
      "Create Start menu shortcuts (w32)" ],
  "file_assocs" =>
    [ "n:0..2", 1, "fileassocs",
      "Change file associations (w32)" ],
  "install_docfiles" =>
    [ "b", 1, "docfiles",
      "Install documentation files" ],
  "install_srcfiles" =>
    [ "b", 1, "srcfiles",
      "Install source files" ],
  "location" =>
    [ "u", "__MASTER__", "repository", 
      "Default package repository" ],
  "post_code" =>
    [ "b", 1, "postcode",
      "Run postinst code blobs" ],
  "sys_bin" =>
    [ "p", "/usr/local/bin", "sys_bin",
      "Destination for symlinks for binaries" ],
  "sys_info" =>
    [ "p", "/usr/local/share/info", "sys_info",
      "Destination for symlinks for info docs" ],
  "sys_man" =>
    [ "p", "/usr/local/share/man", "sys_man",
      "Destination for symlinks for man pages" ],
  "w32_multi_user" =>
    [ "b", 0, "multiuser",
      "Install for all users (w32)" ],
  "generate_updmap" =>
    [ "b", 0, "generate_updmap",
      "Run tlmgr generate updmap after maps have changed" ],
);


our %TLPDBSettings = (
  "platform" => [ "s", "Main platform for this computer" ],
  "available_architectures" => [ "l", "All available/installed architectures" ],
  "usertree" => [ "b", "This tree acts as user tree" ]
);

our $WindowsMainMenuName = "TeX Live $ReleaseYear";

#
# timeout for network connections (wget, LWP) in seconds
our $NetworkTimeout = 30;

1;


=head1 NAME

C<TeXLive::TLConfig> -- TeX Live Configurations

=head1 SYNOPSIS

  use TeXLive::TLConfig;

=head1 DESCRIPTION

The L<TeXLive::TLConfig> module contains definitions of variables 
configuring all of TeX Live.

=over 4

=head1 EXPORTED VARIABLES

All of the following variables are pulled into the callers namespace,
i.e., are declared with C<EXPORT> (and C<EXPORT_OK>).

=item C<@TeXLive::TLConfig::MetaCategories>

The list of meta categories, i.e., those categories whose packages only
depend on other packages, but don't ship any files. Currently 
C<Collection> and <Scheme>.

=item C<@TeXLive::TLConfig::NormalCategories>

The list of normal categories, i.e., those categories whose packages do
ship files. Currently C<TLCore>, C<Package>, C<ConTeXt>.

=item C<@TeXLive::TLConfig::Categories>

The list of all categories, i.e., the union of the above.

=item C<$TeXLive::TLConfig::CategoriesRegexp>

A regexp matching any category.

=item C<$TeXLive::TLConfig::DefaultCategory>

The default category used when creating new packages.

=item C<$TeXLive::TLConfig::InfraLocation>

The subdirectory with various infrastructure files (C<texlive.tlpdb>,
tlpobj files, ...) relative to the root of the installation; currently
C<tlpkg>.

=item C<$TeXLive::TLConfig::BlockSize>

The assumed block size, currently 4k.

=item C<$TeXLive::TLConfig::Archive>
=item C<$TeXLive::TLConfig::TeXLiveURL>

These values specify where to find packages.

=item C<$TeXLive::TLConfig::TeXLiveServerURL>
=item C<$TeXLive::TLConfig::TeXLiveServerPath>

C<TeXLiveURL> is concatenated from these values, with a string between.
The defaults are respectively, C<http://mirror.ctan.org> and
C<systems/texlive/tlnet/>.

=item C<@TeXLive::TLConfig::CriticalPackagesList>
=item C<@TeXLive::TLConfig::CriticalPackagesRegexp>

A list of all those packages which we do not update regularly since they
are too central, currently texlive.infra and (for Windows) tlperl.win32.

=item C<$TeXLive::TLConfig::RelocTree>

The texmf-tree name that can be relocated, defaults to C<texmf-dist>.

=item C<$TeXLive::TLConfig::RelocPrefix>

The string that replaces the C<RelocTree> in the tlpdb if a package is
relocated, defaults to C<RELOC>".

=back

=head1 SEE ALSO

The modules L<TeXLive::TLUtils>, L<TeXLive::TLPSRC>,
L<TeXLive::TLPDB>, L<TeXLive::TLTREE>, L<TeXLive::TeXCatalogue>.

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
