package PDF::Reuse;

use 5.006;
use strict;
use warnings;

require    Exporter;                  
require    Digest::MD5;
use autouse 'Carp' => qw(carp
                         cluck
                         croak);

# commented out avoid dependency for XeTeX installation
# use Compress::Zlib qw(compress inflateInit);

use autouse 'Data::Dumper'   => qw(Dumper);

# changed for xetex installation to remove file system clutter
# use AutoLoader 'AUTOLOAD';
use SelfLoader; 

our $VERSION = '0.292';
our @ISA     = qw(Exporter);
our @EXPORT  = qw(prFile
                  prPage
                  prId
                  prIdType
                  prInitVars
                  prEnd
                  prExtract
                  prForm
                  prImage
                  prJpeg
                  prDoc
                  prDocForm
                  prFont
                  prFontSize
                  prGraphState
                  prGetLogBuffer
                  prAdd
                  prBar
                  prText
                  prDocDir
                  prLogDir
                  prLog
                  prVers
                  prCid
                  prJs
                  prInit
                  prField
                  prTouchUp
                  prCompress
                  prMbox
                  prBookmark
                  prStrWidth
                  prLink);

our ($utfil, $slutNod, $formCont, $imSeq, $duplicateInits, $page, $sidObjNr, $sida,
    $interActive, $NamesSaved, $AARootSaved, $AAPageSaved, $root,
    $AcroFormSaved, $id, $ldir, $checkId, $formNr, $imageNr, 
    $filnamn, $interAktivSida, $taInterAkt, $type, $runfil, $checkCs,
    $confuseObj, $compress, $pos, $fontNr, $objNr,
    $defGState, $gSNr, $pattern, $shading, $colorSpace, $totalCount);
 
our (@kids, @counts, @formBox, @objekt, @parents, @aktuellFont, @skapa,
    @jsfiler, @inits, @bookmarks, @annots);
 
our ( %old, %oldObject, %resurser, %form, %image, %objRef, %nyaFunk, %fontSource, 
     %sidFont, %sidXObject, %sidExtGState, %font, %intAct, %fields, %script, 
     %initScript, %sidPattern, %sidShading, %sidColorSpace, %knownToFile,
     %processed, %embedded, %dummy, %behandlad, %unZipped, %links, %prefs);

our $stream  = '';
our $idTyp   = '';
our $ddir    = '';
our $log     = '';

#########################
# Konstanter för objekt
#########################

use constant   oNR        => 0;
use constant   oPOS       => 1;
use constant   oSTREAMP   => 2;
use constant   oKIDS      => 3;
use constant   oFORM      => 4;   
use constant   oIMAGENR   => 5;  
use constant   oWIDTH     => 6;  
use constant   oHEIGHT    => 7;  
use constant   oTYPE      => 8;
use constant   oNAME      => 9;

###################################
# Konstanter för formulär
###################################

use constant   fOBJ       => 0;
use constant   fRESOURCE  => 1;   
use constant   fBBOX      => 2;
use constant   fIMAGES    => 3;
use constant   fMAIN      => 4;
use constant   fKIDS      => 5;
use constant   fNOKIDS    => 6;
use constant   fID        => 7;
use constant   fVALID     => 8;

####################################
# Konstanter för images
####################################

use constant   imWIDTH     => 0;   
use constant   imHEIGHT    => 1; 
use constant   imXPOS      => 2;
use constant   imYPOS      => 3;
use constant   imXSCALE    => 4;
use constant   imYSCALE    => 5;
use constant   imIMAGENO   => 6;

#####################################
# Konstanter för interaktiva objekt
#####################################

use constant   iNAMES     => 1;
use constant   iACROFORM  => 2;
use constant   iAAROOT    => 3;
use constant   iANNOTS    => 4;
use constant   iSTARTSIDA => 5;
use constant   iAAPAGE    => 6;

#####################################
# Konstanter för fonter
#####################################
   
use constant   foREFOBJ     => 0;
use constant   foINTNAMN    => 1;
use constant   foEXTNAMN    => 2;
use constant   foORIGINALNR => 3;
use constant   foSOURCE     => 4;

##########
# Övrigt
##########

use constant IS_MODPERL => $ENV{MOD_PERL}; # For mod_perl 1.
                                           # For mod_perl 2 pass $r to prFile()
our $touchUp  = 1;

our %stdFont = 
       ('Times-Roman'           => 'Times-Roman',
        'Times-Bold'            => 'Times-Bold',
        'Times-Italic'          => 'Times-Italic',
        'Times-BoldItalic'      => 'Times-BoldItalic',
        'Courier'               => 'Courier',
        'Courier-Bold'          => 'Courier-Bold',
        'Courier-Oblique'       => 'Courier-Oblique',
        'Courier-BoldOblique'   => 'Courier-BoldOblique',
        'Helvetica'             => 'Helvetica',
        'Helvetica-Bold'        => 'Helvetica-Bold',
        'Helvetica-Oblique'     => 'Helvetica-Oblique',
        'Helvetica-BoldOblique' => 'Helvetica-BoldOblique',
        'Symbol'                => 'Symbol',
        'ZapfDingbats'          => 'ZapfDingbats', 
        'TR'  => 'Times-Roman',
        'TB'  => 'Times-Bold',
        'TI'  => 'Times-Italic',
        'TBI' => 'Times-BoldItalic',
        'C'   => 'Courier',
        'CB'  => 'Courier-Bold',
        'CO'  => 'Courier-Oblique',
        'CBO' => 'Courier-BoldOblique',
        'H'   => 'Helvetica',
        'HB'  => 'Helvetica-Bold',
        'HO'  => 'Helvetica-Oblique',
        'HBO' => 'Helvetica-BoldOblique',
        'S'   => 'Symbol',
        'Z'   => 'ZapfDingbats');

our $genLowerX    = 0;
our $genLowerY    = 0;
our $genUpperX    = 595,
our $genUpperY    = 842;
our $genFont      = 'Helvetica';
our $fontSize     = 12;

keys(%resurser)  = 10;

sub prFont
{   my $nyFont = shift;
    my ($intnamn, $extnamn, $objektnr, $oldIntNamn, $oldExtNamn);
    
    if (! $pos)
    {  errLog("No output file, you have to call prFile first");
    }
    $oldIntNamn = $aktuellFont[foINTNAMN];
    $oldExtNamn = $aktuellFont[foEXTNAMN]; 
    if ($nyFont)
    {  ($intnamn, $extnamn, $objektnr) = findFont($nyFont);
    }
    else
    {   $intnamn = $aktuellFont[foINTNAMN];
        $extnamn = $aktuellFont[foEXTNAMN];
    }
    if ($runfil)
    {  $log .= "Font~$nyFont\n";
    }
    if (wantarray)
    {  return ($intnamn, $extnamn, $oldIntNamn, $oldExtNamn);
    }
    else
    {  return $intnamn;
    }
}

sub prFontSize
{   my $fSize = shift || 12;
    my $oldFontSize = $fontSize;
    if ($fSize =~ m'\d+\.?\d*'o)
    { $fontSize = $fSize;
      if ($runfil)
      {  $log .= "FontSize~$fontSize\n";
      }
    }
    if (! $pos)
    {  errLog("No output file, you have to call prFile first");
    }

    return ($fontSize, $oldFontSize);    
}
    
sub prFile
{  if ($pos)
   {  prEnd();
      close UTFIL;
   }
   %prefs = ();
   my $param = shift;
   if (ref($param) eq 'HASH')
   {  $filnamn  = '-';
      for (keys %{$param})
      {   my $key = lc($_);
          if ($key eq 'name')
          {  $filnamn = $param->{$_}; }
          elsif (($key eq 'hidetoolbar')
          ||     ($key eq 'hidemenubar')
          ||     ($key eq 'hidewindowui')
          ||     ($key eq 'fitwindow')
          ||     ($key eq 'centerwindow'))
          {  $prefs{$key} = $param->{$_};
          }
      }    
   }
   else
   {  $filnamn  = $param || '-';
      $prefs{hidetoolbar}  = $_[1]  if defined $_[1];
      $prefs{hidemenubar}  = $_[2]  if defined $_[2];
      $prefs{hidewindowui} = $_[3]  if defined $_[3];
      $prefs{fitwindow}    = $_[4]  if defined $_[4];
      $prefs{centerwindow} = $_[5]  if defined $_[5];
   }
   my $kortNamn;
   if ($filnamn ne '-')
   {   my $ri  = rindex($filnamn,'/');
       if ($ri > 0)
       {  $kortNamn = substr($filnamn, ($ri + 1));
          $utfil = $ddir ? $ddir . $kortNamn : $filnamn; 
       }
       else
       {  $utfil = $ddir ? $ddir . $filnamn : $filnamn;
       }
       $ri = rindex($utfil,'/');
       if ($ri > 0)
       {   my $dirdel = substr($utfil,0,$ri);
           if (! -e $dirdel)
           {  mkdir $dirdel || errLog("Couldn't create dir $dirdel, $!");
           }
       }
       else
       {  $ri = rindex($utfil,'\\');
          if ($ri > 0)
          {   my $dirdel = substr($utfil,0,$ri);
              if (! -e $dirdel)
              {  mkdir $dirdel || errLog("Couldn't create dir $dirdel, $!");
              }
          }
       }
   }
   else
   {   $utfil = $filnamn;
   }
   if (ref $utfil eq 'Apache::RequestRec') # mod_perl 2
   { tie *UTFIL, $utfil;
   }
   elsif (IS_MODPERL && $utfil eq '-')     # mod_perl 1
   { tie *UTFIL, 'Apache';
   }
   else
   { open (UTFIL, ">$utfil") || errLog("Couldn't open file $utfil, $!");
   }
   binmode UTFIL;
   my $utrad = "\%PDF-1.4\n\%\â\ã\Ï\Ó\n";
   
   $pos   = syswrite UTFIL, $utrad; 

   if (defined $ldir)
   {   if ($utfil eq '-')
       {   $kortNamn = 'stdout';
       }
       if ($kortNamn)
       {  $runfil = $ldir . $kortNamn  . '.dat';
       }
       else
       {  $runfil = $ldir . $filnamn  . '.dat';
       }
       open (RUNFIL, ">>$runfil") || errLog("Couldn't open loggfile $runfil, $!");
       $log .= "Vers~$VERSION\n";        
   }

   
   @parents     = ();
   @kids        = ();
   @counts      = ();
   @objekt      = ();
   $objNr       = 2; # Reserverat objekt 1 för root och 2 för initial sidnod
   $parents[0]  = 2;
   $page        = 0;
   $formNr      = 0;
   $imageNr     = 0;
   $fontNr      = 0;
   $gSNr        = 0;
   $pattern     = 0;
   $shading     = 0;
   $colorSpace  = 0;
   $sida        = 0;
   %font        = ();
   %resurser    = ();
   %fields      = ();
   @jsfiler     = ();
   @inits       = ();
   %nyaFunk     = ();
   %objRef      = ();
   %knownToFile = ();
   @aktuellFont = ();
   %old         = ();
   %behandlad   = ();
   @bookmarks   = ();
   %links       = ();
   undef $defGState;
   undef $interActive;
   undef $NamesSaved;
   undef $AARootSaved;
   undef $AcroFormSaved;
   $checkId    = '';
   undef $duplicateInits;
   undef $confuseObj;
   $fontSize  = 12;
   $genLowerX = 0;
   $genLowerY = 0;
   $genUpperX = 595,
   $genUpperY = 842;
   
   prPage(1);
   $stream = ' ';                
   if ($runfil)
   {  $filnamn = prep($filnamn);
      $log .= "File~$filnamn";
      $log .= (exists $prefs{hidetoolbar}) ? "~$prefs{hidetoolbar}" : '~';
      $log .= (exists $prefs{hidemenubar}) ? "~$prefs{hidemenubar}" : '~';
      $log .= (exists $prefs{hidewindowui}) ? "~$prefs{hidewindowui}" : '~';
      $log .= (exists $prefs{fitwindow}) ? "~$prefs{fitwindow}" : '~';
      $log .= (exists $prefs{centerwindow}) ? "~$prefs{centerwindow}" : "~\n";
   }
   1;
}


sub prPage
{  my $noLogg = shift;
   if ((defined $stream) && (length($stream) > 0))
   { skrivSida();
   }
    
   $page++;
   $objNr++;
   $sidObjNr = $objNr;
   
   #
   # Resurserna nollställs
   #
  
   %sidXObject    = ();
   %sidExtGState  = ();
   %sidFont       = ();
   %sidPattern    = ();
   %sidShading    = ();
   %sidColorSpace = ();
   @annots        = ();
   
   undef $interAktivSida;
   undef $checkCs;
   if (($runfil) && (! $noLogg))
   {  $log .= "Page~\n";
       print RUNFIL $log;
       $log = '';
   }
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }
   1;
    
}

sub prText
{ my $xFrom = shift;
  my $y     = shift;
  my $TxT   = shift;
  my $how   = shift || '';

  my ($xTo, $rotate); 
  if (! defined $TxT)
  {  $TxT = '';
  } 

  if (($xFrom !~ m'[\d\.]+'o) || (! defined $xFrom))
  { errLog("Illegal x-position for text: $xFrom");
  } 
  if (($y !~ m'[\d\.]+'o) || (! defined $y))
  { errLog("Illegal y-position for text: $y");
  }

  if ($runfil)
  {   my $Texten   = prep($TxT);
      $log .= "Text~$xFrom~$y~$Texten~$how\n";
  } 

  if (! $aktuellFont[foINTNAMN])
  {  findFont();
  }
  my $Font        = $aktuellFont[foINTNAMN];        # Namn i strömmen
  $sidFont{$Font} = $aktuellFont[foREFOBJ];
  
  if ($how)
  {  $how = lc($how);
     if ($how eq 'right')
     {  $xTo    = $xFrom;
        $xFrom -= prStrWidth($TxT, $aktuellFont[foEXTNAMN], $fontSize);
     }
     elsif ($how eq 'center')
     {  my $width  = prStrWidth($TxT, $aktuellFont[foEXTNAMN], $fontSize);
        $xTo = $xFrom + ($width / 2);
        $xFrom =  $xTo - $width;    
     }
     elsif (($how ne 'left') && ($how =~ m'\d'o))
     {  $rotate = $how;
     }
     elsif (wantarray)
     {  $xTo = $xFrom + prStrWidth($TxT, $Font, $fontSize);
     }
  }
  elsif (wantarray)
  {  $xTo = $xFrom + prStrWidth($TxT, $Font, $fontSize);
  }

  $TxT =~ s|\(|\\(|gos;
  $TxT =~ s|\)|\\)|gos;

  unless ($rotate) 
  {   $stream .= "\nBT /$Font $fontSize Tf ";
      $stream .= "$xFrom $y Td \($TxT\) Tj ET\n";
  }
  else
  {   if ($rotate =~ m'q(\d)'oi)
      {  if ($1 eq '1')
         {  $rotate = 270;
         }
         elsif ($1 eq '2')
         {  $rotate = 180;
         }
         else
         {  $rotate = 90;
         }
      }
      my $radian = sprintf("%.6f", $rotate / 57.2957795);    # approx. 
      my $Cos    = sprintf("%.6f", cos($radian));
      my $Sin    = sprintf("%.6f", sin($radian));
      my $negSin = $Sin * -1;
      $stream .= "BT /$Font $fontSize Tf\n"
               . "$Cos $Sin $negSin $Cos $xFrom $y Tm\n"
               . "($TxT) Tj ET\n";   
  }

  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }

  if (wantarray)
  {   return ($xFrom, $xTo);
  }      
  else
  {   return 1;
  }  
}


sub prAdd
{  my $contents = shift;
   $stream .= "\n$contents\n";
   if ($runfil)
   {   $contents = prep($contents);
       $log .= "Add~$contents\n";
   }
   $checkCs = 1;
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }
   1;
}

########################## 
# Ett grafiskt "formulär" 
##########################

sub prForm
{ my ($sidnr, $adjust, $effect, $tolerant, $infil, $x, $y, $size, $xsize,
      $ysize, $rotate);
  my $param = shift;
  if (ref($param) eq 'HASH')
  {  $infil    = $param->{'file'};
     $sidnr    = $param->{'page'} || 1;
     $adjust   = $param->{'adjust'} || '';
     $effect   = $param->{'effect'} || 'print';
     $tolerant = $param->{'tolerant'} || '';
     $x        = $param->{'x'} || 0;
     $y        = $param->{'y'} || 0;
     $rotate   = $param->{'rotate'} || 0;
     $size     = $param->{'size'} || 1;
     $xsize    = $param->{'xsize'} || 1;
     $ysize    = $param->{'ysize'} || 1;
  }
  else
  {  $infil    = $param;
     $sidnr    = shift || 1;
     $adjust   = shift || '';
     $effect   = shift || 'print';
     $tolerant = shift || '';
     $x        = shift || 0;
     $y        = shift || 0;
     $rotate   = shift || 0;
     $size     = shift || 1;
     $xsize    = shift || 1;
     $ysize    = shift || 1;
  }
  
  my $refNr;
  my $namn;
  $type = 'form';  
  my $fSource = $infil . '_' . $sidnr;
  if (! exists $form{$fSource})
  {  $formNr++;
     $namn = 'Fm' . $formNr;
     $knownToFile{$fSource} = $namn;
     my $action;
     if ($effect eq 'load')
     {  $action = 'load'
     }
     else
     {  $action = 'print'
     }     
     $refNr         = getPage($infil, $sidnr, $action);
     if ($refNr)
     {  $objRef{$namn} = $refNr; 
     }
     else
     {  if ($tolerant)
        {  if ((defined $refNr) && ($refNr eq '0'))   # Sidnumret existerar inte, men ok
           {   $namn = '0';
           }
           else
           {   undef $namn;   # Sidan kan inte användas som form
           }
        }
        elsif (! defined $refNr)
        {  my $mess = "$fSource can't be used as a form. Try e.g. to\n"
                    . "save the file as postscript, and redistill\n";
           errLog($mess);
        }
        else
        {  errLog("File : $infil  Page: $sidnr  doesn't exist");
        }
     }
  }
  else
  {  if (exists $knownToFile{$fSource})
     {  $namn = $knownToFile{$fSource};
     }
     else
     {  $formNr++;
        $namn = 'Fm' . $formNr;
        $knownToFile{$fSource} = $namn;
     }
     if (exists $objRef{$namn})
     {  $refNr = $objRef{$namn};
     }
     else
     {  if (! $form{$fSource}[fVALID])
        {  my $mess = "$fSource can't be used as a form. Try e.g. to\n"
                    . "save the file as postscript, and redistill\n";
           if ($tolerant)
           {  cluck $mess;
              undef $namn;
           }
           else
           {  errLog($mess);
           }
        }
        elsif ($effect ne 'load')
        {  $refNr         =  byggForm($infil, $sidnr);
           $objRef{$namn} =  $refNr;
        }
     }
  }
  my @BBox = @{$form{$fSource}[fBBOX]} if ($refNr);
  if (($effect eq 'print') && ($form{$fSource}[fVALID]) && ($refNr))
  {   if (! defined $defGState)
      { prDefaultGrState();
      }
  
      if ($adjust)
      {   $stream .= "q\n";
          $stream .= fillTheForm(@BBox, $adjust);
          $stream .= "\n/Gs0 gs\n";
          $stream .= "/$namn Do\n";
          $stream .= "Q\n";
      }
      elsif (($x) || ($y) || ($rotate) || ($size != 1) 
                  || ($xsize != 1)     || ($ysize != 1))
      {   $stream .= "q\n";
          $stream .= calcMatrix($x, $y, $rotate, $size, 
                     $xsize, $ysize, $BBox[2], $BBox[3]);
          $stream .= "\n/Gs0 gs\n";
          $stream .= "/$namn Do\n";
          $stream .= "Q\n";
      }
      else
      {   $stream .= "\n/Gs0 gs\n";   
          $stream .= "/$namn Do\n";
          
      }
      $sidXObject{$namn}   = $refNr;
      $sidExtGState{'Gs0'} = $defGState;
  }
  if ($runfil)
  {  $infil = prep($infil);
     $log .= "Form~$infil~$sidnr~$adjust~$effect~$tolerant";
     $log .= "~$x~$y~$rotate~$size~$xsize~$ysize\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }
  if (($effect ne 'print') && ($effect ne 'add'))
  {  undef $namn;
  }
  if (wantarray)
  {  my $images = 0;
     if (exists $form{$fSource}[fIMAGES])
     {  $images = scalar(@{$form{$fSource}[fIMAGES]});
     } 
     return ($namn, $BBox[0], $BBox[1], $BBox[2], 
             $BBox[3], $images);
  }
  else
  {  return $namn;
  }
}



##########################################################
sub prDefaultGrState
##########################################################
{  $objNr++;
   $defGState = $objNr;
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }

   $objekt[$objNr] = $pos;
   my $utrad = "$objNr 0 obj" . '<</Type/ExtGState/SA false/SM 0.02/TR2 /Default'
           . ">>endobj\n";
   $pos += syswrite UTFIL, $utrad;
   $objRef{'Gs0'} = $objNr;
   return ('Gs0', $defGState);
}

######################################################
# En font lokaliseras och fontobjektet skrivs ev. ut
######################################################

sub findFont()
{  no warnings;
   my $Font = shift || '';
      
   if (! (exists $fontSource{$Font}))        #  Fonten måste skapas
   {  if (exists $stdFont{$Font})
      {  $Font = $stdFont{$Font};}
      else
      {  $Font = $genFont; }                 # Helvetica sätts om inget annat finns
      if (! (exists $font{$Font}))
      {  $objNr++;
         $fontNr++;
         my $fontAbbr           = 'Ft' . $fontNr; 
         my $fontObjekt         = "$objNr 0 obj<</Type/Font/Subtype/Type1" .
                               "/BaseFont/$Font/Encoding/WinAnsiEncoding>>endobj\n";
         $font{$Font}[foINTNAMN]      = $fontAbbr; 
         $font{$Font}[foREFOBJ]       = $objNr;
         $objRef{$fontAbbr}           = $objNr;
         $fontSource{$Font}[foSOURCE] = 'Standard';
         $objekt[$objNr]              = $pos;
         $pos += syswrite UTFIL, $fontObjekt;
      }
   }
   else
   {  if (defined $font{$Font}[foREFOBJ])       # Finns redan i filen
      {  ; }
      else
      {  if ($fontSource{$Font}[foSOURCE] eq 'Standard')
         {   $objNr++;
             $fontNr++;
             my $fontAbbr           = 'Ft' . $fontNr; 
             my $fontObjekt         = "$objNr 0 obj<</Type/Font/Subtype/Type1" .
                                      "/BaseFont/$Font/Encoding/WinAnsiEncoding>>endobj\n";
             $font{$Font}[foINTNAMN]    = $fontAbbr; 
             $font{$Font}[foREFOBJ]     = $objNr;
             $objRef{$fontAbbr}         = $objNr;
             $objekt[$objNr]            = $pos;
             $pos += syswrite UTFIL, $fontObjekt;
         }
         else
         {  my $fSource = $fontSource{$Font}[foSOURCE];
            my $ri      = rindex($fSource, '_');
            my $Source  = substr($fSource, 0, $ri);
            my $Page    = substr($fSource, ($ri + 1));
            
            if (! $fontSource{$Font}[foORIGINALNR])
            {  errLog("Couldn't find $Font, aborts");
            }
            else
            {  my $namn = extractObject($Source, $Page,
                                        $fontSource{$Font}[foORIGINALNR], 'Font');
            } 
         }
      }
   }

   $aktuellFont[foEXTNAMN]   = $Font;
   $aktuellFont[foREFOBJ]    = $font{$Font}[foREFOBJ];
   $aktuellFont[foINTNAMN]   = $font{$Font}[foINTNAMN];
   
   $sidFont{$aktuellFont[foINTNAMN]} = $aktuellFont[foREFOBJ];
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }

   return ($aktuellFont[foINTNAMN], $aktuellFont[foEXTNAMN], $aktuellFont[foREFOBJ]);  
}

