#!/usr/bin/env perl
use strict;
$^W=1;

# Copyright (C) 2008, 2011, 2012 Heiko Oberdiek
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301  USA
#
# This file is part of PDFAnnotExtractor. See README.

my $name        = 'PDFAnnotExtractor';
my $program     = "\L$name\E";
my $file        = "$program.pl";
my $version     = "0.1l";
my $date        = "2012/04/18";
my $author      = "Heiko Oberdiek";
my $copyright   = "Copyright (c) 2008, 2011, 2012 by $author.";

# History:
#  2008/10/01 v0.1i: First version of the wrapper script.
#  2012/04/18 v0.1l: Option --version added.

my $title = "$name $version, $date - $copyright\n";
my $usage = <<"END_OF_USAGE";
${title}Syntax:   $program [options] <PDF files[.pdf]>
Options:
  --help      print usage
  --version   print version number
  --install   try installing PDFBox library
  --debug     debug informations
END_OF_USAGE

my $help = 0;
my $debug = 0;
my $install = 0;
my $opt_version = 0;
use Getopt::Long;
GetOptions(
  'debug!' => \$debug,
  'install!' => \$install,
  'help!' => \$help,
  'version!' => \$opt_version,
) or die $usage;
!$help or die $usage;
if ($opt_version) {
  print "$name $date v$version\n";
  exit(0);
}
!$install and (@ARGV >= 1 or die $usage);

print $title;

my $error = '!!! Error:';
my $url_pdfbox = 'http://prdownloads.sourceforge.net/pdfbox/PDFBox-0.7.3.zip?download';
my $size_pdfbox_zip = 22769102;
my $size_pdfbox_jar = 3321771;
my $name_pdfbox_jar = 'PDFBox-0.7.3.jar';
my $entry_pdfbox    = "PDFBox-0.7.3/lib/$name_pdfbox_jar";
my $pdfbox = 'PDFBox';

my $prg_kpsewhich = 'kpsewhich';
my $prg_wget      = 'wget';
my $prg_curl      = 'curl';
my $prg_unzip     = 'unzip';
my $prg_texhash   = 'texhash';
my $prg_mktexlsr  = 'mktexlsr';
my $prg_java      = 'java';
my %prg;

my $jar_pax    = 'pax.jar';
my $main_class = 'pax.PDFAnnotExtractor';
my $jar_pdfbox = 'pdfbox.jar';
my @jar_pdfbox = qw[
    pdfbox.jar
    PDFBox.jar
    pdfbox-0.7.3.jar
    PDFBox-0.7.3.jar
    pdfbox-0.7.2.jar
    PDFBox-0.7.2.jar
];
my @dir_jar = qw[
    /usr/share/java
    /usr/local/share/java
];
my $path_jar_pax = '';
my $path_jar_pdfbox = '';
my $classpath = defined $ENV{'CLASSPATH'} ? $ENV{'CLASSPATH'} : '';
debug('CLASSPATH', $classpath);
my $pdfbox_in_classpath = $classpath =~ /PDFBox/ ? 1 : 0;

my $is_win = 0;
$is_win = 1 if $^O =~ /^MSWin(32|64)/i
            or $^O =~ /^dos/i
            or $^O =~ /^os2/i;
debug('is_win', $is_win);

use File::Which;

sub debug ($$) {
    my $key = shift;
    my $value = shift;
    print "* $key: [$value]\n" if $debug;
}

sub check_prg ($$) {
    my $prg = shift;
    my $die = shift;
    return 1 if $prg{$prg};
    my $path = which($prg);
    if ($path) {
        $prg{$prg} = $path;
        debug "Which $prg", $path;
        return 1;
    }
    debug "Which $prg", '<not found>';
    if ($die) {
        die "$error Cannot find program `$prg'!\n";
    }
    return 0;
}

sub find_jar ($) {
    my $jar_name = shift;

    check_prg $prg_kpsewhich, 1;
    my $cmd = "kpsewhich"
            . " --progname $program"
            . " --format texmfscripts"
            . " $jar_name";
    debug 'Backticks',  $cmd;
    my $path = `$cmd`;
    if ($? == 0) {
        chomp $path;
        debug 'Exit code', '0/success';
        debug $jar_name, $path;
        return $path;
    }
    if ($? == -1) {
        die "!!! Error: Cannot execute `$prg_kpsewhich' ($!)!\n";
    }
    if ($? & 127) {
        die "!!! Error: `$prg_kpsewhich' died with signal " . ($? & 127)
            . (($? & 128) ? ' with coredump' : '') . "!\n";
    }
    debug 'Exit code', ($? >> 8);
    return '';
}

