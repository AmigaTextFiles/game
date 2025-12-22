#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef POLYTEXT_H
#include "polytext.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef CONFIG_H
#include "config.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#include <clib/powerpc_protos.h>

extern double tb_scale_hi;
extern double tb_scale_lo;

int I_GetTime (void);

//---------------------------------------------------------------------------

TextureCache cache;
Filter very_light_glass ("very_light_glass");
Filter light_glass ("light_glass");
Filter medium_glass ("medium_glass");
Filter dark_glass ("dark_glass");
Filter very_dark_glass ("very_dark_glass");
Filter filter_color_red ("filter_color_red");
Filter filter_color_blue ("filter_color_blue");
Filter filter_color_green ("filter_color_green");
Filter filter_color_yellow ("filter_color_yellow");
Filter filter_m100 ("filter_m100");
Filter filter_m75 ("filter_m75");
Filter filter_m50 ("filter_m50");
Filter filter_m25 ("filter_m25");
Filter filter_0 ("filter_0");
Filter filter_25 ("filter_25");
Filter filter_50 ("filter_50");
Filter filter_75 ("filter_75");
Filter filter_100 ("filter_100");

//---------------------------------------------------------------------------

Texture::Texture (int w, int h)
{
  gf = new_graphic_file ();
  gf->width = w;
  gf->height = h;
  gf->palette_entries = 0;
  gf->bitmap = (unsigned char*)malloc (w * h);
  gf->type = gfPaletted;

  usage = NULL;
  strcpy (Texture::name, name);
  transparent = -1;
  filtered = FALSE;
  filters = NULL;
  switch (gf->width)
  {
    case 8: shf_w = 3; and_w = 0x7; break;
    case 16: shf_w = 4; and_w = 0xf; break;
    case 32: shf_w = 5; and_w = 0x1f; break;
    case 64: shf_w = 6; and_w = 0x3f; break;
    case 128: shf_w = 7; and_w = 0x7f; break;
    case 256: shf_w = 8; and_w = 0xff; break;
    case 512: shf_w = 9; and_w = 0x1ff; break;
    case 1024: shf_w = 10; and_w = 0x3ff; break;
  }
  switch (gf->height)
  {
    case 8: shf_h = 3; and_h = 0x7; break;
    case 16: shf_h = 4; and_h = 0xf; break;
    case 32: shf_h = 5; and_h = 0x1f; break;
    case 64: shf_h = 6; and_h = 0x3f; break;
    case 128: shf_h = 7; and_h = 0x7f; break;
    case 256: shf_h = 8; and_h = 0xff; break;
    case 512: shf_h = 9; and_h = 0x1ff; break;
    case 1024: shf_h = 10; and_h = 0x3ff; break;
  }
}

Texture::Texture (char* name)
{
  FILE* fp = fopen (name, "rb");
  gf = LoadGIF (fp, name);
  fclose (fp);
  usage = NULL;
  strcpy (Texture::name, name);
  transparent = -1;
  filtered = FALSE;
  filters = NULL;
  switch (gf->width)
  {
    case 8: shf_w = 3; and_w = 0x7; break;
    case 16: shf_w = 4; and_w = 0xf; break;
    case 32: shf_w = 5; and_w = 0x1f; break;
    case 64: shf_w = 6; and_w = 0x3f; break;
    case 128: shf_w = 7; and_w = 0x7f; break;
    case 256: shf_w = 8; and_w = 0xff; break;
    case 512: shf_w = 9; and_w = 0x1ff; break;
    case 1024: shf_w = 10; and_w = 0x3ff; break;
  }
  switch (gf->height)
  {
    case 8: shf_h = 3; and_h = 0x7; break;
    case 16: shf_h = 4; and_h = 0xf; break;
    case 32: shf_h = 5; and_h = 0x1f; break;
    case 64: shf_h = 6; and_h = 0x3f; break;
    case 128: shf_h = 7; and_h = 0x7f; break;
    case 256: shf_h = 8; and_h = 0xff; break;
    case 512: shf_h = 9; and_h = 0x1ff; break;
    case 1024: shf_h = 10; and_h = 0x3ff; break;
  }
}

// This function must be called AFTER color remapping.
void Texture::set_transparent (int col)
{
  transparent = col; // @@@ Currently, only 0 supported
}

