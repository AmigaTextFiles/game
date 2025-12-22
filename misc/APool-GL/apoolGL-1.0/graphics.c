/* This is "graphics.c", a part of the pool (billiards)-program
                   
"Another Pool GL".

"graphics.c" uses the SDL graphics-library which is available at

http://www.libsdl.org and

Copyright (C) 1995,2002 by Gerrit Jahn (http://www.planetjahn.de)

This file ist part of Another Pool / Another Pool GL (apool, apoolGL).

"Another Pool" is free software; you can redistribute it 
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
#include <sys/time.h>
#include <string.h>
#include <SDL/SDL.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include "apool.h"

#define GR_M_BUTTON_DOWN SDL_MOUSEBUTTONDOWN
#define GR_M_BUTTON_UP SDL_MOUSEBUTTONUP
#define GR_M_BUTTON_CHANGE SDL_MOUSEBUTTONDOWN|SDL_MOUSEBUTTONDOWN
#define GR_M_MOTION SDL_MOUSEMOTION
#define GR_M_KEYPRESS SDL_KEYDOWN

#define PAINT_ALL \
 gl_plotall(-1);\
 paint_spin( 1.0/10.0, 0.45, 0.36 );\
 speed(spd, 1.0/10.0, 0.09, 0.36);\
 gl_plot_target();\
 msg(current_message);\
 msg2(current_message2);\
 SDL_GL_SwapBuffers()

int col[20][3] = {{0,0,0},{255,0,0},{255,255,0},{32,32,32},{0,127,0},
                  {124,224,224},{55,0,0},{255,0,255},{32,32,222},{0,255,0},
                  {255,255,255},{255,55,55},{0,0,0},{0,0,96},{0,0,255},
		  {0,0,127},{140,90,40},{0,0,196},{0,0,127},{0,0,127}};
#define TABLEGREEN 4
double oldalph=0.0, alph=0.0, spd=0.75, e_winkel, old_min;
int counter=0, oldx[BALLS], oldy[BALLS], olds[2];
int old_ball, old_hole, old_paint=5, mmouse = 0;
int SPINPOSX, SPINPOSY;

struct hole posl[6]; /* 6 Lˆcher */
struct bande banpixel[18], ban[18];

SDL_Event event;
SDL_Rect src_rect,dest_rect;

void init_graphics( void )
 {
 InitGL(SCREENRESX, SCREENRESY);
 }

void msg( char *out )
 { /* Gibt einige Dinge unterhalb des Tisches aus */
 glPrint(20,35,out,0,1.0,1.0,1.0,1.0,0.8);
 }

void gl_print_foul( void )
 { /* Fouls anzeigen */
 glPrintCentered(600,foul_msg,0,1.0,0.0,0.0,0.8,1.5);
 }

void gl_print_err2( void )
 { /* freeball/extra shout anzeigen */
 glPrintCentered(300,err2_msg1, 0, 1.0, 0.0, 0.0, 0.8,3.0);
 glPrintCentered(220,err2_msg2, 0, 1.0, 0.0, 0.0, 0.8,3.0);
 }

void msg2( char *out )
 { /* Gibt einige Dinge unterhalb des Tisches aus */
 glPrint(20,15,out,0,1.0,1.0,1.0,1.0,0.8);
 }
 
void plot_standings( void )
 {
 char out[15];
 sprintf(out,"%d : %d",(int)(ply[0].points)%10000+(int)(ply[1].points)/10000,
	 (int)(ply[1].points)%10000 + (int)(ply[0].points)/10000 );
 /*   GrDrawString(out,strlen(out), display->w - (15+strlen(out))*8, 10, 10); */
 }

void speed( double p, double scale, double posx, double posy )
 {
 glDisable(GL_LIGHTING);
 glEnable(GL_BLEND);
 glDisable(GL_FOG);
 glDisable(GL_DEPTH_TEST);             /* Disables Depth Testing */

 glMatrixMode(GL_PROJECTION);
 glPushMatrix();             
 glLoadIdentity();           
 glOrtho(-0.5,0.5,-0.37,0.37,-0.5,1);
 glMatrixMode(GL_MODELVIEW);
 glPushMatrix();
 glLoadIdentity();
 glTranslated(posx, posy - 0.03 * (1.0 - scale), -0.0f);
 
 if(table_color != 0) glColor4d(0.1f,0.3f,0.7f,0.3f);
 else glColor4d(0.7f,0.3f,0.1f,0.3f);

 glBegin(GL_POLYGON);
 glVertex3d( -0.2 - 0.2*scale, -(0.025 + 0.025*scale), 0.1);
 glVertex3d(  0.2 + 0.2*scale, -(0.025 + 0.025*scale), 0.1);
 glVertex3d(  0.2 + 0.2*scale,  (0.01 + 0.04*scale), 0.1);
 glVertex3d( -0.2 - 0.2*scale,  (0.01 + 0.04*scale), 0.1);
 glEnd();
 
 if(table_color != 0) glColor4d(0.1f,0.3f,0.7f,0.3f);
 else glColor4d(0.7f,0.3f,0.1f,0.3f);
 glBegin(GL_POLYGON);
 glVertex3d( -0.2 -0.2*scale, -(0.025 + 0.025*scale), 0.1);
 glVertex3d( (-0.2+spd*0.4) + (-0.2+spd*0.4)*scale, -(0.025 + 0.025*scale), 0.1);
 glVertex3d( (-0.2+spd*0.4) + (-0.2+spd*0.4)*scale,  (0.01 + 0.04*scale), 0.1);
 glVertex3d( -0.2 -0.2*scale,  (0.01 + 0.04*scale), 0.1);
 glEnd();
   
 glEnable(GL_DEPTH_TEST);
 glDisable(GL_BLEND);
 glEnable(GL_LIGHTING);
 glEnable(GL_FOG);
 glMatrixMode(GL_PROJECTION);
 glPopMatrix();
 glMatrixMode(GL_MODELVIEW);
 glPopMatrix();
 }

