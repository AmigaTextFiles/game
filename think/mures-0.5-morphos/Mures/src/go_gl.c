/*

Mures
Copyright (C) 2001 Adam D'Angelo

This program is free software; you can redistribute it and/or
modify it under the terms of the GNU General Public License
as published by the Free Software Foundation; either version 2
of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.

Contact information:

Adam D'Angelo
dangelo@ntplx.net
P.O. Box 1155
Redding, CT 06875-1155
USA

*/

#ifdef HAVE_GL

#include <stdlib.h>
#include <math.h>
#include <time.h>
#include "SDL_opengl.h"
#include "SDL.h"
#include "SDL_image.h"
#include "sim.h"
#include "output.h"
#include "game_input.h"
#include "go_gl.h"
#include "lib.h"
#include "audio_sdl.h"
#include "game_output.h"

#ifdef __MORPHOS__
#include	<GL/gl.h>
#endif

#define GO (*(go_gl*)g->output)
#define TEX(X) GO.texture[X]

typedef struct _particle_type
{
  float x, y, z;
  float xv, yv, zv;
  int start;
  int exists;
  float green;
} particle_type;

#define MAX_PARTICLE 1000
#define MAX_DEAD_MOUSE 128
#define DEAD_MOUSE_LIFE 1000

enum {
  WALL,
  PLAYER0,
  PLAYER1,
  PLAYER2,
  PLAYER3,
  MOUSE_EYE,
  MOUSE,
  MOUSE_EAR,
  MOUSE50,
  MOUSE50_EAR,
  MOUSEQ,
  MOUSEQ_EAR,
  CAT,
  FIRE,
  BOARD,
  FONT,
  DIGITS,
  GENERATOR_FLAT,
  ARROW,
  Q_MOUSE_TYPES,
  WINNER,
  MAX_TEXTURE
};

typedef struct _go_gl
{
  int type;
  int w,h,block_size;
  
  int rocket_last_hit[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  int rocket_last_cat[NUM_BLOCKS_X][NUM_BLOCKS_Y];
  particle_type particle[MAX_PARTICLE];
  int last_time;
  
  particle_type dead_mouse[MAX_DEAD_MOUSE];
  
  GLuint texture[MAX_TEXTURE];
  
} go_gl;

typedef struct _font_type
{
  GLuint texture;
  GLuint list;
  
  int max;
  int per_row;
  int rows;
  int base;
  
  float height, width;
} font_type;

typedef struct _coord
{
  float x;
  float y;
} coord;

enum {
  PLAIN,
  DIGIT,
  Q_MOUSE_TYPE_FONT,
  MAX_FONT
};

font_type font[MAX_FONT] = {
  /*PLAIN*/ {FONT, 0, 256, 16, 16, 32, 16, 16},
  /*DIGIT*/ {DIGITS, 0, 20, 5, 4, '0', .25, .19},
  /*Q_MOUSE_TYPE_FONT*/ {Q_MOUSE_TYPES, 0, 8, 1, 8, 1, 64, 512},
};

typedef struct _texture_data
{
  GLuint id;
  char *file;
} texture_data;

texture_data texdata[MAX_TEXTURE] = {
  {WALL, "wall.png"},
  {PLAYER0, "1.png"},
  {PLAYER1, "2.png"},
  {PLAYER2, "3.png"},
  {PLAYER3, "4.png"},
  {MOUSE_EYE, "mouse_eye.png"},
  {MOUSE, "mouse.png"},
  {MOUSE_EAR, "mouse_ear.png"},
  {MOUSE50, "mouse50.png"},
  {MOUSE50_EAR, "mouse50_ear.png"},
  {MOUSEQ, "mouseq.png"},
  {MOUSEQ_EAR, "mouseq_ear.png"},
  {CAT, "cat.png"},
  {FIRE, "fire.png"},
  {BOARD, "board.png"},
  {FONT, "font.png"},
  {DIGITS, "digits.png"},
  {GENERATOR_FLAT, "generator.png"},
  {ARROW, "arrow.png"},
  {Q_MOUSE_TYPES, "qmouse_types.png"},
  {WINNER, "winner.png"}
};

#define PI (atan(1)*4)
  
#define ROCKET_BLIP_TIME 100 /* ms */

/* how many ms on/off during an arrow's flickering */
#define FLICKER_RATE 20
/* how many ms an arrow flickers for */
#define FLICKER_TIME 1300

#define ROCKET_RADIUS .12
#define ROCKET_HORIZ_STEPS 2 /*5*/
#define ROCKET_STEPS 6/*17*/ /* needs to be mult. of 2 for teams */
#define BULGE_TIME 100

#define PARTS_PER_EXPLOSION 100
#define PART_RADIUS .1
#define AIR_RESISTANCE 1
#define PART_LIFE 250
#define PART_SIZE .02

/* wallposts */
#define WP_SIZE .02
#define WP_HEIGHT .03

#define WALL_THICKNESS .015
#define WALL_HEIGHT     .02
  
#define GEN_RADIUS .1
#define GEN_STEPS 11
#define GEN_HEIGHT .01

/* creatures */
#define C_SIZE .06 /* creature size */

#define CREATURE_RADIUS .06
#define CREATURE_HORIZ_STEPS 2
#define CREATURE_STEPS 6

#define CREATURE_EYE_STEPS 5
#define CREATURE_EYE_RADIUS .015
#define CREATURE_EYE_WIDTH 30
#define CREATURE_EYE_HEIGHT 45

#define CREATURE_EAR_RADIUS .04
#define CREATURE_EAR_ANGLE 60
#define CREATURE_EAR_STEPS 7



#define AMB 1.0f

#define BOARD_DEPTH -2

#define WIDTH 640
#define HEIGHT 480

/* Height / width ration */
float ratio;

float player_color[MAX_PLAYER][4] = {
  {28/255.0, 54/255.0, 183/255.0, 1},             /*  blue  */
  {254/255.0, 220/255.0, 1/255.0, 1},      /* yellow */
  {1, 39/255.0, 0/255.0, 1},             /*  red   */
  {38/255.0, 135/255.0, 27/255.0, 1}       /* green  */
};

#ifndef __MORPHOS__
/* ripped from mesa */
void gluPerspective(GLdouble fovy, GLdouble aspect, GLdouble zNear, GLdouble zFar)
{
  GLdouble xmin, xmax, ymin, ymax;
  
  ymax = zNear * tan( fovy * PI / 360.0 );
  ymin = -ymax;
  
  xmin = ymin * aspect;
  xmax = ymax * aspect;
  
  glFrustum( xmin, xmax, ymin, ymax, zNear, zFar );
}
#endif

coord coord_pos(float x, float y)
{
  coord temp;
  temp.x = x;
  temp.y = y;
  return temp;
}

coord game_gl_gridf2coord(game *g, grid_float_position ongrid)
{
  return coord_pos(ratio*(ongrid.x*2/(NUM_BLOCKS_X)-1), -1*(ongrid.y*2/(NUM_BLOCKS_Y)-1));
}

coord game_gl_grid2coord(game *g, grid_int_position ongrid)
{
  return game_gl_gridf2coord(g, grid_float_pos(ongrid.x, ongrid.y));
}

coord centerf(game *g, coord p)
{
  coord q, r;
  
  q = game_gl_grid2coord(g, grid_int_pos(0, 0));
  r = game_gl_grid2coord(g, grid_int_pos(1, 1));
  
  p.x += (r.x - q.x)/2;
  p.y += (r.y - q.y)/2;
  return p;
}

void gl_add_dead_mouse(game *g, direction dir, float x, float y)
{
  int i;
  go_gl *go = &GO;
  coord p;

  for(i=0; i<MAX_DEAD_MOUSE; i++)
    if(!go->dead_mouse[i].exists || g->sim.elapsed-go->dead_mouse[i].start > DEAD_MOUSE_LIFE) {
      go->dead_mouse[i].exists = 1;
      go->dead_mouse[i].start  = g->sim.elapsed;

      p = centerf(g, game_gl_gridf2coord(g, grid_float_pos(x, y)));
      
      go->dead_mouse[i].x = p.x;
      go->dead_mouse[i].y = p.y;
      go->dead_mouse[i].z = 0;
      return;
    }

  /* ran out */
}

void go_gl_handle_event(game *g, int event, float x, float y, direction dir)
{
  int i;
  float v;
  float a, b;
  int count;
  coord p;

  sound_handle_event(g, event, x, y, dir);

  switch(event) {
  case GET_MOUSE:
  case GET_MOUSE_50:
  case GET_MOUSE_Q:
    GO.rocket_last_hit[(int)x][(int)y] = g->sim.elapsed;
    break;
  case GET_CAT:
    GO.rocket_last_cat[(int)x][(int)y] = g->sim.elapsed;

    count = 0;

    for(i=0; i<MAX_PARTICLE && count < PARTS_PER_EXPLOSION; i++)
      if(!GO.particle[i].exists) {
	v = ((float)(rand()%10000))/10000*3;
	a = ((float)(rand()%20000))/10000*360;
	b = 0;
	/*	b = ((float)(rand()%20000))/10000*180;*/ /* only up */
	
	p = centerf(g, game_gl_grid2coord(g, grid_int_pos((int)x, (int)y)));
	
	GO.particle[i].x = p.x + PART_RADIUS*cos(a)*cos(b);
	GO.particle[i].y = p.y + PART_RADIUS*sin(a)*cos(b);
	GO.particle[i].z = PART_RADIUS*sin(b);
	
	GO.particle[i].xv = v*cos(a)*cos(b);
	GO.particle[i].yv = v*sin(a)*cos(b);
	GO.particle[i].zv = v*sin(b);
	
	GO.last_time = g->sim.elapsed;
	GO.particle[i].start = g->sim.elapsed;
	GO.particle[i].green = ((float)(rand()%1000))/1000;
	GO.particle[i].exists = 1;
	count++;
      }
    
    break;
  case MOUSE_DEATH:
    gl_add_dead_mouse(g, dir, x, y);
    break;
  }    
}

int resizeWindow(game *g, int width, int height)
{
    /* Protect against a divide by zero */
    if ( height == 0 )
	height = 1;

    ratio = ( GLfloat )width / ( GLfloat )height;

    /* Setup our viewport. */
    glViewport( 0, 0, ( GLsizei )width, ( GLsizei )height );
    
    /* change to the projection matrix and set our viewing volume. */
    glMatrixMode( GL_PROJECTION );
    glLoadIdentity( );

    /* Set our perspective */
    gluPerspective( 60.0f, ratio, 0.1f, 100.0f );
    
    /*    glFrustum(-.01, .01, -.01, .01, .01, 100);*/

    /* Make sure we're chaning the model view and not the projection */
    glMatrixMode( GL_MODELVIEW );

    /* Reset The View */
    glLoadIdentity( );

    GO.w = width;
    GO.h = height;

    game_input_changed_output(g);
  
    return 1;
}

void load_texture(char *path, GLuint *target)
{
  SDL_Surface *s;
  
  printf("Loading texture from %s\n", path);
  
  s = IMG_Load(path);
  
  glGenTextures(1, target);
  
  glBindTexture(GL_TEXTURE_2D, *target);
  
  printf("Texture bound to %d\n", *target);
  
  glTexImage2D(GL_TEXTURE_2D, 0, 3, s->w, s->h, 0, GL_RGB, GL_UNSIGNED_BYTE, s->pixels);

  glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR );
  glTexParameteri( GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR );

  SDL_FreeSurface(s);
}

