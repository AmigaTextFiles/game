/* $Id: camera.h,v 1.3 2002/04/12 08:16:26 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __CAMERA__
#define __CAMERA__

enum Camera_type { E_FOLLOW, E_FOLLOW2, E_LOOKAT, E_STATIC};

struct Camera {
    float tx, ty, tz; // translation
    float itx, ity, itz; // Initial translation
    float rx, ry, rz; // rotation
    float irx, iry, irz; // Initial rotation

    enum Camera_type type;
};


#include "flyer.h"

int Camera_get_width();
int Camera_get_height();
void Camera_set_size(int width, int height);

struct Camera *Camera_new(int n);
void Camera_set(struct Camera *camera);
void Camera_update_pos(struct Camera *camera, Flyer *flyer);
void Camera_update_pos_follow(struct Camera *camera, Flyer *flyer);
void Camera_update_pos_follow2(struct Camera *camera, Flyer *flyer);
void Camera_update_pos_static(struct Camera *camera);
void Camera_update_pos_lookat(struct Camera *camera, Flyer *flyer);

#endif