void paint_spin( double scale, double posx, double posy )
 {
 float rad_outer=0.3;
 double angle;
 float MatDifWhite[] = {1.0,1.0,1.0,0.75};

 /* falls Textures ausgeschaltet muss die Spinkugel explizit 
    weiﬂ sein, ansonsten hat sie die gleiche Farbe wie die 
    "next"-Kugel */
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifWhite);

 glDisable(GL_FOG);
 glEnable(GL_BLEND);
 glDisable(GL_LIGHT1);
 glDisable(GL_LIGHT2);
 glEnable(GL_LIGHT3);
  
 glMatrixMode(GL_PROJECTION);
 glPushMatrix();             
 glLoadIdentity();           
 glOrtho(-0.5,0.5,-0.4,0.4,1.0,0);

 glMatrixMode(GL_MODELVIEW);
 glPushMatrix();
 glLoadIdentity();
 glTranslated(posx, posy - 0.03 * (1.0 - scale) + 0.012, -1.0) ;

 angle = sqrt( k[WHITE].e.x*90.0*k[WHITE].e.x*90.0 + 
	       k[WHITE].e.y*90.0*k[WHITE].e.y*90.0 + 
	       k[WHITE].e.z*90.0*k[WHITE].e.z*90.0 );
 glRotated(angle, k[WHITE].e.y, k[WHITE].e.z, k[WHITE].e.x  );

 glMultMatrixd(k[WHITE].mrot);

 glEnable(GL_TEXTURE_2D);
 glBindTexture(GL_TEXTURE_2D, texture[0]); /* Weiﬂe Kugel */
 if( scale <= 0.1 ) icosphere(ico320, 320, rad_outer*scale);
 else icosphere(ico5120, 5120, rad_outer*scale);

 glDisable(GL_TEXTURE_2D);

 glMatrixMode(GL_PROJECTION);
 glPopMatrix();
 glMatrixMode(GL_MODELVIEW);
 glPopMatrix();
 
 glEnable(GL_DEPTH_TEST);
 glDisable(GL_LIGHT3);
 glEnable(GL_LIGHT1);
 glEnable(GL_LIGHT2);
 glDisable(GL_BLEND);
 glEnable(GL_FOG);
 } 

void test_spin( void ) 
 { /* Mouse-Abfrage f¸r das Setzen des lokalen Spins... */
 int oldx, oldy, i, ende=0;
 Uint8 *keys;
 double sz, sp, dummy;
 struct timeval tp_start,tp_cur;
 double time_cur, time_start;
 SDL_GetMouseState(&oldx, &oldy); 
 for( i=10;i>=1;i-- )
  {
  gettimeofday(&tp_start,NULL);
  time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
  glFogf(GL_FOG_DENSITY, 1.0-i/(100.0/5.0));
  gl_plotall(-1);
  paint_spin( 1.0/(double)i, 0.5 - 0.5 / (double)i, 0.4 - 0.4/(double)i );
  speed(spd, 1.0/10.0, 0.09, 0.36);
  glPrintCentered(0.85*768,  "set spin", 0, 1.0, 1.0, 1.0, 1.0,4.0);
  msg("move mouse to change spin. release middle button to leave...");
  SDL_GL_SwapBuffers();
  gettimeofday(&tp_cur,NULL);
  time_cur = tp_cur.tv_sec * 1000000 + tp_cur.tv_usec;
  if( time_cur - time_start < 10000 ) SDL_Delay(10+(time_cur - time_start)/1000);
  }
 keys=SDL_GetKeyState(NULL);
 if( SDL_GetMouseState(&oldx, &oldy) & SDL_BUTTON(2) || keys[SDLK_e] ) 
  {
  do
   {
   do
    {
    while( SDL_PollEvent(&event) );
    SDL_WaitEvent(&event);
    }
   while( event.type != SDL_MOUSEMOTION && event.type != SDL_KEYUP &&
	  (event.type != SDL_MOUSEBUTTONUP) && 
	  (event.type != SDL_MOUSEBUTTONDOWN) );
   keys=SDL_GetKeyState(NULL);
   if( event.type == SDL_MOUSEMOTION )
    {
    /* sollte vielleicht umgerechnet werden in einen Winkel !!! !!! !!! ??? */
    sz = (event.motion.x - oldx)/50.0; 
    sp = (event.motion.y - oldy)/50.0;
    SDL_WarpMouse( oldx, oldy );
    dummy = sqrt( (k[WHITE].e.y+sp)*(k[WHITE].e.y+sp) + (k[WHITE].e.z+sz)*(k[WHITE].e.z+sz) );
    if( dummy < 1.0 ) dummy = 1.0;
    k[WHITE].e.x = 0.0;                        /* wird in translate_spin() entsprechend der Zielrichtung angepasst */
    k[WHITE].e.y = (k[WHITE].e.y+sp) / dummy; 
    k[WHITE].e.z = (k[WHITE].e.z+sz) / dummy; 
    gl_plotall(-1);
    paint_spin( 1.0, 0.0, 0.0 );
    speed(spd, 1.0/10.0, 0.09, 0.36);
    glPrintCentered(0.85*768,  "set spin", 0, 1.0, 1.0, 1.0, 1.0,4.0);
    msg("move mouse to change spin. release middle button to leave...");
    SDL_GL_SwapBuffers();
    }
   else {mmouse=1;}
   if( !(SDL_GetMouseState(NULL,NULL) & SDL_BUTTON(2)) && !keys[SDLK_e] ) ende = 1;
   }
  while( !ende && !(event.type == SDL_KEYDOWN) && 
	 !((event.button.button == SDL_BUTTON_MIDDLE) && 
	   (event.type == SDL_MOUSEBUTTONUP)) && 
	 !(mmouse && ((event.type == SDL_MOUSEBUTTONDOWN) || 
		      (event.type == SDL_MOUSEBUTTONUP))) );
  }
 for( i=1;i<=10;i++ )
  {
  gettimeofday(&tp_start,NULL);
  time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
  gl_plotall(-1);
  paint_spin( 1.0/(double)i, 0.5 - 0.5 / (double)i, 0.4 - 0.4/(double)i );
  speed(spd, 1.0/10.0, 0.09, 0.36);
  msg(current_message);
  msg2(current_message2);
  glFogf(GL_FOG_DENSITY, 1.0-i/20.0);
  SDL_GL_SwapBuffers();
  gettimeofday(&tp_cur,NULL);
  time_cur = tp_cur.tv_sec * 1000000 + tp_cur.tv_usec;
  if( time_cur - time_start < 10000 ) SDL_Delay(10+(time_cur - time_start)/1000);
  }
 glFogf(GL_FOG_DENSITY, 0.5);
 PAINT_ALL;
 mmouse = 0;
 }

void wait_for_click( void )
 /* wartet auf Mouse-Click oder Tasten-Druck */
 {
 SDL_Event event;
 do
  { SDL_WaitEvent(&event); }
 while( ( event.type != SDL_KEYDOWN) && (event.type != SDL_MOUSEBUTTONUP) && 
	(event.type != SDL_QUIT) );
 if( (event.type == SDL_KEYDOWN) || (event.type == SDL_QUIT) ) 
  {
  Uint8 *keystate = SDL_GetKeyState(NULL);
  if( (keystate[SDLK_ESCAPE]) || (event.type == SDL_QUIT) ) stop_it();
  }
 }