void Texture::set_filter (int col, Filter* filter)
{
  int i;
  filtered = TRUE;
  if (!filters)
  {
    filters = new Filter* [256];
    for (i = 0 ; i < 256 ; i++)
      filters[i] = NULL;
  }
  filters[col] = filter;
}

Texture::~Texture ()
{
  //@@@@@@@@@@if (gf) free_graphic_file (gf);
  if (usage) delete [] usage;
  if (filters) delete [] filters;
}

int cmp_colorusage (const void* v1, const void* v2)
{
  ColorUsage* u1 = (ColorUsage*)v1;
  ColorUsage* u2 = (ColorUsage*)v2;
  if (u1->cnt < u2->cnt) return 1;
  else if (u1->cnt > u2->cnt) return -1;
  else return 0;
}

void Texture::clear_color_usage ()
{
  if (usage)
  {
    delete [] usage;
    usage = NULL;
  }
}

void Texture::compute_color_usage ()
{
  int i, x, y;
  if (!usage) usage = new ColorUsage [256];
  for (i = 0 ; i < gf->palette_entries ; i++)
  {
    usage[i].color = gf->palette[i];
    usage[i].cnt = 0;
    usage[i].idx = i;
  }
  unsigned char* d = gf->bitmap;
  for (y = 0 ; y < gf->height ; y++)
    for (x = 0 ; x < gf->width ; x++)
      usage[*d++].cnt++;
  qsort (usage, gf->palette_entries, sizeof (ColorUsage), cmp_colorusage);
}

void Texture::remap_palette (Textures* new_palette)
{
  int i, j, x, y;
  int trans[256];
  int used[256];
  for (i = 0 ; i < 256 ; i++) used[i] = FALSE;
  for (i = 0 ; i < gf->palette_entries ; i++)
  {
    if (i != transparent && (!filtered || filters[i] == NULL))
    {
      trans[i] = new_palette->find_rgb_slow (gf->palette[i].red,
					gf->palette[i].green, gf->palette[i].blue);
      used[trans[i]] = TRUE;
    }
    else trans[i] = -1;
  }

  // All entries which are still -1 are used for non-colors (eg: filters and
  // transparency. Remap them to unused color slots.
  for (i = 0 ; i < gf->palette_entries ; i++)
    if (trans[i] == -1)
    {
      for (j = 0 ; j < 256 ; j++)
	if (!used[j]) { trans[i] = j; used[j] = TRUE; break; }
    }

  unsigned char* d = gf->bitmap;
  for (y = 0 ; y < gf->height ; y++)
    for (x = 0 ; x < gf->width ; x++)
    {
      *d = trans[*d];
      d++;
    }

  if (filters)
  {
    Filter** ff = new Filter* [256];
    for (i = 0 ; i < 256 ; i++)
      ff[i] = NULL;
    for (i = 0 ; i < gf->palette_entries ; i++)
      ff[trans[i]] = filters[i];
    CopyMemPPC (ff, filters,sizeof (Filter*)*256);
    delete [] ff;
  }
}

