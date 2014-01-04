# $Id: TLWinGoo.pm 30367 2013-05-10 12:56:49Z siepo $
# TeXLive::TLWinGoo.pm - Windows nastiness
# Copyright 2008-2013 Siep Kroonenberg, Norbert Preining
# This file is licensed under the GNU General Public License version 2
# or any later version.

# code for broadcast_env adapted from Win32::Env:
# Copyright 2006 Oleg "Rowaa[SR13]" V. Volkov, all rights reserved.
# This program is free software; you can redistribute it and/or modify it
# under the same terms as Perl itself.

package TeXLive::TLWinGoo;

my $svnrev = '$Revision: 30367 $';
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

C<TeXLive::TLWinGoo> -- Additional utilities for Windows

=head2 SYNOPSIS

  use TeXLive::TLWinGoo;

=head2 DIAGNOSTICS

  TeXLive::TLWinGoo::win_version;
  TeXLive::TLWinGoo::is_vista;
  TeXLive::TLWinGoo::admin;
  TeXLive::TLWinGoo::non_admin;
  TeXLive::TLWinGoo::reg_country;

=head2 ENVIRONMENT AND REGISTRY

  TeXLive::TLWinGoo::expand_string($s);
  TeXLive::TLWinGoo::global_tmpdir;
  TeXLive::TLWinGoo::get_system_path;
  TeXLive::TLWinGoo::get_user_path;
  TeXLive::TLWinGoo::setenv_reg($env_var, $env_data);
  TeXLive::TLWinGoo::unsetenv_reg($env_var);
  TeXLive::TLWinGoo::adjust_reg_path_for_texlive($action, $texbindir, $mode);
  TeXLive::TLWinGoo::add_to_progids($ext, $filetype);
  TeXLive::TLWinGoo::remove_from_progids($ext, $filetype);
  TeXLive::TLWinGoo::register_extension($mode, $extension, $file_type);
  TeXLive::TLWinGoo::unregister_extension($mode, $extension);
  TeXLive::TLWinGoo::register_file_type($file_type, $command);
  TeXLive::TLWinGoo::unregister_file_type($file_type);

=head2 ACTIVATING CHANGES IMMEDIATELY

  TeXLive::TLWinGoo::broadcast_env;
  TeXLive::TLWinGoo::update_assocs;

=head2 SHORTCUTS

  TeXLive::TLWinGoo::desktop_path;
  TeXLive::TLWinGoo::add_desktop_shortcut($texdir, $name, $icon,
    $prog, $args, $batgui);
  TeXLive::TLWinGoo::add_menu_shortcut($place, $name, $icon,
    $prog, $args, $batgui);
  TeXLive::TLWinGoo::remove_desktop_shortcut($name);
  TeXLive::TLWinGoo::remove_menu_shortcut($place, $name);

=head2 UNINSTALLER

  TeXLive::TLWinGoo::create_uninstaller;
  TeXLive::TLWinGoo::unregister_uninstaller;

All exported functions return forward slashes.

=head2 DESCRIPTION

=over 4

=cut

BEGIN {
  use Exporter;
  use vars qw( @ISA @EXPORT $Registry);
  @ISA = qw( Exporter );
  @EXPORT = qw(
    &win_version
    &is_vista
    &admin
    &non_admin
    &reg_country
    &expand_string
    &global_tmpdir
    &get_system_path
    &get_user_path
    &setenv_reg
    &unsetenv_reg
    &adjust_reg_path_for_texlive
    &add_to_progids
    &remove_from_progids
    &register_extension
    &unregister_extension
    &register_file_type
    &unregister_file_type
    &broadcast_env
    &update_assocs
    &shell_folder
    &desktop_path
    &add_desktop_shortcut
    &add_menu_shortcut
    &remove_desktop_shortcut
    &remove_menu_shortcut
    &create_uninstaller
    &unregister_uninstaller
  );
  # for testing also:
  @EXPORT_OK = qw(
    &admin_again
    &get_system_env
    &get_user_env
    &global_tmpdir
    &is_a_texdir
    &tex_dirs_on_path
  );
  if ($^O=~/^MSWin(32|64)$/i) {
    require Win32::API;
    require Win32::TieRegistry;
    Win32::TieRegistry->import( qw( $Registry
      REG_SZ REG_EXPAND_SZ REG_NONE KEY_READ KEY_WRITE KEY_ALL_ACCESS
         KEY_ENUMERATE_SUB_KEYS ) );
    $Registry->Delimiter('/');
    $Registry->ArrayValues(0);
    $Registry->FixSzNulls(1);
    require Win32::Shortcut;
    Win32::Shortcut->import( qw( SW_SHOWNORMAL SW_SHOWMINNOACTIVE ) );
    require Time::HiRes;
  }
}

use TeXLive::TLConfig;
use TeXLive::TLUtils;
TeXLive::TLUtils->import( qw( mkdirhier ) );

sub reg_debug {
  return if ($::opt_verbosity < 1);
  my $mess = shift;
  my $regerr = Win32API::Registry::regLastError();
  if ($regerr) {
    debug("$regerr\n$mess");
  }
}

my $is_win = $^O=~/^MSWin(32|64)$/i;

=pod

=back

=head2 DIAGNOSTICS

=over 4

=item C<win_version>

