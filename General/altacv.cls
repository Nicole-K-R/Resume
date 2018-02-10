\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{altacv}[2017/04/30 AltaCV v1.1.3, yet another alternative class for a résumé/curriculum vitae.]
%% v1.1: Optionally load academicons
\newif\if@academicons
\DeclareOption{academicons}{\@academiconstrue}
%% v1.1.3: Choice of round/square photo
\newif\if@normalphoto
\DeclareOption{normalphoto}{\@normalphototrue}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\LoadClass{extarticle}

\RequirePackage[margin=2cm]{geometry}
\RequirePackage{fontawesome}

%% v1.1: Optionally load academicons
\if@academicons
  %% Patch to make academicons compilable with XeLaTeX
  \ExplSyntaxOn
  \msg_redirect_name:nnn { fontspec } { font-not-found } { none }
  \ExplSyntaxOff
  \RequirePackage{academicons}
  \newfontfamily{\AI}{academicons.ttf}
\fi

\RequirePackage{xcolor}

\colorlet{accent}{blue!70!black}
\colorlet{heading}{black}
\colorlet{emphasis}{black}
\colorlet{body}{black!80!white}
\newcommand{\itemmarker}{{\small\textbullet}}
\newcommand{\ratingmarker}{\faCircle}

\RequirePackage{tikz}
\usetikzlibrary{arrows}
\RequirePackage[skins]{tcolorbox}
\RequirePackage{enumitem}
\setlist{leftmargin=*,labelsep=0.5em,nosep,itemsep=0.25\baselineskip,after=\vskip0.25\baselineskip}
\setlist[itemize]{label=\itemmarker}
\RequirePackage{graphicx}
\RequirePackage{etoolbox}
\RequirePackage{dashrule}
\RequirePackage{multirow,tabularx}
\RequirePackage{changepage}
% \RequirePackage{marginfix}

\setlength{\parindent}{0pt}
\newcommand{\divider}{\textcolor{body!30}{\hdashrule{\linewidth}{0.6pt}{0.5ex}}\medskip}

\newenvironment{fullwidth}{%
  \begin{adjustwidth}{}{\dimexpr-\marginparwidth-\marginparsep\relax}}
  {\end{adjustwidth}}

\newcommand{\emailsymbol}{\faAt}
\newcommand{\phonesymbol}{\faPhone}
\newcommand{\homepagesymbol}{\faChain}
\newcommand{\locationsymbol}{\faMapMarker}
\newcommand{\linkedinsymbol}{\faLinkedin}
\newcommand{\twittersymbol}{\faTwitter}
\newcommand{\githubsymbol}{\faGithub}
\newcommand{\orcidsymbol}{\aiOrcid}
\newcommand{\mailsymbol}{\faEnvelope}

