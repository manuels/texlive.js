%%%%
%%%% MF2PT1.MP, by Scott Pakin, scott+mf@pakin.org
%%%%
%%%% This file is used to dump a special version of MetaPost with:
%%%%     mpost -progname=mpost -ini mf2pt1 \\dump
%%%%
%%%% To pretty-print this file, you'll need LaTeX and the mftinc package
%%%% (available from CTAN).
%%%%

%%%% ==================================================================== %%%%
%%%% mf2pt1                                                               %%%%
%%%% Copyright (C) 2012 Scott Pakin                                       %%%%
%%%%                                                                      %%%%
%%%% This program may be distributed and/or modified under the conditions %%%%
%%%% of the LaTeX Project Public License, either version 1.3c of this     %%%%
%%%% license or (at your option) any later version.                       %%%%
%%%%                                                                      %%%%
%%%% The latest version of this license is in:                            %%%%
%%%%                                                                      %%%%
%%%%    http://www.latex-project.org/lppl.txt                             %%%%
%%%%                                                                      %%%%
%%%% and version 1.3c or later is part of all distributions of LaTeX      %%%%
%%%% version 2006/05/20 or later.                                         %%%%
%%%% ==================================================================== %%%%

input mfplain;

%%% addto makepath makepen
%%% length clockwise counterclockwise
%%% scaled dashed withcolor

%% \begin{explaincode}
%%   Enable a \MF\ file to determine if it's being built with
%%   \texttt{mf2pt1}.
%% \end{explaincode}

newinternal ps_output;
ps_output := 1;


%% \begin{explaincode}
%%   The following was taken right out of \texttt{mfplain.mp}.  The \mfcomment
%    |def| and the |special|s at the end
%%   are the sole additions.  Normally, MetaPost outputs a tight bounding
%%   box around the character in its PostScript output.  The purpose of the
%%   first \mfcomment
%    |special|
%%   is to pass \texttt{mf2pt1} a bounding box that includes the proper
%%   surrounding whitespace.  The purpose of the second special is to
%%   provide \texttt{mf2pt1} with a default PostScript font name.
%% \end{explaincode}

def beginchar(expr c,w_sharp,h_sharp,d_sharp) =
  begingroup
    charcode:=if known c: byte c else: 0 fi;
    charwd:=w_sharp;      charht:=h_sharp;       chardp:=d_sharp;
    w:=charwd*pt; h:=charht*pt; d:=chardp*pt;
    charic:=0; clearxy; clearit; clearpen; scantokens extra_beginchar;

    def to_bp (expr num) = decimal (ceiling (num*bp_per_pixel)) enddef;
    special "% MF2PT1: glyph_dimensions 0 " & to_bp (-d) & " " & to_bp(w) & " " & to_bp(h);
    special "% MF2PT1: font_size " & decimal designsize;
    special "% MF2PT1: font_slant " & decimal font_slant_;
    special "% MF2PT1: charwd " & decimal charwd;   % Must come after the |font_size| |special|
    for fvar = "font_identifier", "font_coding_scheme", "font_version",
      "font_comment", "font_family", "font_weight", "font_unique_id",
      "font_name":
      if known scantokens (fvar & "_"):
        special "% MF2PT1: " & fvar & " " & scantokens (fvar & "_");
      fi;
    endfor;
    for fvar = "font_underline_position", "font_underline_thickness":
      if known scantokens (fvar & "_"):
        special "% MF2PT1: " & fvar & " " &
          scantokens ("decimal " & fvar & "_");
      fi;
    endfor;
    special "% MF2PT1: font_fixed_pitch " &
            (if font_fixed_pitch_: "1" else: "0" fi);
enddef;


%% \begin{explaincode}
%%   Enable a character to specify explicitly the PostScript glyph
%%   name associated with it.
%% \end{explaincode}
def glyph_name expr name =
  special "% MF2PT1: glyph_name " & name;
enddef;


%% \begin{explaincode}
%%   Store the value of \mfcomment
%    |font_slant_|, so we can recall it at each |beginchar|.
%% \end{explaincode}

