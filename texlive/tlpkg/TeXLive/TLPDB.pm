# $Id: TLPDB.pm 31361 2013-08-06 01:50:48Z preining $
# TeXLive::TLPDB.pm - module for using tlpdb files
# Copyright 2007-2013 Norbert Preining
# This file is licensed under the GNU General Public License version 2
# or any later version.

package TeXLive::TLPDB;

my $svnrev = '$Revision: 31361 $';
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

C<TeXLive::TLPDB> -- A database of TeX Live Packages

=head1 SYNOPSIS

  use TeXLive::TLPDB;

  TeXLive::TLPDB->new ();
  TeXLive::TLPDB->new (root => "/path/to/texlive/installation/root");

  $tlpdb->root("/path/to/root/of/texlive/installation");
  $tlpdb->copy;
  $tlpdb->from_file($filename);
  $tlpdb->writeout;
  $tlpdb->writeout(FILEHANDLE);
  $tlpdb->save;
  $tlpdb->media;
  $tlpdb->available_architectures();
  $tlpdb->add_tlpcontainer($pkg, $ziploc [, $archrefs [, $dest ]] );
  $tlpdb->add_tlpobj($tlpobj);
  $tlpdb->needed_by($pkg);
  $tlpdb->remove_tlpobj($pkg);
  $tlpdb->get_package("packagename");
  $tlpdb->list_packages ( [$tag] );
  $tlpdb->expand_dependencies(["-only-arch",] $totlpdb, @list);
  $tlpdb->expand_dependencies(["-no-collections",] $totlpdb, @list);
  $tlpdb->find_file("filename");
  $tlpdb->collections;
  $tlpdb->schemes;
  $tlpdb->updmap_cfg_lines;
  $tlpdb->fmtutil_cnf_lines;
  $tlpdb->language_dat_lines;
  $tlpdb->language_def_lines;
  $tlpdb->language_lua_lines;
  $tlpdb->package_revision("packagename");
  $tlpdb->location;
  $tlpdb->platform;
  $tlpdb->config_src_container;
  $tlpdb->config_doc_container;
  $tlpdb->config_container_format;
  $tlpdb->config_release;
  $tlpdb->config_minrelease;
  $tlpdb->config_revision;
  $tlpdb->options;
  $tlpdb->option($key, [$value]);
  $tlpdb->reset_options();
  $tlpdb->add_default_options();
  $tlpdb->settings;
  $tlpdb->setting($key, [$value]);
  $tlpdb->setting([-clear], $key, [$value]);
  $tlpdb->sizes_of_packages($opt_src, $opt_doc, $ref_arch_list [, @packs ]);
  $tlpdb->install_package($pkg, $dest_tlpdb);
  $tlpdb->remove_package($pkg, %options);
  $tlpdb->install_package_files($file [, $file ]);

  TeXLive::TLPDB->listdir([$dir]);
  $tlpdb->generate_listfiles([$destdir]);

  $tlpdb->make_virtual;
  $tlpdb->is_virtual;
  $tlpdb->virtual_add_tlpdb($tlpdb, $tag);
  $tlpdb->virtual_remove_tlpdb($tag);
  $tlpdb->virtual_get_tlpdb($tag);
  $tlpdb->virtual_get_package($pkg, $tag);
  $tlpdb->candidates($pkg);
  $tlpdb->virtual_candidate($pkg);
  $tlpdb->virtual_pinning( [ $pin_file_TLConfFile ] );

=head1 DESCRIPTION

=cut

use TeXLive::TLConfig qw($CategoriesRegexp $DefaultCategory $InfraLocation
      $DatabaseName $MetaCategoriesRegexp $Archive
      %TLPDBOptions %TLPDBSettings
      $RelocPrefix $RelocTree);
use TeXLive::TLUtils qw(dirname mkdirhier member win32 info log debug ddebug
                        tlwarn basename download_file merge_into tldie);
use TeXLive::TLPOBJ;
use TeXLive::TLWinGoo;

use File::Temp qw/tempfile/;

use Cwd 'abs_path';

my $_listdir;

=pod

=over 4

=item C<< TeXLive::TLPDB->new >>

=item C<< TeXLive::TLPDB->new( [root => "$path"] ) >>

C<< TeXLive::TLPDB->new >> creates a new C<TLPDB> object. If the
argument C<root> is given it will be initialized from the respective
location starting at $path. If C<$path> begins with C<http://> or
C<ftp://>, the program C<wget> is used to download the file.  The
C<$path> can also start with C<file:/> in which case it is treated as a
file on the filesystem in the usual way.

Returns an object of type C<TeXLive::TLPDB>, or undef if the root was
given but no package could be read from that location.

=cut

sub new { 
  my $class = shift;
  my %params = @_;
  my $self = {
    root => $params{'root'},
    tlps => $params{'tlps'}
  };
  $_listdir = $params{'listdir'} if defined($params{'listdir'});
  bless $self, $class;
  if (defined($params{'tlpdbfile'})) {
    my $nr_packages_read = $self->from_file($params{'tlpdbfile'}, '-from-file');
    if ($nr_packages_read == 0) {
      # that is bad, we didn't read anything, so return undef.
      return undef;
    }
    return $self;
  } 
  if (defined($self->{'root'})) {
    my $nr_packages_read
      = $self->from_file("$self->{'root'}/$InfraLocation/$DatabaseName");
    if ($nr_packages_read == 0) {
      # that is bad, we didn't read anything, so return undef.
      return undef;
    }
  }
  return $self;
}


sub copy {
  my $self = shift;
  my $bla = {};
  %$bla = %$self;
  bless $bla, "TeXLive::TLPDB";
  return $bla;
}

=pod

=item C<< $tlpdb->add_tlpobj($tlpobj) >>

The C<add_tlpobj> adds an object of the type TLPOBJ to the TLPDB.

=cut

sub add_tlpobj {
  my ($self,$tlp) = @_;
  if ($self->is_virtual) {
    tlwarn("cannot add tlpobj to a virtual tlpdb\n");
    return 0;
  }
  $self->{'tlps'}{$tlp->name} = $tlp;
}

=pod

=item C<< $tlpdb->needed_by($pkg) >>

Returns an array of package names depending on $pkg.

=cut

sub needed_by {
  my ($self,$pkg) = @_;
  my @ret;
  for my $p ($self->list_packages) {
    my $tlp = $self->get_package($p);
    DEPENDS: for my $d ($tlp->depends) {
      # exact match
      if ($d eq $pkg) {
        push @ret, $p;
        last DEPENDS;  # of the for loop on all depends
      }
      # 
      if ($d =~ m/^(.*)\.ARCH$/) {
        my $parent = $1;
        for my $a ($self->available_architectures) {
          if ($pkg eq "$parent.$a") {
            push @ret, $p;
            last DEPENDS;
          }
        }
      }
    }
  }
  return @ret;
}

=pod

=item C<< $tlpdb->remove_tlpobj($pkg) >>

Remove the package named C<$pkg> from the tlpdb. Gives a warning if the
package is not present

=cut

sub remove_tlpobj {
  my ($self,$pkg) = @_;
  if ($self->is_virtual) {
    tlwarn("cannot remove tlpobj from a virtual tlpdb\n");
    return 0;
  }
  if (defined($self->{'tlps'}{$pkg})) {
    delete $self->{'tlps'}{$pkg};
  } else {
    tlwarn("TLPDB: package to be removed not found: $pkg\n");
  }
}

=pod

=item C<< $tlpdb->from_file($filename) >>

The C<from_file> function initializes the C<TLPDB> if the root was not
given at generation time.  See L<TLPDB::new> for more information.

It returns the actual number of packages (TLPOBJs) read from C<$filename>.

=cut

