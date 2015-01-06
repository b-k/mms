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

NewMMS(Section, <|\section{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h2>$1</h2>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)

NewMMS(Subsection, <|\subsection{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                   <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h3>$1</h3>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)

NewMMS(Paragraph, <|\paragraph{$1}<||>m4_ifelse($2,<||>,<||>,<|\label{$2}|>)|>,
                  <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h6>$1</h6>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)


NewMMS(Block, <|\begin{quote}$*\end{quote}|>,
              <|<blockquote><p>$*</blockquote>|>)


HTML version produces a <ul></li> that has to be cut down by sed to <ul>
TeX(define_blind(Items,
            <|\begin{itemize}
            \setlength{\itemsep}{0pt}
            \setlength{\parskip}{0pt}
            \setlength{\parsep}{0pt}
            m4_patsubst(<|$@|>, <|∙|>, <|\\item |>)\end{itemize}|>
))
HTML(define_blind(Items,
        <|<ul>m4_patsubst(<|$@|>, <|∙|>, <|</li>
            <li>|>)
        </li></ul>|>
))

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


HTML(
m4_divert(9)
</P>
m4_divert(0)
<P>
)
