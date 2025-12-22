/* 
 * converts PPM to P8M
 *
 * (w)  1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include "../mortar.h"


int main(int argc, char *argv[])
{
	m_image_t *bm;

	if (!(bm = bm_read(argv[1]))) {
		fprintf(stderr,
			"%s: '%s' image loading failed!\n", *argv, argv[1]);
		return -1;
	}
	bm_write(argv[1], bm);
	return 0;
}
