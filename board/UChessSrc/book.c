/*
 * book.c - C source for GNU CHESS
 *
 * Copyright (c) 1988,1989,1990 John Stanback
 * Copyright (c) 1992 Free Software Foundation
 *
 * This file is part of GNU CHESS.
 *
 * GNU Chess is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * GNU Chess is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with GNU Chess; see the file COPYING.  If not, write to
 * the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.
 */

#include "gnuchess.h"

unsigned int urand (void);

extern char mvstr[8][8];
int __aligned bookcount = 0;
static struct bookentry
{
  unsigned long bookkey;
  unsigned long bookbd;
  unsigned INTSIZE2 bmove;
  unsigned INTSIZE2 hint;
  unsigned char count;
  unsigned char flags;
} __aligned *OpenBook=(struct bookentry *)0L;
static struct bookentry __aligned *BookTable[BKTBLSIZE];
int __aligned whichbookloaded=-1;

void
GetOpenings (op_option)
int op_option;

/*
 * Read in the Opening Book file and parse the algebraic notation for a move
 * into an unsigned integer format indicating the from and to square. Create
 * a linked list of opening lines of play, with entry->next pointing to the
 * next line and entry->move pointing to a chunk of memory containing the
 * moves. More Opening lines of up to 100 half moves may be added to
 * gnuchess.book.
 * But now its a hashed table by position which yields a move or moves for 
 * each position. It no longer knows about openings per say only positions
 * and recommended moves in those positions.
 */
