/* This is "graphics.c", a part of the pool (billiards)-program
                   
                     "ANOTHER POOL".

   "graphics.c" uses SDL and SDL_gfx which are available at

   http://www.libsdl.org and
   http://www.ferzkopp.net/Software/SDL_gfx-2.0

   Copyright (C) 1995/2002 by Gerrit Jahn (http://www.planetjahn.de)

   "ANOTHER POOL" is free software; you can redistribute it 
   and/or modify it under the terms of the GNU General Public License 
   as published by the Free Software Foundation; either version 2 of 
   the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   ME CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with GNU CC; see the file COPYING.  If not, write to
   the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* ------------------------------ graphics.c ----------------------------- */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "apool.h"
#include <SDL.h>
#include <SDL_gfxPrimitives.h>

#define GrFilledBox(a,b,c,d,e) boxRGBA(display, a, b, c, d, col[e][0], col[e][1], col[e][2], 255)
#define GrClearScreen(a) boxRGBA(display, 0, 0, display->w-1, display->h-1, 0, 0, 0, 255)
#define GrFilledCircle(a,b,c,d) filledCircleRGBA(display, a, b, c, col[d][0], col[d][1], col[d][2], 255)
#define GrCircle(a,b,c,d) aacircleRGBA(display, a, b, c, col[d][0], col[d][1], col[d][2], 255)
#define GrDrawString( a, b, c, d, e) stringRGBA(display, c, d, a, col[e][0], col[e][1], col[e][2], 255)
#define GrMouseWarp( a, b ) SDL_WarpMouse( a, b )
#ifndef __MORPHOS__
#define GrFilledCircleArc( a, b, c, d, e, f, g ) filledpieRGBA(display, a, b, c, d, e, col[g][0], col[g][1], col[g][2], 255)
#define GrCircleArc( a, b, c, d, e, f, g ) filledpieRGBA(display, a, b, c, d, e, col[g][0], col[g][1], col[g][2], 255)
#else
#define GrFilledCircleArc( a, b, c, d, e, f, g ) filledPieRGBA(display, a, b, c, d, e, col[g][0], col[g][1], col[g][2], 255)
#define GrCircleArc( a, b, c, d, e, f, g ) filledPieRGBA(display, a, b, c, d, e, col[g][0], col[g][1], col[g][2], 255)
#endif
#define GrLine(a,b,c,d,e ) aalineRGBA(display, a, b, c, d, col[e][0], col[e][1], col[e][2], 255)

#define GR_M_BUTTON_DOWN SDL_MOUSEBUTTONDOWN
#define GR_M_BUTTON_UP SDL_MOUSEBUTTONUP
#define GR_M_BUTTON_CHANGE SDL_MOUSEBUTTONDOWN|SDL_MOUSEBUTTONDOWN
#define GR_M_MOTION SDL_MOUSEMOTION
#define GR_M_KEYPRESS SDL_KEYDOWN

int col[20][3] = {{0,0,0},{255,0,0},{255,255,0},{32,32,32},{0,127,0},
                  {124,224,224},{55,0,0},{255,0,255},{32,32,222},{0,255,0},
                  {255,255,255},{255,55,55},{0,0,0},{0,0,96},{0,0,255},
		  {0,0,127},{140,90,40},{0,0,196},{0,0,127},{0,0,127}};
#define TABLEGREEN 4
double oldalph=0.0, alph=0.0, spd=0.75, RADIUSL, e_winkel, old_min;
int counter=0, oldx[BALLS], oldy[BALLS], olds[2];
int old_ball, old_hole, old_paint=5, mmouse = 0;
int SPINPOSX, SPINPOSY;

struct hole posl[6]; /* 6 Lˆcher */
struct bande ban[18];

SDL_Event event;
SDL_Surface *display, *bltsrc;
SDL_Rect src_rect,dest_rect;
SDL_Cursor *cursor, *cursor_cueball, *cursor_orig;
int cursor_state;

void init_graphics( int a, int b, int c)
 {
 display =
   SDL_SetVideoMode( SCREENRESX, SCREENRESY, 32, SDL_HWSURFACE|SDL_DOUBLEBUF );
 SDL_WM_SetCaption("Another Pool", NULL);
 bltsrc=SDL_CreateRGBSurface(SDL_HWSURFACE|SDL_SRCALPHA,24*RADIUS,4*RADIUS,32,
			     0xFE000000,0x00FF0000,0x0000FF00,0x000000FF);
 /*  bltsrc=SDL_DisplayFormat(bltsrc); */ /* schnell ?! aber funzt nicht!! */
/*  display=SDL_DisplayFormat(display); */
 SPINPOSX=display->w-4*RADIUS-10; 
 SPINPOSY=display->h-6*RADIUS;
 olds[0] = SPINPOSX;
 olds[1] = SPINPOSY;
 cursor_orig = SDL_GetCursor();
 cursor_state=0;
 }

void msg( char *out )
 { /* Gibt einige Dinge unterhalb des Tisches aus */
 GrFilledBox( 0, DOWN+25, RIGHT-20, DOWN+41, 0 );
 GrDrawString( out, strlen(out), 5, DOWN+25, TEXTCOL );
 SDL_Flip(display);
 }
 
void plot_standings( void )
 {
     char out[15];
     sprintf(out,"%d : %d",(int)(ply[0].points)%10000+(int)(ply[1].points)/10000,
     (int)(ply[1].points)%10000 + (int)(ply[0].points)/10000 );
     GrDrawString(out,strlen(out), display->w - (15+strlen(out))*8, 10, 10);
 }

static SDL_Cursor *init_system_cursor(int cueball)
{
  int i, row, col, rad;
  Uint8 data[8*64];
  Uint8 mask[8*64];
  i = -1;
  for ( row=0; row<64; ++row ) {
    for ( col=0; col<64; ++col ) {
      if ( col % 8 ) {
        data[i] <<= 1;
        mask[i] <<= 1;
      } else {
        ++i;
        data[i] = mask[i] = 0;
      }
      rad = sqrt((row-PIXELRADIUS)*(row-PIXELRADIUS) + (col-PIXELRADIUS)*(col-PIXELRADIUS));
      if( rad <= PIXELRADIUS ) 
	{
	  if( cueball ) mask[i] |= 0x01;
	  else
	    {
	      if( rad > 4 ) mask[i] |= 0x01;
	      if( rad >= PIXELRADIUS-3 ) data[i] |= 0x01;
	    }
	}
    }
  }
  return SDL_CreateCursor(data, mask, 64, 64, PIXELRADIUS+1, PIXELRADIUS+1);
}

