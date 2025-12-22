#ifndef _DISPLAY_H
#define _DISPLAY_H

#include "case.h"
#include "communic.h"
#include "gameparams.h"

int getCouleurALEcran (Case c);
void poserPionALEcran (int coul, Case c, int flip);

void faireLeMenageAutourDe (Case c, ComPipe *pipe);
void redrawGoban (ComPipe *pipe);

/* retourne la case à l'emplacement x,y de l'écran. */
Case getCase (float x, float y);

void init_sdl_stuff (GameParams params);

#endif
