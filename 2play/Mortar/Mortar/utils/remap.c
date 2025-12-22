/* 
 * remapss image color indeces and palette entries by cycling them forward
 * by one position.
 *
 * usage: remap [image]
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../mortar.h"


int main(int argc, char *argv[])
{
	int maps, map[256];
	m_rgb_t rgb[256];
	m_uchar  *data;
	m_image_t *bm;
	long size;

	if (!(bm = bm_read(argv[1]))) {
		fprintf(stderr, "usage: %s [P8M image]\n", *argv);
		return -1;
	}

	maps = bm->colors;
	memcpy(rgb, bm->palette, sizeof(m_rgb_t) * maps);

	map[--maps] = 0;
	bm->palette[maps] = rgb[0];
	while (--maps >= 0) {
		bm->palette[maps] = rgb[maps + 1];
		map[maps] = maps + 1;
	}

	data = bm->data;
	size = bm->wd * bm->ht;
	while(--size >= 0) {
		*data = map[*data];
		data++;
	}

	bm_write(argv[1], bm);
	return 0;
}
