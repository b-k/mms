define_blind(Verbatim, <|\begin{verbatim}
$*
\end{verbatim}|>)


define_blind(Pic, <|\begin{figure}[htb]
    \begin{center}
    \begin{tabular}{cc}
    \rotatebox{90}{\abox{$2}{../asst/$1}}
    \end{tabular}

    \caption{$3}
    \label{m4_patsubst($1, <|\..*|>, <||>)}
    \end{center}
\end{figure}
|>)



Here comes the LaTeX header. It is cut/pasted/modified from another document, where it was cut/pasted/modified from another document, ..., meaning that it has a lot that could be excised.

First the ending, stored in m4 buffer 9, then we return to buffer 0 to start from the beginning.
m4_divert(9)
\bibliographystyle{plainnat}
\bibliography{tea}
\end{document}
m4_divert(0)

\documentclass{article}
\usepackage[utf8]{inputenc}

\long\def\comment#1{}
\long\def\cmt#1{}
\long\def\todo#1{}

\usepackage{moreverb, epsfig,calc,amsfonts,natbib,url,xspace,listings,ifthen, float}
\newif\ifimputation
\imputationfalse

% Boldface vectors: \xv produces a boldface x, and so on for all of the following:
\def\definevector#1{\expandafter\gdef\csname #1v\endcsname{{\bf #1}\xspace}}
\def\definemathvector#1{\expandafter\gdef\csname #1v\endcsname{\mbox{{\boldmath$\csname #1\endcsname$}}}}
\definevector{b} \definevector{c} \definevector{d}
\definevector{i} \definevector{j} \definevector{k}
\definevector{p}
%u gets special treatment; see below
 \definevector{v} \definevector{w} \definevector{x} \definevector{y} \definevector{z}
\definevector{A} \definevector{B} \definevector{C} \definevector{D}
\definevector{I} \definevector{J} \definevector{K} \definevector{M}
\definevector{Q} \definevector{R} \definevector{S} \definevector{T} \definevector{U} \definevector{V}
\definevector{W} \definevector{X} \definevector{Y} \definevector{Z}
\def\uv{\mbox{{\boldmath$\epsilon$}}} 
\definemathvector{alpha} \definemathvector{beta} \definemathvector{gamma}
\definemathvector{delta} \definemathvector{epsilon} \definemathvector{iota} \definemathvector{mu}
\definemathvector{theta} \definemathvector{sigma} \definemathvector{Sigma}
\def\Xuv{\underbar{\bf X}}

%code listing:
\lstset{columns=fullflexible, basicstyle=\small,
    emph={size\_t,apop\_data,apop\_model,gsl\_vector,gsl\_matrix,gsl\_rng,FILE},emphstyle=\bfseries}
\def\setlistdefaults{\lstset{ showstringspaces=false,%
 basicstyle=\small, language=C, breaklines=true,caption=,label=%
,xleftmargin=.34cm,%
,frameshape=
,frameshape={nnnynnnnn}{nyn}{nnn}{nnnynnnnn}
}
\lstset{columns=fullflexible, basicstyle=\small, emph={size_t,apop_data,apop_model,gsl_vector,gsl_matrix,gsl_rng,FILE,math_fn},emphstyle=\bfseries}
}
\setlistdefaults

\newenvironment{items}{
\setlength{\leftmargini}{0pt}
\begin{itemize}
  \setlength{\itemsep}{3pt}
  \setlength{\parskip}{0pt}
  \setlength{\parsep}{3pt}
}{\end{itemize}}

\renewcommand{\sfdefault}{phv}
\usepackage{times}
\usepackage{epsfig}
\usepackage{latexsym}
\usepackage{setspace}
\usepackage{verbatim}

\def\link#1#2{#1\footnote{\url{#2}}}

%I think the Computer Modern teletype is too wide.
\usepackage[T1]{fontenc}
\renewcommand\ttdefault{cmtt}
\def\tab{\phantom{hello.}}

\def\Re{{\mathbb R}}
\def\tighten{ \setlength{\itemsep}{1pt}
    \setlength{\parskip}{0pt}}
\def\adrec{\textsc{AdRec}\xspace}

\newenvironment{key}[1]{ %
  \setlength{\parsep}{0pt} %
\hspace{-0.85cm} \textbf{#1}:\\ %
  \setlength{\parindent}{0pt} %
  \setlength{\parsep}{3pt} %
}{}

\begin{document}
\title{Tea for survey processing: a tutorial}
\author{Ben Klemens, Rolando Rodr\'iguez, David Vernet}
\maketitle
