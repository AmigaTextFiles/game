/*
   graphics.c -- graphic functions module for Invasion Force

   This module provides graphics functions for the rest of the program,
   especially map drawing and related functions for the map editor and
   the game play modules.

   This source code is free.  You may make as many copies as you like.
*/

// standard header for all program modules
#include "global.h"

#include <proto/layers.h>
#include <graphics/gfxmacros.h>

USHORT __chip busy_pointer_data[] = {
    0x0000, 0x0000,
    0x0400, 0x07C0,
    0x0000, 0x07C0,
    0x0100, 0x0380,
    0x0000, 0x07E0,
    0x07C0, 0x1FF8,
    0x1FF0, 0x3FEC,
    0x3FF8, 0x7FDE,
    0x3FF8, 0x7FBE,
    0x7FFC, 0xFF7F,
    0x7EFC, 0xFFFF,
    0x7FFC, 0xFFFF,
    0x3FF8, 0x7FFE,
    0x3FF8, 0x7FFE,
    0x1FF0, 0x3FFC,
    0x07C0, 0x1FF8,
    0x0000, 0x07E0,
    0x0000, 0x0000
}; // the data for a standard "busy" mouse pointer

/*
   I store the map_window RastPort in here most of the time for handy
   access by my functions, so I don't have to tell them what rastport to
   use every time I call one of them.  And by changing this value I can
   easily redirect all my graphics to another window for a while.
*/
struct RastPort *rast_port = NULL;

// the bitmap where my map graphics are stored
struct BitMap grafx_bitmap = { 0,0,0,0,0, 0,0,0,0, 0,0,0,0};

// single-hex tranfer bitmap and associated storage space
struct BitMap hex_transfer;
UBYTE __chip transfer_bitmap[512];


// this stucture stores coordinates for plotting hexes
struct hex_struct {
   short srcx, srcy;
} hexes[] = {
   {0,65},     // unknown
   {30,65},    // plains
   {60,65},    // desert
   {270,65},   // forbid
   {180,65},   // brush
   {210,65},   // forest
   {240,65},   // jungle
   {0,97},     // rugged
   {30,97},    // hills
   {60,97},    // mountains
   {90,97},    // peaks
   {120,97},   // swamp
   {150,97},   // shallows
   {180,97},   // ocean
   {210,97},   // depth
   {240,97}    // pack ice
};

// this structure stores all the info I need to plot icons
struct icon_struct {
   short srcx, srcy;    // X,Y location on the map_grafx bitmap
   ULONG *mask;         // my bit-mask for filling the player's color
} icons[30];


// the bitplane mask I use to blit hexagons onto the map
ULONG __chip hex_mask[] = {
   0x00000000,0x00010000,0x0007C000,0x001FF000,0x007FFC00,0x01FFFF00,
   0x07FFFFC0,0x1FFFFFF0,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,
   0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,
   0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,0x7FFFFFFC,
   0x7FFFFFFC,0x1FFFFFF0,0x07FFFFC0,0x01FFFF00,0x007FFC00,0x001FF000,
   0x0007C000,0x00010000
};

// the bitplane mask I use to put my "unit banned" icon on the screen
ULONG __chip banned_mask[] = {
   0x07F00000, 0x1C1C0000, 0x30060000, 0x600F0000, 0xC0398000,
   0xC0618000, 0xC1C18000, 0xC3018000, 0xCE018000, 0x78030000,
   0x30060000, 0x1C1C0000, 0x07F00000
};

