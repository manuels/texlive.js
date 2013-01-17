#!/usr/bin/env ruby

# epspdf conversion utility, main source

#####
# Copyright (C) 2006, 2008, 2009, 2010, 2011 Siep Kroonenberg
# n dot s dot kroonenberg at rug dot nl
#
# This program is free software, licensed under the GNU GPL, >=2.0.
# This software comes with absolutely NO WARRANTY. Use at your own risk!
#####

# Operations on a PostScript- or pdf file.
# The focus is on converting between eps and pdf.

# Code is organized as a set of single-step conversion methods plus an
# any-to-any conversion chaining them together.

# `Target' is not a parameter; all conversions write to a new temp
# file. Conversions can be chained: object.conversion1( params
# ).conversion2( params ) ... The final temp file is moved or copied to
# the desired destination by the main program (which can be epspdf.rb
# itself).

# The use of exception handling makes it unnecessary to inspect return
# values.

###########################################

# some initialization

# add directory of this source to loadpath
# WARNING
# readlink apparently only works right from the directory of the symlink

$SCRIPTDIR = File.dirname( File.expand_path( __FILE__ ))
if RUBY_PLATFORM !~ /win32|mingw/ and File.symlink?( __FILE__ )
  savedir = Dir.pwd
  Dir.chdir( $SCRIPTDIR )
  # puts File.readlink( __FILE__ )
  $SCRIPTDIR = File.dirname( File.expand_path( File.readlink( __FILE__ )))
  Dir.chdir( savedir )
end
$:.unshift( $SCRIPTDIR )
# puts $:

# turn on warnings
#$VERBOSE = 1

$from_gui = nil


###########################################

# Error handling

# internal error: method should not have been called
# under the current conditions
class EPCallError < StandardError; end

# Can't get a valid boundingbox for an eps file
class EPBBError < StandardError; end

# copying failed
class EPCopyError < StandardError; end

# system call failed
class EPSystemError < StandardError; end

###########################################

# PostScript header file for grayscaling

$GRAYHEAD = File.join( $SCRIPTDIR, "makegray.pro" )

###########################################

# handle auto-detected and saved settings

#require 'epspdfrc'
require 'epspdfrc'

###########################################

# Transient options. These will never be saved.
# We set default values here.

$options = {
  'type' => nil,
  'page' => nil,
  'bbox' => false,
  'gray' => false,
  'gRAY' => false,
  'info' => false
}

class << $options

  # create shortcut methods $options.x and $options.x=
  # for reading and writing hash elements.

  $options.each_key { |k|
    eval "def #{k} ; self[\'#{k}\'] ; end"
    eval "def #{k}=(v) ; self[\'#{k}\']=v ; end"
  }

end # class

###########################################

def hash_prn( h )
  if h.empty?
    s = "No parameters" + $/
  else
    s = "Parameters were:" + $/
    h.each_key { |k| s = s + '  ' + k.to_s + ' => ' + h[ k ].to_s + $/ }
  end
  s
end

###########################################

require 'fileutils'
#include FileUtils::Verbose
include FileUtils

###########################################

# Mode strings for file i/o

if ARCH == 'w32'
  $W = 'wb'
  $A = 'ab'
  $R = 'rb'
else
  $W = 'w'
  $A = 'a'
  $R = 'r'
end

###########################################

# copy a slice of a file; is there no such standard function?
# some eps files are very large; don't slurp the file at one go.
# Mode: can be set to append 'a' rather than write 'w'.

def sliceFile( source, dest, len, offs, mode=$W )
  buffer = ''
  File.open( source ) do |s|
    s.binmode if ARCH == 'w32'
    s.seek( offs, IO::SEEK_SET )
    if s.pos == offs
      begin
        File.open( dest, mode ) do |d|
          d.binmode if ARCH == 'w32'
          tocopy = len
          while tocopy>0 and  s.read( [ tocopy, 16384 ].min, buffer )
            tocopy = tocopy - d.write( buffer )
          end # while
        end # do
      rescue
        fail EPCopyError, "Failure to copy to #{dest}"
      end
    end # if s.seek
  end # |s| (automatic closing)
  # return value true if anything has been copied
  File.size?( dest ) # nil if zero-length
end # def

# write our own file copy, to bypass bug in FileUtils.cp

def ccp( source, dest )
  sliceFile( source, dest, File.size( source ), 0, $W )
end

###########################################

# logging

def write_log( s )
  if test( ?e, LOGFILE ) and File.size( LOGFILE ) > 100000
    rm( LOGFILE_OLD ) if test( ?e, LOGFILE_OLD )
    ccp( LOGFILE, LOGFILE_OLD )
    File.truncate( LOGFILE, 0 )
  end
  File.open( LOGFILE, 'a' ) { |f|
    f.print( "#{$$} #{Time.now.strftime('%Y/%m/%d %H:%M:%S')} #{s}\n" )
  }
  puts( s ) if $from_gui

end

###########################################

require 'tmpdir'

#$DEBUG=1

# save filenames for cleanup at end
$tempfiles = []

def mktemp( ext )
  isdone = nil
  (0..99).each do |i|
    fname = Dir.tmpdir + File::SEPARATOR + \
      sprintf( '%d_%02d.%s', $$, i, ext ) # $$ is process id
    next if test( ?e, fname )
    File.open( fname, 'w' ) do |f|; end # creates empty file
    isdone = 1
    $tempfiles.unshift( fname )
    return fname
  end # each do |i|
  fail StandardError, "Cannot create temp file" unless isdone
end # def

def cleantemp
  write_log( "Cleaning tempfiles" + $/ + $tempfiles.join( $/ ) )
  $tempfiles.each{ |tf|; rm( tf ) }
end

###########################################

# identifying file type

# EPS with preview starts with 0xC5D0D3C6
# Encapsulated PostScript starts with %!PS-Adobe-n.n EPSF-n.n
# but %!PS-Adobe-n.n will also be identified as Encapsulated PostScript
# if the filename extension suggests it.
# PostScript starts with %!
# PDF starts with %PDF-version