void wait_for_click_up( void )
 /* wartet auf Mouse-Click oder Tasten-Druck */
 {
 SDL_Event event;
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

void wink( double a ) /* Winkel zwischen Queue und Tisch darstellen */
 {  /* Kˆnnte mal einen dickeren Queue bekommen !!! !!! !!!*/
 /*  double b = a*M_PI/180.0; */
 /*  int posx = 0.5, posy=0.3; */
 /*  GrCircleArc(posx, posy, 6*PIXELRADIUS+1, 270, 362, GR_ARC_STYLE_OPEN, 9); */
 /*  GrFilledCircleArc(posx, posy, 6*PIXELRADIUS, 270, 362,  */
 /* 		   GR_ARC_STYLE_CLOSE2, COL_WHITE); */
 /*  GrFilledCircle(posx+6.5*PIXELRADIUS*cos(oldalph), posy-6.5*PIXELRADIUS*sin(oldalph), */
 /* 		PIXELRADIUS/2,0); */
 /*  GrFilledCircle(posx+6.5*PIXELRADIUS*cos(b), posy-6.5*PIXELRADIUS*sin(oldalph=b), */
 /* 		PIXELRADIUS/2,16); */
 /*  SDL_UpdateRect(display,posx-1-PIXELRADIUS,posy-7.5*(PIXELRADIUS+1)-1, */
 /* 		12*(PIXELRADIUS+2)+2,7.5*(PIXELRADIUS+2)+2); */
 }

void err( char *out )
 { /* Ausgabe der normalen Texte w‰hrend des Spiels */
 glPrintCentered(768/2,out,0,1.0,0.5,0.5,1.0,1.45);
 SDL_GL_SwapBuffers();
 }

void err2( char *out, char *out2 )
 { /* Ausgabe von z.B. Free- oder Extra-Ball ... */
 strcpy(err2_msg1, out);
 strcpy(err2_msg2, out2);
 err2_endtime = timer() + 3000; /* Nachricht wird 2 Sekunden lang angezeigt */
 }

void foul( char *out, int time )
 { /* Ausgabe von z.B. Free- oder Extra-Ball ... */
 strcpy(foul_msg, out);
 foul_endtime = timer() + time; /* Nachricht wird time/1000 Sekunden lang angezeigt */
 }

void debug( char *out )
 { /* Ausgabe der Kommentare beim Computer-Spieler */
 /*  char o[80]; */
 /*  sprintf(o,"%s",out); */
 /*  GrDrawString(out, strlen(out), 0, 35, TEXTCOL ); */
 /*  SDL_Flip(display); */
 }
 
void mouse_on( void )
 { SDL_ShowCursor(1); }

void mouse_off( void )
 { SDL_ShowCursor(0); }

void set_white_ball( void )
 { /* Weiﬂe Kugel am Anfang oder nach Foul neu positionieren */
 int i, j, okx,oky;
 double old, old2, motionx,motiony, dummy; 
 int mousex, mousey;
 struct vect v;
 k[WHITE].p.z = RADIUS;
 k[WHITE].v.z = 0.0;
 k[WHITE].p.x = k[WHITE].p.y = 0.10;
 k[WHITE].stat = (ONTABLE|MOVING);
 if( (c_player == -1) || (cur != c_player ) )
  {
  k[WHITE].e.x = k[WHITE].e.y = k[WHITE].e.z = 0.0;
  old2 = 0.25;
  i = 225;
  do
   {
   old = ((double)i) / 1000.0;
   okx = 1;
   for(j=0;j<BALLS;j++) /* Suche nach freiem Platz auf dem Tisch */
    if( DIFF2( old-k[j].p.x, old2-k[j].p.y ) < 5.0*PIXELRADIUS*PIXELRADIUS )
     {okx=0; break;}
   }
  while( !okx && (--i>50) );
  k[WHITE].p.x = old; k[WHITE].p.y = old2;
  gl_move_table(0.0f,0.0f,0.0f, 0.0f,0.0f,-0.985f, new_game ? 15.0 : 25.0f, 0, 0, 0);
  do
   {
   gl_plotall(-1);
   msg("move mouse to change the position of the cue-ball");
   msg2("press left mouse button to set the position of the cue ball");
   SDL_GL_SwapBuffers();
   while( SDL_PollEvent(&event) );
   SDL_WaitEvent( &event);
   okx=oky=1;
   if( event.type == SDL_MOUSEMOTION )
    {
    SDL_GetMouseState(&mousex, &mousey);
    /*     SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2 ); */
    motionx = (double)(mousex-SCREENRESX/2) / (double)SCREENRESX;
    motiony = (double)(mousey-SCREENRESY/2) / (double)SCREENRESX;
    k[WHITE].p.x += motionx * cos(angz * M_PI/180.0) - motiony * sin(angz * M_PI/180.0);
    k[WHITE].p.y -= motionx * sin(angz * M_PI/180.0) + motiony * cos(angz * M_PI/180.0);
    for(i=0;i<BALLS-1;i++)
     {
     if( ABST(k[i].p,k[WHITE].p) < RADIUS*RADIUS*4.0 ) 
      {
      v.x = k[i].p.x - k[WHITE].p.x;
      v.y = k[i].p.y - k[WHITE].p.y;
      dummy = BETR(v);
      v.x /= dummy;
      v.y /= dummy;
      k[WHITE].p.y = k[i].p.y - 2*RADIUS * v.y;
      k[WHITE].p.y = k[i].p.y - 2*RADIUS * v.y;
      }
     }
    if( k[WHITE].p.x > 0.25 ) k[WHITE].p.x = 0.25;
    if( k[WHITE].p.y > 0.5 - RADIUS ) k[WHITE].p.y = 0.5-RADIUS;
    if( k[WHITE].p.x < RADIUS ) k[WHITE].p.x = RADIUS;
    if( k[WHITE].p.y < RADIUS ) k[WHITE].p.y = RADIUS;
    SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2 );
    }
   }
  while( event.type != SDL_MOUSEBUTTONUP && event.type != SDL_KEYDOWN && event.type != SDL_QUIT );
  if( (event.type == SDL_KEYDOWN) || (event.type == SDL_QUIT) ) 
   {
   Uint8 *keystate = SDL_GetKeyState(NULL);
   if( (keystate[SDLK_ESCAPE]) || (event.type == SDL_QUIT) ) stop_it();
   }
  }
 else /* !!! !!! !!! !!! !!! !!! VERBESSERN! */
  {
  /* Computer kann Weiﬂe legen ... */
  k[WHITE].e.x = k[WHITE].e.y = k[WHITE].e.z = 0.0;
  old2 = 0.25;
  i = 250;
  do
   {
   old = ((double)i) / 1000.0;
   okx = 1;
   for(j=0;j<WHITE;j++) /* Suche nach freiem Platz auf dem Tisch */
    if( DIFF2( old-k[j].p.x, old2-k[j].p.y ) < 5.0*PIXELRADIUS*PIXELRADIUS )
     {okx=0; break;}
   }
  while( !okx && (--i>50) );
  k[WHITE].p.x = old; k[WHITE].p.y = old2;
  gl_plotall(1);
  }
 new_game = 0;
 }

void calc_player_v( void )
 {
 struct vect3 v;
 double dummy;
 v.x = target.x - k[WHITE].p.x;
 v.y = target.y - k[WHITE].p.y;
 if( fabs(v.x) > 1e-10 || fabs(v.y) > 1e-10 )
  {
  v.x /= (dummy = sqrt(v.x*v.x+v.y*v.y));
  v.y /= dummy;
  }
 k[WHITE].e.x *= spd; 
 k[WHITE].e.y *= spd;
 k[WHITE].e.z  *= 1.0; /* *spd!!! ??*/
 k[WHITE].v.x = spd * SPEED_FACTOR * v.x / DIFFX;
 k[WHITE].v.y = spd * SPEED_FACTOR * v.y / DIFFX;
 }