C<win_version> returns the Windows version number as stored in the
registry: 5.0 for Windows 2000, 5.1 for Windows XP and 6.0 for Vista.

=cut

my $windows_version = 0;

if ($is_win) {
  my $tempkey = $Registry->Open(
    "LMachine/software/Microsoft/Windows NT/CurrentVersion/",
    {Access => KEY_READ() });
  $windows_version = $tempkey -> { "/CurrentVersion" };
}

sub win_version { return $windows_version; }

=item C<is_vista>

C<is_vista> returns 1 if win_version is >= 6.0, otherwise 0.

=cut

sub is_vista { return $windows_version >= 6; }

# permissions with which we try to access the system environment

my $is_admin = 1;

sub sys_access_permissions {
  $is_admin ? KEY_ALL_ACCESS() : KEY_READ() | KEY_ENUMERATE_SUB_KEYS();
}

sub get_system_env {
  return $Registry -> Open(
    "LMachine/system/currentcontrolset/control/session manager/Environment/",
    {Access => sys_access_permissions()});
}

# $is_admin was set to true originally. With this value,
# sys-access_permissions returns full access permissions. If that
# doesn't work out then apparently we aren't administrator, so we
# set $is_admin to 0.

if ($is_win) {
  $is_admin = 0 if not get_system_env();
  debug("Configuring TLWinGoo for " .
    ($is_admin ? "admin" : "user") . "mode\n") if win32();
}

sub get_user_env {
  return $Registry -> Open("CUser/Environment", {Access => KEY_ALL_ACCESS()});
}

=pod

=item C<admin>

Returns admin status, admin implying having full read-write access
to the system environment.

=cut

sub admin { return $is_admin; }

=pod

=item C<non_admin>

Pretend not to have admin privileges, to enforce a user- rather than
a system install.

Currently only used for testing.

=cut

sub non_admin {
  debug("TLWinGoo: switching to user mode\n");
  $is_admin = 0;
}

# just for testing; doesn't check actual user permissions
sub admin_again {
  debug("TLWinGoo: switching to admin mode\n");
  $is_admin = 1;
}

=pod

=item C<reg_country>

Two-letter country code representing the locale of the current user

=cut

sub reg_country {
  my $value = $Registry -> {"CUser/Control Panel/International//Locale"};
  return unless $value;
  # there might be trailing nulls on Vista
  $value =~ s/\x00*$//;
  $value = substr $value, -4;
  return unless $value;
  my $lmkey = $Registry -> Open("HKEY_CLASSES_ROOT/MIME/Database/Rfc1766/",
                             {Access => KEY_READ()});
  return unless $lmkey;
  $lm = $lmkey->{"/$value"};
  return unless $lm;
  debug("found lang codes value = $value, lm = $lm...\n");
  if ($lm) {
    if ($lm =~ m/^zh-(tw|hk)$/i) {
      return ("zh", "tw");
    } elsif ($lm =~ m/^zh/) {
      # for anything else starting with zh return, that is zh, zh-cn, zh-sg
      # and maybe something else
      return ("zh", "cn");
    } else {
      my $lang = lc(substr $lm, 0, 2);
      my $area = lc(substr $lm, 3, 2);
      return($lang, $area);
    }
  }
}


=pod

=back

=head2 ENVIRONMENT AND REGISTRY

Most settings can be made for a user and for the system. User
settings override system settings.

For admin users, the functions below affect both user- and system
settings. For non-admin users, only user settings are changed.

An exception is the search path: the effective searchpath consists
of the system searchpath in front concatenated with the user
searchpath at the back.

Note that in a roaming profile network setup, users take only user
settings with them to other systems, not system settings. In this
case, with a TeXLive on the network, a nonadmin install makes the
most sense.

=over 4

=item C<expand_string($s)>

This function replaces substrings C<%env_var%> with their current
values as environment variable and returns the result.

=cut

sub expand_string {
  my ($s) = @_;
  $s =~ s/%([^%;]+)%/$ENV{$1} ? $ENV{$1} : "%$1%"/eg;
  return $s;
}

=pod

=item C<global_tmpdir>

Returns the expanded value of C<%TEMP%> from the system environment,
usually C<%SystemRoot%/Temp>. This value is normally not available
from C<%ENV>.

=cut

if ($is_win) {
  $global_tmp = expand_string(get_system_env()->{'TEMP'}) if $is_win;
}

my $global_tmp = "/tmp";

sub global_tmpdir { return $global_tmp; }

sub is_a_texdir {
  my $d = shift;
  $d =~ s/\\/\//g;
  $d = $d . '/' unless $d =~ m!/$!;
  # don't consider anything under %systemroot% a texdir
  my $sr = uc($ENV{'SystemRoot'});
  $sr =~ s/\\/\//g;
  $sr = $sr . '/' unless $sr =~ m!/$!;
  return 0 if index($d, $sr)==0;
  foreach $p (qw(luatex.exe mktexlsr.exe pdftex.exe tex.exe xetex.exe)) {
    return 1 if (-e $d.$p);
  }
  return 0;
}

=pod

=item C<get_system_path>

Returns unexpanded system path, as stored in the registry, but with
forward slashes.

=cut

sub get_system_path {
  my $value = get_system_env() -> {'/Path'};
  # Remove terminating zero bytes; there may be several, at least
  # under w2k, and the FixSzNulls option only removes one.
  $value =~ s/[\s\x00]+$//;
  return $value;
}

