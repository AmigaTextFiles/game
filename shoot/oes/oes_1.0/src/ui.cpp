/*
  ui system
*/

#include <SDL/SDL.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

#include "config.h"
#include "snipe2d.h"
#include "sexpr/sexp.h"

#include "ui.h"


#define IS_HEAPED(obj) (obj->magic == MAGIC_HEAPED)
#define SET_HEAPED(obj) obj->magic = MAGIC_HEAPED

/* types */
typedef oesui_propnode_t asset_t;


/* globals */
extern PREFS gPrefs;
assetcache_t assetcache1;


/* prototypes */
int oesui_widget_paint (oesui_t *, oesui_widget_t *);
int oesui_widget_update (oesui_t *, oesui_widget_t *);
int oesui_widget_signal (oesui_t *, oesui_widget_t *, oesui_signal_t *);
int oesui_widget_open (oesui_t *, oesui_widget_t *);
int oesui_widget_close (oesui_t *, oesui_widget_t *);


/* functions */

int
hashify (const char *s)
{
  return 0;
}



/**********************
* Asset cache manager *
**********************/

assetcache_t *
assetcache_init (assetcache_t *self)
{
  if (!self)
    {
      self = (assetcache_t*)calloc(1, sizeof(*self));
      if (!self) return NULL;
      SET_HEAPED(self);
    }
  self->len = 1;
  self->alloc = 64;
  self->cache = (asset_t*)calloc(self->alloc, sizeof(asset_t));
  return self;
}


void
assetcache_delete (assetcache_t *self)
{
  if (self->cache) free(self->cache);
  self->cache = NULL;
  self->len = 0;
  self->alloc = 0;
  if (IS_HEAPED(self))
      free(self);
}


void *
assetcache_get (assetcache_t *self, const char *key)
{
  int i, targhash;

  targhash = hashify(key);
  for (i = 1; i < self->len; i++)
    {
      if (self->cache[i].hash != targhash) continue; /* can't possibly match. */
      if (strcmp(self->cache[i].key, key)) continue;  /* not exact match. */
      return self->cache[i].val.p;
    }
  return NULL;
}


void *
assetcache_idx (assetcache_t *self, int idx)
{
  if (idx < 0) return NULL;
  if (idx > self->len) return NULL;
  return self->cache[idx].val.p;
}


assetcache_t *
assetcache_register (assetcache_t *self, const char *key, void *obj)
{
  if (!self)
      self = assetcache_init(NULL);
  if (assetcache_get(self, key))  /* Already registered. */
      return self;
  if (self->len > self->alloc)
    {
      self->alloc += 64;
      self->cache = (asset_t*)realloc(self->cache, self->alloc * sizeof(asset_t));
    }
  self->cache[self->len].key = strdup(key);
  self->cache[self->len].hash = hashify(key);
  self->cache[self->len].valtype = OESATOM_PTR; //20
  self->cache[self->len].val.p = obj;
  self->len++;
  return self;
}


/* special-case asset-manager wrapper */
SDL_Surface *
imgasset_register (const char *name)
{
  void *obj;
  SDL_Surface *img;

  obj = NULL;
  if (!(obj = assetcache_get(&assetcache1, name)))
    {
//printf("caching image '%s'\n", name);
      if ((img = oes_load_img(name)))
        {
          assetcache1.cache[assetcache1.len].hash = hashify(name);
          assetcache1.cache[assetcache1.len].key = strdup(name);
          assetcache1.cache[assetcache1.len].valtype = OESATOM_PTR; //20;
          assetcache1.cache[assetcache1.len].val.p = img;
          assetcache1.len++;
        }
    }
  else
    {
//printf("Image '%s' already cached\n", name);
      img = (SDL_Surface*)obj;
    }
  return img;
}





/**********************
* Properties... list? *
**********************/

oesui_propnode_t *
oesui_propnode_init (oesui_propnode_t *self, const char *key)
{
  int n;
  if (!self)
    {
      self = (oesui_propnode_t*)calloc(1, sizeof(*self));
      if (!self) return NULL;
      SET_HEAPED(self);
    }
  self->hash = hashify(key);
//  self->key = strdup(key);
  n = strlen(key) + 1;
  if (self->key)
    {
      free(self->key);
      self->key = NULL;
    }
  self->key = (char*)malloc(n);
  strcpy(self->key, key);
  return self;
}

void
oesui_propnode_delete (oesui_propnode_t *self)
{
  if (self->key)
    {
      free(self->key);
      self->key = 0;
    }
  switch (self->valtype)
    {
      case OESATOM_INT:
        self->val.i = 0;
        break;
      case OESATOM_FLOAT:
        self->val.f = 0;
        break;
      case OESATOM_SYMBOL:
        self->val.sym = NULL;
        break;
      case OESATOM_STRING:
        free(self->val.s);
        self->val.s = NULL;
        break;
      case OESATOM_PTR:
        self->val.p = NULL;
        break;
    }
  if (IS_HEAPED(self))
      free(self);
}




oesui_props_t *
oesui_props_init (oesui_props_t *self)
{
  if (!self)
    {
      self = (oesui_props_t*)calloc(1, sizeof(oesui_props_t));
      if (!self) return NULL;
      SET_HEAPED(self);
    }
//  memset(self, 0, sizeof(*self));
  self->list = NULL;
  self->tail = NULL;
  return self;
}