void load_textures(game *g)
{
  int i, j;
  char buff[1000];
  
  for(i=0; i<MAX_TEXTURE; i++) {
    for(j=0; j<MAX_TEXTURE; j++)
      if(texdata[j].id == i) {
	sprintf(buff, "textures/%s", texdata[j].file);
	load_texture(buff, &(TEX(i)));
	
	break;
      }
    if(j==MAX_TEXTURE)
      printf("No texture specified for %d\n", i);
  }

  glBindTexture(GL_TEXTURE_2D, 0);
}

void build_font(game *g, int f)
{
  int i;
  float cx, cy;

  font[f].list = glGenLists(font[f].max);
  
  glBindTexture(GL_TEXTURE_2D, TEX(font[f].texture));
  
  for(i=0; i<font[f].max; i++) {
    cx = 1 - ((float)( i % font[f].per_row )) / font[f].per_row;
    cy = 1 - ((float)( i / font[f].per_row )) / font[f].rows;

    glNewList(font[f].list + font[f].max - i - 1, GL_COMPILE);
    
    glBegin(GL_QUADS);
    
    glTexCoord2f(cx - 1.0/font[f].per_row, cy);
    glVertex3f(0, 0, 0);
    
    glTexCoord2f(cx, cy);
    glVertex3f(font[f].width, 0, 0);
    
    glTexCoord2f(cx, cy - 1.0/font[f].rows);
    glVertex3f(font[f].width, font[f].height, 0);
    
    glTexCoord2f(cx - 1.0/font[f].per_row, cy - 1.0/font[f].rows);
    glVertex3f(0, font[f].height, 0);
    
    glEnd();
    
    glTranslatef(font[f].width, 0, 0);
    glEndList();
  }
}

