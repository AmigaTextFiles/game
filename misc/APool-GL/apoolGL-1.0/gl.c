/* This is "gl.c", a part of the pool (billiards)-program
                   
                     "Another Pool GL".

   "gl.c" includes some procedures needed for the OpenGL-graphics-
   system of the game. Therefore GL, GLU and SDL must be installed
   on your system. (Documentation: see http://www.opengl.org and
   http://www.libsdl.org)

   Parts of the following code (texture loading, font output and loading 
   and parts of the initialization ) are based on NeHe's OpenGL Tutorials 
   (see http://nehe.gamedev.net).

   Copyright (C) 1995,2002,2003 by Gerrit Jahn (http://www.planetjahn.de)
   
   This file ist part of Another Pool / Another Pool GL (apool, apoolGL).

   "Another Pool" is free software; you can redistribute it 
   and/or modify it under the terms of the GNU General Public License 
   as published by the Free Software Foundation; either version 2 of 
   the License, or (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with GNU CC; see the file COPYING.  If not, write to
   the Free Software Foundation, 675 Mass Ave, Cambridge, MA 02139, USA.  */

/* ------------------------------ computer.c ----------------------------- */

#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <SDL/SDL.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <string.h>
#include "apool.h"
#include <linux/param.h>
#include <sys/time.h>

#ifndef M_PI
#define M_PI 3.141592654
#endif

#ifndef ABS
#define ABS(a) ((a) < 0 ? -(a) : a)
#endif

#define FALSE   0
#define TRUE    1

#define SIGN(a) ((a) > 0 ? 1 : -1)

/* Längeneinheit: Tisch ist in real life 8 Fuß lang, d.h. 244cm, 
   die im Spiel auf die Länge 1.0 (von -0.5 - +0.5) verteilt sind */

/* liefert die "Höhe" der Bande am Rand wieder - ergibt abgerundete Kante */
#define bfunc_max 60.0
#define BFUNC(m) ((m) > 1 ? (RADIUS*(4.0/3.0 - 4.0/3.0*exp(-1.0/5.0 * (bfunc_max-(m))))) : \
                                                                     RADIUS*4.0/3.0 - (1-m)*0.0004)

#define BFUNC_new_geht_nicht(m) (((m)/1000.0 <= 0.06-4.0/3.0*RADIUS) ? 4.0/3.0*RADIUS : \
    sqrt((16.0/9.0*RADIUS*RADIUS) - ((m)/1000.0-0.06+4.0/3.0*RADIUS)*((m)/1000.0-0.06+4.0/3.0*RADIUS)))

double angx=0.0,angy=0.0,angz=0.0;
double startx=0.0,starty=0.0,startz=-0.985;
double transx=0.0, transy = 0.0, transz = 0.0;

unsigned long poly = 0;

GLfloat LightAmbient3[] = { 0.9, 0.9, 0.8, 1.0 };
GLfloat LightAmbient[] = { 0.15, 0.15, 0.15, 1.0 };
GLfloat LightDiffuse3[] = { 0.5, 0.5, 0.5, 1.0 };
GLfloat LightDiffuse1[] = { 0.9, 0.9, 0.75, 1.0 };
GLfloat LightDiffuse2[] = { 0.9, 0.9, 0.75, 1.0 };
GLfloat LightSpecular[] = { 1.0, 1.0, 1.0, 1.0 };

GLfloat LightAmbient_multi[] = { 0.01, 0.01, 0.01, 0.1 };
GLfloat LightDiffuse_multi[] = { 0.4, 0.4, 0.4, 0.4 };
GLfloat LightSpecular_multi[] = { 0.01, 0.01, 0.01, 0.01};

GLfloat LightZero[] = { 0.0, 0.0, 0.0, 0.0 };

GLfloat LightPosition[][4] = {{  0.25, 0.0, 0.25, 1.0 }, /* Tischbeleuchtung 1 */
			      { -0.25, 0.0, 0.25, 1.0 }, /* Tischbeleuchtung 2 */
			      {  0.0,  0.0, 1.5, 0.0 }}; /* Beleuchtung der Spin-Kugel und der Kugel links oben */

GLfloat MatAmb[] = {0.3, 0.3, 0.3, 0.2};   
GLfloat MatAmbbright[] = {0.75, 0.75, 0.75, 1.0};
GLfloat MatDif[] = {0.9, 0.9, 0.9, 1.0};
GLfloat MatDifTransparent[] = {0.9, 0.9, 0.9, 0.7};
GLfloat MatDifballs[] = {0.7, 0.7, 0.7, 1.0};
GLfloat MatDifballs_multi[] = {0.6, 0.6, 0.6, 0.6};
GLfloat MatDifMetall[] = {0.1, 0.1, 0.125, 1.0};
GLfloat MatDifTablegreen[] = {0.0, 0.55, 0.00, 1.0};
GLfloat MatDifTableblue[] = {0.1, 0.1, 0.7, 1.0};
GLfloat MatDifTablered[] = {0.6, 0.1, 0.1, 1.0};
GLfloat MatDifTableTextgreen[] = {0.0, 0.55, 0.0, 1.0};
GLfloat MatDifTableTextblue[] = {0.1, 0.1, 0.7, 1.0};
GLfloat MatDifTableTextred[] = {0.6, 0.1, 0.1, 1.0};
GLfloat MatDifBorder[] = {0.0, 0.45, 0.0, 1.0};
/* GLfloat MatDifWood[] = {0.5, 0.2, 0.0, 1.0}; */
GLfloat MatDifWood[] = {0.6, 0.6, 0.6, 1.0};
GLfloat MatGummi[] = {0.03, 0.03, 0.03, 1.0};
GLfloat MatDifWooddark[] = {0.01, 0.005, 0.0, 1.0};
GLfloat MatAmbWooddark[] = {0.04, 0.02, 0.0, 1.0};   
GLfloat MatDifDark[] = {0.1, 0.1, 0.1, -1.0};
GLfloat MatEm[] = {0.9, 0.0, 0.0, 0.1};

GLfloat MatSpc[] = { 1.0, 1.0, 1.0, 1.0 };
GLfloat MatSpc_multi[] = { 0.3, 0.3, 0.3, 0.3 };
GLfloat MatSpcWood[] = { 0.65, 0.65, 0.65, 0.5 };
GLfloat MatSpcLow[] = { 0.0, 0.01, 0.0, 0.1 };
GLfloat MatNull[] = { 0.0, 0.0, 0.0, 0.0 };

GLfloat MatRedDif[] = {1.0,0.0,0.0,1.0};
GLfloat MatYellowDif[] = {1.0,1.0,0.0,1.0};
GLfloat MatBlackDif[] = {0.0,0.0,0.0,1.0};
GLfloat MatWhiteDif[] = {1.0,1.0,1.0,1.0};

GLfloat MatShn = 64.0;
GLfloat MatShnsmall = 128.0;                         

GLuint base; /* für Fonts */

/* Ikosaeder mit Mathematica erzeugt, ist um einen Faktor 1.1755705045849463 
   zu groß, wird unten auf 1 normiert */
double ico20[20*3*3] = 
 {0.0, 0.0, 1.1755705045849463, 0.3249196962329063, 1.0,
    0.5257311121191336, 1.0514622242382672, 0.0, 0.5257311121191336, 
 0.0, 0.0, 1.1755705045849463, -0.8506508083520399, 
    0.6180339887498949, 0.5257311121191336, 0.3249196962329063, 1.0, 
    0.5257311121191336, 0.0, 0.0, 1.1755705045849463, 
   -0.8506508083520399, -0.6180339887498949, 0.5257311121191336, 
   -0.8506508083520399, 0.6180339887498949, 0.5257311121191336, 
 0.0, 0.0, 1.1755705045849463, 0.3249196962329063, -1.0, 
    0.5257311121191336, -0.8506508083520399, -0.6180339887498949, 
    0.5257311121191336, 0.0, 0.0, 1.1755705045849463, 
   1.0514622242382672, 0.0, 0.5257311121191336, 0.3249196962329063, -1.0, 
    0.5257311121191336, 
 1.0514622242382672, 0.0, 0.5257311121191336, 
   0.3249196962329063, 1.0, 0.5257311121191336, 
   0.8506508083520399, 0.6180339887498949, -0.5257311121191336, 
 0.3249196962329063, 1.0, 0.5257311121191336, 
   -0.8506508083520399, 0.6180339887498949, 0.5257311121191336, 
   -0.3249196962329063, 1.0, -0.5257311121191336, 
 -0.8506508083520399, 0.6180339887498949, 0.5257311121191336, 
   -0.8506508083520399, -0.6180339887498949, 0.5257311121191336, 
   -1.0514622242382672, 0.0, -0.5257311121191336, 
 -0.8506508083520399, -0.6180339887498949, 0.5257311121191336, 
   0.3249196962329063, -1.0, 0.5257311121191336, 
   -0.3249196962329063, -1.0, -0.5257311121191336, 
 0.3249196962329063, -1.0, 0.5257311121191336, 
   1.0514622242382672, 0.0, 0.5257311121191336, 
   0.8506508083520399, -0.6180339887498949, -0.5257311121191336, 
 0.8506508083520399, 0.6180339887498949, -0.5257311121191336, 
   0.3249196962329063, 1.0, 0.5257311121191336, -0.3249196962329063, 1.0, 
    -0.5257311121191336, 
 -0.3249196962329063, 1.0, -0.5257311121191336, 
   -0.8506508083520399, 0.6180339887498949, 0.5257311121191336, 
   -1.0514622242382672, 0.0, -0.5257311121191336, 
 -1.0514622242382672, 0.0, -0.5257311121191336, 
   -0.8506508083520399, -0.6180339887498949, 0.5257311121191336, 
   -0.3249196962329063, -1.0, -0.5257311121191336, 
 -0.3249196962329063, -1.0, -0.5257311121191336, 
   0.3249196962329063, -1.0, 0.5257311121191336, 
   0.8506508083520399, -0.6180339887498949, -0.5257311121191336, 
 0.8506508083520399, -0.6180339887498949, -0.5257311121191336, 
   1.0514622242382672, 0.0, 0.5257311121191336, 
   0.8506508083520399, 0.6180339887498949, -0.5257311121191336, 
 0.8506508083520399, 0.6180339887498949, -0.5257311121191336, 
   -0.3249196962329063, 1.0, -0.5257311121191336, 
   0.0, 0.0, -1.1755705045849463, 
 -0.3249196962329063, 1.0, -0.5257311121191336, 
   -1.0514622242382672, 0.0, -0.5257311121191336, 
   0.0, 0.0, -1.1755705045849463, 
 -1.0514622242382672, 0.0, -0.5257311121191336, 
   -0.3249196962329063, -1.0, -0.5257311121191336, 
   0.0, 0.0, -1.1755705045849463, 
 -0.3249196962329063, -1.0, -0.5257311121191336, 
   0.8506508083520399, -0.6180339887498949, -0.5257311121191336, 
   0.0, 0.0, -1.1755705045849463, 
 0.8506508083520399, -0.6180339887498949, -0.5257311121191336, 
   0.8506508083520399, 0.6180339887498949, -0.5257311121191336, 
  0.0, 0.0, -1.1755705045849463};

#define shadow_step 3
double shadow[BALLS][(360+shadow_step)/shadow_step][4][3];

#define DIFF_half(a,b,c)\
(a).x = ((c).x - (b).x)/2.0;\
(a).y = ((c).y - (b).y)/2.0;\
(a).z = ((c).z - (b).z)/2.0

#define ADD(a,b,c)\
(a).x = (b).x + (c).x;\
(a).y = (b).y + (c).y;\
(a).z = (b).z + (c).z

#define TRIANGLE(no,x1,x2,x3)\
  ico[(no)*9+0*3+0] = (x1).x;\
  ico[(no)*9+0*3+1] = (x1).y;\
  ico[(no)*9+0*3+2] = (x1).z;\
                           \
  ico[(no)*9+1*3+0] = (x2).x;\
  ico[(no)*9+1*3+1] = (x2).y;\
  ico[(no)*9+1*3+2] = (x2).z;\
                           \
  ico[(no)*9+2*3+0] = (x3).x;\
  ico[(no)*9+2*3+1] = (x3).y;\
  ico[(no)*9+2*3+2] = (x3).z

#define NORMAL(p)\
  if( (dummy = BETR3(p) ) )\
   {\
   (p).x /= dummy;\
   (p).y /= dummy;\
   (p).z /= dummy;\
   }

/* Normiert den mit Mathematica erzeugen Icosaeder so, dass die äußersten
   Punkte auf der Einheitskugel liegen. Mathematica hat den Ikosaeder "im 
   Mittel" auf 1 normiert */
void normalize_ico20(double scale)
 {
 int i,j,k;
 if( scale == 0 ) return;
 for(i=0;i<20;i++)
  for(j=0;j<3;j++)
   for(k=0;k<3;k++)
    ico20[i*9+j*3+k] /= scale;
 }

/* unterteilt teilt jedes Dreieck des übergegebenen Polyhedrons "ico"
   in vier Dreicke und zieht die neu entstandenen Punkte (die
   Mittelpunkte der Verbindungslininen des ursprünglichen Dreiecks)
   auf die Einheitskugel */
void splitpoly(double *ico, double *ico_small, int no)
 {
 int i;
 struct vect3 x1,x2,x3,x4,x5,x6,v;
 double dummy;
 for(i=0;i<no;i++)
  {
  x1.x = ico_small[i*9+0*3+0];
  x1.y = ico_small[i*9+0*3+1];
  x1.z = ico_small[i*9+0*3+2];
    
  x3.x = ico_small[i*9+1*3+0];
  x3.y = ico_small[i*9+1*3+1];
  x3.z = ico_small[i*9+1*3+2];
  
  x5.x = ico_small[i*9+2*3+0];
  x5.y = ico_small[i*9+2*3+1];
  x5.z = ico_small[i*9+2*3+2];

  DIFF_half(v,x1,x3);
  ADD(x2,x1,v);
  NORMAL(x2);

  DIFF_half(v,x3,x5);
  ADD(x4,x3,v);
  NORMAL(x4);

  DIFF_half(v,x5,x1);
  ADD(x6,x5,v);
  NORMAL(x6);

  TRIANGLE(i*4,   x1, x2, x6);
  TRIANGLE(i*4+1, x2, x3, x4);
  TRIANGLE(i*4+2, x6, x4, x5);
  TRIANGLE(i*4+3, x6, x2, x4);
  }
 }

/* ruft die Displaylisten für die entsprechenden Ikosaeder-Kugeln auf */
void icoball(int no)
 {
 switch(no)
  {
  case 20: glCallList(400); break;
  case 80: glCallList(401); break;
  case 320: glCallList(402); break;
  case 1280: glCallList(403); break;
  case 5120: glCallList(404); break;
  case 20480: glCallList(405); break;
  default: glCallList(403); break;
  }
#ifdef DEBUG
 poly += no;
#endif
 }

/* malt Kugel mit angegebenem Kugeldatensatz "ico" mit "no" Polygonen 
   und Radius=radius */
void icosphere(double *ico, int no, double radius)
 {
 int i, sign;
 glCullFace(GL_FRONT);
 glBegin(GL_TRIANGLES);
 for(i=0;i<no;i++)
  {                                       /* damit auf der Rückseite die Textur um 180 Grad gedreht, */
  sign = (ico[i*9+0*3+2] >= 0 ? 1 : -1 ); /* aber nicht gespiegelt ist! */
                                          
  glTexCoord2d( (ico[i*9+0*3+0]+1.0)/2, sign * (ico[i*9+0*3+1]+1.0)/2.0);
  glNormal3f(ico[i*9+0*3+0],ico[i*9+0*3+1],ico[i*9+0*3+2]);
  glVertex3f(ico[i*9+0*3+0] * radius, ico[i*9+0*3+1] * radius, ico[i*9+0*3+2] * radius);

  glTexCoord2d( (ico[i*9+1*3+0]+1.0)/2, sign * (ico[i*9+1*3+1]+1.0)/2.0);
  glNormal3f(ico[i*9+1*3+0],ico[i*9+1*3+1],ico[i*9+1*3+2]);
  glVertex3f(ico[i*9+1*3+0] * radius ,ico[i*9+1*3+1] * radius, ico[i*9+1*3+2] * radius);

  glTexCoord2d( (ico[i*9+2*3+0]+1.0)/2, sign * (ico[i*9+2*3+1]+1.0)/2.0);
  glNormal3f(ico[i*9+2*3+0],ico[i*9+2*3+1],ico[i*9+2*3+2]);
  glVertex3f(ico[i*9+2*3+0] * radius, ico[i*9+2*3+1] * radius, ico[i*9+2*3+2] * radius);

  }
 glEnd();
 glCullFace(GL_BACK);
 }

/* von NeHe übernommen und an den verwendeten Zeichensatz angepasst
   NeHe verwendet eine Textur mit zwei Zeichensätzen. Hier wird
   nur ein Zeichensatz verwendet, der dafür den vollen ASCII-Satz
   enthält */