#ifndef BOOK
#define BOOK "/usr/games/lib/gnuchess.book"
#endif /* BOOK */
{
  FILE *fd;
  REG struct bookentry *OB, *OC;
  REG INTSIZE int i, f, t;
  char opening[80];
  char msg[80];
  INTSIZE int xside, doit, c, side;
  INTSIZE int rf, rt;
  unsigned INTSIZE mv;
#ifndef AMIGA
  int bs;
  unsigned long ltmp;
#endif

  /* allocate space for the book */
  if (whichbookloaded == op_option)
   return;
  if (!OpenBook)
   OpenBook = (struct bookentry *) malloc(BOOKSIZE*sizeof(struct bookentry));
  if (!OpenBook)
   {
    ShowMessage("Unable to alloc book");
    return;
   }
  ClearMem(OpenBook,BOOKSIZE*sizeof(struct bookentry));
  bookcount = 0;
  for (i = 0; i < BKTBLSIZE; i++)
    {
      BookTable[i] = &OpenBook[BOOKSIZE / BKTBLSIZE * i];
    }
  for (OB = OpenBook; OB < &OpenBook[BOOKSIZE]; OB++)
    OB->count = 0;
  if (op_option == white)
   {
    if ((fd = fopen ("uchess:uchesswhite.book", "r")) == NULL)
     {
      fd = fopen ("uchess:uchess.book", "r");
      op_option = 2;
     }
   }
  else
   {
    if ((fd = fopen ("uchess:uchessblack.book", "r")) == NULL)
     {
      fd = fopen ("uchess:uchess.book", "r");
      op_option = 2;
     }
   }
  
  if (fd != NULL)
    {
      whichbookloaded = -1;
      ShowMessage("Loading Book..");
      ShowMessage("Please Wait...");
      OC = NULL;
      /*setvbuf(fd,buffr,_IOFBF,2048);*/ 
      side = white;
      xside = black;
      hashbd = hashkey = 0;
      for (i = 0; i < 64; i++)
	{
	  board[i] = Stboard[i];
	  color[i] = Stcolor[i];
	}
      i = 0;

      while ((c = parse (fd, &mv, side, opening)) >= 0)
	if (c == 1)
	  {

	    /*
	     * if not first move of an opening and first time we have
	     * seen it save next move as hint
	     */
	    if (i && OB->count == 1)
	      OB->hint = mv & 0x3f3f;
	    OC = OB;		/* save for end marking */
	    doit = true;

	    /*
	     * see if this position and move already exist from some
	     * other opening
	     */
	    /* is this ethical, to offer the bad move as a hint????? */
	    for (OB = BookTable[hashkey & BOOKMASK]; OB->count; OB++)
	      {
		if (OB->bookkey == hashkey
		    && OB->bookbd == hashbd
		    && (OB->flags & SIDEMASK) == side
		    && OB->bmove == mv)
		  {
		    
		    /*
		     * yes so just bump count - count is used to choose
		     * opening move in proportion to its presence in the
		     * book
		     */
		    doit = false;
		    OB->count++;
		    if (OB->count < 1)
		      OB->count--;
		    break;
		  }
		/* Book is hashed into BKTBLSIZE chunks based on hashkey */
		if (OB == &OpenBook[BOOKSIZE - 1])
		  OB = OpenBook;
	      }
	    /* doesn`t exist so add it to the book */
	    if (doit)
	      {
		bookcount++;
		OB->bookkey = hashkey;
		OB->bookbd = hashbd;
		OB->bmove = mv;
		OB->hint = 0;
		OB->count = 1;
		OB->flags = side;
	      }
	    /* now update the board and hash values */
	    /* should really check the moves as we do this, but??? */
	    f = mv >> 8 & 0x3F;
	    t = mv & 0x3F;
	    if (board[t] != no_piece)
	      {
		if (color[t] != xside)
		  {
		    algbr (f, t, false);
		    sprintf (msg, CP[211], i + 1, mvstr, opening);
		    ShowMessage (msg);
		  }
		UpdateHashbd (xside, board[t], -1, t);
	      }
	    if (board[f] == no_piece || color[f] != side)
	      {
		algbr (f, t, false);
		sprintf (msg, CP[211], i + 1, mvstr, opening);
		ShowMessage (msg);
	      }
	    UpdateHashbd (side, board[f], f, t);
	    board[t] = board[f];
	    color[t] = color[f];
	    color[f] = neutral;
	    board[f] = no_piece;
	    if ((board[t] == king) && ((mv == BLACKCASTLE) || (mv == WHITECASTLE) || (mv == LONGBLACKCASTLE) || (mv == LONGWHITECASTLE)))
	      {

		if (t > f)
		  {
		    rf = f + 3;
		    rt = t - 1;
		  }
		else
		  {
		    rf = f - 4;
		    rt = t + 1;
		  }
		board[rt] = rook;
		color[rt] = side;
		board[rf] = no_piece;
		color[rf] = neutral;
		UpdateHashbd (side, rook, rf, rt);
	      }
	    i++;
	    xside = side;
	    side = side ^ 1;
	  }
	else if (c == 0 && i > 0)
	  {
	    /* Mark last move as end of an opening */
	    /* might want to terminate? */
	    OB->flags |= BOOKEND;
	    if (i > 1)
	      OC->flags |= BOOKEND;
	    /* reset for next opening */
	    side = white;
	    hashbd = hashkey = 0;
	    for (i = 0; i < 64; i++)
	      {
		board[i] = Stboard[i];
		color[i] = Stcolor[i];
	      }
	    i = 0;

	  }
      fclose (fd);
#ifdef BINBOOK
      fd = fopen (BINBOOK, "w");
      fprintf(fd, "%d\n%d\n", BOOKSIZE, bookcount);
      if(0>fwrite(OpenBook, sizeof(struct bookentry), BOOKSIZE, fd))
	ShowMessage("fwrite");
      fclose (fd);
#endif
#if !defined CHESSTOOL && !defined XBOARD
      ShowMessage("  ");
      ShowMessage("  ");
      ShowMessage("  ");
      ShowMessage("  ");
      ShowMessage("  ");
      if (op_option == white)
       ShowMessage("White Book");
      else if (op_option == black)
       ShowMessage("Black Book");
      else
       ShowMessage("NOptml Book");
      sprintf (msg, CP[213], bookcount, BOOKSIZE);
      ShowMessage (msg);
      whichbookloaded = op_option;
#endif
      /* set every thing back to start game */
      Book = BOOKFAIL;
      for (i = 0; i < 64; i++)
	{
	  board[i] = Stboard[i];
	  color[i] = Stcolor[i];
	}
    }
  else
    {
#if !defined CHESSTOOL && !defined XBOARD
      ShowMessage (CP[212]);
#endif
      Book = 0;
    }
}


