/* ==== sdl-toms.h ==== */
/*  Part of the source of the program "SDL-Toms", a puzzle game.
    Copyright (C) 2002-2003  Tom Barnes-Lawrence
    Current web address: www.angelfire.com/super2/duologue/#sdl-toms
    Current email address: tomble@usermail.com

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */




#include "SDL.h"
#include "SDL_image.h"

#define MAX_PLAYERS 4

#define GET_RECT(col,row,rect) (rect.x=8+(39*col)),(rect.y=8+(39*row))

typedef enum {
   MENU_ARROW,
   MENU_START,
   MENU_PSETUP,
   MENU_DSETUP,
   MENU_QUIT,
   MENU_P2,
   MENU_P3,
   MENU_P4,
   MENU_FS,
   MENU_IGAMMA,
   MENU_DGAMMA,
   MENU_GAMMAICON, /* The halftoned image */
   MENU_RETURN,
   MENU_LAST
} menuitem_t;


struct udlist_t { /* cells that need updating */
   int Col; /* Column this element uses */
   int Extra[10]; /* Array of how many atoms each
                  cell of this column gains. Should be
                  initialised to 0 when this element created */
   struct udlist_t *Next; /* next column with gains */
};
typedef struct udlist_t udlist_t;

struct ulist_t{
   int Idx; /* Index of cell that's unstable */
   int Gl; /* whether or not an atom will be shot to the left */
   int Gr; /* """"" right */
   int Gu; /* """"" up */
   int Gd; /* """"" down */
   int Freeit; /* 0 if from an array */
   struct ulist_t *Next; /* next in list */
};
typedef struct ulist_t ulist_t;

/* protos */
/* chain.c*/
int do_chain(int playerno); /* returns 1 if player wins. Intuitive, eh? ;) */
void new_unstable(int i); /* appends item to list */
void new_update(int index);
ulist_t *get_unstable();
void free_unstable(ulist_t *u);
udlist_t *get_update(); /*NEVER mallocs */
void free_update(); /* just changes a counter */


/* main.c, graphics.c */
void game_loop();
void init_graphics();
void draw_menu_bg();
void draw_grid();
SDL_Surface *at_surf(int player,int atoms);
void main_menu();
int get_menu_choice(int sline,int choices,int dchoice);


/* externs */
extern int cells[];
/* number of atoms in a cell */
extern int pcell[];
/* player who owns cell */

extern int players;
extern int in_game[];

extern ulist_t *unstable_list;

extern SDL_Surface *main_surf;
extern SDL_Surface *expl_surf;

extern SDL_Surface *menu_surface[];
extern SDL_Surface *menu_back[];

extern double gamma;
extern int fullscreen;