def identify( path )
  filestart = nil
  File.open( path, $R ) do |f|
    filestart = f.read( 23 )
  end # this syntax automatically closes the file at end of block
  case filestart
  when /^\xc5\xd0\xd3\xc6/
    'epsPreview'
  when /^%!PS-Adobe-\d\.\d EPSF-\d\.\d/
    'eps'
  when /^%!PS-Adobe-\d\.\d/
     ( path =~ /\.ep(i|s|si|sf)$/i ) ? 'eps' : 'ps'
  when /^%!/
     'ps'
  when /^%PDF/
     'pdf'
  else
     'other'
  end # case
end # def

###########################################

# Boundingboxes; first standard, then hires

#changes:
#hires boundingboxes
#numbers may start with a plus-sign. DSC manual is ambiguous,
# PostScript manual allows it, but of course PS != DSC
#left-right and lower-upper need not be in natural order

BB_PAT = /^\s*%%BoundingBox:\s*([-+]?\d+)((\s+[-+]?\d+){3})\s*$/
BB_END = /^\s*%%BoundingBox:\s*\(\s*atend\s*\)\s*$/

class Bb

  attr_accessor :llx, :lly, :urx, :ury # strings

  def initialize( llx, lly, urx, ury )
    @llx, @lly, @urx, @ury = llx, lly, urx, ury
    # guarantee valid syntax:
    [@llx, @lly, @urx, @ury].each { |l| l = l.to_i.to_s }
    @llx, @urx = @urx, @llx if @llx.to_i > @urx.to_i
    @lly, @ury = @ury, @lly if @lly.to_i > @ury.to_i
  end

  def Bb.from_comment( s )
    return nil unless s =~ BB_PAT
    llx, lly, urx, ury =
      s.sub( /^\s*%%BoundingBox:\s*/, '' ).split( /\s+/ )
    Bb.new( llx, lly, urx, ury )
  end

  def height
    ( @ury.to_i - @lly.to_i ).to_s
  end

  def width
    ( @urx.to_i - @llx.to_i ).to_s
  end

  def valid
    @llx.to_i < @urx.to_i and @lly.to_i < @ury.to_i
  end

  def non_negative
    valid and @llx.to_i >= 0 and @lly.to_i >= 0
  end

  def copy
    Bb.new( @llx, @lly, @urx, @ury )
  end

  def prn
    "#{@llx} #{@lly} #{@urx} #{@ury}"
  end

  def expand
    i = ( $settings.bb_spread ).to_i
    return if i <= 0
    @llx = ( [ 0, @llx.to_i - i ].max ).to_s
    @lly = ( [ 0, @lly.to_i - i ].max ).to_s
    @urx = ( @urx.to_i + i ).to_s
    @ury = ( @ury.to_i + i ).to_s
  end

  ##################

  # wrapper code for a boundingbox;
  # moves lower left corner of eps to (0,0)
  # and defines a page size identical to the eps width and height.
  # The gsave in the wrapper code should be matched by
  # a grestore at the end of the PostScript code.
  # This grestore can be specified on the Ghostscript command-line.

  def wrapper
    fail EPBBError, prn unless valid
    fname = mktemp( 'ps' )
    File.open( fname, $W ) do |f|
      f.binmode if ARCH == 'w32'
      f.write( "%%BoundingBox: 0 0 #{width} #{height}\n" +
        "<< /PageSize [#{width} #{height}] >>" +
        "  setpagedevice\n" +
        "gsave #{(-(@llx.to_i)).to_s} #{(-(@lly.to_i)).to_s}" +
        " translate\n" ) > 0
    end # open
    return fname
  end # wrapper

  ##################

  # convert boundingbox to boundingbox comment

  def comment
    fail EPBBError, prn unless valid
    "%%BoundingBox: #{@llx} #{@lly} #{@urx} #{@ury}"
  end

end # class Bb

# [-+](\d+(\.\d*)?|\.\d+)([eE]\d+)? PostScript number
HRBB_PAT = /^\s*%%HiResBoundingBox:\s*[-+]?(\d+(\.\d*)?|\.\d+)([eE]\d+)?((\s[-+]?(\d+(\.\d*)?|\.\d+)([eE]\d+)?){3})\s*$/
HRBB_END = /^\s*%%HiResBoundingBox:\s*\(\s*atend\s*\)\s*$/

class HRBb

  attr_accessor :llx, :lly, :urx, :ury

  def initialize( llx, lly, urx, ury )
    @llx, @lly, @urx, @ury = llx, lly, urx, ury
    [@llx, @lly, @urx, @ury].each do |l|
      if l =~ /\./
        # make floats conform to Ruby syntax:
        # decimal dots must be padded with digits on either side
        l.sub!( /^\./, '0.' )
        l.sub!( /\.(?!\d)/, '.0' ) # (?!\d): zero-width neg. lookahead
      end
      l = l.to_f.to_s
    end
    @llx, @urx = @urx, @llx if @llx.to_f > @urx.to_f
    @lly, @ury = @ury, @lly if @lly.to_f > @ury.to_f
  end

  def HRBb.from_hrcomment( s )
    return nil unless s =~ HRBB_PAT
    llx, lly, urx, ury =
      s.sub( /^\s*%%HiResBoundingBox:\s*/, '' ).split( /\s+/ )
    HRBb.new( llx, lly, urx, ury )
  end

  def height
    ( @ury.to_f - @lly.to_f ).to_s
  end

  def width
    ( @urx.to_f - @llx.to_f ).to_s
  end

  def valid
    @llx.to_f < @urx.to_f and @lly.to_f < @ury.to_f
  end

  def non_negative
    valid and @llx.to_f >= 0 and @lly.to_f >= 0
  end

  def copy
    HRBb.new( @llx, @lly, @urx, @ury )
  end

  def prn
    "#{@llx} #{@lly} #{@urx} #{@ury}"
  end

  ##################

  # wrapper code for a hires boundingbox;
  # moves lower left corner of eps to (0,0)
  # and defines a page size identical to the eps width and height.
  # The gsave in the wrapper code should be matched by
  # a grestore at the end of the PostScript code.
  # This grestore can be specified on the Ghostscript command-line.

  def wrapper
    fail EPBBError, prn unless valid
    fname = mktemp( 'ps' )
    File.open( fname, $W ) do |f|
      f.binmode if ARCH == 'w32'
      f.write(
        "%%BoundingBox: 0 0 #{width.to_f.ceil} #{height.to_f.ceil}\n" +
        "%%HiResBoundingBox: 0 0 #{width.to_f} #{height.to_f}\n" +
        "<< /PageSize [#{width} #{height}] >>" +
        "  setpagedevice\n" +
        "gsave #{(-(@llx.to_f)).to_s} #{(-(@lly.to_f)).to_s}" +
        " translate\n" ) > 0
    end # open
    return fname
  end # wrapper

  ##################

  # convert hiresboundingbox to hires boundingbox comment

  def hrcomment
    fail EPBBError, prn unless valid
    "%%HiResBoundingBox: #{@llx} #{@lly} #{@urx} #{@ury}"
  end

