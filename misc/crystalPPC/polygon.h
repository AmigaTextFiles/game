#ifndef POLYGON_H
#define POLYGON_H

#ifndef DEF_H
#include "def.h"
#endif

#ifndef MATH3D_H
#include "math3d.h"
#endif

#ifndef POLYTEXT_H
#include "polytext.h"
#endif

#ifndef POLYSET_H
#include "polyset.h"
#endif

#ifndef VIEWPOLY_H
#include "viewpoly.h"
#endif

class Vertex;
class Sector;
class Light;
class World;
class Textures;
class PolyPlane;
class ViewPolygon;
class Polygon2D;
class LightMap;
#if USE_OCCLUSION
class Occlusion;
#endif

// The maximum number of vertices that any polygon can have. This should
// be considerably larger than what you expect to be the real maximum
// number of vertices in a 3D polygon since clipping may add new vertices.
// Note that 100 is probably overkill but this is no problem since there
// are not going to be many of these Polygon2D objects anyway.
#define MAX_VERTICES 100

// This is our main 3D polygon class. Polygons are used to construct the
// outer hull of sectors and the faces of 3D things.
// Polygons can be transformed in 3D (usually they are transformed so
// that the camera position is at (0,0,0) and the Z-axis is forward).
// Polygons cannot be transformed in 2D. That's what Polygon2D is for.
// It is possible to convert a Polygon3D to a Polygon2D though, at
// which point processing continues with the Polygon2D object.
//
// Polygons have a texture and lie on a plane. The plane does not
// define the orientation of the polygon but is derived from it. The plane
// does define how the texture is scaled and translated accross the surface
// of the polygon.
// Several planes can be shared for different polygons. As a result of this
// their textures will be correctly aligned.
//
// If a polygon is part of a sector it can be a portal to another sector.
// A portal-polygon is a see-through polygon that defines a view to another
// sector. Normally the texture for a portal-polygon is not drawn unless
// the texture is filtered in which case it is drawn on top of the other
// sector.

class Polygon3D
{
private:
  int* vertices_idx;	// A table of indices into the vertices of the parent PolygonSet (container).
  int num_vertices;
  int max_vertices;
  char name[30];

  // The following two fields are somewhat related. 'poly_set' is the real
  // parent (container) of this polygon. It is either a 3D thing or a sector.
  // 'sector' is always a sector. If this polygon belongs to a sector ('poly_set'
  // is a sector) then 'sector' will have the same value as 'poly_set'. If
  // this polygon belongs to a thing then 'sector' will be set to the sector
  // containing the thing.
  // @@@ Note! We have to reconsider this. If a thing moves to another sector
  // we would have to update this variable for all polygons of the thing.
  PolygonSet* poly_set;	// Direct container of this polygon.
  Sector* sector;	// Sector that this polygon is in.

  Sector* portal;	// If not-null, this polygon looks at that sector. In other
  			// words, this polygon is a portal.

  // If this polygon is a portal it possibly has a transformation matrix and
  // vector to warp space in some way. This way mirrors can be implemented.
  // @@@ Note, we should have some special place for date concerning portals
  // so that not every polygon needs the following data (maybe use inheritance
  // with virtual functions?).
  // @@@ Note, space warping through portals is not functional yet!
  int do_warp_space;	// If TRUE the space should be warped through the portal.
  Matrix3 m_warp;	// Warp matrix.
  Matrix3 m_warp_inv;
  Vector3 v_warp;	// Warp vector.

  // The PolygonPlane for this polygon.
  // If 'delete_plane' is TRUE this plane was allocated by
  // this Polygon and it should also be deleted by it.
  PolyPlane* plane;
  int delete_plane;
  PolyTexture* tex;	// The transformed texture for this polygon.
  PolyTexture* tex1;	// A mipmapped texture: one step further.
  PolyTexture* tex2;	// A mipmapped texture: two steps further.
  PolyTexture* tex3;	// A mipmapped texture: three steps further.
  LightMap* lightmap;	// The light-map for this polygon.
  LightMap* lightmap1;	// The light-map for this polygon (mipmap level 1)
  LightMap* lightmap2;	// The light-map for this polygon (mipmap level 2)
  LightMap* lightmap3;	// The light-map for this polygon (mipmap level 3)