void Texture::save (FILE* fp, int indent)
{
  int i;
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sTEXTURE '%s' (", sp, name);
  fprintf (fp, "TRANSPARENT=%d", transparent);
  if (filtered)
  {
    fprintf (fp, "\n");
    for (i = 0 ; i < 256 ; i++)
      if (filters[i])
	fprintf (fp, "%s  FILTER %d='%s'\n", sp, i, filters[i]->get_name ());
    fprintf (fp, "%s)\n", sp);
  }
  else
    fprintf (fp, ")\n");
}

void Texture::load (char** buf)
{
  char* t;
  int i;

  skip_token (buf, "TEXTURE");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a TEXTURE!\n");

  while (TRUE)
  {
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "TRANSPARENT"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TRANSPARENT!\n");
      transparent = get_token_int (buf);
    }
    else if (!strcmp (t, "FILTER"))
    {
      i = get_token_int (buf);
      skip_token (buf, "=", "Expected '%s' instead of '%s' after FILTER!\n");
      t = get_token (buf);
      if (!strcmp (t, "light_glass")) set_filter (i, &light_glass);
      else if (!strcmp (t, "dark_glass")) set_filter (i, &dark_glass);
      else if (!strcmp (t, "very_dark_glass")) set_filter (i, &very_dark_glass);
      else if (!strcmp (t, "medium_glass")) set_filter (i, &medium_glass);
      else if (!strcmp (t, "very_light_glass")) set_filter (i, &very_light_glass);
      else if (!strcmp (t, "filter_color_red")) set_filter (i, &filter_color_red);
      else if (!strcmp (t, "filter_color_green")) set_filter (i, &filter_color_green);
      else if (!strcmp (t, "filter_color_blue")) set_filter (i, &filter_color_blue);
      else if (!strcmp (t, "filter_color_yellow")) set_filter (i, &filter_color_yellow);
      else if (!strcmp (t, "filter_m100")) set_filter (i, &filter_m100);
      else if (!strcmp (t, "filter_m75")) set_filter (i, &filter_m75);
      else if (!strcmp (t, "filter_m50")) set_filter (i, &filter_m50);
      else if (!strcmp (t, "filter_m25")) set_filter (i, &filter_m25);
      else if (!strcmp (t, "filter_0")) set_filter (i, &filter_0);
      else if (!strcmp (t, "filter_25")) set_filter (i, &filter_25);
      else if (!strcmp (t, "filter_50")) set_filter (i, &filter_50);
      else if (!strcmp (t, "filter_75")) set_filter (i, &filter_75);
      else if (!strcmp (t, "filter_100")) set_filter (i, &filter_100);
      else
      {
	printf ("Never heard of filter '%s' in my whole existance!\n", t);
	exit (0);
      }
    }
  }
}

//---------------------------------------------------------------------------

#define PREFERED_DIST 16333
#define PREFERED_COL_DIST 133333

Textures::Textures (int max)
{
  max_textures = max;
  num_textures = 0;
  textures = new Texture* [max];
  textured = TRUE;
  mipmapped = 1;

  do_lighting = TRUE;
  read_config ();
}

void Textures::read_config ()
{
  char* p;

  prefered_dist = config.get_int ("RGB_DIST", PREFERED_DIST);
  prefered_col_dist = config.get_int ("RGB_COL_DIST", PREFERED_COL_DIST);
  p = config.get_str ("MIPMAP_NICE", "nice");
  if (!strcmp (p, "nice")) mipmap_nice = MIPMAP_NICE;
  else if (!strcmp (p, "ugly")) mipmap_nice = MIPMAP_UGLY;
  else if (!strcmp (p, "default")) mipmap_nice = MIPMAP_DEFAULT;
  else
  {
    printf ("Bad value '%s' for MIPMAP_NICE!\n", p);
    exit (0);
  }

  p = config.get_str ("TABLE1", "white");
  if (!strcmp (p, "white")) color_table1 = TABLE_WHITE;
  else if (!strcmp (p, "red")) color_table1 = TABLE_RED;
  else if (!strcmp (p, "green")) color_table1 = TABLE_GREEN;
  else if (!strcmp (p, "blue")) color_table1 = TABLE_BLUE;
  else
  {
    printf ("Bad value '%s' for TABLE1!\n", p);
    exit (0);
  }

  p = config.get_str ("TABLE2", "red");
  if (!strcmp (p, "white")) color_table2 = TABLE_WHITE;
  else if (!strcmp (p, "red")) color_table2 = TABLE_RED;
  else if (!strcmp (p, "green")) color_table2 = TABLE_GREEN;
  else if (!strcmp (p, "blue")) color_table2 = TABLE_BLUE;
  else
  {
    printf ("Bad value '%s' for TABLE2!\n", p);
    exit (0);
  }

  p = config.get_str ("TABLE3", "blue");
  if (!strcmp (p, "white")) color_table3 = TABLE_WHITE;
  else if (!strcmp (p, "red")) color_table3 = TABLE_RED;
  else if (!strcmp (p, "green")) color_table3 = TABLE_GREEN;
  else if (!strcmp (p, "blue")) color_table3 = TABLE_BLUE;
  else
  {
    printf ("Bad value '%s' for TABLE3!\n", p);
    exit (0);
  }
}

Textures::~Textures ()
{
  if (textures) delete [] textures;
}

Texture* Textures::new_texture (char* name)
{
  Texture* t = new Texture (name);
  textures[num_textures++] = t;
  return t;
}

int Textures::get_texture_idx (char* name)
{
  int i;
  for (i = 0 ; i < num_textures ; i++)
    if (!strcmp (textures[i]->get_name (), name)) return i;
  return -1;
}