end # class HRBb

###########################################

# PsPdf class definition

class PsPdf

  protected

  SAFESIZE = 16000

  public

  # class methods ###

  def PsPdf.pdf_options
    "-dPDFSETTINGS=/#{$settings.pdf_target}" + \
    ( $settings.pdf_version == 'default' ? '' : \
    " -dCompatibilityLevel=#{$settings.pdf_version}" ) + \
    ($settings.pdf_custom ? ' ' + $settings.pdf_custom : '')
  end

  def PsPdf.gs_options
    "-dNOPAUSE -dBATCH -q -dSAFER"
  end

  def PsPdf.ps_options( sep )
    # the sep(arable_color) option forces a cmyk color model,
    # which should improve chances of grayscaling later on.
    if sep
      case $settings.ps_options
      when /-level\dsep\b/
        $settings.ps_options
      when /-level\d\b/
        $settings.ps_options.sub( /(-level\d)/, '\1sep' )
      else
        $settings.ps_options + " -level3sep"
      end # case
    else
      $settings.ps_options
    end # ifthenelse sep
  end

  # instance methods ###

  attr_accessor :path, :bb, :hrbb, :type, :npages, :atfront, :hr_atfront

  ##################

  def initialize( params={} )

    ext = params[ 'ext' ]
    file = params[ 'file' ]

    if not ext and not file
      @path = nil
      @type = nil
    elsif not file
      @path = mktemp( ext )
      @type = case ext.downcase
      when 'pdf'
        'pdf'
      when 'eps'
        'eps'
      when 'ps'
        'ps'
      else
        'other'
      end
    else
      @path = file
      @type = identify( file )
      @npages = pdf_pages if @type == 'pdf' # should we do this?
      @npages = 1 if @type =~ /^eps/
    end
  end # initialize

  def file_info
    if @npages and @type !~ /^eps/
      return "File type of #{@path} is #{@type} with #{@npages} pages"
    else
      return "File type of #{@path} is #{@type}"
    end
  end

  ##################

  # debug string for EPCallError

  def buginfo( params = nil )
    b = "Source was: " + @path + $/
    b = b + param_hash_prn( params ) if params
    b
  end

  ##################

  # Find boundingbox, simple case.
  # We shall call this method only for eps PsPdf objects which were
  # converted by pdftops or Ghostscript, so we can be sure that
  # the boundingbox is not (atend).
  # We also assume that the hrbb lies within the bb.
  # The file is not rewritten.

  def find_bb_simple

    fail EPCallError, buginfo unless @type == 'eps'
    @bb = nil
    @hrbb = nil
    slurp = ''
    File.open( @path, $R ) do |fl|
      slurp = fl.read( [File.size(@path), SAFESIZE].min )
    end
    lines = slurp.split( /\r\n?|\n/ )
    # look for a bb or a hrbb
    # if a valid bb is found, check the next line for hrbb
    # but look no further; we don't want to mistake a hrbb of
    # an included eps for the hrbb of the outer eps.
    lines.each do |l|
      if l =~ BB_PAT
        @bb = Bb.from_comment( l )
      elsif l =~ HRBB_PAT
        @hrbb = HRBb.from_hrcomment( l )
      elsif @bb
        break # stop looking; we expect hrbb next to bb
      end
      break if @bb and @hrbb
    end # do |l|
    fail EPBBError, @path unless @bb and @bb.valid

  end # def find_bb_simple

  ##################

  def pdf_pages

    fail EPCallError, buginfo unless @type == 'pdf'

    @npages = nil

    # get n. of pages; the Ghostscript pdf2dsc.ps script will
    # create a list of pages. It seems to ignore logical p. numbers.

    dsc = mktemp( "dsc" )
    cmd = "\"#{$settings.gs_prog}\" -dNODISPLAY -q" +
      " -sPDFname=\"#{@path}\" -sDSCname=\"#{dsc}\" pdf2dsc.ps"
    write_log cmd # if $DEBUG
    fail EPSystemError, cmd unless system( cmd ) and test( ?s, dsc )
    lines = []
    File.open( dsc, $R ) do |f|
      lines = f.read( SAFESIZE ).split( /\r\n?|\n/ )
    end
    lines.each do |l|
      if l =~ /^%%Pages:\s+(\d+)\s*$/
        @npages = $1.to_i
        break
      end # if =~
    end # do |l|

    return @npages

  end # pdf_pages

  #############################################################

  # direct conversions. These methods return a PsPdf object,
  # and raise an exception in case of failure.
  # Direct conversions convert at most once between PostScript and pdf.
  # They always write to a temporary file.

  ##################

  # eps_clean: write source eps to an eps without preview, and
  # with a boundingbox in the header.
  # clean up any potential problems
  # the eps is always written to a new file.

  def eps_clean

    fail EPCallError, buginfo if @type != 'eps' and @type != 'epsPreview'
    atend = nil
    hr_atend = nil
    slurp = ''
    offset, ps_len = nil, nil
    if @type == 'eps'
      offset = 0
      ps_len = File.size( @path )
    else
      # read ToC; see Adobe EPS spec
      File.open( @path, $R ) do |fl|
        # bug workaround for unpack
        if "\001\000\000\000".unpack( 'V' )[0] == 1
          dummy, offset, ps_len = fl.read( 12 ).unpack( 'VVV' )
        else
          dummy, offset, ps_len = fl.read( 12 ).unpack( 'NNN' )
        end
      end # File
    end # ifthenelse @type

    # [hires] boundingbox unknown and possibly atend
    @bb, @atfront, @hrbb, @hr_atfront = nil, nil, nil, nil

    # limit search for boundingbox comments.
    # For very large eps files, we don't want to scan the entire file.
    # A boundingbox comment should be in the header or trailer,
    # so scanning the first and last few KB should be plenty.

    File.open( @path, $R ) do |fl|
      fl.seek( offset, IO::SEEK_SET )
      slurp = fl.read( [ps_len,SAFESIZE].min )
    end

    # We capture both lines and separators, as an easy way to
    # keep track of how many bytes have been read.
    # we assume that if there is a hires bb then
    # bb and hires bb are on consecutive lines.
    # Otherwise the logic would get too messy.

    # The epsfile will be reconstituted from:
    # a series of lines and line separators; then either
    # - a bbox or
    # - (bbox or hrbbox), separator, (hrbbox or bbox)
    # the big blob
    # possibly a trailer with removed bb comments

    pre_lines = slurp.split( /(\r\n?|\n)/ )
    bb_comment = ''
    # initialize indices of bb comments to less than smallest index
    i_bb = -1
    i_hrbb = -1
    i = -1
    i_end = -1
    pre_length = 0
    pre_lines.each do |l|
      pre_length += l.length
      i += 1
      next if l =~ /(\r\n?|\n)/
      if l =~ BB_PAT
        @bb = Bb.from_comment( l )
        @atfront = true
        i_bb = i
      elsif l =~ BB_END
        atend = true
        i_bb = i
      elsif l =~ HRBB_PAT
        @hrbb = HRBb.from_hrcomment( l )
        @hr_atfront = true
        i_hrbb = i
      elsif l =~ HRBB_END
        hr_atend = true
        i_hrbb = i
      elsif @bb or atend
        i_end = i
        break # stop looking; we expect hrbb next to bb
      end # =~ BB_PAT
    end # do |l|
    if atend or hr_atend
      if ps_len > SAFESIZE
        File.open( @path, $R ) do |fl|
          fl.seek( offset + ps_len - SAFESIZE, IO::SEEK_SET )
          slurp = fl.read( SAFESIZE )
        end
      end # else use old slurp
      post_lines = slurp.split( /(\r\n?|\n)/ )
      # initialize indices of atend bb comments to more than largest index
      j = post_lines.length
      j_bb = j
      j_hrbb = j
      j_end = j
      post_length = 0
      post_lines.reverse_each do |l|
        post_length += l.length
        j -= 1
        next if l =~ /(\r\n?|\n)/
        if l =~ BB_PAT
          bb_comment = l
          @bb = Bb.from_comment( bb_comment )
          j_bb = j
        elsif l =~ HRBB_PAT
          bb_comment = l
          @hrbb = HRBb.from_hrcomment( bb_comment )
          j_hrbb = j
        end
        if (@bb or !atend) and (@hrbb or !hr_atend)
          j_end = j
          break
        end
      end # do
      #post_lines.slice([j_bb,j_hrbb].min .. -1).each do |l|
      #  post_block = post_block + l
    end # if atend

    fail EPBBError, @path unless @bb.valid
    # in case of discrepancy, drop @hrbb.
    # we accept a `safety margin': a difference >1pt is not a discrepancy.
    @hrbb = nil if @hrbb and
      (( @bb.llx.to_i > @hrbb.llx.to_f.floor ) or
      ( @bb.lly.to_i > @hrbb.lly.to_f.floor ) or
      ( @bb.urx.to_i < @hrbb.urx.to_f.ceil ) or
      ( @bb.ury.to_i < @hrbb.ury.to_f.ceil ))

    retVal = PsPdf.new( 'ext' => 'eps' )

    # always rewrite the eps, to get normalized, ruby-compatible bb syntax.
    # we modify part of the header, and possibly of the trailer.

    # offset, length of middle part, which can be copied byte for byte
    cp_start = offset + pre_length
    cp_len = ps_len - pre_length
    cp_len -= post_length if ( atend or hr_atend )
    # replace boundingbox comments
    if atend
      pre_lines[i_bb].sub!( BB_END, @bb.comment )
      post_lines[j_bb].sub!( BB_PAT, '%%' )
    else
      pre_lines[i_bb].sub!( BB_PAT, @bb.comment )
    end
    if @hrbb
      # replace valid hires boundingbox comments
      if hr_atend
        pre_lines[i_hrbb].sub!( HRBB_END, @hrbb.hrcomment )
        post_lines[j_hrbb].sub!( HRBB_PAT, '%%' )
      else
        pre_lines[i_hrbb].sub!( HRBB_PAT, @hrbb.hrcomment )
      end
    elsif i_hrbb >= 0 # invalid hires bb
      # erase invalid hr boundingbox comments
      if atend
        pre_lines[i_hrbb].sub!( HRBB_END, '%%' )
        post_lines[j_hrbb].sub!( HRBB_PAT, '%%' )
      else
        pre_lines[i_hrbb].sub!( HRBB_PAT, '%%' )
      end
    end # test for @hrbb

    File.open( retVal.path, $W ) do |fl|
      fl.write( pre_lines[ 0 .. i_end ].join )
    end
    sliceFile( @path, retVal.path, cp_len, cp_start, $A )
    if ( atend or hr_atend )
      File.open( retVal.path, $A ) do |fl|
        fl.write( post_lines[ j_end .. -1 ].join )
      end
    end
    retVal.bb = @bb.copy
    retVal.hrbb = @hrbb.copy if @hrbb
    retVal.atfront = true
    retVal.hr_atfront = true
    retVal.npages = 1
    return retVal
  end # eps_clean

  ##################

  # Use the Ghostscript bbox device to give an eps a tight boundingbox.
  # Here, we don't test for use_hires_bb.
  # The eps should already have been cleaned up by eps_clean
  # and the current boundingbox should not contain negative coordinates,
  # otherwise the bbox output device may give incorrect results.
  # Maybe we should test whether gs' bbox device can handle
  # nonnegative coordinates.
  # The boundingbox in the eps is rewritten, but the eps is
  # not otherwise converted.
  # We don't create a new PsPdf object.

  def fix_bb

    fail EPCallError, buginfo \
        unless @type == 'eps' and @bb.non_negative
    # let ghostscript calculate new boundingbox
    cmd = $settings.gs_prog + ' ' + PsPdf.gs_options +
      " -sDEVICE=bbox \"" + @path + "\" 2>&1"
    write_log cmd # if $DEBUG
    bb_output = `#{cmd}`
    # inspect the result
    fail EPSystemError, cmd unless $? == 0 and bb_output
    bb_output.split(/\r\n?|\n/).each do |b|
      if b =~ BB_PAT
        bb_temp = Bb.from_comment( b )
        fail EPBBError, bb_output unless bb_temp.valid
        bb_temp.expand unless $settings.use_hires_bb
        @bb = bb_temp.copy
      elsif b =~ HRBB_PAT
        bb_temp = HRBb.from_hrcomment( b )
        @hrbb = bb_temp.valid ? bb_temp.copy : nil
      end
    end # do |b|
    fail EPBBError, bb_output unless @bb
    # this won't happen, but we deal with it anyway:
    @hrbb = HRBb.new( @bb.llx, @bb.lly, @bb.urx, @bb.ury ) unless @hrbb

    # locate current [hr]boundingbox, which ha[s|ve] to be replaced
    # assumptions: both in header, and hrbb no later than
    # first line after bb.
    slurp = ''
    File.open( @path, $R ) do |fl|
      slurp = fl.read( [File.size(@path),SAFESIZE].min )
    end
    pre_lines = slurp.split( /(\r\n?|\n)/ )
    i_bb = -1
    i_hrbb = -1
    i = -1
    i_end = -1
    pre_length = 0
    pre_lines.each do |l|
      pre_length += l.length
      i += 1
      next if l =~ /(\r\n?|\n)/
      if l =~ BB_PAT
        i_bb = i
      elsif l =~ HRBB_PAT
        i_hrbb = i
      elsif i_bb >= 0
        i_end = i
        break # stop looking; we expect hrbb next to bb
      end # =~ BB_PAT
    end # do |l,i|
    fail EPBBError, "No boundingbox found in #{@path}" if i_bb < 0

    # replace boundingbox[es] by editing initial part pre_block
    # and copying the rest byte for byte
    if i_hrbb < 0
      # no old hrbb; replace bb with new bb and new hrbb
      # pre_lines[i_bb+1] should match /\r\n?|\n/
      pre_lines[i_bb].sub!( BB_PAT, @bb.comment +
        pre_lines[i_bb+1] + @hrbb.hrcomment )
    else
      pre_lines[i_bb].sub!( BB_PAT, @bb.comment )
      pre_lines[i_hrbb].sub!( HRBB_PAT, @hrbb.hrcomment )
    end
    oldpath = @path
    @path = mktemp( 'eps' )
    File.open( @path, $W ) { |fl|
      fl.write( pre_lines[ 0 .. i_end ].join ) }
    sliceFile( oldpath, @path, \
      File.size( oldpath ) - pre_length, pre_length, $A )
    return self

  end # fix_bb

  ##################

  # Convert eps to pdf.
  # The eps should already have a boundingbox in the header.

  def eps_to_pdf( params={} )

    gray = params[ 'gray' ]

    fail EPCallError, buginfo( params ) unless @type == 'eps' and @atfront

    wrp = ( $settings.use_hires_bb and @hrbb ) ? @hrbb.wrapper : @bb.wrapper

    retVal = PsPdf.new( 'ext' => 'pdf' )
    cmd = "\"#{$settings.gs_prog}\" #{PsPdf.gs_options}" +
      " -sDEVICE=pdfwrite #{PsPdf.pdf_options}" +
      " -sOutputFile=\"#{retVal.path}\"" +
      ( gray ? (' "' + $GRAYHEAD + '"') : "" ) +
      " \"#{wrp}\" \"#{@path}\" -c grestore"
      write_log cmd # if $DEBUG
    fail EPSystemError, cmd \
      unless system( cmd ) and test( ?s, retVal.path )
    retVal.npages = 1
    return retVal

  end # eps_to_pdf

  ##################

  # Convert source pdf to eps.
  # The option sep_color is ignored if pdftops is not available.

  def pdf_to_eps( params={} )

    page = params[ 'page' ] ? params[ 'page' ].to_i : 1
    sep = params[ 'sep' ]

    fail EPCallError, buginfo( params ) unless @type == 'pdf'
    fail EPCallError, buginfo( params ) \
      unless page > 0 and page <= @npages
    retVal = PsPdf.new( 'ext' => 'eps' )
    if $settings.pdftops_prog and $settings.use_pdftops
      cmd = "\"#{$settings.pdftops_prog}\"" +
        " #{PsPdf.ps_options( sep )}" +
        " -paper match -eps -f #{page} -l #{page}" +
        " \"#{@path}\" \"#{retVal.path}\""
    else
      cmd = "\"#{$settings.gs_prog}\" -sDEVICE=epswrite -r600" +
        " #{PsPdf.gs_options}" +
        " -dFirstPage=#{page}" +
        " -dLastPage=#{page}" +
        " -sOutputFile=\"#{retVal.path}\" \"#{@path}\""
    end
    write_log cmd # if $DEBUG
    fail EPSystemError, cmd unless \
      system( cmd ) and test( ?s, retVal.path )

