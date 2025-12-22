/**************************************************************************
 *
 * map.c -- Functions for reading and drawing the map into
 *          memory.
 *
 *-------------------------------------------------------------------------
 * Authors: Casper Gripenberg  (casper@alpha.hut.fi)
 *          Kjetil Jacobsen  (kjetilja@stud.cs.uit.no)
 *
 */

/*------------------------------------------------------------------------*/

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>
#include <intuition/intuition.h>
#include <libraries/dos.h>          /* Official return codes defined here */

#include <proto/intuition.h>
#include <proto/graphics.h>

#include "map_protos.h"
#include "main_protos.h"
#include "misc_protos.h"
#include "lists_protos.h"
#include "cannon_protos.h"
#include "fuelpod_protos.h"
#ifndef PURE_OS
#include "hline_protos.h"
#endif

#include "prefs.h"
#include "common.h"
#include "fuelpod.h"
#include "misc.h"

/*------------------------------------------------------------------------*/

#define MAXKEYWORD 80   /* Max length of any keyword in the mapfile  */

extern AWorld World;    /* From main */
char   **map_file;      /* Here every mapline will be put separately */

#define TBLSIZE ('z'-'a')

#define up_tbl(ch) u_tbl['z' - tolower(ch)]
#define dn_tbl(ch) d_tbl['z' - tolower(ch)]
#define le_tbl(ch) l_tbl['z' - tolower(ch)]
#define ri_tbl(ch) r_tbl['z' - tolower(ch)]

#define test_u(ch) ((ch) < 'a' || (ch) > 'z' ? TRUE : up_tbl(ch))
#define test_d(ch) ((ch) < 'a' || (ch) > 'z' ? TRUE : dn_tbl(ch))
#define test_l(ch) ((ch) < 'a' || (ch) > 'z' ? TRUE : le_tbl(ch))
#define test_r(ch) ((ch) < 'a' || (ch) > 'z' ? TRUE : ri_tbl(ch))

/*------------------------------------------------------------------------*/

/*
 * Maptables:
 * These determine when to draw lines based on what is around
 * a certain map point. A small kludge. Maybe I'll think of something
 * more elegant later.. Atleast malloc the tables..
 */
void
init_maptables(BOOL u_tbl[], BOOL d_tbl[], BOOL l_tbl[], BOOL r_tbl[])
{
  int i;

  for (i = 0; i < TBLSIZE; i++) {
    u_tbl[i] = TRUE;
    d_tbl[i] = TRUE;
    l_tbl[i] = TRUE;
    r_tbl[i] = TRUE;
  }

  up_tbl('x') = FALSE;
  up_tbl('q') = FALSE;
  up_tbl('w') = FALSE;

  dn_tbl('x') = FALSE;
  dn_tbl('a') = FALSE;
  dn_tbl('s') = FALSE;

  le_tbl('x') = FALSE;  
  le_tbl('q') = FALSE;
  le_tbl('a') = FALSE;
  
  ri_tbl('x') = FALSE;
  ri_tbl('w') = FALSE;
  ri_tbl('s') = FALSE;
}

/*------------------------------------------------------------------------*/

/*
 * init_map -- Should be partially compatible with xpilot mapfiles.
 *
 */
