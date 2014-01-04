#!/usr/bin/env perl
# $Id: install-menu-wizard.pl 30372 2013-05-10 17:49:37Z karl $
# Copyright 2009-2013 Norbert Preining
# This file is licensed under the GNU General Public License version 2
# or any later version.

use strict;
$^W = 1;

my $svnrev = '$Revision: 11925 $';
$svnrev =~ m/: ([0-9]+) /;
$::menurevision = $1;

#
# the following lists define which options are shown in the Option screen
# for unix and windows. On W32 with admin privileges both @w32 list options
# are shown
my @unix_opts = qw/letter/;
my @w32_opts = qw/letter desktop_integration/;
my @w32_admin_opts = qw/w32_multi_user/;

my @opts_list = ();
if (win32()) {
  push @opts_list, @w32_opts;
  if (admin()) {
    push @opts_list, @w32_admin_opts;
  }
} else {
  push @opts_list, @unix_opts;
}


our %vars;
our $tlpdb;
our $texlive_release;
our @media_available;

our $MENU_INSTALL = 0;
our $MENU_ABORT   = 1;
our $MENU_QUIT    = 2;
our $MENU_ALREADYDONE = 3;


my $return = $MENU_INSTALL;

require Tk;
require Tk::BrowseEntry;
require Tk::Dialog;
require Tk::DialogBox;
require Tk::PNG;
require Tk::ROText;
require Tk::ProgressBar;
require Tk::Font;

use utf8;
no utf8;

#
#
my $tit;
my $can;
my $prv;
my $nxt;
my $img;
my $dest;
my $dest_display;
my $warning;
my $mw;
my $usedfont;
my $fmain;
my $fbuttons;
my $ftitle;
my $counter;
my $lineskip;

$::init_remote_needed = 0;

my $LEFT = 130;
my $RIGHT = 50;
my $TOP  = 50;
my $BOTTOM = 50;
my $INF = 300;
my $MWIDTH = 730;
my $MHEIGHT = 480;
my $TITLEHEIGHT = 30;
my $BUTTONSHEIGHT = 50;
my $INNERWIDTH = ($MWIDTH - $LEFT - $RIGHT);
my $INNERHEIGHT = ($MHEIGHT - $TOP - $TITLEHEIGHT - $BOTTOM - $BUTTONSHEIGHT);

require("TeXLive/trans.pl");

# the main installer runs %{$::run_menu}
$::run_menu = \&run_menu_wizard;

######################################################################
# From here on only function definitions
# ####################################################################

sub menu_abort {
    $return = $MENU_ABORT;
    $mw->destroy;
}

sub setup_hooks_wizard {
  @::info_hook = ();
  push @::info_hook,
    sub {
      return unless defined($mw);
      wizard_update_status(join(" ",@_));
      $mw->update;
    };
  push @::warn_hook,
    sub {
      return unless defined($mw);
      wizard_update_status(join(" ",@_));
      $mw->update;
    };
  @::install_packages_hook = ();
  push @::install_packages_hook, \&wizard_update_progressbar;
  push @::install_packages_hook, sub { $mw->update; };
}

sub wizard_update_status {
  my ($p) = @_;
  return unless defined($::progressw);
  $::progressw->insert("end", "$p");
  $::progressw->see("end");
}
sub wizard_update_progressbar {
  my ($n,$total) = @_;
  if (defined($n) && defined($total)) {
    $::progress->value(int($n*100/$total));
  }
}

################# WELCOME SCREEN ######################################