void
oesui_props_delete (oesui_props_t *self)
{
  llist_t *iter, *next;

  for (iter = self->list; iter; iter = iter->next)
    {
      next = iter->next;
      oesui_propnode_delete((oesui_propnode_t*)(iter->data));
      iter->data = NULL;
      free(iter);
    }
  if (IS_HEAPED(self))
      free(self);
}


oesui_propnode_t *
oesui_props_get (oesui_props_t *self, const char *key)
{
  oesui_propnode_t *temp;
  llist_t *iter;
  int targhash;

  if (!self) return NULL;
  targhash = hashify(key);
  for (iter = self->list; iter; iter = iter->next)
    {
      temp = (oesui_propnode_t*)(iter->data);
      if (targhash != temp->hash)
          continue;  /* can't possibly match */
      if (strcasecmp(temp->key, key))
          continue;  /* not exact match */
      return temp;
    }
  return NULL;
}


oesui_props_t *
oesui_props_append (oesui_props_t *self, oesui_propnode_t *node)
{
  if (!self)
      self = (oesui_props_t*)calloc(1, sizeof(*self));
  if (!self->list)
    {
      self->list = (llist_t*)malloc(sizeof(llist_t));
      self->list->data = node;
      self->list->next = NULL;
      self->tail = self->list;
    }
  else
    {
      self->tail->next = (llist_t*)malloc(sizeof(llist_t));
      self->tail->next->data = node;
      self->tail->next->next = NULL;
      self->tail = self->tail->next;
    }
  return self;
}


oesui_props_t *
oesui_props_set_int (oesui_props_t *self, const char *key, int val)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node)
    {
      node = oesui_propnode_init(NULL, key);
      if (!node) return NULL;
      self = oesui_props_append (self, node);
    }
  node->valtype = OESATOM_INT;
  node->val.i = val;
  return self;
}


oesui_props_t *
oesui_props_set_float (oesui_props_t *self, const char *key, float val)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node)
    {
      node = oesui_propnode_init(NULL, key);
      if (!node) return NULL;
      self = oesui_props_append (self, node);
    }
  node->valtype = OESATOM_FLOAT;
  node->val.f = val;
  return self;
}


oesui_props_t *
oesui_props_set_symbol (oesui_props_t *self, const char *key, const char *val)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node)
    {
      node = oesui_propnode_init(NULL, key);
      if (!node) return NULL;
      self = oesui_props_append (self, node);
    }
  node->valtype = OESATOM_SYMBOL;
  node->val.sym = val;
  return self;
}


oesui_props_t *
oesui_props_set_string (oesui_props_t *self, const char *key, char *val)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node)
    {
      node = oesui_propnode_init(NULL, key);
      if (!node) return NULL;
      self = oesui_props_append (self, node);
    }
  node->valtype = OESATOM_STRING;
  node->val.s = val;
  return self;
}


oesui_props_t *
oesui_props_set_ptr (oesui_props_t *self, const char *key, void *val)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node)
    {
      node = oesui_propnode_init(NULL, key);
      if (!node) return NULL;
      self = oesui_props_append (self, node);
    }
  node->valtype = OESATOM_PTR;
  node->val.p = val;
  return self;
}


int
oesui_props_get_int (oesui_props_t *self, const char *key)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node) return 0;
  switch (node->valtype)
    {
      case OESATOM_INT: return node->val.i; break;
      case OESATOM_FLOAT: return (int)(node->val.f); break;
      case OESATOM_SYMBOL: /* fallthrough */
      case OESATOM_STRING: return strtol(node->val.s, NULL, 0); break;
      case OESATOM_PTR: return 0; break;
    }
  return 0;
}


float
oesui_props_get_float (oesui_props_t *self, const char *key)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node) return 0;
  switch (node->valtype)
    {
      case OESATOM_INT: return (float)(node->val.i); break;
      case OESATOM_FLOAT: return node->val.f; break;
      case OESATOM_SYMBOL: /* fallthrough */
      case OESATOM_STRING: return atof(node->val.s); break;
      case OESATOM_PTR: return 0; break;
    }
  return 0;
}


const char *
oesui_props_get_symbol (oesui_props_t *self, const char *key)
{
  oesui_propnode_t *node;
  static char buf[72];

  node = oesui_props_get(self, key);
  if (!node) return 0;
  switch (node->valtype)
    {
      case OESATOM_INT:
         snprintf(buf, sizeof(buf), "%d", node->val.i); return buf; break;
      case OESATOM_FLOAT:
         snprintf(buf, sizeof(buf), "%f", node->val.f); return buf; break;
      case OESATOM_SYMBOL: return node->val.sym; break;
      case OESATOM_STRING: return node->val.s; break;
      case OESATOM_PTR: return 0; break;
    }
  return 0;
}


char *
oesui_props_get_string (oesui_props_t *self, const char *key)
{
  oesui_propnode_t *node;
//  static char buf[72];
  static char buf[1024];

  node = oesui_props_get(self, key);
  if (!node) return 0;
  switch (node->valtype)
    {
      case OESATOM_INT:
         snprintf(buf, sizeof(buf), "%d", node->val.i); return buf; break;
      case OESATOM_FLOAT:
         snprintf(buf, sizeof(buf), "%f", node->val.f); return buf; break;
      case OESATOM_SYMBOL:
         snprintf(buf, sizeof(buf), "%s", node->val.sym); return buf; break;
      case OESATOM_STRING: return node->val.s; break;
      case OESATOM_PTR: return 0; break;
    }
  return 0;
}


