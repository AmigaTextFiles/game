#include <math.h>
#include <time.h>
#include "system.h"

#ifndef DEF_H
#include "def.h"
#endif

#ifndef CONFIG_H
#include "config.h"
#endif

//---------------------------------------------------------------------------

Config::Config (char* filename)
{
  first = NULL;
  FILE* fp = fopen (filename, "r");
  if (!fp)
  {
    printf ("WARNING! Couldn't open config file '%s'. Using defaults.\n", filename);
    return;
  }
  char buf[1000];
  while (fgets (buf, 999, fp))
  {
    char* p;
    p = strchr (buf, '\n');
    if (p) *p = 0;

    p = strchr (buf, '=');
    if (!p)
    {
      printf ("Bad line in config file:\n");
      printf ("   '%s'\n", buf);
      exit (0);
    }
    *p = 0;
    add (buf, p+1);
  }
}

Config::~Config ()
{
  while (first)
  {
    ConfigEl* n = first->next;
    delete [] first->name;
    delete [] first->val;
    delete first;
    first = n;
  }
}

void Config::add (char* name, char* val)
{
  ConfigEl* n = new ConfigEl;
  n->name = new char [strlen (name)+1];
  strcpy (n->name, name);
  n->val = new char [strlen (val)+1];
  strcpy (n->val, val);
  n->next = first;
  first = n;
}

Config::ConfigEl* Config::get (char* name)
{
  ConfigEl* c = first;
  while (c)
  {
    if (!strcmp (c->name, name)) return c;
    c = c->next;
  }
  return NULL;
}

int Config::get_int (char* name, int def)
{
  ConfigEl* c = get (name);
  if (!c) return def;
  int rc;
  sscanf (c->val, "%d", &rc);
  return rc;
}

char* Config::get_str (char* name, char* def)
{
  ConfigEl* c = get (name);
  if (!c) return def;
  return c->val;
}

int Config::get_yesno (char* name, int def)
{
  ConfigEl* c = get (name);
  if (!c) return def;
  return !strcmp (c->val, "yes");
}

//---------------------------------------------------------------------------

CrystConfig::CrystConfig (char* filename) : Config (filename)
{
}

//---------------------------------------------------------------------------