sub skrivSida
{  my ($compressFlag, $streamObjekt, @extObj);
   if ($checkCs)
   {  @extObj = ($stream =~ m'/(\S+)\s*'gso);
      checkContentStream(@extObj);
   }
   if (( $compress ) && ( length($stream)  > 99 ))
   {   my $output = compress($stream);
       if ((length($output) > 25) && (length($output) < (length($stream))))
       {  $stream = $output;
          $compressFlag = 1;
       }       
   }
      
   if (! $parents[0])
   { $objNr++;
     $parents[0] = $objNr;
   }
   my $parent = $parents[0];

   ##########################################   
   #  Interaktiva funktioner läggs ev. till
   ##########################################

   if ($interAktivSida)
   {  my ($infil, $sidnr) = split(/\s+/, $interActive);
      ($NamesSaved, $AARootSaved, $AAPageSaved, $AcroFormSaved) 
            = AcroFormsEtc($infil, $sidnr);     
   }

   ##########################
   # Skapa resursdictionary
   ##########################
   my $resursDict = "/ProcSet[/PDF/Text]";
   if (scalar %sidFont)
   {  $resursDict .= '/Font << ';
      my $i = 0;
      for (keys %sidFont)
      {  $resursDict .= "/$_ $sidFont{$_} 0 R";
      }
      
      $resursDict .= " >>";
   }
   if (scalar %sidXObject)
   {  $resursDict .= '/XObject<<';
      for (keys %sidXObject)
      {  $resursDict .= "/$_ $sidXObject{$_} 0 R";
      }
      $resursDict .= ">>";
   }
   if (scalar %sidExtGState)
   {  $resursDict .= '/ExtGState<<';
      for (keys %sidExtGState)
      {  $resursDict .= "\/$_ $sidExtGState{$_} 0 R";
      }
      $resursDict .= ">>";
   }
   if (scalar %sidPattern)
   {  $resursDict .= '/Pattern<<';
      for (keys %sidPattern)
      {  $resursDict .= "/$_ $sidPattern{$_} 0 R";
      }
      $resursDict .= ">>";
   }
   if (scalar %sidShading)
   {  $resursDict .= '/Shading<<';
      for (keys %sidShading)
      {  $resursDict .= "/$_ $sidShading{$_} 0 R";
      }
      $resursDict .= ">>";
   }
   if (scalar %sidColorSpace)
   {  $resursDict .= '/ColorSpace<<';
      for (keys %sidColorSpace)
      {  $resursDict .= "/$_ $sidColorSpace{$_} 0 R";
      }
      $resursDict .= ">>";
   }

      
   my $resursObjekt;
   
   if (exists $resurser{$resursDict})
   {  $resursObjekt = $resurser{$resursDict};  # Fanns ett identiskt,
   }                                           # använd det
   else
   {   $objNr++;
       if ( keys(%resurser) < 10)
       {  $resurser{$resursDict} = $objNr;  # Spara 10 första resursobjekten
       }
       $resursObjekt   = $objNr;
       $objekt[$objNr] = $pos;
       $resursDict     = "$objNr 0 obj<<$resursDict>>endobj\n";
       $pos += syswrite UTFIL, $resursDict ;
    }
    my $sidObjekt;

    if (! $touchUp)
    {   #
        # Contents objektet skapas
        #

        my $devX = "900";
        my $devY = "900";

        my $mellanObjekt = '<</Type/XObject/Subtype/Form/FormType 1';
        if (defined $resursObjekt)
        {  $mellanObjekt .= "/Resources $resursObjekt 0 R";
        }
        $mellanObjekt .= "/BBox \[$genLowerX $genLowerY $genUpperX $genUpperY\]" .
                     "/Matrix \[ 1 0 0 1 -$devX -$devY \]";

        my $langd = length($stream);
    
        $objNr++;
        $objekt[$objNr] = $pos;        
        if (! $compressFlag)
        {   $mellanObjekt  = "$objNr 0 obj\n$mellanObjekt/Length $langd>>stream\n" 
                           . $stream;
            $mellanObjekt .= "endstream\nendobj\n";
        }
        else
        {   $stream = "\n" . $stream . "\n";
            $langd++;
            $mellanObjekt  = "$objNr 0 obj\n$mellanObjekt/Filter/FlateDecode"
                           .  "/Length $langd>>stream" . $stream;
            $mellanObjekt .= "endstream\nendobj\n";
        }

        $pos += syswrite UTFIL, $mellanObjekt;
        $mellanObjekt = $objNr;

        if (! defined $confuseObj)
        {  $objNr++;
           $objekt[$objNr] = $pos;

           $stream = "\nq\n1 0 0 1 $devX $devY cm\n/Xwq Do\nq\n";
           $langd = length($stream);
           $confuseObj = $objNr;
           $stream = "$objNr 0 obj<</Length $langd>>stream\n" . "$stream";
           $stream .= "\nendstream\nendobj\n";
           $pos += syswrite UTFIL, $stream;
        }
        $sidObjekt = "$sidObjNr 0 obj\n<</Type/Page/Parent $parent 0 R/Contents $confuseObj 0 R"
                      . "/MediaBox \[$genLowerX $genLowerY $genUpperX $genUpperY\]"
                      . "/Resources <</ProcSet[/PDF/Text]/XObject<</Xwq $mellanObjekt 0 R>>>>";
    }
    else
    {   my $langd = length($stream);
    
        $objNr++;
        $objekt[$objNr] = $pos; 
        if (! $compressFlag)
        {  $streamObjekt  = "$objNr 0 obj<</Length $langd>>stream\n" . $stream;
           $streamObjekt .= "\nendstream\nendobj\n";
        }
        else
        {  $stream = "\n" . $stream . "\n";
           $langd++;

           $streamObjekt  = "$objNr 0 obj<</Filter/FlateDecode"
                             . "/Length $langd>>stream" . $stream;
           $streamObjekt .= "endstream\nendobj\n";
        }

        $pos += syswrite UTFIL, $streamObjekt;
        $streamObjekt = $objNr;
        ##################################
        # Så skapas och skrivs sidobjektet 
        ##################################

        $sidObjekt = "$sidObjNr 0 obj<</Type/Page/Parent $parent 0 R/Contents $streamObjekt 0 R"
                      . "/MediaBox \[$genLowerX $genLowerY $genUpperX $genUpperY\]"
                      . "/Resources $resursObjekt 0 R";
    }
    
    $stream = '';

    my $tSida = $sida + 1;
    if ((@annots) 
    || (defined @{$links{'-1'}}) 
    || (defined @{$links{$tSida}}))
    {  $sidObjekt .= '/Annots ' . mergeLinks() . ' 0 R';
    }
    if (defined $AAPageSaved)
    {  $sidObjekt .= "/AA $AAPageSaved";
       undef $AAPageSaved;
    }
    $sidObjekt .= ">>endobj\n";
    $objekt[$sidObjNr] = $pos;
    $pos += syswrite UTFIL, $sidObjekt;
    push @{$kids[0]}, $sidObjNr;
    $sida++;
    $counts[0]++;
    if ($counts[0] > 9)
    {  ordnaNoder(8); }
}


sub prEnd
{   if (! $pos)
    {  return;
    }
    if ($stream)
    { skrivSida(); }
    skrivUtNoder();
   
    ###################
    # Skriv root 
    ###################

    if (! defined $objekt[$objNr])
    {  $objNr--;                   # reserverat sidobjektnr utnyttjades aldrig
    }
    
    my $utrad = "1 0 obj<</Type/Catalog/Pages $slutNod 0 R";
    if (defined $NamesSaved)
    {  $utrad .= "\/Names $NamesSaved 0 R\n"; 
    }
    elsif ((scalar %fields) || (scalar @jsfiler))
    {  $utrad .= "\/Names " . behandlaNames() . " 0 R\n";
    }
    if (defined $AARootSaved)
    {  $utrad .= "/AA $AARootSaved\n";
    } 
    if ((scalar @inits) || (scalar %fields))
    {  my $nyttANr = skrivKedja();
       $utrad .= "/OpenAction $nyttANr 0 R";
    }
     
    if (defined $AcroFormSaved)
    {  $utrad .= "/AcroForm $AcroFormSaved\n";
    } 
   
    if (scalar @bookmarks)
    {  my $outLine = ordnaBookmarks();
       $utrad .= "/Outlines $outLine 0 R\n";
    }
    if (scalar %prefs)
    {   $utrad .= '/ViewerPreferences << ';
        if (exists $prefs{hidetoolbar})
        {  $utrad .= ($prefs{hidetoolbar}) ? '/HideToolbar true' 
                                           : '/HideToolbar false'; 
        }
        if (exists $prefs{hidemenubar}) 
        {  $utrad .= ($prefs{hidemenubar}) ? '/HideMenubar true'
                                           : '/HideMenubar false';
        }
        if (exists $prefs{hidewindowui})
        {  $utrad .= ($prefs{hidewindowui}) ? '/HideWindowUI true' 
                                            : '/HideWindowUI false';
        }
        if (exists $prefs{fitwindow})
        {  $utrad .= ($prefs{fitwindow}) ? '/FitWindow true'
                                         : '/FitWindow false';
        }
        if (exists $prefs{centerwindow})
        {  $utrad .= ($prefs{centerwindow}) ? '/CenterWindow true'
                                            : '/CenterWindow false';
        }
        $utrad .= '>> ';
    }
 
    $utrad .= ">>endobj\n";

    $objekt[1] = $pos;
    $pos += syswrite UTFIL, $utrad;
    my $antal = $#objekt;
    my $startxref = $pos;
    my $xrefAntal = $antal + 1;
    $pos += syswrite UTFIL, "xref\n";
    $pos += syswrite UTFIL, "0 $xrefAntal\n";
    $pos += syswrite UTFIL, "0000000000 65535 f \n";
    
    for (my $i = 1; $i <= $antal; $i++)
    {  $utrad = sprintf "%.10d 00000 n \n", $objekt[$i];
       $pos += syswrite UTFIL, $utrad;
    }
    
    $utrad  = "trailer\n<<\n/Size $xrefAntal\n/Root 1 0 R\n";
    if ($idTyp ne 'None')
    {  my ($id1, $id2) = definieraId();
       $utrad .= "/ID [<$id1><$id2>]\n";
       $log  .= "IdType~rep\n";
       $log  .= "Id~$id1\n";
    }
    $utrad .= ">>\nstartxref\n$startxref\n";
    $pos += syswrite UTFIL, $utrad; 
    $pos += syswrite UTFIL, "%%EOF\n";
    close UTFIL;

    if ($runfil)
    {   if ($log)
        { print RUNFIL $log;
        }
        close RUNFIL;
    }
    $log    = '';
    $runfil = '';
    $pos    = 0;
    1;   
}
    
sub ordnaNoder
{  my $antBarn = shift;
   my $i       = 0;
   my $j       = 1;
   my $vektor;
      
   while  ($antBarn < $#{$kids[$i]})
   {  # 
      # Skriv ut aktuell förälder
      # flytta till nästa nivå
      #
      $vektor = '[';
      
      for (@{$kids[$i]})
      {  $vektor .= "$_ 0 R "; }
      $vektor .= ']';

      if (! $parents[$j])
      {  $objNr++;
         $parents[$j] = $objNr;
      }
      
      my $nodObjekt;
      $nodObjekt = "$parents[$i] 0 obj<</Type/Pages/Parent $parents[$j] 0 R\n/Kids $vektor\n/Count $counts[$i]>>endobj\n";
      
      $objekt[$parents[$i]] = $pos;
      $pos += syswrite UTFIL, $nodObjekt;
      $counts[$j] += $counts[$i];
      $counts[$i]  = 0;
      $kids[$i]    = [];
      push @{$kids[$j]}, $parents[$i];
      undef $parents[$i];
      $i++;
      $j++;
   }
}
          
sub skrivUtNoder
{  no warnings;
   my ($i, $j, $vektor, $nodObjekt);
   my $si = -1;
   #
   # Hitta slutnoden
   #
   for (@parents)
   { $slutNod = $_; 
     $si++;
   }
   
   for ($i = 0; $parents[$i] ne $slutNod; $i++)
   {  if (defined $parents[$i])  # Bara definierat om det finns kids
      {  $vektor = '[';
         for (@{$kids[$i]})
         {  $vektor .= "$_ 0 R "; }
         $vektor .= ']';
         ########################################
         # Hitta förälder till aktuell förälder
         ########################################
         my $nod;
         for ($j = $i + 1; (! $nod); $j++)
         {  if ($parents[$j])
            {  $nod = $parents[$j];
               $counts[$j] += $counts[$i];
               push @{$kids[$j]}, $parents[$i];
            }
         }
      
         $nodObjekt = "$parents[$i] 0 obj<</Type/Pages/Parent $nod 0 R\n/Kids $vektor/Count $counts[$i]>>endobj\n";
      
         $objekt[$parents[$i]] = $pos;
         $pos += syswrite UTFIL, $nodObjekt;
      }
   }
   #####################################
   #  Så ordnas och skrivs slutnoden ut
   #####################################
   $vektor = '[';
   for (@{$kids[$si]})
   {  $vektor .= "$_ 0 R "; }
   $vektor .= ']';
   $nodObjekt  = "$slutNod 0 obj<</Type/Pages/Kids $vektor/Count $counts[$si]";
   $nodObjekt .= "/MediaBox \[$genLowerX $genLowerY $genUpperX $genUpperY\]";
   $nodObjekt .= " >>endobj\n";
   $objekt[$slutNod] = $pos;
   $pos += syswrite UTFIL, $nodObjekt;
          
}

sub findGet
{  my ($fil, $cid) = @_;
   $fil =~ s|\s+$||o;
   my ($req, $extFil, $tempFil, $fil2, $tStamp, $res);
   
   if (-e $fil)
   {  $tStamp = (stat($fil))[9];
      if ($cid)
      { 
        if ($cid eq $tStamp)
        {  return ($fil, $cid);
        }
      }
      else
      {  return ($fil, $tStamp);
      }
   }
   if ($cid)
   {  $fil2 = $fil . $cid;
      if (-e $fil2)
      {  return ($fil2, $cid);
      }
   }
   errLog("The file $fil can't be found, aborts");  
}
   
sub definieraId
{  if ($idTyp eq 'rep')
   {  if (! defined $id)
      {  errLog("Can't replicate the id if is missing, aborting"); 
      }
      my $tempId = $id;
      undef $id;
      return ($tempId, $tempId);
   }
   elsif ($idTyp eq 'add')
   {  $id++;
      return ($id, $id);
   }
   else   
   {  my $str = time();
      $str .= $filnamn . $pos;
      $str  = Digest::MD5::md5_hex($str);      
      return ($str, $str);
   }     
}
1;

__DATA__

=head1 NAME

PDF::Reuse - Reuse and mass produce PDF documents   

=head1 SYNOPSIS

=for SYNOPSIS.pl begin

   use PDF::Reuse;                     
   prFile('myFile.pdf');                   # Mandatory function
   prText(100, 500, 'Hello World !');
   prEnd();                                # Mandatory function to flush buffers

=for end

=head1 DESCRIPTION

This module could be used when you want to mass produce similar (but not identical)
PDF documents and reuse templates, JavaScripts and some other components. It is
functional to be fast, and to give your programs capacity to produce many pages
per second and very big PDF documents if necessary.

The module produces PDF-1.4 files. Some features of PDF-1.5, like "object streams"
and "cross reference streams", are supported, but only at an experimental level. More
testing is needed. (If you get problems with a new document from Acrobat 6.0, try to 
save it or recreate it as a PDF-1.4 document first, before using it together with 
this module.) 

=over 2

=item Templates

Use your favorite program, probably a commercial visual tool, to produce single 
PDF-files to be used as templates, and then use this module to B<mass produce> files 
from them. 

(If you want small PDF-files or want special graphics, you can use this module also,
but visual tools are often most practical.)

=item Lists

The module uses "XObjects" extensively. This is a format that makes it possible
create big lists, which are compact at the same time.

=item JavaScript

You can attach JavaScripts to your PDF-files, and "initiate" them (Acrobat 5.0, 
Acrobat Reader 5.0.5 or higher).

You can have libraries of JavaScripts. No cutting or pasting, and those who include 
the scripts in documents only need to know how to initiate them. (Of course those
who write the scripts have to know Acrobat JavaScript well.)

See Remarks about Javascript

=item PDF-operators

The module gives you a good possibility to program at a "low level" with the basic
graphic operators of PDF, if that is what you want to do. You can build your
own libraries of low level routines, with PDF-directives "controlled" by Perl.

=item Archive-format

If you want, you get your new documents logged in a format suitable for archiving 
or transfer.

=back

PDF::Reuse::Tutorial might show you best what you can do with this module.

=head2 Remarks about Javascript

If your user has Acrobat Reader 5.0.5 or higher, he/she should be able to use the 
functions with JavaScript. The Reader should have the option "Allow File Open
Actions and Launching File Attachments" checked under "Preferences".

If he/she uses Acrobat there is a complication. Everything should work fine as long
as new files are not read via the web. Acrobat has a plug in, "webpdf.api", which
converts documents, also PDF-documents, when they are fetched over the net.
That is probably a good idea in some cases, but B<it changes the documents, and 
there is a great risk that JavaScripts are lost>.

(In cases of real emergency, you can disable the plug in simply by removing it
from the directory Plug_ins under Acrobat, put it in a safe place, and start Acrobat.
And put it back before you need it next time.) 

Anyway, almost every computer has the Reader somewhere, and if it is not of the
right version, it can be downloaded. So with a little effort, it should be possible
to use also the functions with JavaScrips on most computers.

=head1 FUNCTIONS

All functions which are successful return specified values or 1.

The module doesn't make any attempt to import anything from encrypted files.

=head1 Mandatory Functions

=head2 prFile		- define output

Alternative 1:

   prFile ( $fileName );

Alternative 2 with parameters in an anonymous hash:

   prFile ( { Name         => $fileName,
              HideToolbar  => 1,            # 1 | 0
              HideMenubar  => 1,            # 1 | 0
              HideWindowUI => 1,            # 1 | 0
              FitWindow    => 1,            # 1 | 0
              CenterWindow => 1   } );      # 1 | 0

Alternative 3:

   prFile ( $r );  # For mod_perl 2 pass the request object

$fileName is optional, just like the rest of the parameters.
File to create. If another file is current when this function is called, the first
one is written and closed. Only one file is processed at a single moment. If
$fileName is undefined, output is written to STDOUT. 

HideToolbar, HideMenubar, HideWindowUI, FitWindow and CenterWindow control the
way the document is initially displayed. 

Look at any program in this documentation for examples. prInitVars() shows how
this function could be used together with a web server.

=head2 prEnd		- end/flush buffers 

   prEnd ()

When the processing is going to end, the buffers of the B<last> file has to be written to the disc.
If this function is not called, the page structure, xref part and so on will be 
lost.

Look at any program in this documentation for an example.

=head1 Optional Functions

=head2 prAdd		- add "low level" instructions 

    prAdd ( $string )

With this command you can add whatever you want to the current content stream.
No syntactical checks are made, but if you use an internal name, the module tries
to add the resource of the "name object" to the "Resources" of current page.
"Name objects" always begin with a '/'. 

(In this documentation I often use talk about an "internal name". It denotes a 
"name object". When PDF::Reuse creates these objects, it assigns Ft1, Ft2, Ft3 ...
for fonts, Im1, Im2, Im3 for images, Fo1 .. for forms, Cs1 .. for Color spaces,
Pt1 .. for patterns, Sh1 .. for shading directories, Gs0 .. for graphic state
parameter dictionaries. These names are kept until the program finishes, 
and my ambition is also to keep the resources available in internal tables.)

This is a simple and very powerful function. You should study the examples and 
the "PDF-reference manual", if you want to use it.(When this text is written,
a possible link to download it is: 
http://partners.adobe.com/asn/developer/acrosdk/docs.html) 

This function is intended to give you detail control at a low level.

   use PDF::Reuse;
   use strict;

   prFile('myFile.pdf');
   my $string = "150 600 100 50 re\n";  # a rectangle 
   $string   .= "0 0 1 rg\n";           # blue (to fill)
   $string   .= "b\n";                  # fill and stroke
   prAdd($string);                       
   prEnd(); 


=head2 prBookmark		- define bookmarks 

   prBookmark($reference)

Defines a "bookmark". $reference refers to a hash or array of hashes which look
something like this:
 
          {  text  => 'Document',
             act   => 'this.pageNum = 0; this.scroll(40, 500);',
             kids  => [ { text => 'Chapter 1',
                          act  => '1, 40, 600'
                        },
                        { text => 'Chapter 2',
                          act  => '10, 40, 600'
                        } 
                      ]
          }

Each hash can have these components:

        text    the text shown beside the bookmark
        act     the action to be triggered. Has to be a JavaScript action.
                (Three simple numbers are translated to page, x and y in the
                sentences: this.pageNum = page; this.scroll(x, y); )
        pdfact  an alternative to act: the raw PDF action to be triggered
                (act will be used if present, otherwise pdfact)
        kids    will have a reference to another hash or array of hashes
        close   if this component is present, the bookmark will be closed
                when the document is opened
        color   3 numbers, RGB-colors e.g. '0.5 0.5 1' for light blue
        style   0, 1, 2, or 3. 0 = Normal, 1 = Italic, 2 = Bold, 3 = Bold Italic

Creating bookmarks for a document:

    use PDF::Reuse;
    use strict;

    my @pageMarks;

    prFile('myDoc.pdf');

    for (my $i = 0; $i < 100; $i++)
    {   prText(40, 600, 'Something is written');
        # ...
        my $page = $i + 1;
        my $bookMark = { text => "Page $page",
                         act  => "$i, 40, 700" };
        push @pageMarks, $bookMark;
        prPage();
    }
    prBookmark( { text  => 'Document',
                  close => 1,
                  kids  => \@pageMarks } );
    prEnd();


Traditionally bookmarks have mainly been used for navigation within a document,
but they can be used for many more things. You can e.g. use them to navigate within
your data. You can let your users go to external links also, so they can "drill down"
to other documents.

B<See "Remarks about Javascript">

=head2 prCompress		- compress/zip added streams 

   prCompress (1)

'1' here is a directive to compress all B<new> streams of the current file. Streams
which are included with prForm, prDocForm and prDoc are not changed. New 
JavaScripts are also created as streams and compressed, if they are at least 100
bytes long. The streams are compressed in memory, so probably there is a limit of
how big they can be.

prCompress(); is a directive not to compress. This is default.

See e.g. "Starting to reuse" in the tutorial for an example.

=head2 prDoc		- include pages from a document 

   prDoc ( $documentName, $firstPage, $lastPage )

or with the parameters in an anonymous hash:

   prDoc ( { file  => $documentName,
             first => $firstPage,
             last  => $lastPage } );

Returns number of extracted pages.

If "first" is not given, 1 is assumed. If "last" is not given, you don't have any upper
limit. N.B. The numbering of the pages differs from Acrobat JavaScript. In JavaScript
the first page has index 0. 

Adds pages from a document to the one you are creating. If it is the first interactive
component ( prDoc() or prDocForm() ) the interactive functions are kept and also merged
with JavaScripts you have added, if any. But, if you specify a first page different than 1
or a last page, no JavaScript are extracted from the document, because then there is a
risk that an included JavaScript function might refer to something not included.

   use PDF::Reuse;
   use strict;

   prFile('myFile.pdf');                  # file to make
   prJs('customerResponse.js');           # include a JavaScript file
   prInit('nameAddress(12, 150, 600);');  # init a JavaScript function
   prForm('best.pdf');                    # page 1 from best.pdf
   prPage();                              # page break
   prDoc('long.pdf');                     # a document with 11 pages
   prPage();                              # page break
   prForm('best.pdf');                    # page 1 from best.pdf
   prText(150, 700, 'Customer Data');     # a line of text
   prEnd();

To extract pages 2-3 and 5-7 from a document and create a new document:

   use PDF::Reuse;
   use strict;
    
   prFile('new.pdf');
   prDoc( { file  => 'old.pdf',
            first => 2, 
            last  => 3 });
   prDoc( { file  => 'old.pdf',
            first => 5, 
            last  => 7 });
   prEnd();

=head2 prDocDir		- set directory for produced documents 

   prDocDir ( $directoryName )

Sets directory for produced documents

   use PDF::Reuse;
   use strict;

   prDocDir('C:/temp/doc');
   prFile('myFile.pdf');         # writes to C:\temp\doc\myFile.pdf
   prForm('myFile.pdf');         # page 1 from ..\myFile.pdf
   prText(200, 600, 'New text');
   prEnd();

=head2 prDocForm		- use an interactive page as a form 

Alternative 1) You put your parameters in an anonymous hash (only B<file> is really 
necessary, the others get default values if not given).

   prDocForm ( { file     => $pdfFile,       # template file
                 page     => $page,          # page number (of imported template)
                 adjust   => $adjust,        # try to fill the media box
                 effect   => $effect,        # action to be taken
                 tolerant => $tolerant,      # continue even with an invalid form
                 x        => $x,             # $x pixels from the left
                 y        => $y,             # $y pixels from the bottom
                 rotate   => $degree,        # rotate 
                 size     => $size,          # multiply everything by $size
                 xsize    => $xsize,         # multiply horizontally by $xsize
                 ysize    => $ysize } )      # multiply vertically by $ysize
Ex.:
    my $internalName = prDocForm ( {file     => 'myFile.pdf',
                                    page     => 2 } );
              
Alternative 2) You put your parameters in this order

	prDocForm ( $pdfFile, [$page, $adjust, $effect, $tolerant, $x, $y, $degree,
            $size, $xsize, $ysize] )