sub run_menu_wizard {
  $mw = Tk::MainWindow->new(-width => $MWIDTH, -height => $MHEIGHT);
  $mw->protocol('WM_DELETE_WINDOW' => \&menu_abort);
  setup_hooks_wizard();

  my $img = $mw->Photo(-format => 'png', -file => "$::installerdir/tlpkg/installer/texlive.png");
  $mw->Label(-image => $img, -background => "#0078b8")->place(-x => 0, -y => 0);

  $ftitle = $mw->Frame(-height => $TITLEHEIGHT, -width => $INNERWIDTH);
  $ftitle->update;
  $ftitle->place(-x => $LEFT, -y => $TOP);

  $tit = $ftitle->Label(-text => __('TeX Live %s Installation', $TeXLive::TLConfig::ReleaseYear));

  $usedfont= $tit->cget("-font");
  $lineskip = $usedfont->metrics("-linespace");

  $tit->place(-x => 0, -y => 0);

  $counter = $ftitle->Label(-text => "1/5");
  $counter->place(-x => $INNERWIDTH, -y => 0, -anchor => "ne");

  $fmain = $mw->Frame(-height => $INNERHEIGHT, -width => $INNERWIDTH);
          #, -borderwidth => 1, -relief => "ridge");
  $fmain->place(-x => $LEFT, -y => ($TOP + $TITLEHEIGHT));


  $can = $mw->Button(-width => 10, -relief => "ridge", -text => __('Quit'),
               -command => \&menu_abort);
  $prv = $mw->Button(-width => 10, -relief => "ridge", -text => __('< Back'));
  $nxt = $mw->Button(-width => 10, -relief => "ridge", -text => __('Next >'));

  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");

  my $rb = $MWIDTH - $RIGHT;
  $nxt->place(-x => ($MWIDTH - $RIGHT) , 
              -y => ($MHEIGHT - $BOTTOM), -anchor => "se")->focus();

  reset_start();

  Tk::MainLoop();
  return($return);
}

sub reset_start {
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "1/5");
  $prv->placeForget;

  my $inf = $fmain->Label(
    -text => __("Welcome to the installation of TeX Live %s\nhttp://tug.org/texlive\n\nThis wizard will guide you through the installation.", $TeXLive::TLConfig::ReleaseYear)
      . ( (win32()) ? "\n\n" . __("Best to disable your virus scanner during installation.") : "" )
       . "\n\n"
       . __("For an advanced, customizable installation, please consult\nthe web pages or installation guide.")
      . "\n"
      . ( (win32())
          ? __("Or use install-tl-advanced.bat.")
          : __("Or specify  --gui expert  to install-tl.") ),
    -justify => "left");
  $inf->place(-x => 0, -y => 50);

  # by default, if local media is present, we don't show this option
  # unless the command line option -select_repository is given
  my $adjust_mirror = 0;
  if ($#media_available == -1 || $::opt_select_repository) {
    my $mirror_selector = $fmain->Checkbutton(
      -text => __("Change default repository"),
      -variable => \$adjust_mirror
    );
    $mirror_selector->place(-x => 0, -y => 250);
  }

  $nxt->configure(-text => __("Next >") , 
    -command => sub { 
      if ($adjust_mirror) {
        ask_mirror();
      } else {
        $::init_remote_needed = 1;
        load_remote_screen();
      }
    });
  $nxt->configure(-state => "normal");
  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");
}

################## MIRROR SCREEN ################################

