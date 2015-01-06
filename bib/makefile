b=bibshell

bib:
	echo "\documentclass{article}	 \
	\usepackage[utf8]{inputenc}	 \
	\usepackage{chicago}	 \
	\begin{filecontents}{\jobname.bib}  " > $b.tex
	cat ../../tea.bib >> $b.tex
	echo "\end{filecontents}" >>$b.tex
	echo "\begin{document} \
	\nocite{*} \
	\bibliographystyle{chicago} \
	\bibliography{\jobname}  \
	\end{document}" >>$b.tex
	rm -f $b.bib
	latex $b
	-bibtex $b
	sed -e "/thebibliography/d"  < $b.bbl | \
	tr -d '\n' | \
	sed -e 's/\\bibitem[^]]*]{\([^}]*\)}/<\/p><p> [<a name="\1">\1<\/a>] /g' -e "s/\\newblock//g" \
		-e 's/\\newblock//g' -e "s/~/ /g" -e"s|\\\\/||g"		\
		-e 's/\%\([^ \t\n]\)/\1/g'		\
		-e 's/{\\em \([^}]*\)}/<em>\1<\/em>/g'  \
		-e 's/\\citeN{\([^}]*\)}/<a href="#\1">\1<\/a>/g'  \
		-e 's/[{}]//g'		> $b.html