Anyway the function returns in list context:  B<$intName, @BoundingBox, 
$numberOfImages>, in scalar context:  B<$internalName> of the form.

Look at prForm() for an explanation of the parameters.

N.B. Usually you shouldn't adjust or change size and proportions of an interactive
page. The graphic and interactive components are independent of each other and there 
is a great risk that any coordination is lost. 

This function redefines a page to an "XObject" (the graphic parts), then the 
page can be reused in a much better way. Unfortunately there is an important 
limitation here. "XObjects" can only have single streams. If the page consists
of many streams, you should concatenate them first. Adobe Acrobat can do that.
(If it is an important file, take a copy of it first. Sometimes the procedure fails.)
You open the file with Acrobat and choose the "Touch Up" tool and change anything
graphic in the page. You could e.g. remove 1 space and put it back. Then you
save the file.

   use PDF::Reuse;
   use strict;

   prDocDir('C:/temp/doc');
   prFile('newForm.pdf');
   prField('Mr/Ms', 'Mr');
   prField('First_Name', 'Lars');
   prDocForm('myFile.pdf');
   prFontSize(24);
   prText(75, 790, 'This text is added');
   prEnd();

(You can use the output from the example in prJs() as input to this example.
Remember to save that file before closing it.)

B<See Remarks about Javascript>

=head2 prExtract		- extract an object group 

   prExtract ( $pdfFile, $pageNo, $oldInternalName )

B<oldInternalName>, a "name"-object.  This is the internal name you find in the original file.
Returns a B<$newInternalName> which can be used for "low level" programming. You
have better look at graphObj_pl and modules it has generated for the tutorial,
e.g. thermometer.pm, to see how this function can be used.  

When you call this function, the necessary objects will be copied to your new
PDF-file, and you can refer to them with the new name you receive.

=head2 prField		- assign a value to an interactive field 

	prField ( $fieldName, $value )

B<$fieldName> is an interactive field in the document you are creating.
It has to be spelled exactly the same way here as it spelled in the document.
B<$value> is what you want to assigned to the field.
Put all your sentences with prField early in your script. After prFile and B<before>
prDoc or prDocForm and of course before prEnd. Each sentence with prField is 
translated to JavaScript and merged with old JavaScript  

See prDocForm() for an example

If you are going to assign a value to a field consisting of several lines, you
can write like this:

   my $string = "This is the first line \r second line \n 3:rd line";
   prField('fieldName', $string);

You can also let '$value' be a  snippet of JavaScript-code that assigns something
to the field. Then you have to put 'js:' first in "$value" like this:

   my $sentence = encrypt('This will be decrypted by "unPack"(JavaScript) ');
   prField('Interest_9', "js: unPack('$sentence')");

If you refer to a JavaScript function, it has to be included with prJs first. (The
JavaScript interpreter will simply not be aware of old functions in the PDF-document,
when the initiation is done.)

B<The function prField uses JavaScript, so see "Remarks about Javascript">

=head2 prFont		- set current font 

   prFont ( $fontName )

$fontName is an "external" font name. The parameter is optional. 
In list context returns B<$internalName, $externalName, $oldInternalName,
$oldExternalname> The first two variables refer to the current font, the two later
to the font before the change. In scalar context returns b<$internalName>

If a font wasn't found, Helvetica will be set.
These names are always recognized:
B<Times-Roman, Times-Bold, Times-Italic, Times-BoldItalic, Courier, Courier-Bold,
Courier-Oblique, Courier-BoldOblique, Helvetica, Helvetica-Bold, Helvetica-Oblique,
Helvetica-BoldOblique> or abbreviated 
B<TR, TB, TI, TBI, C, CB, CO, CBO, H, HB, HO, HBO>. 
(B<Symbol and ZapfDingbats> or abbreviated B<S, Z>, also belong to the predefined
fonts, but there is something with them that I really don't understand. You should
print them first on a page, and then use other fonts, otherwise they are not displayed.)

You can also use a font name from an included page. It has to be spelled exactly as
it is done there. Look in the file and search for "/BaseFont" and the font
name. But take care, e.g. the PDFMaker which converts to PDF from different 
Microsoft programs, only defines exactly those letters you can see on the page. You
can use the font, but perhaps some of your letters were not defined. 

In the distribution there is an utility program, 'reuseComponent_pl', which displays
included fonts in a PDF-file and prints some letters. Run it to see the name of the
font and if it is worth extracting.

   use PDF::Reuse;
   use strict;
   prFile('myFile.pdf');

   ####### One possibility #########

   prFont('Times-Roman');     # Just setting a font
   prFontSize(20);
   prText(180, 790, "This is a heading");

   ####### Another possibility #######

   my $font = prFont('C');    # Setting a font, getting an  
                              # internal name
   prAdd("BT /$font 12 Tf 25 760 Td (This is some other text)Tj ET"); 
   prEnd();

The example above shows you two ways of setting and using a font. One simple, and
one complicated with a possibility to detail control. 


=head2 prFontSize		- set current font size 

   prFontSize ( $size )

Returns B<$actualSize, $fontSizeBeforetheChange>. Without parameters
prFontSize() sets the size to 12 pixels, which is default. 

=head2 prForm		- use a page from an old document as a form/background 

Alternative 1) You put your parameters in an anonymous hash (only B<file> is really 
necessary, the others get default values if not given).

   prForm ( { file     => $pdfFile,       # template file
              page     => $page,          # page number (of imported template)
              adjust   => $adjust,        # try to fill the media box
              effect   => $effect,        # action to be taken
              tolerant => $tolerant,      # continue even with an invalid form
              x        => $x,             # $x pixels from the left
              y        => $y,             # $y pixels from the bottom
              rotate   => $degree,        # rotate 
              size     => $size,          # multiply everything by $size
              xsize    => $xsize,         # multiply horizontally by $xsize
              ysize    => $ysize } )      # multiply vertically by $ysize
Ex.:
    my $internalName = prForm ( {file     => 'myFile.pdf',
                                 page     => 2 } );
              
Alternative 2) You put your parameters in this order

	prForm ( $pdfFile, $page, $adjust, $effect, $tolerant, $x, $y, $degree,
            $size, $xsize, $ysize )


Anyway the function returns in list context:  B<$intName, @BoundingBox, 
$numberOfImages>, in scalar context:  B<$internalName> of the form. 

if B<page> is excluded 1 is assumed. 

B<adjust>, could be 1, 2 or 0/nothing. If it is 1, the program tries to adjust the
form to the current media box (paper size) and keeps the proportions unchanged.
If it is 2, the program tries to fill as much of the media box as possible, without 
regards to the original proportions.
If this parameter is given, "x", "y", "rotate", "size", "xsize" and "ysize"
will be ignored.

B<effect> can have 3 values: B<'print'>, which is default, loads the page in an internal
table, adds it to the document and prints it to the current page. B<'add'>, loads the
page and adds it to the document. (Now you can "manually" manage the way you want to
print it to different pages within the document.) B<'load'> just loads the page in an 
internal table. (You can now take I<parts> of a page like fonts and objects and manage
them, without adding all the page to the document.)You don't get any defined 
internal name of the form, if you let this parameter be 'load'.

B<tolerant> can be nothing or something. If it is undefined, you will get an error if your program tries to load
a page which the system cannot really handle, if it e.g. consists of many streams.
If it is set to something, you have to test the first return value $internalName to
know if the function was successful. Look at the program 'reuseComponent_pl' for an 
example of usage.

B<x> where to start along the x-axis   (cannot be combined with "adjust")

B<y> where to start along the y-axis   (cannot be combined with "adjust")

B<rotate> A degree 0-360 to rotate the form counter-clockwise. (cannot be combined
with "adjust") Often the form disappears out of the media box if degree >= 90.
Then you can move it back with the x and y-parameters. If degree == 90, you can 
add the width of the form to x, If degree == 180 add both width and height to x
and y, and if degree == 270 you can add the height to y.

B<rotate> can also by one of 'q1', 'q2' or 'q3'. Then the system rotates the form
clockwise 90, 180 or 270 degrees and tries to keep the form within the media box.

The rotation takes place after the form has been resized or moved.

   Ex. To rotate from portrait (595 x 842 pt) to landscape (842 x 595 pt)

   use PDF::Reuse;
   use strict;
   
   prFile('New_Report.pdf');
   prMbox(0, 0, 842, 595);           
   
   prForm({file   => 'cert1.pdf',
           rotate => 'q1' } );  
   prEnd();

The same rotation can be achieved like this:

   use PDF::Reuse;
   use strict;
   
   prFile('New_Report.pdf');
   prMbox(0, 0, 842, 595);
               
   prForm({file   => 'cert1.pdf',
           rotate => 270,
           y      => 595 } );  
   prEnd();

B<size> multiply every measure by this value (cannot be combined with "adjust") 

B<xsize> multiply horizontally by this value (cannot be combined with "adjust")

B<ysize> multiply vertically by $ysize (cannot be combined with "adjust")

This function redefines a page to an "XObject" (the graphic parts), then the 
page can be reused and referred to as a unit. Unfortunately there is an important 
limitation here. "XObjects" can only have single streams. If the page consists
of many streams, you should concatenate them first. Adobe Acrobat can do that.
(If it is an important file, take a copy of it first. Sometimes the procedure fails.)
You open the file with Acrobat and choose the "Touch Up" tool and change anything
graphic in the page. You could e.g. remove 1 space and put it back. Then you
save the file. You could alternatively save the file as Postscript and redistill it with the
distiller or with Ghost script, but this is a little more risky. You might loose fonts
or something else. An other alternative could be to use prDoc() , but then you get all
the document, and you can only change the appearance of the page with the help of
JavaScript.

   use PDF::Reuse;
   use strict;

   prFile('myFile.pdf');
   prForm('best.pdf');    # Takes page No 1
   prText(75, 790, 'Dear Mr Gates');
   # ...
   prPage();
   prMbox(0, 0, 900, 960);
   my @vec = prForm(   { file => 'EUSA.pdf',
                         adjust => 1 } );
   prPage();
   prMbox();
   prText(35, 760, 'This is the final page');

   # More text ..

   #################################################################
   # We want to put a miniature of EUSA.pdf, 35 pixels from the left
   # 85 pixels up, and in the format 250 X 200 pixels
   #################################################################

   my $xScale = 250 / ($vec[3] - $vec[1]);
   my $yScale = 200 / ($vec[4] - $vec[2]);
   
   prForm ({ file => 'EUSA.pdf',
             xsize => $xScale,
             ysize => $yScale,
             x     => 35,
             y     => 85 });

   prEnd();

The first prForm(), in the code, is a simple and "normal" way of using the
the function. The second time it is used, the size of the imported page is
changed. It is adjusted to the media box which is current at that moment.
Also data about the form is taken, so you can control more in detail how it
will be displayed. 

=head2 prGetLogBuffer		- get the log buffer. 

prGetLogBuffer ()

returns a B<$buffer> of the log of the current page. (It could be used
e.g. to calculate a MD5-digest of what has been registered that far, instead of 
accumulating the single values) A log has to be active, see prLogDir() below

Look at "Using the template" and "Restoring a document from the log" in the
tutorial for examples of usage.

=head2 prGraphState		- define a graphic state parameter dictionary 

   prGraphState ( $string )

This is a "low level" function. Returns B<$internalName>. The B<$string> has to 
be a complete dictionary with initial "<<" and terminating ">>". No syntactical
checks are made. Perhaps you will never have to use this function.

   use PDF::Reuse;
   use strict;

   prFile('myFile.pdf');

   ###################################################
   # Draw a triangle with Gs0 (automatically defined)
   ###################################################

   my $str = "q\n";
   $str   .= "/Gs0 gs\n";
   $str   .= "150 700 m\n";
   $str   .= "225 800 l\n";
   $str   .= "300 700 l\n";
   $str   .= "150 700 l\n";
   $str   .= "S\n";
   $str   .= "Q\n";
   prAdd($str);

   ########################################################
   # Define a new graph. state param. dic. and draw a new
   # triangle further down 
   ########################################################

   $str = '<</Type/ExtGState/SA false/SM 0.02/TR2 /Default'
                      . '/LW 15/LJ 1/ML 1>>';
   my $gState = prGraphState($str);
   $str  = "q\n";
   $str .= "/$gState gs\n";
   $str .= "150 500 m\n";
   $str .= "225 600 l\n";
   $str .= "300 500 l\n";
   $str .= "150 500 l\n";
   $str .= "S\n";
   $str .= "Q\n";
   prAdd($str);
   
   prEnd();


=head2 prImage		- reuse an image from an old PDF document 

Alternative 1) You put your parameters in an anonymous hash (only B<file> is really 
necessary, the others get default values if not given).

   prImage( { file     => $pdfFile,       # template file
              page     => $page,          # page number
              imageNo  => $imageNo        # image number
              adjust   => $adjust,        # try to fill the media box
              effect   => $effect,        # action to be taken
              x        => $x,             # $x pixels from the left
              y        => $y,             # $y pixels from the bottom
              rotate   => $degree,        # rotate 
              size     => $size,          # multiply everything by $size
              xsize    => $xsize,         # multiply horizontally by $xsize
              ysize    => $ysize } )      # multiply vertically by $ysize
Ex.:
   prImage( { file    => 'myFile.pdf',
              page    => 10,
              imageNo => 2 } );
              
Alternative 2) You put your parameters in this order

	prImage ( $pdfFile, [$page, $imageNo, $effect, $adjust, $x, $y, $degree,
            $size, $xsize, $ysize] )

Returns in scalar context B<$internalName> As a list B<$internalName, $width, 
$height> 

Assumes that $pageNo and $imageNo are 1, if not specified. If $effect is given and
anything else then 'print', the image will be defined in the document,
but not shown at this moment.

For all other parameters, look at prForm().

   use PDF::Reuse;
   use strict;

   prFile('myFile.pdf'); 
   my @vec = prImage({ file  => 'best.pdf',
                       x     => 10,
                       y     => 400,
                       xsize => 0.9,
                       ysize => 0.8 } );
   prText(35, 760, 'This is some text');
   # ...
   prPage();
   my @vec2 = prImage( { file    => 'destiny.pdf',
                         page    => 1,
                         imageNo => 1,
                         effect  => 'add' } );
   prText(25, 760, "There shouldn't be any image on this page");
   prPage();
   ########################################################
   #  Now we make both images so that they could fit into
   #  a box 300 X 300 pixels, and they are displayed
   ########################################################

   prText(25, 800, 'This is the first image :');

   my $xScale = 300 / $vec[1];
   my $yScale = 300 / $vec[2];
   if ($xScale < $yScale)
   {  $yScale = $xScale;
   }
   else
   {  $xScale = $yScale;
   }
   prImage({ file   => 'best.pdf',
             x      => 25,
             y      => 450,
             xsize  => $xScale,
             ysize  => $yScale} );

   prText(25, 400, 'This is the second image :');

   $xScale = 300 / $vec2[1];
   $yScale = 300 / $vec2[2];
   if ($xScale < $yScale)
   {  $yScale = $xScale;
   }
   else
   {  $xScale = $yScale;
   }
   prImage({ file   => 'destiny.pdf',
             x      => 25,
             y      => 25,
             xsize  => $xScale,
             ysize  => $yScale} );

   prEnd();

On the first page an image is displayed in a simple way. While the second page
is processed, prImage(), loads an image, but it is not shown here. On the 3:rd
page, the two images are scaled and shown. 

In the distribution there is an utility program, 'reuseComponent_pl', which displays
included images in a PDF-file and their "names".

=head2 prInit		- add JavaScript to be executed at initiation 

   prInit ( $string, $duplicateCode )

B<$string> can be any JavaScript code, but you can only refer to functions included
with prJs. The JavaScript interpreter will not know other functions in the document.
Often you can add new things, but you can't remove or change interactive fields,
because the interpreter hasn't come that far, when initiation is done.

B<$duplicateCode> is undefined or anything. It duplicates the JavaScript code
which has been used at initiation, so you can look at it from within Acrobat and
debug it. It makes the document bigger. This parameter is B<deprecated>.

See prJs() for an example

Remark: Avoid to use "return" in the code you use at initiation. If your user has
downloaded a page with Web Capture, and after that opens a PDF-document where a 
JavaScript is run at initiation and that JavaScript contains a return-statement,
a bug occurs. The JavaScript interpreter "exits" instead of returning, the execution
of the JavaScript might finish to early. This is a bug in Acrobat/Reader 5.

B<The function prInit uses JavaScript, so see "Remarks about Javascript">

=head2 prInitVars		- initiate global variables and internal tables 

   prInitVars(1)

If you run programs with PDF::Reuse as persistent procedures, you probably need to
initiate global variables. If you have '1' or anything as parameter, internal tables for forms, images, fonts
and interactive functions are B<not> initiated. The module "learns" offset and sizes of
used objects, and can process them faster, but at the same time the size of the 
program grows.

   use PDF::Reuse;
   use strict;
   prInitVars();     # To initiate ALL global variables and tables
   # prInitVars(1);  # To make it faster, but more memory consuming

   $| = 1;
   print STDOUT "Content-Type: application/pdf \n\n";

   prFile();         # To send the document uncatalogued to STDOUT                

   prForm('best.pdf');
   prText(25, 790, 'Dear Mr. Anders Persson');
   # ...
   prEnd();

If you call this function without parameters all global variables, including the
internal tables, are initiated.


=head2 prJpeg		- import a jpeg-image 

   prJpeg ( $imageFile, $width, $height )

B<$imageFile> contains 1 single jpeg-image. B<$width> and B<$height>
also have to be specified. Returns the B<$internalName>

   use PDF::Reuse;
   use Image::Info qw(image_info dim);
   use strict;

   my $file = 'myImage.jpg';
   my $info = image_info($file);
   my ($width, $height) = dim($info);    # Get the dimensions

   prFile('myFile.pdf');
   my $intName = prJpeg("$file",         # Define the image 
                         $width,         # in the document
                         $height);

   my $str = "q\n";
   $str   .= "$width 0 0 $height 10 10 cm\n";
   $str   .= "/$intName Do\n";
   $str   .= "Q\n";
   prAdd($str);
   prEnd();

This is a little like an extra or reserve routine to add images to the document.
The most simple way is to use prImage()  

=head2 prJs		- add JavaScript 

   prJs ( $string|$fileName )

