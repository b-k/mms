# Malcontent Management System configuration/make file

# Use this file by setting the variables at the top of the file, then running one of three
# commands:
#
# make
# to generate the PDF
#
# make html
# to generate the HTML document
#
# make push
# to upload the document github's pages.
#
# Combinations like
# make pdf html push
# or
# make html push
# also work.

# These variables all need to be on one line; extend lines with a \
# Any filenames are relative to this project directory. If typing *.bib
# on the command line finds your bibliography file(s), then you can use them here.
# If you have several files and a wildcard doesn't find them, you can list them, e.g.,
# FILES= intro.tex ch01.tex conclusion

# What shall we call the final .pdf and .html files?
Out_name=MMS_manual

# What title and author names to put on the page?
Title=The Malcontent Management System
Author=Ben Klemens

# What files provide the text of the document?
Files=manual

# If you have a bibliography database in the project directory, a references section will
# get added to the documents. Otherwise, leave this blank.
Bib_file=*.bib
Bib_style_files=chicago.*
# The style for your bibliography file. plainnat (plain natural) is a fine default.
Bib_style=plainnat

# These are files that may be inputs to other files, or are linked to: CSS, JPG, PNG, GIF,
# sample code, et cetera. They are copied  into $(Out) and $(HTMLout), so you don't
# have to do so yourself. Any directory structure is largely destroyed.
Extra_files=typical.css $(Out_name).pdf

# In what directory did you put the MMS?
MMS_dir=~/mms

# What shall I call the directory where all temp files and the final PDF will be written?
# This will be a subdirectory of the project directory. You may delete it at any time
# and all contents will be regenerated next time you rebuild. That means that you should
# not put anything there yourself; use Extra_files below to put things here.
Out=outputs

# A separate HTML output directory. If you are going to use the 'make push' command
# to push to a gh-pages branch, then this has to be a repository you have already cloned.
HTMLout=~/tmp/mms

# What file has LaTeX instructions that have to come before the \begin{document} (typically \usepackage commands)?
Preamble=

# What file has HTML instructions that go in the header?
HTMLHeader=





###########
# The rest of the file provides targets for this local makefile. You probably will
# never need to modify anything below here.

Base:=$(shell pwd)

pdf:
	cd $(MMS_dir) && Base=$(Base) Author="$(Author)" Title="$(Title)" Out_name="$(Out_name)" \
		Bib_file="$(Bib_file)" Bib_style_files="$(Bib_style_files)" Bib_style="$(Bib_style)" \
        Out=$(Out) Files="$(Files)" Extra_files="$(Extra_files)" make pdf

html:
	cd $(MMS_dir) && Base=$(Base) Author="$(Author)" Title="$(Title)" Out_name="$(Out_name)"  \
		Bib_file="$(Bib_file)" Bib_style_files="$(Bib_style_files)" Bib_style="$(Bib_style)" \
        HTMLout=$(HTMLout) Out=$(Out) Files="$(Files)" Extra_files="$(Extra_files)" make html

push:
	cd $(MMS_dir) && HTMLout=$(HTMLout) Extra_files="$(Extra_files)" make push