# fix for incorrect DSC header produced by some versions of pdftops:
# if necessary, change line `% Produced by ...' into `%%Produced by ...'
# this is usually the second line.
# otherwise the DSC header would be terminated before the bbox comment
#   match first chk_ze chars against `% Produced by'
    chk_size = [ 1500, File.size( retVal.path ) ].min
    slurp = ''
    File.open( retVal.path, $R ) do |fl|
      slurp = fl.read( chk_size )
    end # File
    pdfpat = /([\r\n])% Produced by/m
    if slurp =~ pdfpat
      newpath = mktemp( 'eps' )
      write_log "pdftops header fix #{retVal.path} => #{newpath}"
      File.open( newpath, $W ) do |fl2|
        fl2.write( slurp.sub( pdfpat, '\1%% Produced by)' ) )
      end
      sliceFile( retVal.path, newpath, File.size( retVal.path ) - chk_size,
          chk_size, $A )
      retVal.path = newpath
    end # if =~
# end fix for incorrect DSC header produced by some versions of pdftops
    retVal.atfront = 1
    retVal.find_bb_simple
    retVal.npages = 1
    return retVal

  end # pdf_to_eps

  ##################

  def ps_to_pdf( params={} )

    gray = params[ 'gray' ]

    fail EPCallError, buginfo( params ) \
      unless @type == 'ps'

    retVal = PsPdf.new( 'ext' => 'pdf' )
    cmd = "\"#{$settings.gs_prog}\" #{PsPdf.gs_options}" +
      " -sDEVICE=pdfwrite #{PsPdf.pdf_options}" +
      " -sOutputFile=\"#{retVal.path}\"" +
      ( gray ? (' "' + $GRAYHEAD + '"') : "" ) + " \"#{@path}\""
    write_log cmd # if $DEBUG
    fail EPSystemError, cmd \
      unless system( cmd ) and test( ?s, retVal.path )

    retVal.pdf_pages
    return retVal

  end # def ps_to_pdf

  ##################

  def pdf_to_ps( params={} )

    sep = params[ 'sep' ]
    page = params[ 'page' ] ? params[ 'page' ].to_s : nil

    fail EPCallError, buginfo( params ) unless @type == 'pdf'
    retVal = PsPdf.new( 'ext' => 'ps' )
    if $settings.pdftops_prog and $settings.use_pdftops
      cmd = "\"#{$settings.pdftops_prog}\" #{PsPdf.ps_options( sep )}" +
        ( page ? " -f #{page} -l #{page}" : '' ) +
        " -paper match \"#{@path}\" \"#{retVal.path}\""
    else
      cmd = "\"#{$settings.gs_prog}\" #{PsPdf.gs_options}" +
      " -sDEVICE=pswrite -r600" +
        ( page ? " -dFirstPage=#{page} -dLastPage#{page}" : '' ) +
      " -sOutputFile=\"#{retVal.path}\"" + " \"#{@path}\""
    end
      write_log cmd # if $DEBUG
    fail EPSystemError, cmd unless \
      system( cmd ) and test( ?s, retVal.path )
    retVal.npages = @npages
    return retVal

  end # pdf_to_ps

  ##################

  # all possible conversions, as concatenations of direct conversions.

  def any_to_any( params={} )

    type = params[ 'type' ]
    page = params[ 'page' ]
    bbox = params[ 'bbox' ]
    gray = params[ 'gray' ]
    gRAY = params[ 'gRAY' ] # try harder to grayscale
    gray = 1 if gRAY
    bbox = nil if type == 'ps'

    fail EPCallError, buginfo( params ) \
      unless ( type=='eps' or type=='pdf' or type=='ps' )
    fail EPCallError, buginfo( params ) \
      if @type=='other'
    fail EPCallError, buginfo( params ) \
      if type=='ps' and bbox
    fail EPCallError, buginfo( params ) \
      if @type=='eps' and type=='ps'

    # gRAY tries harder to grayscale, by converting color first to cmyk
    # even if it requires an additional eps - pdf - eps roundtrip.
    # Normally, conversion to cmyk is done only if it doesn't take
    # an extra roundtrip.
    # The separable color conversion is an option of pdftops.

    pp = self

    pp = pp.eps_clean if pp.type == 'epsPreview'
    pp = pp.eps_clean if pp.type == 'eps' and \
      not ( pp.bb and pp.atfront ) # => not yet `cleaned'
    #pp.pdf_pages if pp.type == 'pdf' and not pp.npages
    # now also done in initialize

    case pp.type
    when 'eps'

      # in some cases extra eps => pdf => eps roundtrip:
      # roundtrip guarantees bb.non_negative, necessary for fix_bb.
      # pdf_to_ps( sep ) improves chances of grayscaling.

      case type
      when 'eps'
        pp = pp.eps_to_pdf.pdf_to_eps( 'sep' => gray ) \
          if gRAY or ( bbox and not pp.bb.non_negative )
        pp = pp.eps_to_pdf( 'gray' => gray ).pdf_to_eps if gray
        pp = pp.fix_bb if bbox
        return pp

      when 'pdf'
        pp = pp.eps_to_pdf.pdf_to_eps( 'sep' => gray ) \
          if gRAY or ( bbox and not pp.bb.non_negative )
        pp = pp.fix_bb if bbox
        return pp.eps_to_pdf( 'gray' => gray )

      when 'ps'
        if gRAY
          pp = pp.eps_to_pdf.pdf_to_ps( 'sep' => gray )
          pp = pp.ps_to_pdf( 'gray' => gray ).pdf_to_ps
        else
          pp = pp.eps_to_pdf( 'gray' => gray ).pdf_to_ps
        end
        return pp

      end # case type

    when 'pdf'

      case type
      when 'eps'
        if not gray
          pp = pp.pdf_to_eps( 'page' => page )
          pp = pp.fix_bb if bbox
          return pp
        else
          pp = pp.pdf_to_eps( 'page' => page, 'sep' => 1 )
          pp = pp.fix_bb if bbox
          pp = pp.eps_to_pdf( 'gray' => 1 )
          return pp.pdf_to_eps
        end

      when 'pdf'
        return pp unless ( gray or bbox or page )
        if bbox or not $settings.pdftops_prog
          pp = pp.pdf_to_eps( 'page' => page, 'sep' => gray )
          pp = pp.fix_bb if bbox
          return pp.eps_to_pdf( 'gray' => gray )
        else
          pp = pp.pdf_to_ps( 'page' => page, 'sep' => gray )
          return pp.ps_to_pdf( 'gray' => gray )
        end

      when 'ps'
        if gray
          pp = pp.pdf_to_ps( 'sep' => 1 )
          pp = pp.ps_to_pdf( 'gray' => 1 )
        end
        return pp.pdf_to_ps

      end # case type

    when 'ps'

      case type
      when 'eps'
        if gRAY
          pp = pp.ps_to_pdf.pdf_to_eps( 'page' => page, 'sep' => 1 )
          pp = pp.eps_to_pdf( 'gray' => 1 )
          pp = pp.pdf_to_eps
        else
          pp = pp.ps_to_pdf( 'gray' => gray )
          pp = pp.pdf_to_eps( 'page' => page )
        end
        return pp.fix_bb

      when 'pdf'
        if bbox
          pp = pp.ps_to_pdf.pdf_to_eps( 'sep' => gray, 'page' => page )
          pp = pp.fix_bb
          return pp = pp.eps_to_pdf( 'gray' => gray )
        elsif page
          pp = pp.ps_to_pdf.pdf_to_ps( 'sep' => gray, 'page' => page )
          return pp = pp.ps_to_pdf( 'gray' => gray )
        else
          pp = pp.ps_to_pdf.pdf_to_ps( 'sep' => 1 ) if gRAY
          return pp.ps_to_pdf( 'gray' => gray )
        end

      when 'ps'
        return pp unless page or gray
        if gRAY
          pp = pp.ps_to_pdf.pdf_to_ps( 'page' => page, 'sep' => 1 )
          return pp.ps_to_pdf( 'gray' => 1 ).pdf_to_ps
        else
          pp = pp.ps_to_pdf( 'gray' => gray )
          return pp = pp.pdf_to_ps( 'page' => page )
        end

      end # case type

    end # case pp.type

    #raise EPCallError
    fail "Unsupported conversion"
    # this shouldn't happen anymore

  end # any_to_any

