/* MoleInvasion 0.3 - Copyright (C) 2004-2006 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#include "font.h"
#include "level_file.h"
#include "events.h"

/* 1 : oui
   0 : sinon ( non, esc, quit() )*/
char process_yesno_events(void);

char wantToSave(char * file);

char confirmToSave(level_info level_infos);

void simpleMessage(char * mesId);
