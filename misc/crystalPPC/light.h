#ifndef LIGHT_H
#define LIGHT_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class Sector;
class Polygon3D;

#define DEFAULT_LIGHT_LEVEL 40		// Light level that is used when there is no light on the texture.
#define NORMAL_LIGHT_LEVEL 200		// Light level that corresponds to a normally lit texture.

// Class for a static light. These lights cast shadows (against
// sector boundaries and with things), they support three different
// colors (default white, red, and blue). They cannot move and
// they cannot vary in intensity.

class Light
{
private:
  Sector* sector;
  Vector3 center;
  float dist, sqdist;
  float strength;
  float red_strength;
  float blue_strength;

public:
  Light (float x, float y, float z, float dist,
  	 float strength, float red_strength, float blue_strength);
  ~Light ();

  void set_sector (Sector* sector) { Light::sector = sector; }

  Vector3& get_center () { return center; }
  float get_dist () { return dist; }
  float get_sq_dist () { return sqdist; }
  float get_strength () { return strength; }
  float get_red_strength () { return red_strength; }
  float get_blue_strength () { return blue_strength; }

  void save (FILE* fp, int indent);
  void load (char** buf);

  void shine ();
  int hit_beam (Vector3& start, Vector3& end, Polygon3D* poly);
};

// Dynamic lights can light maximum 200 polygons.
#define MAX_DYN_POLYGON 200

// Class for a dynamic light. These lights don't cast shadows (in contrast
// with static lights) but they can move and vary in intensity.

class DynLight
{
private:
  DynLight* next, * prev;

  Sector* sector;
  Vector3 center;
  float dist, sqdist;
  float strength;
  float red_strength;
  float blue_strength;

  int num_polygon;
  Polygon3D* polygons[MAX_DYN_POLYGON];

public:
  DynLight (float x, float y, float z, float dist,
  	 float strength, float red_strength, float blue_strength);
  ~DynLight ();

  // Initial placement of the light. This routine computes all
  // polygons that are theoretically reached by this light (by using
  // the squared distance) and adjusts these polygons so that they
  // know about this light.
  void setup ();

  // Every polygon that is shined upon by this dynamic light
  // should call 'add_polygon' to register itself.
  void add_polygon (Polygon3D* p);

  // After running setup use this routine when the intensity or
  // color of the light changes. This will update information in
  // all the polygons reached by this light.
  void shine ();

  void set_sector (Sector* sector) { DynLight::sector = sector; }
  void set_next (DynLight* n) { next = n; }
  void set_prev (DynLight* p) { prev = p; }
  DynLight* get_next () { return next; }
  DynLight* get_prev () { return prev; }

  Vector3& get_center () { return center; }
  float get_dist () { return dist; }
  float get_sq_dist () { return sqdist; }
  float get_strength () { return strength; }
  float get_red_strength () { return red_strength; }
  float get_blue_strength () { return blue_strength; }
};

#endif /*LIGHT_H*/