GLvoid BuildFont(GLvoid)                             /* Build Our Font Display List */
 {
 double cx;                                          /* Holds Our X Character Coord */
 double cy;                                          /* Holds Our Y Character Coord */
 int loop;
 
 base=glGenLists(256);                              /* Creating 256 Display Lists */
 glBindTexture(GL_TEXTURE_2D, texture[32]);         /* Select Our Font Texture */
 for (loop=0; loop<256; loop++)                     /* Loop Through All 256 Lists */
  {
  cx=(double)(loop%16)/16.0;                         /* X Position Of Current Character */
  cy=(double)(loop/16)/16.0;                         /* Y Position Of Current Character */
  
  glNewList(base+loop,GL_COMPILE);                  /* Start Building A List */
  glBegin(GL_QUADS);                                /* Use A Quad For Each Character */
  glTexCoord2d(cx+0.15/16.0,1-cy-0.0625);           /* Texture Coord (Bottom Left) */
  glVertex2i(0,0);                                  /* Vertex Coord (Bottom Left) */
  glTexCoord2d(cx+0.0625-0.15/16.0,1-cy-0.0625);    /* Texture Coord (Bottom Right) */
  glVertex2i(16,0);                                 /* Vertex Coord (Bottom Right) */
  glTexCoord2d(cx+0.0625-0.15/16.0,1-cy);           /* Texture Coord (Top Right) */
  glVertex2i(16,16);                                /* Vertex Coord (Top Right) */
  glTexCoord2d(cx+0.15/16.0,1-cy);                  /* Texture Coord (Top Left) */
  glVertex2i(0,16);                                 /* Vertex Coord (Top Left) */
  glEnd();                                          /* Done Building Our Quad (Character) */
  glTranslated(10,0,0);                             /* Move To The Right Of The Character */
  glEndList();                                      /* Done Building The Display List */
  }                                                 /* Loop Until All 256 Are Built */
 }

GLvoid KillFont(GLvoid)                             /* Delete The Font From Memory */
 {
 glDeleteLists(base,256);                           /* Delete All 256 Display Lists */
 }

/* ebenfalls von Nehe übernommen und an obige Modifkation für einen 
   Zeichensatz angepasst. Weiterhin Skalierung und Farbe eingebaut */
/* malt Strings an die Position x,y (in Bildschirmkoordinaten, bezogen auf 
   1024x768! charset=0,1; Farben klar, scale: Skalierung */
GLvoid glPrint(GLint x, GLint y, char *string, int charset, 
	       double red, double green, double blue, double alpha, double scale)
 {     
 double xp = x * SCREENRESX/1024.0, yp = y * SCREENRESX/1024.0;
 if (charset>1) charset=1;
 glBlendFunc(GL_SRC_ALPHA,GL_ONE);
 glDisable(GL_LIGHTING);
 glEnable(GL_BLEND);
 glDisable(GL_FOG);
 glColor4d(red,green,blue,alpha);
 glEnable(GL_TEXTURE_2D);
 glBindTexture(GL_TEXTURE_2D, texture[32]);             /* Select Our Font Texture */
 glDisable(GL_DEPTH_TEST);                              /* Disables Depth Testing */
 glMatrixMode(GL_PROJECTION);                           /* Select The Projection Matrix */
 glPushMatrix();                                        /* Store The Projection Matrix */
 glLoadIdentity();                                      /* Reset The Projection Matrix */
 glOrtho(0,SCREENRESX,0,SCREENRESY,-1,1);               /* Set Up An Ortho Screen */
 glMatrixMode(GL_MODELVIEW);                            /* Select The Modelview Matrix */
 glPushMatrix();                                        /* Store The Modelview Matrix */
 glLoadIdentity();                                      /* Reset The Modelview Matrix */
 glTranslated(xp,yp,-1.00);                             /* Position The Text (0,0 - Bottom Left) */
 glListBase(base+(128*charset));                        /* Choose The Font Set (0 or 1) */
 glScaled(1.5*SCREENRESX/1024.0, 1.5*SCREENRESX/1024.0, 1.0);
 glScaled(scale,scale,1.0);
 glCallLists(strlen(string),GL_UNSIGNED_BYTE,string);   /* Write The Text To The Screen */
 glMatrixMode(GL_PROJECTION);                           /* Select The Projection Matrix */
 glPopMatrix();                                         /* Restore The Old Projection Matrix */
 glMatrixMode(GL_MODELVIEW);                            /* Select The Modelview Matrix */
 glPopMatrix();                                         /* Restore The Old Projection Matrix */
 glEnable(GL_DEPTH_TEST);                               /* Enables Depth Testing */
 glDisable(GL_TEXTURE_2D);
 glDisable(GL_BLEND);
 glEnable(GL_LIGHTING);
 glEnable(GL_FOG);
 glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
 }

SDL_Surface *LoadBMP(char *filename) /* Von Nehe übernommen */
 {
 Uint8 *rowhi, *rowlo;
 Uint8 *tmpbuf, tmpch;
 SDL_Surface *image;
 int i, j;
 
 if(!(image = SDL_LoadBMP(filename))) 
  {
  if(!(image = SDL_LoadBMP(sprintf("/usr/local/share/apool/%s",filename))))
   {
   fprintf(stderr, "Unable to load %s: %s\n", filename, SDL_GetError());
   return(NULL);
   }
  }
 
 /* GL surfaces are upsidedown and RGB, not BGR :-) */
 if(!(tmpbuf = (Uint8 *)malloc(image->pitch))) 
  {
  fprintf(stderr, "Out of memory\n");
  return(NULL);
  }
 rowhi = (Uint8 *)image->pixels;
 rowlo = rowhi + (image->h * image->pitch) - image->pitch;
 for ( i=0; i<image->h/2; ++i ) 
  {
  for ( j=0; j<image->w; ++j ) 
   {
   tmpch = rowhi[j*3];
   rowhi[j*3] = rowhi[j*3+2];
   rowhi[j*3+2] = tmpch;
   tmpch = rowlo[j*3];
   rowlo[j*3] = rowlo[j*3+2];
   rowlo[j*3+2] = tmpch;
   }
  memcpy(tmpbuf, rowhi, image->pitch);
  memcpy(rowhi, rowlo, image->pitch);
  memcpy(rowlo, tmpbuf, image->pitch);
  rowhi += image->pitch;
  rowlo -= image->pitch;
  }
 free(tmpbuf);
 return(image);
 }

#define cube_txt_size 128

int LoadGLTextures( void ) /* ebenfalls basierend auf einem Nehe Tutorial */
 {                         /* aber für mehrere Texturen angepasst und erweitert f. Mipmapping, Cube-Textures, usw.*/
 int i;
 char txt[80];
 SDL_Surface *TextureImage[ANZ_TEXTURES];
 memset(TextureImage,0,sizeof(void *)*ANZ_TEXTURES);			
 texture = malloc((sizeof(int) * ANZ_TEXTURES));
 
 for(i=0;i<BALLS;i++)
   {
   sprintf(txt,"textures-hi/%d.bmp",i);
   if( !(TextureImage[i]=LoadBMP(txt)) ) 
    {
    printf("can't find %d of hd textures\n",i);
    return FALSE; 
    }
   }

 for(i=BALLS;i<2*BALLS;i++)
   {
   sprintf(txt,"textures-lo/%d.bmp",i-BALLS);
   if( !(TextureImage[i]=LoadBMP(txt)) ) 
    {
    printf("can't find %d of ld textures\n",i-BALLS);
    return FALSE; 
    }
   }
 
 if( !(TextureImage[i++]=LoadBMP("textures-hi/Font.bmp")) ) return FALSE; 
 if( !(TextureImage[i++]=LoadBMP("textures-hi/Holz.bmp")) ) return FALSE; 
 if( !(TextureImage[i++]=LoadBMP("textures-hi/Marmor.bmp")) ) return FALSE; 
 if( !(TextureImage[i++]=LoadBMP("textures-hi/Tuch.bmp")) ) return FALSE; 
 if( !(TextureImage[i++]=LoadBMP("textures-hi/Env.bmp")) ) return FALSE; 
 
 glGenTextures(ANZ_TEXTURES, &texture[0]);
 for (i=0; i<ANZ_TEXTURES; i++)				
  {
  if( i < 32 ) /* Balltexturen mipmappen */
   {
   glBindTexture(GL_TEXTURE_2D, texture[i]);
   glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
   glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR_MIPMAP_LINEAR );
/*
   Das hier war das Problem mit dem unteren "Rand" der weissen Kugel!!!
   if( 1==0 && (i == 0 || i == 16) ) glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP);
   else glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
*/

   glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
   
   /* glTexParameterf(GL_TEXTURE_2D,GL_TEXTURE_MAX_ANISOTROPY_EXT, 2.0); /\* funktioniert, bringts was ?! *\/ */
   
   gluBuild2DMipmaps(GL_TEXTURE_2D, GL_RGB5, TextureImage[i]->w, TextureImage[i]->h,
		     GL_RGB, GL_UNSIGNED_BYTE, TextureImage[i]->pixels);
   }
  else /* Rest (Holz z.B.) nicht mipmappen, sah nicht gut aus */
   {
   glBindTexture(GL_TEXTURE_2D, texture[i]);
   glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
   glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
   glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB5, TextureImage[i]->w, TextureImage[i]->h, 0,
		GL_RGB, GL_UNSIGNED_BYTE, TextureImage[i]->pixels);
   }
  }

 for(i=0;i<BALLS;i++) 
  {
  glGenTextures(1,&cube_texture[i]);
  glBindTexture(GL_TEXTURE_CUBE_MAP_EXT, cube_texture[i]);
  
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
  glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);

  glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
  glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);

  glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

  glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT,0,GL_RGB5,cube_txt_size,cube_txt_size,0,GL_RGB,GL_UNSIGNED_BYTE, NULL);
  glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT,0,GL_RGB5,cube_txt_size,cube_txt_size,0,GL_RGB,GL_UNSIGNED_BYTE, NULL);
  glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT,0,GL_RGB5,cube_txt_size,cube_txt_size,0,GL_RGB,GL_UNSIGNED_BYTE, NULL);
  glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT,0,GL_RGB5,cube_txt_size,cube_txt_size,0,GL_RGB,GL_UNSIGNED_BYTE, NULL);
  glTexImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT,0,GL_RGB5,cube_txt_size,cube_txt_size,0,GL_RGB,GL_UNSIGNED_BYTE, NULL);
  glTexImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT,0,GL_RGB5,cube_txt_size,cube_txt_size,0,GL_RGB,GL_UNSIGNED_BYTE, NULL);
  }
 
 for (i=0; i<ANZ_TEXTURES; i++)					
   if (TextureImage[i]) SDL_FreeSurface(TextureImage[i]);

 return TRUE;
 }

/* Makros/Funktionen zum Malen des Tischtuchs */
#ifdef DEBUG
#define tuch(x1,y1,x2,y2,tx1,ty1,tx2,ty2)\
 {\
  glTexCoord2d(tx1, ty1);\
  glVertex3d( x1, y1, 0.0 );\
  glTexCoord2d(tx2, ty1);\
  glVertex3d( x2, y1, 0.0 );\
  glTexCoord2d(tx2, ty2);\
  glVertex3d( x2, y2, 0.0 );\
  glTexCoord2d(tx1, ty2);\
  glVertex3d( x1, y2, 0.0 );\
  poly++;\
 }
#else
#define tuch(x1,y1,x2,y2,tx1,ty1,tx2,ty2)\
 {\
  glTexCoord2d(tx1, ty1);\
  glVertex3d( x1, y1, 0.0 );\
  glTexCoord2d(tx2, ty1);\
  glVertex3d( x2, y1, 0.0 );\
  glTexCoord2d(tx2, ty2);\
  glVertex3d( x2, y2, 0.0 );\
  glTexCoord2d(tx1, ty2);\
  glVertex3d( x1, y2, 0.0 );\
 }
#endif

#ifdef DEBUG
#define tuch_strips(x1,y1,x2,y2,tx1,ty1,tx2,ty2) \
  glTexCoord2d(tx1, ty1);\
  glVertex3d( x2, y2, 0.0 );\
  glTexCoord2d(tx2, ty2);\
  glVertex3d( x1, y1, 0.0 );\
  poly++
#else
#define tuch_strips(x1,y1,x2,y2,tx1,ty1,tx2,ty2) \
  glTexCoord2d(tx1, ty1);\
  glVertex3d( x2, y2, 0.0 );\
  glTexCoord2d(tx2, ty2);\
  glVertex3d( x1, y1, 0.0)
#endif


void calc_normal_ez( struct vect3 *res, struct vect3 *v )
 {
 struct vect3 ez;
 double dummy;
 ez.x = 0; ez.y = 0; ez.z = 1.0;
 res->x = v->y * ez.z - v->z * ez.y;
 res->y = v->z * ez.x - v->x * ez.z;
 res->z = v->x * ez.y - v->y * ez.x;
 dummy = sqrt(res->x*res->x + res->y*res->y + res->z*res->z );
 if( dummy > 0 )
  {
  res->x /= dummy;
  res->y /= dummy;
  res->z /= dummy;
  }
 }

/* Normalenvektor berechnen, Ergebnis steht im ersten Übergabeparameter */
void calc_normal( double *n, double x1, double y1, double z1, double x2, double y2, double z2, 
		  double x3, double y3, double z3 )
 {
 double v1x=x2-x1, v1y=y2-y1, v1z=z2-z1, v2x=x3-x1, v2y=y3-y1, v2z=z3-z1;
 double dummy;
 n[0] = v1y * v2z - v1z * v2y;
 n[1] = v1z * v2x - v1x * v2z;
 n[2] = v1x * v2y - v1y * v2x;
 dummy = sqrt(n[0]*n[0] + n[1]*n[1] + n[2]*n[2] );
 if( dummy > 0 )
  {
  n[0] /= dummy;
  n[1] /= dummy;
  n[2] /= dummy;
  }
 if( n[2] < 0 ) { n[0] = -n[0]; n[1] = -n[1]; n[2] = -n[2]; }
 }

void holz_strip(double x1, double y1, double z1, double x2, double y2, double z2, double x3, double y3, double z3, 
		double txt_x1, double txt_y1, double txt_x2, double txt_y2 )
 {
 double norm[3];
 calc_normal(norm, x1, y1, z1, x2, y2, z2, x3, y3, z3);
 glNormal3dv( norm );
 glTexCoord2d(txt_x2, txt_y2);
 glVertex3d( x2, y2, z2 );
 glTexCoord2d(txt_x1, txt_y1);
 glVertex3d( x1, y1, z1 );
 }

/* hintere Innenseite der Taschen */
void gummi( double x1, double y1, double x2, double y2)
 {
 glVertex3d( x1, y1, 4.0/3.0 * RADIUS);
 glVertex3d( x2, y2, 4.0/3.0 * RADIUS);
 glVertex3d( x2, y2, -9.0/3.0 * RADIUS );
 glVertex3d( x1, y1, -9.0/3.0 * RADIUS );
 }

/* gummitop malt die Gummiverkleidungen der Löcher "auf" dem Metall */
/* 1,2: im Abstand RADIUS, 3,4: im Abstand 1.25 * RADIUS, 5,6: im Abstand 0.90*RADIUS */
void gummitop( double x1, double y1, double x2, double y2, double x3, double y3, double x4, double y4,
	       double x5, double y5, double x6, double y6, int stat)
 {
 /* hinten */
   
 glNormal3d(x3-x1,y3-y1,0.0);
 glColor3d(0.1, 0.1, 0.1);
 glVertex3d( x5, y5, 4.0/3.0 * RADIUS + 0.002);
 glVertex3d( x6, y6, 4.0/3.0 * RADIUS + 0.002);
 glVertex3d( x6, y6, 3.0/3.0 * RADIUS );
 glVertex3d( x5, y5, 3.0/3.0 * RADIUS );

 glNormal3d(0.0,0.0,1.0);

 /* oben */
 glColor3d(0.4, 0.4, 0.4);
 glVertex3d( x1, y1, 4.0/3.0 * RADIUS + 0.002 );
 glColor3d(0.4, 0.4, 0.4);
 glVertex3d( x2, y2, 4.0/3.0 * RADIUS + 0.002 );
 glColor3d(0.1, 0.1, 0.1);
 glVertex3d( x6, y6, 4.0/3.0 * RADIUS + 0.002 );
 glColor3d(0.1, 0.1, 0.1);
 glVertex3d( x5, y5, 4.0/3.0 * RADIUS + 0.002 );

 /* vorne schräg */
 glNormal3d(0.0,0.0,1.0);
 glColor3d(0.4, 0.4, 0.4);
 glVertex3d( x1, y1, 4.0/3.0 * RADIUS + 0.002 );
 glColor3d(0.1, 0.1, 0.1);
 glVertex3d( x4, y4, 3.5/3.0 * RADIUS);
 glColor3d(0.1, 0.1, 0.1);
 glVertex3d( x3, y3, 3.5/3.0 * RADIUS);
 glColor3d(0.4, 0.4, 0.4);
 glVertex3d( x2, y2, 4.0/3.0 * RADIUS + 0.002 );

 if( stat ) /* Endkappen malen. Im Moment wird ein Polygon ins Nirwana gemalt */
  {
  glColor3d(0.4, 0.4, 0.4);
  glVertex3d(x1, y1, 4.0/3.0 * RADIUS + 0.002);
  glColor3d(0.1, 0.1, 0.1);
  glVertex3d(x5, y5, 4.0/3.0 * RADIUS + 0.002);
  glColor3d(0.1, 0.1, 0.1);
  glVertex3d(x5, y5, 4.0/3.0 * RADIUS);
  glColor3d(0.1, 0.1, 0.1);
  glVertex3d(x3, y3, 3.5/3.0 * RADIUS);
  
  glColor3d(0.4, 0.4, 0.4);
  glVertex3d(x2, y2, 4.0/3.0 * RADIUS + 0.002);
  glColor3d(0.1, 0.1, 0.1);
  glVertex3d(x4, y4, 3.5/3.0 * RADIUS);
  glColor3d(0.1, 0.1, 0.1);
  glVertex3d(x6, y6, 4.0/3.0 * RADIUS);
  glColor3d(0.1, 0.1, 0.1);
  glVertex3d(x6, y6, 4.0/3.0 * RADIUS + 0.002);
  }
#ifdef DEBUG
 poly+=4;
#endif
 }

