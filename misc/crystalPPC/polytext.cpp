#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef POLYTEXT_H
#include "polytext.h"
#endif

#ifndef POLYPLANE_H
#include "polyplan.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef LIGHTMAP_H
#include "lightmap.h"
#endif

extern TextureCache cache;

//---------------------------------------------------------------------------

PolyTexture::PolyTexture ()
{
  next = prev = NULL;
  in_cache = FALSE;
  tmap = NULL;

  light_u = -1;
  light_v = -1;
  sq_rad = 0;
}

PolyTexture::~PolyTexture ()
{
  if (tmap) delete [] tmap;
}

void PolyTexture::set_texnr (Textures* textures, int texnr)
{
  PolyTexture::texnr = texnr;
  texture = textures->get_texture (texnr);
}

void PolyTexture::create_bounding_texture_box ()
{

  // First we compute the bounding box in 2D texture space (uv-space).
  float min_u = 1000000000.;
  float min_v = 1000000000.;
  float max_u = -1000000000.;
  float max_v = -1000000000.;

  PolyPlane* pl = polygon->get_plane ();

  int i;
  Vector3 v1, v2;
  for (i = 0 ; i < polygon->get_num_vertices () ; i++)
  {
    v1 = polygon->vtex (i).get_v (); 	// Coordinates of vertex in world space.
    v1 -= pl->v_world2tex;
    pl->m_world2tex.transform (v1, v2);	// Coordinates of vertex in texture space.
    if (v2.x < min_u) min_u = v2.x;
    if (v2.x > max_u) max_u = v2.x;
    if (v2.y < min_v) min_v = v2.y;
    if (v2.y > max_v) max_v = v2.y;
  }

  int ww = texture->get_width ();
  int hh = texture->get_height ();
  Imin_u = QRound (min_u*ww);
  Imin_v = QRound (min_v*hh);
  Imax_u = QRound (max_u*ww);
  Imax_v = QRound (max_v*hh);

  h = Imax_v-Imin_v;
  int w2 = Imax_u-Imin_u;
  w = 1;
  shf_u = 0;
  and_u = 0;
  while (TRUE)
  {
    if (w2 <= w) break;
    w <<= 1;
    shf_u++;
    and_u = (and_u<<1)+1;
  }

  fdu = min_u*ww;
  fdv = min_v*hh;
  du = QInt16 (min_u*ww);
  dv = QInt16 (min_v*hh);

  size = w*h;
}

