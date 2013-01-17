%%
%% This is file `cd.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% cd.dtx  (with options: `class')
%% 
%% Copyright (C) 1998-2007 by Sebastiano Vigna
%% 
%% This file is free software; you can redistribute it and/or modify
%% it under the terms of the GNU General Public License as published by
%% the Free Software Foundation; either version 2 of the License, or
%% (at your option) any later version.
%% 
%% This program is distributed in the hope that it will be useful,
%% but WITHOUT ANY WARRANTY; without even the implied warranty of
%% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%% GNU General Public License for more details.
%% 
%% You should have received a copy of the GNU General Public License
%% along with this program; if not, write to the Free Software
%% Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
%% 
%% \CharacterTable
%%  {Upper-case    \A\B\C\D\E\F\G\H\I\J\K\L\M\N\O\P\Q\R\S\T\U\V\W\X\Y\Z
%%   Lower-case    \a\b\c\d\e\f\g\h\i\j\k\l\m\n\o\p\q\r\s\t\u\v\w\x\y\z
%%   Digits        \0\1\2\3\4\5\6\7\8\9
%%   Exclamation   \!     Double quote  \"     Hash (number) \#
%%   Dollar        \$     Percent       \%     Ampersand     \&
%%   Acute accent  \'     Left paren    \(     Right paren   \)
%%   Asterisk      \*     Plus          \+     Comma         \,
%%   Minus         \-     Point         \.     Solidus       \/
%%   Colon         \:     Semicolon     \;     Less than     \<
%%   Equals        \=     Greater than  \>     Question mark \?
%%   Commercial at \@     Left bracket  \[     Backslash     \\
%%   Right bracket \]     Circumflex    \^     Underscore    \_
%%   Grave accent  \`     Left brace    \{     Vertical bar  \|
%%   Right brace   \}     Tilde         \~}
%%
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{cd}[2007/10/12 v1.3 CD Cover Class]
\newif\if@lignspine
\@lignspinefalse

\DeclareOption{alignspine}{\@lignspinetrue}

\def\@ligncover{b}
\def\@ligninside{b}
\def\@lignback{b}

\DeclareOption{aligncovertop}{\def\@ligncover{t}}
\DeclareOption{aligninsidetop}{\def\@ligninside{t}}
\DeclareOption{alignbacktop}{\def\@lignback{t}}

\DeclareOption{covergraphics}{\def\@lignback{t}}

\DeclareOption{aligntop}%
    {\ExecuteOptions{aligncovertop,aligninsidetop,alignbacktop}}

\DeclareOption{aligncovercenter}{\def\@ligncover{c}}
\DeclareOption{aligninsidecenter}{\def\@ligninside{c}}
\DeclareOption{alignbackcenter}{\def\@lignback{c}}

\DeclareOption{aligncenter}%
    {\ExecuteOptions{aligncovercenter,aligninsidecenter,alignbackcenter}}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

\ProcessOptions\relax
\LoadClass{article}
\RequirePackage{rotating}
\DeclareRobustCommand*\onecorrection[1]{\def\onec@rrfrac{#1}}
\onecorrection{0}
\DeclareRobustCommand*\coverfont[1]{\def\coverf@nt{#1}}
\DeclareRobustCommand*\backfont[1]{\def\backf@nt{#1}}
\DeclareRobustCommand*\insidefont[1]{\def\insidef@nt{#1}}
\DeclareRobustCommand*\spinefont[1]{\def\spinef@nt{#1}}
\DeclareRobustCommand*\tracklistfont[1]{\def\tracklistf@nt{#1}}
\DeclareRobustCommand*\infofont[1]{\def\infof@nt{#1}}
\DeclareRobustCommand*\indexfont[1]{\def\indexf@nt{#1}}

\DeclareRobustCommand{\lefttracklist}[1]{\def\lefttr@cklist{#1}}
\DeclareRobustCommand{\righttracklist}[1]{\def\righttr@cklist{#1}}
\DeclareRobustCommand{\leftinfo}[1]{\def\leftinf@{#1}}
\DeclareRobustCommand{\rightinfo}[1]{\def\rightinf@{#1}}
\DeclareRobustCommand{\covertext}[1]{\def\c@vertext{#1}}
\DeclareRobustCommand{\backtext}[1]{\def\b@cktext{#1}}
\DeclareRobustCommand{\insidetext}[1]{\def\insid@text{#1}}

\DeclareRobustCommand{\covergraphics}[1]{\def\c@vertext{#1}\def\c@vergraphics{}}
\DeclareRobustCommand{\insidegraphics}[1]{\def\insid@text{#1}\def\insid@graphics{}}

\DeclareRobustCommand*{\leftspine}[1]{\def\leftspin@{#1}}
\DeclareRobustCommand*{\centerspine}[1]{\def\centerspin@{#1}}
\DeclareRobustCommand*{\rightspine}[1]{\def\rightspin@{#1}}
\DeclareRobustCommand*{\leftspinebis}[1]{\def\leftspin@bis{#1}}
\DeclareRobustCommand*{\centerspinebis}[1]{\def\centerspin@bis{#1}}
\DeclareRobustCommand*{\rightspinebis}[1]{\def\rightspin@bis{#1}}
\evensidemargin=0cm
\oddsidemargin=0cm
\topmargin=0cm
\headheight=0cm
\headsep=0cm
\footskip=0cm
\textwidth=\paperwidth
\textheight=\paperheight

\lineskip=0pt
\lineskiplimit=0pt
\parskip=0pt
\parindent=0pt
\hyphenpenalty=10000
\setlength{\unitlength}{1mm}
\newlength{\squ@re}
\newlength{\@temp}
\newlength{\h@nging}
\newlength{\@hstrip}
\newlength{\@wstrip}
\newlength{\winf@}
\newlength{\wtr@cklist}
\newlength{\onec@rrection}
\newcounter{tr@ckindex}
\DeclareRobustCommand*{\setindex}[1]{\setcounter{tr@ckindex}{#1}}

\DeclareRobustCommand*{\track}{%
    \par
    \let\@firstdigit=\@empty
    \setlength{\onec@rrection}{0pt}%
    \settowidth{\@temp}{\indexf@nt1}
    \expandafter\@tfor \expandafter\@digit
      \expandafter:\expandafter=\number\value{tr@ckindex}\do {%
        \ifx\@firstdigit\@empty
            \let\@firstdigit=\@digit
        \else
            \if 1\@firstdigit
                \if 1\@digit\else
                    \setlength{\onec@rrection}{-\onec@rrfrac\@temp}%
                \fi
            \else
                \if 1\@digit
                     \setlength{\onec@rrection}{\onec@rrfrac\@temp}%
                \fi
            \fi
        \fi
    }%
    \settoheight{\@temp}{M}%
    \addtolength{\@temp}{-\squ@re}%
    \raisebox{.5\@temp}{%
        \setlength{\unitlength}{\squ@re}%
        \hspace*{-\h@nging}%
        \begin{picture}(1,1)
            \put(0,0){%
                \framebox(1,1){\hspace*{\onec@rrection}\indexf@nt\thetr@ckindex}%
            }
        \end{picture}%
    }%
    \hspace*{6pt}%
    \addtocounter{tr@ckindex}{1}%
}
\AtBeginDocument{%
    \pagestyle{empty}%
    \thispagestyle{empty}%
    \newcd
}

\DeclareRobustCommand*{\fhb}[2]{%
    \fontsize{#1pt}{#2pt}\selectfont
    \parskip=.1\baselineskip
}

\DeclareRobustCommand*{\fh}[1]{\fontsize{#1pt}{\baselineskip}\selectfont}

\DeclareRobustCommand*{\newcd}{%
    \lefttracklist{}%
    \righttracklist{}%
    \covertext{}%
    \insidetext{}%
    \leftspine{}%
    \centerspine{}%
    \rightspine{}%
    \leftspinebis{\leftspin@}%
    \centerspinebis{\centerspin@}%
    \rightspinebis{\rightspin@}%
    \leftinfo{}%
    \rightinfo{}%
    \coverfont{\fhb{16}{19}}%
    \backfont{\coverf@nt}%
    \insidefont{\fhb{10}{12}}%
    \spinefont{\fhb{9}{11}\bfseries}%
    \tracklistfont{\fhb{9}{10.5}}%
    \infofont{\fhb{7}{8.3}}%
    \indexfont{\fhb{5}{0}}%
}
\DeclareRobustCommand*{\@sethwstrips}[1]{%
    \settowidth{\@wstrip}{\spinef@nt #1}%
    \if@lignspine
        \settoheight{\@hstrip}{\spinef@nt #1}%
    \fi
}

\DeclareRobustCommand*{\alignt@baseline}{%
    \settodepth{\@temp}{gjpqy}%
    \vphantom{gjpqy}\par
    \vspace*{-\@temp}\par
}
\DeclareRobustCommand*{\makecover}[1][lrtb]{%
\voffset=0in
\begin{picture}(120,240)
\end{picture}%
\begin{rotate}{90}%
\begin{picture}(240,120)
    \@tfor\cr@pmark := #1 \do {
    \if l\cr@pmark
        \put(-1,0){\line(-1,0){5}}
        \put(-1,120){\line(-1,0){5}}
    \else\if r\cr@pmark
        \put(241,0){\line(1,0){5}}
        \put(241,120){\line(1,0){5}}
    \else\if b\cr@pmark
        \put(0,-1){\line(0,-1){5}}
        \put(240,-1){\line(0,-1){5}}
        \put(120,-1){\line(0,-1){1}}
        \put(120,-3){\line(0,-1){1}}
        \put(120,-5){\line(0,-1){1}}
    \else\if t\cr@pmark
        \put(0,121){\line(0,1){5}}
        \put(240,121){\line(0,1){5}}
        \put(120,121){\line(0,1){1}}
        \put(120,123){\line(0,1){1}}
        \put(120,125){\line(0,1){1}}
    \else\if c\cr@pmark
        \put(0,0){\line(1,0){240}}
        \put(0,0){\line(0,1){120}}
        \put(120,0){\line(0,1){120}}
        \put(0,120){\line(1,0){240}}
        \put(240,0){\line(0,1){120}}
    \fi\fi\fi\fi\fi
    }

    \ifx\insid@graphics\@empty
        \put(0,0){%
            \makebox(120,120)[\@ligninside]{%
                \parbox{12cm}{%
                     \raggedright\insidef@nt\insid@text\alignt@baseline
                }%
            }%
        }
    \else
        \put(10,10){%
            \makebox(100,100)[\@ligninside]{%
                \parbox{10cm}{%
                     \raggedright\insidef@nt\insid@text\alignt@baseline
                }%
            }%
        }
    \fi
    \ifx\c@vergraphics\@empty
        \put(120,0){%
            \makebox(120,120)[\@ligncover]{%
                \parbox{12cm}{%
                     \raggedright\coverf@nt\c@vertext\alignt@baseline
                }%
            }%
        }
    \else
        \put(130,10){%
            \makebox(100,100)[\@ligncover]{%
                \parbox{10cm}{%
                     \raggedright\coverf@nt\c@vertext\alignt@baseline
                }%
            }%
        }
    \fi
\end{picture}%
\end{rotate}%
}
\DeclareRobustCommand*{\makeback}[1][lrtb]{%
\voffset=-.5in
\setindex{1}%
\settowidth{\squ@re}{\indexf@nt00}%
\settoheight{\@temp}{\indexf@nt0}%
\addtolength{\squ@re}{.4\@temp}%
\setlength{\h@nging}{\squ@re}%
\addtolength{\h@nging}{6pt}%
\settoheight{\@hstrip}{\spinef@nt ABCDEFGHIJKLMNOPQRSTUVWXYZ}%
\ifx\righttr@cklist\@empty
    \setlength{\wtr@cklist}{12cm}%
\else
    \setlength{\wtr@cklist}{5.5cm}%
\fi
\ifx\rightinf@\@empty
    \setlength{\winf@}{12cm}%
\else
    \setlength{\winf@}{5.5cm}%
\fi
\begin{picture}(151,118)
    \@tfor\cr@pmark := #1 \do {
    \if l\cr@pmark
        \put(-1,0){\line(-1,0){5}}
        \put(-1,118){\line(-1,0){5}}
    \else\if r\cr@pmark
        \put(152,0){\line(1,0){5}}
        \put(152,118){\line(1,0){5}}
    \else\if b\cr@pmark
        \put(0,-1){\line(0,-1){5}}
        \put(151,-1){\line(0,-1){5}}
        \put(6.5,-1){\line(0,-1){1}}
        \put(6.5,-3){\line(0,-1){1}}
        \put(6.5,-5){\line(0,-1){1}}
        \put(144.5,-1){\line(0,-1){1}}
        \put(144.5,-3){\line(0,-1){1}}
        \put(144.5,-5){\line(0,-1){1}}
    \else\if t\cr@pmark
        \put(0,119){\line(0,1){5}}
        \put(151,119){\line(0,1){5}}
        \put(6.5,119){\line(0,1){1}}
        \put(6.5,121){\line(0,1){1}}
        \put(6.5,123){\line(0,1){1}}
        \put(144.5,119){\line(0,1){1}}
        \put(144.5,121){\line(0,1){1}}
        \put(144.5,123){\line(0,1){1}}
    \else\if c\cr@pmark
        \put(0,0){\line(1,0){151}}
        \put(0,0){\line(0,1){118}}
        \put(151,0){\line(0,1){118}}
        \put(0,118){\line(1,0){151}}
        \put(6.5,0){\line(0,1){118}}
        \put(144.5,0){\line(0,1){118}}
    \fi\fi\fi\fi\fi
    }

    \@sethwstrips{\leftspin@}

    \put(0,4){%
        \makebox(6.5,110)[b]{%
             \makebox[\@hstrip][r]{%
                  \begin{rotate}{90}\spinef@nt\leftspin@\end{rotate}%
             }%
        }%
    }

    \@sethwstrips{\centerspin@}

    \put(0,4){%
        \makebox(6.5,110){%
             \raisebox{0pt}[\@wstrip]{\makebox[\@hstrip][r]{%
                 \begin{rotate}{90}\spinef@nt\centerspin@\end{rotate}%
             }}%
        }%
    }

    \@sethwstrips{\rightspin@}

    \put(0,4){%
        \makebox(6.5,110)[t]{%
             \raisebox{0pt}[\@wstrip]{\makebox[\@hstrip][r]{%
                  \begin{rotate}{90}\spinef@nt\rightspin@\end{rotate}%
             }}%
        }%
    }

    \@sethwstrips{\leftspin@bis}

    \put(144.5,4){%
        \makebox(6.5,110)[t]{%
             \makebox[\@hstrip][l]{%
                  \begin{rotate}{-90}\spinef@nt\leftspin@bis\end{rotate}%
             }%
        }%
    }

    \@sethwstrips{\centerspin@bis}

    \put(144.5,4){%
        \makebox(6.5,110){%
             \raisebox{\@wstrip}[\@wstrip]{\makebox[\@hstrip][l]{%
                  \begin{rotate}{-90}\spinef@nt\centerspin@bis\end{rotate}%
             }}%
        }%
    }

    \@sethwstrips{\rightspin@bis}

    \put(144.5,4){%
        \makebox(6.5,110)[b]{%
             \raisebox{\@wstrip}[\@wstrip]{\makebox[\@hstrip][l]{%
                  \begin{rotate}{-90}\spinef@nt\rightspin@bis\end{rotate}%
             }}%
        }%
    }

    \put(17,0){%
        \begin{picture}(121,118)
            \put(0,82){%
                \makebox(120,30)[\@lignback]{%
                    \parbox{12.1cm}{%
                        \raggedright\backf@nt
                        \ifx\b@cktext\undefined
                            \ifx\c@vergraphics\@empty\else\c@vertext\fi
                        \else
                            \b@cktext
                        \fi
                        \alignt@baseline
                    }%
                }%
            }

            \put(0,5){%
                \makebox(55,70)[tl]{%
                    \begin{minipage}{\wtr@cklist}%
                        \lineskip=.5pt\lineskiplimit=1pt\raggedright
                        \tracklistf@nt\lefttr@cklist
                    \end{minipage}%
                }%
            }

            \put(65,5){%
                \makebox(55,70)[tl]{%
                    \begin{minipage}{\wtr@cklist}%
                        \lineskip=.5pt\lineskiplimit=1pt\raggedright
                        \tracklistf@nt\righttr@cklist
                    \end{minipage}%
                }%
            }

            \put(0,5){%
                \makebox(0,0)[bl]{%
                    \parbox{\winf@}{%
                        \raggedright\infof@nt\leftinf@\alignt@baseline
                    }%
                }%
            }

            \put(65,5){%
                \makebox(0,0)[bl]{%
                    \parbox{\winf@}{%
                        \raggedright\infof@nt\rightinf@\alignt@baseline
                    }%
                }%
            }

        \end{picture}%
    }

\end{picture}%
}
\DeclareRobustCommand*{\makeslimcover}[1][lrtb]{%
\voffset=0in
\setindex{1}%
\settowidth{\squ@re}{\indexf@nt00}%
\settoheight{\@temp}{\indexf@nt0}%
\addtolength{\squ@re}{.4\@temp}%
\setlength{\h@nging}{\squ@re}%
\addtolength{\h@nging}{6pt}%
\settoheight{\@hstrip}{\spinef@nt ABCDEFGHIJKLMNOPQRSTUVWXYZ}%
\ifx\righttr@cklist\@empty
    \setlength{\wtr@cklist}{10cm}%
\else
    \setlength{\wtr@cklist}{4.7cm}%
\fi
\ifx\rightinf@\@empty
    \setlength{\winf@}{10cm}%
\else
    \setlength{\winf@}{4.7cm}%
\fi
\begin{picture}(120,240)
\end{picture}%
\begin{rotate}{90}%
\begin{picture}(240,120)
    \@tfor\cr@pmark := #1 \do {
    \if l\cr@pmark
        \put(-1,0){\line(-1,0){5}}
        \put(-1,120){\line(-1,0){5}}
    \else\if r\cr@pmark
        \put(241,0){\line(1,0){5}}
        \put(241,120){\line(1,0){5}}
    \else\if b\cr@pmark
        \put(0,-1){\line(0,-1){5}}
        \put(240,-1){\line(0,-1){5}}
        \put(120,-1){\line(0,-1){1}}
        \put(120,-3){\line(0,-1){1}}
        \put(120,-5){\line(0,-1){1}}
    \else\if t\cr@pmark
        \put(0,121){\line(0,1){5}}
        \put(240,121){\line(0,1){5}}
        \put(120,121){\line(0,1){1}}
        \put(120,123){\line(0,1){1}}
        \put(120,125){\line(0,1){1}}
    \else\if c\cr@pmark
        \put(0,0){\line(1,0){240}}
        \put(0,0){\line(0,1){120}}
        \put(120,0){\line(0,1){120}}
        \put(0,120){\line(1,0){240}}
        \put(240,0){\line(0,1){120}}
    \fi\fi\fi\fi\fi
    }

    \put(12,10){%
        \begin{picture}(100,100)
            \put(0,80){%
                \makebox(100,30)[\@lignback]{%
                    \parbox{10.1cm}{%
                        \raggedright\backf@nt
                        \ifx\b@cktext\undefined
                            \ifx\c@vergraphics\@empty\else\c@vertext\fi
                        \else
                            \b@cktext
                        \fi
                        \alignt@baseline
                    }%
                }%
            }

            \put(0,15){%
                \makebox(47,60)[tl]{%
                    \begin{minipage}{\wtr@cklist}%
                        \lineskip=.5pt\lineskiplimit=1pt\raggedright
                        \tracklistf@nt\lefttr@cklist
                    \end{minipage}%
                }%
            }

            \put(55,15){%
                \makebox(47,60)[tl]{%
                    \begin{minipage}{\wtr@cklist}%
                        \lineskip=.5pt\lineskiplimit=1pt\raggedright
                        \tracklistf@nt\righttr@cklist
                    \end{minipage}%
                }%
            }

            \put(0,0){%
                \makebox(0,0)[bl]{%
                    \parbox{\winf@}{%
                        \raggedright\infof@nt\leftinf@\alignt@baseline
                    }%
                }%
            }

            \put(55,0){%
                \makebox(0,0)[bl]{%
                    \parbox{\winf@}{%
                        \raggedright\infof@nt\rightinf@\alignt@baseline
                    }%
                }%
            }

        \end{picture}%
    }
    \ifx\c@vergraphics\@empty
        \put(120,0){%
            \makebox(120,120)[\@ligncover]{%
                \parbox{12cm}{%
                     \raggedright\coverf@nt\c@vertext\alignt@baseline
                }%
            }%
        }
    \else
        \put(130,10){%
            \makebox(100,100)[\@ligncover]{%
                \parbox{10cm}{%
                     \raggedright\coverf@nt\c@vertext\alignt@baseline
                }%
            }%
        }
    \fi
\end{picture}%
\end{rotate}%
}
\DeclareRobustCommand*{\@skCDfile}[1]{%
\def\CDname{#1}%
\ifx\CDname\@empty
    \IfFileExists{\jobname.dat}{%
        \def\CDname{\jobname.dat}%
    }{%
        \typein[\CDname]{Please insert CD data file name:}%
    }%
\fi
\InputIfFileExists{\CDname.dat}{%
}{%
    \InputIfFileExists{\CDname}{%
    }{%
        \ClassError{cd}{CD data file (\CDname.dat or \CDname) not found}{}%
    }
}%
}

\DeclareRobustCommand*{\makeCD}[1][]{%
\@skCDfile{#1}\makecover\par\makeback\par
}

\DeclareRobustCommand*{\makeslimCD}[1][]{%
\@skCDfile{#1}\makeslimcover\par
}

\newread\CDlist

\newcounter{@cd}
\setcounter{@cd}{0}

\newif\ifne@f

\DeclareRobustCommand*{\@sklistfile}[1]{%
\def\CDlistname{#1}%
\ifx\CDlistname\@empty
    \IfFileExists{\jobname.lst}{%
        \def\CDlistname{\jobname.lst}%
    }{%
        \typein[\CDlistname]{Please insert CD list file name:}
    }%
\fi
\IfFileExists{\CDlistname.lst}{%
    \immediate\openin\CDlist=\CDlistname.lst
    }{%
        \IfFileExists{\CDlistname}{%
            \immediate\openin\CDlist=\CDlistname
        }{%
            \ClassError{cd}{CD list (\CDlistname.lst or \CDlistname) not found}{}%
        }
    }
\ne@ftrue
}

\DeclareRobustCommand*{\makelist}[1][]{%
\@sklistfile{#1}%
\advance\endlinechar\@M
\immediate\read\CDlist to \CDname
\advance\endlinechar-\@M
\ifeof\CDlist\ne@ffalse\fi
\@whilesw \ifne@f \fi {%
    \newcd
    \InputIfFileExists{\CDname.dat}{%
    }{%
        \InputIfFileExists{\CDname}{%
        }{%
            \ClassError{cd}{CD data file (\CDname.dat or \CDname) not found}{}%
        }%
    }%
    \advance\endlinechar\@M
    \immediate\read\CDlist to \CDname
    \advance\endlinechar-\@M
    \ifeof\CDlist\ne@ffalse\fi
    \ifodd\value{@cd}%
        \makeback[lrb]\par\makecover\par
    \else
        \makecover\par\ifne@f\makeback[lrt]\else\makeback\fi\par
    \fi
    \addtocounter{@cd}{1}%
}
}

\DeclareRobustCommand*{\makeslimlist}[1][]{%
\@sklistfile{#1}%
\advance\endlinechar\@M
\immediate\read\CDlist to \CDname
\advance\endlinechar-\@M
\ifeof\CDlist\ne@ffalse\fi
\@whilesw \ifne@f \fi {%
    \newcd
    \InputIfFileExists{\CDname.dat}{%
    }{%
        \InputIfFileExists{\CDname}{%
        }{%
            \ClassError{cd}{CD data file (\CDname.dat or \CDname) not found}{}%
        }%
    }%
    \advance\endlinechar\@M
    \immediate\read\CDlist to \CDname
    \advance\endlinechar-\@M
    \ifeof\CDlist\ne@ffalse\fi
    \makeslimcover\par
}
}

\endinput
%%
%% End of file `cd.cls'.
