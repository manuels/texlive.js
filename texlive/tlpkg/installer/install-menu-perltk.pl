#!/usr/bin/env perl
# $Id: install-menu-perltk.pl 30493 2013-05-15 22:13:04Z karl $
#
# Copyright 2008-2013 Norbert Preining
# Copyright 2008 Reinhard Kotucha
# This file is licensed under the GNU General Public License version 2
# or any later version.
#
# TODO:
# - make the fancy selector the default, at least on unix
# - for w32 find out the necessary files for the fancy selector and move
#   them to the installer perl package

use strict;
$^W = 1;

my $svnrev = '$Revision: 30493 $';
$svnrev =~ m/: ([0-9]+) /;
$::menurevision = $1;

require Tk;
require Tk::Dialog;
require Tk::DialogBox;
require Tk::PNG;
require Tk::ROText;
require Tk::ProgressBar;
require Tk::BrowseEntry;

if ($::alternative_selector) {
  require Tk::DirTree;
}

use utf8;
no utf8;

our %vars;
our $tlpdb;
our @collections_std;
our $texlive_release;
our @media_available;
our $media;

our $MENU_INSTALL = 0;
our $MENU_ABORT   = 1;
our $MENU_QUIT    = 2;
our $MENU_ALREADYDONE = 3;

my $return = $MENU_INSTALL;

our $LANG;
our %TRANS;
require("TeXLive/trans.pl");

$::fileassocdesc[0] = __("None");
$::fileassocdesc[1] = __("Only new");
$::fileassocdesc[2] = __("All");

$::letterdesc[0] = __('A4');
$::letterdesc[1] = __('letter');

my $mw;
my $subframe;
my $mainwindow;
my $bin_toggle_button;
my $scheme_toggle_button;
my $collection_toggle_button;
my $portable_toggle_button;
my $texdir_toggle_button;
my $paper_toggle_button;
my $write_eighteen_toggle_button;
my $format_toggle_button;
my $doc_files_toggle_button;
my $src_files_toggle_button;
my $texworks_toggle_button;
my $load_remote_button;
my $adjustrepo_toggle_button;
my $bintextbutton;
my $schemebutton;
my $tmflocalbutton;
my $tmfsysvarbutton;
my $tmfsysconfigbutton;
my $tmfhomebutton;
my $pathbutton;
my $deskintbutton;
my $assocbutton;
my $adminbutton;
my $installbutton;
my $collectionstext;
my $texmflocaltext;
my $texmfsysvartext;
my $texmfsysconfigtext;
my $texmfhometext;
my $texdirtext;
my $optletterstate;
my $optfmtstate;
my $optsrcstate;
my $optdocstate;
my $portableyesno;
my $letteryesno;
my $fmtyesno;
my $srcyesno;
my $deskintyesno;
my $pathadjyesno;
my $fileassocyesno;
my $editoryesno;
my $adminallyesno;
my $docyesno;
my $restrictedyesno;
my $adjustrepoyesno;

$::run_menu = \&run_menu_perltk;


####################################################################
# From here on only function definitions
# ##################################################################

sub setup_perltk_local_vars {
  $portableyesno = ( $vars{'portable'} ? __("Yes") : __("No") );
  $letteryesno = $::letterdesc[$vars{'option_letter'}];
  $fmtyesno = ( $vars{'option_fmt'} ? __("Yes") : __("No") );
  $srcyesno = ( $vars{'option_src'} ? __("Yes") : __("No") );
  $deskintyesno = ( $vars{'option_desktop_integration'} ? __("Yes") : __("No") );
  $pathadjyesno = ( $vars{'option_path'} ? __("Yes") : __("No") );
  $fileassocyesno = $::fileassocdesc[$vars{'option_file_assocs'}];
  $editoryesno = ( $vars{'collection-texworks'} ? __("Yes") : __("No") );
  $adminallyesno = ( $vars{'option_w32_multi_user'} ? __("Yes") : __("No") );
  $docyesno = ( $vars{'option_doc'} ? __("Yes") : __("No") );
  $restrictedyesno = ( $vars{'option_write18_restricted'} ? __("Yes") : __("No") );
  $adjustrepoyesno = ( $vars{'option_adjustrepo'} ? __("Yes") : __("No") );
}

sub menu_abort {
    $return = $MENU_ABORT;
    $mainwindow->destroy;
}

sub setup_hooks_perltk {
  @::info_hook = ();
  push @::info_hook,
    sub {
      return unless defined $mainwindow;
      update_status(join(" ",@_));
      $mainwindow->update;
    };
  push @::warn_hook,
    sub {
      return unless defined $mainwindow ;
      update_status(join(" ",@_));
      $mainwindow->update;
    };
  @::install_packages_hook = ();
  push @::install_packages_hook, \&update_progressbar;
  push @::install_packages_hook,
    sub {
      return unless defined $mainwindow;
      return unless defined $::sww;
      $mainwindow->update;
      $::sww->update;
    };
}

sub update_status {
  my ($p) = @_;
  return unless defined $::progressw;
  $::progressw->insert("end", "$p");
  $::progressw->see("end");
}
sub update_progressbar {
  my ($n,$total) = @_;
  return unless defined $::progress;
  if (defined($n) && defined($total)) {
    $::progress->value(int($n*100/$total));
  }
}

sub disable_buttons {
  change_button_state('disabled');
}
sub enable_buttons {
  change_button_state('normal');
}

sub change_button_state {
  my $what = shift;
  $installbutton->configure(-state => $what);
  $tmflocalbutton->configure(-state => $what);
  $tmfsysvarbutton->configure(-state => $what);
  $tmfsysconfigbutton->configure(-state => $what);
  $tmfhomebutton->configure(-state => $what);
  $bin_toggle_button->configure(-state => $what);
  $scheme_toggle_button->configure(-state => $what);
  $collection_toggle_button->configure(-state => $what);
  $portable_toggle_button->configure(-state => $what);
  $texdir_toggle_button->configure(-state => $what);
  $texdir_toggle_button->configure(-state => $what);
  $paper_toggle_button->configure(-state => $what);
  $write_eighteen_toggle_button->configure(-state => $what);
  $format_toggle_button->configure(-state => $what);
  $adjustrepo_toggle_button->configure(-state => $what);
  $pathbutton->configure(-state => $what);
  $doc_files_toggle_button->configure(-state => $what) if defined($doc_files_toggle_button);
  $src_files_toggle_button->configure(-state => $what) if defined($src_files_toggle_button);
  $texworks_toggle_button->configure(-state => $what) if defined($texworks_toggle_button);
}

