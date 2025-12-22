/* 
Copyright (c) 1992, Trevor Smigiel.  All rights reserved.

(I hope Commodore doesn't mind that I borrowed their copyright notice.)

The source and executable code of this program may only be distributed in free
electronic form, via bulletin board or as part of a fully non-commercial and
freely redistributable diskette.  Both the source and executable code (including
comments) must be included, without modification, in any copy.  This example may
not be published in printed form or distributed with any commercial product.

This program is provided "as-is" and is subject to change; no warranties are
made.  All use is at your own risk.  No liability or responsibility is assumed.

*/

#include <exec/types.h>
#include <intuition/intuition.h>
#include <stdio.h>
#include <string.h>
#include "Tetris.h"

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

int
main(int argc, char *argv[])
{
	BPTR infile, outfile;
	char buf[32];
	struct TLevel level;
	int i, j;

	infile  = Input();
	Flush(infile);
	outfile = Output();
	Flush(outfile);

	switch (argc) {
	case 3:
		outfile = Open(argv[2], MODE_NEWFILE);
	case 2:
		infile  = Open(argv[1], MODE_OLDFILE);
		break;
	}

		FGets(infile, buf, 31);
		stcd_i(buf, &j);
		level.goal = j;

		FGets(infile, buf, 31);
		stcd_i(buf, &j);
		level.lines = j;

		FGets(infile, buf, 31);
		stcd_i(buf, &j);
		level.time = j;

		FGets(infile, buf, 31);
		stcd_i(buf, &j);
		level.line_up = j;
		for (i = 0; i < PFHEIGHT; i++) {
			FGets(infile, buf, 31);
			stch_i(buf, &j);
			level.board[i] = (j << 5) | 0x801f;
		}
		level.board[PFHEIGHT] = 0xffff;

		Write(outfile, &level, sizeof(struct TLevel));

	switch (argc) {
	case 3:
		Close(outfile);
	case 2:
		Close(infile);
		break;
	}
	return 0;
}
