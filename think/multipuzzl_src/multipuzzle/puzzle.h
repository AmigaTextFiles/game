/*
 * puzzle.h
 * ========
 * Interface to puzzle module.
 *
 * Copyright (C) 1994-1998 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef PUZZLE_H
#define PUZZLE_H


/*
 * init_puzzle
 * -----------
 * Initializes module.
 *
 * Arguments:
 *  none
 * Returnvalue:
 *  TRUE on success, FALSE otherwise.
 */
BOOL
init_puzzle (void);


/*
 * finalize_puzzle
 * ---------------
 * Frees memory used by puzzle module.
 *
 * Arguments:
 *  none
 * Returnvalue:
 *  none
 */
void
finalize_puzzle (void);


/*
 * define_puzzle
 * -------------
 * Defines size of puzzle.
 *
 * Arguments:
 *  rows - number of rows.
 *  cols - number of columns.
 * Returnvalue:
 *  TRUE on success, FALSE otherwise.
 */
BOOL
define_puzzle (
   UBYTE   rows,
   UBYTE   cols);


/*
 * shuffle_puzzle
 * --------------
 * Shuffles the puzzle.
 *
 * Arguments:
 *  none
 * Returnvalue:
 *  none
 */
void
shuffle_puzzle (void);


/*
 * puzzle_done
 * -----------
 * Decides if all pieces are in their original position.
 *
 * Arguments:
 *  none
 * Returnvalue:
 *  TRUE if all pieces are in their original position, FALSE otherwise.
 */
BOOL
puzzle_done (void);


/*
 * is_inside_puzzle
 * ----------------
 * Decides if the given point is inside the puzzle.
 *
 * Arguments:
 *  x, y - the point.
 * Returvalue:
 *  TRUE if the given point is inside the puzzle, FALSE otherwise.
 */
BOOL
is_inside_puzzle (
   LONG   x,
   LONG   y);


/*
 * coords2piece
 * ------------
 * Converts a screen point to a piece number.
 *
 * Arguments:
 *  x, y - the point.
 * Returnvalue:
 *  A piece number.
 */
UWORD
coords2piece (
   LONG   x,
   LONG   y);


/*
 * key2piece
 * ---------
 * Converts a RAWKEY-code to a piece number.
 *
 * Arguments:
 *  code - a RAWKEY-code.
 * Returnvalue:
 *  A piece number.
 */
UWORD
key2piece (
   UWORD   code);


/*
 * draw_numbers
 * ------------
 * Draws (or erases) piece numbers.
 *
 * Arguments:
 *  none
 * Returnvalue:
 *  none
 */
void
draw_numbers (void);


/*
 * play_puzzle
 * -----------
 * Tries to move the piece in the given position.
 *
 * Arguments:
 *  n    - the piece position.
 *  draw - TRUE if the move should be drawn, FALSE otherwise.
 * Returnvalue:
 *  none
 */
void
play_puzzle (
   UWORD   n,
   BOOL    draw);

#endif /* PUZZLE_H */