sub from_file {
  my ($self, $path, $arg) = @_;
  if ($self->is_virtual) {
    tlwarn("cannot initialize from file a virtual tlpdb\n");
    return 0;
  }
  if (@_ < 2) {
    die "$0: from_file needs filename for initialization";
  }
  my $root_from_path = dirname(dirname($path));
  if (defined($self->{'root'})) {
    if ($self->{'root'} ne $root_from_path) {
      # only warn if we are not given $arg = "-from-file"
      if (!defined($arg) || ($arg ne "-from-file")) {
        tlwarn("root=$self->{'root'}, root_from_path=$root_from_path\n");
        tlwarn("Initialization from different location as originally given.\nHope you are sure!\n");
      }
    }
  } else {
    $self->root($root_from_path);
  }
  my $retfh;
  my $tlpdbfile;
  # do media detection
  my $rootpath = $self->root;
  if ($rootpath =~ m,http://|ftp://,) {
    $media = 'NET';
  } else {
    if ($rootpath =~ m,file://*(.*)$,) {
      $rootpath = "/$1";
    }
    if (-d "$rootpath/texmf-dist/web2c") {
      $media = 'local_uncompressed';
    } elsif (-d "$rootpath/texmf/web2c") { # older
      $media = 'local_uncompressed';
    } elsif (-d "$rootpath/web2c") {
      $media = 'local_uncompressed';
    } elsif (-d "$rootpath/$Archive") {
      $media = 'local_compressed';
    } else {
      # we cannot find the right type, return undefined, that should
      # make people notice
      return 0;
    }
  }
  $self->{'media'} = $media;
  #
  # actually load the TLPDB
  if ($path =~ m;^((http|ftp)://|file:\/\/*);) {
    debug("TLPDB.pm: trying to initialize from $path\n");
    # if we have xzdec available we try the xz file
    if (defined($::progs{'xzdec'})) {
      # we first try the xz compressed file
      #
      # we have to create a temp file to download to
      my ($xzfh, $xzfile) = tempfile();
      # now $xzfh filehandle is open, the file created
      # TLUtils::download_file will just overwrite what is there
      # on windows that doesn't work, so we close the fh immediately
      # this creates a short loophole, but much better than before anyway
      close($xzfh);
      my $xzfile_quote = $xzfile;
      # this is a variable of the whole sub as we have to remove the file
      # before returning
      my $tlpdbfh;
      ($tlpdbfh, $tlpdbfile) = tempfile();
      # same as above
      close($tlpdbfh);
      my $tlpdbfile_quote = $tlpdbfile;
      if (win32()) {
        $xzfile  =~ s!/!\\!g;
        $tlpdbfile =~ s!/!\\!g;
      }
      $xzfile_quote = "\"$xzfile\"";
      $tlpdbfile_quote = "\"$tlpdbfile\"";
      my $xzdec = TeXLive::TLUtils::quotify_path_with_spaces($::progs{'xzdec'});
      debug("trying to download $path.xz to $xzfile\n");
      my $ret = TeXLive::TLUtils::download_file("$path.xz", "$xzfile");
      # better to check both, the return value AND the existence of the file
      if ($ret && (-r "$xzfile")) {
        # ok, let the fun begin
        debug("un-xzing $xzfile to $tlpdbfile\n");
        # xzdec *hopefully* returns 0 on success and anything else on failure
        # we don't have to negate since not zero means error in the shell
        # and thus in perl true
        if (system("$xzdec <$xzfile_quote >$tlpdbfile_quote")) {
          debug("un-xzing $xzfile failed, tryin gplain file\n");
          # to be sure we unlink the xz file and the tlpdbfile
          unlink($xzfile);
          unlink($tlpdbfile);
        } else {
          unlink($xzfile);
          open($retfh, "<$tlpdbfile") || die "$0: open($tlpdbfile) failed: $!";
          debug("found the uncompressed xz file\n");
        }
      } 
    } else {
      debug("no xzdec defined, not trying tlpdb.xz ...\n");
    }
    if (!defined($retfh)) {
      debug("TLPDB: downloading $path.xz didn't succeed, try $path\n");
      # xz did not succeed, so try the normal file
      $retfh = TeXLive::TLUtils::download_file($path, "|");
      if (!$retfh) {
        die "open tlpdb($path) failed: $!";
      }
    }
  } else {
    open(TMP, "<$path") || die "$0: open($path) failed: $!";
    $retfh = \*TMP;
  }
  my $found = 0;
  my $ret = 0;
  do {
    my $tlp = TeXLive::TLPOBJ->new;
    $ret = $tlp->from_fh($retfh,1);
    if ($ret) {
      $self->add_tlpobj($tlp);
      $found++;
    }
  } until (!$ret);
  if (! $found) {
    debug("$0: Could not load packages from\n");
    debug("  $path\n");
  }

  # remove the un-xz-ed tlpdb file from temp dir
  # THAT IS RACY!!! we should fix that in some better way with tempfile
  close($retfh);
  unlink($tlpdbfile) if $tlpdbfile;
  return($found);
}

=pod

=item C<< $tlpdb->writeout >>

=item C<< $tlpdb->writeout(FILEHANDLE) >>

The C<writeout> function writes the database to C<STDOUT>, or 
the file handle given as argument.

=cut

sub writeout {
  my $self = shift;
  if ($self->is_virtual) {
    tlwarn("cannot write out a virtual tlpdb\n");
    return 0;
  }
  my $fd = (@_ ? $_[0] : STDOUT);
  foreach (sort keys %{$self->{'tlps'}}) {
    ddebug("writeout: tlpname=$_  ", $self->{'tlps'}{$_}->name, "\n");
    $self->{'tlps'}{$_}->writeout($fd);
    print $fd "\n";
  }
}

=pod

=item C<< $tlpdb->save >>

The C<save> functions saves the C<TLPDB> to the file which has been set
as location. If the location is undefined, die.

=cut

sub save {
  my $self = shift;
  if ($self->is_virtual) {
    tlwarn("cannot save a virtual tlpdb\n");
    return 0;
  }
  my $path = $self->location;
  mkdirhier(dirname($path));
  my $tmppath = "$path.tmp";
  open(FOO, ">$tmppath") || die "$0: open(>$tmppath) failed: $!";
  $self->writeout(\*FOO);
  close(FOO);
  # if we managed that one, we move it over
  die ("rename $tmppath to $path failed: $!")
    unless rename($tmppath, $path);
}

=pod

=item C<< $tlpdb->media >>

Returns the media code the respective installation resides on.

=cut

sub media { 
  my $self = shift ; 
  if ($self->is_virtual) {
    return "virtual";
  }
  return $self->{'media'};
}

=pod

=item C<< $tlpdb->available_architectures >>

The C<available_architectures> functions returns the list of available 
architectures as set in the options section 
(i.e., using setting("available_architectures"))

=cut

sub available_architectures {
  my $self = shift;
  my @archs;
  if ($self->is_virtual) {
    for my $k (keys %{$self->{'tlpdbs'}}) {
      TeXLive::TLUtils::push_uniq \@archs, $self->{'tlpdbs'}{$k}->available_architectures;
    }
    return sort @archs;
  } else {
    return $self->_available_architectures;
  }
}

sub _available_architectures {
  my $self = shift;
  my @archs = $self->setting("available_architectures");
  if (! @archs) {
    # fall back to the old method checking tex\.*
    my @packs = $self->list_packages;
    map { s/^tex\.// ; push @archs, $_ ; } grep(/^tex\.(.*)$/, @packs);
  }
  return @archs;
}

=pod

=item C<< $tlpdb->add_tlpcontainer($pkg, $ziploc [, $archrefs [, $dest ]] ) >>

Installs the package C<$pkg> from the container files in C<$ziploc>. If
C<$archrefs> is given then it must be a reference to a list of 
architectures to be installed. If the normal (arch=all) package is
architecture dependent then all arch packages in this list are installed.
If C<$dest> is given then the files are
installed into it, otherwise into the location of the TLPDB.

Note that this procedure does NOT check for dependencies. So if your package
adds new dependencies they are not necessarily fulfilled.

=cut

sub add_tlpcontainer {
  my ($self, $package, $ziplocation, $archrefs, $dest) = @_;
  if ($self->is_virtual) {
    tlwarn("cannot add tlp container to a virtual tlpdb\n");
    return 0;
  }
  my @archs;
  if (defined($archrefs)) {
    @archs = @$archrefs;
  }
  my $cwd = getcwd();
  if ($ziplocation !~ m,^/,) {
    $ziplocation = "$cwd/$ziplocation";
  }
  my $tlpobj = $self->_add_tlpcontainer($package, $ziplocation, "all", $dest);
  if ($tlpobj->is_arch_dependent) {
    foreach (@$archrefs) {
      $self->_add_tlpcontainer($package, $ziplocation, $_, $dest);
    }
  }
}

sub _add_tlpcontainer {
  my ($self, $package, $ziplocation, $arch, $dest) = @_;
  my $unpackprog;
  my $args;
  # WARNING: If you change the location of the texlive.tlpdb this
  # has to be changed, too!!
  if (not(defined($dest))) { 
    $dest = $self->{'root'};
  }
  my $container = "$ziplocation/$package";
  if ($arch ne "all") {
    $container .= ".$arch";
  }
  if (-r "$container.zip") {
    $container .= ".zip";
    $unpackprog="unzip";
    $args="-o -qq $container -d $dest";
  } elsif (-r "$container.xz") {
    $container .= ".xz";
    $unpackprog="NO_IDEA_HOW_TO_UNPACK_LZMA";
    $args="NO IDEA WHAT ARGS IT NEEDS";
    die "$0: xz checked for but not implemented, maybe update TLPDB.pm";
  } else {
    die "$0: No package $container (.zip or .xz) in $ziplocation";
  }
  tlwarn("Huuu, this needs testing and error checking!\n");
  tlwarn("Should we use -a -- adapt line endings etc?\n");
  `$unpackprog $args`;
  # we only create/add tlpobj for arch eq "all"
  if ($arch eq "all") {
    my $tlpobj = new TeXLive::TLPOBJ;
    $tlpobj->from_file("$dest/$TeXLive::TLConfig::InfraLocation/tlpobj/$package.tlpobj");
    $self->add_tlpobj($tlpobj);
    return $tlpobj;
  }
}


=pod

=item C<< $tlpdb->get_package("pkgname") >> 

The C<get_package> function returns a reference to the C<TLPOBJ> object
corresponding to the I<pkgname>, or undef.

=cut

sub get_package {
  my ($self,$pkg,$tag) = @_;
  if ($self->is_virtual) {
    if (defined($tag)) {
      if (defined($self->{'packages'}{$pkg}{'tags'}{$tag})) {
        return $self->{'packages'}{$pkg}{'tags'}{$tag}{'tlp'};
      } else {
        debug("TLPDB::get_package: package $pkg not found in repository $tag\n");
        return;
      }
    } else {
      $tag = $self->{'packages'}{$pkg}{'target'};
      if (defined($tag)) {
        return $self->{'packages'}{$pkg}{'tags'}{$tag}{'tlp'};
      } else {
        return;
      }
    }
  } else {
    return $self->_get_package($pkg);
  }
}

sub _get_package {
  my ($self,$pkg) = @_;
  if (defined($self->{'tlps'}{$pkg})) {
  my $ret = $self->{'tlps'}{$pkg};
    return $self->{'tlps'}{$pkg};
  } else {
    return undef;
  }
}

=pod

=item C<< $tlpdb->media_of_package($pkg [, $tag]);

returns the media type of the package. In the virtual case a tag can
be given and the media of that repository is used, otherwise the
media of the virtual candidate is given.

=cut

sub media_of_package {
  my ($self, $pkg, $tag) = @_;
  if ($self->is_virtual) {
    if (defined($tag)) {
      if (defined($self->{'tlpdbs'}{$tag})) {
        return $self->{'tlpdbs'}{$tag}->media;
      } else {
        tlwarn ("tag $tag is not known.\n");
        return;
      }
    } else {
      my (undef,undef,undef,$maxtlpdb) = $self->virtual_candidate($pkg);
      return $maxtlpdb->media;
    }
  } else {
    return $self->media;
  }
}

=pod

=item C<< $tlpdb->list_packages >>

The C<list_packages> function returns the list of all included packages.

By default, for virtual tlpdbs only packages that are installable
are listed. That means, packages that are only in subsidiary repositories
but are not specifically pinned to it cannot be installed and are thus
not listed. Adding "-all" argument lists also these packages.

Finally, if there is another argument, the tlpdb must be virtual,
and the argument must specify a tag/name of a sub-tlpdb. In this
case all packages (without exceptions) from this repository are returned.

=cut

sub list_packages {
  my $self = shift;
  my $arg = shift;
  my $tag;
  my $showall = 0;
  if (defined($arg)) {
    if ($arg eq "-all") {
      $showall = 1;
    } else {
      $tag = $arg;
    }
  }
  if ($self->is_virtual) {
    if ($showall) {
      return (sort keys %{$self->{'packages'}});
    }
    if ($tag) {
      if (defined($self->{'tlpdbs'}{$tag})) {
        return $self->{'tlpdbs'}{$tag}->list_packages;
      } else {
        tlwarn("TLPDB:list_packages: tag not defined: $tag\n");
        return 0;
      }
    }
    # we have to be careful here: If a package
    # is only present in a subsidiary repository
    # and the package is *not* explicitely
    # pinned to it, it will not be installable.
    # This is what we want. But in this case
    # we don't want it to be listed by default.
    #
    my @pps;
    for my $p (keys %{$self->{'packages'}}) {
      push @pps, $p if (defined($self->{'packages'}{$p}{'target'}));
    }
    return (sort @pps);
  } else {
    return $self->_list_packages;
  }
}

sub _list_packages {
  my $self = shift;
  return (sort keys %{$self->{'tlps'}});
}

=pod

=item C<< $tlpdb->expand_dependencies(["control",] $tlpdb, ($pkgs)) >>

If the first argument is the string C<"-only-arch">, expands only
dependencies of the form C<.>I<ARCH>.

If the first argument is C<"-no-collections">, then dependencies between
"same-level" packages (scheme onto scheme, collection onto collection,
package onto package) are ignored.

C<-only-arch> and C<-no-collections> cannot be specified together; has
to be one or the other.

The next (or first) argument is the target TLPDB, then a list of
packages.

In the virtual case, if a package name is tagged with C<@repository-tag>
then all the dependencies will still be expanded between all included
databases.  Only in case of C<.>I<ARCH> dependencies the repository-tag
is sticky.

We return a list of package names, the closure of the package list with
respect to the depends operator. (Sorry, that was for mathematicians.)

=cut

sub expand_dependencies {
  my $self = shift;
  my $only_arch = 0;
  my $no_collections = 0;
  my $first = shift;
  my $totlpdb;
  if ($first eq "-only-arch") {
    $only_arch = 1;
    $totlpdb = shift;
  } elsif ($first eq "-no-collections") {
    $no_collections = 1;
    $totlpdb = shift;
  } else {
    $totlpdb = $first;
  }
  my %install = ();
  my @archs = $totlpdb->available_architectures;
  for my $p (@_) {
    my ($pp, $aa) = split('@', $p);
    $install{$pp} = (defined($aa) ? $aa : 0);;
  }
  my $changed = 1;
  while ($changed) {
    $changed = 0;
    my @pre_select = keys %install;
    ddebug("pre_select = @pre_select\n");
    for my $p (@pre_select) {
      next if ($p =~ m/^00texlive/);
      my $pkg = $self->get_package($p, ($install{$p}?$install{$p}:undef));
      if (!defined($pkg)) {
        debug("W: $p is mentioned somewhere but not available, disabling\n");
        $install{$p} = 0;
        next;
      }
      for my $p_dep ($pkg->depends) {
        ddebug("checking $p_dep in $p\n");
        my $tlpdd = $self->get_package($p_dep);
        if (defined($tlpdd)) {
          # before we ignored all deps of schemes and colls if -no-collections
          # was given, but this prohibited auto-install of new collections
          # even if the scheme is updated.
          # Now we supress only "same-level dependencies", so scheme -> scheme
          # and collections -> collections and package -> package
          # hoping that this works out better
          # if ($tlpdd->category =~ m/$MetaCategoriesRegexp/) {
          if ($tlpdd->category eq $pkg->category) {
            # we ignore same-level dependencies if "-no-collections" is given
            ddebug("expand_deps: skipping $p_dep in $p due to -no-collections\n");
            next if $no_collections;
          }
        }
        if ($p_dep =~ m/^(.*)\.ARCH$/) {
          my $foo = "$1";
          foreach $a (@archs) {
            # install .ARCH packages from the same sub repository as the
            # main packages
            $install{"$foo.$a"} = $install{$foo}
              if defined($self->get_package("$foo.$a"));
          }
        } elsif ($p_dep =~ m/^(.*)\.win32$/) {
          # a win32 package should *only* be installed if we are installing
          # the win32 arch
          if (grep(/^win32$/,@archs)) {
            $install{$p_dep} = 0;
          }
        } else {
          $install{$p_dep} = 0 unless $only_arch;
        }
      }
    }

    # check for newly selected packages
    my @post_select = keys %install;
    ddebug("post_select = @post_select\n");
    if ($#pre_select != $#post_select) {
      $changed = 1;
    }
  }
  # create return list
  return map { $install{$_} eq "0"?$_:"$_\@" . $install{$_} } keys %install;
  #return(keys %install);
}

=pod

=item C<< $tlpdb->find_file("filename") >>

The C<find_file> returns a list of packages:filename
containing a file named C<filename>.

=cut

# TODO adapt for searching in *all* tags ???
sub find_file {
  my ($self,$fn) = @_;
  my @ret;
  foreach my $pkg ($self->list_packages) {
    my @foo = $self->get_package($pkg)->contains_file($fn);
    foreach my $f ($self->get_package($pkg)->contains_file($fn)) {
      push @ret, "$pkg:$f";
    }
  }
  return(@ret);
}

=pod

=item C<< $tlpdb->collections >>

The C<collections> function returns a list of all collection names.

=cut

sub collections {
  my $self = shift;
  my @ret;
  foreach my $p ($self->list_packages) {
    if ($self->get_package($p)->category eq "Collection") {
      push @ret, $p;
    }
  }
  return @ret;
}

=pod

=item C<< $tlpdb->schemes >>

The C<schemes> function returns a list of all scheme names.

=cut

sub schemes {
  my $self = shift;
  my @ret;
  foreach my $p ($self->list_packages) {
    if ($self->get_package($p)->category eq "Scheme") {
      push @ret, $p;
    }
  }
  return @ret;
}



=pod

=item C<< $tlpdb->package_revision("packagename") >>

The C<package_revision> function returns the revision number of the
package named in the first argument.

=cut

sub package_revision {
  my ($self,$pkg) = @_;
  my $tlp = $self->get_package($pkg);
  if (defined($tlp)) {
    return $tlp->revision;
  } else {
    return;
  }
}

=pod

=item C<< $tlpdb->generate_packagelist >>

The C<generate_packagelist> prints TeX Live package names in the object
database, together with their revisions, to the file handle given in the
first (optional) argument, or C<STDOUT> by default.  It also outputs all
available architectures as packages with revision number -1.

=cut

sub generate_packagelist {
  my $self = shift;
  my $fd = (@_ ? $_[0] : STDOUT);
  foreach (sort $self->list_packages) {
    print $fd $self->get_package($_)->name, " ",
              $self->get_package($_)->revision, "\n";
  }
  foreach ($self->available_architectures) {
    print $fd "$_ -1\n";
  }
}

=pod

=item C<< $tlpdb->generate_listfiles >>

=item C<< $tlpdb->generate_listfiles($destdir) >>

The C<generate_listfiles> generates the list files for the old 
installers. This function will probably go away.

=cut

sub generate_listfiles {
  my ($self,$destdir) = @_;
  if (not(defined($destdir))) {
    $destdir = TeXLive::TLPDB->listdir;
  }
  foreach (sort $self->list_package) {
    $tlp = $self->get_package($_);
    $self->_generate_listfile($tlp, $destdir);
  }
}

sub _generate_listfile {
  my ($self,$tlp,$destdir) = @_;
  my $listname = $tlp->name;
  my @files = $tlp->all_files;
  @files = TeXLive::TLUtils::sort_uniq(@files);
  &mkpath("$destdir") if (! -d "$destdir");
  my (@lop, @lot);
  foreach my $d ($tlp->depends) {
    my $subtlp = $self->get_package($d);
    if (defined($subtlp)) {
      if ($subtlp->is_meta_package) {
        push @lot, $d;
      } else {
        push @lop, $d;
      }
    } else {
      # speudo dependencies on $Package.ARCH can be ignored
      if ($d !~ m/\.ARCH$/) {
        tlwarn("TLPDB: package $tlp->name depends on $d, but this does not exist\n");
      }
    }
  }
  open(TMP, ">$destdir/$listname")
  || die "$0: open(>$destdir/$listname) failed: $!";

  # title and size information for collections and schemes in the
  # first two lines, marked with *
	if ($tlp->category eq "Collection") {
    print TMP "*Title: ", $tlp->shortdesc, "\n";
    # collections references Packages, we have to collect the sizes of
    # all the Package-tlps included
    # What is unclear for me is HOW the size is computed for bin-*
    # packages. The collection-basic contains quite a lot of
    # bin-files, but the sizes for the different archs differ.
    # I guess we have to take the maximum?
    my $s = 0;
    foreach my $p (@lop) {
      my $subtlp = $self->get_package($p);
      if (!defined($subtlp)) {
        tlwarn("TLPDB: $listname references $p, but it is not in tlpdb\n");
      }
      $s += $subtlp->total_size;
    }
    # in case the collection itself ships files ...
    $s += $tlp->runsize + $tlp->srcsize + $tlp->docsize;
    print TMP "*Size: $s\n";
  } elsif ($tlp->category eq "Scheme") {
    print TMP "*Title: ", $tlp->shortdesc, "\n";
    my $s = 0;
    # schemes size includes ONLY those packages which are directly
    # included and direclty included files, not the size of the
    # included collections. But if a package is included in one of
    # the called for collections AND listed directly, we don't want
    # to count its size two times
    my (@inccol,@incpkg,@collpkg);
    # first we add all the packages tlps that are directly included
    @incpkg = @lop;
    # now we select all collections, and for all collections we
    # again select all non-meta-packages
    foreach my $c (@lot) {
      my $coll = $self->get_package($c);
      foreach my $d ($coll->depends) {
        my $subtlp = $self->get_package($d);
        if (defined($subtlp)) {
          if (!($subtlp->is_meta_package)) {
            TeXLive::TLUtils::push_uniq(\@collpkg,$d);
          }
        } else {
          tlwarn("TLPDB: collection $coll->name depends on $d, but this does not exist\n");
        }
      }
    }
    # finally go through all packages and add the ->total_size
    foreach my $p (@incpkg) {
      if (!TeXLive::TLUtils::member($p,@collpkg)) {
        $s += $self->get_package($p)->total_size;
      }
    } 
    $s += $tlp->runsize + $tlp->srcsize + $tlp->docsize;
    print TMP "*Size: $s\n";
  }
  # dependencies and inclusion of packages
  foreach my $t (@lot) {
    # strange, schemes mark included collections via -, while collections
    # themselves mark deps on other collections with +. collections are
    # never referenced in Packages.
    if ($listname =~ m/^scheme/) {
      print TMP "-";
    } else {
      print TMP "+";
    }
    print TMP "$t\n";
  }
  foreach my $t (@lop) { print TMP "+$t\n"; }
  # included files
  foreach my $f (@files) { print TMP "$f\n"; }
  # also print the listfile itself
  print TMP "$destdir/$listname\n";
  # execute statements
  foreach my $e ($tlp->executes) {
    print TMP "!$e\n";
  }
  # finish
  close(TMP);
}

=pod

=item C<< $tlpdb->root([ "/path/to/installation" ]) >>

The function C<root> allows to read and set the root of the
installation. 

=cut

sub root {
  my $self = shift;
  if ($self->is_virtual) {
    tlwarn("cannot set/edit root of a virtual tlpdb\n");
    return 0;
  }
  if (@_) { $self->{'root'} = shift }
  return $self->{'root'};
}

=pod

=item C<< $tlpdb->location >>

Return the location of the actual C<texlive.tlpdb> file used. This is a
read-only function; you cannot change the root of the TLPDB using this
function.

See C<00texlive.installation.tlpsrc> for a description of the
special value C<__MASTER>.

=cut

sub location {
  my $self = shift;
  if ($self->is_virtual) {
    tlwarn("cannot get location of a virtual tlpdb\n");
    return 0;
  }
  return "$self->{'root'}/$InfraLocation/$DatabaseName";
}

=pod

=item C<< $tlpdb->platform >>

returns the platform of this installation.

=cut

# deduce the platform of the referenced media as follows:
# - if the $tlpdb->setting("platform") is there it overrides the detected
#   setting
# - if it is not there call TLUtils::platform()
sub platform {
  # try to deduce the platform
  my $self = shift;
  my $ret = $self->setting("platform");
  return $ret if defined $ret;
  # the platform setting wasn't found in the tlpdb, try TLUtils::platform
  return TeXLive::TLUtils::platform();
}

=pod

=item C<< $tlpdb->listdir >>

The function C<listdir> allows to read and set the packages variable
specifiying where generated list files are created.

=cut

sub listdir {
  my $self = shift;
  if (@_) { $_listdir = $_[0] }
  return $_listdir;
}

=pod

=item C<< $tlpdb->config_src_container >>

Returns 1 if the the texlive config option for src files splitting on 
container level is set. See Options below.

=cut

sub config_src_container {
  my $self = shift;
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package('00texlive.config');
  } else {
    $tlp = $self->{'tlps'}{'00texlive.config'};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^container_split_src_files/(.*)$!) {
        return "$1";
      }
    }
  }
  return 0;
}