void
init_map( void )
{
  FILE *map_fh;
  int i, x, y; 
  int line      = 0;
  char *char_chunk;
  char line_buf[MAXLINE];
  char keyword[MAXKEYWORD];
  char argument[MAXKEYWORD];
  MAP_Point *point_chunk;

  if ( !(map_fh = fopen(prefs.mapname, "r")) )
    cleanExit( RETURN_WARN, "** Mapfile '%s' not found\n", prefs.mapname );

  /*
   * Parse the mapfile
   */
  while (fgets(line_buf, MAXLINE, map_fh)) {
    line++;

    /* Check for comments and empty lines */
    if (line_buf[0] == '#' || line_buf[0] == '\n')
      continue;

    if (strlen(line_buf) > MAXKEYWORD)
      cleanExit( RETURN_WARN, "** Mapline %d too long\n", line-1 );

    if ( sscanf(line_buf, "%[^:]:%s", keyword, argument) != 2 )
      cleanExit( RETURN_WARN, "** Invalid mapline %d.\n", line-1 );

    /* Skip trailing blanks */
    for (i = 0; keyword[i] != '\0'; i++) {
      if (keyword[i] == ' ') {
        keyword[i] = '\0';
        break;
      }
    }
        
    if (stricmp(keyword, "mapWidth") == 0)
      World.Width = atoi(argument);
    else if (stricmp(keyword, "mapHeight") == 0)
      World.Height = atoi(argument);
    else if (stricmp(keyword, "mapData") == 0)
      break;
    else
      printf("** Unsupported keyword %s in mapfile.\n", keyword);
  }

  if (World.Width == 0 || World.Height == 0)
    cleanExit( RETURN_WARN, 
               "** Missing map dimension specifications in mapfile %s\n",
               MAPFILE );

  /*
   * Allocate space for the maplines
   */
  if ((map_file = (char **) malloc(sizeof(char *) * World.Height)) == NULL)
    cleanExit( RETURN_WARN, "** Could not allocate space for map.\n" );
  if ((char_chunk = (char *) 
       malloc(sizeof(char) * (World.Width * World.Height))) == NULL)
    cleanExit( RETURN_WARN, "** Could not allocate space for map.\n" );

  line = 0;
  while (fgets(line_buf, MAXLINE, map_fh)) {

    if ( strlen(line_buf) < World.Width )
      cleanExit( RETURN_WARN, "** Mapline %d too short\n", line+1 );

    map_file[line] = &char_chunk[line * World.Width];

    for (i = 0; i < World.Width; i++)
      map_file[line][i] = line_buf[i];

    line++;
    if (line >= World.Height)
      break;
  }

  fclose(map_fh);

  if (line < World.Height)
    cleanExit( RETURN_WARN, "** Mapfile: Not enough lines.\n" );

  if ((World.map_points = (MAP_Point **) 
       malloc(sizeof(MAP_Point *) * World.Width)) == NULL)
    cleanExit( RETURN_WARN, "** Could not allocate space for map.\n" );
  if ((point_chunk = (MAP_Point *)
       malloc(sizeof(MAP_Point) * (World.Width * World.Height))) == NULL)
    cleanExit( RETURN_WARN, "** Could not allocate space for map.\n" );

  for ( y = 0; y < World.Height; y++ ) {
    World.map_points[y] = &point_chunk[y * World.Width];
    for ( x = 0; x < World.Width; x++ ) 
      World.map_points[y][x].draw_flags = 0;
  }

  prepare_map();

  free(char_chunk);
  free(map_file);
}

/*------------------------------------------------------------------------*/

/*
 * prepare_map -- Converts the read mapifile into an internal format
 *                for later use.
 */