/* Tisch außen */
void outside(double x1, double y1, double x2, double y2 )
 {
 struct vect3 n, v;
 v.x = x2-x1;
 v.y = y2-y1;
 v.z = 0;
 calc_normal_ez(&n, &v);
 glNormal3f(n.x, n.y, n.z);
 glVertex3d( x1, y1, BFUNC(bfunc_max) );
 glVertex3d( x1, y1, -9.0/3.0*RADIUS-0.0011 );
 glVertex3d( x2, y2, -9.0/3.0*RADIUS-0.0011 );
 glVertex3d( x2, y2, BFUNC(bfunc_max) );
#ifdef DEBUG
 poly++;
#endif
 }

/* malt einen "Metallstreifen" der Mittel- und Ecktaschenverkleidung */
void metal_strip( double x1, double y1, double z1, double x2, double y2,  double z2,
		  double x3, double y3, double z3) 
 {
 double norm[3];
 calc_normal(norm, x1, y1, z1, x2, y2, z2, x3, y3, z3);
 glNormal3dv( norm );
 glVertex3d( x1, y1, z1 );
 glVertex3d( x2, y2, z2 );
#ifdef DEBUG
 poly++;
#endif
 }

void metal_strip_b( double x1, double y1, double z1, double x2, double y2,  double z2,
		    double x3, double y3, double z3, double x4, double y4, double z4 ) 
 {
 double norm[3], dum1,dum2;
 norm[0] = x3-x1;
 norm[1] = y3-y1;
 norm[2] = z3-z1;
 dum1 = sqrt(norm[0]*norm[0]+norm[1]*norm[1]+norm[2]*norm[2]);
 if( dum1 ) { norm[0] /= dum1; norm[1] /= dum1; norm[2] /= dum1;}
 dum1 = norm[2];
 dum2 = sqrt(norm[0]*norm[0]+norm[1]*norm[1]);
 if( dum2 == 0 ) {norm[0] = norm[1] = 0; norm[2] = 1;}
 else 
  {
  norm[2] =  dum2;
  norm[0] *= ABS(dum1);
  norm[1] *= ABS(dum1);
  }

 glNormal3dv( norm );
 glVertex3d( x1, y1, z1 );

 norm[0] = x4-x2;
 norm[1] = y4-y2;
 norm[2] = z4-z2;

 dum1 = sqrt(norm[0]*norm[0]+norm[1]*norm[1]+norm[2]*norm[2]);
 if( dum1 ) { norm[0] /= dum1; norm[1] /= dum1; norm[2] /= dum1;}
 dum1 = norm[2];
 dum2 = sqrt(norm[0]*norm[0]+norm[1]*norm[1]);
 if( dum2 == 0 ) {norm[0] = norm[1] = 0; norm[2] = 1;}
 else 
  {
  norm[2] =  dum2;
  norm[0] *= ABS(dum1);
  norm[1] *= ABS(dum1);
  }

 glNormal3dv( norm );
 glVertex3d( x2, y2, z2 );
#ifdef DEBUG
 poly++;
#endif
 }

/* Metall-Verblendung des Tisches außen (Ecktaschen) */
void metal_edge( double x1, double y1, double x2, double y2, double mx, double my, double *n1, double *n2, int stat ) 
 {
 double dummy;
 glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);
 glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifMetall);
 if( (dummy = sqrt(n1[0]*n1[0] + n1[1]*n1[1] + n1[2]*n1[2])) )
  {n1[0] /= dummy; n1[1] /= dummy; }
 if( (dummy = sqrt(n2[0]*n2[0] + n2[1]*n2[1] + n2[2]*n2[2] )) )
  {n2[0] /= dummy; n2[1] /= dummy; }
 
 /* Rand des Tisches */
 glBegin(GL_QUADS);
  glNormal3dv(n1);
  glVertex3d( x1, y1, BFUNC(bfunc_max) );
  glNormal3dv(n1);
  glVertex3d( x1, y1, -9.0/3.0*RADIUS-0.0011 );
  glNormal3dv(n2);
  glVertex3d( x2, y2, -9.0/3.0*RADIUS-0.0011 );
  glNormal3dv(n2);
  glVertex3d( x2, y2, BFUNC(bfunc_max)  );
 glEnd();

 glLightfv(GL_LIGHT1, GL_SPECULAR, LightZero);
 glLightfv(GL_LIGHT2, GL_SPECULAR, LightZero);

 /* unter dem Tisch */
 if( stat )
  {
  glDisable(GL_CULL_FACE);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifDark);
  glBegin(GL_TRIANGLES);
  glNormal3d(0,0,-1.0);
  glVertex3d( mx, my, -9.0/3.0*RADIUS-0.001 );
  glVertex3d( x1, y1, -9.0/3.0*RADIUS-0.001 );
  glVertex3d( x2, y2, -9.0/3.0*RADIUS-0.001 );
  glEnd();
  glEnable(GL_CULL_FACE);
  }
#ifdef DEBUG
 poly+=2;
#endif
 }

/* Metall-Verblendung des Tisches außen (Mitteltaschen) */
void metal_mid( double x1, double y1, double x2, double y2 ) 
 {
 glVertex3d( x1, y1,  BFUNC(bfunc_max)  );
 glVertex3d( x1, y1, -9.0/3.0*RADIUS-0.0011 );
 glVertex3d( x2, y2, -9.0/3.0*RADIUS-0.0011 );
 glVertex3d( x2, y2,  BFUNC(bfunc_max)  );
#ifdef DEBUG
 poly++;
#endif
 }

/* ;-) Unterseite des kompletten Tisches */
void underside( double x1, double y1, double x2, double y2 )
 {
/*   glTexCoord2d( 0.0,1.0 ); */
  glVertex3d( x1, y1, -3.0 * RADIUS -0.001);
/*   glTexCoord2d( 1.0,1.0 ); */
  glVertex3d( x1, y2, -3.0 * RADIUS -0.001);
/*   glTexCoord2d( 1.0,0.0 ); */
  glVertex3d( x2, y2, -3.0 * RADIUS -0.001);
/*   glTexCoord2d( 0.0,0.0 ); */
  glVertex3d( x2, y1, -3.0 * RADIUS -0.001);
#ifdef DEBUG
 poly++;
#endif
 }

#define TABLE_COLOR(add) \
  switch( table_color ) \
   {\
   case TABLE_BLUE:  glColor4f( 0.2+(add)/3.0, 0.2+(add)/3.0, 0.4+(add), 1.0); break;\
   case TABLE_GREEN: glColor4f( 0.0, 0.4+(add), 0.0, 1.0); break;\
   case TABLE_RED:   glColor4f( 0.4+(add), 0.1, 0.1, 1.0); break;\
   }