// here are my masks for blitting color fills onto icons
   ULONG __chip battleship_mask[] = {
      0xFFFFE000,0xFFBFE000,0xFF1FE000,0xFB0FE000,0xF807E000,
      0xD803A000,0xC8012000,0xC8002000,0xC0002000,0xC0002000,
      0xC0002000,0xC0002000,0xC0002000,0XE0002000,0XFFFFE000
   };
   ULONG __chip carrier_mask[] = {
      0xFFFFE000,0xFFFFE000,0xFF3FE000,0xFE1FE000,0xFE1FE000,
      0xFE0FE000,0xC0002000,0xC0002000,0xC0002000,0xC0002000,
      0xC0002000,0xE0002000,0xE0002000,0xF0006000,0xFFFFE000
   };
   ULONG __chip cruiser_mask[] = {
      0xFFFFE000,0xFFFFE000,0xFFBFE000,0xFF1FE000,0xF70EE000,
      0xE2046000,0xE2046000,0xF000E000,0xC000E000,0xC0006000,
      0xC0006000,0xE0006000,0xE0006000,0xF000E000,0xFFFFE000
   };
   ULONG __chip destroyer_mask[] = {
      0xFFFFE000,0xFFFFE000,0xFFFFE000,0xFFFFE000,0xFF9FE000,
      0xFF0FE000,0xFF03E000,0xFE01E000,0xE000E000,0xC0006000,
      0xE0006000,0xF0006000,0xF8006000,0xFC00E000,0xFFFFE000
   };
   ULONG __chip sub_mask[] = {
      0xFFFFE000,0xFFFFE000,0xFFFFE000,0xFFFFE000,0xFF3FE000,
      0xFE1FE000,0xFE1FE000,0xFE0FE000,0xE0006000,0xC0002000,
      0xC0002000,0xE0006000,0xFFFFE000,0xFFFFE000,0xFFFFE000
   };
   ULONG __chip transport_mask[] = {
      0xFFFFE000,0xFF81E000,0xFF03E000,0xFE03E000,0xFC07E000,
      0xF801E000,0xC0006000,0x80006000,0x80006000,0x80006000,
      0xC0006000,0xE0006000,0xF0006000,0xF800E000,0xFFFFE000
   };
   ULONG __chip fighter_mask[] = {
      0xFFFFE000,0xFFFFE000,0xFFE7E000,0xFFC3E000,0xFF876000,
      0xFF062000,0xF8002000,0xE0002000,0xC0002000,0xE0002000,
      0xFF062000,0xFF876000,0xFFC3E000,0xFFE7E000,0xFFFFE000
   };
   ULONG __chip armor_mask[] = {
      0xFFFFE000,0xFFFFE000,0xFF83E000,0xE001E000,0xC000E000,
      0xE000E000,0xFC00E000,0xC0006000,0x80002000,0x80002000,
      0x80002000,0xC0006000,0xC0006000,0xE000E000,0xFFFFE000
   };
   ULONG __chip bomber_mask[] = {
      0xFFFFE000,0xFE1FE000,0xFC0FE000,0xFC1E6000,0xFC0C2000,
      0xC0002000,0x80002000,0x00002000,0x00002000,0x80002000,
      0xFC1C2000,0xFC0E6000,0xFC1FE000,0xFE0FE000,0xFFFFE000
   };
   ULONG __chip aircav_mask[] = {
      0xFFFFE000,0xFFFFE000,0xC002E000,0x80006000,0xC0002000,
      0xE0002000,0xC0002000,0x80006000,0x0002E000,0x0007E000,
      0x800FE000,0xC01FE000,0xC00FE000,0xE01FE000,0xFFFFE000
   };
   ULONG __chip rifle_mask[] = {
      0xFFFFE000,0xF8FFE000,0xF07FE000,0xF03FE000,0xF001E000,
      0xE000E000,0xE001E000,0xE00FE000,0xF07FE000,0xF07FE000,
      0xF03FE000,0xF03FE000,0xF03FE000,0xF01FE000,0xFFFFE000
   };
   ULONG __chip city_mask[] = {
      0x31830000,0x31830000,0xFFFF0000,0xFFFF0000,0x318F0000,
      0x318F0000,0x319B8000,0x319B8000,0xFFB30000,0xFFB30000,
      0x31E30000,0x31E30000,0xFFFF8000,0xFFFF8000,0x31E30000
   };
   ULONG __chip airbase_mask[] = {
      0xFE7FE000,
      0xC0302000,
      0x80602000,
      0x80C06000,
      0x0080E000,
      0x8001E000,
      0xC403E000,
      0xEC06E000,
      0xF8046000,
      0xF0002000,
      0xE0200000,
      0xC0602000,
      0x80C02000,
      0x81806000,
      0xFFCFE000
   };


// These are masks for blitting land and sea mines onto the screen.
   ULONG __chip landmine_mask[] = {
      0x0F000000, 0x3FC00000, 0x3FC00000, 0xFFF00000,
      0xFFF00000, 0xFFF00000, 0x1F800000, 0x00000000
   };
   ULONG __chip seamine_mask[] = {
      0x77000000, 0xFF800000, 0xFF800000, 0xFF800000, 0x7F000000,
      0xFF800000, 0xFF800000, 0xFF800000, 0x77000000, 0x00000000
   };
//

// region for my map-clipping rectangle
struct Region *map_region = NULL;
struct Region *bar_region = NULL;

void init_icons()
{  // link all the icons to their proper bit-masks
   icons[BATTLESHIP].srcx = 1;
   icons[BATTLESHIP].srcy = 49;
   icons[BATTLESHIP].mask = battleship_mask;

   icons[CARRIER].srcx = 23;
   icons[CARRIER].srcy = 49;
   icons[CARRIER].mask = carrier_mask;

   icons[CRUISER].srcx = 45;
   icons[CRUISER].srcy = 49;
   icons[CRUISER].mask = cruiser_mask;

   icons[DESTROYER].srcx = 67;
   icons[DESTROYER].srcy = 49;
   icons[DESTROYER].mask = destroyer_mask;

   icons[SUB].srcx = 89;
   icons[SUB].srcy = 49;
   icons[SUB].mask = sub_mask;

   icons[TRANSPORT].srcx = 111;
   icons[TRANSPORT].srcy = 49;
   icons[TRANSPORT].mask = transport_mask;

   icons[FIGHTER].srcx = 133;
   icons[FIGHTER].srcy = 49;
   icons[FIGHTER].mask = fighter_mask;

   icons[ARMOR].srcx = 155;
   icons[ARMOR].srcy = 49;
   icons[ARMOR].mask = armor_mask;

   icons[BOMBER].srcx = 199;
   icons[BOMBER].srcy = 49;
   icons[BOMBER].mask = bomber_mask;

   icons[AIRCAV].srcx = 221;
   icons[AIRCAV].srcy = 49;
   icons[AIRCAV].mask = aircav_mask;

   icons[RIFLE].srcx = 265;
   icons[RIFLE].srcy = 49;
   icons[RIFLE].mask = rifle_mask;

   icons[CITY].srcx = 287;
   icons[CITY].srcy = 49;
   icons[CITY].mask = city_mask;

   icons[AIRBASE].srcx = 177;
   icons[AIRBASE].srcy = 49;
   icons[AIRBASE].mask = airbase_mask;
}