=pod

=item C<get_user_path>

Returns unexpanded user path, as stored in the registry, but with
forward slashes. The user path often does not exist, and is rarely
expandable.

=cut

sub get_user_path {
  my $value = get_user_env() -> {'/Path'};
  return "" if not $value;
  $value =~ s/[\s\x00]+$//;
  return $value;
}

#=pod
#
#=item C<win_which_dir>
#
#More or less the same as which, except that 1. it returns a
#directory, 2. it consults the path stored in the registry rather
#than the path of the current process, and 3. it assumes that the
#filename includes an extension. Currently only used for testing.
#
#=cut
#
#sub win_which_dir {
#  my $prog = shift;
#  my $d;
#  # first check system path
#  my $path = expand_string(get_system_path());
#  my $user_path = expand_string(get_user_path());
#  $path = $path . ';' . $user_path if $user_path;
#  $path =~ s/\\/\//g;
#  foreach $d (split (';',$path)) {
#    $d =~ s/\/$//;
#    return $d if -e $d.'/'.$prog;
#  }
#  return 0;
#}

=pod

=item C<setenv_reg($env_var, $env_data[, $mode]);>

Set an environment variable $env_var to $env_data.

$mode="user": set for current user. $mode="system": set for all
users. Default: both if admin, current user otherwise.

=cut

sub setenv_reg {
  my $env_var = shift;
  my $env_data = shift;
  my $mode = @_ ? shift : "default";
  die "setenv_reg: Invalid mode $mode"
    if ($mode ne "user" and $mode ne "system" and $mode ne "default");
  die "setenv_reg: mode 'system' only available for admin"
    if ($mode eq "system" and !$is_admin);
  my $env;
  if ($mode ne "system") {
    $env = get_user_env();
    $env->ArrayValues(1);
    $env->{'/'.$env_var} =
       [ $env_data, ($env_data =~ /%/) ? REG_EXPAND_SZ : REG_SZ ];
  }
  if ($mode ne "user" and $is_admin) {
    $env = get_system_env();
    $env->ArrayValues(1);
    $env->{'/'.$env_var} =
       [ $env_data, ($env_data =~ /%/) ? REG_EXPAND_SZ : REG_SZ ];
  }
}

=pod

=item C<unsetenv_reg($env_var[, $mode]);>

Unset an environment variable $env_var

=cut

sub unsetenv_reg {
  my $env_var = shift;
  my $env = get_user_env();
  my $mode = @_ ? shift : "default";
  #print "Unsetenv_reg: unset $env_var with mode $mode\n";
  die "unsetenv_reg: Invalid mode $mode"
    if ($mode ne "user" and $mode ne "system" and $mode ne "default");
  die "unsetenv_reg: mode 'system' only available for admin"
    if ($mode eq "system" and !$is_admin);
  delete get_user_env()->{'/'.$env_var} if $mode ne "system";
  delete get_system_env()->{'/'.$env_var} if ($mode ne "user" and $is_admin);
}

=pod

=item C<tex_dirs_on_path($path)>

Returns tex directories found on the search path.
A directory is a TeX directory if it contains tex.exe or
pdftex.exe.

=cut

sub tex_dirs_on_path {
  my ($path) = @_;
  my ($d, $d_exp);
  my @texdirs = ();
  foreach $d (split (';', $path)) {
    $d_exp = expand_string($d);
    if (is_a_texdir($d_exp)) {
      # tlwarn("Possibly conflicting [pdf]TeX program found at $d_exp\n");
      push(@texdirs, $d_exp);
    };
  }
  return @texdirs;
}

=pod

=item C<adjust_reg_path_for_texlive($action, $tlbindir, $mode)>

Edit system or user PATH variable in the registry.
Adds or removes (depending on $action) $tlbindir directory
to system or user PATH variable in the registry (depending on $mode).

=cut

sub adjust_reg_path_for_texlive {
  my ($action, $tlbindir, $mode) = @_;
  die("Unknown path action: $action\n")
    if ($action ne 'add') && ($action ne 'remove');
  die("Unknown path mode: $mode\n")
    if ($mode ne 'system') && ($mode ne 'user');
  debug("Warning: [pdf]tex program not found in $tlbindir\n")
    if (!is_a_texdir($tlbindir));
  my $path = ($mode eq 'system') ? get_system_path() : get_user_path();
  $tlbindir =~ s!/!\\!g;
  my $tlbindir_short = uc(short_name($tlbindir));
  my ($d, $d_short, @newpath);
  my $tex_dir_conflict = 0;
  my @texdirs;
  foreach $d (split (';', $path)) {
    $d_short = uc(short_name(expand_string($d)));
    $d_short =~ s!/!\\!g;
    ddebug("adjust_reg: compar $d_short with $tlbindir_short\n");
    if ($d_short ne $tlbindir_short) {
      push(@newpath, $d);
      if (is_a_texdir($d)) {
        $tex_dir_conflict++;
        push(@texdirs, $d);
      }
    }
  }
  if ($action eq 'add') {
    if ($tex_dir_conflict) {
      log("Warning: conflicting [pdf]tex program found on the $mode path ", 
          "in @texdirs; appending $tlbindir to the front of the path.\n");
      unshift(@newpath, $tlbindir);
    } else {
      push(@newpath, $tlbindir);
    }
  }
  if (@newpath) {
    debug("TLWinGoo: adjust_reg_path_for_texlive: calling setenv_reg in $mode\n");
    setenv_reg("Path", join(';', @newpath), $mode);
  } else {
    debug("TLWinGoo: adjust_reg_path_for_texlive: calling unsetenv_reg in $mode\n");
    unsetenv_reg("Path", $mode);
  }
  if ( ($action eq 'add') && ($mode eq 'user') ) {
    @texdirs = tex_dirs_on_path( get_system_path() );
    return 0 unless (@texdirs);
    tlwarn("Warning: conflicting [pdf]tex program found on the system path ",
           "in @texdirs; not fixable in user mode.\n");
    return 1;
  }
  return 0;
}

