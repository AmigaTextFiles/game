/* $Id: object3d.h,v 1.6 2002/05/31 11:26:00 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */

#ifndef __OBJECT3D__
#define __OBJECT3D__

#include <GL/gl.h>
#include <math.h>

#define MAX_BOUND	4

// STATES
#define STATE_DRAW          2
#define STATE_MOVE	    4
#define STATE_COLLISION	    8
#define STATE_FIRE	    16
#define STATE_IMPACT        32
#define STATE_TURN_LEFT     64
#define STATE_TURN_RIGHT    128
#define STATE_NORMAL	(STATE_DRAW|STATE_MOVE|STATE_COLLISION|STATE_FIRE)

// TYPES
#define TYPE_PLAYER     1
#define TYPE_ENEMY      2
#define TYPE_WALL       3
#define TYPE_LASER      4

struct Sphere { // for collitions
    float c[3]; // center
    float r;    // radius
};

typedef struct {
    float c[3]; // coords
    float n[3]; // normals
} Vertex;

typedef struct {
    Vertex *v[3]; // index of 3 vertices in the vertex list
} Triangle;

typedef struct {
    float tr[3];    // translation vector
    float r[3];     // rotation vector
    float v[3];     // velocity vector
    float color[3]; // color vector
    Vertex *vertex; // vertex list
    Triangle *t; // triangle list
    int num_faces;
    int num_vertices;
    int state;
    int type;
    GLuint display_list;

    // collitions control
    struct Sphere bound[MAX_BOUND];
    int num_bounds;
} Object3d;

#define ABS(n) (n>=0?(n):-(n))
#define RAD(g) (g * M_PI / 180.0) // convert grades to radians

#define OBJECT_BOUND(o,x,y,z,rad) {\
    (o).bound[(o).num_bounds].c[0] = x; \
    (o).bound[(o).num_bounds].c[1] = y; \
    (o).bound[(o).num_bounds].c[2] = z; \
    (o).bound[(o).num_bounds].r = rad;  \
    ((o).num_bounds)++;                 \
}

void Object3d_calc_normals(Object3d *o);
void Object3d_spin(Object3d *o, float g);
int Object3d_collision(Object3d *o1, Object3d *o2);
void Object3d_set_vel(Object3d *o, float v);
void Object3d_update_pos(Object3d *o);
void Object3d_draw(Object3d *o);
void Object3d_draw_list(Object3d *o);
void Object3d_gen_list(Object3d *o);
void Object3d_load(Object3d *o, char *name);
void Object3d_shift(Object3d *o, float shift);

#endif