/* Displaylisten für den Tisch */
void gl_init_lists(void)
 {
 double x1, y1, x2, y2, xo1=0, xo2=0, yo1=0, yo2=0;
 double rad = 28.0 / 1000.0;      /* exakt wäre eigentlich rad = 27.841;*/ /* gemalter Radius der Taschen-"Rückseite" */
 double rad_outer = 64.00/1000.0; /* stimmt exakt! */
 double ls, ms, msstep, ns, nsstep;
 double n1[3], n2[3];
 int i,j,l,m,n,step=1,stepouter=1, stat, dum_int;
 double r_Kante = 0.0045, dummy, txtstep=500.0;
 struct vect3 norm;
 poly = 0;

 glNewList(400,GL_COMPILE);
 icosphere(ico20,20,RADIUS);
 glEndList();

 glNewList(401,GL_COMPILE);
 icosphere(ico80,80,RADIUS);
 glEndList();

 glNewList(402,GL_COMPILE);
 icosphere(ico320,320,RADIUS);
 glEndList();

 glNewList(403,GL_COMPILE);
 icosphere(ico1280,1280,RADIUS);
 glEndList();

 glNewList(404,GL_COMPILE);
 icosphere(ico5120,5120,RADIUS);
 glEndList();

 glNewList(405,GL_COMPILE);
 icosphere(ico20480,20480,RADIUS);
 glEndList();

 glNewList(257, GL_COMPILE );

 if( shadows != STENCIL_SHADOWS2 )
  {
  glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);
  glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
  }
 else
  {
  glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular_multi);
  glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular_multi);
  }

 glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpcLow);
 glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmb);

 if( display_floor_textures ) 
  {
  glColor4d(1.0, 1.0, 1.0, 1.0);
  switch(table_color)
   {
   case TABLE_GREEN: glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTableTextgreen); break;
   case TABLE_RED:   glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTableTextred);   break;
   case TABLE_BLUE:  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTableTextblue);  break;
   }
  }
 else  
  {
  glColor4d(1.0, 1.0, 1.0, 1.0);
  switch(table_color)
   {
   case TABLE_GREEN: glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTablegreen); break;
   case TABLE_RED:   glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTablered);   break;
   case TABLE_BLUE:  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTableblue);  break;
   }
  }
 
 glNormal3d( 0.0, 0.0, 1.0);

 if( display_floor_textures ) /* Tischtextur */ 
   {
   glEnable(GL_TEXTURE_2D);
   glBindTexture(GL_TEXTURE_2D, texture[35]);
   }

 /* Tischtuch malen */
 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: step = 5;   stepouter=10;  txtstep=125.0; break;
  case DETAIL_HIGH:     step = 25;  stepouter=20;  txtstep=125.0; break;
  case DETAIL_MED:      step = 50;  stepouter=40;  txtstep=250.0; break;
  case DETAIL_LOW:      step = 125; stepouter=80;  txtstep=250.0; break;
  case DETAIL_VERYLOW:  step = 250; stepouter=240; txtstep=500.0; break;
  }
 for(j=-250;j<250;j+=step)
   {
     glBegin(GL_QUAD_STRIP);
     tuch_strips( (double)-485.0/1000.0, (double)j/1000.0, (double)-485.0/1000.0, (double)(j+step)/1000.0,
		  (-485.0)/txtstep, (j+step)/txtstep, (-485.0)/txtstep, ((j))/txtstep);
     for( i=-480;i<=480;i+=stepouter)
       { tuch_strips( (double)i/1000.0, (double)j/1000.0, (double)i/1000.0, (double)(j+step)/1000.0,
		      (i)/txtstep, (j+step)/txtstep, (i)/txtstep, ((j))/txtstep); }
     tuch_strips( (double)485.0/1000.0, (double)j/1000.0, (double)485.0/1000.0, (double)(j+step)/1000.0,
		  (485.0)/txtstep, (j+step)/txtstep, (485.0)/txtstep, ((j))/txtstep);
     glEnd();
   }

 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: step = 5;  stepouter=10; break;
  case DETAIL_HIGH:     step = 20; stepouter=15; break;
  case DETAIL_MED:      step = 20; stepouter=30; break;
  case DETAIL_LOW:      step = 20; stepouter=30; break;
  case DETAIL_VERYLOW:  step = 20; stepouter=30; break;
  }

 /* fehlendes Tuch an den langen Banden zwischen Eck- und Mitteltaschen */
 for(j=250;j<270;j+=step)
  {
  glBegin(GL_QUAD_STRIP);
  for( i=30;i<=480;i+=stepouter)
   { tuch_strips( (double)i/1000.0, (double)j/1000.0, (double)i/1000.0, (double)(j+step)/1000.0,
		  (i)/txtstep, (j+step)/txtstep, (i)/txtstep, (j)/txtstep); }
  tuch_strips( (double)485.0/1000.0, (double)j/1000.0, (double)485.0/1000.0, (double)(j+step)/1000.0,
	       (485.0)/txtstep, (j+step)/txtstep, (485.0)/txtstep, (j)/txtstep); 

  glEnd();
  }
 for(j=250;j<270;j+=step)
  {
  glBegin(GL_QUAD_STRIP);
  for( i=30;i<=480;i+=stepouter)
   { tuch_strips( -(double)i/1000.0, -(double)j/1000.0, -(double)i/1000.0, -(double)(j+step)/1000.0,
		  (-i)/txtstep, -(j+step)/txtstep, (-i)/txtstep, -j/txtstep); }
  tuch_strips( -(double)485.0/1000.0, -(double)j/1000.0, -(double)485.0/1000.0, -(double)(j+step)/1000.0,
	       (-485.0)/txtstep, -(j+step)/txtstep, (-485.0)/txtstep, -j/txtstep);
  glEnd();
  }
 for(j=250;j<270;j+=step)
  {
  glBegin(GL_QUAD_STRIP);
  for( i=30;i<=480;i+=stepouter)
   { tuch_strips( -(double)i/1000.0, (double)(j+step)/1000.0, -(double)i/1000.0, (double)j/1000.0,
		  (-i)/txtstep, (j)/txtstep, (-i)/txtstep, (j+step)/txtstep); }
  tuch_strips( -(double)485.0/1000.0, (double)(j+step)/1000.0, -(double)485.0/1000.0, (double)j/1000.0,
	       (-485.0)/txtstep, (j)/txtstep, (-485.0)/txtstep, (j+step)/txtstep);
  glEnd();
  }
 for(j=250;j<270;j+=step)
  {
  glBegin(GL_QUAD_STRIP);
  for( i=30;i<=480;i+=stepouter)
   { tuch_strips( (double)i/1000.0, -(double)(j+step)/1000.0, (double)i/1000.0, -(double)j/1000.0,
		  (i)/txtstep, -(j)/txtstep, (i)/txtstep, -(j+step)/txtstep); }
  tuch_strips( (double)485.0/1000.0, -(double)(j+step)/1000.0, (double)485.0/1000.0, -(double)j/1000.0,
	       (485.0)/txtstep, -(j)/txtstep, (485.0)/txtstep, -(j+step)/txtstep);
  glEnd();
  }

 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: stepouter=10; break;
  case DETAIL_HIGH:     stepouter=20; break;
  case DETAIL_MED:      stepouter=20; break;
  case DETAIL_LOW:      stepouter=20; break;
  case DETAIL_VERYLOW:  stepouter=230; break;
  }

 /* fehlendes Tuch an den kurzen Banden */
 for(i=-520;i<-480;i+=step)
  {
  glBegin(GL_QUAD_STRIP);
  tuch_strips( (double)i/1000.0, (double)235.0/1000.0, (double)(i+step)/1000.0, (double)235.0/1000.0,
	       (i+step)/txtstep, (235.0)/txtstep, (i)/txtstep, (235.0)/txtstep);
  for(j=-230;j<=230;j+=stepouter)
   { 
   tuch_strips( (double)i/1000.0, -(double)j/1000.0, (double)(i+step)/1000.0, -(double)j/1000.0,
		(i+step)/txtstep, (-j)/txtstep, (i)/txtstep, (-j)/txtstep); 
   }
  tuch_strips( (double)i/1000.0, -(double)235.0/1000.0, (double)(i+step)/1000.0, -(double)235.0/1000.0,
	       (i+step)/txtstep, (-235.0)/txtstep, (i)/txtstep, (-235.0)/txtstep);
  glEnd();
  }
 for(i=480;i<520;i+=step)
  {
  glBegin(GL_QUAD_STRIP);
  tuch_strips( (double)(i+step)/1000.0, (double)-235.0/1000.0, (double)i/1000.0, (double)-235.0/1000.0,
	       (i)/txtstep, (-235.0)/txtstep, (i+step)/txtstep, (-235.0)/txtstep); 
  for(j=-230;j<=230;j+=stepouter)
   { 
   tuch_strips( (double)(i+step)/1000.0, (double)j/1000.0, (double)i/1000.0, (double)j/1000.0,
		(i)/txtstep, (j)/txtstep, (i+step)/txtstep, (j)/txtstep); 
   }
  tuch_strips( (double)(i+step)/1000.0, (double)235.0/1000.0, (double)i/1000.0, (double)235.0/1000.0,
	       (i)/txtstep, (235.0)/txtstep, (i+step)/txtstep, (235.0)/txtstep); 
  glEnd();
  }

 /* Ausschnitte der Ecktaschen und Abrundung der Kante */
 
 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: step = 1;  break;
  case DETAIL_HIGH:     step = 3;  break;
  case DETAIL_MED:      step = 9;  break;
  case DETAIL_LOW:      step = 18; break;
  case DETAIL_VERYLOW:  step = 45; break;
  }

 for(i=-1;i<=1;i+=2)
  {
  glPushMatrix();
  glTranslatef((posl[1].p.x-0.5)*i,0.0,0.0);
  for(j=-1;j<=1;j+=2)
   {
   glPushMatrix();
   glTranslatef(0.0,j*(posl[1].p.y-0.25) ,0.0);
   if( i == -1 && j == -1 ) glRotatef(180,0.0,0.0,1.0);
   else if( i == 1  && j == -1 ) glRotatef(-90,0.0,0.0,1.0);
   else if( i == -1  && j == 1 ) glRotatef(+90,0.0,0.0,1.0);

   glNormal3d( 0.0, 0.0, 1.0);

   glBegin(GL_TRIANGLE_FAN);
   glTexCoord2d(((posl[1].p.x-0.5)+0.04125)*1000.0/txtstep,((posl[1].p.y-0.25)+0.04125)*1000.0/txtstep);
   glVertex3d(0.04125,0.04125,0);
   for(l=90;l>=0;l-=step )  /* malt die Rundung der Taschen "in" der Tischplatte, 0-90 Grad */
    {                      /* und füllt den Bereich bis dorthin aus */
    x1 = posl[1].r/DIFFX * cos((double)l*M_PI/180.0);
    y1 = posl[1].r/DIFFX * sin((double)l*M_PI/180.0);
    glTexCoord2d(((posl[1].p.x-0.5)+x1)*1000/txtstep,((posl[1].p.y-0.25)+y1)*1000/txtstep);
    glVertex3d(x1,y1,0);
#ifdef DEBUG
    poly++;
#endif
    }
   glEnd();
   for(n=0;n<90;n+=step) /* Hier wird die Abrundung der Kante gemalt. (Radius 1/4-1/2 Zoll) */
    {
    yo1 = -r_Kante * (1.0-cos((double)n*M_PI/180.0));
    yo2 = -r_Kante * (1.0-cos((double)(n+step)*M_PI/180.0));
    glBegin(GL_QUAD_STRIP);
    for(l=0;l<=90;l+=step )
     {
     x1 = (posl[1].r/DIFFX-r_Kante*sin((n+step)*M_PI/180.0)) * cos((double)l*M_PI/180.0);
     y1 = (posl[1].r/DIFFX-r_Kante*sin((n+step)*M_PI/180.0)) * sin((double)l*M_PI/180.0);
     dummy = sqrt(x1*x1+y1*y1);
     norm.x = -x1/dummy * (1.0-cos((n+step)*M_PI/180.0));
     norm.y = -y1/dummy * (1.0-cos((n+step)*M_PI/180.0));
     norm.z = (1.0-sin((n+step)*M_PI/180.0));
     glNormal3f(norm.x, norm.y, norm.z);
     glVertex3d( x1, y1, yo2);
     x1 = (posl[1].r/DIFFX-r_Kante*sin(n*M_PI/180.0)) * cos((double)l*M_PI/180.0);
     y1 = (posl[1].r/DIFFX-r_Kante*sin(n*M_PI/180.0)) * sin((double)l*M_PI/180.0);
     dummy = sqrt(x1*x1+y1*y1);
     norm.x = -x1/dummy * (1.0-cos(n*M_PI/180.0));
     norm.y = -y1/dummy * (1.0-cos(n*M_PI/180.0));
     norm.z = (1.0-sin(n*M_PI/180.0));
     glNormal3f(norm.x, norm.y, norm.z);
     glVertex3d(x1, y1, yo1);		;
#ifdef DEBUG
     poly++;
#endif
     }
    glEnd();
    }
   glPopMatrix();
   }
  glPopMatrix();
  }

 /* jetzt das gleiche für die Mitteltaschen. Erst die Ausschnitte */ 
 /* und dann die Abrundung der Kante, Radius wie oben 1/4-1/2 Zoll so etwa */
 for(i=-1;i<=1;i+=2)
  {
  glPushMatrix();
  glTranslatef((posl[5].p.x-0.5),i*(posl[5].p.y-0.25),0.0);
  glRotatef((i-1)/2*180.0,0.0,0.0,1.0);

  glNormal3d( 0.0, 0.0, 1.0);
  glBegin(GL_QUAD_STRIP);
  for(l=-180;l<=0;l+=step)
   {
   x1 = posl[5].r/DIFFX * cos((double)l*M_PI/180.0);
   y1 = posl[5].r/DIFFX * sin((double)l*M_PI/180.0);
   glTexCoord2d(((posl[5].p.x-0.5)+x1)*1000/txtstep,((posl[5].p.y-0.25)+y1)*1000/txtstep);
   glVertex3d(x1,y1,0.0);
   glTexCoord2d(((posl[5].p.x-0.5)+x1)*1000/txtstep,((posl[5].p.y-0.25)-0.03575)*1000/txtstep);
   glVertex3d(x1,-0.03575,0.0);
#ifdef DEBUG
   poly++;
#endif
   }
  glEnd();
  for(n=0;n<90;n+=step) 
   {
   yo1 = -r_Kante * (1.0-cos((double)n*M_PI/180.0));
   yo2 = -r_Kante * (1.0-cos((double)(n+step)*M_PI/180.0));
   glBegin(GL_QUAD_STRIP);
   for(l=0;l>=-180;l-=step )
    {
    x1 = (posl[5].r/DIFFX-r_Kante*sin(n*M_PI/180.0)) * cos((double)l*M_PI/180.0);
    y1 = (posl[5].r/DIFFX-r_Kante*sin(n*M_PI/180.0)) * sin((double)l*M_PI/180.0);
    dummy = sqrt(x1*x1+y1*y1);
    norm.x = -x1/dummy * (1.0-cos(n*M_PI/180.0));
    norm.y = -y1/dummy * (1.0-cos(n*M_PI/180.0));
    norm.z = (1.0-sin(n*M_PI/180.0));
    glNormal3f(norm.x, norm.y, norm.z);
    glVertex3d(x1, y1, yo1);		;
    x1 = (posl[5].r/DIFFX-r_Kante*sin((n+step)*M_PI/180.0)) * cos((double)l*M_PI/180.0);
    y1 = (posl[5].r/DIFFX-r_Kante*sin((n+step)*M_PI/180.0)) * sin((double)l*M_PI/180.0);
    dummy = sqrt(x1*x1+y1*y1);
    norm.x = -x1/dummy * (1.0-cos((n+step)*M_PI/180.0));
    norm.y = -y1/dummy * (1.0-cos((n+step)*M_PI/180.0));
    norm.z = (1.0-sin((n+step)*M_PI/180.0));
    glNormal3f(norm.x, norm.y, norm.z);
    glVertex3d(x1, y1, yo2);
#ifdef DEBUG
   poly++;
#endif
    }
   glEnd();
   }
  glPopMatrix();
  }

 if( display_textures || display_floor_textures ) glDisable(GL_TEXTURE_2D); /* Ende der "floor-texture" */

 /* Schatten der Bande muss vor den ganzen "Aufbauten" gemalt werden 
  wegen abgeschaltetem z-Buffer */
 glDisable(GL_LIGHTING);
 glEnable(GL_BLEND);
 glDisable(GL_DEPTH_TEST);

 for(j=-1;j<=1;j+=2)
  for(i=-1;i<=1;i+=2)
   {
   glBegin(GL_QUADS);
   if( i*j == -1 ) glFrontFace(GL_CW);
   else glFrontFace(GL_CCW);
   glColor4f( 0.0, 0.0, 0.0, 0.5);
   glVertex3d( 0.490*j, 0.270*i, 0.0 );
   glVertex3d( 0.027*j, 0.270*i, 0.0 );
   glColor4f( 0.0, 0.0, 0.0, 0.0);
   glVertex3d( 0.032*j, 0.250*i, 0.0 );
   glVertex3d( 0.460*j, 0.250*i, 0.0 );
   glEnd();
#ifdef DEBUG
   poly++;
#endif
   }
 for(i=-1;i<=1;i+=2)
  {
  if( i==1 ) glFrontFace(GL_CCW);
  else glFrontFace(GL_CW);
  glBegin(GL_QUADS);
  glColor4f( 0.0, 0.0, 0.0, 0.5);
  glVertex3d( 0.520*i, -0.240, 0.0 );
  glVertex3d( 0.520*i, 0.240, 0.0 );
  glColor4f( 0.0, 0.0, 0.0, 0.0);
  glVertex3d( 0.500*i,  0.210, 0.0 );
  glVertex3d( 0.500*i,  -0.210, 0.0 );
  glEnd();
#ifdef DEBUG
  poly++;
#endif
  }
 glFrontFace(GL_CCW);
 
 /* Fussfeldlinie ebenfalls vor den Aufbauten malen, z-Buffer
  weiterhin ausgeschaltet */
 
 glBegin(GL_QUAD_STRIP);
 glColor4f( 0.9, 0.9, 0.9, 0.0);
 glVertex3d( -0.2485, -0.280, 0.001);
 glVertex3d( -0.2485, 0.280, 0.001);
 glColor4f(  0.9, 0.9, 0.9, 0.8);
 glVertex3d( -0.250, -0.280, 0.001);
 glVertex3d( -0.250, 0.280, 0.001);
 glColor4f(  0.9, 0.9, 0.9, 0.001);
 glVertex3d( -0.2515, -0.280, 0.001);
 glVertex3d( -0.2515, 0.280, 0.001);
 glEnd();
#ifdef DEBUG
 poly++;