### File types ###

# Refactored from 2010 edition. New functionality:
# add_to_progids for defining alternate filetypes for an extension.
# Their associated programs show up in the `open with' right-click menu.

### helper subs ###

# merge recursive hash refs such as occur in the registry

sub hash_merge {
  my $target = shift; # the recursive hash ref to be modified by $mods
  my $mods = shift; # the recursive hash ref to be merged into $target
  my $k;
  foreach $k (keys %$mods) {
    if (ref($target->{$k}) eq 'HASH' and ref($mods->{$k}) eq 'HASH') {
      hash_merge($target->{$k}, $mods->{$k});
    } else {
      $target->{$k} = $mods->{$k};
      reg_debug ("at hash merge\n");
      $target->Flush();
      reg_debug ("at hash merge\n");
    }
  }
}

# prevent catastrophies during testing; not to be used in production code

sub getans {
  my $prompt = shift;
  my $ans;
  print STDERR "$prompt ";
  $ans = <STDIN>;
  if ($ans =~ /^y/i) {print STDERR "\n"; return 1;}
  die "Aborting as requested";
}

# delete a registry key recursively.
# the key parameter should be a string, not a registry object.

sub reg_delete_recurse {
  my $parent = shift;
  my $childname = shift;
  my $parentpath = $parent->Path;
  ddebug("Deleting $parentpath$childname\n");
  my $child;
  if ($childname !~ '^/') { # subkey
    $child = $parent->Open ($childname, {Access => KEY_ALL_ACCESS()});
    reg_debug ("at open $childname for all access\n");
    return 1 unless defined($child);
    foreach my $v (keys %$child) {
      if ($v =~ '^/') { # value
        delete $child->{$v};
        reg_debug ("at delete $childname/$v\n");
        $child->Flush();
        reg_debug ("at delete $childname/$v\n");
        Time::HiRes::usleep(20000);
      } else { # subkey
        return 0 unless reg_delete_recurse ($child, $v);
      }
    }
    #delete $child->{'/'};
  }
  delete $parent->{$childname};
  reg_debug ("at delete $parentpath$childname\n");
  $parent->Flush();
  reg_debug ("at delete $parentpath$childname\n");
  Time::HiRes::usleep(20000);
  return 1;
}

sub cu_root {
  my $k = $Registry -> Open("CUser", {
    Access => KEY_ALL_ACCESS(), Delimiter => '/'
  });
  reg_debug ("at open HKCU for all access\n");
  die "Cannot open HKCU for writing" unless $k;
  return $k;
}

sub lm_root {
  my $k = $Registry -> Open("LMachine", {
      Access => ($is_admin ? KEY_ALL_ACCESS() : KEY_READ()),
      Delimiter => '/'
  });
  reg_debug ("at open HKLM\n");
  die "Cannot open HKLM for ".($is_admin ? "writing" : "reading")
      unless $k;
  return $k;
}

sub do_write_regkey {
  my $keypath = shift; # modulo cu/lm
  my $keyhash = shift; # ref to a possibly nested hash; empty hash allowed
  my $remove_cu = shift;
  die "No regkey specified" unless $keypath && defined($keyhash);
  # for error reporting:
  my $hivename = $is_admin ? 'HKLM' : 'HKCU';

  # split into parent and final subkey
  # remove initial slash from parent
  # ensure subkey ends with slash
  my ($parentpath, $keyname);
  if ($keypath =~ /^\/?(.+\/)([^\/]+)\/?$/) {
    ($parentpath, $keyname) = ($1, $2);
    $keyname .= '/';
    debug ("key - $hivename - $parentpath - $keyname\n");
  } else {
    die "Cannot determine final component of $keypath";
  }

  my $cu_key = cu_root();
  my $lm_key = lm_root();
  # cu_root() and lm_root() already die upon failure
  my $parentkey;

  # make sure parent exists
  if ($is_admin) {
    $parentkey = $lm_key->Open($parentpath);
    reg_debug ("at open $parentpath; creating...\n");
    if (!$parentkey) {
      # in most cases, this probably shouldn't happen for lm
      $parentkey = $lm_key->CreateKey($parentpath);
      reg_debug ("at creating $parentpath\n");
    }
  } else {
    $parentkey = $cu_key->Open($parentpath);
    reg_debug ("at open $parentpath; creating...\n");
    if (!$parentkey) {
      $parentkey = $cu_key->CreateKey($parentpath);
      reg_debug ("at creating $parentpath\n");
    }
  }
  if (!$parentkey) {
    tlwarn "Cannot create parent of $hivename/$keypath\n";
    return 0;
  }

  # create or merge key
  if ($parentkey->{$keyname}) {
    hash_merge($parentkey->{$keyname}, $keyhash);
  } else {
    $parentkey->{$keyname} = $keyhash;
    reg_debug ("at creating $keyname\n");
  }
  if (!$parentkey->{$keyname}) {
    tlwarn "Failure to create $hivename/$keypath\n";
    return 0;
  }
  if ($is_admin and $cu_key->{$keypath} and $remove_cu) {
    # delete possibly conflicting cu key
    tlwarn "Failure to delete $hivename/$keypath key\n" unless
      reg_delete_recurse ($cu_key->{$parentpath}, $keyname);
  }
  return 1;
}

