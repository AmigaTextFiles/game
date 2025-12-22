#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

#ifndef CAMERA_H
#include "camera.h"
#endif

#ifndef LIGHT_H
#include "light.h"
#endif

#ifndef POLYPLANE_H
#include "polyplan.h"
#endif

#ifndef POLYGON_H
#include "polygon.h"
#endif

#ifndef THING_H
#include "thing.h"
#endif

#ifndef CSOBJECT_H
#include "csobject.h"
#endif

#ifndef SECTOR_H
#include "sector.h"
#endif

#ifndef SCRIPT_H
#include "script.h"
#endif

#ifndef TEXTURE_H
#include "texture.h"
#endif

#ifndef SCAN_H
#include "scan.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef LIGHTMAP_H
#include "lightmap.h"
#endif

//---------------------------------------------------------------------------

extern TextureCache cache;

World::World ()
{
  first_sector = NULL;
  first_plane = NULL;
  first_script = NULL;
  first_run = NULL;
  first_collection = NULL;
}

World::~World ()
{
  clear ();
}

void World::clear ()
{
  while (first_sector)
  {
    Sector* s = (Sector*)(first_sector->get_next ());
    delete first_sector;
    first_sector = s;
  }
  while (first_plane)
  {
    PolyPlane* p = first_plane->get_next ();
    delete first_plane;
    first_plane = p;
  }
  while (first_run)
  {
    ScriptRun* r = first_run->get_next ();
    delete first_run;
    first_run = r;
  }
  while (first_script)
  {
    Script* s = first_script->get_next ();
    delete first_script;
    first_script = s;
  }
  while (first_collection)
  {
    Collection* c = first_collection->get_next ();
    delete first_collection;
    first_collection = c;
  }
  if (textures) { delete textures; textures = NULL; }
}

Textures* World::new_textures (int max)
{
  textures = new Textures (max);
  return textures;
}

Sector* World::new_sector (char* name, int max_v, int max_p)
{
  Sector* s = new Sector (name, max_v, max_p);
  s->set_next (first_sector);
  first_sector = s;
  return s;
}

Sector* World::get_sector (char* name)
{
  Sector* s = first_sector;
  while (s)
  {
    if (!strcmp (name, s->get_name ())) return s;
    s = (Sector*)(s->get_next ());
  }
  return NULL;
}

PolyPlane* World::new_plane (char* name)
{
  PolyPlane* p = new PolyPlane (name);
  p->set_next (first_plane);
  p->set_prev (NULL);
  if (first_plane) first_plane->set_prev (p);
  first_plane = p;
  return p;
}

PolyPlane* World::get_plane (char* name)
{
  PolyPlane* p = first_plane;
  while (p)
  {
    if (!strcmp (name, p->get_name ())) return p;
    p = p->get_next ();
  }
  return NULL;
}

Script* World::new_script (char* name)
{
  Script* s = new Script (name);
  s->set_next (first_script);
  first_script = s;
  return s;
}

Script* World::get_script (char* name)
{
  Script* s = first_script;
  while (s)
  {
    if (!strcmp (name, s->get_name ())) return s;
    s = s->get_next ();
  }
  return NULL;
}

Collection* World::new_collection (char* name)
{
  Collection* s = new Collection (name);
  s->set_next (first_collection);
  first_collection = s;
  return s;
}

Collection* World::get_collection (char* name)
{
  Collection* s = first_collection;
  while (s)
  {
    if (!strcmp (name, s->get_name ())) return s;
    s = s->get_next ();
  }
  return NULL;
}

Thing* World::get_thing (char* name)
{
  Sector* s = first_sector;
  while (s)
  {
    Thing* t = s->get_thing (name);
    if (t) return t;
    s = (Sector*)(s->get_next ());
  }
  return NULL;
}

ScriptRun* World::run_script (Script* s, CsObject* ps)
{
  ScriptRun* r = new ScriptRun (s, ps);
  r->set_next (first_run);
  r->set_prev (NULL);
  if (first_run) first_run->set_prev (r);
  first_run = r;
  return r;
}

void World::step_scripts ()
{
  ScriptRun* r = first_run;
  while (r)
  {
    ScriptRun* n = r->get_next ();
    if (r->step ())
    {
      // Finish run.
      if (r->get_prev ()) r->get_prev ()->set_next (r->get_next ());
      else first_run = r->get_next ();
      if (r->get_next ()) r->get_next ()->set_prev (r->get_prev ());
      delete r;
    }
    r = n;
  }
}

void World::trigger_activate (Camera& c)
{
  Vector3 where;
  c.get_forward_position (3, where);
  Polygon3D* p = c.get_hit (where);
  where.dump ("where");
  if (p)
  {
    printf ("Activate polygon '%s' ", p->get_name ());
    PolygonSet* ob = p->get_poly_set ();
    printf ("in set '%s'\n", ob->get_name ());
    ob->do_activate_triggers (this);
  }
}