=pod

=item C<< $tlpdb->config_doc_container >>

Returns 1 if the the texlive config option for doc files splitting on 
container level is set. See Options below.

=cut

sub config_doc_container {
  my $self = shift;
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package('00texlive.config');
  } else {
    $tlp = $self->{'tlps'}{'00texlive.config'};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^container_split_doc_files/(.*)$!) {
        return "$1";
      }
    }
  }
  return 0;
}

=pod

=item C<< $tlpdb->config_doc_container >>

Returns the currently set default container format. See Options below.

=cut

sub config_container_format {
  my $self = shift;
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package('00texlive.config');
  } else {
    $tlp = $self->{'tlps'}{'00texlive.config'};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^container_format/(.*)$!) {
        return "$1";
      }
    }
  }
  return "";
}

=pod

=item C<< $tlpdb->config_release >>

Returns the currently set release. See Options below.

=cut

sub config_release {
  my $self = shift;
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package('00texlive.config');
  } else {
    $tlp = $self->{'tlps'}{'00texlive.config'};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^release/(.*)$!) {
        return "$1";
      }
    }
  }
  return "";
}

=pod

=item C<< $tlpdb->config_minrelease >>

Returns the currently allowed minimal release. See Options below.

=cut

sub config_minrelease {
  my $self = shift;
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package('00texlive.config');
  } else {
    $tlp = $self->{'tlps'}{'00texlive.config'};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^minrelease/(.*)$!) {
        return "$1";
      }
    }
  }
  return;
}


