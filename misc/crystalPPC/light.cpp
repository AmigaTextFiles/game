#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

//---------------------------------------------------------------------------

Light::Light (float x, float y, float z, float dist,
	      float strength, float red_strength, float blue_strength)
{
  center.x = x;
  center.y = y;
  center.z = z;
  Light::dist = dist;
  Light::sqdist = dist*dist;
  Light::strength = strength;
  Light::red_strength = red_strength;
  Light::blue_strength = blue_strength;
}

Light::~Light ()
{
}

void Light::save (FILE* fp, int indent)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sLIGHT (%f,%f,%f),%f,%f,%f,%f\n", sp,
  	center.x, center.y, center.z, dist,
	strength, red_strength, blue_strength);
}

void Light::load (char** buf)
{
  skip_token (buf, "LIGHT");
  skip_token (buf, "(", "Expected '%s' instead of '%s' after LIGHT statement!\n");
  center.x = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  center.y = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  center.z = get_token_float (buf);
  skip_token (buf, ")", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  skip_token (buf, ",", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  dist = get_token_float (buf);
  sqdist = dist*dist;
  skip_token (buf, ",", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  strength = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  red_strength = get_token_float (buf);
  skip_token (buf, ",", "Expected '%s' instead of '%s' for LIGHT statement!\n");
  blue_strength = get_token_float (buf);
}

void Light::shine ()
{
  sector->clear_shine_done ();
  sector->shine (this);
}

int Light::hit_beam (Vector3& start, Vector3& end, Polygon3D* poly)
{
  return sector->hit_beam (start, end, poly);
}

//---------------------------------------------------------------------------

DynLight::DynLight (float x, float y, float z, float dist,
	      float strength, float red_strength, float blue_strength)
{
  center.x = x;
  center.y = y;
  center.z = z;
  DynLight::dist = dist;
  DynLight::sqdist = dist*dist;
  DynLight::strength = strength;
  DynLight::red_strength = red_strength;
  DynLight::blue_strength = blue_strength;

  num_polygon = 0;
}

DynLight::~DynLight ()
{
}

void DynLight::setup ()
{
  sector->clear_shine_done ();
  sector->setup_dyn_light (this);
}

void DynLight::add_polygon (Polygon3D* p)
{
  polygons[num_polygon++] = p;
}

void DynLight::shine ()
{
  int i;
  for (i = 0 ; i < num_polygon ; i++)
  {
    //@@@
  }
}

//---------------------------------------------------------------------------
