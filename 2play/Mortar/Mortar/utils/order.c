/* 
 * orders palette colors according to rgb average so that darkest is
 * first and lightest last.
 *
 * usage: order [image]
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "../mortar.h"

typedef struct {
	short value;
	m_uchar order;
} map_t;

int map_cmp(map_t *a, map_t *b)
{
	if (a->value < b->value) {
		return -1;
	}
	if (a->value > b->value) {
		return 1;
	}
	return 0;
}

int rgb_cmp(m_rgb_t *a, m_rgb_t *b)
{
	int c, d;
	c = a->r + a->g + a->b;
	d = b->r + b->g + b->b;
	if (c < d) {
		return -1;
	}
	if (c > d) {
		return 1;
	}
	return 0;
}


int main(int argc, char *argv[])
{
	m_rgb_t *pal;
	map_t order[256];
	m_uchar *data, map[256];
	m_image_t *bm;
	long size;
	int idx;

	if (!(bm = bm_read(argv[1]))) {
		fprintf(stderr, "usage: %s [P8M image]\n", *argv);
		return -1;
	}

	idx = bm->colors;
	pal = bm->palette + idx;
	while (--idx >= 0) {
		pal--;
		order[idx].value = (int)pal->r + pal->g + pal->b;
		order[idx].order = idx;
	}

	/* these should now be sorted to same order
	 */
	qsort(order, bm->colors, sizeof(map_t), map_cmp);
	qsort(bm->palette, bm->colors, sizeof(m_rgb_t), rgb_cmp);

	/* now compose the mapping */
	idx = bm->colors;
	while (--idx >= 0) {
		map[order[idx].order] = idx;
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