To add JavaScript to your new document. B<$string> has to consist only of
JavaScript functions: function a (..){ ... } function b (..) { ...} and so on
If B<$string> doesn't contain '{', B<$string> is interpreted as a filename.
In that case the file has to consist only of JavaScript functions.

   use PDF::Reuse;
   use strict;

   prFile('myFile.pdf');
   prJs('customerResponse.js');
   prInit('nameAddress(0, 100, 700);');
   prEnd();


B<See "Remarks about Javascript">

=head2 prLink    - add a hyperlink

   prLink( { page   => $pageNo,     # Starting with 1  !
             x      => $x,
             y      => $y,
             width  => $width,
             height => $height,
             URI    => $URI     } );

You can also call prLink like this:

   prLink($page, $x, $y, $width, $height, $URI);

You have to put prLink B<after prFile and before the sentences where its' page
is created>. The links are created at the page-breaks. If the page is already 
created, no new link will be inserted. 

Here is an example where the links of a 4 page document are preserved, and a link is
added at the end of the document. We assume that there is some suitable text at that
place (x = 400, y = 350):

   use strict;
   use PDF::Reuse;

   prFile('test.pdf');

   prLink( {page   => 4,
            x      => 400,
            y      => 350,
            width  => 105,
            height => 15,
            URI    => 'http://www.purelyInvented.com/info.html' } );

   prDoc('fourPages.pdf');

   prEnd();

( If you are creating each page of a document separately, you can also use 'hyperLink'
from PDF::Reuse::Util. Then you get an external text in Helvetica-Oblique, underlined
and in blue.

  use strict;
  use PDF::Reuse;
  use PDF::Reuse::Util;

  prFile('test.pdf');
  prForm('template.pdf', 5);
  my ($from, $pos) = prText(25, 700, 'To get more information  ');

  $pos = hyperLink( $pos, 700, 'Press this link',
                    'http://www.purelyInvented.com/info.html' );
  ($from, $pos) = prText( $pos, 700, ' And get connected');
  prEnd();

'hyperLink' has a few parameters: $x, $y, $textToBeShown, $hyperLink and
$fontSize (not shown in the example). It returns current x-position. )

=head2 prLog		- add a string to the log 

   prLog ( $string )

Adds whatever you want to the current log (a reference No, a commentary, a tag ?)
A log has to be active see prLogDir()

Look at "Using the template" and "Restoring the document from the log" in
the tutorial for an example.

=head2 prLogDir		- set directory for the log 

   prLogDir ( $directory )

Sets a directory for the logs and activates the logging. 
A little log file is created for each PDF-file. Normally it should be much, much
more compact then the PDF-file, and it should be possible to restore or verify 
a document with the help of it. (Of course you could compress or store the logs in a 
database to save even more space.) 

   use PDF::Reuse;
   use strict;

   prDocDir('C:/temp/doc');
   prLogDir('C:/run');

   prFile('myFile.pdf');
   prForm('best.pdf');
   prText(25, 790, 'Dear Mr. Anders Persson');
   # ...
   prEnd();

In this example a log file with the name 'myFile.pdf.dat' is created in the
directory 'C:\run'. If that directory doesn't exist, the system tries to create it.
(But, just as mkdir does, it only creates the last level in a directory tree.)

=head2 prMbox		- define the format (MediaBox) of the current page. 

   prMbox ( $lowerLeftX, $lowerLeftY, $upperRightX, $upperRightY )

If the function or the parameters are missing, they are set to 0, 0, 595, 842 pixels respectively.   

See prForm() for an example.


=head2 prPage		- insert a page break

   prPage ($noLog)

Don't use the optional parameter, it is only used internally, not to clutter the log,
when automatic page breaks are made.

See prForm() for an example.

=head2 prStrWidth   - calculate the string width

   prStrWidth($string, $font, $fontSize)

Returns string width in pixels.
Should be used in conjunction with one of these predefined fonts of Acrobat/Reader:
Times-Roman, Times-Bold, Times-Italic, Times-BoldItalic, Courier, Courier-Bold, Courier-Oblique,
Courier-BoldOblique, Helvetica, Helvetica-Bold, Helvetica-Oblique,
Helvetica-BoldOblique. If some other font is given, Helvetica is used, and the
returned value will at the best be approximate.

=head2 prText		- add a text-string 

   prText ( $x, $y, $string, $how )

Puts B<$string> at position B<$x, $y>
Returns 1 in scalar context. Returns ($xFrom, $xTo) in list context. $xTo will not
be defined if $how is a rotation. prStrWidth() is used to calculate the length of the
strings, so only the predefined fonts together with Acrobat/Reader will give
reliable values for $xTo.      

$how can be 'left' (= default), 'center', 'right', a degree 0 - 360, 'q1', 'q2' 
or 'q3'. The parameter is optional.

Current font and font size are used. (If you use prAdd() before this function,
many other things could also influence the text.)

   use strict;
   use PDF::Reuse;

   prFile('test.pdf');

   #####################################
   # Use a "curser" ($pos) along a line
   #####################################

   my ($from, $pos) = prText(25, 800, 'First write this. ');
   ($from, $pos) = prText($pos, 800, 'Then write this. '); 
   prText($pos, 800, 'Finally write this.');

   #####################################
   # Right adjust and center sentences
   #####################################

   prText( 200, 750, 'A short sentence', 'right');
   prText( 200, 735, 'This is a longer sentence', 'right');
   prText( 200, 720, 'A word', 'right');

   prText( 200, 705, 'Centered around a point 200 pixels from the left', 'center');
   prText( 200, 690, 'The same center', 'center');
   prText( 200, 675, '->.<-', 'center');

   ############
   # Rotation
   ############

   prText( 200, 550, ' Rotate 0 degrees', 0);
   prText( 200, 550, ' Rotate 60 degrees', 60);
   prText( 200, 550, ' Rotate 120 degrees', 120);
   prText( 200, 550, ' Rotate 180 degrees', 180);
   prText( 200, 550, ' Rotate 240 degrees', 240);
   prText( 200, 550, ' Rotate 300 degrees', 300);

   prText( 400, 430, 'Rotate 90 degrees clock-wise', 'q1');
   prText( 400, 430, 'Rotate 180 degrees clock-wise', 'q2');
   prText( 400, 430, 'Rotate 270 degrees clock-wise', 'q3');

   prEnd();


=head2 prTouchUp		- make changes and reuse more difficult 

   prTouchUp (1);

By default and after you have issued prTouchUp(1), you can change the document
with the TouchUp tool from within Acrobat.
If you want to switch off this possibility, you use prTouchUp() without any 
parameter.  Then the user shouldn't be able to change anything graphic by mistake.
He has to do something premeditated and perhaps with a little effort.
He could still save it as Postscript and redistill, or he could remove or add single pages. 
(Here is a strong reason why the log files, and perhaps also check sums, are needed.
It would be very difficult to forge a document unless the forger also has access to your
computer and knows how the check sums are calculated.)

B<Avoid to switch off the TouchUp tool for your templates.> It creates an
extra level within the PDF-documents . Use this function for your final documents.

See "Using the template" in the tutorial for an example. 

(To encrypt your documents: use the batch utility within Acrobat)


=head1 INTERNAL OR DEPRECATED FUNCTIONS

=over 2

=item prBar		- define and paint bars for bar fonts 

   prBar ($x, $y, $string)

Prints a bar font pattern at the current page.
Returns $internalName for the font.
$x and $y are coordinates in pixels and $string should consist of the characters
'0', '1' and '2' (or 'G'). '0' is a white bar, '1' is a dark bar. '2' and 'G' are
dark, slightly longer bars, guard bars. 
You can use e.g. GD::Barcode or one module in that group to calculate the barcode
pattern. prBar "translates" the pattern to white and black bars.

   use PDF::Reuse;
   use GD::Barcode::Code39;
   use strict;

   prFile('myFile.pdf');
   my $oGdB = GD::Barcode::Code39->new('JOHN DOE');
   my $sPtn = $oGdB->barcode();
   prBar(100, 600, $sPtn);
   prEnd();

Internally the module uses a font for the bars, so you might want to change the font size before calling
this function. In that case, use prFontSize() .
If you call this function without arguments it defines the bar font but does
not write anything to the current page.

B<An easier and often better way to produce barcodes is to use PDF::Reuse::Barcode.> 
Look at that module!

=item prCid		- define timestamp/checkid 

   prCid ( $timeStamp )

An internal function. Don't bother about it. It is used in automatic
routines when you want to restore a document. It gives modification time of
the next PDF-file or JavaScript.
See "Restoring a document from the log" in the tutorial for more about the
time stamp

=item prId		- define id-string of a PDF document 

   prId ( $string )

An internal function. Don't bother about it. It is used e.g. when a document is
restored and an id has to be set, not calculated.

=item prIdType		- define id-type 

   prIdType ( $string )

An internal function. Avoid using it. B<$string> could be "Rep" for replace or
"None" to avoid calculating an id.

Normally you don't use this function. Then an id is calculated with the help of
Digest::MD5::md5_hex and some data from the run.

=item prMoveTo 

   prMoveTo ( $x, $y )

B<Deprecated> This function will be removed during 2004. You can define positions
with parameters directly to prImage(), prForm() and prDocForm(). 

Defines positions where to put e.g. next image

=item prScale 

   prScale ( $xSize, $ySize )

B<Deprecated> This function will be removed during 2004. You can define sizes
with parameters directly to prImage(), prForm() and prDocForm().

Each of $xSize and $ySize are set to 1 if missing. You can use this function to
scale an image before showing it.


=item prVers		- check version of log and program 

   prVers ( $versionNo )

To check version of this module in case a document has to be
restored.

=back

=head1 SEE ALSO

   PDF::Reuse::Tutorial
   PDF::Reuse::Barcode
   PDF::Reuse::Scramble
   PDF::Reuse::OverlayChart

To program with PDF-operators, look at "The PDF-reference Manual" which probably
is possible to download from http://partners.adobe.com/asn/developer/acrosdk/docs.html
Look especially at chapter 4 and 5, Graphics and Text, and the Operator summary.

Technical Note # 5186 contains the "Acrobat JavaScript Object Specification". I 
downloaded it from http://partners.adobe.com/asn/developer/technotes/acrobatpdf.html

If you are serious about producing PDF-files, you probably need Adobe Acrobat sooner
or later. It has a price tag. Other good programs are GhostScript and GSview. 
I got them via http://www.cs.wisc.edu/~ghost/index.html  Sometimes they can replace Acrobat.
A nice little detail is e.g. that GSview shows the x- and y-coordinates better then Acrobat. If you need to convert HTML-files to PDF, HTMLDOC is a possible tool. Download it from
http://www.easysw.com . A simple tool for vector graphics is Mayura Draw 2.04, download
it from http://www.mayura.com. It is free. I have used it to produce the graphic
OO-code in the tutorial. It produces postscript which the Acrobat Distiller (you get it together with Acrobat)
or Ghostscript can convert to PDF.(The commercial product, Mayura Draw 4.01 or something 
higher can produce PDF-files straight away)

If you want to import jpeg-images, you might need

   Image::Info

To get definitions for e.g. colors, take them from

   PDF::API2::Util 

=head1 LIMITATIONS

Metadata, info and many other features of the PDF-format have not been
implemented in this module. 

Many things can be added afterwards, after creating the files. If you e.g. need
files to be encrypted, you can use a standard batch routine within Adobe Acrobat.   

=head1 TODO

I have been experimenting a little with a helper application for Netscape or
Internet Explorer and it is quite obvious that you could get very good performance
and high reliability if you transferred the logs and constructed the documents at
the target computer, instead of the transferring formatted documents.
The reasons are:

The size of a log is usually only a fraction of the formatted document. The logs
keep a time stamp for all source files, so you could have a simple cashing. It is
possible to put a time stamp on the log file and then you get a hierarchal structure.
When the system reads a log file it could quickly find out which source files are
missing. If it encounters the URL and time stamp of cashed log file, that would be
sufficient.  It would not be necessary to get it over the net.
You would minimize the number of conversations and you would also increase the
possibilities to complete a task even if the connections are bad.    

The cash could function as a secondary library for forms and JavaScripts.
When you work with HTML you are usually interested in the most recent version of
of a component. With PDF the emphasis is usually more on exactness, and PDF-documents
tend to be more stable. This strengthens the motive for a functioning cash.

(Also I think you could skip some holy rules from HTML-processing. E.g. if an 
international body has forms and JavaScripts for booking a hotel room, any 
affiliated hotel should have the right to use the common files, so they could be
used via the cash regardless of if you are booking a room in Agadir or Shanghai.
That would create libraries and rational reuse of code. I think security and
legal problems would be possible to handle.)

At the present time PDF cannot compete with HTML, but if you used the log files
and a simple cash, PDF would be just superior for repeated tasks.

=head1 THANKS TO

Martin Langhoff and others who have contributed with code, suggestions and error
reports.

=head1 AUTHOR

Lars Lundberg elkelund @ worldonline . se

=head1 COPYRIGHT

Copyright (C) 2003 - 2004 Lars Lundberg, Solidez HB. All rights reserved.
This program is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 DISCLAIMER

You get this module free as it is, but nothing is guaranteed to work, whatever 
implicitly or explicitly stated in this document, and everything you do, 
you do at your own risk - I will not take responsibility 
for any damage, loss of money and/or health that may arise from the use of this module.

=cut

sub prLink
{ my %link;
  my $param = shift;
  if (ref($param) eq 'HASH')
  {  $link{page}   = $param->{'page'} || -1;
     $link{x}      = $param->{'x'}    || 100;
     $link{y}      = $param->{'y'}    || 100;
     $link{width}  = $param->{width}  || 75;
     $link{height} = $param->{height} || 15;
     $link{action} = $param->{action} || undef;
     $link{border} = $param->{border} || undef;
     $link{color}  = $param->{color}  || undef;
     $link{URI}    = $param->{URI};
  }
  else
  {  $link{page}   = $param || -1;
     $link{x}      = shift || 100;
     $link{y}      = shift || 100;
     $link{width}  = shift || 75;
     $link{height} = shift || 15;
     $link{URI}    = shift;
  }

  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }

  if ($runfil)
  {  $log .= "Link~$link{page}~$link{x}~$link{y}~$link{width}~" 
          . "$link{height}~$link{URI}\n";
  }
  
  if ($link{URI} || $link{action})
  {  push @{$links{$link{page}}}, \%link;
  }
  1;
}

sub mergeLinks
{   my $tSida = $sida + 1;
    my $rad;
    my ($linkObject, $linkObjectNo);
    for my $link (@{$links{'-1'}}, @{$links{$tSida}} )
    {   my $x2 = $link->{x} + $link->{width};
        my $y2 = $link->{y} + $link->{height};
        if (defined $link->{action})
        {
            if (exists $links{$link->{action}})
            {   $linkObjectNo = $links{$link->{action}};
            }
            else
            {   $objNr++;
                $objekt[$objNr] = $pos;
                $rad = "$objNr 0 obj<<$link->{action}>>endobj\n";
                $linkObjectNo = $objNr;
                $links{$link->{action}} = $objNr;
                $pos += syswrite UTFIL, $rad;
            }
        }
        else
        {
            if (exists $links{$link->{URI}})
            {   $linkObjectNo = $links{$link->{URI}};
            }
            else
            {   $objNr++;
                $objekt[$objNr] = $pos;
                $rad = "$objNr 0 obj<</S/URI/URI($link->{URI})>>endobj\n";
                $linkObjectNo = $objNr;
                $links{$link->{URI}} = $objNr;
                $pos += syswrite UTFIL, $rad;
            }
        }
        $rad = "/Subtype/Link/Rect[$link->{x} $link->{y} "
             . "$x2 $y2]/A $linkObjectNo 0 R";
        if (defined $link->{border})
        {   $rad .= "/Border$link->{border}";
        }
        else
        {   $rad .= "/Border[0 0 0]";
        }
        if (defined $link->{color})
        {   $rad .= "/C$link->{color}";
        }
        if (exists $links{$rad})
        {   push @annots, $links{$rad};
        }
        else
        {   $objNr++;
            $objekt[$objNr] = $pos;
            $links{$rad} = $objNr;
            $rad = "$objNr 0 obj<<$rad>>endobj\n";
            $pos += syswrite UTFIL, $rad;
            push @annots, $objNr;
        }
    }
    @{$links{'-1'}}   = ();
    @{$links{$tSida}} = ();
    $objNr++;
    $objekt[$objNr] = $pos;
    $rad = "$objNr 0 obj[\n";
    for (@annots)
    {  $rad .= "$_ 0 R\n";
    }
    $rad .= "]endobj\n";
    $pos += syswrite UTFIL, $rad;
    @annots = ();
    return $objNr;
}

sub prStrWidth 
{  require PDF::Reuse::Util;
   my $string   = shift;
   my $Font     = shift;
   my $FontSize = shift || $fontSize;
   my $w = 0;
    
  if (! $Font)
  {   if (! $aktuellFont[foEXTNAMN])
      {  findFont();
      }
      $Font = $aktuellFont[foEXTNAMN];
  }

  if (! exists $PDF::Reuse::Util::font_widths{$Font})
  {  if (exists $stdFont{$Font})
     {  $Font = $stdFont{$Font};
     }
     if (! exists $PDF::Reuse::Util::font_widths{$Font})
     {   $Font = 'Helvetica';
     }
  }
  
  if (ref($PDF::Reuse::Util::font_widths{$Font}) eq 'ARRAY')
  {   my @font_table = @{ $PDF::Reuse::Util::font_widths{$Font} };
      for (unpack ("C*", $string)) 
      {  $w += $font_table[$_];	
      }
  }
  else
  {   $w = length($string) * $PDF::Reuse::Util::font_widths{$Font};
  }
  $w = $w / 1000 * $FontSize;
  
  return $w;
}


sub prBookmark
{   my $param = shift;
    if (! ref($param))
    {   $param = eval ($param);
    }
    if (! ref($param))
    {   return undef;
    }
    if (! $pos)
    {  errLog("No output file, you have to call prFile first");
    }
    if (ref($param) eq 'HASH')
    {   push @bookmarks, $param;
    }
    else
    {   push @bookmarks, (@$param);       
    }
    if ($runfil)
    {   local $Data::Dumper::Indent = 0;
        $param = Dumper($param);
        $param =~ s/^\$VAR1 = //;
        $param = prep($param);
        $log .= "Bookmark~$param\n";
    }
    return 1;
}

sub ordnaBookmarks
{   my ($first, $last, $me, $entry, $rad);
    $totalCount = 0;
    if (defined $objekt[$objNr])
    {  $objNr++;
    }
    $me = $objNr;
        
    my $number = $#bookmarks;
    for (my $i = 0; $i <= $number ; $i++)
    {   my %hash = %{$bookmarks[$i]};
        $objNr++;
        $hash{'this'} = $objNr;
        if ($i == 0)
        {   $first = $objNr;           
        }
        if ($i == $number)
        {   $last = $objNr;
        } 
        if ($i < $number)
        {  $hash{'next'} = $objNr + 1;
        }
        if ($i > 0)
        {  $hash{'previous'} = $objNr - 1;
        }
        $bookmarks[$i] = \%hash;
    } 
    
    for $entry (@bookmarks)
    {  my %hash = %{$entry};
       descend ($me, %hash);
    }

    $objekt[$me] = $pos;

    $rad = "$me 0 obj<<";
    $rad .= "/Type/Outlines";
    $rad .= "/Count $totalCount";
    if (defined $first)
    {  $rad .= "/First $first 0 R";
    }
    if (defined $last)
    {  $rad .= "/Last $last 0 R";
    }
    $rad .= ">>endobj\n";
    $pos += syswrite UTFIL, $rad;

    return $me;

}

