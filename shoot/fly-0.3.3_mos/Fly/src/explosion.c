/* $Id: explosion.c,v 1.6 2002/05/31 11:26:00 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */
#include <SDL/SDL_mixer.h>
#include "vector.h"
#include "timing.h"
#include "explosion.h"

static Mix_Chunk *explosion_sound = NULL;

void Explosion_init(Explosion *e, Object3d *parent)
{
    VECTOR_CPY(e->o.tr, parent->tr);
    VECTOR_CPY(e->o.v, parent->v);
    VECTOR_CPY(e->o.color, parent->color);
    e->explode_time_actual = 0;
    //e->o.state = STATE_DRAW;
    
    // sound
    if(explosion_sound == NULL) {
        explosion_sound = Mix_LoadWAV(DATA_DIR"sound/explosion.wav");
        if ( explosion_sound == NULL ) {
            fprintf(stderr, "Couldn't load %s: %s\n",
                "explosion.wav", SDL_GetError());
            exit(0);
        }
    }
 
    Mix_PlayChannel(0, explosion_sound, 0);
}

void Explosion_draw(Explosion *e)
{
    int i,j;
    float v[3][3];

    glPushMatrix();

    glTranslatef(e->o.tr[0], e->o.tr[1], e->o.tr[2]);

    glRotatef(e->o.r[0], 1.0f, 0.0f, 0.0f);
    glRotatef(e->o.r[1], 0.0f, 1.0f, 0.0f);
    glRotatef(e->o.r[2], 0.0f, 0.0f, 1.0f);
 
    glColor3fv(e->o.color);
    glBegin(GL_TRIANGLES);
	for(i = 0; i < e->o.num_faces; i++) {
            for(j = 0; j < 3; j++) {
                v[j][0] = e->o.t[i].v[j]->c[0] + e->o.t[i].v[0]->n[0] * 0.01 * 
                    e->explode_time_actual;
                v[j][1] = e->o.t[i].v[j]->c[1] + e->o.t[i].v[0]->n[1] * 0.01 *
                    e->explode_time_actual;
                v[j][2] = e->o.t[i].v[j]->c[2] + e->o.t[i].v[0]->n[2] * 0.01 *
                    e->explode_time_actual;
            }

	    glNormal3fv(e->o.t[i].v[0]->n);
	    glVertex3fv(v[0]);
	    glNormal3fv(e->o.t[i].v[1]->n);
	    glVertex3fv(v[1]);
	    glNormal3fv(e->o.t[i].v[2]->n);
	    glVertex3fv(v[2]);
	}
    glEnd();
    glPopMatrix();
}


/*
 * Update explosion position.
 *
 * Returns false when the explosion must be deleted.
 */
int Explosion_update_pos(Explosion *e) 
{
    //int i, j;

    if(e->explode_time < e->explode_time_actual) return 0;
    else e->explode_time_actual += dt;

    /*
     for(i = 0; i < e->o.num_faces; i++) {
        for(j = 0; j < 3; j++) {
	    e->o.t[i].v[j]->c[0] += e->o.t[i].v[0]->n[0] * 0.2;
	    e->o.t[i].v[j]->c[1] += e->o.t[i].v[0]->n[1] * 0.2;
	    e->o.t[i].v[j]->c[2] += e->o.t[i].v[0]->n[2] * 0.2;
        }
    }
    */

    Object3d_update_pos(&(e->o));
    
    return 1;
}
