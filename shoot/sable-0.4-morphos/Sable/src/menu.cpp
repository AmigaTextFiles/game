/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  menu.cpp: The main menu
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */

#include "sable.h"

#include <SDL.h>
#include "menu.h"
#include "textures.h"
#include "models.h"
#include "input.h"
#include "sound.h"

void
Menu::init (void)
{
	selection = 0;
	button_down = false;
	playerInput.reset ();

	/* Initialize game graphics */
	glShadeModel( GL_SMOOTH );

	/* Culling. */
	glCullFace( GL_BACK );
	glFrontFace( GL_CCW );
	glEnable( GL_CULL_FACE );

	/* Set the clear color. */
	glClearColor ( 0.0f, 0.0f, 0.0f, 0.0f );

	/* Initialize lighting */
	GLfloat light_position0[] = { 0.5, 1.0, 1.0, 0.0 };
	GLfloat white_light[] = {1.0, 1.0, 1.0, 1.0 };
	GLfloat lmodel_ambient[] = { 0.5, 0.5, 0.5, 1.0 };

	glLightfv(GL_LIGHT0, GL_POSITION, light_position0);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light);
	glLightfv(GL_LIGHT0, GL_SPECULAR, white_light);
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, lmodel_ambient);
	glEnable (GL_LIGHT0);

	glEnableClientState (GL_NORMAL_ARRAY);
	glEnableClientState (GL_VERTEX_ARRAY);

	rotate = 90.0f;
	play_music (MENU_MUSIC);
}

void
Menu::uninit (void)
{
	glDisableClientState (GL_NORMAL_ARRAY);
	glDisableClientState (GL_VERTEX_ARRAY);
	stop_music ();
}

EnvID
Menu::processEvents (void)
{
	SDL_Event event;

	playerInput.frameAdvance ();
	while( SDL_PollEvent( &event ) ) {
		switch( event.type ) {
		case SDL_QUIT:
			/* Handle quit requests (like Ctrl-c). */
			return ENVIRON_EXIT;
			break;
		default:
			break;
		}
		playerInput.process (&event);
	}
	if (playerInput.pulse_quit ())
		return ENVIRON_EXIT;
	if ((!button_down) && 
	    (playerInput.pulse_up () || playerInput.pulse_down ()))
		selection = 1 - selection;
	if (playerInput.pulse_fire ())
		button_down = true;
	if (playerInput.endpulse_fire () && button_down)
		return selection ? ENVIRON_EXIT : ENVIRON_GAME;		
		
	return ENVIRON_MENU;
}

void
Menu::frameAdvance (void)
{
	rotate += 1.0f;
	while (rotate >= 360.0f) rotate -= 360.0f;
}

void
Menu::renderScreen (void)
{
	glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	/* Draw the Sable */
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluPerspective (60.0, 640.0 / 480.0, 1.0, 500.0);
	glEnable (GL_DEPTH_TEST);
	glEnable (GL_LIGHTING);
	glMatrixMode (GL_MODELVIEW);
	glLoadIdentity ();

	glTranslatef(0.0f, 0.0f, -15.0f);
	glRotatef((GLfloat)rotate, 0.0f, 1.0f, 0.0f);
	glRotatef(-110.0f, 1.0f, 0.0f, 0.0f);
	geomPlayer.render ();

	/* Render the menu itself */
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluOrtho2D (0, 640, 0, 480);
	glMatrixMode (GL_MODELVIEW);
	glLoadIdentity ();

	glDisable (GL_LIGHTING);
	glDisable (GL_DEPTH_TEST);
	glEnable (GL_TEXTURE_2D);
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);

	glEnable (GL_BLEND);
	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	select_texture (MENU_TEX);
	glBegin (GL_QUADS);
	glColor3f (1.0f, 1.0f, 1.0f);
	draw_mosaic (192, 400, 0, 4, 7, 5);
	
	int line[2];
	for (int i = 0; i < 2; i++)
	{
		if (selection == i) {
			line[i] = button_down ? 2 : 1;
		} else {
			line[i] = 0;
		}
	}
	draw_mosaic (256, 150, 0, line[0], 3, line[0]);
	draw_mosaic (256, 100, 4, line[1], 7, line[1]);
	glEnd ();

	select_texture (FONT_TEX);
	glBegin (GL_QUADS);
	draw_mosaic (170, 300, 0, 3, 6, 3);
	draw_mosaic (170, 250, 0, 4, 6, 4);
	draw_number (340, 300, 7, last_score);
	draw_number (340, 250, 7, high_score);
	glEnd ();


	glDisable (GL_TEXTURE_2D);
	glDisable (GL_BLEND);

	SDL_GL_SwapBuffers ();
}