#endif

 glEnable(GL_DEPTH_TEST);
 glEnable(GL_LIGHTING);
 
 glEndList();

 /* Tischholz und Banden */

 glNewList(258, GL_COMPILE );

 if( display_textures )
  {
  glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
  glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);

  glMaterialf(GL_FRONT, GL_SHININESS, MatShn);
  glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmb);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifWood);
  glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpcWood);
  glColor4d(0.5, 0.3, 0.1,1.0);
 
  glEnable(GL_TEXTURE_2D);
  switch(table_color)
   {
   case TABLE_GREEN:  glBindTexture(GL_TEXTURE_2D, texture[33]); break;
   case TABLE_BLUE:   glBindTexture(GL_TEXTURE_2D, texture[34]); break;
   case TABLE_RED:    
    glDisable(GL_TEXTURE_2D); 
    glMaterialfv(GL_FRONT, GL_DIFFUSE, MatNull); 
    glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc); 
    break;
   }
  }
 else
  {
  glLightfv(GL_LIGHT2, GL_SPECULAR, MatNull);
  glLightfv(GL_LIGHT1, GL_SPECULAR, MatNull);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifWood);
  glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpcWood);

  glColor4d(0.5, 0.3, 0.1,1.0);
  }
 
 /* Holz: lange Banden */
 /* Rasterung der Kante nach außen hin, seitlich gesehen*/
 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: step = 1;  stepouter = 5;  break;
  case DETAIL_HIGH:     step = 2;  stepouter = 10; break;
  case DETAIL_MED:      step = 5;  stepouter = 25; break;
  case DETAIL_LOW:      step = 5;  stepouter = 50; break;
  case DETAIL_VERYLOW:  step = 10; stepouter = 50; break;
  }

 for(i=-489;i<=39;i+=528)
  {
  for(j=0;j<=180;j+=180)
   {
   glPushMatrix();
   glRotatef(j,0.0,0.0,1.0);
   glTranslatef(i/1000.0,0.0,0.0);
   for( l=0;l<450;l+=stepouter)
    {
    ls = l/1000.0;
    glBegin(GL_QUAD_STRIP);
    for(m=bfunc_max;m>=0;m-=step)
     {
     ms=m/1000.0;
     msstep=ms + step/1000.0;
     holz_strip( ls,         0.270+ms,     BFUNC(m),
		 (ls+stepouter/1000.0), 0.270+ms,     BFUNC(m),
		 ls,         0.270+msstep, BFUNC(m+step),
		 (l)/450.0, (50.0-m)/50.0, (l+stepouter)/450.0, (50.0-m)/50.0);
     }
    glEnd();
    }
   glPopMatrix();
   }
  }

 /* Holz: kurze Banden, erst den "mittleren" Teil */
 for(i=0;i<=180;i+=180)
  {
  glPushMatrix();
  glRotatef(i,0.0,0.0,1.0);
  for(l=-200;l<200;l+=stepouter)
   {
   ls = l/1000.0;
   glBegin(GL_QUAD_STRIP);
   for(m=bfunc_max;m>=0;m-=step)
    {
    ms=m/1000.0;
    msstep=ms + step/1000.0;
    holz_strip( (0.520+ms),      ls+stepouter/1000.0, BFUNC(m),
		(0.520+ms),      ls,                  BFUNC(m),
		(0.520+msstep),  ls,                  BFUNC(m+step),
		(240.0+l+stepouter)/480.0, (bfunc_max-m)/bfunc_max, (240.0+l)/480.0, (bfunc_max-m)/bfunc_max);
    }
   glEnd();
   }
  
  /* seitliche fehlende Stücke zur kurzen Bande */
  glBegin(GL_QUAD_STRIP);
  for(m=bfunc_max;m>=0;m-=step)
   {
   ms=m/1000.0;
   msstep=ms + step/1000.0;
   holz_strip(  (0.520+ms),      0.239, BFUNC(m),
		(0.520+ms),      0.200, BFUNC(m),
		(0.520+msstep),  0.200, BFUNC(m+step),
		(240.0+240)/480.0, (bfunc_max-m)/bfunc_max, (240.0+200)/480.0, (bfunc_max-m)/bfunc_max);
   }
  glEnd();
  glBegin(GL_QUAD_STRIP);
  for(m=bfunc_max;m>=0;m-=step)
   {
   ms=m/1000.0;
   msstep=ms + step/1000.0;
   holz_strip(  (0.520+ms),      -0.200, BFUNC(m),
		(0.520+ms),      -0.239, BFUNC(m),
		(0.520+msstep),  -0.200, BFUNC(m+step),
		-(240.0+200)/480.0, (bfunc_max-m)/bfunc_max, -(240.0+240)/480.0, (bfunc_max-m)/bfunc_max);
   }
  glEnd();
  glPopMatrix();
  }
 glEnd(); /* End of Quads for the "rail-wood" */
 
 if( display_textures ) glDisable(GL_TEXTURE_2D);

 for(l=-1;l<=1;l+=2)
  {
  glPushMatrix();
  glTranslatef(0.516*l,0.0,0.0);
  for( m=-1; m<=1; m+=2)
   {
   glPushMatrix();
   glTranslatef(0.0,m*0.266,0.0);
   if( l == -1 && m == -1 ) glRotatef(180,0.0,0.0,1.0);
   else if( l == 1  && m == -1 ) glRotatef(-90,0.0,0.0,1.0);
   else if( l == -1  && m == 1 ) glRotatef(+90,0.0,0.0,1.0);
  
   /* stepouter: Rasterung des Kreises der Gummiverkleidung der Ecktaschen von oben gesehen ;-), GoodQ:10 */
   switch(geo_detail)
    {
    case DETAIL_VERYHIGH: stepouter = 2;  break;
    case DETAIL_HIGH:     stepouter = 5;  break;
    case DETAIL_MED:      stepouter = 10; break;
    case DETAIL_LOW:      stepouter = 25; break;
    case DETAIL_VERYLOW:  stepouter = 50; break;
    }

   for(i=280;i<530;i+=stepouter)
    {
    x1 = rad * cos( (double)i* M_PI / 180.0 );
    y1 = rad * sin( (double)i* M_PI  / 180.0 );
    x2 = rad * cos( (double)(i+stepouter) * M_PI / 180.0 );
    y2 = rad * sin( (double)(i+stepouter) * M_PI  / 180.0 );
    
    /* zuerst die Taschenhinterseiten*/ 
    glMaterialfv(GL_FRONT, GL_DIFFUSE, MatGummi);
    glMaterialfv(GL_FRONT, GL_SPECULAR, MatNull);
    glMaterialf(GL_FRONT, GL_SHININESS, 0.0);
    
    glNormal3d(-x1/sqrt(x1*x1+y1*y1),-y1/sqrt(x1*x1+y1*y1),0.0);
    glDisable(GL_CULL_FACE);
    glBegin(GL_QUADS);
    gummi( x1, y1, x2, y2 );
    glEnd();
    glEnable(GL_CULL_FACE);
    glDisable(GL_LIGHTING);
    glBegin(GL_QUADS);
    if( i==280 || i >= 530-stepouter ) stat=1; /* f. Gummi-Endkappen */
    else stat=0;
    /* dann die Gummiverkleidung "auf" den Taschen */
    if( env_map) /* sphärisches Env-Mapping wieder ausschalten */
     {
     glDisable(GL_TEXTURE_GEN_R);
     glDisable(GL_TEXTURE_GEN_S);
     glDisable(GL_TEXTURE_GEN_T);
     glDisable(GL_TEXTURE_2D);
     }

    gummitop( (rad*0.85 * cos( (double)(i+stepouter)* M_PI / 180.0 )),
	      (rad*0.85 * sin( (double)(i+stepouter)* M_PI / 180.0 )),
	      (rad*0.85 * cos( (double)i* M_PI / 180.0 )),
     	      (rad*0.85 * sin( (double)i* M_PI / 180.0 )),
	      x1,  y1, x2, y2,
	      (rad*1.15 * cos( (double)(i+stepouter)* M_PI / 180.0 )),
	      (rad*1.15 * sin( (double)(i+stepouter)* M_PI / 180.0 )),
	      (rad*1.15 * cos( (double)i* M_PI / 180.0 )),
	      (rad*1.15 * sin( (double)i* M_PI / 180.0 )), stat);
    glEnd();
    glEnable(GL_LIGHTING);
    }
   
   /* "Metall" Taschenverblendungen */
 
   /* stepouter: Rasterung der Ecktaschenradien außen, von oben gesehen 1,2,4 sind vernündtige Werte, 3 nicht!,  GoodQ:2*/
   /* step_:     Rasterung der Neigung der Metallverblendung der Ecktaschen nach außen hin, seitlich gesehen ;-) GoodQ:5*/
   
   switch(geo_detail)
    {
    case DETAIL_VERYHIGH: step = 1; stepouter = 1; break;
    case DETAIL_HIGH:     step = 2; stepouter = 2; break;
    case DETAIL_MED:      step = 3; stepouter = 5; break;
    case DETAIL_LOW:      step = 5; stepouter = 5; break;
    case DETAIL_VERYLOW:  step = 10; stepouter = 10; break;
    }

 for(i=280;i<530;i+=stepouter)
   {
   struct vect v1,v2;
   /* Punkte auf innerem Radius berechnen */
   x1 = rad * cos( (double)i* M_PI / 180.0 );
   y1 = rad * sin( (double)i* M_PI  / 180.0 );
   x2 = rad * cos( (double)(i+stepouter) * M_PI / 180.0 );
   y2 = rad * sin( (double)(i+stepouter) * M_PI  / 180.0 );
   
   /* Punkte auf äußerem Radius berechnen */
   xo1 = rad_outer * cos( (double)i* M_PI / 180.0 );
   yo1 = rad_outer * sin( (double)i* M_PI  / 180.0 );
   xo2 = rad_outer * cos( (double)(i+stepouter) * M_PI / 180.0 );
   yo2 = rad_outer * sin( (double)(i+stepouter) * M_PI  / 180.0 );
   
   /* Verbindungsvektoren bestimmen */
   v1.x = xo1-x1;
   v1.y = yo1-y1;
   v2.x = xo2-x2;
   v2.y = yo2-y2;
   
   if( display_textures )
    {
    glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
    glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);
    
    glMaterialf(GL_FRONT, GL_SHININESS, MatShn);
    glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc);

    if( env_map ) /* sphärisches Environment-Mapping anschalten */
     {
     glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
     glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
     glEnable(GL_TEXTURE_GEN_S);
     glEnable(GL_TEXTURE_GEN_T);
     glBindTexture(GL_TEXTURE_2D, texture[36]);
     glEnable(GL_TEXTURE_2D);
     }
    }
   else
    {
    glLightfv(GL_LIGHT2, GL_SPECULAR, MatNull);
    glLightfv(GL_LIGHT1, GL_SPECULAR, MatNull);
    }
   glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifMetall);
   
   if( i >= 360 && i < 450 ) /* der 90-Grad Bereich der Ecken */
    {
    glBegin(GL_QUAD_STRIP);
    for(n=bfunc_max;n>=24;n-=step)
     {
     /* Metalleckkappenteil malen entlang der Verbindungsvektoren 
     ausgehend von einem inneren Punkt */
     metal_strip_b( (x1+v1.x/36.0*(n-24)),        (y1+v1.y/36.0*(n-24)),      BFUNC(n),
		    (x2+v2.x/36.0*(n-24)),        (y2+v2.y/36.0*(n-24)),      BFUNC(n),
		    (x1+v1.x/36.0*(n-24+step)),   (y1+v1.y/36.0*(n-24+step)), BFUNC(n+step),
		    (x2+v2.x/36.0*(n-24+step)),   (y2+v2.y/36.0*(n-24+step)), BFUNC(n+step));
     }
    glEnd();
    n1[0] = xo1-x1;
    n1[1] = yo1-y1;
    n1[2] = 0;
    n2[0] = xo2-x2;
    n2[1] = yo2-y2;
    n2[2] = 0;
    metal_edge(xo1, yo1, xo2, yo2, 0, 0, n1, n2, 1);

    }
   else if( i < 360 ) /* Kopfbandenteil */
    {
    glBegin(GL_QUAD_STRIP);
    for(n=bfunc_max;n>=(x2-0.004)*1000.0;n-=step)
     {
     ns = n/1000.0;
     nsstep=ns + step/1000.0;
     metal_strip_b( (0.004+ns),     -0.027, BFUNC(n),
		    (0.004+ns),     y2,     BFUNC(n),
		    (0.004+nsstep), -0.027, BFUNC(n+step),
		    (0.004+nsstep), y2,     BFUNC(n+step));
     }
    glEnd();
    xo1=rad_outer; yo1=y1;
    xo2=rad_outer; yo2=y2;
    n1[0] = xo1-x1;
    n1[1] = yo1-y1;
    n1[2] = 0;
    n2[0] = xo2-x2;
    n2[1] = yo2-y2;
    n2[2] = 0;
    metal_edge(xo1, yo1, xo2, yo2, 0, 0, n1, n2, 0);
    }
   else if( i >= 450 ) /* Rest der Metallverblendung an der langen Bande */
    {
    dum_int = (y2-0.004)*1000.0;
    glBegin(GL_QUAD_STRIP);
    for(n=bfunc_max;n>=dum_int;n-=step)
     {
     ns = n/1000.0;
     nsstep=ns + step/1000.0;
     metal_strip_b( x1,     (0.004+ns),     BFUNC(n),
		    -0.027, (0.004+ns),     BFUNC(n),
		    x1,     (0.004+nsstep), BFUNC(n+step),
		    -0.027, (0.004+nsstep), BFUNC(n+step));
     }
    glEnd();
    xo1=x1; yo1=rad_outer; /* f. metal_edge */
    xo2=x2; yo2=rad_outer;
    n1[0] = xo1-x1;
    n1[1] = yo1-y1;
    n1[2] = 0;
    n2[0] = xo2-x2;
    n2[1] = yo2-y2;
    n2[2] = 0;
    metal_edge(xo1, yo1, xo2, yo2, 0, 0, n1, n2, 0);
    }
   }
   glPopMatrix();
   }
  glPopMatrix();
  }

 if( env_map) /* sphärisches Env-Mapping wieder ausschalten */
  {
  glDisable(GL_TEXTURE_GEN_R);
  glDisable(GL_TEXTURE_GEN_S);
  glDisable(GL_TEXTURE_GEN_T);
  glDisable(GL_TEXTURE_2D);
  }

 glColor4d(0.5,0.5,0.5,1.0);
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatGummi);

 /* step: Innenkreise der Mitteltaschen, Gummiverblendung von oben gesehen 
    (Metallverblendung nicht!!) ;-) */

 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: step = 2; break;
  case DETAIL_HIGH:     step = 5; break;
  case DETAIL_MED:      step = 10; break;
  case DETAIL_LOW:      step = 15; break;
  case DETAIL_VERYLOW:  step = 30; break;
  }

 for(j=-1;j<=1;j+=2)
  {
  glPushMatrix();
  glTranslatef(0.0,j*0.2775,0.0);
  glRotatef(180.0*(j-1)/2,0.0,0.0,1.0);

  for(i=-15;i<195;i+=step)
    {
    x1 = rad * cos( (double)i* M_PI / 180.0 ); 
    y1 = rad * sin( (double)i* M_PI  / 180.0 );
    glBegin(GL_QUADS); /* KANN MAN NOCH DURCH QUAD_STRIPS ERSETZEN */
    glNormal3d(-x1/sqrt(x1*x1+y1*y1),-y1/sqrt(x1*x1+y1*y1),0.0);

    gummi( x1, y1,
	   (x2 = rad * cos( (double)(i+step) * M_PI / 180.0 )), 
	   (y2 = rad * sin( (double)(i+step) * M_PI  / 180.0 )) );
    glEnd();
    if( i==-15 || i>=195-step) stat = 1;
    else stat=0;
    glDisable(GL_LIGHTING);
    glBegin(GL_QUADS);
    gummitop( (rad*0.85 * cos( (double)(i+step)* M_PI / 180.0 )),
	      (rad*0.85 * sin( (double)(i+step)* M_PI / 180.0 )),
	      (rad*0.85 * cos( (double)i* M_PI / 180.0 )),
	      (rad*0.85 * sin( (double)i* M_PI / 180.0 )),
	      x1, y1, x2, y2,
	      (rad*1.15 * cos( (double)(i+step)* M_PI / 180.0 )),
	      (rad*1.15 * sin( (double)(i+step)* M_PI / 180.0 )),
	      (rad*1.15 * cos( (double)i* M_PI / 180.0 )),
	      (rad*1.15 * sin( (double)i* M_PI / 180.0 )), stat);
    glEnd();
    glEnable(GL_LIGHTING);
    }
  glPopMatrix();
  }
 
 if( display_textures )
  {
  glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
  glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);

  glMaterialf(GL_FRONT, GL_SHININESS, MatShn);
  glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc);

  if( env_map )
   {
   glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
   glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
   glEnable(GL_TEXTURE_GEN_S);
   glEnable(GL_TEXTURE_GEN_T);
   glEnable(GL_TEXTURE_2D);
   glBindTexture(GL_TEXTURE_2D, texture[36]);
   }
  }
 else
  {
  glLightfv(GL_LIGHT2, GL_SPECULAR, MatNull);
  glLightfv(GL_LIGHT1, GL_SPECULAR, MatNull);
  }
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifMetall);

 /* stepouter: Rasterung des Innenkreises der Mitteltaschen für die Metallverblendung! von oben gesehen, GoodQ:5 */
 /* step:      Rasterung der "Metall-Kante" nach außen hin, seitlich gesehen,                            GoodQ:5 */

 switch(geo_detail)
  {
  case DETAIL_VERYHIGH: step = 1;  stepouter = 1; break;
  case DETAIL_HIGH:     step = 2;  stepouter = 1; break;
  case DETAIL_MED:      step = 5;  stepouter = 5; break;
  case DETAIL_LOW:      step = 5;  stepouter = 10; break;
  case DETAIL_VERYLOW:  step = 10; stepouter = 20; break;
  }
 
 glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
 glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);
 
 glMaterialf(GL_FRONT, GL_SHININESS, MatShn);
 glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc);

 for(j=-1;j<=1;j+=2)
  {
  glPushMatrix();
  glRotatef((j+1)/2*180.0,0.0,0.0,1.0);
  glTranslatef(0.0,0.2775,0.0);
  for(i=0;i<180-stepouter;i+=stepouter)
   {
   x1 = rad * cos( (double)i* M_PI / 180.0 );
   y1 = rad * sin( (double)i* M_PI  / 180.0 );
   x2 = rad * cos( (double)(i+stepouter) * M_PI / 180.0 );
   y2 = rad * sin( (double)(i+stepouter) * M_PI  / 180.0 );
   
   dum_int=y2*1000+7.5;
   glBegin(GL_QUAD_STRIP);
   for(m=bfunc_max;m>=dum_int;m-=step)
    {
    ms = m/1000.0;
    msstep = ms + step/1000.0;
    metal_strip(x1, (-0.0075+ms),      BFUNC(m),
		x2, (-0.0075+ms),      BFUNC(m),
		x2, (-0.0075+msstep),  BFUNC(m+step));
    }
   glEnd();
   }
  /* die beiden seitlichen Streifen */
  glBegin(GL_QUAD_STRIP);
  for(m=bfunc_max;m>=0;m-=step)
   {
   ms = m/1000.0;
   msstep = ms + step/1000.0;
   metal_strip( 0.039, (-0.0075+ms),      BFUNC(m),
		0.027, (-0.0075+ms),      BFUNC(m),
		0.039, (-0.0075+msstep),  BFUNC(m+step));
   }
  glEnd();
  glBegin(GL_QUAD_STRIP);
  for(m=bfunc_max;m>=0;m-=step)
   {
   ms = m/1000.0;
   msstep = ms + step/1000.0;
   metal_strip( -0.027, (-0.0075+ms),      BFUNC(m),
		-0.039, (-0.0075+ms),      BFUNC(m),
		
		-0.039, (-0.0075+msstep),  BFUNC(m+step));
   }
  glEnd();
  glPopMatrix();
  }

 /* Metallverkleidung der Mitteltaschen */
 glBegin(GL_QUADS);

 glNormal3d(0,1.0,0.0);
 metal_mid( 0.039,  0.330, -0.039,  0.330);
 glNormal3d(0,-1.0,0.0);
 metal_mid(-0.039, -0.330, 0.039, -0.330);

 glEnd();
 if( env_map )
  {
  glDisable(GL_TEXTURE_GEN_S);
  glDisable(GL_TEXTURE_GEN_T);
  glDisable(GL_TEXTURE_2D);
  }

 glBegin(GL_QUADS);
 /* Unterseite des Tisches*/
 glLightfv(GL_LIGHT1, GL_SPECULAR, LightZero);
 glLightfv(GL_LIGHT2, GL_SPECULAR, LightZero);

 glColor4d(0.1, 0.1, 0.1,1.0); 
 glNormal3d( 0, 0, -1.0);

/*  glEnable(GL_TEXTURE_2D); */
/*  glBindTexture(GL_TEXTURE_2D, texture[3]); */
 underside(-0.516, -0.33, 0.516, 0.33 );
