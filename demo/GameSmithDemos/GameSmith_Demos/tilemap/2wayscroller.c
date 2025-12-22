/*

   2-Way Tilemap Scroller Example
   
   Clint A. Sinclair - Apr. 11, 1994 
   
   The demonstration lets you use the joystick to scroll the screen
   left/right through a tilemap which is ten screens wide (200x10 tiles).
   The tiles are 16x16 blocks, 6 bitplanes (EXTRA_HALFBRITE).
   This uses a bitmap 688 pixels wide (twice the width of the display,
   plus an extra row on each side and one in the middle -- makes blitting
   the tiles easier).
   
   The files "TILES.DAT" and "MAP.DAT" must be in the current directory.
   
   "TILES.DAT" is the graphics data for the tiles -- each tile takes 192 
   bytes (16 x 16 x 6 planes), and there are 107 tiles in the set.
   "MAP.DAT" is the tilemap -- 200x10 tiles, 1 byte per tile. 
   
   Compiled with SAS (Lattice) V5.02.

   --------------------------------

   NOTE: graphics (c) Clint A. Sinclair 1994, all rights reserved.  This
   example is included with the GameSmith development system by permission.
   The graphics are not to be used for anything beyond this demo (Clint is
   making a game with them and was generous enough to share).

   --------------------------------

*/


#include <stdio.h>
#include <stdlib.h>         /* SAS 6.0 type addition */
#include <exec/types.h>
#include <exec/memory.h>
#include <libraries/dos.h>
#include <graphics/gfxbase.h>

#include <proto/exec.h>      /* SAS 6.0 type addition */
#include <proto/dos.h>      /* SAS 6.0 type addition */
#include <proto/graphics.h> /* SAS 6.0 type addition */

#include <GameSmith:GameSmith.h>
#include <GameSmith:include/libraries/libptrs.h>

/* Defines */

#define MAPWIDTH  200      /* Map is 200 tiles wide */
#define MAPHEIGHT  10      /* Map is 10 tiles high */

#define SCREENWIDTH  20      /* Visible screen width in tiles */
#define SCREENHEIGHT  10   /* Visible screen height in tiles */
#define SCREENDEPTH   6      /* number of bitplanes to use */

#define NUMTILES  106      /* 106 tiles in the set */
#define TILESIZE   ((16/8)*16*SCREENDEPTH)      /* tile size in bytes (width*height*depth) */

#define SCROLLSPEED  2      /* Pixels scrolled per frame - must be 1, 2, 4, or 8 in this example. */


/* 64 colour palette */
ULONG colortable[] = {
0x0,0xeebb99,0xff0000,0xbb0000,0xff6600,0xee00,0xbb00,0xee,
0xaa,0xffff33,0xcccc11,0x999911,0xedee,0xbbbb,0xbb6611,0x994411,
0x773311,0xffffff,0xcccccc,0x998899,0x99ff,0x77cc,0x11cc99,0x119977,
0xee0099,0xbb0077,0x8800dd,0x5500aa,0x556611,0x224400,0x775544,0xeeeebb,
0x0,0x775d4c,0x7f0000,0x5d0000,0x7f3300,0x7700,0x5d00,0x77,
0x55,0x7f7f19,0x666608,0x4c4c08,0x7677,0x5d5d,0x5d3308,0x4c2208,
0x3b1908,0x7f7f7f,0x666666,0x4c444c,0x4c7f,0x3b66,0x8664c,0x84c3b,
0x77004c,0x5d003b,0x44006e,0x2a0055,0x2a3308,0x112200,0x3b2a22,0x77775d
};

/* For Dos Files */
BPTR file=0;
BPTR Open();
int len=0;

