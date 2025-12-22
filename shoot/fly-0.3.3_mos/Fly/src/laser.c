/* $Id: laser.c,v 1.5 2002/06/05 11:20:46 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */
#include <math.h>
#include <SDL/SDL_mixer.h>
#include "vector.h"
#include "scenario.h"
#include "laser.h"
#include "cache.h"

static Mix_Chunk *laser_sound = NULL;
static char *laser_filename = DATA_DIR"models/laser.obj";

void Laser_init(Laser *laser, Object3d *parent)
{
    Object3d *o;
    VECTOR_CPY(laser->o.tr, parent->tr);
    VECTOR_CPY(laser->o.r, parent->r);
 
    Object3d_set_vel(&(laser->o), 17 + Vector_modxz(parent->v));

    laser->o.state = STATE_DRAW|STATE_MOVE|STATE_COLLISION;
    laser->o.color[0] = 1.0f;
    laser->o.color[1] = laser->o.color[2] = 0.0f;

    // bounding sphere
    laser->o.num_bounds = 0;
    OBJECT_BOUND(laser->o,-0.45, 0.0, 0.35, 0.15);
 
    // sound
    if(laser_sound == NULL) {
        laser_sound = Mix_LoadWAV(DATA_DIR"sound/laser.wav");
        if ( laser_sound == NULL ) {
            fprintf(stderr, "Couldn't load %s: %s\n",
                "laser.wav", SDL_GetError());
            exit(0);
        }
        
        Mix_VolumeChunk( laser_sound, 30);
    }
    
    Mix_PlayChannel(-1, laser_sound, 0);
    
    OBJECT_BOUND(laser->o,-0.45, 0.0,-0.35, 0.15);
 
    o = Cache_get_object3d(laser_filename);
    laser->o.display_list = o->display_list;
}

void Laser_draw(Laser *laser)
{
    Object3d_draw_list(&(laser->o));
}


/*
 * Update laser position.
 * If the laser exits of scenario returns false.
 */
int Laser_update_pos(Laser *laser) {
    
    if(laser->o.tr[0] > Scenario_get_width() + 10 ||laser->o.tr[0] < -10 ||
	laser->o.tr[2] > Scenario_get_height() + 10 || laser->o.tr[2] < -10) return 0;
    
    Object3d_update_pos(&(laser->o));

    return 1;
}