/*  glDisable(GL_TEXTURE_2D); */
 underside(0.515,  -0.266, 0.58, 0.266 );
 underside(-0.58, -0.266, -0.515, 0.266 );

 /* Außenseite des Tisches */

 glColor4d(0.1, 0.1, 0.1,1.0);

 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifWooddark);
 glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmbWooddark);

 outside(  0.489,  0.330,  0.039,  0.330 );
 outside( -0.489, -0.330, -0.039, -0.330 );
 outside( -0.039,  0.330, -0.489,  0.330 );
 outside(  0.039, -0.330,  0.489, -0.330 );
 
 outside(  0.580, -0.239,  0.580,  0.239 );
 outside( -0.580,  0.239, -0.580, -0.239 );

 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifDark);
 glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmb);

 glEnd();

 glEndList(); /* Ende Aufbauten (Löcher Verblendungen, Holz, die tuchfarbenen Banden kommen mit 259 */

 glNewList(259, GL_COMPILE);

 /* Banden malen: Erstmal die seitlichen Stücke */
 glColor4d(1.0, 1.0, 1.0, 1.0);
 glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpcLow);
 glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmb);
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifBorder);

 glDisable(GL_LIGHTING);

 glBegin(GL_QUADS);
 for(i=0;i<18;i+=3)
  {
  glNormal3d( ban[i].n.x, ban[i].n.y, -0.1);
  TABLE_COLOR(0.0);
  glVertex3d( (double)ban[i].p0.x-0.5, ((double)ban[i].p0.y-0.25), -0.001);
  TABLE_COLOR(0.0);
  glVertex3d( (double)ban[i].p0.x-0.5, ((double)ban[i].p0.y-0.25), 4.0/3.0*RADIUS);
  TABLE_COLOR(0.3);
  glVertex3d( (double)ban[i].p1.x-0.5, ((double)ban[i].p1.y-0.25), 635/1000.0 * 2.0*RADIUS);
  TABLE_COLOR(0.3);
  glVertex3d( (double)ban[i].p1.x-0.5, ((double)ban[i].p1.y-0.25), 635/1000.0 * 2.0*RADIUS);
#ifdef DEBUG
  poly++;
#endif
  }
 
 for(i=2;i<18;i+=3)
  {
  glNormal3d( ban[i].n.x, ban[i].n.y, -0.1);
  TABLE_COLOR(0.0);
  glVertex3d( (double)ban[i].p1.x-0.5, ((double)ban[i].p1.y-0.25), -0.001);
  TABLE_COLOR(0.2);
  glVertex3d( (double)ban[i].p0.x-0.5, ((double)ban[i].p0.y-0.25), 635/1000.0 * 2.0*RADIUS);
  TABLE_COLOR(0.2);
  glVertex3d( (double)ban[i].p0.x-0.5, ((double)ban[i].p0.y-0.25), 635/1000.0 * 2.0*RADIUS);
  TABLE_COLOR(0.0);
  glVertex3d( (double)ban[i].p1.x-0.5, ((double)ban[i].p1.y-0.25), 4.0/3.0*RADIUS);
#ifdef DEBUG
  poly++;
#endif
  }

 for(i=1;i<18;i+=3)
  {
  glNormal3d( ban[i].n.x, ban[i].n.y, -0.1);
  TABLE_COLOR(0.2);
  glVertex3d( (double)ban[i].p1.x-0.5, ((double)ban[i].p1.y-0.25), 635/1000.0 * 2.0*RADIUS);
  TABLE_COLOR(0.2);
  glVertex3d( (double)ban[i+1].p1.x-0.5, ((double)ban[i+1].p1.y-0.25), -0.001);
  TABLE_COLOR(0.0);
  glVertex3d( (double)ban[i-1].p0.x-0.5, ((double)ban[i-1].p0.y-0.25), -0.001);
  TABLE_COLOR(0.0);
  glVertex3d( (double)ban[i].p0.x-0.5, ((double)ban[i].p0.y-0.25), 635/1000.0 * 2.0*RADIUS);
#ifdef DEBUG
  poly++;
#endif
  }

 /* Banden malen: Oberseite */
 for(i=0;i<6;i++)
  {
  glNormal3d( 0.0, 0.0, 1.0);
  TABLE_COLOR(0.2);
  glVertex3d( (double)ban[i*3+2].p1.x-0.5, (double)ban[i*3+2].p1.y-0.25, 4.0/3.0*RADIUS);
  TABLE_COLOR(0.5);
  glVertex3d( (double)ban[i*3+2].p0.x-0.5, (double)ban[i*3+2].p0.y-0.25, 635/1000.0 * 2.0*RADIUS);
  TABLE_COLOR(0.5);
  glVertex3d( (double)ban[i*3].p1.x-0.5,   (double)ban[i*3].p1.y-0.25, 635/1000.0 * 2.0*RADIUS);
  TABLE_COLOR(0.2);
  glVertex3d( (double)ban[i*3].p0.x-0.5,   (double)ban[i*3].p0.y-0.25, 4.0/3.0*RADIUS);
#ifdef DEBUG
  poly++;
#endif
  }
 glEnd();
 
 glEnable(GL_LIGHTING); 
 
 glEndList(); /* Ende Bandenaufbauten */

 switch(geo_detail)  /* Rasterung des Schattenkreises */
  {
  case DETAIL_VERYHIGH: step = 5; break;
  case DETAIL_HIGH:     step = 10; break;
  case DETAIL_MED:      step = 20; break;
  case DETAIL_LOW:      step = 20; break;
  case DETAIL_VERYLOW:  step = 30; break;
  }
 glNewList(280, GL_COMPILE ); /* Liste für Schatten der Kugeln */
 glBegin(GL_TRIANGLE_FAN);
 glColor4f(0.0,0.0,0.0,0.08);
 glVertex3d(0.0,0.0,0.0);
 for(i=360;i>=00;i-=step)
  glVertex3d(0.8*RADIUS * sin((double)i*M_PI/180.0), 0.8*RADIUS * cos((double)i*M_PI/180.0), 0.001);
 glEnd();
 glBegin(GL_QUAD_STRIP);
 for(i=0;i<=360;i+=step)
  {
  glColor4f(0.0,0.0,0.0,0.0);
  glVertex3d(RADIUS*1.1 * sin((double)i*M_PI/180.0), RADIUS*1.1 * cos((double)i*M_PI/180.0), 0.001);
  glColor4f(0.0,0.0,0.0,0.08);
  glVertex3d(0.8*RADIUS * sin((double)i*M_PI/180.0), 0.8*RADIUS * cos((double)i*M_PI/180.0), 0.001);
#ifdef DEBUG
  poly++;
#endif
  }
 glEnd();
 glEndList();
 
 /* Displaylisten für Kugeln inkl. Texturen */
 for(i=0;i<BALLS;i++)
  {
  glNewList(290+i, GL_COMPILE );
  if( display_textures ) 
   {
   glBindTexture(GL_TEXTURE_2D, texture[i + (txt_detail < TEXTURE_HIGH ? 16 : 0)]);
   }
  else /* switch über k[i].col hat nicht funktioniert... ?! */
   {
   if( i == 0 ) glMaterialfv(GL_FRONT, GL_DIFFUSE, MatWhiteDif);
   if( i == 8 ) glMaterialfv(GL_FRONT, GL_DIFFUSE, MatBlackDif);
   if( i > 0 && i < 8 ) glMaterialfv(GL_FRONT, GL_DIFFUSE, MatRedDif);
   if( i > 8 ) glMaterialfv(GL_FRONT, GL_DIFFUSE, MatYellowDif);
   }
  switch(geo_detail) 
   {
   case DETAIL_VERYHIGH: icoball(20480); break;
   case DETAIL_HIGH:     icoball(5120);  break;
   case DETAIL_MED:      icoball(1280);  break;
   case DETAIL_LOW:      icoball(320);   break;
   case DETAIL_VERYLOW:  icoball(80);    break;
   }
  glEndList();
  }
#ifdef DEBUG 
 printf("In init_lists: Polygone: %ld\n",poly);
#endif
 }

void InitGL(int width, int height)
 {
 char out[128];
 SDL_Init(SDL_INIT_VIDEO); /* wird benötigt vor SetVideoMode; ohne muss ein Extra SDL-Fenster geöffnet werden */
 SDL_GL_SetAttribute(SDL_GL_STENCIL_SIZE,8); /* Sicherstellen, dass stencil-buffer vorhanden ist! */

 if ( SDL_SetVideoMode(width, height, 0, SDL_OPENGL|GLOPT) == NULL ) 
  {
  fprintf(stderr, "Unable to create OpenGL screen: %s\n", SDL_GetError());
  SDL_Quit();
  exit(1);
  }
 sprintf(out,"Another Pool GL V %s, (c) 1995-2013 by Gerrit Jahn",VERSION);
  SDL_WM_SetCaption(out, NULL);

 LoadGLTextures(); /* wichtig: erst GL-VideoMode erzeugen, DANN Texturen laden ! ;-)) */
 BuildFont();

 glViewport(0, 0, width, height);
 glClearColor(0.0, 0.0, 0.0, 0.0);              /* Clear Screen mit angegebenen Farben */
 glClearDepth(1.0);				/* Z-Buffer löschen */
 glDepthFunc(GL_LEQUAL);

 glFogf(GL_FOG_MODE, GL_EXP2);                  /* "Nebel" */
 glFogf(GL_FOG_DENSITY, 0.5);
 glEnable(GL_FOG);

 glCullFace(GL_BACK);
 glEnable(GL_CULL_FACE);
 
 glEnable(GL_DEPTH_TEST);			    /* Z-Buffer anschalten */
 glHint(GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST);
 glDisable(GL_POLYGON_SMOOTH);                      /* sonst treten bei MESA an den Polygonkanten Linienartefakte auf */

 glShadeModel(GL_SMOOTH);		

 glPolygonMode(GL_FRONT_AND_BACK,GL_FILL);

 glLightModelf(GL_LIGHT_MODEL_COLOR_CONTROL, GL_SEPARATE_SPECULAR_COLOR); /* für die schönenen Glanzlichter ;-) */
 
 glMatrixMode(GL_PROJECTION);                   /* Perspektive am Anfang festlegen */
 glLoadIdentity();				
 gluPerspective(45.0,(GLdouble)width/(GLdouble)height,0.01,100.0);
 
 glMatrixMode(GL_MODELVIEW);
 glLoadIdentity();

 glLightfv(GL_LIGHT1, GL_AMBIENT, LightAmbient);    /* LIGHT1,2 sind die beiden Hauptlichter über dem Tisch */
 glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse1);
 glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);
 glLightfv(GL_LIGHT1, GL_POSITION,LightPosition[0]);
 glEnable(GL_LIGHT1);

 glLightfv(GL_LIGHT2, GL_AMBIENT, LightAmbient);
 glLightfv(GL_LIGHT2, GL_DIFFUSE, LightDiffuse2);
 glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
 glLightfv(GL_LIGHT2, GL_POSITION,LightPosition[1]);
 glEnable(GL_LIGHT2);

 glLightfv(GL_LIGHT3, GL_AMBIENT, LightAmbient3);   /* LIGHT3 wird nur benötigt, um Spin-Kugel usw. zu beleuchten */
 glLightfv(GL_LIGHT3, GL_DIFFUSE, LightDiffuse3); 
 glLightfv(GL_LIGHT3, GL_SPECULAR, LightSpecular); 
 glLightfv(GL_LIGHT3, GL_POSITION,LightPosition[2]);

 oldang.x = angx; /* die "letzte Ansicht" (GL-Mode: "l" drücken) initialisieren */
 oldang.y = angy;
 oldang.z = angz;
 oldstart.x = startx;
 oldstart.y = starty;
 oldstart.z = startz;

 /* Ikosaeder umnormieren, so dass die äußersten Punkt auf 
    der Einheitskugel liegen. Im Moment liegen die mittleren
    Verbindungslinien der Dreiecke auf der 1 */
 normalize_ico20(1.1755705045849463);

 /* Kugeln aus dem Ikosaeder erzeugen durch Aufteilen der
    vorhandenen Dreicke in 4 Dreiecke - mehrfach */
 splitpoly(ico80,    ico20,   20);
 splitpoly(ico320,   ico80,   80);
 splitpoly(ico1280,  ico320,  320);
 splitpoly(ico5120,  ico1280, 1280);
 splitpoly(ico20480, ico5120, 5120);
 }

/* malt den Schatten der Kugeln mittels Alpha-Blendung auf das Tischtuch */
void gl_planar_shadows(void)
 {
 int i,j;
 double dummy, tangens, scale=1.0;
 struct vect3 diff, ez={0.0,0.0,1.0}, trans;
 glDisable(GL_LIGHTING);
 glEnable(GL_BLEND);
 glLightfv(GL_LIGHT2, GL_SPECULAR, LightZero);
 glLightfv(GL_LIGHT1, GL_SPECULAR, LightZero);
 glMaterialfv(GL_FRONT, GL_SPECULAR, MatNull);
 glMaterialfv(GL_FRONT, GL_DIFFUSE, MatNull);
  
 glBlendFunc(GL_ZERO,GL_ONE_MINUS_SRC_ALPHA);
 glDisable(GL_DEPTH_TEST);
  
 for(i=0;i<BALLS;i++)
  {
  if( k[i].stat & ONTABLE )
   {
   for(j=0;j<2;j++)
    {
    glPushMatrix();
    glTranslated((double)k[i].p.x-0.5, (double)k[i].p.y-0.25, 0.0);
    diff.x = LightPosition[j][0] - (k[i].p.x-0.5);
    diff.y = LightPosition[j][1] - (k[i].p.y-0.25);
    diff.z = LightPosition[j][2] - 2.0*RADIUS;
    if( ABS(diff.x) > 1E-10 || ABS(diff.y) > 1E-10 )
     {
     dummy = sqrt(diff.x*diff.x + diff.y*diff.y);
     tangens = diff.z / dummy;
     scale = 1.0 + 1.0 / tangens;
     dummy = BETR3(diff);
     diff.x /= dummy;
     diff.y /= dummy;
     diff.z /= dummy;
     dummy = SKALP3(diff, ez);
     trans.x = diff.x - dummy * ez.x;
     trans.y = diff.y - dummy * ez.y;
     trans.z = diff.z - dummy * ez.z;
     glTranslated(-RADIUS*scale * trans.x, -RADIUS*scale*trans.y, 0.0);

     glRotated(atan(trans.y/trans.x) * 180.0/M_PI, 0.0,0.0,1.0);
     glScaled(scale, 1.0,1.0);
     }
    else  glScaled(1.0,1.0,1.0);
    glCallList(280);     /* Schattenkreise malen */
    glPopMatrix();
    }
   }
  }
 glEnable(GL_DEPTH_TEST);
 glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
 glDisable(GL_BLEND);
 glEnable(GL_LIGHTING);
 }

/* malt die Kugeln */
void gl_plotballs(int stencilrun, int create_cubemaps_flag)
 {
 int i;
 double angle;
 if( display_textures )
  {
  glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc);
  glMaterialf(GL_FRONT, GL_SHININESS, MatShnsmall);
  }
 else
  {
  glLightfv(GL_LIGHT2, GL_SPECULAR, LightZero);
  glLightfv(GL_LIGHT1, GL_SPECULAR, LightZero);
  glMaterialfv(GL_FRONT, GL_SPECULAR, MatNull);
  glMaterialf(GL_FRONT, GL_SHININESS, 0.0);
  }

 glMaterialfv(GL_FRONT, GL_AMBIENT, MatAmbbright);
 
 if( stencilrun != 2 ) 
  {
  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifballs);
  if( ball_env_map != 1 )  glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc);
  else glMaterialfv(GL_FRONT, GL_SPECULAR, MatNull);
  }
 else 
  {
  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifballs_multi);
  glMaterialfv(GL_FRONT, GL_SPECULAR, MatSpc_multi);
  }

 glColor4d(1.0, 1.0, 1.0, 1.0);
 
 if( display_textures ) glEnable(GL_TEXTURE_2D);

 /* In der for-Schleife für die Kugeln werden die ruhenden Kugeln in Displaylisten gesteckt */
 /* Bei sich bewegenden Kugeln wird nur der statische Anteil (Sphere und Texturemapping */
 /* aus einer Liste geholt */

 for(i=0;i<BALLS;i++)
  {
  if( !( k[i].stat & DELETED) )
   {
   if( ball_env_map || (k[i].stat & MOVING) ) /* Kugel bewegt sich noch, also nur einen Teil aus Liste holen */
    {
    glPushMatrix();
        
    glTranslated((double)k[i].p.x-0.5, (double)k[i].p.y-0.25, (double)k[i].p.z);
    if( display_textures )
     {
     angle = sqrt( k[i].rot.x*k[i].rot.x + k[i].rot.y*k[i].rot.y /* + k[i].rot.z*k[i].rot.z */ );
     glRotated(angle, k[i].rot.x, k[i].rot.y, 0.0 /* k[i].rot.z */ );
     glMultMatrixd(k[i].mrot);
     }
    glCallList((290+k[i].no));

    if( display_textures )
     {
     if( ball_env_map && create_cubemaps_flag )
      {
      glDisable(GL_LIGHTING);
      glColor4f(0.2,0.2,0.2,1.0);
      glEnable(GL_BLEND);
      glBlendFunc(GL_SRC_ALPHA, GL_ONE);
     
      if( ball_env_map == 2 )
       {
       glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
       glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_SPHERE_MAP);
       glEnable(GL_TEXTURE_GEN_S);
       glEnable(GL_TEXTURE_GEN_T);
       glBindTexture(GL_TEXTURE_2D, texture[36]);
       }
      else if( ball_env_map == 1 )
       {
       glDisable(GL_TEXTURE_2D);
       
       /* die Cube-Environment-Textur wird immer unrotiert auf die das
	  Objekt gemappt (unabh. davon, wie die Modelview-Matrix
	  aktuell rotiert ist. Daher muss die Textur-Matrix das
	  Inverse der Modelview Matrix sein bzgl. Rotationen. Also
	  einfach Textur-Matrix mit negativen Winkeln in umgekehrter
	  Reihenfolge rotieren, damit sich die Cube-Env-Textur nicht
	  mitdreht, der Raum um die Kugeln also "stabil" bleibt: */
       glMatrixMode(GL_TEXTURE);
       glPushMatrix();
       glLoadIdentity();
       glRotatef(-angz,0.0,0.0,1.0);
       glRotatef(-angy,0.0,1.0,0.0);
       glRotatef(-angx,1.0,0.0,0.0);

       glEnable(GL_TEXTURE_CUBE_MAP_EXT);

       glBindTexture(GL_TEXTURE_CUBE_MAP_EXT, cube_texture[WHITE]);
       glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
       glTexParameteri(GL_TEXTURE_CUBE_MAP_EXT, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
       glTexParameteri(GL_TEXTURE_CUBE_MAP_EXT, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
       
       glTexGeni(GL_S, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
       glTexGeni(GL_T, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
       glTexGeni(GL_R, GL_TEXTURE_GEN_MODE, GL_REFLECTION_MAP_EXT);
       glEnable(GL_TEXTURE_GEN_S);
       glEnable(GL_TEXTURE_GEN_T);
       glEnable(GL_TEXTURE_GEN_R);
       }
      }

      switch(geo_detail)
       {
       case DETAIL_VERYHIGH: icoball(20480);   break;
       case DETAIL_HIGH:     icoball(5120);   break;
       case DETAIL_MED:      icoball(1280);  break;
       case DETAIL_LOW:      icoball(320);   break;
       case DETAIL_VERYLOW:  icoball(80);   break;
       }
     
      if( ball_env_map == 1 ) 
       {
       glPopMatrix();
       glMatrixMode(GL_MODELVIEW);
       glDisable(GL_TEXTURE_GEN_R);
       glDisable(GL_TEXTURE_CUBE_MAP_EXT);
       glEnable(GL_TEXTURE_2D);
       }
      glDisable(GL_TEXTURE_GEN_S);
      glDisable(GL_TEXTURE_GEN_T);
      glDisable(GL_BLEND);
      glEnable(GL_LIGHTING);
      glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);
     }
    glPopMatrix();
    }
   else
    {
    if( k[i].stat & GL_LISTED_NOT_MOVING )
     {
     glCallList(260+i); /* falls schon in Liste, Liste aufrufen */
     }
    else /* sonst Liste erstellen */
     {
     glNewList(260+i,GL_COMPILE_AND_EXECUTE);

     glPushMatrix();
     
     angle = sqrt( k[i].rot.x*k[i].rot.x + k[i].rot.y*k[i].rot.y /* + k[i].rot.z*k[i].rot.z */ );
     
     glTranslated((double)k[i].p.x-0.5, (double)k[i].p.y-0.25, (double)k[i].p.z);
     glRotated(angle, k[i].rot.x, k[i].rot.y, 0.0 /* k[i].rot.z */ );
     glMultMatrixd(k[i].mrot);
     
     glCallList((290+k[i].no));
     
     glPopMatrix();
     glEndList();
     k[i].stat |= GL_LISTED_NOT_MOVING;
     }
    }
   }
  }
 if( display_textures ) 
  {
  glDisable(GL_TEXTURE_2D);
  }
 }

/* gibt den aktuellen Spieler und die kleine Kugel links oben aus */
void gl_plotplayer(void)
 {
 char out[256];
 if( !new_game )
  {
  glDisable(GL_FOG);
  glEnable(GL_BLEND);
  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatDifTransparent);
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
  
  glColor4d(1.0, 1.0, 1.0, 0.4);
  glTranslated(-0.45, 0.35, -1.0);

  if( display_textures )
   {
   glEnable(GL_TEXTURE_2D);
   switch( ply[cur].col)
    {
    case COL_RED: glBindTexture(GL_TEXTURE_2D, texture[2 + (txt_detail < TEXTURE_HIGH ? 16 : 0)]);break;
    case COL_YELLOW: glBindTexture(GL_TEXTURE_2D, texture[10 + (txt_detail < TEXTURE_HIGH ? 16 : 0)]); break;
    case COL_BLACK:  glBindTexture(GL_TEXTURE_2D, texture[8 + (txt_detail < TEXTURE_HIGH ? 16 : 0)]); break;
    default: glBindTexture(GL_TEXTURE_2D, texture[0 + (txt_detail < TEXTURE_HIGH ? 16 : 0)]); break;
    }
   }
  else
   {
   switch( ply[cur].col)
    {
    case COL_RED: glMaterialfv(GL_FRONT, GL_DIFFUSE, MatRedDif); break;
    case COL_YELLOW: glMaterialfv(GL_FRONT, GL_DIFFUSE, MatYellowDif); break;
    case COL_BLACK:  glMaterialfv(GL_FRONT, GL_DIFFUSE, MatBlackDif);break;
    default: glMaterialfv(GL_FRONT, GL_DIFFUSE, MatWhiteDif); break;
    }
   }
  icosphere(ico320,320,RADIUS*2); /* displaylist */

  if( display_textures ) glDisable(GL_TEXTURE_2D);
  
  glMatrixMode(GL_PROJECTION);
  glPopMatrix();
  glMatrixMode(GL_MODELVIEW);
  glPopMatrix();
  glEnable(GL_LIGHT1);
  glEnable(GL_LIGHT2);
  glDisable(GL_LIGHT3);
  glEnable(GL_FOG);

  sprintf(out,"Player: %d %s",cur+1,(extra_shot==1 || freeball == 1)?"(xS)":"");
  glPrint(100,768-55,out,0,0.5,0.5,0.8,0.8, 1.0); 
  }
 } 

