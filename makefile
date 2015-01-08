# This makefile assumes it is being called by the client makefile in the project directory.

MMS_dir:=$(shell pwd)

pdf:
	mkdir -p $(Base)/$(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | \
		m4 -P -DMMSTitle="$(Title)" -DMMSAuthor="$(Author)" \
			  -DMMSBibfile=`basename $(Bib_file)`           \
		      -D MMSDocType=TeXDoc $(MMS_dir)/common.m4 $(MMS_dir)/textify.m4  - | \
		sed -e 's/…/.../g' -e 's/&gt;/>/' -e 's/&lt;/</' > $(Base)/$(Out)/$(Out_name).tex ;
	if [ "$(Base)/$(Extra_files)" != "$(Base)/" ] ; then \
		cd $(Base) && cp $(Extra_files) $(Base)/$(Out); \
	fi
	cd $(Base)/$(Out) && pdflatex $(Out_name).tex;
	if [ "x$(Bib_file)" != "x" ] ; then \
		cp $(Base)/$(Bib_file) $(Base)/$(Out)&& \
	    cd $(Base)/$(Out);                      \
	    bibtex $(Out_name) ;                       \
	    pdflatex $(Out_name).tex;                  \
	    pdflatex $(Out_name).tex;                  \
	fi

insert_ps:

html: insert_ps
	mkdir -p $(Base)/$(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | m4 -P $(MMS_dir)/common.m4 - | sed -e 's|<ul> *</li>|<ul>|' | $(MMS_dir)/insert_ps | \
        sed -e 's/<p><h6>/<h6>/' -e 's|</h6></p>|</h6>|' -e 's|<p></li>|</li>|g'\
        -e '$d' -e 's/``/“/g' -e 's/\\dots/…/g' -e 's/\\%/%/g' -e 's/\\#/#/g' -e 's/---/—/g'\
            |awk -f $(MMS_dir)/awk_cut > $(Base)/$(Out)/$(Out_name).html;
	if [ "x$(Bib_file)" != "x" ] ; then \
		mkdir -p $(Base)/$(Out)/bib;    \
		cp $(Base)/$(Bib_styles) $(Base)/$(Out)/bib; \
		Base=$(Base) Bib_file="$(Base)/$(Bib_file)" Bob="$(Base)/$(Out)/bib" $(MMS_dir)/bib2html; \
		echo "<h2>Bibliography</h2>" > $(Base)/$(Out)/bib/xxx;                         \
	else                                                                               \
		touch $(Base)/$(Out)/bib/xxx  $(Base)/$(Out)/bib/bibshell.html;                \
	fi
		cat $(MMS_dir)/head.html $(Base)/$(Out)/$(Out_name).html $(Base)/$(Out)/bib/xxx  $(Base)/$(Out)/bib/bibshell.html $(MMS_dir)/tail.html > $(HTMLout)/index.html
	if [ "$(Base)/$(Extra_files)" != "$(Base)" ] ; then \
	    cd $(Base) && cp $(Extra_files) $(HTMLout) \
	fi

push:
	cd $(HTMLout) && git commit -a -m "Another update." && git push origin gh-pages
