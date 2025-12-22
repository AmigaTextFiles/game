#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef THING_H
#include "thing.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef SCAN_H
#include "scan.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef CAMERA_H
#include "camera.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

//---------------------------------------------------------------------------

Thing::Thing (char* name, int max_v, int max_p) : PolygonSet (name, CS_THING, max_v, max_p)
{
  v_obj2world.x = 0;
  v_obj2world.y = 0;
  v_obj2world.z = 0;
  m_obj2world.identity ();
  m_world2obj.identity ();
}

Thing::~Thing ()
{
}

void Thing::transform ()
{
  int i;
  for (i = 0 ; i < num_vertices ; i++)
    vertices[i].object_to_world (m_obj2world, m_world2obj, v_obj2world);
  for (i = 0 ; i < num_polygon ; i++)
    polygon[i]->object_to_world (m_obj2world, m_world2obj, v_obj2world);
}

void Thing::set_move (Sector* home, float x, float y, float z)
{
  v_obj2world.x = -x;
  v_obj2world.y = -y;
  v_obj2world.z = -z;
  sector = home;
}

void Thing::set_transform (Matrix3& matrix)
{
  m_obj2world = matrix;
  m_world2obj = m_obj2world;
  m_world2obj.inverse ();
}

void Thing::move (float dx, float dy, float dz)
{
  v_obj2world.x += dx;
  v_obj2world.y += dy;
  v_obj2world.z += dz;
}

void Thing::transform (Matrix3& matrix)
{
  m_obj2world *= matrix;
  m_world2obj = m_obj2world;
  m_world2obj.inverse ();
}

void Thing::mipmap_settings (int setting)
{
  int i;
  for (i = 0 ; i < num_polygon ; i++)
  {
    polygon[i]->mipmap_settings (setting);
  }
}

void Thing::shine (Light* light)
{
  int i;
  for (i = 0 ; i < num_polygon ; i++)
    if (polygon[i]->visible_from_point (light->get_center ()))
      polygon[i]->shine (light);
}

void Thing::clear_shine_done ()
{
  int i;
  for (i = 0 ; i < num_polygon ; i++) polygon[i]->clear_shine_done ();
}

void Thing::draw (ViewPolygon* view, Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c)
{
  int i;

  if (transform_world2cam (m_w2c, m_c2w, v_w2c))
  {
    for (i = 0 ; i < num_polygon ; i++)
    {
      if (polygon[i]->do_perspective (m_w2c, m_c2w, v_w2c, &Polygon2D::clipped))
      {
	if (Polygon2D::clipped.clip_poly_variant (view))
	{
	  Polygon2D::clipped.draw_filled (polygon[i], TRUE);
	  if (Scan::c->edit_mode != MODE_NONE && Scan::c->sel_polygon == polygon[i])
	    Polygon2D::clipped.draw (Scan::textures->red ());
	  else if (Scan::c->edit_mode == MODE_POLYGON) Polygon2D::clipped.draw (Scan::textures->white ());
	}
      }
    }

    if (Scan::c->edit_mode != MODE_NONE) edit_draw_vertices ();
  }
}

void Thing::save (FILE* fp, int indent, Textures* textures)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  PolygonSet::save (fp, indent, textures, "THING");
  fprintf (fp, "%s  MOVE (\n", sp);
  m_obj2world.save (fp, indent+4);
  Vector3 v = v_obj2world;
  v.x = -v.x; v.y = -v.y; v.z = -v.z;
  v.save (fp, indent+4);
  fprintf (fp, "%s  )\n", sp);
  fprintf (fp, "%s)\n", sp);
}

void Thing::load (World* w, char** buf, Textures* textures)
{
  PolygonSet::load (w, buf, textures, "THING");
  skip_token (buf, "MOVE", "Expected '%s' instead of '%s' for a THING!\n");
  skip_token (buf, "(", "Expected '%s' instead of '%s' after MOVE!\n");
  m_obj2world.load (buf);
  Vector3 v;
  v.load (buf);
  v.x = -v.x; v.y = -v.y; v.z = -v.z;
  v_obj2world = v;
  skip_token (buf, ")", "Expected '%s' instead of '%s' to finish MOVE!\n");
  skip_token (buf, ")", "Expected '%s' instead of '%s' to finish the THING!\n");
  m_world2obj = m_obj2world;
  m_world2obj.inverse ();

  transform ();
}