end # class PsPdf

#################################
# main program

require 'optparse'

def gui( action )
  case action
  when 'config_w' then
    puts "pdftops_prog=#{$settings.pdftops_prog}" if ARCH=='w32'
    puts "pdf_viewer=#{$settings.pdf_viewer}" if ARCH=='unix'
    puts "ps_viewer=#{$settings.ps_viewer}" if ARCH=='unix'
    puts "defaultDir=#{$settings.defaultDir}"
    puts "ignore_pdftops=#{$settings.ignore_pdftops}"
    puts "pdf_target=#{$settings.pdf_target}"
    puts "pdf_version=#{$settings.pdf_version}"
    puts "pdf_custom=#{$settings.pdf_custom}"
    puts "ps_options=#{$settings.ps_options}"
    puts "ignore_hires_bb=#{$settings.ignore_hires_bb}"
    puts "bb_spread=#{$settings.bb_spread}"
    exit
  when 'config_r' then
    while line = gets
      (varname, val) = line.split('=', 2)
      varname.strip! if varname
      val.strip! if val
      if $settings.has_key?( varname )
        val = nil if val == ''
        $settings[varname].val = val
        # puts( "\"#{val}\" assigned to #{varname}" )
      end
    end # while
    $settings.write_settings
    exit
  when nil then
    $from_gui = true
  else
    abort( "Action should be omitted or 'config_w' or 'config_r'" )
  end # case