# remove a registry key under HKCU or HKLM, depending on privilege level

sub do_remove_regkey {
  my $keypath = shift; # key or value
  my $remove_cu = shift;
  my $hivename = $is_admin ? 'HKLM' : 'HKCU';

  my $parentpath = "";
  my $keyname = "";
  my $valname = "";
  # two successive delimiters: value.
  # *? = non-greedy match: want FIRST double delimiter
  if ($keypath =~ /^(.*?\/)(\/.*)$/) {
    ($parentpath, $valname) = ($1, $2);
    $parentpath =~ s!^/!!; # remove leading delimiter
  } elsif ($keypath =~ /^\/?(.+\/)([^\/]+)\/?$/) {
    ($parentpath, $keyname) = ($1, $2);
    $keyname .= '/';
  } else {
    die "Cannot determine final component of $keypath";
  }

  my $cu_key = cu_root();
  my $lm_key = lm_root();
  my ($parentkey, $k, $skv, $d);
  if ($is_admin) {
    $parentkey = $lm_key->Open($parentpath);
  } else {
    $parentkey = $cu_key->Open($parentpath);
  }
  reg_debug ("at opening $parentpath\n");
  if (!$parentkey) {
    debug ("$hivename/$parentpath not present or not writable".
      " so $keypath not removed\n");
    return 1;
  }
  if ($keyname) {
    #getans("Deleting $parentpath$keyname regkey? ");
    reg_delete_recurse($parentkey, $keyname);
    if ($parentkey->{$keyname}) {
      tlwarn "Failure to delete $hivename/$keypath\n";
      return 0;
    }
    if ($is_admin and $cu_key->{$parentpath}) {
      reg_delete_recurse($cu_key->{$parentpath}, $keyname);
      if ($cu_key->{$parentpath}->{$keyname}) {
        tlwarn "Failure to delete HKCU/$keypath\n";
        return 0;
      }
    }
  } else {
    delete $parentkey->{$valname};
    reg_debug ("at deleting $valname\n");
    if ($parentkey->{$valname}) {
      tlwarn "Failure to delete $hivename/$keypath\n";
      return 0;
    }
    if ($is_admin and $cu_key->{$parentpath}) {
      delete $cu_key->{$parentpath}->{$valname};
      reg_debug ("at deleting $valname\n");
      if ($cu_key->{$parentpath}->{$valname}) {
        tlwarn "Failure to delete HKCU/$keypath\n";
        return 0;
      }
    }
  }
  return 1;
}

# Effective default value of any key under Classes.
# admin: HKLM; user: HKCU or otherwise HKLM
# Reject if there is no corresponding key under classes
sub current_filetype {
  my $extension = shift;
  my $filetype;
  if ($is_admin) {
    $filetype = lm_root()->{"Software/Classes/$extension//"}; # REG_SZ
  } else {
    # Mysterious failures on w7_64 => merge HKLM/HKCU info explicitly
    # rather than checking HKCR
    $filetype = cu_root()->{"Software/Classes/$extension//"};
    if (!defined($filetype) or ($filetype eq "")) {
      $filetype = lm_root()->{"Software/Classes/$extension//"}
    };
  }
  $filetype = "" unless defined($filetype);
  return $filetype;
}

### now the exported file type functions ###

=pod

=item C<add_to_progids($ext, $filetype)>

