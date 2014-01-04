# $Id: TLUtils.pm 31511 2013-08-24 21:47:05Z karl $
# TeXLive::TLUtils.pm - the inevitable utilities for TeX Live.
# Copyright 2007-2013 Norbert Preining, Reinhard Kotucha
# This file is licensed under the GNU General Public License version 2
# or any later version.

package TeXLive::TLUtils;

my $svnrev = '$Revision: 31511 $';
my $_modulerevision;
if ($svnrev =~ m/: ([0-9]+) /) {
  $_modulerevision = $1;
} else {
  $_modulerevision = "unknown";
}
sub module_revision {
  return $_modulerevision;
}

=pod

=head1 NAME

C<TeXLive::TLUtils> -- utilities used in the TeX Live infrastructure

=head1 SYNOPSIS

  use TeXLive::TLUtils;

=head2 Platform Detection

  TeXLive::TLUtils::platform();
  TeXLive::TLUtils::platform_name($canonical_host);
  TeXLive::TLUtils::platform_desc($platform);
  TeXLive::TLUtils::win32();
  TeXLive::TLUtils::unix();

=head2 System Tools

  TeXLive::TLUtils::getenv($string);
  TeXLive::TLUtils::which($string);
  TeXLive::TLUtils::get_system_tmpdir();
  TeXLive::TLUtils::tl_tmpdir();
  TeXLive::TLUtils::xchdir($dir);
  TeXLive::TLUtils::xsystem(@args);
  TeXLive::TLUtils::run_cmd($cmd);

=head2 File Utilities

  TeXLive::TLUtils::dirname($path);
  TeXLive::TLUtils::basename($path);
  TeXLive::TLUtils::dirname_and_basename($path);
  TeXLive::TLUtils::tl_abs_path($path);
  TeXLive::TLUtils::dir_writable($path);
  TeXLive::TLUtils::dir_creatable($path);
  TeXLive::TLUtils::mkdirhier($path);
  TeXLive::TLUtils::rmtree($root, $verbose, $safe);
  TeXLive::TLUtils::copy($file, $target_dir);
  TeXLive::TLUtils::touch(@files);
  TeXLive::TLUtils::collapse_dirs(@files);
  TeXLive::TLUtils::removed_dirs(@files);
  TeXLive::TLUtils::download_file($path, $destination [, $progs ]);
  TeXLive::TLUtils::setup_programs($bindir, $platform);
  TeXLive::TLUtils::tlcmp($file, $file);
  TeXLive::TLUtils::nulldev();
  TeXLive::TLUtils::get_full_line($fh);

=head2 Installer Functions

  TeXLive::TLUtils::make_var_skeleton($path);
  TeXLive::TLUtils::make_local_skeleton($path);
  TeXLive::TLUtils::create_fmtutil($tlpdb,$dest,$localconf);
  TeXLive::TLUtils::create_updmap($tlpdb,$dest,$localconf);
  TeXLive::TLUtils::create_language_dat($tlpdb,$dest,$localconf);
  TeXLive::TLUtils::create_language_def($tlpdb,$dest,$localconf);
  TeXLive::TLUtils::create_language_lua($tlpdb,$dest,$localconf);
  TeXLive::TLUtils::time_estimate($totalsize, $donesize, $starttime)
  TeXLive::TLUtils::install_packages($from_tlpdb,$media,$to_tlpdb,$what,$opt_src, $opt_doc)>);
  TeXLive::TLUtils::install_package($what, $filelistref, $target, $platform);
  TeXLive::TLUtils::do_postaction($how, $tlpobj, $do_fileassocs, $do_menu, $do_desktop, $do_script);
  TeXLive::TLUtils::announce_execute_actions($how, @executes);
  TeXLive::TLUtils::add_symlinks($root, $arch, $sys_bin, $sys_man, $sys_info);
  TeXLive::TLUtils::remove_symlinks($root, $arch, $sys_bin, $sys_man, $sys_info);
  TeXLive::TLUtils::w32_add_to_path($bindir, $multiuser);
  TeXLive::TLUtils::w32_remove_from_path($bindir, $multiuser);
  TeXLive::TLUtils::setup_persistent_downloads();

=head2 Miscellaneous

  TeXLive::TLUtils::sort_uniq(@list);
  TeXLive::TLUtils::push_uniq(\@list, @items);
  TeXLive::TLUtils::member($item, @list);
  TeXLive::TLUtils::merge_into(\%to, \%from);
  TeXLive::TLUtils::texdir_check($texdir);
  TeXLive::TLUtils::quotify_path_with_spaces($path);
  TeXLive::TLUtils::conv_to_w32_path($path);
  TeXLive::TLUtils::native_slashify($internal_path);
  TeXLive::TLUtils::forward_slashify($path_from_user);
  TeXLive::TLUtils::give_ctan_mirror();
  TeXLive::TLUtils::give_ctan_mirror_base();
  TeXLive::TLUtils::tlmd5($path);
  TeXLive::TLUtils::compare_tlpobjs($tlpA, $tlpB);
  TeXLive::TLUtils::compare_tlpdbs($tlpdbA, $tlpdbB);
  TeXLive::TLUtils::report_tlpdb_differences(\%ret);
  TeXLive::TLUtils::tlnet_disabled_packages($root);
  TeXLive::TLUtils::mktexupd();

=head1 DESCRIPTION

=cut

# avoid -warnings.
our $PERL_SINGLE_QUOTE; # we steal code from Text::ParseWords
use vars qw(
  $::LOGFILENAME @::LOGLINES 
  @::debug_hook @::ddebug_hook @::dddebug_hook @::info_hook @::warn_hook
  @::install_packages_hook
  $::latex_updated
  $::machinereadable
  $::no_execute_actions
  $::regenerate_all_formats
  $::tex_updated
  $TeXLive::TLDownload::net_lib_avail
);

BEGIN {
  use Exporter ();
  use vars qw(@ISA @EXPORT_OK @EXPORT);
  @ISA = qw(Exporter);
  @EXPORT_OK = qw(
    &platform
    &platform_name
    &platform_desc
    &unix
    &getenv
    &which
    &get_system_tmpdir
    &dirname
    &basename
    &dirname_and_basename
    &tl_abs_path
    &dir_writable
    &dir_creatable
    &mkdirhier
    &rmtree
    &copy
    &touch
    &collapse_dirs
    &removed_dirs
    &install_package
    &install_packages
    &make_var_skeleton
    &make_local_skeleton
    &create_fmtutil
    &create_updmap
    &create_language_dat
    &create_language_def
    &create_language_lua
    &parse_AddFormat_line
    &parse_AddHyphen_line
    &sort_uniq
    &push_uniq
    &texdir_check
    &member
    &quotewords
    &quotify_path_with_spaces
    &conv_to_w32_path
    &native_slashify
    &forward_slashify
    &untar
    &unpack
    &merge_into
    &give_ctan_mirror
    &give_ctan_mirror_base
    &create_mirror_list
    &extract_mirror_entry
    &tlmd5
    &xsystem
    &run_cmd
    &announce_execute_actions
    &add_symlinks
    &remove_symlinks
    &w32_add_to_path
    &w32_remove_from_path
    &tlcmp
    &time_estimate
    &compare_tlpobjs
    &compare_tlpdbs
    &report_tlpdb_differences
    &setup_persistent_downloads
    &mktexupd
    &nulldev
    &get_full_line
  );
  @EXPORT = qw(setup_programs download_file process_logging_options
               tldie tlwarn info log debug ddebug dddebug debug_hash
               win32 xchdir xsystem run_cmd);
}

use Cwd;
use Digest::MD5;
use Getopt::Long;
use File::Temp;

use TeXLive::TLConfig;

$::opt_verbosity = 0;  # see process_logging_options


=head2 Platform Detection

=over 4

=item C<platform>

If C<$^O=~/MSWin(32|64)$/i> is true we know that we're on
Windows and we set the global variable C<$::_platform_> to C<win32>.
Otherwise we call C<platform_name> with the output of C<config.guess>
as argument.

The result is stored in a global variable C<$::_platform_>, and
subsequent calls just return that value.

=cut

sub platform {
  unless (defined $::_platform_) {
    if ($^O =~ /^MSWin/i) {
      $::_platform_ = "win32";
    } else {
      my $config_guess = "$::installerdir/tlpkg/installer/config.guess";

      # We cannot rely on #! in config.guess but have to call /bin/sh
      # explicitly because sometimes the 'noexec' flag is set in
      # /etc/fstab for ISO9660 file systems.
      chomp (my $guessed_platform = `/bin/sh '$config_guess'`);

      # For example, if the disc or reader has hardware problems.
      die "$0: could not run $config_guess, cannot proceed, sorry"
        if ! $guessed_platform;

      $::_platform_ = platform_name($guessed_platform);
    }
  }
  return $::_platform_;
}


=item C<platform_name($canonical_host)>

Convert a canonical host names as returned by C<config.guess> into
TeX Live platform names.

CPU type is determined by a regexp, and any C</^i.86/> name is replaced
by C<i386>.

For OS we need a list because what's returned is not likely to match our
historical names, e.g., C<config.guess> returns C<linux-gnu> but we need
C<linux>.  This list might/should contain OSs which are not currently
supported.

If a particular platform is not found in this list we use the regexp
C</.*-(.*$)/> as a last resort and hope it provides something useful.

=cut

sub platform_name {
  my ($guessed_platform) = @_;

  $guessed_platform =~ s/^x86_64-(.*-k?)(free|net)bsd/amd64-$1$2bsd/;
  my $CPU; # CPU type as reported by config.guess.
  my $OS;  # O/S type as reported by config.guess.
  ($CPU = $guessed_platform) =~ s/(.*?)-.*/$1/;
  $CPU =~ s/^alpha(.*)/alpha/;   # alphaev whatever
  $CPU =~ s/mips64el/mipsel/;    # don't distinguish mips64 and 32 el
  $CPU =~ s/powerpc64/powerpc/;  # don't distinguish ppc64
  $CPU =~ s/sparc64/sparc/;      # don't distinguish sparc64

  # armv6l-unknown-linux-gnueabihf -> armhf-linux (RPi)
  # armv7l-unknown-linux-gnueabi   -> armel-linux (Android)
  if ($CPU =~ /^arm/) {
    $CPU = $guessed_platform =~ /hf$/ ? "armhf" : "armel";
  }

  my @OSs = qw(aix cygwin darwin freebsd hpux irix
               kfreebsd linux netbsd openbsd solaris);
  for my $os (@OSs) {
    # Match word boundary at the beginning of the os name so that
    #   freebsd and kfreebsd are distinguished.
    # Do not match word boundary at the end of the os so that
    #   solaris2 is matched.
    $OS = $os if $guessed_platform =~ /\b$os/;
  }
  
  if ($OS eq "darwin") {
    # We want to guess x86_64-darwin on new-enough systems.  
    # Most robust approach is to check sw_vers (os version)
    # and sysctl (processor hardware).
    chomp (my $sw_vers = `sw_vers -productVersion`);
    my ($os_major,$os_minor) = split (/\./, $sw_vers);
    #
    chomp (my $sysctl = `PATH=/usr/sbin:\$PATH sysctl hw.cpu64bit_capable`);
    my (undef,$hw_64_bit) = split (" ", $sysctl);
    #
    $CPU = ($os_major >= 10 && $os_minor >= 6 && $hw_64_bit >= 1)
           ? "x86_64" : "universal";
    
  } elsif ($CPU =~ /^i.86$/) {
    $CPU = "i386";  # 586, 686, whatever
  }

  if (! defined $OS) {
    ($OS = $guessed_platform) =~ s/.*-(.*)/$1/;
  }

  return "$CPU-$OS";
}

=item C<platform_desc($platform)>

Return a string which describes a particular platform identifier, e.g.,
given C<i386-linux> we return C<Intel x86 with GNU/Linux>.

=cut

sub platform_desc {
  my ($platform) = @_;

  my %platform_name = (
    'alpha-linux'      => 'DEC Alpha with GNU/Linux',
    'amd64-freebsd'    => 'x86_64 with FreeBSD',
    'amd64-kfreebsd'   => 'x86_64 with GNU/kFreeBSD',
    'amd64-netbsd'     => 'x86_64 with NetBSD',
    'armel-linux'      => 'ARM with GNU/Linux',
    'armhf-linux'      => 'ARMhf with GNU/Linux',
    'hppa-hpux'        => 'HP-UX',
    'i386-cygwin'      => 'Intel x86 with Cygwin',
    'i386-darwin'      => 'Intel x86 with MacOSX/Darwin',
    'i386-freebsd'     => 'Intel x86 with FreeBSD',
    'i386-kfreebsd'    => 'Intel x86 with GNU/kFreeBSD',
    'i386-openbsd'     => 'Intel x86 with OpenBSD',
    'i386-netbsd'      => 'Intel x86 with NetBSD',
    'i386-linux'       => 'Intel x86 with GNU/Linux',
    'i386-solaris'     => 'Intel x86 with Solaris',
    'mips-irix'        => 'SGI IRIX',
    'mipsel-linux'     => 'MIPSel with GNU/Linux',
    'powerpc-aix'      => 'PowerPC with AIX',
    'powerpc-darwin'   => 'PowerPC with MacOSX/Darwin',
    'powerpc-linux'    => 'PowerPC with GNU/Linux',
    'sparc-linux'      => 'Sparc with GNU/Linux',
    'sparc-solaris'    => 'Sparc with Solaris',
    'universal-darwin' => 'universal binaries for MacOSX/Darwin',
    'win32'            => 'Windows',
    'x86_64-darwin'    => 'x86_64 with MacOSX/Darwin',
    'x86_64-linux'     => 'x86_64 with GNU/Linux',
    'x86_64-solaris'   => 'x86_64 with Solaris',
  );

  # the inconsistency between amd64-freebsd and x86_64-linux is
  # unfortunate (it's the same hardware), but the os people say those
  # are the conventional names on the respective os's, so we follow suit.

  if (exists $platform_name{$platform}) {
    return "$platform_name{$platform}";
  } else {
    my ($CPU,$OS) = split ('-', $platform);
    return "$CPU with " . ucfirst "$OS";
  }
}


=item C<win32>

Return C<1> if platform is Windows and C<0> otherwise.  The test is
currently based on the value of Perl's C<$^O> variable.

=cut

sub win32 {
  if ($^O =~ /^MSWin/i) {
    return 1;
  } else {
    return 0;
  }
  # the following needs config.guess, which is quite bad ...
  # return (&platform eq "win32")? 1:0;
}


=item C<unix>

Return C<1> if platform is UNIX and C<0> otherwise.

=cut

sub unix {
  return (&platform eq "win32")? 0:1;
}


=back

=head2 System Tools

=over 4

=item C<getenv($string)>

Get an environment variable.  It is assumed that the environment
variable contains a path.  On Windows all backslashes are replaced by
forward slashes as required by Perl.  If this behavior is not desired,
use C<$ENV{"$variable"}> instead.  C<0> is returned if the
environment variable is not set.

=cut

sub getenv {
  my $envvar=shift;
  my $var=$ENV{"$envvar"};
  return 0 unless (defined $var);
  if (&win32) {
    $var=~s!\\!/!g;  # change \ -> / (required by Perl)
  }
  return "$var";
}


=item C<which($string)>

C<which> does the same as the UNIX command C<which(1)>, but it is
supposed to work on Windows too.  On Windows we have to try all the
extensions given in the C<PATHEXT> environment variable.  We also try
without appending an extension because if C<$string> comes from an
environment variable, an extension might already be present.

=cut

sub which {
  my ($prog) = @_;
  my @PATH;
  my $PATH = getenv('PATH');

  if (&win32) {
    my @PATHEXT = split (';', getenv('PATHEXT'));
    push (@PATHEXT, '');  # in case argument contains an extension
    @PATH = split (';', $PATH);
    for my $dir (@PATH) {
      for my $ext (@PATHEXT) {
        if (-f "$dir/$prog$ext") {
          return "$dir/$prog$ext";
        }
      }
    }

  } else { # not windows
    @PATH = split (':', $PATH);
    for my $dir (@PATH) {
      if (-x "$dir/$prog") {
        return "$dir/$prog";
      }
    }
  }
  return 0;
}

=item C<get_system_tmpdir>

Evaluate the environment variables C<TMPDIR>, C<TMP>, and C<TEMP> in
order to find the system temporary directory.

=cut