void
prepare_map( void )
{
  int x, y;

  char *p_line;
  char *c_line;
  char *n_line;

  /* True if there should be a line in this 'direction' */
  BOOL u_ch, d_ch, l_ch, r_ch;

  BOOL u_tbl[TBLSIZE];
  BOOL d_tbl[TBLSIZE];
  BOOL l_tbl[TBLSIZE];
  BOOL r_tbl[TBLSIZE];

  init_maptables(u_tbl, d_tbl, l_tbl, r_tbl);

  for ( y = 0; y < World.Height; y++ ) {

    if (y == 0) 
       p_line = NULL;
    else        
       p_line = map_file[y-1];

    if ( y < World.Height-1 ) 
       n_line = map_file[y+1];
    else
       n_line = NULL;

    c_line = map_file[y];

    for ( x = 0; x < World.Width; x++ ) {
      if (p_line) u_ch = test_u(p_line[x]);
      else        u_ch = FALSE;
      if (n_line) d_ch = test_d(n_line[x]);
      else        d_ch = FALSE;
      if (x > 0)  l_ch = test_l(c_line[x-1]);
      else        l_ch = FALSE;
      if (x < World.Width-1) r_ch = test_r(c_line[x+1]);
      else                   r_ch = FALSE;
      
      /* Precalculate these..speeds up map rendering (?) */
      World.map_points[y][x].edge_x = x * MAP_BLOCKSIZE;
      World.map_points[y][x].edge_y = y * MAP_BLOCKSIZE;

      switch (c_line[x]) {
        case ' ':
          World.map_points[y][x].blocktype = BLOCK_EMPTY;
          break;
        case 'x':
          if ( !u_ch && !d_ch && !l_ch && !r_ch ) {
            World.map_points[y][x].blocktype = BLOCK_FILLED_ND;
            break;
          }
          World.map_points[y][x].blocktype = BLOCK_FILLED;
          if (u_ch) World.map_points[y][x].draw_flags |= DRAW_UP;
          if (d_ch) World.map_points[y][x].draw_flags |= DRAW_DOWN;
          if (l_ch) World.map_points[y][x].draw_flags |= DRAW_LEFT;
          if (r_ch) World.map_points[y][x].draw_flags |= DRAW_RIGHT;
          break;
        case 'a':
          World.map_points[y][x].blocktype = BLOCK_RU;
          if (u_ch) World.map_points[y][x].draw_flags |= DRAW_UP;
          if (r_ch) World.map_points[y][x].draw_flags |= DRAW_RIGHT;
          break;
        case 's':
          World.map_points[y][x].blocktype = BLOCK_LU;
          if (u_ch) World.map_points[y][x].draw_flags |= DRAW_UP;
          if (l_ch) World.map_points[y][x].draw_flags |= DRAW_LEFT;
          break;
        case 'q':
          World.map_points[y][x].blocktype = BLOCK_RD;
          if (d_ch) World.map_points[y][x].draw_flags |= DRAW_DOWN;
          if (r_ch) World.map_points[y][x].draw_flags |= DRAW_RIGHT;
          break;
        case 'w':
          World.map_points[y][x].blocktype = BLOCK_LD;
          if (d_ch) World.map_points[y][x].draw_flags |= DRAW_DOWN;
          if (l_ch) World.map_points[y][x].draw_flags |= DRAW_LEFT;
          break;
        case 'r':
          World.map_points[y][x].blocktype = BLOCK_CU;
          World.map_points[y][x].objectptr = (APTR) alloc_cannon(x,y,C_UP);
          break;
        case 'c':
          World.map_points[y][x].blocktype = BLOCK_CD;
          World.map_points[y][x].objectptr = (APTR) alloc_cannon(x,y,C_DN);
          break;
        case 'f':
          World.map_points[y][x].blocktype = BLOCK_CR;
          World.map_points[y][x].objectptr = (APTR) alloc_cannon(x,y,C_RG);
          break;
        case 'd':
          World.map_points[y][x].blocktype = BLOCK_CL;
          World.map_points[y][x].objectptr = (APTR) alloc_cannon(x,y,C_LF);
          break;
        case '#':
          World.map_points[y][x].blocktype = BLOCK_FUEL;
          World.map_points[y][x].draw_flags |= DRAW_UP    | DRAW_DOWN |
                                               DRAW_RIGHT | DRAW_LEFT;
          World.map_points[y][x].objectptr = (APTR) alloc_fuelpod(x,y);
          break;
        case '_':
          World.map_points[y][x].blocktype = BLOCK_BASE;
          World.map_points[y][x].objectptr = (APTR) alloc_base(x,y);
          break;
        default:
          World.map_points[y][x].blocktype = BLOCK_EMPTY;
          break;
      }
    }
  }
}

/*------------------------------------------------------------------------*/

/*
 * draw_map -- Draws the map using the ship local_ship's cordinates
 *             to position the map on the display.
 */