struct gs_viewport vpS =
{
   NULL,      /* ptr to next viewport */
   colortable,      /* ptr to color table */
   64,         /* number of colors in table */
   NULL,         /* ptr to user copper list */
   SCREENHEIGHT*16,320,SCREENDEPTH,SCREENHEIGHT*16,688,   /* height, width, depth, bmheight, bmwidth */
   0,0,      /* top & left viewport offsets */
   16,0,      /* X & Y bitmap offsets */
   GSVP_ALLOCBM,    /* flags (alloc bitmaps) */
   NULL,NULL,      /* 2.xx & above compatibility stuff */
   NULL,NULL,      /* bitmap pointers */
   NULL,      /* future expansion */
   0,0,0,0      /* display clip (MinX,MinY,MaxX,MaxY) */
};
struct display_struct display =
{
   NULL,      /* ptr to previous display view */
   NULL,NULL,      /* 2.xx & above compatibility stuff */
   0,0,      /* X and Y display offsets (1.3 style) */
   EXTRA_HALFBRITE,         /* display mode ID */
   4,4,     /* sprite priorities */
   GSV_SCROLLABLE,   /* flags (scrollable) */
   &vpS,      /* ptr to 1st viewport */
   NULL      /* future expansion */
};


struct gs_viewport *gsvp;  /* Pointer to gs_viewport */   

struct BitMap *bm;   /* Pointer to the display bitmap */

UBYTE *tilesdata=0;   /* Pointer to chunk of chip data for tiles graphics */

UBYTE map[MAPHEIGHT][MAPWIDTH];    /* Map array - y,x (NOT x,y, because of how it's loaded in, ROW at a time.) */


/* Struct for blitting tiles to screen (just using same struct and changing "data" pointer for each) */
struct blit_struct blit =
{
   0,0,0,
   6,0xff,1,16,32,
   0,0,0,0,0,0,0
};


void BlitRow(WORD, WORD);
void Quit(char *);