int Textures::find_rgb (int r, int g, int b)
{
  return find_rgb_slow (r, g, b);
}

int Textures::find_rgb_slow (int r, int g, int b)
{
  int i, min, dist, mindist;
  mindist = 1000*256*256; min = -1;

  for(i = 0 ; i < 256 ; i++)
    if (alloc[i])
    {
      dist = 299*(r-pal[i].red)*(r-pal[i].red)+
	587*(g-pal[i].green)*(g-pal[i].green)+
	114*(b-pal[i].blue)*(b-pal[i].blue);
      if (dist == 0) return i;
      if (dist < mindist) { mindist = dist; min = i; }
    }
  return min;
}

int Textures::alloc_rgb (int r, int g, int b, int dist)
{
  int d, j;
  if (r < 0) r = 0; else if (r > 255) r = 255;
  if (g < 0) g = 0; else if (g > 255) g = 255;
  if (b < 0) b = 0; else if (b > 255) b = 255;

  int i = find_rgb_slow (r, g, b);
  if (i != -1)
  {
    d = 299*(r-pal[i].red)*(r-pal[i].red)+
      587*(g-pal[i].green)*(g-pal[i].green)+
      114*(b-pal[i].blue)*(b-pal[i].blue);
  }
  if (i == -1 || d > dist)
  {
    for (j = 0 ; j < 256 ; j++)
      if (!alloc[j])
      {
        alloc[j] = TRUE;
	pal[j].red = r;
	pal[j].green = g;
	pal[j].blue = b;
	return j;
      }
    return i; // We couldn't allocate a new color, return best fit
  }
  else return i;
}

struct SortRed
{
  int idx;
  int red;
};

int cmp_red (const void* v1, const void* v2)
{
  SortRed* u1 = (SortRed*)v1;
  SortRed* u2 = (SortRed*)v2;
  if (u1->red < u2->red) return -1;
  else if (u1->red > u2->red) return 1;
  else return 0;
}

void Textures::compute_palette ()
{
  int i, j, t;

  printf ("Computing palette... "); fflush (stdout);

  for (i = 1 ; i < 256 ; i++)
    alloc[i] = FALSE;

  // By allocating black at 0 and white at 255 we are compatible with
  // the Windows palette (those two colors cannot be modified).
  alloc[0] = TRUE;
  pal[0].red = 0;
  pal[0].green = 0;
  pal[0].blue = 0;
  alloc[255] = TRUE;
  pal[255].red = 255;
  pal[255].green = 255;
  pal[255].blue = 255;

  // First compute the usage of all colors of all textures.
  // These usage lists will be sorted so that the most frequently
  // used color of each textures is put first.
  for (i = 0 ; i < num_textures ; i++)
    textures[i]->compute_color_usage ();

  int pr1, pg1, pb1, pr2, pg2, pb2, pr3, pg3, pb3;
  if (color_table1 == TABLE_RED)        { pr1 = 50; pg1 = 0; pb1 = 0; }
  else if (color_table1 == TABLE_GREEN) { pr1 = 0; pg1 = 50; pb1 = 0; }
  else if (color_table1 == TABLE_BLUE)  { pr1 = 0; pg1 = 0; pb1 = 50; }
  else { pr1 = 0; pg1 = 0; pb1 = 0; }
  if (color_table2 == TABLE_RED)        { pr2 = 50; pg2 = 0; pb2 = 0; }
  else if (color_table2 == TABLE_GREEN) { pr2 = 0; pg2 = 50; pb2 = 0; }
  else if (color_table2 == TABLE_BLUE)  { pr2 = 0; pg2 = 0; pb2 = 50; }
  else { pr2 = 0; pg2 = 0; pb2 = 0; }
  if (color_table3 == TABLE_RED)        { pr3 = 50; pg3 = 0; pb3 = 0; }
  else if (color_table3 == TABLE_GREEN) { pr3 = 0; pg3 = 50; pb3 = 0; }
  else if (color_table3 == TABLE_BLUE)  { pr3 = 0; pg3 = 0; pb3 = 50; }
  else { pr3 = 0; pg3 = 0; pb3 = 0; }

  // Then allocate colors for all textures at the same time.
  for (i = 0 ; i < 256 ; i++)
  {
    for (t = 0 ; t < num_textures ; t++)
      if (i < textures[t]->get_num_colors ())
      {
	j = textures[t]->get_usage (i).idx;
	if (j != textures[t]->get_transparent () && (!textures[t]->get_filtered () ||
						     textures[t]->get_filters()[j] == NULL))
	{
	  alloc_rgb (
		     textures[t]->get_usage (i).color.red,
		     textures[t]->get_usage (i).color.green,
		     textures[t]->get_usage (i).color.blue,
		     prefered_dist);
	  if (pr1 || pg1 || pb1)
	    alloc_rgb (
		       textures[t]->get_usage (i).color.red+pr1,
		       textures[t]->get_usage (i).color.green+pg1,
		       textures[t]->get_usage (i).color.blue+pb1,
		       prefered_col_dist);
	  if (pr2 || pg2 || pb2)
	    alloc_rgb (
		       textures[t]->get_usage (i).color.red+pr2,
		       textures[t]->get_usage (i).color.green+pg2,
		       textures[t]->get_usage (i).color.blue+pb2,
		       prefered_col_dist);
	  if (pr3 || pg3 || pb3)
	    alloc_rgb (
		       textures[t]->get_usage (i).color.red+pr3,
		       textures[t]->get_usage (i).color.green+pg3,
		       textures[t]->get_usage (i).color.blue+pb3,
		       prefered_col_dist);
	}
      }
  }

  // Remap all textures according to the new colormap.
  for (i = 0 ; i < num_textures ; i++)
    textures[i]->remap_palette (this);

  for (i = 0 ; i < num_textures ; i++)
    textures[i]->clear_color_usage ();

  black_color = find_rgb (0, 0, 0);
  white_color = find_rgb (255, 255, 255);
  red_color = find_rgb (255, 0, 0);
  blue_color = find_rgb (0, 0, 255);
  yellow_color = find_rgb (255, 255, 0);
  green_color = find_rgb (0, 255, 0);

  printf ("DONE\n");
}

