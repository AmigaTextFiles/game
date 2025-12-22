#include <GL/gl.h>
#include <stdlib.h>
#include "level.h"
#include "flyer.h"
#include "scenario.h"
#include "camera.h"
#include "list.h"

/*
 * Draw the 2D map.
 *
 * @param follow_l->player If true, the map rotate with the l->player.
 * @param iry If 'follow_l->player' is false, this is the initial 
 *      rotation of the map.
 */
void Map_draw(struct Level *l)
{
    Flyer *enemy;
    int follow_player = l->camera->type == E_FOLLOW ? 1 : 0;
    float iry = -90.0;
    
    float height = 100.0;
    float width = Scenario_get_width() * 100 / Scenario_get_height();

    glPushMatrix();
    glLoadIdentity();
    glColor3f(0.0, 0.5, 0.2);
#ifdef __MORPHOS__
    glTranslatef(Camera_get_width() - 20, Camera_get_height() - height - 20,0);
#else
    glTranslatef(Camera_get_width() - width - 20, Camera_get_height() - 20,0);
#endif
    if(follow_player&&l->player&&0.0) glRotatef(l->player->o.r[1],0.0,0.0,1.0);
    else {
        glRotatef(iry-90, 0.0, 0.0, 1.0);
#ifdef __MORPHOS__
        glRotatef(180.0,1.0,0.0,0.0);
#else
        glRotatef(180.0,0.0,1.0,0.0);
#endif
    }

    glBegin(GL_LINE_STRIP);
        glVertex2f(0, height);
        glVertex2f(width,height);
        glVertex2f(width,0);
        glVertex2f(0,0);    
        glVertex2f(0,height);
    glEnd();
	
#ifdef __MORPHOS__
	glColor3f(0.7, 0.0, 0.0);
	for(enemy = list_first(l->flyers); enemy != NULL; enemy = list_next(l->flyers)) {
		if(enemy->o.state == STATE_NORMAL) {
			glBegin(GL_QUADS);
				glVertex2f(enemy->o.tr[0]*width/Scenario_get_width() - 2, enemy->o.tr[2]*height/Scenario_get_height() - 2);
				glVertex2f(enemy->o.tr[0]*width/Scenario_get_width() - 2, enemy->o.tr[2]*height/Scenario_get_height() + 2);
				glVertex2f(enemy->o.tr[0]*width/Scenario_get_width() + 2, enemy->o.tr[2]*height/Scenario_get_height() + 2);
				glVertex2f(enemy->o.tr[0]*width/Scenario_get_width() + 2, enemy->o.tr[2]*height/Scenario_get_height() - 2);
			glEnd();
		}
	}
	
	glColor3f(0.7, 0.7, 0.7);
	if(l->player != NULL) {
		glBegin(GL_QUADS);
			glVertex2f(l->player->o.tr[0]*width/Scenario_get_width() - 2, l->player->o.tr[2]*height/Scenario_get_height() - 2);
			glVertex2f(l->player->o.tr[0]*width/Scenario_get_width() - 2, l->player->o.tr[2]*height/Scenario_get_height() + 2);
			glVertex2f(l->player->o.tr[0]*width/Scenario_get_width() + 2, l->player->o.tr[2]*height/Scenario_get_height() + 2);
			glVertex2f(l->player->o.tr[0]*width/Scenario_get_width() + 2, l->player->o.tr[2]*height/Scenario_get_height() - 2);
		glEnd();
	}
#else
    glBegin(GL_POINTS);
	glColor3f(0.7, 0.0, 0.0);
        for(enemy = list_first(l->flyers); enemy != NULL; enemy = list_next(l->flyers)) {
	    if(enemy->o.state != STATE_NORMAL) continue;
	    glVertex2f(enemy->o.tr[0]*width/Scenario_get_width(), 
                    enemy->o.tr[2]*height/Scenario_get_height());
	}

	glColor3f(0.7, 0.7, 0.7);
	if(l->player != NULL) 
            glVertex2f(l->player->o.tr[0]*width/Scenario_get_width(), 
                l->player->o.tr[2]*height/Scenario_get_height());
    glEnd();
#endif
	
    glPopMatrix();
}
