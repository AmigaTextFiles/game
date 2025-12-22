/* emulates MORTAR message.c for pbm.c included into image filters */

#include <stdio.h>
#include "../mortar.h"

void msg_print(int msg)
{
	char *err;

	switch (msg) {
		case ERR_ALLOC:
			err = "allocation failed";
			break;
		case ERR_READ:
			err = "file read failed";
			break;
		case ERR_SAVE:
			err = "file save failed";
			break;
		case ERR_IMAGE:
			err = "image reading failed";
			break;
		case ERR_COLORS:
			err = "illegal number of colors";
			break;
		default:
			err = "undefined msg_print() error";
	}
	fprintf(stderr, "error: %s!\n", err);
}