int Textures::find_rgb_map (int r, int g, int b, int map_type, int l)
{
  int nr = r, ng = g, nb = b;
  switch (map_type)
  {
    case TABLE_WHITE:
      nr = l*r / 200;
      ng = l*g / 200;
      nb = l*b / 200;
      break;
    case TABLE_RED:
      nr = r+l;
      ng = g;
      nb = b;
      break;
    case TABLE_BLUE:
      nr = r;
      ng = g;
      nb = b+l;
      break;
    case TABLE_GREEN:
      nr = r;
      ng = g+l;
      nb = b;
      break;
  }
  return find_rgb (nr, ng, nb);
}

void Textures::compute_light_tables ()
{
  int l, i;
  int r, g, b;

  if (color_table1 == TABLE_WHITE) level1 = DEFAULT_LIGHT_LEVEL; else level1 = 0;
  if (color_table2 == TABLE_WHITE) level2 = DEFAULT_LIGHT_LEVEL; else level2 = 0;
  if (color_table3 == TABLE_WHITE) level3 = DEFAULT_LIGHT_LEVEL; else level3 = 0;

  // Light level 200 is normal

  printf ("Computing light tables... "); fflush (stdout);

  FILE* fp = fopen ("light.tables", "rb");
  if (fp)
  {
    printf ("reading from file... "); fflush (stdout);
    for (i = 0 ; i < 256 ; i++)
      for (l = 0 ; l < 256 ; l++)
      {
        fread ((void*)&(light[l][i]), sizeof (unsigned char), 1, fp);
        fread ((void*)&(red_light[l][i]), sizeof (unsigned char), 1, fp);
        fread ((void*)&(blue_light[l][i]), sizeof (unsigned char), 1, fp);
      }
    fclose (fp);
  }
  else
  {
    fp = fopen ("light.tables", "wb");
    time_t s1 = I_GetTime(), s2;
    for (i = 0 ; i < 256 ; i++)
      if (alloc[i])
      {
        r = pal[i].red;
        g = pal[i].green;
        b = pal[i].blue;
        for (l = 0 ; l < 256 ; l++)
        {
	  light[l][i] = find_rgb_map (r, g, b, color_table1, l);
	  red_light[l][i] = find_rgb_map (r, g, b, color_table2, l);
	  blue_light[l][i] = find_rgb_map (r, g, b, color_table3, l);
	  fwrite ((void*)&(light[l][i]), sizeof (unsigned char), 1, fp);
	  fwrite ((void*)&(red_light[l][i]), sizeof (unsigned char), 1, fp);
	  fwrite ((void*)&(blue_light[l][i]), sizeof (unsigned char), 1, fp);
        }
      }
    s2 = I_GetTime();
    printf ("(Elapsed time = %ld seconds) ", s2-s1);
    fclose (fp);
  }

  printf ("DONE\n");
}

