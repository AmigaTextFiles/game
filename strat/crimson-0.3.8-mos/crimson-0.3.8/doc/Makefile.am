if BUILD_BI2CF
BI2CF_MAN = bi2cf.6
endif
if BUILD_CFED
CFED_MAN = cfed.6
endif
if BUILD_COMET
COMET_MAN = comet.6
endif
man_MANS = $(BI2CF_MAN) $(CFED_MAN) $(COMET_MAN) crimson.6
EXTRA_DIST = bi2cf.6 cfed.6 comet.6 crimson.6 bi2cf.xml cfed.xml comet.xml crimson.xml

XSLT_DB2MAN = http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
XSLT_DB2HTML = http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl

SUFFIXES = .xml .6 .html
.xml.6:		xsltcheck
		$(XSLTPROC) -o "$@" $(XSLT_DB2MAN) "$<";

.xml.html:	xsltcheck
		$(XSLTPROC) -o "$@" $(XSLT_DB2HTML) "$<";

html:		bi2cf.html cfed.html comet.html crimson.html

xsltcheck:
		if test x$(XSLTPROC) = x; then \
		  @echo "Error: XSLT processor not available"; \
		  exit 1; \
		fi