typedef char ObName[30];

void Thing::load_sixface (World* w, char** buf, Textures* textures)
{
  char* t;
  char* old_buf;
  int j;

  set_max (25, 16);

  num_vertices = 0;
  num_polygon = 0;

  skip_token (buf, "SIXFACE");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a SIXFACE!\n");

  v_obj2world.x = 0;
  v_obj2world.y = 0;
  v_obj2world.z = 0;
  m_obj2world.identity ();
  m_world2obj.identity ();

  int color;
  float tscale;
  color = 0;
  tscale = 1;

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
      m_obj2world.load (buf);
      v_obj2world.load (buf);
      m_world2obj = m_obj2world;
      m_world2obj.inverse ();
      v_obj2world.x = -v_obj2world.x;
      v_obj2world.y = -v_obj2world.y;
      v_obj2world.z = -v_obj2world.z;
      skip_token (buf, ")", "Expected '%s' instead of '%s' to finish MOVE!\n");
    }
    else if (!strcmp (t, "TEXTURE"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXTURE!\n");
      t = get_token (buf);
      color = textures->get_texture_idx (t);
      if (color == -1) printf ("Couldn't find texture named '%s'!\n", t);
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
      printf ("What is '%s' doing in a SIXFACE statement?\n", t);
    }
  }

  j = 0;
#if 1
  set_vertex (j++, v0);
  set_vertex (j++, v1);
  set_vertex (j++, v2);
  set_vertex (j++, v3);
  set_vertex (j++, v4);
  set_vertex (j++, v5);
  set_vertex (j++, v6);
  set_vertex (j++, v7);
#else
  mm.transform (v0, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v1, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v2, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v3, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v4, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v5, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v6, vv); vv += vm; set_vertex (j++, vv);
  mm.transform (v7, vv); vv += vm; set_vertex (j++, vv);
#endif

  Polygon3D* p;

  struct Todo
  {
    ObName poly;
    int v1, v2, v3, v4;
    int tv1, tv2;
    int color;
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
  todo[todo_end].color = color;
  todo_end++;

  strcpy (todo[todo_end].poly, "east");
  todo[todo_end].v1 = 1;
  todo[todo_end].v2 = 5;
  todo[todo_end].v3 = 7;
  todo[todo_end].v4 = 3;
  todo[todo_end].tv1 = 1;
  todo[todo_end].tv2 = 5;
  todo[todo_end].color = color;
  todo_end++;

  strcpy (todo[todo_end].poly, "south");
  todo[todo_end].v1 = 5;
  todo[todo_end].v2 = 4;
  todo[todo_end].v3 = 6;
  todo[todo_end].v4 = 7;
  todo[todo_end].tv1 = 5;
  todo[todo_end].tv2 = 4;
  todo[todo_end].color = color;
  todo_end++;

  strcpy (todo[todo_end].poly, "west");
  todo[todo_end].v1 = 4;
  todo[todo_end].v2 = 0;
  todo[todo_end].v3 = 2;
  todo[todo_end].v4 = 6;
  todo[todo_end].tv1 = 4;
  todo[todo_end].tv2 = 0;
  todo[todo_end].color = color;
  todo_end++;

  strcpy (todo[todo_end].poly, "up");
  todo[todo_end].v1 = 4;
  todo[todo_end].v2 = 5;
  todo[todo_end].v3 = 1;
  todo[todo_end].v4 = 0;
  todo[todo_end].tv1 = 4;
  todo[todo_end].tv2 = 5;
  todo[todo_end].color = color;
  todo_end++;

  strcpy (todo[todo_end].poly, "down");
  todo[todo_end].v1 = 2;
  todo[todo_end].v2 = 3;
  todo[todo_end].v3 = 7;
  todo[todo_end].v4 = 6;
  todo[todo_end].tv1 = 2;
  todo[todo_end].tv2 = 3;
  todo[todo_end].color = color;
  todo_end++;

  while (done < todo_end)
  {
    p = new_polygon (todo[done].poly, 20, textures, todo[done].color);
    p->add_vertex (todo[done].v4);
    p->add_vertex (todo[done].v3);
    p->add_vertex (todo[done].v2);
    p->add_vertex (todo[done].v1);
    p->set_texture_space (vtex (todo[done].tv2), vtex (todo[done].tv1), tscale);
    done++;
  }

  transform ();
}

//---------------------------------------------------------------------------