void *
oesui_props_get_ptr (oesui_props_t *self, const char *key)
{
  oesui_propnode_t *node;

  node = oesui_props_get(self, key);
  if (!node) return 0;
  switch (node->valtype)
    {
      case OESATOM_INT: return 0; break;
      case OESATOM_FLOAT: return 0; break;
      case OESATOM_SYMBOL: /* fallthrough */
      case OESATOM_STRING: return (void*)(node->val.s); break;
      case OESATOM_PTR: return node->val.p; break;
    }
  return 0;
}





/*****************
* Signal message *
*****************/


oesui_signal_t *
oesui_signal_init (oesui_signal_t *self, int len)
{
  int chunksize;

  if (!len)
      return NULL;
  if (!self)
    {
      chunksize = sizeof(*self) + (len * sizeof(oesui_atom_t));
      self = (oesui_signal_t*)calloc(1, chunksize);
      if (!self) return NULL;
      SET_HEAPED(self);
    }
  self->len = len;
  return self;
}


void
oesui_signal_delete (oesui_signal_t *self)
{
  free(UISIG_NAME(self));
  if (IS_HEAPED(self))
      free(self);
}





/*****************
* Widget Signals *
*****************/


oesui_widget_t *
oesui_signals_init (oesui_widget_t *self)
{
  if (!self)
    {
      self = (oesui_widget_t*)calloc(1, sizeof(*self));
      if (!self) return NULL;
      SET_HEAPED(self);
    }
//  memset(self, 0, sizeof(*self));
//  self->props = oesui_props_set_ptr(self->props, " queue ", 0);  /* pending signals */
  self->props = NULL;
  return self;
}

/* Connect widget to signal. */
int
oesui_signals_connect (oesui_widget_t *self, const char *signal, int ofs, oesui_widget_t *widget)
{
  llist_t *chain, *temp, *curr;

  chain = (llist_t*)oesui_props_get_ptr(self->props, signal);
  if (chain)
    {
      if (ofs < 0) ofs = INT_MAX;
      temp = (llist_t*)calloc(1, sizeof(*temp));
      temp->data = widget;
      temp->next = NULL;
      if (ofs == 0)
        {
          temp->next = chain;
          chain = temp;
        }
      else
        {
          curr = chain;
          while (curr->next && (ofs-- > 1))
              curr = curr->next;
          temp->next = curr->next;
          curr->next = temp;
        }
    }
  else
    { /* empty chain */
      chain = (llist_t*)calloc(1, sizeof(*chain));
      chain->data = widget;
      chain->next = NULL;
    }
  self->props = oesui_props_set_ptr(self->props, signal, chain);
  return 1;
}


/* raise signal. */
int
oesui_signals_raise (oesui_widget_t *self, int len, const char *signal, ...)
{
  llist_t *chain, *curr, *temp;
  char *signame;
  oesui_signal_t *sig;
  va_list vp;
  int i, n;

  signame = strdup(signal);
  chain = (llist_t*)oesui_props_get_ptr(self->props, " queue ");

  if (!(sig = oesui_signal_init(NULL, len)))
    {
      free(temp);
      return 0;
    }
  UISIG_NAME(sig) = signame;
  va_start(vp, signal);
  for (i = 1; i < len; i++)
    {
      n = va_arg(vp, int);
      UISIG_ARG(sig, 1).i = n;
    }
  va_end(vp);

  if (chain)
    {
//printf("appending signal '%s' (%08X)\n", signame, signame);
      curr = chain;
      while (curr->next)
          curr = curr->next;
      temp = (llist_t*)calloc(1, sizeof(*temp));
      if (!temp) return 0;
//      temp->data = signame;
      temp->data = sig;
      temp->next = curr->next;
      curr->next = temp;
    }
  else
    { /* empty chain */
//printf("inserting signal '%s' (%08X)\n", signame, signame);
      chain = (llist_t*)calloc(1, sizeof(*chain));
//      chain->data = signame;
      chain->data = sig;
      chain->next = NULL;
    }
  self->props = oesui_props_set_ptr(self->props, " queue ", chain);
  return 1;
}


/* propagate signals. */
int
oesui_signals_cycle (oesui_t *gui, oesui_widget_t *signals)
{
  char *signame;
  llist_t *queue, *nque, *chain;
  oesui_widget_t *widget;
  oesui_signal_t *sig;
  int n;

//printf("signals_cycle...\n");
  queue = (llist_t*)oesui_props_get_ptr(signals->props, " queue ");
//printf("queue => %08X\n", queue);
  if (!queue) return 0;
  nque = queue->next;
  signals->props = oesui_props_set_ptr(signals->props, " queue ", nque);
//printf("next in queue = %08X\n", nque);
//  signame = (char*)(queue->data);
  sig = (oesui_signal_t*)(queue->data);
  signame = UISIG_NAME(sig);
//printf("signame => (%08X) %s\n", signame, signame);
  if (!signame) return 0;

//printf("Propagating signal '%s'\n", signame);
  chain = (llist_t*)oesui_props_get_ptr(signals->props, signame);
  n = 0;
  for(; chain; chain = chain->next)
    {
      widget = (oesui_widget_t*)(chain->data);
      if (oesui_props_get_int(widget->props, "enabled"))
          n = oesui_widget_signal(gui, widget, sig);
      if (n) break; //return 1;
    }

/* unblocked signal. */
  if (n == 0)
    {
//printf("unblocked signal '%s'\n", signame);
      n = gui->sighandler(gui, sig);
    }

//  free(signame);
  oesui_signal_delete(sig);
  free(queue);  /* Next-in-queue already saved to property */
  return n;
}





/***********************************
* Translation of data into widgets *
***********************************/


