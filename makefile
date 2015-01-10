# This makefile assumes it is being called by the client makefile in the project directory.

MMS_dir:=$(shell pwd)

pdf:
	mkdir -p $(Base)/$(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | \
		m4 -P -DMMSTitle="$(Title)" -DMMSAuthor="$(Author)" \
			  -DMMSBibfile=`basename $(Bib_file)` -DMMSBibstyle=$(Bib_style) -DMMSPreamble=$(Preamble) \
		      -D MMSDocType=TeXDoc $(MMS_dir)/common.m4 - | \
		sed -e 's/…/.../g' -e 's/&gt;/>/' -e 's/&lt;/</' > $(Base)/$(Out)/$(Out_name).tex ;
	-if [ "$(Base)/$(Extra_files)" != "$(Base)/" ] ; then \
		cd $(Base) && cp $(Extra_files) $(Base)/$(Out); \
	fi
	cd $(Base)/$(Out) && pdflatex $(Out_name).tex;
	if [ "x$(Bib_file)" != "x" ] ; then \
		cp $(Base)/$(Bib_file) $(Base)/$(Bib_style_files)  $(Base)/$(Out)&& \
	    cd $(Base)/$(Out);                      \
	    bibtex $(Out_name) ;                       \
	    pdflatex $(Out_name).tex;                  \
	    pdflatex $(Out_name).tex;                  \
	fi

insert_ps:

html: insert_ps
	mkdir -p $(Base)/$(Out)
	cd $(Base) && cat $(Files) | sed 's/,/<|,|>/g' | sed 's/~~/,/g' | \
		m4 -P -DMMSTitle="$(Title)" -DMMSAuthor="$(Author)"  -DMMSHTMLHead=$(HTMLHeader) \
			  -DMMSBibfile=`basename $(Bib_file)` -DMMSBibstyle=$(Bib_style) \
  	$(MMS_dir)/common.m4 - | sed -e 's|<ul> *</li>|<ul>|' | $(MMS_dir)/insert_ps | \
        sed -e 's/<p><h6>/<h6>/' -e 's|</h6></p>|</h6>|' -e 's|<p></li>|</li>|g'\
        -e '$d' -e 's/``/“/g' -e 's/\\dots/…/g' -e 's/\\%/%/g' -e 's/\\#/#/g' -e 's/---/—/g'\
            |awk -f $(MMS_dir)/awk_cut > $(Base)/$(Out)/$(Out_name).html;
	if [ "x$(Bib_file)" != "x" ] ; then \
		mkdir -p $(Base)/$(Out)/bib;    \
		cp $(Base)/$(Bib_style_files) $(Base)/$(Out)/bib;  \
		Base=$(Base) Bib_file="$(Base)/$(Bib_file)"   \
		Bibstyle=$(Bib_style)                         \
		Bob="$(Base)/$(Out)/bib" $(MMS_dir)/bib2html; \
		echo "<h2>Bibliography</h2>" > $(Base)/$(Out)/bib/xxx;                         \
	else                                                                               \
		touch $(Base)/$(Out)/bib/xxx  $(Base)/$(Out)/bib/bibshell.html;                \
	fi
		cat $(Base)/$(Out)/$(Out_name).html $(Base)/$(Out)/bib/xxx  $(Base)/$(Out)/bib/bibshell.html > $(HTMLout)/index.html
	-if [ "x$(Extra_files)" != "x" ] ; then \
	    cd $(Base) && cp $(Extra_files) $(HTMLout); \
	fi

push:
	cd $(HTMLout) && git checkout -B gh-pages 
	cd $(HTMLout) && git add $(Extra_files) index.html && git commit -a -m "Another update." && git push origin gh-pages