void init_gl(game *g, int width, int height)
{
  static GLfloat pos[4] = {2, 5, 5, 0};
  int x, y, i;

  GLfloat LightAmbient[]= { AMB, AMB, AMB, 1.0f };
  GLfloat LightDiffuse[]= { 1, 1, 1, 1};
  
  /* Enable smooth shading */
  glShadeModel( GL_SMOOTH );
  
  /* Set the background black */
  glClearColor( 0.0f, 0.0f, 0.0f, 0.0f );
  
  /* Depth buffer setup */
  glClearDepth( 1.0f );
  
  /* Enables Depth Testing */
  glEnable( GL_DEPTH_TEST );

  /*  glEnable(GL_CULL_FACE);*/

  glPolygonMode(GL_LINE, GL_LINE);

  glEnable(GL_TEXTURE_2D);

  glEnable(GL_POLYGON_SMOOTH);
  
  /* The Type Of Depth Test To Do */
  glDepthFunc( GL_LEQUAL );
  
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  
  glEnable(GL_LIGHTING);
  
  glLightfv(GL_LIGHT0, GL_POSITION, pos);
  glLightfv(GL_LIGHT0, GL_AMBIENT, LightAmbient);
  glLightfv(GL_LIGHT0, GL_DIFFUSE, LightDiffuse);
  glEnable(GL_LIGHT0);
  
  /* Really Nice Perspective Calculations */
  glHint( GL_PERSPECTIVE_CORRECTION_HINT, GL_NICEST );

  glEnable(GL_NORMALIZE);
  
  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++) {
      GO.rocket_last_hit[x][y] = -10000;
      GO.rocket_last_cat[x][y] = -10000;
      for(i=0; i<MAX_PARTICLE; i++)
	GO.particle[i].exists = 0;
    }

  for(i=0; i<MAX_DEAD_MOUSE; i++)
    GO.dead_mouse[i].exists = 0;

  load_textures(g);
  
  for(i=0; i<MAX_FONT; i++)
    build_font(g, i);

  resizeWindow(g, width, height);

}  

GLvoid print_over(game *g, int x, int y, char *string, int f, float factor)
{
  glBindTexture(GL_TEXTURE_2D, TEX(font[f].texture));
    
  glDisable(GL_DEPTH_TEST);
    
  glMatrixMode(GL_PROJECTION);
  glPushMatrix();
    
  glLoadIdentity();
  glOrtho(0, 640, 0, 480, -1, 1);
    
  glMatrixMode(GL_MODELVIEW);
  glPushMatrix();
  glLoadIdentity();
  
  glTranslated(x, y, 0);
  
  glScalef(640/3*factor, 480/3*factor, 0);
  
  glListBase(font[f].list - font[f].base);
  
  glCallLists(strlen(string), GL_BYTE, string);
  
  glMatrixMode(GL_PROJECTION);
  glPopMatrix();

  glMatrixMode(GL_MODELVIEW);
  glPopMatrix();

  glEnable(GL_DEPTH_TEST);
}

GLvoid print_in(game *g, char *string, int center, int f)
{
  glBindTexture(GL_TEXTURE_2D, TEX(font[f].texture));
  
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_LIGHTING);
  
  glPushMatrix();
  
  if(center)
    glTranslatef(-font[f].width*strlen(string)/2, -font[f].height/2, 0);
  
  glListBase(font[f].list - font[f].base);
  
  glCallLists(strlen(string), GL_BYTE, string);
  
  glPopMatrix();
  
  glEnable(GL_LIGHTING);
  glEnable(GL_DEPTH_TEST);
}

void show_board(game *g)
{
  int x, y;
  coord p, q;

  glDisable(GL_LIGHTING);

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(!g->sim.map.hole[x][y]) {
	
	p = game_gl_grid2coord(g, grid_int_pos(x, y));
	q = game_gl_grid2coord(g, grid_int_pos(x+1, y+1));

	if((x + y)%2 == 0)
	  glColor4f(1, .5, .5, 1);
	else
	  glColor4f(1, .8, .8, 1);
	
	glBindTexture(GL_TEXTURE_2D, TEX(BOARD));
	
	glBegin(GL_QUADS);
	
	glNormal3f(0, 0, 1);
	
	glTexCoord2d(0, 0);
	glVertex3f(p.x, p.y, 0);
	
	glTexCoord2d(0, 1);
	glVertex3f(p.x, q.y, 0);
	
	glTexCoord2d(1, 1);
	glVertex3f(q.x, q.y, 0);
	
	glTexCoord2d(1, 0);
	glVertex3f(q.x, p.y, 0);
	
	glEnd();
      }

  glEnable(GL_LIGHTING);
}

void show_explosions(game *g)
{
  int i;
  int time, diff;
  float per;

  particle_type part;
  
  time = g->sim.elapsed;
  
  diff = time - GO.last_time;
  
  GO.last_time = time;

  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_LIGHTING);
  
  glBindTexture(GL_TEXTURE_2D, TEX(FIRE));
  
  for(i=0; i<MAX_PARTICLE; i++)
    if(GO.particle[i].exists) {

      part = GO.particle[i];
	  
      part.x += part.xv*diff/1000;
      part.y += part.yv*diff/1000;
      part.z += part.zv*diff/1000;
	  
      per = ((float)g->sim.elapsed - part.start)/PART_LIFE;
      if(per > 1)
	per = 1;
      per = per * per;
      per = 1-per;
	  
      glColor4f(1, part.green, 0, per);
      
      part.xv -= ((float)diff*AIR_RESISTANCE*part.xv)/1000;
      part.yv -= ((float)diff*AIR_RESISTANCE*part.yv)/1000;
      part.zv -= ((float)diff*AIR_RESISTANCE*part.zv)/1000;
	  
      if(g->sim.elapsed - part.start > PART_LIFE)
	part.exists = 0;
	  
      GO.particle[i] = part;
	  
      glBegin(GL_QUADS);
      
      glTexCoord2d(0, 0);
      glVertex3f(part.x, part.y, part.z);
      glTexCoord2d(1, 0);
      glVertex3f(part.x+PART_SIZE, part.y, part.z);
      glTexCoord2d(1, 1);
      glVertex3f(part.x+PART_SIZE, part.y+PART_SIZE, part.z);
      glTexCoord2d(0, 1);
      glVertex3f(part.x, part.y+PART_SIZE, part.z);

      glEnd();
      
    }

  glDisable(GL_BLEND);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);

}	  

void sphere_vertex(float ha, float ca, float radius)
{
  float ch, cr;
  float px, py;

  ch = sin(ha)*radius;
  cr = cos(ha)*radius;
  
  px = sin(ca)*cr;
  py = cos(ca)*cr;

  glNormal3f(px, py, ch);
  glVertex3f(px, py, ch);
}