llist_t *
sexp_to_widgetlist (oesui_t *gui, sexp_t *descrlist)
{
  llist_t *wlist, *tail;
  oesui_widget_t *widget;
  sexp_t *descr;
  char buf[1024];

//print_sexp(buf, sizeof(buf), descrlist);
//printf("descrlist = %s\n", buf);
  wlist = NULL;
  for (; descrlist; descrlist = descrlist->next)
    {
      descr = descrlist->list;
      widget = sexp_to_widget(gui, descr);
//      wlist =  llist_add(wlist, widget);
      if (!wlist)
        {
          wlist = (llist_t*)calloc(1, sizeof(*wlist));
          tail = wlist;
          wlist->data = widget;
          wlist->next = NULL;
        }
      else
        {
          tail->next = (llist_t*)calloc(1, sizeof(*wlist));
          tail->next->data = widget;
          tail->next->next = NULL;
          tail = tail->next;
        }
    }
  return wlist;
}


oesui_widget_t *
sexp_to_widget (oesui_t *gui, sexp_t *descrlist)
{
  sexp_t *descr, *alist, *pair;
  llist_t *wlist;
  oesui_widget_t *widget;
  const char *key, *val;
  char buf[1024];

//print_sexp(buf, sizeof(buf), descrlist);
//printf("widgetlist = %s\n", buf);
  widget = (oesui_widget_t*)calloc(1, sizeof(*widget));
  widget->props = oesui_props_set_int(widget->props, "enabled", 0);
  /* alist */
  alist = descrlist;
//print_sexp(buf, sizeof(buf), alist);
//printf("alist = %s\n", buf);
  if ((descrlist->ty == SEXP_LIST) && (descrlist->next == NULL))
      alist = descrlist->list;
  for (; alist; alist = alist->next)
    {
//print_sexp(buf, sizeof(buf), alist);
//printf("attrib pair = %s\n", buf);
      if (alist->ty != SEXP_LIST) continue;
      pair = alist->list;
      key = pair->val;
      if (0);
      else if (0 == strcasecmp(key, "connect"))
        {
          sexp_t *sigs;
          sigs = pair->next;
          for (sigs = pair->next; sigs; sigs = sigs->next)
            {
              val = sigs->val;
//printf("will connect to signal '%s'\n", val);
              oesui_signals_connect(gui->signals, val, -1, widget);
            }
//          widget->props = oesui_props_set_ptr(widget->props, "connect", sigs);
        }
      else if (0 == strcasecmp(key, "container"))
        {
//printf("container...\n");
          wlist = sexp_to_widgetlist(gui, pair->next);
          widget->props = oesui_props_set_ptr(widget->props, key, wlist);
        }
      else
        {
          /* normal key/value pair */
          val = "";
          if (pair->next)
              val = pair->next->val;
//printf("attrib %s = %s  ||  widget->props = %08X\n", key, val, widget->props);
          widget->props = oesui_props_set_string(widget->props, key, strdup(val));
        }
    }
//printf("proplist dump:\n");
#if 0
oesui_propnode_t *prop;
for (wlist = widget->props->list; wlist; wlist = wlist->next)
{
  prop = (oesui_propnode_t*)(wlist->data);
  printf(" key = %s  =>  %s\n", prop->key, prop->valtype == OESATOM_STRING ? prop->val.s : "-");
}
#endif /* 0 */
//printf("/done => %08X.%08X\n", widget, widget->props);
  return widget;
}





/*************************
* um... support/utility? *
*************************/


int
oesui_pointed (oesui_t *gui, oesui_widget_t *widget)
{
  int x0, x1, y0, y1;  /* boundary check */
  int px, py;  /* pointer location */

  x0 = oesui_props_get_int(widget->props, "x");
  x1 = x0 + oesui_props_get_int(widget->props, "w");
  y0 = oesui_props_get_int(widget->props, "y");
  y1 = y0 + oesui_props_get_int(widget->props, "h");
  px = gui->px;
  py = gui->py;
//printf("has_focus: X=%d|%d|%d  Y=%d|%d|%d\n", x0, px, x1, y0, py, y1);
  if ((x0 < px) && (px < x1) && (y0 < py) && (py < y1))
      return 1;
  return 0;
}





/*******************
* Ownerdraw widget *
*******************/


int
oesui_ownerdraw_paint (oesui_t *gui, oesui_widget_t *widget)
{
  SDL_Rect r;
  const char *objtype = 0;
  int rendertime, loadtime;
  oesui_signal_t *sig;
  char *signame;

  objtype = oesui_props_get_string(widget->props, "tag");
  if (!objtype) return 0;
  rendertime = oesui_props_get_int(widget->props, "rendertime");
  loadtime = oesui_props_get_int(gui->toplevel->props, "loadtime");
  if ((loadtime) && (rendertime >= loadtime))
      return 0;
//printf("Drawing ownertype '%s' (load @ %d, lastrender @ %d)\n", objtype, loadtime, rendertime);
  oesui_signals_raise(gui->signals, 5, objtype, r.x, r.y, r.w, r.h);
  rendertime = SDL_GetTicks();
  widget->props = oesui_props_set_int(widget->props, "rendertime", rendertime);
  return 1;
}





/***************
* Label widget *
***************/