void set_player_power( void )
 {
 int oldx, oldy, i, ende = 0;
 struct timeval tp_start,tp_cur;
 double time_cur, time_start;
 for( i=10;i>0;i-- )
 {
  gettimeofday(&tp_start,NULL);
  time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
  glFogf(GL_FOG_DENSITY, 1.0-i/(100.0/5.0));
  gl_plotall(-1);
  paint_spin( 1.0/10.0, 0.45, 0.36 );
  speed(spd, 1.0/(double)i, 0.1 - 0.1/(double)i, 0.4 - 0.4/(double)i );
  glPrintCentered(0.6*768,  "set speed", 0, 1.0, 1.0, 1.0, 1.0,4.0);
  msg("move mouse to change initial speed, release button to leave...");
  SDL_GL_SwapBuffers();
  gettimeofday(&tp_cur,NULL);
  time_cur = tp_cur.tv_sec * 1000000 + tp_cur.tv_usec;
  if( time_cur - time_start < 10000 ) SDL_Delay(10+(time_cur - time_start)/1000);
  }
 if( SDL_GetMouseState(&oldx, &oldy) & SDL_BUTTON(3) ) 
  {
  do
   {
   while( SDL_PollEvent(&event) );
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
     gl_plotall(-1);
     paint_spin( 1.0/10.0, 0.45, 0.36 );
     speed(spd, 1.0, 0.0, 0.0 );
     glPrintCentered(0.6*768,  "set speed", 0, 1.0, 1.0, 1.0, 1.0,4.0);
     msg("move mouse to change initial speed, release button to leave...");
     SDL_GL_SwapBuffers();
     }
    }
   if( !(SDL_GetMouseState(NULL,NULL) & SDL_BUTTON(3)) ) ende = 1;
   }
  while( !ende && (event.type != SDL_MOUSEBUTTONUP) );
  }
 for( i=1;i<=10;i++ )
  {
  gettimeofday(&tp_start,NULL);
  time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
  glFogf(GL_FOG_DENSITY, 1.0-i/(100.0/5.0));
  gl_plotall(-1);
  paint_spin( 1.0/10.0, 0.45, 0.36 );
  speed(spd, 1.0/(double)i, 0.1 - 0.1/(double)i, 0.4 - 0.4/(double)i );
  msg(current_message);
  msg2(current_message2);
  SDL_GL_SwapBuffers();
  gettimeofday(&tp_cur,NULL);
  time_cur = tp_cur.tv_sec * 1000000 + tp_cur.tv_usec;
  if( time_cur - time_start < 10000 ) SDL_Delay(10+(time_cur - time_start)/1000);
  }
 glFogf(GL_FOG_DENSITY, 0.5);
 PAINT_ALL;
 }

