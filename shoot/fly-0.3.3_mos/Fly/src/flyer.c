/* $Id: flyer.c,v 1.9 2002/06/18 07:51:54 bladecoder Exp $
 * 
 * This program is under GPL.
 * See COPYING file for license information.
 * (C) Rafael García.
 */
#include <math.h>
#include <stdlib.h>
#include <GL/gl.h>
#include "vector.h"
#include "scenario.h"
#include "explosion.h"
#include "flyer.h"
#include "timing.h"
#include "laser.h"
#include "level.h"
#include "cache.h"

void Flyer_init(Flyer *f, char *filename)
{
    Object3d *o;
    
    f->o.tr[0] = f->o.tr[2] = 0.0f;
    f->o.tr[1] = 1.0f;
    f->o.r[0] = f->o.r[1] = f->o.r[2] = 0.0f;
    f->o.v[0] = f->o.v[1] = f->o.v[2] = 0.0f;
    Object3d_set_vel(&(f->o), 15.0);

    f->o.state = STATE_NORMAL;
    //f->spin_vel = 150;  // grades per second
    f->spin_vel = 100;  // grades per second
    f->explode_time = 800; // milliseconds
    f->fire_time = 0;  // milliseconds
    f->fire_time_last= actual_tick;
    f->impact_time = 100;
    f->energy = 100;
    f->points = 0;
    f->o.color[0] = f->o.color[1] = f->o.color[2] = 0.4f;
    VECTOR_CPY( f->tmpcolor, f->o.color);
    f->AI = Flyer_AI3;

    // bounding sphere
    f->o.num_bounds = 0;
    OBJECT_BOUND(f->o, 0.0, 0.0, 0.0, 0.5);

    strcpy(f->filename, filename);
    o = Cache_get_object3d(filename);
    f->o.display_list = o->display_list;
}


void Flyer_fire(Flyer *f, List *lasers)
{
    Laser *laser;
    
    if(!(f->o.state & STATE_FIRE)) return;

    if(f->fire_time > actual_tick - f->fire_time_last) {
	return;
    } else f->fire_time_last = actual_tick;

    laser = (Laser *)malloc(sizeof(Laser));
    list_add(lasers, laser);
    Laser_init(laser, &(f->o));
}

void Flyer_draw(Flyer *f)
{
    if(f->o.state & STATE_IMPACT) {
        f->o.color[0] = 0.4;
        f->o.color[1] = 0.0;
        f->o.color[2] = 0.0;
        
        if(f->impact_time < actual_tick - f->impact_time_last) {
            f->o.state &= ~STATE_IMPACT;
            VECTOR_CPY(f->o.color, f->tmpcolor);
        } 
    }
    
    Object3d_draw_list(&(f->o));
}

void Flyer_update_pos(Flyer *f) {
    
    Object3d_update_pos(&(f->o));

    if(f->o.tr[0] > Scenario_get_width() + 1.0) f->o.tr[0] = Scenario_get_width() + 1.0;
    else if(f->o.tr[0] < -1.0) f->o.tr[0] = -1.0;
    if(f->o.tr[2] > Scenario_get_height() + 1.0) f->o.tr[2] = Scenario_get_height() + 1.0;
    else if(f->o.tr[2] < -1.0) f->o.tr[2] = -1.0;
}

void Flyer_explode(Flyer *f, List *explosions)
{
    Explosion *e = (Explosion *)malloc(sizeof(Explosion));
    list_add(explosions, e);
    memcpy(&(e->o), Cache_get_object3d(f->filename), sizeof(Object3d));
    Explosion_init(e, &(f->o));
    e->explode_time = f->explode_time;
}

/*
 * Make the next movement of one flyer enemie.
 */
void Flyer_AI1(struct Level *l, Flyer *enemy)
{
    float x = enemy->o.tr[0];
    float z = enemy->o.tr[2];

    // Turn right if near of border
    if( x > Scenario_get_width() - 10 || x < 10 || 
            z > Scenario_get_height() - 10 || z < 10) {
	Object3d_spin(&(enemy->o), enemy->spin_vel * dt / 1000.0);
    }
}

/*
 * Make the next movement of one flyer enemie.
 * The enemy must decide to turn right, left or stay in the same direction.
 */