int
oesui_label_paint (oesui_t *gui, oesui_widget_t *widget)
{
  oesui_propnode_t *prop;
  int col; /* color */
  char text[256];
  SDL_Surface *img = 0;
  SDL_Rect br;

  prop = oesui_props_get(widget->props, "text");
  if (!prop) return 0;
  *text = 0;
  switch (prop->valtype)
    {
      case OESATOM_INT:
        snprintf(text, sizeof(text), "%d", prop->val.i);
        break;
      case OESATOM_FLOAT:
        snprintf(text, sizeof(text), "%f", prop->val.i);
        break;
      case OESATOM_SYMBOL:
        snprintf(text, sizeof(text), "%s", prop->val.sym);
        break;
      case OESATOM_STRING:
        snprintf(text, sizeof(text), "%s", prop->val.s);
        break;
    }
  if (!*text)
      return 0;

  br.x = oesui_props_get_int(widget->props, "x");
  br.y = oesui_props_get_int(widget->props, "y");
  br.w = oesui_props_get_int(widget->props, "w");
  br.h = oesui_props_get_int(widget->props, "h");
  col = oesui_props_get_int(widget->props, "color");

  print(br.x, br.y, col, text);

  return 1;
}





/***************
* Image widget *
***************/


int
oesui_image_paint (oesui_t *gui, oesui_widget_t *widget)
{
  oesui_propnode_t *prop;
  const char *imgname;
  SDL_Surface *img = 0;
  SDL_Rect br;

  prop = oesui_props_get(widget->props, "image");
  if (!prop) return 0;
  switch (prop->valtype)
    {
      case OESATOM_INT:
        img = (SDL_Surface*)assetcache_idx(&assetcache1, prop->val.i);
        break;
      case OESATOM_SYMBOL:
        img = imgasset_register(prop->val.sym);
        break;
      case OESATOM_STRING:
        img = imgasset_register(prop->val.s);
        break;
      case OESATOM_PTR:
        img = (SDL_Surface*)(prop->val.p);
        break;
    }
  if (!img) return 0;
  widget->props = oesui_props_set_ptr(widget->props, "image", img);

  br.x = oesui_props_get_int(widget->props, "x");
  br.y = oesui_props_get_int(widget->props, "y");
  br.w = oesui_props_get_int(widget->props, "w");
  br.h = oesui_props_get_int(widget->props, "h");

  if (!br.w)
    {
      br.w = img->w;
      widget->props = oesui_props_set_int(widget->props, "w", img->w);
    }
  if (!br.h)
    {
      br.h = img->h;
      widget->props = oesui_props_set_int(widget->props, "h", img->h);
    }

  SDL_BlitSurface(img, NULL, gui->screen, &br);

  return 0;
}


int
oesui_image_update (oesui_t *gui, oesui_widget_t *widget)
{
  const char *objname;
  SDL_Surface *img;

//  objname = oesui_props_get_string(widget->props, "name");
//  if (!objname) return 0;
//  if (0);
  return 0;
}





/****************
* Button widget *
****************/


int
oesui_button_paint (oesui_t *gui, oesui_widget_t *widget)
{
  SDL_Rect br = { 0, };
  SDL_Surface *img = 0;
  int focus = 0;
  const char *field = 0, *imgname = 0;
  void *imgobj;
  oesui_propnode_t *prop;

//  img = gButton.fullscreen;
//  img = (SDL_Surface*)imgobj;
//  imgobj = oesui_props_get_ptr(widget->props, field);
//  imgname = oesui_props_get_string(widget->props, field);
  focus = oesui_pointed(gui, widget);
  field = focus ? "himage" : "image";
  prop = oesui_props_get(widget->props, field);
  if (!prop) return 0;
  switch (prop->valtype)
    {
      case OESATOM_INT:
        img = (SDL_Surface*)assetcache_idx(&assetcache1, prop->val.i);
        break;
      case OESATOM_SYMBOL:
        img = imgasset_register(prop->val.sym);
        break;
      case OESATOM_STRING:
        img = imgasset_register(prop->val.s);
        break;
      case OESATOM_PTR:
        img = (SDL_Surface*)(prop->val.p);
        break;
    }
  if (!img) return 0;
  widget->props = oesui_props_set_ptr(widget->props, field, img);

  br.x = oesui_props_get_int(widget->props, "x");
  br.y = oesui_props_get_int(widget->props, "y");
  br.w = oesui_props_get_int(widget->props, "w");
  br.h = oesui_props_get_int(widget->props, "h");

  if (!br.w)
    {
      br.w = img->w;
      widget->props = oesui_props_set_int(widget->props, "w", img->w);
    }
  if (!br.h)
    {
      br.h = img->h;
      widget->props = oesui_props_set_int(widget->props, "h", img->h);
    }

//printf("button at (%d, %d), %d x %d\n", br.x, br.y, br.w, br.h);

  SDL_BlitSurface(img, NULL, gui->screen, &br);

  return 1;
}


