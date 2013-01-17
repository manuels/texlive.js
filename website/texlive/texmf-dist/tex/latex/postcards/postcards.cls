% `postcards.cls' - a letter-based class used to print multiple
% 5.5 x 3.5'' postcards via the `envlab' and `mailing' packages.

%  author: bil kleb <w.l.kleb@larc.nasa.gov>
%    date: 14 aug 1999
% version: 0.1
% license: lppl


% begin the beginning:

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{postcards}[1999/08/14 v0.1 multiple postcards class]


% load the standard latex letter class:

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions\relax
\LoadClass[landscape]{letter}

% strip the return address, date, and to-address from the
% standard letter class opening:
\renewcommand*{\opening}[1]{\thispagestyle{firstpage}#1\par\nobreak}

% reduced vertical space allowed for signature in closing:
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
  \stopbreaks
  \noindent
  \ifx\@empty\fromaddress\else
  \hspace*{\longindentation}\fi
  \parbox{\indentedwidth}{\raggedright
       \ignorespaces #1\\[3\medskipamount]% [wlk: was 6]
       \ifx\@empty\fromsig
           \fromname
       \else \fromsig \fi\strut}%
   \par}


% use `geometry' package to specify new page size and layout:

\RequirePackage[papersize={3.5in,5.5in},% postcard size
               margin=0.375in,% margins
               landscape,%    % landscape page orientation
               voffset=5in,%  % moves ``page'' to upper left corner
               noheadfoot%    % no header or footers
               ]{geometry}[1998/04/08]


% use `envlab' package to print address ``labels'' on the postcards:

\RequirePackage[norotateenvelopes,% landscape mode from above
                                  % already rotates the
                                  % ``envelopes''
                alwaysbarcodes% necessary since we're using the
                              % mailing package (see envlab
                              % guide)
                ]{envlab}[1997/07/16]

% set postcard size:
\SetEnvelope{5.5in}{3.5in}

% change a margin:
\setlength{\ToAddressTopMargin}{0.25in}% [default is 0.5in]

% set to-address flush right instead of centered:
\renewcommand{\PrintEnvelope}[2]{%
  \begin{minipage}[t][\EnvelopeHeight]{\EnvelopeWidth}%
    \baselineskip=0pt%
    \lineskip=0pt%
    \parindent=0pt%
    \PrintReturnAddress{#1}\\%
    \begin{flushright}%
      \PrintAddress{#2}%
    \end{flushright}%
  \end{minipage}}
\makelabels


% load `mailing' package to handle multiple addresses:

\RequirePackage{mailing}[1999/03/03]

% this package requires a database file containing addresses of the form:
%
%   name
%   street\\town
%   opening
%   [blank line]
%
% via the \addressfile{databasefilename} command in the preamble


% automatically put the \makemailing command
% at the beginning of the document:

\AtBeginDocument{\makemailing}
