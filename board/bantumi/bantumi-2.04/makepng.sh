#!/bin/sh
#bmptopnm sshot-alpha.bmp | pamchannel R | pamtopnm -assume > alpha.pgm
bmptopnm sshot-alpha.bmp | ppmtopgm > alpha.pgm
bmptopnm sshot.bmp | pnmtopng -alpha alpha.pgm > sshot.png
rm alpha.pgm