int
oesui_button_update (oesui_t *gui, oesui_widget_t *widget)
{
  const char *bname;
  int w, h;
  SDL_Surface *img = 0, *himg = 0;
  const char *imgname = 0, *himgname = 0;

//printf("Button Update\n");
  bname = oesui_props_get_string(widget->props, "name");
  if (!bname) return 0;
  if (0);
  else if (0 == strcmp(bname, "Fullscreen"))
    {
      imgname = gPrefs.fullscreen ? "fullscreen.png" : "window.png";
      himgname = gPrefs.fullscreen ? "fullscreenh.png" : "windowh.png";
    }
  else if (0 == strcmp(bname, "Audio"))
    {
      imgname = gPrefs.audio ? "audioon.png" : "audiooff.png";
      himgname = gPrefs.audio ? "audioonh.png" : "audiooffh.png";
//printf("Audio button should currently show: %d\n", gPrefs.audio);
    }
  else if (0 == strcmp(bname, "Difficulty"))
    {
      switch (gPrefs.difficulty)
        {
          case 1: imgname = "easy.png"; himgname = "easyh.png"; break;
          case 2: imgname = "medium.png"; himgname = "mediumh.png"; break;
          case 3: default: imgname = "hard.png"; himgname = "hardh.png"; break;
        }
    }
  else if (0 == strcmp(bname, "Quit"))
    {
      0;
    }
  if (imgname) img = imgasset_register(imgname);
  if (himgname) himg = imgasset_register(himgname);
  if (img) widget->props = oesui_props_set_ptr(widget->props, "image", img);
  if (himg) widget->props = oesui_props_set_ptr(widget->props, "himage", himg);
//  if (0 == oesui_props_get_int(widget->props, "w"))
//      widget->props = oesui_props_set_int(widget->props, "w", img->w);
//  if (0 == oesui_props_get_int(widget->props, "h"))
//      widget->props = oesui_props_set_int(widget->props, "h", img->h);
  
  return 0;
}


int
oesui_button_signal (oesui_t *gui, oesui_widget_t *widget, oesui_signal_t *sig)
{
  const char *spit;
  int focus;

  if (0);
  else if (0 == strcmp(UISIG_NAME(sig), "click"))
    {
//printf("button signal CLICK\n");
      if (!(oesui_pointed(gui, widget)))
          return 0;
      spit = oesui_props_get_string(widget->props, "on-click");
      if (!spit) return 0;
//      oesui_signals_raise(gui->signals, spit);
      oesui_signals_raise(gui->signals, 1, spit);
    }
  else if (0 == strcmp(UISIG_NAME(sig), "focus"))
    { 
      focus = oesui_props_get_int(widget->props, "focus");
      if (oesui_pointed(gui, widget))
        {
          /* in focus */
          if (focus == 0)
            {
              0;  /* just came into focus. */
            }
        }
      else
        {
          /* not in focus. */
          if (focus)
            {
              0;  /* just lost focus. */
            }
        }
    }
  return 0;
}





/******************
* Toplevel widget *
******************/


int
oesui_toplevel_paint (oesui_t *gui, oesui_widget_t *widget)
{
  llist_t *container;
  oesui_widget_t *child;

  container = (llist_t*)oesui_props_get_ptr(widget->props, "container");
  if (!container) return 0;
  for (; container; container = container->next)
    {
      child = (oesui_widget_t*)(container->data);
      oesui_widget_paint(gui, child);
    }
  return 0;
}


int
oesui_toplevel_update (oesui_t *gui, oesui_widget_t *widget)
{
  llist_t *container;
  oesui_widget_t *child;

  if (!widget) return 0;
  container = (llist_t*)oesui_props_get_ptr(widget->props, "container");
  for (; container; container = container->next)
    {
      child = (oesui_widget_t*)(container->data);
      oesui_widget_update(gui, child);
    }
}


int
oesui_toplevel_signal (oesui_t *gui, oesui_widget_t *widget, oesui_signal_t *sig)
{
  const char *emit;
  int focus;

  if (0);
  else if (0 == strcmp(UISIG_NAME(sig), "esc"))
    {
      emit = oesui_props_get_string(widget->props, "on-esc");
      if (!emit) return 0;
//printf("Toplevel got signal '%s', will emit '%s'\n", sig->data[0].s, emit);
//      oesui_signals_raise(gui->signals, emit);
      oesui_signals_raise(gui->signals, 1, emit);
    }
  else if (0 == strcmp(UISIG_NAME(sig), "cycle-focus"))
    {
      0;
    }
  return 0;
}


int
oesui_toplevel_open (oesui_t *gui, oesui_widget_t *widget)
{
  llist_t *container;
  oesui_widget_t *child;
  int loadtime;

  loadtime = SDL_GetTicks();
//printf("LOADED MENU '%s' at %d\n", menuname, loadtime);
  widget->props = oesui_props_set_int(widget->props, "loadtime", loadtime);
  widget->props = oesui_props_set_int(widget->props, "enabled", 1);

  container = (llist_t*)oesui_props_get_ptr(widget->props, "container");
  if (!container) return 0;
  for (; container; container = container->next)
    {
      child = (oesui_widget_t*)(container->data);
      child->props = oesui_props_set_int(child->props, "enabled", 1);
    }
  oesui_widget_update(gui, widget);
  return 0;
}


int
oesui_toplevel_close (oesui_t *gui, oesui_widget_t *widget)
{
  llist_t *container;
  oesui_widget_t *child;

  oesui_widget_update(gui, widget);
  container = (llist_t*)oesui_props_get_ptr(widget->props, "container");
  widget->props = oesui_props_set_int(widget->props, "enabled", 0);
  if (!container) return 0;
  for (; container; container = container->next)
    {
      child = (oesui_widget_t*)(container->data);
      child->props = oesui_props_set_int(child->props, "enabled", 0);
    }
  return 0;
}





/*********************************/
/* Generalized widget functions. */
/*********************************/