sub descend
{   my ($parent, %entry) = @_;
    my ($first, $last, $count, $me, $rad, $jsObj);
    if (! exists $entry{'close'})
    {  $totalCount++; }
    $count = $totalCount;
    $me = $entry{'this'};
    if (exists $entry{'kids'})
    {   if (ref($entry{'kids'}) eq 'ARRAY')
        {   my @array = @{$entry{'kids'}};
            my $number = $#array;
            for (my $i = 0; $i <= $number ; $i++)
            {   $objNr++;
                $array[$i]->{'this'} = $objNr;
                if ($i == 0)
                {   $first = $objNr;           
                }
                if ($i == $number)
                {   $last = $objNr;
                } 

                if ($i < $number)
                {  $array[$i]->{'next'} = $objNr + 1;
                }
                if ($i > 0)
                {  $array[$i]->{'previous'} = $objNr - 1;
                }
                if (exists $entry{'close'})
                {  $array[$i]->{'close'} = 1;
                }
            } 

            for my $element (@array)
            {   descend($me, %{$element})
            }
        }
        else                                          # a hash
        {   my %hash = %{$entry{'kids'}};
            $objNr++;
            $hash{'this'} = $objNr;
            $first        = $objNr;           
            $last         = $objNr;
            descend($me, %hash)
        }
     }     

     if (exists $entry{'act'})
     {   my $code = $entry{'act'};
         if ($code =~ m/^\s*(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*$/os)
         {  $code = "this.pageNum = $1; this.scroll($2, $3);";
         }
         $jsObj = skrivJS($code);         
     }

     $objekt[$me] = $pos;
     $rad = "$me 0 obj<<";
     if (exists $entry{'text'})
     {   $rad .= "/Title ($entry{'text'})";
     }
     $rad .= "/Parent $parent 0 R";
     if (defined $jsObj)
     {  $rad .= "/A $jsObj 0 R";
     }
     elsif (exists $entry{'pdfact'})
     {  $rad .= "/A << $entry{'pdfact'} >>";
     }
     if (exists $entry{'previous'})
     {  $rad .= "/Prev $entry{'previous'} 0 R";
     }
     if (exists $entry{'next'})
     {  $rad .= "/Next $entry{'next'} 0 R";
     }
     if (defined $first)
     {  $rad .= "/First $first 0 R";
     }
     if (defined $last)
     {  $rad .= "/Last $last 0 R";
     }
     if ($count != $totalCount)
     {   $count = $totalCount - $count;
         $rad .= "/Count $count";
     }
     if (exists $entry{'color'})
     {   $rad .= "/C [$entry{'color'}]";
     }
     if (exists $entry{'style'})
     {   $rad .= "/F $entry{'style'}";
     }

     $rad .= ">>endobj\n";
     $pos += syswrite UTFIL, $rad;
}  

sub prInitVars
{   my $exit = shift;
    $genLowerX    = 0;
    $genLowerY    = 0;
    $genUpperX    = 595,
    $genUpperY    = 842;
    $fontSize     = 12;
    ($utfil, $slutNod, $formCont, $imSeq, 
    $page, $sidObjNr, $interActive, $NamesSaved, $AARootSaved, $AAPageSaved,
    $root, $AcroFormSaved, $id, $ldir, $checkId, $formNr, $imageNr, 
    $filnamn, $interAktivSida, $taInterAkt, $type, $runfil, $checkCs,
    $confuseObj, $compress,$pos, $fontNr, $objNr,
    $defGState, $gSNr, $pattern, $shading, $colorSpace) = '';

    (@kids, @counts, @formBox, @objekt, @parents, @aktuellFont, @skapa,
     @jsfiler, @inits, @bookmarks, @annots) = ();

    ( %resurser,  %objRef, %nyaFunk,%oldObject, %unZipped, 
      %sidFont, %sidXObject, %sidExtGState, %font, %fields, %script,
      %initScript, %sidPattern, %sidShading, %sidColorSpace, %knownToFile,
      %processed, %dummy) = ();

     $stream = '';
     $idTyp  = '';
     $ddir   = '';
     $log    = '';

     if ($exit)
     {  return 1;
     }
   
     ( %form, %image, %fontSource, %intAct) = ();

     return 1;
}

####################
# Behandla en bild
####################

sub prImage
{ my $param = shift;
  my ($infil, $sidnr, $bildnr, $effect, $adjust, $x, $y, $size, $xsize,
      $ysize, $rotate);

  if (ref($param) eq 'HASH')
  {  $infil  = $param->{'file'};
     $sidnr  = $param->{'page'} || 1;
     $bildnr = $param->{'imageNo'} || 1;
     $effect = $param->{'effect'} || 'print';
     $adjust = $param->{'adjust'} || '';
     $x      = $param->{'x'} || 0;
     $y      = $param->{'y'} || 0;
     $rotate = $param->{'rotate'} || 0;
     $size   = $param->{'size'} || 1;
     $xsize  = $param->{'xsize'} || 1;
     $ysize  = $param->{'ysize'} || 1;
  }
  else
  {  $infil  = $param;
     $sidnr  = shift || 1;
     $bildnr = shift || 1;
     $effect = shift || 'print';
     $adjust = shift || '';
     $x      = shift || 0;
     $y      = shift || 0;
     $rotate = shift || 0;
     $size   = shift || 1;
     $xsize  = shift || 1;
     $ysize  = shift || 1;
  }

  my ($refNr, $inamn, $bildIndex, $xc, $yc, $xs, $ys);
  $type = 'image';
  
  $bildIndex = $bildnr - 1;
  my $fSource = $infil . '_' . $sidnr;
  my $iSource = $fSource . '_' . $bildnr;
  if (! exists $image{$iSource})
  {  $imageNr++;
     $inamn = 'Im' . $imageNr;
     $knownToFile{'Im:' . $iSource} = $inamn;
     $image{$iSource}[imXPOS]   = 0;
     $image{$iSource}[imYPOS]   = 0;
     $image{$iSource}[imXSCALE] = 1;
     $image{$iSource}[imYSCALE] = 1;
     if (! exists $form{$fSource} )
     {  $refNr = getPage($infil, $sidnr, '');
        if ($refNr)
        {  $formNr++;
           my $namn = 'Fm' . $formNr;
           $knownToFile{$fSource} = $namn;
        }
        elsif ($refNr eq '0')
        {  errLog("File: $infil  Page: $sidnr can't be found");
        }          
     }
     my $in = $form{$fSource}[fIMAGES][$bildIndex];
     $image{$iSource}[imWIDTH]  = $form{$fSource}->[fOBJ]->{$in}->[oWIDTH];
     $image{$iSource}[imHEIGHT] = $form{$fSource}->[fOBJ]->{$in}->[oHEIGHT];
     $image{$iSource}[imIMAGENO] = $form{$fSource}[fIMAGES][$bildIndex];
  }
  if (exists $knownToFile{'Im:' . $iSource})
  {   $inamn = $knownToFile{'Im:' . $iSource};
  }
  else
  {   $imageNr++;
      $inamn = 'Im' . $imageNr;
      $knownToFile{'Im:' . $iSource} = $inamn;
  }
  if (! exists $objRef{$inamn})         
  {  $refNr = getImage($infil,  $sidnr, 
                       $bildnr, $image{$iSource}[imIMAGENO]);
     $objRef{$inamn} = $refNr;
  }
  else
  {   $refNr = $objRef{$inamn};
  }
     
  my @iData = @{$image{$iSource}};

  if (($effect eq 'print') && ($refNr))
  {  if (! defined  $defGState)
     { prDefaultGrState();}
     $stream .= "\n/Gs0 gs\n";
     $stream .= "q\n";
     
     if ($adjust)
     {  $stream .= fillTheForm(0, 0, $iData[imWIDTH], $iData[imHEIGHT],$adjust);        
     }
     else
     {   my $tX     = ($x + $iData[imXPOS]);
         my $tY     = ($y + $iData[imYPOS]);
         $stream .= calcMatrix($tX, $tY, $rotate, $size, 
                               $xsize, $ysize, $iData[imWIDTH], $iData[imHEIGHT]);
     }
     $stream .= "$iData[imWIDTH] 0 0 $iData[imHEIGHT] 0 0 cm\n";
     $stream .= "/$inamn Do\n";
     $sidXObject{$inamn} = $refNr;
     $stream .= "Q\n";
     $sidExtGState{'Gs0'} = $defGState;
  }
  if ($runfil)
  {  $infil = prep($infil);
     $log .= "Image~$infil~$sidnr~$bildnr~$effect~$adjust";
     $log .= "$x~$y~$size~$xsize~$ysize~$rotate\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }

  if (wantarray)
  {   return ($inamn, $iData[imWIDTH], $iData[imHEIGHT]);
  }
  else
  {   return $inamn;
  }
}



sub prMbox
{  my $lx = shift || 0;
   my $ly = shift || 0;
   my $ux = shift || 595;
   my $uy = shift || 842;
   
   if ((defined $lx) && ($lx =~ m'^[\d\-\.]+$'o))
   { $genLowerX = $lx; }
   if ((defined $ly) && ($ly =~ m'^[\d\-\.]+$'o))
   { $genLowerY = $ly; } 
   if ((defined $ux) && ($ux =~ m'^[\d\-\.]+$'o))
   { $genUpperX = $ux; } 
   if ((defined $uy) && ($uy =~ m'^[\d\-\.]+$'o))
   { $genUpperY = $uy; } 
   if ($runfil)
   {  $log .= "Mbox~$lx~$ly~$ux~$uy\n";
   }
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }
   1;
}

sub prField
{  my ($fieldName, $fieldValue) = @_;
   if (($interAktivSida) || ($interActive))
   {  errLog("Too late, has already tried to INITIATE FIELDS within an interactive page");
   }
   elsif (! $pos)
   {  errLog("Too early INITIATE FIELDS, create a file first");
   }
   $fields{$fieldName} = $fieldValue;
   if ($fieldValue =~ m'^\s*js\s*\:(.*)'oi)
   {  my $code = $1;
      my @fall = ($code =~ m'([\w\d\_\$]+)\s*\(.*?\)'gs);
      for (@fall)
      {  if (! exists $initScript{$_})
         { $initScript{$_} = 0; 
         }
      }
   }
   if ($runfil)
   {   $fieldName  = prep($fieldName);
       $fieldValue = prep($fieldValue);
       $log .= "Field~$fieldName~$fieldValue\n";
   } 
   1;
}
############################################################
sub prBar
{ my ($xPos, $yPos, $TxT) = @_; 
 
  $TxT   =~ tr/G/2/;
    
  my @fontSpar = @aktuellFont;
         
  findBarFont();
  
  my $Font = $aktuellFont[foINTNAMN];                # Namn i strömmen
  
  if (($xPos) && ($yPos))
  {  $stream .= "\nBT /$Font $fontSize Tf ";
     $stream .= "$xPos $yPos Td \($TxT\) Tj ET\n";
  }
  if ($runfil)
  {  $log .= "Bar~$xPos~$yPos~$TxT\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }
  @aktuellFont = @fontSpar;
  return $Font;
  
}


sub prExtract
{  my $name = shift;
   my $form = shift;
   my $page = shift || 1;
   if ($name =~ m'^/(\w+)'o)
   {  $name = $1;
   }
   my $fullName = "$name~$form~$page";
   if (exists $knownToFile{$fullName})
   {   return $knownToFile{$fullName};
   }
   else
   {   if ($runfil)
       {  $log = "Extract~$fullName\n";
       }
       if (! $pos)
       {  errLog("No output file, you have to call prFile first");
       }
   
       if (! exists $form{$form . '_' . $page})
       {  prForm($form, $page, undef, 'load', 1);
       }
       $name = extractName($form, $page, $name);
       if ($name)
       {  $knownToFile{$fullName} = $name;
       }
       return $name;
   }
}


########## Extrahera ett dokument ####################       
sub prDoc
{ my ($infil, $first, $last); 
  my $param = shift;
  if (ref($param) eq 'HASH')
  {  $infil = $param->{'file'};
     $first = $param->{'first'} || 1;
     $last  = $param->{'last'} || '';
  }
  else
  {  $infil = $param;
     $first = shift || 1;
     $last  = shift || '';     
  }
  
  if ($stream)
  {  if ($stream =~ m'\S+'os)
     {  skrivSida();}
     else
     {  undef $stream; }
  }
   
  if (! $objekt[$objNr])         # Objektnr behöver inte reserveras här
  { $objNr--;
  }
  
  my ($sidor, $Names, $AARoot, $AcroForm) = analysera($infil, $first, $last);
  if (($Names) || ($AARoot) || ($AcroForm))
  { $NamesSaved     = $Names;
    $AARootSaved    = $AARoot;
    $AcroFormSaved  = $AcroForm;
    $interActive    = 1;
  }
  if ($runfil)
  {   $infil = prep($infil);
      $log .= "Doc~$infil~$first~$last\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }
  return $sidor;
}

############# Ett interaktivt + grafiskt "formulär" ##########

sub prDocForm
{my ($sidnr, $adjust, $effect, $tolerant, $infil, $x, $y, $size, $xsize,
      $ysize, $rotate);
  my $param = shift;
  if (ref($param) eq 'HASH')
  {  $infil    = $param->{'file'};
     $sidnr    = $param->{'page'} || 1;
     $adjust   = $param->{'adjust'} || '';
     $effect   = $param->{'effect'} || 'print';
     $tolerant = $param->{'tolerant'} || '';
     $x        = $param->{'x'} || 0;
     $y        = $param->{'y'} || 0;
     $rotate   = $param->{'rotate'} || 0;
     $size     = $param->{'size'} || 1;
     $xsize    = $param->{'xsize'} || 1;
     $ysize    = $param->{'ysize'} || 1;
  }
  else
  {  $infil    = $param;
     $sidnr    = shift || 1;
     $adjust   = shift || '';
     $effect   = shift || 'print';
     $tolerant = shift || '';
     $x        = shift || 0;
     $y        = shift || 0;
     $rotate   = shift || 0;
     $size     = shift || 1;
     $xsize    = shift || 1;
     $ysize    = shift || 1;
  }
  my $namn;
  my $refNr;
  $type = 'docform';
  my $fSource = $infil . '_' . $sidnr; 
  my $action;
  if (! exists $form{$fSource})
  {  $formNr++;
     $namn = 'Fm' . $formNr;
     $knownToFile{$fSource} = $namn;
     if ($effect eq 'load')
     {  $action = 'load'
     }
     else
     {  $action = 'print'
     }     
     $refNr         = getPage($infil, $sidnr, $action);
     if ($refNr)
     {  $objRef{$namn} = $refNr; 
     }
     else
     {  if ($tolerant)
        {  if ((defined $refNr) && ($refNr eq '0'))   # Sidnumret existerar inte, men ok
           {   $namn = '0';
           }
           else
           {   undef $namn;   # Sidan kan inte användas som form
           }
        }
        elsif (! defined $refNr)
        {  my $mess = "$fSource can't be used as a form. Try e.g. to\n"
                    . "save the file as postscript, and redistill\n";
           errLog($mess);
        }
        else
        {  errLog("File : $infil  Page: $sidnr  doesn't exist");
        }
     }
  }
  else
  {  if (exists $knownToFile{$fSource})
     {   $namn = $knownToFile{$fSource};
     }
     else
     {  $formNr++;
        $namn = 'Fm' . $formNr;
        $knownToFile{$fSource} = $namn; 
     }
     if (exists $objRef{$namn})
     {  $refNr = $objRef{$namn};
     }
     else
     {  if (! $form{$fSource}[fVALID])
        {  my $mess = "$fSource can't be used as a form. Try e.g. to\n"
                    . "concatenate the streams of the page\n";
           if ($tolerant)
           {  cluck $mess;
              undef $namn;
           }
           else
           {  errLog($mess);
           }
        }
        elsif ($effect ne 'load')
        {  $refNr         =  byggForm($infil, $sidnr);
           $objRef{$namn} = $refNr;
        }
     }  
  }
  my @BBox = @{$form{$fSource}[fBBOX]} if ($refNr);
  if (($effect eq 'print') && ($form{$fSource}[fVALID]) && ($refNr))
  {   if ((! defined $interActive)
      && ($sidnr == 1)
      &&  (defined %{$intAct{$fSource}[0]}) )
      {  $interActive = $infil . ' ' . $sidnr;
         $interAktivSida = 1;
      }
      if (! defined $defGState)
      { prDefaultGrState();
      }
      if ($adjust)
      {   $stream .= "q\n";
          $stream .= fillTheForm(@BBox, $adjust);
          $stream .= "\n/Gs0 gs\n";
          $stream .= "/$namn Do\n";
          $stream .= "Q\n";
      }
      elsif (($x) || ($y) || ($rotate) || ($size != 1) 
                  || ($xsize != 1)     || ($ysize != 1))
      {   $stream .= "q\n";
          $stream .= calcMatrix($x, $y, $rotate, $size, 
                               $xsize, $ysize, $BBox[2], $BBox[3]);
          $stream .= "\n/Gs0 gs\n";
          $stream .= "/$namn Do\n";
          $stream .= "Q\n";
      }
      else
      {   $stream .= "\n/Gs0 gs\n";   
          $stream .= "/$namn Do\n";          
      }
      $sidXObject{$namn} = $refNr;
      $sidExtGState{'Gs0'} = $defGState;
  }
  if ($runfil)
  {   $infil = prep($infil); 
      $log .= "Form~$infil~$sidnr~$adjust~$effect~$tolerant";
      $log .= "~$x~$y~$rotate~$size~$xsize~$ysize\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }
  if (($effect ne 'print') && ($effect ne 'add'))
  {  undef $namn;
  }
  if (wantarray)
  {  my $images = 0;
     if (exists $form{$fSource}[fIMAGES])
     {  $images = scalar(@{$form{$fSource}[fIMAGES]});
     } 
     return ($namn, $BBox[0], $BBox[1], $BBox[2], 
             $BBox[3], $images);
  }
  else
  {  return $namn;
  }
}

sub calcMatrix
{  my ($x, $y, $rotate, $size, $xsize, $ysize, $upperX, $upperY) = @_;
   my ($str, $xSize, $ySize);
   $size  = 1 if ($size  == 0);
   $xsize = 1 if ($xsize == 0);
   $ysize = 1 if ($ysize == 0);
   $xSize = $xsize * $size;
   $ySize = $ysize * $size;   
   $str = "$xSize 0 0 $ySize $x $y cm\n";
   if ($rotate)
   {   if ($rotate =~ m'q(\d)'oi)
       {  my $tal = $1;
          if ($tal == 1)
          {  $upperY = $upperX;
             $upperX = 0;
             $rotate = 270;
          }
          elsif ($tal == 2)
          {  $rotate = 180;
          }
          else
          {  $rotate = 90;
             $upperX = $upperY;
             $upperY = 0;
          }
       }
       else
       {   $upperX = 0;
           $upperY = 0;
       }  
       my $radian = sprintf("%.6f", $rotate / 57.2957795);    # approx. 
       my $Cos    = sprintf("%.6f", cos($radian));
       my $Sin    = sprintf("%.6f", sin($radian));
       my $negSin = $Sin * -1;
       $str .= "$Cos $Sin $negSin $Cos $upperX $upperY cm\n";
   }
   return $str;
}

sub fillTheForm
{  my $left   = shift || 0;
   my $bottom = shift || 0;
   my $right  = shift || 0;
   my $top    = shift || 0; 
   my $how    = shift || 1;
   my $image  = shift;
   my $str;
   my $scaleX = 1;
   my $scaleY = 1; 
   
   my $xDim = $genUpperX - $genLowerX;
   my $yDim = $genUpperY - $genLowerY;
   my $xNy  = $right - $left;
   my $yNy  = $top - $bottom;
   $scaleX  = $xDim / $xNy;
   $scaleY  = $yDim / $yNy;
   if ($how == 1)
   {  if ($scaleX < $scaleY)
      {  $scaleY = $scaleX;
      }
      else
      {  $scaleX = $scaleY;
      }
   }
   $str = "$scaleX 0 0 $scaleY $left $bottom cm\n";
   return $str;
}

sub prJpeg
{  my ($iFile, $iWidth, $iHeight) = @_;
   my ($iLangd, $namnet, $utrad);
   if (! $pos)                    # If no output is active, it is no use to continue
   {   return undef;
   }
   my $checkidOld = $checkId;
   ($iFile, $checkId) = findGet($iFile, $checkidOld);
   if ($iFile)
   {  $iLangd = (stat($iFile))[7];
      $imageNr++;
      $namnet = 'Im' . $imageNr;
      $objNr++;
      $objekt[$objNr] = $pos;
      open (BILDFIL, "<$iFile") || errLog("Couldn't open $iFile, $!, aborts");
      binmode BILDFIL;
      my $iStream;
      sysread BILDFIL, $iStream, $iLangd;
      $utrad = "$objNr 0 obj\n<</Type/XObject/Subtype/Image/Name/$namnet" .
                "/Width $iWidth /Height $iHeight /BitsPerComponent 8 /Filter/DCTDecode/ColorSpace/DeviceRGB"
                . "/Length $iLangd >>stream\n$iStream\nendstream\nendobj\n";
      close BILDFIL;
      $pos += syswrite UTFIL, $utrad;
      if ($runfil)
      {  $log .= "Cid~$checkId\n";
         $log .= "Jpeg~$iFile~$iWidth~$iHeight\n";
      }
      $objRef{$namnet} = $objNr;
   }
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }
   undef $checkId;
   return $namnet;
}

sub checkContentStream
{  for (@_)
   {  if (my $value = $objRef{$_})
      {   my $typ = substr($_, 0, 2);
          if ($typ eq 'Ft')
          {  $sidFont{$_} = $value;
          }
          elsif ($typ eq 'Gs')
          {  $sidExtGState{$_} = $value;
          }
          elsif ($typ eq 'Pt')
          {  $sidPattern{$_} = $value;
          }
          elsif ($typ eq 'Sh')
          {  $sidShading{$_} = $value;
          }
          elsif ($typ eq 'Cs')
          {  $sidColorSpace{$_} = $value;
          }
          else
          {  $sidXObject{$_} = $value;
          }
      }
      elsif (($_ eq 'Gs0') && (! defined $defGState))
      {  my ($dummy, $oNr) = prDefaultGrState();
         $sidExtGState{'Gs0'} = $oNr;
      }
   }    
}

sub prGraphState
{  my $string = shift;
   $gSNr++;
   my $name = 'Gs' . $gSNr ;
   $objNr++;
   $objekt[$objNr] = $pos;
   my $utrad = "$objNr 0 obj\n" . $string  . "\nendobj\n";
   $pos += syswrite UTFIL, $utrad;
   $objRef{$name} = $objNr;
   if ($runfil)
   {  $log .= "GraphStat~$string\n";
   }
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }
   return $name;
}

##############################################################
# Streckkods fonten lokaliseras och objekten skrivs ev. ut
##############################################################

sub findBarFont()
{  my $Font = 'Bar';
   
   if (exists $font{$Font})              #  Objekt är redan definierat
   {  $aktuellFont[foEXTNAMN]   = $Font;
      $aktuellFont[foREFOBJ]    = $font{$Font}[foREFOBJ];
      $aktuellFont[foINTNAMN]   = $font{$Font}[foINTNAMN];
   }
   else
   {  $objNr++;
      $objekt[$objNr]  = $pos;
      my $encodObj     = $objNr;
      my $fontObjekt   = "$objNr 0 obj\n<< /Type /Encoding\n" .
                         '/Differences [48 /tomt /streck /lstreck]' . "\n>>\nendobj\n";
      $pos += syswrite UTFIL, $fontObjekt;
      my $charProcsObj = createCharProcs();
      $objNr++;
      $objekt[$objNr]  = $pos;
      $fontNr++;
      my $fontAbbr     = 'Ft' . $fontNr; 
      $fontObjekt      = "$objNr 0 obj\n<</Type/Font/Subtype/Type3\n" .
                         '/FontBBox [0 -250 75 2000]' . "\n" .
                         '/FontMatrix [0.001 0 0 0.001 0 0]' . "\n" .
                         "\/CharProcs $charProcsObj 0 R\n" .
                         "\/Encoding $encodObj 0 R\n" .
                         '/FirstChar 48' . "\n" .
                         '/LastChar 50' . "\n" .
                         '/Widths [75 75 75]' . "\n>>\nendobj\n";

      $font{$Font}[foINTNAMN]  = $fontAbbr; 
      $font{$Font}[foREFOBJ]   = $objNr;
      $objRef{$fontAbbr}       = $objNr;
      $objekt[$objNr]          = $pos;
      $aktuellFont[foEXTNAMN]  = $Font;
      $aktuellFont[foREFOBJ]   = $objNr;
      $aktuellFont[foINTNAMN]  = $fontAbbr;
      $pos += syswrite UTFIL, $fontObjekt;
   }
   if (! $pos)
   {  errLog("No output file, you have to call prFile first");
   }
      
   $sidFont{$aktuellFont[foINTNAMN]} = $aktuellFont[foREFOBJ];
}

sub createCharProcs()
{   #################################
    # Fonten (objektet) för 0 skapas
    #################################
    
    $objNr++;
    $objekt[$objNr]  = $pos;
    my $tomtObj = $objNr;
    my $str = "\n75 0 d0\n6 0 69 2000 re\n1.0 g\nf\n";
    my $strLength = length($str);
    my $obj = "$objNr 0 obj\n<< /Length $strLength >>\nstream" .
           $str . "\nendstream\nendobj\n";
    $pos += syswrite UTFIL, $obj;

    #################################
    # Fonten (objektet) för 1 skapas
    #################################

    $objNr++;
    $objekt[$objNr]  = $pos;
    my $streckObj = $objNr;
    $str = "\n75 0 d0\n4 0 71 2000 re\n0.0 g\nf\n";
    $strLength = length($str);
    $obj = "$objNr 0 obj\n<< /Length $strLength >>\nstream" .
           $str . "\nendstream\nendobj\n";
    $pos += syswrite UTFIL, $obj;

    ###################################################
    # Fonten (objektet) för 2, ett långt streck skapas
    ###################################################

    $objNr++;
    $objekt[$objNr]  = $pos;
    my $lStreckObj = $objNr;
    $str = "\n75 0 d0\n4 -250 71 2250 re\n0.0 g\nf\n";
    $strLength = length($str);
    $obj = "$objNr 0 obj\n<< /Length $strLength >>\nstream" .
           $str . "\nendstream\nendobj\n";
    $pos += syswrite UTFIL, $obj;
   
    #####################################################
    # Objektet för "CharProcs" skapas
    #####################################################

    $objNr++;
    $objekt[$objNr]  = $pos;
    my $charProcsObj = $objNr;
    $obj = "$objNr 0 obj\n<</tomt $tomtObj 0 R\n/streck $streckObj 0 R\n" .
           "/lstreck $lStreckObj 0 R>>\nendobj\n";
    $pos += syswrite UTFIL, $obj;
    return $charProcsObj;
}



sub prCid
{   $checkId = shift;
    if ($runfil)
    {  $log .= "Cid~$checkId\n";
    }
    1;    
}
    
sub prIdType
{   $idTyp = shift;
    if ($runfil)
    {  $log .= "IdType~rep\n";
    }
    1;
}
         
    
sub prId
{   $id = shift;
    if ($runfil)
    {  $log .= "Id~$id\n";
    }
    if (! $pos)
    {  errLog("No output file, you have to call prFile first");
    }
    1;
}

sub prJs
{   my $filNamnIn = shift;
    my $filNamn;
    if ($filNamnIn !~ m'\{'os)
    {  my $checkIdOld = $checkId;
       ($filNamn, $checkId) = findGet($filNamnIn, $checkIdOld);
       if (($runfil) && ($checkId) && ($checkId ne $checkIdOld))
       {  $log .= "Cid~$checkId\n";
       }
       $checkId = '';
    }
    else
    {  $filNamn = $filNamnIn;
    }
    if ($runfil)
    {  my $filnamn = prep($filNamn);
       $log .= "Js~$filnamn\n";
    }
    if (($interAktivSida) || ($interActive))
    {  errLog("Too late, has already tried to merge JAVA SCRIPTS within an interactive page");
    }
    elsif (! $pos)
    {  errLog("Too early for JAVA SCRIPTS, create a file first"); 
    }
    push @jsfiler, $filNamn;
    1;
}

sub prInit
{   my $initText  = shift;
    my $duplicate = shift || '';
    my @fall = ($initText =~ m'([\w\d\_\$]+)\s*\(.*?\)'gs);
    for (@fall)
    {  if (! exists $initScript{$_})
       { $initScript{$_} = 0; 
       }
    }
    if ($duplicate)
    {  $duplicateInits = 1;
    }
    push @inits, $initText;
    if ($runfil)
    {   $initText = prep($initText);
        $log .= "Init~$initText~$duplicate\n";
    }
    if (($interAktivSida) || ($interActive))
    {  errLog("Too late, has already tried to create INITIAL JAVA SCRIPTS within an interactive page");
    }
    elsif (! $pos)
    {  errLog("Too early for INITIAL JAVA SCRIPTS, create a file first");
    }
    1;
    
}

sub prVers
{   my $vers = shift;            
    ############################################################
    # Om programmet körs om så kontrolleras VERSION
    ############################################################
    if ($vers ne $VERSION)
    {  warn  "$vers \<\> $VERSION might give different results, if comparing two runs \n";
       return undef;
    }
    else
    {  return 1;
    }
}

sub prDocDir
{  $ddir = findDir(shift);
   1;
}

sub prLogDir
{  $ldir = findDir(shift);
   1;
}

sub prLog
{  my $mess = shift;
   if ($runfil)
   {  $mess  = prep($mess);
      $log .= "Log~$mess\n";
      return 1;
   }
   else
   {  errLog("You have to give a directory for the logfiles first : prLogDir <dir> , aborts");
   }
   
}

sub prGetLogBuffer
{  
   return $log;
}

sub findDir
{ my $dir = shift;
  if ($dir eq '.')
  { return undef; }
  if (! -e $dir)
   {  mkdir $dir || errLog("Couldn't create directory $dir, $!");
   }

  if ((-e $dir) && (-d $dir))
  {  if (substr($dir, length($dir), 1) eq '/')
     {  return $dir; }
     else
     {  return ($dir . '/');
     }
  }
  else
  { errLog("Error finding/creating directory $dir, $!");
  }
}

sub prTouchUp
{ $touchUp = shift;
  if ($runfil)
  {  $log .= "TouchUp~$touchUp\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }
  1;
}

sub prCompress
{ $compress = shift;
  if ($runfil)
  {  $log .= "Compress~$compress\n";
  }
  if (! $pos)
  {  errLog("No output file, you have to call prFile first");
  }
  1;

}

sub prep
{  my $indata = shift;
   $indata =~ s/[\n\r]+/ /sgo;
   $indata =~ s/~/<tilde>/sgo;
   return $indata;
} 


sub xRefs
{  my ($bytes, $infil) = @_;
   my ($j, $nr, $xref, $i, $antal, $inrad, $Root, $tempRoot, $referens);
   my $buf = '';
   %embedded =();

   my $res = sysseek INFIL, -50, 2;
   if ($res)
   {  sysread INFIL, $buf, 100;
      if ($buf =~ m'Encrypt'o)
      {  errLog("The file $infil is encrypted, cannot be used, aborts");
      }
      if ($buf =~ m'\bstartxref\s+(\d+)'o)
      {  $xref = $1;
         while ($xref)
         {  $res = sysseek INFIL, $xref, 0;
            $res = sysread INFIL, $buf, 200;
            if ($buf =~ m '^\d+\s\d+\sobj'os)
            {  ($xref, $tempRoot, $nr) = crossrefObj($nr, $xref);
            }
            else
            {  ($xref, $tempRoot, $nr) = xrefSection($nr, $xref, $infil);
            }
            if (($tempRoot) && (! $Root))
            {  $Root = $tempRoot;
            }
         }
      }
   }

   ($Root) || errLog("The Root object in $infil couldn't be found, aborting");

   ##############################################################
   # Objekten sorteras i fallande ordning (efter offset i filen)
   ##############################################################

   my @offset = sort { $oldObject{$b} <=> $oldObject{$a} } keys %oldObject;

   my $saved;

   for (@offset)
   {   $saved  = $oldObject{$_};
       $bytes -= $saved;
       
       if ($_ !~ m'^xref'o)
       {   if ($saved == 0)
           {   $oldObject{$_} = [ 0, 0, $embedded{$_}];
           }
           else
           {   $oldObject{$_} = [ $saved, $bytes];
           }
       }
       $bytes = $saved;
   } 
   %embedded = ();
   return $Root;
}

sub crossrefObj
{   my ($nr, $xref) = @_;
    my ($buf, %param, $len, $tempRoot);
    my $from = $xref;
    sysseek INFIL, $xref, 0;
    sysread INFIL, $buf, 400;
    my $str;
    if ($buf =~ m'^(.+>>\s*)stream'os)
    {  $str = $1;
       $from = length($str) + 7;
       if (substr($buf, $from, 1) eq "\n")
       {  $from++;
       }
       $from += $xref;
    }
    
    for (split('/',$str))
    {  if ($_ =~ m'^(\w+)(.*)'o)
       {  $param{$1} = $2 || ' ';
       }
    }
    if ((exists $param{'Root'}) && ($param{'Root'} =~ m'^\s*(\d+)'o))
    {  $tempRoot = $1;
    }
    my @keys = ($param{'W'} =~ m'(\d+)'og);
    my $keyLength = 0;
    for (@keys)
    {  $keyLength += $_;
    }
    my $recLength = $keyLength + 1;
    my $upTo = 1 + $keys[0] + $keys[1];
    if ((exists $param{'Length'}) && ($param{'Length'} =~ m'(\d+)'o))
    {  $len = $1;
       sysseek INFIL, $from, 0;
       sysread INFIL, $buf, $len;
       my $x = inflateInit()
               || die "Cannot create an inflation stream\n" ;
       my ($output, $status) = $x->inflate(\$buf) ;
       die "inflation failed\n"
                     unless $status == 1;
       
       my $i = 0;
       my @last = (0, 0, 0, 0, 0, 0, 0);
       my @word = ('0', '0', '0', '0', '0', '0', '0');
       my $recTyp;
       my @intervall = ($param{'Index'} =~ m'(\d+)\D'osg);
       my $m = 0;
       my $currObj = $intervall[$m];
       $m++;
       my $max     = $currObj + $intervall[$m];   
       
       for (unpack ("C*", $output))
       {  if (($_ != 0) && ($i > 0) && ($i < $upTo))
          {   my $tal = $_ + $last[$i] ;
              if ($tal > 255)
              {$tal -= 256;
              }
          
              $last[$i] = $tal;
              $word[$i] = sprintf("%x", $tal);
              if (length($word[$i]) == 1)
              {  $word[$i] = '0' . $word[$i];
              }
          }                    
          $i++;
          if ($i == $recLength)
          {  $i = 0;
             my $j = 0;
             my $offsObj;               # offset or object
             if ($keys[0] == 0)
             {  $recTyp = 1;
                $j = 1;
             }
             else
             {  $recTyp = $word[1];
                $j = 2;
             }
             my $k = 0;
             while ($k < $keys[1])
             {  $offsObj .= $word[$j];
                $k++;
                $j++;
             }
                       
             if ($recTyp == 1)
             {   if (! (exists $oldObject{$currObj}))
                 {  $oldObject{$currObj} = hex($offsObj); }
                 else
                 {  $nr++;
                    $oldObject{'xref' . "$nr"} = hex($offsObj);
                 }
             }
             elsif ($recTyp == 2)
             {   if (! (exists $oldObject{$currObj}))
                 {  $oldObject{$currObj} = 0; 
                 }
                 $embedded{$currObj} = hex($offsObj);
             }
             if ($currObj < $max)
             {  $currObj++;
             }
             else
             {  $m++;
                $currObj = $intervall[$m];
                $m++;
                $max     = $currObj + $intervall[$m];
             } 
          }
       }       
    }
    return ($param{'Prev'}, $tempRoot, $nr);
}
 
sub xrefSection
{   my ($nr, $xref, $infil) = @_;
    my ($i, $root, $antal);    
    $nr++;
    $oldObject{('xref' . "$nr")} = $xref;  # Offset för xref sparas 
    $xref += 5;
    sysseek INFIL, $xref, 0;      
    $xref  = 0;
    my $inrad = '';
    my $buf   = '';
    my $c;
    sysread INFIL, $c, 1;
    while ($c =~ m!\s!s)   
    {  sysread INFIL, $c, 1; }

    while ( (defined $c)
    &&   ($c ne "\n")
    &&   ($c ne "\r") )   
    {    $inrad .= $c;
         sysread INFIL, $c, 1;
    }

    if ($inrad =~ m'^(\d+)\s+(\d+)'o)
    {   $i     = $1;
        $antal = $2;
    }
            
    while ($antal)
    {   for (my $l = 1; $l <= $antal; $l++)
        {  sysread INFIL, $inrad, 20;
           if ($inrad =~ m'^\s?(\d+) \d+ (\w)\s*'o)
           {  if ($2 eq 'n')
              {  if (! (exists $oldObject{$i}))
                 {  $oldObject{$i} = int($1); }
                 else
                 {  $nr++;
                    $oldObject{'xref' . "$nr"} = int($1);
                 }
              } 
           }
           $i++;
        }
        undef $antal;
        undef $inrad;
        sysread INFIL, $c, 1;
        while ($c =~ m!\s!s)   
        {  sysread INFIL, $c, 1; }

        while ( (defined $c)
        &&   ($c ne "\n")
        &&   ($c ne "\r") )   
        {    $inrad .= $c;
             sysread INFIL, $c, 1;
        }
        if ($inrad =~ m'^(\d+)\s+(\d+)'o)
        {   $i     = $1;
            $antal = $2;
        }

    }
             
    while ($inrad)
    {   if ($buf =~ m'Encrypt'o)
        {  errLog("The file $infil is encrypted, cannot be used, aborts");
        }
        if ((! $root) && ($buf =~ m'\/Root\s+(\d+)\s{1,2}\d+\s{1,2}R'so))
        {  $root = $1;
           if ($xref)
           { last; }
        }

        if ((! $xref) && ($buf =~ m'\/Prev\s+(\d+)\D'so))
        {  $xref = $1;
           if ($root)
           { last; }
        }
                
        if ($buf =~ m'xref'so)
        {  last; }
                
        sysread INFIL, $inrad, 30;
        $buf .= $inrad;
    }
    return ($xref, $root, $nr);
}
 
sub getObject
{   my ($nr, $noId, $noEnd) = @_;
    
    my $buf;
    my ($offs, $siz, $embedded) = @{$oldObject{$nr}};
    
    if ($offs)
    {  sysseek INFIL, $offs, 0;
       sysread INFIL, $buf, $siz;
       if (($noId) && ($noEnd))
       {   if ($buf =~ m'^\d+ \d+ obj\s*(.*)endobj'os)
           {   if (wantarray)
               {   return ($1, $offs, $siz, $embedded);
               }
               else
               {   return $1;
               } 
           }
       }
       elsif ($noId)
       {   if ($buf =~ m'^\d+ \d+ obj\s*(.*)'os)
           {   if (wantarray)
               {   return ($1, $offs, $siz, $embedded);
               }
               else
               {   return $1;
               } 
           }
       }
       if (wantarray)
       {   return ($buf, $offs, $siz, $embedded)
       }
       else
       {   return $buf;
       } 
    }
    elsif (exists $unZipped{$nr})
    {  ;
    }
    elsif ($embedded)
    {   unZipPrepare($embedded);
    }
    if ($noEnd)
    {   if (wantarray)
        {   return ($unZipped{$nr}, $offs, $siz, $embedded)
        }
        else
        {   return $unZipped{$nr};
        }
    }
    else
    {   if (wantarray)
        {   return ("$unZipped{$nr}endobj\n", $offs, $siz, $embedded)
        }
        else
        {   return "$unZipped{$nr}endobj\n";
        }
    } 
}

sub getKnown
{   my ($p, $nr) = @_;
    my ($del1, $del2);
    my @objData = @{$$$p[0]->{$nr}};
    if (defined $objData[oSTREAMP])
    {  sysseek INFIL, ($objData[oNR][0] + $objData[oPOS]), 0;
       sysread INFIL, $del1, ($objData[oSTREAMP] - $objData[oPOS]);
       sysread INFIL, $del2, ($objData[oNR][1]   - $objData[oSTREAMP]);
    }
    else
    {  my $buf;
       my ($offs, $siz, $embedded) = @{$objData[oNR]};
       if ($offs)
       {  sysseek INFIL, $offs, 0;
          sysread INFIL, $buf, $siz;
          if ($buf =~ m'^\d+ \d+ obj\s*(.*)'os)
          {   $del1 = $1;
          }  
       }
       elsif (exists $unZipped{$nr})
       {  $del1 = "$unZipped{$nr} endobj";
       }
       elsif ($embedded)
       {   @objData = @{$$$p[0]->{$embedded}};
           unZipPrepare($embedded, $objData[oNR][0], $objData[oNR][1]);
           $del1 = "$unZipped{$nr} endobj"; 
       }        
    }
    return (\$del1, \$del2, $objData[oKIDS], $objData[oTYPE]);
}


sub unZipPrepare
{  my ($nr, $offs, $size) = @_;
   my $buf;
   if ($offs)
   {   sysseek INFIL, $offs, 0;
       sysread INFIL, $buf, $size;
   }
   else
   {   $buf = getObject($nr);
   }
   my (%param, $stream, $str);
   
   if ($buf =~ m'^(\d+ \d+ obj\s*<<[\w\d\/\s\[\]<>]+)stream\b'os)
   {  $str  = $1;
      $offs = length($str) + 7;
      if (substr($buf, $offs, 1) eq "\n")
      {  $offs++;
      }

      for (split('/',$str))
      {  if ($_ =~ m'^(\w+)(.*)'o)
         {  $param{$1} = $2 || ' ';
         }
      }
      $stream = substr($buf, $offs, $param{'Length'});
      my $x = inflateInit()
           || die "Cannot create an inflation stream\n";
      my ($output, $status) = $x->inflate($stream);
      die "inflation failed\n"
                     unless $status == 1;

      my $first = $param{'First'};
      my @oOffsets = (substr($output, 0, $first) =~ m'(\d+)\b'osg);
      my $i = 0;
      my $j = 1;
      my $bytes;
      while ($oOffsets[$i])
      {  my $k = $j + 2;
         if ($oOffsets[$k])
         {  $bytes = $oOffsets[$k] - $oOffsets[$j];
         }
         else 
         {  $bytes = length($output) - $first - $oOffsets[$j];
         }         
         $unZipped{$oOffsets[$i]} = substr($output,($first + $oOffsets[$j]), $bytes); 
         $i += 2;
         $j += 2;
      }
   }
}
         
############################################
# En definitionerna för en sida extraheras
############################################

sub getPage
{  my ($infil, $sidnr, $action)  = @_;

   my ($res, $i, $referens,$objNrSaved,$validStream, $formRes, @objData, 
       @underObjekt, @sidObj, $strPos, $startSida, $sidor, $filId, $del1, $del2,
       $offs, $siz, $embedded, $vektor, $utrad, $robj, $valid, $Annots, $Names,
       $AcroForm, $AARoot, $AAPage);

   my $sidAcc = 0;
   my $seq    = 0;
   $imSeq     = 0;
   @skapa     = ();   
   undef $formCont;
   
   
   $objNrSaved = $objNr;   
   my $fSource = $infil . '_' . $sidnr;
   my $checkidOld = $checkId;
   ($infil, $checkId) = findGet($infil, $checkidOld);
   if (($ldir) && ($checkId) && ($checkId ne $checkidOld))
   {  $log .= "Cid~$checkId\n";
   }
   $form{$fSource}[fID] =  $checkId;
   $checkId = '';
   $behandlad{$infil}->{old} = {} 
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});

   if ($action eq 'print')
   {  *old = $behandlad{$infil}->{old};
   }
   else
   {  $behandlad{$infil}->{dummy} = {};
      *old = $behandlad{$infil}->{dummy};
   }
   
   *oldObject =  $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};
   $root      = (exists $processed{$infil}->{root}) 
                    ? $processed{$infil}->{root} : 0;
   
   
   my @stati = stat($infil);
   open (INFIL, "<$infil") || errLog("Couldn't open $infil, $!");
   binmode INFIL;

   if (! $root)
   {  $root = xRefs($stati[7], $infil);
   }

   #############
   # Hitta root
   #############           

   my $objektet = getObject($root);;
   
   if ($sidnr == 1) 
   {  if ($objektet =~ m'/AcroForm(\s+\d+\s{1,2}\d+\s{1,2}R)'so)
      {  $AcroForm = $1;
      }
      if ($objektet =~ m'/Names\s+(\d+)\s{1,2}\d+\s{1,2}R'so)
      {  $Names = $1;
      } 
      #################################################
      #  Finns ett dictionary för Additional Actions ?
      #################################################
      if ($objektet =~ m'/AA\s*\<\<\s*[^\>]+[^\>]+'so) # AA är ett dictionary
      {  my $k;
         my ($dummy, $obj) = split /\/AA/, $objektet;
         $obj =~ s/\<\</\#\<\</gs;
         $obj =~ s/\>\>/\>\>\#/gs;
         my @ord = split /\#/, $obj;
         for ($i = 0; $i <= $#ord; $i++)
         {   $AARoot .= $ord[$i];
             if ($ord[$i] =~ m'\S+'os)
             {  if ($ord[$i] =~ m'<<'os)
                {  $k++; }
                if ($ord[$i] =~ m'>>'os)
                {  $k--; }
                if ($k == 0)
                {  last; }
             } 
          }
      }
   }
     
   #
   # Hitta pages
   #
 
   if ($objektet =~ m'/Pages\s+(\d+)\s{1,2}\d+\s{1,2}R'os)
   {  $objektet = getObject($1);
      if ($objektet =~ m'/Count\s+(\d+)'os)
      {  $sidor = $1;
         if ($sidnr <= $sidor)
         {  ($formRes, $valid) = kolla($objektet); 
         }
         else
         {   return 0;
         }
         if ($sidor > 1)
         {   undef $AcroForm;
             undef $Names;
             undef $AARoot;
             if ($type eq 'docform')
             {  errLog("prDocForm can only be used for single page documents - try prDoc or reformat $infil");
             }
         }
      }
   }
   else
   { errLog("Didn't find Pages in $infil - aborting"); }

   if ($objektet =~ m'/Kids\s*\[([^\]]+)'os)
   {  $vektor = $1; } 
   while ($vektor =~ m'(\d+)\s{1,2}\d+\s{1,2}R'go)
   {   push @sidObj, $1;       
   }

   my $bryt1 = -20;                     # Hängslen
   my $bryt2 = -20;                     # Svångrem för att undvika oändliga loopar
   
   while ($sidAcc < $sidnr)
   {  @underObjekt = @sidObj;
      @sidObj     = ();
      $bryt1++;
      for my $uO (@underObjekt)
      {  $objektet = getObject($uO);
         if ($objektet =~ m'/Count\s+(\d+)'os)
         {  if (($sidAcc + $1) < $sidnr)
            {  $sidAcc += $1; }
            else
            {  ($formRes, $valid) = kolla($objektet, $formRes);
               if ($objektet =~ m'/Kids\s*\[([^\]]+)'os)
               {  $vektor = $1; } 
               while ($vektor =~ m'(\d+)\s{1,2}\d+\s{1,2}R'gso)
               {   push @sidObj, $1;  }
               last; 
            }
         }
         else
         {  $sidAcc++; }
         if ($sidAcc == $sidnr)
         {   $seq = $uO;
             last;  }
         $bryt2++;
      }
      if (($bryt1 > $sidnr) || ($bryt2 > $sidnr))   # Bryt oändliga loopar 
      {  last; } 
   }    

   ($formRes, $validStream) = kolla($objektet, $formRes);
   $startSida = $seq;
       
   if ($sidor == 1)
   {  #################################################
      # Kontrollera Page-objektet för annoteringar
      #################################################

      if ($objektet =~ m'/Annots\s*([^\/]+)'so)
      {  $Annots = $1;
      } 
      #################################################
      #  Finns ett dictionary för Additional Actions ?
      #################################################
      if ($objektet =~ m'/AA\s*\<\<\s*[^\>]+[^\>]+'so)  # AA är ett dictionary. Hela kopieras
      {  my $k;
         my ($dummy, $obj) = split /\/AA/, $objektet;
         $obj =~ s/\<\</\#\<\</gs;
         $obj =~ s/\>\>/\>\>\#/gs;
         my @ord = split /\#/, $obj;
         for ($i = 0; $i <= $#ord; $i++)
         {   $AAPage .= $ord[$i];
             if ($ord[$i] =~ m'\S+'s)
             {  if ($ord[$i] =~ m'<<'s)
                {  $k++; }
                if ($ord[$i] =~ m'>>'s)
                {  $k--; }
                if ($k == 0)
                {  last; }
             } 
          }
      }      
   }

   my $rform = \$form{$fSource};
   @$$rform[fRESOURCE]  = $formRes;
   my @BBox;
   if (defined $formBox[0])
   {  $BBox[0] = $formBox[0]; }
   else
   {  $BBox[0] = $genLowerX; }
 
   if (defined $formBox[1])
   {  $BBox[1] = $formBox[1]; }
   else
   {  $BBox[1] = $genLowerY; }
 
   if (defined $formBox[2])
   {  $BBox[2] = $formBox[2]; }
   else
   {  $BBox[2] = $genUpperX; }
 
   if (defined $formBox[3])
   {  $BBox[3] = $formBox[3]; }
   else
   {  $BBox[3] = $genUpperY; }
 
   @{$form{$fSource}[fBBOX]} = @BBox;

   if ($formCont) 
   {   $seq = $formCont;
       ($objektet, $offs, $siz, $embedded) = getObject($seq);
       
       $robj  = \$$$rform[fOBJ]->{$seq};
       @{$$$robj[oNR]} = ($offs, $siz, $embedded);
       $$$robj[oFORM] = 'Y';
       $form{$fSource}[fMAIN] = $seq;
       if ($objektet =~ m'^(\d+ \d+ obj\s*<<)(.+)(>>\s*stream)'so)
       {  $del1   = $2;
          $strPos           = length($1) + length($2) + length($3);
          $$$robj[oPOS]     = length($1);      
          $$$robj[oSTREAMP] = $strPos; 
          my $nyDel1;
          $nyDel1 = '<</Type/XObject/Subtype/Form/FormType 1'; 
          $nyDel1 .= "/Resources $formRes" .
                     "/BBox \[ $BBox[0] $BBox[1] $BBox[2] $BBox[3]\]" .
                     # "/Matrix \[ 1 0 0 1 0 0 \]" .
                     $del1;
          if ($action eq 'print')
          {  $objNr++;
             $objekt[$objNr] = $pos;
          }
          $referens = $objNr;

          $res = ($nyDel1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs);
          if ($res)
          { $$$robj[oKIDS] = 1; }
          if ($action eq 'print')
          {   $utrad  = "$referens 0 obj\n" . "$nyDel1" . ">>\nstream";
              $del2   = substr($objektet, $strPos);
              $utrad .= $del2;
              $pos   += syswrite UTFIL, $utrad;
          }
          $form{$fSource}[fVALID] = $validStream;
      }
      else                              # Endast resurserna kan behandlas
      {   $formRes =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;  
      }
   }
   else                                # Endast resurserna kan behandlas
   {  $formRes =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   } 
      
   my $preLength;
   while (scalar @skapa)
   {  my @process = @skapa;
      @skapa = ();
      for (@process)
      {  my $Font;
         my $gammal = $$_[0];
         my $ny     = $$_[1];
         ($objektet, $offs, $siz, $embedded)  = getObject($gammal);
         $robj      = \$$$rform[fOBJ]->{$gammal};
         @{$$$robj[oNR]} = ($offs, $siz, $embedded);      
         if ($objektet =~ m'^(\d+ \d+ obj\s*<<)(.+)(>>\s*stream)'os)
         {  $del1             = $2;
            $strPos           = length ($1) + length($2) + length($3);
            $$$robj[oPOS]     = length($1);
            $$$robj[oSTREAMP] = $strPos;
 
            ######## En bild ########
            if ($del1 =~ m'/Subtype\s*/Image'so)
            {  $imSeq++;
               $$$robj[oIMAGENR] = $imSeq;
               push @{$$$rform[fIMAGES]}, $gammal;

               if ($del1 =~ m'/Width\s+(\d+)'os)
               {  $$$robj[oWIDTH] = $1; }
               if ($del1 =~ m'/Height\s+(\d+)'os)
               {  $$$robj[oHEIGHT] = $1; }
            }     
            $res = ($del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs);
            if ($res)
            { $$$robj[oKIDS] = 1; }            
            if ($action eq 'print')
            {   $objekt[$ny] = $pos;
                $utrad  = "$ny 0 obj\n<<" . "$del1" . '>>stream';
                $del2   = substr($objektet, $strPos);
                $utrad .= $del2; 
            }
         }
         else
         {  if ($objektet =~ m'^(\d+ \d+ obj\s*)'os)
            {  $preLength = length($1);
               $$$robj[oPOS] = $preLength;               
               $objektet     = substr($objektet, $preLength);
            }
            else
            {  $$$robj[oPOS] = 0;
            }
            $res = ($objektet =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs);
            if ($res)
            { $$$robj[oKIDS] = 1; }
            if ($objektet =~ m'/Subtype\s*/Image'so)
            {  $imSeq++;
               $$$robj[oIMAGENR] = $imSeq;
               push @{$$$rform[fIMAGES]}, $gammal;
               ###################################
               # Sparar dimensionerna för bilden
               ###################################
               if ($del1 =~ m'/Width\s+(\d+)'os)
               {  $$$robj[oWIDTH] = $1; }
      
               if ($del1 =~ m'/Height\s+(\d+)'os)
               {  $$$robj[oHEIGHT] = $1; }
            }
            elsif ($objektet =~ m'/BaseFont\s*/([^\s\/]+)'os)
            {  $Font = $1;
               $$$robj[oTYPE] = 'Font';
               $$$robj[oNAME] = $Font;
               if ((! exists $font{$Font}) 
               && ($action))
               {  $fontNr++;
                  $font{$Font}[foINTNAMN]          = 'Ft' . $fontNr;
                  $font{$Font}[foORIGINALNR]       = $gammal;
                  $fontSource{$Font}[foSOURCE]     = $fSource;
                  $fontSource{$Font}[foORIGINALNR] = $gammal;
                  if ($action eq 'print')
                  {  $font{$Font}[foREFOBJ]  = $ny;
                     $objRef{'Ft' . $fontNr} = $ny;
                  }
               }   
            }
               
            if ($action eq 'print')
            {   $objekt[$ny] = $pos;
                $utrad = "$ny 0 obj $objektet";
            }
         }
         if ($action eq 'print')
         {   $pos += syswrite UTFIL, $utrad;
         }
       }
   }
   
   my $ref = \$form{$fSource};
   my @kids;
   my @nokids;  
   
   #################################################################
   # lägg upp vektorer över vilka objekt som har KIDS eller NOKIDS
   #################################################################   

   for my $key (keys %{$$$ref[fOBJ]})
   {   $robj  = \$$$ref[fOBJ]->{$key};
       if (! defined  $$$robj[oFORM])
       {   if (defined  $$$robj[oKIDS])
           {   push @kids, $key; }
           else
           {   push @nokids, $key; }
       }
       if ((defined $$$robj[0]->[2]) && (! exists $$$ref[fOBJ]->{$$$robj[0]->[2]}))
       {  $$$ref[fOBJ]->{$$$robj[0]->[2]}->[0] = $oldObject{$$$robj[0]->[2]};
       }
   }
   if (scalar @kids)
   {  $form{$fSource}[fKIDS] = \@kids; 
   } 
   if (scalar @nokids)
   {  $form{$fSource}[fNOKIDS] = \@nokids; 
   } 
   
   if ($action ne 'print')
   {  $objNr = $objNrSaved;            # Restore objNo if nothing was printed
   }

   $behandlad{$infil}->{dummy} = {};
   *old = $behandlad{$infil}->{dummy};
    
   $objNrSaved = $objNr;               # Save objNo

   if ($sidor == 1)
   {   @skapa = ();
       $old{$startSida} = $sidObjNr;
       my $ref = \$intAct{$fSource};
       @$$ref[iSTARTSIDA] = $startSida;
       if (defined $Names)
       {   @$$ref[iNAMES] = $Names;
           quickxform($Names);
       }
       if (defined $AcroForm)
       {   @$$ref[iACROFORM] = $AcroForm;
           $AcroForm =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
       }
       if (defined $AARoot)
       {   @$$ref[iAAROOT] = $AARoot;
           $AARoot =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
       }
       if (defined $AAPage)
       {   @$$ref[iAAPAGE] = $AAPage;
           $AAPage =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
       }
       if (defined $Annots)
       {   my @array;
           if ($Annots =~ m'\[([^\[\]]*)\]'os)
           {  $Annots = $1;
              @array = ($Annots =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'ogs);  
           }
           else
           {  if ($Annots =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'os)
              {  $Annots = getObject($1);
                 @array = ($Annots =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'ogs);
              }
           }             
           @$$ref[iANNOTS] = \@array;
           $Annots =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
       }
      
      while (scalar @skapa)
      {  my @process = @skapa;
         @skapa = ();
         for (@process)
         {  my $gammal = $$_[0];
            my $ny     = $$_[1];
            ($objektet, $offs, $siz, $embedded) = getObject($gammal);
            $robj  = \$$$ref[fOBJ]->{$gammal};
            @{$$$robj[oNR]} = ($offs, $siz, $embedded);
            if ($objektet =~ m'^(\d+ \d+ obj\s*<<)(.+)(>>\s*stream)'os)
            {  $del1             = $2;
               $$$robj[oPOS]     = length($1);
               $$$robj[oSTREAMP] = length($1) + length($2) + length($3);
                  
               $res = ($del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs);
               if ($res)
               { $$$robj[oKIDS] = 1; }  
            }
            else
            {  if ($objektet =~ m'^(\d+ \d+ obj)'os)
               {  my $preLength = length($1);
                  $$$robj[oPOS] = $preLength;
                  $objektet = substr($objektet, $preLength);
                                 
                  $res = ($objektet =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs);
                  if ($res)
                  { $$$robj[oKIDS] = 1; }
                }
             }
         }
      }
      for my $key (keys %{$$$ref[fOBJ]})
      {   $robj  = \$$$ref[fOBJ]->{$key};
          if ((defined $$$robj[0]->[2]) && (! exists $$$ref[fOBJ]->{$$$robj[0]->[2]}))
          {  $$$ref[fOBJ]->{$$$robj[0]->[2]}->[0] = $oldObject{$$$robj[0]->[2]};
          }
      }
  }

  $objNr = $objNrSaved;
  $processed{$infil}->{root}         = $root;
  close INFIL;
  return $referens;
}  

##################################################
# Översätter ett gammalt objektnr till ett nytt
# och sparar en tabell med vad som skall skapas
##################################################

sub xform
{  if (exists $old{$1})
   {  $old{$1}; 
   }
   else
   {  push @skapa, [$1, ++$objNr];
      $old{$1} = $objNr;                   
   } 
}
 
sub kolla
{  #
   # Resurser
   #
   my $obj       = shift;
   my $resources = shift;
   my $valid;
    
   if ($obj =~ m'MediaBox\s*\[\s*([\-\.\d]+)\s+([\-\.\d]+)\s+([\-\.\d]+)\s+([\-\.\d]+)'os)
   { $formBox[0] = $1;
     $formBox[1] = $2;
     $formBox[2] = $3;
     $formBox[3] = $4;
   }
  
   if ($obj =~ m'/Contents\s+(\d+)'so)
   { $formCont = $1;
     $valid    = 1;
   }
   
   if ($obj =~ m'^(.+/Resources)'so)
   {  if ($obj =~ m'Resources(\s+\d+\s{1,2}\d+\s{1,2}R)'os)   # Hänvisning
      {  $resources = $1; }
      else                 # Resurserna är ett dictionary. Hela kopieras
      {  my $dummy;
         my $i;
         my $k;
         undef $resources;
         ($dummy, $obj) = split /\/Resources/, $obj;
         $obj =~ s/\<\</\#\<\</gs;
         $obj =~ s/\>\>/\>\>\#/gs;
         my @ord = split /\#/, $obj;
         for ($i = 0; $i <= $#ord; $i++)
         {   $resources .= $ord[$i];
             if ($ord[$i] =~ m'\S+'s)
             {  if ($ord[$i] =~ m'<<'s)
                {  $k++; }
                if ($ord[$i] =~ m'>>'s)
                {  $k--; }
                if ($k == 0)
                {  last; }
             } 
          }
       }
    }
    return ($resources, $valid);
}

##############################
# Ett formulär (åter)skapas
##############################

sub byggForm
{  no warnings; 
   my ($infil, $sidnr) = @_;
   
   my ($res, $corr, $nyDel1, $formRes, $del1, $del2, $kids, $typ, $nr,
       $utrad);
      
   my $fSource = $infil . '_' . $sidnr;
   my @stati = stat($infil);

   $behandlad{$infil}->{old} = {} 
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});

   *old       = $behandlad{$infil}->{old};
   *oldObject = $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};
      
   if ($form{$fSource}[fID] != $stati[9])
   {    errLog("$stati[9] ne $form{$fSource}[fID] aborts");
   }
   if ($checkId) 
   {  if ($checkId ne $stati[9])
      {  my $mess =  "$checkId \<\> $stati[9] \n"
                  . "The Pdf-file $fSource has not the correct modification time. \n"
                  .  "The program is aborted";
         errLog($mess);
      }
      undef $checkId;
    }
    if ($ldir)
    {  $log .= "Cid~$stati[9]\n";
    }

   open (INFIL, "<$infil") || errLog("The file $infil couldn't be opened, aborting $!");
   binmode INFIL;

   ####################################################
   # Objekt utan referenser  kopieras och skrivs
   ####################################################   

   for my $key (@{$form{$fSource}->[fNOKIDS]})
   {   if ((defined $old{$key}) && ($objekt[$old{$key}]))    # already processed
       {  next;
       }
              
       if (! defined $old{$key})
       {  $old{$key} = ++$objNr;
       }
       $nr = $old{$key};
       $objekt[$nr] = $pos;
     
       ($del1, $del2, $kids, $typ) = getKnown(\$form{$fSource},$key);
             
       if ($typ eq 'Font')
       {  my $Font = ${$form{$fSource}}[0]->{$key}->[oNAME];
          if (! defined $font{$Font}[foINTNAMN])
          {  $fontNr++;
             $font{$Font}[foINTNAMN]  = 'Ft' . $fontNr;
             $font{$Font}[foREFOBJ]   = $nr;
             $objRef{'Ft' . $fontNr}  = $nr;
          }
       }
       if (! defined $$del2)
       {   $utrad = "$nr 0 obj " . $$del1;
       }
       else
       {   $utrad = "$nr 0 obj\n<<" . $$del1 . $$del2;
       }     
       $pos += syswrite UTFIL, $utrad;     
   }

   #######################################################
   # Objekt med referenser kopieras, behandlas och skrivs
   #######################################################
   for my $key (@{$form{$fSource}->[fKIDS]})
   {   if ((defined $old{$key}) && ($objekt[$old{$key}]))  # already processed
       {  next;
       }
        
       if (! defined $old{$key})
       {  $old{$key} = ++$objNr;
       }
       $nr = $old{$key};
       
       $objekt[$nr] = $pos;
       
       ($del1, $del2, $kids, $typ) = getKnown(\$form{$fSource},$key);

       $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/translate() . ' 0 R'/oegs;
       
       if (defined $$del2)          
       {  $utrad = "$nr 0 obj\n<<" . $$del1 . $$del2;
       }
       else
       {  $utrad = "$nr 0 obj " . $$del1;
       } 
       
       if (($typ) && ($typ eq 'Font'))
       {  my $Font = $form{$fSource}[0]->{$key}->[oNAME];
          if (! defined $font{$Font}[foINTNAMN])
          {  $fontNr++;
             $font{$Font}[foINTNAMN]  = 'Ft' . $fontNr;
             $font{$Font}[foREFOBJ]   = $nr;
             $objRef{'Ft' . $fontNr} = $nr;
          }
       }   
       
       $pos += syswrite UTFIL, $utrad;                
   }

   #################################
   # Formulärobjektet behandlas 
   #################################
   
   my $key = $form{$fSource}->[fMAIN];
   if (! defined $key)
   {  return undef;
   }

   if (exists $old{$key})                      # already processed
   {  close INFIL;
      return $old{$key}; 
   }

   $nr = ++$objNr;
   
   $objekt[$nr] = $pos;
   
   $formRes = $form{$fSource}->[fRESOURCE];   
    
   ($del1, $del2) = getKnown(\$form{$fSource}, $key);  

   $nyDel1 = '<</Type/XObject/Subtype/Form/FormType 1'; 
   $nyDel1 .= "/Resources $formRes" .
                 '/BBox [' .
                 $form{$fSource}->[fBBOX]->[0]  . ' ' .
                 $form{$fSource}->[fBBOX]->[1]  . ' ' .
                 $form{$fSource}->[fBBOX]->[2]  . ' ' .
                 $form{$fSource}->[fBBOX]->[3]  . ' ]' .  
                 # "\]/Matrix \[ $sX 0 0 $sX $tX $tY \]" .
                 $$del1;
   $nyDel1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/translate() . ' 0 R'/oegs;

   $utrad = "$nr 0 obj" . $nyDel1 . $$del2;
   
   $pos += syswrite UTFIL, $utrad;                    
   close INFIL;

   return $nr;   
}

##################
#  En bild läses
##################

sub getImage
{  my ($infil, $sidnr, $bildnr, $key) =  @_;
   if (! defined $key)
   {  errLog("Can't find image $bildnr on page $sidnr in file $infil, aborts");
   } 
   
   @skapa = ();
   my ($res, $corr, $nyDel1, $del1, $del2, $nr, $utrad);
   my $fSource = $infil . '_' . $sidnr;
   my $iSource = $fSource . '_' . $bildnr;

   $behandlad{$infil}->{old} = {} 
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});  

   *old       = $behandlad{$infil}->{old};
   *oldObject = $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};
      
   my @stati = stat($infil);

   if ($form{$fSource}[fID] != $stati[9])
   {    errLog("$stati[9] ne $form{$fSource}[fID], modification time has changed, aborting");
   }

   if (exists $old{$key})
   {  return $old{$key}; 
   }

   open (INFIL, "<$infil") || errLog("The file $infil couldn't be opened, $!");
   binmode INFIL; 

   #########################################################
   # En bild med referenser kopieras, behandlas och skrivs
   #########################################################

   $nr = ++$objNr;
   $old{$key} = $nr;
   
   $objekt[$nr] = $pos;

   ($del1, $del2) = getKnown(\$form{$fSource}, $key);

   $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;      
   if (defined $$del2)
   {  $utrad = "$nr 0 obj\n<<" . $$del1 . $$del2;
   }
   else
   {  $utrad = "$nr 0 obj " . $$del1;
   }
   $pos += syswrite UTFIL, $utrad;
   ##################################
   #  Skriv ut underordnade objekt
   ################################## 
   while (scalar @skapa)
   {  my @process = @skapa;
      @skapa = ();
      for (@process)
      {  my $gammal = $$_[0];
         my $ny     = $$_[1];

         ($del1, $del2) = getKnown(\$form{$fSource}, $gammal);

         $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;      
         if (defined $$del2)
         {  $utrad = "$ny 0 obj\n<<" . $$del1 . $$del2;
         }
         else
         {  $utrad = "$ny 0 obj " . $$del1;
         }
         $objekt[$ny] = $pos;
         $pos += syswrite UTFIL, $utrad;
      }
   }
        
   close INFIL;
   return $nr;   
   
}

