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
#include <exec/memory.h>
#include <math.h>
#include <stdio.h>
#include "tetris.h"

#include <proto/exec.h>
#include <proto/dos.h>
#include <proto/graphics.h>
#include <proto/intuition.h>

#include "main_protos.h"
#include "TetrisImages_protos.h"

struct TBoard *
NewBoard(struct RastPort *rp, WORD bleft, WORD btop)
{
	struct TBoard *board;
	int i;

	board = AllocMem(sizeof(struct TBoard), MEMF_CLEAR);
	if (board) {

		InitBitMap(&board->bitmap, Depth, PWidth, PHeight);
		board->bitmap.Planes[0] = AllocMem(board->bitmap.BytesPerRow * board->bitmap.Rows * board->bitmap.Depth, MEMF_CHIP | MEMF_CLEAR);
		if (board->bitmap.Planes[0]) {

			for (i = 1; i < Depth; i++) 
				board->bitmap.Planes[i] = board->bitmap.Planes[i-1] + board->bitmap.BytesPerRow;
			board->bitmap.BytesPerRow *=  Depth;

			board->rastport = rp;

			board->board_off.x = bleft;
			board->board_off.y = btop;
			board->score_off.x = bleft;
			board->score_off.y = 1 * (board->rastport->TxHeight + 1) + btop - YSize * 4;
			board->line_off.x  = bleft;
			board->line_off.y  = 3 * (board->rastport->TxHeight + 1) + btop - YSize * 4;
			board->time_off.x  = bleft;
			board->time_off.y  = 2 * (board->rastport->TxHeight + 1) + btop - YSize * 4;
			board->next_off.x  = bleft + PWidth - XSize * 4;
			board->next_off.y  = btop - ((YSize * 7) / 2);

			for (i = 0; i < PFHEIGHT; i++) {
				board->level.board[i] = 0x801f;
			}
			board->level.board[i] = 0xffff;
			board->level.goal     = GOAL_TIME_LIMIT | GOAL_CLEAR_LINES;
			board->level.lines    = 5;
			board->level.time     = 60;
			board->level.line_up  = 30;

			CurrentTime((LONG *)&board->seed[1], (LONG *)&board->seed[0]);

			board->next_which   = TFirst[nrand48(board->seed) % 7];
			board->piece.which  = TFirst[nrand48(board->seed) % 7];
			board->piece.bx     = (PFWIDTH / 2) - 2;
			board->piece.x      = board->piece.bx * XSize;
			board->piece.by     = 0;
			board->piece.y      = 0;
			board->next_sec     = UPDATE_SECONDS;
			board->points       = 0;
			board->clevel       = Level;
			board->next_line_up = board->level.line_up;
			board->drop_up      = 30;
			board->next_drop_up = board->drop_up;
			board->drop         = 10;
			board->next_drop    = board->drop;

			board->lines        = board->level.lines;
			board->time         = board->level.time;

			return board;
		}
		FreeMem(board, sizeof(struct TBoard));
	}
	return NULL;
}

void 
FreeBoard(struct TBoard *board)
{
	FreeMem(board->bitmap.Planes[0], board->bitmap.BytesPerRow * board->bitmap.Rows);
	FreeMem(board, sizeof(struct TBoard));
}

void 
AddPiece(struct TBoard *board)
{
	UWORD piece = TPieces[board->piece.which], p;
	UWORD *b = &board->level.board[board->piece.by];
	WORD x = board->piece.bx + 1;
	*b |= ((piece & 0xf000) >> x);
	if (p = piece & 0x0f00) {
		b++; x -= 4;
		*b |= ((x >= 0) ? (p >> x) : (p << -x));
		if (p = piece & 0x00f0) {
			b++; x -= 4;
			*b |= ((x >= 0) ? (p >> x) : (p << -x));
			if (p = piece & 0x000f) {
				b++; x -= 4;
				*b |= ((x >= 0) ? (p >> x) : (p << -x));
			}
		}
	}
}

WORD
TestMove(struct TBoard *board, WORD which, WORD x, WORD y)
{
	UWORD piece = TPieces[which];
	UWORD *b = &board->level.board[y];
	UWORD p;
	x++;
	if (*b & ((piece & 0xf000) >> x)) return 0;
	if (p = piece & 0x0f00) {
		b++; x -= 4;
		if (*b & ((x >= 0) ? (p >> x) : (p << -x))) return 0;
		if (p = piece & 0x00f0) {
			b++; x -= 4;
			if (*b & ((x >= 0) ? (p >> x) : (p << -x))) return 0;
			if (p = piece & 0x000f) {
				b++; x -= 4;
				if (*b & ((x >= 0) ? (p >> x) : (p << -x))) return 0;
			}
		}
	}
	return 1;
}