sub ask_mirror {
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "1-1/5");

  my @mirror_list;
  my @netlst;
  my @loclst;
  if ($#media_available >= 0) {
    for my $l (@media_available) {
      my ($a, $b) = split ('#', $l);
      if ($a eq 'local_compressed' || $a eq 'local_uncompressed') {
        push @loclst, "  $b";
      } elsif ($a eq 'NET') {
        #push @netlst, "  cmd line repository: $b";
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

  $fmain->Label(-text => __("Select repository") . ":")->place(
    -x => 0, -y => 0);
  $fmain->Label(-text => __("Mirror:"))->place(-x => 0, -y => 50);
  $fmain->BrowseEntry(-state => 'readonly',
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
    -variable => \$mirror_entry)->place(-x => 150, -y => 50);
 
  $prv->configure(-text => __('< Back'), -command => \&reset_start );
  $nxt->configure(-text => __('Next >'), 
    -command => 
      sub { $::init_remote_needed = 1; load_remote_screen($mirror_entry); });

  my $rb = $MWIDTH - $RIGHT;
  $rb -= $nxt->width;
  $rb -= 30;

  $prv->place(-x => $rb, -y => ($MHEIGHT - $BOTTOM), -anchor => "se");
  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");
}

sub ask_mirror_hierarchical {
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "1-1/5");

  our $mirrors;
  require("installer/mirrors.pl");

  my @continents = sort keys %$mirrors;
  my @countries;
  my @mirrors;
  $fmain->Label(-text => "Select mirror for installation:")->place(
    -x => 0, -y => 0);
  my $continent = "";
  my $country = "";
  my $mirror = "";
  my $cbrowser;
  my $mbrowser;
  $fmain->Label(-text => __("Continent"))->place(-x => 0, -y => 50);
  $fmain->BrowseEntry(-state => 'readonly',
    -listheight => $#continents + 1, -choices => \@continents,
    -variable => \$continent,
    -browsecmd => 
      sub {
        $cbrowser->delete(0,"end");
        @countries = sort keys %{$mirrors->{$continent}};
        for my $c (@countries) {
          $cbrowser->insert("end", $c);
        }
        $mirror = "";
        $country = "";
      })->place(-x => 150, -y => 50);
  $fmain->Label(-text => __("Countries"))->place(-x => 0, -y => 100);
  $cbrowser = $fmain->BrowseEntry(-state => 'readonly',
    -listheight => 5, -choices => \@countries,
    -variable => \$country,
    -browsecmd => 
      sub {
        $mbrowser->delete(0,"end");
        @mirrors = sort keys %{$mirrors->{$continent}{$country}};
        for my $m (@mirrors) {
          $mbrowser->insert("end", $m);
        }
        # always select the first mirror in the list
        if ($#mirrors >= 0) {
          $mirror = $mirrors[0];
        } else {
          $mirror = "";
        }
      })->place(-x => 150, -y => 100);
  $fmain->Label(-text => __("Mirrors"))->place(-x => 0, -y => 150);
  $mbrowser = $fmain->BrowseEntry(-state => 'readonly',
    -listheight => 5, -choices => \@mirrors,
    -variable => \$mirror,)->place(-x => 150, -y => 150);
 
  $prv->configure(-text => __('< Back'), -command => \&reset_start );
  $nxt->configure(-text => __('Next >'), 
    -command => 
      sub {
        if (!defined($continent) || !defined($country) || !defined($mirror) ||
            $continent eq "" || $country eq "" || $mirror eq "") {
          # do nothing, we just use the default mirror
          $::init_remote_needed = 1;
          load_remote_screen();
        } else {
          my %m = %{$mirrors->{$continent}->{$country}->{$mirror}->{'protocols_path'}};
          my $mfull;
          $mfull = "ftp://" . $m{'ftp'} if defined($m{'ftp'});
          $mfull = "http://" . $m{'http'} if defined($m{'http'});
          # remove terminal / if present
          $mfull =~ s!/$!!;
          $mfull .= "/" . $TeXLive::TLConfig::TeXLiveServerPath;
          # set the selected location before going on!
          $::init_remote_needed = 1;
          load_remote_screen($mfull);
        }
      });

  my $rb = $MWIDTH - $RIGHT;
  $rb -= $nxt->width;
  $rb -= 30;

  $prv->place(-x => $rb, -y => ($MHEIGHT - $BOTTOM), -anchor => "se");
  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");
}


################## PATH SCREEN ################################

sub load_remote_screen {
  my $remote_path = shift;
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "1-2/5");

  if ($::init_remote_needed) {
    my $labela = $fmain->Label(-text => __('Please wait while the repository database is loaded.'))->place(-x => 0, -y => 50);
    my $labelb = $fmain->Label(-text => __('This will take some time!'))->place(-x => 0, -y => 150);
    $prv->placeForget;
    $can->placeForget;
    $nxt->configure(-text => __('Cancel'),
       -command => sub { $return = $MENU_ABORT; $mw->destroy; });
    $mw->update;
    if (!only_load_remote($remote_path)) {
      $labela->configure(-text => __('Could not load remote TeX Live Database:') . $remote_path);
      $labelb->configure(-text => __('Please go back and select a different mirror.'));
      $prv->configure(-text => __('< Back'), -command => \&reset_start );
    } elsif (!do_version_agree()) {
      $labela->configure(-text => __('The TeX Live versions of the local installation
and the repository being accessed are not compatible:
     local: %s
repository: %s', $TeXLive::TLConfig::ReleaseYear, $texlive_release));
      $labelb->configure(-text => __('Please go back and select a different mirror.'));
      $prv->configure(-text => __('< Back'), -command => \&reset_start );
    } else {
      final_remote_init($remote_path);
      ask_path();
    }
  } else {
    ask_path();
  }

  my $rb = $MWIDTH - $RIGHT;
  $rb -= $nxt->width;
  $rb -= 30;

  $prv->place(-x => $rb, -y => ($MHEIGHT - $BOTTOM), -anchor => "se");
  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");
}

sub ask_path {
  for ($fmain->children) {
    $_->destroy;
  }

  $counter->configure(-text => "2/5");

  $dest = $vars{'TEXDIR'};
  $dest_display = native_slashify($dest);

  my $lab = $fmain->Label(-text => __('Destination folder:'));
  my $val = $fmain->Label(-textvar => \$dest_display);
  my $but = $fmain->Button(-text => __("Change"), -command => \&change_path,
                           -relief => "ridge", -width => 10);

  # texworks will be anyway installed in scheme-full
  #my $but_tw = $fmain->Checkbutton(-text => __("Install TeXworks front end'),
  #                                -variable => \$vars{"addon_editor"});

  #
  # disable the "Advanced Configuration" button switching to the 
  # perltk installer
  #
  #my $cb = $fmain->Button(-text => __("Advanced Configuration"), 
  #       -relief => "ridge",
  #       -command => sub { $mw->destroy; 
  #                         require("installer/install-menu-perltk.pl");
  #                         setup_hooks_perltk();
  #                         $return = run_menu_perltk();
  #                       });

  calc_depends();


  $fmain->Label(-text => __("The destination folder will contain the installation.\nIt is strongly recommended to keep the year as the last component."), 
                -justify => "left")->place(-x => 0, -y => 20);

  my $ytmp = 100;
  $lab->place(-x => 0, -y => $ytmp, -anchor => "w");
  $ytmp += ($lineskip + 10);
  $val->place(-x => 0, -y => $ytmp, -anchor => "w");

  $but->place(-x => $INNERWIDTH, -y => $ytmp, -anchor => "e");

  $warning = $fmain->Label(-foreground => "red");
  check_show_warning();
  $ytmp += ($lineskip + 10);
  $warning->place(-x => 0, -y => $ytmp, -anchor => "w");


  #if (win32()) {
  #  $but_tw->place(-x => 0, -y => $ytmp + 60);
  #}

  #$cb->place(-x => $INNERWIDTH, -y => $INNERHEIGHT, -anchor => "se");

  $fmain->Label(-text => __('disk space required:') . " $vars{'total_size'} MB", 
                -justify => "left"
             )->place(-x => 0, -y => $fmain->height, -anchor => "sw");

  $prv->configure(-text => __('< Back'), -command => \&reset_start );
  $nxt->configure(-text => __('Next >'), -command => \&ask_options );

  my $rb = $MWIDTH - $RIGHT;
  $rb -= $nxt->width;
  $rb -= 30;

  $prv->place(-x => $rb, -y => ($MHEIGHT - $BOTTOM), -anchor => "se");
  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");
}

sub check_show_warning {
  if (TeXLive::TLUtils::texdir_check($vars{'TEXDIR'})) {
    $warning->configure(-text => "");
    $nxt->configure(-state => "normal");
  } else {
    $warning->configure(-text => __('(default not allowed or not writable - please change!)'));
    $nxt->configure(-state => "disabled");
  }
}
  
sub change_path {
  my $val = $dest;
  my $sw = $mw->Toplevel(-title => "Changing TEXDIR");
  $sw->transient($mw);
  $sw->grab();
  $sw->Label(-text => __('Enter path for') . " TEXDIR: ")->pack(-padx => "2m", -pady => "2m");
  my $entry = $sw->Entry(-text => native_slashify($val), -width => 60);
  $entry->pack(-padx => "2m", -pady => "2m")->focus();
  my $f = $sw->Frame;
  my $okbutton = $f->Button(-text => __('Ok'), -width => 10, 
     -relief => "ridge",
     -command => sub { $val = forward_slashify($entry->get); callback_change_texdir($val) ; $sw->destroy })->pack(-side => 'left', -padx => "2m", -pady => "2m");
  my $cancelbutton = $f->Button(-text => __('Cancel'), -relief => "ridge",
     -width => 10,
     -command => sub { $sw->destroy })->pack(-side => 'right', -padx => "2m", -pady => "2m");
  $f->pack(-expand => 'x');
  # bindings
  $sw->bind('<Return>' => [ $okbutton, 'Invoke']);
  $sw->bind('<Escape>' => [ $cancelbutton, 'Invoke']);
}

sub callback_change_texdir {
  my ($val) = @_;
  my $home = getenv('HOME');
  my $texdirnoslash;
  if (win32()) {
    $home = getenv('USERPROFILE');
    $home =~ s!\\!/!g;
  }
  $home ||= '~';
  $val =~ s!\\!/!g;
  $vars{'TEXDIR'} = $val;
  $vars{'TEXDIR'} =~ s/^~/$home/;
  $vars{'TEXMFLOCAL'} =~ s/^~/$home/;
  $vars{'TEXMFSYSVAR'} =~ s/^~/$home/;
  $vars{'TEXMFSYSCONFIG'} =~ s/^~/$home/;
  # only if we set TEXDIR we set the others in parallel
  if ($vars{'TEXDIR'}=~/^(.*)\/$texlive_release$/) {
    $vars{'TEXMFLOCAL'}="$1/texmf-local";
    $vars{'TEXMFSYSVAR'}="$1/$texlive_release/texmf-var";
    $vars{'TEXMFSYSCONFIG'}="$1/$texlive_release/texmf-config";
  } elsif ($vars{'TEXDIR'}=~/^(.*)$/) {
    $texdirnoslash = $1;
    $texdirnoslash =~ s!/$!!;
    $vars{'TEXMFLOCAL'}="$texdirnoslash/texmf-local";
    $vars{'TEXMFSYSVAR'}="$texdirnoslash/texmf-var";
    $vars{'TEXMFSYSCONFIG'}="$texdirnoslash/texmf-config";
  }
  $dest = $vars{'TEXDIR'};
  $dest_display = native_slashify($dest); # useful as -textvar value in Labels
  check_show_warning();
}

################## OPTIONS SCREEN ################################

my %opts_to_str = (
  "letter" => __("Default paper size"),
  "desktop_integration" => __("Add menu shortcuts"),
  "file_assocs" => __("Change file associations"),
  "path" => __("Adjust PATH setting in registry"),
  "w32_multi_user" => __("Installation for all users"),
);

# options choices: if there is an entry, use radio buttons,
# otherwise a checkbutton
my %opts_choices = (
  "letter" => ["A4", "letter"],
);

sub ask_options {
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "3/5");

  my $inf = $fmain->Label(-text => __("This screen allows you to configure some options"), -justify => "left");
  $inf->place(-x => 0, -y => 20);

#  my %opt_cb;
#
#  $opt_cb{"letter"} = $fmain->Checkbutton(
#                    -text => __("Use letter size instead of A4 by default"), 
#                    -variable => \$vars{"option_letter"});
#
#  $opt_cb{"desktop_integration"} = $fmain->Checkbutton(
#                    -text => __("Add shortcuts to menu and desktop"),
##                    -variable => \$vars{"option_desktop_integration"});
#
#  $opt_cb{"file_assocs"} = $fmain->Checkbutton(
#                    -text => __('Change file associations'), 
##                    -variable => \$vars{"option_file_assocs"});
#
#  $opt_cb{"path"} = $fmain->Checkbutton(
#                    -text => __('Adjust PATH setting in registry'), 
#                    -variable => \$vars{"option_path"});
#
#  $opt_cb{"w32_multi_user"} = $fmain->Checkbutton(
##                    -text => __('Installation for all users'), 
#                    -variable => \$vars{"option_w32_multi_user"});
#
  calc_depends();

  my $ytmp = 60;

  for my $o (@opts_list) {
    # $opt_cb{$o}->place(-x => 0, -y => $ytmp);
    if (exists($opts_choices{$o})) {
      my $fopt = $fmain->Frame()->place(-x => 0, -y => $ytmp);
      $fopt->Label(
        -text => $opts_to_str{$o} . ":\t"
      )->pack(-side => 'left');
      for (my $i = 0; $i < @{$opts_choices{$o}}; $i++) {
        $fopt->Radiobutton(
          -text => __($opts_choices{$o}->[$i]),
          -variable => \$vars{"option_$o"},
          -value => $i,
        )->pack(-side => 'left');
      }
    } else {
      $fmain->Checkbutton(-text => $opts_to_str{$o},
        -variable => \$vars{"option_$o"})->place(-x => 0, -y => $ytmp);
    }
    $ytmp += 50;
  }

  $prv->configure(-text => __('< Back'), -command => \&ask_path );
  $nxt->configure(-text => __('Next >'), -command => \&ask_go );

  my $rb = $MWIDTH - $RIGHT;
  $rb -= $nxt->width;
  $rb -= 30;

  $prv->place(-x => $rb, -y => ($MHEIGHT - $BOTTOM), -anchor => "se");
}


################## INSTALL SCREEN #############################

sub ask_go {
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "4/5");
  my $inf = $fmain->Label(-justify => "left", -text => __("We are ready to install TeX Live %s.\nThe following settings will be used.\nIf you want to change something please go back,\notherwise press the \"Install\" button.", $TeXLive::TLConfig::ReleaseYear));


  $inf->place(-x => 0, -y => 80);

  my $ytmp = 170;

  $fmain->Label(-justify => "left", 
                -text => __("Destination folder:") . "\t $dest_display")->place(-x => 0, -y => $ytmp);
  $ytmp += 20;

  for my $o (@opts_list) {
    my $text = $opts_to_str{$o} . ":\t";
    if (exists ($opts_choices{$o})) {
      $text .= $opts_choices{$o}->[$vars{"option_$o"}];
    } else {
      $text .= $vars{"option_$o"} ? __("Yes") : __("No");
    }
    $fmain->Label(-justify => "left", 
                  -text => $text)->place(-x => 0, -y => $ytmp);
    $ytmp += 20;
  }


  
  $nxt->configure(-text => __('Install'), 
                  -command => \&wizard_installation_window);
  $prv->configure(-text => __('< Back'), -command => \&ask_options);
  $can->place(-x => $LEFT, -y => ($MHEIGHT - $BOTTOM), -anchor => "sw");
}

