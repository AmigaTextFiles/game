#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef LIGHTMAP_H
#include "lightmap.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

//---------------------------------------------------------------------------

int LightMap::setting = MIPMAP_SHADOW_ACCURATE;

LightMap::LightMap ()
{
  light_map = NULL;
  red_light_map = NULL;
  blue_light_map = NULL;
}

LightMap::~LightMap ()
{
  if (light_map) delete [] light_map;
  if (red_light_map) delete [] red_light_map;
  if (blue_light_map) delete [] blue_light_map;
}

void LightMap::alloc (int w, int h, Polygon3D* poly)
{
  size = w*h;
  int i;
  if (light_map)
  {
    delete [] light_map;
    light_map = NULL;
  }
  if (red_light_map)
  {
    delete [] red_light_map;
    red_light_map = NULL;
  }
  if (blue_light_map)
  {
    delete [] blue_light_map;
    blue_light_map = NULL;
  }

  if (size > 1000000) return;

  int lw = w/16+2;
  int lh = h/16+2;
  light_map = new unsigned char [lw*lh];
  red_light_map = new unsigned char [lw*lh];
  blue_light_map = new unsigned char [lw*lh];
  if (poly)
    for (i = 0 ; i < lw*lh ; i++)
    {
      light_map[i] = poly->get_sector ()->get_level1 ();
      red_light_map[i] = poly->get_sector ()->get_level2 ();
      blue_light_map[i] = poly->get_sector ()->get_level3 ();
    }
}

void LightMap::mipmap_lightmap (int w, int h, LightMap* source, int w2, int h2)
{
  alloc (w, h, NULL);

  if (size > 1000000 || source->size > 1000000) return;
  int lw = w/16+2;
  int lh = h/16+2;
  int lw2 = w2/16+2;
  int lh2 = h2/16+2;
  int u, v, uv, uv2;

  for (v = 0 ; v < lh ; v++)
    for (u = 0 ; u < lw ; u++)
    {
      uv = v*lw + u;

      if (u+u >= lw2 || v+v >= lh2)
      {
	if (u+u >= lw2) uv2 = (v+v)*lw2 + lw2-1;
	else if (v+v >= lh2) uv2 = (lh2-1)*lw2 + u+u;
      }
      else uv2 = (v+v)*lw2 + u+u;

      light_map[uv] = source->light_map[uv2];
      red_light_map[uv] = source->red_light_map[uv2];
      blue_light_map[uv] = source->blue_light_map[uv2];
    }
}

//---------------------------------------------------------------------------