Add $filetype to the list of alternate progids/filetypes of extension $ext.
The associated program shows up in the `open with' right-click menu.

=cut

sub add_to_progids {
  my $ext = shift;
  my $filetype = shift;
  #$Registry->ArrayValues(1);
  #do_write_regkey("Software/Classes/$ext/OpenWithProgIds/",
  #    {"/$filetype" => [0, REG_NONE()]});
  #$Registry->ArrayValues(0);
  do_write_regkey("Software/Classes/$ext/OpenWithProgIds/",
      {"/$filetype" => ""});
}

=pod

=item C<remove_from_progids($ext, $filetype)>

Remove $filetype from the list of alternate filetypes for $ext

=cut

sub remove_from_progids {
  my $ext = shift;
  my $filetype = shift;
  do_remove_regkey("Software/Classes/$ext/OpenWithProgIds//$filetype");
}

=pod

=item C<register_extension($mode, $extension, $file_type)>

Add registry entry to associate $extension with $file_type. Slashes
are flipped where necessary.

If $mode is 0, nothing is actually done.

For $mode 1, the filetype for the extension is preserved, but only
if there is a registry key under Classes for it. For $mode>0,
the new filetype is always added to the openwithprogids list.

For $mode 2, the filetype is always overwritten. The old filetype
moves to the openwithprogids list if necessary.

=cut

sub register_extension {
  my $mode = shift;
  return 1 if $mode == 0;
  my $extension = shift;
  # ensure leading dot
  $extension = '.'.$extension unless $extension =~ /^\./;
  $extension = lc($extension);
  my $file_type = shift;
  my $regkey;

  my $old_file_type = current_filetype($extension);
  if ($old_file_type) {
    if ($is_admin) {
      if (not lm_root()->{"Software/Classes/$old_file_type/"}) {
        $old_file_type = "";
      }
    } else {
      if ((not cu_root()->{"Software/Classes/$old_file_type/"}) and
          (not lm_root()->{"Software/Classes/$old_file_type/"})) {
        $old_file_type = "";
      }
    }
  }
  # admin: whether to remove HKCU entry. admin never _writes_ to HKCU
  my $remove_cu = ($mode == 2) && admin();
  # can do the following safely:
  debug ("Adding $file_type to OpenWithProgIds of $extension\n");
  add_to_progids ($extension, $file_type);
  if ($old_file_type and $old_file_type ne $file_type) {
    if ($mode == 1) {
      debug ("Not overwriting $old_file_type with $file_type for $extension\n");
    } else {
      debug("Linking $extension to $file_type\n");
      debug ("Moving $old_file_type to OpenWithProgIds\n");
      add_to_progids ($extension, $old_file_type);
      $regkey = {'/' => $file_type};
      do_write_regkey("Software/Classes/$extension/", $regkey, $remove_cu);
    }
  } else {
    $regkey = {'/' => $file_type};
    do_write_regkey("Software/Classes/$extension/", $regkey, $remove_cu);
  }
}

=pod

=item C<unregister_extension($mode, $extension, $file_type)>

Reversal of register_extension.

=cut

sub unregister_extension {
  # we don't error check; we just do the best we can.
  my $mode = shift;
  return 1 if $mode == 0;
  # mode 1 and 2 treated identically:
  # only unregister if the current value is as expected
  my $extension = shift;
  my $file_type = shift;
  $extension = '.'.$extension unless $extension =~ /^\./;
  remove_from_progids($extension, $file_type);
  my $old_file_type = current_filetype("$extension");
  if ($old_file_type ne $file_type) {
    debug("Filetype $extension now $old_file_type; not ours, so not removed\n");
    return 1;
  } else {
    debug("unregistering extension $extension\n");
    do_remove_regkey("Software/Classes/$extension//");
  }
}

=pod

=item C<register_file_type($file_type, $command)>

Add registry entries to associate $file_type with $command. Slashes
are flipped where necessary. Double quotes should be added by the
caller if necessary.

=cut

sub register_file_type {
  my $file_type = shift;
  my $command = shift;
  tlwarn "register_file_type called with empty command\n" unless $command;
  $command =~s!/!\\!g;
  debug ("Linking $file_type to $command\n");
  my $keyhash = {
    "shell/" => {
      "open/" => {
        "command/" => {
          "/" => $command
        }
      }
    }
  };
  do_write_regkey("Software/Classes/$file_type", $keyhash);
}

=pod

=item C<unregister_file_type($file_type)>

Reversal of register_file_type.

=cut

sub unregister_file_type {
  # we don't error check; we just do the best we can.
  # All our filetypes start with 'TL.' so we consider them
  # our own even if they have been tampered with.
  my $file_type = shift;
  debug ("unregistering $file_type\n");
  do_remove_regkey("Software/Classes/$file_type/");
}

=pod

=back

=head2 ACTIVATING CHANGES IMMEDIATELY

=over 4

=item C<broadcast_env>

Broadcasts system message that enviroment has changed. This only has
an effect on newly-started programs, not on running programs and the
processes they spawn.

=cut

sub broadcast_env() {
  use constant HWND_BROADCAST	=> 0xffff;
  use constant WM_SETTINGCHANGE	=> 0x001A;
  my $result = "";
  my $SendMessage;
  debug("Broadcasting \"Enviroment settings changed\" message...\n");
  #$SendMessage = new Win32::API('user32', 'SendMessage', 'LLPP', 'L');
  #$result = $SendMessage->Call(HWND_BROADCAST, WM_SETTINGCHANGE,
  #    0, 'Environment') if $SendMessage;
  $SendMessage = new Win32::API('user32', 'SendMessageTimeout', 'LLPPLLP', 'L');
  my $ans = "12345678"; # room for dword
  $result = $SendMessage->Call(HWND_BROADCAST, WM_SETTINGCHANGE,
      0, 'Environment', 0, 2000, $ans) if $SendMessage;
  debug("Broadcast complete; result: $result.\n");
}

=pod

=item C<update_assocs>

Notifies the system that filetypes have changed.

=cut

sub update_assocs() {
  use constant SHCNE_ASSOCCHANGED	=> 0x8000000;
  use constant SHCNF_IDLIST =>	0;
  my $update_fu = new Win32::API('shell32', 'SHChangeNotify', 'LIPP', 'V');
  if ($update_fu) {
    debug("Notifying changes in filetypes...\n");
    $update_fu->Call (SHCNE_ASSOCCHANGED, SHCNF_IDLIST, 0, 0);
    debug("Done notifying\n");
  } else {
    debug("No update_fu\n");
  }
}

=pod

=back

=head2 SHORTCUTS

=cut

# short path names

my $shortfu;
if ($^O=~/^MSWin(32|64)$/i) {
  $shortfu = new Win32::API('kernel32', 'GetShortPathName', 'PPN', 'N');
}

sub short_name {
  my ($fname) = @_;
  return $fname unless $is_win;
  my $buffer = (' ' x 260);
  my $slength = $shortfu->Call($fname, $buffer, 260);
  if ($slength>0) { return substr $buffer, 0, $slength; }
  else { return ''; }
}

=pod

=over 4

=item C<shell_folder>

Location of shell `special folders'; $user_name is the name
to look for in user mode, $admin_name is the name for admin mode,
e.g. `Desktop' and `Common Desktop'. The default for $admin_name is
'Common .$user_name

