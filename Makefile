#
# Makefile
# Shlomi Fish, 2018-10-08 16:55
#

all: epub html pdf

SRC = README.asciidoc
OUT_base = testing-static-sites

DOCBOOK5_XSL_STYLESHEETS_PATH := /usr/share/sgml/docbook/xsl-ns-stylesheets
EPUB_SCRIPT = $(DOCBOOK5_XSL_STYLESHEETS_PATH)/epub/bin/dbtoepub
DBTOEPUB = ruby $(EPUB_SCRIPT)
EPUB = $(OUT_base).epub
DOCBOOK5 = $(OUT_base).docbook5.xml
PDF = $(OUT_base).pdf
XHTML = $(OUT_base).xhtml

html: $(XHTML)

$(EPUB): $(DOCBOOK5)
	$(DBTOEPUB) -o $@ $<

$(XHTML): $(SRC)
	asciidoctor --backend=xhtml5 -o $@ $<

$(DOCBOOK5): $(SRC)
	asciidoctor --backend=docbook5 -o $@ $<

$(PDF): $(DOCBOOK5)
	docmake -o $@ pdf $<

epub: $(EPUB)

pdf: $(PDF)

clean:
	rm -f $(DOCBOOK5) $(PDF) $(XHTML)

# MIT License
#
# Copyright (c) 2016 Shlomi Fish
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# vim:ft=make
#
