#ifndef LIGHTMAP_H
#define LIGHTMAP_H

class PolyTexture;
class Polygon3D;

// There are three possible levels of mipmapping accuracy.
// This accuracy has nothing to do with the quality of the
// mipmapped texture itself but it controls the quality
// of the shadows.
//
// With MIPMAP_SHADOW_ACCURATE the shadows
// are 'perfect' at all distances. Even polygons that are
// far away (mipmap level 3) will have correct shadows.
// The disadvantage of this is that this is slower for the
// texture cache. It will not influence stationary frame rate,
// but far away textures will take somewhat longer to load
// in the cache. Once in the cache, there is no difference.
//
// MIPMAP_SHADOW_INACCURATE gives the fastest way for the
// texture cache but shadows will be noticeably worse when
// polygons gets farther away. This is rather ugly. This
// mode is included only so that you can see the difference :-)
//
// MIPMAP_SHADOW_REASONABLE is somewhat in between. Polygons
// far away will have reasonably accurate shadows (not as
// accurate as with MIPMAP_SHADOW_ACCURATE) and they will
// draw somewhat faster (not as fast as with MIPMAP_SHADOW_INACCURATE).
//
// Note that none of these options affect textures that are
// really close by.
//
// Note that changing this option (by pressing 'alt-t') will only
// be visible when a texture is removed from the texture cache and
// reinserted again. The texture cache can be cleared by pressing 'r'.

#define MIPMAP_SHADOW_ACCURATE 0
#define MIPMAP_SHADOW_INACCURATE 1
#define MIPMAP_SHADOW_REASONABLE 2

class LightMap
{
  friend class PolyTexture;

private:
  unsigned char* light_map;
  unsigned char* red_light_map;
  unsigned char* blue_light_map;
  int size;

public:
  static int setting;	// One of MIPMAP_SHADOW_...

public:
  LightMap ();
  ~LightMap ();

  unsigned char* get_light_map () { return light_map; }
  unsigned char* get_red_light_map () { return red_light_map; }
  unsigned char* get_blue_light_map () { return blue_light_map; }

  // Allocate the lightmap. 'w' and 'h' are the size of the
  // bounding box in lightmap space.
  void alloc (int w, int h, Polygon3D* poly);

  // Allocate this lightmap by mipmapping the given source
  // lightmap.
  void mipmap_lightmap (int w, int h, LightMap* source, int w2, int h2);
};

#endif /*LIGHTMAP_H*/

