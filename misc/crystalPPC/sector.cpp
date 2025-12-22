#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef THING_H
#include "thing.h"
#endif

//#ifndef OCCLUS_H
//#include "occlus.h"
//#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef SCAN_H
#include "scan.h"
#endif

#ifndef CAMERA_H
#include "camera.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

//---------------------------------------------------------------------------

Sector::Sector (char* name, int max_v, int max_p) : PolygonSet (name, CS_SECTOR, max_v, max_p)
{
  first_thing = NULL;
#if USE_OCCLUSION
  first_occlusion = NULL;
#endif
  num_lights = 0;
  sector = this;
  draw_done = FALSE;
  beam_done = FALSE;
  level1 = level2 = level3 = 0;
}

Sector::~Sector ()
{
  int i;
  while (first_thing)
  {
    Thing* n = (Thing*)(first_thing->get_next ());
    delete first_thing;
    first_thing = n;
  }
#if USE_OCCLUSION
  while (first_occlusion)
  {
    Occlusion* n = first_occlusion->get_next ();
    delete first_occlusion;
    first_occlusion = n;
  }
#endif
  for (i = 0 ; i < num_lights ; i++)
  {
    delete lights[i];
  }
}

void Sector::add_thing (Thing* thing)
{
  thing->set_next ((PolygonSet*)first_thing);
  first_thing = thing;
}

#if USE_OCCLUSION
void Sector::add_occlusion (Occlusion* occlusion)
{
  occlusion->set_next (first_occlusion);
  first_occlusion = occlusion;
}
#endif

void Sector::add_light (Light* light)
{
  lights[num_lights++] = light;
  light->set_sector (this);
}

Polygon3D* Sector::hit_beam (Vector3& start, Vector3& end)
{
  Vector3 isect;
  Polygon3D* p;

  // First check the things of this sector and return the one with
  // the closest distance.
  Thing* sp = first_thing;
  float sq_dist, min_sq_dist = 100000000.;
  Polygon3D* min_poly = NULL;
  while (sp)
  {
    p = sp->intersect_segment (start, end, isect);
    if (p)
    {
      sq_dist = (isect.x-start.x)*(isect.x-start.x) +
	(isect.y-start.y)*(isect.y-start.y) +
	(isect.z-start.z)*(isect.z-start.z);
      if (sq_dist < min_sq_dist) { min_sq_dist = sq_dist; min_poly = p; }
    }
    sp = (Thing*)(sp->get_next ());
  }

  if (min_poly) return min_poly;

  p = intersect_segment (start, end, isect);
  if (p)
  {
    if (p->get_portal ()) return p->get_portal ()->hit_beam (start, end);
    else return p;
  }
  else return NULL;
}

int Sector::hit_beam (Vector3& start, Vector3& end, Polygon3D* poly)
{
  int rc = FALSE;
  Polygon3D* p;
  Vector3 isect;

  if (this == poly->get_sector ()) rc = TRUE;
  else
  {
    beam_done = TRUE;

    p = intersect_segment (start, end, isect);
    if (p)
    {
      // If the two polygons are on the same plane there is a hit.
      if (p->same_plane (poly))
        rc = TRUE;
      else
      {
        Sector* s = p->get_portal ();
        if (!s) rc = FALSE;
        else if (s->beam_done) rc = FALSE;
        else rc = s->hit_beam (start, end, poly);
      }
    }

    beam_done = FALSE;
  }

  // If rc == TRUE the beam of light hits the polygon. In
  // that case we check if there are no things in between the
  // light and the polygon that could still block that beam.
  if (rc)
  {
    Thing* sp = first_thing;
    while (sp)
    {
      p = sp->intersect_segment (start, end, isect);
      if (p && p->get_poly_set () != poly->get_poly_set ()) return FALSE;
      sp = (Thing*)(sp->get_next ());
    }
  }

  return rc;
}

void Sector::shine_lights ()
{
  int i;
  for (i = 0 ; i < num_lights ; i++)
  {
    printf ("Shining light %d (%2.2f,%2.2f,%2.2f) %2.2f in sector '%s'\n",
	    i, lights[i]->get_center ().x, lights[i]->get_center ().y, lights[i]->get_center ().z,
	    lights[i]->get_dist (),
	    get_name ());
    lights[i]->shine ();
  }
}

void Sector::clear_shine_done ()
{
  int i;
  draw_done = TRUE;
  for (i = 0 ; i < num_polygon ; i++)
  {
    Sector* s = polygon[i]->get_portal ();
    if (s)
    {
      if (!s->draw_done) s->clear_shine_done ();
    }
    else
    {
      polygon[i]->clear_shine_done ();
    }
  }
  draw_done = FALSE;

  Thing* sp = first_thing;
  while (sp)
  {
    sp->clear_shine_done ();
    sp = (Thing*)(sp->get_next ());
  }
}