void show_rocket(game *g, int player, float radius)
{
  float ha, ca;
  int i;
  int count=0;
  int which[MAX_PLAYER];
  int c2;
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->sim.player[i].exists)
      if(g->sim.player[i].team_leader == g->sim.player[player].team_leader)
	which[count++] = i;
  
  c2 = 0;
  for(ca=0; ca<2*PI-.0001; ca += PI*2/ROCKET_STEPS) {
    
    glBindTexture(GL_TEXTURE_2D, TEX(PLAYER0+which[c2*count/ROCKET_STEPS]));
    
    glBegin(GL_QUAD_STRIP);
    
    for(ha=0; ha<PI/2+.0001; ha += PI/2/ROCKET_HORIZ_STEPS) {
      sphere_vertex(ha, ca, radius);
      sphere_vertex(ha, ca+PI*2/ROCKET_STEPS, radius);
    }
    
    glEnd();
    
    c2++;
  }
}

void show_rockets(game *g)
{
  int x, y, x2, y2, i;
  float radius;
  float per;
  
  coord p, q;
  
  /*  glDisable(GL_DEPTH_TEST);*/

  if(g->sim.mode != EVERYBODY_MOVE) {
    for(x=0; x<NUM_BLOCKS_X; x++)
      for(y=0; y<NUM_BLOCKS_Y; y++)
	if(sim_rocket_owner(&g->sim, x, y) >= 0) {

	  radius = ROCKET_RADIUS;
	  
	  if(GO.rocket_last_hit[x][y] <= g->sim.elapsed && GO.rocket_last_hit[x][y] + BULGE_TIME > g->sim.elapsed)
	    radius += .5 * radius * (g->sim.elapsed - GO.rocket_last_hit[x][y]) / BULGE_TIME;

	  glPushMatrix();
	
	  p = centerf(g, game_gl_grid2coord(g, grid_int_pos(x, y)));
	
	  glTranslatef(p.x, p.y, 0);
	  
	  show_rocket(g, sim_rocket_owner(&g->sim, x, y), radius);

	  glPopMatrix();
	}
  }
  else {
    per = 1-((float)g->sim.mode_timer)/EVERYBODY_MOVE_L;
    per = ((pow((per-.5)*2, 3)/2)+.5 + 3*per)/4;

    for(i=0; i<MAX_PLAYER; i++)
      for(x=0; x<NUM_BLOCKS_X; x++)
	for(y=0; y<NUM_BLOCKS_Y; y++)
	  for(x2=0; x2<NUM_BLOCKS_X; x2++)
	    for(y2=0; y2<NUM_BLOCKS_Y; y2++)
	      if(sim_rocket_owner(&g->sim, x, y) == i && sim_last_rocket_owner(&g->sim, x2, y2) == i) {
		
		glPushMatrix();
		
		p = centerf(g, game_gl_grid2coord(g, grid_int_pos(x, y)));
		q = centerf(g, game_gl_grid2coord(g, grid_int_pos(x2, y2)));
		
		glTranslatef(p.x*per+q.x*(1-per), p.y*per+q.y*(1-per), 0);
		
		show_rocket(g, i, ROCKET_RADIUS);
		
		glPopMatrix();
	      }
  }

  /*  glEnable(GL_DEPTH_TEST);*/

}


void show_circle(game *g, float radius, int steps)
{
  float a;

  glBegin(GL_TRIANGLE_FAN);

  glNormal3f(0, 1, 0);
  glVertex3f(0, 0, 0);
  
  for(a=0; a<2*PI+.001; a+=2*PI/steps)
    glVertex3f(sin(a)*radius, 0, cos(a)*radius);
  
  glEnd();
}  

void show_eye(game *g, int type)
{
  glBindTexture(GL_TEXTURE_2D, TEX(MOUSE_EYE));
  
  show_circle(g, CREATURE_EYE_RADIUS, CREATURE_EYE_STEPS);
}

void show_ear(game *g, int type)
{
  switch(type) {
  case cat: glBindTexture(GL_TEXTURE_2D, TEX(CAT)); break;
  case mouse50: glBindTexture(GL_TEXTURE_2D, TEX(MOUSE50_EAR)); break;
  case mouseq: glBindTexture(GL_TEXTURE_2D, TEX(MOUSEQ_EAR)); break;
  default: glBindTexture(GL_TEXTURE_2D, TEX(MOUSE_EAR)); break;
  }
  
  glPushMatrix();
  glRotatef(CREATURE_EAR_ANGLE, 1, 0, 0);

  show_circle(g, CREATURE_EAR_RADIUS, CREATURE_EAR_STEPS);
  glPopMatrix();
}

void show_creature(game *g, int type, int id, float pos)
{
  float ha, ca;
  float factor;
  
  glTranslatef(0, sin(pos*10+id)*CREATURE_RADIUS/8, 0);

  switch(type) {
  case cat: glScalef(2, 2, 2); break;
  case mouseq:
  case mouse50: glScalef(.75, .75, .75); break;
  default: break;
  }

  factor = (float)((id*174227)%100)/1000.0 - .05 + 1;
  
  glScalef(factor, factor, factor);

  glRotatef((((int)pos*1000+id*400)%1000)/100.0-5, 0, 0, 1);
  
  glPushMatrix();
  
  switch(type) {
  case cat: glBindTexture(GL_TEXTURE_2D, TEX(CAT)); break;
  case mouse50: glBindTexture(GL_TEXTURE_2D, TEX(MOUSE50)); break;
  case mouseq: glBindTexture(GL_TEXTURE_2D, TEX(MOUSEQ)); break;
  default: glBindTexture(GL_TEXTURE_2D, TEX(MOUSE)); break;
  }
  
  glTranslatef(0, 0, CREATURE_RADIUS);

  for(ha=-PI/2; ha<PI/2-.0001; ha += PI/2/CREATURE_HORIZ_STEPS) {
    
    glBegin(GL_QUAD_STRIP);
    
    for(ca=0; ca<=2*PI+.0001; ca += PI*2/CREATURE_STEPS) {
      sphere_vertex(ha, ca, CREATURE_RADIUS);
      sphere_vertex(ha+PI/2/CREATURE_HORIZ_STEPS, ca, CREATURE_RADIUS);
    }
    
    glEnd();
  }
  
  /* eyes */

  glPushMatrix();

  glRotatef(CREATURE_EYE_HEIGHT, 1, 0, 0);

  glRotatef(-CREATURE_EYE_WIDTH/2, 0, 0, 1);

  glPushMatrix();

  glTranslatef(0, CREATURE_RADIUS, 0);
  
  show_eye(g, type);
  
  glPopMatrix();
  
  glRotatef(CREATURE_EYE_WIDTH, 0, 0, 1);

  glPushMatrix();

  glTranslatef(0, CREATURE_RADIUS, 0);
  
  show_eye(g, type);
  
  glPopMatrix();

  glPopMatrix();
  
  /* ears */
  
  glTranslatef(CREATURE_RADIUS, -CREATURE_RADIUS/3, CREATURE_RADIUS);

  show_ear(g, type);
  
  glTranslatef(-CREATURE_RADIUS*2, 0, 0);

  show_ear(g, type);

  glPopMatrix();

}