##############################################################
#  Interaktiva funktioner knutna till ett formulär återskapas
##############################################################

sub AcroFormsEtc
{  my ($infil, $sidnr) =  @_;
   
   my ($Names, $AARoot, $AAPage, $AcroForm);
   @skapa = ();
   
   my ($res, $corr, $nyDel1, @objData, $del1, $del2, $utrad);
   my $fSource = $infil . '_' . $sidnr;

   $behandlad{$infil}->{old} = {} 
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});   

   *old       = $behandlad{$infil}->{old};
   *oldObject = $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};
        
   my @stati = stat($infil);
   if ($form{$fSource}[fID] != $stati[9])
   {    print "$stati[9] ne $form{$fSource}[fID]\n";
        errLog("Modification time for $fSource has changed, aborting");
   }
    
   open (INFIL, "<$infil") || errLog("The file $infil couldn't be opened, aborting $!");
   binmode INFIL;

   my $fdSidnr = $intAct{$fSource}[iSTARTSIDA];
   $old{$fdSidnr} = $sidObjNr;

   if (($intAct{$fSource}[iNAMES]) ||(scalar @jsfiler) || (scalar @inits) || (scalar %fields))
   {  $Names  = behandlaNames($intAct{$fSource}[iNAMES], $fSource);
   }
   
   ##################################
   # Referenser behandlas och skrivs
   ##################################
         
   if (defined $intAct{$fSource}[iACROFORM])
   {   $AcroForm = $intAct{$fSource}[iACROFORM];
       $AcroForm =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   }
   if (defined $intAct{$fSource}[iAAROOT])
   {  $AARoot = $intAct{$fSource}[iAAROOT];
      $AARoot =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   }
   
   if (defined $intAct{$fSource}[iAAPAGE])
   {   $AAPage = $intAct{$fSource}[iAAPAGE];
       $AAPage =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   }
   if (defined $intAct{$fSource}[iANNOTS])
   {  for (@{$intAct{$fSource}[iANNOTS]})
      {  push @annots, quickxform($_);
      }
   }

   ##################################
   #  Skriv ut underordnade objekt
   ################################## 
   while (scalar @skapa)
   {  my @process = @skapa;
      @skapa = ();
      for (@process)
      {  my $gammal = $$_[0];
         my $ny     = $$_[1];
         
         my $oD   = \@{$intAct{$fSource}[0]->{$gammal}};
         @objData = @{$$oD[oNR]};

         if (defined $$oD[oSTREAMP])
         {  $res = sysseek INFIL, ($objData[0] + $$oD[oPOS]), 0;
            $corr = sysread INFIL, $del1, ($$oD[oSTREAMP] - $$oD[oPOS]) ;
            if (defined  $$oD[oKIDS]) 
            {   $del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
            }
            $res = sysread INFIL, $del2, ($objData[1] - $corr); 
            $utrad = "$ny 0 obj\n<<" . $del1 . $del2;
         }
         else
         {  $del1 = getObject($gammal);
            $del1 = substr($del1, $$oD[oPOS]);
            if (defined  $$oD[oKIDS])
            {   $del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
            }
            $utrad = "$ny 0 obj " . $del1;
         }

         $objekt[$ny] = $pos;
         $pos += syswrite UTFIL, $utrad;
      }
   }
    
   close INFIL;
   return ($Names, $AARoot, $AAPage, $AcroForm);
} 

