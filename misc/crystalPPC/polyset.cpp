#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef POLYSET_H
#include "polyset.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

#ifndef CAMERA_H
#include "camera.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef SCAN_H
#include "scan.h"
#endif

//---------------------------------------------------------------------------

PolygonSet::PolygonSet (char* name, int type, int max_v, int max_p) : CsObject (name, type)
{
  num_vertices = 0;
  num_polygon = 0;

  vertices = NULL;
  polygon = NULL;

  set_max (max_v, max_p);
}

void PolygonSet::set_max (int max_v, int max_p)
{
  if (vertices) delete [] vertices;
  if (polygon) delete [] polygon;
  max_vertices = max_v;
  vertices = new Vertex [max_vertices];
  max_polygon = max_p;
  polygon = new Polygon3D* [max_polygon];
}

PolygonSet::~PolygonSet ()
{
  if (vertices) delete [] vertices;
  if (polygon) delete [] polygon;
}

void PolygonSet::set_vertex (int idx, float x, float y, float z)
{
  // By default all vertices are set with the same object space and world space.
  vertices[idx].set_o (x, y, z);
  vertices[idx].set (x, y, z);
  if (idx >= num_vertices) num_vertices = idx+1;
}

Polygon3D* PolygonSet::get_polygon (char* name)
{
  int i;
  for (i = 0 ; i < num_polygon ; i++)
    if (!strcmp (polygon[i]->get_name (), name)) return polygon[i];
  return NULL;
}

Polygon3D* PolygonSet::new_polygon (char* name, int max, Textures* textures, char* tex_name)
{
  return new_polygon (name, max, textures, textures->get_texture_idx (tex_name));
}

Polygon3D* PolygonSet::new_polygon (char* name, int max, Textures* textures, int texnr)
{
  Polygon3D* p = new Polygon3D (name, max, textures, texnr);
  polygon[num_polygon++] = p;
  p->set_poly_set (this);
  p->set_sector (sector);
  return p;
}

void PolygonSet::add_polygon (Polygon3D* poly)
{
  // Here we could try to include a test for the right orientation
  // of the polygon.
  polygon[num_polygon++] = poly;
  poly->set_poly_set (this);
}

Polygon3D* PolygonSet::intersect_segment (Vector3& start, Vector3& end, Vector3& isect)
{
  int i;
  for (i = 0 ; i < num_polygon ; i++)
  {
    if (polygon[i]->intersect_segment (start, end, isect)) return polygon[i];
  }
  return NULL;
}

void PolygonSet::dump ()
{
  MSG (("========================================================\n"));
  MSG (("Dump sector '%s':\n", name));
  MSG (("    num_vertices=%d max_vertices=%d num_polygon=%d max_polygon=%d\n",
	num_vertices, max_vertices, num_polygon, max_polygon));
  int i;

  MSG (("Vertices:\n"));
  for (i = 0 ; i < num_vertices ; i++)
  {
    MSG (("Vertex[%d]=", i));
    vertices[i].dump ();
    MSG (("\n"));
  }
  MSG (("Polygons:\n"));
  for (i = 0 ; i < num_polygon ; i++)
  {
    polygon[i]->dump ();
  }
}

void PolygonSet::save (FILE* fp, int indent, Textures* textures, char* setname)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%s%s '%s' (\n", sp, setname, name);
  fprintf (fp, "%s  MAX_VERTICES=%d\n", sp, max_vertices);
  fprintf (fp, "%s  MAX_POLYGON=%d\n", sp, max_polygon);
  int i;
  for (i = 0 ; i < num_vertices ; i++)
    vertices[i].save (fp, indent+2);
  for (i = 0 ; i < num_polygon ; i++)
    polygon[i]->save (fp, indent+2, textures);
}