sub run_menu_perltk {
  if ($::opt_select_repository) {
  } else {
    do_remote_init();
    setup_perltk_local_vars();
    calc_depends();
  }
  $mainwindow = Tk::MainWindow->new;
  $mainwindow->protocol('WM_DELETE_WINDOW' => \&menu_abort);
  setup_hooks_perltk();

  # Taco once reported for 2010 that using these scrolled pane
  # on Windows just died
  # with the proliferation of netbooks and a new perl installed
  # let us try to go back to using scrolled pane on both unix and windows
  #if (!win32()) {
    require Tk::Pane;
    $subframe = $mainwindow->Scrolled("Frame", -scrollbars => "oe");
  #} else {
  #  $subframe = $mainwindow->Frame;
  #}
  $mw = $subframe->Frame;

  # image frame on the left
  my $fl = $mw->Frame(-background => "#0078b8");
  my $img = $fl->Photo(-format => 'png',
                       -file => "$::installerdir/tlpkg/installer/texlive.png");
  $fl->Label(-image => $img, -background => "#0078b8")->pack(-expand => 1, -fill => "y");
  $fl->Label(-text => "v$::installerrevision/$::menurevision", -background => "#0078b8")->pack;

  # data frame on the right
  my $fr = $mw->Frame;
  $fl->pack(-side => 'left', -expand => 1, -fill => "y");
  $fr->pack(-side => 'right');


  my $row = 1;
  $fr->Label(-text => __("TeX Live %s Installation", $TeXLive::TLConfig::ReleaseYear))->grid(-row => $row, -column => 1, -columnspan => 3);

  if ($::opt_select_repository) {
    $row++;
    my @mirror_list;
    my @netlst;
    my @loclst;
    if ($#media_available >= 0) {
      for my $l (@media_available) {
        my ($a, $b) = split ('#', $l);
        if ($a eq 'local_compressed' || $a eq 'local_uncompressed') {
          push @loclst, "  $b";
        } elsif ($a eq 'NET') {
          push @netlst, "  " . __("Command line repository") . ": $b";
        } else {
          tlwarn("Unknown media $l\n");
        }
      }
      if ($#loclst >= 0) {
        push @mirror_list, __("LOCAL REPOSITORIES");
        push @mirror_list, @loclst;
      }
    }
    push @mirror_list, __("NETWORK REPOSITORIES");
    push @mirror_list, "  " . __("Default remote repository") . ": http://mirror.ctan.org";
    push @mirror_list, @netlst;
    push @mirror_list, TeXLive::TLUtils::create_mirror_list();
    my $mirror_entry;
    $fr->Label(-text => __('Select repository'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->BrowseEntry(-state => 'readonly',
    -listheight => 12, 
    -listwidth => 400,
    -width => 35,
    -autolistwidth => 1,
    -choices => \@mirror_list,
    -browsecmd => 
      sub {
        if ($mirror_entry !~ m/^  /) {
          $mirror_entry = "";
        } elsif ($mirror_entry =~ m!(http|ftp)://!) {
          $mirror_entry = TeXLive::TLUtils::extract_mirror_entry($mirror_entry);
        } else {
          $mirror_entry =~ s/^\s*//;
          # $mirror_entry = TeXLive::TLUtils::extract_mirror_entry($mirror_entry);
        }
      },
    -variable => \$mirror_entry)->grid(-row => $row, -column => 2, -sticky => 'w');
    $load_remote_button = $fr->Button(-text => __("Load"), 
      -command => sub { 
        $::init_remote_needed = 1;
        my $mfull = $mirror_entry;
        only_load_remote($mfull);
        if (!only_load_remote($mfull)) {
          $fr->Dialog(-title => __("Warning"),
            -text => __('Could not load remote TeX Live Database:') . $mfull
              . "\n\n" . 
              __('Please select a different mirror.'),
            -buttons => [ __("Ok") ])->Show;
          $mirror_entry = "";
        } elsif (!do_version_agree()) {
          $fr->Dialog(-title => __("Warning"),
            -text => __('The TeX Live versions of the local installation and the repository being accessed are not compatible:
  local: %s
  repository: %s
Please select a different mirror.', $TeXLive::TLConfig::ReleaseYear, $texlive_release),
            -buttons => [ __("Ok") ])->Show;
          $mirror_entry = "";
        } else {
          $load_remote_button->configure(-state => 'disable');
          final_remote_init($mfull);
          setup_perltk_local_vars();
          calc_depends();
          menu_update_texts();
          enable_buttons();
        }
      })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
  }
  if (!$vars{'in_place'}) {

    $row++;
    $fr->Label(-text => "------- " . __("Basic Information") . " -------")->grid(-row => $row, -column => 1, -columnspan => 3);

    # binary system line
    if (!win32()) {
      $row++;
      $fr->Label(-text => __('Binary system(s)'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
      $bintextbutton = $fr->Label(-anchor => 'w');
      $bintextbutton->grid(-row => $row, -column => 2, -padx => "2m");
      $bin_toggle_button = $fr->Button(-text => __("Change"), -command => sub { menu_select_binsystems(); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
    }

    $row++;

    # scheme line
    $fr->Label(-text => __('Selected scheme'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $schemebutton = $fr->Label(-anchor => 'w');
    $schemebutton->grid(-row => $row, -column => 2, -padx => "2m");
    $scheme_toggle_button = $fr->Button(-text => __("Change"), -command => sub { menu_select_scheme(); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

    $row++;

    # further customization
    $fr->Label(-text => "------- " . __("Further Customization") . " -------")->grid(-row => $row, -column => 1,-columnspan => 3);

    $row++;
    # collection line
    $fr->Label(-text => __('Installation collections'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $collection_toggle_button = $fr->Button(-text => __("Change"), -command => sub { menu_select_standard_collections(); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

    $row++;
    $collectionstext = $fr->Label();
    $collectionstext->grid(-row => $row, -column => 1, -columnspan => 3);
  }

  $row++;
  # further customization
  $fr->Label(-text => "------- " . __("Directory setup") . " -------")->grid(-row => $row, -column => 1, -columnspan => 3);

  $row++;
  $fr->Label(-text => __('Portable setup'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $fr->Label(-anchor => 'w', -textvariable => \$portableyesno)->grid(-row => $row, -column => 2, -padx => "2m");
  $portable_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_portable(); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  $row++;
  # texdir line
  $fr->Label(-text => __('TEXDIR (the main TeX directory)'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $texdirtext = $fr->Label(-anchor => 'w')->grid(-row => $row, -column => 2, -padx => "2m");
  if (!$vars{'in_place'}) {
    if ($::alternative_selector) {
      $texdir_toggle_button = $fr->Button(-text => __("Change"), -command => sub { menu_edit_texdir("TEXDIR"); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
    } else {
      $texdir_toggle_button = $fr->Button(-text => __("Change"), -command => sub { menu_edit_vars_value("TEXDIR"); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
    }
  }


  $row++;
  # texmflocal line
  $fr->Label(-text => __('TEXMFLOCAL (directory for site-wide local files)'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $texmflocaltext = $fr->Label(-anchor => 'w')->grid(-row => $row, -column => 2, -padx => "2m");
  $tmflocalbutton = $fr->Button(-text => __("Change"), -command => sub { menu_edit_vars_value("TEXMFLOCAL"); });
  $tmflocalbutton -> grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  $row++;
  # texmfsysvar line
  $fr->Label(-text => __('TEXMFSYSVAR (directory for autogenerated data)'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $texmfsysvartext = $fr->Label(-anchor => 'w')->grid(-row => $row, -column => 2, -padx => "2m");
  $tmfsysvarbutton = $fr->Button(-text => __("Change"), -command => sub { menu_edit_vars_value("TEXMFSYSVAR"); });
  $tmfsysvarbutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  $row++;
  # texmfsysconfig line
  $fr->Label(-text => __('TEXMFSYSCONFIG (directory for local config)'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $texmfsysconfigtext = $fr->Label(-anchor => 'w')->grid(-row => $row, -column => 2, -padx => "2m");
  $tmfsysconfigbutton = $fr->Button(-text => __("Change"), -command => sub { menu_edit_vars_value("TEXMFSYSCONFIG"); });
  $tmfsysconfigbutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  $row++;
  # texmfhome line
  $fr->Label(-text => __('TEXMFHOME (directory for user-specific files)'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $texmfhometext = $fr->Label(-anchor => 'w')->grid(-row => $row, -column => 2, -padx => "2m");
  $tmfhomebutton = $fr->Button(-text => __("Change"), -command => sub { menu_edit_vars_value("TEXMFHOME"); });
  $tmfhomebutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  if ($vars{'portable'}) {
    for my $b ($tmflocalbutton, $tmfsysvarbutton, $tmfsysconfigbutton, $tmfhomebutton) {
      $b->configure(-state => 'disabled')
    }
  }

  $row++;
  # Options
  $fr->Label(-text => "------- " . __("Options") . " -------")->grid(-row => $row, -column => 1, -columnspan => 3);

  $row++;
  # optpaper
  $fr->Label(-text => __('Default paper size'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $fr->Label(-anchor => 'w', -textvariable => \$letteryesno)->grid(-row => $row, -column => 2, -padx => "2m");
  $paper_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_letter'}, \$letteryesno, \@::letterdesc); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  $row++;
  $fr->Label(-text => __('Allow execution of restricted list of programs via \write18'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $fr->Label(-anchor => 'w', -textvariable => \$restrictedyesno)->grid(-row => $row, -column => 2, -padx => "2m");
  $write_eighteen_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_write18_restricted'}, \$restrictedyesno); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  $row++;
  $fr->Label(-text => __('Create all format files'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $fr->Label(-anchor => 'w', -textvariable => \$fmtyesno)->grid(-row => $row, -column => 2, -padx => "2m");
  $format_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_fmt'}, \$fmtyesno); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  if ($vars{'doc_splitting_supported'} and !$vars{'in_place'}) {
    $row++;
    $fr->Label(-text => __('Install font/macro doc tree'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->Label(-anchor => 'w', -textvariable => \$docyesno)->grid(-row => $row, -column => 2, -padx => "2m");
    $doc_files_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_doc'}, \$docyesno); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
  }

  if ($vars{'src_splitting_supported'} and !$vars{'in_place'}) {
    $row++;
    $fr->Label(-text => __('Install font/macro source tree'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->Label(-anchor => 'w', -textvariable => \$srcyesno)->grid(-row => $row, -column => 2, -padx => "2m");
    $src_files_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_src'}, \$srcyesno); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
  }

  $row++;
  $fr->Label(-text => (win32()) ? __('Adjust PATH setting in registry') :
                                 __('Create symlinks in system directories'),
             -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
  $fr->Label(-anchor => 'w', -textvariable => \$pathadjyesno)->grid(-row => $row, -column => 2, -padx => "2m");
  if (unix()) {
    $pathbutton = $fr->Button(-text => __("Change"), -command => sub { menu_select_symlink(); });
  } else {
    $pathbutton = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_path'}, \$pathadjyesno); });
  }
  $pathbutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

  if ($::opt_all_options || win32()) {
    $row++;
    $fr->Label(-text => __('Add menu shortcuts'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->Label(-anchor => 'w', -textvariable => \$deskintyesno)->grid(-row => $row, -column => 2, -padx => "2m");
    $deskintbutton = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_desktop_integration'}, \$deskintyesno); });
    $deskintbutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

    $row++;
    $fr->Label(-text => __('Change file associations'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->Label(-anchor => 'w', -textvariable => \$fileassocyesno)->grid(-row => $row, -column => 2, -padx => "2m");
    $assocbutton = $fr->Button(-text => __("Change"), -command => sub { menu_edit_file_assocs(); });
    $assocbutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");

    if ($::opt_all_options || admin()) {
      $row++;
      $fr->Label(-text => __('Installation for all users'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
      $fr->Label(-anchor => 'w', -textvariable => \$adminallyesno)->grid(-row => $row, -column => 2, -padx => "2m");
      $adminbutton = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_w32_multi_user'}, \$adminallyesno); });
      $adminbutton->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
    }

    $row++;
    $fr->Label(-text => __('Install TeXworks front end'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->Label(-anchor => 'w', -textvariable => \$editoryesno)->grid(-row => $row, -column => 2, -padx => "2m");
    if (!$vars{'in_place'}) {
      $texworks_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'collection-texworks'}, \$editoryesno); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
    }
  }
  if ($media ne 'NET') {
    $row++;
    $fr->Label(-text => __('After installation, get package updates from CTAN'), -anchor => 'w')->grid(-row => $row, -column => 1, -sticky => 'w');
    $fr->Label(-anchor => 'w', -textvariable => \$adjustrepoyesno)->grid(-row => $row, -column => 2, -padx => "2m");
    $adjustrepo_toggle_button = $fr->Button(-text => __("Toggle"), -command => sub { toggle_and_set_opt_variable(\$vars{'option_adjustrepo'}, \$adjustrepoyesno); })->grid(-row => $row, -column => 3, -sticky => "ew", -padx => "2m");
  }

  if ($vars{'portable'}) {
    for $b ($pathbutton, $deskintbutton, $assocbutton, $adminbutton) {
      $b->configure(-state => 'disabled') if $b;
    }
  }

  # install/cancel buttons
  my $f3 = $fr->Frame;
  $installbutton = $f3->Button(
    -text    => __("Install TeX Live"),
    -command => sub { installation_window(); });
  $installbutton->pack(-side => 'left', -padx => "2m", -pady => "2m")->focus();
  my $quitbutton = $f3->Button(
    -text    => __("Quit"),
    -command => \&menu_abort,
  )->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $mw->bind('<Escape>', [ $quitbutton, 'Invoke' ]);
  #my $wizardbutton = $f3->Button(
  #  -text    => __("Wizard"),
  #  -command => sub {
  #     $mainwindow->destroy;
  #     require("installer/install-menu-wizard.pl");
  #     setup_hooks_wizard();
  #     $return = run_menu_wizard();
  #   })->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $row++;
  $f3->grid(-row => $row, -column => 1, -columnspan => 3);
  if (!$::opt_select_repository) {
    menu_update_texts();
  } else {
    disable_buttons();
  }
  $fr->gridColumnconfigure(2, -minsize => 300);
  $mw->pack(-expand => 1, -fill => "both");
  $mw->update;
  my $rh = $mw->reqheight;
  my $rw = $mw->reqwidth;
  my $maxheight = $mainwindow->screenheight() - 20;
  debug("Requested height: $rh, requested width: $rw, max height: $maxheight\n");
  if ($rh > $maxheight) {
    $rh = $maxheight;
    $rw += 20; # for the scrollbar =  =
  }
  $subframe->configure(-height => $rh, -width=>$rw);
  $subframe->pack(-expand => 1, -fill => "both");
  $mainwindow->configure(-height => $rh, -width=>$rw);
  #$mw->pack(-expand => 1, -fill => "both");

  pre_warn($mainwindow) if win32();

  Tk::MainLoop();
  return($return);
}

sub pre_warn() {
  my $parent = shift;
  require TeXLive::TLWinGoo;
  my $pre_warning = $parent->Toplevel();
  $pre_warning->title(
    __("TeX Live %s Installation", $TeXLive::TLConfig::ReleaseYear));
  my $wrn = __('Best to disable your virus scanner during installation.');

  if (!admin()) {
    $wrn .= "\n\n".
      __("The installer does not have adminstrative permissions;\nso can only install for current user.");
    if (is_vista()) {
      $wrn .= "\n\n".
      __("Right-click install-tl-advanced and select \"run as administrator\"\n if you want to install for all users.");
    }
  }
  $pre_warning->Label(-textvariable=>\$wrn, -justify=>'left')->pack();
  my $sf = $pre_warning->Frame;
  $sf->Button(-text=>__('Quit'), -command=>sub{exit()})->pack(-side=>'left');
  $sf->Button(-text=>__('Continue'), -command=>sub{
    $parent->deiconify();
    $parent->raise;
    $pre_warning->withdraw();
  })->pack(-side=>'right');
  $sf->pack(-fill => 'x');
}

sub installation_window {
  # create a progress bar window
  $::sww = $mainwindow->Toplevel(-title => __("Installation process"),
                                 -width => 400);
  $::sww->transient($mainwindow);
  $::sww->grab();
  $::sww->Label(-text => __("Installation process"))->pack;
  $::progressw = $::sww->Scrolled("ROText", -scrollbars => "e", -height => 16);
  $::progressw->pack(-expand => 1, -fill => "both");
  my $percent_done = 0;
  $::progress = $::sww->ProgressBar(-variable => \$percent_done,
    -width => 20, -length => 400, -from => 0, -to => 100, -blocks => 10,
    -colors => [ 0, '#0078b8' ]);
  $::progress->pack(-fill => "x");
  my $f = $::sww->Frame;
  my $b = $f->Button(-text => __("Cancel"),
                     -command => sub { $::sww->destroy; $mainwindow->destroy;
                                       do_cleanup(); exit(1); }
                    )->pack(-pady => "2m");
  $b->focus();
  $f->pack;
  do_installation();
  $return = $MENU_ALREADYDONE;
  my $t = __("See %s/index.html for links to documentation.\nThe TeX Live web site (http://tug.org/texlive/) contains any updates and corrections. TeX Live is a joint project of the TeX user groups around the world; please consider supporting it by joining the group best for you. The list of groups is available on the web at http://tug.org/usergroups.html.", $::vars{'TEXDIR'});
  if (!win32()) {
    $t .= "\n\n" . __("Add %s/texmf-dist/doc/man to MANPATH.\nAdd %s/texmf-dist/doc/info to INFOPATH.\nMost importantly, add %s/bin/%s\nto your PATH for current and future sessions.", $::vars{'TEXDIR'}, $::vars{'TEXDIR'}, $::vars{'TEXDIR'}, $::vars{'this_platform'});
  }
  if (@::WARNLINES) {
    $t .= "\n\n" . __("There were some warnings during the installation process.\nHere is the list of warning messages:") . "\n";
    $t .= join('', @::WARNLINES);
    $t =~ s/\n\z//;
  }

  $t .= "\n\n" . __("Welcome to TeX Live!");
  #$t =~ s/\\n/\n/g;
  $::progressw->insert("end", "\n");
  my $linechar = $::progressw->index("end");
  $::progressw->markSet("finaltext", $linechar);
  $::progressw->markGravity("finaltext", "left");
  $::progressw->insert("end", "\n$t");
  $::progressw->see("end");
  $::progressw->tagAdd("centered", $linechar, "end");
  $::progressw->tagConfigure("centered", -justify => "center");
  $b->configure(-text => __("Finish"),
                -command => sub { $mainwindow->destroy; });
}

# this sub will not be called if $vars{'in_place'}
sub menu_edit_texdir {
  my $key = shift;
  our $addyear = 1;
  our $addtexlive = 1;
  my $val = $vars{$key};
  our $currsel;
  our $entry;
  sub update_label {
    my $t = $currsel;
    $t .= "/texlive" if ($addtexlive);
    $t .= "/$texlive_release" if ($addyear);
    $entry->configure(-text => "$t");
  }
  my $hint_var;
  if ($key ne 'TEXMFHOME') {
    $hint_var = win32() ? $ENV{'USERPROFILE'} : $ENV{'HOME'};
  } else {
    $hint_var = win32() ? '%USERPROFILE%' : '$HOME';
  }
  if ($val =~ m!^(.*)/texlive/$texlive_release$!) {
    $currsel = "$1";
    $addyear = 1;
    $addtexlive = 1;
  } elsif ($val =~ m!^(.*)/$texlive_release$!) {
    $currsel = "$1";
    $addyear = 1;
    $addtexlive = 0;
  } elsif ($val =~ m!^(.*)/texlive$!) {
    $currsel = "$1";
    $addyear = 0;
    $addtexlive = 1;
  } else {
    $addyear = 0;
    $addtexlive = 0;
    $currsel = $val;
  }
  my $sw = $mainwindow->Toplevel(-title => __("Change variable value"));
  $sw->transient($mainwindow);
  $sw->grab();
  $sw->Label(-text =>  __("Enter path for %s (use ~ for %s)", $key, $hint_var))->pack(-padx => "2m", -pady => "2m");
  $entry = $sw->Entry(-width => 60)->pack(-padx => "2m", -pady => "2m");
  my $f = $sw->Frame;
  my $c1 = $f->Checkbutton(-text => 'Add "texlive"', -variable => \$addtexlive,
    -command => \&update_label);
  my $c2 = $f->Checkbutton(-text => "Add \"$texlive_release\"", -variable => \$addyear,
    -command => \&update_label);
  my $foo = $sw->Scrolled("DirTree", -scrollbars => "osoe",
                          -browsecmd => sub { my ($d) = @_; $currsel = $d; update_label(); },
                          -directory => "$currsel");
  my $ff = $sw->Frame;
  my $ok = $ff->Button(-text => __("Ok"), -command => sub { $val = $entry->get; callback_edit_directories($key,$val); $sw->destroy; });
  my $cancel = $ff->Button(-text => __("Cancel"), -command => sub { $sw->destroy; });
  update_label();
  $c1->pack(-side => "left",  -padx => "2m", -pady => "2m");
  $c2->pack(-side => "right", -padx => "2m", -pady => "2m");
  $f->pack;
  $foo->pack(-fill => "both", -expand => 1);
  $ok->pack(-side => 'left' , -padx => "2m", -pady => "2m");
  $cancel->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $ff->pack;
  # bindings
  $sw->bind('<Return>' => [ $ok, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancel, 'Invoke']);
}

sub menu_edit_vars_value {
  my $key = shift;
  my $sw = $mainwindow->Toplevel(-title => __("Change variable value"));
  $sw->transient($mainwindow);
  $sw->grab();
  my $val = $vars{$key};
  my $hint_var;
  if ($key ne 'TEXMFHOME') {
    $hint_var = win32() ? $ENV{'USERPROFILE'} : $ENV{'HOME'};
  } else {
    $hint_var = win32() ? '%USERPROFILE%' : '$HOME';
  }
  $sw->Label(-text => __("Enter path for %s (use ~ for %s)", $key, $hint_var))->pack(-padx => "2m", -pady => "2m");
  my $entry = $sw->Entry(-text => native_slashify($val), -width => 60);
  $entry->pack(-padx => "2m", -pady => "2m")->focus();
  my $f = $sw->Frame;
  my $okbutton = $f->Button(-text => __("Ok"),
     -command => sub { $val = forward_slashify($entry->get); callback_edit_directories($key,$val) ; $sw->destroy })->pack(-side => 'left', -padx => "2m", -pady => "2m");
  my $cancelbutton = $f->Button(-text => __("Cancel"),
     -command => sub { $sw->destroy })->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $f->pack(-expand => 'x');
  # bindings
  $sw->bind('<Return>' => [ $okbutton, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancelbutton, 'Invoke']);
}

sub menu_edit_file_assocs {
  my $sw = $mainwindow->Toplevel(-title => __('Change file associations'));
  $sw->transient($mainwindow);
  $sw->grab();
  my $key = 'option_file_assocs';
  my $var = $::fileassocdesc[$vars{$key}];
  $sw->Label(-text => __("Change file associations"))->pack(-padx => "2m", -pady => "2m");
  my $opt = $sw->BrowseEntry(-autolistwidth => 1,
                             -variable => \$var);
  for my $i (0..2) {
    $opt->insert("end", $::fileassocdesc[$i]);
  }

  $opt->pack(-padx => "2m", -pady => "2m")->focus();
  my $f = $sw->Frame;
  my $okbutton = $f->Button(-text => __("Ok"),
    -command => sub {
                      my $idx;
                      if ($var eq $::fileassocdesc[0]) {
                        $idx = 0;
                      } elsif ($var eq $::fileassocdesc[1]) {
                        $idx = 1;
                      } elsif ($var eq $::fileassocdesc[2]) {
                        $idx = 2;
                      } else {
                        die "How that could happen!\n";
                      }
                      $vars{$key} = $idx;
                      $fileassocyesno = $::fileassocdesc[$idx];
                      $sw->destroy; })->pack(-side => "left", -padx => "2m", -pady => "2m");
  my $cancelbutton = $f->Button(-text => __("Cancel"), -command => sub { $sw->destroy; })->pack(-side => "left", -padx => "2m", -pady => "2m");
  $f->pack;
  $sw->bind('<Return>', [ $okbutton, 'Invoke' ]);
  $sw->bind('<Escape>', [ $cancelbutton, 'Invoke' ]);
}


sub menu_select_scheme {
  my $sw = $mainwindow->Toplevel(-title => __('Selected scheme'));
  $sw->transient($mainwindow);
  $sw->grab();
  my @schemes;
  foreach my $pkg ($tlpdb->list_packages) {
    my $tlpobj = $tlpdb->{'tlps'}{$pkg};
    if ($tlpobj->category eq "Scheme") {
      push @schemes, $pkg;
      $vars{"$pkg"}=($vars{'selected_scheme'} eq $pkg)? 1:0;
    }
  }
  my @scheme_order = schemes_ordered_for_presentation();
  push @scheme_order, "scheme-custom";
  my $selected = $vars{'selected_scheme'};
  $sw->Label(-text => __("Selected scheme"))->pack(-padx => "2m", -pady => "2m");
  my $f2 = $sw->Frame;
  foreach my $scheme (@scheme_order) {
    my $desc;
    if ($scheme ne "scheme-custom") {
      my $tlpobj = $tlpdb->get_package("$scheme");
      $desc = $tlpobj->shortdesc;
    } else {
      $desc = __("custom selection of collections");
    }
    my $b;
    $b = $f2->Radiobutton(-variable => \$selected, -value => $scheme,
      -text => __($desc), 
      -justify => 'left', -wraplength => 500)->pack(-anchor => 'w', -pady => "1m");
    if ($selected eq $scheme) {
      $b->focus();
    }
  }
  $f2->pack;
  my $f3 = $sw->Frame;
  my $okbutton = $f3->Button(-text => __("Ok"),
     -command => sub { callback_select_scheme($selected) ; $sw->destroy })->pack(-side => 'left', -padx => "2m", -pady => "2m");
  my $cancelbutton = $f3->Button(-text => __("Cancel"),
     -command => sub { $sw->destroy })->pack(-side => 'left', -padx => "2m", -pady => "2m");
  $f3->pack(-expand => 'x');
  $sw->bind('<Return>' => [ $okbutton, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancelbutton, 'Invoke']);
}

sub menu_select_standard_collections {
  my $sw = $mainwindow->Toplevel(-title => __('Installation collections'));
  $sw->transient($mainwindow);
  $sw->grab();
  my $fb = $sw->Frame;
  my $fc = $sw->Frame;
  my $fd = $sw->Frame;
  my $f1 = $fb->Frame;
  my $f2 = $fb->Frame;
  my %lvars = %vars;
  $sw->Label(-text => __("Select the collections to be installed"))->pack(-padx => "2m", -pady => "2m");
  my $halfcol = $#collections_std / 2;
  my $i = 0;
  foreach my $coll (sort @collections_std) {
    my $tlpobj = $tlpdb->get_package("$coll");
    if ($i < $halfcol) {
      $f1->Checkbutton(-variable => \$lvars{$coll}, -text => __($tlpobj->shortdesc))->pack(-anchor => 'w');
    } else {
      $f2->Checkbutton(-variable => \$lvars{$coll}, -text => __($tlpobj->shortdesc))->pack(-anchor => 'w');
    }
    $i++;
  }
  $f1->pack(-side => 'left', -padx => "2m", -pady => "2m");
  $f2->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $fb->pack(-padx => "2m", -pady => "2m");
  $fc->pack();
  $fc->Button(-text => __("Select All"),
    -command => sub { select_collections(\%lvars, @collections_std) })->pack(-side => 'left', -padx => "2m", -pady => "2m")->focus();
  $fc->Button(-text => __("Deselect All"),
    -command => sub { deselect_collections(\%lvars, @collections_std) })->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $fd->pack(-expand => 'x', -padx => "2m", -pady => "2m");
  my $okbutton = $fd->Button(-text => __("Ok"),
    -command => sub {
      # we call the update only if something has changed
      my $changed = 0;
      for my $k (keys %lvars) {
        if ($vars{$k} ne $lvars{$k}) {
          $changed = 1;
          last;
        }
      }
      if ($changed) {
        %vars = %lvars;
        callback_select_collection();
      }
      $sw->destroy;
    })->pack(-side => 'left', -padx => "2m", -pady => "2m");
  my $cancelbutton = $fd->Button(-text => __("Cancel"),
     -command => sub { $sw->destroy })->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $sw->bind('<Return>' => [ $okbutton, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancelbutton, 'Invoke']);
}

sub menu_select_symlink {
  our ($lbin,$lman,$linfo);
  our $osym = $vars{'option_path'};
  our ($binlab,$binb,$manlab,$manb,$infolab,$infob);
  sub set_unset_buttons {
    $lbin = ($osym ? $vars{'option_sys_bin'} : '');
    $linfo = ($osym ? $vars{'option_sys_info'} : '');
    $lman = ($osym ? $vars{'option_sys_man'} : '');
    if ($osym) {
      $binb->configure (-state => 'normal');
      $manb->configure (-state => 'normal');
      $infob->configure(-state => 'normal');
    } else {
      $infob->configure(-state => 'disabled');
      $manb->configure (-state => 'disabled');
      $binb->configure (-state => 'disabled');
    }
  }
  sub return_callback {
    if ($osym) {
      my $home = getenv('HOME');
      $home = getenv('USERPROFILE') if (win32());
      $home ||= '~';
      $lbin =~ s/^~/$home/;
      $linfo =~ s/^~/$home/;
      $lman =~ s/^~/$home/;
      $vars{'option_sys_bin'} = $lbin;
      $vars{'option_sys_info'} = $linfo;
      $vars{'option_sys_man'} = $lman;
    }
    $vars{'option_path'} = $osym;
    toggle_and_set_opt_variable(\$vars{'option_path'}, \$pathadjyesno);
  }
  my $sw = $mainwindow->Toplevel(-title => __('Create symlinks in system directories'));
  $sw->transient($mainwindow);
  $sw->grab();
  $sw->Checkbutton(-variable => \$osym,
                   -text => __("create symlinks in standard directories"),
		   -command => sub { set_unset_buttons(); } )->grid(-column => 1,
                                                        -row => 1,
                                                        -columnspan => 2,
                                                        -padx => "2m");
  $binlab = $sw->Label(-text => __("binaries to"));
  $binb = $sw->Entry(-textvariable => \$lbin);
  $manlab = $sw->Label(-text => __("manpages to"));
  $manb = $sw->Entry(-textvariable => \$lman);
  $infolab = $sw->Label(-text => __("info to"));
  $infob = $sw->Entry(-textvariable => \$linfo);
  $binlab->grid(-row => 2, -column => 1, -sticky => "w", -padx => "2m");
  $binb->grid(-row => 2, -column => 2, -sticky => "ew", -padx => "2m");
  $manlab->grid(-row => 3, -column => 1, -sticky => "w", -padx => "2m");
  $manb->grid(-row => 3, -column => 2, -sticky => "ew", -padx => "2m");
  $infolab->grid(-row => 4, -column => 1, -sticky => "w", -padx => "2m");
  $infob->grid(-row => 4, -column => 2, -sticky => "ew", -padx => "2m");
  set_unset_buttons();
  my $f2 = $sw->Frame; $f2->grid(-column => 1, -columnspan => 2, -row => 5);
  my $okbutton = $f2->Button(-text => __("Ok"),
     -command => sub { return_callback(); $sw->destroy })->pack(-side => 'left');
  my $cancelbutton = $f2->Button(-text => __("Cancel"),
     -command => sub { $sw->destroy })->pack(-side => 'right');
  $sw->bind('<Return>' => [ $okbutton, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancelbutton, 'Invoke']);
}

sub menu_select_binsystems {
  my $f2r;
  my $f2;
  my $sw = $mainwindow->Toplevel(-title => __('Binary system(s)'));
  $sw->transient($mainwindow);
  $sw->grab();
  my @diskarchs = ();
  foreach my $key (keys %vars) {
    if ($key=~/binary_(.*)/) {
      push @diskarchs, $1;
    }
  }
  $sw->Label(-text => __("Select arch-os"))->pack(-padx => "2m", -pady => "2m");
  $f2 = $sw->Frame;
  my $f2l = $f2->Frame;
  foreach my $sys (sort @diskarchs) {
    $f2l->Checkbutton(-variable => \$vars{"binary_$sys"}, 
      -command => sub { check_on_removal($sw, $sys); },
      -text => platform_desc($sys))->pack(-anchor => 'w');
  }
  $f2l->pack(-side => 'left');
  $f2->pack(-padx => "2m", -pady => "2m");
  my $f3 = $sw->Frame;
  my $okbutton = $f3->Button(-text => __("Ok"),
     -command => sub { callback_select_systems() ; $sw->destroy })->pack(-side => 'left', -padx => "2m", -pady => "2m");
  my $cancelbutton = $f3->Button(-text => __("Cancel"),
     -command => sub { $sw->destroy })->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $f3->pack(-expand => 'x');
  $sw->bind('<Return>' => [ $okbutton, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancelbutton, 'Invoke']);
}

sub check_on_removal {
  my $arch_frame = shift;
  my $a = shift;
  if (!$vars{"binary_$a"} && $a eq $vars{'this_platform'}) {
    # removal not supported
    $vars{"binary_$a"} = 1;
    $arch_frame->Dialog(-title => __("Warning"),
                        -text => __("Removals of the main platform not possible!"),
                        -buttons => [ __("Ok") ])->Show;
  }
}


sub menu_set_text {
  my $w = shift;
  my $t = shift;
  # if in_place or portable not a complete interface
  $w->configure(-text => $t, @_) if $w;
}

sub menu_set_schemebutton_text {
  menu_set_text($schemebutton, "$vars{'selected_scheme'}");
}

sub menu_set_binbutton_text {
  if (!win32()) {
    if ($vars{'n_systems_selected'} == 1) {
      my $selsys;
      foreach my $key (keys %vars) {
        if ($key=~/binary_(.*)/) {
          if ($vars{$key}) {
            $selsys = $1;
            # we have only one system selected, stop here
            last;
          }
        }
      }
      menu_set_text($bintextbutton, $selsys);
    } else {
      menu_set_text($bintextbutton, __("%s out of %s", $vars{'n_systems_selected'}, $vars{'n_systems_available'}));
    }
  }
}

sub menu_set_collections_text {
  menu_set_text($collectionstext, __("%s collections out of %s",
          $vars{'n_collections_selected'}, $vars{'n_collections_available'})
      .  " (" . __("disk space required:") . " $vars{'total_size'} MB)");
}

sub menu_set_pathes_text {
  if (TeXLive::TLUtils::texdir_check($vars{'TEXDIR'})) {
    menu_set_text($texdirtext, native_slashify($vars{'TEXDIR'}), -foreground => "black");
  } else {
    menu_set_text($texdirtext, __("(default not allowed or not writable - please change!)"), -foreground => "red");
  }
  menu_set_text($texmflocaltext, native_slashify($vars{'TEXMFLOCAL'}));
  if ((-w $vars{'TEXMFSYSVAR'}) || (-w dirname($vars{'TEXMFSYSVAR'}))) {
    menu_set_text($texmfsysvartext, native_slashify($vars{'TEXMFSYSVAR'}), -foreground => "black");
  } elsif ("$vars{'TEXMFSYSVAR'}" =~ m;^$vars{'TEXDIR'};) {
    if (TeXLive::TLUtils::texdir_check($vars{'TEXDIR'})) {
      menu_set_text($texmfsysvartext, native_slashify($vars{'TEXMFSYSVAR'}), -foreground => "black");
    } else {
      menu_set_text($texmfsysvartext, __("(please change TEXDIR first!)"), -foreground => "red");
    }
  } else {
    menu_set_text($texmfsysvartext, __("(default not writable - please change!)"));
  }
  if ((-w $vars{'TEXMFSYSCONFIG'}) || (-w dirname($vars{'TEXMFSYSCONFIG'}))) {
    menu_set_text($texmfsysconfigtext, native_slashify($vars{'TEXMFSYSCONFIG'}), -foreground => "black");
  } elsif ("$vars{'TEXMFSYSCONFIG'}" =~ m;^$vars{'TEXDIR'};) {
    if (TeXLive::TLUtils::texdir_check($vars{'TEXDIR'})) {
      menu_set_text($texmfsysconfigtext, native_slashify($vars{'TEXMFSYSCONFIG'}), -foreground => "black");
    } else {
      menu_set_text($texmfsysconfigtext, __("(please change TEXDIR first!)"), -foreground => "red");
    }
  } else {
    menu_set_text($texmfsysconfigtext, __("(default not writable - please change!)"));
  }
  menu_set_text($texmfhometext, native_slashify($vars{'TEXMFHOME'}));
}


sub menu_update_texts {
  menu_set_pathes_text;
  menu_set_collections_text;
  menu_set_binbutton_text;
  menu_set_schemebutton_text;
  $optletterstate = $::letterdesc[$vars{'option_letter'}];
  $optfmtstate = ($vars{'option_fmt'} ? __("Yes") : __("No"));
  $optsrcstate = ($vars{'option_src'} ? __("Yes") : __("No"));
  $optdocstate = ($vars{'option_doc'} ? __("Yes") : __("No"));
}

sub callback_select_scheme {
  my $s = shift;
  select_scheme($s);
  $editoryesno = ($vars{'collection-texworks'} ? __("Yes") : __("No"));
  menu_update_texts();
}

sub callback_select_collection {
  # special case for collection-texworks:
  $editoryesno = ($vars{'collection-texworks'} ? __("Yes") : __("No"));
  calc_depends();
  select_scheme("scheme-custom");
  update_numbers();
  menu_update_texts();
}

sub callback_select_systems() {
  if ($vars{"binary_win32"}) {
    $vars{"collection-wintools"} = 1;
  } else {
    $vars{"collection-wintools"} = 0;
  }
  calc_depends();
  update_numbers();
  menu_update_texts();
}

sub callback_edit_directories {
  my ($key,$val) = @_;
  my $home = getenv('HOME');
  if (win32()) {
    $home = getenv('USERPROFILE');
    $home =~ s!\\!/!g;
  }
  $home ||= '~';
  $val =~ s!\\!/!g;
  $vars{$key} = $val;
  $vars{'TEXDIR'} =~ s/^~/$home/;
  $vars{'TEXMFLOCAL'} =~ s/^~/$home/;
  $vars{'TEXMFSYSVAR'} =~ s/^~/$home/;
  $vars{'TEXMFSYSCONFIG'} =~ s/^~/$home/;
  # only if we set TEXDIR we set the others in parallel
  my $texdirnoslash;
  if ($key eq "TEXDIR") {
    if ($vars{'TEXDIR'}=~/^(.*)\/$texlive_release$/) {
      $texdirnoslash = $1;
      $vars{'TEXMFLOCAL'}="$texdirnoslash/texmf-local";
      $vars{'TEXMFSYSVAR'}="$texdirnoslash/$texlive_release/texmf-var";
      $vars{'TEXMFSYSCONFIG'}="$texdirnoslash/$texlive_release/texmf-config";
    } elsif ($vars{'TEXDIR'}=~/^(.*)$/) {
      $texdirnoslash = $1;
      $texdirnoslash =~ s!/$!!;
      $vars{'TEXMFLOCAL'}="$texdirnoslash/texmf-local";
      $vars{'TEXMFSYSVAR'}="$texdirnoslash/texmf-var";
      $vars{'TEXMFSYSCONFIG'}="$texdirnoslash/texmf-config";
    }
  }
  menu_update_texts();
}

sub  callback_edit_var() {
  my ($key,$val) = @_;
  $vars{$key} = $val;
  menu_update_texts();
}

sub dump_vars_stdout {
  foreach my $k (keys %vars) {
    print "DEBUG: vars{$k} = $vars{$k}\n";
  }
}

sub toggle_portable {
  my $td = $vars{'TEXDIR'};
  my $b;
  if ($vars{'portable'}) {
    $vars{'portable'} = 0;
    $portableyesno = __('No');
    # enable some buttons
    for $b ($tmflocalbutton, $tmfsysvarbutton, $tmfsysconfigbutton, $tmfhomebutton) {
      $b->configure(-state => 'normal');
    }
    for $b ($pathbutton, $deskintbutton, $assocbutton, $adminbutton) {
      $b->configure(-state => 'normal') if $b;
    }
  } else {
    $vars{'portable'} = 1;
    $portableyesno = __('Yes');
    # disable some buttons. These should get a name first.
    for $b ($tmflocalbutton, $tmfsysvarbutton, $tmfsysconfigbutton, $tmfhomebutton) {
      $b->configure(-state => 'disabled');
    }
    $vars{'option_path'} = 0;
    $vars{'option_desktop_integration'} = 0;
    $vars{'option_file_assocs'} = 0;
    $vars{'option_w32_multi_user'} = 0;
    $deskintyesno = __("No");
    $pathadjyesno = __("No");
    $fileassocyesno = __("None");
    $adminallyesno = __("No");
    for $b ($pathbutton, $deskintbutton, $assocbutton, $adminbutton) {
      $b->configure(-state => 'disabled') if $b;
    }
  }
  set_texlive_default_dirs(); # this sub tests for portable and in_place
  $mw -> messageBox(
    -title => __('Warning'),
    -message => __("Portable option changed;\nDirectories have been reinitialized"),
    -type => 'OK', -icon => 'warning');
  menu_set_pathes_text();
  # same for some options
}

sub toggle_and_set_opt_variable {
  my ($varsref, $toggleref, $choicesref) = @_;
  my ($no, $yes) = $choicesref ? @$choicesref : (__('No'), __('Yes'));
  $$toggleref = ($$toggleref eq $yes) ? $no : $yes;
  $$varsref = 0;
  $$varsref = 1 if ($$toggleref eq $yes);
  calc_depends();
  menu_update_texts();
}

1;

__END__

### Local Variables:
### perl-indent-level: 2
### tab-width: 2
### indent-tabs-mode: nil
### End:
# vim:set tabstop=2 expandtab: #