void Sector::mipmap_settings (int setting)
{
  int i;
  for (i = 0 ; i < num_polygon ; i++)
  {
    Sector* s = polygon[i]->get_portal ();
    if (!s)
    {
      polygon[i]->mipmap_settings (setting);
    }
  }

  Thing* sp = first_thing;
  while (sp)
  {
    sp->mipmap_settings (setting);
    sp = (Thing*)(sp->get_next ());
  }
}

void Sector::shine (Light* light)
{
  int i;
  draw_done = TRUE;
  for (i = 0 ; i < num_polygon ; i++)
  {
    if (polygon[i]->visible_from_point (light->get_center ()))
    {
      if (polygon[i]->sq_distance (light->get_center ()) < light->get_sq_dist ())
      {
	Sector* s = polygon[i]->get_portal ();
	if (s)
	{
	  if (!s->draw_done) s->shine (light);
	}
	else
	{
	  polygon[i]->shine (light);
	}
      }
    }
  }
  draw_done = FALSE;

  Thing* sp = first_thing;
  while (sp)
  {
    sp->shine (light);
    sp = (Thing*)(sp->get_next ());
  }
}

void Sector::setup_dyn_light (DynLight* light)
{
  int i;
  float sq_dist;

  draw_done = TRUE;
  for (i = 0 ; i < num_polygon ; i++)
  {
    if (polygon[i]->visible_from_point (light->get_center ()))
    {
      sq_dist = polygon[i]->sq_distance (light->get_center ());
      if (sq_dist < light->get_sq_dist ())
      {
	Sector* s = polygon[i]->get_portal ();
	if (s)
	{
	  if (!s->draw_done) s->setup_dyn_light (light);
	}
	else
	{
	  polygon[i]->setup_dyn_light (light, sq_dist);
	}
      }
    }
  }
  draw_done = FALSE;
}

DynLight* Sector::add_dyn_light (float x, float y, float z, float dist, float strength,
				 float red_strength, float blue_strength)
{
  DynLight* l = new DynLight (x, y, z, dist, strength, red_strength, blue_strength);
  l->set_sector (this);
  l->setup ();
  return l;
}

void Sector::draw (ViewPolygon* view, Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c)
{
  int i;
  draw_done = TRUE;

#if USE_OCCLUSION
  // First compute the convex hulls for all occlusion objects.
  // These can then be used to 
  Occlusion* o = first_occlusion;
  while (o)
  {
    if (o->transform_world2cam (m_w2c, m_c2w, v_w2c))
    {
      o->convex_hull ();
      if (Scan::c->edit_mode != MODE_NONE) o->edit_draw_vertices ();
    }
    else o->clear_hull ();
    o = o->get_next ();
  }
#endif /*USE_OCCLUSION*/

  transform_world2cam (m_w2c, m_c2w, v_w2c);

  for (i = 0 ; i < num_polygon ; i++)
  {
    if (polygon[i]->do_perspective (m_w2c, m_c2w, v_w2c, &Polygon2D::clipped))
    {
      if (Polygon2D::clipped.clip_poly_variant (view))
      {
#       if USE_OCCLUSION
	o = first_occlusion;
	while (o)
	{
	  if (!Polygon2D::clipped.clip_to_occlusion (o)) break;
	  o = o->get_next ();
	}
	if (o) continue; // Polygon has been completely clipped away
#       endif /*USE_OCCLUSION*/

	Sector* s = polygon[i]->get_portal ();
	if (s)
	{
	  //if (!s->draw_done)
	  {
	    ViewPolygon* new_view = Polygon2D::clipped.create_view ();
	    if (new_view)
	    {
	      int filtered =
		Scan::textures->get_texture (polygon[i]->get_texnr ())->get_transparent () != -1 ||
		Scan::textures->get_texture (polygon[i]->get_texnr ())->get_filtered ();

	      Polygon2D* keep_clipped = NULL;
	      if (filtered)
		keep_clipped = new Polygon2D (Polygon2D::clipped);

	      if (polygon[i]->is_space_warped ())
	      {
		Matrix3 mw_w2c = m_w2c;
		Matrix3 mw_c2w = m_c2w;
		Vector3 vw_w2c = v_w2c;
		polygon[i]->warp_space (mw_w2c, mw_c2w, vw_w2c);
		s->draw (new_view, mw_w2c, mw_c2w, vw_w2c);
	      }
	      else s->draw (new_view, m_w2c, m_c2w, v_w2c);
	      delete new_view;

	      if (filtered)
	      {
		keep_clipped->draw_filled (polygon[i]);
		delete keep_clipped;
	      }
	    }
	  }
	  //else printf ("This should not happen!\n");
	}
	else Polygon2D::clipped.draw_filled (polygon[i]);

	if (Scan::c->edit_mode != MODE_NONE && Scan::c->sel_polygon == polygon[i])
	  Polygon2D::clipped.draw (Scan::textures->red ());
	else if (Scan::c->edit_mode == MODE_POLYGON) Polygon2D::clipped.draw (Scan::textures->white ());
      }
    }
  }

  if (Scan::c->edit_mode != MODE_NONE) edit_draw_vertices ();

  Thing* sp = first_thing;
  while (sp)
  {
    sp->draw (view, m_w2c, m_c2w, v_w2c);
    sp = (Thing*)(sp->get_next ());
  }

  draw_done = FALSE;
}