sub get_system_tmpdir {
  my $systmp=0;
  $systmp||=getenv 'TMPDIR';
  $systmp||=getenv 'TMP';
  $systmp||=getenv 'TEMP';
  $systmp||='/tmp';
  return "$systmp";
}

=item C<tl_tmpdir>

Create a temporary directory which is cleaned up as soon as the program
is terminated.

=cut

sub tl_tmpdir {
  return (File::Temp::tempdir(CLEANUP => 1));
}

=item C<xchdir($dir)>

C<chdir($dir)> or die.

=cut

sub xchdir {
  my ($dir) = @_;
  chdir($dir) || die "$0: chdir($dir) failed: $!";
  ddebug("xchdir($dir) ok\n");
}


=item C<xsystem(@args)>

Run C<system(@args)> and die if unsuccessful.

=cut

sub xsystem {
  my (@args) = @_;
  ddebug("running system(@args)\n");
  my $retval = system(@args);
  if ($retval != 0) {
    $retval /= 256 if $retval > 0;
    my $pwd = cwd ();
    die "$0: system(@args) failed in $pwd, status $retval";
  }
}

=item C<run_cmd($cmd)>

runs a command and captures its output. Then returns a list with the
output as first element and the return value (exit code) as second.

=cut

sub run_cmd {
  my $cmd = shift;
  my $output = `$cmd`;
  my $retval = $?;
  if ($retval != 0) {
    $retval /= 256 if $retval > 0;
  }
  return ($output, $retval);
}




=back

=head2 File Utilities

=over 4

=item C<dirname_and_basename($path)>

Return both C<dirname> and C<basename>.  Example:

  ($dirpart,$filepart) = dirname_and_basename ($path);

=cut

