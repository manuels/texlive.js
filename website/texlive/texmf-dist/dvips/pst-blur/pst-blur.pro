%%
%% This is file `pst-blur.pro',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% pst-blur.dtx  (with options: `prolog')
%% 
%% IMPORTANT NOTICE:
%% 
%% For the copyright see the source file.
%% 
%% Any modified versions of this file must be renamed
%% with new filenames distinct from pst-blur.pro.
%% 
%% For distribution of the original source see the terms
%% for copying and modification in the file pst-blur.dtx.
%% 
%% This generated file may be distributed as long as the
%% original source files, as listed above, are part of the
%% same distribution. (The sources need not necessarily be
%% in the same archive or directory.)
%% $Id: pst-blur.dtx,v 2.0 2005/09/08 09:48:33 giese Exp $
%%
%% Copyright 1998-2007 Martin Giese, mgiese@risc.uni-linz.ac.at
%%                     Herbert Voss, voss@pstricks.de
%%
%% This file is under the LaTeX Project Public License
%% See CTAN archives in directory macros/latex/base/lppl.txt.
%%
%% DESCRIPTION:
%%   `pst-blur' is a PSTricks package for blurred shadows
%%
/tx@PstBlurDict 60 dict def
tx@PstBlurDict begin
/Iterate {
  /SegLines ED
  /ThisB ED /ThisG ED /ThisR ED
  /NextB ED /NextG ED /NextR ED
  /W 2.0 BlurRadius mul def
  /WDec W SegLines div def
  /RInc NextR ThisR sub SegLines div def
  /GInc NextG ThisG sub SegLines div def
  /BInc NextB ThisB sub SegLines div def
  /R ThisR def
  /G ThisG def
  /B ThisB def
  SegLines {
    R G B
    sqrt 3 1 roll sqrt 3 1 roll sqrt 3 1 roll
    setrgbcolor
    gsave W setlinewidth
    stroke grestore
    /W W WDec sub def
    /R R RInc add def
    /G G GInc add def
    /B B BInc add def
  } bind repeat
} def
/BlurShadow {
  Shadow
  /BlurSteps ED
  /BlurRadius ED
  dup mul /BEnd ED dup mul /GEnd ED dup mul /REnd ED
  dup mul /BBeg ED dup mul /GBeg ED dup mul /RBeg ED
  RBeg REnd add 0.5 mul /RMid ED
  GBeg GEnd add 0.5 mul /GMid ED
  BBeg BEnd add 0.5 mul /BMid ED
  /OuterSteps BlurSteps 2 div cvi def
  /InnerSteps BlurSteps OuterSteps sub def
  1 setlinejoin
  RMid GMid BMid REnd GEnd BEnd OuterSteps Iterate
  gsave RBeg sqrt GBeg sqrt BBeg sqrt setrgbcolor fill grestore
  clip
  0 setlinejoin
  RMid GMid BMid RBeg GBeg BBeg InnerSteps Iterate
} def
end