void Sector::save (FILE* fp, int indent, Textures* textures)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  PolygonSet::save (fp, indent, textures, "SECTOR");
#if USE_OCCLUSION
  Occlusion* o = first_occlusion;
  while (o)
  {
    o->save (fp, indent+2);
    o = o->get_next ();
  }
#endif
  Thing* s = first_thing;
  while (s)
  {
    s->save (fp, indent+2, textures);
    s = (Thing*)(s->get_next ());
  }
  int i;
  for (i = 0 ; i < num_lights ; i++)
    lights[i]->save (fp, indent+2);

  fprintf (fp, "%s)\n", sp);
}

typedef char ObName[30];

void Sector::load_room (World* w, char** buf, Textures* textures)
{
  char* t;
  char* old_buf;
  int i, j, k, l;
  int i1, i2, i3, i4;

  level1 = textures->get_level1 ();
  level2 = textures->get_level2 ();
  level3 = textures->get_level3 ();

  set_max (200, 100);

  num_vertices = 0;
  num_polygon = 0;
  for (i = 0 ; i < num_lights ; i++) delete lights[i];
  num_lights = 0;
  while (first_thing)
  {
    Thing* n = (Thing*)(first_thing->get_next ());
    delete first_thing;
    first_thing = n;
  }

  skip_token (buf, "ROOM");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a ROOM!\n");

  Matrix3 mm; mm.identity ();
  Vector3 vm (0, 0, 0);
  int texnr;
  float tscale;
  int no_mipmap = FALSE, no_lighting = FALSE;
  texnr = 0;
  tscale = 1;

  int num_portals = 0;
  struct Portal
  {
    ObName poly;
    ObName sector;
    int is_warp;
    Matrix3 m_warp;
    Vector3 v_warp;
  };
  Portal portals[30];

  int num_splits = 0;
  struct Split
  {
    ObName poly;
    float pctA[20];
    float widA[20];
    int dir;
    int cnt;
  };
  Split to_split[60];
  struct Color
  {
    ObName poly;
    ObName plane;
    int texnr;
  };
  Color colors[100];
  int num_colors = 0;

  Vector3 v0, v1, v2, v3, v4, v5, v6, v7;
  v0.x = -1; v0.y =  1; v0.z =  1;
  v1.x =  1; v1.y =  1; v1.z =  1;
  v2.x = -1; v2.y = -1; v2.z =  1;
  v3.x =  1; v3.y = -1; v3.z =  1;
  v4.x = -1; v4.y =  1; v4.z = -1;
  v5.x =  1; v5.y =  1; v5.z = -1;
  v6.x = -1; v6.y = -1; v6.z = -1;
  v7.x =  1; v7.y = -1; v7.z = -1;
  float r;

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "MOVE"))
    {
      skip_token (buf, "(", "Expected '%s' instead of '%s' after MOVE!\n");
      mm.load (buf);
      vm.load (buf);
      skip_token (buf, ")", "Expected '%s' instead of '%s' to finish MOVE!\n");
    }
    else if (!strcmp (t, "TEXTURE"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE!\n");
      t = get_token (buf);
      texnr = textures->get_texture_idx (t);
      if (texnr == -1)
      {
        printf ("Couldn't find texture named '%s'!\n", t);
	exit (0);
      }
    }
    else if (!strcmp (t, "TEXTURE_LIGHTING"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE_LIGHTING!\n");
      t = get_token (buf);
      no_lighting = !!strcmp (t, "yes");
    }
    else if (!strcmp (t, "TEXTURE_MIPMAP"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE_MIPMAP!\n");
      t = get_token (buf);
      no_mipmap = !!strcmp (t, "yes");
    }
    else if (!strcmp (t, "CEIL_TEXTURE"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after CEIL_TEXTURE!\n");
      t = get_token (buf);
      colors[num_colors].texnr = textures->get_texture_idx (t);
      if (colors[num_colors].texnr == -1)
      {
        printf ("Couldn't find texture named '%s'!\n", t);
	exit (0);
      }
      strcpy (colors[num_colors].poly, "up");
      colors[num_colors].plane[0] = 0;
      num_colors++;
    }
    else if (!strcmp (t, "FLOOR_TEXTURE"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after FLOOR_TEXTURE!\n");
      t = get_token (buf);
      colors[num_colors].texnr = textures->get_texture_idx (t);
      if (colors[num_colors].texnr == -1)
      {
        printf ("Couldn't find texture named '%s'!\n", t);
	exit (0);
      }
      strcpy (colors[num_colors].poly, "down");
      colors[num_colors].plane[0] = 0;
      num_colors++;
    }
    else if (!strcmp (t, "TEX"))
    {
      t = get_token (buf);
      strcpy (colors[num_colors].poly, t);
      skip_token (buf, "=", "Expected '%s' instead of '%s' in TEX!\n");
      skip_token (buf, "(", "Expected '%s' instead of '%s' in TEX!\n");
      colors[num_colors].plane[0] = 0;
      colors[num_colors].texnr = -1;

      while (TRUE)
      {
	old_buf = *buf;
	t = get_token (buf);
	if (*t == ')' || *t == 0) break;
	if (!strcmp (t, "TEXTURE"))
	{
	  t = get_token (buf);
	  colors[num_colors].texnr = textures->get_texture_idx (t);
	  if (colors[num_colors].texnr == -1)
	  {
	    printf ("Couldn't find texture named '%s'!\n", t);
	    exit (0);
	  }
	}
	else if (!strcmp (t, "PLANE"))
	{
	  t = get_token (buf);
	  strcpy (colors[num_colors].plane, t);
	}
	else
	{
	  printf ("What is '%s' doing in a ROOM/TEX statement?\n", t);
	  exit (0);
	}
      }
      num_colors++;
    }
    else if (!strcmp (t, "TEXTURE_SCALE"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE_SCALE!\n");
      tscale = get_token_float (buf);
    }
    else if (!strcmp (t, "DIMX"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after DIMX!\n");
      r = get_token_float (buf);
      r /= 2;
      v0.x = -r;
      v1.x = r;
      v2.x = -r;
      v3.x = r;
      v4.x = -r;
      v5.x = r;
      v6.x = -r;
      v7.x = r;
    }
    else if (!strcmp (t, "DIMY"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after DIMY!\n");
      r = get_token_float (buf);
      r /= 2;
      v0.y = r;
      v1.y = r;
      v2.y = -r;
      v3.y = -r;
      v4.y = r;
      v5.y = r;
      v6.y = -r;
      v7.y = -r;
    }
    else if (!strcmp (t, "DIMZ"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after DIMZ!\n");
      r = get_token_float (buf);
      r /= 2;
      v0.z = r;
      v1.z = r;
      v2.z = r;
      v3.z = r;
      v4.z = -r;
      v5.z = -r;
      v6.z = -r;
      v7.z = -r;
    }
    else if (!strcmp (t, "FLOOR_HEIGHT"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after FLOOR_HEIGHT!\n");
      r = get_token_float (buf);
      v0.y = r+v0.y-v2.y;
      v1.y = r+v1.y-v3.y;
      v4.y = r+v4.y-v6.y;
      v5.y = r+v5.y-v7.y;
      v2.y = r;
      v3.y = r;
      v6.y = r;
      v7.y = r;
    }
    else if (!strcmp (t, "HEIGHT"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after HEIGHT!\n");
      r = get_token_float (buf);
      v0.y = r+v2.y;
      v1.y = r+v3.y;
      v4.y = r+v6.y;
      v5.y = r+v7.y;
    }
    else if (!strcmp (t, "FLOOR") || !strcmp (t, "FLOOR_CEIL"))
    {
      int floor_ceil = !strcmp (t, "FLOOR_CEIL");
      skip_token (buf, "(", "Expected '%s' instead of '%s' after FLOOR!\n");
      v2.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after FLOOR!\n");
      v2.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v2.y = v2.z;
        v2.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after FLOOR!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after FLOOR!\n"); exit (0); }

      skip_token (buf, "(", "Expected '%s' instead of '%s' after FLOOR!\n");
      v3.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after FLOOR!\n");
      v3.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v3.y = v3.z;
        v3.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after FLOOR!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after FLOOR!\n"); exit (0); }

      skip_token (buf, "(", "Expected '%s' instead of '%s' after FLOOR!\n");
      v7.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after FLOOR!\n");
      v7.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v7.y = v7.z;
        v7.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after FLOOR!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after FLOOR!\n"); exit (0); }

      skip_token (buf, "(", "Expected '%s' instead of '%s' after FLOOR!\n");
      v6.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after FLOOR!\n");
      v6.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v6.y = v6.z;
        v6.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after FLOOR!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after FLOOR!\n"); exit (0); }
      if (floor_ceil)
      {
        v0 = v2;
	v1 = v3;
	v5 = v7;
	v4 = v6;
      }
    }
    else if (!strcmp (t, "CEILING"))
    {
      skip_token (buf, "(", "Expected '%s' instead of '%s' after CEILING!\n");
      v0.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after CEILING!\n");
      v0.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v0.y = v0.z;
        v0.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after CEILING!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after CEILING!\n"); exit (0); }

      skip_token (buf, "(", "Expected '%s' instead of '%s' after CEILING!\n");
      v1.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after CEILING!\n");
      v1.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v1.y = v1.z;
        v1.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after CEILING!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after CEILING!\n"); exit (0); }

      skip_token (buf, "(", "Expected '%s' instead of '%s' after CEILING!\n");
      v5.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after CEILING!\n");
      v5.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v5.y = v5.z;
        v5.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after CEILING!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after CEILING!\n"); exit (0); }

      skip_token (buf, "(", "Expected '%s' instead of '%s' after CEILING!\n");
      v4.x = get_token_float (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' after CEILING!\n");
      v4.z = get_token_float (buf);
      t = get_token (buf);
      if (*t == ',')
      {
        v4.y = v4.z;
        v4.z = get_token_float (buf);
        skip_token (buf, ")", "Expected '%s' instead of '%s' after CEILING!\n");
      }
      else if (*t != ')') { printf ("Expected ')' after CEILING!\n"); exit (0); }
    }
    else if (!strcmp (t, "LIGHT"))
    {
      *buf = old_buf;
      Light* l = new Light (0, 0, 0, 4, 1, 0, 0);
      l->load (buf);
      add_light (l);
    }
    else if (!strcmp (t, "SIXFACE"))
    {
      // Not an object but it is translated to a special thing.
      t = get_token (buf);
      Thing* sp = new Thing (t, 100, 100);
      sp->set_sector (this);
      *buf = old_buf;
      sp->load_sixface (w, buf, textures);
      add_thing (sp);
    }
    else if (!strcmp (t, "THING"))
    {
      // A thing.
      t = get_token (buf);
      Thing* sp = new Thing (t, 100, 100);
      sp->set_sector (this);
      *buf = old_buf;
      sp->load (w, buf, textures);
      add_thing (sp);
    }
#if USE_OCCLUSION
    else if (!strcmp (t, "OCCLUSION"))
    {
      // An occlusion object.
      t = get_token (buf);
      Occlusion* sp = new Occlusion (t, 100);
      sp->set_sector (this);
      *buf = old_buf;
      sp->load (w, buf);
      add_occlusion (sp);
    }
#endif
    else if (!strcmp (t, "PORTAL"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after PORTAL!\n");
      skip_token (buf, "(", "Expected '%s' instead of '%s' after PORTAL!\n");
      t = get_token (buf);
      strcpy (portals[num_portals].poly, t);
      skip_token (buf, ",", "Expected '%s' instead of '%s' in PORTAL statement!\n");
      t = get_token (buf);
      strcpy (portals[num_portals].sector, t);
      t = get_token (buf);
      portals[num_portals].is_warp = FALSE;
      if (*t == ',')
      {
	portals[num_portals].is_warp = TRUE;
	portals[num_portals].m_warp.load (buf);
	portals[num_portals].v_warp.load (buf);
	skip_token (buf, ")", "Expected '%s' instead of '%s' to end PORTAL statement!\n");
      }
      else if (*t != ')')
      {
	printf ("Expected ')' or ',' to end PORTAL statement!\n");
	exit (0);
      }
      num_portals++;
    }
    else if (!strcmp (t, "SPLIT"))
    {
      t = get_token (buf);
      strcpy (to_split[num_splits].poly, t);
      t = get_token (buf);
      if (!strcmp (t, "VER")) to_split[num_splits].dir = 0;
      else if (!strcmp (t, "HOR")) to_split[num_splits].dir = 1;
      else
      {
        printf ("Expected 'VER' or 'HOR' in SPLIT statement!\n");
        to_split[num_splits].dir = 0;
      }
      t = get_token (buf);
      int cnt = 0;
      if (*t == '%')
      {
        to_split[num_splits].pctA[cnt] = get_token_float (buf);
	cnt++;
      }
      else if (*t == '[')
      {
	while (*t && *t != ']')
	{
	  if (*t != '[' && *t != ',')
	  {
	    printf ("Expected '[' or ',' instead of '%s' in list of sizes!\n", t);
	  }
	  t = get_token (buf);
	  if (*t == '%')
	  {
	    to_split[num_splits].pctA[cnt] = get_token_float (buf);
	    cnt++;
	  }
	  else
	  {
	    to_split[num_splits].pctA[cnt] = -1;
	    sscanf (t, "%f", &to_split[num_splits].widA[cnt]);
	    cnt++;
	  }
	  t = get_token (buf);
	}
      }
      else
      {
        to_split[num_splits].pctA[cnt] = -1;
        sscanf (t, "%f", &to_split[num_splits].widA[cnt]);
	cnt++;
      }
      to_split[num_splits].cnt = cnt;
      num_splits++;
    }
    else if (!strcmp (t, "TRIGGER"))
    {
      t = get_token (buf);
      if (!strcmp (t, "activate"))
      {
	skip_token (buf, ":", "Expected '%s' instead of '%s' in TRIGGER!\n");
	t = get_token (buf);
	Script* s = w->get_script (t);
	if (!s)
	{
	  printf ("Don't know script '%s'!\n", t);
	  exit (0);
	}
	new_activate_trigger (s);
      }
      else
      {
	printf ("Trigger '%s' not supported or known for object '%s'!\n", t, name);
	exit (0);
      }
    }
    else
    {
      printf ("What is '%s' doing in a ROOM statement?\n", t);
      exit (0);
    }
  }

  Vector3 v, vv;
  j = 0;
  mm.transform (v0, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v1, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v2, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v3, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v4, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v5, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v6, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v7, vv); vv += vm; set_vertex (j++, vv);

  Polygon3D* p;

  struct Todo
  {
    ObName poly;
    int v1, v2, v3, v4;
    int tv1, tv2;
    int texnr;
    int col_idx;	// Idx in colors table if there was an override.
  };
  Todo todo[100];
  int done = 0;
  int todo_end = 0;

  strcpy (todo[todo_end].poly, "north");
  todo[todo_end].v1 = 0;
  todo[todo_end].v2 = 1;
  todo[todo_end].v3 = 3;
  todo[todo_end].v4 = 2;
  todo[todo_end].tv1 = 0;
  todo[todo_end].tv2 = 1;
  todo[todo_end].texnr = texnr;
  todo[todo_end].col_idx = -1;
  for (i = 0 ; i < num_colors ; i++)
    if (!strcmp (todo[todo_end].poly, colors[i].poly))
    {
      todo[todo_end].col_idx = i;
      break;
    }
  todo_end++;

  strcpy (todo[todo_end].poly, "east");
  todo[todo_end].v1 = 1;
  todo[todo_end].v2 = 5;
  todo[todo_end].v3 = 7;
  todo[todo_end].v4 = 3;
  todo[todo_end].tv1 = 1;
  todo[todo_end].tv2 = 5;
  todo[todo_end].texnr = texnr;
  todo[todo_end].col_idx = -1;
  for (i = 0 ; i < num_colors ; i++)
    if (!strcmp (todo[todo_end].poly, colors[i].poly))
    {
      todo[todo_end].col_idx = i;
      break;
    }
  todo_end++;

  strcpy (todo[todo_end].poly, "south");
  todo[todo_end].v1 = 5;
  todo[todo_end].v2 = 4;
  todo[todo_end].v3 = 6;
  todo[todo_end].v4 = 7;
  todo[todo_end].tv1 = 5;
  todo[todo_end].tv2 = 4;
  todo[todo_end].texnr = texnr;
  todo[todo_end].col_idx = -1;
  for (i = 0 ; i < num_colors ; i++)
    if (!strcmp (todo[todo_end].poly, colors[i].poly))
    {
      todo[todo_end].col_idx = i;
      break;
    }
  todo_end++;

  strcpy (todo[todo_end].poly, "west");
  todo[todo_end].v1 = 4;
  todo[todo_end].v2 = 0;
  todo[todo_end].v3 = 2;
  todo[todo_end].v4 = 6;
  todo[todo_end].tv1 = 4;
  todo[todo_end].tv2 = 0;
  todo[todo_end].texnr = texnr;
  todo[todo_end].col_idx = -1;
  for (i = 0 ; i < num_colors ; i++)
    if (!strcmp (todo[todo_end].poly, colors[i].poly))
    {
      todo[todo_end].col_idx = i;
      break;
    }
  todo_end++;

  strcpy (todo[todo_end].poly, "up");
  todo[todo_end].v1 = 4;
  todo[todo_end].v2 = 5;
  todo[todo_end].v3 = 1;
  todo[todo_end].v4 = 0;
  todo[todo_end].tv1 = 4;
  todo[todo_end].tv2 = 5;
  todo[todo_end].texnr = texnr;
  todo[todo_end].col_idx = -1;
  for (i = 0 ; i < num_colors ; i++)
    if (!strcmp (todo[todo_end].poly, colors[i].poly))
    {
      todo[todo_end].col_idx = i;
      break;
    }
  todo_end++;

  strcpy (todo[todo_end].poly, "down");
  todo[todo_end].v1 = 2;
  todo[todo_end].v2 = 3;
  todo[todo_end].v3 = 7;
  todo[todo_end].v4 = 6;
  todo[todo_end].tv1 = 2;
  todo[todo_end].tv2 = 3;
  todo[todo_end].texnr = texnr;
  todo[todo_end].col_idx = -1;
  for (i = 0 ; i < num_colors ; i++)
    if (!strcmp (todo[todo_end].poly, colors[i].poly))
    {
      todo[todo_end].col_idx = i;
      break;
    }
  todo_end++;

  int split;
  while (done < todo_end)
  {
    split = FALSE;
    for (i = 0 ; i < num_splits ; i++)
      if (!strcmp (todo[done].poly, to_split[i].poly))
      {
        split = TRUE;
	break;
      }

    if (split)
    {
      if (to_split[i].dir)
      {
	// Horizontal
	i1 = todo[done].v1;
	i2 = todo[done].v2;
	i3 = todo[done].v3;
	i4 = todo[done].v4;

	for (l = 0 ; l < to_split[i].cnt ; l++)
	{
	  Vector3::between (vtex (i1).get_v (), vtex (i2).get_v (),
			    v, to_split[i].pctA[l], to_split[i].widA[l]);
	  set_vertex (j++, v);
	  Vector3::between (vtex (i4).get_v (), vtex (i3).get_v (),
			    v, to_split[i].pctA[l], to_split[i].widA[l]);
	  set_vertex (j++, v);

	  sprintf (todo[todo_end].poly, "%s%c", todo[done].poly, l+'A');
	  todo[todo_end].v1 = i1;
	  todo[todo_end].v2 = j-2;
	  todo[todo_end].v3 = j-1;
	  todo[todo_end].v4 = i4;
	  todo[todo_end].tv1 = todo[done].tv1;
	  todo[todo_end].tv2 = todo[done].tv2;
	  todo[todo_end].texnr = todo[done].texnr;
	  todo[todo_end].col_idx = todo[done].col_idx;
	  for (k = 0 ; k < num_colors ; k++)
	    if (!strcmp (todo[todo_end].poly, colors[k].poly))
	    {
	      todo[todo_end].col_idx = k;
	      break;
	    }
	  todo_end++;

	  i1 = j-2;
	  i4 = j-1;
	}

	sprintf (todo[todo_end].poly, "%s%c", todo[done].poly, l+'A');
        todo[todo_end].v1 = i1;
        todo[todo_end].v2 = i2;
        todo[todo_end].v3 = i3;
        todo[todo_end].v4 = i4;
        todo[todo_end].tv1 = todo[done].tv1;
        todo[todo_end].tv2 = todo[done].tv2;
        todo[todo_end].texnr = todo[done].texnr;
	todo[todo_end].col_idx = todo[done].col_idx;
	for (k = 0 ; k < num_colors ; k++)
	  if (!strcmp (todo[todo_end].poly, colors[k].poly))
	  {
	    todo[todo_end].col_idx = k;
	    break;
	  }
        todo_end++;
      }
      else
      {
	// Vertical
	i1 = todo[done].v1;
	i2 = todo[done].v2;
	i3 = todo[done].v3;
	i4 = todo[done].v4;

	for (l = 0 ; l < to_split[i].cnt ; l++)
	{
	  Vector3::between (vtex (i4).get_v (), vtex (i1).get_v (),
			    v, to_split[i].pctA[l], to_split[i].widA[l]);
	  set_vertex (j++, v);
	  Vector3::between (vtex (i3).get_v (), vtex (i2).get_v (),
			    v, to_split[i].pctA[l], to_split[i].widA[l]);
	  set_vertex (j++, v);

	  sprintf (todo[todo_end].poly, "%s%d", todo[done].poly, l+1);
	  todo[todo_end].v1 = j-2;
	  todo[todo_end].v2 = j-1;
	  todo[todo_end].v3 = i3;
	  todo[todo_end].v4 = i4;
	  todo[todo_end].tv1 = todo[done].tv1;
	  todo[todo_end].tv2 = todo[done].tv2;
	  todo[todo_end].texnr = todo[done].texnr;
	  todo[todo_end].col_idx = todo[done].col_idx;
	  for (k = 0 ; k < num_colors ; k++)
	    if (!strcmp (todo[todo_end].poly, colors[k].poly))
	    {
	      todo[todo_end].col_idx = k;
	      break;
	    }
	  todo_end++;

	  i3 = j-1;
	  i4 = j-2;
	}

	sprintf (todo[todo_end].poly, "%s%d", todo[done].poly, l+1);
        todo[todo_end].v1 = i1;
        todo[todo_end].v2 = i2;
        todo[todo_end].v3 = i3;
        todo[todo_end].v4 = i4;
        todo[todo_end].tv1 = todo[done].tv1;
        todo[todo_end].tv2 = todo[done].tv2;
        todo[todo_end].texnr = todo[done].texnr;
	todo[todo_end].col_idx = todo[done].col_idx;
	for (k = 0 ; k < num_colors ; k++)
	  if (!strcmp (todo[todo_end].poly, colors[k].poly))
	  {
	    todo[todo_end].col_idx = k;
	    break;
	  }
        todo_end++;
      }
    }
    else
    {
      int idx = todo[done].col_idx;
      if (idx == -1 || colors[idx].texnr == -1) texnr = todo[done].texnr;
      else texnr = colors[idx].texnr;

      p = new_polygon (todo[done].poly, 10, textures, texnr);
      p->add_vertex (todo[done].v1);
      p->add_vertex (todo[done].v2);
      p->add_vertex (todo[done].v3);
      p->add_vertex (todo[done].v4);
      if (idx == -1 || colors[idx].plane[0] == 0)
	p->set_texture_space (vtex (todo[done].tv1), vtex (todo[done].tv2), tscale);
      else
	p->set_texture_space (w->get_plane (colors[idx].plane));
      p->set_no_mipmap (no_mipmap);
      p->set_no_lighting (no_lighting);
    }
    done++;
  }

  Sector* portal;

  for (i = 0 ; i < num_portals ; i++)
  {
    p = get_polygon (portals[i].poly);
    if (!p)
    {
      printf ("Error locating polygon '%s' in room '%s'!\n", portals[i].poly, name);
      return;
    }

    portal = w->get_sector (portals[i].sector);
    if (!portal)
      portal = w->new_sector (portals[i].sector, 10, 10);  // This will later be defined correctly
    p->set_portal (portal);
    if (portals[i].is_warp)
      p->set_warp (portals[i].m_warp, portals[i].v_warp);
  }
}

void Sector::load (World* w, char** buf, Textures* textures)
{
  char* t;
  char* old_buf;
  PolygonSet::load (w, buf, textures, "SECTOR");
  int i;

  level1 = textures->get_level1 ();
  level2 = textures->get_level2 ();
  level3 = textures->get_level3 ();

  for (i = 0 ; i < num_lights ; i++) delete lights[i];
  num_lights = 0;

  while (first_thing)
  {
    Thing* n = (Thing*)(first_thing->get_next ());
    delete first_thing;
    first_thing = n;
  }

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "THING"))
    {
      t = get_token (buf);
      Thing* sp = new Thing (t, 100, 100);
      sp->set_sector (this);
      *buf = old_buf;
      sp->load (w, buf, textures);
      add_thing (sp);
    }
#if USE_OCCLUSION
    else if (!strcmp (t, "OCCLUSION"))
    {
      t = get_token (buf);
      Occlusion* sp = new Occlusion (t, 100);
      sp->set_sector (this);
      *buf = old_buf;
      sp->load (w, buf);
      add_occlusion (sp);
    }
#endif
    else if (!strcmp (t, "SIXFACE"))
    {
      t = get_token (buf);
      Thing* sp = new Thing (t, 100, 100);
      sp->set_sector (this);
      *buf = old_buf;
      sp->load_sixface (w, buf, textures);
      add_thing (sp);
    }
    else if (!strcmp (t, "LIGHT"))
    {
      *buf = old_buf;
      Light* l = new Light (0, 0, 0, 4, 1, 0, 0);
      l->load (buf);
      add_light (l);
    }
    else
    {
      printf ("What is '%s' doing in a THING statement?\n", t);
    }
  }
}

Thing* Sector::get_thing (char* name)
{
  Thing* s = first_thing;
  while (s)
  {
    if (!strcmp (name, s->get_name ())) return s;
    s = (Thing*)(s->get_next ());
  }
  return NULL;
}

Polygon3D* Sector::select_polygon (Camera* c, ViewPolygon* view, int xx, int yy)
{
  // First check the things.
  Thing* sp = first_thing;
  Polygon3D* p, * min_p = NULL;
  Vector2 vs;
  Vector3 vc;
  vs.x = (float)xx;
  vs.y = (float)yy;
  float min_z = 1000000000.;

  while (sp)
  {
    p = sp->select_polygon (c, view, xx, yy);
    if (p)
    {
      // Directly after a ::select_polygon, Polygon2D::clipped still contains
      // the clipped polygon.
#if 0
      //@@@DOES NOT WORK ANYMORE! I HAVE TO CHANGE IT
      Polygon2D::clipped.get_3d_point (vs, vc);
#endif
      if (vc.z < min_z)
      {
	min_z = vc.z;
	min_p = p;
      }
    }
    sp = (Thing*)(sp->get_next ());
  }

  if (min_p) return min_p;
  else return PolygonSet::select_polygon (c, view, xx, yy);
}

//---------------------------------------------------------------------------
