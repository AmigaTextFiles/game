/***************************************************************************
 *
 * misc.c -- Some misc routines..
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

#include <stdio.h>
#include <math.h>
#include <exec/types.h>
#include <intuition/intuition.h>
#include <proto/graphics.h>

#include "map.h"
#include "defs.h"
#include "misc.h"
#include "ships.h"

#ifndef PURE_OS
#include "hline_protos.h"
#endif

/*--------------------------------------------------------------------------*/

int sina[360];
int cosa[360];
int atana[PRECS+1];

extern AWorld World;

int pixelbyterow[WP_TABLESIZE];        /* Need this in HorizontalLine */
#ifndef PURE_OS
static int pixelbytecol[WP_TABLESIZE];
#endif

/*--------------------------------------------------------------------------*/

/*
 * init_sctables -- Precalculates sine & cosine tables for fast lookup +
 *                  arctan table upto 45 degrees.
 *
 */
void
init_sctables(void)
{
  int i;

  for (i = 0; i < 360; i++) {
    sina[i] = (int) (sin((double)(PI/180)*(double)i) * PRECS);
    cosa[i] = (int) (cos((double)(PI/180)*(double)i) * PRECS);
  }
  for (i = 0; i < PRECS+1; i++)
    atana[i] = (int) (atan((double)i/(double)PRECS)*180.0/PI);
}

/*--------------------------------------------------------------------------*/

#ifndef PURE_OS    /* We don't need these on 3rd party cards.. */

/*
 * init_writepixel -- Precalculates some pixel values, speeds up
 *                    myWritePixel with about 30%.
 */
void
init_writepixel( int bytesPerRow )
{
  int i;

  for (i = 0; i < WP_TABLESIZE; i++) {
    pixelbyterow[i] = i * bytesPerRow;
    pixelbytecol[i] = (i >> 3);
  }
}  

/*--------------------------------------------------------------------------*/

/*
 * myWritePixel -- Just a speedier WritePixel routine than the one provided
 *                 by the system. (Does no range/window checking).
 *                 int mode: 1 -> Set the pixel, 0 -> Clear it.
 */
void
myWritePixel( PLANEPTR thePlane, int x, int y, int mode )
{
  int pixbyte, pixrot;

  /* 
   * pixbyte = y*bytesPerRow + (x >> 3); 
   */

  pixbyte = pixelbyterow[y] + pixelbytecol[x];
  pixrot  = x & 0x7;

  if (mode == 1)
    thePlane[pixbyte] |= (0x80 >> pixrot);
  else
    thePlane[pixbyte] &= ~(0x80 >> pixrot);
}

/*--------------------------------------------------------------------------*/

/*
 * VerticalLine -- Draws...gasp...vertical lines.
 *
 */
void
VerticalLine( PLANEPTR thePlane, int x, int y, int length, int onoff )
{
  int i, pixbyte;
  USHORT pixbit;
  int bpr = pixelbyterow[1];

  pixbyte = pixelbyterow[y] + pixelbytecol[x];
  pixbit  = (onoff == 0) ? ~(0x80 >> (x & 0x7)) : (0x80 >> (x & 0x7)) ;
  
  if (onoff == 0) {
    for (i = 0; i < length; i++) {
      thePlane[pixbyte] &= pixbit;
      pixbyte += bpr;
    }
  } else {
    for (i = 0; i < length; i++) {
      thePlane[pixbyte] |= pixbit;
      pixbyte += bpr;
    }
  }
}

#endif /* !PURE_OS */

/*--------------------------------------------------------------------------*/

/*
 * draw_hud -- Draws the heads up display on the local console.
 *             To be expanded...
 */