void show_creatures(game *g)
{
  coord p;
  creature c;
  int i;
  
  for(i=0; i<MAX_CREATURE; i++)
    if(g->sim.creature[i].exists) {
      
      c = g->sim.creature[i];
      p = centerf(g, game_gl_gridf2coord(g, c.pos));

      glPushMatrix();

      glTranslatef(p.x, p.y, 0);
      glRotatef(-g->sim.creature[i].dir*90, 0, 0, 1);

      show_creature(g, c.type, i, p.x+p.y);

      glPopMatrix();
    }
}

void show_floaters(game *g)
{
  coord p;
  int i;
  
  for(i=0; i<MAX_CREATURE; i++)
    if(g->sim.floater[i].exists) {
      
      p = centerf(g, game_gl_gridf2coord(g, g->sim.floater[i].pos));
      
      glPushMatrix();
      
      glTranslatef(p.x, p.y, 0);
      glRotatef(-g->sim.floater[i].old_dir*90, 0, 0, 1);
      
      show_creature(g, g->sim.floater[i].type, i, p.x+p.y);

      glPopMatrix();
    }
}

void show_wallposts(game *g)
{
  coord p;
  int x, y;
  
  glBindTexture(GL_TEXTURE_2D, TEX(WALL));
  
  for(x=0; x<NUM_BLOCKS_X+1; x++)
    for(y=0; y<NUM_BLOCKS_Y+1; y++)
      if(
	 g->sim.map.hwall[x%NUM_BLOCKS_X][y%NUM_BLOCKS_Y] ||
	 g->sim.map.vwall[x%NUM_BLOCKS_X][y%NUM_BLOCKS_Y] ||

	 (x-1 >= 0 &&
	  g->sim.map.hwall[(x-1)%NUM_BLOCKS_X][y%NUM_BLOCKS_Y]) ||

	 (y-1 >= 0 &&
	  g->sim.map.vwall[x%NUM_BLOCKS_X][(y-1)%NUM_BLOCKS_Y])
	 ) {
	p = game_gl_grid2coord(g, grid_int_pos(x, y));

	glPushMatrix();
	glTranslatef(p.x, p.y, 0);
	glRotatef(45, 0, 0, 1);
	
	glBegin(GL_QUADS);
	
	/* front */
	glNormal3f(0, 0, 1);
	glVertex3f(-WP_SIZE, -WP_SIZE, WP_HEIGHT);
	glVertex3f(-WP_SIZE, WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, -WP_SIZE, WP_HEIGHT);

	/* left */
	glNormal3f(-1, 0, 0);
	glVertex3f(-WP_SIZE, -WP_SIZE, WP_HEIGHT);
	glVertex3f(-WP_SIZE, WP_SIZE, WP_HEIGHT);
	glVertex3f(-WP_SIZE, WP_SIZE, 0);
	glVertex3f(-WP_SIZE, -WP_SIZE, 0);

	/* top */
	glNormal3f(0, 1, 0);
	glVertex3f(-WP_SIZE, WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, WP_SIZE, 0);
	glVertex3f(-WP_SIZE, WP_SIZE, 0);

	/* right */
	glNormal3f(1, 0, 0);
	glVertex3f(WP_SIZE, WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, -WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, -WP_SIZE, 0);
	glVertex3f(WP_SIZE, WP_SIZE, 0);

	/* bottom */
	glNormal3f(0, -1, 0);
	glVertex3f(-WP_SIZE, -WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, -WP_SIZE, WP_HEIGHT);
	glVertex3f(WP_SIZE, -WP_SIZE, 0);
	glVertex3f(-WP_SIZE, -WP_SIZE, 0);
	
	glEnd();
	glPopMatrix();
      }
	

}  
	

void show_walls(game *g)
{
  int x, y;
  coord p, p2;

  glBindTexture(GL_TEXTURE_2D, TEX(WALL));
  
  glBegin(GL_QUADS);

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y+1; y++)
      if(g->sim.map.hwall[x][y%NUM_BLOCKS_Y]) {
	p  = game_gl_grid2coord(g, grid_int_pos(x, y));
	p2 = game_gl_grid2coord(g, grid_int_pos(x+1, y));

	glNormal3f(0, -1, 0);
	glVertex3f(p.x, p.y-WALL_THICKNESS, 0);
	glVertex3f(p.x, p.y-WALL_THICKNESS, WALL_HEIGHT);
	glVertex3f(p2.x, p2.y-WALL_THICKNESS, WALL_HEIGHT);
	glVertex3f(p2.x, p2.y-WALL_THICKNESS, 0);
  
	glNormal3f(0, 1, 0);
	glVertex3f(p.x, p.y+WALL_THICKNESS, 0);
	glVertex3f(p.x, p.y+WALL_THICKNESS, WALL_HEIGHT);
	glVertex3f(p2.x, p2.y+WALL_THICKNESS, WALL_HEIGHT);
	glVertex3f(p2.x, p2.y+WALL_THICKNESS, 0);
  
	glNormal3f(0, 0, 1);
	glTexCoord2f( 0.0f, 1.0f );
	glVertex3f(p.x, p.y+WALL_THICKNESS, WALL_HEIGHT);
	glTexCoord2f(1.0f, 1.0f );
	glVertex3f(p.x, p.y-WALL_THICKNESS, WALL_HEIGHT);
	glTexCoord2f(1.0f, 0.0f );
	glVertex3f(p2.x, p2.y-WALL_THICKNESS, WALL_HEIGHT);
	glTexCoord2f(0.0f, 0.0f );
	glVertex3f(p2.x, p2.y+WALL_THICKNESS, WALL_HEIGHT);
      }
  
  for(x=0; x<NUM_BLOCKS_X+1; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(g->sim.map.vwall[x%NUM_BLOCKS_X][y]) {
	p  = game_gl_grid2coord(g, grid_int_pos(x, y));
	p2 = game_gl_grid2coord(g, grid_int_pos(x, y+1));

	glNormal3f(-1, 0, 0);
	glVertex3f(p.x-WALL_THICKNESS, p.y, 0);
	glVertex3f(p.x-WALL_THICKNESS, p.y, WALL_HEIGHT);
	glVertex3f(p2.x-WALL_THICKNESS, p2.y, WALL_HEIGHT);
	glVertex3f(p2.x-WALL_THICKNESS, p2.y, 0);
	
	glNormal3f(1, 0, 0);
	glVertex3f(p.x+WALL_THICKNESS, p.y, 0);
	glVertex3f(p.x+WALL_THICKNESS, p.y, WALL_HEIGHT);
	glVertex3f(p2.x+WALL_THICKNESS, p2.y, WALL_HEIGHT);
	glVertex3f(p2.x+WALL_THICKNESS, p2.y, 0);

	glNormal3f(0, 0, 1);
	glVertex3f(p.x-WALL_THICKNESS, p.y, WALL_HEIGHT);
	glVertex3f(p.x+WALL_THICKNESS, p.y, WALL_HEIGHT);
	glVertex3f(p2.x+WALL_THICKNESS, p2.y, WALL_HEIGHT);
	glVertex3f(p2.x-WALL_THICKNESS, p2.y, WALL_HEIGHT);
    }

  glEnd();
}

