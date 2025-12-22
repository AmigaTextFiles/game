# Makefile for Amiga

all: 040 060 WOS

WOS:
	$(MAKE) -f Makefile.WOS

040:
	$(MAKE) -f Makefile.040

060:
	$(MAKE) -f Makefile.060


clean: 040clean 060clean WOSclean

WOSclean:
	$(MAKE) -f Makefile.WOS clean

040clean:
	$(MAKE) -f Makefile.040 clean

060clean:
	$(MAKE) -f Makefile.060 clean