sub find_jar_pax () {
    return if $path_jar_pax;
    foreach my $dir (@dir_jar) {
        my $path = "$dir/$jar_pax";
        if (-f $path) {
            $path_jar_pax = $path;
            debug $jar_pax, $path_jar_pax;
            return;
        }
    }
    $path_jar_pax = find_jar $jar_pax;
    if (!$path_jar_pax) {
        die "$error Cannot find `$jar_pax'!\n";
    }
}

sub find_jar_pdfbox () {
    return if $path_jar_pdfbox;
    foreach my $dir (@dir_jar) {
        foreach my $jar (@jar_pdfbox) {
            my $path = "$dir/$jar";
            if (-f $path) {
                $path_jar_pdfbox = $path;
                debug $jar_pdfbox, $path_jar_pdfbox;
                return;
            }
        }
    }
    foreach my $jar_pdfbox (@jar_pdfbox) {
        $path_jar_pdfbox = find_jar $jar_pdfbox;
        last if $path_jar_pdfbox;
    }
}

sub launch_pax () {
    check_prg $prg_java, 1;
    my @cmd = ($prg_java);
    my $sep = $is_win ? ';' : ':';
    my $cp = "$path_jar_pax";
    $cp .= "$sep$path_jar_pdfbox" if $path_jar_pdfbox;
    $cp .= "$sep$classpath" if $classpath;
    push @cmd, '-cp';
    push @cmd, $cp;
    push @cmd, $main_class;
    push @cmd, @ARGV;
    debug 'System', "@cmd";
    system @cmd;
    if ($? == 0) {
        debug 'Result', 'ok';
        return 0;
    }
    if ($? == -1) {
        die "$error Cannot execute `$prg_java' ($!)!\n";
    }
    if ($? & 127) {
        die "$error `$prg_java' died with signal " . ($? & 127)
            . (($? & 128) ? ' with coredump' : '') . "!\n";
    }
    my $exit_code = $? >> 8;
    debug 'Exit code', $exit_code;
    return $exit_code;
}

# install part

sub expand_var ($) {
    my $var = shift;
    check_prg $prg_kpsewhich, 1;
    my $cmd = $prg_kpsewhich
              . " --progname $program"
              . ' --expand-var';
    $cmd .= $is_win ? " \$$var" : " \\\$$var";
    debug 'Backticks', $cmd;
    my $path = `$cmd`;
    if ($? == 0) {
        chomp $path;
        debug 'Exit code', '0/success';
        debug "\$$var", $path;
        return $path;
    }
    if ($? == -1) {
        die "!!! Error: Cannot execute `$prg_kpsewhich' ($!)!\n";
    }
    if ($? & 127) {
        die "!!! Error: `$prg_kpsewhich' died with signal " . ($? & 127)
            . (($? & 128) ? ' with coredump' : '') . "!\n";
    }
    debug 'Exit code', ($? >> 8);
    return '';
}

sub ensure_dir ($) {
    my $dir = shift;
    return if -d $dir;
    mkdir $dir or die "$error Cannot create directory `$dir'!\n";
    debug 'mkdir', $dir;
}

sub file_size ($) {
    my $file = shift;
    return -1 unless -f $file;
    return (stat $file)[7];
}