void PolyTexture::create_lighted_texture (Textures* textures)
{
  if (tmap)
  {
    delete [] tmap;
    tmap = NULL;
  }

  if (!lm) return;

  unsigned char* light_map = lm->get_light_map ();
  unsigned char* red_light_map = lm->get_red_light_map ();
  unsigned char* blue_light_map = lm->get_blue_light_map ();

  unsigned char* otmap = texture->get_bitmap ();

  int shf_w = texture->get_w_shift ();
  int and_w = texture->get_w_mask ();
  int and_h = texture->get_h_mask ();
  and_h <<= shf_w;

  tmap = new unsigned char [size];
  unsigned char* tm = tmap;
  int u, v, old_w;
  old_w = Imax_u-Imin_u;
  unsigned char* light, * red_light, * blue_light;
  int lu, lv, lw, lh;
  lw = w/mipmap_size+2;
  lh = h/mipmap_size+2;
  int luv, du, dv;

  int whi_00, red_00, blu_00;
  int whi_10, red_10, blu_10;
  int whi_01, red_01, blu_01;
  int whi_11, red_11, blu_11;
  int whi_0, whi_1, whi_d, whi_0d, whi_1d;
  int red_0, red_1, red_d, red_0d, red_1d;
  int blu_0, blu_1, blu_d, blu_0d, blu_1d;
  int whi, red, blu;
  int o_idx, ov_idx;

  luv = 0;
  for (lv = 0 ; lv < lh ; lv++)
  {
    for (lu = 0 ; lu < lw ; lu++)
    {
      whi_00 = light_map[luv];
      whi_10 = light_map[luv+1];
      whi_01 = light_map[luv+lw];
      whi_11 = light_map[luv+lw+1];
      red_00 = red_light_map[luv];
      red_10 = red_light_map[luv+1];
      red_01 = red_light_map[luv+lw];
      red_11 = red_light_map[luv+lw+1];
      blu_00 = blue_light_map[luv];
      blu_10 = blue_light_map[luv+1];
      blu_01 = blue_light_map[luv+lw];
      blu_11 = blue_light_map[luv+lw+1];

      u = lu*mipmap_size;
      v = lv*mipmap_size;
      tm = &tmap[w*v+u];

      if (blu_00 == 0 && blu_10 == 0 && blu_01 == 0 && blu_11 == 0)
      {
	// No blue lighting

	if (red_00 == 0 && red_10 == 0 && red_01 == 0 && red_11 == 0)
	{
	  // No colored lighting

	  if (whi_00 == whi_10 && whi_00 == whi_01 && whi_00 == whi_11)
	  {
	    //*****
	    // Constant level of white light and no colored light.
	    //*****

	    light = textures->get_light_table (whi_00);

	    for (dv = 0 ; dv < mipmap_size ; dv++, tm += w-mipmap_size)
	      if (v+dv < h)
	      {
		ov_idx = ((v+dv+Imin_v)<<shf_w) & and_h;

		for (du = 0 ; du < mipmap_size ; du++)
		  if (u+du < w)
		  {
		    o_idx = ov_idx + ((u+du+Imin_u) & and_w);
		    *tm++ = light[otmap[o_idx]];
		  }
		  else { tm += mipmap_size-du; break; }
	      }
	      else break;
	  }
	  else
	  {
	    //*****
	    // No colored light and a varying level of white light.
	    //*****

	    whi_0 = whi_00 << 16; whi_0d = ((whi_01-whi_00)<<16) / mipmap_size;
	    whi_1 = whi_10 << 16; whi_1d = ((whi_11-whi_10)<<16) / mipmap_size;

	    for (dv = 0 ; dv < mipmap_size ; dv++, tm += w-mipmap_size)
	      if (v+dv < h)
	      {
		ov_idx = ((v+dv+Imin_v)<<shf_w) & and_h;
		whi = whi_0; whi_d = (whi_1-whi_0)/mipmap_size;

		for (du = 0 ; du < mipmap_size ; du++)
		  if (u+du < w)
		  {
		    light = textures->get_light_table (whi >> 16);
		    o_idx = ov_idx + ((u+du+Imin_u) & and_w);
		    *tm++ = light[otmap[o_idx]];
		    whi += whi_d;
		  }
		  else { tm += mipmap_size-du; break; }

		whi_0 += whi_0d;
		whi_1 += whi_1d;
	      }
	      else break;
	  }
	}
	else
	{
	  //*****
	  // No blue lighting but with red lighting
	  //*****

	  whi_0 = whi_00 << 16; whi_0d = ((whi_01-whi_00)<<16) / mipmap_size;
	  whi_1 = whi_10 << 16; whi_1d = ((whi_11-whi_10)<<16) / mipmap_size;
	  red_0 = red_00 << 16; red_0d = ((red_01-red_00)<<16) / mipmap_size;
	  red_1 = red_10 << 16; red_1d = ((red_11-red_10)<<16) / mipmap_size;

	  for (dv = 0 ; dv < mipmap_size ; dv++, tm += w-mipmap_size)
	    if (v+dv < h)
	    {
	      ov_idx = ((v+dv+Imin_v)<<shf_w) & and_h;

	      whi = whi_0; whi_d = (whi_1-whi_0)/mipmap_size;
	      red = red_0; red_d = (red_1-red_0)/mipmap_size;

	      for (du = 0 ; du < mipmap_size ; du++)
		if (u+du < w)
		{
		  light = textures->get_light_table (whi >> 16);
		  red_light = textures->get_red_light_table (red >> 16);

		  o_idx = ov_idx + ((u+du+Imin_u) & and_w);
		  *tm++ = red_light[light[otmap[o_idx]]];

		  whi += whi_d;
		  red += red_d;
		}
		else { tm += mipmap_size-du; break; }

	      whi_0 += whi_0d;
	      whi_1 += whi_1d;
	      red_0 += red_0d;
	      red_1 += red_1d;
	    }
	    else break;
	}

//u = lu*mipmap_size; v = lv*mipmap_size;
//if (u < w && v < h) { tm = &tmap[w*v+u]; *tm = textures->get_light_table (255)[*tm]; }

	luv++;
	continue;
      }
      else if (red_00 == 0 && red_10 == 0 && red_01 == 0 && red_11 == 0)
      {
	//*****
	// No red lighting but with blue lighting
	//*****

	whi_0 = whi_00 << 16; whi_0d = ((whi_01-whi_00)<<16) / mipmap_size;
	whi_1 = whi_10 << 16; whi_1d = ((whi_11-whi_10)<<16) / mipmap_size;
	blu_0 = blu_00 << 16; blu_0d = ((blu_01-blu_00)<<16) / mipmap_size;
	blu_1 = blu_10 << 16; blu_1d = ((blu_11-blu_10)<<16) / mipmap_size;

	for (dv = 0 ; dv < mipmap_size ; dv++, tm += w-mipmap_size)
	  if (v+dv < h)
	  {
	    ov_idx = ((v+dv+Imin_v)<<shf_w) & and_h;

	    whi = whi_0; whi_d = (whi_1-whi_0)/mipmap_size;
	    blu = blu_0; blu_d = (blu_1-blu_0)/mipmap_size;

	    for (du = 0 ; du < mipmap_size ; du++)
	      if (u+du < w)
	      {
		light = textures->get_light_table (whi >> 16);
		blue_light = textures->get_blue_light_table (blu >> 16);

		o_idx = ov_idx + ((u+du+Imin_u) & and_w);
		*tm++ = blue_light[light[otmap[o_idx]]];

		whi += whi_d;
		blu += blu_d;
	      }
	      else { tm += mipmap_size-du; break; }

	    whi_0 += whi_0d;
	    whi_1 += whi_1d;
	    blu_0 += blu_0d;
	    blu_1 += blu_1d;
	  }
	  else break;

//u = lu*mipmap_size; v = lv*mipmap_size;
//if (u < w && v < h) { tm = &tmap[w*v+u]; *tm = textures->get_light_table (255)[*tm]; }

	luv++;
	continue;
      }

      //*****
      // Most general case: varying levels of white, red, and blue light.
      //*****

      whi_0 = whi_00 << 16; whi_0d = ((whi_01-whi_00)<<16) / mipmap_size;
      whi_1 = whi_10 << 16; whi_1d = ((whi_11-whi_10)<<16) / mipmap_size;
      red_0 = red_00 << 16; red_0d = ((red_01-red_00)<<16) / mipmap_size;
      red_1 = red_10 << 16; red_1d = ((red_11-red_10)<<16) / mipmap_size;
      blu_0 = blu_00 << 16; blu_0d = ((blu_01-blu_00)<<16) / mipmap_size;
      blu_1 = blu_10 << 16; blu_1d = ((blu_11-blu_10)<<16) / mipmap_size;

      for (dv = 0 ; dv < mipmap_size ; dv++, tm += w-mipmap_size)
	if (v+dv < h)
        {
	  ov_idx = ((v+dv+Imin_v)<<shf_w) & and_h;

	  whi = whi_0; whi_d = (whi_1-whi_0)/mipmap_size;
	  red = red_0; red_d = (red_1-red_0)/mipmap_size;
	  blu = blu_0; blu_d = (blu_1-blu_0)/mipmap_size;

	  for (du = 0 ; du < mipmap_size ; du++)
	    if (u+du < w)
	    {
	      light = textures->get_light_table (whi >> 16);
	      red_light = textures->get_red_light_table (red >> 16);
	      blue_light = textures->get_blue_light_table (blu >> 16);

	      o_idx = ov_idx + ((u+du+Imin_u) & and_w);
	      *tm++ = blue_light[red_light[light[otmap[o_idx]]]];

	      whi += whi_d;
	      red += red_d;
	      blu += blu_d;
	    }
	    else { tm += mipmap_size-du; break; }

	  whi_0 += whi_0d;
	  whi_1 += whi_1d;
	  red_0 += red_0d;
	  red_1 += red_1d;
	  blu_0 += blu_0d;
	  blu_1 += blu_1d;
	}
	else break;

//u = lu*mipmap_size; v = lv*mipmap_size;
//if (u < w && v < h) { tm = &tmap[w*v+u]; *tm = textures->get_light_table (255)[*tm]; }

      luv++;
    }
  }
}