void PolygonSet::load (World* w, char** buf, Textures* textures, char* setname)
{
  char* t;
  char* old_buf;
  int i;
  num_vertices = 0;
  num_polygon = 0;
  int default_texnr = -1;
  float default_texlen = 1;

  skip_token (buf, setname);
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a POLYGONSET!\n");

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "MAX_VERTICES"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after MAX_VERTICES!\n");
      i = get_token_int (buf);
      set_max (i, max_polygon);
    }
    else if (!strcmp (t, "MAX_POLYGON"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after MAX_POLYGON!\n");
      i = get_token_int (buf);
      set_max (max_vertices, i);
    }
    else if (!strcmp (t, "VERTEX"))
    {
      *buf = old_buf;
      vertices[num_vertices++].load (buf);
    }
    else if (!strcmp (t, "POLYGON"))
    {
      t = get_token (buf);
      Polygon3D* p = new_polygon (t, 10, textures, 0);
      *buf = old_buf;
      p->load (w, buf, textures, default_texnr, default_texlen);
    }
    else if (!strcmp (t, "TEXNR"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXNR!\n");
      t = get_token (buf);
      default_texnr = textures->get_texture_idx (t);
      if (default_texnr == -1)
      {
        printf ("Couldn't find texture named '%s'!\n", t);
      }
    }
    else if (!strcmp (t, "TEXLEN"))
    {
      skip_token (buf, "=", "Expected '%s' instead of '%s' after TEXLEN!\n");
      default_texlen = get_token_float (buf);
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
    else break;
  }
  *buf = old_buf;
}

int PolygonSet::transform_world2cam (Matrix3& m_w2c, Matrix3& m_c2w, Vector3& v_w2c)
{
  (void)m_c2w;
  int i, cnt_vis;

  cnt_vis = 0;
  for (i = 0 ; i < num_vertices ; i++)
  {
    vertices[i].world_to_camera (m_w2c, v_w2c);
    if (vertices[i].get_tz () >= SMALL_Z) cnt_vis++; 
  }

  return cnt_vis > 0;
}

Polygon3D* PolygonSet::select_polygon (Camera* c, ViewPolygon* view, int xx, int yy)
{
  int i;
  Vector2 v;
  v.x = (float)xx;
  v.y = (float)yy;

  if (transform_world2cam (c->m_world2cam, c->m_cam2world, c->v_world2cam))
  {
    for (i = 0 ; i < num_polygon ; i++)
    {
      if (polygon[i]->do_perspective (Scan::c->m_world2cam, Scan::c->m_cam2world,
				      Scan::c->v_world2cam, &Polygon2D::clipped))
      {
	if (Polygon2D::clipped.clip_poly_variant (view))
	{
	  if (v.in_poly_2d (Polygon2D::clipped.get_vertices (),
			    Polygon2D::clipped.get_num_vertices (),
			    &Polygon2D::clipped.get_bounding_box ()) == POLY_IN)
	  {
	    Sector* s = polygon[i]->get_portal ();
	    if (s)
	    {
	      ViewPolygon* new_view = Polygon2D::clipped.create_view ();
	      if (new_view)
	      {
		Polygon3D* rc = s->select_polygon (c, new_view, xx, yy);
		delete new_view;
		return rc;
	      }
	    }
	    return polygon[i];
	  }
	}
      }
    }
  }
  return NULL;
}

Vertex* PolygonSet::select_vertex (Camera* c, ViewPolygon* view, int xx, int yy)
{
  (void)c;
  int i, j;
  j = -1;
  float mindist = 1000000000.;
  float dist;
  float fx = (float)xx;
  float fy = (float)yy;

  for (i = 0 ; i < num_vertices ; i++)
  {
    float x = vertices[i].get_tx ();
    float y = vertices[i].get_ty ();
    float z = vertices[i].get_tz ();
    if (z < SMALL_Z) continue;
    Vector2 v;
    v.x = (ASPECT * x) / z + (FRAME_WIDTH/2);
    v.y = (ASPECT * y) / z + (FRAME_HEIGHT/2);
    if (v.in_poly_2d (view->get_vertices (), view->get_num_vertices (),
		      &view->get_bounding_box ()) != POLY_IN) continue;
    dist = (fx-v.x)*(fx-v.x) + (fy-v.y)*(fy-v.y);
    if (dist < mindist) { mindist = dist; j = i; }
  }
  return &vertices[j];
}

void PolygonSet::edit_draw_vertices ()
{
  int i, j;
  int col;

  for (i = 0 ; i < num_vertices ; i++)
  {
    col = -1;
    if (Scan::c->edit_mode == MODE_VERTEX) col = Scan::textures->white ();
    for (j = 0 ; j < Scan::c->num_sel_verts ; j++)
      if (Scan::c->sel_vertex[j] == &vertices[i])
      {
	col = Scan::textures->red ();
	break;
      }
    if (Scan::c->edit_mode != MODE_VERTEX && col != Scan::textures->red ()) continue;

    float x = vertices[i].get_tx ();
    float y = vertices[i].get_ty ();
    float z = vertices[i].get_tz ();
    if (z < SMALL_Z) continue;
    x = (ASPECT * x) / z + (FRAME_WIDTH/2);
    y = (ASPECT * y) / z + (FRAME_HEIGHT/2);
    int xx = QInt (x);
    int yy = QInt (y);
    Scan::g->SetPixel (xx, yy, col);
    Scan::g->SetPixel (xx-1, yy, col);
    Scan::g->SetPixel (xx+1, yy, col);
    Scan::g->SetPixel (xx-2, yy, col);
    Scan::g->SetPixel (xx+2, yy, col);
    Scan::g->SetPixel (xx, yy-1, col);
    Scan::g->SetPixel (xx, yy+1, col);
    Scan::g->SetPixel (xx, yy-2, col);
    Scan::g->SetPixel (xx, yy+2, col);
  }
}

void PolygonSet::edit_split_poly (Camera* c, Textures* textures)
{
  int pidx = 0, i, j;
  char name[50];
  Polygon3D* pnew[MAX_SEL_VERTEX];
  int idx[MAX_SEL_VERTEX];
  float x, y, z;

  Polygon3D* p = c->sel_polygon;

  for (i = 0 ; i < num_polygon ; i++)
    if (polygon[i] == p) { pidx = i; break; }

  strcpy (name, p->get_name ());
  strcat (name, "A");

  x = y = z = 0;
  for (i = 0 ; i < c->num_sel_verts ; i++)
  {
    name[strlen (name)-1] = i+'A';
    pnew[i] = new_polygon (name, p->get_max_vertices (), textures, p->get_texnr ());
    pnew[i]->set_texture_space (p);
    for (j = 0 ; j < p->get_num_vertices () ; j++)
      if (&(p->vtex (j)) == c->sel_vertex[i]) { idx[i] = j; break; }
    if (j == p->get_num_vertices ()) return; // ERROR!
    x += p->vtex (j).get_ox ();
    y += p->vtex (j).get_oy ();
    z += p->vtex (j).get_oz ();
  }
  x /= c->num_sel_verts;
  y /= c->num_sel_verts;
  z /= c->num_sel_verts;

  set_vertex (num_vertices, x, y, z);

  for (i = 0 ; i < c->num_sel_verts ; i++)
  {
    int j1;
    j = idx[i];
    j1 = idx[(i+1) % c->num_sel_verts];
    pnew[i]->add_vertex (num_vertices-1);
    while (j != j1)
    {
      pnew[i]->add_vertex (p->get_vertices_idx ()[j]);
      j = (j+1) % p->get_num_vertices ();
    }
    pnew[i]->add_vertex (p->get_vertices_idx ()[j1]);
  }

  delete p;
  polygon[pidx] = pnew[0];
  for (i = 1 ; i < c->num_sel_verts ; i++)
    polygon[num_polygon++] = pnew[i];
}

//---------------------------------------------------------------------------
