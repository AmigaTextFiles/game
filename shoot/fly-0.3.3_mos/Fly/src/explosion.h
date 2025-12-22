/* $Id: explosion.h,v 1.3 2002/04/12 08:16:26 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __EXPLOSION__
#define __EXPLOSION__

#include "object3d.h"
#include "list.h"

typedef struct {
    Object3d o;

    int explode_time;       // all times in milliseconds
    int explode_time_actual;
} Explosion;


void Explosion_init(Explosion *e, Object3d *parent);
void Explosion_draw(Explosion *e);
int Explosion_update_pos(Explosion *e); 

#endif