/*
   NOTE: All the graphics functions that use raw, pixelwise coordinates
   have names beginning with "px_".  This distinguishes them from the
   higher level functions that go by row and column.
*/

// draw a hex cell outline, pixelwise, current color
void px_outline_hex(x,y)
int x,y;
{
   Move(rast_port,x+15,y);
   Draw(rast_port,x,y+8);
   Draw(rast_port,x,y+24);
   Draw(rast_port,x+15,y+32);
   Draw(rast_port,x+30,y+24);
   Draw(rast_port,x+30,y+8);
   Draw(rast_port,x+15,y);
}


// macro fills in a hex, current color, no outline
#define px_wipe_hex(a,b) BltPattern(rast_port,(PLANEPTR)hex_mask,a,b,a+30,b+31,4);


void px_plot_hex(destx,desty,code)
int destx,desty,code;
{  // plot a map terrain hex at the specified X,Y pixel coords
   BltBitMap(&grafx_bitmap,hexes[code].srcx,hexes[code].srcy,&hex_transfer,0,0,32,32,0x0C0,0xFF,NULL);
   BltMaskBitMapRastPort(&hex_transfer,0,0,rast_port,destx,desty,32,32,0xE0,(PLANEPTR)hex_mask);
}


/*
   wrap_coords() takes a pair of coordinates that may be somewhere off the map
   and wraps them around onto it.  The end result is a pair of coordinates that
   are definitely somewhere on the map.  This only works currently with the
   wrap-around map option (because otherwise we should never be dealing with
   coords off the map).  It is always safe to call.
*/