=cut

sub shell_folder {
  my ($user_name, $admin_name) = @_;
  $admin_name = 'Common '.$user_name unless ($admin_name or !$user_name);
  my ($shell_key, $sh_folder);
  if (admin()) {
    return 0 unless $admin_name;
    $shell_key = $Registry->Open(
    "LMachine/software/microsoft/windows/currentversion/explorer/user shell folders/",
      {Access => KEY_READ}) or return 0;
    $sh_folder = $shell_key -> {"/$admin_name"};
    $sh_folder = short_name(expand_string($sh_folder));
  } else {
    $shell_key = $Registry->Open(
    "CUser/software/microsoft/windows/currentversion/explorer/user shell folders/",
      {Access => KEY_READ}) or return 0;
    $sh_folder = $shell_key -> {"/$user_name"};
    $sh_folder = short_name(expand_string($sh_folder));
  }
  $sh_folder =~ s!\\!/!g;
  return $sh_folder;
}

sub desktop_path() {
  return shell_folder('Desktop');
}

sub menu_path() {
  return shell_folder('Programs', 'Common Programs');
}

=pod

=item C<add_desktop_shortcut($name, $icon, $prog, $args, $batgui)>

Add a desktop shortcut, with name $name and icon $icon, pointing to
program $prog with parameters $args (a string).  Use a non-null
batgui parameter if the shortcut starts a gui program via a
batchfile. Then the inevitable command prompt will be hidden
rightaway, leaving only the gui program visible.

=cut

sub add_desktop_shortcut {
  my ($name, $icon, $prog, $args, $batgui) = @_;

  # create shortcut
  my ($shc, $shpath, $shfile);
  $shc = new Win32::Shortcut();
  $shc->{'IconLocation'} = $icon if -f $icon;
  $shc->{'Path'} = $prog;
  $shc->{'Arguments'} = $args;
  $shc->{'ShowCmd'} = $batgui ? SW_SHOWMINNOACTIVE : SW_SHOWNORMAL;
  $shfile = desktop_path().'/'.$name.'.lnk';
  $shc->Save($shfile);
}

=pod

=item C<add_menu_shortcut($place, $name, $icon,
  $prog, $args, $batgui)>

Add a menu shortcut at place $place (relative to Start/Programs),
with name $name and icon $icon, pointing to program $prog with
parameters $args. See above for batgui.

=cut

sub add_menu_shortcut {
  my ($place, $name, $icon, $prog, $args, $batgui) = @_;
  $place =~ s!\\!/!g;

  my ($shc, $shpath, $shfile);
  $shc = new Win32::Shortcut();
  $shc->{'IconLocation'} = $icon if -f $icon;
  $shc->{'Path'} = $prog;
  $shc->{'Arguments'} = $args;
  $shc->{'ShowCmd'} = $batgui ? SW_SHOWMINNOACTIVE : SW_SHOWNORMAL;
  $shpath = $place;
  $shpath =~ s!\\!/!g;
  $shpath = '/'.$shpath unless $shpath =~ m!^/!;
  $shpath = menu_path().$shpath;
  if ((-e $shpath) and not (-d $shpath)) {
    next; # fail silently and don't worry about it
  } elsif (not (-d $shpath)) {
    mkdirhier($shpath);
    return unless -d $shpath;
  }
  $shfile = $shpath.'/'.$name.'.lnk';
  $shc->Save($shfile);
}

=pod

=item C<remove_desktop_shortcut($name)>

For uninstallation of an individual package.

=cut

sub remove_desktop_shortcut {
  my $name = shift;
  unlink desktop_path().'/'.$name.'.lnk';
}

=pod

=item C<remove_menu_shortcut($place, $name)>

For uninstallation of an individual package.

=cut

sub remove_menu_shortcut {
  my $place = shift;
  my $name = shift;
  $place =~ s!\\!/!g;
  $place = '/'.$place unless $place =~ m!^/!;
  unlink menu_path().$place.'/'.$name.'.lnk';
}

=pod

=back

=head2 UNINSTALLER

=over 4

=item C<create_uninstaller>

Writes registry entries for add/remove programs which  reference
the uninstaller script and creates uninstaller batchfiles to finish
the job.

=cut

