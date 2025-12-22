/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef EVENTS_H
#define EVENTS_H

#include <string.h>
#include "SDL.h"
#include "list.h"

#define KEYCONFIG_FILE "key_config"
#include "level_file.h"

/* description des touches utiles */
typedef struct {

	/* these ones are TRUE when key is down, FALSE when it's up */
	/* à VRAI sur touche à l'état enfoncée, à FAUX sur touche relevée */
	char	space,	quit,	esc;
	/* config dependant : */
	char	left,	right,	jump,	down,	accel;
	
	/* these ones are TRUE when key is pressed, FALSE however */
	/* à VRAI lorsque la touche est préssée, à FAUX sinon */
	char	F1_kp,	F2_kp,	F3_kp,	F4_kp,	F5_kp,	F6_kp,	F7_kp,	F8_kp;
	char	o_kp,	p_kp,	y_kp,	s_kp,	n_kp,	f_kp;
	char	n0_kp,	n1_kp,	n2_kp,	n3_kp,	n4_kp,	n5_kp,	n6_kp,	n7_kp,	n8_kp,	n9_kp;
	char	arrow_up_kp,	arrow_down_kp,	arrow_left_kp,	arrow_right_kp;
	/* config dependant : */
	char 	special_kp,	jump_kp;
}all_events_status;

typedef struct {
	SDLKey key;
	char * txt_key;
	char * txt_id;
}key_config_desc;


void events_init();

all_events_status events_get_all();

int any_event_found();

myList * get_current_config();

void change_key_config(int pos);

int load_keyconfig();
int save_keyconfig();

#endif
