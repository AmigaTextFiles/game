/* $Id: flyer.h,v 1.8 2002/06/18 07:51:54 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __FLYER__
#define __FLYER__

#include "object3d.h"
#include "list.h"

typedef struct {
    Object3d o;

    float spin_vel;   // velocity in grades per second
    int explode_time; // all times in milliseconds
    int fire_time;
    int fire_time_last;
    int impact_time;
    int impact_time_last;
    float tmpcolor[3]; // when impact the real color is saved here

    int energy;  // energy of the flyer
    int points;  // points of the flyer
    char filename[100];

    void (*AI)(); // pointer to AI function
} Flyer;


struct Level;

void Flyer_init(Flyer *f, char *filename);
void Flyer_draw(Flyer *f);
void Flyer_AI1(struct Level *l, Flyer *enemy);
void Flyer_AI2(struct Level *l, Flyer *enemy);
void Flyer_AI3(struct Level *l, Flyer *enemy);

void Flyer_update_pos(Flyer *f); 
void Flyer_fire(Flyer *f, List *lasers);
void Flyer_explode(Flyer *f, List *explosions);
void Flyer_update_explosion(Flyer *f);

#endif