sub create_uninstaller {
  my $td_fw = shift;
  # TEXDIR, TEXMFSYSVAR, TEXMFSYSCONFIG
  $td_fw =~ s![\\/]$!!;
  my $td = $td_fw;
  $td =~ s!/!\\!g;

  my $tdmain = `$td\\bin\\win32\\kpsewhich -var-value=TEXMFMAIN`;
  chomp $tdmain;

  my $uninst_key = $Registry -> Open((admin() ? "LMachine" : "CUser") .
    "/software/microsoft/windows/currentversion/",
    {Access => KEY_ALL_ACCESS()});
  my $k = $uninst_key->CreateKey(
    "uninstall/TeXLive$::TeXLive::TLConfig::ReleaseYear/");
  $k->{"/DisplayName"} = "TeX Live $::TeXLive::TLConfig::ReleaseYear";
  $k->{"/UninstallString"} = "\"$td\\tlpkg\\installer\\uninst.bat\"";
  $k->{'/DisplayVersion'} = $::TeXLive::TLConfig::ReleaseYear;
  $k->{'/URLInfoAbout'} = "http://www.tug.org/texlive";

  mkdirhier("$td_fw/tlpkg/installer"); # wasn't this done yet?
  if (open UNINST, ">$td_fw/tlpkg/installer/uninst.bat") {
    print UNINST <<UNEND;
\@echo off
setlocal
path $td\\tlpkg\\tlperl\\bin;$td\\bin\\win32;%path%
set PERL5LIB=$td\\tlpkg\\tlperl\\lib
rem Clean environment from other Perl variables
set PERL5OPT=
set PERLIO=
set PERLIO_DEBUG=
set PERLLIB=
set PERL5DB=
set PERL5DB_THREADED=
set PERL5SHELL=
set PERL_ALLOW_NON_IFS_LSP=
set PERL_DEBUG_MSTATS=
set PERL_DESTRUCT_LEVEL=
set PERL_DL_NONLAZY=
set PERL_ENCODING=
set PERL_HASH_SEED=
set PERL_HASH_SEED_DEBUG=
set PERL_ROOT=
set PERL_SIGNALS=
set PERL_UNICODE=

perl.exe \"$tdmain\\scripts\\texlive\\uninstall-win32.pl\"
if errorlevel 1 goto :eof
rem test for taskkill and try to stop exit tray menu
taskkill /? >nul 2>&1
if not errorlevel 1 1>nul 2>&1 taskkill /IM tl-tray-menu.exe /f
copy \"$td\\tlpkg\\installer\\uninst2.bat\" \"\%TEMP\%\"
rem pause
\"\%TEMP\%\\uninst2.bat\"
UNEND
;
  close UNINST;
  } else {
    warn "Cannot open $td_fw/tlpkg/installer/uninst.bat for append";
  }

  # We could simply delete everything under the root at one go,
  # but this might be catastrophic if TL doesn't have its own root.
  if (open UNINST2, ">$td_fw/tlpkg/installer/uninst2.bat") {
    print UNINST2 <<UNEND2;
rmdir /s /q \"$td\\bin\"
rmdir /s /q \"$td\\readme-html.dir\"
rmdir /s /q \"$td\\readme-txt.dir\"
if exist \"$td\\temp\" rmdir /s /q \"$td\\temp\"
rmdir /s /q \"$td\\texmf-dist\"
rmdir /s /q \"$td\\tlpkg\"
del /q \"$td\\README.*\"
del /q \"$td\\LICENSE.*\"
if exist \"$td\\doc.html\" del /q \"$td\\doc.html\"
del /q \"$td\\index.html\"
del /q \"$td\\texmf.cnf\"
del /q \"$td\\texmfcnf.lua\"
del /q \"$td\\install-tl*.*\"
del /q \"$td\\tl-tray-menu.exe\"
rem del /q \"$td\\texlive.profile\"
del /q \"$td\\release-texlive.txt\"
UNEND2
;
    for my $d ('TEXMFSYSVAR', 'TEXMFSYSCONFIG') {
      my $kd = `$td\\bin\\win32\\kpsewhich -var-value=$d`;
      chomp $kd;
      print UNINST2 "rmdir /s /q \"", $kd, "\"\r\n";
    }
    if ($td !~ /^.:$/) {
      print UNINST2 <<UNEND3;
for \%\%f in (\"$td\\*\") do goto :done
for /d \%\%f in (\"$td\\*\") do goto :done
rd \"$td\"
:done
\@echo Done uninstalling TeXLive.
\@pause
del \"%0\"
UNEND3
;
    }
    close UNINST2;
  } else {
    warn "Cannot open $td_fw/tlpkg/installer/uninst2.bat for writing";
  }
}

=pod

=item C<unregister_uninstaller>

Removes TeXLive from Add/Remove Programs.

=cut

sub unregister_uninstaller {
  my ($w32_multi_user) = @_;
  my $regkey_uninst_path = ($w32_multi_user ? "LMachine" : "CUser") . 
    "/software/microsoft/windows/currentversion/uninstall/";
  my $regkey_uninst = $Registry->Open($regkey_uninst_path,
    {Access => KEY_ALL_ACCESS()});
  reg_delete_recurse(
    $regkey_uninst, "TeXLive$::TeXLive::TLConfig::ReleaseYear/") 
    if $regkey_uninst;
  tlwarn "Failure to unregister uninstaller\n" if
    $regkey_uninst->{"TeXLive$::TeXLive::TLConfig::ReleaseYear/"};
}

=pod

=back

=cut

# needs a terminal 1 for require to succeed!
1;

### Local Variables:
### perl-indent-level: 2
### tab-width: 2
### indent-tabs-mode: nil
### End:
# vim:set tabstop=2 expandtab: #