font_slant_ := 0;

def font_slant expr x =
  font_slant_ := x;
  fontdimen 1: x
enddef;


%% \begin{explaincode}
%%   Redefine \mfcomment
%    |bpppix_|, the number of ``big'' points per pixel. \mfcomment
%    This in turn redefines |mm|, |in|, |pt|, and other derived units.
%% \end{explaincode}

def bpppix expr x =
  bpppix_ := x;
  mm := 2.83464 / bpppix_;
  pt := 0.99626 / bpppix_;
  dd := 1.06601 / bpppix_;
  bp := 1 / bpppix_;
  cm := 28.34645 / bpppix_;
  pc := 11.95517 / bpppix_;
  cc := 12.79213 / bpppix_;
  in := 72 / bpppix_;
  hppp := pt;
  vppp := pt;
enddef;


%% \begin{explaincode}
%%   Define a bunch of PostScript font parameters to be used by
%%   \texttt{mf2pt1.pl}.  Default values are specified in
%%   \texttt{mf2pt1.pl}, not here.
%% \end{explaincode}

forsuffixes fvar = font_version, font_comment, font_family, font_weight,
                   font_name, font_unique_id:
  scantokens ("string " & str fvar & "_;");
  scantokens ("def " & str fvar & " expr x = " & str fvar & "_ := x enddef;");
endfor;

forsuffixes fvar = font_underline_position, font_underline_thickness:
  scantokens ("numeric " & str fvar & "_;");
  scantokens ("def " & str fvar & " expr x = " & str fvar & "_ := x enddef;");
endfor;

boolean font_fixed_pitch_;
font_fixed_pitch_ := false;
def font_fixed_pitch expr x = font_fixed_pitch_ := x enddef;


%% \begin{explaincode}
%%   We'd like to be able to use calligraphic pens.  Normally, MetaPost's
%%   output routine does all the work for us of converting these to filled
%%   PostScript paths.  The only exception occurs for paths drawn using a
%%   pen that was transformed from  \mfcomment
%    |pencircle|.  MetaPost outputs these paths as stroked PostScript
%%   paths.  The following code tricks MetaPost into using a filled path
%%   for  \mfcomment
%    |pencircle| by replacing the primitive |pencircle| pen with a
%%   non-primitive approximation.  Note that we use a 20-gon for our circle
%%   instead of a diamond, so we get better results from  \mfcomment
%    |draw|.
%% \end{explaincode}

pen fakepencircle, mfplain_pencircle;
mfplain_pencircle := pencircle;
fakepencircle := makepen (for deg=0 step 360/20 until 359:
    (0.5 cosd deg, 0.5 sind deg)--
  endfor cycle);
save pencircle;
pen pencircle;
pencircle := fakepencircle;


%% \begin{explaincode}
%%   Return  \mfcomment
%    |true| if a path is cyclic, |false| otherwise.
%% \end{explaincode}

def is_cyclic expr cpath =
  (point 0 of cpath = point (length cpath) of cpath)
enddef;


%% \begin{explaincode}
%%   Determine the direction of a path which doesn't intersect
%%   itself. \mfcomment
%    Returns |true| if the curve is clockwise, |false| if
%%   counterclockwise.  For non-cyclic paths the result is not
%%   predictable.
%%   \bigskip
%%
%%   The \mfcomment
%    |crossproduct|, |makeline|, and |is_clockwise| functions were
%%   provided by Werner Lemberg.
%%   \bigskip
%%
%%   The algorithm used is quite simple:
%%
%%   \begin{itemize}
%%     \item Find a point~$P$ on the path which has a non-zero direction,
%%     and which is on a not-too-short path element.
%%
%%     \item Construct a ray of ``infinite'' length, starting in the
%%     vicinity of~$P$ which intersects the path at this point.
%%
%%     \item Use \mfcomment
%      |intersectiontimes| to find the intersection.  If the direction of
%%     the path at this point is (near) zero, or if we have a grazing
%%     intersection or even a tangent, get a new ray.
%%
%%     \item Shorten the ray so that it starts right after the
%%     intersection.  Repeat the previous step until no intersection is
%%     found.  Then go back to the last intersection and compare the path's
%%     direction with the direction of the ray.  According to the
%%     \emph{nonzero winding number} rule we have found a clockwise
%%     oriented path if it crosses the ray from left to right.
%%   \end{itemize}
%%
%%   This method completely avoids any problems with the geometry of
%%   B\'{e}zier curves.  If problems arise, a different ray is tried.
%%   Since it isn't necessary to analyze the whole path it runs quite fast
%%   in spite of using \mfcomment
%    |intersectiontimes| which is a slow MetaPost command.
%% \end{explaincode}