void makecursor( void )
{
  cursor=init_system_cursor(0);
  cursor_cueball=init_system_cursor(1);
  SDL_SetCursor(cursor);
}

void plot_table( void )
/* Hier wird der Tisch neu initialisiert und gemalt, die Banden und Lˆcher
   werden aus der Datei "table.dat" ausgelesen und entsprechend gemalt. 
   Gleichzeitig werden diese Daten f¸r das Spiel aufbereitet... */
 {
 FILE *dat;
 int i, j, counter = 0;
 static Sint16 poly_x[4], poly_y[4];
 double dummy, dummy2[4];
 struct vect n;
 char out[80];
 GrClearScreen( 0 );
 GrFilledBox( LEFT-10, UP-10, RIGHT+10, DOWN+10, TABLEGREEN ); /* "Tuch" */ 
 if( !(dat = fopen("table.dat","r")) ) 
  {
    close_graphics();
    printf("error: can't find the file 'table.dat'. \n");
    printf("create this file using 'apool -init 35' ...\n\n");
    exit(0);
  }
 fscanf(dat,"%lg",&RADIUSL );
 for(i=0;i<6;i++) /* Teilkreise der Taschen malen */
  {
   for(j=0;j<2;j++) fscanf(dat,"%lg",&dummy2[j]);
   GrFilledCircle( LEFT+dummy2[0], UP+dummy2[1], RADIUSL, 0 );
   posl[i].p.x = dummy2[0] / DIFFX;
   posl[i].p.y = dummy2[1] / DIFFX;
  }
 for(i=0;i<6;i++)  /* Banden initialisieren und malen */
  {
  for(j=0;j<4;j++)
   { 
    fscanf(dat,"%lg",&dummy); poly_x[j] = LEFT + (int)dummy; 
    fscanf(dat,"%lg",&dummy); poly_y[j] = UP + (int)dummy; 
   }
  for( j=1;j<4;j++) /* Punkte den Banden zuweisen und Norm.vektoren berech. */
   {
   ban[counter].p0.x = poly_x[j-1]-LEFT;
   ban[counter].p0.y = poly_y[j-1]-UP;
   ban[counter].p1.x = poly_x[j]-LEFT;
   ban[counter].p1.y = poly_y[j]-UP;
   /* "Den" zum "Richtungs-Vektor" der Bande senkrechten Vektor bestimmen */
   n.y = ban[counter].p1.x-ban[counter].p0.x;   
   n.x =  - ( ban[counter].p1.y-ban[counter].p0.y );   
   /* Normieren */
   ban[counter].n.x = n.x / ( dummy = BETR( n ) );
   ban[counter].n.y = n.y / dummy;
   counter++;
   }
  filledPolygonRGBA(display, poly_x, poly_y, 4, 0, 96, 0, 255);
  }
 fclose(dat);
 /* dicke Banden wieder schmaler machen (optisch) */
 GrFilledBox( 0,0, display->w, UP-11, 0 );
 GrFilledBox( 0,DOWN+11, display->w, display->h, 0 );
 GrFilledBox( 0,0, LEFT-11, display->h, 0 );
 GrFilledBox( RIGHT+11,0, display->w, display->h, 0 );
 GrDrawString("ANOTHER POOL", 12, display->w/2, 0, TEXTCOL );
 sprintf(out,"V %s",VERSION);
 GrDrawString( out, strlen(out), 615, 0, TEXTCOL);
 GrFilledCircle( SPINPOSX, SPINPOSY, 39, COL_WHITE );
 GrCircle( SPINPOSX, SPINPOSY, 39, 9 );
 calc_hot_spot();
 calc_e_winkel();
 plot_standings();
 /* Kugeln zum Blitten auf anderes Surface legen */
 filledCircleRGBA(bltsrc, 3*RADIUS, 2*RADIUS,RADIUS,255,0,0,255);
 filledCircleRGBA(bltsrc, 7*RADIUS, 2*RADIUS,RADIUS,255,255,0,255);
 filledCircleRGBA(bltsrc, 11*RADIUS, 2*RADIUS,RADIUS,255,255,255,255);
 filledCircleRGBA(bltsrc, 15*RADIUS, 2*RADIUS,RADIUS,0,0,0,255);
 filledCircleRGBA(bltsrc, 19*RADIUS, 2*RADIUS,RADIUS,0,127,0,255);
 makecursor();
 SDL_Flip(display);
 }

void speed( double p )
 {
   int mx = display->w, my = display->h;
   boxRGBA(display, 10, my - 1.5*Radius, mx-10, my-1, 0, 0, 96, 255);
   boxRGBA(display, 10, my - 1.5*Radius, (mx-10.0)*p, my-1, 0, 0, 196, 255);
   SDL_UpdateRect(display, 10, my - 1.5*Radius, mx-10, 1.5*Radius);
 }

void plot_balls( int paintall )
 {
 int i;
 src_rect.y =   RADIUS;
 src_rect.w = 2*RADIUS+1;
 src_rect.h = 2*RADIUS+1;
 for(i=0;i<BALLS;i++)
  {
  if( !k[i].nopaint || paintall )
   {
   src_rect.x=18*RADIUS;
   dest_rect.x = oldx[i]-RADIUS;
   dest_rect.y = oldy[i]-RADIUS;
   SDL_BlitSurface(bltsrc,&src_rect,display,&dest_rect);
/*   SDL_UpdateRect(display, oldx[i]-RADIUS-1, oldy[i]-RADIUS-1,
		  2*RADIUS+2, 2*RADIUS+2 );*/
   oldx[i]=(LEFT+DIFFX*k[i].p.x+0.5);
   oldy[i]=(UP+DIFFX*k[i].p.y+0.5);
   dest_rect.x = oldx[i]-RADIUS;
   dest_rect.y = oldy[i]-RADIUS;
   switch(k[i].col)
    {
    case COL_BLACK: src_rect.x = 14*RADIUS; break;
    case COL_WHITE: src_rect.x = 10*RADIUS; break;
    case COL_RED: src_rect.x = 2*RADIUS; break;
    case COL_YELLOW: src_rect.x =6*RADIUS; break;
    default: src_rect.x = 18*RADIUS;
    }
   SDL_BlitSurface(bltsrc,&src_rect,display,&dest_rect);
 /*  SDL_UpdateRect(display, oldx[i]-RADIUS, oldy[i]-RADIUS,
		  2*RADIUS, 2*RADIUS );*/
   }
  }
	SDL_Flip(display);
 }