int
OpeningBook (unsigned INTSIZE *hint, INTSIZE int side)
     
/*
 * Go thru each of the opening lines of play and check for a match with the
 * current game listing. If a match occurs, generate a random number. If this
 * number is the largest generated so far then the next move in this line
 * becomes the current "candidate". After all lines are checked, the
 * candidate move is put at the top of the Tree[] array and will be played by
 * the program. Note that the program does not handle book transpositions.
 */

{
  INTSIZE pnt;
  unsigned INTSIZE m;
  unsigned r, cnt, tcnt, ccnt;
  REG struct bookentry *OB, *OC;
  int possibles = TrPnt[2] - TrPnt[1];

  gsrand ((unsigned int) time ((long *) 0));
  m = 0;
  cnt = 0;
  tcnt = 0;
  ccnt = 0;
  OC = NULL;
  

  /*
   * find all the moves for this position  - count them and get their total
   * count
   */
  for (OB = BookTable[hashkey & BOOKMASK]; OB->count; OB++)
    {
      if (OB->bookkey == hashkey
	  && OB->bookbd == hashbd
	  && ((OB->flags) & SIDEMASK) == side)
	{
	  if (OB->bmove & BADMOVE)
	    {
	      m = OB->bmove ^ BADMOVE;
	      /* is the move is in the MoveList */
	      for (pnt = TrPnt[1]; pnt < TrPnt[2]; pnt++)
		{
		  if (((Tree[pnt].f << 8) | Tree[pnt].t) == m)
		    {
		      if (--possibles)
			{
			  Tree[pnt].score = DONTUSE;
			  break;
			}
		    }
		}

	    }
	  else
	    {
	      OC = OB;
	      cnt++;
	      tcnt += OB->count;
	    }
	}
    }
  /* if only one just do it */
  if (cnt == 1)
    {
      m = OC->bmove;
    }
  else
    /* more than one must choose one at random */
  if (cnt > 1)
    {
      /* pick a number */
      r = urand () % 1000;

      for (OC = BookTable[hashkey & BOOKMASK]; OC->count; OC++)
	{
	  if (OC->bookkey == hashkey
	      && OC->bookbd == hashbd
	      && ((OC->flags) & SIDEMASK) == side
	      && !(OC->bmove & BADMOVE))
	    {
	      ccnt += OC->count;
	      if (((ccnt * BOOKRAND) / tcnt) >= r)
		{
		  m = OC->bmove;
		  break;
		}
	    }
	}
    }
  else
    {
      /* none decrement count of no finds */
      Book--;
      return false;
    }
  /* make sure the move is in the MoveList */
  for (pnt = TrPnt[1]; pnt < TrPnt[2]; pnt++)
    {
      if (((Tree[pnt].f << 8) | Tree[pnt].t) == m)
	{
          Tree[pnt].flags |= book;
	  Tree[pnt].score = 0;
	  break;
	}
    }
  /* Make sure its the best */

  pick (TrPnt[1], TrPnt[2] - 1);
  if (Tree[TrPnt[1]].score)
    {
      /* no! */
      Book--;
      return false;
    }
  /* ok pick up the hint and go */
  *hint = OC->hint;
  Book = ((OC->flags & BOOKEND) && ((urand () % 1000) > BOOKENDPCT)) ? 0 : BOOKFAIL;
  return true;
}