void Textures::create_mipmap_textures ()
{
  int i, j, mm, start, stop;
  int r, g, b;

  rnum_textures = num_textures;

  printf ("Create mipmapped textures ... "); fflush (stdout);

  for (mm = 1 ; mm <= 3 ; mm++)
  {
    if (mm == 1)
    {
      offs_mipmap1 = num_textures;
      start = 0;
      stop = offs_mipmap1;
    }
    else if (mm == 2)
    {
      offs_mipmap2 = num_textures;
      start = offs_mipmap1;
      stop = offs_mipmap2;
      printf ("level 2 ... "); fflush (stdout);
    }
    else
    {
      offs_mipmap3 = num_textures;
      start = offs_mipmap2;
      stop = offs_mipmap3;
      printf ("level 3 ... "); fflush (stdout);
    }

    for (i = start ; i < stop ; i++)
    {
      int w, h, w2, h2, x, y;
      w = textures[i]->get_width ();
      h = textures[i]->get_height ();
      w2 = w/2;
      h2 = h/2;
      Texture* t = new Texture (w2, h2);
      textures[num_textures++] = t;
      unsigned char* bm = textures[i]->get_bitmap ();
      unsigned char* bm2 = t->get_bitmap ();

      t->set_transparent (textures[i]->get_transparent ());
      int tran = textures[i]->get_transparent () != -1;
      int filt = textures[i]->get_filtered ();
      if (filt)
      {
	Filter** f = textures[i]->get_filters ();
	for (j = 0 ; j < 256 ; j++)
	  if (f[j]) t->set_filter (j, f[j]);
      }

      if (tran || filt || mipmap_nice == MIPMAP_UGLY)
	for (y = 0 ; y < h2 ; y++)
	{
	  for (x = 0 ; x < w2 ; x++)
	  {
	    *bm2++ = *bm;
	    bm += 2;
	  }
	  bm += w;
	}
      else if (mipmap_nice == MIPMAP_DEFAULT)
	for (y = 0 ; y < h2 ; y++)
	{
	  for (x = 0 ; x < w2 ; x++)
	  {
	    // @@@ Consider a more accurate algorithm that shifts the source bitmap one
	    // half pixel. In the current implementation there is a small shift in the
	    // texture data.
	    r = pal[*bm].red + pal[*(bm+1)].red + pal[*(bm+w)].red + pal[*(bm+w+1)].red;
	    g = pal[*bm].green + pal[*(bm+1)].green + pal[*(bm+w)].green + pal[*(bm+w+1)].green;
	    b = pal[*bm].blue + pal[*(bm+1)].blue + pal[*(bm+w)].blue + pal[*(bm+w+1)].blue;
	    *bm2++ = find_rgb (r/4, g/4, b/4);
	    bm += 2;
	  }
	  bm += w;
	}
      else
      {
	int m11, m12, m13;
	int m21, m22, m23;
	int m31, m32, m33;
	for (y = 0 ; y < h ; y += 2)
	{
	  for (x = 0 ; x < w ; x += 2)
	  {
	    m11 = ((x-1+w)%w) + ((y-1+h)%h) * w;
	    m12 = x           + ((y-1+h)%h) * w;
	    m13 = ((x+1)%w)   + ((y-1+h)%h) * w;
	    m21 = ((x-1+w)%w) + y * w;
	    m22 = x           + y * w;
	    m23 = ((x+1)%w)   + y * w;
	    m31 = ((x-1+w)%w) + ((y+1)%h) * w;
	    m32 = x           + ((y+1)%h) * w;
	    m33 = ((x+1)%w)   + ((y+1)%h) * w;
	    r =   pal[bm[m11]].red +   2*pal[bm[m12]].red +     pal[bm[m13]].red +
	        2*pal[bm[m21]].red +   4*pal[bm[m22]].red +   2*pal[bm[m23]].red +
	          pal[bm[m31]].red +   2*pal[bm[m32]].red +     pal[bm[m33]].red;
	    g =   pal[bm[m11]].green + 2*pal[bm[m12]].green +   pal[bm[m13]].green +
	        2*pal[bm[m21]].green + 4*pal[bm[m22]].green + 2*pal[bm[m23]].green +
	          pal[bm[m31]].green + 2*pal[bm[m32]].green +   pal[bm[m33]].green;
	    b =   pal[bm[m11]].blue +  2*pal[bm[m12]].blue +    pal[bm[m13]].blue +
	        2*pal[bm[m21]].blue +  4*pal[bm[m22]].blue +  2*pal[bm[m23]].blue +
	          pal[bm[m31]].blue +  2*pal[bm[m32]].blue +    pal[bm[m33]].blue;
	    *bm2++ = find_rgb (r/16, g/16, b/16);
	  }
	}
      }
    }
  }

  printf ("DONE\n");
}

