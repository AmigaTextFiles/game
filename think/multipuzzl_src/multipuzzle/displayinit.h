/*
 * displayinit.h
 * =============
 * Interface to display initialization.
 *
 * Copyright (C) 1994-1998 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef DISPLAYINIT_H
#define DISPLAYINIT_H

#include <exec/types.h>


#define PRG_NAME        "MultiPuzzle"
#define VERSION_NO      "1.2"
#define CREATION_YEAR   "1994-1998"
#define AUTHOR          "Håkan L. Younes"
#define MAIL_ADDRESS    "(lorens@hem.passagen.se)"


/* menynradens alternativ */
#define MENU_GAME       0
#define ITEM_NEW        0
#define ITEM_ABOUT      2
#define ITEM_QUIT       4
#define MENU_SETTINGS   1
#define ITEM_PICTURE    0


/* felmeddelanden */
#define FILE_ABORT   1
#define FILE_ERROR   2


BOOL
request_picture (
   char  *pict_name);


/*
 * load_picture
 * ------------
 * Reads a picture with the given name to use as puzzle.
 *
 * Arguments:
 *  pict_name - name of picture file.
 * Returnvalue:
 *  TRUE on success, FALSE otherwise.
 * Sideeffects:
 *  A window is opened and some datastructures get initialized.
 */
BOOL
load_picture (
   char  *pict_name);


/*
 * init_display
 * ------------
 * Initializes the graphical inteface and reads the given picture.
 *
 * Arguments:
 *  pubscr_name - name of public screen.
 *  pict_name   - name of picture.
 * Returnvalue:
 *  TRUE on success, FALSE otherwise.
 */
BOOL
init_display (
   char  *pubscr_name,
   char  *pict_name);


/*
 * finalize_display
 * ----------------
 * Closes the window and frees dynamically allocated data structures.
 *
 * Arguments:
 *  none
 * Returvalue:
 *  none
 */
void
finalize_display (void);

#endif /* DISPLAYINIT_H */