void 
CheckRows(struct TBoard *board, WORD btop, WORD pheight)
{
	UWORD *b, *src, *dst;
	WORD top, height, ymax;
	int first;
	int i, j;
	char buf[12];
	int pt = 0;

	top = 0;
	for (i = btop - 1; board->level.board[i] & 0x7fe0; i--);
	first = i + 1;
	top = first * YSize;
	height = (btop - first) * YSize;
	ymax = board->board_off.y + top + height + YSize - 1;
	for (b = &board->level.board[btop], i = 0; i < pheight; i++, b++) {
		if (*b == 0xffff) { 
			if (height)
				BltBitMap(&board->bitmap, 0, top, &board->bitmap, 0, top + YSize, PWidth, height, 0xC0, 0xff, NULL);
			BltClear(board->bitmap.Planes[0] + top * board->bitmap.BytesPerRow, board->bitmap.BytesPerRow * YSize, 0);
			ScrollRaster(board->rastport, 0, -YSize, board->board_off.x, board->board_off.y + top, board->board_off.x + PWidth - 1, ymax);
			for (src = b - 1, dst = b, j = i + btop - first; j > 0; j--)
				*dst-- = *src--;
			board->level.board[first] = 0x801f;
			top += YSize;
			first++;

			pt++;
			board->points += pt;
			sprintf(buf, "Score:%4d", board->points);
			Move(board->rastport, board->score_off.x, board->score_off.y);
			Text(board->rastport, buf, 10);

			board->lines--; 
			sprintf(buf, "Lines:%4d", board->lines);
			Move(board->rastport, board->line_off.x, board->line_off.y);
			Text(board->rastport, buf, 10);
			if ((board->level.goal & GOAL_CLEAR_LINES) && (board->lines <= 0)) {
				board->flags |= TETF_NEXTLEVEL;
			}
		} else {
			height += YSize;
		}
		ymax += YSize;
	}
}

void 
PrintBits(struct TBoard *board)
{
	int i, j;
	for (i = 0; i <= PFHEIGHT; i++) {
		for (j = 0x4000; j & 0x7fe0; j >>= 1)
			printf((j & board->level.board[i]) ? "1" : "0");
		printf("\n");
	}
	printf("\n");
}

void  
MoveTetris(struct TBoard *board, WORD move)
{
	struct TPiece npiece;
	WORD left, top, width, height;

	if ((board) && (board->flags & (TETF_GAMEOVER | TETF_NEXTLEVEL))) return;

	npiece = board->piece;

	left = board->piece.x;
	top = board->piece.y;
	width = TSizes[board->piece.which].x;
	height = TSizes[board->piece.which].y;

	switch (move) {
	case COMMAND_DOWN:
		npiece.by++;
		npiece.y += YSize;
		height += YSize;
		break;
	case COMMAND_LEFT:
		npiece.bx--;
		npiece.x -= XSize;
		left -= XSize;
		width += XSize;
		break;
	case COMMAND_RIGHT:
		npiece.bx++;
		npiece.x += XSize;
		width += XSize;
		break;
	case COMMAND_ROTATE:
		npiece.which = TNext[npiece.which];
		if (TSizes[npiece.which].x > width)  width  = TSizes[npiece.which].x;
		if (TSizes[npiece.which].y > height) height = TSizes[npiece.which].y;
		break;
	default: break;
	}
	if (TestMove(board, npiece.which, npiece.bx, npiece.by)) {
		BltBitMap(&TBitMaps[board->piece.which], 0, 0, &board->bitmap, board->piece.x, board->piece.y, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0x22, 0xff, NULL);
		board->piece = npiece;
		BltBitMap(&TBitMaps[npiece.which], 0, 0, &board->bitmap, board->piece.x, board->piece.y, TSizes[npiece.which].x, TSizes[npiece.which].y, 0xEE, 0xff, NULL);
		WaitTOF();
		BltBitMapRastPort(&board->bitmap, left, top, board->rastport, board->board_off.x + left, board->board_off.y + top, width, height, 0xC0);
	} else if (move == COMMAND_DOWN) {
		AddPiece(board);
		CheckRows(board, board->piece.by, TSSizes[board->piece.which].y);
		board->piece.bx = (PFWIDTH / 2) - 2;
		board->piece.x = board->piece.bx * XSize;
		board->piece.by = 0;
		board->piece.y = 0;
		board->piece.which = board->next_which;
		board->next_which = TFirst[nrand48(board->seed) % 7];
		//board->pieces[board->piece.which]++;
		BltBitMap(&TBitMaps[board->piece.which], 0, 0, &board->bitmap, board->piece.x, board->piece.y, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0xEE, 0xff, NULL);
		BltBitMapRastPort(&board->bitmap, board->piece.x, board->piece.y, board->rastport, board->board_off.x + board->piece.x, board->board_off.y + board->piece.y, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0xC0);
		BltBitMapRastPort(&TBitMaps[board->piece.which], 0, 0, board->rastport, board->next_off.x, board->next_off.y, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0x22);
		BltBitMapRastPort(&TBitMaps[board->next_which], 0, 0, board->rastport, board->next_off.x, board->next_off.y, TSizes[board->next_which].x, TSizes[board->next_which].y, 0xC0);
		if (!TestMove(board, board->piece.which, board->piece.bx, board->piece.by))
			board->flags |= TETF_GAMEOVER | TETF_OUTOFROOM;
	}
}

