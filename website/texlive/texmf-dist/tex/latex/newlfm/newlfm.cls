%%
%% This is file `newlfm.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% newlfm.dtx  (with options: `package')
%% 
%% \iffalse meta-comment
%% \CharacterTable
%% {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%  Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%  Digits        \0\1\2\3\4\5\6\7\8\9
%%  Exclamation   \!     Double quote  \"     Hash (number) \#
%%  Dollar        \$     Percent       \%     Ampersand     \&
%%  Acute accent  \'     Left paren    \(     Right paren   \)
%%  Asterisk      \*     Plus          \+     Comma         \,
%%  Minus         \-     Point         \.     Solidus       \/
%%  Colon         \:     Semicolon     \;     Less than     \<
%%  Equals        \=     Greater than  \>     Question mark \?
%%  Commercial at \@     Left bracket  \[     Backslash     \\
%%  Right bracket \]     Circumflex    \^     Underscore    \_
%%  Grave accent  \`     Left brace    \{     Vertical bar  \|
%%  Right brace   \}     Tilde         \~}
\NeedsTeXFormat{LaTeX2e}[1996/06/01]
\ProvidesClass{newlfm}
              [2009/04/10 v9.4
               Letter-Fax-Memo LaTeX Document Class]

\def\ifta{0}\def\iftb{0}%
\def\txa#1{\ifthenelse{\equal{\ifta}{1}}{\typeout{#1}}{}}%
\def\txb#1{}%\ifthenelse{\iftb=1}{\typeout{#1}}{}}%
\RequirePackage{keyval}%
\RequirePackage{ifthen}[1997/11/02]%
\RequirePackage{ifpdf}%
\RequirePackage{setdim}%
\RequirePackage{fancyhdr}%
\RequirePackage{eso-pic}%
\RequirePackage{setspace}%
\RequirePackage{lastpage}%
\@ifundefined{ps@@empty}{%
  \ClassError{newlfm}{Version of fancyhdr.sty is not current. \MessageBreak Please obtain%
    a recent copy of fancyhdr.sty (Version 1.99d or later) from CTAN.}  {Go to CTAN and%
    download the current version of fancyhdr.sty}}{}%
\RequirePackage{calc}[1997/11/11]%
\RequirePackage{graphicx}[1997/06/09]%
\RequirePackage{rotating}[1997/06/09]%
\newlength{\@addr@fr@sk@b}\setlength{\@addr@fr@sk@b}{0in}%
\newlength{\@addr@fr@sk@a}\setlength{\@addr@fr@sk@a}{0in}%
\newlength{\@addr@to@sk@b}\setlength{\@addr@to@sk@b}{0in}%
\newlength{\@addr@to@sk@a}\setlength{\@addr@to@sk@a}{0in}%
\newlength{\@blka@b}\setlength{\@blka@b}{0in}%
\newlength{\@blka@a}\setlength{\@blka@a}{0in}%
\newlength{\@blkb@b}\setlength{\@blkb@b}{0in}%
\newlength{\@blkb@a}\setlength{\@blkb@a}{0in}%
\newlength{\@blkc@b}\setlength{\@blkc@b}{0in}%
\newlength{\@blkc@a}\setlength{\@blkc@a}{0in}%
\newlength{\@caption@skip@above}\setlength{\@caption@skip@above}{0in}%
\newlength{\@caption@skip@below}\setlength{\@caption@skip@below}{0in}%
\newlength{\@cello@h}\setlength{\@cello@h}{1in}%
\newlength{\@cello@w}\setlength{\@cello@w}{3in}%
\newlength{\@cello@d}\setlength{\@cello@d}{2.5in}%
\newlength{\@cello@l}\setlength{\@cello@l}{1in}%
\newlength{\@dt@sk@b}\setlength{\@dt@sk@b}{0in}%
\newlength{\@dt@sk@a}\setlength{\@dt@sk@a}{0in}%
\newlength{\@Dth@H@L}\setlength{\@Dth@H@L}{0in}%
\newlength{\@Dth@H@C}\setlength{\@Dth@H@C}{0in}%
\newlength{\@Dth@H@R}\setlength{\@Dth@H@R}{0in}%
\newlength{\@Dth@F@L}\setlength{\@Dth@F@L}{0in}%
\newlength{\@Dth@F@C}\setlength{\@Dth@F@C}{0in}%
\newlength{\@Dth@F@R}\setlength{\@Dth@F@R}{0in}%
\newlength{\@Dth@h@l}\setlength{\@Dth@h@l}{0in}%
\newlength{\@Dth@h@c}\setlength{\@Dth@h@c}{0in}%
\newlength{\@Dth@h@r}\setlength{\@Dth@h@r}{0in}%
\newlength{\@Dth@f@l}\setlength{\@Dth@f@l}{0in}%
\newlength{\@Dth@f@c}\setlength{\@Dth@f@c}{0in}%
\newlength{\@Dth@f@r}\setlength{\@Dth@f@r}{0in}%
\newlength{\@greet@to@sk@b}\setlength{\@greet@to@sk@b}{0in}%
\newlength{\@greet@to@sk@a}\setlength{\@greet@to@sk@a}{0in}%
\newlength{\@Hgt@Head}\setlength{\@Hgt@Head}{0in}%
\newlength{\@Hrw}\setlength{\@Hrw}{1pt}%
\newlength{\@hrw}\setlength{\@hrw}{1pt}%
\newlength{\@extr@hor}\setlength{\@extr@hor}{0pt}%
\newlength{\@Frw}\setlength{\@Frw}{1pt}%
\newlength{\@frw}\setlength{\@frw}{1pt}%
\newlength{\@Hgt@Foot}\setlength{\@Hgt@Foot}{0in}%
\newlength{\@Hgt@head}\setlength{\@Hgt@head}{0in}%
\newlength{\@Hgt@foot}\setlength{\@Hgt@foot}{0in}%
\newlength{\@Hgt@H@L}\setlength{\@Hgt@H@L}{0in}%
\newlength{\@Hgt@H@C}\setlength{\@Hgt@H@C}{0in}%
\newlength{\@Hgt@H@R}\setlength{\@Hgt@H@R}{0in}%
\newlength{\@Hgt@F@L}\setlength{\@Hgt@F@L}{0in}%
\newlength{\@Hgt@F@C}\setlength{\@Hgt@F@C}{0in}%
\newlength{\@Hgt@F@R}\setlength{\@Hgt@F@R}{0in}%
\newlength{\@Hgt@h@l}\setlength{\@Hgt@h@l}{0in}%
\newlength{\@Hgt@h@c}\setlength{\@Hgt@h@c}{0in}%
\newlength{\@Hgt@h@r}\setlength{\@Hgt@h@r}{0in}%
\newlength{\@Hgt@f@l}\setlength{\@Hgt@f@l}{0in}%
\newlength{\@Hgt@f@c}\setlength{\@Hgt@f@c}{0in}%
\newlength{\@Hgt@f@r}\setlength{\@Hgt@f@r}{0in}%
\newlength{\@lab@bl}\setlength{\@lab@bl}{0in}%
\newlength{\@lab@pl}\setlength{\@lab@pl}{0in}%
\newlength{\@lab@pw}\setlength{\@lab@pw}{0in}%
\newlength{\@lab@bh}\setlength{\@lab@bh}{0in}%
\newlength{\@lab@bw}\setlength{\@lab@bw}{0in}%
\newlength{\@lab@th}\setlength{\@lab@th}{0in}%
\newlength{\@lab@lm}\setlength{\@lab@lm}{0in}%
\newlength{\@marg@lt}\setlength{\@marg@lt}{1in}%
\newlength{\@marg@rt}\setlength{\@marg@rt}{1in}%
\newlength{\@marg@tp}\setlength{\@marg@tp}{1in}%
\newlength{\@marg@bt}\setlength{\@marg@bt}{1in}%
\newlength{\@marg@tp@a}\setlength{\@marg@tp@a}{0in}%
\newlength{\@marg@bt@a}\setlength{\@marg@bt@a}{0in}%
\newlength{\@marg@bt@b}\setlength{\@marg@bt@b}{0in}%
\newlength{\@marg@tp@b}\setlength{\@marg@tp@b}{0in}%
\newlength{\@marg@tp@s}\setlength{\@marg@tp@s}{0in}%
\newlength{\@marg@lt@r}\setlength{\@marg@lt@r}{0in}%
\newlength{\@marg@lt@l}\setlength{\@marg@lt@l}{0in}%
\newlength{\@marg@rt@r}\setlength{\@marg@rt@r}{0in}%
\newlength{\@marg@rt@l}\setlength{\@marg@rt@l}{0in}%
\newlength{\@marg@lt@tp@d}\setlength{\@marg@lt@tp@d}{0pt}%
\newlength{\@marg@rt@tp@d}\setlength{\@marg@rt@tp@d}{0pt}%
\newlength{\@Min@Hgt@Head}\setlength{\@Min@Hgt@Head}{0in}%
\newlength{\@Min@Hgt@head}\setlength{\@Min@Hgt@head}{0in}%
\newlength{\@Min@Hgt@Foot}\setlength{\@Min@Hgt@Foot}{0in}%
\newlength{\@Min@Hgt@foot}\setlength{\@Min@Hgt@foot}{0in}%
\newlength{\@Min@Hgt@Right}\setlength{\@Min@Hgt@Right}{0in}%
\newlength{\@Min@Hgt@right}\setlength{\@Min@Hgt@right}{0in}%
\newlength{\@Min@Hgt@Left}\setlength{\@Min@Hgt@Left}{0in}%
\newlength{\@Min@Hgt@left}\setlength{\@Min@Hgt@left}{0in}%
\newlength{\@Plg}\setlength{\@Plg}{0in}%
\newlength{\@Pwd}\setlength{\@Pwd}{0in}%
\newlength{\@plg}\setlength{\@plg}{0in}%
\newlength{\@pwd}\setlength{\@pwd}{0in}%
\newlength{\@post@sig@sp@a}\setlength{\@post@sig@sp@a}{0in}%
\newlength{\@post@sig@sp@b}\setlength{\@post@sig@sp@b}{0in}%
\newlength{\@pre@memo@sp}\setlength{\@pre@memo@sp}{0in}%
\newlength{\@post@memo@sp}\setlength{\@post@memo@sp}{0in}%
\newlength{\@sig@sp}\setlength{\@sig@sp}{0in}%
\newlength{\@text@width}\setlength{\@text@width}{0in}%
\newlength{\@sig@sk@a}\setlength{\@sig@sk@a}{5pt}%
\newlength{\@sig@sk@b}\setlength{\@sig@sk@b}{5pt}%
\newlength{\@sig@sk@c}\setlength{\@sig@sk@c}{5pt}%
\newlength{\@sig@sk@r}\setlength{\@sig@sk@r}{5pt}%
\newlength{\@cls@sk@a}\setlength{\@cls@sk@a}{1em}%
\newlength{\@cls@sk@b}\setlength{\@cls@sk@b}{1em}%
\newlength{\@text@height}\setlength{\@text@height}{0in}%
\newlength{\@unpr@tp}\setlength{\@unpr@tp}{0in}%
\newlength{\@unpr@bm}\setlength{\@unpr@bm}{0in}%
\newlength{\@unpr@rt}\setlength{\@unpr@rt}{0in}%
\newlength{\@unpr@lt}\setlength{\@unpr@lt}{0in}%
\newlength{\@util}\setlength{\@util}{0in}%
\newlength{\@utila}\setlength{\@utila}{0in}%
\newlength{\@utilb}\setlength{\@utilb}{0in}%
\newlength{\@utilc}\setlength{\@utilc}{0in}%
\newlength{\@utild}\setlength{\@utild}{0in}%
\newlength{\@utile}\setlength{\@utile}{0in}%
\newlength{\@utilf}\setlength{\@utilf}{0in}%
\newlength{\@utilg}\setlength{\@utilg}{0in}%
\newlength{\@utilh}\setlength{\@utilh}{0in}%
\newlength{\@utili}\setlength{\@utili}{0in}%
\newlength{\@utilj}\setlength{\@utilj}{0in}%
\newlength{\@utilk}\setlength{\@utilk}{0in}%
\newlength{\@utill}\setlength{\@utill}{0in}%
\newlength{\@xda}\setlength{\@xda}{0in}%
\newlength{\@xdb}\setlength{\@xdb}{0in}%
\newlength{\@xdc}\setlength{\@xdc}{0in}%
\newlength{\@xdd}\setlength{\@xdd}{0in}%
\newlength{\@xde}\setlength{\@xde}{0in}%
\newlength{\@xdf}\setlength{\@xdf}{0in}%
\newlength{\@xdg}\setlength{\@xdg}{0in}%
\newlength{\@xdh}\setlength{\@xdh}{0in}%
\newlength{\@xdi}\setlength{\@xdi}{0in}%
\txa{newlength done}%
\newsavebox{\@sig@box@a}\newsavebox{\b@addr@fr}\newsavebox{\b@addr@to}%
\newsavebox{\@x@c}\newsavebox{\@x@l}\newsavebox{\@x@r}%
\newsavebox{\fba}\newsavebox{\adrfr}\newsavebox{\adrto}%
\newsavebox{\@sig@box@b}\newsavebox{\@sig@box@c}\newsavebox{\@sig@box@d}%
\newsavebox{\@sig@box@e}\newsavebox{\@sig@box@f}\newsavebox{\@sig@box@g}%
\newsavebox{\@sig@box@h}\newsavebox{\@sig@box@i}\newsavebox{\@sig@box@j}%
\newsavebox{\@rest@ltr}\newsavebox{\@resta@ltr}\newsavebox{\@restb@ltr}%
\newsavebox{\@restc@ltr}\newsavebox{\@restd@ltr}\newsavebox{\@reste@ltr}%
\txa{newsavebox done}%
\newcounter{@c@pos}\newcounter{figure}\newcounter{table}%
\newcounter{@sig@tot}\newcounter{@lab@tot@row}%
\newcounter{@lab@tot@col}\newcounter{@lab@cnt@row}\newcounter{@lab@cnt@col}%
\newcount\@nlfm@addr%
\newcount\@nlfm@util%
\newcount\@nlfm@uta%
\newcount\@nlfm@utb%
\txa{newcount done}%
\newboolean{@addr@fr@l}%
\newboolean{@addr@fr@p}%
\newboolean{@addr@fr@e}\setboolean{@addr@fr@e}{false}%
\newboolean{@addr@fr@f}\setboolean{@addr@fr@f}{false}%
\newboolean{@addr@fr@t}\setboolean{@addr@fr@t}{false}%
\newboolean{@addr@swtch}\setboolean{@addr@swtch}{true}%
\newboolean{@addr@to@l}%
\newboolean{@addr@to@p}%
\newboolean{@addr@to@f}\setboolean{@addr@to@f}{false}%
\newboolean{@addr@to@e}\setboolean{@addr@to@e}{false}%
\newboolean{@addr@to@t}\setboolean{@addr@to@t}{false}%
\newboolean{@b@h}\setboolean{@b@h}{false}%
\newboolean{@b@f}\setboolean{@b@f}{false}%
\newboolean{@b@r}\setboolean{@b@r}{false}%
\newboolean{@b@l}\setboolean{@b@l}{false}%
\newboolean{@B@h}\setboolean{@B@h}{false}%
\newboolean{@B@f}\setboolean{@B@f}{false}%
\newboolean{@B@r}\setboolean{@B@r}{false}%
\newboolean{@B@l}\setboolean{@B@l}{false}%
\newboolean{@bg@use}\setboolean{@bg@use}{false}%
\newboolean{@Bg@use}\setboolean{@Bg@use}{false}%
\newboolean{@cello@win}\setboolean{@cello@win}{false}%
\newboolean{@cf@use}\setboolean{@cf@use}{false}%
\newboolean{@Ch@use}\setboolean{@Ch@use}{false}%
\newboolean{@Cf@use}\setboolean{@Cf@use}{false}%
\newboolean{@COf@use}\setboolean{@COf@use}{false}%
\newboolean{@CUh@use}\setboolean{@CUh@use}{false}%
\newboolean{@ch@use}\setboolean{@ch@use}{false}%
\newboolean{@do@any}%
\newboolean{@dt@l}\setboolean{@dt@l}{true}%
\newboolean{@dt@c}\setboolean{@dt@c}{false}%
\newboolean{@dt@p}%
\newboolean{@env@open}\setboolean{@env@open}{false}%
\newboolean{@env@close}\setboolean{@env@close}{false}%
\newboolean{@fax@m@run}\setboolean{@fax@m@run}{false}%
\newboolean{@fax@hdr@pg}%
\newboolean{@fax@RA}%
\newboolean{@fax@RU}%
\newboolean{@fax@bla}\setboolean{@fax@bla}{true}%
\newboolean{@fax@blb}\setboolean{@fax@blb}{false}%
\newboolean{@fl}\setboolean{@fl}{true}%
\newboolean{@Fl}\setboolean{@Fl}{true}%
\newboolean{@greet@p}%
\newboolean{@greet@l}%
\newboolean{@hl}\setboolean{@hl}{true}%
\newboolean{@Hl}\setboolean{@Hl}{true}%
\newboolean{@in@tab}%
\newboolean{@in@makeenv}\setboolean{@in@makeenv}{false}%
\newboolean{@l@am}\setboolean{@l@am}{true}%
\newboolean{@l@en}\setboolean{@l@en}{false}%
\newboolean{@l@ge}\setboolean{@l@ge}{false}%
\newboolean{@l@fr}\setboolean{@l@fr}{false}%
\newboolean{@l@ot}\setboolean{@l@ot}{false}%
\newboolean{@l@pi}\setboolean{@l@pi}{false}%
\newboolean{@lab@t}\setboolean{@lab@t}{true}%
\newboolean{@lab@cft}\setboolean{@lab@cft}{false}%
\newboolean{@lab@rft}\setboolean{@lab@rft}{false}%
\newboolean{@Lf@use}\setboolean{@Lf@use}{false}%
\newboolean{@lf@use}\setboolean{@lf@use}{false}%
\newboolean{@Lh@use}\setboolean{@Lh@use}{false}%
\newboolean{@lh@use}\setboolean{@lh@use}{false}%
\newboolean{@LOf@use}\setboolean{@LOf@use}{false}%
\newboolean{@LUh@use}\setboolean{@LUh@use}{false}%
\newboolean{@marg@lt@fl@tp}\setboolean{@marg@lt@fl@tp}{false}%
\newboolean{@marg@rt@fl@tp}\setboolean{@marg@rt@fl@tp}{false}%
\newboolean{@marg@luse}\setboolean{@marg@luse}{false}%
\newboolean{@marg@ruse}\setboolean{@marg@ruse}{false}%
\newboolean{@marg@Luse}\setboolean{@marg@Luse}{false}%
\newboolean{@marg@Ruse}\setboolean{@marg@Ruse}{false}%
\newboolean{@memo@bl}%
\newboolean{@memo@a}%
\newboolean{@memo@b}\setboolean{@memo@b}{false}%
\newboolean{@memo@c}\setboolean{@memo@c}{false}%
\newboolean{@memo@d}\setboolean{@memo@d}{false}%
\newboolean{@memo@e}\setboolean{@memo@e}{true}%
\newboolean{@memo@f}\setboolean{@memo@f}{true}%
\newboolean{@memo@g}\setboolean{@memo@g}{true}%
\newboolean{@memo@h}\setboolean{@memo@h}{false}%
\newboolean{@memo@i}\setboolean{@memo@i}{false}%
\newboolean{@memo@j}\setboolean{@memo@j}{false}%
\newboolean{@memo@k}\setboolean{@memo@k}{false}%
\newboolean{@memo@l}\setboolean{@memo@l}{false}%
\newboolean{@memo@m}\setboolean{@memo@m}{false}%
\newboolean{@memo@n}\setboolean{@memo@n}{false}%
\newboolean{@no@cen}\setboolean{@no@cen}{false}%
\newboolean{@no@spc}\setboolean{@no@spc}{false}%
\newboolean{@rest@l}\setboolean{@rest@l}{false}%
\newboolean{@resta@l}\setboolean{@resta@l}{false}%
\newboolean{@restb@l}\setboolean{@restb@l}{false}%
\newboolean{@restc@l}\setboolean{@restc@l}{false}%
\newboolean{@restd@l}\setboolean{@restd@l}{false}%
\newboolean{@reste@l}\setboolean{@reste@l}{false}%
\newboolean{@ROf@use}\setboolean{@ROf@use}{false}%
\newboolean{@Rf@use}\setboolean{@Rf@use}{false}%
\newboolean{@rf@use}\setboolean{@rf@use}{false}%
\newboolean{@Rh@use}\setboolean{@Rh@use}{false}%
\newboolean{@RUh@use}\setboolean{@RUh@use}{false}%
\newboolean{@rh@use}\setboolean{@rh@use}{false}%
\newboolean{@ov@a}\setboolean{@ov@a}{true}%
\newboolean{@ov@t}\setboolean{@ov@t}{false}%
\newboolean{@ov@l}\setboolean{@ov@l}{false}%
\newboolean{@ov@f}\setboolean{@ov@f}{false}%
\newboolean{@ov@s}\setboolean{@ov@s}{false}%
\newboolean{@pt@regard}\setboolean{@pt@regard}{false}%
\newboolean{@s@b@s}\setboolean{@s@b@s}{false}%
\newboolean{@set@env}\setboolean{@set@env}{false}%
\newboolean{@sig@p}%
\newboolean{@sig@mp}%
\newboolean{@sig@l}\setboolean{@sig@l}{false}%
\newboolean{@sig@c}\setboolean{@sig@c}{false}%
\newboolean{@space@d}\setboolean{@space@d}{true}%
\newboolean{@space@s}\setboolean{@space@s}{false}%
\newboolean{@mult@sig}\setboolean{@mult@sig}{false}%
\newboolean{@use@sig}%
\newboolean{@use@close}%
\newboolean{@use@sig@nm}%
\newboolean{@use@all@fr}%
\newboolean{@use@all@to}%
\newboolean{@use@envlab}\setboolean{@use@envlab}{false}%
\newboolean{@use@water}\setboolean{@use@water}{false}%
\newboolean{@ztila}\newboolean{@ztilb}%
\newboolean{@pr@p}\setboolean{@pr@p}{false}%
\newboolean{@pr@by}%
\txa{newboolean done}%
\def\@d@pos#1{\def\@intd@pos{#1}}%
\def\@t@pos#1{\def\@intt@pos{#1}}%
\def\@f@pos#1{\def\@intf@pos{#1}}%
\def\newlfmParam{\@ifnextchar[%]%
\newlx@i{\newlx@i[]}}%
\def\newlx@i[#1]{{\setkeys{ov}{#1}}}%
\def\Dimens{\@ifnextchar[%]%
\Dimens@i{\Dimens@i[]}}%
\def\Dimens@i[#1]{{\setkeys{ov}{#1}}}%
\def\Language{\@ifnextchar[%]%
\Lang@i{\Lang@i[]}}%
\def\Lang@i[#1]{{\setkeys{ov}{#1}}}%
\def\MemoParam{\@ifnextchar[%]%
\MemoP@i{\MemoP@i[]}}%
\def\MemoP@i[#1]{{\setkeys{ov}{#1}}}%
\def\LetterParam{\@ifnextchar[%]%
\LetrP@i{\LetrP@i[]}}%
\def\LetrP@i[#1]{{\setkeys{ov}{#1}}}%
\def\FAZParam{\@ifnextchar[%]%
\FAXP@i{\FAXP@i[]}}%
\def\FAXP@i[#1]{{\setkeys{ov}{#1}}}%
\def\LetterP#1{\setkeys{ov}{#1}}%
\def\newlfmP#1{\setkeys{ov}{#1}}%
\def\LanguageP#1{\setkeys{ov}{#1}}%
\def\FAXP#1{\setkeys{ov}{#1}}%
\def\DimensP#1{\setkeys{ov}{#1}}%
\def\MemoP#1{\setkeys{ov}{#1}}%
\def\iffixt#1#2{\ifthenelse{\equal{#1}{true}}{\setboolean{#2}{true}}{}}%
\def\iffixf#1#2{\ifthenelse{\equal{#1}{true}}{\setboolean{#2}{false}}{}}%
\def\iffixq#1#2{\ifthenelse{\equal{#1}{true}}{#2}{}}%
\txa{Done with key definitions sections}%
\def\DatePhrase#1{\def\@date@phr{#1}}%
\def\PhrFAXcovp#1{\def\@fax@cover@line{#1}}%
\def\PhrFAXpgcnt#1{\def\@fax@page@count{#1}}%
\def\PhrEmail#1{\def\@email@phr{#1}}%
\def\PhrFax#1{\def\@fax@phr{#1}}%
\def\PhrPager#1{\def\@pager@phr{#1}}%
\def\PhrDocument#1{\def\@doc@phr{#1}}%
\def\PhrPhone#1{\def\@phn@phr{#1}}%
\def\PhrRe#1{\def\@re@phr{#1}}%
\def\PhrSubre#1{\def\@subre@phr{#1}}%
\def\PhrCc#1{\def\@cc@phr{#1}}%
\def\PhrPs#1{\def\@ps@phr{#1}}%
\def\PhrMessage#1{\def\@m@phr{#1}}%
\def\PhrPps#1{\def\@pps@phr{#1}}%
\def\PhrPpps#1{\def\@ppps@phr{#1}}%
\def\PhrEncl#1{\def\@encl@phr{#1}}%
\def\PhrTo#1{\def\@hnto@phr{#1}}%
\def\PhrFrom#1{\def\@hnfr@phr{#1}}%
\def\PhrRegard#1{\def\@regard@phr{#1}}%
\def\PhrContact#1{\def\@contact@phr{#1}}%
\def\PhrRelease#1{\def\@release@phr{#1}}%
\def\PhrMore#1{\def\@more@phr{#1}}%
\def\PhrPRend#1{\def\@PRend@phr{#1}}%
\def\lth{}\def\sig{}\def\adr{}%
\def\letrh#1{\def\@ltr@h{#1}\setboolean{@ov@l}{true}}%
\define@key{ov}{letrh}{\def\@ltr@h{#1}\setboolean{@ov@l}{true}}%
\txa{Done with phr defs}%
\def\waterpage#1{\def\@water@page{#1}\setboolean{@use@water}{true}}%
\define@key{ov}{waterpage}{\def\@water@page{#1}\setboolean{@use@water}{true}}%
\txa{Waterpage}%
\def\Background#1{\def\@Backgrnd{#1}\setboolean{@Bg@use}{true}}%
\txa{Z}%
\define@key{ov}{Background}{\def\@Backgrnd{#1}\setboolean{@Bg@use}{true}}%
\def\background#1{\setboolean{@bg@use}{true}\def\@backgrnd{#1}}%
\define@key{ov}{background}{\setboolean{@bg@use}{true}\def\@backgrnd{#1}}%
\def\@adr@t{}\def\@adr@f{}\def\@ltr@h{}\def\@sig@b{}%
\def\addrt#1{\def\@adr@t{#1}\setboolean{@ov@t}{true}}%
\define@key{ov}{addrt}{\def\@adr@t{#1}\setboolean{@ov@t}{true}}%
\def\addrf#1{\def\@adr@f{#1}\setboolean{@ov@f}{true}}%
\define@key{ov}{addrf}{\def\@adr@f{#1}\setboolean{@ov@f}{true}}%
\def\sigtr#1{\def\@sig@b{#1}\setboolean{@ov@s}{true}}%%
\define@key{ov}{sigtr}{\def\@sig@b{#1}\setboolean{@ov@s}{true}}%
\def\MinHead#1{\setlength{\@Min@Hgt@Head}{#1}}%
\define@key{ov}{MinHead}{\setlength{\@Min@Hgt@Head}{#1}}%
\def\minhead#1{\setlength{\@Min@Hgt@head}{#1}}%
\define@key{ov}{minhead}{\setlength{\@Min@Hgt@head}{#1}}%
\def\MinLeft#1{\setlength{\@Min@Hgt@Left}{#1}}%
\define@key{ov}{MinLeft}{\setlength{\@Min@Hgt@Left}{#1}}%
\def\minleft#1{\setlength{\@Min@Hgt@left}{#1}}%
\define@key{ov}{minleft}{\setlength{\@Min@Hgt@left}{#1}}%
\def\MinFoot#1{\setlength{\@Min@Hgt@Foot}{#1}}%
\define@key{ov}{MinFoot}{\setlength{\@Min@Hgt@Foot}{#1}}%
\def\minfoot#1{\setlength{\@Min@Hgt@foot}{#1}}%
\define@key{ov}{minfoot}{\setlength{\@Min@Hgt@foot}{#1}}%
\def\MinRight#1{\setlength{\@Min@Hgt@Right}{#1}}%
\define@key{ov}{MinRight}{\setlength{\@Min@Hgt@Right}{#1}}%
\def\minright#1{\setlength{\@Min@Hgt@right}{#1}}%
\define@key{ov}{minright}{\setlength{\@Min@Hgt@right}{#1}}%
\def\@def@l{american}%
\def\@am@phr{%
\DatePhrase{Date}%
\PhrFAXcovp{FAX Cover Page}%
\PhrFAXpgcnt{FAX Page Count}%
\PhrFax{FAX}%
\PhrPager{Pager}%
\PhrEmail{E-mail}%
\PhrDocument{Document}%
\PhrPhone{Telephone}%
\PhrRe{Re}%
\PhrSubre{\ensuremath{\mathrm{Re}_2}}%
\PhrCc{cc}%
\PhrPs{Ps}%
\PhrMessage{Message}%
\PhrPps{Pps}%
\PhrPpps{Ppps}%
\PhrEncl{Encl}%
\PhrPager{Page}%
\PhrTo{To}%
\PhrFrom{From}%
\PhrRegard{Regarding}%
\PhrContact{Contact}%
\PhrRelease{For Immediate Release}%
\PhrMore{--- more ---}%
\PhrPRend{\# \# \#}%
}%
\InputIfFileExists{extracd.tex}%
{\typeout{Reading alternative macro definitions from extracd.tex}}%
{\typeout{All language information must be in newlfm.cls}}%
\DeclareOption{french}%
{\def\@def@l{french}\setboolean{@l@fr}{true} \@fr@phr}%
\define@key{ov}{french}[true]%
{\iffixq{#1}{\def\@def@l{french}\setboolean{@l@fr}{true} \@fr@phr}}%
\DeclareOption{german}{\def\@def@l{german}\setboolean{@l@ge}{true} \@gr@phr}%
\define@key{ov}{german}[true]%
{\iffixq{#1}{\def\@def@l{german}\setboolean{@l@ge}{true} \@gr@phr}}%
\DeclareOption{american}%
{\def\@def@l{american}\setboolean{@l@am}{true} \@am@phr}%
\define@key{ov}{american}[true]%
{\iffixq{#1}{\def\@def@l{american}\setboolean{@l@am}{true} \@am@phr}}%
\DeclareOption{english}%
{\def\@def@l{english}\setboolean{@l@en}{true} \@en@phr}%
\define@key{ov}{english}[true]%
{\iffixq{#1}{\def\@def@l{english}\setboolean{@l@en}{true} \@en@phr}}%
\DeclareOption{othlang}%
{\renewco@lgnd{\@def@l}{othlang}\setboolean{@l@ot}{true} \@ot@phr}%
\define@key{ov}{othlang}[true]%
{\iffixq{#1}{\def\@def@l{othlang}\setboolean{@l@ot}{true} \@ot@phr}}%
\DeclareOption{piglatin}%
{\def\@def@l{piglatin}\setboolean{@l@pi}{true} \@pl@phr}%
\define@key{ov}{piglatin}[true]%
{\iffixq{#1}{\def\@def@l{piglatin}\setboolean{@l@pi}{true} \@pl@phr}}%
\define@key{ov}{textwidthsize}{\setlength{\@text@width}{#1}}%
\def\textwidthsize#1{\setlength{\@text@width}{#1}}%
\define@key{ov}{textheightsize}{\setlength{\@text@height}{#1}}%
\def\textheightsize#1{\setlength{\@text@height}{#1}}%
\define@key{ov}{bottommarginskip}{\setlength{\@marg@bt@a}{#1}}%
\def\bottommarginskip#1{\setlength{\@marg@bt@a}{#1}}%
\define@key{ov}{bottommarginskipbelow}{\setlength{\@marg@bt@b}{#1}}%
\def\bottommarginskipbelow#1{\setlength{\@marg@bt@b}{#1}}%
\def\topmarginskip#1{\setlength{\@marg@tp@a}{#1}}%
\define@key{ov}{topmarginskip}{\setlength{\@marg@tp@a}{#1}}%
\def\topmarginsize#1{\setlength{\@marg@tp@s}{#1}}%
\define@key{ov}{topmarginsize}{\setlength{\@marg@tp@s}{#1}}%
\def\headermarginskip#1{\setlength{\@marg@tp@b}{#1}}%
\define@key{ov}{headermarginskip}{\setlength{\@marg@tp@b}{#1}}%
\def\rightmarginsize#1{\setlength{\@marg@rt}{#1}}%
\define@key{ov}{rightmarginsize}{\setlength{\@marg@rt}{#1}}%
\def\leftmarginsize#1{\setlength{\@marg@lt}{#1}}%
\define@key{ov}{leftmarginsize}{\setlength{\@marg@lt}{#1}}%
\def\headermarginsize#1{\setlength{\@marg@tp}{#1}}%
\define@key{ov}{headermarginsize}{\setlength{\@marg@tp}{#1}}%
\def\footermarginsize#1{\setlength{\@marg@bt}{#1}}%
\define@key{ov}{footermarginsize}{\setlength{\@marg@bt}{#1}}%
\def\leftmargintopdist#1%
{\setlength{\@marg@lt@tp@d}{#1}\setboolean{@marg@lt@fl@tp}{true}}%
\define@key{ov}{leftmargintopdist}%
{\setlength{\@marg@lt@tp@d}{#1}\setboolean{@marg@lt@fl@tp}{true}}%
\def\rightmargintopdist#1%
{\setlength{\@marg@rt@tp@d}{#1}\setboolean{@marg@rt@fl@tp}{true}}%
\define@key{ov}{rightmargintopdist}%
{\setlength{\@marg@rt@tp@d}{#1}\setboolean{@marg@rt@fl@tp}{true}}%
\define@key{ov}{leftmarginskipleft}%
{\setlength{\@marg@lt@l}{#1}\setboolean{@marg@lt@fl@tp}{false}}%
\def\leftmarginskipleft#1{\setlength{\@marg@lt@l}{#1}}%
\define@key{ov}{rightmarginskipleft}%
{\setlength{\@marg@rt@l}{#1}\setboolean{@marg@lt@fl@tp}{false}}%
\def\rightmarginskipleft#1{\setlength{\@marg@rt@l}{#1}}%
\def\leftmarginskipright#1{\setlength{\@marg@lt@r}{#1}}%
\define@key{ov}{leftmarginskipright}{\setlength{\@marg@lt@r}{#1}}%
\def\rightmarginskipright#1{\setlength{\@marg@rt@r}{#1}}%
\define@key{ov}{rightmarginskipright}{\setlength{\@marg@rt@r}{#1}}%
\def\dateskipbefore#1{\setlength{\@dt@sk@b}{#1}}%
\define@key{ov}{dateskipbefore}{\setlength{\@dt@sk@b}{#1}}%
\def\dateskipafter#1{\setlength{\@dt@sk@a}{#1}}%
\define@key{ov}{dateskipafter}{\setlength{\@dt@sk@a}{#1}}%
\def\addrfromskipafter#1{\setlength{\@addr@fr@sk@a}{#1}}%
\define@key{ov}{addrfromskipafter}{\setlength{\@addr@fr@sk@a}{#1}}%
\def\addrfromskipbefore#1{\setlength{\@addr@fr@sk@b}{#1}}%
\define@key{ov}{addrfromskipbefore}{\setlength{\@addr@fr@sk@b}{#1}}%
\def\addrtoskipafter#1{\setlength{\@addr@to@sk@a}{#1}}%
\define@key{ov}{addrtoskipafter}{\setlength{\@addr@to@sk@a}{#1}}%
\def\addrtoskipbefore#1{\setlength{\@addr@to@sk@b}{#1}}%
\define@key{ov}{addrtoskipbefore}{\setlength{\@addr@to@sk@b}{#1}}%
\def\greettoskipafter#1{\setlength{\@greet@to@sk@a}{#1}}%
\define@key{ov}{greettoskipafter}{\setlength{\@greet@to@sk@a}{#1}}%
\def\sigskipbefore#1{\setlength{\@sig@sk@b}{#1}}%
\define@key{ov}{sigskipbefore}{\setlength{\@sig@sk@b}{#1}}%
\def\sigskipafter#1{\setlength{\@sig@sk@a}{#1}}%
\define@key{ov}{sigskipafter}{\setlength{\@sig@sk@a}{#1}}%
\def\closeskipbefore#1{\setlength{\@cls@sk@b}{#1}}%
\define@key{ov}{closeskipbefore}{\setlength{\@cls@sk@b}{#1}}%
\def\closeskipafter#1{\setlength{\@cls@sk@a}{#1}}%
\define@key{ov}{closeskipafter}{\setlength{\@cls@sk@a}{#1}}%
\def\sigskipcolumn#1{\setlength{\@sig@sk@c}{#1}}%
\define@key{ov}{sigskipcolumn}{\setlength{\@sig@sk@c}{#1}}%
\def\sigskiprow#1{\setlength{\@sig@sk@r}{#1}}%
\define@key{ov}{sigskiprow}{\setlength{\@sig@sk@r}{#1}}%
\def\sigsize#1{\setlength{\@sig@sp}{#1}}%
\define@key{ov}{sigsize}{\setlength{\@sig@sp}{#1}}%
\def\postsigskipafter#1{\setlength{\@post@sig@sp@a}{#1}}%
\define@key{ov}{postsigskipafter}{\setlength{\@post@sig@sp@a}{#1}}% %
\def\postsigskipbefore#1{\setlength{\@post@sig@sp@b}{#1}}%
\define@key{ov}{postsigskipbefore}{\setlength{\@post@sig@sp@b}{#1}}% %
\def\memoskipafter#1{\setlength{\@post@memo@sp}{#1}}%
\define@key{ov}{memoskipafter}{\setlength{\@post@memo@sp}{#1}}%
\def\memoskipbefore#1{\setlength{\@pre@memo@sp}{#1}}%
\define@key{ov}{memoskipbefore}{\setlength{\@pre@memo@sp}{#1}}%
\def\restletter#1{\setboolean{@resta@l}{true}%
\begin{lrbox}{\@resta@ltr}\begin{minipage}{\textwidth}#1\end{minipage}\end{lrbox}}%
\def\restlettera#1{\setboolean{@resta@l}{true}%
\begin{lrbox}{\@resta@ltr}\begin{minipage}{\textwidth}#1\end{minipage}\end{lrbox}}%
\def\restletterb#1{\setboolean{@restb@l}{true}%
\begin{lrbox}{\@restb@ltr}\begin{minipage}{\textwidth}#1\end{minipage}\end{lrbox}}%
\def\restletterc#1{\setboolean{@restc@l}{true}%
\begin{lrbox}{\@restc@ltr}\begin{minipage}{\textwidth}#1\end{minipage}\end{lrbox}}%
\def\restletterd#1{\setboolean{@restd@l}{true}%
\begin{lrbox}{\@restd@ltr}\begin{minipage}{\textwidth}#1\end{minipage}\end{lrbox}}%
\def\restlettere#1{\setboolean{@reste@l}{true}%
\begin{lrbox}{\@reste@ltr}\begin{minipage}{\textwidth}#1\end{minipage}\end{lrbox}}%
\def\unprtop#1{\setlength{\@unpr@tp}{#1}}%
\define@key{ov}{unprtop}{\setlength{\@unpr@tp}{#1}}%
\def\unprbottom#1{\setlength{\@unpr@bm}{#1}}%
\define@key{ov}{unprbottom}{\setlength{\@unpr@bm}{#1}}%
\def\unprright#1{\setlength{\@unpr@rt}{#1}}%
\define@key{ov}{unprright}{\setlength{\@unpr@rt}{#1}}%
\def\unprleft#1{\setlength{\@unpr@lt}{#1}}%
\define@key{ov}{unprleft}{\setlength{\@unpr@lt}{#1}}%
\def\@opt@stm{%
\setboolean{@addr@fr@p}{false}%
\setboolean{@addr@to@p}{false}%
\setboolean{@memo@bl}{true}%
\setboolean{@greet@p}{false}%
\setboolean{@dt@l}{false}%
\setboolean{@dt@c}{false}%
\setboolean{@dt@p}{false}%
\setboolean{@sig@p}{false}%
\setboolean{@sig@mp}{true}%
}%
\def\@opt@stpr{%
\setboolean{@addr@fr@p}{false}%
\setboolean{@addr@to@p}{false}%
\setboolean{@memo@bl}{true}%
\setboolean{@greet@p}{false}%
\setboolean{@dt@l}{false}%
\setboolean{@dt@c}{false}%
\setboolean{@dt@p}{false}%
\setboolean{@sig@p}{false}%
\setboolean{@sig@mp}{true}%
}%
\def\@opt@flm{%
\setboolean{@addr@fr@p}{false}%
\setboolean{@addr@to@p}{false}%
\setboolean{@memo@bl}{true}%
\setboolean{@greet@p}{false}%
\setboolean{@dt@l}{false}%
\setboolean{@dt@c}{false}%
\setboolean{@dt@p}{false}%
\setboolean{@sig@p}{false}%
\setboolean{@sig@mp}{false}%
\setboolean{@memo@b}{true}%
\setboolean{@memo@c}{true}%
\setboolean{@memo@d}{true}%
\setboolean{@memo@h}{true}%
\setboolean{@memo@i}{true}%
\setboolean{@memo@j}{true}%
\setboolean{@memo@k}{true}%
\setboolean{@memo@l}{true}%
\setboolean{@memo@m}{true}%
\setboolean{@memo@n}{true}%
}%
\DeclareOption{memoaddrto}{\setboolean{@memo@b}{true}}%
\define@key{ov}{memoaddrto}[true]{\iffixt{#1}{@memo@b}}%
\DeclareOption{memoemailto}{\setboolean{@memo@k}{true}}%
\define@key{ov}{memoemailto}[true]{\iffixt{#1}{@memo@k}}%
\DeclareOption{memophoneto}{\setboolean{@memo@c}{true}}%
\define@key{ov}{memophoneto}[true]{\iffixt{#1}{@memo@c}}%
\DeclareOption{memopagerto}{\setboolean{@memo@n}{true}}%
\define@key{ov}{memopagerto}[true]{\iffixt{#1}{@memo@n}}%
\DeclareOption{memofaxto}{\setboolean{@memo@d}{true}}%
\define@key{ov}{memofaxto}[true]{\iffixt{#1}{@memo@d}}%
\DeclareOption{memoaddrfrom}{\setboolean{@memo@h}{true}}%
\define@key{ov}{memoaddrfrom}[true]{\iffixt{#1}{@memo@h}}%
\DeclareOption{memoemailfrom}{\setboolean{@memo@l}{true}}%
\define@key{ov}{memoemailfrom}[true]{\iffixt{#1}{@memo@l}}%
\DeclareOption{memopagerfrom}{\setboolean{@memo@m}{true}}%
\define@key{ov}{memopagerfrom}[true]{\iffixt{#1}{@memo@m}}%
\DeclareOption{memophonefrom}{\setboolean{@memo@i}{true}}%
\define@key{ov}{memophonefrom}[true]{\iffixt{#1}{@memo@i}}%
\DeclareOption{memofaxfrom}{\setboolean{@memo@j}{true}}%
\define@key{ov}{memofaxfrom}[true]{\iffixt{#1}{@memo@j}}%
\DeclareOption{memodate}{\setboolean{@dt@p}{true}}%
\define@key{ov}{memodate}[true]{\iffixt{#1}{@dt@p}}%
\DeclareOption{memonofrom}{\setboolean{@memo@e}{true}}%
\define@key{ov}{memonofrom}[true]{\iffixt{#1}{@memo@e}}%
\DeclareOption{memonoto}{\setboolean{@memo@g}{true}}%
\define@key{ov}{memonoto}[true]{\iffixt{#1}{@memo@g}}%
\DeclareOption{memonore}{\setboolean{@memo@f}{true}}%
\define@key{ov}{memonore}[true]{\iffixt{#1}{@memo@f}}%
\DeclareOption{fullmemo}{\@opt@flm}%
\define@key{ov}{fullmemo}[true]{\iffixq{#1}{\@opt@flm}}%
\DeclareOption{stdmemo}{\@opt@stm}%
\define@key{ov}{stdmemo}[true]{\iffixq{#1}{\@opt@stm}}%
\def\@opt@pr{%
\setboolean{@addr@fr@p}{true}%
\setboolean{@addr@to@p}{false}%
\setboolean{@pr@p}{true}%
\setboolean{@greet@p}{false}%
\setboolean{@dt@l}{false}%
\setboolean{@dt@c}{false}%
\setboolean{@dt@p}{false}%
\setboolean{@sig@p}{false}%
\setboolean{@sig@mp}{false}%
}%
\DeclareOption{pressrelease}{\@opt@pr}%
\define@key{ov}{pressrelease}[true]{\iffixq{#1}{\@opt@pr}}%
\DeclareOption{stdpressrelease}{\@opt@pr}%
\define@key{ov}{stdpressrelease}[true]{\iffixq{#1}{\@opt@pr}}%
\DeclareOption{dspace}{\setboolean{@space@d}{true}\setboolean{@space@s}{false}}%
\DeclareOption{sspace}{\setboolean{@space@s}{true}\setboolean{@space@d}{false}}%
\define@key{ov}{dspace}[true]{%
\iffixq{#1}{\setboolean{@space@d}{true}\setboolean{@space@s}{false}}}%
\define@key{ov}{sspace}[true]{%
\iffixq{#1}{\setboolean{@space@s}{true}\setboolean{@space@d}{false}}}%
\DeclareOption{faxhp}{\setboolean{@fax@hdr@pg}{true}\setboolean{@fax@RA}{false}}%
\DeclareOption{faxheaderpage}{\setboolean{@fax@hdr@pg}{true}\setboolean{@fax@RA}{false}}%
\define@key{ov}{faxheaderpage}[true]%
{\iffixq{#1}{\setboolean{@fax@hdr@pg}{true}\setboolean{@fax@RA}{false}}}%
\DeclareOption{faxhba}%   Print fax header block on leader in right top-margin.
{\setboolean{@fax@RA}{true}\setboolean{@fax@hdr@pg}{false}}%
\define@key{ov}{faxhba}[true]%   Print fax header block on leader in right top-margin.
{\iffixq{#1}{\setboolean{@fax@RA}{true}\setboolean{@fax@hdr@pg}{false}}}%
\DeclareOption{faxhbb}%   Print fax header block - leader - upper right quad letter
{\setboolean{@fax@RU}{true}\setboolean{@fax@hdr@pg}{false}}%
\DeclareOption{faxbla}%   Print FAX block in \Rheader
{\setboolean{@fax@bla}{true}\setboolean{@fax@blb}{false}}%
\DeclareOption{faxblb}%
{\setboolean{@fax@blb}{true}\setboolean{@fax@bla}{false}}%
\DeclareOption{faxblocka}%Print FAX block in \Rheader
{\setboolean{@fax@bla}{true}\setboolean{@fax@blb}{false}}%
\define@key{ov}{faxblocka}[true]%
{\iffixq{#1}{\setboolean{@fax@bla}{true}\setboolean{@fax@blb}{false}}}%
\DeclareOption{faxblockb}%
{\setboolean{@fax@blb}{true}\setboolean{@fax@bla}{false}}%
\define@key{ov}{faxblockb}[true]%
{\iffixq{#1}{\setboolean{@fax@blb}{true}\setboolean{@fax@bla}{false}}}%
\def\@opt@slr{%
\setboolean{@addr@fr@l}{false}%
\setboolean{@addr@fr@p}{true}%
\setboolean{@addr@to@p}{true}%
\setboolean{@dt@p}{true}%
\setboolean{@dt@l}{false}%
\setboolean{@dt@c}{false}%
\setboolean{@greet@p}{true}%
\setboolean{@sig@p}{true}%
\setboolean{@sig@mp}{false}%
\setboolean{@addr@to@l}{true}%
\setboolean{@memo@bl}{false}%
\setboolean{@dt@l}{false}%
\txa{In @opt@slr}%
\setboolean{@sig@l}{false}%
\setboolean{@sig@c}{false}%
\@d@pos{1}\@t@pos{3}\@f@pos{2}\setboolean{@s@b@s}{false}}%
\DeclareOption{stdletter}{\@opt@slr}%
\define@key{ov}{stdletter}[true]{\iffixq{#1}{\@opt@slr}}%
\def\@opt@sln{\setboolean{@addr@fr@l}{false}%
\setboolean{@addr@fr@p}{false}%
\setboolean{@addr@to@p}{true}%
\setboolean{@dt@p}{true}%
\setboolean{@dt@l}{false}%
\setboolean{@dt@c}{false}%
\setboolean{@greet@p}{true}%
\setboolean{@sig@p}{true}%
\setboolean{@sig@mp}{false}%
\setboolean{@addr@to@l}{true}%
\setboolean{@memo@bl}{false}%
\setboolean{@dt@l}{false}%
\txa{In @opt@sln}%
\setboolean{@sig@l}{false}%
\setboolean{@sig@c}{false}%
\@d@pos{1}\@t@pos{3}\@f@pos{2}\setboolean{@s@b@s}{false}}%
\DeclareOption{stdletternofrom} {\@opt@sln}%
\define@key{ov}{stdletternofrom}[true]{\iffixq{#1}{\@opt@sln}}%
\def\@opt@blr{\setboolean{@addr@fr@l}{true}%
\setboolean{@addr@fr@p}{true}%
\setboolean{@memo@bl}{false}%
\setboolean{@addr@to@l}{true}%
\setboolean{@dt@l}{true}%
\setboolean{@dt@c}{false}%
\txa{In @opt@blr}%
\setboolean{@sig@l}{true}%
\setboolean{@sig@c}{false}%
\setboolean{@sig@p}{true}%
\setboolean{@sig@mp}{false}%
\@d@pos{1}\@t@pos{3}\@f@pos{2}\setboolean{@s@b@s}{false}}%
\DeclareOption{busletter} {\@opt@blr}%
\define@key{ov}{busletter}[true]{\iffixq{#1}{\@opt@blr}}%
\def\@opt@bln{\setboolean{@addr@fr@l}{true}%
\setboolean{@addr@fr@p}{false}%
\setboolean{@memo@bl}{false}%
\setboolean{@addr@to@l}{true}%
\setboolean{@dt@l}{true}%
\setboolean{@dt@c}{false}%
\txa{In @opt@bln}%
\setboolean{@sig@l}{true}%
\setboolean{@sig@p}{true}%
\setboolean{@sig@mp}{false}%
\setboolean{@sig@c}{false}%
\@d@pos{1}\@t@pos{3}\@f@pos{2}\setboolean{@s@b@s}{false}}%
\DeclareOption{busletternofrom} {\@opt@bln}%
\newboolean{@test@opt}\setboolean{@test@opt}{false}%
\define@key{ov}{busletternofrom}[true]{\iffixq{#1}{\@opt@bln}}%
\DeclareOption{addrfromleft} {\setboolean{@addr@fr@l}{true}}%
\define@key{ov}{addrfromleft}[true]{\iffixt{#1}{@addr@fr@l}}%
\DeclareOption{addrfromright}{\setboolean{@addr@fr@l}{false}}%
\define@key{ov}{addrfromright}[true]{\iffixf{#1}{@addr@fr@l}}%
\DeclareOption{addrtoleft}   {\setboolean{@addr@to@l}{true}}%
\define@key{ov}{addrtoleft}[true]{\iffixt{#1}{@addr@to@l}}%
\DeclareOption{addrtoright}  {\setboolean{@addr@to@l}{false}}%
\define@key{ov}{addrtoright}[true]{\iffixf{#1}{@addr@to@l}}%
\DeclareOption{addrtoemail}  {\setboolean{@addr@to@e}{true}}%
\define@key{ov}{addrtoemail}[true]{\iffixt{#1}{@addr@to@e}}%
\DeclareOption{addrtophone}  {\setboolean{@addr@to@t}{true}}%
\define@key{ov}{addrtophone}[true]{\iffixt{#1}{@addr@to@t}}%
\DeclareOption{addrtofax}    {\setboolean{@addr@to@f}{true}}%
\DeclareOption{addrfromemail}{\setboolean{@addr@fr@e}{true}}%
\define@key{ov}{addrfromemail}[true]{\iffixt{#1}{@addr@fr@e}}%
\DeclareOption{addrfromphone}{\setboolean{@addr@fr@t}{true}}%
\define@key{ov}{addrfromphone}[true]{\iffixt{#1}{@addr@fr@t}}%
\DeclareOption{addrfromfax}  {\setboolean{@addr@fr@f}{true}}%
\define@key{ov}{addrfromfax}[true]{\iffixt{#1}{@addr@fr@f}}%
\providecommand{\boxht}{}\providecommand{\boxwd}{}\providecommand{\btwlb}{}%
\providecommand{\topht}{}\providecommand{\lftwd}{}%
\def\labpl#1{\setlength{\@lab@pl}{#1}}%
\def\boxht#1{\setlength{\@lab@bh}{#1}}%
\def\boxwd#1{\setlength{\@lab@bw}{#1}}%
\def\topht#1{\setlength{\@lab@th}{#1}}%
\def\lftwd#1{\setlength{\@lab@lm}{#1}}%
\def\btwlb#1{\setlength{\@lab@bl}{#1}}%
\def\@labname{nolines,dateno}%
\def\Alaba{\def\@labname{Avery5160,nolines,dateno}%
  \setboolean{@set@env}{true}\setboolean{@use@envlab}{false} \def\@tab@just{rrr}\labpl{10.125in}%
  \setcounter{@lab@tot@row}{10} \setcounter{@lab@tot@col}{3} \btwlb{5pt}%
  \boxht{67pt} \boxwd{174pt} \topht{38pt} \lftwd{-77pt} \setlength{\@Hgt@Foot}{0pt}}%
\def\Alabb{\def\@labname{Avery5161,nolines,dateno}%
  \setboolean{@set@env}{true}\setboolean{@use@envlab}{false} \def\@tab@just{rr}\labpl{10.125in}%
  \setcounter{@lab@tot@row}{10} \setcounter{@lab@tot@col}{2} \btwlb{8pt}%
  \boxht{67pt} \boxwd{274pt} \topht{37pt} \lftwd{-80pt} \setlength{\@Hgt@Foot}{0pt}}%
\def\Alabc{\def\@labname{Avery5162,nolines,dateno}%
  \setboolean{@set@env}{true}\setboolean{@use@envlab}{false} \def\@tab@just{rr}\labpl{9.5in}%
  \setcounter{@lab@tot@row}{7} \setcounter{@lab@tot@col}{2} \btwlb{8pt}%
  \boxht{93pt} \boxwd{274pt} \topht{62pt} \lftwd{-80pt} \setlength{\@Hgt@Foot}{0pt}}%
\def\Alabd{\def\@labname{Avery5163,nolines,dateno}%
  \setboolean{@set@env}{true}\setboolean{@use@envlab}{false} \def\@tab@just{rr}\labpl{10.125in}%
  \setcounter{@lab@tot@row}{5} \setcounter{@lab@tot@col}{2} \btwlb{8pt}%
  \boxht{139pt} \boxwd{274pt} \topht{38pt} \lftwd{-80pt} \setlength{\@Hgt@Foot}{0pt}}%
\def\Alabe{\def\@labname{Avery5164,nolines,dateno}%
  \setboolean{@set@env}{true}\setboolean{@use@envlab}{false} \def\@tab@just{rr}\labpl{10.125in}%
  \setcounter{@lab@tot@row}{3} \setcounter{@lab@tot@col}{2} \btwlb{8pt}%
  \boxht{232pt} \boxwd{274pt} \topht{38pt} \lftwd{-80pt} \setlength{\@Hgt@Foot}{0pt}}%
\DeclareOption{Avery5160}{\Alaba}%
\DeclareOption{Avery5161}{\Alabb}%
\DeclareOption{Avery5261}{\Alabb}%
\DeclareOption{Avery5162}{\Alabc}%
\DeclareOption{Avery5163}{\Alabd}%
\DeclareOption{Avery5164}{\Alabe}%
\DeclareOption{Avery5264}{\Alabe}%
\DeclareOption{labto}{\setboolean{@lab@t}{true}}%
\DeclareOption{labrowfrto}{\setboolean{@lab@rft}{true}\setboolean{@lab@t}{false}}%
\DeclareOption{labcolfrto}{\setboolean{@lab@cft}{true}\setboolean{@lab@t}{false}}%
\def\labsize#1{\def\@lab@size{#1}}%
\define@key{ov}{Avery5160}[true]{\iffixq{#1}{\Alaba}}%
\define@key{ov}{Avery5161}[true]{\iffixq{#1}{\Alabb}}%
\define@key{ov}{Avery5261}[true]{\iffixq{#1}{\Alabb}}%
\define@key{ov}{Avery5162}[true]{\iffixq{#1}{\Alabc}}%
\define@key{ov}{Avery5163}[true]{\iffixq{#1}{\Alabd}}%
\define@key{ov}{Avery5164}[true]{\iffixq{#1}{\Alabe}}%
\define@key{ov}{Avery5264}[true]{\iffixq{#1}{\Alabe}}%
\define@key{ov}{labto}[true]{\iffixq{#1}{\setboolean{@lab@t}{true}}}%
\define@key{ov}{labrowfrto}[true]{\iffixq{#1}%
{\setboolean{@lab@rft}{true}\setboolean{@lab@t}{false}}}%
\define@key{ov}{labsize}{\def\@lab@size{#1}}
\define@key{ov}{labcolfrto}[true]{\iffixq{#1}%
{\setboolean{@lab@cft}{true}\setboolean{@lab@t}{false}}}%
\DeclareOption{setuplabel}{\setboolean{@set@env}{true}\setboolean{@use@envlab}{false}}%
\define@key{ov}{setuplabel}[true]{%
\iffixq{#1}{\setboolean{@set@env}{true}\setboolean{@use@envlab}{false}}}%
\def\@dodtf{\@d@pos{1}\@t@pos{3}\@f@pos{2}\setboolean{@s@b@s}{false}}%
\def\@dofdt{\@d@pos{2}\@t@pos{3}\@f@pos{1}\setboolean{@s@b@s}{false}}%
\def\@doftd{\@d@pos{3}\@t@pos{2}\@f@pos{1}\setboolean{@s@b@s}{false}}%
\def\@dosbs{\@d@pos{1}\@t@pos{0}\@f@pos{0}\setboolean{@s@b@s}{true}}%
\DeclareOption{orderdatefromto}{\@dodtf}%
\define@key{ov}{orderdatefromto}[true]{\iffixq{#1}{\@dodtf}}%
\DeclareOption{orderfromdateto}{\@dofdt}%
\define@key{ov}{orderfromdateto}[true]{\iffixq{#1}{\@dofdt}}%
\DeclareOption{orderfromtodate}{\@doftd}%
\define@key{ov}{orderfromtodate}[true]{\iffixq{#1}{\@doftd}}%
\DeclareOption{sidebyside}{\@dosbs}%
\define@key{ov}{sidebyside}[true]{\iffixq{#1}{\@dosbs}}%
\DeclareOption{margflush}{\setboolean{@marg@lt@fl@tp}{true}}%
\define@key{ov}{margflush}[true]{\iffixt{#1}{@marg@lt@fl@tp}}%
\DeclareOption{biggap}{\setboolean{@gap@small}{false}}%
\DeclareOption{addrfromno}{\setboolean{@addr@fr@p}{false}}%
\DeclareOption{noaddrfr}{\setboolean{@addr@fr@p}{false}}%
\DeclareOption{noaddrfrom}{\setboolean{@addr@fr@p}{false}}%
\define@key{ov}{noaddrfrom}[true]{\iffixf{#1}{@addr@fr@p}}%
\DeclareOption{addrtono}{\setboolean{@addr@to@p}{false}}%
\DeclareOption{noaddrto}{\setboolean{@addr@to@p}{false}}%
\define@key{ov}{noaddrto}[true]{\iffixf{#1}{@addr@to@p}}%
\DeclareOption{greetno}{\setboolean{@greet@p}{false}}%
\define@key{ov}{nogreet}[true]{\iffixf{#1}{@greet@p}}%
\DeclareOption{cellowindow}{\setboolean{@cello@win}{true}}%
\define@key{ov}{cellowindow}[true]{\iffixt{#1}{@cello@win}}%
\def\celloheight#1{\setlength{\@cello@h}{#1}}%
\def\cellowidth#1{\setlength{\@cello@w}{#1}}%
\define@key{ov}{celloheight}{\celloheight{#1}}%
\define@key{ov}{cellowidth}{\cellowidth{#1}}%
\def\cellodown#1{\setlength{\@cello@d}{#1}}%
\def\celloleft#1{\setlength{\@cello@l}{#1}}%
\define@key{ov}{cellodown}{\cellodown{#1}}%
\define@key{ov}{celloleft}{\celloleft{#1}}%
\DeclareOption{dateright}{\setboolean{@dt@l}{false}\setboolean{@dt@c}{false}}%
\define@key{ov}{dateright}[true]{\iffixq{#1}{\setboolean{@dt@l}{false}\setboolean{@dt@c}{false}}}%
\def\dateright#1{\iffixq{#1}{\setboolean{@dt@l}{false}\setboolean{@dt@c}{false}}}%
\DeclareOption{dateleft}{\setboolean{@dt@l}{true}\setboolean{@dt@c}{false}}%
\define@key{ov}{dateleft}[true]{\iffixq{#1}{\setboolean{@dt@l}{true}\setboolean{@dt@c}{false}}}%
\def\dateleft#1{\iffixq{#1}{\setboolean{@dt@l}{true}\setboolean{@dt@c}{false}}}%
\DeclareOption{datecenter}{\setboolean{@dt@l}{false}\setboolean{@dt@c}{true}}%
\define@key{ov}{datecenter}[true]{\iffixq{#1}{\setboolean{@dt@l}{false}\setboolean{@dt@c}{true}}}%
\def\datecenter#1{\iffixq{#1}{\setboolean{@dt@l}{false}\setboolean{@dt@c}{true}}}%
\DeclareOption{dateno}{\setboolean{@dt@p}{false}}%
\define@key{ov}{dateno}[true]{\iffixf{#1}{@dt@p}}%
\def\dateno#1{\iffixf{#1}{@dt@p}}%
\DeclareOption{dateyes}{\setboolean{@dt@p}{true}}%
\def\setsigl{\setboolean{@sig@l}{true}\setboolean{@sig@c}{false}}
\def\setsigc{\setboolean{@sig@l}{false}\setboolean{@sig@c}{true}}
\def\setsigr{\setboolean{@sig@l}{false}\setboolean{@sig@c}{false}}
\DeclareOption{signatureleft}{\txa{DO fsignl}\setsigl}%
\define@key{ov}{signatureleft}[true]{\iffixq{#1}{\txa{DK fsignl}\setsigl}}%
\def\signatureleft#1{\txa{SO fsignl}\setsigl}%
\DeclareOption{sigleft}{\txa{DO asignl}\setsigl}%
\define@key{ov}{sigleft}[true]{\iffixq{#1}{\txa{DK asignl}\setsigl}}%
\def\sigleft#1{\txa{SO asignl}\setsigl}%
\DeclareOption{signaturecenter}{\txa{DO fsignc}\setsigc}%
\define@key{ov}{signaturecenter}[true]{\iffixq{#1}{\txa{DK fsignc}\setsigc}}%
\def\signaturecenter#1{\txa{SO fsignc}\setsigc}%
\DeclareOption{sigcenter}{\txa{DO asignc}\setsigc}%
\define@key{ov}{sigcenter}[true]{\iffixq{#1}{\txa{DK asignc}\setsigc}}%
\def\sigcenter#1{\txa{SO asignc}\setsigc}%
\DeclareOption{signatureright}{\txa{DO fsignr}\setsigr}%
\define@key{ov}{signatureright}[true]{\iffixq{#1}{\txa{DK fsignr}\setsigr}}%
\def\signatureright#1{\txa{SO fsignr}\setsigr}%
\DeclareOption{sigright}{\txa{DO asignr}\setsigr}%
\define@key{ov}{sigright}[true]{\iffixq{#1}{\txa{DK asignr}\setsigr}}%
\def\sigright#1{\txa{SO asignr}\setsigr}%
\DeclareOption{signatureno}{\setboolean{@sig@p}{false}}%
\define@key{ov}{signatureno}[true]{\iffixf{#1}{\setboolean{@sig@p}{false}}}%
\def\signatureno#1{\setboolean{@sig@p}{false}}%
\def\@fix@all@fr{%
\setboolean{@use@all@fr}{true}\setboolean{@addr@fr@p}{true}\setboolean{@addr@fr@l}{true}%
\setboolean{@addr@fr@f}{true}\setboolean{@addr@fr@e}{true}\setboolean{@addr@fr@t}{true}}%
\DeclareOption{printallfrom}{\@fix@all@fr}%
\define@key{ov}{printallfrom}[true]{\iffixq{#1}{\@fix@all@fr}}%
\def\@fix@all@to{
\setboolean{@use@all@to}{true}\setboolean{@addr@to@p}{true}\setboolean{@addr@to@l}{true}%
\setboolean{@addr@to@f}{true}\setboolean{@addr@to@e}{true}\setboolean{@addr@to@t}{true}}%
\DeclareOption{printallto}{\@fix@all@to}%
\define@key{ov}{printallto}[true]{\iffixq{#1}{\@fix@all@to}}%
\DeclareOption{blankheader}{\setboolean{@b@h}{true}}%
\define@key{ov}{blankheader}[true]{\iffixt{#1}{@b@h}}%
\DeclareOption{Blankheader}{\setboolean{@B@h}{true}}%
\define@key{ov}{Blankheader}[true]{\iffixt{#1}{@B@h}}%
\DeclareOption{blankfooter}{\setboolean{@b@f}{true}}%
\define@key{ov}{blankfooter}[true]{\iffixt{#1}{@b@f}}%
\DeclareOption{Blankfooter}{\setboolean{@B@f}{true}}%
\define@key{ov}{Blankfooter}[true]{\iffixt{#1}{@B@f}}%
\DeclareOption{blanklmargin}{\setboolean{@b@l}{true}}%
\DeclareOption{blankleftmargin}{\setboolean{@b@l}{true}}%
\define@key{ov}{blankleftmargin}[true]{\iffixt{#1}{@b@l}}%
\DeclareOption{Blankleftmargin}{\setboolean{@B@l}{true}}%
\define@key{ov}{Blankleftmargin}[true]{\iffixt{#1}{@B@l}}%
\DeclareOption{blankrmargin}{\setboolean{@b@r}{true}}%
\DeclareOption{blankrightmargin}{\setboolean{@b@r}{true}}%
\define@key{ov}{blankrightmargin}[true]{\iffixt{#1}{@b@r}}%
\DeclareOption{Blankrightmargin}{\setboolean{@B@r}{true}}%
\define@key{ov}{Blankrightmargin}[true]{\iffixt{#1}{@B@r}}%
\DeclareOption{Blankall}{\setboolean{@B@f}{true}\setboolean{@B@l}{true}%
\setboolean{@B@h}{true}\setboolean{@B@r}{true}}%
\define@key{ov}{Blankall}[true]%
{\iffixq{#1}{\setboolean{@B@f}{true}\setboolean{@B@l}{true}%
\setboolean{@B@h}{true}\setboolean{@B@r}{true}}}%
\DeclareOption{blankall}{\setboolean{@b@f}{true}\setboolean{@b@l}{true}%
\setboolean{@b@h}{true}\setboolean{@b@r}{true}}%
\define@key{ov}{blankall}[true]%
{\iffixq{#1}{\setboolean{@b@f}{true}\setboolean{@b@l}{true}%
\setboolean{@b@h}{true}\setboolean{@b@r}{true}}}%
\DeclareOption{BlankTotal}% Fixed
{\setboolean{@B@f}{true}\setboolean{@B@l}{true}\setboolean{@B@h}{true}\setboolean{@B@r}{true}%
\setboolean{@b@f}{true}\setboolean{@b@l}{true}\setboolean{@b@h}{true}\setboolean{@b@r}{true}}%
\define@key{ov}{BlankTotal}[true]%
{\iffixq{#1}{\setboolean{@B@f}{true}\setboolean{@B@l}{true}\setboolean{@B@h}{true}\setboolean{@B@r}{true}%
\setboolean{@b@f}{true}\setboolean{@b@l}{true}%
\setboolean{@b@h}{true}\setboolean{@b@r}{true}}}%
\DeclareOption{useenvlab}{\setboolean{@set@env}{false}\setboolean{@use@envlab}{true}}%
\define@key{ov}{useenvlab}[true]{%
\iffixq{#1}{\setboolean{@use@envlab}{true}\setboolean{@set@env}{false}}}%
\def\@paper@type{letterpaper}%
\def\ifta{0}
\DeclareOption{letterpaper}{\def\@paper@type{letterpaper}}%
\define@key{ov}{letterpaper}[true]{\iffixq{#1}{\def\@paper@type{letterpaper}}}%
\DeclareOption{legalpaper}{\def\@paper@type{legalpaper}}%
\define@key{ov}{legalpaper}[true]{\iffixq{#1}{\def\@paper@type{legalpaper}}}%
\DeclareOption{a4paper}{\def\@paper@type{a4paper}}%
\define@key{ov}{a4paper}[true]{\iffixq{#1}{\def\@paper@type{a4paper}}}%
\DeclareOption{a3paper}{\def\@paper@type{a3paper}}%
\define@key{ov}{a3paper}[true]{\iffixq{#1}{\def\@paper@type{a3paper}}}%
\setkeys{ov}{textwidthsize=0pt,textheightsize=0pt,bottommarginskip=5pt,%
headermarginskip=0pt,rightmarginsize=72pt,leftmarginsize=72pt,bottommarginskipbelow=5pt,%
leftmargintopdist=0pt,addrtoskipafter=18pt,unprright=0pt,labsize=\normalsize,%
leftmarginskipleft=10pt,leftmarginskipright=10pt,dateskipbefore=20pt,%
dateskipafter=36pt,addrfromskipafter=36pt,addrfromskipbefore=0pt,%
greettoskipafter=18pt,sigskipbefore=12pt,sigskipafter=12pt,sigsize=72pt,%
postsigskipafter=10pt,memoskipafter=15pt,memoskipbefore=35pt,unprtop=0pt,unprbottom=0pt,%
unprleft=0pt}%
\ExecuteOptions{\@paper@type,stdletter,american}%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}%
\ProcessOptions%
\def\showdim#1{%
\txa{ * * * }%
\txa{*****************************************************************************}%
\txa{Dimensions: #1}%
\txa{\string\headheight:     \the\headheight,  \string\headsep:        \the\headsep}%
\txa{\string\paperheight:    \the\paperheight, \string\paperwidth:    \the\paperwidth}%
\txa{\string\textheight:     \the\textheight,  \string\textwidth:      \the\textwidth}
\txa{\string\@colht:         \the\@colht,      \string\@colroom:       \the\@colroom}%
\txa{\string\vsize:          \the\vsize,   \string\columnwidth: \the\columnwidth}%
\txa{\string\hsize: \the\hsize, \string\linewidth: \the\linewidth}%
\txa{\string\evensidemargin: \the\evensidemargin, \string\footskip:       \the\footskip}%
\txa{\string\oddsidemargin:  \the\oddsidemargin, \string\columnsep:      \the\columnsep}%
\txa{\string\topmargin:      \the\topmargin}%
\txa{\string\marginparpush: \the\marginparpush, \string\marginparsep: \the\marginparsep}%
\txa{*****************************************************************************}%
\txa{ * * * }%
}%
\showdim{Before LoadClass}%
\PassOptionsToClass{\@paper@type,oneside,final}{letter}%
\LoadClass{letter}%
\showdim{Before addrset}%
\RequirePackage{addrset}%
\IfFileExists{afterpage.sty}{\RequirePackage{afterpage}}{}%
\IfFileExists{envlab.sty}{\RequirePackage{envlab}}{}%
\showdim{After LoadClass}%
\setlength{\voffset}{0in}%
\setlength{\itemsep}{.2em}%
\setlength{\topsep}{.2em}%
\setlength{\partopsep}{0\p@}%
\setlength{\arraycolsep}{5\p@}%
\setlength{\tabcolsep}{6\p@}%
\setlength{\arrayrulewidth}{.4\p@}%
\setlength{\doublerulesep}{2\p@}%
\setlength{\tabbingsep}{\labelsep}%
\skip\@mpfootins = \skip\footins%
\setlength{\fboxsep}{3\p@}%
\setlength{\fboxrule}{.4\p@}%
\providecommand{\geometry}{ }%
\def\geometry#1{\typeout{Command \string\geometry{items} no longer supported.}%
\typeout{newlfm supports several dimensional commands.  Please check the manual for detail.}%
}%
\renewcommand{\theequation}{\@arabic\c@equation}%
\renewcommand{\footnoterule}{%
\kern-\p@%
\hrule \@width .4\columnwidth%
\kern .6\p@}%
\long\def\@makefntext#1{%
\noindent \hangindent 5\p@%
\hb@xt@5\p@{\hss\@makefnmark}#1}%
\renewcommand{\thefigure}{\@arabic\c@figure}%
\providecommand{\figurename}{}\renewcommand{\figurename}{Figure}%
\providecommand{\tablename}{} \renewcommand{\tablename}{Table}%
\newcommand{\fps@figure}{tbp}\newcommand{\ftype@figure}{1}\newcommand{\ext@figure}{lof}%
\newcommand{\fnum@figure}{\figurename~\thefigure}%
\newenvironment{figure}{\@float{figure}}{\end@float}%
\newenvironment{figure*}{\@dblfloat{figure}}{\end@dblfloat}%
\renewcommand\thetable{\@arabic\c@table}%
\newcommand{\fps@table}{tbp}\newcommand{\ftype@table}{2}%
\newcommand{\ext@table}{lot}%
\newcommand{\fnum@table}{\tablename~\thetable}%
\newenvironment{table}{\@float{table}}{\end@float}%
\newenvironment{table*}{\@dblfloat{table}}{\end@dblfloat}%
\setlength\@caption@skip@above{10\p@}\setlength\@caption@skip@below{0\p@}%
\long\def\@makecaption#1#2{%
\vskip\@caption@skip@above\sbox\@tempboxa{#1: #2}%
\ifdim \wd\@tempboxa >\hsize%
#1: #2\par%
\else\global \@minipagefalse%
\hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
\fi\vskip\@caption@skip@below}%
\newcommand{\section}[1]{{\Large {\bfseries #1}}}%
\def\monthname{% timestamp function
\ifcase\month%
\or January\or February\or March\or April \or May\or June%
\or July\or August\or September\or October \or November\or December%
\fi%
}%
\def\timestring{%
\begingroup%
\count0 = \time \divide\count0 by 60%
\count2 = \count0 % the hour%
\count4 = \time \multiply\count0 by 60%
\advance\count4 by -\count0% the minute%
\ifnum\count4<10 \toks1 = {0} \else \toks1 = {}\fi%
\ifnum\count2<12 \toks0 = {A.M.}%
\else \toks0 = {P.M.}\advance\count2 by -12\fi%
\ifnum\count2=0 \count2 = 12 \fi % make midnight 12%
{\number\count2:\the\toks1 \number\count4%
\thinspace \the\toks0}%
\endgroup%
}%
\def\timestamp{\number\day\space\monthname\space\number\year,\space\timestring}%
\def\datestamp{\monthname\space\number\day,\space\number\year}%
\def\noheadline{\setboolean{@hl}{false}}%
\define@key{ov}{noheadline}[true]{\iffixq{#1}{\setboolean{@hl}{false}}}%
\def\nofootline{\setboolean{@fl}{false}}%
\define@key{ov}{nofootline}[true]{\iffixq{#1}{\setboolean{@fl}{false}}}%
\def\nolines{\setboolean{@fl}{false}\setboolean{@hl}{false}}%
\define@key{ov}{nolines}[true]{\iffixq{#1}{\setboolean{@fl}{false}\setboolean{@hl}{false}}}%
\def\noHeadline{\setboolean{@Hl}{false}}%
\define@key{ov}{noHeadline}[true]{\iffixq{#1}{\setboolean{@Hl}{false}}}%
\def\noFootline{\setboolean{@Fl}{false}}%
\define@key{ov}{noFootline}[true]{\iffixq{#1}{\setboolean{@Fl}{false}}}%
\def\noLines{\setboolean{@Fl}{false}\setboolean{@hl}{false}}%
\define@key{ov}{noLines}[true]{\iffixq{#1}{\setboolean{@Fl}{false}\setboolean{@Hl}{false}}}%
\def\@plhl{1}\def\nopheadline{\def\@plhl{0}}%
\def\@plfl{1}\def\nopfootline{\def\@plfl{0}}%
\def\Headlinewd#1{\setlength{\@Hrw}{#1}}%
\def\headlinewd#1{\setlength{\@hrw}{#1}}%
\def\Footlinewd#1{\setlength{\@Frw}{#1}}%
\def\footlinewd#1{\setlength{\@frw}{#1}}%
\define@key{ov}{Headlinewd}{\setlength{\@Hrw}{#1}}%
\define@key{ov}{headlinewd}{\setlength{\@hrw}{#1}}%
\define@key{ov}{Footlinewd}{\setlength{\@Frw}{#1}}%
\define@key{ov}{footlinewd}{\setlength{\@frw}{#1}}%
\fancypagestyle{ltrhead}{%
\def\ifta{0}%
\txa{Before setting up letterhead}%
\showdim{Letterhead}%
\fancyhf{}%
\txa{Current stored info: \string\@ltr@h:\@ltr@h}%
\fancyfoot[L]{\@Lfooter}%
\fancyfoot[C]{\@Cfooter}%
\fancyfoot[R]{\@Rfooter}%
\fancyhead[L]{\@Lheader \vspace*{\the\@marg@tp@a}}%
\fancyhead[C]{\@Cheader \vspace*{\the\@marg@tp@a}}%
\fancyhead[R]{\@Rheader \vspace*{\the\@marg@tp@a}}%
\showdim{Letterhead}%
\def\@lodd{\relax}%
\def\@rodd{\relax}%
\txa{After setting up letterhead}%
\def\ifta{0}%
}%
\fancypagestyle{othhead}{%
\def\ifta{0}%
\fancyhf{}%
\fancyfoot[L]{\@lfooter}%
\fancyfoot[C]{\@cfooter}%
\fancyfoot[R]{\@rfooter}%
\fancyhead[L]{\@lheader \vspace*{\the\@marg@tp@a}}%
\fancyhead[R]{\@rheader \vspace*{\the\@marg@tp@a}}%
\fancyhead[C]{\@cheader \vspace*{\the\@marg@tp@a}}%
\def\@lodd{\relax}%
\def\@rodd{\relax}%
}%
\providecommand{\@Lfooter}{}%
\providecommand{\@Cfooter}{}%
\providecommand{\@Rfooter}{}%
\providecommand{\@lfooter}{}%
\providecommand{\@cfooter}{}%
\providecommand{\@rfooter}{}%
\providecommand{\@LOfooter}{}%
\providecommand{\@COfooter}{}%
\providecommand{\@ROfooter}{}%
\providecommand{\@Lheader}{}%
\providecommand{\@Cheader}{}%
\providecommand{\@Rheader}{}%
\providecommand{\@lheader}{}%
\providecommand{\@cheader}{}%
\providecommand{\@rheader}{}%
\providecommand{\@LUheader}{}%
\providecommand{\@CUheader}{}%
\providecommand{\@RUheader}{}%
\providecommand{\@Rmarg}{}%
\providecommand{\@Lmarg}{}%
\providecommand{\@rmarg}{}%
\providecommand{\@lmarg}{}%
\def\Lfooter#1{\setboolean{@Lf@use}{true}\def\@Lfooter{#1}}%
\def\Cfooter#1{\setboolean{@Cf@use}{true}\def\@Cfooter{#1}}%
\def\Rfooter#1{\setboolean{@Rf@use}{true}\def\@Rfooter{#1}}%
\def\LOfooter#1{\setboolean{@LOf@use}{true}\def\@LOfooter{#1}}%
\def\COfooter#1{\setboolean{@COf@use}{true}\def\@COfooter{#1}}%
\def\ROfooter#1{\setboolean{@ROf@use}{true}\def\@ROfooter{#1}}%
\def\lfooter#1{\setboolean{@lf@use}{true}\def\@lfooter{#1}}%
\def\cfooter#1{\setboolean{@cf@use}{true}\def\@cfooter{#1}}%
\def\rfooter#1{\setboolean{@rf@use}{true}\def\@rfooter{#1}}%
\def\Lheader#1{\setboolean{@Lh@use}{true}\def\@Lheader{#1}}%
\def\Cheader#1{\setboolean{@Ch@use}{true}\def\@Cheader{#1}}%
\def\Rheader#1{\setboolean{@Rh@use}{true}\def\@Rheader{#1}}%
\def\LUheader#1{\setboolean{@LUh@use}{true}\def\@LUheader{#1}}%
\def\CUheader#1{\setboolean{@CUh@use}{true}\def\@CUheader{#1}}%
\def\RUheader#1{\setboolean{@RUh@use}{true}\def\@RUheader{#1}}%
\def\lheader#1{\setboolean{@lh@use}{true}\def\@lheader{#1}}%
\def\cheader#1{\setboolean{@ch@use}{true}\def\@cheader{#1}}%
\def\rheader#1{\setboolean{@rh@use}{true}\def\@rheader{#1}}%
\def\Rmargin#1{\def\@Rmarg{#1}\setboolean{@marg@Ruse}{true}}%
\def\Lmargin#1{\def\@Lmarg{#1}\setboolean{@marg@Luse}{true}}%
\def\rmargin#1{\def\@rmarg{#1}\setboolean{@marg@ruse}{true}}%
\def\lmargin#1{\def\@lmarg{#1}\setboolean{@marg@luse}{true}}%
\newcommand{\Prnt@Chk}[7]{%
  \ifthenelse{\boolean{#1}}{\ifempty{#6}{}{%
    \vspace*{-2\parskip}\vspace*{#6}}}{}%
  \ifthenelse{\boolean{#1}}%
    {\ifthenelse{\boolean{#2}}{\begin{flushleft}{#4}\end{flushleft}}%
    {\ifthenelse{\boolean{#3}}%
      {\begin{center}{#4}\end{center}}%
      {\begin{flushright}{#4}\end{flushright}}}%
    }{}%
  \ifthenelse{\boolean{#1}}{#5}{}%
  \ifthenelse{\boolean{#1}}{\ifempty{#7}{}%
    {\vspace*{-2\parskip}\vspace*{#7}}}{}%
}%
\newcommand{\fixphr}[2]{\strut & \parbox[t]{\the\@utilc}{#1} #2 \\}%
\def\ifta{0}%
\def\memosec{%
\def\ifta{0}\txa{Start of memosec}%
\noindent\ignorespaces%
\settowidth{\@utila}{{\bf \@hnfr@phr:\hspace*{1.25em}}}%
\setlength{\@utilb}{\textwidth-\@utila-.1em}%
\addtolength{\@utilb}{-5pt}%
\settowidth{\@utilc}{\@phn@phr:\hspace*{2em}}%
\settowidth{\@utild}{\@fax@phr:\hspace*{2em}}%
\ifthenelse{\lengthtest{\@utilc<\@utild}}{\setlength{\@utilc}{\the\@utild}}{}%
\settowidth{\@utild}{\@pager@phr:\hspace*{2em}}%
\ifthenelse{\lengthtest{\@utilc<\@utild}}{\setlength{\@utilc}{\the\@utild}}{}%
\settowidth{\@utild}{\@email@phr:\hspace*{2em}}%
\ifthenelse{\lengthtest{\@utilc<\@utild}}{\setlength{\@utilc}{\the\@utild}}{}%
\txa{After length tests}%
{\vspace*{-1em}\setlength{\tabcolsep}{0pt}%
\setboolean{@memo@a}{false}%
\vspace*{\@pre@memo@sp}\noindent\par%
\begin{flushleft}%
\begin{tabular}{p{\the\@utila}l}%
\ifthenelse{\boolean{@memo@g}}%
{\setboolean{@memo@a}{true}%
\strut {\bf \@hnto@phr:} & \@name@to \strut \\%
\ifthenelse{\boolean{@memo@b}}{\strut &%
\parbox[t]{\the\@utilb}{\@addr@to\strut}\strut\\}{}%
\ifthenelse{\boolean{@memo@c}}{\fixphr{\@phn@phr:}{\@phn@to}}{}%
\ifthenelse{\boolean{@memo@d}}{\fixphr{\@fax@phr:}{\@fax@to}}{}%
\ifthenelse{\boolean{@memo@n}}{\fixphr{\@pager@phr:}{\@pager@to}}{}%
\ifthenelse{\boolean{@memo@k}}{\fixphr{\@email@phr:}{\@email@to}}{}%
}{}%
\ifthenelse{\boolean{@memo@e}}%
{\setboolean{@memo@a}{true}%
\strut {\bf \@hnfr@phr:} &{\@name@fr} \strut \\%
\ifthenelse{\boolean{@memo@h}}{\strut &%
\parbox[t]{\the\@utilb}{\@addr@fr \strut} \strut \\}{}%
\ifthenelse{\boolean{@memo@i}}{\fixphr{\@phn@phr:}{\@phn@fr}}{}%
\ifthenelse{\boolean{@memo@j}}{\fixphr{\@fax@phr:}{\@fax@fr}}{}%
\ifthenelse{\boolean{@memo@m}}{\fixphr{\@pager@phr:}{\@pager@fr}}{}%
\ifthenelse{\boolean{@memo@l}}{\fixphr{\@email@phr:}{\@email@fr}}{}%
}{}%
\ifthenelse{\boolean{@memo@f}}{\setboolean{@memo@a}{true}%
\strut {\bf \@re@phr:}   &  {\@re@line} \\%
}{}%
\ifthenelse{\boolean{@dt@p}}{\strut {\bf \@date@phr:} & \@xdate \\}{}%
\ifthenelse{\boolean{@memo@a}}{\hline}{}%
\end{tabular}%
\end{flushleft}%
}%
\vspace*{\@post@memo@sp}\noindent\par%
\txa{End of memosec}
}%
\InputIfFileExists{memosec.tex}%
{\typeout{Reading {\tt memosec.tex}}}%
{\typeout{The default definition for memosec is used.  File memosec.tex doesn't exist.}}%
\newcommand{\pressbegin}{%maybe set dimensions, esp 1 inch margins, here
\settowidth{\@utila}{\@addr@fr}%
\def\ifta{0}%
\txa{Setup beginning of press release}%
\renewcommand{\headrulewidth}{0pt}\renewcommand{\footrulewidth}{0pt}%
\setboolean{@Hl}{false}\setlength{\@Hrw}{0pt}%
\setboolean{@hl}{false}\setlength{\@hrw}{0pt}%
\setboolean{@Fl}{false}\setlength{\@Frw}{0pt}%
\setboolean{@fl}{false}\setlength{\@frw}{0pt}%
\begin{flushleft}%
\rule{\textwidth}{1pt} \par \noindent%
\centerline{\LARGE \@pr@release \strut} \par\noindent%
\rule{\textwidth}{1pt} \par \noindent
\txa{After first block}
\setlength{\tabcolsep}{0pt}%
\begin{tabular}{l@{\hspace{1em}}l}%
\textbf{\@contact@phr:} & \@name@fr \strut \\%
& \parbox[t]{\@utila}{\@addr@fr  \strut } \strut \\ %%
\ifempty{\@phn@fr}{}{\textbf{\@phn@phr:} & \@phn@fr \strut \\}%
\ifempty{\@phnb@fr}{}{\textbf{\@phn@phr:} & \@phnb@fr \strut \\}%
\ifempty{\@phnc@fr}{}{\textbf{\@phn@phr:} & \@phnc@fr \strut \\}%
\ifempty{\@phnd@fr}{}{\textbf{\@phn@phr:} & \@phnd@fr \strut \\}%
\ifempty{\@fax@fr}{}{\textbf{\@fax@phr:} & \@fax@fr \strut \\}%    % maybe email, web site?
\textbf{Date:} & \@xdate%
\end{tabular}%
\end{flushleft}%
\txa{After endflushleft}
\rule{\textwidth}{1pt} \par \noindent
\centerline{\textbf{\Large \@pr@headline}} \par \noindent
\rule{\textwidth}{1pt} \par \noindent
\ifthenelse{\boolean{@space@d}}{\begin{doublespace}}{\begin{singlespace}}%
\ifthenelse{\boolean{@pr@by}}{\noindent \@pr@byline \\}{}
\noindent
\txa{end of pressbegin}
}%
\InputIfFileExists{prsrls.tex}%
  {\typeout{Reading press release page setup from prsrls.tex}}%
  {\typeout{Press release definitions stored in newlfm.cls}}%
\txa{Next part}
\newcommand*{\faxpage}{{%
\def\ifta{0}\showdim{Before setpage inside faxpage}%
\lsetpage{722pt}{6.5in}{1in}{0in}{.25in}{1in}{.75in}{.25in}{.25in}%
\showdim{After setpage}%
{\def\ifta{0}\showdim{Before fax page setup A}%
\setlength{\@utila}{\paperheight}\addtolength{\@utila}{-1in}%
\setlength{\@utilb}{\paperwidth}\addtolength{\@utilb}{-2in}%
\global\setlength{\textwidth}{\paperwidth-2in}%
\txa{\string\paperheight:\paperheight,\string\@utila:\the\@utila}%
\txa{\string\paperwidth:\paperwidth,\string\@utilb:\the\@utilb}\gdef\npind{A1}%
\@clear@box%
\def\ifta{0}%
\txa{\string\paperheight:\the\paperheight,\string\@utila:\the\@utila}%
\txa{\string\paperwidth:\the\paperwidth,\string\@utilb:\the\@utilb}%
\txa{\string\textheight:\the\textheight,\string\textwidth:\the\textwidth}%
\newpage\c@page\@ne\interlinepenalty=200%
\showdim{Before fax page setup B}%
\thispagestyle{empty}%
\vspace*{-\the\@Hgt@Head}\vspace*{.5in}%
\showdim{Inside fax page specification}%
\begin{center}%
\framebox{\Huge{\@fax@cover@line}} \\%
\vspace*{.5in} \Large{\@fax@page@count: \ref{totpage}} \\%
\vspace*{.5in} \Large{\timestamp} \\%
\end{center}%
\settowidth{\@utila}{\LARGE{\@hnto@phr:}}%
\settowidth{\@utilb}{\LARGE{\@hnfr@phr:}}%
\ifthenelse{\lengthtest{\@utila<\@utilb}}{\setlength{\@utila}{\@utilb}}{}%
\settowidth{\@utilb}{\LARGE{\@m@phr:}}%
\ifthenelse{\lengthtest{\@utila<\@utilb}}{\setlength{\@utila}{\@utilb}}{}%
\setlength{\tabcolsep}{0pt}%
\setlength{\@utilb}{\the\textwidth-\the\@utila}%
\txa{Lengths:\the\textwidth, \the\@utila, \the\@utilb}%
\begin{tabular}{p{\the\@utila}p{\the\@utilb}} \hline \\%
\LARGE{\@hnto@phr:} & \parbox[t]{\@utilb}{\@name@to \strut \\ \@addr@to \strut%
\ifempty{\@phn@to}{}{\\ \@phn@phr:\space\@phn@to \strut}%
\ifempty{\@phnb@to}{}{\\ \@phn@phr:\space\@phnb@to \strut}%
\ifempty{\@phnc@to}{}{\\ \@phn@phr:\space\@phnc@to \strut}%
\ifempty{\@phnd@to}{}{\\ \@phn@phr:\space\@phnd@to \strut}%
\ifempty{\@fax@to}{}{\\ \@fax@phr:\space\@fax@to \strut}} \vspace*{5pt} \\ \hline \vspace*{5pt}%
\LARGE{\@hnfr@phr:} & \vspace*{5pt}%
\parbox[t]{\@utilb}{\@name@fr \strut \\ \@addr@fr \strut %%
\ifempty{\@phn@fr}{}{\\ \@phn@phr:\space\@phn@fr \strut}%
\ifempty{\@phnb@fr}{}{\\ \@phn@phr:\space\@phnb@fr \strut}%
\ifempty{\@phnc@fr}{}{\\ \@phn@phr:\space\@phnc@fr \strut}%
\ifempty{\@phnd@fr}{}{\\ \@phn@phr:\space\@phnd@fr \strut}%
\ifempty{\@fax@fr}{}{\\ \@fax@phr:\space\@fax@fr \strut}} \vspace*{5pt} \\  \hline%
\vspace*{5pt}%
\strut \LARGE{\@re@phr:} & \strut%
\ifthenelse{\equal{\@re@line}{---BLANK---}}{}{\@re@line}\strut \\%
\ifempty{\@fax@mssg}{}{ \strut%
\LARGE{\@m@phr:} \strut &%
\parbox[t]{\@utilb}{\strut \@fax@mssg} \strut \\ \hline}%
\end{tabular}}%
\def\ifta{0}\showdim{End of fax page setup }%
\@dim@resetfalse%
\txa{After dimreset}%
\gdef\npind{F}%
\txa{Before newpage}%
\newpage%
\txa{After newpage}%
}}%
\InputIfFileExists{faxpage.tex}%
  {\typeout{Reading FAX page definitions from faxpage.tex}}%
  {\typeout{faxpage definitions stored in newlfm.cls}}%
\newcommand{\faxblocka}{%
\sbox{\fba}{%
\framebox[3.0in]{\parbox[b]{3.0in}{\setlength{\tabcolsep}{0pt}%
\begin{tabular}{p{1.0in}p{2in}}%
\multicolumn{2}{l}{\Large \hspace*{.25in}%
\@fax@phr{} \@doc@phr} \\ \hline%
\@hnfr@phr:\space & \@name@fr \\%
\@fax@phr:\space & \@fax@fr \\ \hline%
\@hnto@phr:\space & \@name@to \\%
\@fax@phr:\space & \@fax@to \\ \hline%
\@re@phr: & \@re@line%
\end{tabular}}}}}%
\newcommand{\faxblockb}{%
{\parbox[t]{\textwidth}{\fbox{%
\begin{tabular}{llll}%
\@hnfr@phr:\space & \@name@fr & \@hnto@phr:\space & \@name@to \\%
\@fax@phr:\space & \@fax@fr & \@fax@phr:\space & \@fax@to \\%
\@phn@phr:\space & \@phn@fr & \@phn@phr:\space & \@phn@to \\%
\@re@phr: & \multicolumn{3}{l}{\parbox[t]{2in}{\@re@line}} \\%
\end{tabular}%
}}}}%
\newcommand{\ifempty}[3]{\ifthenelse{\equal{#1}{}}{#2}{#3}}%
\newcommand{\ifpempty}[3]{\ifthenelse{\equal{\protect#1}{}}{#2}{#3}}%
\newcommand{\@prnt@sec}[1]{%  Actual printing of addresses here
\ifthenelse{#1=\@intd@pos}%
{\Prnt@Chk{@dt@p}{@dt@l}{@dt@c}{\@xdate}{}{\@dt@sk@b}{\@dt@sk@a}}{}%
\ifthenelse{#1=\@intf@pos}%
{\Prnt@Chk{@addr@fr@p}{@addr@fr@l}{@no@cen}%
{\usebox{\b@addr@fr}}{}{\@addr@fr@sk@b}{\@addr@fr@sk@a}}{}%
\ifthenelse{#1=\@intt@pos}%
{\Prnt@Chk{@addr@to@p}{@addr@to@l}{@no@cen}%
{\usebox{\b@addr@to}}{}{\@addr@to@sk@b}{\@addr@to@sk@a}}{}%
}%
\newcommand*{\openlfm}{%
\def\ifta{0}%
\ifthenelse{\boolean{@use@water}}%
{\ClearShipoutPicture%
\AddToShipoutPicture{\includegraphics[natheight=11in,natwidth=8.5in]{\@water@page}}%
}{}%
\ifthenelse{\boolean{@marg@Ruse}}%             Here we set up right-side marginal notes
{\setlength{\@utile}{-\@Hgt@Head+\@marg@rt@tp@d}% Adjust column top to leftmargintopdist
\normalmarginpar%
\marginpar{\vspace*{\the\@utile} \hspace*{\@marg@rt@l}\hspace*{-\marginparsep} \@Rmarg}}{}%
\ifthenelse{\boolean{@marg@Luse}}%             Here we set up left-side marginal notes
{\setlength{\@utile}{-\@Hgt@Head+\@marg@lt@tp@d}% Adjust column top to leftmargintopdist
\reversemarginpar\txa{Left margin}%
\marginpar{\vspace*{\the\@utile} \hspace*{\@marg@lt@l} \@Lmarg}}{}%
\ifpempty{\@LUheader}{}{\@LUheader \hfill}%
\ifpempty{\@CUheader}{}{\hfill \@CUheader \hfill}%
\ifpempty{\@RUheader}{}{\hfill \@RUheader}%
\txa{Running memosec}%                         Memo processing
\ifthenelse{\boolean{@memo@bl}}%
{{\memosec}\setboolean{@dt@p}{false}%
\setboolean{@no@spc}{true}}% %Memo
{}%
\txa{Running pressbegin}%
\ifthenelse{\boolean{@pr@p}}%
{\pressbegin%                                Press release processing
\txa{here we go again - out of pressbegin}
\setboolean{@no@spc}{true}}{}% % Press Release
\sbox{\b@addr@fr}{\noindent\setlength{\tabcolsep}{0pt}% Address-from into a box
\raggedleft\begin{tabular}{l@{}}%
\noindent\ignorespaces\@addr@fr%
\ifthenelse{\boolean{@addr@fr@t}}{\\ \@phn@phr: \@phn@fr}{}%
\ifthenelse{\boolean{@addr@fr@f}}{\\ \@fax@phr: \@fax@fr}{}%
\ifthenelse{\boolean{@addr@fr@e}}{\\ \@email@phr: \@email@fr}{}%
\end{tabular}}%
\settowidth{\@utilc}{\usebox{\b@addr@fr}}%
\sbox{\b@addr@fr}{\noindent\setlength{\tabcolsep}{0pt}%
\parbox[t]{\@utilc}{\noindent%
\begin{tabular}{l@{}}%
\ignorespaces\@addr@fr%
\ifthenelse{\boolean{@addr@fr@t}}{\\ \@phn@phr: \@phn@fr}{}%
\ifthenelse{\boolean{@addr@fr@f}}{\\ \@fax@phr: \@fax@fr}{}%
\ifthenelse{\boolean{@addr@fr@e}}{\\ \@email@phr: \@email@fr}{}%
\end{tabular}}}%
\sbox{\b@addr@to}{\noindent\setlength{\tabcolsep}{0pt}%Address-to into a box
\raggedleft\begin{tabular}{l@{}}%
\noindent\ignorespaces\@name@to \strut \\ \@addr@to%
\ifthenelse{\boolean{@addr@to@t}}{\\ \@phn@phr: \@phn@to}{}%
\ifthenelse{\boolean{@addr@to@f}}{\\ \@fax@phr: \@fax@to}{}%
\ifthenelse{\boolean{@addr@to@e}}{\\ \@email@phr: \@email@to}{}%
\end{tabular}}%
\settowidth{\@utild}{\usebox{\b@addr@to}}%
\sbox{\b@addr@to}{\noindent\setlength{\tabcolsep}{0pt}%
\parbox[t]{\@utild}{\noindent%
\begin{tabular}{l@{}}%
\ignorespaces\@name@to \strut \\ \@addr@to%
\ifthenelse{\boolean{@addr@to@t}}{\\ \@phn@phr: \@phn@to}{}%
\ifthenelse{\boolean{@addr@to@f}}{\\ \@fax@phr: \@fax@to}{}%
\ifthenelse{\boolean{@addr@to@e}}{\\ \@email@phr: \@email@to}{}%
\end{tabular}}}%
\ifthenelse{\boolean{@no@spc}}{}{%
\ifthenelse{\boolean{@s@b@s}}{\par\noindent{\usebox{\b@addr@to} \hfill \usebox{\b@addr@fr}}}{}%
\setcounter{@c@pos}{1} \@prnt@sec{\the@c@pos}%  Print from and to addresses and date
\setcounter{@c@pos}{2} \@prnt@sec{\the@c@pos}%
\setcounter{@c@pos}{3} \@prnt@sec{\the@c@pos}%
\setboolean{@greet@l}{true}%
\ifthenelse{\boolean{@pt@regard}}{\@regard@phr: \@regard@line}{}%
\Prnt@Chk{@greet@p}{@greet@l}{@no@cen}%
{\par\@greet@to\par\nobreak}{}{}{\@greet@to@sk@a}%
}%
\txa{End of openlfm}%
}%
\def\ifta{0}
\def\@fix@one@box{%
\settowidth{\@utila}{\setlength{\tabcolsep}{0pt}%
\begin{tabular}{l}%
\hspace*{1pt}%
\vspace*{\@cls@sk@b} \\%
\ifthenelse{\boolean{@use@close}}{{\@closeline}\\}{}%
\vspace*{\@cls@sk@a} \\%
\ifthenelse{\boolean{@use@sig}}%
{{\@sig@fr}\\}{\parbox[t][\the\@sig@sp][t]{.1pt}{\vspace*{\@sig@sp}}\\}%
\ifthenelse{\boolean{@use@sig@nm}}{\@sig@nm\\}{\@name@fr\\}%
\end{tabular}%
}%
\sbox{\@sig@box@b} {\begin{tabular}{p{\the\@utila}}%
\hspace*{1pt}\vspace*{\@cls@sk@b} \\%
\ifthenelse{\boolean{@use@close}}{{\@closeline}\\}{}%
\vspace*{\@cls@sk@a} \\%
\ifthenelse{\boolean{@use@sig}}%
{{\@sig@fr}\\}{\parbox[t][\the\@sig@sp][t]{.1pt}{\vspace*{\@sig@sp}}\\}%
\ifthenelse{\boolean{@use@sig@nm}}{\@sig@nm\\}{\@name@fr\\}%
\end{tabular}}}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\closlfm{\def\ifta{0}\txa{In closlfm}%
\setlength{\@utila}{\@sig@sk@b}\addtolength{\@utila}{-1.5\baselineskip}%
\vspace*{\the\@utila}\noindent\setlength{\tabcolsep}{0pt}%
\ifthenelse{\boolean{@pr@p}}%
{\medskip\begin{center}\@PRend@phr\end{center}%
\markboth{}{}%
}% markboth mechanism resets center footer
{}% note require {} to finish ifthenelse
%%%%%
\ifthenelse{\boolean{@mult@sig}}%
{%\begin{flushleft}%
\ifthenelse{\equal{\the@sig@tot}{1}}{\def\@sig@tab{l}}{}% Set multiple columns
\ifthenelse{\equal{\the@sig@tot}{2}}{\def\@sig@tab{ll}}{}%
\ifthenelse{\equal{\the@sig@tot}{3}}{\def\@sig@tab{lll}}{}%
\ifthenelse{\equal{\the@sig@tot}{4}}{\def\@sig@tab{llll}}{}%
\setlength{\@utilb}{0pt}\setlength{\@utila}{0pt}% Reset counters to 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@for\@one@sig:=\@sig@list\do%
{\setboolean{@use@sig}{false}\setboolean{@use@close}{false}%
\setboolean{@use@sig@nm}{false}%
\expandafter\csname sig\@one@sig\endcsname%
\@fix@one@box\settowidth{\@utild}{\usebox{\@sig@box@b}}%
\ifthenelse{\lengthtest{\@utila<\@utild}}{\setlength{\@utila}{\@utild}}{}%
\settoheight{\@utilc}{\usebox{\@sig@box@b}}\settodepth{\@utild}{\usebox{\@sig@box@b}}%
\addtolength{\@utilc}{\@utild}% Find total depth
\ifthenelse{\lengthtest{\@utilb<\@utilc}}{\setlength{\@utilb}{\@utilc}}{}}%
\setcounter{@lab@cnt@col}{0}%
\setlength{\@utile}{0pt}% Set up for number signatures across
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\@for\@one@sig:=\@sig@list\do% Loop thru signature abbreviations
{\setboolean{@use@sig}{false}\setboolean{@use@close}{false}%
\setboolean{@use@sig@nm}{false}%
\txa{\the\@utile}%
\ifthenelse{\equal{\the@lab@cnt@col}{0}}{~\vspace*{\the\@utile}\\\noindent}{}%
\expandafter\csname sig\@one@sig\endcsname%
\ignorespaces \@fix@one@box\settoheight{\@utilc}{\usebox{\@sig@box@b}}%
\settodepth{\@utild}{\usebox{\@sig@box@b}}\addtolength{\@utilc}{\@utild}%
\ifthenelse{\equal{\the@sig@tot}{1}}{\setlength{\@utilb}{\@utilc}}{}%
\addtolength{\@utilc}{-\@utilb}%
\raisebox{-\the\@utilc/2}{\parbox[t]{\the\@utila}{\usebox{\@sig@box@b}}}%
\addtocounter{@lab@cnt@col}{1}%
\ifthenelse{\equal{\the@lab@cnt@col}{\the@sig@tot}}%
{\txa{else condition}%
\setcounter{@lab@cnt@col}{0}\setlength{\@utile}{\@sig@sk@r}}{\hspace*{\the\@sig@sk@c}}}%
\vspace*{\the\@sig@sk@a}%\end{flushleft}
}%
{% Print normal signature
\def\ifta{0}
\@fix@one@box\settowidth{\@utila}{\usebox{\@sig@box@b}}% Set up box, measure
\ifthenelse{\boolean{@sig@l}}{\txa{@sig@l:true}}{\txa{@sig@l:false}}
\ifthenelse{\boolean{@sig@c}}{\txa{@sig@c:true}}{\txa{@sig@c:false}}
\Prnt@Chk{@sig@p}{@sig@l}{@sig@c}%
{\parbox{\@utila}{\usebox{\@sig@box@b}}}{}{\@cls@sk@b}{\@sig@sk@a}}%
\ifthenelse{\boolean{@resta@l}}{\newpage\usebox{\@resta@ltr}}{}%
\ifthenelse{\boolean{@restb@l}}{\newpage\usebox{\@restb@ltr}}{}%
\ifthenelse{\boolean{@restc@l}}{\newpage\usebox{\@restc@ltr}}{}%
\ifthenelse{\boolean{@restd@l}}{\newpage\usebox{\@restd@ltr}}{}%
\ifthenelse{\boolean{@reste@l}}{\newpage\usebox{\@reste@ltr}}{}%
}%
\def\@post@sig@bl#1#2#3{%
\setlength{\@utilb}{\textwidth}%
\settowidth{\@utila}{{\small\normalfont #1: }}%
\addtolength{\@utilb}{-\@utila}%
\ifthenelse{\equal{#2}{#3}}{}{%
\vspace*{\the\@post@sig@sp@b} \hspace*{-.01pt} \\ \noindent%
\parbox[t]{\textwidth}{\@hangfrom{{\small\normalfont #1: }}%
\ignorespaces \parbox[t]{\@utilb}{{\small#2}}\strut}\par%
\vspace*{\the\@post@sig@sp@a}%
}}%
\newif \if@read@one \@read@onetrue%
\def\@ltr@info@name{letrinfo.tex}%
\define@key{ov}{InfoFileName}{\def\@ltr@info@name{#1}}%
\InputIfFileExists{\@ltr@info@name}%
{\typeout{Reading default letter definitions from \@ltr@info@name}}%
{\typeout{\@ltr@info@name\ not found.  All letter definitions must be in newlfm.cls}}%
\gdef\npind{0}%
\def\ltrbody#1{\protect\def\@ltr@body{#1}}%
\DeclareRobustCommand{\letterbody}[1]{\def\@ltr@body{#1}}%
\DeclareRobustCommand*{\doltr}[1]%
{#1 \begin{newlfm} \@ltr@body \end{newlfm} \gdef\npind{B} % \newpage%
\ifthenelse{\boolean{@env@open}}{}{}}%
\DeclareRobustCommand*{\@env@label}[1]{#1\parbox[t][\@lab@bh][t]{\@lab@bw}%
{{\@name@to \\ \@addr@to} \hfill}}%
\DeclareRobustCommand*{\@env@oth}[2]{%
\txa{box height:\the\@lab@bh, box width:\the\@lab@bw, between: \the\tabcolsep}%
\parbox[t][\@lab@bh][t]{\@lab@bw}{\@lab@size \strut #1 \\ #2 \strut}}%
\DeclareRobustCommand*{\@env@row}[4]{\settowidth{\@utila}{\@hnfr@phr:}%
\setlength{\tabcolsep}{0pt}%
\fbox{\parbox[t][\@lab@bh][t]{\@lab@bw}{%
\@lab@size \begin{tabular}{ll}{\Large\@hnfr@phr:}&{\Large\@hnto@phr:}\\%
\parbox[t]{2.0in}{#3\\#4}&\parbox[t]{2.0in}{#1\\#2}%
\end{tabular}\hfill}}}%
\DeclareRobustCommand*{\@env@col}[4]{\parbox[t][\@lab@bh][t]{\@lab@bw}{%
{\@lab@size{\Large\@hnfr@phr:}\\#3\\#4\\{\Large\@hnto@phr:}\\#1\\#2}}}%
\DeclareRobustCommand*{\x@env@col}[4]{\parbox[t][\@lab@bh][t]{\@lab@bw}{%
{\@lab@size\begin{tabular}{p{.5in}p{3.25in}}{\Large\@hnfr@phr:}&#3\\&\parbox[t]{3.25in}{#4}%
\vspace*{10pt}\\{\Large\@hnto@phr:}&#1\\&\parbox[t]{3.25in}{#2}\\\end{tabular}}}}%
\def\multletter#1{\@for\@addr@x:=#1\do{{\oneletter{\@addr@x}}}}%
\def\doletter#1{\setadrto{#1}\txa{ZA}%
\begin{newlfm}\@ltr@body\end{newlfm}\gdef\npind{D}\newpage}%
\def\oneletter#1{\txa{In oneletter}\setadrto{\csname adr#1\endcsname}\txa{ZB}\addrt{#1}%
\begin{newlfm}\@ltr@body\end{newlfm}\gdef\npind{E}}%
\DeclareRobustCommand*{\@env@ext}[1]{\txa{#1:1}%
\setadrto{\csname adr#1\endcsname}\txa{ZC}\txa{#1:2}%
\@env@oth{\@name@to}{\@addr@to}\txa{#1:3}}%
\def\clearall{\def\@ltr@h{}\def\@adr@t{}\def\@adr@f{}\def\@sig@b{}%
\setboolean{@ov@t}{false}\setboolean{@ov@f}{false}
\setboolean{@ov@s}{false}\setboolean{@ov@l}{false}}%
\def\makeenvst{}%
\def\makeenvfn{%
\def\ifta{0}%
\ClearShipoutPicture%
\nolines\dateset{}\clearall\noheadline\noHeadline\@dim@resetfalse
\setboolean{@Hl}{false}\setlength{\@Hrw}{0pt}%
\setboolean{@hl}{false}\setlength{\@hrw}{0pt}%
\setboolean{@Fl}{false}\setlength{\@Frw}{0pt}%
\setboolean{@fl}{false}\setlength{\@frw}{0pt}%
\@clear@box%
\def\headrulewidth{0pt}%
\def\footrulewidth{0pt}%
\setboolean{@ov@a}{false}\setboolean{@fax@RA}{false}%
\setboolean{@fax@RU}{false}\setboolean{@fax@hdr@pg}{false}%
\setboolean{@no@spc}{true}\setboolean{@B@f}{false}%
\setboolean{@B@h}{false}\setboolean{@B@l}{false}%
\setboolean{@B@r}{false}\setboolean{@b@f}{false}%
\setboolean{@b@h}{false}\setboolean{@b@l}{false}%
\setboolean{@b@r}{false}\setboolean{@sig@p}{false}%
\setboolean{@sig@mp}{false}\setboolean{@env@open}{false}%
\ifthenelse{\lengthtest{\@lab@th<12pt}}{\setlength{\@lab@th}{12.1pt}}{}%
\ifthenelse{\boolean{@use@envlab}}{%
\def\ifta{0}%
\setpage{11in}{8.5in}{-1in}{72pt}{0in}{-1in}{120pt}{0in}{20pt}%
\txa{use@envlab true}%
}%
{%
\gdef\npind{A3}%
\setpage{\@lab@pl}{8.5in}{-1in}{\@lab@lm}{0in}{-1in}{\@lab@th}{0in}{20pt}%
\txa{use@envlab false}%
\txa{headheight:\the\@lab@th}%
}%
\setboolean{@in@makeenv}{true}%
\begin{newlfm}\pagestyle{empty}\thispagestyle{empty}%
\def\ifta{0}%
\showdim{Start of makeenvfn}%
\@nlfm@util=0%
\setcounter{@lab@cnt@col}{0} \setcounter{@lab@cnt@row}{0}%
\setboolean{@env@open}{true} \setboolean{@env@close}{true}%
\setboolean{@ztila}{false}%
\def\ifta{0}%
\txa{Count:\number\@nlfm@addr,Test:\number\@nlfm@util}%
\setboolean{@do@any}{false}%
\loop \ifnum\number\@nlfm@util<\number\@nlfm@addr%
\global\advance\@nlfm@util by1%
\txa{Loop S Count: \number\@nlfm@util}%
\setboolean{@do@any}{true}%
\def\@onet{\csname @aadr@t\number\@nlfm@util\endcsname}%
\def\@onef{\csname @aadr@f\number\@nlfm@util\endcsname}%
\txa{\string\@onet:\@onet -- \string\@onef:\@onef}
\protect\setadrto{\csname adr\@onet\endcsname}\txa{ZD}%
\protect\setadrfr{\csname adr\@onef\endcsname}%
\def\ifta{0}%
\txa{To: adr\@onet,\@name@to --- From: \@name@fr,adr\@onef --- Just:\@tab@just}%
\txa{@aadr@t\number\@nlfm@util: \csname @aadr@t\number\@nlfm@util\endcsname}%
\ifthenelse{\boolean{@env@open}}%
{\setcounter{@lab@cnt@row}{0}\txa{New page}%
\setboolean{@env@open}{false} \setboolean{@env@close}{true}%
\def\ifta{0}%
\showdim{Checking values before newpage}%
\gdef\npind{C}%
\ifthenelse{\boolean{@ztila}}{\newpage}{}%
\setboolean{@ztila}{true}%
\showdim{Checking values after newpage}%
\def\ifta{0}%
\setlength{\tabcolsep}{\@lab@bl} \begin{table}[t] \begin{tabular}{\@tab@just}%
\txa{Starting table}%
}%
{}%
\ifthenelse{\boolean{@lab@t}}%
{\txa{Label to only}\@env@oth{\@name@to}{\@addr@to}}{}%
\ifthenelse{\boolean{@lab@rft}}%
{\txa{Label row from to}\@env@row{\@name@to}{\@addr@to}{\@name@fr}{\@addr@fr}}{}%
\ifthenelse{\boolean{@lab@cft}}%
{\txa{Label col from to}\@env@col{\@name@to}{\@addr@to}{\@name@fr}{\@addr@fr}}{}%
\addtocounter{@lab@cnt@col}{1}%
\ifthenelse{\equal{\the@lab@cnt@col}{\the@lab@tot@col}}%
{\addtocounter{@lab@cnt@row}{1}\setcounter{@lab@cnt@col}{0}%
\txa{Ending row}\\}%
{\txa{Ending column}&}%
\ifthenelse{\equal{\the@lab@cnt@row}{\the@lab@tot@row}}%
{\setcounter{@lab@cnt@row}{0}\setcounter{@lab@cnt@col}{0}%
\txa{Ending table}\\ \end{tabular}\end{table}%
\setboolean{@env@close}{false} \setboolean{@env@open}{true}%
}%
{}%
\def\ifta{0}%
\txa{Loop E Count: \number\@nlfm@util}%
\repeat%
\txa{Ending table}%
\txa{Out of big loop: \arabic{@lab@cnt@col}}%
\def\ifta{0}%
\global\@nlfm@uta=\value{@lab@cnt@row}%
\sbox{\@x@l}{\phantom{A}}
\ifthenelse{\boolean{@env@close} \and \boolean{@do@any}}
{\txa{\the@lab@cnt@col, \the@lab@cnt@row, \the@lab@tot@row}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\equal{\arabic{@lab@cnt@col}}{0}}{}%
{\whiledo{\the@lab@cnt@col<\the@lab@tot@col}%
{\@env@oth{\usebox{\@x@l}}{\usebox{\@x@l}}%
\addtocounter{@lab@cnt@col}{1}%
\ifthenelse{\the@lab@cnt@col<\the@lab@tot@col}{&}{}} \\%
\addtocounter{@lab@cnt@row}{1}
}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\whiledo{\the@lab@cnt@row<\the@lab@tot@row}%
{\setcounter{@lab@cnt@col}{0}%
\whiledo{\the@lab@cnt@col<\the@lab@tot@col}%
{\@env@oth{\usebox{\@x@l}}{\usebox{\@x@l}}%
\addtocounter{@lab@cnt@col}{1}%
\ifthenelse{\the@lab@cnt@col<\the@lab@tot@col}{&}{\\}
}%
\addtocounter{@lab@cnt@row}{1}%
\ifthenelse{\the@lab@cnt@row<\the@lab@tot@row}
{}%
{\\ \end{tabular}\end{table} \newpage%
\showdim{At the end of the table}}%
\setboolean{@env@close}{false}%
\setboolean{@env@open}{true}%
}%
}%
{}%
\setboolean{@use@envlab}{false}%
\end{newlfm}%
\def\ifta{0}%
}%

\newcommand{\@zfancyvbox}[2]{
\gdef\@zpqutil{1pt}
\setbox0\vbox{#2}\ifdim\ht0>#1
\setlength{\@utill}{\the\ht0}
\addtolength{\@utill}{-#1}
\addtolength{\@utill}{5.0pt}
\txa{utill:\the\@utill}
\xdef\@zpqutil{\the\@utill}
\txa{@zpqutil:\@zpqutil}
\fi
}
\newcommand{\@zfancyhead}[5]{#1\hbox to\headwidth{\fancy@reset
  \@zfancyvbox\headheight{\hbox
    {\rlap{\parbox[b]{\headwidth}{\raggedright#2}}\hfill
      \parbox[b]{\headwidth}{\centering#3}\hfill
      \llap{\parbox[b]{\headwidth}{\raggedleft#4}}}\zheadrule}}#5}

\newcommand{\@zfancyfoot}[5]{#1\hbox to\headwidth{\fancy@reset
    \@zfancyvbox\footskip{\zfootrule
      \hbox{\rlap{\parbox[t]{\headwidth}{\raggedright#2}}\hfill
        \parbox[t]{\headwidth}{\centering#3}\hfill
        \llap{\parbox[t]{\headwidth}{\raggedleft#4}}}}}#5}

\newcommand{\zheadrule}{{\if@fancyplain\let\headrulewidth\plainheadrulewidth\fi
    \hrule\@height\headrulewidth\@width\headwidth \vskip-\headrulewidth}}

\newcommand{\zfootrule}{{\if@fancyplain\let\footrulewidth\plainfootrulewidth\fi
    \vskip-\footruleskip\vskip-\footrulewidth
    \hrule\@width\headwidth\@height\footrulewidth\vskip\footruleskip}}

\newenvironment{newlfm}{% Start of fax environment, in fax class%
\if@read@one \global\@read@onefalse \fi%
\def\ifta{0}\txa{Start of newlfm startup}%
\ifthenelse{\boolean{@ov@a}}{\txa{oa: t}}{\txa{oa: f}}%
\ifthenelse{\boolean{@ov@t}}{\txa{ot: t}}{\txa{ot: f}}%
\ifthenelse{\boolean{@ov@f}}{\txa{of: t}}{\txa{of: f}}%
\ifthenelse{\boolean{@ov@l}}{\txa{ol: t}}{\txa{ol: f}}%
\ifthenelse{\boolean{@ov@s}}{\txa{os: t}}{\txa{os: f}}%
\txa{nameto: \@name@to}%
\txa{namefrom: \@name@fr}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Begin with fax cover page
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\ifthenelse{\boolean{@ov@a}}{\faxblocka}{}%
\ifthenelse{\boolean{@fax@RA}}%
{\ifthenelse{\boolean{@fax@bla}}{\Rheader{\usebox{\fba}}}{}%
\ifthenelse{\boolean{@fax@blb}}{\Rheader{\faxblockb}}{}}{}%
\ifthenelse{\boolean{@fax@RU}}%
{\txa{setting up ruh}%
\ifthenelse{\boolean{@fax@bla}}{\RUheader{\faxblocka}}{}%
\ifthenelse{\boolean{@fax@blb}}{\RUheader{\faxblockb}}{}}{}%
\ifthenelse{\boolean{@ov@a}}{%
\ifthenelse{\boolean{@ov@l}}{\expandafter\csname lth\@ltr@h \endcsname}{}%
\ifthenelse{\boolean{@ov@t}}{\setadrto{\expandafter\csname adr\@adr@t \endcsname}}{}%
\ifthenelse{\boolean{@ov@f}}{\setadrfr{\expandafter\csname adr\@adr@f \endcsname}}{}%
\ifthenelse{\boolean{@ov@s}}{\expandafter\csname sig\@sig@b \endcsname}{}%
\@set@em@up
}{}%
\txa{setting up ruh}%
\def\ifta{0}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\txa{name@to:\@name@to}%
\ifthenelse{\boolean{@ov@t}}{\txa{oversetto:true}}{\txa{oversetto:false}}%
\txa{name@fr:\@name@fr}%
\ifthenelse{\boolean{@ov@f}}{\txa{oversetfr:true}}{\txa{oversetfr:false}}%
\retdims%
\ifthenelse{\boolean{@fax@hdr@pg}}%
{{\txa{FAX Page Setup}%
\def\ifta{0}%
\showdim{Before resetting dimensions for fax}%
\faxpage%
\def\ifta{0}%
\showdim{After resetting dimensions for fax}%
\showdim{After restoring dimensions for fax}%
\txa{Before newpage issued}%
\txa{After newpage issued}%
\showdim{After fax page setup}%
}}{}%
\rstdims%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ifta{0}\showdim{After fax page section closes}\gdef\npind{G}%
\if@twoside \ifodd\c@page%
\else\thispagestyle{empty}\null\newpage\fi  \fi%
\c@page\@ne%
\interlinepenalty=200 % smaller than the TeXbook value%
\setlength{\headwidth}{\textwidth}%
\txa{Before Rfooter}\ifthenelse{\boolean{@B@f}}%
{\Cfooter{\phantom{\Cfooter}} \Rfooter{\phantom{\Rfooter}} \Lfooter{\phantom{\Lfooter}}} {}%
\txa{Before Rheader}\ifthenelse{\boolean{@B@h}}%
{\Rheader{\phantom{\Rheader}} \Lheader{\phantom{\Lheader}} \Cheader{\phantom{\Cheader}}} {}%
\txa{Before Lmargin}\ifthenelse{\boolean{@B@l}}%
{\ifempty{\@Lmarg}{}{\Lmargin{\phantom{\Lmargin}}}}{}%
\txa{Before Rmargin}\ifthenelse{\boolean{@B@r}}%
{\ifempty{\@Rmarg}{}{\Rmargin{\phantom{\Rmargin}}}}{}%
\txa{Before rfooter}\ifthenelse{\boolean{@b@f}}%
{\rfooter{\phantom{\rfooter}} \lfooter{\phantom{\lfooter}} \cfooter{\phantom{\cfooter}}} {}%
\txa{Before rheader}\ifthenelse{\boolean{@b@h}}%
{\rheader{\phantom{\rheader}} \lheader{\phantom{\lheader}} \cheader{\phantom{\cheader}}} {}%
\txa{Before lmargin}\ifthenelse{\boolean{@b@l}}%
{\lmargin{\phantom{\lmargin}}} {}%
\txa{Before rmargin}\ifthenelse{\boolean{@b@r}}%
{\rmargin{\phantom{\rmargin}}} {}%
\setlength{\textwidth}{\paperwidth-\@marg@rt-\@marg@lt-1pt}%
\txa{Before opening}%
\txa{\string\@marg@rt: \the\@marg@rt, \string\@marg@rt: \the\@marg@rt}%
\txa{\string\textwidth: \the\textwidth, \string\paperwidth: \the\paperwidth}%
\openlfm%
\def\ifta{0}%
\txa{nameto:\@name@to}%
\txa{namefr:\@name@fr}%
\txa{\string\@marg@rt: \the\@marg@rt, \string\@marg@rt: \the\@marg@rt}%
\txa{\string\textwidth: \the\textwidth, \string\paperwidth: \the\paperwidth}%
\txa{After opening}%
\def\ifta{0}%
\txa{\string\@marg@rt: \the\@marg@rt, \string\@marg@rt: \the\@marg@rt}%
\txa{\string\textwidth: \the\textwidth, \string\paperwidth: \the\paperwidth}%
\txa{Before pagestyle}%
\pagestyle{othhead}\thispagestyle{ltrhead}%
\def\ifta{0}%
\txa{After pagestyle}%
\ifthenelse{\boolean{@in@makeenv}}{\txa{makeenv true}}{\txa{makeenv false}%
\global\advance \@nlfm@addr by1%
\txa{Count: \number\@nlfm@addr -- To: \@adr@t -- From: \@adr@f}%
\expandafter\xdef\csname @aadr@t\number\@nlfm@addr\endcsname{\@adr@t}%
\expandafter\xdef\csname @aadr@f\number\@nlfm@addr\endcsname{\@adr@f}%
\txa{Count: \number\@nlfm@addr -- To: \@adr@t -- From: \@adr@f}
\txa{@aadr@t\number\@nlfm@addr: \csname @aadr@t\number\@nlfm@addr\endcsname}%
\txa{To:  \csname @aadr@t\number\@nlfm@addr\endcsname,\@adr@t}%
}%
\showdim{Dimensions at end of newlfm startup section}\def\ifta{0}%
}%
{% Here we are at the processing of the close of the newlfm env
\def\ifta{0}\txa{At the start of the close of newlfm env}%
\ifthenelse{\boolean{@pr@p}}{\closlfm}{}%
\ifthenelse{\boolean{@sig@p}}%
{\txa{Before closing}%
\ifthenelse{\boolean{@pr@p}}{}{\closlfm}%
\txa{After closing}%
\showdim{Current Dimensions}%
\@post@sig@bl{\@ps@phr}{\@ps@item}{---BLANK---}%
\@post@sig@bl{\@pps@phr}{\@pps@item}{---BLANK---}%
\@post@sig@bl{\@ppps@phr}{\@ppps@item}{---BLANK---}%
\@post@sig@bl{\@encl@phr}{\@encl@item}{---BLANK---}%
\@post@sig@bl{\@cc@phr}{\@cc@item}{---BLANK---}}{}%
\ifthenelse{\boolean{@sig@mp}}{%
\@post@sig@bl{\@ps@phr}{\@ps@item}{---BLANK---}%
\@post@sig@bl{\@pps@phr}{\@pps@item}{---BLANK---}%
\@post@sig@bl{\@ppps@phr}{\@ppps@item}{---BLANK---}%
\@post@sig@bl{\@encl@phr}{\@encl@item}{---BLANK---}%
\@post@sig@bl{\@cc@phr}{\@cc@item}{---BLANK---}}{}%
\ifthenelse{\boolean{@env@open}}{}{}%
\txa{Before the pagebreak}%
\gdef\npind{J}%
\stopletter\@@par\pagebreak\@@par%
\immediate\write\@auxout{\string\newlabel{totpage}{{\thepage}{0}}}%
\@clear@box%
\global\@read@onetrue%
\setboolean{@s@b@s}{false}%
\ifthenelse{\boolean{@pr@p}}{%
\ifthenelse{\boolean{@space@d}}{\end{doublespace}}{\end{singlespace}}%
}{}%
}%
\def\@make@big@env{%
\@nlfm@util=0%
\def\ifta{0}%
\txa{In @make@big@env}%
\txa{Count: \number\@nlfm@addr}%
\txa{ZI}%
\txa{@aadr@t\number\@nlfm@addr: \csname @aadr@t\number\@nlfm@addr\endcsname}%
\txa{To:  \csname @aadr@t\number\@nlfm@addr\endcsname,\@adr@t}%
\loop \ifnum\@nlfm@util < \@nlfm@addr%
\advance\@nlfm@util by1%
\def\@onet{\expandafter\csname @aadr@t\number\@nlfm@util\endcsname}%
\def\@onef{\expandafter\csname @aadr@f\number\@nlfm@util\endcsname}%
\setadrto{\expandafter\csname adr\@onet\endcsname}\txa{ZF}%
\setadrfr{\expandafter\csname adr\@onef\endcsname}%
\gdef\npind{I}%
\newpage%
\def\ifta{0}%
\gdef\npind{A4}%
\setpage{11in}{8.5in}{1in}{1in}{0pt}{0in}{120in}{0in}{0in}%
\txa{Actually using the makeenvelope...}%
\startlabels%
\@capitalizeaddressfalse%
\txa{From: \@name@fr}%
\txa{To: \@name@to}%
\mlabel{\@name@fr \hspace*{.1pt} \\ \@addr@fr \hspace*{.1pt}}%
{\@name@to \hspace*{.1pt} \\ \@addr@to \hspace*{.1pt}}%
\txa{From: \@name@fr}%
\txa{To: \@name@to}%
\repeat%
\global\@nlfm@addr=0%
\txa{Count at end: \number\@nlfm@addr}%
}%
\def\@clear@box{%
\Background{}\background{}\Lfooter{}\Cfooter{}\Rfooter{}\LOfooter{}%
\COfooter{}\ROfooter{}\lfooter{}\cfooter{}\rfooter{}\Lheader{}%
\Cheader{}\Rheader{}\LUheader{}\CUheader{}\RUheader{}\lheader{}%
\cheader{}\rheader{}\Rmargin{}\Lmargin{}\rmargin{}\lmargin{}%
}%
\newcommand{\pgrph}[1]{{\bf #1}}%
\pagestyle{ltrhead}%
\pagenumbering{arabic}%
\raggedbottom%
\providecommand{\@texttop}{}%
\DeclareRobustCommand*{\@texttop}
{\ifnum\c@page=1\vskip \z@ plus.00006fil\relax\fi}%
\onecolumn%
\def\@set@em@up{%
\txa{Real start}%
\ifthenelse{\boolean{@pr@p}}{%
\PhrMore{\thepage\ of \pageref{LastPage}}
\Cfooter{\@more@phr}\cfooter{\@more@phr}%
}{}%
\def\ifta{0}\txa{Start of @set@em@up}%
\ifthenelse{\boolean{@set@env}}{\makeenvst\txa{Making envelope}}{}%
\ifthenelse{\boolean{@Hl}}%
{\def\headrulewidth{\the\@Hrw}}%
{\setlength{\@Hrw}{0pt}\def\headrulewidth{0pt}}%
\ifthenelse{\boolean{@Fl}}%
{\def\footrulewidth{\the\@Frw}}%
{\setlength{\@Frw}{0pt}\def\footrulewidth{0pt}}%
\def\ifta{0}\txa{Here in the middle}%
\settowidth{\@utili}{\@Lheader}%
\settowidth{\@utilj}{\@Cheader}%
\settowidth{\@utilk}{\@Rheader}%
\begin{lrbox}{\@x@l}\begin{minipage}{\@utili}\@Lheader\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@c}\begin{minipage}{\@utilj}\@Cheader\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@r}\begin{minipage}{\@utilk}\@Rheader\end{minipage}\end{lrbox}%
\ifthenelse{\boolean{@Ch@use}}%
{\settoheight{\@Hgt@H@C}{\strut\usebox{\@x@c}\strut}\settodepth{\@Dth@H@C}{\strut\usebox{\@x@c}\strut}%
\addtolength{\@Hgt@H@C}{\@Dth@H@C}}{\setlength{\@Hgt@H@C}{0pt}\setlength{\@Dth@H@C}{0pt}}%
\ifthenelse{\boolean{@Rh@use}}%
{\settoheight{\@Hgt@H@R}{\strut\usebox{\@x@r}\strut}\settodepth{\@Dth@H@R}{\strut\usebox{\@x@r}\strut}%
\addtolength{\@Hgt@H@R}{\@Dth@H@R}}{\setlength{\@Hgt@H@R}{0pt}\setlength{\@Dth@H@R}{0pt}}%
\ifthenelse{\boolean{@Lh@use}}%
{\settoheight{\@Hgt@H@L}{\strut\usebox{\@x@l}\strut}\settodepth{\@Dth@H@L}{\strut\usebox{\@x@l}\strut}%
\addtolength{\@Hgt@H@L}{\@Dth@H@L}}{\setlength{\@Hgt@H@L}{0pt}\setlength{\@Dth@H@L}{0pt}}%
\settoheight{\@utilf}{
\vbox{\llap{\hbox{\parbox{\@utili}{\raggedright\usebox{\@x@l}}\hfill
\parbox{\@utilj}{\centering\usebox{\@x@c}}\hfill
\rlap{\parbox{\@utilk}{\raggedleft\usebox{\@x@r}}}}}}}
\settodepth{\@utilg}{
\vbox{\hbox{\llap{\parbox{\@utili}{\raggedright\usebox{\@x@l}}\hfill
\parbox{\@utilj}{\centering\usebox{\@x@c}}\hfill
\rlap{\parbox{\@utilk}{\raggedleft\usebox{\@x@r}}}}}}}
\addtolength{\@utilh}{\@utilf}
\addtolength{\@utilh}{\@utilg}
\begin{lrbox}{\@x@c}\begin{minipage}{\textwidth}\@cheader\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@l}\begin{minipage}{\textwidth}\@lheader\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@r}\begin{minipage}{\textwidth}\@rheader\end{minipage}\end{lrbox}%
\txa{\@lheader}%
\txa{\@rheader}%
\ifthenelse{\boolean{@ch@use}}%
{\settoheight{\@Hgt@h@c}{\strut\usebox{\@x@c}\strut}\settodepth{\@Dth@h@c}{\strut\usebox{\@x@c}\strut}%
\addtolength{\@Hgt@h@c}{\@Dth@h@c}}{\setlength{\@Hgt@h@c}{0pt}\setlength{\@Dth@h@c}{0pt}}%
\ifthenelse{\boolean{@rh@use}}%
{\settoheight\@Hgt@h@r{\strut\usebox{\@x@r}\strut}\settodepth\@Dth@h@r{\strut\usebox{\@x@r}\strut}%
\addtolength\@Hgt@h@r{\@Dth@h@r}}{\setlength\@Hgt@h@r{0pt}\setlength\@Dth@h@r{0pt}}%
\ifthenelse{\boolean{@lh@use}}%
{\settoheight\@Hgt@h@l{\strut\usebox{\@x@l}\strut}\settodepth\@Dth@h@l{\strut\usebox{\@x@l}\strut}%
\addtolength\@Hgt@h@l{\@Dth@h@l}}{\setlength\@Hgt@h@l{0pt}\setlength\@Dth@h@l{0pt}}%
\begin{lrbox}{\@x@c}\begin{minipage}{\textwidth}\@Cfooter\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@l}\begin{minipage}{\textwidth}\@Lfooter\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@r}\begin{minipage}{\textwidth}\@Rfooter\end{minipage}\end{lrbox}%
\ifthenelse{\boolean{@Cf@use}}%
{\settoheight{\@Hgt@F@C}{\strut\usebox{\@x@c}\strut}\settodepth{\@Dth@F@C}{\strut\usebox{\@x@c}\strut}%
\addtolength{\@Hgt@F@C}{\@Dth@F@C}}{\setlength{\@Hgt@F@C}{0pt}\setlength{\@Dth@F@C}{0pt}}%
\ifthenelse{\boolean{@Rf@use}}%
{\settoheight{\@Hgt@F@R}{\strut\usebox{\@x@r}\strut}\settodepth{\@Dth@F@R}{\strut\usebox{\@x@r}\strut}%
\addtolength{\@Hgt@F@R}{\@Dth@F@R}}{\setlength{\@Hgt@F@R}{0pt}\setlength{\@Dth@F@R}{0pt}}%
\ifthenelse{\boolean{@Lf@use}}%
{\settoheight{\@Hgt@F@L}{\strut\usebox{\@x@l}\strut}\settodepth{\@Dth@F@L}{\strut\usebox{\@x@l}\strut}%
\addtolength{\@Hgt@F@L}{\@Dth@F@L}}{\setlength{\@Hgt@F@L}{0pt}\setlength{\@Dth@F@L}{0pt}}%
\begin{lrbox}{\@x@c}\begin{minipage}{\textwidth}\@cfooter\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@l}\begin{minipage}{\textwidth}\@lfooter\end{minipage}\end{lrbox}%
\begin{lrbox}{\@x@r}\begin{minipage}{\textwidth}\@rfooter\end{minipage}\end{lrbox}%
\ifthenelse{\boolean{@ch@use}}%
{\settoheight{\@Hgt@f@c}{\strut\usebox{\@x@c}\strut}\settodepth{\@Dth@f@c}{\strut\usebox{\@x@c}\strut}%
\addtolength{\@Hgt@f@c}{\@Dth@f@c}}{\setlength{\@Hgt@f@c}{0pt}\setlength{\@Dth@f@c}{0pt}}%
\ifthenelse{\boolean{@rh@use}}%
{\settoheight{\@Hgt@f@r}{\strut\usebox{\@x@r}\strut}\settodepth{\@Dth@f@r}{\strut\usebox{\@x@r}\strut}%
\addtolength{\@Hgt@f@r}{\@Dth@f@r}}{\setlength{\@Hgt@f@r}{0pt}\setlength{\@Dth@f@r}{0pt}}%
\ifthenelse{\boolean{@lh@use}}%
{\settoheight{\@Hgt@f@l}{\strut\usebox{\@x@l}\strut}\settodepth{\@Dth@f@l}{\strut\usebox{\@x@l}\strut}%
\addtolength{\@Hgt@f@l}{\@Dth@f@l}}{\setlength{\@Hgt@f@l}{0pt}\setlength{\@Dth@f@l}{0pt}}%
\txa{Height of letterhead header}%
\ifthenelse{\lengthtest{\@Hgt@H@L<\@Hgt@H@C}}%
{\setlength{\@Hgt@Head}{\@Hgt@H@C}}{\setlength{\@Hgt@Head}{\@Hgt@H@L}}%
\txa{1) @Hgt@Head: \the\@Hgt@Head,C:\the\@Hgt@H@C,L:\the\@Hgt@H@L,R:\the\@Hgt@H@R}%
\ifthenelse{\lengthtest{\@Hgt@Head<\@Hgt@H@R}}%
{\setlength{\@Hgt@Head}{\@Hgt@H@R}}{}%
\txa{2) @Hgt@Head: \the\@Hgt@Head}%
\ifthenelse{\lengthtest{\@Hgt@Head<\@Min@Hgt@Head}}%
{\setlength{\@Hgt@Head}{\@Min@Hgt@Head}}{}%
\txa{3) @Hgt@Head: \the\@Hgt@Head}%
\ifthenelse{\lengthtest{\@Hgt@Head<1pt}}%
{\setlength{\@Hgt@Head}{\@marg@tp}}%
{%\ifthenelse{\lengthtest{\@marg@tp@a<\@unpr@tp}}%
\txa{5) @Hgt@Head: \the\@Hgt@Head}%
\addtolength{\@Hgt@Head}{\@unpr@tp}%
\txa{6) @Hgt@Head: \the\@Hgt@Head}%
\addtolength{\@Hgt@Head}{\@marg@tp@a}%
\txa{7) @Hgt@Head: \the\@Hgt@Head}%
\addtolength{\@Hgt@Head}{\@Hrw}%
\addtolength{\@Hgt@Head}{\@unpr@tp}%
\ifthenelse{\lengthtest{\@Hrw<2pt}}{\addtolength{\@Hgt@Head}{2.0pt}}{}%
\txa{8) @Hgt@Head: \the\@Hgt@Head,\the\@Hrw,\headrulewidth}%
}%
\txa{Left: \the\@Hgt@H@L, Center: \the\@Hgt@H@C, Right: \the\@Hgt@H@R}%
\txa{Min: \the\@Min@Hgt@Head, Total: \the\@Hgt@Head}%
\txa{Marg: \the\@marg@tp, Marga: \the\@marg@tp@a, Unpr: \the\@unpr@tp}%
\txa{@Hgt@Head: \the\@Hgt@Head,@utilf:\the\@utilf,@utilg:\the\@utilg,@utilh:\the\@utilh}
\txa{Height of non-letterhead header}%
\ifthenelse{\lengthtest{\@Hgt@h@l<\@Hgt@h@c}}%
{\setlength{\@Hgt@head}{\@Hgt@h@c}}%
{\setlength{\@Hgt@head}{\@Hgt@h@l}}%
\ifthenelse{\lengthtest{\@Hgt@head<\@Hgt@h@r}}%
{\setlength{\@Hgt@head}{\@Hgt@h@r}}{}%
\ifthenelse{\lengthtest{\@Hgt@head<\@Min@Hgt@head}}%
{\setlength{\@Hgt@head}{\@Min@Hgt@head}}{}%
\ifthenelse{\lengthtest{\@Hgt@head<1pt}}%
{\setlength{\@Hgt@head}{\@marg@tp}}%
{%\ifthenelse{\lengthtest{\@marg@tp@a<\@unpr@tp}}%
\addtolength{\@Hgt@head}{\@marg@tp@a}%
\addtolength{\@Hgt@head}{\@hrw}%
\addtolength{\@Hgt@head}{2.60005pt}%
\txa{unprtop: \the\@unpr@tp}%
\addtolength{\@Hgt@head}{\@unpr@tp}%
\ifthenelse{\lengthtest{\@hrw<2pt}}{\addtolength{\@Hgt@head}{2.0pt}}{}%
}%
\txa{Left: \the\@Hgt@h@l, Center: \the\@Hgt@h@c, Right: \the\@Hgt@h@r}%
\txa{Min: \the\@Min@Hgt@head, Total: \the\@Hgt@head}%
\txa{Marg: \the\@marg@tp, Marga: \the\@marg@tp@a, Unpr: \the\@unpr@tp}%
\txa{Height of letterhead footer}%
\ifthenelse{\lengthtest{\@Hgt@F@L<\@Hgt@F@C}}%
{\setlength{\@Hgt@Foot}{\@Hgt@F@C}}{\setlength{\@Hgt@Foot}{\@Hgt@F@L}}%
\ifthenelse{\lengthtest{\@Hgt@Foot<\@Hgt@F@R}}%
{\setlength{\@Hgt@Foot}{\@Hgt@F@R}}{}%
\ifthenelse{\lengthtest{\@Hgt@Foot<\@Min@Hgt@Foot}}%
{\setlength{\@Hgt@Foot}{\@Min@Hgt@Foot}}{}%
\ifthenelse{\lengthtest{\@Hgt@Foot<1pt}}%
{\setlength{\@Hgt@Foot}{\@marg@bt}}%
{\ifthenelse{\lengthtest{\@marg@bt@b<\@unpr@bm}}%
{\setlength{\@marg@bt@b}{\@unpr@bm}}{}%
\addtolength{\@Hgt@Foot}{\@marg@bt@a}}%
\txa{Height of non-letterhead footer}%
\ifthenelse{\lengthtest{\@Hgt@f@l<\@Hgt@f@c}}%
{\setlength{\@Hgt@foot}{\@Hgt@f@c}} {\setlength{\@Hgt@foot}{\@Hgt@f@l}}%
\ifthenelse{\lengthtest{\@Hgt@foot<\@Hgt@f@r}}%
{\setlength{\@Hgt@foot}{\@Hgt@f@r}}{}%
\ifthenelse{\lengthtest{\@Hgt@foot<\@Min@Hgt@foot}}%
{\setlength{\@Hgt@foot}{\@Min@Hgt@foot}}{}%
\ifthenelse{\lengthtest{\@marg@lt@tp@d<1pt}}%
{\setlength{\@marg@lt@tp@d}{\@Hgt@Head+\@marg@tp@a}}{}%
\setlength{\@Plg}{\paperheight-\@Hgt@Head-\@Hgt@Foot-\@marg@tp@b-\@marg@tp@a-%
\@marg@bt@a-\@marg@bt@b-\@f@f-\@Hrw-\@Frw}%
\setlength{\@plg}{\paperheight-\@Hgt@head-\@Hgt@foot-\@marg@tp@b-\@marg@tp@a-%
\@marg@bt@a-\@marg@bt@b-\@f@f-\@hrw-\@frw}%
\ifthenelse{\lengthtest{\@text@height>.1pt}}{\setlength{\@Plg}{\@text@height}}{}%
\ifthenelse{\boolean{@Bg@use}}%
{\ClearShipoutPicture%
\AddToShipoutPicture{\includegraphics[natheight=11in,natwidth=8.5in]{\@Backgrnd}}}%
{\ifthenelse{\boolean{@bg@use}}%
{\ClearShipoutPicture%
\AddToShipoutPicture{\includegraphics[natheight=11in,natwidth=8.5in]{\@backgrnd}}%
}{}}%
\def\ifta{0}%
\txa{\string\@Hgt@H@C: \the\@Hgt@H@C, \string\@Hgt@H@R: \the\@Hgt@H@R}%
\txa{\string\@Hgt@H@L: \the\@Hgt@H@L, \string\@Hgt@Head: \the\@Hgt@Head}%
\txa{\string\@Hgt@h@c: \the\@Hgt@h@c, \string\@Hgt@h@r: \the\@Hgt@h@r}%
\txa{\string\@Hgt@h@l: \the\@Hgt@h@l, \string\@Hgt@head: \the\@Hgt@head}%
\txa{\string\@Hgt@F@C: \the\@Hgt@F@C, \string\@Hgt@F@R: \the\@Hgt@F@R}%
\txa{\string\@Hgt@F@L: \the\@Hgt@F@L, \string\@Hgt@Foot: \the\@Hgt@Foot}%
\txa{\string\@Hgt@f@c: \the\@Hgt@f@c, \string\@Hgt@f@r: \the\@Hgt@f@r}%
\txa{\string\@Hgt@f@l: \the\@Hgt@f@l, \string\@Hgt@foot: \the\@Hgt@foot}%
\txa{\string\@Plg:\the\@Plg, \string\paperheight:\the\paperheight}%
\txa{\string\@Hgt@Head:\the\@Hgt@Head, \string\@Hgt@head:\the\@Hgt@head}%
\txa{\string\@f@f:\@f@f,\string\footskip:\the\footskip}%
\txa{\string\@Hgt@foot:\the\@Hgt@Foot, \string\baselineskip:\the\baselineskip}%
\txa{\string\@plg:\the\@plg, \string\paperheight:\the\paperheight}%
\txa{\string\@Hgt@foot:\the\@Hgt@Foot, \string\baselineskip:\the\baselineskip}%
\txa{\string\@Hgt@foot:\the\@Hgt@Foot}%
\txa{\string\voffset:\the\voffset, \string\headsep:\the\headsep}%
\txa{\string\footruleskip:\footruleskip, \string\footrulewidth:\footrulewidth}%
\def\ifta{0}%
\ifthenelse{\boolean{@marg@Luse}}%
{\txa{Setting up left column...}%
\settowidth{\@utile}{\@Lmarg}%
\txa{Lt column width:\the\@utile}
\ifthenelse{\lengthtest{\@unpr@lt>\@marg@lt@l}}{\setlength{\@marg@lt@l}{\@unpr@lt}}%
{\addtolength{\@marg@lt@l}{\@unpr@lt}}%
\addtolength{\@utile}{\@marg@lt@l}%
\setlength{\marginparwidth}{\@utile}%
\setlength{\marginparsep}{\@marg@lt@r}%
\setlength{\@marg@lt}{\@utile}%
\txa{Lt Column width+edge:\the\@util,\the\@marg@lt@l}%
\txa{\string\@util:\the\@util, width:\the\marginparwidth,sep:\the\marginparsep}%
\ifthenelse{\lengthtest{\@marg@lt@tp@d<1pt}}{\setlength{\@marg@lt@tp@d}{\@Hgt@Head}}{}%
\txa{Done!}
}%
{%
\setlength{\marginparsep}{0in}%
\setlength{\marginparwidth}{0in}%
\ifthenelse{\lengthtest{\@unpr@lt>\@marg@lt}}{\setlength{\@marg@lt}{\@unpr@lt}}{}%
}%
\ifthenelse{\boolean{@marg@Ruse}}%
{%
\txa{Setting up right column...}%
\settowidth{\@utile}{\@Rmarg}%
\txa{Rt Column width:\the\@utile}%
\ifthenelse{\lengthtest{\@marg@rt@l<.01pt}}{\setlength{\@marg@rt@l}{\@marg@lt@r}}{}%
\ifthenelse{\lengthtest{\@marg@rt@r<.01pt}}{\setlength{\@marg@rt@r}{\@marg@lt@l}}{}%
\txa{Unpr Rt:\the\@unpr@rt,Marg Rt R:\the\@marg@rt@r}
\ifthenelse{\lengthtest{\@unpr@rt>\@marg@rt@r}}{\setlength{\@marg@rt@r}{\@unpr@rt}}{}%
\txa{Unpr Rt:\the\@unpr@rt,Marg Rt R:\the\@marg@rt@r}%
\addtolength{\@utile}{\@marg@rt@r}%
\txa{Rt Column width+gutter:\the\@utile}%
\addtolength{\@utile}{\@marg@rt@l}%
\txa{Rt Column width+edge:\the\@utile}%
\setlength{\@marg@rt}{\@utile}%
\txa{\string\@util:\the\@util, \string\marginparwidth:\the\marginparwidth}%
\ifthenelse{\lengthtest{\@marg@rt@tp@d<1pt}}%
  {\setlength{\@marg@rt@tp@d}{\@Hgt@Head}}{}%
\txa{Done!}%
}%
{%
\txa{No right column}%
\ifthenelse{\lengthtest{\@unpr@rt>\@marg@rt}}{\setlength{\@marg@rt}{\@unpr@rt}}{}%
\ifthenelse{\lengthtest{\@unpr@rt>\@marg@rt}}{\setlength{\@marg@rt}{\@unpr@rt}}{}%
}%
\setlength{\@Pwd}{\paperwidth-\@marg@lt-\@marg@rt}%
\txa{Page width:\the\@Pwd,paper:\the\paperwidth}%
\txa{\string\@Hgt@H@C:\the\@Hgt@H@C, width:\the\marginparwidth,sep:\the\marginparsep}%
\ifthenelse{\lengthtest{\@text@width>.1pt}}{\setlength{\@Pwd}{\@text@width}}{}%
\showdim{At raggedbottom}%
\raggedbottom%
\def\ifta{0}%
\showdim{Before setpage}%
\txa{\string\@marg@tp@a:\the\@marg@tp@a,\string\@Hgt@Head:\the\@Hgt@Head}%
\txa{\string\@marg@tp@b:\the\@marg@tp@b,\string\@Hgt@Foot:\the\@Hgt@Foot}%
\txa{\string\@marg@bt@a:\the\@marg@bt@a,\string\@Hgt@Head:\the\@Hgt@Head}%
\txa{\string\@marg@bt@b:\the\@marg@bt@b,\string\@Hgt@Foot:\the\@Hgt@Foot}%
\txa{\string\@unpr@bm:\the\@unpr@bm,\string\@unpr@tp:\the\@Hgt@Foot}%
\txa{Before Setting page 1}%
\settoheight{\@utile}{\@Rheader}%
\settodepth{\@utilb}{\@Rheader}%
\addtolength{\@utile}{\@utilb}%
\txa{Right: \the\@utile}%
\settoheight{\@utile}{\@Cheader}%
\settodepth{\@utilb}{\@Cheader}%
\addtolength{\@utile}{\@utilb}%
\txa{Center: \the\@utile}%
\settoheight{\@utile}{\@Lheader}%
\settodepth{\@utilb}{\@Lheader}%
\addtolength{\@utile}{\@utilb}%
\txa{Left: \the\@utile}%
\txa{marg-tp-a: \the\@marg@tp@a}%
\gdef\npind{A5}%
\ifthenelse{\lengthtest{\@Hgt@head<10pt}}{\setlength{\@Hgt@head}{13pt}}{}%
\setpage{\@Plg}{\@Pwd}{\@marg@rt-1in}{\@marg@lt-1in}{10pt}%
{\@marg@tp@a-1in}{\@Hgt@Head}{\@marg@tp@b}{\@Hgt@Foot}%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 \vspace*{\the\@marg@tp@a}
\txa{headrulewidth:\headrulewidth}
\@zfancyhead{\relax}{\f@ncyolh}{\f@ncyolh}{\f@ncyorh}{\relax}
\txa{HgtHead:\the\@Hgt@Head,utill:\the\@utill,zpqutil:\@zpqutil}
\addtolength{\@Hgt@Head}{\@utill}
\addtolength{\@Hgt@Head}{\@zpqutil}
\txa{HgtHead:\the\@Hgt@Head}
\setpage{\@Plg}{\@Pwd}{\@marg@rt-1in}{\@marg@lt-1in}{10pt}%
{\@marg@tp@a-1in}{\@Hgt@Head}{\@marg@tp@b}{\@Hgt@Foot}%
\txa{headheight:\the\headheight}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\txa{After Setting page 1}%
\fixhh{\@Hgt@head}%
\fixth{\@plg}%
\showdim{After setpage}%
\setlength{\headwidth}{\textwidth}%
\def\ifta{0}%
\ifthenelse{\boolean{@cello@win}} {%
\setlength{\@utila}{\@cello@d}%
\txa{1. \the\@utila}
\addtolength{\@utila}{-\@Hgt@Head}%
\txa{2. \the\@utila,\the\@Hgt@Head}%
\addtolength{\@utila}{-\@marg@tp@a}%
\txa{3. \the\@utila,\the\@marg@tp@a}
\addtolength{\@utila}{-\@marg@tp@b}%
\txa{4. \the\@utila,\the\@marg@tp@b}
\ifthenelse{\boolean{@dt@p}}{\txa{Fixing date}%
\ifthenelse{\@intd@pos<\@intt@pos}{%
\addtolength{\@utila}{-\@dt@sk@b}%
\txa{5. \the\@utila,\the\@dt@sk@b}%
\addtolength{\@utila}{-\@dt@sk@a}%
\txa{6. \the\@utila,\the\@dt@sk@a}
\settoheight{\@utile}{\@xdate}%
\addtolength{\@utila}{-\@utile}%
\txa{7. \the\@utila,\the\@utile}%
}{}}{}%
\ifthenelse{\boolean{@addr@fr@p}}{\txa{Fixing from address}%
\ifthenelse{\@intf@pos<\@intt@pos}{%
\addtolength{\@utila}{-\@addr@fr@sk@b}%
\addtolength{\@utila}{-\@addr@fr@sk@a}%
\sbox{\b@addr@fr}{\noindent\setlength{\tabcolsep}{0pt}% Address-from into a box
\raggedleft\begin{tabular}{l@{}}%
\noindent\ignorespaces\@addr@fr%
\ifthenelse{\boolean{@addr@fr@t}}{\\ \@phn@phr: \@phn@fr}{}%
\ifthenelse{\boolean{@addr@fr@f}}{\\ \@fax@phr: \@fax@fr}{}%
\ifthenelse{\boolean{@addr@fr@e}}{\\ \@email@phr: \@email@fr}{}%
\end{tabular}}%
\settoheight{\@utile}{\usebox{\b@addr@fr}}%
\addtolength{\@utila}{-\@utile}%
\txa{8. \the\@utila,\the\@utile}%
}{}}{}%
\txa{9. \the\@utila}%
\setlength{\@utilb}{\@cello@l}%
\txa{10. Horizontal position}%
\txa{11. Start: \the\@utilb}%
\addtolength{\@utilb}{-\@marg@lt}%
\txa{12. \the\@utilb,\the\@marg@lt}%
\txa{13. \the\@utilb}%
\ifthenelse{\lengthtest{\@utila > 0pt}}{\setboolean{@ztila}{true}}%
{\typeout{Cello window requested, but cannot be used.}%
\typeout{'To-address' cannot be placed vertically.  Suggestions:}%
\typeout{1. Make letterhead components smaller.}%
\typeout{2. Eliminate date or 'from-address' from letter.}%
\typeout{3. Move date or 'from-address' below 'to-address'.}%
\setboolean{@ztila}{false}%
}%
\ifthenelse{\lengthtest{\@utilb > 0pt}}{\setboolean{@ztilb}{true}}%
{\typeout{Cello window requested, but cannot be used.}%
\typeout{'To-address' cannot be placed horizontally.  Suggestions:}%
\typeout{1. Make left-margin width smaller.}%
\typeout{2. Eliminate margin components.}%
\setboolean{@ztilb}{false}%%
}%
\ifthenelse{\boolean{@ztila} \and \boolean{@ztilb}}{%
\setlength{\@addr@to@sk@b}{\@utila}%
\setlength{\@extr@hor}{\@utila}}{}%
}{\setboolean{@cello@win}{false}\setlength{\@extr@hor}{0pt}}%
\def\ifta{0}%
\txa{End of @set@em@up}%
}%
\newif \if@dim@reset \@dim@resettrue%
\newif \if@repth \@repthfalse%
\newcommand{\@rep@th}{}%
\newcommand{\fixth}[1]{\renewcommand{\@rep@th}{#1} \global\@repthtrue}%
\newdimen \@rep@th%
\newif \if@reptw \@reptwfalse%
\newcommand{\@rep@tw}{}%
\newcommand{\fixtw}[1]{\renewcommand{\@rep@tw}{#1} \global\@reptwtrue}%
\newdimen \@rep@tw%
\newif \if@repom \@repomfalse%
\newcommand{\@rep@om}{}%
\newcommand{\fixom}[1]{\renewcommand{\@rep@om}{#1} \global\@repomtrue}%
\newdimen \@rep@om%
\newif \if@repem \@repemfalse%
\newcommand{\@rep@em}{}%
\newcommand{\fixem}[1]{\renewcommand{\@rep@em}{#1} \global\@repemtrue}%
\newdimen \@rep@em%
\newif \if@repcs \@repcsfalse%
\newcommand{\@rep@cs}{}%
\newcommand{\fixcs}[1]{\renewcommand{\@rep@cs}{#1} \global\@repcstrue}%
\newdimen \@rep@cs%
\newif \if@reptm \@reptmfalse%
\newcommand{\@rep@tm}{}%
\newcommand{\fixtm}[1]{\renewcommand{\@rep@tm}{#1} \global\@reptmtrue}%
\newdimen \@rep@tm%
\newif \if@rephh \@rephhfalse%
\newcommand{\@rep@hh}{}%
\newcommand{\fixhh}[1]{\renewcommand{\@rep@hh}{#1} \global\@rephhtrue}%
\newdimen \@rep@hh%
\newif \if@rephs \@rephsfalse%
\newcommand{\@rep@hs}{}%
\newcommand{\fixhs}[1]{\renewcommand{\@rep@hs}{#1} \global\@rephstrue}%
\newdimen \@rep@hs%
\newif \if@repfs \@repfsfalse%
\newcommand{\@rep@fs}{}%
\newcommand{\fixfs}[1]{\renewcommand{\@rep@fs}{#1} \global\@repfstrue}%
\newdimen \@rep@fs%
\def\@outputpage{%
  \def\ifta{0}%
  \txa{npind:\npind}%
  \showdim{New page - before shipout}%
  \begingroup%           % the \endgroup is put in by \aftergroup
    \let \protect \noexpand%
    \@resetactivechars%
    \global\let\@@if@newlist\if@newlist%
    \global\@newlistfalse%
    \@parboxrestore%
\txa{topmargin:\the\topmargin}%
\txa{Before shipout...}%
  \showdim{New page - immediately before shipout}%
    \shipout \vbox{%%
      \set@typeset@protect%
      \aftergroup \endgroup%
      \aftergroup \set@typeset@protect% correct? or just restore by ending the group%
      \if@specialpage%
        \global\@specialpagefalse\@nameuse{ps@\@specialstyle}%%
      \fi%
      \if@twoside%
        \ifodd\count\z@ \let\@thehead\@oddhead \let\@thefoot\@oddfoot%
          \let\@themargin\oddsidemargin%
        \else \let\@thehead\@evenhead%
          \let\@thefoot\@evenfoot \let\@themargin\evensidemargin%
        \fi%
      \fi%
      \reset@font%
      \normalsize%
\txa{Before normalsfcodes}%
      \normalsfcodes%
      \let\label\@gobble%
      \let\index\@gobble%
      \let\glossary\@gobble%
      \baselineskip\z@skip \lineskip\z@skip \lineskiplimit\z@%
      \@begindvi%
      \vskip \topmargin%
    \moveright\@themargin \vbox {%%
      \setbox\@tempboxa \vbox to\headheight{%%
        \vfil%
        \color@hbox%
          \normalcolor%
          \hb@xt@\textwidth{\@thehead}%%
        \color@endbox%
        }%                        %% 22 Feb 87%
      \dp\@tempboxa \z@%
      \box\@tempboxa%
      \vskip \headsep%
      \box\@outputbox%
      \baselineskip \footskip%
      \color@hbox%
        \normalcolor%
        \hb@xt@\textwidth{\@thefoot}%%
      \color@endbox%
      }%%
    }%
\txa{After shipout}%
\global\let\if@newlist\@@if@newlist%
\showdim{New page - before reset}%
\if@dim@reset%
\if@repth \global\textheight \@rep@th \global\@repthfalse \fi%
\fi%
\global \@colht \textheight%
\stepcounter{page}%
\let\firstmark\botmark%
\if@dim@reset%
\if@repth \global\textheight \@rep@th     \global\@repthfalse \fi%
\if@reptw \global\textwidth \@rep@tw      \global\@reptwfalse \fi%
\if@repom \global\oddsidemargin \@rep@om  \global\@repomfalse \fi%
\if@repem \global\evensidemargin \@rep@em \global\@repemfalse \fi%
\if@repcs \global\columnsep \@rep@cs      \global\@repcsfalse \fi%
\if@reptm \global\topmargin \@rep@tm      \global\@reptmfalse \txa{Fixing tm} \fi%
\if@rephh \global\headheight \@rep@hh     \global\@rephhfalse \fi%
\if@rephs \global\headsep \@rep@hs        \global\@rephsfalse \fi%
\if@repfs \global\footskip \@rep@fs       \global\@repfsfalse \fi%
\fi%
\showdim{New page - after reset}%
\def\ifta{0}%
\renewcommand{\headrulewidth}{\the\@hrw}%
\renewcommand{\footrulewidth}{\the\@frw}%
}%
\AtEndDocument{%
\ifthenelse{\boolean{@set@env}}%
{\@clear@box%
\pagestyle{empty}\thispagestyle{empty}%
\def\ifta{0}%
\showdim{Before changeing dimensions}%
\gdef\npind{A6}%
\setpage{11in}{8.5in}{-1in}{-1in}{0in}{-1in}{0in}{0in}{0in}%
\txa{Starting the call to makeenvfn}%
\makeenvfn%
\txa{After return from the call to makeenvfn}%
}{}%
\ifthenelse{\boolean{@use@envlab}}{\@make@big@env}{}%
}%
\AtBeginDocument{%
\def\ifta{0}%
\txa{AtBeginDocument...}%
\@nlfm@addr=0%
\ifthenelse{\boolean{@use@envlab}}%
{%
\IfFileExists{envlab.sty}%
{\makelabels}%
{\typeout{The option <useenvlab> was issued.  File <envlab.sty> cannot be found.}%
\typeout{Option <useenvlab> is disabled.  Please install envlab system.}%
\setboolean{@use@envlab}{false}}}{}%
{}%
\txa{At the very very end...}%
}%
\endinput%

%%% Local Variables:
%%% mode: latex
%%% TeX-master: t
%%% End:
\endinput
%%
%% End of file `newlfm.cls'.
