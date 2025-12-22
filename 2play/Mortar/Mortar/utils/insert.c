/* 
 * adds a bogus (first) palette entry for non-transparent images
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../mortar.h"


int main(int argc, char *argv[])
{
	m_rgb_t rgb[256];
	m_uchar *data;
	m_image_t *bm;
	long size;

	if (!(bm = bm_read(argv[1]))) {
		fprintf(stderr,
			"%s: '%s' image loading failed!\n", *argv, argv[1]);
		return -1;
	}

	rgb->r = 0;
	rgb->g = 0;
	rgb->b = 0;
	memcpy(&rgb[1], bm->palette, sizeof(m_rgb_t) * bm->colors);

	bm->palette = rgb;
	bm->colors++;

	data = bm->data;
	size = bm->wd * bm->ht;
	while(--size >= 0) {
		(*data)++;
		data++;
	}

	bm_write(argv[1], bm);
	return 0;
}
