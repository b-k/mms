m4_divert(-1)
m4_changecom()
m4_changequote(`<|', `|>')

m4_define(<|define_blind|>, <|_define_blind(<|$1|>, <|$2|>, <|$|><|#|>, <|$|><|0|>)|>)
m4_define(<|_define_blind|>, <|m4_define(<|$1|>, <|m4_ifelse(<|$3|>, <|0|>, <|<|$4|>|>, <|$2|>)|>)|>)


m4_ifelse(MMSDocType, TeXDoc, <|define_blind(TeX, <|$*|>)define_blind(HTML,)|>, <|define_blind(TeX,)define_blind(HTML, <|$*|>)|>)

define_blind(Comment, <||>)

define_blind(<|NewMMS|>, <|define_blind($1, <|TeX(<|$2|>)HTML(<|$3|>)|>)|>)

NewMMS(em, <|{\em $*}|>,  <|<em>$*</em>|>)
NewMMS(sc, <|{\sc $*}|>,  <|<sc>$*</sc>|>)
NewMMS(bf, <|{\bf $*}|>,  <|<b>$*</b>|>)

Two types of teletype
NewMMS(tt, <|\verb@$*@|>,  <|<tt>$*</tt>|>)
NewMMS(Tt, <|{\tt $*}|>, <|<tt>$*</tt>|>)

NewMMS(Chapter, <|\section{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h1>$1</h1>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)

NewMMS(Section, <|\subsection{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h2>$1</h2>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)

NewMMS(Subsection, <|\subsubsection{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                   <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h3>$1</h3>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)

NewMMS(Paragraph, <|\paragraph{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                  <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h6>$1</h6>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)


NewMMS(Block, <|\begin{quote}$*\end{quote}|>,
              <|<blockquote><p>$*</blockquote>|>)

Figures take (filename, scaling, caption). The label associated is the filename with everything after
the dot replaced with pic. E.g., pants.jpg ==> pantspic.
NewMMS(Pic, <|\begin{figure}[htb]
            \begin{center}
            \scalebox{90}{$1}
             \caption{$3}
             \label{m4_patsubst($1, <|\..*|>, <|pic|>)}
           \end{center}
           \end{figure}
            |>,
    <|<a href="#<||>m4_patsubst($1, <|\..*|>, <|pic|>)"><img src="$1" alt="$3" width="90%"></a>|>)

TeX(<|define_blind(Items,
            <|\begin{itemize}
            \setlength{\itemsep}{0pt}
            \setlength{\parskip}{0pt}
            \setlength{\parsep}{0pt}
            m4_patsubst(<|$@|>, <|∙|>, <|\\item |>)\end{itemize}|>
)|>)

HTML version produces a <ul></li> that has to be cut down by sed to <ul>
HTML(<|define_blind(Items,
        <|<ul>m4_patsubst(<|$@|>, <|∙|>, <|</li>
            <li>|>)
        </li></ul>|>
)|>)

NewMMS(Citet, <|\citet{$1}|>,
              <|<a href="#$1">$2</a>|>)

NewMMS(Citep, <|\citep<||>m4_ifelse($2,<||>,<||>,<|[$2]|>){$1}|>,
              <|(<a href="#$1">$1<||>m4_ifelse($2,<||>,<||>,<|, $2|>)</a>)|>)


NewMMS(Link, <|\link{m4_shift($*)}{$1}|>,
                   <|<a href="$1">m4_shift($*)</a>|>)

NewMMS(PRef, <|$1 (page \pageref{m4_translit(<|$2|>, '
')})|>
           , <|<a href="#<||>m4_translit(<|$2|>, '
')">$1</a>|>)

NewMMS(Ref, <|\ref{m4_translit(<|$2|>, '
')}|>
        , <|<a href="#<||>m4_translit(<|$2|>, '
')">$1</a>|>)


m4_divert(9)
HTML(<|
</P>
</body></html>
|>)
TeX(<|
m4_ifelse(<|MMSBibfile|>, <||>, <||>, <|\bibliographystyle{MMSBibstyle}
    \bibliography{MMSBibfile}
    |>)
\end{document}|>)
m4_divert(0)
HTML(<|
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html> <head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
     <title>MMSTitle</title>


<!-- LaTeX math -->
<script type="text/javascript" src="http://cdn.mathjax.org/mathjax/latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML"></script>
<script type="text/x-mathjax-config">
      MathJax.Hub.Config({tex2jax: {inlineMath: [['$','$'], ['\\(','\\)']],
      processEscapes: true}});
</script>

m4_ifelse(<|MMSHTMLHead|>, <||>, <||>, <|m4_include(MMSHTMLHead)|>)

     </head><body>
     <h1>MMSTitle</h1>

        
        <P>|>)
TeX(<|
\documentclass{article}
\usepackage[utf8]{inputenc}

\usepackage{epsfig,amsfonts,natbib,url,xspace,listings}

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

\renewcommand{\sfdefault}{phv}
\usepackage{times, epsfig, latexsym, setspace, verbatim}

\def\link#1#2{#1\footnote{\url{#2}}}

%I think the Computer Modern teletype is too wide.
\usepackage[T1]{fontenc}
\renewcommand\ttdefault{cmtt}

\def\Re{{\mathbb R}}

m4_ifelse(<|MMSPreamble|>, <||>, <||>, <|m4_include(MMSPreamble)|>)

\begin{document}
\title{MMSTitle}
\author{MMSAuthor}
\maketitle
|>)
