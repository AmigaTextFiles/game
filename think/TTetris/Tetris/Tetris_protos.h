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
Tetris.c
 */
struct TBoard * NewBoard(struct RastPort *, WORD , WORD );
void FreeBoard(struct TBoard *);
void AddPiece(struct TBoard *);
WORD TestMove(struct TBoard *, WORD , WORD , WORD );
void CheckRows(struct TBoard *, WORD , WORD );
void MoveTetris(struct TBoard *, WORD );
void DrawLine(struct TBoard *, WORD );
void UpdateTetris(struct TBoard *);
void DrawBoard(struct TBoard *);
void StartLevel(struct TBoard *, WORD );