end

# create a pause to examine temp files
def abortt( msg )
  if $DEBUG
    $stderr.puts msg + "\nPress <enter> to finish"
    $stdin.gets
  end
  fail
end

save_settings = false

opts = OptionParser.new do |opts|
  # for help output
  opts.banner = "Convert between [e]ps and pdf formats"
  opts.separator "Usage: epspdf.rb [options] infile [outfile]"
  opts.separator ""
  opts.separator "Default for outfile is file.pdf" +
    " if infile is file.eps or file.ps"
  opts.separator "Default for outfile is file.eps" +
    " if infile is file.pdf"
  opts.separator ""

  opts.on( "-g", "--gray", "--grey",
    "Convert to grayscale;",
    "success not guaranteed" ) do |opt|
      $options.gray = true
  end

  opts.on( "-G", "--GRAY", "--GREY",
    "Try harder to convert to grayscale" ) do |opt|
      $options.gRAY = true
  end

  opts.on( "-p PAGENUMBER", "--pagenumber=PAGENUMBER",
      "Page to be converted or selected", Integer ) do |opt|
    $options.page = opt
  end

  opts.on( "-b", "--bbox", "--BoundingBox",
    "Compute tight boundingbox" ) do |opt|
      $options.bbox = true
  end

  opts.on( "-n", "--no-hires",
    "Don't use hires boundingbox" ) do |opt|
      $settings.ignore_hires_bb = '1'
  end

  opts.on( "-r", "--hires",
    "Use hires boundingbox" ) do |opt|
      $settings.ignore_hires_bb = '0'
  end

  opts.on( "-T TARGET", "--target=TARGET",
      PDF_TARGETS,
      "Target use of pdf; one of",
      "#{PDF_TARGETS.join( ', ' )}" ) do |opt|
    $settings.pdf_target = opt
  end

  opts.on( "-N PDFVERSION", "--pdfversion=PDFVERSION",
      PDF_VERSIONS,
      "Pdf version to be generated" ) do |opt|
    $settings.pdf_version = opt
  end

  opts.on( "-V PDFVERSION", "--version=PDFVERSION",
      PDF_VERSIONS,
      "Deprecated; use `-N' or `--pdfversion'." ) do |opt|
      if opt == ""
        puts EPVERSION
        exit
      end
    $settings.pdf_version = opt
  end

  opts.on( "-I",
      "Ignore pdftops even if available",
      "(default: use if available)" ) do |opt|
    $settings.ignore_pdftops = '1'
  end

  opts.on( "-U",
      "Use pdftops if available",
      "(overrides previous -I setting)" ) do |opt|
    $settings.ignore_pdftops = '0'
  end

  opts.on( "-C CUSTOMOPTIONS", "--custom=CUSTOMOPTIONS",
      "Custom options for conversion to pdf,",
      "view Use.htm and ps2pdf.htm from",
      "the Ghostscript documentation set" ) do |opt|
    $settings.pdf_custom = opt
  end

  opts.on( "-P PSOPTIONS", "--psoptions=PSOPTIONS",
       "Options for pdftops; default -level3,",
       "don't include -eps or page number options;",
       "these will be generated by the program" ) do |opt|
    $settings.ps_options = opt
  end

  opts.on( "-i", "--info",
    "Info: display detected filetype" ) do |opt|
      $options.info = true
  end

  opts.on( "-s",
    "Save (some) settings" ) do |opt|
      save_settings = true
  end

  opts.on( "-d", "Debug: don't remove temp files" ) do |opt|
    $DEBUG = 1
  end

  opts.on( "--gui[=ACTION]", "Do not use; reserved for GUI" ) do |opt|
    gui( opt )
  end

  opts.separator ""

  opts.on( "-v", "Prints version info" ) do |opt|
    puts EPVERSION
    exit
  end

  opts.on_tail("-h", "--help", "Show this message") do
    puts "Epspdf version " + EPVERSION
    puts "Copyright (C) " + COPYRIGHT + " Siep Kroonenberg"
    puts opts
    exit
  end
