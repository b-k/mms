The Malcontent Management System
================================

We write technical and academic documents, and are not happy with typical content management systems.

* The math has to look good.
* We have to get the references in the right style.
* We're posting one possibly very long document, not a daily sequence of short entries.
* We need a PDF and web version of the document.
* We are collaborating on one document, and some of our collaborators may not know the intricacies of LaTeX or HTML.


Setup and use
=============

Have a look at the manual (in the `manual` directory) for an example of how to format your documents. Your document will be plain text with occasional formatting elements like `Section(section head)` or `em(emphasized text)`.

The metadata about the project goes into a configuration/make file; copy the makefile in the manual directory to your project directory, and follow the instructions in that file to set the variables accordingly.