void show_generators(game *g)
{
  int i;
  float s;
  coord p;

  glBindTexture(GL_TEXTURE_2D, TEX(GENERATOR_FLAT));

  for(i=0; i<g->sim.map.max_generator; i++) {
    p = centerf(g, game_gl_grid2coord(g, g->sim.map.generator[i].pos));
    
    glPushMatrix();
    
    glTranslatef(p.x, p.y, .001);

    glBegin(GL_QUADS);
      
    for(s=0; s<2*PI; s+=2*PI/GEN_STEPS) {
      glNormal3f(cos(s), sin(s), 0);

      glVertex3f(GEN_RADIUS*cos(s), GEN_RADIUS*sin(s), 0);
      glVertex3f(GEN_RADIUS*cos(s), GEN_RADIUS*sin(s), GEN_HEIGHT);

      glNormal3f(cos(s+2*PI/GEN_STEPS), sin(s+2*PI/GEN_STEPS), 0);
      glVertex3f(GEN_RADIUS*cos(s+2*PI/GEN_STEPS), GEN_RADIUS*sin(s+2*PI/GEN_STEPS), GEN_HEIGHT);
      glVertex3f(GEN_RADIUS*cos(s+2*PI/GEN_STEPS), GEN_RADIUS*sin(s+2*PI/GEN_STEPS), 0);
    }
      
    glEnd();

    glBegin(GL_TRIANGLE_FAN);

    glNormal3f(0, 0, 1);
    glVertex3f(0, 0, GEN_HEIGHT);

    for(s=0; s<2*PI; s+=2*PI/GEN_STEPS) {
      glVertex3f(GEN_RADIUS*cos(s), GEN_RADIUS*sin(s), GEN_HEIGHT);
    }
      
    glEnd();

    glPopMatrix();
  }
}

void tex_place(int x)
{
  switch((x+1)%4) {
  case 0: glTexCoord2d(0, 0); break;
  case 1: glTexCoord2d(1, 0); break;
  case 2: glTexCoord2d(1, 1); break;
  case 3: glTexCoord2d(0, 1); break;
  }
}

void show_arrow(game *g, int player, int health, int dir)
{
  float factor;

  glPushMatrix();
	    
  glBindTexture(GL_TEXTURE_2D, TEX(PLAYER0+player));
	    
  if(health==0)
    factor = 0.8;
  else
    factor = 1.0;
  
  glScalef(factor, factor, 1);
  
  glNormal3f(0, 0, 1);
  
  glBegin(GL_QUADS);
  
  glVertex3f(-1, -1, 0);
  glVertex3f(-1, 1, 0);
  glVertex3f(1, 1, 0);
  glVertex3f(1, -1, 0);
  
  glEnd();
  
  glEnable(GL_BLEND);
  glBlendFunc(GL_ONE, GL_ONE);
  
  glBindTexture(GL_TEXTURE_2D, TEX(ARROW));
  
  glBegin(GL_QUADS);
  
  tex_place(dir);
  glVertex3f(-1, -1, 0);
  tex_place(dir+1);
  glVertex3f(-1, 1, 0);
  tex_place(dir+2);
  glVertex3f(1, 1, 0);
  tex_place(dir+3);
  glVertex3f(1, -1, 0);
  
  glEnd();
  
  glDisable(GL_BLEND);
  
  glPopMatrix();

}



void show_arrows(game *g)
{
  int i, j;
  coord p, q, center;
  /*  coord a, b;*/
  float width, height;
  
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_LIGHTING);
  
  glColor4f(1, 1, 1, 1);
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->sim.player[i].exists)
      for(j=0; j<MAX_ARROW; j++)
	if(g->sim.player[i].arrow[j].exists)
	  if(g->sim.player[i].arrow[j].time_left > FLICKER_TIME || g->sim.player[i].arrow[j].time_left/FLICKER_RATE%2==0) {
	    p = game_gl_grid2coord(g, g->sim.player[i].arrow[j].pos);
	    q = game_gl_grid2coord(g, grid_int_pos(g->sim.player[i].arrow[j].pos.x+1, g->sim.player[i].arrow[j].pos.y+1));
	    
	    width = q.x - p.x;
	    height = q.y - p.y;
	    
	    center.x = (q.x+p.x)/2;
	    center.y = (q.y+p.y)/2;
	    
	    glPushMatrix();
	    
	    glTranslatef(center.x, center.y, 0);
	    
	    glScalef(width/2, height/2, 1);
	    
	    show_arrow(g, i, g->sim.player[i].arrow[j].health, g->sim.player[i].arrow[j].dir);
	    
	    glPopMatrix();
	  }
  
  glEnable(GL_LIGHTING);
  glEnable(GL_DEPTH_TEST);

}

void show_pointer_triangle()
{
  glBegin(GL_TRIANGLES);
  glVertex3f(0, 0, 0);
  glVertex3f(.1, -.2, 0);
  glVertex3f(.2, -.1, 0);
  glEnd();
}

void show_pointers(game *g)
{
  int i;
  coord c;
  grid_float_position p;
  vector v;
  
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_LIGHTING);
  
  for(i=0; i<MAX_PLAYER; i++)
    if(g->sim.player[i].exists)
      if(game_input_player_exists(g, i)) {
	
	/*	glBindTexture(GL_TEXTURE_2D, TEX(PLAYER0+i));*/

	glBindTexture(GL_TEXTURE_2D, 0);

	glPushMatrix();
	
	v = game_input_player_pointer(g, i);
	p.x = v.x;
	p.y = v.y;
	
	p.x *= NUM_BLOCKS_X;
	p.y *= NUM_BLOCKS_Y;
	
	c = game_gl_gridf2coord(g, p);
	
	glTranslatef(c.x, c.y, 0);
	
	glColor4f(1, 1, 1, 1);
	glPushMatrix();
	glTranslatef(-0.02, 0.02, 0);
	glScalef(1.18, 1.18, 1);
	show_pointer_triangle();
	glPopMatrix();

	glColor4fv(player_color[i]);
	show_pointer_triangle();
	
	glPopMatrix();
      }
  
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
}