void World::save (FILE* fp, int indent)
{
  char sp[100]; strcpy (sp, spaces); sp[indent] = 0;
  fprintf (fp, "%sWORLD (\n", sp);
  textures->save (fp, indent+2);

  PolyPlane* p = first_plane;
  while (p)
  {
    p->save (fp, indent+2);
    p = p->get_next ();
  }

  Script* sc = first_script;
  while (sc)
  {
    sc->save (fp, indent+2);
    sc = sc->get_next ();
  }

  Sector* s = first_sector;
  while (s)
  {
    s->save (fp, indent+2, textures);
    s = (Sector*)(s->get_next ());
  }

  Collection* c = first_collection;
  while (c)
  {
    c->save (fp, indent+2);
    c = c->get_next ();
  }

  fprintf (fp, "%s)\n", sp);
}

void World::load (char** buf)
{
  char* t;
  char* old_buf;

  clear ();

  skip_token (buf, "WORLD");
  skip_token (buf, "(", "Expected '%s' instead of '%s' after WORLD!\n");
  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "SECTOR"))
    {
      t = get_token (buf);
      Sector* s = get_sector (t);
      if (!s) s = new_sector (t, 10, 10);
      *buf = old_buf;
      s->load (this, buf, textures);
    }
    else if (!strcmp (t, "PLANE"))
    {
      t = get_token (buf);
      PolyPlane* p = new_plane (t);
      *buf = old_buf;
      p->load (buf);
    }
    else if (!strcmp (t, "SCRIPT"))
    {
      t = get_token (buf);
      Script* s = new_script (t);
      *buf = old_buf;
      s->load (buf);
    }
    else if (!strcmp (t, "COLLECTION"))
    {
      t = get_token (buf);
      Collection* c = new_collection (t);
      *buf = old_buf;
      c->load (this, buf);
    }
    else if (!strcmp (t, "TEXTURES"))
    {
      *buf = old_buf;
      if (textures) delete textures;
      textures = new Textures (50);
      textures->load (buf);
      Filter::init_filters (textures);
    }
    else if (!strcmp (t, "ROOM"))
    {
      // Not an object but it is translated to a special sector.
      t = get_token (buf);
      Sector* s = get_sector (t);
      if (!s) s = new_sector (t, 100, 50);
      *buf = old_buf;
      s->load_room (this, buf, textures);
    }
    else
    {
      printf ("What is '%s' doing in a WORLD statement?\n", t);
    }
  }

  cache.clear ();
  shine_lights ();
  mipmap_settings (LightMap::setting);
}

void World::shine_lights ()
{
  Sector* s = first_sector;
  while (s)
  {
    s->shine_lights ();
    s = (Sector*)(s->get_next ());
  }
}

void World::mipmap_settings (int setting)
{
  Sector* s = first_sector;
  while (s)
  {
    s->mipmap_settings (setting);
    s = (Sector*)(s->get_next ());
  }
}

void World::save (char* file)
{
  FILE* fp = fopen (file, "w");
  save (fp, 0);
  fclose (fp);
}

void World::load (char* file)
{
  FILE* fp = fopen (file, "rb");
  fseek (fp, 0, SEEK_END);
  long off = ftell (fp);
  fseek (fp, 0, SEEK_SET);
  char* buf = new char [off];
  char* b = buf;
  fread (b, 1, off, fp);

  load (&b);

  delete[] buf;

  fclose (fp);
}

void World::draw (Graphics* g, Camera* c, ViewPolygon* view)
{
  Scan::g = g;
  Scan::c = c;
  Scan::textures = textures;

  if (!Scan::z_buffer)
  {
    Scan::z_buffer = new unsigned long [FRAME_WIDTH*FRAME_HEIGHT];
    // @@@ This is never freed!!!
  }
  //@@@ WE SHOULD USE A WAY SO THAT WE DON'T NEED TO CLEAR THIS BUFFER.
  // -> IF WE DO A Z-FILL OF EVERYTHING WHILE DRAWING THE SECTORS THIS
  // STEP IS NOT NEEDED ANYMORE!
  memset (Scan::z_buffer, 0, sizeof (unsigned long)*FRAME_WIDTH*FRAME_HEIGHT);

  c->sector->draw (view, Scan::c->m_world2cam, Scan::c->m_cam2world, Scan::c->v_viewpos);
}

Polygon3D* World::select_polygon (Camera* c, ViewPolygon* view, int xx, int yy)
{
  yy = FRAME_HEIGHT-yy;
  return c->sector->select_polygon (c, view, xx, yy);
}

Vertex* World::select_vertex (Camera* c, ViewPolygon* view, int xx, int yy)
{
  yy = FRAME_HEIGHT-yy;
  return c->sector->select_vertex (c, view, xx, yy);
}

void World::edit_split_poly (Camera* c)
{
  if (!c->sel_polygon)
  {
    printf ("Please select a polygon!\n");
    return;
  }
  if (c->num_sel_verts < 3)
  {
    printf ("Please select at least three vertices adjacent to the polygon!\n");
    return;
  }

  PolygonSet* pset = c->sel_polygon->get_poly_set ();
  pset->edit_split_poly (c, textures);
}

//---------------------------------------------------------------------------