#include <exec/types.h>

extern ULONG rtgpal[770];


void Textures::alloc_palette (Graphics* g)
{
  int i;
  for (i = 0 ; i < 256 ; i++)
  {
   if (alloc[i])
   {
    rtgpal[3*i+1]=pal[i].red*0x01010101;
    rtgpal[3*i+2]=pal[i].green*0x01010101;
    rtgpal[3*i+3]=pal[i].blue*0x01010101;
    graphicsPalette[i].red=pal[i].red;
    graphicsPalette[i].green=pal[i].green;
    graphicsPalette[i].blue=pal[i].blue;
   }
   else
   {
    rtgpal[3*i+1]=graphicsPalette[i].red*0x01010101;
    rtgpal[3*i+2]=graphicsPalette[i].green*0x01010101;
    rtgpal[3*i+3]=graphicsPalette[i].blue*0x01010101;
   }
  }
  rtgpal[769]=0;
  rtgpal[0]=256*65536+0;
  g->SetRGB(0,0,0,0);
}

void Textures::save (FILE* fp, int indent)
{
  int i;
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sTEXTURES (\n", sp);
  fprintf (fp, "%s  MAX_TEXTURES=%d\n", sp, max_textures);
  for (i = 0 ; i < rnum_textures ; i++) textures[i]->save (fp, indent+2);
  fprintf (fp, "%s)\n", sp);
}

void Textures::load (char** buf)
{
  char* t;
  char* old_buf;
  Texture* tex;

  skip_token (buf, "TEXTURES");
  skip_token (buf, "(", "Expected '%s' instead of '%s' after TEXTURES statement!\n");

  num_textures = 0;

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "MAX_TEXTURES"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after MAX_TEXTURES!\n");
      max_textures = get_token_int (buf);
      if (textures) delete [] textures;
      textures = new Texture* [max_textures];
    }
    else if (!strcmp (t, "TEXTURE"))
    {
      t = get_token (buf);
      tex = new_texture (t);
      *buf = old_buf;
      tex->load (buf);
    }
  }

  compute_palette ();
  compute_light_tables ();
  create_mipmap_textures ();
}

//---------------------------------------------------------------------------

void Filter::init_filters (Textures* tex)
{
  ::very_light_glass.light_glass (tex);
  ::light_glass.light_glass (tex);
  ::dark_glass.dark_glass (tex);
  ::very_dark_glass.very_dark_glass (tex);
  ::medium_glass.medium_glass (tex);
  ::filter_color_red.add_color (tex, 50, 0, 0);
  ::filter_color_blue.add_color (tex, 0, 0, 50);
  ::filter_color_green.add_color (tex, 0, 50, 0);
  ::filter_color_yellow.add_color (tex, 50, 50, 0);
  ::filter_m100.add_color (tex, -100, -100, -100);
  ::filter_m75.add_color (tex, -75, -75, -75);
  ::filter_m50.add_color (tex, -50, -50, -50);
  ::filter_m25.add_color (tex, -25, -25, -25);
  ::filter_0.add_color (tex, 0, 0, 0);
  ::filter_25.add_color (tex, 25, 25, 25);
  ::filter_50.add_color (tex, 50, 50, 50);
  ::filter_75.add_color (tex, 75, 75, 75);
  ::filter_100.add_color (tex, 100, 100, 100);
}

Filter::Filter (char* name)
{
  strcpy (Filter::name, name);
  trans = new unsigned char [256];
}