void wrap_coords(col,row)
int *col, *row;
{  // correct the coordinates for a wrap-around map
   if (wrap) {
      while (*col<0)
         *col += width;
      while (*col>=width)
         *col -= width;
      while (*row<0)
         *row += height;
      while (*row>=height)
         *row -= height;
   FI
}


/*
   The log_to_abs() function is critical for the graphics subsystems.
   It takes a LOGICAL col,row coordinate pair specifying a map sector,
   and translates that to an ABSOLUTE pixel location on the screen,
   taking into account the current offset values, wrap-around, etc.
   This function is not responsible for clipping -- the new *absx and
   *absy values may or may not actually be somewhere on the screen.

   This function assumes we are dealing with hexagons.  Unit icons will
   require an additional offset to center them in the hex.

   For the reverse of this function, see abs_to_log().
   See also log_to_phys(), which converts logical coords to a physical sector
   location on the screen display.
*/

void log_to_abs(col,row,absx,absy)
int col, row, *absx, *absy;
{
   int phx, phy;     // physical sector coordinates

   *absx = -100;
   *absy = -100;

   phx = col-xoffs;
   phy = row-yoffs;
   if (wrap) {
      if (phx<-1)
         phx += width;
      if (phx>disp_wd)
         phx -= width;
      if (phy<-1)
         phy += height;
      if (phy>disp_ht)
         phy -= height;
   FI
   if (phx<-1 || phx>disp_wd || phy<-1 || phy>disp_ht)
      return;
   /*
      I use a "neatness" border of 4 or 6 pixels at the top & left edges
      That includes the visible beveled border plus a little extra space
      also +10 x to make room for the movement bar meter
   */
   *absx = map_window->BorderLeft+6+phx*30+abs(15*(row%2))+10;
   *absy = map_window->BorderTop+4+phy*24;
}


/*
   given an x/y pixel location, find the hex cell that is under it
   this returns the position on the MAP, not the display
   i.e. the values are corrected for offset
   for the opposite conversion, see log_to_abs()
   see also log_to_phys()
   NOTE: This function can accept coordinates way off the actual display.
*/
void abs_to_log(px,py,col,row)
int px, py, *col, *row;
{
   *row = yoffs+(py-1)/24-1;
   *col = xoffs+((px+19)-((*row%2)*15)-10)/30-1; // -10 x for movement bar

   if (wrap) {
      if (*col<0)
         *col += width;
      if (*col>width)
         *col -= width;
      if (*row<0)
         *row += height;
      if (*row>height)
         *row -= height;
   }
}


/*
   log_to_phys() converts a set of logical (map) coordinates to a physical
   sector location relative the map display.  THE RESULTING SECTOR COORDINATES
   MAY OR MAY NOT ACTUALLY BE ON THE SCREEN!!!  This is a low level routine
   meant to be used by visibleP(), log_to_abs(), and related functions.
*/
void log_to_phys(col,row,phx,phy)
int col, row, *phx, *phy;
{
   wrap_coords(&col,&row);
   *phx = col-xoffs;
   *phy = row-yoffs;
   if (wrap) {
      if (*phx<0)
         *phx += width;
      if (*phx>disp_wd)
         *phx -= width;
      if (*phy<0)
         *phy += height;
      if (*phy>disp_ht)
         *phy -= height;
   FI
}


void outline_hex(col,row,color)
int col,row,color;
{  // outline (highlight) a hex with the specified color
   int px, py;

   log_to_abs(col,row,&px,&py);
   SetAPen(rast_port,color);
   px_outline_hex(px,py);
}


void wipe_hex(col,row,color)
int col,row,color;
{  // solid-fill a hex with the specified color
   int px, py;

   log_to_abs(col,row,&px,&py);
   SetAPen(rast_port,color);
   px_outline_hex(px,py);
   px_wipe_hex(px,py);
}


void plot_hex(col,row,code)
int col,row,code;
{  // plot a terrain hex at a specified column and row
   int px, py;

   log_to_abs(col,row,&px,&py);

   // outline the hex in black
   SetAPen(rast_port,BLACK);
   px_outline_hex(px,py);

   // copy graphics to "hex_transfer" bitmap area
   BltBitMap(&grafx_bitmap,hexes[code].srcx,hexes[code].srcy,&hex_transfer,0,0,32,32,0x0C0,0xFF,NULL);

   // blit onto the screen using the hexagon mask
   BltMaskBitMapRastPort(&hex_transfer,0,0,rast_port,px,py,32,32,0xE0,(PLANEPTR)hex_mask);
}


void drawto(x1,y1,x2,y2,color)
int x1,y1,x2,y2,color;
{
   SetAPen(rast_port,color);
   Move(rast_port,x1,y1);
   Draw(rast_port,x2,y2);
}


void draw_road(col1,row1,col2,row2)
int col1, row1, col2, row2;
{
   int x1, y1, x2, y2;
   int cx, cy;

   if (!(visibleP(col1,row1)&&visibleP(col2,row2)))
      return;

   log_to_abs(col1,row1,&x1,&y1);
   log_to_abs(col2,row2,&x2,&y2);

   x1+=15; y1+=16; x2+=15; y2+=16;

   if (row1==row2)
      for (cy=-2; cy<=3; cy++)
         drawto(x1,y1+cy,x2,y2+cy,BLACK);
   else
      for (cx=-2; cx<=2; cx++)
         for (cy=-1; cy<=1; cy++)
            drawto(x1+cx,y1+cy,x2+cx,y2+cy,BLACK);

   SetDrPt(rast_port,0x1F1F);
   SetBPen(rast_port,BLACK);
   drawto(x1,y1,x2,y2,WHITE);
   SetBPen(rast_port,LT_GRAY);
   SetDrPt(rast_port,(unsigned short)~0);
}

#if FALSE
// draws all roads going out from a given hex
// used mainly for map editor display

void hex_draw_roads(col,row)
int col, row;
{
   int hexes, ctr, flag;

   // outline_hex(col,row,WHITE);
   hexes = adjacent(col,row);
   for (ctr=0; ctr<hexes; ctr++) {
      flag = get_flags(t_grid,hexlist[ctr].col,hexlist[ctr].row);
      if (flag & ROAD)
         draw_road(col,row,hexlist[ctr].col,hexlist[ctr].row);
   OD
}


// Following is same as hex_draw_roads(), except specific to the
// current player.  (i.e. only draws roads he knows about)

void plex_draw_roads(col,row)
int col, row;
{
   int hexes, ctr, flag;

   // outline_hex(col,row,WHITE);
   hexes = adjacent(col,row);
   for (ctr=0; ctr<hexes; ctr++) {
      flag = get_flags(PLAYER.map,hexlist[ctr].col,hexlist[ctr].row);
      if (flag & ROAD)
         draw_road(col,row,hexlist[ctr].col,hexlist[ctr].row);
   OD
}
#endif

// draw a 3-D look beveled box, as around an icon

void bevel_box(x,y,w,h,depress)
int x,y,w,h;
BOOL depress;
{
   w--;  h--;
   if (depress)
      SetAPen(rast_port,WHITE);
   else
      SetAPen(rast_port,BLACK);
   Move(rast_port,x+w,y);
   Draw(rast_port,x+w,y+h);
   Draw(rast_port,x,y+h);
   if (depress)
      SetAPen(rast_port,BLACK);
   else
      SetAPen(rast_port,WHITE);
   Move(rast_port,x+w,y);
   Draw(rast_port,x,y);
   Draw(rast_port,x,y+h);
}


// draw a 3-D look frame, to indicate if a gadget is editable

void bevel_frame(x,y,w,h,depress)
int x,y,w,h;
BOOL depress;
{
   bevel_box(x,y,w,h,depress);
   bevel_box(x+1,y+1,w-2,h-2,!depress);
}


void box(x,y,w,h,color)
int x,y,w,h,color;
{  // draw a box
   w--;  h--;

   SetAPen(rast_port,color);
   Move(rast_port,x,y);
   Draw(rast_port,x,y+h);
   Draw(rast_port,x+w,y+h);
   Draw(rast_port,x+w,y);
   Draw(rast_port,x,y);
}


void frame(x,y,w,h,depress)
int x,y,w,h;
BOOL depress;
{
   w--;  h--;
   if (depress) {
      box(x,y,w,h,BLACK);
      box(x+1,y+1,w,h,WHITE);
   } else {
      box(x,y,w,h,WHITE);
      box(x+1,y+1,w,h,BLACK);
   FI
}


void plot_text(x,y,string,frontpen,backpen,drawmode,font)
int x,y;
char *string;
int frontpen,backpen,drawmode;
struct TextAttr *font;
{
   struct IntuiText itext;

   itext.FrontPen = (UBYTE)frontpen;
   itext.BackPen = (UBYTE)backpen;
   itext.DrawMode = (UBYTE)drawmode;
   itext.LeftEdge = 0;
   itext.TopEdge = 0;
   itext.ITextFont = font;
   itext.IText = string;
   itext.NextText = NULL;

   PrintIText(rast_port,&itext,x,y);
}


void outline_text(x,y,string,color,font)
int x,y;
char *string;
int color;
struct TextAttr *font;
{
   int ctr1, ctr2;

   for (ctr1=-1; ctr1<2; ctr1++)
      for (ctr2=-1; ctr2<2; ctr2++)
         plot_text(x+ctr1,y+ctr2,string,BLACK,LT_GRAY,JAM1,font);
   plot_text(x,y,string,color,LT_GRAY,JAM1,font);
}


// functions to plot mines onto the screen

void px_plot_landmine(destx,desty)
int destx,desty;
{
   // blit the image of the mine into hex_transfer
   BltBitMap(&grafx_bitmap,295,156,&hex_transfer,0,0,16,8,0x0C0,0xFF,NULL);
   // blit with mask from hex_transfer onto screen
   BltMaskBitMapRastPort(&hex_transfer,0,0,rast_port,destx,desty,32,8,0xE0,(PLANEPTR)landmine_mask);
}

void px_plot_seamine(destx,desty)
int destx,desty;
{
   // blit the image of the mine into hex_transfer
   BltBitMap(&grafx_bitmap,296,132,&hex_transfer,0,0,16,10,0x0C0,0xFF,NULL);
   // blit with mask from hex_transfer onto screen
   BltMaskBitMapRastPort(&hex_transfer,0,0,rast_port,destx,desty,32,10,0xE0,(PLANEPTR)seamine_mask);
}


void px_plot_icon(type,x,y,color,token,multiple)
int type,x,y,color,token;
BOOL multiple;
{  // plot a unit icon on the map
   struct icon_struct *icon = &icons[type];

   if (!icon->mask)
      return;

   // step one, blit the icon
   BltBitMapRastPort(&grafx_bitmap,icon->srcx,icon->srcy,rast_port,x,y,19,15,0x0C0);

   // step two, blit-fill the appropriate color
   SetAPen(rast_port,color);
   BltPattern(rast_port,(PLANEPTR)icon->mask,x,y,x+18,y+14,4);

   // step three, fix border as needed
   bevel_box(x-1,y-1,21,17,FALSE);
   if (multiple)
      bevel_box(x-2,y-2,23,19,FALSE);

   // blit in the appropriate order token
   if (token!=ORDER_NONE) {
      int srcy=0;
      switch (token) {
         case ORDER_SENTRY:
            srcy=66;     // S
            break;
         case ORDER_FORTIFY:
            srcy = 114;  // orange F
            break;
         case ORDER_FORTIFIED:
            srcy = 74;   // white F
            break;
         case ORDER_GOTO:
            srcy = 82;   // G
            break;
         case ORDER_LOAD:
            srcy = 106;  // L
            break;
         case ORDER_AIRBASE:
            srcy = 122;  // orange A
      }
      if (srcy)
         BltBitMapRastPort(&grafx_bitmap,301,srcy,rast_port,x+13,y+9,7,7,0x0C0);
   }
}


void plot_icon(type,col,row,color,token,multiple)
int type, col, row, color, token;
BOOL multiple;
{  // plot a unit icon on the map
   int px, py;
   struct icon_struct *icon = &icons[type];

   if (!VALID_HEX(col,row))
      return;

   // icon graphic not available
   if (!icon->mask)
      return;

   log_to_abs(col,row,&px,&py);
   px += 6;   py += 9;  // centering it in the hexagon

   px_plot_icon(type,px,py,color,token,multiple);
}



void px_plot_city(x,y)
int x,y;
{
   struct icon_struct *icon = &icons[CITY];
   BltBitMapRastPort(&grafx_bitmap,icon->srcx,icon->srcy,rast_port,x,y,17,15,0x0C0);
}

void px_plot_roads(x,y)
int x,y;
{
   struct icon_struct *icon = &icons[ROADS];
   BltBitMapRastPort(&grafx_bitmap,icon->srcx,icon->srcy,rast_port,x,y,17,15,0x0C0);
}

void px_plot_city_complete(px,py,color,defended)
int px,py,color;
BOOL defended;
{  // plot a city on the current rastport
   struct icon_struct *icon = &icons[CITY];
   // step one, blit the icon
   BltBitMapRastPort(&grafx_bitmap,icon->srcx,icon->srcy,rast_port,px,py,17,15,0x0C0);
   if (color!=0) {
      SetAPen(rast_port,color);
      BltPattern(rast_port,(PLANEPTR)icon->mask,px,py,px+18,py+14,4);
      bevel_box(px-1,py-1,19,17,FALSE);
      if (defended)
         bevel_box(px-2,py-2,21,19,FALSE);
   FI
}


void plot_city(col,row,color,defended)
int col,row,color;
BOOL defended;
{  // plot a city on the map
   int px, py;

   if (!VALID_HEX(col,row))
      return;
   if (!visibleP(col,row))
      return;

   log_to_abs(col,row,&px,&py);
   px += 7;    py += 9;    // center it in the hexagon
   px_plot_city_complete(px,py,color,defended);
}


void save_hex_graphics(col,row,buf)
int col,row,buf;
{  // store a hex background to a safe place in the bitmap
   // find the location
   int px, py, locy;

   log_to_abs(col,row,&px,&py);
   px += 5;    py += 8;    // to get the hex interior

   locy = 190+(buf*31);    // find the buffer location in my master bitmap

   // blit the background to a safe place
   BltBitMap(rast_port->BitMap,px-1,py+13,&grafx_bitmap,locy,130,23,19,0x0C0,0xFF,NULL);
}


void restore_hex_graphics(col,row,buf)
int col,row,buf;
{
   // find the location
   int px, py, locy;

   log_to_abs(col,row,&px,&py);
   px += 5;    py += 8;

   locy = 190+(buf*31);    // this finds the correct buffer location in my bitmap

   // restore the previously saved background
   BltBitMapRastPort(&grafx_bitmap,locy,130,rast_port,px-1,py-1,23,19,0x0C0);
}


void plot_mapobject(col,row,srcx,srcy)
int col,row,srcx,srcy;
{
   // find the location
   int px, py;

   if (!VALID_HEX(col,row))
      return;

   log_to_abs(col,row,&px,&py);
   px += 5;    py += 8;

   // blit the cursor into place
   BltBitMapRastPort(&grafx_bitmap,srcx,srcy,rast_port,px,py,21,17,0x0C0);
}


void init_map_grafx()
{  // get all the internal graphics structures set up
   static struct Rectangle clip_rect = { 6, 15, 617, 370 };

   // here I set window-adaptive values for my clipping rectangle
   clip_rect.MinX = map_window->BorderLeft+2+10;  // 10 to make room for bar
   clip_rect.MinY = map_window->BorderTop+1;
   clip_rect.MaxX = map_window->Width-map_window->BorderRight-19;
   clip_rect.MaxY = map_window->Height-map_window->BorderBottom-14;

   /*
      This first bitmap is the big one that holds all my map graphic
      elements, such as hex terrain, icon markers, and anything else
      I might want to use.  It provides my link into the map_grafx.c data
      prepared and compiled elsewhere.
   */
   InitBitMap(&grafx_bitmap,4,320,200);
   grafx_bitmap.Planes[0] = (PLANEPTR)map_grafx;
   grafx_bitmap.Planes[1] = (PLANEPTR)map_grafx+8000;
   grafx_bitmap.Planes[2] = (PLANEPTR)map_grafx+16000;
   grafx_bitmap.Planes[3] = (PLANEPTR)map_grafx+24000;

   /*
      This small (32x32) bitmap is used as a temporary storage area for
      blitting my hex terrain onto the map.  For some reason the Amiga
      requires this roundabout way of doing things.  I don't know why.
   */
   InitBitMap(&hex_transfer,4,32,32);
   hex_transfer.Planes[0] = (PLANEPTR)transfer_bitmap;
   hex_transfer.Planes[1] = (PLANEPTR)transfer_bitmap+128;
   hex_transfer.Planes[2] = (PLANEPTR)transfer_bitmap+256;
   hex_transfer.Planes[3] = (PLANEPTR)transfer_bitmap+384;

   DrawBevelBox(map_window->RPort,map_window->BorderLeft,map_window->BorderTop,
      map_window->Width-map_window->BorderLeft-map_window->BorderRight-16,
      map_window->Height-map_window->BorderTop-map_window->BorderBottom-12,
      GT_VisualInfo,vi,TAG_END);

   // now attempt to set up a clipping region for my map
   map_region = NewRegion();
   OrRectRegion(map_region,&clip_rect);  // add the rectangle to the region
   InstallClipRegion(map_window->WLayer,map_region);

   // create also a clipping region for my movement meter bar
   clip_rect.MinX = map_window->BorderLeft+2;
   clip_rect.MinY = map_window->BorderTop+1;
   clip_rect.MaxX = clip_rect.MinX+9;  // bar width 10 pixels
   clip_rect.MaxY = map_window->Height-map_window->BorderBottom-14;
   bar_region = NewRegion();
   OrRectRegion(bar_region,&clip_rect);  // add the rectangle to the region

   init_icons();
}


// if there's no map being displayed, I will reset the scrollers to
// full size, so they can't be moved

void zero_scrollers()
{
   GT_SetGadgetAttrs(horz_scroller,map_window,NULL,
      GTSC_Top,      0,
      GTSC_Total,    disp_wd,
      GTSC_Visible,  disp_wd,
      TAG_END);
   GT_SetGadgetAttrs(vert_scroller,map_window,NULL,
      GTSC_Top,      0,
      GTSC_Total,    disp_ht,
      GTSC_Visible,  disp_ht,
      TAG_END);
}

// update the size and position of the scroller gadgets to match
// the current size and position of the game map

void update_scrollers()
{
   GT_SetGadgetAttrs(horz_scroller,map_window,NULL,
      GTSC_Top,      xoffs + (wrap ? WRAP_OVERLAP : 0),
      GTSC_Total,    width+2+2*(wrap ? WRAP_OVERLAP : 0),
      GTSC_Visible,  disp_wd,
      TAG_END);
   GT_SetGadgetAttrs(vert_scroller,map_window,NULL,
      GTSC_Top,      yoffs+(wrap ? WRAP_OVERLAP : 0),
      GTSC_Total,    height+2+2*(wrap ? WRAP_OVERLAP : 0),
      GTSC_Visible,  disp_ht,
      TAG_END);
}


/*
   Check the scrolly gadgets (presumably after one has been used)
   and update the xoffs and yoffs values to match.

   If the map position has been changed, scrolly() will return a
   TRUE value, otherwise FALSE.  If TRUE, the function must be followed
   by appropriate activity to update the screen display.
*/

BOOL scrolly(object,code)
struct Gadget *object;
UWORD code;
{
   int pos=code-(wrap?WRAP_OVERLAP:0);

   if (object==horz_scroller)
      if (xoffs==pos)
         return FALSE;
      else {
         xoffs = pos;
         return TRUE;
      FI
   else
      if (yoffs==pos)
         return FALSE;
      else {
         yoffs = pos;
         return TRUE;
      FI
}



/*
   fat_plot() plots a "fat" pixel onto a rastport, using the current
   pen color.  This is used for the world map display.  It allows plotting
   different sized pixels (i.e. fatness), in order to best fit various
   size maps to the available display area.
*/

void fat_plot(rastport,x,y,fatness)
struct RastPort *rastport;
int x, y, fatness;
{  // plot a "fatness" size pixel on the screen
   if (fatness==1) {
      WritePixel(rastport,x,y);
      return;
   FI
   RectFill(rastport,x,y,x+fatness-1,y+fatness-1);
}


/*
   visible_stripP() determines whether a certain LOGICAL sector currently
   falls within a certain PHYSICAL area on the screen display.  This is
   important for the optimized scrolling functions.
*/

BOOL visible_stripP(col,row,xmin,ymin,xmax,ymax)
{  // does this sector fall within the specified strip on display?
   int phx, phy;  // pysical sector coordinates

   wrap_coords(&col,&row);
   phx=col-xoffs;    phy=row=yoffs;

   // correct values for wrap, if it's active
   if (wrap) {
      if (phx<-1)
         phx += width;
      if (phx>(disp_wd+1))
         phx -= width;
      if (phy<-1)
         phy += height;
      if (phy>(disp_ht+1))
         phy -= height;
   }

   if (phx<xmin || phx>xmax || phy<ymin || phy>ymax)
      return FALSE;
   else
      return TRUE;
}


// within_areaP(), similar to visible_stripP(), except everything's logical

BOOL within_areaP(col,row,xmin,ymin,xmax,ymax)
{  // does this sector fall within the specified area on the map?
   // correct values for wrap, if it's active
   if (wrap) {
      if (col<xmin)
         col += width;
      if (col>xmax)
         col -= width;
      if (row<ymin)
         row += height;
      if (row>ymax)
         row -= height;
   FI
   if (col<xmin || col>xmax || row<ymin || row>ymax)
      return FALSE;
   else
      return TRUE;
}


// visibleP() determines if a specified LOGICAL sector is on the part of
// the map currently visible in the window

BOOL visibleP(col,row)
int col,row;
{  // is this part of the map currently visible?
   /*
      Because of overlap, there are four possible zones that could be visible
      on the display.  I must determine which of the zones are present and
      whether the specified sector falls into one of them.
                                             ____________
                                             |       |  |<- display
                        _____________________|_______|__|
                        |  |                 |       |  |
                        | B|                 |   A   |  |
                        |__|                 |_______|__|
                        |                            |
                        |       map                  |
                        |                            |
                        |__                   _______|
                        | D|                 |   C   |
                        |__|_________________|_______|


      The large "map" box represents the logical map area.  The smaller
      box at the upper right represents the actual display.  Thanks to
      the wrap-around overlap, an area in each corner of the map is
      visible on the display.  These are categorized as follows:

      A = The area normally enclosed by the display.  This zone is always
          present, and is the *only* zone present when wrap is off.

      B = The area revealed by the horizontal wrap of the display.  This
          zone is present when xoffs<0 or xoffs+disp_wd>width.

      C = The area revealed by the vertical wrap of the display.  This is
          present when yoffs<0 or yoffs+disp_ht>height.

      D = The area revealed by both horizontal and vertical wrap.  This
          zone is present when both B and C are present.

      Whenever the wrap flag is active, each of these zones must be checked
      to see if it contains the specified sector.

      ADDENDUM: Forget about the chart and all that stuff I wrote above!
                I figured out an easier way.  BTW, compare this to the
                calculation of damage areas in GP_smart_scroll()!
   */
   int phx, phy;     // physical sector coordinates

   if (!VALID_HEX(col,row))
      return FALSE;

   phx = col-xoffs;
   phy = row-yoffs;
   if (wrap) {
      if (phx<0)
         phx += width;
      if (phx>disp_wd)
         phx -= width;
      if (phy<0)
         phy += height;
      if (phy>disp_ht)
         phy -= height;
   FI
   return within_areaP(phx,phy,-1,-1,disp_wd,disp_ht);
}


BOOL easily_visibleP(col,row)
{
   int phx, phy;     // physical sector coordinates

   phx = col-xoffs;
   phy = row-yoffs;
   if (wrap) {
      if (phx<0)
         phx += width;
      if (phx>disp_wd)
         phx -= width;
      if (phy<0)
         phy += height;
      if (phy>disp_ht)
         phy -= height;
   FI
   return within_areaP(phx,phy,1,1,disp_wd-1,disp_ht-1);
}


// The need_to_scrollP() function takes a coordinate set and
// determines whether the map needs to be scrolled to
// keep the action easily visible on screen.  This could be used when moving
// a unit on the map, or when switching from one unit to the next.

BOOL need_to_scrollP(xdest,ydest)
int xdest, ydest;
{
   BOOL scroll = FALSE;

   // first, test for the need to scroll left
   if (xoffs>0 && xdest<=(xoffs+1))
         scroll = TRUE;

   // test for need to scroll right
   if (xoffs<(width-disp_wd) && xdest>=(xoffs+disp_wd-2))
         scroll = TRUE;

   // test for need to scroll up
   if (yoffs>0 && ydest<=(yoffs+1))
         scroll = TRUE;

   // test for need to scroll down
   if (yoffs<(height-disp_ht) && ydest>=(yoffs+disp_ht-2))
         scroll = TRUE;

   return scroll;
}


// function to clear the graphics bar to black

void clear_movebar()
{
   if (map_window==NULL || bar_region==NULL || map_region==NULL)
      return;
   InstallClipRegion(map_window->WLayer,bar_region);
   SetRast(rast_port,BLACK);
   InstallClipRegion(map_window->WLayer,map_region);
}


// do animated movement of a unit on the map

void anim_move(unit,org_col,org_row,dest_col,dest_row)
struct Unit *unit;
int org_col, org_row, dest_col, dest_row;
{
   int orgx, orgy, destx, desty, ctr;
   int iter=6;    // control number of movement frames

   log_to_abs(org_col,org_row,&orgx,&orgy);
   orgx+=5;    orgy+=8;    // to get the hex interior
   log_to_abs(dest_col,dest_row,&destx,&desty);
   destx+=5;   desty+=8;

   for (ctr=0; ctr<iter; ctr++) {
      int curx, cury;
      curx = orgx+(destx-orgx)*ctr/iter;
      cury = orgy+(desty-orgy)*ctr/iter;

      // then draw in the icon itself
      px_plot_icon(unit->type,curx,cury,roster[unit->owner].color,NULL,NULL);

      // time delay for frame visibility
      if (ctr % 2)
         Delay(1L);
   OD
}



// end of listing
