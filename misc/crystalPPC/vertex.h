#ifndef VERTEX_H
#define VERTEX_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class Vertex
{
private:
  // The following are essential to the vertex. They 'describe' it.
  Vector3 vo;		// Coordinates in object space.
  Vector3 v;		// Coordinates in world space.

  // The following are transient variables recalculated at specified times.
  // They contain redundant information.
  Vector3 vr;		// Coordinates in camera space.
  int visible;		// TRUE if visible.

public:
  Vertex (Vector3& v);
  Vertex (float x, float y, float z);
  Vertex ();
  ~Vertex () { }

  void set (Vector3& v);
  void set (float x, float y, float z);
  float get_x () { return v.x; }
  float get_y () { return v.y; }
  float get_z () { return v.z; }
  Vector3& get_v () { return v; }

  void set_t (Vector3& vr);
  void set_t (float x, float y, float z);
  float get_tx () { return vr.x; }
  float get_ty () { return vr.y; }
  float get_tz () { return vr.z; }
  Vector3& get_tv () { return vr; }

  int is_visible () { return visible; }

  void set_o (Vector3& vo);
  void set_o (float x, float y, float z);
  float get_ox () { return vo.x; }
  float get_oy () { return vo.y; }
  float get_oz () { return vo.z; }
  Vector3& get_ov () { return vo; }

  void world_to_camera (Matrix3& m_w2c, Vector3& v_w2c);
  void object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w);
  void translate (Vector3& v_w2c);

  void dump ();

  void save (FILE* fp, int indent);
  void load (char** buf);
};


#endif /*VERTEX_H*/