Filter::~Filter ()
{
  if (trans) delete [] trans;
}

void Filter::mean_with_color (Textures* tex, int rg, int gg, int bg, int weight)
{
  int i, r, g, b, rd, gd, bd;
  rg *= weight;
  bg *= weight;
  gg *= weight;
  for (i = 0 ; i < 256 ; i++)
    if (tex->get_pal_alloced (i))
    {
      r = tex->get_pal_red (i);
      g = tex->get_pal_green (i);
      b = tex->get_pal_blue (i);
      rd = (r+rg)/2;
      gd = (g+gg)/2;
      bd = (b+bg)/2;
      trans[i] = tex->find_rgb (rd, gd, bd);
    }
}

void Filter::add_color (Textures* tex, int rg, int gg, int bg)
{
  int i, r, g, b, rd, gd, bd;
  for (i = 0 ; i < 256 ; i++)
    if (tex->get_pal_alloced (i))
    {
      r = tex->get_pal_red (i);
      g = tex->get_pal_green (i);
      b = tex->get_pal_blue (i);
      rd = r+rg;
      gd = g+gg;
      bd = b+bg;
      trans[i] = tex->find_rgb (rd, gd, bd);
    }
}

void Filter::very_light_glass (Textures* tex)
{
  mean_with_color (tex, 220, 240, 250, 1);
}

void Filter::light_glass (Textures* tex)
{
  mean_with_color (tex, 200, 220, 240, 1);
}

void Filter::medium_glass (Textures* tex)
{
  mean_with_color (tex, 190, 210, 230, 1);
}

void Filter::dark_glass (Textures* tex)
{
  mean_with_color (tex, 180, 200, 220, 1);
}

void Filter::very_dark_glass (Textures* tex)
{
  mean_with_color (tex, 150, 180, 180, 1);
}

void Filter::transparent (Textures* tex)
{
  (void)tex;
  int i;
  for (i = 0 ; i < 256 ; i++)
    trans[i] = i;
}

//---------------------------------------------------------------------------

TextureCache::TextureCache ()
{
  clear ();
}

TextureCache::~TextureCache ()
{
}

void TextureCache::clear ()
{
  while (first)
  {
    PolyTexture* n = first->next;
    first->next = first->prev = NULL;
    first->in_cache = FALSE;
    if (first->tmap)
    {
      delete [] first->tmap;
      first->tmap = NULL;
    }
    first = n;
  }

  first = last = NULL;
  total_size = 0;
  total_textures = 0;
}

void TextureCache::dump ()
{
  printf ("Texture cache information:\n");
  printf ("  There are %d textures in the cache\n", total_textures);
  printf ("  with a total size of %ld bytes\n", total_size);
  int mean;
  if (total_textures == 0) mean = 0;
  else mean = total_size/total_textures;
  printf ("  giving %d bytes per texture in the cache.\n", mean);
}

void TextureCache::use_texture (PolyTexture* pt, Textures* textures)
{
  if (!pt->polygon->get_lightmap ()) return;

  if (pt->in_cache)
  {
    // Texture is already in the cache.

    // Unlink texture and put it in front (MRU).
    if (pt != first)
    {
      if (pt->prev) pt->prev->next = pt->next;
      else first = pt->next;
      if (pt->next) pt->next->prev = pt->prev;
      else last = pt->prev;

      pt->prev = NULL;
      pt->next = first;
      if (first) first->prev = pt;
      else last = pt;
      first = pt;
    }
  }
  else
  {
    // Texture is not in the cache.
    while (total_size + pt->size >= MAX_CACHE_SIZE)
    {
      // Total size of textures in cache is too high. Remove the last one.
      PolyTexture* l = last;
      last = last->prev;
      if (last) last->next = NULL;
      else first = NULL;
      l->prev = NULL;
      l->in_cache = FALSE;
      if (l->tmap)
      {
	delete [] l->tmap;
	l->tmap = NULL;
      }
      total_textures--;
      total_size -= l->size;
    }
    total_textures++;
    total_size += pt->size;

    // Add new texture to cache.
    pt->next = first;
    pt->prev = NULL;
    if (first) first->prev = pt;
    else last = pt;
    first = pt;
    pt->in_cache = TRUE;
    pt->create_lighted_texture (textures);
  }
}

//---------------------------------------------------------------------------
