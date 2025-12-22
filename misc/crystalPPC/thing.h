#ifndef THING_H
#define THING_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

#ifndef POLYSET_H
#include "polyset.h"
#endif

class Sector;
class Light;
class ViewPolygon;
class World;
class Textures;

class Thing : public PolygonSet
{
private:
  Sector* home, * other;
  Vector3 v_obj2world;
  Matrix3 m_obj2world, m_world2obj;

public:
  Thing (char* name, int max_v, int max_p);
  ~Thing ();

  void set_move (Sector* home, Vector3& v) { set_move (home, v.x, v.y, v.z); }
  void set_move (Sector* home, float x, float y, float z);
  void set_transform (Matrix3& matrix);
  void move (float dx, float dy, float dz);
  void move (Vector3& v) { move (v.x, v.y, v.z); }
  void transform (Matrix3& matrix);
  void transform ();

  void mipmap_settings (int setting);
  void shine (Light* light);
  void clear_shine_done ();
  void draw (ViewPolygon* view, Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c);

  void save (FILE* fp, int indent, Textures* textures);
  void load (World* w, char** buf, Textures* textures);
  void load_sixface (World* w, char** buf, Textures* textures);
};

#endif /*THING_H*/
