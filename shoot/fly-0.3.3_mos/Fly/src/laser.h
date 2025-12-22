/* $Id: laser.h,v 1.3 2002/04/12 08:16:26 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __LASER__
#define __LASER__

#include "object3d.h"

typedef struct {
    Object3d o;
} Laser;


void Laser_init(Laser *laser, Object3d *parent);
void Laser_draw(Laser *laser);
int Laser_update_pos(Laser *laser); 

#endif
