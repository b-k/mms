#Title=tea_tutorial
#Out=out
HTMLout=~/tmp/

MMS_dir:=$(shell pwd)

pdf:
	mkdir -p $(Base)/$(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | m4 -P $(MMS_dir)/textify.m4  - | \
		sed -e 's/…/.../g' -e 's/&gt;/>/' -e 's/&lt;/</' > $(Base)/$(Out)/`basename $(Title) .tex`.tex ;
	cd $(Base)/$(Out) && pdflatex $(Title).tex
	cd $(Base) && cp $(Extra_files) $(Base)/$(Out);
	if [ "x$(Bib_file)" != "x" ] ; then \
		cp $(Base)/$(Bib_file) $(Base)/$(Out) ; \
	    cd $(Base)/$(Out);                      \
	    bibtex $(Title) ;               \
	    pdflatex $(Title).tex;              \
	    pdflatex $(Title).tex;              \
	fi

HTMLout=~/tmp/tea-tutorial

insert_ps:

html: insert_ps
	mkdir -p $(Out)
	f=../tea_tutorial ;  \
		sed 's/,/<|,|>/g' $$f  | sed 's/~~/,/g' | m4 -P htmlify.m4  - | sed -e 's|<ul> *</li>|<ul>|' | insert_ps | \
        sed -e 's/<p><h6>/<h6>/' -e 's|</h6></p>|</h6>|' -e 's|<p></li>|</li>|g'\
        -e '$d' -e 's/``/“/g' -e 's/\\dots/…/g' -e 's/\\%/%/g' -e 's/\\#/#/g' -e 's/---/—/g'\
            |awk -f awk_cut > $(Out)/`basename $$f xx`.html;
	cd bib&&make
	echo "<h2>Bibliography</h2>" > $(Out)/xxx
	cat head.html $(Out)/tea_tutorial.html $(Out)/xxx  bib/bibshell.html tail.html > $(HTMLout)/index.html
	cp tutorial.css $(HTMLout)

push:
	cd $(HTMLout) && git commit -a -m "Another update." && git push origin gh-pages
	scp $(Out)/tea_tutorial.pdf klemens@klemens.org:/var/www/html/ben/pdfs/
