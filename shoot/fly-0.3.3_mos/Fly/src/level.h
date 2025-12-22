/* $Id: level.h,v 1.5 2002/06/05 11:20:46 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __LEVEL__
#define __LEVEL__

#include "SDL/SDL.h"
#include "SDL/SDL_mixer.h"
#include "camera.h"
#include "list.h"
#include "flyer.h"

struct Level {
    List *flyers;
    List *lasers;
    List *walls;
    List *explosions;

    struct Camera *camera;
    Flyer *player;

    char name[100];
    Mix_Music *music;

    int num_level;
    int show_text;
    int random;
};

void Level_init(struct Level *l);
void Level_load(struct Level *l, char *filename);
void Level_rand(struct Level *l, int level);
void Level_frame(struct Level *l);
void Level_update(struct Level *l);
void Level_draw(struct Level *l);
void Level_collisions(struct Level *l);
void Level_free(struct Level *l);
void Level_process_keys(struct Level *l);
void Level_process_keyup(struct Level *l, SDLKey key);
void Level_next(struct Level *l);

#endif