void
draw_hud( struct RastPort *rp, UWORD buf, UWORD nframes )
{
  /* 
   * h_drawn is used when erasing the hud; tells in which buffers 
   * the hud has been drawn. 
   */
  static int  ontime   = 0;
  static BOOL h_drawn[MY_BUFFERS] = { FALSE, FALSE };

  AShip    *lship = World.local_ship;
  char cbuf[10];
  int  i, fuelheight;
  int  sv_x, sv_y;
#ifndef PURE_OS
  PLANEPTR bpl1;

  bpl1 = rp->BitMap->Planes[1];
#endif

  /*
   * Remove old speedvector..
   */
  SetAPen(rp, 0);
  SetWriteMask(rp, 1l);
  Move(rp, LOCL_X, LOCL_Y);
  Draw(rp, World.p_sv[buf].x, World.p_sv[buf].y);
  
  /*
   * Draw hud upper and lower lines..
   */
#ifdef PURE_OS
  SetWriteMask(rp, 2l);
  SetAPen(rp,2);
  for (i = 0; i < 10; i++) {
    HLINE( rp, LOCL_X-63+(13*i), LOCL_Y-51, 10 )
  }
  HLINE( rp, LOCL_X-63, LOCL_Y+51, 128 )
#else
  for (i = 0; i < 10; i++) {
    HorizontalLine( bpl1, LOCL_X-63+(13*i), LOCL_Y-51, 10, 1 );
  }
  HorizontalLine( bpl1, LOCL_X-63, LOCL_Y+51, 128, 1 );
#endif

  if (World.local_ship->fueling || World.hudon) {
    World.hudon = FALSE;
    ontime = 1;
  }

  /*
   * Draw fuelmeter..
   */
  if (ontime != 0) {
    ontime += nframes;
    if (ontime >= HUDON_TIME) {
      ontime = 0;
    }
#ifdef PURE_OS
    SetAPen(rp,2);
    HLINE( rp, LOCL_X+54, LOCL_Y-48, 10 )
    HLINE( rp, LOCL_X+54, LOCL_Y+37, 10 )
    VLINE( rp, LOCL_X+54, LOCL_Y-47, 84 )
    VLINE( rp, LOCL_X+63, LOCL_Y-47, 84 )
#else
    HorizontalLine( bpl1, LOCL_X+54, LOCL_Y-48, 10, 1 );
    HorizontalLine( bpl1, LOCL_X+54, LOCL_Y+37, 10, 1 );
    VerticalLine( bpl1, LOCL_X+54, LOCL_Y-47, 84, 1 );
    VerticalLine( bpl1, LOCL_X+63, LOCL_Y-47, 84, 1 );
#endif
    fuelheight = ((((World.local_ship->fuel << SHFTPR) / MAXFUEL) * 82)
                 >> SHFTPR);
#ifndef PURE_OS
    SetWriteMask(rp, 2l);
#endif

    SetAPen(rp, 0);
    RectFill( rp, LOCL_X+56, LOCL_Y-47+fuelheight, 
                  LOCL_X+61, LOCL_Y+35 );
    SetAPen(rp, 2);
    RectFill( rp, LOCL_X+56, LOCL_Y+35-fuelheight, 
                  LOCL_X+61, LOCL_Y+35 );

    sprintf(cbuf, "%5d", World.local_ship->fuel);
    Move( rp, LOCL_X+39, LOCL_Y+47 );
    Text( rp, cbuf, 5 );

    h_drawn[buf] = TRUE;

  } else if (h_drawn[buf] == TRUE) {
    /*
     * Remove fuelmeter..
     */
    SetAPen(rp, 0);
    SetWriteMask(rp, 2l);
    RectFill( rp, LOCL_X+54, LOCL_Y-48, LOCL_X+63, LOCL_Y+37 );
    RectFill( rp, LOCL_X+38, LOCL_Y+40, LOCL_X+63, LOCL_Y+48 );
    h_drawn[buf] = FALSE;
  }  

  /*
   * Check if dead.
   */
  if (lship->status > 0)
    return;

  /*
   * Calculate and draw new speed vector.
   */
  sv_x = LOCL_X + (((lship->xvel * 20) >> SHFTPR) % LOCL_X);
  sv_y = LOCL_Y + (((lship->yvel * 20) >> SHFTPR) % LOCL_Y);

  World.p_sv[buf].x = sv_x;
  World.p_sv[buf].y = sv_y;
 
  SetAPen(rp, 1);
  SetWriteMask(rp, 1l);
  Move(rp, LOCL_X, LOCL_Y);
  Draw(rp, sv_x, sv_y);
}
