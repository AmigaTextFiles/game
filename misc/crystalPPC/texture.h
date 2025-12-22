#ifndef TEXTURE_H
#define TEXTURE_H

//vonmir
//extern "C" {

//ersatzlos gestrichen
//
#include "gifload.h"
//vonmir
//}

//ersatzlos gestrichen
//

#define ZDIST_MIPMAP1 15.
#define ZDIST_MIPMAP2 30.
#define ZDIST_MIPMAP3 60.

class Filter;
class Textures;
class PolyTexture;

struct ColorUsage
{
  int cnt;      // How many times is this color used in a texture
  int idx;      // Original index in texture
  RGBcolor color;
};

class Texture
{
private:
  Graphic_file* gf;
  ColorUsage* usage;
  char name[50];
  int transparent;
  int filtered;
  Filter** filters;
  int shf_w, shf_h;
  int and_w, and_h;

public:
  Texture (char* name);         // Create a texture directly from a graphic file.
  Texture (int w, int h);       // Create an empty texture with a width and height.
  ~Texture ();

  void set_transparent (int col);
  int get_transparent () { return transparent; }
  void set_filter (int col, Filter* filter);
  int get_filtered () { return filtered; }
  Filter** get_filters () { return filters; }

  char* get_name () { return name; }
  unsigned char* get_bitmap () { return gf->bitmap; }
  int get_width () { return gf->width; }
  int get_height () { return gf->height; }
  int get_w_shift () { return shf_w; }
  int get_h_shift () { return shf_h; }
  int get_w_mask () { return and_w; }
  int get_h_mask () { return and_h; }

  int get_pal_red (int idx) { return gf->palette[idx].red; }
  int get_pal_green (int idx) { return gf->palette[idx].green; }
  int get_pal_blue (int idx) { return gf->palette[idx].blue; }
  int get_num_colors () { return gf->palette_entries; }
  void compute_color_usage ();
  void clear_color_usage ();
  ColorUsage& get_usage (int idx) { return usage[idx]; }
  void remap_palette (Textures* new_palette);

  void save (FILE* fp, int indent);
  void load (char** buf);
};

typedef unsigned char RGBmap[256];

#define TABLE_WHITE 0
#define TABLE_RED 1
#define TABLE_GREEN 2
#define TABLE_BLUE 3

#define MIPMAP_UGLY 0
#define MIPMAP_DEFAULT 1
#define MIPMAP_NICE 2

class Textures
{
private:
  Texture** textures;
  int num_textures;
  int max_textures;
  int rnum_textures;
  int offs_mipmap1;
  int offs_mipmap2;
  int offs_mipmap3;
  RGBcolor pal[256];
  RGBmap light[256];
  RGBmap red_light[256];
  RGBmap blue_light[256];
  int alloc[256];
  int red_color, yellow_color, green_color, blue_color, white_color, black_color;
  int level1, level2, level3;

  // Configuration values.
  int prefered_dist, prefered_col_dist;
  int color_table1;
  int color_table2;
  int color_table3;
  int mipmap_nice;

  void read_config ();

public:
  int mipmapped;
  int textured;
  int do_lighting;

public:
  Textures (int max);
  ~Textures ();

  Texture* new_texture (char* name);
  Texture* get_texture (int idx) { return textures[idx]; }
  int get_texture_idx (char* name);

  int find_rgb_map (int r, int g, int b, int map_type, int l);
  int find_rgb (int r, int g, int b);
  int find_rgb_slow (int r, int g, int b);
  int alloc_rgb (int r, int g, int b, int dist);
  void compute_palette ();
  void compute_light_tables ();
  void alloc_palette (Graphics* g);

  void create_mipmap_textures ();
  int get_mipmap1_nr (int texnr) { return texnr+offs_mipmap1; }
  int get_mipmap2_nr (int texnr) { return texnr+offs_mipmap2; }
  int get_mipmap3_nr (int texnr) { return texnr+offs_mipmap3; }

  int get_pal_alloced (int idx) { return alloc[idx]; }
  int get_pal_red (int idx) { return pal[idx].red; }
  int get_pal_green (int idx) { return pal[idx].green; }
  int get_pal_blue (int idx) { return pal[idx].blue; }

  unsigned char* get_light_table (int lev) { return (unsigned char*)(light[lev]); }
  unsigned char* get_red_light_table (int lev) { return (unsigned char*)(red_light[lev]); }
  unsigned char* get_blue_light_table (int lev) { return (unsigned char*)(blue_light[lev]); }
  int get_level1 () { return level1; }
  int get_level2 () { return level2; }
  int get_level3 () { return level3; }

  void save (FILE* fp, int indent);
  void load (char** buf);

  int red () { return red_color; }
  int blue () { return blue_color; }
  int yellow () { return yellow_color; }
  int green () { return green_color; }
  int white () { return white_color; }
  int black () { return black_color; }
};

class Filter
{
private:
  unsigned char* trans;
  char name[30];

public:
  Filter (char* name);
  ~Filter ();

  static void init_filters (Textures* tex);

  char* get_name () { return name; }

  void mean_with_color (Textures* tex, int rg, int gg, int bg, int weight);
  void add_color (Textures* tex, int rg, int gg, int bg);

  void very_light_glass (Textures* tex);
  void light_glass (Textures* tex);
  void dark_glass (Textures* tex);
  void medium_glass (Textures* tex);
  void very_dark_glass (Textures* tex);
  void transparent (Textures* tex);

  unsigned char translate (int idx) { return trans[idx]; }
};

#define MAX_CACHE_SIZE 5000000

class TextureCache
{
private:
  PolyTexture* first, * last;
  long total_size;
  int total_textures;

public:
  TextureCache ();
  ~TextureCache ();

  void clear ();
  void use_texture (PolyTexture* pt, Textures* textures);

  void dump ();
};

extern TextureCache cache;

#endif /*TEXTURE_H*/