void plot_one_ball( int i )
 {
 oldx[i]=(LEFT+DIFFX*k[i].p.x)+0.5; 
 oldy[i]=(UP+DIFFX*k[i].p.y)+0.5;
 dest_rect.x = oldx[i]-RADIUS;
 dest_rect.y = oldy[i]-RADIUS;
 switch(k[i].col)
   {
   case COL_BLACK: src_rect.x = 14*RADIUS; break;
   case COL_WHITE: src_rect.x = 10*RADIUS; break;
   case COL_RED: src_rect.x = 2*RADIUS; break;
   case COL_YELLOW: src_rect.x = 6*RADIUS; break;
   default: src_rect.x = 6*RADIUS;
   }
 src_rect.y = RADIUS;
 src_rect.w=2*RADIUS+1;
 src_rect.h=2*RADIUS+1;
 SDL_BlitSurface(bltsrc,&src_rect,display,&dest_rect);
 SDL_UpdateRect(display, oldx[i]-RADIUS, oldy[i]-RADIUS,
		2*RADIUS, 2*RADIUS );
 }


void set_spin( double sx, double sy, double sz )
 { /* hier wird der (lokale) Spin der Weiﬂen am Anfang gesetzt und gemalt */
  GrFilledCircle( olds[0], olds[1], 7, COL_WHITE );
  k[WHITE].ez = sz; k[WHITE].e.y = sy; k[WHITE].e.x = sx;
  olds[0] = SPINPOSX + (31.0*k[WHITE].ez + 0.5);
  olds[1] = SPINPOSY + (31.0*k[WHITE].e.y + 0.5);
  GrFilledCircle( olds[0], olds[1], 7, 17 );
  SDL_UpdateRect(display, SPINPOSX-40, SPINPOSY-40, 80, 80);
 } 

void test_spin( int x, int y ) 
 { /* Mouse-Abfrage f¸r das Setzen des lokalen Spins... */
 int oldx=x, oldy=y;
 double sz, sp, dummy;
 do
  {
  do
    SDL_WaitEvent(&event);
  while( event.type != SDL_MOUSEMOTION && event.type != SDL_KEYUP &&
	 (event.type != SDL_MOUSEBUTTONUP) && 
	 (event.type != SDL_MOUSEBUTTONDOWN) );
  if( event.type == SDL_MOUSEMOTION )
   {
    /* sollte vielleicht umgerechnet werden in einen Winkel !!! !!! !!! ??? */
    sz = (event.button.x - oldx)/31.0; sp = (event.button.y - oldy)/31.0; 
    SDL_WarpMouse( oldx, oldy );
    if( (k[WHITE].ez+sz)*(k[WHITE].ez+sz)+
      (k[WHITE].e.y+sp)*(k[WHITE].e.y+sp) < 1.0 )
      set_spin( 0.0, k[WHITE].e.y+sp, k[WHITE].ez+sz );
    else if( (k[WHITE].e.y+sp) || (k[WHITE].ez+sz) )
     {
      dummy = sqrt( (k[WHITE].ez+sz)*(k[WHITE].ez+sz) +
       (k[WHITE].e.y+sp)*(k[WHITE].e.y+sp) );
      set_spin( 0.0, (k[WHITE].e.y+sp)/dummy, (k[WHITE].ez+sz)/dummy );
     }
   }
  else {mmouse=1;}
  }
 while( !(event.type == SDL_KEYUP) && 
	!((event.button.button == SDL_BUTTON_MIDDLE) && 
	  (event.type == SDL_MOUSEBUTTONUP)) && 
	!(mmouse && ((event.type == SDL_MOUSEBUTTONDOWN) || 
		     (event.type == SDL_MOUSEBUTTONUP))) );
 mmouse = 0;
}

void wait_for_click( void )
/* wartet auf Mouse-Click oder Tasten-Druck */
 {
 SDL_Event event;
 msg("press any key or mouse-button");
 do
  { SDL_WaitEvent(&event); }
 while( ( event.type != SDL_KEYUP) && (event.type != SDL_MOUSEBUTTONUP) && 
	(event.type != SDL_QUIT) );
 if( (event.type == SDL_KEYUP) || (event.type == SDL_QUIT) ) 
  {
      Uint8 *keystate = SDL_GetKeyState(NULL);
      if( (keystate[SDLK_ESCAPE]) || (event.type == SDL_QUIT) ) stop_it();
  }
 }

void wait_for_click_up( void )
/* wartet auf Mouse-Click oder Tasten-Druck */
 {
 SDL_Event event;
 msg("press any key or mouse-button");
 do
  { SDL_WaitEvent(&event); }
 while( ( event.type != SDL_KEYDOWN) && (event.type != SDL_MOUSEBUTTONUP) && 
	(event.type != SDL_QUIT) );
 if( (event.type == SDL_KEYUP) || (event.type == SDL_QUIT) ) 
  {
      Uint8 *keystate = SDL_GetKeyState(NULL);
      if( (keystate[SDLK_ESCAPE]) || (event.type == SDL_QUIT) ) stop_it();
  }
 }

void wink( double a ) /* Winkel zwischen Queue und Tisch darstellen */
 {  /* Kˆnnte mal einen dickeren Queue bekommen !!! !!! !!!*/
 double b = a*M_PI/180.0;
 int posx = SPINPOSX-200, posy=SPINPOSY+3*RADIUS;
 GrCircleArc(posx, posy, 6*RADIUS+1, 270, 362, GR_ARC_STYLE_OPEN, 9);
 GrFilledCircleArc(posx, posy, 6*RADIUS, 270, 362, 
		   GR_ARC_STYLE_CLOSE2, COL_WHITE);
/*  GrLine(posx+6*(RADIUS+1)*cos(oldalph),posy-6*(RADIUS+1)*sin(oldalph), */
/* 	posx+12*(RADIUS+1)*cos(oldalph),posy-12*(RADIUS+1)*sin(oldalph),0); */
/*  GrLine(posx+6*(RADIUS+1)*cos(b), posy-6*(RADIUS+1)*sin(b), */
/* 	posx+12*(RADIUS+1)*cos(b), posy-12*(RADIUS+1)*sin(oldalph=b),16); */
/*  SDL_UpdateRect(display,posx-1-RADIUS,posy-12*(RADIUS+1)-1, */
/* 		12*(RADIUS+2)+2,12*(RADIUS+2)+2); */
 GrFilledCircle(posx+6.5*RADIUS*cos(oldalph), posy-6.5*RADIUS*sin(oldalph),
		RADIUS/2,0);
 GrFilledCircle(posx+6.5*RADIUS*cos(b), posy-6.5*RADIUS*sin(oldalph=b),
		RADIUS/2,16);
 SDL_UpdateRect(display,posx-1-RADIUS,posy-7.5*(RADIUS+1)-1,
		12*(RADIUS+2)+2,7.5*(RADIUS+2)+2);
 }

