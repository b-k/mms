# This makefile assumes it is being called by the client makefile in the project directory.

MMS_dir:=$(shell pwd)

pdf:
	mkdir -p $(Base)/$(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | \
		m4 -P -D MMSDocType=TeXDoc $(MMS_dir)/common.m4 $(MMS_dir)/textify.m4  - | \
		sed -e 's/…/.../g' -e 's/&gt;/>/' -e 's/&lt;/</' > $(Base)/$(Out)/$(Title).tex ;
	cd $(Base)/$(Out) && pdflatex $(Title).tex
	cd $(Base) && cp $(Extra_files) $(Base)/$(Out);
	if [ "x$(Bib_file)" != "x" ] ; then \
		cp $(Base)/$(Bib_file) $(Base)/$(Out) ; \
	    cd $(Base)/$(Out);                      \
	    bibtex $(Title) ;                       \
	    pdflatex $(Title).tex;                  \
	    pdflatex $(Title).tex;                  \
	fi

HTMLout=~/tmp/tea-tutorial

insert_ps:

html: insert_ps
	mkdir -p $(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | m4 -P $(MMS_dir)/common.m4 - | sed -e 's|<ul> *</li>|<ul>|' | $(MMS_dir)/insert_ps | \
        sed -e 's/<p><h6>/<h6>/' -e 's|</h6></p>|</h6>|' -e 's|<p></li>|</li>|g'\
        -e '$d' -e 's/``/“/g' -e 's/\\dots/…/g' -e 's/\\%/%/g' -e 's/\\#/#/g' -e 's/---/—/g'\
            |awk -f $(MMS_dir)/awk_cut > $(Base)/$(Out)/$(Title).html;
	if [ "x$(Bib_file)" != "x" ] ; then \
		cd bib && Bib_file="$(Base)/$(Out)/$(Bib_file)" Bob="$(Base)/$(Out)/bib" make; \
		echo "<h2>Bibliography</h2>" > $(Base)/$(Out)/bib/xxx                          \
	else                                                                               \
		touch $(Base)/$(Out)/bib/xxx  $(Base)/$(Out)/bib/bibshell.html;                \
	fi
		cat $(MMS_dir)/head.html $(Base)/$(Out)/$(Title).html $(Base)/$(Out)/bib/xxx  $(Base)/$(Out)/bib/bibshell.html $(MMS_dir)/tail.html > $(HTMLout)/index.html
	cd $(Base) && cp $(Extra_files) $(HTMLout)

push:
	cd $(HTMLout) && git commit -a -m "Another update." && git push origin gh-pages
	scp $(Out)/tea_tutorial.pdf klemens@klemens.org:/var/www/html/ben/pdfs/