vardef crossproduct (expr u, v) =
  save u_, v_;
  pair u_, v_;

  u_ := unitvector u;
  v_ := unitvector v;

  abs (xpart u_ * ypart v_ - ypart u_ * xpart v_)
enddef;

vardef makeline primary p =
  save start, bad_n, loop, distance, d, i, n;
  pair start, d;

  loop := 0;
  bad_n := -1;
  for i := 0 step 1 until length p - 1:
    distance := length (point i of p - point (i + 1) of p);
    if distance <> 0:
      if distance < 1:
        % In case we don't find something better.
        bad_n := i;
      else:
        n := i;
        loop := 1;
      fi;
    fi;
    exitif loop = 1;
  endfor;

  if loop = 0:
    if bad_n <> -1:
      n := bad_n;
      loop = 1;
    fi;
  fi;

  % Add some randomness to get different lines for each function call.
  n := n + uniformdeviate 0.8 + 0.1;
  start := point n of p;

  if loop = 0:
    % Construct a line which misses the degenerated path.
    start + (1, 0)
    -- start + (1, 1)
  else:
    d := direction n of p;

    % Again, some added randomness.
    n := uniformdeviate 150 + 15;
    d := unitvector (d rotated n);

    % Construct a line which intersects the path at least once.
    start - eps * d
    -- infinity * d
  fi
enddef;

vardef is_clockwise primary p =
  save line, cut, cut_new, res, line_dir, tangent_dir;
  path line;
  pair cut, cut_new, line_dir, tangent_dir;

  line := makeline p;
  line_dir := direction 0 of line;

  % Find the outermost intersection.
  cut := (0, 0);
  forever:
    cut_new := line intersectiontimes p;
    exitif cut_new = (-1, -1);

    % Compute a new line if we have a strange intersection.
    tangent_dir := direction (ypart cut_new) of p;
    if abs tangent_dir < eps:
      % The vector is zero or too small.
      line := makeline p;
      line_dir := direction 0 of line;

    elseif abs (ypart cut_new - floor (ypart cut_new + 0.5)) < eps:
      % Avoid possible tangent touching in a corner or cusp.
      line := makeline p;
      line_dir := direction 0 of line;

    elseif crossproduct (tangent_dir, line_dir) < 0.2:
      % Grazing intersection (arcsin 0.2 ~= 11.5 degrees).
      line := makeline p;
      line_dir := direction 0 of line;

    else:
      % Go ahead.
      cut := cut_new;
      line := subpath (xpart cut + eps, infinity) of line;
    fi;
  endfor;

  tangent_dir := direction (ypart cut) of p;
  if tangent_dir <> (0, 0):
    res := (angle tangent_dir - angle line_dir + 180) mod 360 - 180;
    res < 0
  else:
    false
  fi
enddef;


%% \begin{explaincode}
%%   Make a given path run clockwise or counterclockwise.  \mfcomment
%    (|counterclockwise| is defined by \texttt{mfplain} but we override
%%   it here.)
%% \end{explaincode}

vardef counterclockwise primary c =
  (if is_clockwise c: (reverse c) else: c fi)
enddef;

vardef clockwise primary c =
  (if is_clockwise c: c else: (reverse c) fi)
enddef;


