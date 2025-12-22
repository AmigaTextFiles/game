#ifndef POLYSET_H
#define POLYSET_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

#ifndef SCRIPT_H
#include "script.h"
#endif

#ifndef VERTEX_H
#include "vertex.h"
#endif

#ifndef CSOBJECT_H
#include "csobject.h"
#endif

class Polygon3D;
class Sector;
class World;
class Camera;
class ViewPolygon;
class Textures;

// A PolygonSet class is a set of polygons (amazing, isn't it :-)
// A PolygonSet describes a set of polygons that form a convex and
// (probably) closed hull. All polygons in a set share vertices
// from the same pool.
//
// Every polygon in the set has a visible and an invisible face;
// if the vertices of the polygon are ordered clockwise then the
// polygon is visible. Using this feature it is possible to define
// two kinds of PolygonSets: in one kind the polygons are oriented
// such that they are visible from within the hull. In other words,
// the polygons form a sort of container or room where the camera
// can be located. We call this kind of PolygonSet a Sector (a
// subclass of PolygonSet). In another kind the polygons are
// oriented such that they are visible from the outside. We call
// this kind of PolygonSet a Thing (another subclass of PolygonSet).
//
// Things and Sectors have many similarities. That's why the
// PolygonSet class was created: to exploit these similarities.
// However, there are some important differences between Things and
// Sectors:
//    - Currently, only things can move. This means that the object
//      space coordinates of a Sector are ALWAYS equal to the world
//      space coordinates. It would be possible to allow moveable
//      Sectors but I don't how this should be integrated into an
//      easy model of the world.
//    - Polygons in things don't support filtering, transparency,
//      and portals although this could be added. It would give
//      some nice effects. But for this feature to be really useful
//      we would need to have good support for space warping via
//      portals.

class PolygonSet : public CsObject
{
protected:
  PolygonSet* next;	// PolygonSets are linked either in a World object or in
  			// another PolygonSet (Thing in Sector for example).

  Vertex* vertices;	// Table of vertices used by polygons in set
  int num_vertices;
  int max_vertices;

  Polygon3D** polygon;	// Table of ptr to polygons forming the outside of the set
  int num_polygon;	// Number used
  int max_polygon;	// Max supported

  Sector* sector;	// Sector where this polyset belongs (pointer to this if it is a sector).

public:
  PolygonSet (char* name, int type, int max_v, int max_p);
  ~PolygonSet ();

  void set_max (int max_v, int max_p);

  void set_vertex (int idx, Vector3 v) { set_vertex (idx, v.x, v.y, v.z); }
  void set_vertex (int idx, float x, float y, float z);
  Vertex& vtex (int idx) { return vertices[idx]; }

  void add_polygon (Polygon3D* poly);
  Polygon3D* new_polygon (char* name, int max, Textures* textures, int texnr);
  Polygon3D* new_polygon (char* name, int max, Textures* textures, char* tex_name);
  int get_num_polygon () { return num_polygon; }
  Polygon3D* get_polygon (int idx) { return polygon[idx]; }
  Polygon3D* get_polygon (char* name);

  // Intersect world-space segment with polygons of this set. Return
  // polygon it intersects with (or NULL) and the intersection point
  // in world coordinates.
  Polygon3D* intersect_segment (Vector3& start, Vector3& end, Vector3& isect);

  // Return FALSE if none of the vertices of this sector is in front
  // of the camera.
  int transform_world2cam (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c);

  void dump ();
  PolygonSet* get_next () { return next; }
  void set_next (PolygonSet* next) { PolygonSet::next = next; }
  void set_sector (Sector* sector) { PolygonSet::sector = sector; }

  void save (FILE* fp, int indent, Textures* textures, char* setname);
  void load (World* w, char** buf, Textures* textures, char* setname);

  Polygon3D* select_polygon (Camera* c, ViewPolygon* view, int xx, int yy);
  Vertex* select_vertex (Camera* c, ViewPolygon* view, int xx, int yy);
  void edit_draw_vertices ();
  void edit_split_poly (Camera* c, Textures* textures);
};

#endif /*POLYSET_H*/