sub dirname_and_basename {
  my $path=shift;
  my ($share, $base) = ("", "");
  if (win32) {
    $path=~s!\\!/!g;
  }
  # do not try to make sense of paths ending with /..
  return (undef, undef) if $path =~ m!/\.\.$!;
  if ($path=~m!/!) {   # dirname("foo/bar/baz") -> "foo/bar"
    # eliminate `/.' path components
    while ($path =~ s!/\./!/!) {};
    # UNC path? => first split in $share = //xxx/yy and $path = /zzzz
    if (win32() and $path =~ m!^(//[^/]+/[^/]+)(.*)$!) {
      ($share, $path) = ($1, $2);
      if ($path =~ m!^/?$!) {
        $path = $share;
        $base = "";
      } elsif ($path =~ m!(/.*)/(.*)!) {
        $path = $share.$1;
        $base = $2;
      } else {
        $base = $path;
        $path = $share;
      }
      return ($path, $base);
    }
    # not a UNC path
    $path=~m!(.*)/(.*)!; # works because of greedy matching
    return ((($1 eq '') ? '/' : $1), $2);
  } else {             # dirname("ignore") -> "."
    return (".", $path);
  }
}


=item C<dirname($path)>

Return C<$path> with its trailing C</component> removed.

=cut

sub dirname {
  my $path = shift;
  my ($dirname, $basename) = dirname_and_basename($path);
  return $dirname;
}


=item C<basename($path)>

Return C<$path> with any leading directory components removed.

=cut

sub basename {
  my $path = shift;
  my ($dirname, $basename) = dirname_and_basename($path);
  return $basename;
}


=item C<tl_abs_path($path)>

# Other than Cwd::abs_path, tl_abs_path also works
# if only the grandparent exists.

=cut

sub tl_abs_path {
  my $path = shift;
  if (win32) {
    $path=~s!\\!/!g;
  }
  my $ret;
  eval {$ret = Cwd::abs_path($path);}; # eval needed for w32
  return $ret if defined $ret;
  # $ret undefined: probably the parent does not exist.
  # But we also want an answer if only the grandparent exists.
  my ($parent, $base) = dirname_and_basename($path);
  return undef unless defined $parent;
  eval {$ret = Cwd::abs_path($parent);};
  if (defined $ret) {
    if ($ret =~ m!/$! or $base =~ m!^/!) {
      $ret = "$ret$base";
    } else {
      $ret = "$ret/$base";
    }
    return $ret;
  } else {
    my ($pparent, $pbase) = dirname_and_basename($parent);
    return undef unless defined $pparent;
    eval {$ret = Cwd::abs_path($pparent);};
    return undef unless defined $ret;
    if ($ret =~ m!/$!) {
      $ret = "$ret$pbase/$base";
    } else {
      $ret = "$ret/$pbase/$base";
    }
    return $ret;
  }
}


=item C<dir_creatable($path)>

Tests whether its argument is a directory where we can create a directory.

=cut

sub dir_slash {
  my $d = shift;
  $d = "$d/" unless $d =~ m!/!;
  return $d;
}

# test whether subdirectories can be created in the argument
sub dir_creatable {
  my $path=shift;
  #print STDERR "testing $path\n";
  $path =~ s!\\!/!g if win32;
  return 0 unless -d $path;
  $path =~ s!/$!!;
  #print STDERR "testing $path\n";
  my $i = 0;
  my $too_large = 100000;
  while ((-e $path . "/" . $i) and $i<$too_large) { $i++; }
  return 0 if $i>=$too_large;
  my $d = $path."/".$i;
  #print STDERR "creating $d\n";
  return 0 unless mkdir $d;
  return 0 unless -d $d;
  rmdir $d;
  return 1;
}


=item C<dir_writable($path)>

Tests whether its argument is writable by trying to write to
it. This function is necessary because the built-in C<-w> test just
looks at mode and uid/guid, which on Windows always returns true and
even on Unix is not always good enough for directories mounted from
a fileserver.

=cut

# Theoretically, the test below, which uses numbers as names, might
# lead to a race condition. OTOH, it should work even on a very
# broken Perl.

# The Unix test gives the wrong answer when used under Windows Vista
# with one of the `virtualized' directories such as Program Files:
# lacking administrative permissions, it would write successfully to
# the virtualized Program Files rather than fail to write to the
# real Program Files. Ugh.

sub dir_writable {
  my $path=shift;
  return 0 unless -d $path;
  $path =~ s!\\!/!g if win32;
  $path =~ s!/$!!;
  my $i = 0;
  my $too_large = 100000;
  while ((-e $path . "/" . $i) and $i<$too_large) { $i++; }
  return 0 if $i>=$too_large;
  my $f = $path."/".$i;
  return 0 unless open TEST, ">".$f;
  my $written = 0;
  $written = (print TEST "\n");
  close TEST;
  unlink $f;
  return $written;
}


=item C<mkdirhier($path, [$mode])>

The function C<mkdirhier> does the same as the UNIX command C<mkdir -p>.
The optional parameter sets the permission flags.

=cut

sub mkdirhier {
  my ($tree,$mode) = @_;

  return if (-d "$tree");
  my $subdir = "";
  # win32 is special as usual: we need to separate //servername/ part
  # from the UNC path, since (! -d //servername/) tests true
  $subdir = $& if ( win32() && ($tree =~ s!^//[^/]+/!!) );

  @dirs = split (/\//, $tree);
  for my $dir (@dirs) {
    $subdir .= "$dir/";
    if (! -d $subdir) {
      if (defined $mode) {
        mkdir ($subdir, $mode)
        || die "$0: mkdir($subdir,$mode) failed, goodbye: $!\n";
      } else {
        mkdir ($subdir) || die "$0: mkdir($subdir) failed, goodbye: $!\n";
      }
    }
  }
}


=item C<rmtree($root, $verbose, $safe)>

The C<rmtree> function provides a convenient way to delete a
subtree from the directory structure, much like the Unix command C<rm -r>.
C<rmtree> takes three arguments:

=over 4

=item *

the root of the subtree to delete, or a reference to
a list of roots.  All of the files and directories
below each root, as well as the roots themselves,
will be deleted.

=item *

a boolean value, which if TRUE will cause C<rmtree> to
print a message each time it examines a file, giving the
name of the file, and indicating whether it's using C<rmdir>
or C<unlink> to remove it, or that it's skipping it.
(defaults to FALSE)

=item *

a boolean value, which if TRUE will cause C<rmtree> to
skip any files to which you do not have delete access
(if running under VMS) or write access (if running
under another OS).  This will change in the future when
a criterion for 'delete permission' under OSs other
than VMS is settled.  (defaults to FALSE)

=back

It returns the number of files successfully deleted.  Symlinks are
simply deleted and not followed.

B<NOTE:> There are race conditions internal to the implementation of
C<rmtree> making it unsafe to use on directory trees which may be
altered or moved while C<rmtree> is running, and in particular on any
directory trees with any path components or subdirectories potentially
writable by untrusted users.

Additionally, if the third parameter is not TRUE and C<rmtree> is
interrupted, it may leave files and directories with permissions altered
to allow deletion (and older versions of this module would even set
files and directories to world-read/writable!)

Note also that the occurrence of errors in C<rmtree> can be determined I<only>
by trapping diagnostic messages using C<$SIG{__WARN__}>; it is not apparent
from the return value.

=cut

#taken from File/Path.pm
#
my $Is_VMS = $^O eq 'VMS';
my $Is_MacOS = $^O eq 'MacOS';

# These OSes complain if you want to remove a file that you have no
# write permission to:
my $force_writeable = ($^O eq 'os2' || $^O eq 'dos' || $^O eq 'MSWin32' ||
		       $^O eq 'amigaos' || $^O eq 'MacOS' || $^O eq 'epoc');

sub rmtree {
  my($roots, $verbose, $safe) = @_;
  my(@files);
  my($count) = 0;
  $verbose ||= 0;
  $safe ||= 0;

  if ( defined($roots) && length($roots) ) {
    $roots = [$roots] unless ref $roots;
  } else {
    warn "No root path(s) specified";
    return 0;
  }

  my($root);
  foreach $root (@{$roots}) {
    if ($Is_MacOS) {
      $root = ":$root" if $root !~ /:/;
      $root =~ s#([^:])\z#$1:#;
    } else {
      $root =~ s#/\z##;
    }
    (undef, undef, my $rp) = lstat $root or next;
    $rp &= 07777;	# don't forget setuid, setgid, sticky bits
    if ( -d _ ) {
      # notabene: 0700 is for making readable in the first place,
      # it's also intended to change it to writable in case we have
      # to recurse in which case we are better than rm -rf for
      # subtrees with strange permissions
      chmod($rp | 0700, ($Is_VMS ? VMS::Filespec::fileify($root) : $root))
        or warn "Can't make directory $root read+writeable: $!"
          unless $safe;

      if (opendir my $d, $root) {
        no strict 'refs';
        if (!defined ${"\cTAINT"} or ${"\cTAINT"}) {
          # Blindly untaint dir names
          @files = map { /^(.*)$/s ; $1 } readdir $d;
        } else {
          @files = readdir $d;
        }
        closedir $d;
      } else {
        warn "Can't read $root: $!";
        @files = ();
      }
      # Deleting large numbers of files from VMS Files-11 filesystems
      # is faster if done in reverse ASCIIbetical order
      @files = reverse @files if $Is_VMS;
      ($root = VMS::Filespec::unixify($root)) =~ s#\.dir\z## if $Is_VMS;
      if ($Is_MacOS) {
        @files = map("$root$_", @files);
      } else {
        @files = map("$root/$_", grep $_!~/^\.{1,2}\z/s,@files);
      }
      $count += rmtree(\@files,$verbose,$safe);
      if ($safe &&
            ($Is_VMS ? !&VMS::Filespec::candelete($root) : !-w $root)) {
        print "skipped $root\n" if $verbose;
        next;
      }
      chmod $rp | 0700, $root
        or warn "Can't make directory $root writeable: $!"
          if $force_writeable;
      print "rmdir $root\n" if $verbose;
      if (rmdir $root) {
	      ++$count;
      } else {
        warn "Can't remove directory $root: $!";
        chmod($rp, ($Is_VMS ? VMS::Filespec::fileify($root) : $root))
          or warn("and can't restore permissions to "
            . sprintf("0%o",$rp) . "\n");
      }
    } else {
      if ($safe &&
            ($Is_VMS ? !&VMS::Filespec::candelete($root)
              : !(-l $root || -w $root)))
      {
        print "skipped $root\n" if $verbose;
        next;
      }
      chmod $rp | 0600, $root
        or warn "Can't make file $root writeable: $!"
          if $force_writeable;
      print "unlink $root\n" if $verbose;
      # delete all versions under VMS
      for (;;) {
        unless (unlink $root) {
          warn "Can't unlink file $root: $!";
          if ($force_writeable) {
            chmod $rp, $root
              or warn("and can't restore permissions to "
                . sprintf("0%o",$rp) . "\n");
          }
          last;
        }
        ++$count;
        last unless $Is_VMS && lstat $root;
      }
    }
  }
  $count;
}


=item C<copy($file, $target_dir)>

=item C<copy("-f", $file, $destfile)>

Copy file C<$file> to directory C<$target_dir>, or to the C<$destfile>
in the second case.  No external programs are involved.  Since we need
C<sysopen()>, the Perl module C<Fcntl.pm> is required.  The time stamps
are preserved and symlinks are created on Unix systems.  On Windows,
C<(-l $file)> will never return 'C<true>' and so symlinks will be
(uselessly) copied as regular files.

C<copy> invokes C<mkdirhier> if target directories do not exist.  Files
have mode C<0777> if they are executable and C<0666> otherwise, with
the set bits in I<umask> cleared in each case.

C<$file> can begin with a file:/ prefix.

If C<$file> is not readable, we return without copying anything.  (This
can happen when the database and files are not in perfect sync.)  On the
other file, if the destination is not writable, or the writing fails,
that is a fatal error.

=cut

sub copy {
  my $infile = shift;
  my $filemode = 0;
  if ($infile eq "-f") { # second argument is a file
    $filemode = 1;
    $infile = shift;
  }
  my $destdir=shift;

  my $outfile;
  my @stat;
  my $mode;
  my $buffer;
  my $offset;
  my $filename;
  my $dirmode = 0755;
  my $blocksize = $TeXLive::TLConfig::BlockSize;

  $infile =~ s!^file://*!/!i;  # remove file:/ url prefix
  $filename = basename "$infile";
  if ($filemode) {
    # given a destination file
    $outfile = $destdir;
    $destdir = dirname($outfile);
  } else {
    $outfile = "$destdir/$filename";
  }

  mkdirhier ($destdir) unless -d "$destdir";

  if (-l "$infile") {
    symlink (readlink $infile, "$destdir/$filename");
  } else {
    if (! open (IN, $infile)) {
      warn "open($infile) failed, not copying: $!";
      return;
    }
    binmode IN;

    $mode = (-x "$infile") ? oct("0777") : oct("0666");
    $mode &= ~umask;

    open (OUT, ">$outfile") || die "open(>$outfile) failed: $!";
    binmode OUT;

    chmod $mode, "$outfile";

    while ($read = sysread (IN, $buffer, $blocksize)) {
      die "read($infile) failed: $!\n" unless defined $read;
      $offset = 0;
      while ($read) {
        $written = syswrite (OUT, $buffer, $read, $offset);
        die "write($outfile) failed: $!" unless defined $written;
        $read -= $written;
        $offset += $written;
      }
    }
    close (OUT) || warn "close($outfile) failed: $!";
    close IN || warn "close($infile) failed: $!";;
    @stat = lstat ("$infile");
    utime ($stat[8], $stat[9], $outfile);
  }
}


=item C<touch(@files)>

Update modification and access time of C<@files>.  Non-existent files
are created.

=cut

sub touch {
  my @files=@_;

  foreach my $file (@_) {
    if (-e $file) {
	    utime time, time, $file;
    } else {
      if (open( TMP, ">$file")) {
        close(TMP);
      } else {
        warn "Can't create file $file: $!\n";
      }
    }
  }
}





=item C<collapse_dirs(@files)>

Return a (more or less) minimal list of directories and files, given an
original list of files C<@files>.  That is, if every file within a given
directory is included in C<@files>, replace all of those files with the
absolute directory name in the return list.  Any files which have
sibling files not included are retained and made absolute.

We try to walk up the tree so that the highest-level directory
containing only directories or files that are in C<@files> is returned.
(This logic may not be perfect, though.)

This is not just a string function; we check for other directory entries
existing on disk within the directories of C<@files>.  Therefore, if the
entries are relative pathnames, the current directory must be set by the
caller so that file tests work.

As mentioned above, the returned list is absolute paths to directories
and files.

For example, suppose the input list is

  dir1/subdir1/file1
  dir1/subdir2/file2
  dir1/file3

If there are no other entries under C<dir1/>, the result will be
C</absolute/path/to/dir1>.

=cut

sub collapse_dirs {
  my (@files) = @_;
  my @ret = ();
  my %by_dir;

  # construct hash of all directories mentioned, values are lists of the
  # files in that directory.
  for my $f (@files) {
    my $abs_f = Cwd::abs_path ($f);
    die ("oops, no abs_path($f) from " . `pwd`) unless $abs_f;
    (my $d = $abs_f) =~ s,/[^/]*$,,;
    my @a = exists $by_dir{$d} ? @{$by_dir{$d}} : ();
    push (@a, $abs_f);
    $by_dir{$d} = \@a;
  }

  # for each of our directories, see if we are given everything in
  # the directory.  if so, return the directory; else return the
  # individual files.
  for my $d (sort keys %by_dir) {
    opendir (DIR, $d) || die "opendir($d) failed: $!";
    my @dirents = readdir (DIR);
    closedir (DIR) || warn "closedir($d) failed: $!";

    # initialize test hash with all the files we saw in this dir.
    # (These idioms are due to "Finding Elements in One Array and Not
    # Another" in the Perl Cookbook.)
    my %seen;
    my @rmfiles = @{$by_dir{$d}};
    @seen{@rmfiles} = ();

    # see if everything is the same.
    my $ok_to_collapse = 1;
    for my $dirent (@dirents) {
      next if $dirent =~ /^\.(\.|svn)?$/;  # ignore . .. .svn

      my $item = "$d/$dirent";  # prepend directory for comparison
      if (! exists $seen{$item}) {
        $ok_to_collapse = 0;
        last;  # no need to keep looking after the first.
      }
    }

    push (@ret, $ok_to_collapse ? $d : @{$by_dir{$d}});
  }

  if (@ret != @files) {
    @ret = &collapse_dirs (@ret);
  }
  return @ret;
}

=item C<removed_dirs(@files)>

returns all the directories from which all content will be removed

=cut

# return all the directories from which all content will be removed
#
# idea:
# - create a hashes by_dir listing all files that should be removed
#   by directory, i.e., key = dir, value is list of files
# - for each of the dirs (keys of by_dir and ordered deepest first)
#   check that all actually contained files are removed
#   and all the contained dirs are in the removal list. If this is the
#   case put that directory into the removal list
# - return this removal list
#
sub removed_dirs {
  my (@files) = @_;
  my %removed_dirs;
  my %by_dir;

  # construct hash of all directories mentioned, values are lists of the
  # files/dirs in that directory.
  for my $f (@files) {
    # what should we do with not existing entries????
    next if (! -r "$f");
    my $abs_f = Cwd::abs_path ($f);
    # the following is necessary because on win32,
    #   abs_path("tl-portable")
    # returns
    #   c:\tl test\...
    # and not forward slashes, while, if there is already a forward /
    # in the path, also the rest is done with forward slashes.
    $abs_f =~ s!\\!/!g if win32();
    if (!$abs_f) {
      warn ("oops, no abs_path($f) from " . `pwd`);
      next;
    }
    (my $d = $abs_f) =~ s,/[^/]*$,,;
    my @a = exists $by_dir{$d} ? @{$by_dir{$d}} : ();
    push (@a, $abs_f);
    $by_dir{$d} = \@a;
  }

  # for each of our directories, see if we are removing everything in
  # the directory.  if so, return the directory; else return the
  # individual files.
  for my $d (reverse sort keys %by_dir) {
    opendir (DIR, $d) || die "opendir($d) failed: $!";
    my @dirents = readdir (DIR);
    closedir (DIR) || warn "closedir($d) failed: $!";

    # initialize test hash with all the files we saw in this dir.
    # (These idioms are due to "Finding Elements in One Array and Not
    # Another" in the Perl Cookbook.)
    my %seen;
    my @rmfiles = @{$by_dir{$d}};
    @seen{@rmfiles} = ();

    # see if everything is the same.
    my $cleandir = 1;
    for my $dirent (@dirents) {
      next if $dirent =~ /^\.(\.|svn)?$/;  # ignore . .. .svn
      my $item = "$d/$dirent";  # prepend directory for comparison
      if (
           ((-d $item) && (defined($removed_dirs{$item})))
           ||
           (exists $seen{$item})
         ) {
        # do nothing
      } else {
        $cleandir = 0;
        last;
      }
    }
    if ($cleandir) {
      $removed_dirs{$d} = 1;
    }
  }
  return keys %removed_dirs;
}

=item C<time_estimate($totalsize, $donesize, $starttime)>

Returns the current running time and the estimated total time
based on the total size, the already done size, and the start time.

=cut

sub time_estimate {
  my ($totalsize, $donesize, $starttime) = @_;
  if ($donesize <= 0) {
    return ("??:??", "??:??");
  }
  my $curtime = time();
  my $passedtime = $curtime - $starttime;
  my $esttotalsecs = int ( ( $passedtime * $totalsize ) / $donesize );
  #
  # we change the display to show that passed time instead of the
  # estimated remaining time. We keep the old code and naming and
  # only initialize the $remsecs to the $passedtime instead.
  # my $remsecs = $esttotalsecs - $passedtime;
  my $remsecs = $passedtime;
  my $min = int($remsecs/60);
  my $hour;
  if ($min >= 60) {
    $hour = int($min/60);
    $min %= 60;
  }
  my $sec = $remsecs % 60;
  $remtime = sprintf("%02d:%02d", $min, $sec);
  if ($hour) {
    $remtime = sprintf("%02d:$remtime", $hour);
  }
  my $tmin = int($esttotalsecs/60);
  my $thour;
  if ($tmin >= 60) {
    $thour = int($tmin/60);
    $tmin %= 60;
  }
  my $tsec = $esttotalsecs % 60;
  $tottime = sprintf("%02d:%02d", $tmin, $tsec);
  if ($thour) {
    $tottime = sprintf("%02d:$tottime", $thour);
  }
  return($remtime, $tottime);
}


=item C<install_packages($from_tlpdb, $media, $to_tlpdb, $what, $opt_src, $opt_doc)>

Installs the list of packages found in C<@$what> (a ref to a list) into
the TLPDB given by C<$to_tlpdb>. Information on files are taken from
the TLPDB C<$from_tlpdb>.

C<$opt_src> and C<$opt_doc> specify whether srcfiles and docfiles should be
installed (currently implemented only for installation from uncompressed media).

Returns 1 on success and 0 on error.

=cut

sub install_packages {
  my ($fromtlpdb,$media,$totlpdb,$what,$opt_src,$opt_doc) = @_;
  my $container_src_split = $fromtlpdb->config_src_container;
  my $container_doc_split = $fromtlpdb->config_doc_container;
  my $root = $fromtlpdb->root;
  my @packs = @$what;
  my $totalnr = $#packs + 1;
  my $td = length("$totalnr");
  my $n = 0;
  my %tlpobjs;
  my $totalsize = 0;
  my $donesize = 0;
  my %tlpsizes;
  foreach my $p (@packs) {
    $tlpobjs{$p} = $fromtlpdb->get_package($p);
    if (!defined($tlpobjs{$p})) {
      die "STRANGE: $p not to be found in ", $fromtlpdb->root;
    }
    if ($media ne 'local_uncompressed') {
      # we use the container size as the measuring unit since probably
      # downloading will be the limiting factor
      $tlpsizes{$p} = $tlpobjs{$p}->containersize;
      $tlpsizes{$p} += $tlpobjs{$p}->srccontainersize if $opt_src;
      $tlpsizes{$p} += $tlpobjs{$p}->doccontainersize if $opt_doc;
    } else {
      # we have to add the respective sizes, that is checking for
      # installation of src and doc file
      $tlpsizes{$p} = $tlpobjs{$p}->runsize;
      $tlpsizes{$p} += $tlpobjs{$p}->srcsize if $opt_src;
      $tlpsizes{$p} += $tlpobjs{$p}->docsize if $opt_doc;
      my %foo = %{$tlpobjs{$p}->binsize};
      for my $k (keys %foo) { $tlpsizes{$p} += $foo{$k}; }
      # all the packages sizes are in blocks, so transfer that to bytes
      $tlpsizes{$p} *= $TeXLive::TLConfig::BlockSize;
    }
    $totalsize += $tlpsizes{$p};
  }
  my $starttime = time();
  foreach my $package (@packs) {
    my $tlpobj = $tlpobjs{$package};
    my $reloc = $tlpobj->relocated;
    $n++;
    my ($estrem, $esttot) = time_estimate($totalsize, $donesize, $starttime);
    my $infostr = sprintf("Installing [%0${td}d/$totalnr, "
                     . "time/total: $estrem/$esttot]: $package [%dk]",
                     $n, int($tlpsizes{$package}/1024) + 1);
    info("$infostr\n");
    foreach my $h (@::install_packages_hook) {
      &$h($n,$totalnr);
    }
    my $real_opt_doc = $opt_doc;
    my $container;
    my @installfiles;
    push @installfiles, $tlpobj->runfiles;
    push @installfiles, $tlpobj->allbinfiles;
    push @installfiles, $tlpobj->srcfiles if ($opt_src);
    push @installfiles, $tlpobj->docfiles if ($real_opt_doc);
    if ($media eq 'local_uncompressed') {
      $container = [ $root, @installfiles ];
    } elsif ($media eq 'local_compressed') {
      if (-r "$root/$Archive/$package.zip") {
        $container = "$root/$Archive/$package.zip";
      } elsif (-r "$root/$Archive/$package.tar.xz") {
        $container = "$root/$Archive/$package.tar.xz";
      } else {
        tlwarn("No package $package (.zip or .xz) in $root/$Archive\n");
        next;
      }
    } elsif ($media eq 'NET') {
      $container = "$root/$Archive/$package.$DefaultContainerExtension";
    }
    if (!install_package($container, $reloc, $tlpobj->containersize,
                         $tlpobj->containermd5, \@installfiles,
                         $totlpdb->root, $vars{'this_platform'})) {
      # we already warn in install_package that something bad happened,
      # so only return here
      return 0;
    }
    # if we are installing from compressed media we have to fetch the respective
    # source and doc packages $pkg.source and $pkg.doc and install them, too
    if (($media eq 'NET') || ($media eq 'local_compressed')) {
      # we install split containers under the following conditions:
      # - the container were split generated
      # - src/doc files should be installed
      # (- the package is not already a split one (like .i386-linux))
      # the above test has been removed since that would mean that packages
      # with a dot like texlive.infra will never have the docfiles installed
      # that is already happening ...bummer. But since we already check
      # whether there are src/docfiles present at all that is fine
      # - there are actually src/doc files present
      if ($container_src_split && $opt_src && $tlpobj->srcfiles) {
        my $srccontainer = $container;
        $srccontainer =~ s/(\.tar\.xz|\.zip)$/.source$1/;
        if (!install_package($srccontainer, $reloc, $tlpobj->srccontainersize,
                             $tlpobj->srccontainermd5, \@installfiles,
                             $totlpdb->root, $vars{'this_platform'})) {
          return 0;
        }
      }
      if ($container_doc_split && $real_opt_doc && $tlpobj->docfiles) {
        my $doccontainer = $container;
        $doccontainer =~ s/(\.tar\.xz|\.zip)$/.doc$1/;
        if (!install_package($doccontainer, $reloc,
                             $tlpobj->doccontainersize,
                             $tlpobj->doccontainermd5, \@installfiles,
                             $totlpdb->root, $vars{'this_platform'})) {
          return 0;
        }
      }
    }
    # we don't want to have wrong information in the tlpdb, so remove the
    # src/doc files if they are not installed ...
    if (!$opt_src) {
      $tlpobj->clear_srcfiles;
    }
    if (!$real_opt_doc) {
      $tlpobj->clear_docfiles;
    }
    # if a package is relocatable we have to cancel the reloc prefix
    # before we save it to the local tlpdb
    if ($tlpobj->relocated) {
      $tlpobj->replace_reloc_prefix;
    }
    $totlpdb->add_tlpobj($tlpobj);
    # we have to write out the tlpobj file since it is contained in the
    # archives (.tar.xz) but at uncompressed-media install time we don't have them
    my $tlpod = $totlpdb->root . "/tlpkg/tlpobj";
    mkdirhier( $tlpod );
    open(TMP,">$tlpod/".$tlpobj->name.".tlpobj") ||
      die "$0: open tlpobj " . $tlpobj->name . "failed: $!";
    $tlpobj->writeout(\*TMP);
    close(TMP);
    $donesize += $tlpsizes{$package};
  }
  my $totaltime = time() - $starttime;
  my $totmin = int ($totaltime/60);
  my $totsec = $totaltime % 60;
  info(sprintf("Time used for installing the packages: %02d:%02d\n",
       $totmin, $totsec));
  $totlpdb->save;
  return 1;
}


=item C<install_package($what, $reloc, $size, $md5, $filelistref, $target, $platform)>

This function installs the files given in @$filelistref from C<$what>
into C<$target>.

C<$size> gives the size in bytes of the container, or -1 if we are
installing from uncompressed media, i.e., from a list of files to be copied.

If C<$what> is a reference to a list of files then these files are
assumed to be readable and are copied to C<$target>, creating dirs on
the way. In this case the list C<@$filelistref> is not taken into
account.

If C<$what> starts with C<http://> or C<ftp://> then C<$what> is
downloaded from the net and piped through C<xzdec> and C<tar>.

If $what ends with C<.tar.xz> (but does not start with C<http://> or
C<ftp://>, but possibly with C<file:/>) it is assumed to be a readable
file on the system and is likewise piped through C<xzdec> and C<tar>.

In both of these cases currently the list C<$@filelistref> currently
is not taken into account (should be fixed!).

if C<$reloc> is true the container (NET or local_compressed mode) is packaged in a way
that the initial texmf-dist is missing.

Returns 1 on success and 0 on error.

=cut

sub install_package {
  my ($what, $reloc,  $whatsize, $whatmd5, $filelistref, $target, $platform) = @_;

  my @filelist = @$filelistref;

  my $tempdir = "$target/temp";

  # we assume that $::progs has been set up!
  my $wget = $::progs{'wget'};
  my $xzdec = quotify_path_with_spaces($::progs{'xzdec'});
  if (!defined($wget) || !defined($xzdec)) {
    tlwarn("install_package: wget/xzdec programs not set up properly.\n");
    return 0;
  }
  if (ref $what) {
    # we are getting a ref to a list of files, so install from uncompressed media
    my ($root, @files) = @$what;
    foreach my $file (@files) {
      # @what is taken, not @filelist!
      # is this still needed?
      my $dn=dirname($file);
      mkdirhier("$target/$dn");
      copy "$root/$file", "$target/$dn";
    }
  } elsif ($what =~ m,\.tar.xz$,) {
    # this is the case when we install from compressed media
    #
    # in all other cases we create temp files .tar.xz (or use the present
    # one), xzdec them, and then call tar

    # if we are unpacking a relocated container we adjust the target
    if ($reloc) {
      $target .= "/$TeXLive::TLConfig::RelocTree" if $reloc;
      mkdir($target) if (! -d $target);
    }

    my $fn = basename($what);
    my $pkg = $fn;
    $pkg =~ s/\.tar\.xz$//;
    mkdirhier("$tempdir");
    my $xzfile = "$tempdir/$fn";
    my $tarfile  = "$tempdir/$fn"; $tarfile =~ s/\.xz$//;
    my $xzfile_quote = $xzfile;
    my $tarfile_quote = $tarfile;
    if (win32()) {
      $xzfile =~ s!/!\\!g;
      $tarfile =~ s!/!\\!g;
      $target =~ s!/!\\!g;
    }
    $xzfile_quote = "\"$xzfile\"";
    $tarfile_quote = "\"$tarfile\"";
    my $gotfiledone = 0;
    if (-r $xzfile) {
      # check that the downloaded file is not partial
      if ($whatsize >= 0) {
        # we have the size given, so check that first
        my $size = (stat $xzfile)[7];
        if ($size == $whatsize) {
          # we want to check also the md5sum if we have it present
          if ($whatmd5) {
            if (tlmd5($xzfile) eq $whatmd5) {
              $gotfiledone = 1;
            } else {
              tlwarn("Downloaded $what, size equal, but md5sum differs;\n",
                     "downloading again.\n");
            }
          } else {
            # size ok, no md5sum
            tlwarn("Downloaded $what, size equal, but no md5sum available;\n",
                   "continuing, with fingers crossed.");
            $gotfiledone = 1;
          }
        } else {
          tlwarn("Partial download of $what found, removing it.\n");
          unlink($tarfile, $xzfile);
        }
      } else {
        # ok no size information, hopefully we have md5 sums
        if ($whatmd5) {
          if (tlmd5($xzfile) eq $whatmd5) {
            $gotfiledone = 1;
          } else {
            tlwarn("Downloaded file, but md5sum differs, removing it.\n");
          }
        } else {
          tlwarn("Container found, but cannot verify size of md5sum;\n",
                 "continuing, with fingers crossed.\n");
          $gotfiledone = 1;
        }
      }
      debug("Reusing already downloaded container $xzfile\n")
        if ($gotfiledone);
    }
    if (!$gotfiledone) {
      if ($what =~ m,http://|ftp://,) {
        # we are installing from the NET
        # download the file and put it into temp
        if (!download_file($what, $xzfile) || (! -r $xzfile)) {
          tlwarn("Downloading $what did not succeed.\n");
          return 0;
        }
      } else {
        # we are installing from local compressed media
        # copy it to temp
        copy($what, $tempdir);
      }
    }
    debug("un-xzing $xzfile to $tarfile\n");
    system("$xzdec < $xzfile_quote > $tarfile_quote");
    if (! -f $tarfile) {
      tlwarn("Unpacking $xzfile did not succeed.\n");
      return 0;
    }
    if (!TeXLive::TLUtils::untar($tarfile, $target, 1)) {
      tlwarn("untarring $tarfile failed, stopping install.\n");
      return 0;
    }
    # we remove the created .tlpobj it is recreated anyway in
    # install_packages above in the right place. This way we also
    # get rid of the $pkg.source.tlpobj which are useless
    unlink ("$target/tlpkg/tlpobj/$pkg.tlpobj")
      if (-r "$target/tlpkg/tlpobj/$pkg.tlpobj");
    if ($what =~ m,http://|ftp://,) {
      # we downloaded the original .tar.lzma from the net, so we keep it
    } else {
      # we are downloading it from local compressed media, so we can unlink it to save
      # disk space
      unlink($xzfile);
    }
  } else {
    tlwarn("Sorry, no idea how to install $what\n");
    return 0;
  }
  return 1;
}

=item C<do_postaction($how, $tlpobj, $do_fileassocs, $do_menu, $do_desktop, $do_script)>

Evaluates the C<postaction> fields in the C<$tlpobj>. The first parameter
can be either C<install> or C<remove>. The second gives the TLPOBJ whos
postactions should be evaluated, and the last four arguments specify
what type of postactions should (or shouldn't) be evaluated.

Returns 1 on success, and 0 on failure.

=cut

sub do_postaction {
  my ($how, $tlpobj, $do_fileassocs, $do_menu, $do_desktop, $do_script) = @_;
  my $ret = 1;
  if (!defined($tlpobj)) {
    tlwarn("do_postaction: didn't get a tlpobj\n");
    return 0;
  }
  debug("running postaction=$how for " . $tlpobj->name . "\n")
    if $tlpobj->postactions;
  for my $pa ($tlpobj->postactions) {
    if ($pa =~ m/^\s*shortcut\s+(.*)\s*$/) {
      $ret &&= _do_postaction_shortcut($how, $tlpobj, $do_menu, $do_desktop, $1);
    } elsif ($pa =~ m/\s*filetype\s+(.*)\s*$/) {
      next unless $do_fileassocs;
      $ret &&= _do_postaction_filetype($how, $tlpobj, $1);
    } elsif ($pa =~ m/\s*fileassoc\s+(.*)\s*$/) {
      $ret &&= _do_postaction_fileassoc($how, $do_fileassocs, $tlpobj, $1);
      next;
    } elsif ($pa =~ m/\s*progid\s+(.*)\s*$/) {
      next unless $do_fileassocs;
      $ret &&= _do_postaction_progid($how, $tlpobj, $1);
    } elsif ($pa =~ m/\s*script\s+(.*)\s*$/) {
      next unless $do_script;
      $ret &&= _do_postaction_script($how, $tlpobj, $1);
    } else {
      tlwarn("do_postaction: don't know how to do $pa\n");
      $ret = 0;
    }
  }
  # nothing to do
  return $ret;
}

sub _do_postaction_fileassoc {
  my ($how, $mode, $tlpobj, $pa) = @_;
  return 1 unless win32();
  my ($errors, %keyval) =
    parse_into_keywords($pa, qw/extension filetype/);

  if ($errors) {
    tlwarn("parsing the postaction line >>$pa<< did not succeed!\n");
    return 0;
  }

  # name can be an arbitrary string
  if (!defined($keyval{'extension'})) {
    tlwarn("extension of fileassoc postaction not given\n");
    return 0;
  }
  my $extension = $keyval{'extension'};

  # cmd can be an arbitrary string
  if (!defined($keyval{'filetype'})) {
    tlwarn("filetype of fileassoc postaction not given\n");
    return 0;
  }
  my $filetype = $keyval{'filetype'}.'.'.$ReleaseYear;

  &log("postaction $how fileassoc for " . $tlpobj->name .
    ": $extension, $filetype\n");
  if ($how eq "install") {
    TeXLive::TLWinGoo::register_extension($mode, $extension, $filetype);
  } elsif ($how eq "remove") {
    TeXLive::TLWinGoo::unregister_extension($mode, $extension, $filetype);
  } else {
    tlwarn("Unknown mode $how\n");
    return 0;
  }
  return 1;
}

sub _do_postaction_filetype {
  my ($how, $tlpobj, $pa) = @_;
  return 1 unless win32();
  my ($errors, %keyval) =
    parse_into_keywords($pa, qw/name cmd/);

  if ($errors) {
    tlwarn("parsing the postaction line >>$pa<< did not succeed!\n");
    return 0;
  }

  # name can be an arbitrary string
  if (!defined($keyval{'name'})) {
    tlwarn("name of filetype postaction not given\n");
    return 0;
  }
  my $name = $keyval{'name'}.'.'.$ReleaseYear;

  # cmd can be an arbitrary string
  if (!defined($keyval{'cmd'})) {
    tlwarn("cmd of filetype postaction not given\n");
    return 0;
  }
  my $cmd = $keyval{'cmd'};

  my $texdir = `kpsewhich -var-value=SELFAUTOPARENT`;
  chomp($texdir);
  my $texdir_bsl = conv_to_w32_path($texdir);
  $cmd =~ s!^("?)TEXDIR/!$1$texdir/!g;

  &log("postaction $how filetype for " . $tlpobj->name .
    ": $name, $cmd\n");
  if ($how eq "install") {
    TeXLive::TLWinGoo::register_file_type($name, $cmd);
  } elsif ($how eq "remove") {
    TeXLive::TLWinGoo::unregister_file_type($name);
  } else {
    tlwarn("Unknown mode $how\n");
    return 0;
  }
  return 1;
}

# alternate filetype (= progid) for an extension;
# associated program shows up in `open with' menu
sub _do_postaction_progid {
  my ($how, $tlpobj, $pa) = @_;
  return 1 unless win32();
  my ($errors, %keyval) =
    parse_into_keywords($pa, qw/extension filetype/);

  if ($errors) {
    tlwarn("parsing the postaction line >>$pa<< did not succeed!\n");
    return 0;
  }

  if (!defined($keyval{'extension'})) {
    tlwarn("extension of progid postaction not given\n");
    return 0;
  }
  my $extension = $keyval{'extension'};

  if (!defined($keyval{'filetype'})) {
    tlwarn("filetype of progid postaction not given\n");
    return 0;
  }
  my $filetype = $keyval{'filetype'}.'.'.$ReleaseYear;

  &log("postaction $how progid for " . $tlpobj->name .
    ": $extension, $filetype\n");
  if ($how eq "install") {
    TeXLive::TLWinGoo::add_to_progids($extension, $filetype);
  } elsif ($how eq "remove") {
    TeXLive::TLWinGoo::remove_from_progids($extension, $filetype);
  } else {
    tlwarn("Unknown mode $how\n");
    return 0;
  }
  return 1;
}

sub _do_postaction_script {
  my ($how, $tlpobj, $pa) = @_;
  my ($errors, %keyval) =
    parse_into_keywords($pa, qw/file filew32/);

  if ($errors) {
    tlwarn("parsing the postaction line >>$pa<< did not succeed!\n");
    return 0;
  }

  # file can be an arbitrary string
  if (!defined($keyval{'file'})) {
    tlwarn("filename of script not given\n");
    return 0;
  }
  my $file = $keyval{'file'};
  if (win32() && defined($keyval{'filew32'})) {
    $file = $keyval{'filew32'};
  }
  my $texdir = `kpsewhich -var-value=SELFAUTOPARENT`;
  chomp($texdir);
  my @syscmd;
  if ($file =~ m/\.pl$/i) {
    # we got a perl script, call it via perl
    push @syscmd, "perl", "$texdir/$file";
  } elsif ($file =~ m/\.texlua$/i) {
    # we got a texlua script, call it via texlua
    push @syscmd, "texlua", "$texdir/$file";
  } else {
    # we got anything else, call it directly and hope it is excutable
    push @syscmd, "$texdir/$file";
  }
  &log("postaction $how script for " . $tlpobj->name . ": @syscmd\n");
  push @syscmd, $how, $texdir;
  my $ret = system (@syscmd);
  if ($ret != 0) {
    $ret /= 256 if $ret > 0;
    my $pwd = cwd ();
    warn "$0: calling post action script $file did not succeed in $pwd, status $ret";
    return 0;
  }
  return 1;
}

sub _do_postaction_shortcut {
  my ($how, $tlpobj, $do_menu, $do_desktop, $pa) = @_;
  return 1 unless win32();
  my ($errors, %keyval) =
    parse_into_keywords($pa, qw/type name icon cmd args hide/);

  if ($errors) {
    tlwarn("parsing the postaction line >>$pa<< did not succeed!\n");
    return 0;
  }

  # type can be either menu or desktop
  if (!defined($keyval{'type'})) {
    tlwarn("type of shortcut postaction not given\n");
    return 0;
  }
  my $type = $keyval{'type'};
  if (($type ne "menu") && ($type ne "desktop")) {
    tlwarn("type of shortcut postaction $type is unknown (menu, desktop)\n");
    return 0;
  }

  if (($type eq "menu") && !$do_menu) {
    return 1;
  }
  if (($type eq "desktop") && !$do_desktop) {
    return 1;
  }

  # name can be an arbitrary string
  if (!defined($keyval{'name'})) {
    tlwarn("name of shortcut postaction not given\n");
    return 0;
  }
  my $name = $keyval{'name'};

  # icon, cmd, args is optional
  my $icon = (defined($keyval{'icon'}) ? $keyval{'icon'} : '');
  my $cmd = (defined($keyval{'cmd'}) ? $keyval{'cmd'} : '');
  my $args = (defined($keyval{'args'}) ? $keyval{'args'} : '');

  # hide can be only 0 or 1, and defaults to 1
  my $hide = (defined($keyval{'hide'}) ? $keyval{'hide'} : 1);
  if (($hide ne "0") && ($hide ne "1")) {
    tlwarn("hide of shortcut postaction $hide is unknown (0, 1)\n");
    return 0;
  }

  &log("postaction $how shortcut for " . $tlpobj->name . "\n");
  if ($how eq "install") {
    my $texdir = `kpsewhich -var-value=SELFAUTOPARENT`;
    chomp($texdir);
    my $texdir_bsl = conv_to_w32_path($texdir);
    $icon =~ s!^TEXDIR/!$texdir/!;
    $cmd =~ s!^TEXDIR/!$texdir/!;
    # $cmd can be an URL, in which case we do NOT want to convert it to
    # w32 paths!
    if ($cmd !~ m!^\s*(http://|ftp://)!) {
      $cmd = conv_to_w32_path($cmd);
    }
    if ($type eq "menu") {
      TeXLive::TLWinGoo::add_menu_shortcut(
                        $TeXLive::TLConfig::WindowsMainMenuName,
                        $name, $icon, $cmd, $args, $hide);
    } elsif ($type eq "desktop") {
      TeXLive::TLWinGoo::add_desktop_shortcut(
                        $name, $icon, $cmd, $args, $hide);
    } else {
      tlwarn("Unknown type of shortcut: $type\n");
      return 0;
    }
  } elsif ($how eq "remove") {
    if ($type eq "menu") {
      TeXLive::TLWinGoo::remove_menu_shortcut(
        $TeXLive::TLConfig::WindowsMainMenuName, $name);
    } elsif ($type eq "desktop") {
      TeXLive::TLWinGoo::remove_desktop_shortcut($name);
    } else {
      tlwarn("Unknown type of shortcut: $type\n");
      return 0;
    }
  } else {
    tlwarn("Unknown mode $how\n");
    return 0;
  }
  return 1;
}

sub parse_into_keywords {
  my ($str, @keys) = @_;
  my @words = quotewords('\s+', 0, $str);
  my %ret;
  my $error = 0;
  while (@words) {
    $_ = shift @words;
    if (/^([^=]+)=(.*)$/) {
      $ret{$1} = $2;
    } else {
      tlwarn("parser found a invalid word in parsing keys: $_\n");
      $error++;
      $ret{$_} = "";
    }
  }
  for my $k (keys %ret) {
    if (!member($k, @keys)) {
      $error++;
      tlwarn("parser found invalid keyword: $k\n");
    }
  }
  return($error, %ret);
}

=item C<announce_execute_actions($how, $tlpobj)>

Announces that the actions given in C<$tlpobj> should be executed
after all packages have been unpacked.

=cut

sub announce_execute_actions {
  my ($type, $tlp, $what) = @_;
  # do simply return immediately if execute actions are suppressed
  return if $::no_execute_actions;

  if (defined($type) && ($type eq "regenerate-formats")) {
    $::regenerate_all_formats = 1;
    return;
  }
  if (defined($type) && ($type eq "files-changed")) {
    $::files_changed = 1;
    return;
  }
  if (defined($type) && ($type eq "latex-updated")) {
    $::latex_updated = 1;
    return;
  }
  if (defined($type) && ($type eq "tex-updated")) {
    $::tex_updated = 1;
    return;
  }
  if (!defined($type) || (($type ne "enable") && ($type ne "disable"))) {
    die "announce_execute_actions: enable or disable, not type $type";
  }
  my (@maps, @formats, @dats);
  if ($tlp->runfiles || $tlp->srcfiles || $tlp->docfiles) {
    $::files_changed = 1;
  }
  $what = "map format hyphen" if (!defined($what));
  foreach my $e ($tlp->executes) {
    if ($e =~ m/^add((Mixed|Kanji)?Map)\s+([^\s]+)\s*$/) {
      # save the refs as we have another =~ grep in the following lines
      my $a = $1;
      my $b = $3;
      $::execute_actions{$type}{'maps'}{$b} = $a if ($what =~ m/map/);
    } elsif ($e =~ m/^AddFormat\s+(.*)\s*$/) {
      my %r = TeXLive::TLUtils::parse_AddFormat_line("$1");
      if (defined($r{"error"})) {
        tlwarn ("$r{'error'} in parsing $e for return hash\n");
      } else {
        $::execute_actions{$type}{'formats'}{$r{'name'}} = \%r
          if ($what =~ m/format/);
      }
    } elsif ($e =~ m/^AddHyphen\s+(.*)\s*$/) {
      my %r = TeXLive::TLUtils::parse_AddHyphen_line("$1");
      if (defined($r{"error"})) {
        tlwarn ("$r{'error'} in parsing $e for return hash\n");
      } else {
        $::execute_actions{$type}{'hyphens'}{$r{'name'}} = \%r
          if ($what =~ m/hyphen/);
      }
    } else {
      tlwarn("Unknown execute $e in ", $tlp->name, "\n");
    }
  }
}


=pod

=item C<add_symlinks($root, $arch, $sys_bin, $sys_man, $sys_info)>

=item C<remove_symlinks($root, $arch, $sys_bin, $sys_man, $sys_info)>

These two functions try to create/remove symlinks for binaries, man pages,
and info files as specified by the options $sys_bin, $sys_man, $sys_info.

The functions return 1 on success and 0 on error.
On Windows it returns undefined.

=cut

sub add_link_dir_dir {
  my ($from, $to) = @_;
  mkdirhier $to;
  if (-w  $to) {
    debug("linking files from $from to $to\n");
    chomp (@files = `ls "$from"`);
    my $ret = 1;
    for my $f (@files) {
      # skip certain dangerous entries that should never be linked somewhere
      if ($f eq "man") {
        debug("not linking man into $to.\n");
        next;
      }
      unlink("$to/$f");
      if (system("ln -s \"$from/$f\" \"$to\"")) {
        tlwarn("Linking $f from $from to $to failed: $!\n");
        $ret = 0;
      }
    }
    return $ret;
  } else {
    tlwarn("destination $to not writable, no linking files in $from done.\n");
    return 0;
  }
}

sub remove_link_dir_dir {
  my ($from, $to) = @_;
  if ((-d "$to") && (-w "$to")) {
    debug("removing links from $from to $to\n");
    chomp (@files = `ls "$from"`);
    my $ret = 1;
    foreach my $f (@files) {
      next if (! -r "$to/$f");
      if ($f eq "man") {
        debug("not considering man in $to, it should not be from us!\n");
        next;
      }
      if ((-l "$to/$f") &&
          (readlink("$to/$f") =~ m;^$from/;)) {
        $ret = 0 unless unlink("$to/$f");
      } else {
        $ret = 0;
        tlwarn ("not removing $to/$f, not a link or wrong destination!\n");
      }
    }
    # trry to remove the destination directory, it might be empty and
    # we might have write permissions, ignore errors
    # `rmdir "$to" 2>/dev/null`;
    return $ret;
  } else {
    tlwarn ("destination $to not writable, no removal of links done!\n");
    return 0;
  }
}

sub add_remove_symlinks {
  my ($mode, $Master, $arch, $sys_bin, $sys_man, $sys_info) = @_;
  my $errors = 0;
  my $plat_bindir = "$Master/bin/$arch";
  return if win32();
  if ($mode eq "add") {
    $errors++ unless add_link_dir_dir($plat_bindir, $sys_bin);
    if (-d "$Master/texmf-dist/doc/info") {
      $errors++
        unless add_link_dir_dir("$Master/texmf-dist/doc/info", $sys_info);
    }
  } elsif ($mode eq "remove") {
    $errors++ unless remove_link_dir_dir($plat_bindir, $sys_bin);
    if (-d "$Master/texmf-dist/doc/info") {
      $errors++
        unless remove_link_dir_dir("$Master/texmf-dist/doc/info", $sys_info);
    }
  } else {
    die ("should not happen, unknown mode $mode in add_remove_symlinks!");
  }
  mkdirhier $sys_man if ($mode eq "add");
  if (-w  $sys_man && -d "$Master/texmf-dist/doc/man") {
    debug("$mode symlinks for man pages in $sys_man\n");
    my $foo = `(cd "$Master/texmf-dist/doc/man" && echo *)`;
    chomp (my @mans = split (' ', $foo));
    foreach my $m (@mans) {
      my $mandir = "$Master/texmf-dist/doc/man/$m";
      next unless -d $mandir;
      if ($mode eq "add") {
        $errors++ unless add_link_dir_dir($mandir, "$sys_man/$m");
      } else {
        $errors++ unless remove_link_dir_dir($mandir, "$sys_man/$m");
      }
    }
    # `rmdir "$sys_man" 2>/dev/null` if ($mode eq "remove");
  } else {
    tlwarn("destination of man symlink $sys_man not writable, "
      . "cannot $mode symlinks.\n");
    $errors++;
  }
  # we collected errors in $ret, so return the negation of it
  if ($errors) {
    info("$mode of symlinks failed $errors times, please see above messages.\n");
    return 0;
  } else {
    return 1;
  }
}

sub add_symlinks {
  return (add_remove_symlinks("add", @_));
}
sub remove_symlinks {
  return (add_remove_symlinks("remove", @_));
}

=pod

=item C<w32_add_to_path($bindir, $multiuser)>
=item C<w32_remove_from_path($bindir, $multiuser)>

These two functions try to add/remove the binary directory $bindir
on Windows to the registry PATH variable.

If running as admin user and $multiuser is set, the system path will
be adjusted, otherwise the user path.

After calling these functions TeXLive::TLWinGoo::broadcast_env() should
be called to make the changes immediately visible.

=cut

sub w32_add_to_path {
  my ($bindir, $multiuser) = @_;
  return if (!win32());

  my $path = TeXLive::TLWinGoo::get_system_env() -> {'/Path'};
  $path =~ s/[\s\x00]+$//;
  &log("Old system path: $path\n");
  $path = TeXLive::TLWinGoo::get_user_env() -> {'/Path'};
  if ($path) {
    $path =~ s/[\s\x00]+$//;
    &log("Old user path: $path\n");
  } else {
    &log("Old user path: none\n");
  }
  my $mode = 'user';
  if (TeXLive::TLWinGoo::admin() && $multiuser) {
    $mode = 'system';
  }
  debug("TLUtils:w32_add_to_path: calling adjust_reg_path_for_texlive add $bindir $mode\n");
  TeXLive::TLWinGoo::adjust_reg_path_for_texlive('add', $bindir, $mode);
  $path = TeXLive::TLWinGoo::get_system_env() -> {'/Path'};
  $path =~ s/[\s\x00]+$//;
  &log("New system path: $path\n");
  $path = TeXLive::TLWinGoo::get_user_env() -> {'/Path'};
  if ($path) {
    $path =~ s/[\s\x00]+$//;
    &log("New user path: $path\n");
  } else {
    &log("New user path: none\n");
  }
}

sub w32_remove_from_path {
  my ($bindir, $multiuser) = @_;
  my $mode = 'user';
  if (TeXLive::TLWinGoo::admin() && $multiuser) {
    $mode = 'system';
  }
  debug("w32_remove_from_path: trying to remove $bindir in $mode\n");
  TeXLive::TLWinGoo::adjust_reg_path_for_texlive('remove', $bindir, $mode);
}

=pod

=item C<unpack($what, $targetdir>

If necessary, downloads C$what>, and then unpacks it into C<$targetdir>.
Returns the name of the unpacked package (determined from the name of C<$what>)
in case of success, otherwise undefined.

=cut

sub unpack {
  my ($what, $target) = @_;

  if (!defined($what)) {
    tlwarn("TLUtils::unpack: nothing to unpack!\n");
    return;
  }

  # we assume that $::progs has been set up!
  my $wget = $::progs{'wget'};
  my $xzdec = TeXLive::TLUtils::quotify_path_with_spaces($::progs{'xzdec'});
  if (!defined($wget) || !defined($xzdec)) {
    tlwarn("_install_package: programs not set up properly, strange.\n");
    return;
  }

  my $type;
  if ($what =~ m,\.tar(\.xz)?$,) {
    $type = defined($what) ? "xz" : "tar";
  } else {
    tlwarn("TLUtils::unpack: don't know how to unpack this: $what\n");
    return;
  }

  my $tempdir = tl_tmpdir();

  # we are still here, so something was handed in and we have either .tar or .tar.xz
  my $fn = basename($what);
  my $pkg = $fn;
  $pkg =~ s/\.tar(\.xz)?$//;
  my $tarfile;
  my $remove_tarfile = 1;
  if ($type eq "xz") {
    my $xzfile = "$tempdir/$fn";
    $tarfile  = "$tempdir/$fn"; $tarfile =~ s/\.xz$//;
    my $xzfile_quote = $xzfile;
    my $tarfile_quote = $tarfile;
    my $target_quote = $target;
    if (win32()) {
      $xzfile =~ s!/!\\!g;
      $tarfile =~ s!/!\\!g;
      $target =~ s!/!\\!g;
    }
    $xzfile_quote = "\"$xzfile\"";
    $tarfile_quote = "\"$tarfile\"";
    $target_quote = "\"$target\"";
    if ($what =~ m,http://|ftp://,) {
      # we are installing from the NET
      # download the file and put it into temp
      if (!download_file($what, $xzfile) || (! -r $xzfile)) {
        tlwarn("Downloading \n");
        tlwarn("   $what\n");
        tlwarn("did not succeed, please retry.\n");
        unlink($tarfile, $xzfile);
        return;
      }
    } else {
      # we are installing from local compressed files
      # copy it to temp
      TeXLive::TLUtils::copy($what, $tempdir);
    }
    debug("un-xzing $xzfile to $tarfile\n");
    system("$xzdec < $xzfile_quote > $tarfile_quote");
    if (! -f $tarfile) {
      tlwarn("TLUtils::unpack: Unpacking $xzfile failed, please retry.\n");
      unlink($tarfile, $xzfile);
      return;
    }
    unlink($xzfile);
  } else {
    $tarfile = "$tempdir/$fn";
    if ($what =~ m,http://|ftp://,) {
      if (!download_file($what, $tarfile) || (! -r $tarfile)) {
        tlwarn("Downloading \n");
        tlwarn("   $what\n");
        tlwarn("failed, please retry.\n");
        unlink($tarfile);
        return;
      }
    } else {
      $tarfile = $what;
      $remove_tarfile = 0;
    }
  }
  if (untar($tarfile, $target, $remove_tarfile)) {
    return "$pkg";
  } else {
    return;
  }
}

=pod

=item C<untar($tarfile, $targetdir, $remove_tarfile)>

Unpacks C<$tarfile> in C<$targetdir> (changing directories to
C<$targetdir> and then back to the original directory).  If
C<$remove_tarfile> is true, unlink C<$tarfile> after unpacking.

Assumes the global C<$::progs{"tar"}> has been set up.

=cut

# return 1 if success, 0 if failure.
sub untar {
  my ($tarfile, $targetdir, $remove_tarfile) = @_;
  my $ret;

  my $tar = $::progs{'tar'};  # assume it's been set up

  # don't use the -C option to tar since Solaris tar et al. don't support it.
  # don't use system("cd ... && $tar ...") since that opens us up to
  # quoting issues.
  # so fall back on chdir in Perl.
  #
  debug("unpacking $tarfile in $targetdir\n");
  my $cwd = cwd();
  chdir($targetdir) || die "chdir($targetdir) failed: $!";

  # on w32 don't extract file modified time, because AV soft can open
  # files in the mean time causing time stamp modification to fail
  if (system($tar, win32() ? "xmf" : "xf", $tarfile) != 0) {
    tlwarn("untar: untarring $tarfile failed (in $targetdir)\n");
    $ret = 0;
  } else {
    $ret = 1;
  }
  unlink($tarfile) if $remove_tarfile;

  chdir($cwd) || die "chdir($cwd) failed: $!";
  return $ret;
}


=item C<tlcmp($file, $file)>

Compare two files considering CR, LF, and CRLF as equivalent.
Returns 1 if different, 0 if the same.

=cut

sub tlcmp {
  my ($filea, $fileb) = @_;
  if (!defined($fileb)) {
    die <<END_USAGE;
tlcmp needs two arguments FILE1 FILE2.
Compare as text files, ignoring line endings.
Exit status is zero if the same, 1 if different, something else if trouble.
END_USAGE
  }
  my $file1 = &read_file_ignore_cr ($filea);
  my $file2 = &read_file_ignore_cr ($fileb);

  return $file1 eq $file2 ? 0 : 1;
}


=item C<read_file_ignore_cr($file)>

Return contents of FILE as a string, converting all of CR, LF, and
CRLF to just LF.

=cut

sub read_file_ignore_cr {
  my ($fname) = @_;
  my $ret = "";

  local *FILE;
  open (FILE, $fname) || die "open($fname) failed: $!";
  while (<FILE>) {
    s/\r\n?/\n/g;
    #warn "line is |$_|";
    $ret .= $_;
  }
  close (FILE) || warn "close($fname) failed: $!";

  return $ret;
}



=item C<setup_programs($bindir, $platform)>

Populate the global C<$::progs> hash containing the paths to the
programs C<wget>, C<tar>, C<xzdec>. The C<$bindir> argument specifies
the path to the location of the C<xzdec> binaries, the C<$platform>
gives the TeX Live platform name, used as the extension on our
executables.  If a program is not present in the TeX Live tree, we also
check along PATH (without the platform extension.)

Return 0 if failure, nonzero if success.

=cut

sub setup_programs {
  my ($bindir, $platform) = @_;
  my $ok = 1;

  $::progs{'wget'} = "wget";
  $::progs{'xzdec'} = "xzdec";
  $::progs{'xz'} = "xz";
  $::progs{'tar'} = "tar";

  if ($^O =~ /^MSWin(32|64)$/i) {
    $::progs{'wget'}    = conv_to_w32_path("$bindir/wget/wget.exe");
    $::progs{'tar'}     = conv_to_w32_path("$bindir/tar.exe");
    $::progs{'xzdec'} = conv_to_w32_path("$bindir/xz/xzdec.exe");
    $::progs{'xz'}    = conv_to_w32_path("$bindir/xz/xz.exe");
    for my $prog ("xzdec", "wget") {
      my $opt = $prog eq "xzdec" ? "--help" : "--version";
      my $ret = system("$::progs{$prog} $opt >nul 2>&1"); # on windows
      if ($ret != 0) {
        warn "TeXLive::TLUtils::setup_programs (w32) failed";  # no nl for perl
        warn "$::progs{$prog} $opt failed (status $ret): $!\n";
        warn "Output is:\n";
        system ("$::progs{$prog} $opt");
        warn "\n";
        $ok = 0;
      }
    }
  } else {
    if (!defined($platform) || ($platform eq "")) {
      # we assume that we run from uncompressed media, so we can call platform() and
      # thus also the config.guess script
      # but we have to setup $::installerdir because the platform script
      # relies on it
      $::installerdir = "$bindir/../..";
      $platform = platform();
    }
    my $s = 0;
    $s += setup_unix_one('wget', "$bindir/wget/wget.$platform", "--version");
    $s += setup_unix_one('xzdec',"$bindir/xz/xzdec.$platform","--help");
    $s += setup_unix_one('xz', "$bindir/xz/xz.$platform", "notest");
    $ok = ($s == 3);  # failure return unless all are present.
  }

  return $ok;
}


# setup one prog on unix using the following logic:
# - if the shipped one is -x and can be executed, use it
# - if the shipped one is -x but cannot be executed, copy it. set -x
#   . if the copy is -x and executable, use it
#   . if the copy is not executable, GOTO fallback
# - if the shipped one is not -x, copy it, set -x
#   . if the copy is -x and executable, use it
#   . if the copy is not executable, GOTO fallback
# - if nothing shipped, GOTO fallback
#
# fallback:
# if prog is found in PATH and can be executed, use it.
#
# Return 0 if failure, 1 if success.
#
sub setup_unix_one {
  my ($p, $def, $arg) = @_;
  our $tmp;
  my $test_fallback = 0;
  if (-r $def) {
    my $ready = 0;
    if (-x $def) {
      # checking only for the executable bit is not enough, we have
      # to check for actualy "executability" since a "noexec" mount
      # option may interfere, which is not taken into account by
      # perl's -x test.
      $::progs{$p} = $def;
      if ($arg ne "notest") {
        my $ret = system("$def $arg > /dev/null 2>&1" ); # we are on Unix
        if ($ret == 0) {
          $ready = 1;
          debug("Using shipped $def for $p (tested).\n");
        } else {
          ddebug("Shipped $def has -x but cannot be executed.\n");
        }
      } else {
        # do not test, just return
        $ready = 1;
        debug("Using shipped $def for $p (not tested).\n");
      }
    }
    if (!$ready) {
      # out of some reasons we couldn't execute the shipped program
      # try to copy it to a temp directory and make it executable
      #
      # create tmp dir only when necessary
      $tmp = TeXLive::TLUtils::tl_tmpdir() unless defined($tmp);
      # probably we are running from uncompressed media and want to copy it to
      # some temporary location
      copy($def, $tmp);
      my $bn = basename($def);
      $::progs{$p} = "$tmp/$bn";
      chmod(0755,$::progs{$p});
      # we do not check the return value of chmod, but check whether
      # the -x bit is now set, the only thing that counts
      if (! -x $::progs{$p}) {
        # hmm, something is going really bad, not even the copy is
        # executable. Fall back to normal path element
        $test_fallback = 1;
        ddebug("Copied $p $::progs{$p} does not have -x bit, strange!\n");
      } else {
        # check again for executability
        if ($arg ne "notest") {
          my $ret = system("$::progs{$p} $arg > /dev/null 2>&1");
          if ($ret == 0) {
            # ok, the copy works
            debug("Using copied $::progs{$p} for $p (tested).\n");
          } else {
            # even the copied prog is not executable, strange
            $test_fallback = 1;
            ddebug("Copied $p $::progs{$p} has x bit but not executable, strange!\n");
          }
        } else {
          debug("Using copied $::progs{$p} for $p (not tested).\n");
        }
      }
    }
  } else {
    # hope that we can find in in the global PATH
    $test_fallback = 1;
  }
  if ($test_fallback) {
    # all our playing around and copying did not succeed, try the
    # fallback
    $::progs{$p} = $p;
    if ($arg ne "notest") {
      my $ret = system("$p $arg > /dev/null 2>&1");
      if ($ret == 0) {
        debug("Using system $p (tested).\n");
      } else {
        tlwarn("$0: Initialization failed (in setup_unix_one):\n");
        tlwarn("$0: could not find a usable $p.\n");
        tlwarn("$0: Please install $p and try again.\n");
        return 0;
      }
    } else {
      debug ("Using system $p (not tested).\n");
    }
  }
  return 1;
}

=item C<download_file( $relpath, $destination [, $progs ] )>

Try to download the file given in C<$relpath> from C<$TeXLiveURL>
into C<$destination>, which can be either
a filename of simply C<|>. In the latter case a file handle is returned.

The optional argument C<$progs> is a reference to a hash giving full
paths to the respective programs, at least C<wget>.  If C<$progs> is not
given the C<%::progs> hash is consulted, and if this also does not exist
we try a literal C<wget>.

Downloading honors two environment variables: C<TL_DOWNLOAD_PROGRAM> and
C<TL_DOWNLOAD_ARGS>. The former overrides the above specification
devolving to C<wget>, and the latter overrides the default wget
arguments.

C<TL_DOWNLOAD_ARGS> must be defined so that the file the output goes to
is the first argument after the C<TL_DOWNLOAD_ARGS>.  Thus, typically it
would end in C<-O>.  Use with care.

=cut

sub download_file {
  my ($relpath, $dest, $progs) = @_;
  my $wget;
  if (defined($progs) && defined($progs->{'wget'})) {
    $wget = $progs->{'wget'};
  } elsif (defined($::progs{'wget'})) {
    $wget = $::progs{'wget'};
  } else {
    tlwarn ("download_file: Programs not set up, trying literal wget\n");
    $wget = "wget";
  }
  my $url;
  if ($relpath =~ m;^file://*(.*)$;) {
    my $filetoopen = "/$1";
    # $dest is a file name, we have to get the respective dirname
    if ($dest eq "|") {
      open(RETFH, "<$filetoopen") or
        die("Cannot open $filetoopen for reading");
      # opening to a pipe always succeeds, so we return immediately
      return \*RETFH;
    } else {
      my $par = dirname ($dest);
      if (-r $filetoopen) {
        copy ($filetoopen, $par);
        return 1;
      }
      return 0;
    }
  }
  if ($relpath =~ /^(http|ftp):\/\//) {
    $url = $relpath;
  } else {
    $url = "$TeXLiveURL/$relpath";
  }

  my $wget_retry = 0;
  if (defined($::tldownload_server) && $::tldownload_server->enabled) {
    debug("persistent connection set up, trying to get $url (for $dest)\n");
    $ret = $::tldownload_server->get_file($url, $dest);
    if ($ret) {
      debug("downloading file via persistent connection succeeded\n");
      return $ret;
    } else {
      tlwarn("TLUtils::download_file: persistent connection ok,"
             . " but download failed: $url\n");
      tlwarn("TLUtils::download_file: retrying with wget.\n");
      $wget_retry = 1; # just so we can give another msg.
    }
  } else {
    if (!defined($::tldownload_server)) {
      debug("::tldownload_server not defined\n");
    } else {
      debug("::tldownload_server->enabled is not set\n");
    }
    debug("persistent connection not set up, using wget\n");
  }
  
  # try again.
  my $ret = _download_file($url, $dest, $wget);
  
  if ($wget_retry) {
    tlwarn("TLUtils::download_file: retry with wget "
           . ($ret ? "succeeded" : "failed") . ": $url\n");
  }
  
  return($ret);
}

sub _download_file {
  my ($url, $dest, $wgetdefault) = @_;
  if (win32()) {
    $dest =~ s!/!\\!g;
  }

  my $wget = $ENV{"TL_DOWNLOAD_PROGRAM"} || $wgetdefault;
  my $wgetargs = $ENV{"TL_DOWNLOAD_ARGS"}
                 || "--user-agent=texlive/wget --tries=10 --timeout=$NetworkTimeout -q -O";

  debug("downloading $url using $wget $wgetargs\n");
  my $ret;
  if ($dest eq "|") {
    open(RETFH, "$wget $wgetargs - $url|")
    || die "open($url) via $wget $wgetargs failed: $!";
    # opening to a pipe always succeeds, so we return immediately
    return \*RETFH;
  } else {
    my @wgetargs = split (" ", $wgetargs);
    $ret = system ($wget, @wgetargs, $dest, $url);
    # we have to reverse the meaning of ret because system has 0=success.
    $ret = ($ret ? 0 : 1);
  }
  # return false/undef in case the download did not succeed.
  return ($ret) unless $ret;
  debug("download of $url succeeded\n");
  if ($dest eq "|") {
    return \*RETFH;
  } else {
    return 1;
  }
}

=item C<nulldev ()>

Return C</dev/null> on Unix and C<nul> on Windows.

=cut

sub nulldev {
  return (&win32)? 'nul' : '/dev/null';
}

=item C<get_full_line ($fh)>

returns the next line from the file handle $fh, taking 
continuation lines into account (last character of a line is \, and 
no quoting is parsed).

=cut

#     open my $f, '<', $file_name or die;
#     while (my $l = get_full_line($f)) { ... }
#     close $f or die;
sub get_full_line {
  my ($fh) = @_;
  my $line = <$fh>;
  return undef unless defined $line;
  return $line unless $line =~ s/\\\r?\n$//;
  my $cont = get_full_line($fh);
  if (!defined($cont)) {
    tlwarn('Continuation disallowed at end of file');
    $cont = "";
  }
  $cont =~ s/^\s*//;
  return $line . $cont;
}


=back

=head2 Installer Functions

=over 4

=item C<make_var_skeleton($prefix)>

Generate a skeleton of empty directories in the C<TEXMFSYSVAR> tree.

=cut

sub make_var_skeleton {
  my ($prefix) = @_;

  mkdirhier "$prefix/tex/generic/config";
  mkdirhier "$prefix/fonts/map/dvipdfm/updmap";
  mkdirhier "$prefix/fonts/map/dvips/updmap";
  mkdirhier "$prefix/fonts/map/pdftex/updmap";
  mkdirhier "$prefix/fonts/pk";
  mkdirhier "$prefix/fonts/tfm";
  mkdirhier "$prefix/web2c";
  mkdirhier "$prefix/xdvi";
  mkdirhier "$prefix/tex/context/config";
}


=item C<make_local_skeleton($prefix)>

Generate a skeleton of empty directories in the C<TEXMFLOCAL> tree,
unless C<TEXMFLOCAL> already exists.

=cut

sub make_local_skeleton {
  my ($prefix) = @_;

  return if (-d $prefix);

  mkdirhier "$prefix/bibtex/bib/local";
  mkdirhier "$prefix/bibtex/bst/local";
  mkdirhier "$prefix/doc/local";
  mkdirhier "$prefix/dvips/local";
  mkdirhier "$prefix/fonts/source/local";
  mkdirhier "$prefix/fonts/tfm/local";
  mkdirhier "$prefix/fonts/type1/local";
  mkdirhier "$prefix/fonts/vf/local";
  mkdirhier "$prefix/metapost/local";
  mkdirhier "$prefix/tex/latex/local";
  mkdirhier "$prefix/tex/plain/local";
  mkdirhier "$prefix/tlpkg";
  mkdirhier "$prefix/web2c";
}



=item C<create_fmtutil($tlpdb, $dest, $localconf)>

=item C<create_updmap($tlpdb, $dest, $localconf)>

=item C<create_language_dat($tlpdb, $dest, $localconf)>

=item C<create_language_def($tlpdb, $dest, $localconf)>

=item C<create_language_lua($tlpdb, $dest, $localconf)>

These five functions create C<fmtutil.cnf>, C<updmap.cfg>, C<language.dat>,
C<language.def>, and C<language.dat.lua> respectively, in C<$dest> (which by
default is below C<$TEXMFSYSVAR>).  These functions merge the information
present in the TLPDB C<$tlpdb> (formats, maps, hyphenations) with local
configuration additions: C<$localconf>.

Currently the merging is done by omitting disabled entries specified
in the local file, and then appending the content of the local
configuration files at the end of the file. We should also check for
duplicates, maybe even error checking.

=cut

#
# get_disabled_local_configs
# returns the list of disabled formats/hyphenpatterns/maps
# disabling is done by putting
#    #!NAME
# or
#    %!NAME
# into the respective foo-local.cnf/cfg file
# 
sub get_disabled_local_configs {
  my $localconf = shift;
  my $cc = shift;
  my @disabled = ();
  if (-r "$localconf") {
    open FOO, "<$localconf"
      or die "strange, -r ok but cannot open $localconf: $!";
    my @tmp = <FOO>;
    close(FOO) || warn("Closing $localconf did not succeed: $!");
    @disabled = map { if (m/^$cc!(\S+)\s*$/) { $1 } else { }} @tmp;
  }
  return @disabled;
}

sub create_fmtutil {
  my ($tlpdb,$dest,$localconf) = @_;
  my @lines = $tlpdb->fmtutil_cnf_lines(
                         get_disabled_local_configs($localconf, '#'));
  _create_config_files($tlpdb, "texmf-dist/web2c/fmtutil-hdr.cnf", $dest,
                       $localconf, 0, '#', \@lines);
}

sub create_updmap {
  my ($tlpdb,$dest) = @_;
  check_for_old_updmap_cfg();
  my @tlpdblines = $tlpdb->updmap_cfg_lines();
  _create_config_files($tlpdb, "texmf-dist/web2c/updmap-hdr.cfg", $dest,
                       undef, 0, '#', \@tlpdblines);
}

sub check_for_old_updmap_cfg {
  chomp( my $tmfsysconf = `kpsewhich -var-value=TEXMFSYSCONFIG` ) ;
  my $oldupd = "$tmfsysconf/web2c/updmap.cfg";
  return unless -r $oldupd;  # if no such file, good.

  open (OLDUPD, "<$oldupd") || die "open($oldupd) failed: $!";
  my $firstline = <OLDUPD>;
  close(OLDUPD);
  # cygwin returns undef when reading from an empty file, we have
  # to make sure that this is anyway initialized
  $firstline = "" if (!defined($firstline));
  chomp ($firstline);
  #
  if ($firstline =~ m/^# Generated by (install-tl|.*\/tlmgr) on/) {
    # assume it was our doing, rename it.
    my $nn = "$oldupd.DISABLED";
    if (-r $nn) {
      my $fh;
      ($fh, $nn) = File::Temp::tempfile( 
        "updmap.cfg.DISABLED.XXXXXX", DIR => "$tmfsysconf/web2c");
    }
    print "Renaming old config file from 
  $oldupd
to
  $nn
";
    if (rename($oldupd, $nn)) {
      if (system("mktexlsr", $tmfsysconf) != 0) {
        die "mktexlsr $tmfsysconf failed after updmap.cfg rename, fix fix: $!";
      }
      print "No further action should be necessary.\n";
    } else {
      print STDERR "
Renaming of
  $oldupd
did not succeed.  This config file should not be used anymore,
so please do what's necessary to eliminate it.
See the documentation for updmap.
";
    }

  } else {  # first line did not match
    # that is NOT a good idea, because updmap creates updmap.cfg in
    # TEXMFSYSCONFIG when called with --enable Map etc, so we should
    # NOT warn here
    # print STDERR "Apparently
#  $oldupd
# was created by hand.  This config file should not be used anymore,
# so please do what's necessary to eliminate it.
# See the documentation for updmap.
# ";
  }
}

sub check_updmap_config_value {
  my ($k, $v, $f) = @_;
  return 0 if !defined($k);
  return 0 if !defined($v);
  if (member( $k, qw/dvipsPreferOutline dvipsDownloadBase35 
                     pdftexDownloadBase14 dvipdfmDownloadBase14/)) {
    if ($v eq "true" || $v eq "false") {
      return 1;
    } else {
      tlwarn("Unknown setting for $k in $f: $v\n");
      return 0;
    }
  } elsif ($k eq "LW35") {
    if (member($v, qw/URW URWkb ADOBE ADOBEkb/)) {
      return 1;
    } else {
      tlwarn("Unknown setting for LW35  in $f: $v\n");
      return 0;
    }
  } elsif ($k eq "kanjiEmbed") {
    # any string is fine
    return 1;
  } else {
    return 0;
  }
}

sub create_language_dat {
  my ($tlpdb,$dest,$localconf) = @_;
  # no checking for disabled stuff for language.dat and .def
  my @lines = $tlpdb->language_dat_lines(
                         get_disabled_local_configs($localconf, '%'));
  _create_config_files($tlpdb, "texmf-dist/tex/generic/config/language.us",
                       $dest, $localconf, 0, '%', \@lines);
}

sub create_language_def {
  my ($tlpdb,$dest,$localconf) = @_;
  # no checking for disabled stuff for language.dat and .def
  my @lines = $tlpdb->language_def_lines(
                         get_disabled_local_configs($localconf, '%'));
  my @postlines;
  push @postlines, "%%% No changes may be made beyond this point.\n";
  push @postlines, "\n";
  push @postlines, "\\uselanguage {USenglish}             %%% This MUST be the last line of the file.\n";
  _create_config_files ($tlpdb,"texmf-dist/tex/generic/config/language.us.def",
                        $dest, $localconf, 1, '%', \@lines, @postlines);
}

sub create_language_lua {
  my ($tlpdb,$dest,$localconf) = @_;
  # no checking for disabled stuff for language.dat and .lua
  my @lines = $tlpdb->language_lua_lines(
                         get_disabled_local_configs($localconf, '--'));
  my @postlines = ("}\n");
  _create_config_files ($tlpdb,"texmf-dist/tex/generic/config/language.us.lua",
                        $dest, $localconf, 0, '--', \@lines, @postlines);
}

sub _create_config_files {
  my ($tlpdb, $headfile, $dest,$localconf, $keepfirstline, $cc,
      $tlpdblinesref, @postlines) = @_;
  my $root = $tlpdb->root;
  my @lines = ();
  if (-r "$root/$headfile") {
    # we might be in user mode and do *not* want that the generation
    # of the configuration file just boils out.
    open (INFILE, "<$root/$headfile")
      || die "open($root/$headfile) failed, but -r ok: $!";
    @lines = <INFILE>;
    close (INFILE);
  } else {
    tlwarn("TLUtils::_create_config_files: $root/$headfile: "
           . " head file not found, ok in user mode");
  }
  push @lines, @$tlpdblinesref;
  if (defined($localconf) && -r $localconf) {
    #
    # this should be done more intelligently, but for now only add those
    # lines without any duplication check ...
    open (FOO, "<$localconf")
      || die "strange, -r ok but cannot open $localconf: $!";
    my @tmp = <FOO>;
    close (FOO);
    push @lines, @tmp;
  }
  if (@postlines) {
    push @lines, @postlines;
  }
  if ($#lines >= 0) {
    open(OUTFILE,">$dest")
      or die("Cannot open $dest for writing: $!");

    if (!$keepfirstline) {
      print OUTFILE $cc;
      printf OUTFILE " Generated by %s on %s\n", "$0", scalar localtime;
    }
    print OUTFILE @lines;
    close(OUTFILE) || warn "close(>$dest) failed: $!";
  }
}

sub parse_AddHyphen_line {
  my $line = shift;
  my %ret;
  # default values
  my $default_lefthyphenmin = 2;
  my $default_righthyphenmin = 3;
  $ret{"lefthyphenmin"} = $default_lefthyphenmin;
  $ret{"righthyphenmin"} = $default_righthyphenmin;
  $ret{"synonyms"} = [];
  for my $p (quotewords('\s+', 0, "$line")) {
    my ($a, $b) = split /=/, $p;
    if ($a eq "name") {
      if (!$b) {
        $ret{"error"} = "AddHyphen line needs name=something";
        return %ret;
      }
      $ret{"name"} = $b;
      next;
    }
    if ($a eq "lefthyphenmin") {
      $ret{"lefthyphenmin"} = ( $b ? $b : $default_lefthyphenmin );
      next;
    }
    if ($a eq "righthyphenmin") {
      $ret{"righthyphenmin"} = ( $b ? $b : $default_righthyphenmin );
      next;
    }
    if ($a eq "file") {
      if (!$b) {
        $ret{"error"} = "AddHyphen line needs file=something";
        return %ret;
      }
      $ret{"file"} = $b;
      next;
    }
    if ($a eq "file_patterns") {
        $ret{"file_patterns"} = $b;
        next;
    }
    if ($a eq "file_exceptions") {
        $ret{"file_exceptions"} = $b;
        next;
    }
    if ($a eq "luaspecial") {
        $ret{"luaspecial"} = $b;
        next;
    }
    if ($a eq "databases") {
      @{$ret{"databases"}} = split /,/, $b;
      next;
    }
    if ($a eq "synonyms") {
      @{$ret{"synonyms"}} = split /,/, $b;
      next;
    }
    if ($a eq "comment") {
        $ret{"comment"} = $b;
        next;
    }
    # should not be reached at all
    $ret{"error"} = "Unknown language directive $a";
    return %ret;
  }
  # this default value couldn't be set earlier
  if (not defined($ret{"databases"})) {
    if (defined $ret{"file_patterns"} or defined $ret{"file_exceptions"}
        or defined $ret{"luaspecial"}) {
      @{$ret{"databases"}} = qw(dat def lua);
    } else {
      @{$ret{"databases"}} = qw(dat def);
    }
  }
  return %ret;
}


sub parse_AddFormat_line {
  my $line = shift;
  my %ret;
  $ret{"options"} = "";
  $ret{"patterns"} = "-";
  $ret{"mode"} = 1;
  for my $p (quotewords('\s+', 0, "$line")) {
    my ($a, $b);
    if ($p =~ m/^(name|engine|mode|patterns|options)=(.*)$/) {
      $a = $1;
      $b = $2;
    } else {
      $ret{"error"} = "Unknown format directive $p";
      return %ret;
    }
    if ($a eq "name") {
      if (!$b) {
        $ret{"error"} = "AddFormat line needs name=something";
        return %ret;
      }
      $ret{"name"} = $b;
      next;
    }
    if ($a eq "engine") {
      if (!$b) {
        $ret{"error"} = "AddFormat line needs engine=something";
        return %ret;
      }
      $ret{"engine"} = $b;
      next;
    }
    if ($a eq "patterns") {
      $ret{"patterns"} = ( $b ? $b : "-" );
      next;
    }
    if ($a eq "mode") {
      $ret{"mode"} = ( $b eq "disabled" ? 0 : 1 );
      next;
    }
    if ($a eq "options") {
      $ret{"options"} = ( $b ? $b : "" );
      next;
    }
    # should not be reached at all
    $ret{"error"} = "Unknown format directive $p";
    return %ret;
  }
  return %ret;
}


=back

=head2 Miscellaneous

Ideas from Fabrice Popineau's C<FileUtils.pm>.

=over 4

=item C<sort_uniq(@list)>

The C<sort_uniq> function sorts the given array and throws away multiple
occurrences of elements. It returns a sorted and unified array.

=cut

sub sort_uniq {
  my (@l) = @_;
  my ($e, $f, @r);
  $f = "";
  @l = sort(@l);
  foreach $e (@l) {
    if ($e ne $f) {
      $f = $e;
      push @r, $e;
    }
  }
  return @r;
}


=item C<push_uniq(\@list, @items)>

The C<push_uniq> function pushes the last elements on the list referenced
by the first argument.

=cut

sub push_uniq {
  # can't we use $l as a reference, and then use my?  later ...
  local (*l, @le) = @_;
  foreach my $e (@le) {
    if (! &member($e, @l)) {
      push @l, $e;
    }
  }
}


=item C<member($item, @list)>

The C<member> function returns true if the the first argument is contained
in the list of the remaining arguments.

=cut

sub member {
  my $what = shift;
  return scalar grep($_ eq $what, @_);
}


=item C<merge_into(\%to, \%from)>

Merges the keys of %from into %to.

=cut

sub merge_into {
  my ($to, $from) = @_;
  foreach my $k (keys %$from) {
    if (defined($to->{$k})) {
      push @{$to->{$k}}, @{$from->{$k}};
    } else {
      $to->{$k} = [ @{$from->{$k}} ];
    }
  }
}


=item C<texdir_check($texdir)>

Test whether installation with TEXDIR set to $texdir would succeed due to
writing permissions.

Writable or not, we will not allow installation to the root
directory (Unix) or the root of a drive (Windows).

=cut

sub texdir_check {
  my $texdir = shift;
  return 0 unless defined $texdir;
  # convert to absolute/canonical, for safer parsing
  # tl_abs_path should work as long as grandparent exists
  $texdir = tl_abs_path($texdir);
  return 0 unless defined $texdir;
  # also reject the root of a drive/volume,
  # assuming that only the canonical form of the root ends with /
  return 0 if $texdir =~ m!/$!;
  my $texdirparent;
  my $texdirpparent;

  return dir_writable($texdir) if (-d $texdir);
  ($texdirparent = $texdir) =~ s!/[^/]*$!!;
  #print STDERR "Checking $texdirparent".'[/]'."\n";
  return  dir_creatable($texdirparent) if -d dir_slash($texdirparent);
  # try another level up the tree
  ($texdirpparent = $texdirparent) =~ s!/[^/]*$!!;
  #print STDERR "Checking $texdirpparent".'[/]'."\n";
  return dir_creatable($texdirpparent) if -d dir_slash($texdirpparent);
  return 0;
}


# no newlines or spaces are added, multiple args are just concatenated.
#
sub logit {
  my ($out, $level, @rest) = @_;
  _logit($out, $level, @rest) unless $::opt_quiet;
  _logit('file', $level, @rest);
}

sub _logit {
  my ($out, $level, @rest) = @_;
  if ($::opt_verbosity >= $level) {
    # if $out is a ref/glob to STDOUT or STDERR, print it there
    if (ref($out) eq "GLOB") {
      print $out @rest;
    } else {
      # we should log it into the logfile, but that might be not initialized
      # so either print it to the filehandle $::LOGFILE, or push it onto
      # the to be printed log lines @::LOGLINES
      if (defined($::LOGFILE)) {
        print $::LOGFILE @rest;
      } else {
        push (@::LOGLINES, join ("", @rest));
      }
    }
  }
}


=item C<info ($str1, $str2, ...)>

Write a normal informational message, the concatenation of the argument
strings.  The message will be written unless C<-q> was specified.  If
the global C<$::machinereadable> is set (the C<--machine-readable>
option to C<tlmgr>), then output is written to stderr, else to stdout.
If the log file (see L<process_logging_options>) is defined, it also
writes there.

It is best to use this sparingly, mainly to give feedback during lengthy
operations and for final results.

=cut

sub info {
  my $str = join("", @_);
  my $fh = ($::machinereadable ? \*STDERR : \*STDOUT);
  logit($fh, 0, $str);
  for my $i (@::info_hook) {
    &{$i}($str);
  }
}


=item C<debug ($str1, $str2, ...)>

Write a debugging message, the concatenation of the argument strings.
The message will be omitted unless C<-v> was specified.  If the log
file (see L<process_logging_options>) is defined, it also writes there.

This first level debugging message reports on the overall flow of
work, but does not include repeated messages about processing of each
package.

=cut

sub debug {
  my $str = "D:" . join("", @_);
  return if ($::opt_verbosity < 1);
  logit(\*STDOUT, 1, $str);
  for my $i (@::debug_hook) {
    &{$i}($str);
  }
}


=item C<ddebug ($str1, $str2, ...)>

Write a deep debugging message, the concatenation of the argument
strings.  The message will be omitted unless C<-v -v> (or higher) was
specified.  If the log file (see L<process_logging_options>) is defined,
it also writes there.

This second level debugging message reports messages about processing
each package, in addition to the first level.

=cut

sub ddebug {
  my $str = "DD:" . join("", @_);
  return if ($::opt_verbosity < 2);
  logit(\*STDOUT, 2, $str);
  for my $i (@::ddebug_hook) {
    &{$i}($str);
  }
}

=item C<dddebug ($str1, $str2, ...)>

Write the deepest debugging message, the concatenation of the argument
strings.  The message will be omitted unless C<-v -v -v> was specified.
If the log file (see L<process_logging_options>) is defined, it also
writes there.

This third level debugging message reports messages about processing
each line of any tlpdb files read, in addition to the first and second
levels.

=cut

sub dddebug {
  my $str = "DDD:" . join("", @_);
  return if ($::opt_verbosity < 3);
  logit(\*STDOUT, 3, $str);
  for my $i (@::dddebug_hook) {
    &{$i}($str);
  }
}


=item C<log ($str1, $str2, ...)>

Write a message to the log file (and nowhere else), the concatenation of
the argument strings.

=cut

sub log {
  my $savequiet = $::opt_quiet;
  $::opt_quiet = 0;
  _logit('file', -100, @_);
  $::opt_quiet = $savequiet;
}


=item C<tlwarn ($str1, $str2, ...)>

Write a warning message, the concatenation of the argument strings.
This always and unconditionally writes the message to standard error; if
the log file (see L<process_logging_options>) is defined, it also writes
there.

=cut

sub tlwarn {
  my $savequiet = $::opt_quiet;
  my $str = join("", @_);
  $::opt_quiet = 0;
  logit (\*STDERR, -100, $str);
  $::opt_quiet = $savequiet;
  for my $i (@::warn_hook) {
    &{$i}($str);
  }
}

=item C<tldie ($str1, $str2, ...)>

Uses C<tlwarn> to issue a warning, then exits with exit code 1.

=cut

sub tldie {
  tlwarn(@_);
  exit(1);
}

=item C<debug_hash ($label, hash))>

Write LABEL followed by HASH elements, all on one line, to stderr.
If HASH is a reference, it is followed.

=cut

sub debug_hash {
  my ($label) = shift;
  my (%hash) = (ref $_[0] && $_[0] =~ /.*HASH.*/) ? %{$_[0]} : @_;

  my $str = "$label: {";
  my @items = ();
  for my $key (sort keys %hash) {
    my $val = $hash{$key};
    $key =~ s/\n/\\n/g;
    $val =~ s/\n/\\n/g;
    push (@items, "$key:$val");
  }
  $str .= join (",", @items);
  $str .= "}";

  warn "$str\n";
}


=item C<process_logging_options ($texdir)>

This function handles the common logging options for TeX Live scripts.
It should be called before C<GetOptions> for any program-specific option
handling.  For our conventional calling sequence, see (for example) the
L<tlpfiles> script.

These are the options handled here:

=over 4

=item B<-q>

Omit normal informational messages.

=item B<-v>

Include debugging messages.  With one C<-v>, reports overall flow; with
C<-v -v> (or C<-vv>), also reports per-package processing; with C<-v -v
-v> (or C<-vvv>), also reports each line read from any tlpdb files.
Further repeats of C<-v>, as in C<-v -v -v -v>, are accepted but
ignored.  C<-vvvv> is an error.

The idea behind these levels is to be able to specify C<-v> to get an
overall idea of what is going on, but avoid terribly voluminous output
when processing many packages, as we often are.  When debugging a
specific problem with a specific package, C<-vv> can help.  When
debugging problems with parsing tlpdb files, C<-vvv> gives that too.

=item B<-logfile> I<file>

Write all messages (informational, debugging, warnings) to I<file>, in
addition to standard output or standard error.  In TeX Live, only the
installer sets a log file by default; none of the other standard TeX
Live scripts use this feature, but you can specify it explicitly.

=back

See also the L<info>, L<debug>, L<ddebug>, and L<tlwarn> functions,
which actually write the messages.

=cut

sub process_logging_options {
  $::opt_verbosity = 0;
  $::opt_quiet = 0;
  my $opt_logfile;
  my $opt_Verbosity = 0;
  my $opt_VERBOSITY = 0;
  # check all the command line options for occurrences of -q and -v;
  # do not report errors.
  my $oldconfig = Getopt::Long::Configure(qw(pass_through permute));
  GetOptions("logfile=s" => \$opt_logfile,
             "v+"  => \$::opt_verbosity,
             "vv"  => \$opt_Verbosity,
             "vvv" => \$opt_VERBOSITY,
             "q"   => \$::opt_quiet);
  Getopt::Long::Configure($oldconfig);

  # verbosity level, forcing -v -v instead of -vv is too annoying.
  $::opt_verbosity = 2 if $opt_Verbosity;
  $::opt_verbosity = 3 if $opt_VERBOSITY;

  # open log file if one was requested.
  if ($opt_logfile) {
    open(TLUTILS_LOGFILE, ">$opt_logfile") || die "open(>$opt_logfile) failed: $!\n";
    $::LOGFILE = \*TLUTILS_LOGFILE;
    $::LOGFILENAME = $opt_logfile;
  }
}

=pod

This function takes a single argument I<path> and returns it with
C<"> chars surrounding it on Unix.  On Windows, the C<"> chars are only
added if I<path> a few special characters, since unconditional quoting
leads to errors there.  In all cases, any C<"> chars in I<path> itself
are (erroneously) eradicated.
 
=cut

sub quotify_path_with_spaces {
  my $p = shift;
  my $m = win32() ? '[+=^&();,!%\s]' : '.';
  if ( $p =~ m/$m/ ) {
    $p =~ s/"//g; # remove any existing double quotes
    $p = "\"$p\""; 
  }
  return($p);
}

=pod

This function returns a "Windows-ized" version of its single argument
I<path>, i.e., replaces all forward slashes with backslashes, and adds
an additional C<"> at the beginning and end if I<path> contains any
spaces.  It also makes the path absolute. So if $path does not start
with one (arbitrary) characer followed by C<:>, we add the output of
C<`cd`>.

The result is suitable for running in shell commands, but not file tests
or other manipulations, since in such internal Perl contexts, the quotes
would be considered part of the filename.

=cut

sub conv_to_w32_path {
  my $p = shift;
  # we need absolute paths, too
  my $pabs = tl_abs_path($p);
  if (not defined $pabs) {
    $pabs = $p;
    tlwarn ("sorry, could not determine absolute path of $p!\n".
      "using original path instead");
  }
  $pabs =~ s!/!\\!g;
  $pabs = quotify_path_with_spaces($pabs);
  return($pabs);
}

=pod

The next two functions are meant for user input/output in installer menus.
They help making the windows user happy by turning slashes into backslashes
before displaying a path, and our code happy by turning backslashes into forwars
slashes after reading a path. They both are no-ops on Unix.

=cut

sub native_slashify {
  my ($r) = @_;
  $r =~ s!/!\\!g if win32();
  return $r;
}

sub forward_slashify {
  my ($r) = @_;
  $r =~ s!\\!/!g if win32();
  return $r;
}

=item C<setup_persistent_downloads()>

Set up to use persistent connections using LWP/TLDownload, that is look
for a download server.  Return the TLDownload object if successful, else
false.

=cut

sub setup_persistent_downloads {
  if ($TeXLive::TLDownload::net_lib_avail) {
    ddebug("setup_persistent_downloads has net_lib_avail set\n");
    $::tldownload_server = TeXLive::TLDownload->new;
    if (!defined($::tldownload_server)) {
      ddebug("TLUtils:setup_persistent_downloads: failed to get ::tldownload_server\n");
    } else {
      ddebug("TLUtils:setup_persistent_downloads: got ::tldownload_server\n");
    }
    return $::tldownload_server;
  }
  return 0;
}


=item C<query_ctan_mirror()>

Return a particular mirror given by the generic CTAN auto-redirecting
default (specified in L<$TLConfig::TexLiveServerURL>) if we get a
response, else the empty string.

Neither C<TL_DOWNLOAD_PROGRAM> nor <TL_DOWNLOAD_ARGS> is honored (see
L<download_file>), since certain options have to be set to do the job
and the program has to be C<wget> since we parse the output.

=cut

sub query_ctan_mirror {
  my $wget = $::progs{'wget'};
  if (!defined ($wget)) {
    tlwarn("query_ctan_mirror: Programs not set up, trying wget\n");
    $wget = "wget";
  }

  # we need the verbose output, so no -q.
  # do not reduce retries here, but timeout still seems desirable.
  my $mirror = $TeXLiveServerURL;
  my $cmd = "$wget $mirror --timeout=$NetworkTimeout -O "
            . (win32() ? "nul" : "/dev/null") . " 2>&1";

  #
  # since we are reading the output of wget to find a mirror
  # we have to make sure that the locale is unset
  my $saved_lcall;
  if (defined($ENV{'LC_ALL'})) {
    $saved_lcall = $ENV{'LC_ALL'};
  }
  $ENV{'LC_ALL'} = "C";
  # we try 3 times to get a mirror from mirror.ctan.org in case we have
  # bad luck with what gets returned.
  my $max_trial = 3;
  my $mhost;
  for (my $i = 1; $i <= $max_trial; $i++) {
    my @out = `$cmd`;
    # analyze the output for the mirror actually selected.
    foreach (@out) {
      if (m/^Location: (\S*)\s*.*$/) {
        (my $mhost = $1) =~ s,/*$,,;  # remove trailing slashes since we add it
        return $mhost;
      }
    }
    sleep(1);
  }

  # reset LC_ALL to undefined or the previous value
  if (defined($saved_lcall)) {
    $ENV{'LC_ALL'} = $saved_lcall;
  } else {
    delete($ENV{'LC_ALL'});
  }

  # we are still here, so three times we didn't get a mirror, give up 
  # and return undefined
  return;
}
  
=item C<check_on_working_mirror($mirror)>

Check if MIRROR is functional.

=cut

sub check_on_working_mirror {
  my $mirror = shift;

  my $wget = $::progs{'wget'};
  if (!defined ($wget)) {
    tlwarn ("check_on_working_mirror: Programs not set up, trying wget\n");
    $wget = "wget";
  }
  $wget = quotify_path_with_spaces($wget);
  #
  # the test is currently not completely correct, because we do not
  # use the LWP if it is set up for it, but I am currently too lazy
  # to program it,
  # so try wget and only check for the return value
  # please KEEP the / after $mirror, some ftp mirrors do give back
  # an error if the / is missing after ../CTAN/
  my $cmd = "$wget $mirror/ --timeout=$NetworkTimeout -O "
            . (win32() ? "nul" : "/dev/null")
            . " 2>" . (win32() ? "nul" : "/dev/null");
  my $ret = system($cmd);
  # if return value is not zero it is a failure, so switch the meanings
  return ($ret ? 0 : 1);
}

=item C<give_ctan_mirror_base()>

 1. get a mirror (retries 3 times to contact mirror.ctan.org)
    - if no mirror found, use one of the backbone servers
    - if it is an http server return it (no test is done)
    - if it is a ftp server, continue
 2. if the ftp mirror is good, return it
 3. if the ftp mirror is bad, search for http mirror (5 times)
 4. if http mirror is found, return it (again, no test,)
 5. if no http mirror is found, return one of the backbone servers

=cut

sub give_ctan_mirror_base {
  my @backbone = qw!http://www.ctan.org/tex-archive
                    http://www.tex.ac.uk/tex-archive
                    http://dante.ctan.org/tex-archive!;

  # start by selecting a mirror and test its operationality
  my $mirror = query_ctan_mirror();
  if (!defined($mirror)) {
    # three times calling mirror.ctan.org did not give anything useful,
    # return one of the backbone servers
    tlwarn("cannot contact mirror.ctan.org, returning a backbone server!\n");
    return $backbone[int(rand($#backbone + 1))];
  }

  if ($mirror =~ m!^http://!) {  # if http mirror, assume good and return.
    return $mirror;
  }

  # we are still here, so we got a ftp mirror from mirror.ctan.org
  if (check_on_working_mirror($mirror)) {
    return $mirror;  # ftp mirror is working, return.
  }

  # we are still here, so the ftp mirror failed, retry and hope for http.
  # theory is that if one ftp fails, probably all ftp is broken.
  my $max_mirror_trial = 5;
  for (my $try = 1; $try <= $max_mirror_trial; $try++) {
    my $m = query_ctan_mirror();
    debug("querying mirror, got " . (defined($m) ? $m : "(nothing)") . "\n");
    if (defined($m) && $m =~ m!^http://!) {
      return $m;  # got http this time, assume ok.
    }
    # sleep to make mirror happy, but only if we are not ready to return
    sleep(1) if $try < $max_mirror_trial;
  }

  # 5 times contacting the mirror service did not return a http server,
  # use one of the backbone servers.
  debug("no mirror found ... randomly selecting backbone\n");
  return $backbone[int(rand($#backbone + 1))];
}


sub give_ctan_mirror {
  return (give_ctan_mirror_base(@_) . "/$TeXLiveServerPath");
}

=item C<create_mirror_list()>

=item C<extract_mirror_entry($listentry)>

C<create_mirror_list> returns the lists of viable mirrors according to 
ctan-mirrors.pl, in a list which also contains continents, and country headers.

C<extract_mirror_entry> extracts the actual repository data from one
of these entries.

# KEEP THESE TWO FUNCTIONS IN SYNC!!!

=cut

sub create_mirror_list {
  our $mirrors;
  my @ret = ();
  require("installer/ctan-mirrors.pl");
  my @continents = sort keys %$mirrors;
  for my $continent (@continents) {
    # first push the name of the continent
    push @ret, uc($continent);
    my @countries = sort keys %{$mirrors->{$continent}};
    for my $country (@countries) {
      my @mirrors = sort keys %{$mirrors->{$continent}{$country}};
      my $first = 1;
      for my $mirror (@mirrors) {
        my $mfull = $mirror;
        $mfull =~ s!/$!!;
        # do not append the server path part here, but add
        # it down there in the extract mirror entry
        #$mfull .= "/" . $TeXLive::TLConfig::TeXLiveServerPath;
        #if ($first) {
          my $country_str = sprintf "%-12s", $country;
          push @ret, "  $country_str  $mfull";
        #  $first = 0;
        #} else {
        #  push @ret, "    $mfull";
        #}
      }
    }
  }
  return @ret;
}

# extract_mirror_entry is not very intelligent, it assumes that
# the last "word" is the URL
sub extract_mirror_entry {
  my $ent = shift;
  my @foo = split ' ', $ent;
  return $foo[$#foo] . "/" . $TeXLive::TLConfig::TeXLiveServerPath;
}

sub tlmd5 {
  my ($file) = @_;
  if (-r $file) {
    open(FILE, $file) || die "open($file) failed: $!";
    binmode(FILE);
    my $md5hash = Digest::MD5->new->addfile(*FILE)->hexdigest;
    close(FILE);
    return $md5hash;
  } else {
    tlwarn("tlmd5, given file not readable: $file\n");
    return "";
  }
}

#
# compare_tlpobjs 
# returns a hash
#   $ret{'revision'} = "leftRev:rightRev"     if revision differ
#   $ret{'removed'} = \[ list of files removed from A to B ]
#   $ret{'added'} = \[ list of files added from A to B ]
#
sub compare_tlpobjs {
  my ($tlpA, $tlpB) = @_;
  my %ret;
  my @rem;
  my @add;

  my $rA = $tlpA->revision;
  my $rB = $tlpB->revision;
  if ($rA != $rB) {
    $ret{'revision'} = "$rA:$rB";
  }
  if ($tlpA->relocated) {
    $tlpA->replace_reloc_prefix;
  }
  if ($tlpB->relocated) {
    $tlpB->replace_reloc_prefix;
  }
  my @fA = $tlpA->all_files;
  my @fB = $tlpB->all_files;
  my %removed;
  my %added;
  for my $f (@fA) { $removed{$f} = 1; }
  for my $f (@fB) { delete($removed{$f}); $added{$f} = 1; }
  for my $f (@fA) { delete($added{$f}); }
  @rem = sort keys %removed;
  @add = sort keys %added;
  $ret{'removed'} = \@rem if @rem;
  $ret{'added'} = \@add if @add;
  return %ret;
}

#
# compare_tlpdbs
# return several hashes
# @{$ret{'removed_packages'}} = list of removed packages from A to B
# @{$ret{'added_packages'}} = list of added packages from A to B
# $ret{'different_packages'}->{$package} = output of compare_tlpobjs
#
sub compare_tlpdbs {
  my ($tlpdbA, $tlpdbB, @add_ignored_packs) = @_;
  my @ignored_packs = qw/00texlive.installer 00texlive.image/;
  push @ignored_packs, @add_ignored_packs;

  my @inAnotinB;
  my @inBnotinA;
  my %diffpacks;
  my %do_compare;
  my %ret;

  for my $p ($tlpdbA->list_packages()) {
    my $is_ignored = 0;
    for my $ign (@ignored_packs) {
      if (($p =~ m/^$ign$/) || ($p =~ m/^$ign\./)) {
        $is_ignored = 1;
        last;
      }
    }
    next if $is_ignored;
    my $tlpB = $tlpdbB->get_package($p);
    if (!defined($tlpB)) {
      push @inAnotinB, $p;
    } else {
      $do_compare{$p} = 1;
    }
  }
  $ret{'removed_packages'} = \@inAnotinB if @inAnotinB;
  
  for my $p ($tlpdbB->list_packages()) {
    my $is_ignored = 0;
    for my $ign (@ignored_packs) {
      if (($p =~ m/^$ign$/) || ($p =~ m/^$ign\./)) {
        $is_ignored = 1;
        last;
      }
    }
    next if $is_ignored;
    my $tlpA = $tlpdbA->get_package($p);
    if (!defined($tlpA)) {
      push @inBnotinA, $p;
    } else {
      $do_compare{$p} = 1;
    }
  }
  $ret{'added_packages'} = \@inBnotinA if @inBnotinA;

  for my $p (sort keys %do_compare) {
    my $tlpA = $tlpdbA->get_package($p);
    my $tlpB = $tlpdbB->get_package($p);
    my %foo = compare_tlpobjs($tlpA, $tlpB);
    if (keys %foo) {
      # some diffs were found
      $diffpacks{$p} = \%foo;
    }
  }
  $ret{'different_packages'} = \%diffpacks if (keys %diffpacks);

  return %ret;
}

sub tlnet_disabled_packages {
  my ($root) = @_;
  my $disabled_pkgs = "$root/tlpkg/dev/tlnet-disabled-packages.txt";
  my @ret;
  if (-r $disabled_pkgs) {
    open (DISABLED, "<$disabled_pkgs") || die "Huu, -r but cannot open: $?";
    while (<DISABLED>) {
      chomp;
      next if /^\s*#/;
      next if /^\s*$/;
      $_ =~ s/^\s*//;
      $_ =~ s/\s*$//;
      push @ret, $_;
    }
    close(DISABLED) || warn ("Cannot close tlnet-disabled-packages.txt: $?");
  }
  return @ret;
}

sub report_tlpdb_differences {
  my $rret = shift;
  my %ret = %$rret;

  if (defined($ret{'removed_packages'})) {
    info ("removed packages from A to B:\n");
    for my $f (@{$ret{'removed_packages'}}) {
      info ("  $f\n");
    }
  }
  if (defined($ret{'added_packages'})) {
    info ("added packages from A to B:\n");
    for my $f (@{$ret{'added_packages'}}) {
      info ("  $f\n");
    }
  }
  if (defined($ret{'different_packages'})) {
    info ("different packages from A to B:\n");
    for my $p (keys %{$ret{'different_packages'}}) {
      info ("  $p\n");
      for my $k (keys %{$ret{'different_packages'}->{$p}}) {
        if ($k eq "revision") {
          info("    revision differ: $ret{'different_packages'}->{$p}->{$k}\n");
        } elsif ($k eq "removed" || $k eq "added") {
          info("    $k files:\n");
          for my $f (@{$ret{'different_packages'}->{$p}->{$k}}) {
            info("      $f\n");
          }
        } else {
          info("  unknown differ $k\n");
        }
      }
    }
  }
}

#############################################
#
# Taken from Text::ParseWords
#
sub quotewords {
  my($delim, $keep, @lines) = @_;
  my($line, @words, @allwords);

  foreach $line (@lines) {
    @words = parse_line($delim, $keep, $line);
    return() unless (@words || !length($line));
    push(@allwords, @words);
  }
  return(@allwords);
}

sub parse_line {
  my($delimiter, $keep, $line) = @_;
  my($word, @pieces);

  no warnings 'uninitialized';	# we will be testing undef strings

  $line =~ s/\s+$//; # kill trailing whitespace
  while (length($line)) {
    $line =~ s/^(["'])			# a $quote
              ((?:\\.|(?!\1)[^\\])*)	# and $quoted text
              \1				# followed by the same quote
                |				# --OR--
            ^((?:\\.|[^\\"'])*?)		# an $unquoted text
            (\Z(?!\n)|(?-x:$delimiter)|(?!^)(?=["']))
                  # plus EOL, delimiter, or quote
      //xs or return;		# extended layout
    my($quote, $quoted, $unquoted, $delim) = ($1, $2, $3, $4);
    return() unless( defined($quote) || length($unquoted) || length($delim));

    if ($keep) {
      $quoted = "$quote$quoted$quote";
    } else {
      $unquoted =~ s/\\(.)/$1/sg;
      if (defined $quote) {
        $quoted =~ s/\\(.)/$1/sg if ($quote eq '"');
        $quoted =~ s/\\([\\'])/$1/g if ( $PERL_SINGLE_QUOTE && $quote eq "'");
      }
    }
    $word .= substr($line, 0, 0);	# leave results tainted
    $word .= defined $quote ? $quoted : $unquoted;

    if (length($delim)) {
      push(@pieces, $word);
      push(@pieces, $delim) if ($keep eq 'delimiters');
      undef $word;
    }
    if (!length($line)) {
      push(@pieces, $word);
    }
  }
  return(@pieces);
}

=item C<mktexupd ()>

Append entries to C<ls-R> files.  Usage example:

  my $updLSR=&mktexupd();
  $updLSR->{mustexist}(1);
  $updLSR->{add}(file1);
  $updLSR->{add}(file2);
  $updLSR->{add}(file3);
  $updLSR->{exec}();
  
The first line creates a new object.  Only one such object should be 
created in a program in order to avoid duplicate entries in C<ls-R> files.

C<add> pushes a filename or a list of filenames to a hash encapsulated 
in a closure.  Filenames must be specified with the full (absolute) path.  
Duplicate entries are ignored.  

C<exec> checks for each component of C<$TEXMFDBS> whether there are files
in the hash which have to be appended to the corresponding C<ls-R> files 
and eventually updates the corresponding C<ls-R> files.  Files which are 
in directories not stated in C<$TEXMFDBS> are silently ignored.

If the flag C<mustexist> is set, C<exec> aborts with an error message 
if a file supposed to be appended to an C<ls-R> file doesn't exist physically
on the file system.  This option was added for compatibility with the 
C<mktexupd> shell script.  This option shouldn't be enabled in scripts,
except for testing, because it degrades performance on non-cached file
systems.

=cut

sub mktexupd {
  my %files;
  my $mustexist=0;

  my $hash={
    "add" => sub {     
      foreach my $file (@_) {
        $file =~ s|\\|/|g;
        $files{$file}=1;
      }
    },
    "reset" => sub { 
       %files=();
    },
    "mustexist" => sub {
      $mustexist=shift;
    },
   "exec" => sub {
      # check whether files exist
      if ($mustexist) {
        foreach my $file (keys %files) {
          die "File \"$file\" doesn't exist.\n" if (! -f $file);
        }
      }
      my $delim= (&win32)? ';' : ':';
      my $TEXMFDBS;
      chomp($TEXMFDBS=`kpsewhich --show-path="ls-R"`);

      my @texmfdbs=split ($delim, "$TEXMFDBS");
      my %dbs;
     
      foreach my $path (keys %files) {
        foreach my $db (@texmfdbs) {
          $db=substr($db, -1) if ($db=~m|/$|); # strip leading /
          $db = lc($db) if win32();
          $up = (win32() ? lc($path) : $path);
          if (substr($up, 0, length("$db/")) eq "$db/") {
            # we appended a / because otherwise "texmf" is recognized as a
            # substring of "texmf-dist".
            my $np = './' . substr($up, length("$db/"));
            my ($dir, $file);
            $_=$np;
            ($dir, $file) = m|(.*)/(.*)|;
            $dbs{$db}{$dir}{$file}=1;
          }
        }
      }
      foreach my $db (keys %dbs) {
        if (! -f "$db" || ! -w "$db/ls-R") {
          &mkdirhier ($db);
        }
        open LSR, ">>$db/ls-R";
        foreach my $dir (keys %{$dbs{$db}}) {
          print LSR "\n$dir:\n";
          foreach my $file (keys %{$dbs{$db}{$dir}}) {
            print LSR "$file\n";
          }
        }
        close LSR;
      }
    }
  };
  return $hash;
}


=back
=cut
1;
__END__

=head1 SEE ALSO

The modules L<TeXLive::TLPSRC>, L<TeXLive::TLPOBJ>,
L<TeXLive::TLPDB>, L<TeXLive::TLTREE>, and the
document L<Perl-API.txt> and the specification in the TeX Live
repository trunk/Master/tlpkg/doc/.

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
