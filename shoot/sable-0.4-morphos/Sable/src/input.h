/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  input.h: A control abstraction
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

#ifndef _INPUT_H_
#define _INPUT_H_

#include <SDL.h>

class PlayerInput {
 public:
	PlayerInput (void);
	~PlayerInput (void) {}

	void init (void);
	void uninit (void);

	void reset (void);
	void frameAdvance (void);
	
	void process (SDL_Event *e);

	void getDirection (int *x, int *y);
	
	bool up(void) { return check(_up); }
	bool down(void) { return check(_down); }
	bool left(void) { return check(_left); }
	bool right(void) { return check(_right); }
	bool fire(void) { return check(_fire); }

	bool pulse_up(void) { return check_fall (_up, _old_up); }
	bool pulse_down(void) { return check_fall (_down, _old_down); }
	bool pulse_fire(void) { return check_fall (_fire, _old_fire); }
	bool endpulse_fire(void) { return check_rise (_fire, _old_fire); }
	bool pulse_pause(void) { return check_fall (_pause, _old_pause); }
	bool pulse_radar(void) { return check_fall (_radar, _old_radar); }
	bool pulse_quit(void) { return check_fall (_quit, _old_quit); }
	
 private:
	bool check (int t) { return t != 0; }
	bool check_fall (int t, int o) { return (t != 0) && (o == 0); }
	bool check_rise (int t, int o) { return (t == 0) && (o != 0); }
	int _up, _down, _left, _right, _fire;
	int _pause, _radar, _quit;

	/* old values for the pulse */
	int _old_pause, _old_radar, _old_quit, _old_fire, _old_up, _old_down;

	/* Joystick positions */
	int joyloc[2];
};

extern PlayerInput playerInput;

#endif
