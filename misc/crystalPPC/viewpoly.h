#ifndef VIEWPOLY_H
#define VIEWPOLY_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class ViewPolygon
{
private:
  Vector2* vertices;
  int num_vertices, max_vertices;
  Box bbox;			// Bounding box

public:
  ViewPolygon (int num);
  ~ViewPolygon ();

  void add_vertex (float x, float y);
  void add_vertex (Vector2& v) { add_vertex (v.x, v.y); }

  Box& get_bounding_box () { return bbox; }
  int get_num_vertices () { return num_vertices; }
  Vector2* get_vertices () { return vertices; }

  void dump (char* name);
};

#endif /*VIEWPOLY_H*/

