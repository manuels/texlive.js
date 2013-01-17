%%
%% This is file `pst-slpe.pro',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pst-slpe.dtx  (with options: `prolog')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from pst-slpe.pro.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file pst-slpe.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% This program can be redistributed and/or modified under the terms
%% of the LaTeX Project Public License Distributed from CTAN archives
%% in directory macros/latex/base/lppl.txt.
%%
/tx@PstSlopeDict 60 dict def tx@PstSlopeDict begin
/Opacity 1 def % preset, no transparency
/Opacity++ { Opacity dOpacity add /Opacity ED } def
/max {2 copy lt {exch} if pop} bind def
/Iterate {
  1 sub /NumSegs ED
  dup mul 3 1 roll dup mul 3 1 roll dup mul 3 1 roll
  setrgbcolor currenthsbcolor
  /ThisB ED
  /ThisS ED
  /ThisH ED
  /ThisPt ED
  Opacity .setopacityalpha
  gsave
  fill
  grestore
  NumSegs {
    dup mul 3 1 roll dup mul 3 1 roll dup mul 3 1 roll
    setrgbcolor currenthsbcolor
    /NextB ED
    /NextS ED
    /NextH ED
    /NextPt ED
    ThisPt NextPt sub ThisPt div NumSteps mul cvi /SegSteps exch def
    /NumSteps NumSteps SegSteps sub def
    SegSteps 0 eq not {
      ThisS 0 eq {/ThisH NextH def} if
      NextS 0 eq {/NextH ThisH def} if
      ThisH NextH sub 0.5 gt
        {/NextH NextH 1.0 add def}
        { NextH ThisH sub 0.5 ge {/ThisH ThisH 1.0 add def} if }
      ifelse
      /B ThisB def
      /S ThisS def
      /H ThisH def
      /BInc NextB ThisB sub SegSteps div def
      /SInc NextS ThisS sub SegSteps div def
      /HInc NextH ThisH sub SegSteps div def
      SegSteps {
        H dup 1. gt {1. sub} if S B sethsbcolor
        currentrgbcolor
        sqrt 3 1 roll sqrt 3 1 roll sqrt 3 1 roll
        setrgbcolor
        DrawStep
        /H H HInc add def
        /S S SInc add def
        /B B BInc add def
      } bind repeat
      /ThisH NextH def
      /ThisS NextS def
      /ThisB NextB def
      /ThisPt NextPt def
    } if
  } bind repeat
} def
/PatchRadius {
  Radius 0 eq {
    /UpdRR { dup mul exch dup mul add RR max /RR ED } bind def
    gsave
    flattenpath
    /RR 0 def
    {UpdRR} {UpdRR} {} {} pathforall
    grestore
    /Radius RR sqrt def
  } if
} def
/SlopesFill {
  /Fading ED % do we have fading?
  Fading {
    /FadingEnd ED % the last opacity value
    dup /FadingStart ED % the first opacity value
    /Opacity ED % the opacity start value
  } if
  gsave
  180 add rotate
  /NumSteps ED
  Fading { /dOpacity FadingEnd FadingStart sub NumSteps div def } if
  clip
  pathbbox
  /h ED /w ED
  2 copy translate
  h sub neg /h ED
  w sub neg /w ED
  /XInc w NumSteps div def
  /DrawStep {
    Fading { % do we have a fading?
      Opacity .setopacityalpha  % set opacity value
      Opacity++ % increase opacity
    } if
    0 0 XInc h rectfill
    XInc 0 translate
  } bind def
  Iterate
  grestore
} def
/CcSlopesFill {
  /Fading ED % do we have fading?
  Fading {
    /FadingEnd ED % the last opacity value
    dup /FadingStart ED % the first opacity value
    /Opacity ED % the opacity start value
  } if
  gsave
  /Radius ED
  /CenterY ED
  /CenterX ED
  /NumSteps ED
  Fading { /dOpacity FadingEnd FadingStart sub NumSteps div def } if
  clip
  pathbbox
  /h ED /w ED
  2 copy translate
  h sub neg /h ED
  w sub neg /w ED
  w CenterX mul h CenterY mul translate
  PatchRadius
  /RadPerStep Radius NumSteps div neg def
  /Rad Radius def
  /DrawStep {
    Fading { % do we have a fading?
      Opacity .setopacityalpha  % set opacity value
      Opacity++ % increase opacity
    } if
    0 0 Rad 0 360 arc
    closepath fill
    /Rad Rad RadPerStep add def
  } bind def
  Iterate
  grestore
} def
/RadSlopesFill {
  /Fading ED % do we have fading?
  Fading {
    /FadingEnd ED % the last opacity value
    dup /FadingStart ED % the first opacity value
    /Opacity ED % the opacity start value
  } if
  gsave
  rotate
  /Radius ED
  /CenterY ED
  /CenterX ED
  /NumSteps ED
  Fading { /dOpacity FadingEnd FadingStart sub NumSteps div def } if
  clip
  pathbbox
  /h ED /w ED
  2 copy translate
  h sub neg /h ED
  w sub neg /w ED
  w CenterX mul h CenterY mul translate
  PatchRadius
  /AngleIncrement 360 NumSteps div neg def
  /dY AngleIncrement sin AngleIncrement cos div Radius mul def
  /DrawStep {
    Fading { % do we have a fading?
      Opacity .setopacityalpha  % set opacity value
      Opacity++ % increase opacity
    } if
    0 0 moveto
    Radius 0 rlineto
    0 dY rlineto
    closepath fill
    AngleIncrement rotate
  } bind def
  Iterate
  grestore
} def
end