void err( char *out )
 { /* Ausgabe der normalen Texte w‰hrend des Spiels */
 GrFilledBox( 0, DOWN+120, RIGHT-100, DOWN+140, 0 );
 GrDrawString( out, strlen( out ), 0, DOWN+121, TEXTCOL);
 SDL_Flip(display);
 }

void err2( char *out, int lcol )
 { /* Ausgabe von z.B. Free- oder Extra-Ball ... */
 GrFilledBox( 0, DOWN+90, RIGHT-100, DOWN+110, 0 );
 GrDrawString(out, strlen(out), 0, DOWN+91, lcol );
 SDL_Flip(display);
 }

void debug( char *out )
 { /* Ausgabe der Kommentare beim Computer-Spieler */
 char o[80];
 sprintf(o,"%s",out);
 GrFilledBox( 0, 35, 540, 55, 0 );
 GrDrawString(out, strlen(out), 0, 35, TEXTCOL );
 SDL_Flip(display);
 }
 
void mouse_on( void )
 { SDL_ShowCursor(1); }

void mouse_off( void )
 { SDL_ShowCursor(0); }

void plot_cur_player( int cur )
 { /* gibt die kleine Kugel oben links und den akt. Spieler aus */
 char whois[20];
 GrFilledBox( 0, 0, 2*RADIUS+3, 2*RADIUS+3, 0 );
 filledCircleRGBA(display, 1+RADIUS, 1+RADIUS, RADIUS,
     col[ply[cur].col][0], col[ply[cur].col][1], col[ply[cur].col][2], 255);
 if( ply[cur].col == COL_BLACK ) 
     circleRGBA(display, 1+RADIUS,RADIUS-1,RADIUS-1,
     col[COL_WHITE][0], col[COL_WHITE][1], col[COL_WHITE][2], 255);

 sprintf(whois,"player no: %d",cur+1);
 GrDrawString( whois, strlen(whois), 3*RADIUS+1, 1, TEXTCOL );
 SDL_Flip(display);
 }

void set_white_ball( void )
 { /* Weiﬂe Kugel am Anfang oder nach Foul neu positionieren */
 int i, j, okx,oky, mousex, mousey;
 double old, old2; 
 SDL_SetCursor(cursor_cueball);
 k[WHITE].p.x = k[WHITE].p.y = 0.20;
 k[WHITE].stat = 0;
 if( (c_player == -1) || (cur != c_player ) )
  {
  SDL_ShowCursor(1);
  msg("place cue-ball");
  set_spin( 0.0, 0.0, 0.0 );
  old2 = 0.25;
  i = 225;
  do
   {
    old = ((double)i) / 1000.0;
    okx = 1;
    for(j=0;j<WHITE;j++) /* Suche nach freiem Platz auf dem Tisch */
     if( DIFF2( old-k[j].p.x, old2-k[j].p.y ) < 5.0*RADIUS*RADIUS )
      {okx=0; break;}
   }
  while( !okx && (--i>50) );
  k[WHITE].p.x = old; k[WHITE].p.y = old2;
  GrMouseWarp( LEFT + old*DIFFX, UP + old2*DIFFX );
  do
   {
    do
     SDL_WaitEvent( &event);
    while(! ((event.type==SDL_KEYDOWN) || (event.type==SDL_MOUSEMOTION) || 
             (event.type==SDL_MOUSEBUTTONUP) ) );

    okx=oky=1;
    if( event.type == SDL_MOUSEMOTION )
     { /* Verschieben des Spielballs, aber nicht "auf" andere Kugeln */
      mousex=event.motion.x;
      mousey=event.motion.y;
      for(j=0;j<WHITE;j++)
       if((!(k[j].stat)) && 
	  (DIFF2( (mousex-LEFT)/DIFFX - k[j].p.x,
		  (mousey-UP)/DIFFX - k[j].p.y ) < 5.0*RADIUS*RADIUS) )
	 { okx = oky = 0; break; }
      if((mousex <= LEFT+RADIUS) || (mousex >= LEFT+0.25*DIFFX)) okx=0;
      if((mousey <= UP+RADIUS) || (mousey >= DOWN-RADIUS)) oky=0;
      if( oky ) old2 = (double)(mousey-UP)/DIFFX; 
      if( okx ) old = (double)(mousex-LEFT)/DIFFX;
      if(!okx || !oky) GrMouseWarp(LEFT + old*DIFFX+0.5, UP + old2*DIFFX+0.5);
      k[WHITE].p.x = old; k[WHITE].p.y = old2;
     }
   }
  while( ( event.type != SDL_KEYDOWN) && (event.type!=SDL_MOUSEBUTTONUP) && 
         (event.type != SDL_QUIT) );
  if( (event.type == SDL_KEYDOWN) || (event.type == SDL_QUIT) ) 
    {
      Uint8 *keystate = SDL_GetKeyState(NULL);
      if( (keystate[SDLK_ESCAPE]) || (event.type == SDL_QUIT) ) stop_it();
    }
  }
 else /* !!! !!! !!! !!! !!! !!! VERBESSERN! */
  {
  /* Computer kann Weiﬂe legen ... */
  set_spin( 0.0, 0.0, 0.0 );
  old2 = 0.25;
  i = 250;
  do
   {
    old = ((double)i) / 1000.0;
    okx = 1;
    for(j=0;j<WHITE;j++) /* Suche nach freiem Platz auf dem Tisch */
     if( DIFF2( old-k[j].p.x, old2-k[j].p.y ) < 5.0*RADIUS*RADIUS )
      {okx=0; break;}
   }
  while( !okx && (--i>50) );
  k[WHITE].p.x = old; k[WHITE].p.y = old2;
  }
 k[WHITE].stat = 0; /* Weiﬂe wieder auf dem Tisch */
 plot_one_ball( WHITE );
 SDL_SetCursor(cursor);
}