  // This flag indicates that we want no mipmapping for this polygon.
  // This is useful for sky-textures (for example).
  int no_mipmap;

  // This flag indicates that we want no lighting for this polygon.
  int no_lighting;

  // This flag is used by the lighting routines to indicate that this
  // polygon has already been lit by some light. It is used by 'shine'.
  int shine_done;

  // The plane equation should maybe be part of PolyPlane. But currently it
  // resides here:
  float Ao, Bo, Co, Do;	// The object space plane equation (this is fixed).
  float A, B, C, D;	// The world space plane equation.
  float Ac, Bc, Cc, Dc;	// The camera space plane equation.

public:
  Polygon3D (char* name, int max, Textures* textures, int texnr);
  ~Polygon3D ();

  // Add a vertex from the container to the polygon.
  void add_vertex (int v);

  char* get_name () { return name; }

  // Several maintenance functions.
  void set_portal (Sector* portal) { Polygon3D::portal = portal; }
  Sector* get_portal () { return portal; }
  void set_poly_set (PolygonSet* poly_set) { Polygon3D::poly_set = poly_set; }
  PolygonSet* get_poly_set () { return poly_set; }
  Sector* get_sector () { return sector; }
  void set_sector (Sector* sector) { Polygon3D::sector = sector; }

  PolyPlane* get_plane () { return plane; }

  int get_max_vertices () { return max_vertices; }
  int get_num_vertices () { return num_vertices; }
  int* get_vertices_idx () { return vertices_idx; }

  // Warp space (if this is a portal).
  int is_space_warped () { return do_warp_space; }
  void warp_space (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c);
  void set_warp (Matrix3& m_w, Vector3& v_w);

  // 'idx' is a local index into the vertices table of the polygon.
  // This index is translated to the index in the parent container and
  // a reference to the vertex is returned.
  Vertex& vtex (int idx) { return poly_set->vtex (vertices_idx[idx]); }

  // Set the texture number for this polygon.
  void set_texnr (Textures* textures, int texnr);
  int get_texnr () { return tex->get_texnr (); }
  PolyTexture* get_polytex (int mipmap);
  PolyTexture* get_polytex (float z_dist);
  void set_no_lighting (int no) { no_lighting = no; }
  void set_no_mipmap (int no) { no_mipmap = no; }
  int get_no_lighting () { return no_lighting; }
  int get_no_mipmap () { return no_mipmap; }

  // After the plane normal and the texture matrices have been set
  // up this routine makes some needed pre-calculations for this polygon.
  // It will create a texture space bounding box that
  // is going to be used for lighting and the texture cache.
  // Then it will allocate the light map tables for this polygons.
  void precalculate ();

  // One of the set_texture_space functions should be called after
  // adding all vertices to the polygon (not before) and before
  // doing any processing on the polygon (not after)!
  // It makes sure that the plane normal is correctly computed and
  // the texture and plane are correctly initialized.
  // 'precalculate ()' is called after that.
  //
  // Internally the transformation from 3D to texture space is
  // represented by a matrix and a vector. You can supply this
  // matrix directly or let it be calculated from other parameters.
  // If you supply another Polygon or a PolyPlane to this function
  // it will automatically share the plane.

  // Copy the plane from the other polygon. The plane is automatically shared.
  void set_texture_space (Polygon3D* copy_from);

  // Use the given plane.
  void set_texture_space (PolyPlane* plane);

  // Calculate the matrix using two vertices (which are preferably on the
  // plane of the polygon and are possibly (but not necessarily) two vertices
  // of the polygon). The first vertex is seen as the origin and the second
  // as the u-axis of the texture space coordinate system. The v-axis is
  // calculated on the plane of the polygon and orthogonal to the given
  // u-axis. The length of the u-axis and the v-axis is given as the 'len1'
  // parameter.
  // For example, if 'len1' is equal to 2 this means that texture will
  // be tiled exactly two times between vertex 'v_orig' and 'v1'.
  // I hope this explanation is clear since I can't seem to make it
  // any clearer :-)
  void set_texture_space (Vertex& v_orig, Vertex& v1, float len1);
  void set_texture_space (float xo, float yo, float zo,
			  float x1, float y1, float z1, float len1);