void show_digits(game *g, float x, float y, char *string, int center, float alpha)
{
  glEnable(GL_BLEND);

  glPushMatrix();
  
  glTranslatef(x, y, 0);

  glColor4f(alpha, alpha, alpha, alpha);
  glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_COLOR);
  print_in(g, string, center, DIGIT);
  
  glColor4f(1, 1, 1, alpha);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
  print_in(g, string, center, DIGIT);
  
  glBlendFunc(GL_SRC_ALPHA, GL_ONE);

  glPopMatrix();

  glDisable(GL_BLEND);
}  

void show_score_changes(game *g)
{
  int x, y;
  coord p;
  char buff[10];
  int i;

  for(x=0; x<NUM_BLOCKS_X; x++)
    for(y=0; y<NUM_BLOCKS_Y; y++)
      if(g->sim.score_change_timer[x][y] > 0) {
	p = centerf(g, game_gl_grid2coord(g, grid_int_pos(x, y)));
	
	sprintf(&buff[0], g->sim.score_change[x][y] > 0 ? ":%d":"%d", g->sim.score_change[x][y]);
	
	for(i=0; buff[i]; i++)
	  if(buff[i]=='-')
	    buff[i] = ';';
	
	show_digits(g, p.x, p.y, &buff[0], 1, ((float)g->sim.score_change_timer[x][y])/SCORE_CHANGE_L);
      }
}
	
void show_interface(game *g)
{
  int i, d;
  char buff[100];
  int count;

  glEnable(GL_BLEND);
  glDisable(GL_LIGHTING);
  glDisable(GL_DEPTH_TEST);

  if(g->sim.type == BATTLE) {
    for(i=0; i<MAX_PLAYER; i++)
      if(g->sim.player[i].exists) {
	glColor4fv(player_color[i]);
	
	sprintf(&buff[0], "%03d", g->sim.player[i].score);
	
	print_over(g, i*120, 10, buff, DIGIT, .8);
      }
  }
  else {
    if(g->sim.type == PUZZLE) {
      glColor4fv(player_color[0]);
      
      sprintf(&buff[0], "%03d", g->sim.player[0].score);
      
      print_over(g, 0, 10, buff, DIGIT, .8);
    }
  }
	
      
    
  glColor4f(1, 1, 1, 1);
  
  sprintf(&buff[0], "%01d%c%02d", g->sim.clock/1000/60, '9'+3, g->sim.clock/1000%60);
  
  print_over(g, 500, 10, buff, DIGIT, .8);
  
  glDisable(GL_BLEND);

  /* free arrows for puzzle mode */

  count = 0;

  if(g->sim.type == PUZZLE)
    for(d=0; d<MAX_DIR; d++)
      for(i=0; i<g->sim.map.max_arrow[d] - arrow_dir_count(&g->sim, d); i++) {
	printf("dir %d\n", d);
	glPushMatrix();
	glTranslatef(1.48, .9-.25*count, 0);
	glScalef(.1, -.1, 1);
	show_arrow(g, 0, 1, d);
	glPopMatrix();
	count++;
      }

  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glDisable(GL_BLEND);
  
}

#define WINNER_WIDTH 2.0
#define WINNER_HEIGHT (WINNER_WIDTH/8.0)

void winner_picture(game *g, float basey)
{
    glBegin(GL_QUADS);

    glTexCoord2d(0, basey+1.0/8);
    glVertex3f(-WINNER_WIDTH/2, -WINNER_HEIGHT/2, 0);

    glTexCoord2d(1, basey+1.0/8);
    glVertex3f(WINNER_WIDTH/2, -WINNER_HEIGHT/2, 0);

    glTexCoord2d(1, basey);
    glVertex3f(WINNER_WIDTH/2, WINNER_HEIGHT/2, 0);
    
    glTexCoord2d(0, basey);
    glVertex3f(-WINNER_WIDTH/2, WINNER_HEIGHT/2, 0);

    glEnd();
}

void show_winner(game *g)
{
  int i;
  float basey;
  float per;

  glDisable(GL_LIGHTING);
  glDisable(GL_DEPTH_TEST);
  glEnable(GL_BLEND);

  i = sim_winner(&g->sim);
  
  if(g->sim.state == POST_GAME) {
    
    glBindTexture(GL_TEXTURE_2D, TEX(WINNER));
    
    if(g->sim.type == BATTLE) {
      if(i >= 0)
	basey = 0;
      else
	basey = 1.0/8;
    }
    else if(g->sim.type == PUZZLE) {
      if(i >= 0)
	basey = 2.0/8;
      else
	basey = 3.0/8;
    }
    else
      return; /* this might cause trouble */

    per = 1 - ((float)g->sim.state_timer)/POST_GAME_LENGTH;

    per *= 4;
    
    if(per > 2)
      per = 2;    
    
    glPushMatrix();
    glScalef(per, per, 1);
    
    glBlendFunc(GL_ZERO, GL_ONE_MINUS_SRC_COLOR);
    glColor4f(1, 1, 1, 1);
    winner_picture(g, basey);
    glBlendFunc(GL_ONE, GL_ONE);
    if(i >= 0)
      glColor4fv(player_color[i]);
    else
      glColor4f(1, 1, 1, 1);
    
    winner_picture(g, basey);
    
    glPopMatrix();
    
  }
  
  glDisable(GL_BLEND);
}
    

#define SPINNER_LENGTH 1
#define SPINNER_HEIGHT 0.1
#define SPINNER_RADIUS (.5*SPINNER_HEIGHT+SPINNER_HEIGHT/pow(2,.5))
#define SPINNER_Z_POS 1

void show_mode_change(game *g)
{
  int i;
  float per;
  
  glDisable(GL_LIGHTING);
  glEnable(GL_DEPTH_TEST);

  if(g->sim.mode == MODE_INTRO) {
    
    glColor4f(1, 1, 1, 1);
    
    glTranslatef(.1, 0, SPINNER_Z_POS);
    
    glBindTexture(GL_TEXTURE_2D, TEX(Q_MOUSE_TYPES));
    
    glPushMatrix();
    
    per = 1 - (float)g->sim.mode_timer/MODE_INTRO_L;
    
    per *= 3;
    
    if(per > 1)
      per = 1;
    
    per = pow(per, .25);
    
    glRotatef(per * 360*3, 1, 0, 0);

    glRotatef((MAX_QMOUSE_TYPE - g->sim.next_mode)*360/MAX_QMOUSE_TYPE, 1, 0, 0);
    
    glTranslatef(-SPINNER_LENGTH/2.0, 0, 0);

    i=0;
    
    for(i=0; i<MAX_QMOUSE_TYPE; i++) {
      glPushMatrix();
      
      glRotatef(360/8.0*i, 1, 0, 0);
      glBegin(GL_QUADS);
      
      glTexCoord2f(0, i/8.0);
      glVertex3f(0, SPINNER_HEIGHT/2, SPINNER_RADIUS);
      glTexCoord2f(0, i/8.0+1/8.0);
      glVertex3f(0, -SPINNER_HEIGHT/2, SPINNER_RADIUS);
      glTexCoord2f(1, i/8.0+1/8.0);
      glVertex3f(SPINNER_LENGTH, -SPINNER_HEIGHT/2, SPINNER_RADIUS);
      glTexCoord2f(1, i/8.0);
      glVertex3f(SPINNER_LENGTH, SPINNER_HEIGHT/2, SPINNER_RADIUS);
      
      glEnd();
      
      glPopMatrix();
    }
    
    
    
    glPopMatrix();

  }
    /*
    text = mode_string(s->next_mode);

    temp = render_text(go->mode_intro_font, text, white, box_color);
    */

  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);

}

