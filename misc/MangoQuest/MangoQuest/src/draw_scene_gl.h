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

#ifndef _DRAW_SCENE_GL_H
#define _DRAW_SCENE_GL_H

void draw_entire_scene_GL();
void draw_entire_scene_GL_and_ingame_menu();

void draw_3D_scene();
void draw_sectors();

void draw_empty_rooms(sector_t *sector);
void draw_bonus(sector_t *sector);
void draw_huts_and_shmollux(sector_t *sector);
void draw_teleports(sector_t *sector);
void draw_winning_post(sector_t *sector);
void draw_one_special_texture(special_texture_t *teleport);
void draw_one_special_3d_object(special_3d_object_t *obj);

void fade_out_black();
void reset_fog_state();

#endif
