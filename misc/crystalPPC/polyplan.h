#ifndef POLYPLANE_H
#define POLYPLANE_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class Vertex;

// This class represents a texture plane. This is a plane
// that defines the orientation and offset of a texture. It can
// be used by several polygons to let the textures fit perfectly.

class PolyPlane
{
  friend class Polygon3D;
  friend class Polygon2D;
  friend class PolyTexture;

private:
  char name[30];
  PolyPlane* next, * prev;

  Matrix3 m_obj2tex;	// Transformation from object to texture space.
  Vector3 v_obj2tex;	// Translation from object to texture space.

  Matrix3 m_world2tex;	// Transformation from world to texture space.
  Vector3 v_world2tex;	// Translation from world to texture space.

  // Transformed texture space transformation. This transforms a
  // coordinate from camera space to texture space. This transformation
  // is obtained by using m_world2tex and v_world2tex with the camera transformation.
  Matrix3 m_cam2tex;
  Vector3 v_cam2tex;

public:
  PolyPlane (char* name);
  ~PolyPlane ();

  char* get_name () { return name; }
  void set_next (PolyPlane* n) { next = n; }
  void set_prev (PolyPlane* p) { prev = p; }
  PolyPlane* get_next () { return next; }
  PolyPlane* get_prev () { return prev; }

  void transform_world2cam (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c);
  void object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w);

  void set_texture_space (Vertex& v_orig,
  			  Vertex& v1, float len1,
  			  Vertex& v2, float len2);
  void set_texture_space (float xo, float yo, float zo,
			  float x1, float y1, float z1, float len1,
			  float x2, float y2, float z2, float len2);
  void set_texture_space (Vertex& v_orig, Vertex& v_u, Vertex& v_v);
  void set_texture_space (float xo, float yo, float zo,
  			  float xu, float yu, float zu,
  			  float xv, float yv, float zv);
  void set_texture_space (float xo, float yo, float zo,
  			  float xu, float yu, float zu,
  			  float xv, float yv, float zv,
  			  float xw, float yw, float zw);
  void set_texture_space (Matrix3& tx_matrix, Vector3& tx_vector);

  void save (FILE* fp, int indent);
  void load (char** buf);
};

#endif /*POLYPLANE_H*/
