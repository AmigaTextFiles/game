# makefile


POVRAY=x-povray

all:	e-title.bmp title.bmp

clean:
	-rm title.bmp
	-rm title.png
	-rm e-title.bmp
	-rm e-title.png


e-title.bmp:	e-title.png
	pngtopnm e-title.png | ppmtobmp > e-title.bmp

e-title.png:	title.pov
	$(POVRAY) +d +p +Ititle.pov +L/usr/local/lib/povray-3.4.99.3/include/ \
		+W240 +H320 +A +Oe-title.png



title.bmp:	title.png
	pngtopnm title.png | ppmtobmp > title.bmp

title.png:	title.pov
	$(POVRAY) +d +p +Ititle.pov +L/usr/local/lib/povray-3.4.99.3/include/ \
		+W640 +H480 +A