=pod

=item C<< $tlpdb->config_revision >>

Returns the currently set revision. See Options below.

=cut

sub config_revision {
  my $self = shift;
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package('00texlive.config');
  } else {
    $tlp = $self->{'tlps'}{'00texlive.config'};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^revision/(.*)$!) {
        return "$1";
      }
    }
  }
  return "";
}


=pod

=item C<< $tlpdb->sizes_of_packages ( $opt_src, $opt_doc, $ref_arch_list, [ @packs ] ) >>

This function returns a reference to a hash with package names as keys
and the sizes in bytes as values. The sizes are computed for the list of
package names given as the fourth argument, or all packages if not
specified.

If anything has been computed one additional key is synthesized,
C<__TOTAL__>, which contains the total size of all packages under
consideration.

If the third argument is a reference to a list of architectures, then
only the sizes for the binary packages for these architectures are used,
otherwise all sizes for all architectures are summed.

=cut

sub sizes_of_packages {
  my ($self, $opt_src, $opt_doc, $arch_list_ref, @packs) = @_;
  @packs || ( @packs = $self->list_packages() );
  my @archs;
  if (defined($arch_list_ref)) {
    @archs = @$arch_list_ref;
  }
  # if nothing is passed on, then we keep @archs undefined, which means
  # use all architectures
  my %tlpsizes;
  my %tlpobjs;
  my $totalsize;
  foreach my $p (@packs) {
    $tlpobjs{$p} = $self->get_package($p);
    my $media = $self->media_of_package($p);
    if (!defined($tlpobjs{$p})) {
      warn "STRANGE: $p not to be found in ", $self->root;
      next;
    }
    $tlpsizes{$p} = $self->size_of_one_package($media, $tlpobjs{$p},
                                               $opt_src, $opt_doc, @archs);
    $totalsize += $tlpsizes{$p};
  }
  if ($totalsize) {
    $tlpsizes{'__TOTAL__'} = $totalsize;
  }
  return \%tlpsizes;
}

sub size_of_one_package {
  my ($self, $media, $tlpobj, $opt_src, $opt_doc, @used_archs) = @_;
  my $size = 0;
  if ($media ne 'local_uncompressed') {
    # we use the container size as the measuring unit since probably
    # downloading will be the limiting factor
    $size =  $tlpobj->containersize;
    $size += $tlpobj->srccontainersize if $opt_src;
    $size += $tlpobj->doccontainersize if $opt_doc;
  } else {
    # we have to add the respective sizes, that is checking for
    # installation of src and doc file
    $size  = $tlpobj->runsize;
    $size += $tlpobj->srcsize if $opt_src;
    $size += $tlpobj->docsize if $opt_doc;
    my %foo = %{$tlpobj->binsize};
    for my $k (keys %foo) { 
      if (@used_archs && member($k, @used_archs)) {
        $size += $foo{$k};
      }
    }
    # packages sizes are stored in blocks; transform that to bytes.
    $size *= $TeXLive::TLConfig::BlockSize;
  }
  return $size;
}

=pod

=item C<< $tlpdb->install_package_files($f [, $f]) >>

Install a package from a package file, i.e. a .tar.xz.
Returns the number of packages actually installed successfully.

=cut

