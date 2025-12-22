#ifndef OESUI_H_
#define OESUI_H_

#include "sexpr/sexp.h"

sexp_t *assoc_sexp(sexp_t*, const char *);


/* UI events */
enum {
  OESUI_UPDATE,   /* Synchronize memory spaces. */
  OESUI_REFRESH,  /* Redraw widgets */
  OESUI_MHORIZ,   /* Motion (relative) horizontal */
  OESUI_MVERT,    /* Motion (relative) vertical */
  OESUI_WHORIZ,   /* Warp (absolute) horizontal */
  OESUI_WVERT,    /* Warp (absolute) vertical */
  OESUI_OPEN,     /* First painting */
  OESUI_CLOSE,    /* closing */
  OESUI_CLICK,    /* Pointer click */
  OESUI_KEY,      /* Keypress */
  OESUI_UNKEY,    /* Keyrelease */
};


/* Property value types. */
enum {
  OESATOM_NULL,
  OESATOM_INT,
  OESATOM_FLOAT,
  OESATOM_STRING,
  OESATOM_SYMBOL,
  OESATOM_PAIR,
  OESATOM_PTR,
};


enum {
  MAGIC_HEAPED = 0x569A2937,
};


typedef struct llist_t {
  int magic;
  void *data;
  struct llist_t *next;
} llist_t;


typedef union oesui_atom_t {
  int i;
  float f;
  char *s;
  const char *sym;
  void *p;
} oesui_atom_t;

typedef struct oesui_propnode_t {
  int magic;
  int hash;
  char *key;
  int valtype;
  oesui_atom_t val;
} oesui_propnode_t;

typedef struct oesui_props_t {
  int magic;
  llist_t *list, *tail;
} oesui_props_t;

typedef struct oesui_widget_t {
  int magic;
  oesui_props_t *props;
} oesui_widget_t;


typedef struct oesui_signal_t {
  int magic;
  int len;
  oesui_atom_t msg[];
} oesui_signal_t;

#define UISIG_ARG(sig, n) ((sig)->msg[n])
#define UISIG_NAME(sig) (UISIG_ARG(sig, 0).s)


typedef struct oesui_t {
  int magic;
  SDL_Surface *screen;
  oesui_widget_t *toplevel;
  oesui_widget_t *signals;  /* signals for widgets. */
  int x, y, w, h;  /* draw boundaries? */
  int px, py, pz;  /* pointer position */
  int (*sighandler)(struct oesui_t *, oesui_signal_t *);
  int retcode;   /* communications/synchronization hack. */
} oesui_t;


typedef struct assetcache_t {
  int magic;
  int len;
  int alloc;
  oesui_propnode_t *cache;  /* array of pairs. */
} assetcache_t;


oesui_widget_t * sexp_to_widget (oesui_t *, sexp_t *);
llist_t * sexp_to_widgetlist (oesui_t *, sexp_t *);


oesui_propnode_t *oesui_propnode_init (oesui_propnode_t *, const char *key);
void oesui_propnode_delete (oesui_propnode_t *);

oesui_props_t * oeui_props_init (oesui_props_t *);
oesui_props_t * oeui_props_delete (oesui_props_t *);
oesui_propnode_t * oeui_props_get (oesui_props_t *);
oesui_props_t * oesui_props_set_int (oesui_props_t *, const char *key, int val);
oesui_props_t * oesui_props_set_float (oesui_props_t *, const char *key, float val);
oesui_props_t * oesui_props_set_string (oesui_props_t *, const char *key, const char * val);
oesui_props_t * oesui_props_set_ptr (oesui_props_t *, const char *key, void * val);
int oeui_props_get_int (oesui_props_t *, const char *key);
float oeui_props_get_float (oesui_props_t *, const char *key);
const char * oeui_props_get_string (oesui_props_t *, const char *key);
void * oeui_props_get_ptr (oesui_props_t *, const char *key);

oesui_t * oesui_init (oesui_t *);
oesui_t * oesui_init_surface (oesui_t *, SDL_Surface *sdlscreen);
void oesui_delete (oesui_t *);
int oesui_load (oesui_t *, const char *fname);
int oesui_event (oesui_t *, int evtype, int parm);
int oesui_open (oesui_t *, const char *tlname);
int oesui_loop (oesui_t *);  /* main gui loop */
int oesui_sighandle (oesui_t *, int (*sighandle)(oesui_t *, oesui_signal_t *));

#endif /* OESUI_H_ */

