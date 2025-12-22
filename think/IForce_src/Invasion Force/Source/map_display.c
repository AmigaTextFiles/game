/*
   map_display.c -- Invasion Force map display module

   This module has functions for displaying game maps in the various
   program modes: map editor, movement and survey, and production.

   Lower level graphic functions go in graphics.c.

   This source code is free.  You may make as many copies as you like.

 ***********************************************************************
 ***            THE GAME OF INVASION FORCE FOR THE AMIGA             ***
 ***                         by Tony Belding                         ***
 ***********************************************************************

 The game was written with the SAS/C compiler.
 Compatibility with other compilers is anybody's guess.
*/

// standard header for all program modules
#include "global.h"

#define ME_MAP 1     // mode indicators for the map
#define GP_MAP 2
#define PM_MAP 3

// NOTE: functions beginning with ME_ are for the map editor, GP_ for
// gameplay (i.e. movement and survey modes), and PM_ for production mode.

// Following is same as plex_draw_roads(), except it also updates
// the icons of surrounding hexes: necessary to keep roads from
// over-writing cities or other objects

void GP_draw_roads(col,row)
int col, row;
{
   int hexes, ctr, flag;
   struct MapIcon *piece;

   // outline_hex(col,row,WHITE);
   hexes = adjacent(col,row);
   for (ctr=0; ctr<hexes; ctr++) {
      flag = get_flags(PLAYER.map,hexlist[ctr].col,hexlist[ctr].row);
      if (flag & ROAD) {
         draw_road(col,row,hexlist[ctr].col,hexlist[ctr].row);

         // search for icons to redraw
         for (piece=(struct MapIcon *)PLAYER.icons.mlh_Head; piece->inode.mln_Succ; piece=(struct MapIcon *)piece->inode.mln_Succ) {
            if (piece->col==hexlist[ctr].col && piece->row==hexlist[ctr].row) {
               if (piece->type==CITY)
                  plot_city(piece->col,piece->row,roster[piece->owner].color,FALSE);
               else
                  plot_icon(piece->type,piece->col,piece->row,roster[piece->owner].color,piece->token,piece->stacked!=NULL);
               break;
            }
         }
      }
   OD
}


void ME_draw_roads(col,row)
int col, row;
{
   int hexes, ctr, flag;
   struct City *metro;

   // outline_hex(col,row,WHITE);
   hexes = adjacent(col,row);
   for (ctr=0; ctr<hexes; ctr++) {
      flag = get_flags(t_grid,hexlist[ctr].col,hexlist[ctr].row);
      if (flag & ROAD) {
         draw_road(col,row,hexlist[ctr].col,hexlist[ctr].row);

         // search for cities to update
         for (metro=(struct City *)city_list.mlh_Head;
         metro->cnode.mln_Succ;
         metro=(struct City *)metro->cnode.mln_Succ) {
            if (metro->col==hexlist[ctr].col && metro->row==hexlist[ctr].row) {
               plot_city(metro->col,metro->row,roster[metro->owner].color,FALSE);
               break;
            FI
         OD
      FI
   OD
}


// Yet another draw_roads function, this time for the production mode map.
// It will correctly update the cities in the surrounding hexes.

void PM_draw_roads(col,row)
int col, row;
{
   int hexes, ctr, flag;

   // outline_hex(col,row,WHITE);
   hexes = adjacent(col,row);
   for (ctr=0; ctr<hexes; ctr++) {
      flag = get_flags(PLAYER.map,hexlist[ctr].col,hexlist[ctr].row);
      if (flag & ROAD) {
         struct City *metro=city_hereP(hexlist[ctr].col,hexlist[ctr].row);

         draw_road(col,row,hexlist[ctr].col,hexlist[ctr].row);
         if (metro) {
            if (metro->owner==player)
               plot_icon(metro->unit_type,metro->col,metro->row,PLAYER.color,NULL,FALSE);
            else
               if (get(PLAYER.map,metro->col,metro->row)!=HEX_UNEXPLORED) {
                  /*
                     This bit is going to be a little tricky.  I must search
                     the player's map icons to determine who he thinks owns the
                     city (because his info could be out of date).
                  */
                  struct MapIcon *piece = (struct MapIcon *)PLAYER.icons.mlh_Head;
                  int color=WHITE;

                  for (;piece->inode.mln_Succ;piece=(struct MapIcon *)piece->inode.mln_Succ)
                     if (piece->col==metro->col && piece->row==metro->row) {
                        color = roster[piece->owner].color;
                        break;
                     FI
                  if (metro->recon[player]==CITY)
                     plot_city(metro->col,metro->row,color,FALSE);
                  else
                     plot_icon(metro->recon[player],metro->col,metro->row,color,0,0);
               FI
         FI
      FI
   OD
}


// I want to update the display of one hex only

void GP_update_hex_display(col,row)
int col, row;
{
   struct MapIcon *piece=(struct MapIcon *)PLAYER.icons.mlh_Head;

   if (!VALID_HEX(col,row))
      return;
   if (visibleP(col,row))
      plot_hex(col,row,get(PLAYER.map,col,row));

   if (get_flags(PLAYER.map,col,row)&ROAD)
      GP_draw_roads(col,row);

   for (; piece->inode.mln_Succ; piece = (struct MapIcon *)piece->inode.mln_Succ) {
      if (piece->col != col || piece->row != row)
         continue;
      if (piece->type==CITY) {
         BOOL defended = FALSE;
         struct Unit *unit =  (struct Unit *)unit_list.mlh_Head;

         if (piece->owner==player)
            for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
               if (unit->col==piece->col && unit->row==piece->row) {
                  defended = TRUE;
                  break;
               FI

         // display city on map
         plot_city(piece->col,piece->row,roster[piece->owner].color,defended);
      } else
         plot_icon(piece->type,piece->col,piece->row,roster[piece->owner].color,piece->token,piece->stacked!=NULL);
   OD
}


void GP_update_at_hex(col,row)
int col, row;
{
   GP_update_hex_display(col,row);
   GP_update_hex_display(col-1,row);
   GP_update_hex_display(col+1,row);
   GP_update_hex_display(col,row-1);
   GP_update_hex_display(col,row+1);
   if (row%2) {  // i.e. if it's an odd-numbered column
      GP_update_hex_display(col+1,row-1);
      GP_update_hex_display(col+1,row+1);
   } else {
      GP_update_hex_display(col-1,row-1);
      GP_update_hex_display(col-1,row+1);
   FI
}


void PM_update_hex(col,row)
{
   int terra;
   struct City *metro=(struct City *)city_list.mlh_Head;

   terra = get(PLAYER.map,col,row);
   if (terra!=HEX_UNEXPLORED) {
      plot_hex(col,row,terra);
      if (get_flags(PLAYER.map,col,row)&ROAD)
         PM_draw_roads(col,row);
   }

   for (;metro->cnode.mln_Succ;metro=(struct City *)metro->cnode.mln_Succ)
      if (metro->col==col && metro->row==row) {
         if (metro->owner==player)
            plot_icon(metro->unit_type,metro->col,metro->row,PLAYER.color,NULL,FALSE);
         else
            if (get(PLAYER.map,metro->col,metro->row)!=HEX_UNEXPLORED) {
               struct MapIcon *piece = (struct MapIcon *)PLAYER.icons.mlh_Head;
               int color=WHITE;

               for (;piece->inode.mln_Succ;piece=(struct MapIcon *)piece->inode.mln_Succ)
                  if (piece->col==metro->col && piece->row==metro->row) {
                     color = roster[piece->owner].color;
                     break;
                  FI
               plot_city(metro->col,metro->row,color,FALSE);
            FI
         break;
      FI
}

void ME_draw_mapstrip(x0,y0,x1,y1)
int x0, y0, x1, y1;
{
   int xc, yc;

   // display the hex terrain
   for (yc=y0; yc<=y1; yc++)
      for (xc=x0; xc<=x1; xc++) {
         int xw=xc, yw=yc;

         wrap_coords(&xw,&yw);
         if (visibleP(xw,yw)) {  // basic bounds checking
            int terra;

            if (VALID_HEX(xw,yw)) {
               terra = get(t_grid,xw,yw);
               plot_hex(xw,yw,terra);
               if (get_flags(t_grid,xw,yw)&ROAD)
                  ME_draw_roads(xw,yw);
            FI
         FI
      OD


   // display the cities
   {
      struct City *metro;

      for (metro=(struct City *)city_list.mlh_Head;
      metro->cnode.mln_Succ;
      metro=(struct City *)metro->cnode.mln_Succ) {
         if (within_areaP(metro->col,metro->row,x0,y0,x1,y1)) {
            // display city on map
            plot_city(metro->col,metro->row,roster[metro->owner].color,FALSE);
         FI
      OD
   }
}


void ME_draw_map()
{
   // clear window
   SetRast(rast_port,LT_GRAY);

   // call to this function does all the grunt work,
   // treats display like one huge strip to update
   ME_draw_mapstrip(xoffs-1,yoffs-1,xoffs+disp_wd,yoffs+disp_ht);

   update_scrollers();
}


void ME_smart_scroll(oldxoffs,oldyoffs)
int oldxoffs,oldyoffs;
{
   smart_scroll(oldxoffs,oldyoffs,ME_MAP);
}


void GP_draw_mapstrip(x0,y0,x1,y1)
int x0,y0,x1,y1;
{  // build the player's map display
   int xc, yc;

   // display the hex terrain
   for (yc=y0; yc<=y1; yc++)
      for (xc=x0; xc<=x1; xc++) {
         int xw=xc, yw=yc;

         wrap_coords(&xw,&yw);
         if (visibleP(xw,yw)) {  // basic bounds checking
            int terra;

            if (VALID_HEX(xw,yw)) {
               terra = get(PLAYER.map,xw,yw);
               if (terra!=HEX_UNEXPLORED) {
                  plot_hex(xw,yw,terra);
                  if (get_flags(PLAYER.map,xw,yw)&ROAD)
                     GP_draw_roads(xw,yw);
               FI
            FI
         FI
      OD


   // display the icons
   {
      struct MapIcon *piece = (struct MapIcon *)PLAYER.icons.mlh_Head;
      for (; piece->inode.mln_Succ; piece = (struct MapIcon *)piece->inode.mln_Succ) {
         if (within_areaP(piece->col,piece->row,x0,y0,x1,y1)) {
            if (piece->type==CITY) {
               BOOL defended = FALSE;
               struct Unit *unit =  (struct Unit *)unit_list.mlh_Head;

               if (piece->owner==player)
                  for (; unit->unode.mln_Succ; unit = (struct Unit *)unit->unode.mln_Succ)
                     if (unit->col==piece->col && unit->row==piece->row) {
                        defended = TRUE;
                        break;
                     FI

               // display city on map
               plot_city(piece->col,piece->row,roster[piece->owner].color,defended);
            } else {
               // display unit icon
               plot_icon(piece->type,piece->col,piece->row,roster[piece->owner].color,piece->token,piece->stacked!=NULL);
            FI
         FI
      OD
   }
}


void GP_draw_map()
{  // build the player's map display
   // clear window
   SetRast(rast_port,LT_GRAY);

   // call to this function does all the grunt work,
   // treats display like one huge strip to update
   GP_draw_mapstrip(xoffs-1,yoffs-1,xoffs+disp_wd,yoffs+disp_ht);

   update_scrollers();
   display = TRUE;
}


void smart_scroll(oldxoffs,oldyoffs,mode)
int oldxoffs,oldyoffs,mode;
{ // optimized scroll the map for various game modes
   int dx = (xoffs-oldxoffs)*30;  // see how much movement is called for
   int dy = (yoffs-oldyoffs)*24;
   struct Rectangle *rect = &(map_region->bounds);
   int cwidth = rect->MaxX-rect->MinX;
   int cheight = rect->MaxY-rect->MinY;

   if (dx==0 && dy==0)
      return;

   if (dx>=cwidth || dy>=cheight) {  // too much, might as well redraw
      switch (mode) {
         case GP_MAP:
            GP_draw_map();
            break;
         case ME_MAP:
            ME_draw_map();
            break;
         case PM_MAP:
            PM_draw_map();
      }
      return;
   FI

   ScrollRaster(rast_port,dx,dy,rect->MinX,rect->MinY,rect->MaxX,rect->MaxY);

   // now the hard part: draw in all the newly visible areas
   // it's similar to view_map() except working on strips,
   // not the whole display at once

   // If you have difficulty understanding the following code, you might
   // be comforted to learn that I had difficulty writing it.
   {
      struct Rectangle full, dam;
      int xsiz, ysiz;            // x and y size of damage area in hexes
      int xorg, yorg;            // x and y origin of damage area in hexes

      // calculate the clipping area
      dam.MinX = full.MinX = map_window->BorderLeft+2+10;  // 10 to make room for bar
      dam.MinY = full.MinY = map_window->BorderTop+1;
      dam.MaxX = full.MaxX = map_window->Width-map_window->BorderRight-19;
      dam.MaxY = full.MaxY = map_window->Height-map_window->BorderBottom-14;

      // calculate the damage area
      if (dx>0) {    // scrolling right
         dam.MinX = full.MaxX-dx;
         if (dam.MinX<full.MinX)
            dam.MinX = full.MinX;
      FI
      if (dx<0) {    // scrolling left
         dam.MaxX = full.MinX-dx;
         if (dam.MaxX>full.MaxX)
            dam.MaxX = full.MaxX;
      FI
      if (dy>0) {    // scrolling down
         dam.MinY = full.MaxY-dy;
         if (dam.MinY<full.MinY)
            dam.MinY = full.MinY;
      FI
      if (dy<0) {    // scrolling up
         dam.MaxY = full.MinY-dy;
         if (dam.MaxY>full.MaxY)
            dam.MaxY = full.MaxY;
      FI

      // Having calculated the damaged area in pixel terms, now I must convert that
      // value to hexes.  In other words, I must examine the damaged area and
      // determine the extent of hexes that need to be redrawn.
      xorg = xoffs+(dam.MinX-65)/30;
      yorg = yoffs+(dam.MinY-64)/24;
      xsiz = xoffs+((dam.MaxX-20)/30)-xorg+1;
      ysiz = yoffs+((dam.MaxY-32)/24)-yorg+1;

      switch (mode) {
         case GP_MAP:
            GP_draw_mapstrip(xorg,yorg,xorg+xsiz,yorg+ysiz);
            break;
         case ME_MAP:
            ME_draw_mapstrip(xorg,yorg,xorg+xsiz,yorg+ysiz);
            break;
         case PM_MAP:
            PM_draw_mapstrip(xorg,yorg,xorg+xsiz,yorg+ysiz);
      }

      // If it's a diagonal scroll, then we probably have two more
      // damage areas to worry about.
      if (xoffs-oldxoffs && yoffs-oldyoffs) {
         int xnwd = disp_wd+2-xsiz;
         int xnorg = (xorg-xoffs<0 ? xorg+xsiz : xorg-xnwd);
         int ynwd = disp_ht+2-ysiz;
         int ynorg = (yorg-yoffs<0 ? yorg+ysiz : yorg-ynwd);

         switch (mode) {
            case GP_MAP:
               GP_draw_mapstrip(xnorg,yorg,xnorg+xnwd,yorg+ysiz);
               GP_draw_mapstrip(xorg,ynorg,xorg+xsiz,ynorg+ynwd);
               break;
            case ME_MAP:
               ME_draw_mapstrip(xnorg,yorg,xnorg+xnwd,yorg+ysiz);
               ME_draw_mapstrip(xorg,ynorg,xorg+xsiz,ynorg+ynwd);
               break;
            case PM_MAP:
               PM_draw_mapstrip(xnorg,yorg,xnorg+xnwd,yorg+ysiz);
               PM_draw_mapstrip(xorg,ynorg,xorg+xsiz,ynorg+ynwd);
         }
      FI
   }
}


void GP_smart_scroll(oldxoffs,oldyoffs)
int oldxoffs,oldyoffs;
{
   smart_scroll(oldxoffs,oldyoffs,GP_MAP);
}


/*
   All of the PM_ prefix functions are map drawing functions for the
   Production Mode (or Production Map, if you wish) -- the map that shows
   no units, but displays the production type of each city.

   PM_draw_mapstrip() draws an area of the production map
*/
void PM_draw_mapstrip(x0,y0,x1,y1)
int x0,y0,x1,y1;
{  // build the player's map display
   int xc, yc;

   // display the hex terrain
   for (yc=y0; yc<=y1; yc++)
      for (xc=x0; xc<=x1; xc++) {
         int xw=xc, yw=yc;

         wrap_coords(&xw,&yw);
         if (visibleP(xw,yw))   // basic bounds checking
         {
            int terra;

            if (VALID_HEX(xw,yw)) {
               terra = get(PLAYER.map,xw,yw);
               if (terra!=HEX_UNEXPLORED) {
                  plot_hex(xw,yw,terra);
                  if (get_flags(PLAYER.map,xw,yw)&ROAD)
                     PM_draw_roads(xw,yw);
               FI
            FI
         }
      OD

   // display the cities
   {
      struct City *metro=(struct City *)city_list.mlh_Head;

      /*
         Show cities owned by the player as unit icons representing the unit
         type the city is producing.  Cities not owned by the player are also
         shown in their correct colors, and it even shows the last known
         production of enemy cities that have been reconned by the player's
         aircraft.
      */
      for (;metro->cnode.mln_Succ;metro=(struct City *)metro->cnode.mln_Succ)
         if (within_areaP(metro->col,metro->row,x0,y0,x1,y1)) {
            if (metro->owner==player)
               plot_icon(metro->unit_type,metro->col,metro->row,PLAYER.color,NULL,FALSE);
            else
               if (get(PLAYER.map,metro->col,metro->row)!=HEX_UNEXPLORED) {
                  /*
                     This bit is going to be a little tricky.  I must search
                     the player's map icons to determine who he thinks owns the
                     city (because his info could be out of date).
                  */
                  struct MapIcon *piece = (struct MapIcon *)PLAYER.icons.mlh_Head;
                  int color=WHITE;

                  for (;piece->inode.mln_Succ;piece=(struct MapIcon *)piece->inode.mln_Succ)
                     if (piece->col==metro->col && piece->row==metro->row) {
                        color = roster[piece->owner].color;
                        break;
                     FI
                  if (metro->recon[player]==CITY)
                     plot_city(metro->col,metro->row,color,FALSE);
                  else
                     plot_icon(metro->recon[player],metro->col,metro->row,color,0,0);
               FI
         FI
   }
}


void PM_draw_map()
{  // build the player's Production Map display
   // clear window
   SetRast(rast_port,LT_GRAY);

   // call to this function does all the grunt work,
   // treats display like one huge strip to update
   PM_draw_mapstrip(xoffs-1,yoffs-1,xoffs+disp_wd,yoffs+disp_ht);

   update_scrollers();
   display = TRUE;
}


void PM_smart_scroll(oldxoffs,oldyoffs)
int oldxoffs,oldyoffs;
{
   smart_scroll(oldxoffs,oldyoffs,PM_MAP);
}


// end of listing