sub install_package_files {
  my ($self, @files) = @_;

  my $ret = 0;

  my $opt_src = $self->option("install_srcfiles");
  my $opt_doc = $self->option("install_docfiles");

  for my $f (@files) {

    # - create a tmp directory
    my $tmpdir = TeXLive::TLUtils::tl_tmpdir();
    # - unpack everything there
    if (!TeXLive::TLUtils::unpack($f, $tmpdir)) {
      tlwarn("TLPDB::install_package_files: couldn't install $f\n");
      next;
    }
    # we are  still here, so the files have been unpacked properly
    # we need now to find the tlpobj in $tmpdir/tlpkg/tlpobj/
    my ($tlpobjfile, $anotherfile) = <$tmpdir/tlpkg/tlpobj/*.tlpobj>;
    if (defined($anotherfile)) {
      # we found several tlpobj files, that is not allowed, stop
      tlwarn("TLPDB::install_package_files: several tlpobj files in $what in tlpkg/tlpobj/, stopping!\n");
      next;
    }
    # - read the tlpobj from there
    my $tlpobj = TeXLive::TLPOBJ->new;
    $tlpobj->from_file($tlpobjfile);
    # we didn't die in this process, so that seems to be a proper tlpobj
    # (btw, why didn't I work on proper return values!?!)

    #
    # we are now ready for installation
    # if this package existed before, remove it from the tlpdb
    if ($self->get_package($tlpobj->name)) {
      $self->remove_package($tlpobj->name);
    }

    # code partially from TLPDB->not_virtual_install_package!!!
    my @installfiles = ();
    my $reloc = 1 if $tlpobj->relocated;
    foreach ($tlpobj->runfiles) { push @installfiles, $_; };
    foreach ($tlpobj->allbinfiles) { push @installfiles, $_; };
    if ($opt_src) { foreach ($tlpobj->srcfiles) { push @installfiles, $_; } }
    if ($opt_doc) { foreach ($tlpobj->docfiles) { push @installfiles, $_; } }
    # 
    # remove the RELOC prefix, but do NOT replace it with RelocTree
    @installfiles = map { s!^$TeXLive::TLConfig::RelocPrefix/!!; $_; } @installfiles;
    # if the first argument of _install_package is scalar, it is the
    # place from where files should be installed
    if (!_install_package ($tmpdir, \@installfiles, $reloc, \@installfiles, $self)) {
      tlwarn("TLPDB::install_package_files: couldn't install $what!\n"); 
      next;
    }
    if ($reloc) {
      if ($self->setting("usertree")) {
        $tlpobj->cancel_reloc_prefix;
      } else {
        $tlpobj->replace_reloc_prefix;
      }
      $tlpobj->relocated(0);
    }
    my $tlpod = $self->root . "/tlpkg/tlpobj";
    mkdirhier( $tlpod );
    open(TMP,">$tlpod/".$tlpobj->name.".tlpobj") or
      die("Cannot open tlpobj file for ".$tlpobj->name);
    $tlpobj->writeout(\*TMP);
    close(TMP);
    $self->add_tlpobj($tlpobj);
    $self->save;
    TeXLive::TLUtils::announce_execute_actions("enable", $tlpobj);
    # do the postinstallation actions
    #
    # Run the post installation code in the postaction tlpsrc entries
    # in case we are on w32 and the admin did install for himself only
    # we switch off admin mode
    if (win32() && admin() && !$self->option("w32_multi_user")) {
      non_admin();
    }
    # for now desktop_integration maps to both installation
    # of desktop shortcuts and menu items, but we can split them later
    &TeXLive::TLUtils::do_postaction("install", $tlpobj,
      $self->option("file_assocs"),
      $self->option("desktop_integration"),
      $self->option("desktop_integration"),
      $self->option("post_code"));

    # remember that we installed this package correctly
    $ret++;
  }
  return $ret;
}


=pod

=item C<< $tlpdb->install_package($pkg, $dest_tlpdb [, $tag]) >>

Installs the package $pkg into $dest_tlpdb.
If C<$tag> is present and the tlpdb is virtual, tries to install $pkg
from the repository tagged with $tag.

=cut

sub install_package {
  my ($self, $pkg, $totlpdb, $tag) = @_;
  if ($self->is_virtual) {
    if (defined($tag)) {
      if (defined($self->{'packages'}{$pkg}{'tags'}{$tag})) {
        return $self->{'tlpdbs'}{$tag}->install_package($pkg, $totlpdb);
      } else {
        tlwarn("package $pkg not found in repository $tag\n");
        return;
      }
    } else {
      my ($maxtag, $maxrev, $maxtlp, $maxtlpdb) = $self->virtual_candidate($pkg);
      return $maxtlpdb->install_package($pkg, $totlpdb);
    }
  } else {
    if (defined($tag)) {
      tlwarn("not a virtual database, ignoring tag $tag on installation of $pkg\n");
    }
    return $self->not_virtual_install_package($pkg, $totlpdb);
  }
  return;
}

sub not_virtual_install_package {
  my ($self, $pkg, $totlpdb) = @_;
  my $fromtlpdb = $self;
  my $ret;
  die("TLPDB not initialized, cannot find tlpdb!") unless (defined($fromtlpdb));
  my $tlpobj = $fromtlpdb->get_package($pkg);
  if (!defined($tlpobj)) {
    tlwarn("$0: Cannot find package $pkg\n");
    return 0;
  } else {
    my $container_src_split = $fromtlpdb->config_src_container;
    my $container_doc_split = $fromtlpdb->config_doc_container;
    # get options about src/doc splitting from $totlpdb
    my $opt_src = $totlpdb->option("install_srcfiles");
    my $opt_doc = $totlpdb->option("install_docfiles");
    my $real_opt_doc = $opt_doc;
    my $reloc = 1 if $tlpobj->relocated;
    my $container;
    my @installfiles;
    my $root = $self->root;
    # make sure that there is no terminal / in $root, otherwise we
    # will get double // somewhere
    $root =~ s!/$!!;
    foreach ($tlpobj->runfiles) {
      # s!^!$root/!;
      push @installfiles, $_;
    }
    foreach ($tlpobj->allbinfiles) {
      # s!^!$root/!;
      push @installfiles, $_;
    }
    if ($opt_src) {
      foreach ($tlpobj->srcfiles) {
        # s!^!$root/!;
        push @installfiles, $_;
      }
    }
    if ($real_opt_doc) {
      foreach ($tlpobj->docfiles) {
        # s!^!$root/!;
        push @installfiles, $_;
      }
    }
    my $media = $self->media;
    if ($media eq 'local_uncompressed') {
      $container = \@installfiles;
    } elsif ($media eq 'local_compressed') {
      if (-r "$root/$Archive/$pkg.zip") {
        $container = "$root/$Archive/$pkg.zip";
      } elsif (-r "$root/$Archive/$pkg.tar.xz") {
        $container = "$root/$Archive/$pkg.tar.xz";
      } else {
        tlwarn("Cannot find a package $pkg (.zip or .xz) in $root/$Archive\n");
        next;
      }
    } elsif (&media eq 'NET') {
      $container = "$root/$Archive/$pkg.$TeXLive::TLConfig::DefaultContainerExtension";
    }
    $self->_install_package ($container, $reloc, \@installfiles, $totlpdb) 
      || return(0);
    # if we are installing from local_compressed or NET we have to fetch the respective
    # source and doc packages $pkg.source and $pkg.doc and install them, too
    if (($media eq 'NET') || ($media eq 'local_compressed')) {
      # we install split containers under the following conditions:
      # - the container were split generated
      # - src/doc files should be installed
      # (- the package is not already a split one (like .i386-linux))
      # the above test has been removed because it would mean that
      #   texlive.infra.doc.tar.xz
      # will never be installed, and we do already check that there
      # are at all src/doc files, which in split packages of the form 
      # foo.ARCH are not present. And if they are present, than that is fine,
      # too (bin-foobar.win32.doc.tar.xz)
      # - there are actually src/doc files present
      if ($container_src_split && $opt_src && $tlpobj->srcfiles) {
        my $srccontainer = $container;
        $srccontainer =~ s/(\.tar\.xz|\.zip)$/.source$1/;
        $self->_install_package ($srccontainer, $reloc, \@installfiles, $totlpdb) 
          || return(0);
      }
      if ($container_doc_split && $real_opt_doc && $tlpobj->docfiles) {
        my $doccontainer = $container;
        $doccontainer =~ s/(\.tar\.xz|\.zip)$/.doc$1/;
        $self->_install_package ($doccontainer, $reloc, \@installfiles, $totlpdb) 
          || return(0);
      }
      #
      # if we installed from NET/local_compressed and we got a relocatable container
      # make sure that the stray texmf-dist/tlpkg directory is removed
      # in USER MODE that should NOT be done because we keep the information
      # there, but for now do it unconditionally
      if ($tlpobj->relocated) {
        my $reloctree = $totlpdb->root . "/" . $TeXLive::TLConfig::RelocTree;
        my $tlpkgdir = $reloctree . "/" . $TeXLive::TLConfig::InfraLocation;
        my $tlpod = $tlpkgdir .  "/tlpobj";
        TeXLive::TLUtils::rmtree($tlpod) if (-d $tlpod);
        # we try to remove the tlpkg directory, that will succeed only
        # if it is empty. So in normal installations it won't be, but
        # if we are installing a relocated package it is texmf-dist/tlpkg
        # which will be (hopefully) empty
        rmdir($tlpkgdir) if (-d "$tlpkgdir");
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
    # and unset the relocated setting
    # before we save it to the local tlpdb
    if ($tlpobj->relocated) {
      if ($totlpdb->setting("usertree")) {
        $tlpobj->cancel_reloc_prefix;
      } else {
        $tlpobj->replace_reloc_prefix;
      }
      $tlpobj->relocated(0);
    }
    # we have to write out the tlpobj file since it is contained in the
    # archives (.tar.xz) but at DVD install time we don't have them
    my $tlpod = $totlpdb->root . "/tlpkg/tlpobj";
    mkdirhier( $tlpod );
    open(TMP,">$tlpod/".$tlpobj->name.".tlpobj") or
      die("Cannot open tlpobj file for ".$tlpobj->name);
    $tlpobj->writeout(\*TMP);
    close(TMP);
    $totlpdb->add_tlpobj($tlpobj);
    $totlpdb->save;
    # compute the return value
    TeXLive::TLUtils::announce_execute_actions("enable", $tlpobj);
    # do the postinstallation actions
    #
    # Run the post installation code in the postaction tlpsrc entries
    # in case we are on w32 and the admin did install for himself only
    # we switch off admin mode
    if (win32() && admin() && !$totlpdb->option("w32_multi_user")) {
      non_admin();
    }
    # for now desktop_integration maps to both installation
    # of desktop shortcuts and menu items, but we can split them later
    &TeXLive::TLUtils::do_postaction("install", $tlpobj,
      $totlpdb->option("file_assocs"),
      $totlpdb->option("desktop_integration"),
      $totlpdb->option("desktop_integration"),
      $totlpdb->option("post_code"));
  }
  return 1;
}

#
# _install_package
# actually does the installation work
# returns 1 on success and 0 on error
#
sub _install_package {
  my ($self, $what, $reloc, $filelistref, $totlpdb) = @_;

  my $target = $totlpdb->root;
  my $tempdir = "$target/temp";

  my @filelist = @$filelistref;

  # we assume that $::progs has been set up!
  my $wget = $::progs{'wget'};
  my $xzdec = TeXLive::TLUtils::quotify_path_with_spaces($::progs{'xzdec'});
  if (!defined($wget) || !defined($xzdec)) {
    tlwarn("_install_package: programs not set up properly, strange.\n");
    return(0);
  }

  if (ref $what) {
    # determine the root from where we install
    # if the first argument $self is a string, then it should be the
    # root from where to install the files, otherwise it should be 
    # a TLPDB object (installation from DVD)
    my $root;
    if (!ref($self)) {
      $root = $self;
    } else {
      $root = $self->root;
    }
    # if we are installing a reloc, add the RelocTree to the target
    if ($reloc) {
      if (!$totlpdb->setting("usertree")) {
        $target .= "/$TeXLive::TLConfig::RelocTree";
      }
    }

    foreach my $file (@$what) {
      # @what is taken, not @filelist!
      # is this still needed?
      my $dn=dirname($file);
      mkdirhier("$target/$dn");
      TeXLive::TLUtils::copy "$root/$file", "$target/$dn";
    }
    # we always assume that copy will work
    return(1);
  } elsif ($what =~ m,\.tar(\.xz)?$,) {
    if ($reloc) {
      if (!$totlpdb->setting("usertree")) {
        $target .= "/$TeXLive::TLConfig::RelocTree";
      }
    }
    my $pkg = TeXLive::TLUtils::unpack($what, $target);
    if (!$pkg) {
      tlwarn("TLPDB::_install_package: couldn't unpack $what to $target\n");
      return(0);
    }
    # remove the $pkg.tlpobj, we recreate it anyway again
    unlink ("$target/tlpkg/tlpobj/$pkg.tlpobj") 
      if (-r "$target/tlpkg/tlpobj/$pkg.tlpobj");
    return(1);
  } else {
    tlwarn("_install_package: Don't know how to install $what\n");
    return(0);
  }
}

=pod

=item << $tlpdb->remove_package($pkg, %options) >>

removes a single package with all the files and the entry in the db.

=cut

#
# remove_package removes a single package with all files (including the
# # tlpobj files) and the entry from the tlpdb.
sub remove_package {
  my ($self, $pkg, %opts) = @_;
  my $localtlpdb = $self;
  my $tlp = $localtlpdb->get_package($pkg);
  my $usertree = $localtlpdb->setting("usertree");
  if (!defined($tlp)) {
    tlwarn ("$pkg: package not present, cannot remove\n");
  } else {
    my $currentarch = $self->platform();
    if ($pkg eq "texlive.infra" || $pkg eq "texlive.infra.$currentarch") {
      log ("Not removing $pkg, it is essential!\n");
      return 0;
    }
    # we have to chdir to $localtlpdb->root
    my $Master = $localtlpdb->root;
    chdir ($Master) || die "chdir($Master) failed: $!";
    my @files = $tlp->all_files;
    # also remove the .tlpobj file
    push @files, "tlpkg/tlpobj/$pkg.tlpobj";
    # and the ones from src/doc splitting
    if (-r "tlpkg/tlpobj/$pkg.source.tlpobj") {
      push @files, "tlpkg/tlpobj/$pkg.source.tlpobj";
    }
    if (-r "tlpkg/tlpobj/$pkg.doc.tlpobj") {
      push @files, "tlpkg/tlpobj/$pkg.doc.tlpobj";
    }
    #
    # some packages might be relocated, thus having the RELOC prefix
    # in user mode we just remove the prefix, in normal mode we
    # replace it with texmf-dist
    # since we don't have user mode 
    if ($tlp->relocated) {
      for (@files) {
        if (!$usertree) {
          s:^$RelocPrefix/:$RelocTree/:;
        }
      }
    }
    #
    # we want to check that a file is only listed in one package, so
    # in case that a file to be removed is listed in another package
    # we will warn and *not* remove it
    my %allfiles;
    for my $p ($localtlpdb->list_packages) {
      next if ($p eq $pkg); # we have to skip the to be removed package
      for my $f ($localtlpdb->get_package($p)->all_files) {
        $allfiles{$f} = $p;
      }
    }
    my @goodfiles = ();
    my @badfiles = ();
    my @debugfiles = ();
    for my $f (@files) {
      # in usermode we have to add texmf-dist again for comparison
      if (defined($allfiles{$f})) {
        # this file should be removed but is mentioned somewhere, too
        # take into account if we got a warn list
        if (defined($opts{'remove-warn-files'})) {
          my %a = %{$opts{'remove-warn-files'}};
          if (defined($a{$f})) {
            push @badfiles, $f;
          } else {
            # NO NOTHING HERE!!!
            # DON'T PUSH IT ON @goodfiles, it will be removed, which we do
            # NOT want. We only want to supress the warning!
            push @debugfiles, $f;
          }
        } else {
          push @badfiles, $f;
        }
      } else {
        push @goodfiles, $f;
      }
    }
    if ($#debugfiles >= 0) {
      debug("The following files will not be removed due to the removal of $pkg.\n");
      debug("But we do not warn on it because they are moved to other packages.\n");
      for my $f (@debugfiles) {
        debug(" $f - $allfiles{$f}\n");
      }
    }
    if ($#badfiles >= 0) {
      # warn the user
      tlwarn("The following files should be removed due to the removal of $pkg,\n");
      tlwarn("but are part of another package, too.\n");
      for my $f (@badfiles) {
        tlwarn(" $f - $allfiles{$f}\n");
      }
    }
    #
    # Run only the postaction code thing now since afterwards the
    # files will be gone ...
    if (defined($opts{'nopostinstall'}) && $opts{'nopostinstall'}) {
      &TeXLive::TLUtils::do_postaction("remove", $tlp,
        0, # option_file_assocs,
        0, # option_desktop_integration, menu part
        0, # option_desktop_integration, desktop part
        $localtlpdb->option("post_code"));
    }
    # 
    my @removals = &TeXLive::TLUtils::removed_dirs (@goodfiles);
    # now do the removal
    for my $entry (@goodfiles) {
      unlink $entry;
    }
    for my $d (@removals) {
      rmdir $d;
    }
    $localtlpdb->remove_tlpobj($pkg);
    TeXLive::TLUtils::announce_execute_actions("disable", $tlp);
    # should we save at each removal???
    # advantage: the tlpdb actually reflects what is installed
    # disadvantage: removing a collection calls the save routine several times
    # still I consider it better that the tlpdb is in a consistent state
    $localtlpdb->save;
    #
    # Run the post installation code in the postaction tlpsrc entries
    # in case we are on w32 and the admin did install for himself only
    # we switch off admin mode
    if (win32() && admin() && !$localtlpdb->option("w32_multi_user")) {
      non_admin();
    }
    #
    # Run the post installation code in the postaction tlpsrc entries
    # the postaction code part cannot be evaluated now since the
    # files are already removed.
    # Again, desktop integration maps to desktop and menu links
    if (!$opts{'nopostinstall'}) {
      &TeXLive::TLUtils::do_postaction("remove", $tlp,
        $localtlpdb->option("file_assocs"),
        $localtlpdb->option("desktop_integration"),
        $localtlpdb->option("desktop_integration"),
        0);
    }
  }
  return 1;
}


=pod

=item C<< $tlpdb->option($key [, $val]) >>
=item C<< $tlpdb->setting($key [, $val]) >>

Need to be documented

=cut

sub _set_option_value {
  my $self = shift;
  $self->_set_value_pkg('00texlive.installation', 'opt_', @_);
}
sub _set_setting_value {
  my $self = shift;
  $self->_set_value_pkg('00texlive.installation', 'setting_', @_);
}
sub _set_value_pkg {
  my ($self,$pkgname,$pre,$key,$value) = @_;
  my $k = "$pre$key";
  my $pkg;
  if ($self->is_virtual) {
    $pkg = $self->{'tlpdbs'}{'main'}->get_package($pkgname);
  } else {
    $pkg = $self->{'tlps'}{$pkgname};
  }
  my @newdeps;
  if (!defined($pkg)) {
    $pkg = new TeXLive::TLPOBJ;
    $pkg->name($pkgname);
    $pkg->category("TLCore");
    push @newdeps, "$k:$value";
  } else {
    my $found = 0;
    foreach my $d ($pkg->depends) {
      if ($d =~ m!^$k:!) {
        $found = 1;
        push @newdeps, "$k:$value";
      } else {
        push @newdeps, $d;
      }
    }
    if (!$found) {
      push @newdeps, "$k:$value";
    }
  }
  $pkg->depends(@newdeps);
  $self->add_tlpobj($pkg);
}

sub _clear_option {
  my $self = shift;
  $self->_clear_pkg('00texlive.installation', 'opt_', @_);
}

sub _clear_setting {
  my $self = shift;
  $self->_clear_pkg('00texlive.installation', 'setting_', @_);
}

sub _clear_pkg {
  my ($self,$pkgname,$pre,$key) = @_;
  my $k = "$pre$key";
  my $pkg;
  if ($self->is_virtual) {
    $pkg = $self->{'tlpdbs'}{'main'}->get_package($pkgname);
  } else {
    $pkg = $self->{'tlps'}{$pkgname};
  }
  my @newdeps;
  if (!defined($pkg)) {
    return;
  } else {
    foreach my $d ($pkg->depends) {
      if ($d =~ m!^$k:!) {
        # do nothing, we drop the value
      } else {
        push @newdeps, $d;
      }
    }
  }
  $pkg->depends(@newdeps);
  $self->add_tlpobj($pkg);
}


sub _get_option_value {
  my $self = shift;
  $self->_get_value_pkg('00texlive.installation', 'opt_', @_);
}

sub _get_setting_value {
  my $self = shift;
  $self->_get_value_pkg('00texlive.installation', 'setting_', @_);
}

sub _get_value_pkg {
  my ($self,$pkg,$pre,$key) = @_;
  my $k = "$pre$key";
  my $tlp;
  if ($self->is_virtual) {
    $tlp = $self->{'tlpdbs'}{'main'}->get_package($pkg);
  } else {
    $tlp = $self->{'tlps'}{$pkg};
  }
  if (defined($tlp)) {
    foreach my $d ($tlp->depends) {
      if ($d =~ m!^$k:(.*)$!) {
        return "$1";
      }
    }
    return;
  }
  tlwarn("$pkg not found, cannot read option $key.\n");
  return;
}

sub option_pkg {
  my $self = shift;
  my $pkg = shift;
  my $key = shift;
  if (@_) { $self->_set_value_pkg($pkg, "opt_", $key, shift); }
  my $ret = $self->_get_value_pkg($pkg, "opt_", $key);
  # special case for location == __MASTER__
  if (defined($ret) && $ret eq "__MASTER__" && $key eq "location") {
    return $self->root;
  }
  return $ret;
}
sub option {
  my $self = shift;
  my $key = shift;
  if (@_) { $self->_set_option_value($key, shift); }
  my $ret = $self->_get_option_value($key);
  # special case for location == __MASTER__
  if (defined($ret) && $ret eq "__MASTER__" && $key eq "location") {
    return $self->root;
  }
  return $ret;
}
sub setting_pkg {
  my $self = shift;
  my $pkg = shift;
  my $key = shift;
  if (@_) { 
    if ($TLPDBSettings{$key}->[0] eq "l") {
      $self->_set_value_pkg($pkg, "setting_", $key, "@_"); 
    } else {
      $self->_set_value_pkg($pkg, "setting_", $key, shift); 
    }
  }
  my $ret = $self->_get_value_pkg($pkg, "setting_", $key);
  # check the types of the settings, and if it is a "l" return a list
  if ($TLPDBSettings{$key}->[0] eq "l") {
    my @ret;
    if (defined $ret) {
      @ret = split(" ", $ret);
    } else {
      tlwarn "TLPDB::setting_pkg: no $key, returning empty list ...\n";
      @ret = ();
    }
    return @ret;
  }
  return $ret;
}
sub setting {
  my $self = shift;
  my $key = shift;
  if ($key eq "-clear") {
    my $realkey = shift;
    $self->_clear_setting($realkey);
    return;
  }
  if (@_) { 
    if ($TLPDBSettings{$key}->[0] eq "l") {
      $self->_set_setting_value($key, "@_"); 
    } else {
      $self->_set_setting_value($key, shift); 
    }
  }
  my $ret = $self->_get_setting_value($key);
  # check the types of the settings, and if it is a "l" return a list
  if ($TLPDBSettings{$key}->[0] eq "l") {
    my @ret;
    if (defined $ret) {
      @ret = split(" ", $ret);
    } else {
      tlwarn "TLPDB::setting: no $key, returning empty list ...\n";
      @ret = ();
    }
    return @ret;
  }
  return $ret;
}

sub reset_options {
  my $self = shift;
  for my $k (keys %TeXLive::TLConfig::TLPDBOptions) {
    $self->option($k, $TeXLive::TLConfig::TLPDBOptions{$k}->[1]);
  }
}

sub add_default_options {
  my $self = shift;
  for my $k (sort keys %TeXLive::TLConfig::TLPDBOptions) {
    # if the option is not set already, do set it to defaults
    if (! $self->option($k) ) {
      $self->option($k, $TeXLive::TLConfig::TLPDBOptions{$k}->[1]);
    }
  }
}

=pod

=item C<< $tlpdb->options >>

Returns a reference to a hash with option names.

=cut

sub _keyshash {
  my ($self, $pre, $hr) = @_;
  my @allowed = keys %$hr;
  my %ret;
  my $pkg;
  if ($self->is_virtual) {
    $pkg = $self->{'tlpdbs'}{'main'}->get_package('00texlive.installation');
  } else {
    $pkg = $self->{'tlps'}{'00texlive.installation'};
  }
  if (defined($pkg)) {
    foreach my $d ($pkg->depends) {
      if ($d =~ m!^$pre([^:]*):(.*)!) {
        if (member($1, @allowed)) {
          $ret{$1} = $2;
        } else {
          tlwarn("Unsupported option/setting $d\n");
        }
      }
    }
  }
  return \%ret;
}

sub options {
  my $self = shift;
  return ($self->_keyshash('opt_', \%TLPDBOptions));
}
sub settings {
  my $self = shift;
  return ($self->_keyshash('setting_', \%TLPDBSettings));
}

=pod

=item C<< $tlpdb->format_definitions >>

This function returns a list of references to hashes where each hash
represents a parsed AddFormat line.

=cut

sub format_definitions {
  my $self = shift;
  my @ret;
  foreach my $p ($self->list_packages) {
    my $obj = $self->get_package ($p);
    die "$0: No TeX Live package named $p, strange" if ! $obj;
    push @ret, $obj->format_definitions;
  }
  return(@ret);
}

=item C<< $tlpdb->fmtutil_cnf_lines >>

The function C<fmtutil_cnf_lines> returns the list of a fmtutil.cnf file
containing only those formats present in the installation.

Every format listed in the tlpdb but listed in the arguments
will not be included in the list of lines returned.

=cut
sub fmtutil_cnf_lines {
  my $self = shift;
  my @lines;
  foreach my $p ($self->list_packages) {
    my $obj = $self->get_package ($p);
    die "$0: No TeX Live package named $p, strange" if ! $obj;
    push @lines, $obj->fmtutil_cnf_lines(@_);
  }
  return(@lines);
}

=item C<< $tlpdb->updmap_cfg_lines ( [@disabled_maps] ) >>

The function C<updmap_cfg_lines> returns the list of a updmap.cfg file
containing only those maps present in the installation.

A map file mentioned in the tlpdb but listed in the arguments will not 
be included in the list of lines returned.

=cut
sub updmap_cfg_lines {
  my $self = shift;
  my @lines;
  foreach my $p ($self->list_packages) {
    my $obj = $self->get_package ($p);
    die "$0: No TeX Live package named $p, strange" if ! $obj;
    push @lines, $obj->updmap_cfg_lines(@_);
  }
  return(@lines);
}

=item C<< $tlpdb->language_dat_lines ( [@disabled_hyphen_names] ) >>

The function C<language_dat_lines> returns the list of all
lines for language.dat that can be generated from the tlpdb.

Every hyphenation pattern listed in the tlpdb but listed in the arguments
will not be included in the list of lines returned.

=cut

sub language_dat_lines {
  my $self = shift;
  my @lines;
  foreach my $p ($self->list_packages) {
    my $obj = $self->get_package ($p);
    die "$0: No TeX Live package named $p, strange" if ! $obj;
    push @lines, $obj->language_dat_lines(@_);
  }
  return(@lines);
}

=item C<< $tlpdb->language_def_lines ( [@disabled_hyphen_names] ) >>

The function C<language_def_lines> returns the list of all
lines for language.def that can be generated from the tlpdb.

Every hyphenation pattern listed in the tlpdb but listed in the arguments
will not be included in the list of lines returned.

=cut

sub language_def_lines {
  my $self = shift;
  my @lines;
  foreach my $p ($self->list_packages) {
    my $obj = $self->get_package ($p);
    die "$0: No TeX Live package named $p, strange" if ! $obj;
    push @lines, $obj->language_def_lines(@_);
  }
  return(@lines);
}

=item C<< $tlpdb->language_lua_lines ( [@disabled_hyphen_names] ) >>

The function C<language_lua_lines> returns the list of all
lines for language.dat.lua that can be generated from the tlpdb.

Every hyphenation pattern listed in the tlpdb but listed in the arguments
will not be included in the list of lines returned.

=cut

sub language_lua_lines {
  my $self = shift;
  my @lines;
  foreach my $p ($self->list_packages) {
    my $obj = $self->get_package ($p);
    die "$0: No TeX Live package named $p, strange" if ! $obj;
    push @lines, $obj->language_lua_lines(@_);
  }
  return(@lines);
}

=back

=head1 VIRTUAL DATABASES

The purpose of virtual databases is to collect several data sources
and present them in one way. The normal functions will always return
the best candidate for the set of functions.

More docs to be written

=cut

#
# packages are saved:
# $self->{'packages'}{$pkgname}{'tags'}{$tag}{'revision'} = $rev
# $self->{'packages'}{$pkgname}{'tags'}{$tag}{'tlp'} = $tlp
# $self->{'packages'}{$pkgname}{'target'} = $target_tag
#

sub is_virtual {
  my $self = shift;
  if (defined($self->{'virtual'}) && $self->{'virtual'}) {
    return 1;
  }
  return 0;
}

sub make_virtual {
  my $self = shift;
  if (!$self->is_virtual) {
    if ($self->list_packages) {
      tlwarn("Cannot convert a initialized tlpdb to virtual for now!\n");
      return 0;
    }
    $self->{'virtual'} = 1;
  }
  return 1;
}

sub virtual_get_tlpdb {
  my ($self, $tag) = @_;
  if (!$self->is_virtual) {
    tlwarn("Cannot remove tlpdb from a non-virtual tlpdb!\n");
    return 0;
  }
  if (!defined($self->{'tlpdbs'}{$tag})) {
    tlwarn("TLPDB virtual_get_tlpdb: unknown tag $tag\n");
    return 0;
  }
  return $self->{'tlpdbs'}{$tag};
}

sub virtual_add_tlpdb {
  my ($self, $tlpdb, $tag) = @_;
  if (!$self->is_virtual) {
    tlwarn("Cannot add tlpdb to a non-virtual tlpdb!\n");
    return 0;
  }
  $self->{'tlpdbs'}{$tag} = $tlpdb;
  for my $p ($tlpdb->list_packages) {
    my $tlp = $tlpdb->get_package($p);
    $self->{'packages'}{$p}{'tags'}{$tag}{'revision'} = $tlp->revision;
    $self->{'packages'}{$p}{'tags'}{$tag}{'tlp'} = $tlp;
  }
  $self->check_evaluate_pinning();
  return 1;
}

sub virtual_remove_tlpdb {
  my ($self, $tag) = @_;
  if (!$self->is_virtual) {
    tlwarn("Cannot remove tlpdb from a non-virtual tlpdb!\n");
    return 0;
  }
  if (!defined($self->{'tlpdbs'}{$tag})) {
    tlwarn("TLPDB virtual_remove_tlpdb: unknown tag $tag\n");
    return 0;
  }
  for my $p ($self->{'tlpdbs'}{$tag}->list_packages) {
    delete $self->{'packages'}{$p}{'tags'}{$tag};
  }
  delete $self->{'tlpdbs'}{$tag};
  $self->check_evaluate_pinning();
  return 1;
}

sub virtual_get_package {
  my ($self, $pkg, $tag) = @_;
  if (defined($self->{'packages'}{$pkg}{'tags'}{$tag})) {
    return $self->{'packages'}{$pkg}{'tags'}{$tag}{'tlp'};
  } else {
    tlwarn("pkg $pkg not found in tag $tag\n");
    return;
  }
}

=item C<< $tlpdb->candidates ( $pkg ) >>

Returns the list of candidates for the given package in the
format

  tag/revision

If the returned list is empty, then the database was not virtual and
no install candidate was found.

If the returned list contains undef as first element, the database
is virtual, and no install candidate was found.

The remaining elements in the list are all repositories that provide
that package.

Note that there might not be an install candidate, but still the
package is provided by a sub-repository. This can happen if a package
is present only in the sub-repository and there is no explicit pin
for that package in the pinning file.

=cut

sub is_repository {
  my $self = shift;
  my $tag = shift;
  if (!$self->is_virtual) {
    return ( ($tag eq $self->{'root'}) ? 1 : 0 );
  }
  return ( defined($self->{'tlpdbs'}{$tag}) ? 1 : 0 );
}


# returns a list of tag/rev
sub candidates {
  my $self = shift;
  my $pkg = shift;
  my @ret = ();
  if ($self->is_virtual) {
    if (defined($self->{'packages'}{$pkg})) {
      my $t = $self->{'packages'}{$pkg}{'target'};
      if (defined($t)) {
        push @ret, "$t/" . $self->{'packages'}{$pkg}{'tags'}{$t}{'revision'};
      } else {
        $t = "";
        # no target found, but maybe available somewhere else,
        # we return undef as first one
        push @ret, undef;
      }
      # make sure that we always check for main as repo
      my @repos = keys %{$self->{'packages'}{$pkg}};
      for my $r (sort keys %{$self->{'packages'}{$pkg}{'tags'}}) {
        push @ret, "$r/" . $self->{'packages'}{$pkg}{'tags'}{$r}{'revision'}
          if ($t ne $r);
      }
    }
  } else {
    my $tlp = $self->get_package($pkg);
    if (defined($tlp)) {
      push @ret, "main/" . $tlp->revision;
    }
  }
  return @ret;
}

=item C<< $tlpdb->candidate ( ) >>

Returns either a list of four undef, if no install candidate is found,
or the following information on the install candidate as list: the tag
name of the repository, the revision number of the package in the
candidate repository, the tlpobj of the package in the candidate
repository, and the candidate repository's TLPDB itself.

=cut

#
sub virtual_candidate {
  my ($self, $pkg) = @_;
  my $t = $self->{'packages'}{$pkg}{'target'};
  if (defined($t)) {
    return ($t, $self->{'packages'}{$pkg}{'tags'}{$t}{'revision'},
      $self->{'packages'}{$pkg}{'tags'}{$t}{'tlp'}, $self->{'tlpdbs'}{$t});
  }
  return(undef,undef,undef,undef);
}

=item C<< $tlpdb->virtual_pinning ( [ $pinfile_TLConfFile] ) >>

Sets or returns the C<TLConfFile> object for the pinning data.

=cut

sub virtual_pindata {
  my $self = shift;
  return ($self->{'pindata'});
}

sub virtual_update_pins {
  my $self = shift;
  if (!$self->is_virtual) {
    tlwarn("Not-virtual databases cannot have pinning data.\n");
    return 0;
  }
  my $pincf = $self->{'pinfile'};
  my @pins;
  for my $k ($pincf->keys) {
    for my $v ($pincf->value($k)) {
      # we recompose the values into lines again, as we *might* have
      # options later, i.e., lines of the format
      #   repo:pkg:opt
      push @pins, $self->make_pin_data_from_line("$k:$v");
    }
  }
  $self->{'pindata'} = \@pins;
  $self->check_evaluate_pinning();
  return ($self->{'pindata'});
}
sub virtual_pinning {
  my ($self, $pincf) = @_;
  if (!$self->is_virtual) {
    tlwarn("Not-virtual databases cannot have pinning data.\n");
    return 0;
  }
  if (!defined($pincf)) {
    return ($self->{'pinfile'});
  }
  $self->{'pinfile'} = $pincf;
  $self->virtual_update_pins();
  return ($self->{'pinfile'});
}

#
# current format:
# <repo>:<pkg_glob>[,<pkg_glob>,...][:<options>]
# only supported options for now is
#   revision
# meaning that, if for the selected package there is no other
# "non-revision" pinning, then all repo/package versions are compared
# using normal revision comparison, and the biggest revision number wins.
# That allows you to have the same package in several repos:
#   repo1:foo:revision
#   repo2:foo:revision
#   repo1:*
#   repo2:*
# means that:
# for package "foo" the revision numbers of "foo" in the repos "repo1",
# "repo2", and "main" are numerically compared and biggest number wins.
# for all other packages of "repo1" and "repo2", other other repositories
# are not considered.
#
# NOT IMPLEMENTED YET!!!
#
# $pin{'repo'} = $repo;
# $pin{'glob'} = $glob;
# $pin{'re'} = $re;
# $pin{'line'} = $line; # for debug/warning purpose
sub make_pin_data_from_line {
  my $self = shift;
  my $l = shift;
  my ($a, $b, $c) = split(/:/, $l);
  my @ret;
  my %m;
  $m{'repo'} = $a;
  $m{'line'} = $l;
  if (defined($c)) {
    $m{'options'} = $c;
  }
  # split the package globs
  for (split(/,/, $b)) {
    # remove leading and terminal white space
    s/^\s*//;
    s/\s*$//;
    my %mm = %m;
    $mm{'glob'} = $_;
    $mm{'re'} = glob_to_regex($_);
    push @ret, \%mm;
  }
  return @ret;
}