end # opts

# hack alert! we support `--version' for version info although
# --version is still interpreted as desired pdf output version

if ARGV.length == 1 and ARGV[0] == '--version'
  puts EPVERSION
  exit
end

# save original command-line for later reporting
cmdline = "#{$0} #{ARGV.join( sep=' ' )}"

# parse options destructively
begin
  opts.parse!( ARGV )
rescue OptionParser::ParseError => e
  STDERR.puts e.message, "\n", opts
  exit( -1 )
end

# log cmdline AFTER we found out whether we run from gui
write_log( cmdline )

$options.page = 1 if $options.bbox and not $options.page

$settings.write_settings if save_settings

if ARGV.length < 1
  if not save_settings # help output
    puts opts
    abort
  else
    exit
  end
elsif $options.info
  p = PsPdf.new( 'file' => ARGV[0] )
  puts( p.file_info )
  exit
elsif ARGV.length > 1 and
    File.expand_path( ARGV[0] ) == File.expand_path( ARGV[1] )
  abort " Input and output files should be different."
else
  infile = ARGV[0]
  abort( infile + " not found or empty" ) unless test( ?s, infile )
end

# done with options

########################################

source = PsPdf.new( 'file' => infile )

# We aren't finicky about the extension of the input file,
# but still want to check whether pdf is pdf.