void set_white_ball_orig( void )
 { /* Weiﬂe Kugel am Anfang oder nach Foul neu positionieren */
 int i, j, okx,oky, mousex, mousey;
 double old, old2; 
 SDL_SetCursor(cursor_cueball);
 k[WHITE].p.x = k[WHITE].p.y = 0.25;
 k[WHITE].stat = 0;
 if( (c_player == -1) || (cur != c_player ) )
  {
  SDL_ShowCursor(1);
  msg("place cue-ball");
  set_spin( 0.0, 0.0, 0.0 );
  old2 = 0.25;
  i = 250;
  do
   {
    old = ((double)i) / 1000.0;
    okx = 1;
    for(j=0;j<WHITE;j++) /* Suche nach freiem Platz auf dem Tisch */
     if( DIFF2( old-k[j].p.x, old2-k[j].p.y ) < 5.0*RADIUS*RADIUS )
      {okx=0; break;}
   }
  while( !okx && (--i>50) );
  k[WHITE].p.x = old; k[WHITE].p.y = old2;
  GrMouseWarp( LEFT + old*DIFFX, UP + old2*DIFFX );
  do
   {
    do
     SDL_WaitEvent( &event);
    while(! ((event.type==SDL_KEYDOWN) || (event.type==SDL_MOUSEMOTION) || 
             (event.type==SDL_MOUSEBUTTONUP) ) );

    okx=oky=1;
    if( event.type == SDL_MOUSEMOTION )
     { /* Verschieben des Spielballs, aber nicht "auf" andere Kugeln */
      for(j=0;j<WHITE;j++)
       if((!(k[j].stat)) && (DIFF2( (event.button.x-LEFT)/DIFFX - k[j].p.x,
        (event.button.y-UP)/DIFFX - k[j].p.y ) < 5.0*RADIUS*RADIUS) )
          { okx = oky = 0; break; }
      mousex=event.motion.x;
      mousey=event.motion.y;
      if((mousex <= LEFT+RADIUS) || 
          (mousex >= (int)(LEFT+0.25*DIFFX)) ) okx=0;
      if((mousey <= UP+RADIUS) || (mousey >= DOWN-RADIUS)) oky=0;
      if( okx && oky )
       {
        old = (double)(mousex-RIGHT+DIFFX)/DIFFX;
        old2 = (double)(mousey-DOWN+DIFFX/2)/DIFFX;
        }
      else 
        {
        if( okx || oky )
          {
          if( !okx )
            {
/*          old2 = (double)(mousey-DOWN+DIFFX/2)/DIFFX; */
            }
          else if( !oky )
            {
/*          old = (double)(mousex-RIGHT+DIFFX)/DIFFX; */
            }
	  GrMouseWarp((double)LEFT + old * DIFFX, (double)UP + old2*DIFFX);
          }

        }
      k[WHITE].p.x = old; k[WHITE].p.y = old2;
     }
   }
  while( ( event.type != SDL_KEYDOWN) && (event.type!=SDL_MOUSEBUTTONUP) && 
         (event.type != SDL_QUIT) );
  if( (event.type == SDL_KEYDOWN) || (event.type == SDL_QUIT) ) 
    {
      Uint8 *keystate = SDL_GetKeyState(NULL);
      if( (keystate[SDLK_ESCAPE]) || (event.type == SDL_QUIT) ) stop_it();
    }
  }
 else /* !!! !!! !!! !!! !!! !!! VERBESSERN! */
  {
  /* Computer kann Weiﬂe legen ... */
  set_spin( 0.0, 0.0, 0.0 );
  old2 = 0.25;
  i = 250;
  do
   {
    old = ((double)i) / 1000.0;
    okx = 1;
    for(j=0;j<WHITE;j++) /* Suche nach freiem Platz auf dem Tisch */
     if( DIFF2( old-k[j].p.x, old2-k[j].p.y ) < 5.0*RADIUS*RADIUS )
      {okx=0; break;}
   }
  while( !okx && (--i>50) );
  k[WHITE].p.x = old; k[WHITE].p.y = old2;
  }
 k[WHITE].stat = 0; /* Weiﬂe wieder auf dem Tisch */
 plot_one_ball( WHITE );
 SDL_SetCursor(cursor);
}


void calc_player_v( void )
{
    struct vect v;
    double dummy;
    int mousex, mousey;
    SDL_PollEvent(&event);
    SDL_GetMouseState(&mousex, &mousey); 
    v.x = (double)(mousex - LEFT) - k[WHITE].p.x*DIFFX;
    v.y = (double)(mousey - UP) - k[WHITE].p.y*DIFFX;
    if( v.x || v.y )
    {
	v.x /= (dummy = sqrt(v.x*v.x+v.y*v.y));
	v.y /= dummy;
    }
    set_spin( k[WHITE].e.x*spd, k[WHITE].e.y*spd, k[WHITE].ez/* *spd!!! ??*/);
    k[WHITE].v.x = spd * v.x / DIFFX;
    k[WHITE].v.y = spd * v.y / DIFFX;
}

void set_player_power( void )
{
    int oldx, oldy;
    mouse_off();
    SDL_GetMouseState(&oldx, &oldy); 
  do
  {
      SDL_WaitEvent(&event);
      if( (event.type == SDL_MOUSEMOTION ) )
      {
          if( (event.button.x != oldx) || (event.button.y != oldy) )
	  {
              spd += 1.0/500.0 * (double)(event.button.x - oldx);
              spd += 1.0/500.0 * (double)(-event.button.y + oldy);
	      SDL_WarpMouse(oldx, oldy);
              if( spd > 1.0 ) spd = 1.0;
              if( spd < 0.0 ) spd = 0.0;
	      speed(spd);
	  }
      }
  }
  while( !( event.type == SDL_MOUSEBUTTONUP && 
            event.button.button == SDL_BUTTON_RIGHT) );
  mouse_off();
  speed( spd );
}

void set_player_spin( void )
 { /* zum Einstellen des Spins; dicke Kugel rechts unten */
  int oldx, oldy, mousex, mousey; 
  double oldalph_local;
  oldalph=alph;
  mouse_off();
  msg("move mouse to change spin, press right button to change angle");
  SDL_GetMouseState(&mousex, &mousey); 
  test_spin(mousex, mousey); 
  if( (event.type == SDL_MOUSEBUTTONDOWN) &&
      ((event.button.button == SDL_BUTTON_MIDDLE) ||
       (event.button.button == SDL_BUTTON_RIGHT))) 
   {
    SDL_GetMouseState(&mousex, &mousey); 
    oldx = mousex; oldy = mousey;
    msg("move mouse to change angle between queue an table");
     do
      {
       oldalph_local = alph;
       SDL_WaitEvent( &event );
       if( event.type == GR_M_MOTION )
        {
        if( (oldx-event.motion.x) || (oldy-event.motion.y) )
	  {    
	  alph += 0.1 * (oldx - event.motion.x + oldy - event.motion.y);
	  GrMouseWarp( oldx, oldy );
	  if( alph > 90.0 ) alph = 90.0;
	  if( alph < 0.0 ) alph = 0.0;
	  wink( alph );
	  }
        }
      }
     while( !(event.type == GR_M_KEYPRESS) && 
	     !( (event.type == SDL_MOUSEBUTTONUP) && 
		 ((event.button.button == SDL_BUTTON_MIDDLE) ||
		  (event.button.button == SDL_BUTTON_RIGHT))) ); 
   }
  mouse_on();
  MSG2;
 }