sub check_evaluate_pinning {
  my $self = shift;
  my @pins = (defined($self->{'pindata'}) ? @{$self->{'pindata'}} : ());
  #
  # run through the pin lines and make sure that all the conditions
  # and requirements are obeyed
  my %pkgs = %{$self->{'packages'}};
  # main:*
  my ($mainpin) = $self->make_pin_data_from_line("main:*");
  # the default main:* is always considered to be matched
  $mainpin->{'hit'} = 1;
  push @pins, $mainpin;
  for my $pkg (keys %pkgs) {
    PINS: for my $pp (@pins) {
      my $pre = $pp->{'re'};
      if (($pkg =~ m/$pre/) &&
          (defined($self->{'packages'}{$pkg}{'tags'}{$pp->{'repo'}}))) {
        $self->{'packages'}{$pkg}{'target'} = $pp->{'repo'};
        # register that this pin was hit
        $pp->{'hit'} = 1;
        last PINS;
      }
    }
  }
  # check that all pinning lines where hit
  for my $p (@pins) {
    next if defined($p->{'hit'});
    tlwarn("tlmgr: pinning warning: the package pattern ", $p->{'glob'},
           " on the line:\n  ", $p->{'line'},
           "\n  does not match any package\n");
  }
}


# implementation copied from Text/Glob.pm (copyright Richard Clamp).
# changes made:
# remove $strict_leading_dot and $strict_wildcard_slash if calls
# and execute the code unconditionally, as we do not change the
# default settings of 1 of these two variables.
sub glob_to_regex {
    my $glob = shift;
    my $regex = glob_to_regex_string($glob);
    return qr/^$regex$/;
}