void 
DrawLine(struct TBoard *board, WORD line)
{
	int i, top, left, size = YSize * board->bitmap.BytesPerRow;

	BltClear(board->bitmap.Planes[0] + line * size, size, 0);

	top = line * YSize;
	for (left = 0, i = 0x4000; i & 0x7fe0; i >>= 1, left += XSize) {
		if (board->level.board[line] & i)
			BltBitMap((struct BitMap *)&TBitMaps[19], 0, 0, &board->bitmap, left, top, XSize, YSize, 0xC0, 0xff, NULL);
	}
}

/* called every timer event, (every 1/10th of a second) */
void 
UpdateTetris(struct TBoard *board)
{
	int i;
	char buf[12];

	if ((board) && (board->flags & (TETF_GAMEOVER | TETF_NEXTLEVEL))) return;

	board->next_drop--;
	if (board->next_drop < 0) {
		board->next_drop = board->drop;
		MoveTetris(board, COMMAND_DOWN);
	}

	board->next_sec--;
	if (board->next_sec < 0) {
		board->next_sec = UPDATE_SECONDS;

		board->time--;

		sprintf(buf, "Time:%2d:%02d", board->time / 60, board->time % 60);
		Move(board->rastport, board->time_off.x, board->time_off.y);
		Text(board->rastport, buf, 10);

		if (board->time <= 0) {
			if (board->level.goal & GOAL_TIME_LIMIT)
				board->flags |= TETF_GAMEOVER | TETF_OUTOFTIME;
			else if (board->level.goal & GOAL_ENDURANCE)
				board->flags |= TETF_NEXTLEVEL;
		}


		board->next_line_up--;
		if (board->next_line_up < 0) {
			board->next_line_up = board->level.line_up;

			for (i = 0; i < PFHEIGHT; i++)
				board->level.board[i] = board->level.board[i + 1];
			board->level.board[PFHEIGHT - 1] &= ~(0x20 << (lrand48() % 10));

			/* move piece up */
			if (board->piece.by) {
				board->piece.by--;
				board->piece.y -= YSize;
			} else {
				/* Erase piece */
				BltBitMap(&TBitMaps[board->piece.which], 0, 0, &board->bitmap, board->piece.x, board->piece.y, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0x22, 0xff, NULL);
				/* Redraw piece down one so that its in the right place when the board is scrolled up */
				BltBitMap(&TBitMaps[board->piece.which], 0, 0, &board->bitmap, board->piece.x, board->piece.y + YSize, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0xEE, 0xff, NULL);
			}
			/* scroll board up */
			BltBitMap(&board->bitmap, 0, YSize, &board->bitmap, 0, 0, PWidth, PHeight - YSize, 0xC0, 0xff, NULL);
			/* draw the new line */
			DrawLine(board, PFHEIGHT - 1);
			/* update entire board to screen */
			BltBitMapRastPort(&board->bitmap, 0, 0, board->rastport, board->board_off.x, board->board_off.y, PWidth, PHeight, 0xC0);
		}

		board->next_drop_up--;
		if (board->next_drop_up < 0) {
			board->next_drop_up = board->drop_up;
			if (board->drop) board->drop--;
		}
	}
}