/* Frames/s und aktuellen Spieler ausgeben */
void gl_plotfps(void)
 {
 char out[256];
 sprintf(out,"%d",(int)(frames_per_second+0.5));
 /*glPrint(1024-60,22,out,0,0.5,0.5,0.8,0.8, 1.0); */
 glPrint(924-60,22,out,0,0.5,0.5,0.8,0.8, 1.0); 
 }

void initshadow(double xL, double yL, double zL) 
 {  /* z-Werte des Schattenvolumens sind falsch. Sollten nicht konstant sein! */
 int i,j;
 float x1,y1,z1,x2,y2,z2;
 struct vect3 v,e1,e2;
 double dummy, dummysin, dummycos;

 for(j=0;j<BALLS;j++)
  {
  if( !( k[j].stat & DELETED) )
   {
   /* Verbindungslinie Licht - Mittelpunkt der Kugel */
   v.x = xL - (k[j].p.x-0.5);
   v.y = yL - (k[j].p.y-0.25);
   v.z = zL - k[j].p.z;

   /* zwei Vektoren senkrecht zueinander und senkrecht auf v bestimmen */
   e1.x = 0;
   e1.y = v.z;
   e1.z = -v.y;
   
   if( (dummy = BETR3(e1)) )
    {
    e1.x /= dummy;
    e1.y /= dummy;
    e1.z /= dummy;
    }
   
   e2.x = v.y * e1.z - v.z * e1.y;
   e2.y = v.z * e1.x - v.x * e1.z;
   e2.z = v.x * e1.y - v.y * e1.x;
   
   if( (dummy = BETR3(e2)) )
    {
    e2.x /= dummy;
    e2.y /= dummy;
    e2.z /= dummy;
    }

   for(i=0;i<360;i+=shadow_step)
    {
    dummysin = sin(i*M_PI/180.0); 
    dummycos = cos(i*M_PI/180.0); 
    x1= RADIUS * dummysin * e1.x + RADIUS * dummycos * e2.x;
    y1= RADIUS * dummysin * e1.y + RADIUS * dummycos * e2.y;
    z1= RADIUS * dummysin * e1.z + RADIUS * dummycos * e2.z;

    /* Mittelpunktkoordinaten dazuaddieren (Translation des Schattenvolumens 
       an die Kugelposition) */
    x1 += k[j].p.x-0.5;
    y1 += k[j].p.y-0.25;
    z1 += k[j].p.z;

    /* Verlängerungsvektor berechnen, Scheibenrand - Licht */
    x2 = x1 - xL;
    y2 = y1 - yL;
    z2 = z1 - zL;
    
    dummy = sqrt(x2*x2+y2*y2+z2*z2);
    x2 /= dummy;
    y2 /= dummy;
    z2 /= dummy;

    /* nach "unendlich" verlängerte Punkte des Zylinders berechnen */
    
    x2 = x1 + x2;
    y2 = y1 + y2;
    z2 = z1 + z2;

    /* QUAD_STRIP-Koordinaten des Schattenzylinders abspeichern */
    shadow[j][i/shadow_step][0][0] = x2;
    shadow[j][i/shadow_step][0][1] = y2;
    shadow[j][i/shadow_step][0][2] = z2;
    shadow[j][i/shadow_step][1][0] = x1;
    shadow[j][i/shadow_step][1][1] = y1;
    shadow[j][i/shadow_step][1][2] = z1;
    }
   /* Den "Zylinder" schließen: */
   shadow[j][i/shadow_step][0][0] = shadow[j][0][0][0];
   shadow[j][i/shadow_step][0][1] = shadow[j][0][0][1];
   shadow[j][i/shadow_step][0][2] = shadow[j][0][0][2];
   shadow[j][i/shadow_step][1][0] = shadow[j][0][1][0];
   shadow[j][i/shadow_step][1][1] = shadow[j][0][1][1];
   shadow[j][i/shadow_step][1][2] = shadow[j][0][1][2];
   }
  }
 }

void gl_plotshadow(void)
 {
 int i,j;
 glDisable(GL_LIGHTING);
 glEnable(GL_BLEND);
 glColor4f(0.9,0.9,0.9,0.5);
 for(i=0;i<BALLS;i++)
  {
  if( !( k[i].stat & DELETED) )
   {
   glBegin(GL_QUAD_STRIP);
   for(j=0;j<=360/shadow_step;j++)
    {
    glVertex3d(shadow[i][j][0][0],shadow[i][j][0][1],shadow[i][j][0][2]);
    glVertex3d(shadow[i][j][1][0],shadow[i][j][1][1],shadow[i][j][1][2]);
    }
   glEnd();
   }
  }
 glDisable(GL_BLEND);
 glEnable(GL_LIGHTING);
 }

void position_lights(void)
 {
 glLightfv(GL_LIGHT1, GL_POSITION,LightPosition[0]); /* Licht positionieren */
 glLightfv(GL_LIGHT2, GL_POSITION,LightPosition[1]);
 }

void create_cubemaps(int which)
 {
 glPushMatrix();
 glMatrixMode(GL_PROJECTION);                   /* Perspektive am Anfang festlegen */
 glPushMatrix();
 glLoadIdentity();				
 gluPerspective(90.0,1.0,0.01,2.0);

 glViewport(0,0,cube_txt_size, cube_txt_size);  /* Viewport auf Texturgröße setzen */

 glMatrixMode(GL_MODELVIEW);            /* Am Anfang einmal MODELVIEW initialisieren */

 glBindTexture(GL_TEXTURE_CUBE_MAP_EXT, cube_texture[which]);

 glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
 glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
 glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
 glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);
 glTexParameteri(GL_TEXTURE_CUBE_MAP_ARB, GL_TEXTURE_WRAP_R, GL_CLAMP_TO_EDGE);
 glTexEnvi(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_MODULATE);

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */
 glLoadIdentity();

 glRotated(180.0,1.0,0.0,0.0);          /* nach "oben" schauen */
 glTranslated(-(k[which].p.x-0.5),-(k[which].p.y-0.25),-RADIUS);
 glDisable(GL_LIGHTING);                /* Licht ausschalten und virtuelle Lichter in Buffer rendern */
 glMaterialfv(GL_FRONT,GL_DIFFUSE,MatWhiteDif);
 glColor3f(1.0,1.0,1.0);
 glBegin(GL_QUADS);
 glVertex3f(-0.4,-0.1,0.5);
 glVertex3f(-0.4,0.1,0.5);
 glVertex3f(-0.03,0.1,0.5);
 glVertex3f(-0.03,-0.1,0.5);
 glVertex3f(0.4,-0.1,0.5);
 glVertex3f(0.03,-0.1,0.5);
 glVertex3f(0.03,0.1,0.5);
 glVertex3f(0.4,0.1,0.5);
 glEnd();
 glEnable(GL_LIGHTING);

 glCopyTexSubImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT,0,0,0,0,0,cube_txt_size,cube_txt_size); /* Buffer -> Textur */

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */
 glLoadIdentity();                      /* nach "unten" schauen, Drehung um 0 Grad...  */

 glTranslated(-(k[which].p.x-0.5),-(k[which].p.y-0.25),-RADIUS);
 position_lights();

 glCallList(257);

/* gl_planar_shadows(); gj 2006*/
  
 glCopyTexSubImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT,0,0,0,0,0,cube_txt_size,cube_txt_size); /* Buffer -> Textur */

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */
 glLoadIdentity();

 glRotated(-90.0,1.0,0.0,0.0);          /* nach "rechts" schauen */
 glTranslated(-(k[which].p.x-0.5),-(k[which].p.y-0.25),-RADIUS);
 position_lights();

 glCallList(257);
/*  gl_planar_shadows(); */
 gl_plotballs(0,0);
 glCallList(259);

 glCopyTexSubImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT,0,0,0,0,0,cube_txt_size,cube_txt_size); /* Buffer -> Textur */

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */
 glLoadIdentity();

 glRotated(90.0,1.0,0.0,0.0);          /* nach "links" schauen */
 glTranslated(-(k[which].p.x-0.5),-(k[which].p.y-0.25),-RADIUS);
 position_lights();

 glCallList(257);
/*  gl_planar_shadows(); */
 gl_plotballs(0,0);
 glCallList(259);

 glCopyTexSubImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT,0,0,0,0,0,cube_txt_size,cube_txt_size); /* Buffer -> Textur */

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */
 glLoadIdentity();

 glRotated(180.0,1.0,0.0,0.0);          /* nach "vorne" schauen */
 glRotated(-90.0,0.0,1.0,0.0); 
 glTranslated(-(k[which].p.x-0.5),-(k[which].p.y-0.25),-RADIUS);
 position_lights();

 glCallList(257);
/*  gl_planar_shadows(); */
 gl_plotballs(0,0);
 glCallList(259);

 glCopyTexSubImage2D(GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT,0,0,0,0,0,cube_txt_size,cube_txt_size); /* Buffer -> Textur */

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */
 glLoadIdentity();

 glRotated(180,1.0,0.0,0.0);          /* nach "hinten" schauen */
 glRotated(90.0,0.0,1.0,0.0); 
 glTranslated(-(k[which].p.x-0.5),-(k[which].p.y-0.25),-RADIUS);
 position_lights();

 glCallList(257);
/*  gl_planar_shadows(); */
 gl_plotballs(0,0);
 glCallList(259);

 glCopyTexSubImage2D(GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT,0,0,0,0,0,cube_txt_size,cube_txt_size); /* Buffer -> Textur */

 glMatrixMode(GL_PROJECTION);           /* Perspektive wieder zurückdrehen */
 glPopMatrix();
 glViewport(0,0,SCREENRESX, SCREENRESY);
 glMatrixMode(GL_MODELVIEW);    
 glPopMatrix();
 }