void set_player_spin( void )
 {
 int oldx, oldy; 
 msg("move mouse to change spin, press right button to change angle");
 test_spin(); 
 SDL_GetMouseState(&oldx, &oldy); 
 return;
 if( (event.type == SDL_MOUSEBUTTONDOWN) &&
     ((event.button.button == SDL_BUTTON_MIDDLE) ||
      (event.button.button == SDL_BUTTON_RIGHT))) 
  {
  msg("move mouse to change angle between queue an table");
  do
   {
   while( SDL_PollEvent(&event) );
   SDL_WaitEvent( &event );
   if( event.type == GR_M_MOTION )
    {
    if( (oldx-event.motion.x) || (oldy-event.motion.y) )
     {    
     alph += 0.1 * (oldx - event.motion.x + oldy - event.motion.y);
     SDL_WarpMouse( oldx, oldy );
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
 MSG2;
 }

void set_test_power( void )
 { /* Test-Prozedur, berechnet Geschw., die die Weisse haben muﬂ, um zur akt.
      Maus-Position zu rollen */
 struct vect3 v;
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
 struct vect3 v1, v2, v3, v4;
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

void gl_plot_target( void )
 {
 float MatDif[] = {0.5f, 0.5f, 1.0f, 0.3f};
 float MatAmb[] = {0.1f, 0.1f, 0.4f, 0.1f};
 float MatSpc[] = {0.0f, 0.0f, 0.5f, 1.0f};
 float MatEm[] = {0.9f, 0.0f, 0.9f, 0.5f};
 float MatZero[] = {0.0f, 0.0f, 0.0f, 0.0f};
 GLfloat LightEmission[] = { 1.0f, 0.5f, 1.0f, 1.0f };

 glPushMatrix();
 glLightfv(GL_LIGHT1, GL_EMISSION, LightEmission);
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDif);
 glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmb);
 glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc);
 glMaterialfv(GL_FRONT, GL_EMISSION, MatEm);

 glTranslatef((double)target.x-0.5f, (double)target.y-0.25f, RADIUS);
                    
 glEnable(GL_BLEND);
 glColor4d(0.2,0.2,1.0,0.3);

 icosphere(ico320, 320, RADIUS);
 glDisable(GL_BLEND);

 glMaterialfv(GL_FRONT, GL_EMISSION, MatZero);
 glLightfv(GL_LIGHT1, GL_EMISSION, MatZero);
 glPopMatrix();
 }

void newstartpos(  double sx, double sy , double sz, int key, int invoke, int button )
 {
 Uint8 *keys;
 int ende=0;
 do
  {
  startx += sx;
  starty += sy;
  startz += sz;
  gl_plotall(-1);
  gl_plot_target();
  SDL_GL_SwapBuffers();
  SDL_Delay(20);
  SDL_PollEvent(NULL);
  keys = SDL_GetKeyState(NULL);
  if( keys[key] != SDL_PRESSED && invoke == 2 ) ende = 1;
  if( !(SDL_GetMouseState(NULL,NULL) & SDL_BUTTON(button)) && invoke == 1 ) ende = 1;
  }
 while( !ende );
 }

void newtranspos(  double sx, double sy , double sz, int key, int invoke )
 {
 Uint8 *keys;
 int ende=0;
 do
  {
  transx += sx;
  transy += sy;
  transz += sz;
  gl_plotall(1);
  SDL_Delay(20);
  SDL_PollEvent(NULL);
  keys = SDL_GetKeyState(NULL);
  if( keys[key] != SDL_PRESSED && invoke == 2 ) ende = 1;
  if( !(SDL_GetMouseState(NULL,NULL) & SDL_BUTTON(1)) && invoke == 1 ) ende = 1;
  }
 while( !ende );
 }

void special_target_mode(void)
 {
 struct vect v,p;
 v.x = target.x - k[WHITE].p.x;
 v.y = target.y - k[WHITE].p.y;
 p.x = 1.0;
 p.y = 0.0;
 newstartx = 0.0;
 newstarty = 0.0;
 newstartz = -0.2;
 newangz = 90.0 + (v.y < 0 ? 1 : -1) * 180.0/M_PI * acos(COSV(p,v));
 newangx = -70.0;
 newangy = 0.0;
 newtransx = -(k[WHITE].p.x-0.5); 
 newtransy = -(k[WHITE].p.y-0.25);
 newtransz = -6*RADIUS; 
 }

/* berechnet den Schwerpunkt der Kugeln, die der aktuelle Spieler
   zu spielen hat und setzt den Target-Ball dorthin, ¸berpr¸ft
   daraufhin, ob dort Platz ist und verschiebt den Target Ball 
   so lange bis es "passt" oder eine gewisse Anzahl vo
   Verschiebungszyklen abgelaufen ist */
void calc_target_pos(int cur)
 {
 int i, count=0, ok;
 double dummy;
 struct vect a;
 target.x = 0;
 target.y = 0;
   
 switch( ply[cur].col )
  {
  case COL_BLACK:
   target.x = k[BLACK].p.x;
   target.y = k[BLACK].p.y;
   break;
  case COL_RED:
   for(i=0;i<BALLS;i++)
    {
    if( (k[i].stat & ONTABLE) && (k[i].col == COL_RED) )
     {
     count ++;
     target.x += k[i].p.x;
     target.y += k[i].p.y;
     }
    }
   target.x /= count;
   target.y /= count;
   break;
  case COL_YELLOW:
   for(i=0;i<BALLS;i++)
    {
    if( (k[i].stat & ONTABLE) && (k[i].col == COL_YELLOW) )
     {
     count ++;
     target.x += k[i].p.x;
     target.y += k[i].p.y;
     }
    }
   target.x /= count;
   target.y /= count;
   break;
  default:
   for(i=0;i<BALLS;i++)
    {
    if( k[i].stat & ONTABLE )
     {
     count ++;
     target.x += k[i].p.x;
     target.y += k[i].p.y;
     }
    }
   target.x /= (double)(count-1);
   target.y /= (double)(count-1);
   break;
  }

 do
  {
  ok=1;
  for(i=0;i<=BALLS;i++)
   {
   a.x = k[i].p.x - target.x;
   a.y = k[i].p.y - target.y;
   if( SKALP(a,a) < 4.0*RADIUS*RADIUS )
    { 
    a.x = k[WHITE].p.x - target.x;
    a.y = k[WHITE].p.y - target.y;
    dummy = BETR(a);
    a.x /= dummy;
    a.y /= dummy;
    target.x += a.x * 2.0*RADIUS;
    target.y += a.y * 2.0*RADIUS;
    ok=0; break;
    }
   }
  }
 while( !ok && ++counter < 30 );
 }

int menu( void ) 
 { 
 int i, ok=0, ret_wert=0;
 double motionx, motiony, dummy;
 int mousex, mousey;
 char out[255], out2[128];
 struct vect v;
 gamemode &= (0xffff ^ PLAY_MODE); /* ungeschickt, eigentlich sowas wie MAXINT */
 gamemode &= (0xffff ^ FREELOOK_MODE); /* ungeschickt, eigentlich sowas wie MAXINT */
 wink( alph = 0.0 );
 for( i=0;i<BALLS;i++) /* alle Kugeln neu initialisieren */
  {  
  k[i].v.x = k[i].v.y = 0;
  k[i].e.x = k[i].e.y = k[i].e.z = 0.0; 
  }
 clear_rotation_matrix(WHITE); /* damit der SPIN-BALL rechts oben nicht verdreht ist... */
/*  k[WHITE].rot.x = 0 -0*angx; */
/*  k[WHITE].rot.y = -90.0+0*angy; */
/*  k[WHITE].rot.z = 0 +angz; */
 k[WHITE].stat ^= GL_LISTED_NOT_MOVING; /* damit der Treffpunkt des Queues neu gemalt wird... */
/*  calc_rotation_inkl_z(WHITE); */

 if( new_game ) title_screen();
 if( k[WHITE].stat & DELETED ) set_white_ball(); /* Weiﬂe neu setzen */
 if( cur == c_player ) { computer_stoss(); return ret_wert; }
 ok = 0;
 MSG2;
 if( simulation_flag ) {target.x = undo_target.x; target.y = undo_target.y;}
 else calc_target_pos(cur);
 simulation_flag=0;

 if( gamemode == TARGET_MODE ) 
  gl_move_table(0.0f,0.0f,0.0f, 0.0f,0.0f,-0.985f, 10.0f, 0,0,0);
 else if( gamemode == SPECIAL_TARGET_MODE ) 
  {
  special_target_mode();
  gl_move_table(newangx,newangy,newangz,newstartx,newstarty,newstartz, 20.0f, newtransx, newtransy, newtransz);
  }

 PAINT_ALL;
 mouse_off();
 SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2 );
 do
  {
  do 
   { 
   while( SDL_PollEvent(&event) ); /* versteht kein Mensch... */
   SDL_WaitEvent(&event); 
   }
  while( !( (event.type == SDL_KEYDOWN)       || (event.type == SDL_MOUSEBUTTONDOWN) ||
	    (event.type == SDL_MOUSEBUTTONUP) || (event.type == SDL_QUIT)          ||
	    (event.type == SDL_MOUSEMOTION)   || (event.type == SDL_SYSWMEVENT)  ||
	    (event.type == 1) || (event.type == 17) ) );
  switch( event.type )
   {
   case 1: case 17: PAINT_ALL; break; /* Window-Refresh nˆtig */
   case SDL_MOUSEMOTION:
    {
    if( !(gamemode & FREELOOK_MODE) )
     {
     SDL_GetMouseState(&mousex, &mousey);
     SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2 );
     motionx = (double)(mousex-SCREENRESX/2) / (double)SCREENRESX;
     motiony = (double)(mousey-SCREENRESY/2) / (double)SCREENRESX;
     target.x += motionx * cos(angz * M_PI/180.0) -motiony * sin(angz * M_PI/180.0);
     target.y -= motionx * sin(angz * M_PI/180.0) + motiony * cos(angz * M_PI/180.0);
     for(i=0;i<BALLS;i++)
      {
      if( ABST(k[i].p,target) < RADIUS*RADIUS*4.0 )  /* funktioniert meistens, sieht ganz lustig aus ;-) */
       {
       v.x = k[i].p.x - target.x;
       v.y = k[i].p.y - target.y;
       dummy = BETR(v);
       v.x /= dummy;
       v.y /= dummy;
       target.x = k[i].p.x - 2*RADIUS * v.x;
       target.y = k[i].p.y - 2*RADIUS * v.y;
       }
      }
     if( target.x > 1.0 - RADIUS ) target.x = 1.0-RADIUS;
     if( target.y > 0.5 - RADIUS ) target.y = 0.5-RADIUS;
     if( target.x < RADIUS ) target.x = RADIUS;
     if( target.y < RADIUS ) target.y = RADIUS;
     /* Abfrage, ob target zu nahe an Kugel ist noch machen... */
     SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2 );
     if( gamemode & SPECIAL_TARGET_MODE ) 
      {
      special_target_mode();
      startx = newstartx;
      starty = newstarty;
      startz = newstartz;
      angx = newangx;
      angy = newangy;
      angz = newangz;
      transx = newtransx;
      transy = newtransy;
      transz = newtransz;
      }
     PAINT_ALL;
     }
    else if( gamemode & FREELOOK_MODE )
     {
     angz+=(double)event.motion.xrel;
     angx+=(double)event.motion.yrel;
     SDL_WarpMouse(SCREENRESX/2, SCREENRESY/2);
     PAINT_ALL;
     break;
     }
    }
    break; /* ‰uﬂeres switch, Ende von event.type == MOUSE_MOTION */
   case SDL_QUIT: ok = ret_wert = 1; stop_it(); break;
   case SDL_MOUSEBUTTONDOWN: case SDL_MOUSEBUTTONUP:
    {
    switch(event.button.button)
     {
     case SDL_BUTTON_LEFT: /* Stoﬂ: Geschw. berechnen */
      switch(gamemode)
       {
       case FREELOOK_MODE: /* erstmal ;-) */
       case SPECIAL_TARGET_MODE:
       case TARGET_MODE:   
	if( event.type == SDL_MOUSEBUTTONUP )   { calc_player_v(); ok = 1; gamemode |= PLAY_MODE; }
	else ok=0;
	break;
       }
      break;
     case SDL_BUTTON_RIGHT:  /* Geschwindigkeits (Power)-Faktor verstellen */
      if( event.type == SDL_MOUSEBUTTONDOWN ) set_player_power(); 
      break;
     case SDL_BUTTON_MIDDLE: /* Spin einstellen */
      if( event.type == SDL_MOUSEBUTTONDOWN ) set_player_spin(); break;
     case 4: alph = ((alph+=0.5) > 90 ? 90 : alph); wink( alph ); break;
     case 5: alph = ((alph-=0.5) < 0 ? 0 : alph); wink( alph ); break;
     }
    }
    break;
   case SDL_KEYDOWN:
    {
    switch( event.key.keysym.sym )
     {
     case SDLK_SPACE: 
      gamemode ^= FREELOOK_MODE;
      if( gamemode & FREELOOK_MODE )
       {
       sprintf(current_message, "free look mode - move mouse to change view, ...");
       sprintf(current_message2,"F1: help; press SPACE to return to target mode, ...");
       }
      else if( gamemode & TARGET_MODE )
       {
       sprintf(current_message, "target mode - move mouse to change the position of the target ball");
       sprintf(current_message2,"F1: help; left button: cue, right button speed, ...");
       }
      else if( gamemode & SPECIAL_TARGET_MODE )
       {
       sprintf(current_message, "special target mode; press w to toggle normal mode");
       sprintf(current_message2,"F1: help; left button: cue, right button speed, ...");
       }
      PAINT_ALL;
      break;
     case SDLK_F9:
      ball_env_map++;
      if( ball_env_map > 2 ) ball_env_map = 0;
      gl_init_lists();
      PAINT_ALL;
      switch(ball_env_map)
       {
       case 0:  sprintf(out2,"off"); break;
       case 1:  sprintf(out2,"cube"); break;
       case 2:  sprintf(out2,"sphere"); break;
       }
      sprintf(out,"ball environment mapping is set to %s\n",out2);
      err(out);
      SDL_GL_SwapBuffers();
      break;
     case SDLK_F8:
      env_map = 1 - env_map;
      gl_init_lists();
      PAINT_ALL;
      sprintf(out,"environment mapping is set to %s\n",env_map == 0 ? "off" : "on");
      err(out);
      SDL_GL_SwapBuffers();
      break;
     case SDLK_F7:
      if( ++txt_detail > TEXTURE_HIGH ) txt_detail = TEXTURE_LOW;
      switch(txt_detail)
       {
       case TEXTURE_LOW:      sprintf(out2,"low"); break;
       case TEXTURE_HIGH:     sprintf(out2,"high"); break;
       }
      gl_init_lists();
      PAINT_ALL;
      sprintf(out,"texture detail level is set to %s\n",out2);
      err(out);
      SDL_GL_SwapBuffers();
      break;
     case SDLK_F6: 
      if( (++shadows) > 3 ) shadows = 0; 
      gl_init_lists();
      PAINT_ALL; 
      switch(shadows)
       {
       case 0: sprintf(out2,"off"); break;
       case 1: sprintf(out2,"planar"); break;
       case 2: sprintf(out2,"stencil (alpha)"); break;
       case 3: sprintf(out2,"stencil (multi)"); break;
       }
      sprintf(out,"shadows set to %s\n",out2);
      err(out);
      SDL_GL_SwapBuffers(); 
      break;
     case SDLK_F5: 
      if( ++geo_detail > DETAIL_VERYHIGH ) geo_detail = DETAIL_VERYLOW;
      switch(geo_detail)
       {
       case DETAIL_VERYLOW:  sprintf(out2,"very low");  txt_detail = TEXTURE_LOW;  break;
       case DETAIL_LOW:      sprintf(out2,"low");       txt_detail = TEXTURE_LOW;  break;
       case DETAIL_MED:      sprintf(out2,"medium");    txt_detail = TEXTURE_LOW;  break;
       case DETAIL_HIGH:     sprintf(out2,"high");      txt_detail = TEXTURE_HIGH; break;
       case DETAIL_VERYHIGH: sprintf(out2,"very high"); txt_detail = TEXTURE_HIGH; break;
       }
      gl_init_lists();
      PAINT_ALL;
      sprintf(out,"geometric detail level is set to %s\n",out2);
      err(out);
      SDL_GL_SwapBuffers();
      break;
     case SDLK_F3: 
      display_floor_textures ^= 1;
      gl_init_lists();
      PAINT_ALL;
      sprintf(out,"display of floor texture is set to %s\n",display_floor_textures ? "on" : "off");
      err(out);
      SDL_GL_SwapBuffers();
      break;
     case SDLK_F4: 
      display_textures ^= 1;
      gl_init_lists();
      PAINT_ALL;
      sprintf(out,"display textures is set to %s\n",display_textures ? "on" : "off");
      err(out);
      SDL_GL_SwapBuffers();
      break;
     case SDLK_h:
      calc_player_v(); 
      ok = 1; 
      simulation_flag=1;
      gamemode |= (SIMULATION_MODE|PLAY_MODE);
      break;
     case SDLK_t: 
      gl_move_table(0.0,0.0,0.0, 0.0,0.0,-0.985, 50.0, 0, 0, 0);
      break;
     case SDLK_s: 
      gl_move_table(-55.0,0.0,-90.0, 0.0,0.1,-0.9, 50.0, 0, 0, 0);
      break;
     case SDLK_l: 
      gl_move_table(oldang.x,oldang.y,oldang.z, oldstart.x,oldstart.y,oldstart.z, 50.0f, 
		    oldtrans.x, oldtrans.y, oldtrans.z);
      break;
     case SDLK_KP2:     newtranspos(  0.0,  0.003, 0.0, SDLK_KP2, 2); break;
     case SDLK_KP8:     newtranspos(  0.0, -0.003, 0.0, SDLK_KP8, 2); break;
     case SDLK_KP6:     newtranspos( -0.003,  0.0,  0.0, SDLK_KP6, 2); break;
     case SDLK_KP4:     newtranspos(  0.003,  0.0,  0.0, SDLK_KP4, 2); break;
     case SDLK_w:     
      gamemode = (gamemode == TARGET_MODE) ? SPECIAL_TARGET_MODE : TARGET_MODE;
      if( gamemode == SPECIAL_TARGET_MODE ) 
       {
       sprintf(current_message, "special target mode; press w to toggle normal mode");
       special_target_mode();
       gl_move_table(newangx, newangy, newangz, newstartx, newstarty, newstartz, 50.0, 
		     newtransx, newtransy, newtransz);
       PAINT_ALL;
       }
      else if( gamemode == TARGET_MODE )
       {
       sprintf(current_message, "target mode - move mouse to change the position of the target ball");
       gl_move_table(0.0,0.0,0.0, 0.0,0.0,-0.985, 50.0, 0,0,0);
       PAINT_ALL;
       }
      break;
     case SDLK_DOWN:     newstartpos(  0.0,  0.003, 0.0, SDLK_DOWN, 2, -1); break;
     case SDLK_UP:       newstartpos(  0.0, -0.003, 0.0, SDLK_UP, 2, -1); break;
     case SDLK_RIGHT:    newstartpos( -0.003,  0.0,  0.0, SDLK_RIGHT, 2, -1); break;
     case SDLK_LEFT:     newstartpos(  0.003,  0.0,  0.0, SDLK_LEFT, 2, -1); break;
     case SDLK_PAGEUP:   newstartpos(  0.0,  0.0,  0.005, SDLK_PAGEUP, 2, -1); break;
     case SDLK_PAGEDOWN: newstartpos(  0.0,  0.0, -0.005, SDLK_PAGEDOWN, 2, -1); break;
     case SDLK_ESCAPE: ok = ret_wert = 1; break;
     case SDLK_n:		/* new game */
      mouse_off();
      ply[1-cur].points += 1;
      stats[cur].losses += 1;
      cur = 1 - cur;
      delete_ball(WHITE, -1);
      init_table(); 
      ok = 1; 
      break;
     case SDLK_u:		/* undo last shot */
      undo(); 
      debug("undo..."); 
      PAINT_ALL;
      break;
     case SDLK_d: 
      demo = 1; 
      msg("press space or mouse button to stop demo");
      c_player = cur;
      last_gamemode = gamemode;
      gamemode = TARGET_MODE;
      gl_move_table(0.0,0.0,0.0, 0.0,0.0,-0.985, 50.0, 0,0,0);
      computer_stoss();
      ok = 1;
      break;
     case SDLK_y: gl_plotall(1); /* to make nicer screenshots ;-) */
      break;
     case SDLK_c:		/* computer plays every shot*/
      if( c_player == -1 ) 
       {
       c_player = cur; 
       last_gamemode = gamemode;
       gamemode = TARGET_MODE;
       gl_move_table(0.0,0.0,0.0, 0.0,0.0,-0.985, 50.0, 0,0,0);
       }
      else { c_player = -1; break; }
     case SDLK_x:		/* let computer play one shot */
      computer_stoss();
      ok = 1;
      break;
     case SDLK_F11: if( ++table_color > 2 ) table_color = 0;
      gl_init_lists();
      PAINT_ALL;
      break;
     case SDLK_F12: plot_statistics( 0, 1 ); break;
     case SDLK_F1: help(); break;			/* F1 */
     case SDLK_F2: credits(); break;		/* F2 */
     case SDLK_f: showfps = 1-showfps; break;
     case SDLK_p: /* put away every ball except of white and eight ball ;-) */
      for( i=BLACK+1;i<WHITE;i++ ) delete_ball( i, -1 );
      for( i=0;i<BLACK;i++ ) delete_ball( i, -1 ); 
      break;
     case SDLK_e: mmouse = 1; 
      test_spin(); 
      break;
     case SDLK_PLUS: alph = ((alph+=1) > 90 ? 90 : alph); wink( alph ); break;
     case SDLK_MINUS: alph = ((alph-=1) < 0 ? 0 : alph); wink( alph ); break;
     default: {}
     }
    }
   default:  break; 
   } 
  }
 while( !ok );
 if( !ret_wert && !(gamemode & SIMULATION_MODE) ) 
  {
  if( !( gamemode & SPECIAL_TARGET_MODE) ) gl_move_table(-55.0,0.0,-90.0, 0.0,0.1,-0.9, 10.0, 0, 0, 0);
  else gl_move_table(angx,angy,angz,startx,starty,startz*3.0,10.0,transx,transy,transz);
  }
 mouse_off();
 return ret_wert;
 }
  