void set_test_power( void )
 { /* Test-Prozedur, berechnet Geschw., die die Weisse haben muﬂ, um zur akt.
      Maus-Position zu rollen */
  struct vect v;
  debug("press button, to play white to cur.pos. !");
  do 
   { SDL_WaitEvent( &event ); }
  while( !(event.type == GR_M_BUTTON_DOWN) );
  v.x = (event.button.x-LEFT)/DIFFX - k[WHITE].p.x;
  v.y = (event.button.y-UP)/DIFFX  - k[WHITE].p.y;
  set_c_speed( SET_V(BETR( v ), 0), v );
 }

int set_test_power2( void )
 { /* Test-Prozedur, berechnet die Geschw., die die Weisse benˆtigt, um ein
      best. Kugel in ein best. Loch zu schieﬂen; ohne jeden Test, ob andere
      Kugeln im Weg liegen ... */
  int i, puffer_ball;
  struct vect v1, v2, v3, v4;
  double dum1, dummy; 
  int dum2;
  char outtext[80];
  debug("ball ?");
  do 
   { SDL_WaitEvent( &event ); }
  while( !(event.type == GR_M_BUTTON_DOWN) );
  v1.x = (event.button.x-LEFT) / DIFFX; 
  v1.y = (event.button.y-UP) / DIFFX; 
  dum1 = dum2 = 4;
  for( i=0;i<WHITE;i++ )
   if( DIFF( v1.x-k[i].p.x, v1.y-k[i].p.y ) < dum1 )
    { dum1 = DIFF( v1.x-k[i].p.x, v1.y-k[i].p.y ); dum2 = i; }  
  v1.x = k[dum2].p.x; v1.y = k[dum2].p.y;
  puffer_ball = dum2;
  sprintf(outtext,"ball no: %d, hole ?", dum2 );
  debug(outtext);
  do 
   { SDL_WaitEvent( &event ); }
  while( !(event.type == GR_M_BUTTON_DOWN) );
  v2.x = (event.button.x-LEFT) / DIFFX; 
  v2.y = (event.button.y-UP) / DIFFX; 
  dum1 = 1000.0; dum2 = 0;
  for( i=0;i<6;i++ )
   if( DIFF( v2.x-posl[i].m.x, v2.y-posl[i].m.y ) < dum1 )
    { dum1 = DIFF( v2.x-posl[i].m.x, v2.y-posl[i].m.y ); dum2 = i; } 
  sprintf(outtext,"hole: %d",dum2);
  debug(outtext);
  v2.x = posl[dum2].m.x; v2.y = posl[dum2].m.y;
  v3 = calc_tp( v1, v2 );
  dummy = sqrt( DIFF( k[WHITE].p.x-v3.x, k[WHITE].p.y-v3.y ));
  /* geht so nat¸rlich noch nicht wieder !!! */
  v4.x = v2.x - v3.x; v4.y = v2.y - v3.y;
  v1.x = v3.x - k[WHITE].p.x; v1.y = v3.y - k[WHITE].p.y;
  if( COSV( v1, v4 ) > 0.0 )
   {
    v2.x = posl[dum2].p.x - posl[dum2].m.x;
    v2.y = posl[dum2].p.y - posl[dum2].m.y;
    v3.x = posl[dum2].m.x - k[puffer_ball].p.x;
    v3.y = posl[dum2].m.y - k[puffer_ball].p.y;
    if( ((dum2 == 2 || dum2 == 5) && COSV( v2, v3 ) > COS(e_winkel)) 
     || (dum2 != 2 && dum2 != 5) )
      {
       if( (dum1=COSV( v1, v4 )) ) dummy += BETR(v4) / (dum1 * dum1);
       else dummy = 1000000.0; /* =infinity */
       set_c_speed( SET_V(dummy*sqrt(1.0/ROLL), 0), v1 );  
       return 1;
      }
     else 
      {
       char out[80];
       sprintf(out,"can't play this..(ew:%g/ pw:%g)", e_winkel, 
        180.0/M_PI * acos(COSV( v2, v3 )) );
       debug(out);
       return 0;
      }
   }
  debug("can't play this...");
  return 0;
}
 
         /* steht nur wegen der Grafik-Befehle und #defines in graphics.c */