int main(void)      /* MAIN */
{
   int joy;                  /* Value returned from joystick */
   WORD x,y;               /* Positions */
   WORD nextrow;            /* Number of next row in map to be scrolled onto */
   
   
   /* Open the dos and graphics libraries */
   if(gs_open_libs(DOS|GRAPHICS,0))Quit("Can't open a library!");

   /* Allocate memory for tile graphics (each tile takes 192 bytes) */
   if(!(tilesdata=(UBYTE *)AllocMem(TILESIZE*NUMTILES,MEMF_CHIP)))
      Quit("Not Enough Chip Memory.");
   
   /* Load tile graphics */
   file=Open("TILES.DAT",MODE_OLDFILE);
   if(file==0)Quit("Can't Open File: TILES.DAT!");
   len=Read(file,(BYTE *)tilesdata,TILESIZE*NUMTILES);
   if(len==-1)Quit("Can't Read File: TILES.DAT!");
   Close(file);file=0;
   
   /* Load tilemap */
   file=Open("MAP.DAT",MODE_OLDFILE);
   if(file==0)Quit("Can't Open File: MAP.DAT!");
   len=Read(file,(BYTE *)&map[0][0],MAPWIDTH*MAPHEIGHT);
   if(len==-1)Quit("Can't Read File: MAP.DAT!");
   Close(file);file=0;
   
   Forbid();  /* Take over the system */
   
   #ifdef NTSC_MONITOR_ID   /* JE: AGA mode promotion must hide too much of left */
                           /* on scrollable screen.  Let's disable it. */
      if (GfxBase->LibNode.lib_Version >= 36)   /* if WB 2.0 or higher */
         {               /* this defeats mode promotion on AGA machines */
         if (ModeNotAvailable(NTSC_MONITOR_ID))   /* select correct display type. NTSC preferred */
            {
            display.modes |= PAL_MONITOR_ID;
            }
         else
            {
            display.modes |= NTSC_MONITOR_ID;
            }
         }
   #endif
   /* Create the GameSmith display - 688x160x64, not double-buffered. */
   if(gs_create_display(&display))Quit("Can't create display!");

   /* Actually show the new display */
   gs_show_display(&display,1);  /* Sync'ed */
   
   gsvp=display.vp;  /* Set pointer to gs_viewport */
   bm=gsvp->bitmap1;  /* Set pointer to bitmap1 */
   
   /* Blit first screen of tiles to the visible display (and blit the same thing again, one screen to the right) */
   for(y=0;y<SCREENHEIGHT;y++)
   {
      for(x=0;x<=SCREENWIDTH;x++)
      {
            /* Set pointer to graphics data */
            blit.data=(USHORT *)tilesdata+(96*(map[y][x]));
            /* blit tile into bitmap (twice) */
            gs_blit_copy(&blit,bm,(x<<4)+16,y<<4);   /* "<<4" == "*16" */
            gs_blit_copy(&blit,bm,(x<<4)+352,y<<4);
      }
   }
   
   nextrow=SCREENWIDTH;      /* Set next row to be scrolled into (to the right) */
   
   
   
   /* The main loop  */
   
   for(;;)
   {
      
      if(gs_joystick(0)&(JOY_BUTTON1|JOY_BUTTON2))break;  /* Poll mouse port - click to exit */
      
      joy=gs_joystick(1);   /* Poll joystick port */
      
      
      /* If joystick is moved RIGHT */
      
      if(joy&JOY_RIGHT&&nextrow<MAPWIDTH)
      {
      
      /* Wait until system has updated the last scroll we gave it before proceeding */
      while(display.flags&GSV_SCROLL1);
      
      /* Draw tiles */
      x = gsvp->xoff % 16;
      if(x){y=nextrow-1;BlitRow((WORD)((gsvp->xoff-16)-x),y);}   /* If current x pos is not on even word, blit tiles _behind_ current pos. */
      else {BlitRow((WORD)(gsvp->xoff+320),nextrow);nextrow++;}   /* If it is, blit tiles _ahead_ of current pos, and advance nextrow */
      
      /* Scroll */
      if(gsvp->xoff>=(352-SCROLLSPEED))
         gs_scroll_vp(&display,0,-(336-SCROLLSPEED),0,1);    /* Jump back (more than a full screen - there's an extra row in there) if reached end of bitmap */
      else
         gs_scroll_vp(&display,0,SCROLLSPEED,0,1);   /* Otherwise just scroll one "step" */
      }

      /* If joystick is moved LEFT */
      
      else if(joy&JOY_LEFT&&nextrow>20)
      {
      
      /* Wait till previous scroll is actually done */
      while(display.flags&GSV_SCROLL1);
      
      /* Draw tiles */
      x = gsvp->xoff % 16;
      if(x){y=nextrow-21;if(y>=0)BlitRow((WORD)((gsvp->xoff+320)+(16-x)),y);if(x==SCROLLSPEED)nextrow--;}    /* Only blit the tiles if NOT less than tilerow 0 (y>=0) */
      else {y=nextrow-21;if(y>=0)BlitRow((WORD)(gsvp->xoff-16),y);}
      
      /* Scroll */
      if(gsvp->xoff<=(16+SCROLLSPEED))
         gs_scroll_vp(&display,0,336-SCROLLSPEED,0,1);    /* Jump foreward if reached beginning of bitmap */
      else
         gs_scroll_vp(&display,0,-SCROLLSPEED,0,1);  /* Otherwise regular step */
      }

   }
   
   Quit("Bye!");   /* Clean up */
   
   return(0);      /* (This is just to stop the compiler from giving me a warning) */
}


void BlitRow(bitmapx,mapx)   /* Draw a vertical row of tiles. bitmapx = position into bitmap (pixel pos), mapx = which row to read from tilemap. */
WORD bitmapx,mapx;
{
   UBYTE ystep;
   
   for(ystep=0;ystep<SCREENHEIGHT;ystep++)
   {
         /* Set pointer to graphics data */
         blit.data=(USHORT *)tilesdata+(96*(map[ystep][mapx]));
         /* blit tile into bitmap */
         gs_blit_copy(&blit,bm,bitmapx,ystep<<4);
   }
}


void Quit(char *stringy)   /* Close everything and exit */
{
   /* Close file if open */
   if(file)Close(file);
   
   /* Free tiles data */
   if(tilesdata)FreeMem(tilesdata,TILESIZE*NUMTILES);
   
   /* Remove the display */
   gs_remove_display(&display);
   
   Permit();  /* Give the system back */
   
   gs_close_libs();   /* Close ALL opened libraries */
   
   if(stringy)printf("%s\n",stringy);  /* Print error string */
   
   exit(0);  /* Leave */
}
