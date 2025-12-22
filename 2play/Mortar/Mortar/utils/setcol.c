/* 
 * set given color to given hex RGB value
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../mortar.h"


int main(int argc, char *argv[])
{
	m_image_t *bm;
	m_rgb_t *rgb;
	int index;
	long hex;

	if (argc < 3 || argc > 4) {
		fprintf(stderr, "usage: %s <index> <hex RGB> [image]\n", *argv);
	}

	index = atoi(argv[1]);
	hex = strtol(argv[2], NULL, 0);

	if (!(bm = bm_read(argv[3]))) {
		fprintf(stderr,
			"%s: '%s' image loading failed!\n", *argv, argv[3]);
		return -1;
	}

	rgb = bm->palette;
	rgb->r = 0;
	rgb->g = 0;
	rgb->b = 0;

	rgb += index;
	rgb->r = (hex >> 16) & 0xff;
	rgb->g = (hex >> 8) & 0xff;
	rgb->b = hex & 0xff;

	bm_write(argv[3], bm);
	return 0;
}