int menu( void ) 
/* hier wird einiges geregelt, Mouse-Abfragen, die zum Stoﬂen, Spin u.
   Geschw. einstellen dienen und Tastaturabfragen, wie z.B. Computer-
   Gegner anschalten, Porgramm beenden ... */
 { 
  int i, ok=0, ret_wert=0, mousex, mousey;
  plot_cur_player( cur );
  wink( alph = 0.0 );
  set_spin( 0.0, 0.0, 0.0 );
  for( i=0;i<BALLS;i++) /* alle Kugeln neu initialisieren */
   {  k[i].v.x = k[i].v.y = k[i].e.x = k[i].e.y = k[i].ez = 0.0; }
  if( k[WHITE].stat ) set_white_ball(); /* Weiﬂe neu setzen */
  if( cur == c_player ) { computer_stoss(); return ret_wert; }
  ok = 0;
  MSG2;
  do
   {
    mouse_on();
    do 
     { SDL_WaitEvent(&event); }
    while(!((event.type==SDL_KEYDOWN) || (event.type==SDL_MOUSEBUTTONDOWN) ||
	    (event.type==SDL_MOUSEBUTTONUP) || (event.type == SDL_QUIT) ||
	    (event.type==SDL_MOUSEMOTION)));
    if( event.type == SDL_MOUSEMOTION )
     {
       if( (event.motion.x>LEFT+RADIUS) && (event.motion.x<RIGHT-RADIUS) &&
	   (event.motion.y>UP+RADIUS) && (event.motion.y<DOWN-RADIUS) )
	 { if( !cursor_state ) {SDL_SetCursor(cursor); cursor_state=1;} }
       else
	 { if( cursor_state ) {SDL_SetCursor(cursor_orig); cursor_state=0;} }
     }
    if( event.type == SDL_QUIT ) {ok = ret_wert = 1;}
    if( (event.type==SDL_MOUSEBUTTONDOWN) || (event.type==SDL_MOUSEBUTTONUP) )
     {
     switch(event.button.button)
      {
       case SDL_BUTTON_LEFT: /* Stoﬂ: Geschw. berechnen */
	 if( event.type == SDL_MOUSEBUTTONUP && cursor_state ) 
	   { calc_player_v(); ok = 1; }
         else ok=0;
         break;
       case SDL_BUTTON_RIGHT:  /* Geschwindigkeits (Power)-Faktor verstellen */
	 if( event.type == SDL_MOUSEBUTTONDOWN ) set_player_power(); break;
       case SDL_BUTTON_MIDDLE: /* Spin einstellen */
	if( event.type == SDL_MOUSEBUTTONDOWN ) set_player_spin(); break;
      case 4: alph = ((alph+=0.5) > 90 ? 90 : alph); wink( alph ); break;
      case 5: alph = ((alph-=0.5) < 0 ? 0 : alph); wink( alph ); break;
      default: {}
      }
     }
    else if( event.type == GR_M_KEYPRESS )
     {
     switch( event.key.keysym.sym )
       {
       case SDLK_F12: SDL_SaveBMP(display, "screenshot.bmp"); break;
       case SDLK_ESCAPE: ok = ret_wert = 1; break;
       case SDLK_n:		/* new game */
	 mouse_off();
	 ply[1-cur].points += 1;
	 stats[cur].losses += 1;
	 cur = 1 - cur;
	 delete_ball(WHITE);
	 init_table(); 
	 ok = 1; 
	 break;
       case SDLK_f: SDL_WM_ToggleFullScreen(display); break;
       case SDLK_r:		/* 'instant replay'-mode on/off */
	 i = STEP; 
	 STEP = old_paint; 
	 old_paint = i; 
	 if( STEP < 6 ) debug("replay-mode on");
	 else debug("replay-mode off");
	 break;
       case SDLK_u:		/* undo last shot */
	 undo(); debug("undo..."); break; /* akt ??? !!! !!! !!! */
       case SDLK_d: 
	 demo = 1; 
	 msg("press space or mouse button to stop demo");
	 c_player = cur;
	 computer_stoss();
	 ok = 1;
	 break;
       case SDLK_c:		/* computer plays every shot*/
	 if( c_player == -1 ) c_player = cur; 
	 else { c_player = -1; break; }
       case SDLK_x:		/* let computer play one shot */
	 computer_stoss();
	 ok = 1;
	 break;
       case SDLK_s: plot_statistics( 0, 1 ); break;
       case SDLK_F1: help(); break;			/* F1 */
       case SDLK_F2: credits(); break;		/* F2 */
#ifdef BANDEN
       case SDLK_b:		/* show shots 'through' 1 or 2 sides */
	 mouse_off();
	 banden_stoss();
	 mouse_on();
	 ok = 0;
	 break;
#endif
       case SDLK_p: /* put away balls except of eight ball ;-) */
	 for( i=BLACK+1;i<WHITE;i++ ) delete_ball( i );
	 for( i=0;i<BLACK;i++ ) delete_ball( i ); 
	 break;
       case SDLK_w:		/* shot ball (1) in hole (2) */
	 ok = set_test_power2(); break;
       case SDLK_e: mmouse = 1; 
	 SDL_GetMouseState(&mousex, &mousey); 
	 test_spin(mousex, mousey); 
	 break;
       case SDLK_PLUS: alph = ((alph+=1) > 90 ? 90 : alph); wink( alph ); break;
       case SDLK_MINUS: alph = ((alph-=1) < 0 ? 0 : alph); wink( alph ); break;
       default: {}
       }
     } 
   }
  while( !ok );
  mouse_off();
  return ret_wert;
 }
  
void delete_ball( int n )
/* Kugel "n" f‰llt in Tasche und wird gelˆscht; auﬂerdem wird gepr¸ft, ob
   ein Foul durch das Versenken begangen wurde... Hatte der Spieler vor dem
   Versenken noch keine Farbe (Anfang des Spiels) so bekommt er hier diese */
 {
/*  int dummy = k[n].col; */
/*  k[n].col = -1;      /\* damit die Kugel gr¸n ¸bermalt wird        *\/ */
/*  plot_one_ball(n);   /\*                                           *\/ */
/*  k[n].col = dummy;   /\* urspr¸nglichen Farbwert wieder herstellen *\/ */
 k[n].stat = 1;
 k[n].p.x = k[n].p.y = 10000.0; /* eigentlich unnˆtig ! --- soso ;-/ */
 if( k[n].col == COL_WHITE ) ply[cur].stat |= FOUL_WHITE_POCKETED;
 else if( (k[n].col == COL_BLACK) && (ply[cur].col != COL_BLACK) )
   ply[cur].stat |= FOUL_BLACK_ILLEGALY_POCKETED;
 else if( !ply[cur].col && (k[n].col != COL_WHITE) ) 
   { /* falls noch kein Spieler-Farbe festgelegt ist */
     if( (k[n].col != COL_BLACK) && (ply[1-cur].col != k[n].col) )
       ply[cur].col = k[n].col;
     ply[1-cur].col = 3 - k[n].col;
     ply[cur].stat |= FOUL_CORRECT_POT;
     col_in = k[n].col;
     new_col |= NEW_COL_NEW;
   }
 else if( !freeball && (k[n].col != ply[cur].col) ) /* falsche Farbe */
   {
     if( new_col & NEW_COL_NEW ) new_col |= NEW_COL_DOUBLE;
     else ply[cur].stat |= FOUL_WRONG_COLOR_POCKETED;
   }
 else if( freeball || (k[n].col == ply[cur].col))  /* OK */
   ply[cur].stat |= FOUL_CORRECT_POT;
 bande_hit = 1;
 last_pocketed_balls++;
 }

void print( char *out, int align, int x, int y )
 {
 GrDrawString( out, strlen(out), x, y, TEXTCOL );
 SDL_Flip(display);
 }

void print2( char *out, int align, int x, int y )
 {
 GrDrawString( out, strlen(out), x, y, TEXTCOL );
 SDL_Flip(display);
 }

void close_graphics( void )
 {
   SDL_FreeCursor(cursor);
   SDL_FreeCursor(cursor_cueball);
   SDL_FreeCursor(cursor_orig);
   atexit(SDL_Quit);
 }

