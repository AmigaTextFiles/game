#include <exec/types.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>

#include "modplayer.h"

int CXBRK(void) { return 0; }

int
main(int argc, char **argv)
{
	struct MMD0	*module = NULL;
	int		c;

	if ((module = LoadModule("/gamemod.MED")) == NULL) {
		fprintf(stderr, "Can't load module!\n");
		exit(-1);
	}

	InitPlayer();

	PlayModule(module);

	do {
		printf("Module number (0..8), or (Q)uit> ");

		c = getch();
		if (isprint(c)) printf("%c\n", c); else printf("\n");

		if (c >= '0' && c <= '8') {
			StopPlayer();
			modnum = (c - '0');
			PlayModule(module);
		}
	} while (c != 'q' && c != 'Q' && c != EOF);

	StopPlayer();
	UnLoadModule(module);
	RemPlayer();
}
