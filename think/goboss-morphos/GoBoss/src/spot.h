
#ifndef _SPOT_H
#define _SPOT_H

/*** spots ***/

#include "case.h"

typedef struct {
  int id;
  Case cible;int color;
  float x1;float x2;float y1;float y2;
  float px1;float px2;float py1;float py2;
  int centerx; int centery;
} Spot;

Spot *spot_new (Case cible, int color);
void spot_free (Spot *spot);
void spot_approche_cible (Spot *spot);
void spot_draw (Spot *spot);

#endif