\newcommand{\printinfo}[2]{\mbox{\textcolor{accent}{#1}\hspace{0.5em}#2\hspace{2em}}}

% *** Header *** %
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\tagline}[1]{\def\@tagline{#1}}
% *** Contact Info (Text) *** %
\newcommand{\phoneText}[1]{\def\@phoneText{#1}}
\newcommand{\emailText}[1]{\def\@emailText{#1}}
\newcommand{\webText}[1]{\def\@webText{#1}}
\newcommand{\githubText}[1]{\def\@githubText{#1}}
\newcommand{\linkedinText}[1]{\def\@linkedinText{#1}}
% *** Contact Info (Symbols) *** %
\newcommand{\email}[1]{\printinfo{\emailsymbol}{#1}}
\newcommand{\mailaddress}[1]{\printinfo{\mailsymbol}{#1}}
\newcommand{\phone}[1]{\printinfo{\phonesymbol}{#1}}
\newcommand{\homepage}[1]{\printinfo{\homepagesymbol}{#1}}
\newcommand{\twitter}[1]{\printinfo{\twittersymbol}{#1}}
\newcommand{\linkedin}[1]{\printinfo{\linkedinsymbol}{#1}}
\newcommand{\github}[1]{\printinfo{\githubsymbol}{#1}}
% *** Icons *** %
\newcommand{\location}[1]{\printinfo{\locationsymbol}{#1}}
% *** Font Sizes *** %
\newcommand\HUGE{\@setfontsize\Huge{25}{30}} 
\newcommand\contactSize{\@setfontsize\tiny{3}{3.5}} 

% ***** Header ***** %
\newcommand{\makecvheader}{%
  \begingroup
    \raggedright\color{emphasis}%
    {\HUGE\bfseries\MakeUppercase{\@name}\par}
    \medskip
    {\LARGE\bfseries\color{accent}\@tagline\par}
  \endgroup\bigskip
}

% ***** Contact Info ***** %
\newcommand{\contactInfo}[2]{
  \begingroup
  \begin{changemargin}{-0.03cm}{0cm} %% Add left margin
{\phone\contactSize\color{emphasis}\@phoneText\scalebox{0.8}\par}
{\mailaddress\contactSize\color{emphasis}\@emailText\scalebox{0.8}\par}
{\homepage\contactSize\color{emphasis}\@webText\scalebox{0.8}\par}
{\github\contactSize\color{emphasis}\@githubText\scalebox{0.8}\par}
{\linkedin\contactSize\color{emphasis}\@linkedinText\scalebox{0.8}\par}
   \end{changemargin}
  \endgroup\smallskip
}

% ***** cvsection ***** %
\newcommand{\cvsection}[2][]{%
	\smallskip
  \ifstrequal{#1}{}{}{\marginpar
  {\vspace*
  	% \dimexp #pt defines the vertical displacement of the right column
  	{\dimexpr-53pt-\baselineskip}\raggedright\input{#1}
  }}%
  {\color{heading}\LARGE\bfseries\MakeUppercase{#2}}\\[-1ex]%
  {\color{heading}\rule{\linewidth}{2pt}\par}\medskip % Underline
}

% ***** cvsubsection ***** %
\newcommand{\cvsubsection}[1]{%
  \smallskip%
  {\color{emphasis}\large\bfseries{#1}\par}\medskip
}

% ***** cvevent ***** %
\newcommand{\cvevent}[4]{%
  {\large\color{emphasis}#1\par} % Job title
  \smallskip
  \textbf{\color{emphasis}#2}\par % Company
  \smallskip 
  % Time range
  {\small\makebox[0.77\linewidth][l]{\faCalendar \hspace{0.5em}#3}%
  \ifstrequal{#4}{}{}{\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}#4}}\par} % Location
  \smallskip
}

% ***** cvproject ***** %
\newcommand{\cvproject}[4]{%
  {\large\color{emphasis}#1\par} % Job title
  \smallskip
  % Time range
  {\small\makebox[0.77\linewidth][l]{\faCalendar \hspace{0.5em}#2}%
  \ifstrequal{#3}{}{}{\makebox[0.5\linewidth][l]{\faMapMarker\hspace{0.5em}#3}}\par} % Location
  \smallskip
}

% ***** cvskill ***** %
\newcommand{\cvskill}[2]{%
\textcolor{emphasis}{\textbf{#1}}\hfill
\foreach \x in {1,...,5}{%
  \space{\ifnumgreater{\x}{#2}{\color{body!30}}{\color{accent}}\faCircle}}\par%
}

% ***** cvskillType ***** %
\newcommand{\cvskillType}[2]{%
	\textcolor{accent}{\Large\textbf{#1}}\hfill
}

% ***** cvachievement ***** %
\newcommand{\cvachievement}[3]{%
  \begin{tabularx}{\linewidth}{@{}p{2em} @{\hspace{1ex}} >{\raggedright\arraybackslash}X@{}}
  \multirow{2}{*}{\Large\color{accent}#1} & \bfseries\textcolor{emphasis}{#2}\\
  & #3
  \end{tabularx}%
  \smallskip
}

% ***** cvtag ***** %
\newcommand{\cvtag}[1]{%
  \tikz[baseline]\node[anchor=base,draw=body!30,rounded corners,inner xsep=1ex,inner ysep =0.75ex,text height=1.5ex,text depth=.25ex]{#1};
}

\RequirePackage[backend=biber,style=authoryear,sorting=ydnt]{biblatex}
\defbibheading{pubtype}{\cvsubsection{#1}}
\renewcommand{\bibsetup}{\vspace*{-\baselineskip}}
\AtEveryBibitem{\makebox[\bibhang][l]{\itemmarker}}
\setlength{\bibitemsep}{0.25\baselineskip}

% v1.1.2: make it easier to add a sidebar aligned with top of next page
\RequirePackage{afterpage}
\newcommand{\addsidebar}[2][]{\marginpar{%
  \ifstrequal{#1}{}{}{\vspace*{#1}}%
  \input{#2}}%
}
\newcommand{\addnextpagesidebar}[2][]{\afterpage{\addsidebar[#1]{#2}}}

\AtBeginDocument{%
  \pagestyle{empty}
  \color{body}
  \raggedright
}
