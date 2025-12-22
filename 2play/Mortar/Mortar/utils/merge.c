/* 
 * merges given images vertically and outputs the composite image to stdout
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../mortar.h"


int main(int argc, char *argv[])
{
	int idx, wd, ht, colors, images;
	m_image_t *dst, *bm[argc];
	m_uchar *data;
	long size;

	wd = ht = colors = images = 0;
	while (--argc > 0) {

		dst = bm_read(*++argv);

		if (dst) {
			if (!images) {
				wd = dst->wd;
				colors = dst->colors;
			}
			if (wd != dst->wd || colors != dst->colors) {
				fprintf(stderr, "image width or palette sizes don't match!\n");
				return -1;
			}
			ht += dst->ht;
			bm[images++] = dst;
		} else {
			fprintf(stderr, "image '%s' reading failed!\n", *argv);
		}
	}

	if (!images) {
		fprintf(stderr, "usage: merge <image-1> [image-2...] > image.pic\n");
		return -1;
	}

	dst = bm_alloc(wd, ht, colors);
	if (!dst) {
		fprintf(stderr, "allocation failed!\n");
		return -1;
	}

	/* copy data */
	data = dst->data;
	for (idx = 0; idx < images; idx++) {
		size = bm[idx]->wd * bm[idx]->ht;
		memcpy(data, bm[idx]->data, size);
		data += size;
	}

	/* copy palette */
	if (colors) {
		memcpy(dst->palette, bm[0]->palette, sizeof(m_rgb_t) * colors);
	}

	bm_write(NULL, dst);
	return 0;
}