int
oesui_widget_paint (oesui_t *gui, oesui_widget_t *widget)
{
  const char *objtype;
  int (*paintfunc)(oesui_t *, oesui_widget_t*);

  objtype = oesui_props_get_string(widget->props, "type");
  if (!objtype) return 0;
//printf("painting objtype '%s'\n", objtype);
  paintfunc = 0;
  if (0 == strcasecmp(objtype, "toplevel"))
      paintfunc = oesui_toplevel_paint;
  else if (0 == strcasecmp(objtype, "button"))
      paintfunc = oesui_button_paint;
  else if (0 == strcasecmp(objtype, "image"))
      paintfunc = oesui_image_paint;
  else if (0 == strcasecmp(objtype, "ownerdraw"))
      paintfunc = oesui_ownerdraw_paint;
  else if (0 == strcasecmp(objtype, "label"))
      paintfunc = oesui_label_paint;
  if (paintfunc)
      return paintfunc(gui, widget);
  return 0;
}


int
oesui_widget_update (oesui_t *gui, oesui_widget_t *widget)
{
  const char *objtype;
  int (*updatefunc)(oesui_t *, oesui_widget_t *);

  if (!widget) return 0;
  objtype = oesui_props_get_string(widget->props, "type");
  if (!objtype) return 0;
  if (0 == strcasecmp(objtype, "toplevel"))
      updatefunc = oesui_toplevel_update;
  else if (0 == strcasecmp(objtype, "button"))
      updatefunc = oesui_button_update;
  if (updatefunc)
      return updatefunc(gui, widget);
  return 0;
}


int
oesui_widget_signal (oesui_t *gui, oesui_widget_t *widget, oesui_signal_t *sig)
{
  const char *objtype;
  int (*sigfunc)(oesui_t*, oesui_widget_t*, oesui_signal_t *);

  objtype = oesui_props_get_string(widget->props, "type");
//printf("widget_signal on %s\n", objtype);
  if (!objtype) return 0;
  if (0);
  else if (0 == strcasecmp(objtype, "toplevel"))
      sigfunc = oesui_toplevel_signal;
  else if (0 == strcasecmp(objtype, "button"))
      sigfunc = oesui_button_signal;
  if (sigfunc)
      return sigfunc(gui, widget, sig);
  return 0;
}


int
oesui_widget_open (oesui_t *gui, oesui_widget_t *widget)
{
  const char *objtype;
  int (*openfunc)(oesui_t *, oesui_widget_t *);

  objtype = oesui_props_get_string(widget->props, "type");
  if (!objtype) return 0;
  if (0);
  else if (0 == strcasecmp(objtype, "toplevel"))
      openfunc = oesui_toplevel_open;
  if (openfunc)
      return openfunc(gui, widget);
  return 0;
}


int
oesui_widget_close (oesui_t *gui, oesui_widget_t *widget)
{
  const char *objtype;
  int (*closefunc)(oesui_t *, oesui_widget_t *);

  objtype = oesui_props_get_string(widget->props, "type");
  if (!objtype) return 0;
  if (0);
  else if (0 == strcasecmp(objtype, "toplevel"))
      closefunc = oesui_toplevel_close;
  if (closefunc)
      return closefunc(gui, widget);
  return 0;
}





/************
* UI System *
************/


/* Inject event into UI system. */
int
oesui_event (oesui_t *self, int evtype, int parm)
{
  int px, py;  /* pointer location */
  int x0, y0, x1, y1;  /* bounary */
  const char *objtype;

objtype = oesui_props_get_string(self->toplevel->props, "type");
//printf("toplevel objtype (%08X) = %s\n", self->toplevel, objtype);

  switch (evtype)
    {
      case OESUI_UPDATE:
        oesui_widget_update(self, self->toplevel);
        break;
      case OESUI_REFRESH:
        oesui_widget_paint(self, self->toplevel);
        break;
      case OESUI_WHORIZ:
        self->px = 0;
        /* fallthrough */
      case OESUI_MHORIZ:
        self->px += parm;
        if (self->px > self->screen->w)
            self->px = self->screen->w;
        if (self->px < 0)
            self->px = 0;
//printf("Pointer @ (%d, %d)\n", self->px, self->py);
        break;
      case OESUI_WVERT:
        self->py = 0;
        /* fallthrough */
      case OESUI_MVERT:
        self->py += parm;
        if (self->py > self->screen->h)
            self->py = self->screen->h;
        if (self->py < 0)
            self->py = 0;
//printf("Pointer @ (%d, %d)\n", self->px, self->py);
        break;
      case OESUI_OPEN:
        oesui_widget_open(self, self->toplevel);
        break;
      case OESUI_CLOSE:
        oesui_widget_close(self, self->toplevel);
        break;
      case OESUI_UNKEY:
        switch (parm)
          {
            case SDLK_ESCAPE:
//              oesui_signals_raise(self->signals, "esc");
              oesui_signals_raise(self->signals, 1, "esc");
              break;
            case SDLK_TAB:
//              oesui_signals_raise(self->signals, "cycle-focus");
              oesui_signals_raise(self->signals, 1, "cycle-focus");
              break;
          }
        break;
      case OESUI_CLICK:
//        return oesui_toplevel_click(self, self->toplevel, parm);
        if (parm)
//            return oesui_signals_raise(self->signals, "click");
            return oesui_signals_raise(self->signals, 3, "click", self->px, self->py);
        break;
    }

  return 0;
}


/* Load assets specified in data file */
int
oesui_cache_assets (oesui_t *self, sexp_t *se)
{
  sexp_t *pair;
  const char *objtype;
  char *objname;
  SDL_Surface *img;

  for (; se; se = se->next)
    {
      pair = se->list;
      objtype = pair->val;
      if (0);
      else if (0 == strcasecmp(objtype, "img"))
        {
          objname = pair->next->val;
//printf("caching asset (img) '%s'\n", objname);
//          img = oes_load_img(objname);
//          assetcache_register(&assetcache1, objname, img);
          imgasset_register(objname);
        }
    }
  return 0;
}