case source.type
when 'eps', 'epsPreview', 'ps'
  abort "Wrong extension; input is not in pdf format" \
    if infile =~ /\.pdf$/i
when 'pdf'
  abort "Wrong extension; input is in pdf format" \
    if infile !~ /\.pdf$/i
else
  abort "Invalid input file type; not [e]ps or pdf" \
    if source.type == 'other'
end # case source.type

# find or construct output file name
if ARGV.length > 1
  outfile = ARGV[1]
else
  case source.type
  when 'eps', 'epsPreview', 'ps'
    outfile = infile.sub( /\.[^.]+$/, '.pdf' )
  when 'pdf'
    outfile = infile.sub( /\.[^.]+$/, '.eps' )
  end # case
end # ifthenelse ARGV.length
outfile = File.expand_path( outfile )

$options.type = case outfile
when /\.pdf$/i
  "pdf"
when /\.ps$/i
  "ps"
when /\.eps$/i
  "eps"
else
  nil
end # case outfile

abort "Unknown or unsupported output file extension" \
  unless $options.type
#abort "Output format not supported without xpdf utilities" \
#  if outfile == 'ps' and not $settings.pstopdf_prog

pp = PsPdf.new( 'file' => infile )

begin # inner rescue block
  pp = pp.any_to_any( $options )
  write_log( pp.file_info ) if $from_gui
  ccp( pp.path, outfile )
rescue EPCallError => exc
  mess =
   "Wrong method call or conversion not supported or wrong page number" +
      $/ + exc.message + $/ + exc.backtrace.join( $/ )
  write_log( mess )
  puts mess
  exit 1
rescue EPBBError => exc
  mess = "Boundingbox problem" + $/ +
      exc.message + $/ + exc.backtrace.join( $/ )
  write_log( mess )
  puts mess
  exit 1
rescue EPCopyError => exc
  mess = "Copying problem" + $/ +
      exc.message + $/ + exc.backtrace.join( $/ )
  write_log( mess )
  puts mess
  exit 1
rescue EPSystemError => exc
  mess = "Problem with system call" + $/ +
      exc.message + $/ + exc.backtrace.join( $/ )
  write_log( mess )
  puts mess
  exit 1
rescue StandardError => exc
  mess = exc.message + $/ + exc.backtrace.join( $/ )
  write_log( mess )
  puts mess
  exit 1
end # rescue block

cleantemp unless $DEBUG == 1
__END__
