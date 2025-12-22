/*  The Blue Mango Quest
 *  Copyright (c) Clément 'phneutre' Bourdarias (code)
 *                   email: phneutre@users.sourceforge.net
 *                Guillaume 'GuBuG' Burlet (graphics)
 *                   email: gubug@users.sourceforge.net
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Library General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 */

#ifdef WIN32
#include <windows.h>
#endif
#include <stdio.h>
#include <stdlib.h>
#include <GL/gl.h>
#include <GL/glu.h>
#include <SDL/SDL.h>

#ifdef HAVE_SDL_MIXER
# include <SDL/SDL_mixer.h>
#endif

#include <math.h>

#include "font.h"

#include "timers.h"
#include "world_geometry.h"
#include "hut.h"
#include "bonus.h"
#include "mango.h"
#include "world_building.h"
#include "texture.h"
#include "sector.h"
#include "map.h"
#include "system_gl.h"
#include "draw_scene_gl.h"
#include "hud.h"

extern player_t *player;
extern game_data_t *world;

#define _FOV_ 1.043

int TESTEUR=0;

void draw_entire_scene_GL()
{
  set_GL_projection (MANGO_3D);
  set_GL_options (MANGO_3D);
  glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
  glLoadIdentity();
  draw_3D_scene();
  
  set_GL_projection (MANGO_2D);
  set_GL_options (MANGO_2D);

  draw_HUD();

  SDL_GL_SwapBuffers();
}


void draw_3D_scene()
{
  glRotatef(-180*player->elevation+player->x_rot, 1.0f, 0, 0); 
  glRotatef(180*player->elevation, 0.0f, 1.0, 0);

  glRotatef(360.0f - player->y_rot, 0, 1.0f, 0);
  glTranslatef(-player->pos_x, -player->pos_y[player->elevation], -player->pos_z);

  if (player->status == STATUS_DEAD)
    {
      fade_out_black();
    } 

  draw_sectors();
}

void draw_sectors()
{
  TESTEUR = -10;
  test_visibility_sectors(player->mySector, player->u, _FOV_);

  for (int i=0; i < world->num_sectors; i++)
    {
      if (world->sectors[i].visible)
	{
	  draw_empty_rooms(&world->sectors[i]);

	  test_visibility_bonus(&world->sectors[i]);
	  draw_bonus(&world->sectors[i]);

	  draw_huts_and_shmollux(&world->sectors[i]);
	  draw_teleports(&world->sectors[i]);
	  draw_winning_post(&world->sectors[i]);
	}

      reset_sector(&world->sectors[i]);
    }

  reset_portals();
}

void draw_empty_rooms(sector_t *sector)
{
  //GLfloat mat_specular[] = {1.0, 1.0, 1.0, 1.0};
  //GLfloat mat_shininess[] = {10.0};

  triangle_t *triangle=0;

  glEnable(GL_TEXTURE_2D);

  glMaterialfv(GL_FRONT, GL_AMBIENT_AND_DIFFUSE, world->mat_amb_diff);
  //glMaterialfv(GL_FRONT, GL_SPECULAR, mat_specular);
  //glMaterialfv(GL_FRONT, GL_SHININESS, mat_shininess);

  for (int i=0; i < sector->num_triangles; i++)
    {
      triangle = &(sector->triangles[i]);
      if (triangle->texture != -3)
      {
	
	glBindTexture(GL_TEXTURE_2D, world->base_tex[triangle->texture]);

	glBegin(GL_TRIANGLES);

	// vertex 0
	glNormal3f(triangle->normal_x, triangle->normal_y,triangle->normal_z);

	glTexCoord2f(triangle->vertex[0].u, triangle->vertex[0].v);

	glVertex3f(triangle->vertex[0].x, triangle->vertex[0].y,
		   triangle->vertex[0].z);

	
	// vertex 1
	glTexCoord2f(triangle->vertex[1].u, triangle->vertex[1].v);

	glVertex3f(triangle->vertex[1].x, triangle->vertex[1].y,
		   triangle->vertex[1].z);

	
	// vertex 2
	glTexCoord2f(triangle->vertex[2].u, triangle->vertex[2].v);

	glVertex3f(triangle->vertex[2].x, triangle->vertex[2].y,
		   triangle->vertex[2].z);

	glEnd();
      }
    }

  glDisable (GL_TEXTURE_2D);
}

void draw_bonus(sector_t *sector)
{
  bonus_t *bonus;

  for (int i=0; i < sector->num_bonus; i++)
    {
      bonus = &sector->bonus[i];
      if ((bonus->visible)&&(bonus->still_here))
	{
	  if (bonus->type == -1) 
	    world->dituboite->affiche(bonus->x, bonus->y, bonus->z, 0,0);

	  else 
	    world->tab_bonus[bonus->type]->affiche(bonus->x,bonus->y,bonus->z,1,1);
	}
    }
}

void draw_huts_and_shmollux(sector_t *sector)
{
  int i=0, j=0;
  double coordX=0, coordZ=0;
  sector_t *tmpSe=0, *tmpSe2=0;

  hut_t *hut;
  shmollux_t *shmollux;

  for (i=0; i < world->num_huts; i++)
    {
      hut = &world->huts[i];
      coordX = hut->pos_x;
      coordZ = hut->pos_z;
      tmpSe = get_sector(coordX,coordZ);
      if (tmpSe == sector) draw_hut(hut);

      for (j=0; j < hut->total_num_shmol;j++)
	{
	  shmollux = &hut->shmollux[j];
	  coordX = shmollux->pos_x;
	  coordZ = shmollux->pos_z;
	  tmpSe2 = get_sector(coordX,coordZ);
	  shmollux->my_sector = (sector_t *)tmpSe2;
	  if (tmpSe2==sector) draw_shmollux(shmollux);
	}
    }
}

void draw_teleports(sector_t *sector)
{
  int i=0;
  double coordX=0, coordZ=0;
  sector_t *tmpSe=0;

  special_texture_t *teleport;

  if (world->num_teleports > 0) {
    for (i=0; i < world->num_teleports; i++)
      {
	teleport = &world->teleports[i];
	coordX = teleport->pos_x;
	coordZ = teleport->pos_z;
	tmpSe = get_sector(coordX,coordZ);
	if (tmpSe == sector) draw_one_special_texture(teleport);
      }
  }
}

void draw_winning_post(sector_t *sector)
{
  double coordX=0, coordZ=0;
  sector_t *tmpSe=0;

  special_texture_t *post;
  special_3d_object_t *obj;

  if (world->finish_square >= 0) {
    post = &world->winning_post;
    coordX = post->pos_x;
    coordZ = post->pos_z;
    tmpSe = get_sector(coordX,coordZ);
    if (tmpSe == sector) { 
      obj = &world->winning_post_object;
      draw_one_special_texture(post);
      draw_one_special_3d_object(obj);
    }
  }
}

void fade_out_black()
{
  for (int i=0; i < 4; i++) 
    world->mat_amb_diff[i] -= 0.0006 * world->game_sync->dt;
}

void reset_fog_state()
{
  GLfloat color[4]={0.0f,0.0f,0.0f,1.0f};
  glFogfv(GL_FOG_COLOR, color);
  glFogf(GL_FOG_START, 15.0);
  glFogf(GL_FOG_END, 40.0);
  glFogf(GL_FOG_DENSITY, 0.1);
  glClearColor(0.0f,0.0f,0.0f,0.0f);
  glEnable(GL_FOG);
}
