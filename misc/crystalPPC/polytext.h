#ifndef POLYTEXT_H
#define POLYTEXT_H

#ifndef MATH3D_H
#include "math3d.h"
#endif

class Polygon3D;
class TextureCache;
class Texture;
class Textures;
class PolyPlane;
class Light;
class DynLight;
class Vertex;
class LightMap;

class PolyTexture
{
  friend class Polygon3D;
  friend class TextureCache;

private:
  PolyTexture* next, * prev; // Linked in texture cache.
  int in_cache;		     // TRUE if in cache.
  Polygon3D* polygon;

  int texnr;
  Texture* texture;

  // Bounding box of corresponding polygon in 2D texture space.
  // Note that the u-axis of this bounding box is made a power of 2 for
  // efficiency reasons.
  int Imin_u, Imin_v, Imax_u, Imax_v;
  int shf_u, and_u;

  // New texture data with lighting added. This is an untiled texture
  // so it is more efficient to draw. This texture data is allocated
  // and maintained by the texture cache. If a PolyTexture is in the
  // cache it will be allocated, otherwise it won't.
  int w, h, size;
  unsigned char* tmap;
  int du, dv;
  float fdu, fdv;

  // Mipmap size and lightmap to use for lightmap boxes: 16, 8, 4, or 2.
  LightMap* lm;
  int mipmap_size;

  // Information for dynamic lights.
  // @@@ Note! Dynamic lights are not functional yet!
  int light_u, light_v;		// Center u,v point for dynamic light.
  int sq_rad;			// Squared radius for dynamic light.

public:
  PolyTexture ();
  ~PolyTexture ();

  int get_width () { return w; }
  int get_height () { return h; }
  unsigned char* get_bitmap () { return tmap; }
  int get_du () { return du; }
  int get_dv () { return dv; }
  float get_fdu () { return fdu; }
  float get_fdv () { return fdv; }
  int get_shf_u () { return shf_u; }
  int get_and_u () { return and_u; }

  void set_polygon (Polygon3D* p) { polygon = p; }

  void set_texnr (Textures* textures, int texnr);
  int get_texnr () { return texnr; }
  Texture* get_texture () { return texture; }

  int get_light_u () { return light_u; }
  int get_light_v () { return light_v; }
  int get_sq_rad () { return sq_rad; }

  void create_lighted_texture (Textures* textures);
  void create_bounding_texture_box ();

  void shine (Light* light);
  void setup_dyn_light (DynLight* light, float sq_dist);
};

#endif /*POLYTEXT_H*/