  // Use 'v1' and 'len1' for the u-axis and 'v2' and 'len2' for the
  // v-axis. Otherwise this function is the same as the previous one.
  void set_texture_space (Vertex& v_orig,
  			  Vertex& v1, float len1,
  			  Vertex& v2, float len2);
  void set_texture_space (float xo, float yo, float zo,
			  float x1, float y1, float z1, float len1,
			  float x2, float y2, float z2, float len2);

  // Similar to the previous function but treat as if the lengths
  // are set to 1.
  void set_texture_space (Vertex& v_orig, Vertex& v_u, Vertex& v_v);
  void set_texture_space (float xo, float yo, float zo,
  			  float xu, float yu, float zu,
  			  float xv, float yv, float zv);

  // The most general functions. With these you provide the matrix
  // directly.
  void set_texture_space (float xo, float yo, float zo,
  			  float xu, float yu, float zu,
  			  float xv, float yv, float zv,
  			  float xw, float yw, float zw);
  void set_texture_space (Matrix3& tx_matrix, Vector3& tx_vector);

  // Shine a light on this polygon. If the polygon has already
  // been lighted by this light ('shine_done' == TRUE) nothing
  // will happen. Otherwise the light maps are initialized according
  // to the distance of the light to the polygon and other parameters
  // of the light.
  void shine (Light* light);
  void clear_shine_done () { shine_done = FALSE; }
  void mipmap_settings (int setting);
  LightMap* get_lightmap () { return lightmap; }

  // Setup a dynamic light for this polygon.
  void setup_dyn_light (DynLight* light, float sq_dist);

  // Transform the plane of this polygon from object space to world space.
  // This is mainly used for things since sectors currently have
  // identical object and world space coordinates.
  void object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w);

  // Transform the plane normal of this polygon from object to world space.
  void normal_object_to_world (Matrix3& m_o2w, Matrix3& m_w2o, Vector3& v_o2w);
  void normal_world_to_camera (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c);

  // This is the link between Polygon3D and Polygon2D (see below for
  // more info about Polygon2D). It should be used after the parent
  // container has been transformed from world to camera space.
  // It will fill the given Polygon2D with a perspective corrected
  // polygon that is also clipped to the view plane (Z=SMALL_Z).
  // If all vertices are behind the view plane the polygon will not
  // be visible and it will return FALSE.
  // 'do_perspective' will also do back-face culling and returns FALSE
  // if the polygon is not visible because of this.
  // If the polygon is deemed to be visible it will first transform
  // the plane from world to camera space and return TRUE.
  int do_perspective (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c, Polygon2D* dest);

  // Check if the polygon in world space is visible from the given point.
  // To do this it will only do back-face culling. No other tests (like
  // other polygons blocking this one) are performed.
  int visible_from_point (Vector3& p);

  // Return POLY_IN, POLY_OUT, or POLY_ON for a vector with respect
  // to the polygon.
  // This algorithm assumes that the polygon is convex and that
  // the vertices of the polygon are oriented in clockwise ordering.
  // If this was not the case then the polygon should not be drawn (culled)
  // and this routine would not be called for it.
  int in_poly_3d (Vector3& vv);

  // Return the minimum squared distance from the plane of the polygon to
  // a point in 3D space (using world coordinates).
  float sq_distance (Vector3& v);

  // Return the closest point on the plane of the polygon to a point
  // in 3D space (using world coordinates).
  void closest_point (Vector3& v, Vector3& isect);

  // Return TRUE if this polygon and the given polygon are on the same
  // plane. If their planes are shared this is automatically the case.
  // Otherwise this function will check their respective plane equations
  // to test for equality.
  int same_plane (Polygon3D* p);

  // Return twice the signed area of the polygon in world space coordinates using
  // the yz, zx, and xy components. In effect this calculates the (P,Q,R) or the
  // plane normal of the polygon.
  void PlaneNormal (float* yz, float* zx, float* xy);

  // Precompute the plane normal. Normally this is done automatically by
  // set_texture_space by if needed you can call this function again when
  // something has changed.
  void compute_normal ();

  // Get the camera space normal as calculated by do_perspective.
  void get_camera_normal (float* p_A, float* p_B, float* p_C, float* p_D);

  // Get the world space normal.
  void get_world_normal (float* p_A, float* p_B, float* p_C, float* p_D);

  // Intersect world-space segment with this polygon. Return
  // TRUE if it intersects and the intersection point in world coordinates.
  int intersect_segment (Vector3& start, Vector3& end, Vector3& isect);

  void save (FILE* fp, int indent, Textures* textures);
  void load (World* w, char** buf, Textures* textures, int default_texnr = -1,
    float default_texlen = 1.);

  // Debugging dump of this polygon.
  void dump ();
};