void delete_ball( int n, int pocket )
 /* Kugel "n" f‰llt in Tasche und wird gelˆscht; auﬂerdem wird gepr¸ft, ob
    ein Foul durch das Versenken begangen wurde... Hatte der Spieler vor dem
    Versenken noch keine Farbe (Anfang des Spiels) so bekommt er hier diese */
 {
 k[n].stat = FALLING;
 k[n].v.z = 0.0;
 if( pocket >= 0 ) k[n].pocket = pocket;
 if( k[n].col == COL_WHITE ) ply[cur].stat |= FOUL_WHITE_POCKETED;
 else if( (k[n].col == COL_BLACK) && (ply[cur].col != COL_BLACK) )
  ply[cur].stat |= FOUL_BLACK_ILLEGALY_POCKETED;
 else if( !ply[cur].col && (k[n].col != COL_WHITE) ) 
  { /* falls noch keine Spieler-Farbe festgelegt ist */
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
 /*  GrDrawString( out, strlen(out), x, y, TEXTCOL ); */
 /*  SDL_Flip(display); */
 }

void print2( char *out, int align, int x, int y )
 {
 /*  GrDrawString( out, strlen(out), x, y, TEXTCOL ); */
 /*  SDL_Flip(display); */
 }

void close_graphics( void )
 {
 glDeleteLists(257,2);
 glDeleteLists(260,BALLS);
 glDeleteLists(290,BALLS);
 glDeleteLists(280,2);
 atexit(SDL_Quit);
 }

void plot_statistics( double time, int grx )
 {
 int a=30; 
 char out[256];
 if( SCREENRESX < 640) return;
 glDisable(GL_LIGHTING);
 
 glColor4d(0.1,0.1,0.1,0.7);
 glEnable(GL_BLEND);
 glBegin(GL_POLYGON);
 glVertex3d( -2.0, -2.0, 2.1*RADIUS );
 glVertex3d( 2.0, -2.0, 2.1*RADIUS );
 glVertex3d( 2.0, 2.0, 2.1*RADIUS );
 glVertex3d( -2.0, 2.0, 2.1*RADIUS );
 glEnd();

 glPrintCentered(768-(a+=90), "STATISTICS",0,1.0,1.0,1.0,1.0,5.0);
 glPrint(20,768-(a+=90),"    Player",0,1.0,1.0,1.0,1.0,3.0);
 glPrint(605,768-a,"1",0,1.0,1.0,1.0,1.0,3.0);
 glPrint(725,768-a,"2",0,1.0,1.0,1.0,1.0,3.0);
 glPrint(20,768-(a+=70), "standings",0,1.0,1.0,1.0,1.0,sqrt(2.0));
 sprintf(out,"%5d", stats[0].wins+stats[1].losses);
 glPrint(545,768-a, out,0,1.0,1.0,1.0,1.0,sqrt(2.0));
 sprintf(out,"%5d", stats[1].wins+stats[0].losses);
 glPrint(665,768-a, out,0,1.0,1.0,1.0,1.0,sqrt(2.0));

 sprintf(out,"-games won (correct play on black)   %5d   %5d",
	 stats[0].wins, stats[1].wins);
 glPrint(20,768-(a+=50), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"-games lost ('direct' foul on black) %5d   %5d",
	 stats[0].losses, stats[1].losses  );
 glPrint(20,768-(a+=30), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"number of pocketed balls             %5d   %5d",
	 stats[0].pots, stats[1].pots  );
 glPrint(20,768-(a+=70), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"no. of attempts without success      %5d   %5d",
	 stats[0].nopots, stats[1].nopots  );
 glPrint(20,768-(a+=30), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"fouls: wrong color touched           %5d   %5d",
	 stats[0].fouls.wrongct, stats[1].fouls.wrongct  );
 glPrint(20,768-(a+=30), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"fouls: wrong color pocketed          %5d   %5d",
	 stats[0].fouls.wrongcp, stats[1].fouls.wrongcp  );
 glPrint(20,768-(a+=30), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"fouls: white ball disappeared        %5d   %5d",
	 stats[0].fouls.whited, stats[1].fouls.whited  );
 glPrint(20,768-(a+=30), out,0,1.0,1.0,1.0,1.0,1.0);
 sprintf(out,"fouls: no ball or rail touched       %5d   %5d",
	 stats[0].fouls.notouch, stats[1].fouls.notouch  );
 glPrint(20,768-(a+=30), out,0,1.0,1.0,1.0,1.0,1.0);
 msg2("press an key or mouse button");
 SDL_GL_SwapBuffers();
 wait_for_click();
 PAINT_ALL;
 }

void help( void )
 {
 int a=30; 
 if( SCREENRESX < 640) return;
 glDisable(GL_LIGHTING);
 
 glColor4d(0.1,0.1,0.1,0.7);
 glEnable(GL_BLEND);
 glBegin(GL_POLYGON);
 glVertex3d( -2.0, -2.0, 2.1*RADIUS );
 glVertex3d( 2.0, -2.0, 2.1*RADIUS );
 glVertex3d( 2.0, 2.0, 2.1*RADIUS );
 glVertex3d( -2.0, 2.0, 2.1*RADIUS );
 glEnd();

 glPrint(20,768-(a+=45), "HELP-Screen", 0, 1.0, 1.0, 1.0, 1.0,2.0);
 glPrint(20,768-(a+=40), "KEYS:", 0, 1.0, 1.0, 1.0, 1.0,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'e': change spin, same as middle button", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'c': activate/deactivate computer opponent", 0, 1.0, 1.0, 1.0, 1.0,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'x': let computer play next shot", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'n': new game, current game is lost", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'd': demo-mode on; any key to stop demo", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'u': undo last shot (no redo implemented)", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "SPACE: toggle free look mode on and off", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'c': center view on white ball", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'z': calculate end position immediately", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'w': toggle special target mode", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "  'h': simulation mode (test)", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), " 'F4': switch texture display (on/off)", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), " 'F5': switch geometric detail level (hi/lo)", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), " 'F1': this screen", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), " 'F2': credits", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=35), "'F12': statistics", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 glPrint(20,768-(a+=30),"  ESC: menu: quit game, computer player: stop", 0, 1.0, 1.0, 1.0, 1.0 ,sqrt(2.0));
 msg2("press an key or mouse button");
 SDL_GL_SwapBuffers();
 wait_for_click();
 PAINT_ALL;
 }

void credits( void )
 {
 int a=30;
 char out[256];
 if( SCREENRESX < 640) return;
 glDisable(GL_LIGHTING);
 
 glColor4d(0.1,0.1,0.1,0.7);
 glEnable(GL_BLEND);
 glBegin(GL_POLYGON);
 glVertex3d( -2.0, -2.0, 2.1*RADIUS );
 glVertex3d( 2.0, -2.0, 2.1*RADIUS );
 glVertex3d( 2.0, 2.0, 2.1*RADIUS );
 glVertex3d( -2.0, 2.0, 2.1*RADIUS );
 glEnd();

 sprintf(out,"Another Pool GL");
 glPrint(20, 768-(a+=50), out, 0,1.0,1.0,1.0,1.0 ,3.0);
 sprintf(out,"    V %s, %s",VERSION, DATE);
 glPrint(20, 768-(a+=30), out, 0,1.0,1.0,1.0,1.0,sqrt(2.0));
 glPrint(20, 768-(a+=30), "copyright (c) 1995-2013 by Gerrit Jahn", 0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(20, 768-(a+=30), "http://www.planetjahn.de",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=80), "CREDITS", 0,1.0,1.0,1.0,1.0 ,sqrt(2.0));
 glPrint(10, 768-(a+=30), "------------------------------------------------------------------",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "'ANOTHER POOL (GL)' is free software;   you  can  redistribute  it",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "and/or modify it under the terms of the GNU General Public License",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "as published by the Free Software Foundation;  either version 2 of",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "the License, or (at your option) any later version.",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "Another Pool GL is distributed in the hope  that it will be useful,",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "but  WITHOUT  ANY  WARRANTY;  without  even the implied warranty of",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "MERCHANTABILITY  or  FITNESS  FOR A  PARTICULAR  PURPOSE.   See the",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "GNU General Public License  (see file 'copying')  for more details.",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "------------------------------------------------------------------",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "If you have any  problems,  questions or suggestions,  look at the",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "the homepage.",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "                                 have fun!",0,1.0,1.0,1.0,1.0 ,1.0);
 glPrint(10, 768-(a+=30), "       ;-)                                             Gerrit Jahn",0,1.0,1.0,1.0,1.0 ,1.0);
 msg2("press an key or mouse button");
 SDL_GL_SwapBuffers();
 wait_for_click();
 PAINT_ALL;
 }