sub glob_to_regex_string
{
    my $glob = shift;
    my ($regex, $in_curlies, $escaping);
    local $_;
    my $first_byte = 1;
    for ($glob =~ m/(.)/gs) {
        if ($first_byte) {
            $regex .= '(?=[^\.])' unless $_ eq '.';
            $first_byte = 0;
        }
        if ($_ eq '/') {
            $first_byte = 1;
        }
        if ($_ eq '.' || $_ eq '(' || $_ eq ')' || $_ eq '|' ||
            $_ eq '+' || $_ eq '^' || $_ eq '$' || $_ eq '@' || $_ eq '%' ) {
            $regex .= "\\$_";
        }
        elsif ($_ eq '*') {
            $regex .= $escaping ? "\\*" : "[^/]*";
        }
        elsif ($_ eq '?') {
            $regex .= $escaping ? "\\?" : "[^/]";
        }
        elsif ($_ eq '{') {
            $regex .= $escaping ? "\\{" : "(";
            ++$in_curlies unless $escaping;
        }
        elsif ($_ eq '}' && $in_curlies) {
            $regex .= $escaping ? "}" : ")";
            --$in_curlies unless $escaping;
        }
        elsif ($_ eq ',' && $in_curlies) {
            $regex .= $escaping ? "," : "|";
        }
        elsif ($_ eq "\\") {
            if ($escaping) {
                $regex .= "\\\\";
                $escaping = 0;
            }
            else {
                $escaping = 1;
            }
            next;
        }
        else {
            $regex .= $_;
            $escaping = 0;
        }
        $escaping = 0;
    }
    print "# $glob $regex\n" if debug;

    return $regex;
}