%% \begin{explaincode}
%%   Redefine  \mfcomment
%    |fill| and |unfill| to ensure that filled paths run
%%   counterclockwise and unfilled paths run clockwise, as is required
%%   by PostScript Type~1 fonts.
%% \end{explaincode}

def fill expr c =
  addto currentpicture contour counterclockwise c t_ pc_
enddef;

def unfill expr c =
  addto currentpicture contour clockwise c t_ pc_ withcolor background
enddef;


%% \begin{explaincode}
%%   Convert  \mfcomment
%    |filldraw| and |unfilldraw| to |fill| and |unfill|.
%% \end{explaincode}

let mfplain_filldraw := filldraw;
def filldraw expr c =
  begingroup
    message "! Warning: Replacing filldraw with fill.";
    fill c
  endgroup
enddef;

let mfplain_unfilldraw := unfilldraw;
def unfilldraw expr c =
  begingroup
    message "! Warning: Replacing unfilldraw with unfill.";
    unfill c
  endgroup
enddef;


%% \begin{explaincode}
%%   Return  \mfcomment
%    |true| if |currentpen| looks like a |pencircle|.
%% \end{explaincode}

def using_pencircle =
  begingroup
    path qpath, circlepath;
    qpath = makepath currentpen;
    numeric circlediv;
    circlepath = makepath pencircle;
    circlediv = xpart (lrcorner circlepath);

    (length qpath = length circlepath) and (pen_rt <> 0) and (pen_top <> 0)
    for pp = 0 upto (length qpath)-1:
      and ((xpart (point pp of qpath) / pen_rt,
            ypart (point pp of qpath) / pen_top) =
           point pp of circlepath / circlediv)
    endfor
  endgroup
enddef;


%% \begin{explaincode}
%%   If the pen looks like a circular pen, draw a nice circle.  Otherwise,
%%   draw the pen as is.
%% \end{explaincode}

def drawdot expr z =
  if using_pencircle:
    begingroup
      path cpath;
      numeric clength;
      cpath = makepath currentpen;
      clength = length cpath;
      fill ((point 0 of cpath)
        ..(point clength/4 of cpath)
        ..(point clength/2 of cpath)
        ..(point 3*clength/4 of cpath)
        ..cycle) shifted z t_
    endgroup
  else:
    addto currentpicture contour makepath currentpen shifted z
    t_ pc_
  fi
enddef;


%% \begin{explaincode}
%%   Do the same as the above, but unfill the current pen.
%% \end{explaincode}

def undrawdot expr z =
  if using_pencircle:
    begingroup
      path cpath;
      numeric clength;
      cpath = makepath currentpen;
      clength = length cpath;
      unfill ((point 0 of cpath)
        ..(point clength/4 of cpath)
        ..(point clength/2 of cpath)
        ..(point 3*clength/4 of cpath)
        ..cycle) shifted z t_
    endgroup
  else:
    unfill makepath currentpen shifted z t_
  fi
enddef;


%% \begin{explaincode}
%%   MetaPost renders \mfcomment
%    |draw| with a filled curve.
%%   Hence, we need to ensure the orientation is correct (i.e.,
%%   counterclockwise).  Unfortunately, we have no way to check for
%%   overlap, and it's fairly common for MetaPost to output
%%   self-overlapping curve outlines, even if the curve itself has no
%%   overlap.
%% \end{explaincode}

def draw expr p =
  addto currentpicture
  if picture p:
    also p
  elseif is_cyclic p:
    doublepath counterclockwise p t_ withpen currentpen
  else:
    if is_clockwise (p--cycle):
      doublepath (reverse p) t_ withpen currentpen
    else:
      doublepath p t_ withpen currentpen
    fi
  fi
  pc_
enddef;

def undraw expr p =
  addto currentpicture
  if picture p:
    also p
  elseif is_cyclic p:
    doublepath clockwise p t_ withpen currentpen
  else:
    if is_clockwise (p--cycle):
      doublepath p t_ withpen currentpen
    else:
      doublepath (reverse p) t_ withpen currentpen
    fi
  fi
  pc_ withcolor background
enddef;