void PolyTexture::shine (Light* light)
{
  if (!lm) return;

  int lw = w/mipmap_size+2;
  int lh = h/mipmap_size+2;

  unsigned char* light_map = lm->get_light_map ();
  unsigned char* red_light_map = lm->get_red_light_map ();
  unsigned char* blue_light_map = lm->get_blue_light_map ();

  int u, v, uv;
  float cx, cy, cz;
  int l, red_l, blue_l;
  float x, y, z, d, dl;

  int ww = texture->get_width ();
  int hh = texture->get_height ();

  PolyPlane* pl = polygon->get_plane ();

  // From: T = Mwt * (W - Vwt)
  // ===>
  // Mtw * T = W - Vwt
  // Mtw * T + Vwt = W
  Matrix3 m_t2w = pl->m_world2tex;
  m_t2w.inverse ();
  Vector3 vv = pl->v_world2tex;

  Vector3 v1, v2;

  int ru, rv;

  for (v = 0 ; v < lh ; v++)
    for (u = 0 ; u < lw ; u++)
    {
      uv = v*lw+u;

      ru = u*mipmap_size;
      rv = v*mipmap_size;
      if (ru > w || rv > h)
      {
        // Special case. The beam hit some part that is
	// in fact not on the polygon. In that case there
	// is the posibility that our hit_beam will not work
	// correctly. Therefore we currently solve this problem
	// by just taking the light values of the closest hit
	// on the polygon. This is not an ideal solution but
	// it is the first thing I came up with.@@@
	if (ru > w)
	{
	  light_map[uv] = light_map[uv-1];
	  red_light_map[uv] = red_light_map[uv-1];
	  blue_light_map[uv] = blue_light_map[uv-1];
	}
	else if (rv > h)
	{
	  light_map[uv] = light_map[uv-lw];
	  red_light_map[uv] = red_light_map[uv-lw];
	  blue_light_map[uv] = blue_light_map[uv-lw];
	}
	continue;
      }

      v1.x = (float)(ru+Imin_u)/(float)ww;
      v1.y = (float)(rv+Imin_v)/(float)hh;
      v1.z = 0;
      m_t2w.transform (v1, v2);
      v2 += vv;
      x = v2.x;
      y = v2.y;
      z = v2.z;

      // @@@ Due to floating point rounding errors it is possible
      // that the resulting vector 'v2' will not lie on the polygon.
      // This can happen when either 'ru' or 'rv' is 0 (this is at
      // one of the top or left borders of the uv bounding box).
      // In this case our hit routine will most likely not reach the polygon
      // and the point will be unlit (shadowed).
      // I don't currently have a good solution for this problem but I
      // do solve most occurences of it by modifying 'hit_beam' so that
      // it considers hits with a polygon on the same plane as good hits.
      // This only solves the problem in some cases.
      
      l = light_map[uv];
      red_l = red_light_map[uv];
      blue_l = blue_light_map[uv];

      cx = light->get_center ().x;
      cy = light->get_center ().y;
      cz = light->get_center ().z;
      d = sqrt ((cx-x)*(cx-x)+(cy-y)*(cy-y)+(cz-z)*(cz-z));
      if (d < light->get_dist ())
      {
	if (!light->hit_beam (light->get_center (), v2, polygon)) continue;

	dl = (light->get_strength ()*200)/light->get_dist ();
	l = l + QRound (light->get_strength ()*200 - d*dl);
	if (light->get_red_strength () > 0)
	{
	  dl = (light->get_red_strength ()*200)/light->get_dist ();
	  red_l = red_l + QRound (light->get_red_strength ()*200 - d*dl);
	}
	if (light->get_blue_strength () > 0)
	{
	  dl = (light->get_blue_strength ()*200)/light->get_dist ();
	  blue_l = blue_l + QRound (light->get_blue_strength ()*200 - d*dl);
	}

	if (l > 255) l = 255;
	light_map[uv] = l;
	if (red_l > 255) red_l = 255;
	red_light_map[uv] = red_l;
	if (blue_l > 255) blue_l = 255;
	blue_light_map[uv] = blue_l;
      }
    }
}

void PolyTexture::setup_dyn_light (DynLight* light, float sq_dist)
{
  Vector3 isect, luv;
  polygon->closest_point (light->get_center (), isect);
  PolyPlane* pl = polygon->get_plane ();

  // From: T = Mwt * (W - Vwt)
  isect -= pl->v_world2tex;
  pl->m_world2tex.transform (isect, luv);

  int ww = texture->get_width ();
  int hh = texture->get_height ();

  light_u = QRound (luv.x*ww);
  light_v = QRound (luv.y*hh);
  sq_rad = QRound (light->get_sq_dist () - sq_dist) * ww * ww;
}

//---------------------------------------------------------------------------