if ($install) {
    # Can PDFBox already be found?
    find_jar_pdfbox;
    if ($path_jar_pdfbox) {
        print "* Nothing to do, because $pdfbox is already found:\n"
              . "  $path_jar_pdfbox\n";
        exit(0);
    }

    # Find TEXMFVAR
    my $tds_root;
    foreach my $var ('TEXMFVAR', 'VARTEXMF') {
        $tds_root = expand_var $var;
        last if $tds_root;
    }
    $tds_root or die "$error Cannot find settings for `TEXMFVAR' or `VARTEXMF'!\n";

    # Create directories
    ensure_dir $tds_root;
    my $tds_pax = $tds_root;
    $tds_pax =~ s/(\/*)$/\/scripts/;
    ensure_dir $tds_pax;
    $tds_pax .= '/pax';
    ensure_dir $tds_pax;
    my $tds_pax_lib = "$tds_pax/lib";
    ensure_dir $tds_pax_lib;

    # Download
    my $dest_file = "$tds_pax/PDFBox-0.7.3.zip";
    if (file_size $dest_file == $size_pdfbox_zip) {
        debug "$pdfbox archive found", $dest_file;
    }
    else {
        my @cmd;
        my $prg_download;
        check_prg $prg_wget, 0;
        if ($prg{$prg_wget}) {
            $prg_download = $prg_wget;
            push @cmd, $prg_wget;
            push @cmd, '-O';
        }
        else {
            check_prg $prg_curl, 0;
            $prg{$prg_curl} or die "$error Cannot find programs `wget' or `curl'"
                                   . " for downloading!\n";
            $prg_download = $prg_curl;
            push @cmd, $prg_curl;
            push @cmd, '-L';
            push @cmd, '-o';
        }
        push @cmd, $dest_file;
        push @cmd, $url_pdfbox;
        debug 'System', "@cmd";
        system @cmd;
        if ($? == 0) {
            debug 'Result', 'ok';
        }
        elsif ($? == -1) {
            die "$error Cannot execute `$prg_download' ($!)!\n";
        }
        elsif ($? & 127) {
            die "$error `$prg_download' died with signal " . ($? & 127)
                . (($? & 128) ? ' with coredump' : '') . "!\n";
        }
        else {
            my $exit_code = $? >> 8;
            die "$error `$prg_download' returns error code `$exit_code'!\n";
        }
        -f $dest_file or die "$error Download failed!\n";
        my $size = file_size $dest_file;
        $size == $size_pdfbox_zip
                or die "$error File size of $dest_file is $size,\n"
                . "but expected size is $size_pdfbox_zip!\n";
    }
    print "* Downloaded: $dest_file\n";

    # Unpack jar file
    check_prg $prg_unzip, 0;
    if ($prg{$prg_unzip}) {
        my @cmd = (
            $prg_unzip,
            '-j',
            '-d',
            $tds_pax_lib,
            $dest_file,
            $entry_pdfbox
        );
        debug 'System', "@cmd";
        system @cmd;
        if ($? == 0) {
            debug 'Result', 'ok';
        }
        elsif ($? == -1) {
            die "$error Cannot execute `$prg_unzip' ($!)!\n";
        }
        elsif ($? & 127) {
            die "$error `$prg_unzip' died with signal " . ($? & 127)
                . (($? & 128) ? ' with coredump' : '') . "!\n";
        }
        else {
            my $exit_code = $? >> 8;
            die "$error `$prg_unzip' returns error code `$exit_code'!\n";
        }
    }
    else {
        die "$error `$prg_unzip' not found!\n";
    }
    my $dest_jar = "$tds_pax_lib/$name_pdfbox_jar";
    -f $dest_jar or die "$error Unpacking failed!\n";
    my $size = file_size $dest_jar;
    $size == $size_pdfbox_jar
            or die "$error File size of $dest_jar is $size,\n"
            . "but expected size is $size_pdfbox_jar!\n";

    print "* Unpacked: $dest_jar\n";

    # Update TDS data base
    my $prg_tds_update;
    check_prg $prg_texhash, 0;
    if ($prg{$prg_texhash}) {
       $prg_tds_update = $prg_texhash;
    }
    else {
        check_prg $prg_mktexlsr, 0;
        $prg{$prg_mktexlsr} or die "$error Neither `$prg_texhash' nor `$prg_mktexlsr' found!\n";
        $prg_tds_update = $prg_mktexlsr;
    }
    my @cmd = ($prg_tds_update, $tds_root);
    debug 'System', "@cmd";
    system @cmd;
    if ($? == 0) {
        debug 'Result', 'ok';
    }
    elsif ($? == -1) {
        die "$error Cannot execute `$prg_tds_update' ($!)!\n";
    }
    elsif ($? & 127) {
        die "$error `$prg_tds_update' died with signal " . ($? & 127)
            . (($? & 128) ? ' with coredump' : '') . "!\n";
    }
    else {
        my $exit_code = $? >> 8;
        die "$error `$prg_tds_update' returns error code `$exit_code'!\n";
    }

    # Check installation result
    find_jar_pdfbox;
    if ($path_jar_pdfbox) {
        exit(0);
    }
    die "$error Installation failed, because $pdfbox library cannot be found!\n";
}

# main program

my $ret = 0;
find_jar_pax;
if ($pdfbox_in_classpath) {
    debug 'PDFBox in CLASSPATH', 'yes';
}
else {
    find_jar_pdfbox;
    $path_jar_pdfbox or die "$error Cannot find $pdfbox library!\n"
            . "See README and option `--install'.\n";
}
exit launch_pax;

__END__
