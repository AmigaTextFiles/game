/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  logo.cpp: Bumbershoot Software logo.
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
#include "logo.h"
#include "textures.h"
#include "input.h"

void
Logo::init (void)
{
	intensity = 0;
	counter = 0;
	state = 0;
	playerInput.reset ();

	/* Initialize game graphics */
	glShadeModel( GL_SMOOTH );

	/* Culling. */
	glCullFace( GL_BACK );
	glFrontFace( GL_CCW );
	glEnable( GL_CULL_FACE );

	/* Set the clear color. */
	glClearColor ( 0.0f, 0.0f, 0.0f, 0.0f );
}

void
Logo::uninit (void)
{
}

EnvID
Logo::processEvents (void)
{
	SDL_Event event;

	playerInput.frameAdvance ();
	while( SDL_PollEvent( &event ) ) {
		switch( event.type ) {
		case SDL_QUIT:
			/* Handle quit requests (like Ctrl-c). */
			return ENVIRON_EXIT;
			break;
		case SDL_KEYDOWN:
			if (state < 2)
				state = 2;
			else
				return ENVIRON_MENU;
			break;
		default:
			break;
		}
		playerInput.process (&event);
	}

	if (state > 2)
		return ENVIRON_MENU;

	return ENVIRON_LOGO;
}

void
Logo::frameAdvance (void)
{
	switch (state) {
	case 0:
		intensity += 1;
		if (intensity > 90) state++;
		break;
	case 1:
		counter++;
		if (counter > 300) state++;
		break;
	case 2:
		intensity -= 1;
		if (intensity < 10) state++;
		break;
	default:
		break;
	}
}

void
Logo::renderScreen (void)
{
	glClear (GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluOrtho2D (0, 344, 0, 258);
	glMatrixMode (GL_MODELVIEW);
	glLoadIdentity ();

	glDisable (GL_LIGHTING);
	glDisable (GL_DEPTH_TEST);
	glEnable (GL_TEXTURE_2D);
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
	glEnable (GL_BLEND);
	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	select_texture (LOGO_TEX);
	glBegin (GL_QUADS);
	draw_mosaic (44, 1, 0, 0, 7, 7);
	glEnd ();
	glDisable (GL_TEXTURE_2D);

	glBegin (GL_QUADS);
	glColor4f (0.0f, 0.0f, 0.0f, (100 - intensity) / 100.0f);
	glVertex2i (0, 0);
	glVertex2i (640, 0);
	glVertex2i (640, 480);
	glVertex2i (0, 480);
	glEnd ();

	glDisable (GL_BLEND);

	SDL_GL_SwapBuffers ();
}