void show_grid_boxes(game *g)
{
  coord p1, p2, p3, p4;
  int i;
  grid_int_position pos;
  float len;

  glDisable(GL_DEPTH_TEST);
  glDisable(GL_LIGHTING);
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  
  glBindTexture(GL_TEXTURE_2D, 0);
  
  for(i=0; i<MAX_PLAYER; i++)
    if(game_input_player_exists(g, i)) {
      
      pos = game_input_player_grid_pos(g, i);
	
      p1 = game_gl_grid2coord(g, pos);
	
      pos.x++;
      p2 = game_gl_grid2coord(g, pos);
	
      len = p2.x - p1.x;
	
      pos.y++;
      p3 = game_gl_grid2coord(g, pos);
	
      pos.x--;
      p4 = game_gl_grid2coord(g, pos);

      if(free_for_arrow(&g->sim, game_input_player_grid_pos(g, i), -1))
	glColor4f(1.0, 1.0, 1.0, 0.9);
      else
	glColor4f(0.7, 0.7, 0.7, 0.9);
	
      glBegin(GL_QUADS);
	
      glVertex3f(p1.x, p1.y, 0);
      glVertex3f(p1.x+len*2/5, p1.y, 0);
      glVertex3f(p1.x+len*2/5, p1.y-len/8, 0);
      glVertex3f(p1.x, p1.y-len/8, 0);
	
      glVertex3f(p1.x, p1.y-len/8, 0);
      glVertex3f(p1.x, p1.y-len*2/5, 0);
      glVertex3f(p1.x+len/8, p1.y-len*2/5, 0);
      glVertex3f(p1.x+len/8, p1.y-len/8, 0);
	
      glVertex3f(p2.x, p2.y, 0);
      glVertex3f(p2.x-len*2/5, p2.y, 0);
      glVertex3f(p2.x-len*2/5, p2.y-len/8, 0);
      glVertex3f(p2.x, p2.y-len/8, 0);
	
      glVertex3f(p2.x, p2.y-len/8, 0);
      glVertex3f(p2.x, p2.y-len*2/5, 0);
      glVertex3f(p2.x-len/8, p2.y-len*2/5, 0);
      glVertex3f(p2.x-len/8, p2.y-len/8, 0);
	
      glVertex3f(p3.x, p3.y, 0);
      glVertex3f(p3.x-len*2/5, p3.y, 0);
      glVertex3f(p3.x-len*2/5, p3.y+len/8, 0);
      glVertex3f(p3.x, p3.y+len/8, 0);
	
      glVertex3f(p3.x, p3.y+len/8, 0);
      glVertex3f(p3.x, p3.y+len*2/5, 0);
      glVertex3f(p3.x-len/8, p3.y+len*2/5, 0);
      glVertex3f(p3.x-len/8, p3.y+len/8, 0);
	
      glVertex3f(p4.x, p4.y, 0);
      glVertex3f(p4.x+len*2/5, p4.y, 0);
      glVertex3f(p4.x+len*2/5, p4.y+len/8, 0);
      glVertex3f(p4.x, p4.y+len/8, 0);
	
      glVertex3f(p4.x, p4.y+len/8, 0);
      glVertex3f(p4.x, p4.y+len*2/5, 0);
      glVertex3f(p4.x+len/8, p4.y+len*2/5, 0);
      glVertex3f(p4.x+len/8, p4.y+len/8, 0);
	
      glEnd();
    }
  
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
}

void show_dead_mice(game *g)
{
  int i;
  float per;
  
  glEnable(GL_BLEND);
  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
  glBindTexture(GL_TEXTURE_2D, TEX(MOUSE));
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_LIGHTING);
  
  for(i=0; i<MAX_DEAD_MOUSE; i++)
    if(GO.dead_mouse[i].exists && g->sim.elapsed - GO.dead_mouse[i].start < DEAD_MOUSE_LIFE) {

      per = 1 - ((float)g->sim.elapsed - GO.dead_mouse[i].start)/DEAD_MOUSE_LIFE;
      per *= .5;

      glColor4f(0.5, 0.5, 0.5, per);
      
      glPushMatrix();

      glTranslatef(GO.dead_mouse[i].x, GO.dead_mouse[i].y, GO.dead_mouse[i].z);
      
      show_creature(g, mouse, 0, 0);
      
      glPopMatrix();
    }

  glDisable(GL_BLEND);
}    
  

void go_gl_refresh(game *g, SDL_Surface *out)
{
  sound_refresh(g);
  
  if(out->w != GO.w || out->h != GO.h)
    init_gl(g, out->w, out->h);

  /*    resizeWindow(g, out->w, out->h);*/

  /* Reset The View */
  glLoadIdentity( );
  
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

  /* angle view */

  /*
  glRotatef(-45, 1, 0, 0);
  glTranslatef(0, 1.7, 0);
  */

  glPushMatrix();
  
  glTranslatef(-0.1, 0.1, BOARD_DEPTH);

  show_board(g);
  show_arrows(g);
  show_grid_boxes(g);
  show_walls(g);
  show_wallposts(g);
  show_generators(g);
  show_creatures(g);
  show_floaters(g);
  show_dead_mice(g);
  show_explosions(g);
  show_rockets(g);
  show_pointers(g);
  show_score_changes(g);
  show_interface(g);
  show_winner(g);
  show_mode_change(g);

  glPopMatrix();
  
  return;
}

void go_gl_bigchange(game *g)
{
  return;
}

void go_gl_exit(game *g)
{
  change_screen(SCREEN_WIDTH, SCREEN_HEIGHT, 0);
  return;
}

void go_gl_init(game *g)
{
  printf("Initializing GL game output.\n");

  game_output_refresh      = go_gl_refresh;
  game_output_handle_event = go_gl_handle_event;
  game_output_bigchange    = go_gl_bigchange;
  game_output_exit         = go_gl_exit;

  g->output = malloc(sizeof(go_gl));
  
  GO.type = GL;
  
  change_screen(WIDTH, HEIGHT, 1);
  
  init_gl(g, WIDTH, HEIGHT);
}

#endif /* HAVE_GL */