sub wizard_installation_window {
  for ($fmain->children) {
    $_->destroy;
  }
  $counter->configure(-text => "5/5");
  # create a progress bar window
  # compute the height of the Text by the given font

  $::progressw = $fmain->Scrolled("ROText", -scrollbars => "e",
                                -wrap => "word");

  # we want to have the progressbar about 20px wide, so compute how
  # many lines of the current font do fit into the remaining area
  my $lines = int( ($INNERHEIGHT - 20) / $lineskip);
  # it seems that on Windows the computation is not right, the
  # progress bar overwrites the last line of the text widget
  # remove one line here
  $lines-- if win32();
  $::progressw->configure(-height => $lines);
  $::progressw->place(-x => 0, -y => 0, -width => $INNERWIDTH); 

  # that is necessary otherwise the progressbar gets very strange dimensions
  $fmain->update;


  my $percent_done = 0;

  # compute the remaining space in pixel for the progressbar
  my $pw = $INNERHEIGHT - ($lines * $lineskip) - 5;
  # make sure that the line we remove above for Windows is not re-added
  # to the size of the progressbar. The 7 was found by trial and error
  $pw -= ($lineskip + 7) if win32();
  $::progress = $fmain->ProgressBar(-variable => \$percent_done,
      -width => $pw, -length => $INNERWIDTH,
      -from => 0, -to => 110, -blocks => 10,
      -colors => [ 0, '#0078b8' ]);
  $::progress->place(-x => 0, -y => $INNERHEIGHT, -anchor => "sw");

  #
  # change the buttons so that the Prev disappears, the Next becomes
  # Cancel, and the Cancel button disappears
  $prv->placeForget;
  $can->placeForget;
  $nxt->configure(-text => __('Cancel'),
                  -command => sub { $return = $MENU_ABORT; $mw->destroy; });
  calc_depends();
  do_installation();
  $::progress->value(110);
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
  $t .= "\n\n" . __('Welcome to TeX Live!');
  #$t =~ s/\\n/\n/g;
  my $linechar = $::progressw->index("end");
  $::progressw->markSet("finaltext", $linechar);
  $::progressw->markGravity("finaltext", "left");
  $::progressw->insert("end", "\n$t");
  $::progressw->see("end");
  $::progressw->tagAdd("centered", $linechar, "end");
  $::progressw->tagConfigure("centered", -justify => "center");
  $nxt->configure(-text => __('Finish'),
                -command => sub { $mw->destroy; });
}

################### END OF MODULE RETURN 1 FOR REQUIRE ###########

1;

__END__

### Local Variables:
### perl-indent-level: 2
### tab-width: 2
### indent-tabs-mode: nil
### End:
# vim:set tabstop=2 expandtab: #