void
draw_map( struct RastPort *wRp, AShip *local_ship, UWORD buf, UWORD nframes )
{
  const int bsz  = MAP_BLOCKSIZE;
  const int bsz1 = MAP_BLOCKSIZE+1;
  const int bsz2 = MAP_BLOCKSIZE/2;
  
  int       i, x, y, onoff, xbsz, ybsz;
  int       bp_x, bp_y, start_x, start_y, end_x, end_y;
  int       fuelamount;
#ifndef PURE_OS
  PLANEPTR  bpl0, bpl1;
#endif  
  UBYTE     cannon_pen, map_pen;
  USHORT    d_flags;
  MAP_Point **map_points = World.map_points;

  static int p_mapx[MY_BUFFERS];
  static int p_mapy[MY_BUFFERS];

#ifndef PURE_OS
  bpl0 = wRp->BitMap->Planes[0];
  bpl1 = wRp->BitMap->Planes[1];
#endif 

  /* First clear old map and then draw new */
  for (i = 0; i < 2; i++) {
    switch (i) {
      case 0:
        /* Clear it */
        SetWriteMask(wRp, 2l);
        SetAPen(wRp, 0);
        cannon_pen = 0;
        map_pen    = 0;
        onoff = 0;
        start_x = (p_mapx[buf]-SCR_WIDTH/2)/MAP_BLOCKSIZE;
        start_y = (p_mapy[buf]-SCR_HEIGHT/2)/MAP_BLOCKSIZE;
        end_x = 1+(p_mapx[buf]+SCR_WIDTH/2)/MAP_BLOCKSIZE;
        end_y = 1+(p_mapy[buf]+SCR_HEIGHT/2)/MAP_BLOCKSIZE;
        bp_x = p_mapx[buf]-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
        bp_y = p_mapy[buf]-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;
        break;
      case 1:
        /* Draw it */
        /* Draw hud first and then the map on the hud. */
        draw_hud(wRp, buf, nframes);
        SetWriteMask(wRp, 2l);
        SetAPen(wRp, 2);
        cannon_pen = 3;
        map_pen    = 2;
        onoff = 1;
        start_x = (local_ship->pos.x-SCR_WIDTH/2)/MAP_BLOCKSIZE;
        start_y = (local_ship->pos.y-SCR_HEIGHT/2)/MAP_BLOCKSIZE;
        end_x = 1+(local_ship->pos.x+SCR_WIDTH/2)/MAP_BLOCKSIZE;
        end_y = 1+(local_ship->pos.y+SCR_HEIGHT/2)/MAP_BLOCKSIZE;
        bp_x = local_ship->pos.x-(SCR_WIDTH+MAP_BLOCKSIZE*2)/2;
        bp_y = local_ship->pos.y-(SCR_HEIGHT+MAP_BLOCKSIZE*2)/2;
        break;
      default:
        /* NOTREACHED */
        break;
    }

    start_x = max( 0, start_x );
    start_y = max( 0, start_y );
    end_x = min( World.Width , end_x );
    end_y = min( World.Height, end_y );

    WaitBlit();

    /* Check for map edges */
    if (start_y == 0) {
      xbsz = map_points[0][start_x].edge_x;
      ybsz = map_points[0][start_x].edge_y;
#ifdef PURE_OS
      HLINE(wRp, xbsz-bp_x, ybsz-bp_y, (end_x-start_x)*bsz)
#else
      HorizontalLine(bpl1, xbsz-bp_x, ybsz-bp_y, (end_x-start_x)*bsz, onoff);
#endif
    }
    if (end_y == World.Height) {
      xbsz = map_points[end_y-1][start_x].edge_x;
      ybsz = map_points[end_y-1][start_x].edge_y;
#ifdef PURE_OS
      HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, (end_x-start_x)*bsz)
#else
      HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, (end_x-start_x)*bsz, onoff);
#endif
    }
    if (start_x == 0) {
      xbsz = map_points[start_y][0].edge_x;
      ybsz = map_points[start_y][0].edge_y;
#ifdef PURE_OS
      VLINE(wRp, xbsz-bp_x, ybsz-bp_y, (end_y-start_y)*bsz)
#else
      VerticalLine(bpl1, xbsz-bp_x, ybsz-bp_y, (end_y-start_y)*bsz, onoff);
#endif
    }
    if (end_x == World.Width) {
      xbsz = map_points[start_y][end_x-1].edge_x;
      ybsz = map_points[start_y][end_x-1].edge_y;
#ifdef PURE_OS
      VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, (end_y-start_y)*bsz)
#else
      VerticalLine(bpl1, xbsz+bsz-bp_x, ybsz-bp_y, (end_y-start_y)*bsz, onoff);
#endif
    }

    for ( y = start_y; y < end_y; y++ ) {
      for ( x = start_x; x < end_x; x++ ) {
        switch (map_points[y][x].blocktype) {                
          case BLOCK_EMPTY:
          case BLOCK_FILLED_ND:
            break;
          case BLOCK_FILLED:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            d_flags = map_points[y][x].draw_flags;
#ifdef PURE_OS
            if (d_flags & DRAW_UP)    { HLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1) }
            if (d_flags & DRAW_DOWN)  { HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1) }
            if (d_flags & DRAW_LEFT)  { VLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1) }
            if (d_flags & DRAW_RIGHT) { VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, bsz1) }
#else
            if (d_flags & DRAW_UP)    { HorizontalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_DOWN)  { HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_LEFT)  { VerticalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_RIGHT) { VerticalLine(bpl1, xbsz+bsz-bp_x, ybsz-bp_y, bsz1, onoff); }
