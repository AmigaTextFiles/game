/* $Id: wall.c,v 1.4 2002/05/13 07:59:45 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */
#include <math.h>
#include "scenario.h"
#include "wall.h"
#include "cache.h"
#include "object3d.h"

//static char *wall_filename = DATA_DIR"models/cube.obj";
static char *wall_filename = DATA_DIR"models/tetra.obj";

void Wall_init(Object3d *wall)
{
    Object3d *o;
 
    wall->v[0] = wall->v[1] = wall->v[2] = 0.0f;
    wall->r[0] = wall->r[1] = wall->r[2] = 0.0f;

    wall->state = STATE_DRAW|STATE_COLLISION;
    wall->color[0] = 0.0;
    wall->color[1] = 0.3;
    wall->color[2] = 0.6;

    // bounding sphere
    wall->num_bounds = 0;
    OBJECT_BOUND((*wall), 0.0, 0.0, 0.0, 0.7);
    
    o = Cache_get_object3d(wall_filename);
    wall->display_list = o->display_list;
}