##############################
# Ett namnobjekt extraheras
##############################

sub extractName
{  my ($infil, $sidnr, $namn) = @_;
   
   my ($res, $del1, $resType, $key, $corr, $formRes, $kids, $nr, $utrad);
   my $del2 = '';
   @skapa = ();
   
   $behandlad{$infil}->{old} = {} 
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});

   *old       = $behandlad{$infil}->{old};
   *oldObject = $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};
   
   my $fSource = $infil . '_' . $sidnr;

   my @stati = stat($infil);

   if ($form{$fSource}[fID] != $stati[9])
   {    errLog("$stati[9] ne $form{$fSource}[fID] aborts");
   }
   if ($checkId) 
   {  if ($checkId ne $stati[9])
      {  my $mess =  "$checkId \<\> $stati[9] \n"
                  . "The Pdf-file $fSource has not the correct modification time. \n"
                  .  "The program is aborted";
         errLog($mess);
      }
      undef $checkId;
    }
    if ($ldir)
    {  $log .= "Cid~$stati[9]\n";
    }

   open (INFIL, "<$infil") || errLog("The file $infil couldn't be opened, aborting $!");
   binmode INFIL;

   #################################
   # Resurserna läses
   #################################

   $formRes = $form{$fSource}->[fRESOURCE];
   
   if ($formRes !~ m'<<.*>>'os)                   # If not a directory, get it
   {   if ($formRes =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R'o)
       {  $key   = $1;
          $formRes = getKnown(\$form{$fSource}, $key);
       }
       else
       {  return undef;
       }
   }
   undef $key;
   while ($formRes =~ m'\/(\w+)\s*\<\<([^>]+)\>\>'osg)
   {   $resType = $1;
       my $str  = $2;
       if ($str =~ m|$namn\s+(\d+)\s{1,2}\d+\s{1,2}R|s)
       {   $key = $1;
           last;
       }
   }
   if (! defined $key)                      # Try to expand the references
   {   my ($str, $del1, $del2);
       while ($formRes =~ m'(\/\w+)\s+(\d+)\s{1,2}\d+\s{1,2}R'ogs)
       { $str .= $1 . ' ';
         ($del1, $del2) = getKnown(\$form{$fSource}, $2);
         my $string =  $$del1;
         $str .= $string . ' ';
       }
       $formRes = $str;
       while ($formRes =~ m'\/(\w+)\s*\<\<([^>]+)\>\>'osg)
       {   $resType = $1;
           my $str  = $2;
           if ($str =~ m|$namn (\d+)\s{1,2}\d+\s{1,2}R|s)
           {   $key = $1;
               last;
           }
       }
       return undef unless $key;
   }
    
   ########################################
   #  Read the top object of the hierarchy
   ########################################

   ($del1, $del2) = getKnown(\$form{$fSource}, $key);

   $objNr++;
   $nr = $objNr;

   if ($resType eq 'Font')
   {  my ($Font, $extNamn);
      if ($$del1 =~ m'/BaseFont\s*/([^\s\/]+)'os)
      {  $extNamn = $1;
         if (! exists $font{$extNamn})
         {  $fontNr++;
            $Font = 'Ft' . $fontNr;
            $font{$extNamn}[foINTNAMN]       = $Font;
            $font{$extNamn}[foORIGINALNR]    = $nr;
            $fontSource{$Font}[foSOURCE]     = $fSource;
            $fontSource{$Font}[foORIGINALNR] = $nr;            
         }
         $font{$extNamn}[foREFOBJ]   = $nr;
         $Font = $font{$extNamn}[foINTNAMN];
         $namn = $Font;
         $objRef{$Font}  = $nr;
      }
      else
      {  errLog("Inconsitency in $fSource, font $namn can't be found, aborting");
      }
   }
   elsif ($resType eq 'ColorSpace')
   {  $colorSpace++;
      $namn = 'Cs' . $colorSpace;
      $objRef{$namn} = $nr;
   }
   elsif ($resType eq 'Pattern')
   {  $pattern++;
      $namn = 'Pt' . $pattern;
      $objRef{$namn} = $nr;
   }
   elsif ($resType eq 'Shading')
   {  $shading++;
      $namn = 'Sh' . $shading;
      $objRef{$namn} = $nr;
   }
   elsif ($resType eq 'ExtGState')
   {  $gSNr++;
      $namn = 'Gs' . $gSNr;
      $objRef{$namn} = $nr;
   }
   elsif ($resType eq 'XObject')
   {  if (defined $form{$fSource}->[0]->{$nr}->[oIMAGENR])
      {  $namn = 'Im' . $form{$fSource}->[0]->{$nr}->[oIMAGENR];
      }
      else
      {  $formNr++;
         $namn = 'Fo' . $formNr;
      }
      
      $objRef{$namn} = $nr;
   }

   $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;

   if (defined $$del2)
   {  $utrad = "$nr 0 obj\n<<" . $$del1 . $$del2;
   }
   else
   {  $utrad = "$nr 0 obj " . $$del1;
   }
   $objekt[$nr] = $pos;
   $pos += syswrite UTFIL, $utrad;

   ##################################
   #  Skriv ut underordnade objekt
   ##################################
 
   while (scalar @skapa)
   {  my @process = @skapa;
      @skapa = ();
      for (@process)
      {  my $gammal = $$_[0];
         my $ny     = $$_[1];
         
         ($del1, $del2, $kids) = getKnown(\$form{$fSource}, $gammal);
         
         $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs
                                     unless (! defined $kids);      
         if (defined $$del2)
         {  $utrad = "$ny 0 obj\n<<" . $$del1 . $$del2;
         }
         else
         {  $utrad = "$ny 0 obj " . $$del1;
         }
         $objekt[$ny] = $pos;
         $pos += syswrite UTFIL, $utrad;
      }
   }
   close INFIL;
   
   return $namn;   
 
}
 
########################
# Ett objekt extraheras
########################

sub extractObject
{  no warnings;
   my ($infil, $sidnr, $key, $typ) = @_;
   
   my ($res, $del1, $corr, $namn, $kids, $nr, $utrad);
   my $del2 = '';
   @skapa = ();

   $behandlad{$infil}->{old} = {} 
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});

   *old       = $behandlad{$infil}->{old};
   *oldObject = $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};
   
   my $fSource = $infil . '_' . $sidnr;
   my @stati = stat($infil);

   if ($form{$fSource}[fID] != $stati[9])
   {    errLog("$stati[9] ne $form{$fSource}[fID] aborts");
   }
   if ($checkId) 
   {  if ($checkId ne $stati[9])
      {  my $mess =  "$checkId \<\> $stati[9] \n"
                  . "The Pdf-file $fSource has not the correct modification time. \n"
                  .  "The program is aborted";
         errLog($mess);
      }
      undef $checkId;
    }
    if ($ldir)
    {  $log .= "Cid~$stati[9]\n";
       my $indata = prep($infil);
       $log .= "Form~$indata~$sidnr~~load~1\n";
    }

   open (INFIL, "<$infil") || errLog("The file $infil couldn't be opened, aborting $!");
   binmode INFIL;

   ########################################
   #  Read the top object of the hierarchy
   ########################################

   ($del1, $del2, $kids) = getKnown(\$form{$fSource}, $key);
        
   if (exists $old{$key})
   {  $nr = $old{$key}; }
   else
   {  $old{$key} = ++$objNr;
      $nr = $objNr;
   }     
 
   if ($typ eq 'Font')
   {  my ($Font, $extNamn);
      if ($$del1 =~ m'/BaseFont\s*/([^\s\/]+)'os)
      {  $extNamn = $1;
         $fontNr++;
         $Font = 'Ft' . $fontNr;
         $font{$extNamn}[foINTNAMN]    = $Font;
         $font{$extNamn}[foORIGINALNR] = $key;
         if ( ! defined $fontSource{$extNamn}[foSOURCE])
         {  $fontSource{$extNamn}[foSOURCE]     = $fSource;
            $fontSource{$extNamn}[foORIGINALNR] = $key;            
         }
         $font{$extNamn}[foREFOBJ]   = $nr;
         $Font = $font{$extNamn}[foINTNAMN];
         $namn = $Font;
         $objRef{$Font}  = $nr;
      }
      else
      {  errLog("Error in $fSource, $key is not a font, aborting");
      }
   }
   elsif ($typ eq 'ColorSpace')
   {  $colorSpace++;
      $namn = 'Cs' . $colorSpace;
      $objRef{$namn} = $nr;
   }
   elsif ($typ eq 'Pattern')
   {  $pattern++;
      $namn = 'Pt' . $pattern;
      $objRef{$namn} = $nr;
   }
   elsif ($typ eq 'Shading')
   {  $shading++;
      $namn = 'Sh' . $shading;
      $objRef{$namn} = $nr;
   }
   elsif ($typ eq 'ExtGState')
   {  $gSNr++;
      $namn = 'Gs' . $gSNr;
      $objRef{$namn} = $nr;
   }
   elsif ($typ eq 'XObject')
   {  if (defined $form{$fSource}->[0]->{$nr}->[oIMAGENR])
      {  $namn = 'Im' . $form{$fSource}->[0]->{$nr}->[oIMAGENR];
      }
      else
      {  $formNr++;
         $namn = 'Fo' . $formNr;
      }
      
      $objRef{$namn} = $nr;
   }

   $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs 
                                  unless (! defined $kids);      
   if (defined $$del2)
   {  $utrad = "$nr 0 obj\n<<" . $$del1 . $$del2;
   }
   else
   {  $utrad = "$nr 0 obj " . $$del1;
   }

   $objekt[$nr] = $pos;
   $pos += syswrite UTFIL, $utrad;

   ##################################
   #  Skriv ut underordnade objekt
   ##################################
 
   while (scalar @skapa)
   {  my @process = @skapa;
      @skapa = ();
      for (@process)
      {  my $gammal = $$_[0];
         my $ny     = $$_[1];
         
         ($del1, $del2, $kids) = getKnown(\$form{$fSource}, $gammal);

         $$del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs
                                 unless (! defined  $kids);
       
         if (defined $$del2)          
         {  $utrad = "$ny 0 obj<<" . $$del1 . $$del2;
         }
         else
         {  $utrad = "$ny 0 obj " . $$del1;
         } 

         $objekt[$ny] = $pos;
         $pos += syswrite UTFIL, $utrad;
      }
   }
   close INFIL;
   return $namn;      
}
 

