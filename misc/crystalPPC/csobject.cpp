#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef CSOBJECT_H
#include "csobject.h"
#endif

#ifndef THING_H
#include "thing.h"
#endif

#ifndef TOKEN_H
#include "token.h"
#endif

#ifndef WORLD_H
#include "world.h"
#endif

//---------------------------------------------------------------------------

CsObject::CsObject (char* name, int type)
{
  strcpy (CsObject::name, name);
  CsObject::type = type;
}

CsObject::~CsObject ()
{
}

void CsObject::new_activate_trigger (Script* script, CsObject* ob)
{
  activate_triggers.add_trigger (script, ob);
}

void CsObject::do_activate_triggers (World* w)
{
  activate_triggers.perform (w, this);
}

//---------------------------------------------------------------------------

Collection::Collection (char* name) : CsObject (name, CS_COLLECTION)
{
  objects = NULL;
  num_objects = 0;
}

Collection::~Collection ()
{
  if (objects) delete [] objects;
}

CsObject* Collection::find_object (char* name)
{
  int i;
  for (i = 0 ; i < num_objects ; i++)
  {
    if (!strcmp (objects[i]->get_name (), name)) return objects[i];
  }
  return NULL;
}

void Collection::transform ()
{
  int i;
  for (i = 0 ; i < num_objects ; i++)
  {
    if (objects[i]->get_type () == CS_THING)
      ((Thing*)(objects[i]))->transform ();
  }
}

void Collection::set_move (Sector* home, float x, float y, float z)
{
  int i;
  for (i = 0 ; i < num_objects ; i++)
  {
    if (objects[i]->get_type () == CS_THING)
      ((Thing*)(objects[i]))->set_move (home, x, y, z);
  }
}

void Collection::set_transform (Matrix3& matrix)
{
  int i;
  for (i = 0 ; i < num_objects ; i++)
  {
    if (objects[i]->get_type () == CS_THING)
      ((Thing*)(objects[i]))->set_transform (matrix);
  }
}

void Collection::move (float dx, float dy, float dz)
{
  int i;
  for (i = 0 ; i < num_objects ; i++)
  {
    if (objects[i]->get_type () == CS_THING)
      ((Thing*)(objects[i]))->move (dx, dy, dz);
  }
}

void Collection::transform (Matrix3& matrix)
{
  int i;
  for (i = 0 ; i < num_objects ; i++)
  {
    if (objects[i]->get_type () == CS_THING)
      ((Thing*)(objects[i]))->transform (matrix);
  }
}

void Collection::save (FILE* fp, int indent)
{
#if 0
  // @@@ Not implemented yet
#endif
}

void Collection::load (World* w, char** buf)
{
  char* t;
  char* old_buf, * old_buf_restart;
  int idx_objects;

  skip_token (buf, "COLLECTION");
  t = get_token (buf);
  strcpy (name, t);
  skip_token (buf, "(", "Expected '%s' instead of '%s' after the name of a COLLECTION!\n");

  old_buf_restart = *buf;
  num_objects = 0;

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "THING"))
    {
      get_token (buf);
      num_objects++;
    }
    else if (!strcmp (t, "COLLECTION"))
    {
      get_token (buf);
      num_objects++;
    }
    else if (!strcmp (t, "TRIGGER"))
    {
      get_token (buf);
      skip_token (buf, ",", "Expected '%s' instead of '%s' in COLLECTION/TRIGGER!\n");
      get_token (buf);
      skip_token (buf, ":", "Expected '%s' instead of '%s' in COLLECTION/TRIGGER!\n");
      get_token (buf);
    }
    else
    {
      printf ("What is '%s' doing in a COLLECTION statement?\n", t);
      exit (0);
    }
  }

  *buf = old_buf_restart;
  idx_objects = 0;
  if (objects) delete [] objects;
  objects = new CsObject* [num_objects];

  while (TRUE)
  {
    old_buf = *buf;
    t = get_token (buf);
    if (*t == ')' || *t == 0) break;
    if (!strcmp (t, "THING"))
    {
      t = get_token (buf);
      Thing* th = w->get_thing (t);
      if (!th)
      {
	printf ("Thing '%s' not found!\n", t);
	exit (0);
      }
      objects[idx_objects] = (CsObject*)th;
      idx_objects++;
    }
    else if (!strcmp (t, "COLLECTION"))
    {
      t = get_token (buf);
      Collection* th = w->get_collection (t);
      if (!th)
      {
	printf ("Collection '%s' not found!\n", t);
	exit (0);
      }
      objects[idx_objects] = (CsObject*)th;
      idx_objects++;
    }
    else if (!strcmp (t, "TRIGGER"))
    {
      CsObject* cs = NULL;
      Thing* th;
      t = get_token (buf);
      int i;
      for (i = 0 ; i < num_objects ; i++)
	if (!strcmp (objects[i]->get_name (), t))
	{
	  cs = objects[i];
	  break;
	}
      if (!cs)
      {
	printf ("Object '%s' not found!\n", t);
	exit (0);
      }

      skip_token (buf, ",", "Expected '%s' instead of '%s' in COLLECTION/TRIGGER!\n");

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
	th = (Thing*)cs;
	th->new_activate_trigger (s, this);
      }
      else
      {
	printf ("Trigger '%s' not supported or known for object '%s'!\n", t, name);
	exit (0);
      }
    }
    else
    {
      printf ("What is '%s' doing in a COLLECTION statement?\n", t);
      exit (0);
    }
  }
}


//---------------------------------------------------------------------------
