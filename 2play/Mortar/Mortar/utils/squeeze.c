/* 
 * squeeze removes extra space from images layed out into a fixed size grid
 * such as a grap from xfd font table. For example:
 *	squeeze 16 14 6 5 font.pic
 *
 * tells that 'font.pic' is a 16x14 grid of (character) images, each being
 * surrounded by 5 pixels of redundant/removable space.
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../mortar.h"


void help(void)
{
	fprintf(stderr,	"usage: squeeze <x> <y> <xskip> <yskip> [image]\n");
	exit(-1);
}

int main(int argc, char *argv[])
{
	int x, y, w, h, wd, ht, xskip, yskip, bytes, align;
	m_uchar *src, *dst;
	m_image_t *bm;

	if (argc < 5) {
		help();
	}

	x = atoi(*++argv);
	y = atoi(*++argv);
	xskip = atoi(*++argv);
	yskip = atoi(*++argv);

	if (!(yskip && xskip && x && y)) {
		help();
	}

	if (!(bm = bm_read(*++argv))) {
		help();
	}

	bytes = bm->wd;
	wd = bytes / x - 2*xskip;
	ht = bm->ht / y - 2*yskip;

	bm->wd = wd * x;
	bm->ht = ht * y;

	align = bytes - (wd + 2*xskip) * x;

	src = dst = bm->data;
	src += (yskip + 1) * bytes + xskip;

	while (--y >= 0) {
		h = ht;
		while (--h >= 0) {
			w = x;
			while (--w >= 0) {
				memmove(dst, src, wd);
				src += wd + 2*xskip;
				dst += wd;
			}
			src += align;
		}
		src += 2*yskip * bytes;
	}

	bm_write(NULL, bm);
	return 0;
}