/* Select toplevel to display */
int
oesui_open (oesui_t *self, const char *tlname)
{
///  int loadtime;
//  loadtime = SDL_GetTicks();
//  self->toplevel->props = oesui_props_set_int(self->toplevel->props, "loadtime", loadtime);

  if (self->toplevel)
      oesui_toplevel_close(self, self->toplevel);
  self->toplevel = (oesui_widget_t*)assetcache_get(&assetcache1, tlname);
  oesui_toplevel_open(self, self->toplevel);
//printf("LOADED MENU '%s' at %d\n", tlname, oesui_props_get_int(self->toplevel->props, "loadtime"));
  return 0;
}


/* Load UI info from file. */
int
oesui_load (oesui_t *self, const char *fname)
{
  FILE *guifile;
  sexp_iowrap_t *io;
  sexp_t *se;
  const char *objtype;
  oesui_widget_t *widget;

  if (!(guifile = fopen("menus.cfg", "r")))
      return 0;
  io = init_iowrap(fileno(guifile));
//  self->toplevel = read_one_sexp(io);
  while ((se = read_one_sexp(io)))
    {
      if (se->ty == SEXP_LIST)
        {
          if (hd_sexp(se)->ty == SEXP_VALUE)
            {
              objtype = se->list->val;
              if (0);
              else if (0 == strcasecmp(objtype, "assets"))
                  oesui_cache_assets(self, se->list->next);
            }
          else
            {
              /* toplevel description. */
              widget = sexp_to_widget(self, se);
              objtype = oesui_props_get_string(widget->props, "name");
//printf("done widget '%s'\n", objtype);
              assetcache_register(&assetcache1, objtype, widget);
              oesui_widget_update(self, widget);
            }
        }
//      self->toplevel = sexp_to_widget(se);
//      oesui_widget_update (self, self->toplevel);
        destroy_sexp(se);
    }
//printf("retrieving 'main'...\n");
//  self->toplevel = (oesui_widget_t*)assetcache_get(&assetcache1, "main");
//  self->toplevel = (oesui_widget_t*)assetcache_get(&assetcache1, "prefs");
//printf("gui->toplevel = %08X\n", self->toplevel);
//  oesui_widget_update(self, self->toplevel);
  destroy_iowrap(io);
  fclose(guifile);
  return 1;
}


oesui_t *
oesui_init (oesui_t *self)
{
  if (!self)
    {
      self = (oesui_t*)calloc(1, sizeof(oesui_t));
      if (!self) return NULL;
      SET_HEAPED(self);
    }
//  memset(self, 0, sizeof(*self));

  self->screen = NULL;
  self->toplevel = NULL;
  self->sighandler = NULL;

  self->x = 0;
  self->y = 0;
//  self->w = self->screen->w;  /* redundant? */
//  self->h = self->screen->h;
  self->px = self->w / 2;
  self->py = self->h / 2;
  self->pz = 0;
  self->signals = oesui_signals_init(self->signals);
  self->retcode = 0;
  assetcache_init(&assetcache1);
  return self;
}


/* Initialize with screen. */
oesui_t *
oesui_init_surface (oesui_t *self, SDL_Surface *sdlscreen)
{
  if ((self = oesui_init(self)))
    {
      self->screen = sdlscreen;
      self->w = self->screen->w;  /* redundant? */
      self->h = self->screen->h;
    }
  return self;
}


void
oesui_delete (oesui_t *self)
{
//  destroy_sexp(gui->toplevel);
  if (IS_HEAPED(self))
      free(self);
}


/* UI loop. */
int
oesui_loop (oesui_t *self)
{
  int lastdraw = 0;
  int px, py, pz;  /* pointer (mouse) location. */
  int ticks;
  SDL_Event event;

  SDL_ShowCursor(1);
  while (!self->retcode)
    {
      ticks = SDL_GetTicks();
      if (ticks > lastdraw + 20)
        {
          oesui_event(self, OESUI_REFRESH, 1);
          SDL_Flip(self->screen);
        }
      while (SDL_PollEvent(&event))
        {
          switch (event.type)
            {
              case SDL_KEYUP:
                if (event.key.keysym.sym == SDLK_F12)  /* failsafe */
                    exit(0);
                else
                    oesui_event(self, OESUI_UNKEY, (int)(event.key.keysym.sym));
                break;
              case SDL_MOUSEMOTION:
                SDL_GetMouseState(&px, &py);
                oesui_event(self, OESUI_WHORIZ, px);
                oesui_event(self, OESUI_WVERT, py);
                break;
              case SDL_MOUSEBUTTONDOWN:
                switch (event.button.button)
                  {
                    case SDL_BUTTON_LEFT:
                      oesui_event(self, OESUI_CLICK, 1);
                      break;
                  }
              case SDL_MOUSEBUTTONUP:
                switch (event.button.button)
                  {
                    case SDL_BUTTON_LEFT:
                      oesui_event(self, OESUI_CLICK, 0);
                      break;
                  }
                break;
              case SDL_QUIT:
                exit(0);
                break;
            } //switch event.type
        } //while SDL_PollEvents
      /* Propagate pending signals. */
      oesui_signals_cycle(self, self->signals);
    } //while !self->retcode
  return self->retcode;
}


/* Set callback handler for unhandled widget signals. */
int
oesui_sighandle (oesui_t *gui, int (*sighandle)(oesui_t *, oesui_signal_t*))
{
  gui->sighandler = sighandle;
  return 0;
}