#endif
            break;
          case BLOCK_RU:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            Move(wRp, xbsz-bp_x, ybsz-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz+bsz-bp_y);
            d_flags = map_points[y][x].draw_flags;
            WaitBlit();
#ifdef PURE_OS
            if (d_flags & DRAW_UP)    { HLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1) }
            if (d_flags & DRAW_RIGHT) { VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, bsz1) }
#else
            if (d_flags & DRAW_UP)    { HorizontalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_RIGHT) { VerticalLine(bpl1, xbsz+bsz-bp_x, ybsz-bp_y, bsz1, onoff); }
#endif
            break;
          case BLOCK_LU:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            Move(wRp, xbsz-bp_x, ybsz+bsz-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz-bp_y);
            d_flags = map_points[y][x].draw_flags;
            WaitBlit();
#ifdef PURE_OS
            if (d_flags & DRAW_UP)   { HLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1) }
            if (d_flags & DRAW_LEFT) { VLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1) }
#else
            if (d_flags & DRAW_UP)   { HorizontalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_LEFT) { VerticalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff); }
#endif
            break;
          case BLOCK_RD:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            Move(wRp, xbsz-bp_x, ybsz+bsz-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz-bp_y);
            d_flags = map_points[y][x].draw_flags;
            WaitBlit();
#ifdef PURE_OS
            if (d_flags & DRAW_DOWN)  { HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1) }
            if (d_flags & DRAW_RIGHT) { VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, bsz1) }
#else
            if (d_flags & DRAW_DOWN)  { HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_RIGHT) { VerticalLine(bpl1, xbsz+bsz-bp_x, ybsz-bp_y, bsz1, onoff); }
#endif
            break;
          case BLOCK_LD:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            Move(wRp, xbsz-bp_x, ybsz-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz+bsz-bp_y);
            d_flags = map_points[y][x].draw_flags;
            WaitBlit();
#ifdef PURE_OS
            if (d_flags & DRAW_DOWN) { HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1) }
            if (d_flags & DRAW_LEFT) { VLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1) }
#else
            if (d_flags & DRAW_DOWN) { HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff); }
            if (d_flags & DRAW_LEFT) { VerticalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff); }
#endif
            break;
          case BLOCK_FUEL:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
#ifdef PURE_OS
            HLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1)
            HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1)
            VLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1)
            VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, bsz1)
#else
            HorizontalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff);
            HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff);
            VerticalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff);
            VerticalLine(bpl1, xbsz+bsz-bp_x, ybsz-bp_y, bsz1, onoff);
#endif
            if (onoff == 1) {
              fuelamount = ( (((((AFuelPod *)map_points[y][x].objectptr)->fuel
                           << SHFTPR) / MAX_PODFUEL) * (MAP_BLOCKSIZE-3))
                           >> SHFTPR );
            } else {
              fuelamount = ((AFuelPod *)
                             map_points[y][x].objectptr)->p_fuel[buf];
            }
#ifdef PURE_OS
            SetWriteMask(wRp,1l); 
	    if (onoff == 1) SetAPen(wRp,3); 
            HLINE(wRp, xbsz-bp_x+1, ybsz+bsz-bp_y-1-fuelamount, bsz-2)
	    HLINE(wRp, xbsz-bp_x+1, ybsz+bsz-bp_y-2-fuelamount, bsz-2)
            SetWriteMask(wRp,2l); 
	    if (onoff == 1) SetAPen(wRp,map_pen); 
#else
            HorizontalLine(bpl0, xbsz-bp_x+1, 
                           ybsz+bsz-bp_y-1-fuelamount, bsz-2, onoff);
            HorizontalLine(bpl0, xbsz-bp_x+1, 
                           ybsz+bsz-bp_y-2-fuelamount, bsz-2, onoff);
#endif
            ((AFuelPod *)map_points[y][x].objectptr)->p_fuel[buf] = fuelamount;
            break;
          case BLOCK_CU:
            /* Check if we should draw the cannon */
            if ( ((ACannon *)map_points[y][x].objectptr)->cstate == DEAD
                 && onoff == 1 )
              break;
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            SetWriteMask(wRp, 3l);
            SetAPen(wRp,cannon_pen); 
            Move(wRp, xbsz-bp_x, ybsz+bsz-bp_y-1);
            Draw(wRp, xbsz+bsz2-bp_x , ybsz+bsz-CAN_HEIGHT-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz+bsz-bp_y-1);
            WaitBlit();