void
DrawBoard(struct TBoard *board)
{
	int len;
	char buf[12];

	SetAPen(board->rastport, 3);
	RectFill(board->rastport, board->board_off.x - BSize, board->board_off.y, board->board_off.x, board->board_off.y + PHeight + BSize - 1);
	RectFill(board->rastport, board->board_off.x - 1, board->board_off.y + PHeight, board->board_off.x + PWidth, board->board_off.y + PHeight + BSize - 1);
	RectFill(board->rastport, board->board_off.x + PWidth, board->board_off.y, board->board_off.x + PWidth + BSize - 1, board->board_off.y + PHeight + BSize - 1);
	SetAPen(board->rastport, 2);
	Move(board->rastport, board->board_off.x - 1, board->board_off.y);
	Draw(board->rastport, board->board_off.x - BSize, board->board_off.y);
	Draw(board->rastport, board->board_off.x - BSize, board->board_off.y + PHeight + BSize - 1);
	SetAPen(board->rastport, 1);
	Move(board->rastport, board->board_off.x - BSize + 1, board->board_off.y + PHeight + BSize - 1);
	Draw(board->rastport, board->board_off.x + PWidth + BSize - 1, board->board_off.y + PHeight + BSize - 1);
	Draw(board->rastport, board->board_off.x + PWidth + BSize - 1, board->board_off.y);
	SetAPen(board->rastport, 2);
	Draw(board->rastport, board->board_off.x + PWidth, board->board_off.y);
	Draw(board->rastport, board->board_off.x + PWidth, board->board_off.y + PHeight);
	Draw(board->rastport, board->board_off.x - 1, board->board_off.y + PHeight);
	SetAPen(board->rastport, 1);
	Draw(board->rastport, board->board_off.x - 1, board->board_off.y + 1);

	
	BltBitMap(&TBitMaps[board->piece.which], 0, 0, &board->bitmap, board->piece.x, board->piece.y, TSizes[board->piece.which].x, TSizes[board->piece.which].y, 0xEE, 0xff, NULL);
	BltBitMapRastPort(&board->bitmap, 0, 0, board->rastport, board->board_off.x, board->board_off.y, PWidth, PHeight, 0xC0);

	EraseRect(board->rastport, board->next_off.x, board->next_off.y, board->next_off.x + XSize * 4 - 1, board->next_off.y + YSize * 7 / 2 - 1);
	BltBitMapRastPort(&TBitMaps[board->next_which], 0, 0, board->rastport, board->next_off.x, board->next_off.y, TSizes[board->next_which].x, TSizes[board->next_which].y, 0xC0);

	len = sprintf(buf, "Score:%4d", board->points);
	Move(board->rastport, board->score_off.x, board->score_off.y);
	Text(board->rastport, buf, len);

	len = sprintf(buf, "Lines:%4d", board->lines);
	Move(board->rastport, board->line_off.x, board->line_off.y);
	Text(board->rastport, buf, len);

	len = sprintf(buf, "Time:%2d:%02d", board->time / 60, board->time % 60);
	Move(board->rastport, board->time_off.x, board->time_off.y);
	Text(board->rastport, buf, len);
}

void 
StartLevel(struct TBoard *board, WORD l)
{
	int i;
	char filename[32];
	BPTR file;

	if ((board) && (board->flags & TETF_GAMEOVER)) return;

	BltClear(board->bitmap.Planes[0], board->bitmap.Rows * board->bitmap.BytesPerRow, 0);

	sprintf(filename, "tetris:levels/%d", l);
	file = Open(filename, MODE_OLDFILE);
	if (file) {
		Read(file, &board->level, sizeof(struct TLevel));
		Close(file);
		for (i = 0; i < PFHEIGHT; i++) {
			DrawLine(board, i);
		}
	} else {	

		board->level.goal     = GOAL_TIME_LIMIT | GOAL_CLEAR_LINES;
		board->level.lines    = 5  + l * 5;
		board->level.time     = 60 + l * 30;
		board->level.line_up  = 45 - l * 5 / 2;

		for (i = 0; i < PFHEIGHT; i++) {
		board->level.board[i] = 0x801f;
		}
		board->level.board[i] = 0xffff;
	}

	board->flags       &= ~TETF_NEXTLEVEL;
	board->lines        = 0;
	board->next_which   = TFirst[nrand48(board->seed) % 7];
	board->piece.which  = TFirst[nrand48(board->seed) % 7];
	board->piece.bx     = (PFWIDTH / 2) - 2;
	board->piece.x      = board->piece.bx * XSize;
	board->piece.by     = 0;
	board->piece.y      = 0;
//	board->drop_up     -= 1;
//	board->drop         = board->drop_up;
	board->next_drop    = board->drop;
	board->next_sec     = UPDATE_SECONDS;
	board->lines        = board->level.lines;
	board->time         = board->level.time;
	board->next_line_up = board->level.line_up;
	board->next_drop_up = board->drop_up;
	board->clevel = l;

	DrawBoard(board);

}

/*
void 
EndLevel(struct TBoard *board)
{
}
*/