##########################################
# En fil analyseras och sidorna kopieras
##########################################

sub analysera
{  my $infil = shift;
   my $from  = shift || 1;
   my $to    = shift || 0;
   my ($i, $res, @underObjekt, @sidObj, $vektor, $resources, $valid,
       $strPos, $sidor, $filId, $Root, $del1, $del2, $utrad);

   my $extraherade = 0;
   my $sidAcc = 0;
   @skapa     = ();
  
   $behandlad{$infil}->{old} = {}
        unless (defined $behandlad{$infil}->{old});
   $processed{$infil}->{oldObject} = {} 
        unless (defined $processed{$infil}->{oldObject});   
   $processed{$infil}->{unZipped} = {} 
        unless (defined $processed{$infil}->{unZipped});
   *old       = $behandlad{$infil}->{old};
   *oldObject = $processed{$infil}->{oldObject};
   *unZipped  = $processed{$infil}->{unZipped};

   $root      = (exists $processed{$infil}->{root}) 
                    ? $processed{$infil}->{root} : 0;
             
   my ($AcroForm, $Annots, $Names, $AARoot);
   undef $taInterAkt;
   undef %script;
   
   my $checkIdOld = $checkId;
   ($infil, $checkId) = findGet($infil, $checkIdOld);
   if (($ldir) && ($checkId) && ($checkId ne $checkIdOld))
   {  $log .= "Cid~$checkId\n";
   }
   undef $checkId;
   my @stati = stat($infil);
   open (INFIL, "<$infil") || errLog("Couldn't open $infil,aborting.  $!");
   binmode INFIL;
  
   if (! $root)
   {  $root      = xRefs($stati[7], $infil);
   }   
   #############
   # Hitta root
   #############           

   my $offSet;
   my $bytes;
   my $objektet = getObject($root);
   
   if ((! $interActive) && ( ! $to) && ($from == 1))
   {  if ($objektet =~ m'/AcroForm(\s+\d+\s{1,2}\d+\s{1,2}R)'so)
      {  $AcroForm = $1;
      }      
      if ($objektet =~ m'/Names\s+(\d+)\s{1,2}\d+\s{1,2}R'so)
      {  $Names = $1;
      }
      if ((scalar %fields) || (scalar @jsfiler) || (scalar @inits))
      {   $Names  = behandlaNames($Names);
      }
      elsif ($Names)
      {  $Names = quickxform($Names);
      }

      #################################################
      #  Finns ett dictionary för Additional Actions ?
      #################################################
      if ($objektet =~ m'/AA(\s+\d+\s{1,2}\d+\s{1,2}R)'os)   # Hänvisning
      {  $AARoot = $1; }
      elsif ($objektet =~ m'/AA\s*\<\<\s*[^\>]+[^\>]+'so) # AA är ett dictionary
      {  my $k;
         my ($dummy, $obj) = split /\/AA/, $objektet;
         $obj =~ s/\<\</\#\<\</gs;
         $obj =~ s/\>\>/\>\>\#/gs;
         my @ord = split /\#/, $obj;
         for ($i = 0; $i <= $#ord; $i++)
         {   $AARoot .= $ord[$i];
             if ($ord[$i] =~ m'\S+'os)
             {  if ($ord[$i] =~ m'<<'os)
                {  $k++; }
                if ($ord[$i] =~ m'>>'os)
                {  $k--; }
                if ($k == 0)
                {  last; }
             } 
          }
       }
       $taInterAkt = 1;   # Flagga att ta med interaktiva funktioner
   } 
   
   #
   # Hitta pages
   #
 
   if ($objektet =~ m'/Pages\s+(\d+)\s{1,2}\d+\s{1,2}R'os)
   {  $objektet = getObject($1);
      ($resources, $valid) = kolla($objektet);
      if ($objektet =~ m'/Count\s+(\d+)'os)
      {  $sidor = $1; }   
   }
   else
   { errLog("Didn't find pages "); }

   my @levels;
   my $li = -1;

   if ($objektet =~ m'/Kids\s*\[([^\]]+)'os)
   {  $vektor = $1;  
      while ($vektor =~ m'(\d+)\s{1,2}\d+\s{1,2}R'go)
      {   push @sidObj, $1;       
      }
      $li++;
      $levels[$li] = \@sidObj;
   }

   while (($li > -1) && ($sidAcc < $sidor))
   {  if (scalar @{$levels[$li]})
      {   my $j = shift @{$levels[$li]};
          $objektet = getObject($j);
          ($resources, $valid) = kolla($objektet, $resources); 
          if ($objektet =~ m'/Kids\s*\[([^\]]+)'os)
          {  $vektor = $1; 
             my @sObj; 
             while ($vektor =~ m'(\d+)\s{1,2}\d+\s{1,2}R'go)
             {   push @sObj, $1;       
             }
             $li++;
             $levels[$li] = \@sObj;
          }
          else
          {  $sidAcc++;
             if ($sidAcc >= $from)
             {   if ($to)
                 {  if ($sidAcc <= $to)
                    {  sidAnalys($j, $objektet, $resources);
                       $extraherade++;
                       $sida++;
                    }
                    else
                    {  $sidAcc = $sidor;
                    }
                 }
                 else
                 {  sidAnalys($j, $objektet, $resources);
                    $extraherade++;
                    $sida++;
                 }
              }
          }
      }
      else
      {  $li--;
      }
   }
   
   if (defined $AcroForm)
   {  $AcroForm =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   }
   if (defined $AARoot)
   {  $AARoot =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   }
   
   while (scalar @skapa)
   {  my @process = @skapa;
      @skapa = ();
      for (@process)
      {  my $gammal = $$_[0];
         my $ny     = $$_[1];
         $objektet  = getObject($gammal);         

         if ($objektet =~ m'^(\d+ \d+ obj\s*<<)(.+)(>>\s*stream)'os)
         {  $del1 = $2;
            $strPos = length($2) + length($3) + length($1);
            $del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
            $objekt[$ny] = $pos;
            $utrad = "$ny 0 obj<<" . "$del1" . '>>stream';
            $del2   = substr($objektet, $strPos);
            $utrad .= $del2; 

            $pos += syswrite UTFIL, $utrad;
         }
         else
         {  if ($objektet =~ m'^(\d+ \d+ obj)'os)
            {  my $preLength = length($1);
               $objektet = substr($objektet, $preLength);
            }
            $objektet =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
            $objekt[$ny] = $pos;
            $utrad = "$ny 0 obj$objektet";
            $pos += syswrite UTFIL, $utrad;
         }
      }
  }
  close INFIL;
  $processed{$infil}->{root}         = $root;

  return ($extraherade, $Names, $AARoot, $AcroForm);
}

sub sidAnalys
{  my ($oNr, $obj, $resources) = @_;
   my ($ny, $strPos, $spar, $closeProc, $del1, $del2, $utrad, $Annots);

   if (! $parents[0])
   { $objNr++;
     $parents[0] = $objNr;
   }
   my $parent = $parents[0];
   $objNr++;
   $ny = $objNr; 

   $old{$oNr} = $ny;
     
   if ($obj =~ m'/Parent\s+(\d+)\s{1,2}\d+\s{1,2}R\b'os)
   {  $old{$1} = $parent;
   }
   
   if ($obj =~ m'^(\d+ \d+ obj\s*<<)(.+)(>>\s*stream)'os)
   {  $del1   = $2;
      $strPos = length($2) + length($3) + length($1);
      $del2   = substr($obj, $strPos);
   }
   elsif ($obj =~ m'^\d+ \d+ obj\s*<<(.+)>>\s*endobj'os)
   {  $del1 = $1;
   }
   if (%links)
   {   my $tSida = $sida + 1;
       if (defined (@{$links{'-1'}}) || (defined @{$links{$tSida}}))
       {   if ($del1 =~ m'/Annots\s*([^\/\<\>]+)'os)
           {  $Annots  = $1;
              @annots = (); 
              if ($Annots =~ m'\[([^\[\]]*)\]'os)
              {  ; }
              else
              {  if ($Annots =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'os)
                 {  $Annots = getObject($1);
                 }
              }
              while ($Annots =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'ogs)
              {   push @annots, xform();
              }
              $del1 =~ s?/Annots\s*([^\/\<\>]+)??os;
           }
           $Annots = '/Annots ' . mergeLinks() . ' 0 R';
       }
   }

   if (! $taInterAkt)
   {  $del1 =~ s?\s*/AA\s*<<[^>]*>>??os;
   }
   if ($del1 !~ m'/Resources'o)
   {  $del1 .= "/Resources $resources";
   }
       
   $del1 =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   if ($Annots)
   {  $del1 .= $Annots;
   }

   $utrad = "$ny 0 obj<<$del1>>";
   if (defined $del2)
   {   $utrad .= "stream\n$del2";
   }
   else
   {  $utrad .= "endobj\n";
   }

   $objekt[$ny] = $pos;
   $pos += syswrite UTFIL, $utrad;
     
   push @{$kids[0]}, $ny;
   $counts[0]++;
   if ($counts[0] > 9)
   {  ordnaNoder(8); 
   }
}  


sub translate
{ if (exists $old{$1})
  { $old{$1}; }
  else
  {  $old{$1} = ++$objNr;
  }     
}  

sub behandlaNames
{  my ($namnObj, $iForm) = @_;
   
   my ($low, $high, $antNod0, $entry, $nyttNr, $ny, $obj,
       $fObjnr, $offSet, $bytes, $res, $key, $func, $corr, @objData);
   my (@nod0, @nodUpp, @kid, @soek, %nytt);
   
   my $objektet  = '';
   my $vektor    = '';   
   my $antal     = 0;
   my $antNodUpp = 0;
   if ($namnObj)
   {  if ($iForm)                                # Läsning via interntabell
      {   $objektet = getObject($namnObj, 1);

          if ($objektet =~ m'<<(.+)>>'ogs)
          { $objektet = $1; }
          if ($objektet =~ s'/JavaScript\s+(\d+)\s{1,2}\d+\s{1,2}R''os)
          {  my $byt = $1; 
             push @kid, $1;
             while (scalar @kid)
             {  @soek = @kid;
                @kid = ();
                for my $sObj (@soek)
                {  $obj = getObject($sObj, 1);
                   if ($obj =~ m'/Kids\s*\[([^]]+)'ogs)
                   {  $vektor = $1;
                   }
                   while ($vektor =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'ogs)
                   {  push @kid, $1;
                   }
                   $vektor = '';
                   if ($obj =~ m'/Names\s*\[([^]]+)'ogs)
                   {   $vektor = $1;
                   }
                   while ($vektor =~ m'\(([^\)]+)\)\s*(\d+) \d R'gos)
                   {   $script{$1} = $2;                
                   }
                }
             }
          }
      }
      else                                #  Läsning av ett "doc"
      {  $objektet = getObject($namnObj);             
         if ($objektet =~ m'<<(.+)>>'ogs)
         {  $objektet = $1; }
         if ($objektet =~ s'/JavaScript\s+(\d+)\s{1,2}\d+\s{1,2}R''os)
         {  my $byt = $1; 
            push @kid, $1;
            while (scalar @kid)
            {  @soek = @kid;
               @kid = ();
               for my $sObj (@soek)
               {  $obj = getObject($sObj);  
                  if ($obj =~ m'/Kids\s*\[([^]]+)'ogs)
                  {  $vektor = $1;
                  }
                  while ($vektor =~ m'\b(\d+)\s{1,2}\d+\s{1,2}R\b'ogs)
                  {  push @kid, $1;
                  }
                  undef $vektor;
                  if ($obj =~ m'/Names\s*\[([^]]+)'ogs)
                  {  $vektor = $1;
                  }
                  while ($vektor =~ m'\(([^\)]+)\)\s*(\d+) \d R'gos)
                  {   $script{$1} = $2;                
                  }
               }        
             }
          }
      } 
   }
   for my $filnamn (@jsfiler)
   {   inkludera($filnamn);
   }
   my @nya = (keys %nyaFunk);
   while (scalar @nya)
   {   my @behandla = @nya;
       @nya = ();
       for $key (@behandla)
       {   if (exists $initScript{$key})
           {  if (exists $nyaFunk{$key})
              {   $initScript{$key} = $nyaFunk{$key};
              }
              if (exists $script{$key})   # företräde för nya funktioner !
              {   delete $script{$key};    # gammalt script m samma namn plockas bort
              } 
              my @fall = ($initScript{$key} =~ m'([\w\d\_\$]+)\s*\('ogs);
              for (@fall)
              {   if (($_ ne $key) && (exists $nyaFunk{$_}))
                  {  $initScript{$_} = $nyaFunk{$_}; 
                     push @nya, $_; 
                  }
              }
           }
       }
   }
   while  (($key, $func) = each %nyaFunk)
   {  $fObjnr = skrivJS($func);
      $script{$key} = $fObjnr;
      $nytt{$key}   = $fObjnr;
   }
     
   if (scalar %fields)
   {  push @inits, 'Ladda();';
      $fObjnr = defLadda();
      if ($duplicateInits)
      {  $script{'Ladda'} = $fObjnr;
         $nytt{'Ladda'} = $fObjnr;
      }
   }

   if ((scalar @inits) && ($duplicateInits))
   {  $fObjnr = defInit();
      $script{'Init'} = $fObjnr;
      $nytt{'Init'} = $fObjnr;
   }
   undef @jsfiler;
 
   for my $key (sort (keys %script))
   {  if (! defined $low)
      {  $objNr++;
         $ny = $objNr;     
         $objekt[$ny] = $pos;
         $obj = "$ny 0 obj\n";
         $low  = $key;
         $obj .= '<< /Names [';
      }
      $high = $key;
      $obj .= '(' . "$key" . ')';
      if (! exists $nytt{$key})
      {  $nyttNr = quickxform($script{$key});
      }
      else
      {  $nyttNr = $script{$key};
      }
      $obj .= "$nyttNr 0 R\n";      
      $antal++;
      if ($antal > 9)
      {   $obj .= ' ]/Limits [(' . "$low" . ')(' . "$high" . ')] >>' . "endobj\n";
          $pos += syswrite UTFIL, $obj;
          push @nod0, \[$ny, $low, $high];
          $antNod0++; 
          undef $low;
          $antal = 0; 
      }
   }
   if ($antal)
   {   $obj .= ']/Limits [(' . $low . ')(' . $high . ')]>>' . "endobj\n";
       $pos += syswrite UTFIL, $obj;
       push @nod0, \[$ny, $low, $high];
       $antNod0++;
   }
   $antal = 0;

   while (scalar @nod0)
   {   for $entry (@nod0)
       {   if ($antal == 0)
           {   $objNr++;     
               $objekt[$objNr] = $pos;
               $obj = "$objNr 0 obj\n";
               $low  = $$entry->[1];
               $obj .= '<</Kids [';
           }
           $high = $$entry->[2];
           $obj .= " $$entry->[0] 0 R";
           $antal++;
           if ($antal > 9)
           {   $obj .= ']/Limits [(' . $low . ')(' . $high . ')]>>' . "endobj\n";
               $pos += syswrite UTFIL, $obj;
               push @nodUpp, \[$objNr, $low, $high];
               $antNodUpp++; 
               undef $low;
               $antal = 0; 
           } 
       }
       if ($antal > 0)
       {   if ($antNodUpp == 0)     # inget i noderna över
           {   $obj .= ']>>' . "endobj\n";
               $pos += syswrite UTFIL, $obj;
           }
           else
           {   $obj .= ']/Limits [(' . "$low" . ')(' . "$high" . ')]>>' . "endobj\n";
               $pos += syswrite UTFIL, $obj;
               push @nodUpp, \[$objNr, $low, $high];
               $antNodUpp++; 
               undef $low;
               $antal = 0; 
           }
       }
       @nod0    = @nodUpp;
       $antNod0 = $antNodUpp;
       undef @nodUpp;
       $antNodUpp = 0;
   }
      
  
   $ny = $objNr;
   $objektet =~ s|\s*/JavaScript\s*\d+\s{1,2}\d+\s{1,2}R||os;
   $objektet =~ s/\b(\d+)\s{1,2}\d+\s{1,2}R\b/xform() . ' 0 R'/oegs;
   if (scalar %script)
   {  $objektet .= "\n/JavaScript $ny 0 R\n";
   }
   $objNr++;
   $ny = $objNr;
   $objekt[$ny] = $pos;
   $objektet = "$ny 0 obj<<" . $objektet . ">>endobj\n";
   $pos += syswrite UTFIL, $objektet;
   return $ny;
}


sub quickxform
{  my $inNr = shift;
   if (exists $old{$inNr})
   {  $old{$inNr}; }
   else
   {  push @skapa, [$inNr, ++$objNr];
      $old{$inNr} = $objNr;                   
   } 
} 


sub skrivKedja
{  my $code = ' ';
   
   for (values %initScript)
   {   $code .= $_ . "\n";
   }
   $code .= "function Init()\r{\r";
   $code .= 'if (typeof this.info.ModDate == "object")' . "\r{ return true; }\r"; 
   for (@inits)
   {  $code .= $_ . "\n";
   }
   $code .= "}\r Init(); ";

   my $spar = skrivJS($code);
   undef @inits;
   undef %initScript;
   return $spar;
}



sub skrivJS
{  my $kod = shift;
   my $obj;
   if (($compress) && (length($kod) > 99))
   {  $objNr++;
      $objekt[$objNr] = $pos;
      my $spar = $objNr;
      $kod = compress($kod);
      my $langd = length($kod);
      $obj = "$objNr 0 obj<</Filter/FlateDecode"
                           .  "/Length $langd>>stream\n" . $kod 
                           .  "\nendstream\nendobj\n";
      $pos += syswrite UTFIL, $obj;
      $objNr++;
      $objekt[$objNr] = $pos;
      $obj = "$objNr 0 obj<</S/JavaScript/JS $spar 0 R >>endobj\n";
   }
   else
   {  $kod =~ s'\('\\('gso;
      $kod =~ s'\)'\\)'gso;
      $objNr++;
      $objekt[$objNr] = $pos;
      $obj = "$objNr 0 obj<</S/JavaScript/JS " . '(' . $kod . ')';
      $obj .= ">>endobj\n";
   }
   $pos += syswrite UTFIL, $obj;           
   return $objNr;
}

sub inkludera
{   my $jsfil = shift;
    my $fil;
    if ($jsfil !~ m'\{'os)
    {   open (JSFIL, "<$jsfil") || return;
        while (<JSFIL>)
        { $fil .= $_;}

        close JSFIL;
    }
    else
    {  $fil = $jsfil;
    }
    $fil =~ s|function\s+([\w\_\d\$]+)\s*\(|"zXyZcUt function $1 ("|sge;
    my @funcs = split/zXyZcUt /, $fil;
    for my $kod (@funcs)
    {   if ($kod =~ m'^function ([\w\_\d\$]+)'os)
        {   $nyaFunk{$1} = $kod;
        }
    }   
}


sub defLadda
{  my $code = "function Ladda()\r{\r";
   for (keys %fields)
   {  my $val = $fields{$_};
      if ($val =~ m'\s*js\s*\:(.+)'oi) 
      {   $val = $1;
          $code .= "if (this.getField('$_')) this.getField('$_').value = $val;\r";
      }
      else
      {  $val =~ s/([^A-Za-z0-9\-_.!* ])/sprintf("%%%02X", ord($1))/ge;
         $code .= "if (this.getField('$_')) this.getField('$_').value = unescape('$val');\r";
      }

   }  
   $code .= " 1;}\r";
   
   
   $initScript{'Ladda'} = $code;
   if ($duplicateInits) 
   {  my $ny = skrivJS($code);        
      return $ny;
   }
   else
   {  return 1;
   }
}

sub defInit
{  my $code = "function Init()\r{\r";
   $code .= 'if (typeof this.info.ModDate == "object")' . "\r{ return true; }\r"; 
   for (@inits)
   {  $code .= $_ . "\n";
   }
   $code .= '}';
             
   my $ny = skrivJS($code);        
   return $ny;

}



sub errLog
{   no strict 'refs';
    my $mess = shift;
    my $endMess  = " $mess \n More information might be found in"; 
    if ($runfil)
    {   $log .= "Log~Err: $mess\n";
        $endMess .= "\n   $runfil";
        if (! $pos)
        {  $log .= "Log~Err: No pdf-file has been initiated\n";
        }
        elsif ($pos > 15000000)
        {  $log .= "Log~Err: Current pdf-file is very big: $pos bytes, will not try to finnish it\n"; 
        }
        else
        {  $log .= "Log~Err: Will try to finnish current pdf-file\n";
           $endMess .= "\n   $utfil";
        }
    }
    my $errLog = 'error.log';
    my $now = localtime();
    my $lpos = $pos || 'undef';
    my $lobjNr = $objNr || 'undef';
    my $lutfil = $utfil || 'undef';
    
    my $lrunfil = $runfil || 'undef'; 
    open (ERRLOG, ">$errLog") || croak "$mess can't open an error logg, $!";
    print ERRLOG "\n$mess\n\n";
    print ERRLOG Carp::longmess("The error occurred when executing:\n");
    print ERRLOG "\nSituation when the error occurred\n\n";
    print ERRLOG "   Bytes written to the current pdf-file,    pos    = $lpos\n";
    print ERRLOG "   Object processed, not necessarily written objNr  = $lobjNr\n";
    print ERRLOG "   Current pdf-file,                         utfil  = $lutfil\n";
    print ERRLOG "   File logging the run,                     runfil = $lrunfil\n";
    print ERRLOG "   Local time                                       = $now\n"; 
    print ERRLOG "\n\n";    
    close ERRLOG;
    $endMess .= "\n   $errLog";
    if (($pos) && ($pos < 15000000))
    {  prEnd();
    }
    print STDERR Carp::shortmess("An error occurred \n");
    croak "$endMess\n";      
}