#define stencilrun  2
#define stencilstep  45
void gl_plotall( int paintall ) /* ruft die andern plot-Funktionen auf */
 {
 int l,m,n;

 if( ball_env_map == 1 )
  {
  /* cube-maps updaten */
  for(l=WHITE;l<BALLS;l++) create_cubemaps(l);
  }

 glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT); /* Buffer löschen */

 glMatrixMode(GL_MODELVIEW);            /* Am Anfang einmal MODELVIEW initialisieren */
 glLoadIdentity();

 glTranslated(startx,starty,startz);    /* "Kamera" verschieben und rotieren */
 glRotated(angx,1.0,0.0,0.0); 
 glRotated(angy,0.0,1.0,0.0); 
 glRotated(angz,0.0,0.0,1.0);
 glTranslated(transx,transy,transz);

 glLightfv(GL_LIGHT1, GL_POSITION,LightPosition[0]); /* Licht positionieren */
 glLightfv(GL_LIGHT2, GL_POSITION,LightPosition[1]);

 glEnable(GL_LIGHTING);
 glDisable(GL_BLEND);

 if( shadows < STENCIL_SHADOWS )
  {
  /*************************************************************************************/
  /* ersten Teil des Tisches malen. Muss gemalt werden, BEVOR die planaren Schatten    */
  /* der Kugeln gemalt werden, da dabei dann der Z-Buffer ausgeschaltet ist            */
  /*************************************************************************************/

  glCallList(257);              /* Tischtuch, Rundung an Taschenkanten, Bandenschatten */
  
  /* planare Schatten malen? */
  if( display_textures && shadows == PLANAR_SHADOWS ) gl_planar_shadows();
  
  /* Kugeln malen */
  if( display_textures )
   {
   glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular);
   glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular);
   }

  gl_plotballs(shadows,1);
  
  /* zweiter Teil des Tisches (Aufbauten) */
  glCallList(258); /* Banden, Taschen+Gummi- und Metallverkleidung, Rand, Unterseite */ 
  glCallList(259); /* Banden, Taschen+Gummi- und Metallverkleidung, Rand, Unterseite */ 
  }
 else /* if shadows == STENCIL_SHADOWS */
  {
  if( shadows == STENCIL_SHADOWS2 )
   {
   glLightfv(GL_LIGHT1, GL_SPECULAR, LightZero );
   glLightfv(GL_LIGHT2, GL_SPECULAR, LightZero );
   glLightfv(GL_LIGHT1, GL_DIFFUSE, LightZero);
   glLightfv(GL_LIGHT2, GL_DIFFUSE, LightZero);
   glLightfv(GL_LIGHT1, GL_AMBIENT, LightZero);
   glLightfv(GL_LIGHT2, GL_AMBIENT, LightZero);
   
   glCallList(257);                                    /* Tischtuch, Rundung an Taschenkanten, Bandenschatten */
   gl_plotballs( 4,1 );                                /* Kugeln malen ohne specular light usw. */
   glCallList(258);                                    /* Banden,Taschen+Gummi- und Metallverkleidung,Rand,Unterseite */
   glCallList(259);                                    /* Banden,Taschen+Gummi- und Metallverkleidung,Rand,Unterseite */
   
   /*   initshadow(LightPosition[0][0],LightPosition[0][1],LightPosition[0][2]); */
   /*   glDisable(GL_CULL_FACE); */
   /*   gl_plotshadow(); */
   /*   glEnable(GL_CULL_FACE); */
   
   /*   initshadow(LightPosition[1][0],LightPosition[1][1],LightPosition[1][2]); */
   /*   glDisable(GL_CULL_FACE); */
   /*   gl_plotshadow(); */
   /*   glEnable(GL_CULL_FACE); */
   
   glLightfv(GL_LIGHT1, GL_AMBIENT, LightZero);        /* ambientes Licht aus */
   glLightfv(GL_LIGHT1, GL_DIFFUSE, LightZero);        /* diffuses Licht an */
   glLightfv(GL_LIGHT2, GL_AMBIENT, LightZero);        /* ambientes Licht aus */
   glLightfv(GL_LIGHT2, GL_DIFFUSE, LightZero);        /* diffuses Licht an */
   }
  else
   {
   glCallList(257);                                    /* Tischtuch, Rundung an Taschenkanten, Bandenschatten */
   gl_plotballs( 4,1 );                                /* Kugeln malen ohne specular light usw. */
   glCallList(258);                                    /* Banden,Taschen+Gummi- und Metallverkleidung,Rand,Unterseite */
   glCallList(259);                                    /* Banden,Taschen+Gummi- und Metallverkleidung,Rand,Unterseite */
   }

  l=0;
  m=0;
/*   for(l=0;l<=5;l++) */
/*   for(m=1;m<=(l+1)*(l+1);m++) */
  for(n=0;n<2;n++) /* Schleife über die beiden Lichtquellen */
   {
   double r = (double)l*0.01;
   double x = r * cos(((double)m/(l*l+1)*360.0)*M_PI/180.0);
   double y = r * sin(((double)m/(l*l+1)*360.0)*M_PI/180.0);
   if( n == 0 )      { glEnable(GL_LIGHT1); glDisable(GL_LIGHT2);}
   else if( n == 1 ) { glEnable(GL_LIGHT2); glDisable(GL_LIGHT1);}

   glClear(GL_STENCIL_BUFFER_BIT);

   initshadow(LightPosition[n][0]+x, LightPosition[n][1]+y, LightPosition[n][2]);

   glDisable( GL_LIGHTING );                          /* Licht aus */
   glDisable( GL_BLEND );                             /* Blending aus */ 
   
   glColorMask(0,0,0,0);                              /* bedeutet, dass kein Farb-Bit im Framebuffer überschrieben 
							 werden kann */
   
   glDepthMask(0);                                    /* 0 bedeutet: in den Z-Buffer kann nicht reingeschrieben werden! 
							 andere Werte: schreiben ist möglich */
   
   glDepthFunc( GL_LEQUAL );                          /* aktuelles "Fragment" (Pixel) besteht nur, wenn es kleinere 
							 z_W-Wert hat als das im Buffer hat... -- je nachdem ob der 
							 z-Buffer-Test fehlschlägt oder nicht, können bei der Stencil-Op 
							 entsprechende Flags gesetzt werden !*/
   
   glEnable( GL_STENCIL_TEST );                       /* Stencil-Buffer Test anschalten */
   
   glStencilFunc( GL_ALWAYS, 0, ~0);                  /* glStencilFunc(func,ref,mask): ref ist der Referenzwert, 
							 mask wird verANDed mit dem Refernzwert und dem im Buffer 
							 gespeicherten Wert, ALWAYS: Stencil-Test wird immer 
							 "bestanden", d.h. alle  Pixel  werden "durchgelassen" */
   
   glStencilMask(~0);                                 /* was ist ~0? jedenfalls: Stencil Buffer beschreibbar machen! */
   
   /*********************************************************/
   /* Schatteneintritte malen und zählen                    */
   /*********************************************************/
   
   glCullFace(GL_BACK);                               /* nur vordere Seiten malen */
   
   glStencilOp(GL_KEEP, GL_KEEP, GL_INCR);            /* Ergebnisse des Stencil-Tests egal, bei bestandenem z-Buffer-Test 
							 wird das aktuelle Byte im Stencil-Buffer um eins erhöht, 
							 z-Test nicht best.: egal */
   
   gl_plotshadow();                                   /* Rückseiten des Schattenvolumens malen */
   
   /*********************************************************/
   /* Schattenaustritte malen und zählen                    */
   /*********************************************************/
   
   glCullFace(GL_FRONT);                              /* nur hintere Seiten malen */
   
   glStencilOp(GL_KEEP, GL_KEEP, GL_DECR);            /* Ergebnisse des Stencil-Tests egal, bei bestandenem z-Buffer-Test 
							 wird das aktuelle Byte im Stencil-Buffer um eins erniedrigt, 
							 z-Test nicht best.: egal */
   
   gl_plotshadow();                                   /* Vorderseiten des Schattenvolumens malen */
   
   /*********************************************************/
   /* nochmal Objecte mit angeschalteten Stencil-Test malen */
  /*********************************************************/
   glBlendFunc(GL_SRC_ALPHA,GL_ONE);
   
   glColorMask(1,1,1,1);                              /* Framebuffer wieder beschreibbar */
   glDepthMask(1);                                    /* z-Buffer beschreiben ist wieder möglich, warum hier schon? */
   
   if( shadows == STENCIL_SHADOWS2 )
    {
    glStencilFunc(GL_EQUAL, 0, ~0);                   /* Stencil Test wird nur dann bestanden, wenn Buffer-Wert == 0 */
    glEnable(GL_LIGHTING);                            /* Licht an */
    if( n == 0 )      
     {
     glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse_multi);    /* diffuses Licht "hell" an */
     glLightfv(GL_LIGHT1, GL_SPECULAR, LightSpecular_multi);  /* specular Light an */
     }
    else if( n == 1 ) 
     {
     glLightfv(GL_LIGHT2, GL_DIFFUSE, LightDiffuse_multi);    /* diffuses Licht "hell" an */
     glLightfv(GL_LIGHT2, GL_SPECULAR, LightSpecular_multi);  /* specular Light an */
     }
    glCullFace(GL_BACK);                              /* für die komplette Szene nochmal nur die nach vorne geneigten 
							 Polygone malen (schneller) */
    glEnable(GL_BLEND);
    
    glCallList(257);                                  /* Tischtuch, Rundung an Taschenkanten, Bandenschatten */
    gl_plotballs( STENCIL_SHADOWS,1 );                /* Kugeln malen ohne specular light usw. */
    glCallList(258);                                  /* Banden,Taschen+Gummi- und Metallverkleidung,Rand,Unterseite */
    glCallList(259);                                  /* Banden,Taschen+Gummi- und Metallverkleidung,Rand,Unterseite */
    }
   else
    {
    glStencilFunc(GL_NOTEQUAL, 0, ~0);                /* Stencil Test wird nur dann bestanden, wenn Buffer-Wert != 0 */

    glDisable(GL_LIGHTING);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
   /*  glColor4f(0.0,0.0,0.0,0.2/(60.0)); */          /* 60, falls die beiden for-Schleife oben unkommentiert sind ... */
    glColor4f(0.0,0.0,0.0,0.1);
  
    glMatrixMode(GL_PROJECTION);                      /* um alpha-geblendetes Polygon zu malen, wird zuerst Parallel- */
    glPushMatrix();                                   /* projektion angeschaltet und danach eben ein Polygon über den */
    glLoadIdentity();                                 /* kompletten Bildschirm gemalt. Durch den Stencil-Test */
    glOrtho(0,0,1,1,0,1);                             /* wird effektiv nur in beschatteten Regionen gemalt */
    glMatrixMode(GL_MODELVIEW);
    glPushMatrix();
    glLoadIdentity();

    glDisable(GL_DEPTH_TEST);

    glBegin(GL_QUADS);
    glVertex2f(-1,-1);
    glVertex2f(-1,1);
    glVertex2f(1,1);
    glVertex2f(1,-1);
    glEnd();
    glEnable(GL_DEPTH_TEST);

    glMatrixMode(GL_PROJECTION);
    glPopMatrix();
    glMatrixMode(GL_MODELVIEW);
    glPopMatrix();
    }

   glDisable(GL_BLEND);
   glDisable(GL_STENCIL_TEST);                       /* Stencil-Test wieder ausschalten */
   glBlendFunc(GL_SRC_ALPHA,GL_ONE_MINUS_SRC_ALPHA);
   }
  
  glEnable(GL_LIGHT1);
  glEnable(GL_LIGHT2);
  glLightfv(GL_LIGHT1, GL_DIFFUSE, LightDiffuse1);
  glLightfv(GL_LIGHT2, GL_DIFFUSE, LightDiffuse2);
  glLightfv(GL_LIGHT1, GL_DIFFUSE, LightSpecular);
  glLightfv(GL_LIGHT2, GL_DIFFUSE, LightSpecular);
  glLightfv(GL_LIGHT1, GL_AMBIENT, LightAmbient);
  glLightfv(GL_LIGHT2, GL_AMBIENT, LightAmbient);
  glMaterialf(GL_FRONT, GL_SHININESS, MatShn);
  }
  
 /* aktuellen Spieler und zu spielende Kugel-"Art" malen */
 gl_plotplayer();
 
 if( timer() < err2_endtime ) gl_print_err2();
 if( timer() < foul_endtime ) gl_print_foul();

 if( showfps ) gl_plotfps();

 if( paintall != -1 ) SDL_GL_SwapBuffers();
 }

/* berechnet die Rotationsmatrix für die Kugeln */
void calc_rotation(int n)
 {
 double angle = sqrt( k[n].rot.x*k[n].rot.x + k[n].rot.y*k[n].rot.y /* + k[n].rot.z*k[n].rot.z */ );
 glPushMatrix();
 glLoadIdentity();
 glRotated( angle, k[n].rot.x, k[n].rot.y, /* k[n].rot.z */  0.0 );
 glMultMatrixd(k[n].mrot);
 k[n].rot.x = 0.0; 
 k[n].rot.y = 0.0; 
 k[n].rot.z = 0.0;
 glGetDoublev(GL_MODELVIEW_MATRIX,k[n].mrot);
 glPopMatrix();
 }

void calc_rotation_inkl_z(int n)
 {
 double angle = sqrt( k[n].rot.x*k[n].rot.x + k[n].rot.y*k[n].rot.y + k[n].rot.z*k[n].rot.z );
 glPushMatrix();
 glLoadIdentity();
 glRotated( angle, k[n].rot.x, k[n].rot.y, k[n].rot.z );
 glMultMatrixd(k[n].mrot);
 k[n].rot.x = 0.0; 
 k[n].rot.y = 0.0; 
 k[n].rot.z = 0.0;
 glGetDoublev(GL_MODELVIEW_MATRIX,k[n].mrot);
 glPopMatrix();
 }

/* Einheitsmatrix für Kugel[n] erzeugen */
void clear_rotation_matrix(int n) /* wird nur zum Initilisieren benötigt, nicht geschwindigkeitsrelevant */
 {
 int i;
 for(i=0;i<16;i++) k[n].mrot[i] = (i % 5 ? 0 : 1);
 }

void gl_move_table(double x, double y, double z, double sx, double sy, double sz, double step,
		   double tx, double ty, double tz)
 {
 double stepx, stepy, stepz, stepstartx, stepstarty, stepstartz, steptransx, steptransy, steptransz;
 int i;
 struct timeval tp_start,tp_cur;
 double time_cur, time_start;

 angx = (double)((int)(angx+0.5) % 360); /* bissle unhübsch, aber was solls ;-) */
 angy = (double)((int)(angy+0.5) % 360); /* vermeidet jetzt jedenfalls Mehrfachdrehungen */
 angz = (double)((int)(angz+0.5) % 360);
 if( angx > 180.0 ) angx -= 360.0;
 if( angy > 180.0 ) angy -= 360.0;
 if( angz > 180.0 ) angz -= 360.0;
 if( angx < -180.0 ) angx += 360.0;
 if( angy < -180.0 ) angy += 360.0;
 if( angz < -180.0 ) angz += 360.0;
 if( x > 180.0 )  x -= 360.0;
 if( y > 180.0 )  y -= 360.0;
 if( z > 180.0 )  z -= 360.0;
 if( x < -180.0 ) x += 360.0;
 if( y < -180.0 ) y += 360.0;
 if( z < -180.0 ) z += 360.0;
 oldang.x = angx; 
 oldang.y = angy;
 oldang.z = angz;
 oldstart.x = startx; 
 oldstart.y = starty;
 oldstart.z = startz;
 oldtrans.x = transx;
 oldtrans.y = transy;
 oldtrans.z = transz;
 /* Abfrage, ob angx-x > 180 oder < -180 */
 stepx = (angx - x)/step;
 stepy = (angy - y)/step;
 stepz = (angz - z)/step;
 stepstartx = (startx - sx)/step;
 stepstarty = (starty - sy)/step;
 stepstartz = (startz - sz)/step;
 steptransx = (transx - tx)/step;
 steptransy = (transy - ty)/step;
 steptransz = (transz - tz)/step;
 init_timer();
 
 for( i=0;i<(int)step;i++ )
  {
  angx -= stepx;
  angy -= stepy;
  angz -= stepz;
  startx -= stepstartx;
  starty -= stepstarty;
  startz -= stepstartz;
  transx -= steptransx;
  transy -= steptransy;
  transz -= steptransz;
  gettimeofday(&tp_start,NULL);
  time_start = tp_start.tv_sec * 1000000 + tp_start.tv_usec;
  gl_plotall(1);
  gettimeofday(&tp_cur,NULL);
  time_cur = tp_cur.tv_sec * 1000000 + tp_cur.tv_usec;

  if( time_cur - time_start < 20000 ) SDL_Delay(20+(time_cur - time_start)/1000);
  }
 angx=x; angy=y; angz=z;
 startx=sx; starty=sy; startz=sz;
 transx = tx; transy = ty; transz = tz;
 gl_plotall(1);
 }

void glPrintCentered(int y, char *out, int charset, float r, float g, float b, float alpha, float scale)
 {
   glPrint(1024/2 - strlen(out)*1024/132*scale,y,out,charset,r,g,b,alpha,scale);
 }

void title_screen( void )
 {
 long ende = 0, pressed=0;
 double dummy;
 char out[80];
 struct timeval tp_start,tp_cur;
 Uint8 *keys;
 SDL_Event event;
 Uint8 buttons;
 frames_per_second=0.0;
 angx = -60;
 startz = -1.3;
 k[WHITE].stat = (ONTABLE|MOVING);
 k[WHITE].p.x = 0.22; k[WHITE].p.y = 0.25;
 k[WHITE].p.z = RADIUS;
 glFogf(GL_FOG_DENSITY, 0.9);
 angz=180.0;
 do
  {
  gettimeofday(&tp_start,NULL);
  gl_plotall(-1);
  glPrintCentered(768/3*2.0+80,"Another Pool GL",0,0.7,0.7,1.0,1.0,4.0);
  sprintf(out,"Version %s - %s",VERSION, DATE);
  glPrintCentered(768/3*2.0-50,out,0,0.7,0.7,1.0,1.0,sqrt(2.0));
  if( SCREENRESX > 600 )
   {
   /*
   glPrintCentered(768/3*2.4,";-) ",0,0.7,0.7,1.0,1.0,6.0);
   glPrintCentered(768/3*2.0-60,"(c) 1995-2013 by Gerrit Jahn",0,0.7,0.7,1.0,1.0,1.0);
   glPrintCentered(768/3*2.0-90,"http://www.planetjahn.de/apool",0,0.7,0.7,1.0,1.0,1.0);
   */
   /* xxxxx */
   glPrintCentered(768/3*2.0+20,"(c) 1995-2013 by Gerrit Jahn",0,0.7,0.7,1.0,1.0,1.0);
   glPrintCentered(768/3*2.0-10,"http://www.planetjahn.de/apool",0,0.7,0.7,1.0,1.0,1.0);
   }
  msg("press left mouse button or SPACE to start ApoolGL...");
  SDL_GL_SwapBuffers();

  gettimeofday(&tp_cur,NULL);
  dummy = (tp_cur.tv_usec + tp_cur.tv_sec * 1000000 - tp_start.tv_usec - tp_start.tv_sec * 1000000);
  if( dummy > 0 ) 
    {
    frames_per_second = 19.0*frames_per_second + 1000000.0 / (double)dummy;
    frames_per_second /= 20.0;
    }
  else frames_per_second = 1000.0;
  angz += 20.0/1000000.0 * dummy;
  if( angz > 360.0 ) angz -= 360.0;
  SDL_PollEvent(&event);
  keys = SDL_GetKeyState(NULL);
  buttons = SDL_GetRelativeMouseState(NULL, NULL);
  if( keys[SDLK_SPACE] ) ende = 1;
  if( keys[SDLK_ESCAPE] ) stop_it();
  if( buttons & SDL_BUTTON(1) ) pressed = 1;
  if( pressed && !( buttons & SDL_BUTTON(1) ) ) ende = 1;
  }
 while( !ende );
 glFogf(GL_FOG_DENSITY, 0.5);

 k[WHITE].stat = DELETED;
 }