sub match_glob {
    print "# ", join(', ', map { "'$_'" } @_), "\n" if debug;
    my $glob = shift;
    my $regex = glob_to_regex $glob;
    local $_;
    grep { $_ =~ $regex } @_;
}

=pod

=head1 OPTIONS

Options regarding the full TeX Live installation to be described are saved
in a package C<00texlive.config> as values of C<depend> lines. This special
package C<00texlive.config> does not contain any files, only depend lines
which set one or more of the following options:

=over 4

=item C<container_split_src_files/[01]>

=item C<container_split_doc_files/[01]>

These options specify that at container generation time the source and
documentation files for a package have been put into a separate container
named C<package.source.extension> and C<package.doc.extension>.

=item C<container_format/I<format>>

This option specifies a format for containers. The currently supported 
formats are C<xz> and C<zip>. But note that C<zip> is untested.

=item C<release/I<relspec>>

This option specifies the current release. The first four characters must
be a year.

=item C<minrelease/I<relspec>>

This option specifies the minimum release for which this repository is
valid.

=back

To set these options the respective lines should be added to
C<00texlive.config.tlpsrc>.

=head1 SEE ALSO

The modules L<TeXLive::TLPSRC>, L<TeXLive::TLPOBJ>, 
L<TeXLive::TLTREE>, L<TeXLive::TLUtils> and the
document L<Perl-API.txt> and the specification in the TeX Live
repository trunk/Master/tlpkg/doc/.

=head1 AUTHORS AND COPYRIGHT

This script and its documentation were written for the TeX Live
distribution (L<http://tug.org/texlive>) and both are licensed under the
GNU General Public License Version 2 or later.

=cut

1;

### Local Variables:
### perl-indent-level: 2
### tab-width: 2
### indent-tabs-mode: nil
### End:
# vim:set tabstop=2 expandtab autoindent: #
