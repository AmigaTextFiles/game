/*
  Rebindable key mappings.
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <SDL/SDL_keyboard.h>
#include <SDL/SDL_keysym.h>

#include "sexpr/sexp.h"
#include "binds.h"


oeskeymap_t oeskeymap = { 0, };
sexp_t *addlkeys = NULL;



int
oeskeymap_nop (int val)
{
  return 0;
}


/* Set up binds map. */
int
oeskeymap_from_sexp (oeskeymap_t *self, sexp_t *alist)
{
  sexp_t *se, *pair;
  const char *sym, *bindname, *sc;
  oes_xlat_t *x;
  int keycode;
  float scale;
  oesbind_t binding;
//char buf[1024] = { 0, };

//printf("Keymap from sexp:\n");
//print_sexp(buf, sizeof(buf), alist);
//printf("%s\n", buf);
  if (!alist) return 0;
  alist = alist->list;
  sym = alist->val;
//printf("sym looks like '%s'\n", sym);
  if (strcasecmp(sym, "bindmap"))  /* must start with 'bindmap */
      return 0;
  se = alist->next;
  for (; se; se = se->next)
    { 
      pair = se->list;
      if (pair->ty != SEXP_VALUE)
          continue;
      sym = pair->val;
      bindname = pair->next->val;
      sc = pair->next->next ? pair->next->next->val : NULL;
      keycode = oeskeymap_resolve(sym);
//printf("BINDLINE: %s, %s, %s\n", sym, bindname, sc);
      x = oesxlat;
      binding = NULL;
      while (x->symbol)
        { 
//printf("Checking intern bindfunc '%s' to '%s'\n", x->symbol, bindname);
          if (0 == strcasecmp(x->symbol, bindname))
            {
              binding = x->binding;
              break;
            }
          x++;
        }
      scale = sc ? atof(sc) : 1.0f;
//printf("SETTING keymap[%d] = %08X x %f\n", keycode, binding, scale);
      oeskeymap_set(&oeskeymap, keycode, binding, scale);
    }
  return 1;
}

int
oeskeymap_load (oeskeymap_t *self, const char *fname)
{
  FILE *bindfile;
  sexp_iowrap_t *io;
  sexp_t *se;
  int i;

//printf("LOADING FROM BINDFILE '%s'\n", fname);
  if (!(bindfile = fopen(fname, "r")))
    {
//printf("Could not open '%s'\n", fname);
      return 0;
    }
  io = init_iowrap(fileno(bindfile));
//  se = read_one_sexp(io);
  se = NULL;
  while (!oeskeymap_from_sexp(self, se))
    {
//printf("1 SEXP FROM BINDFILE\n");
      if (se) destroy_sexp(se);
      se = read_one_sexp(io);
      if (!se) break;
    }
  destroy_iowrap(io);
  fclose(bindfile);
  return 1;
}

oeskeymap_t *
oeskeymap_init (oeskeymap_t *self)
{
  FILE *keysfile;
  sexp_iowrap_t *io;
  sexp_t *se;
  int i;

  if (!self)
    {
      self = (oeskeymap_t*)calloc(1, sizeof(*self));
      if (!self) return NULL;
    }
  for (i = 0; i < OESKEYMAPSIZE; i++)
    {
//      (*self)[i] = oeskeymap_nop;
      (*self)[i] = NULL;
    }

  if (addlkeys) return self;

  if (!(keysfile = fopen("keys.cfg", "r")))
      return 0;
  io = init_iowrap(fileno(keysfile));
  se = read_one_sexp(io);
  if (se->ty == SEXP_LIST)
      addlkeys = se;
  else
      addlkeys = NULL;
  destroy_iowrap(io);
  fclose(keysfile);

  return self;
}

int
oeskeymap_set (oeskeymap_t *self, int key, oesbind_t binding, float scale)
{
  if (key < 0) return 0;
  if (key >= OESKEYMAPSIZE) return 0;
  (*self)[key] = binding;
  return key;
}

oesbind_t
oeskeymap_get (oeskeymap_t *self, int key)
{
  if (key < 0) NULL;
  if (key >= OESKEYMAPSIZE) return NULL;
  return (*self)[key];
}

const char *
oeskeymap_lookup (int keycode)
{
  static char keyname[256];
  sexp_t *se;
  int i;
  int addlcode;

  *keyname = 0;
  if (keycode < 0)
    {
      snprintf(keyname, sizeof(keyname), "0x%04X", keycode);
      return keyname;
    }
  if (keycode < SDLK_LAST)
    {
      snprintf(keyname, sizeof(keyname), "%s", SDL_GetKeyName((SDLKey)keycode));
      return keyname;
    }
  se = addlkeys->list;
  i = 1;
  while (se)
    {
      if (keycode == (SDLK_LAST + i))
        {
          snprintf(keyname, sizeof(keyname), "%s", se->val);
          return keyname;
        }
      se = se->next;
    }
  snprintf(keyname, sizeof(keyname), "0x%04X", keycode);
  return keyname;
}

int
oeskeymap_resolve (const char *keysym)
{
  char lookup[256];
  const char *keyname;
  int i;
  int addlcode;
  sexp_t *se;

  /* Try with "SDLK_" prefix */
  snprintf(lookup, sizeof(lookup), "SDLK_%s", keysym);
//printf("oeskeymap_resolve: Looking for %s\n", lookup);
  for (i = 0; i < SDLK_LAST; i++)
    {
      keyname = SDL_GetKeyName((SDLKey)i);
//printf(" Checking '%s' against (%d)'%s'\n", lookup, i, keyname);
      if (0 == strcasecmp(lookup, keyname))
        {
          return i;
        }
    }
  /* Not found with SDLK_ prefix.  Try again without prefix. */
  snprintf(lookup, sizeof(lookup), "%s", keysym);
  for (i = 0; i < SDLK_LAST; i++)
    {
      keyname = SDL_GetKeyName((SDLKey)i);
//printf(" Checking '%s' against (%d)'%s'\n", lookup, i, keyname);
      if (0 == strcasecmp(lookup, keyname))
        {
          return i;
        }
    }
  /* Not found as SDL key.  Try additional keysyms. */
  se = addlkeys->list;
  addlcode = SDLK_LAST + 1;
  snprintf(lookup, sizeof(lookup), "%s", keysym);
  while (se)
    {
      if (se->ty == SEXP_LIST)
        {
          /* sym/code pair */
          keyname = se->list->val;
//printf(" Checking '%s' against [pair](%d)'%s'\n", lookup, i, keyname);
          if (0 == strcasecmp(lookup, keyname))
            {
              return strtol(se->list->next->val, NULL, 0);
            }
        }
      else
        {
          /* bare sym */
          keyname = se->val;
//printf(" Checking '%s' against [addl](%d)'%s'\n", lookup, addlcode, keyname);
          if (0 == strcasecmp(lookup, keyname))
            {
              return addlcode;
            }
          addlcode++;
        }
      se = se->next;
    }
  /* Not found as additional keysym either.  Interpret as integer. */
  i = strtol(keyname, NULL, 0);
  return i;
}



int
oeskeymap_test()
{
  oesbind_t x;
  oeskeymap_init(&oeskeymap);
  x = oeskeymap_get(&oeskeymap, 0);
  printf("BIND 0 = FUNC %08X\n", x);
  return 0;
}