void smile( int malen )
 {
  GrFilledCircle( SPINPOSX, SPINPOSY, 39, COL_WHITE );
  if( malen )
   {
    GrFilledCircle( SPINPOSX - 14, SPINPOSY-12, 7, COL_BLACK );
    GrFilledCircle( SPINPOSX + 14, SPINPOSY-12, 7, COL_BLACK );
    GrCircleArc( SPINPOSX, SPINPOSY+2, 25, 0, 180, 
		 GR_ARC_STYLE_OPEN, COL_BLACK );
    GrCircleArc( SPINPOSX, SPINPOSY+2, 19, 0, 185, 
		 GR_ARC_STYLE_OPEN, COL_WHITE );
    SDL_UpdateRect(display, SPINPOSX-40, SPINPOSY-40, 80, 80);
   }
 }

void plot_statistics( double time, int grx )
 {
 int add = 84;
 char out[80];
 mouse_off();
 GrClearScreen( 0 );
 GrDrawString( "STATISTICS", 10, display->w/2, 30, COL_WHITE );
 sprintf(out,"                          Player     %5d   %5d", 1, 2);
 GrDrawString( out, strlen(out), 1, add, COL_WHITE );
 add += 32;
 sprintf(out,"standings                            %5d   %5d",
	 stats[0].wins+stats[1].losses, stats[1].wins+stats[0].losses);
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 sprintf(out,"-games won (correct play on black)   %5d   %5d",
	 stats[0].wins, stats[1].wins);
 GrDrawString( out, strlen(out), 1, (add+=24), COL_WHITE );
 sprintf(out,"-games lost ('direct' foul on black) %5d   %5d",
	 stats[0].losses, stats[1].losses  );
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 sprintf(out,"number of pocketed balls             %5d   %5d",
	 stats[0].pots, stats[1].pots  );
 GrDrawString( out, strlen(out), 1, (add+=20), COL_WHITE );
 sprintf(out,"no. of attempts without success      %5d   %5d",
	 stats[0].nopots, stats[1].nopots  );
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 sprintf(out,"fouls: wrong color touched           %5d   %5d",
	 stats[0].fouls.wrongct, stats[1].fouls.wrongct  );
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 sprintf(out,"fouls: wrong color pocketed          %5d   %5d",
	 stats[0].fouls.wrongcp, stats[1].fouls.wrongcp  );
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 sprintf(out,"fouls: white ball disappeared        %5d   %5d",
	 stats[0].fouls.whited, stats[1].fouls.whited  );
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 sprintf(out,"fouls: no ball or side touched       %5d   %5d",
	 stats[0].fouls.notouch, stats[1].fouls.notouch  );
 GrDrawString( out, strlen(out), 1, (add+=16), COL_WHITE );
 wait_for_click_up(); 
 plot_table();
 plot_balls(0);
 speed(spd);
 wink(alph);
 set_spin( k[WHITE].e.x*spd, k[WHITE].e.y*spd, k[WHITE].ez);
 plot_balls(0);
 }

void help( void )
 {
 int a=100;
 mouse_off();
 GrClearScreen( 0 );
 GrDrawString("HELP-Screen", 11, display->w/2, 30, COL_WHITE );
 print("KEYS:",0, 30, 65);
 print("  'e': change spin, same as middle button", 0, 30, a+=16 );
 print("  '+', '-': change angle between cue and table (m.+r. button)",
       0, 30, a+=16 );
 print("  'c': activate/deactivate computer opponent", 0, 30, a+=16);
 print("  'x': computer plays only one shot", 0, 30, a+=16 );
 print("  'n': new game, actual game is lost", 0, 30, a+=16 );
 print("  'd': demo-mode on; any key to stop demo", 0, 30, a+=16 );
 print("  'w': ball rolls to actual mouse-position (test-procedure)",
       0, 30 , a+=16 );
 print("  'W': some sort of computer help (test it)", 0, 30, a+=16 ); 
 print("  'u': undo last shot (no redo implemented)", 0, 30 , a+=16 );
 print("  'r': slow-motion-mode on/off", 0, 30, a+=16 );
 print("  's': show statistics", 0, 30, a+=16 );
 print(" 'F1': this screen", 0, 30, a+=16 );
 print(" 'F2': credits", 0, 30, a+=16 );
 print("ENTER: or SPACE: same as left mouse-button", 0, 30, a+=16 );
 print("  'q': show statistics before quitting the game", 0, 30, a+=16);
 print("  ESC: 'fast' quit game (works im allmost every situation)",
       0, 30, a+=16 );
 wait_for_click_up();
 plot_table();
 plot_balls(0);
 speed(spd);
 wink(alph);
 set_spin( k[WHITE].e.x*spd, k[WHITE].e.y*spd, k[WHITE].ez);
 mouse_on();
}

void credits( void )
 {
 int a=70;
 char out[90];
 mouse_off();
 GrClearScreen( 0 );
 sprintf(out,"Another Pool V %s, %s, copyright (c) by Gerrit Jahn",
	 VERSION, DATE);
 print2(out, 1, 90, 20 );
 GrDrawString("CREDITS", 8, display->w/2, 40, COL_WHITE );
 print2("'ANOTHER POOL' is free software;   you can redistribute it",
	0, 90, a+=15);
 print2("and/or modify it under the terms of the GNU General Public License",
	0, 90, a+=15);
 print2("as published by the Free Software Foundation; either version 2 of",
	0, 90, a+=15);
 print2("the License, or (at your option) any later version.",
	0, 90, a+=15);a+=15;
 print2("Another Pool is distributed in the hope that it will be useful,",
	0, 90, a+=15);
 print2("but WITHOUT ANY WARRANTY; without even the implied warranty of",
	0, 90, a+=15);
 print2("MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the",
	0, 90, a+=15);
 print2("GNU General Public License (see file COPYING) for more details.",
	0, 90, a+=15);a+=5;
 print2("------------------------------------------------------------------",
	0, 90, a+=15);a+=5;
 print2("If you have any problems, questions or suggestions, look at:",
	0, 90, a+=15);
 print2("http://www.planetjahn.de                 --            Gerrit",
	0, 90, a+=15);a+=15;
 wait_for_click_up();
 plot_table();
 plot_balls(0);
 speed(spd);
 wink(alph);
 set_spin( k[WHITE].e.x*spd, k[WHITE].e.y*spd, k[WHITE].ez);
 mouse_on();
 }

void plot_pockets(void)
 {
 int j;
 for(j=0;j<6;j++) /* Teilkreise der Taschen nachmalen */
   GrFilledCircle( LEFT+posl[j].p.x*DIFFX, UP+posl[j].p.y*DIFFX, RADIUSL, 0 );
 SDL_Flip(display);
 }
