% harnon-cv.cls
% By William Hart, 2012
%
% A template for providing a neat CV
% Find it at https://github.com/mecharius/latex-timelineCV
%
% Released as public domain, so use in any way you see fit
% with no warranty.
%


\ProvidesClass{harnon-cv}
\LoadClass[a4paper, 11pt]{article}

% margins
\usepackage[top=0.75in,bottom=0.75in,left=0.75in,right=0.75in]{geometry}

% turn off all page styling
\pagestyle{plain}
\usepackage{nopageno}

% add etoolbox for if/then/else enhancements
\usepackage{etoolbox}

% framed package for borders
\usepackage{framed}

% define a custom timeline framed section based on leftbar
\newenvironment{timelinebar}{%
	\def\FrameCommand{\color{verylightgrey}\vrule width 1pt \hspace{10pt}\color{black}}%
	\MakeFramed {\advance\hsize-\width \FrameRestore}}%
{\endMakeFramed}
 
% package for tables
\usepackage{tabularx}

% fields that user can set
\makeatletter

	\newcommand{\yourname}[1]{\def \@yourname{#1}}
	\newcommand{\yournumber}[1]{\def \@yournumber{#1}}
	\newcommand{\youraddress}[1]{\def \@youraddress{#1}}
	\newcommand{\youremail}[1]{\def \@youremail{#1}}
	\newcommand{\yourwebsite}[1]{\def \@yourwebsite{#1}}
	\newcommand{\recenthistory}[1]{\def \@recenthistory{#1}}

	\yourname{}
	\yournumber{}
	\youraddress{}
	\youremail{}
	\yourwebsite{}
	\recenthistory{}
	
	% redefine the author command
	\renewcommand{\author}[1]{\yourname{#1}}
\makeatother

% images - such as a headshot if desired
\usepackage[pdftex]{graphicx}

% colours
\usepackage{xcolor}
\definecolor{verylightgrey}{rgb}{0.85,0.85,0.85}
\definecolor{lightgrey}{rgb}{0.5,0.5,0.5}
\definecolor{darkgrey}{rgb}{0.3,0.3,0.3}

% fonts
\usepackage[default]{cantarell}
\usepackage[T1]{fontenc}

% set some default lengths
\setlength{\parindent}{18pt}

% some custom font styling
\makeatletter
	% for document headers
	\newcommand{\adddocumentheader}[1]{{\huge \textsc{#1}}}

	% for section headers
	\newenvironment{sectionheader}{\vspace{1.2cm} \color{darkgrey} \LARGE \noindent}{\par\vspace{3mm}}
	\newcommand{\addheadertext}[1]{\begin{sectionheader}#1\end{sectionheader}}
	
	% for sub headings
	\newenvironment{subheader}{\color{darkgrey} \large}{\par}
	\newcommand{\addsubheader}[1]{\begin{subheader}#1\end{subheader}}

	% for bold callouts
	\newenvironment{callout}{\color{darkgrey} \large}{}
	\newcommand{\addcallout}[1]{\begin{callout}#1\end{callout}}

	% for timeline headers
	\newenvironment{timelineheader}{\color{lightgrey}  \large}{}
	\newcommand{\addtimelineheader}[1]{\begin{timelineheader}#1\end{timelineheader}}

	% for list items with a particular format
	\newcommand\listitem[1]{\item{\addcallout{#1}\enspace}}
\makeatother

% title
\makeatletter
\def \@maketitle {%
	\noindent\begin{minipage}{0.5\textwidth}
		\begin{flushleft}
			\ifdefempty{\@yourname}{\relax}{\adddocumentheader{\@yourname}\\}
			\ifdefempty{\@youremail}{\relax}{l\small\@youremail\\}
			\ifdefempty{\@yourwebsite}{\relax}{\small\url{\@yourwebsite}\\}
			\ifdefempty{\@yournumber}{\relax}{\small\@yournumber}
		\end{flushleft}
	\end{minipage}
	\begin{minipage}{0.5\textwidth}
		\begin{flushright}
			\ifdefempty{\@youraddress}{\relax}{\hfill\small\@youraddress}
		\end{flushright}
	\end{minipage}
	
	% add a closing rule
	\vspace{0.5cm}
	\noindent\rule{\textwidth}{0.2mm}
	
	% draw recent history if there is any
	\ifdefempty{\@recenthistory}{\relax}{%
		\vspace{7mm}
		\noindent\@recenthistory\\

		% add a closing rule
		\noindent\rule{\textwidth}{0.2mm}
	}
	\vspace{-1cm}
}
\makeatother

% timeline
\makeatletter

	% start a timeline - fixes spacing before the timeline
	\newcommand{\starttimeline}{\vspace{0.2cm}}
	
	% end a timeline - fix up spacing after a timeline
	\newcommand{\stoptimeline}{\vspace{0.5cm}}
	
	% add a timeline bullet point
	\newenvironment{timelinebullet}{\leftskip=12mm \parindent=-6mm $\bullet$ \hspace{2mm}}{\par\parindent=18pt}
	\newcommand{\addtimelinebullet}[1]{\begin{timelinebullet}#1\end{timelinebullet}}
	
	% recent summary listing in the form of a timeline - takes 2 arguments
	%   - First is the 'year' or date you want to apply
	%   - Second is the comments against that date
	\newcommand{\timelineitem}[2]{
		\noindent
		\begin{minipage}[t]{0.2\textwidth}
			\vspace{0.2cm}
			\begin{center}
				\addtimelineheader{#1}\quad\color{verylightgrey}\leaders\vrule height 5pt depth -4pt \hfill\color{black} \null
			\end{center}
		\end{minipage}
		\hspace{-2mm}
		\begin{minipage}[t]{0.8\textwidth}
			\begin{timelinebar}
				\vspace{2mm}
				#2
				\vspace{4mm}
			\end{timelinebar}
		\end{minipage}
		\vspace{-1cm}
	}

	% make a timeline space, between two timeline items to pad them out
	\newcommand{\timelinespacer}{
		\par\noindent\begin{minipage}{0.2\textwidth}\quad\end{minipage}
		\hspace{-2mm}
		\begin{minipage}{0.8\textwidth}\begin{timelinebar}
			\vspace{1.5cm}\quad
		\end{timelinebar}\end{minipage}\par
		\vspace{-5mm}
	}
\makeatother

% hyperref package for links etc
\usepackage{hyperref}