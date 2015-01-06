m4_divert(-1)
m4_changecom()
m4_changequote(`<|', `|>')

m4_define(<|define_blind|>, <|_define_blind(<|$1|>, <|$2|>, <|$|><|#|>, <|$|><|0|>)|>)
m4_define(<|_define_blind|>, <|m4_define(<|$1|>, <|m4_ifelse(<|$3|>, <|0|>, <|<|$4|>|>, <|$2|>)|>)|>)

define_blind(PAR, <|</P><P>|>)

define_blind(TeX, <||>)
define_blind(HTML, <|$*|>)
define_blind(Comment, <||>)

define_blind(mm, <|<div class="math">$*</div>|>)
define_blind(tt, <|<tt>$*</tt>|>)
define_blind(Tt, <|<tt>$*</tt>|>)
define_blind(sc, <|<sc>$*</sc>|>)
define_blind(bf, <|<b>$*</b>|>)
define_blind(em, <|<em>$*</em>|>)

define_blind(Section, <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h2>$1</h2>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)
define_blind(Subsection, <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h3>$1</h3>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)
define_blind(Paragraph, <|m4_ifelse($2,<||>,<||>,<|<a name="$2">|>)<h6>$1</h6>m4_ifelse($2,<||>,<||>,<|</a>|>)<p>|>)
define_blind(Block, <|<blockquote><p>$*</blockquote>|>)

define_blind(PRef, <|<a href="#<||>m4_translit(<|$2|>, ' 	
')">$1</a>|>)
define_blind(Ref, <|<a href="#<||>m4_translit(<|$2|>, ' 	
')">$1</a>|>)

define_blind(Citet, <|<a href="#$1">$2</a>|>)
define_blind(Citep, <|(<a href="#$1">$1<||>m4_ifelse($2,<||>,<||>,<|, $2|>)</a>)|>)

define_blind(RCode, <|<div class="rcode"><pre><code>$1</code></pre></div>
|>)

define_blind(SpecCode, <|<div class="spec"><pre><code>$1</code></pre></div>
|>)

define_blind(InR, <|<div class="rcode"><pre><code># $1.R

m4_include(../$1<||>.R)
</code></pre></div>
|>)

define_blind(InSpec, <|<div class="spec"><pre><code># $1.spec

m4_include(../$1<||>.spec)
</code></pre></div>
|>)


define_blind(Link, <|<a href="$1">m4_shift($*)</a>|>)

Produces a <ul></li> that has to be cut down by sed to <ul>
define_blind(Items,
<|<ul>m4_patsubst(<|$@|>, <|∙|>, <|</li>
<li>|>)
</li></ul>|>)

m4_divert(9)
</P>
m4_divert(0)
<P>