void Flyer_AI2(struct Level *l, Flyer *enemy)
{
    Flyer *f;
    Object3d *w;
    float u[3];
    float p, m;
    float x = enemy->o.tr[0];
    float z = enemy->o.tr[2];
    float epsilon = 0.1; // error margin in vision line
    float depsilon = 10.0; // dangerous distance between flyers
    float spin = 0.0; // 1 turn right, 2 turn left, 0 keep same direction

    Flyer *player = l->player;
    if(player == NULL) player = list_first(l->flyers);
    
    // Calc the direction of the union line
    Vector_sub( player->o.tr, enemy->o.tr, u);
    p = Vector_projection(enemy->o.v, u);
    m = Vector_mod(enemy->o.v);  
    
    if(p > m - epsilon) {
	Flyer_fire(enemy, l->lasers); // player locked, fire
    }

    // Turn right if near enemy or player
    for (f = list_first(l->flyers); f != NULL; f = list_next(l->flyers)) {
	if(f == enemy) continue;
	// If diferent direction doesn't spin (?)
	if(Vector_dot_product(f->o.v,enemy->o.v) > 0) continue;

	if(Vector_lengthxz(f->o.tr,enemy->o.tr) < depsilon) {
	    spin = 1;
	    break;
	}
    }

    // Turn right if near wall
    for (w = list_first(l->walls); w != NULL; w = list_next(l->walls)) {
        Vector_sub(w->tr, enemy->o.v, u);
        
        // If diferent direction doesn't spin (?)
	if(Vector_dot_product(enemy->o.v, u) > 0) continue;

	if(Vector_lengthxz(w->tr,enemy->o.tr) < depsilon) {
	    spin = 1;
	    break;
	}
    }

    // Turn right if it is in the player's line of vision
    // Calcs the direction of the union line
    Vector_sub( enemy->o.tr, player->o.tr, u);
    p = Vector_projection(player->o.v, u);
    m = Vector_mod(player->o.v);  
    
    if( p < m + epsilon && p > m - epsilon) {
	spin = 1;
    }

    // TODO: Turn right if it is in one laser's line of impact

    // Turn right if near of border
    if( x > Scenario_get_width() - 10 && enemy->o.v[0] > 0) spin = 1;
    if( x < 10 && enemy->o.v[0] < 0) spin = 1;
    if( z > Scenario_get_height() - 10 && enemy->o.v[2] > 0) spin = 1;
    if( z < 10 && enemy->o.v[2] < 0) spin = 1;
        
    
    Object3d_spin(&(enemy->o), spin * enemy->spin_vel * dt / 1000.0);
}


/*
 * Make the next movement of one flyer enemie.
 * The enemy must decide to turn right, left or stay in the same direction.
 */
void Flyer_AI3(struct Level *l, Flyer *enemy)
{
    Flyer *f;
    Object3d *w;
    float u[3],v[3];
    float p, m;
    float x = enemy->o.tr[0];
    float z = enemy->o.tr[2];
    float epsilon = 0.1; // error margin in vision line
    float depsilon = 10.0; // dangerous distance between flyers
    float spin = 0.0; // 1 turn right, 2 turn left, 0 keep same direction

    Flyer *player = l->player;
    if(player == NULL) player = list_first(l->flyers);
    
    // Calc the direction of the union line
    Vector_sub( player->o.tr, enemy->o.tr, u);
    p = Vector_projection(enemy->o.v, u);
    m = Vector_mod(enemy->o.v);  
    
    if(p > m - epsilon) {
	Flyer_fire(enemy, l->lasers); // player locked, fire
    } else {
        float p1,p2;
        
        VECTOR_CPY(v, enemy->o.v);
        Vector_rotate(v, epsilon);
        p1 = Vector_projection(v, u);
        Vector_rotate(v, -2 * epsilon);
        p2 = Vector_projection(v, u);
        
        if( p1 > p2) // Turn to search the flyer
            spin = 1.0; 
        else spin = -1.0;
    }

    // Turn right if near enemy or player
    for (f = list_first(l->flyers); f != NULL; f = list_next(l->flyers)) {
	if(f == enemy) continue;
	// If diferent direction doesn't spin (?)
	if(Vector_dot_product(f->o.v,enemy->o.v) > 0) continue;

	if(Vector_lengthxz(f->o.tr,enemy->o.tr) < depsilon) {
	    spin = 1;
	    break;
	}
    }

    // Turn right if near wall
    for (w = list_first(l->walls); w != NULL; w = list_next(l->walls)) {
        Vector_sub(w->tr, enemy->o.v, u);
        
        // If diferent direction doesn't spin (?)
	if(Vector_dot_product(enemy->o.v, u) > 0) continue;

	if(Vector_lengthxz(w->tr,enemy->o.tr) < depsilon) {
	    spin = 1;
	    break;
	}
    }

    // Turn right if it is in the player's line of vision
    // Calcs the direction of the union line
    Vector_sub( enemy->o.tr, player->o.tr, u);
    p = Vector_projection(player->o.v, u);
    m = Vector_mod(player->o.v);  
    
    if( p < m + epsilon && p > m - epsilon) {
	spin = 1;
    }

    // TODO: Turn right if it is in one laser's line of impact

    // Turn right if near of border
    if( x > Scenario_get_width() - 10 && enemy->o.v[0] > 0) spin = 1;
    if( x < 10 && enemy->o.v[0] < 0) spin = 1;
    if( z > Scenario_get_height() - 10 && enemy->o.v[2] > 0) spin = 1;
    if( z < 10 && enemy->o.v[2] < 0) spin = 1;
        
    
    Object3d_spin(&(enemy->o), spin * enemy->spin_vel * dt / 1000.0);
}