// The following class represents a 2D polygon (the 2D coordinates are
// perspective corrected coordinates).
//
// This class is used as the main driver for the engine pipeline.
// The source Polygon is first converted to 2D using Polygon3D::do_perspective.

class Polygon2D
{
private:
  Vector2* vertices;		// The 2D vertices
  int num_vertices;
  int max_vertices;

  Box bbox;			// A 2D bounding box that is maintained automatically.

public:
  static Polygon2D clipped;

  Polygon2D (int max);
  Polygon2D (Polygon2D& copy);
  ~Polygon2D ();

  // Initialize the Polygon2D to empty.
  void make_empty ();

  // Maintenance functions.
  int get_num_vertices () { return num_vertices; }
  int get_max_vertices () { return max_vertices; }
  Vector2* get_vertices () { return vertices; }

  // Add a vertex (2D) to the polygon
  void add_vertex (Vector2& v) { add_vertex (v.x, v.y); }
  void add_vertex (float x, float y);

  // Compute the perspective transformation of a 3D vertex and add it to the polygon.
  void add_perspective (Vector3& v) { add_perspective (v.x, v.y, v.z); }
  void add_perspective (float x, float y, float z);

  Box& get_bounding_box () { return bbox; }
  int overlap_bounding_box (Box* box) { return bbox.overlap (box); }
  int overlap_bounding_box (Polygon2D* poly) { return bbox.overlap (&poly->bbox); }

#if 0
  // Rewrite using plane normals.

  // Given a perspective correct 2D point in screen space calculate the corresponding
  // 3D (often camera) space point. This function is not efficient so it should not
  // be used by the engine itself. Note that the polygon needs to be transformed to camera
  // space but not clipped to the view.
  void get_3d_point (Vector2& vs, Vector3& vc);
#endif

  // Clipping routines. They return FALSE if they are not visible for some reason.
  // Note that these routines must not be called if the polygon is not visible.
  // These routines will not check that.
  // @@@ Note that clip_poly is currently not used because of problems with
  // special cases. I would prefer to use clip_poly instead of clip_poly_variant
  // as I suspect the former to be faster. Please, can someone fix clip_poly?
  int clip_poly (ViewPolygon* view, Polygon2D* dest, int verbose = FALSE)
  {
    (void)verbose;
    return clip_poly (view->get_vertices (),
	       view->get_num_vertices (),
	       &view->get_bounding_box (),
	       dest);
  }
  int clip_poly (Vector2* Q, int m, Box* box, Polygon2D* dest);
  void clip_poly_plane (Vector2& v1, Vector2& v2);
  int clip_poly_variant (Vector2* Q, int m, Box* box);
  int clip_poly_variant (ViewPolygon* view)
  {
    return clip_poly_variant (view->get_vertices (),
		       view->get_num_vertices (),
		       &view->get_bounding_box ());
  }

#if USE_OCCLUSION
  // Clip this 2D polygon to the occlusion object. This is a very
  // approximate clipper that preserves convexity without having
  // to split the polygon in seperate parts.
  // This routine returns FALSE if the polygon is completely clipped
  // away.
  int clip_to_occlusion (Occlusion* o);
#endif

  // Create a view polygon from this polygon. This is used for portals.
  ViewPolygon* create_view ();

  // Draw the polygon.
  void draw (int col);
  void draw_filled (Polygon3D* poly, int use_z_buf = FALSE);

  // Debugging dump of this polygon.
  void dump (char* name);
};

#endif /*POLYGON_H*/
