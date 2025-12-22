/*
 * puzzle.c
 * ========
 * Implementation of puzzle module.
 *
 * Copyright (C) 1994-1998 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <graphics/rastport.h>
#include <intuition/intuition.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "puzzle.h"

#include <clib/exec_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>


extern struct Window  *puzzle_win;
extern struct RastPort   pict_rp;


#define SGN(x) ((x) ? (abs ((x)) / (x)) : 0)

#define MIN_COLS_ROWS 3
#define MIN_BORDER 2
#define MIN_PIECE_SIDE 10
#define EMPTYPIECE (num_rows * num_cols - 1)


static UBYTE   max_rows, max_cols;
static UBYTE   num_rows = 0, num_cols = 0;
static UBYTE   piece_w, piece_h;
static ULONG   x_offs, y_offs;
static UWORD  *pieces;
static UWORD   num_correct;
static UWORD   empty_pos;
static BOOL    is_numbers_drawn = FALSE;


static void
draw_piece (
   UWORD   n)
{
   if (pieces[n] != EMPTYPIECE)
   {
      ClipBlit (&pict_rp,
                x_offs + (pieces[n] % num_cols) * piece_w,
                y_offs + (pieces[n] / num_cols) * piece_h,
                puzzle_win->RPort,
                puzzle_win->BorderLeft + x_offs + (n % num_cols) * piece_w,
                puzzle_win->BorderTop + y_offs + (n / num_cols) * piece_h,
                piece_w, piece_h, 0xC0);
   }
   else
   {
      SetAPen (puzzle_win->RPort, 0);
      RectFill (puzzle_win->RPort,
                puzzle_win->BorderLeft + x_offs + (n % num_cols) * piece_w,
                puzzle_win->BorderTop + y_offs + (n / num_cols) * piece_h,
                puzzle_win->BorderLeft + x_offs + ((n % num_cols) + 1) * piece_w - 1,
                puzzle_win->BorderTop + y_offs + ((n / num_cols) + 1) * piece_h - 1);
   }
}


static void
draw_puzzle (void)
{
   UWORD   n;
   
   if (puzzle_done ())
   {
      ClipBlit (&pict_rp, x_offs, y_offs,
                puzzle_win->RPort,
                puzzle_win->BorderLeft + x_offs,
                puzzle_win->BorderTop + y_offs,
                num_cols * piece_w, num_rows * piece_h, 0xC0);
   }
   else
   {
      for (n = 0; n < num_cols * num_rows; ++n)
         draw_piece (n);
   }
}


void
move_pieces (
   UWORD   from,
   UWORD   to,
   WORD    step,
   BOOL    draw)
{
   UWORD   n;
   BOOL    done = FALSE;
   
   for (n = to; !done; n += step)
   {
      if (pieces[n] == n)
         --num_correct;
      if (done = (n == from))
      {
         pieces[n] = EMPTYPIECE;
         empty_pos = n;
      }
      else
         pieces[n] = pieces[n + step];
      if (pieces[n] == n)
         ++num_correct;
      if (draw)
         draw_piece (n);
   }
}


void
play_puzzle (
   UWORD   n,
   BOOL    draw)
{
   if (draw && is_numbers_drawn)
      draw_numbers ();
   if (n != empty_pos)
   {
      if (n % num_cols == empty_pos % num_cols)
         move_pieces (n, empty_pos, num_cols * SGN (n - empty_pos), draw);
      else if (n / num_cols == empty_pos / num_cols)
         move_pieces (n, empty_pos, SGN (n - empty_pos), draw);
      if (draw && puzzle_done ())
         draw_puzzle ();
   }
}


BOOL
init_puzzle (void)
{
   ULONG   pict_w, pict_h;
   
   pict_w = puzzle_win->Width -
            puzzle_win->BorderLeft - puzzle_win->BorderRight;
   pict_h = puzzle_win->Height -
            puzzle_win->BorderTop - puzzle_win->BorderBottom;
   max_cols = (pict_w - 2 * MIN_BORDER) / MIN_PIECE_SIDE;
   max_rows = (pict_h - 2 * MIN_BORDER) / MIN_PIECE_SIDE;
   if (max_cols < MIN_COLS_ROWS || max_rows < MIN_COLS_ROWS)
      return FALSE;
   
   srand48 (time (NULL));
   
   return TRUE;
}


void
finalize_puzzle (void)
{
   FreeVec (pieces);
}


BOOL
define_puzzle (
   UBYTE   rows,
   UBYTE   cols)
{
   ULONG   pict_w, pict_h;
   
   if (cols < MIN_COLS_ROWS)
      cols = MIN_COLS_ROWS;
   else if (cols > max_cols)
      cols = max_cols;
   if (rows < MIN_COLS_ROWS)
      rows = MIN_COLS_ROWS;
   else if (rows > max_rows)
      rows = max_rows;
   
   if (rows != num_rows || cols != num_cols)
   {
      FreeVec (pieces);
      pieces = AllocVec (rows * cols * sizeof (*pieces), 0L);
   }
   if (pieces == NULL)
      return FALSE;
   
   num_cols = cols;
   num_rows = rows;
   num_correct = num_cols * num_rows;
   pict_w = puzzle_win->Width -
            puzzle_win->BorderLeft - puzzle_win->BorderRight;
   pict_h = puzzle_win->Height -
            puzzle_win->BorderTop - puzzle_win->BorderBottom;
   piece_w = (pict_w - 2 * MIN_BORDER) / num_cols;
   piece_h = (pict_h - 2 * MIN_BORDER) / num_rows;
   x_offs = (pict_w - piece_w * num_cols) / 2;
   y_offs = (pict_h - piece_h * num_rows) / 2;
   
   return TRUE;
}


void
shuffle_puzzle (void)
{
   UWORD   n;
   
   SetWindowPointer (puzzle_win, WA_BusyPointer, TRUE, TAG_DONE);
   for (n = 0; n < num_cols * num_rows; ++n)
      pieces[n] = n;
   num_correct = num_cols * num_rows;
   empty_pos = EMPTYPIECE;
   
   do
   {
      for (n = 0; n < 20 * num_cols * num_rows; ++n)
      {
         if (n & 1)
         {
            play_puzzle (empty_pos % num_cols +
                         (UWORD)(drand48 () * num_rows) * num_cols, FALSE);
         }
         else
         {
            play_puzzle ((empty_pos / num_cols) * num_cols +
                         (UWORD)(drand48 () * num_cols), FALSE);
         }
      }
   }
   while (puzzle_done ());
   draw_puzzle ();
   SetWindowPointer (puzzle_win, WA_Pointer, NULL, TAG_DONE);
}


BOOL
puzzle_done (void)
{
   return (BOOL)(num_correct == num_cols * num_rows);
}


BOOL
is_inside_puzzle (
   LONG   x,
   LONG   y)
{
   return (BOOL)(x >= puzzle_win->BorderLeft + x_offs &&
                 y >= puzzle_win->BorderTop + y_offs &&
                 x < puzzle_win->BorderLeft + x_offs +
                     piece_w * num_cols &&
                 y < puzzle_win->BorderTop + y_offs +
                     piece_h * num_rows);
}


UWORD
coords2piece (
   LONG   x,
   LONG   y)
{
   return (UWORD)((x - puzzle_win->BorderLeft - x_offs) / piece_w +
          ((y - puzzle_win->BorderTop - y_offs) / piece_h) * num_cols);
}


UWORD
key2piece (
   UWORD   code)
{
   LONG   ret_val = empty_pos;
   
   switch (code)
   {
   case CURSORUP:
      ret_val = empty_pos + num_cols;
      if (ret_val > EMPTYPIECE)
         ret_val = empty_pos;
      break;
   case CURSORDOWN:
      ret_val = empty_pos - num_cols;
      if (ret_val < 0)
         ret_val = empty_pos;
      break;
   case CURSORRIGHT:
      ret_val = empty_pos - 1;
      if (ret_val < 0 || ret_val / num_cols != empty_pos / num_cols)
         ret_val = empty_pos;
      break;
   case CURSORLEFT:
      ret_val = empty_pos + 1;
      if (ret_val / num_cols != empty_pos / num_cols)
         ret_val = empty_pos;
      break;
   }
   
   return (UWORD)ret_val;
}


void
draw_numbers (void)
{
   UWORD   val;
   UBYTE   num_positions;
   char    num_str[6];
   WORD    text_len;
   UWORD   n;
   UBYTE   i;
   
   is_numbers_drawn = !is_numbers_drawn;
   SetDrMd (puzzle_win->RPort, COMPLEMENT);
   SetAPen (puzzle_win->RPort,
            (1 << puzzle_win->RPort->BitMap->Depth) - 1);
   
   for (n = 0; n < num_rows * num_cols; ++n)
   {
      if (n != empty_pos)
      {
         val = pieces[n] + 1;
         num_positions = log10 (val + .2) + 1;
         for (i = num_positions; i >= 1; --i, val /= 10)
            num_str[i - 1] = val % 10 + '0';
         text_len = TextLength (puzzle_win->RPort, 
                                num_str, num_positions);
         if (text_len <= piece_w && puzzle_win->RPort->TxHeight <= piece_h)
         {
            Move (puzzle_win->RPort,
                  puzzle_win->BorderLeft + x_offs +
                  (n % num_cols) * piece_w + (piece_w - text_len) / 2,
                  puzzle_win->BorderTop + y_offs +
                  puzzle_win->RPort->TxBaseline + (n / num_cols) * piece_h +
                  (piece_h - puzzle_win->RPort->TxHeight) / 2);
            Text (puzzle_win->RPort, num_str, num_positions);
         }
      }
   }
   
   SetDrMd (puzzle_win->RPort, JAM1);
}
