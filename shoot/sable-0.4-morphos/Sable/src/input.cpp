/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  input.cpp: Processing player input.
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

#include <stdio.h>
#include <math.h>
#include "input.h"
#include "vcontrol.h"

PlayerInput playerInput;

PlayerInput::PlayerInput (void)
{
	_up = _down = _left = _right = _fire = 0;
	_pause = _quit = _radar = 0;

	_old_pause = _old_radar = _old_quit = _old_fire = _old_up = _old_down = 0;
	joyloc[0] = joyloc[1] = 0;
}

void PlayerInput::init (void)
{
	VControl_Init ();
	static VControl_NameBinding bindings[] = {
		{"Up", &_up},
		{"Down", &_down},
		{"Left", &_left},
		{"Right", &_right},
		{"Fire", &_fire},
		{"Pause", &_pause},
		{"Radar", &_radar},
		{"Quit", &_quit},
	};
	
	VControl_RegisterNameTable (bindings);

	VControl_AddKeyBinding (SDLK_UP, &_up);
	VControl_AddKeyBinding (SDLK_KP8, &_up);
	VControl_AddKeyBinding (SDLK_DOWN, &_down);
	VControl_AddKeyBinding (SDLK_KP2, &_down);
	VControl_AddKeyBinding (SDLK_LEFT, &_left);
	VControl_AddKeyBinding (SDLK_KP4, &_left);
	VControl_AddKeyBinding (SDLK_RIGHT, &_right);
	VControl_AddKeyBinding (SDLK_KP6, &_right);
	VControl_AddKeyBinding (SDLK_LCTRL, &_fire);
	VControl_AddKeyBinding (SDLK_RCTRL, &_fire);
	VControl_AddKeyBinding (SDLK_LSHIFT, &_fire);
	VControl_AddKeyBinding (SDLK_RSHIFT, &_fire);
	VControl_AddKeyBinding (SDLK_RETURN, &_fire);
	VControl_AddKeyBinding (SDLK_SPACE, &_fire);
	VControl_AddKeyBinding (SDLK_KP_ENTER, &_fire);
	VControl_AddKeyBinding (SDLK_p, &_pause);
	VControl_AddKeyBinding (SDLK_r, &_radar);
	VControl_AddKeyBinding (SDLK_ESCAPE, &_quit);

	if (SDL_NumJoysticks () > 0)
	{
		fprintf (stderr, "Including joystick support.\n");
		VControl_SetJoyThreshold (0, 15000);
		VControl_AddJoyAxisBinding (0, 0, -1, &_left);
		VControl_AddJoyAxisBinding (0, 0,  1, &_right);
		VControl_AddJoyAxisBinding (0, 1, -1, &_up);
		VControl_AddJoyAxisBinding (0, 1,  1, &_down);
		VControl_AddJoyButtonBinding (0, 0, &_fire);
	}
}

void
PlayerInput::uninit (void)
{
	VControl_Uninit ();
}

void
PlayerInput::reset (void)
{
	VControl_ResetInput ();
	_old_pause = _old_radar = _old_quit = _old_fire = _old_up = _old_down = 0;
	joyloc[0] = joyloc[1] = 0;
}

void
PlayerInput::frameAdvance (void)
{
	_old_pause = _pause;
	_old_radar = _radar;
	_old_quit = _quit;
	_old_fire = _fire;
	_old_up = _up;
	_old_down = _down;
}

void
PlayerInput::process (SDL_Event *e)
{
	VControl_HandleEvent (e);
	if (e->type == SDL_JOYAXISMOTION) {
		int a = e->jaxis.axis;
		int value = (int)floor((e->jaxis.value) / 1638.4f);
		if ((a == 0) || (a == 1)) {
			joyloc[e->jaxis.axis] = value;
		}
	}
}

void
PlayerInput::getDirection (int *x, int *y)
{
	if (joyloc[0] || joyloc[1])
	{
		*x = joyloc[0];
		*y = -joyloc[1];
		if ((*x > -3) && (*x < 3)) *x = 0;
		if ((*y > -3) && (*y < 3)) *y = 0;
	}
	else
	{
		*x = 0; *y = 0;
		if (left ()) *x -= 20;
		if (right ()) *x += 20;
		if (up ()) *y += 20;
		if (down ()) *y -= 20;
	}
}