#ifdef PURE_OS
            HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1)
            HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1)
#else
            HorizontalLine(bpl0, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff);
            HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff);
#endif
            SetWriteMask(wRp, 2l);
            SetAPen(wRp,map_pen); 
            break;
          case BLOCK_CD:
            /* Check if we should draw the cannon */
            if ( ((ACannon *)map_points[y][x].objectptr)->cstate == DEAD
                 && onoff == 1 )
              break;
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            SetWriteMask(wRp, 3l);
            SetAPen(wRp,cannon_pen); 
            Move(wRp, xbsz-bp_x, ybsz-bp_y);
            Draw(wRp, xbsz+bsz2-bp_x , ybsz+CAN_HEIGHT-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz-bp_y);
            WaitBlit();
#ifdef PURE_OS
            HLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1)
            HLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1)
#else
            HorizontalLine(bpl0, xbsz-bp_x, ybsz-bp_y, bsz1, onoff);
            HorizontalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff);
#endif
            SetWriteMask(wRp, 2l);
            SetAPen(wRp,map_pen); 
            break;
          case BLOCK_CR:
            /* Check if we should draw the cannon */
            if ( ((ACannon *)map_points[y][x].objectptr)->cstate == DEAD
                 && onoff == 1 )
              break;
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            SetWriteMask(wRp, 3l);
            SetAPen(wRp,cannon_pen); 
            Move(wRp, xbsz-bp_x, ybsz-bp_y);
            Draw(wRp, xbsz+CAN_HEIGHT-bp_x , ybsz+bsz2-bp_y);
            Draw(wRp, xbsz-bp_x, ybsz+bsz-bp_y);
            WaitBlit();
#ifdef PURE_OS
            VLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1)
            VLINE(wRp, xbsz-bp_x, ybsz-bp_y, bsz1)
#else
            VerticalLine(bpl0, xbsz-bp_x, ybsz-bp_y, bsz1, onoff);
            VerticalLine(bpl1, xbsz-bp_x, ybsz-bp_y, bsz1, onoff);
#endif
            SetWriteMask(wRp, 2l);
            SetAPen(wRp,map_pen); 
            break;
          case BLOCK_CL:
            /* Check if we should draw the cannon */
            if ( ((ACannon *)map_points[y][x].objectptr)->cstate == DEAD
                 && onoff == 1 )
              break;
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
            SetWriteMask(wRp, 3l);
            SetAPen(wRp,cannon_pen); 
            Move(wRp, xbsz+bsz-bp_x, ybsz-bp_y);
            Draw(wRp, xbsz+bsz-CAN_HEIGHT-bp_x , ybsz+bsz2-bp_y);
            Draw(wRp, xbsz+bsz-bp_x, ybsz+bsz-bp_y);
            WaitBlit();
#ifdef PURE_OS
            VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, bsz1)
            VLINE(wRp, xbsz+bsz-bp_x, ybsz-bp_y, bsz1)
#else
            VerticalLine(bpl0, xbsz+bsz-bp_x, ybsz-bp_y, bsz1, onoff);
            VerticalLine(bpl1, xbsz+bsz-bp_x, ybsz-bp_y, bsz1, onoff);
#endif
            SetWriteMask(wRp, 2l);
            SetAPen(wRp,map_pen); 
            break;
          case BLOCK_BASE:
            xbsz = map_points[y][x].edge_x;
            ybsz = map_points[y][x].edge_y;
#ifdef PURE_OS
            SetWriteMask(wRp, 3l); 
	    if (onoff == 1) SetAPen(wRp, 3);
            HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1)
            HLINE(wRp, xbsz-bp_x, ybsz+bsz-bp_y, bsz1)
            if (onoff == 1) SetAPen(wRp, 2);
	    SetWriteMask(wRp, 2l);
#else
            HorizontalLine(bpl0, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff);
            HorizontalLine(bpl1, xbsz-bp_x, ybsz+bsz-bp_y, bsz1, onoff);
#endif
            break;
          default:
            break;
        }
      }
    }
  }
  p_mapx[buf] = local_ship->pos.x;
  p_mapy[buf] = local_ship->pos.y;
}
