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

/* Prototypes for functions defined in
TetrisImages.c
 */

extern Point TSizes[];

extern Point TSSizes[];

extern struct BitMap TBitMaps[];

extern UWORD TColors[];

extern UWORD TFirst[];

extern UWORD TNext[];

extern UWORD TPieces[];

void DrawTetrisImage(struct BitMap *, WORD , WORD , WORD , WORD );

BOOL InitTetrisImages(WORD , WORD , WORD );

void FreeTetrisImages(WORD , WORD , WORD );

