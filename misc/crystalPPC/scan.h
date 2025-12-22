#ifndef SCAN_H
#define SCAN_H

#define INTERPOL_STEP 16

class Camera;
class Texture;
class Textures;
class Filter;
class Polygon3D;
class Graphics;
class PolyTexture;

struct SegmentInfo
{
  float x1, y1, z1;	// Left side
  float x2, y2, z2;	// Right side
  float x_left, x_right;
};

// This structure is used to put information for the scanline drawer in a global
// structure (for efficiency).
class Scan
{
public:
  // All global variables
  static Graphics* g;
  static Camera* c;
  static Texture* texture;
  static Textures* textures;
  static unsigned char* tmap;
  static int texnr;
  static int tw;
  static int th;
  static int shf_w, and_w;
  static int shf_h, and_h;
  static float t11, t12, t13;	// Texture transform matrix
  static float t21, t22, t23;
  static float t31, t32, t33;
  static float tx, ty, tz;
  static SegmentInfo sinfo;
  static unsigned long* z_buffer;

  static unsigned char* tmap2;
  static int tw2;
  static int th2;
  static float fdu, fdv;
  static int shf_u;

  // Draw one horizontal scanline for one polygon.
  static void draw_scanline_flat (int xx, unsigned char* d, unsigned long* z_buf,
  			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline_z_buf_flat (int xx, unsigned char* d, unsigned long* z_buf,
  			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline (int xx, unsigned char* d, unsigned long* z_buf,
  			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline_map (int xx, unsigned char* d, unsigned long* z_buf,
			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline_transp (int xx, unsigned char* d, unsigned long* z_buf,
			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline_filtered (int xx, unsigned char* d, unsigned long* z_buf,
			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline_z_buf (int xx, unsigned char* d, unsigned long* z_buf,
			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);
  static void draw_scanline_z_buf_map (int xx, unsigned char* d, unsigned long* z_buf,
			  float inv_z, float u_div_z, float v_div_z,
			  float M, float J1, float K1);

#if 0
  // Light one horizontal scanline for one polygon.
  static void light_scanline (int xx,
			      int uu, int vv,
			      unsigned char* d,
			      float d1, float d2, float dd1, float dd2,
			      float dd_u, float da_u, float dd_v, float da_v,
			      int lu, int lv, int sq_rad);
#endif

  static void init_draw (Polygon3D* p, PolyTexture* tex);
};

#endif /*SCAN_H*/

