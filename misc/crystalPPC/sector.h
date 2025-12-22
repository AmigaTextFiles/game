#ifndef SECTOR_H
#define SECTOR_H

#ifndef DEF_H
#include "def.h"
#endif

#ifndef MATH3D_H
#include "math3d.h"
#endif

#ifndef POLYSET_H
#include "polyset.h"
#endif

class Thing;
class Light;
class Polygon3D;
class ViewPolygon;
class Camera;
class World;
class DynLight;
#if USE_OCCLUSION
class Occlusion;
#endif

class Sector : public PolygonSet
{
private:
  Thing* first_thing;
#if USE_OCCLUSION
  Occlusion* first_occlusion;
#endif
  Light* lights[16];
  int num_lights;
  int draw_done;
  int beam_done;
  int level1, level2, level3;

public:
  Sector (char* name, int max_v, int max_p);
  ~Sector ();

  void add_thing (Thing* thing);
#if USE_OCCLUSION
  void add_occlusion (Occlusion* occlusion);
#endif
  void add_light (Light* light);

  Thing* get_thing (char* name);

  int get_level1 () { return level1; }
  int get_level2 () { return level2; }
  int get_level3 () { return level3; }

  Polygon3D* hit_beam (Vector3& start, Vector3& end);
  int hit_beam (Vector3& start, Vector3& end, Polygon3D* poly);
  void mipmap_settings (int setting);
  void shine (Light* light);
  void shine_lights ();
  void clear_shine_done ();
  void draw (ViewPolygon* view, Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c);
  void setup_dyn_light (DynLight* light);
  DynLight* add_dyn_light (float x, float y, float z, float dist, float strenght,
			   float red_strength, float blue_strength);

  void save (FILE* fp, int indent, Textures* textures);
  void load (World* w, char** buf, Textures* textures);
  void load_room (World* w, char** buf, Textures* textures);

  Light** get_lights () { return lights; }
  int get_num_lights () { return num_lights; }

  Polygon3D* select_polygon (Camera* c, ViewPolygon* view, int xx, int yy);
};

#endif /*SECTOR_H*/
