/*
  Rebindable key mappings.
*/

#include "sexpr/sexp.h"

typedef int (*oesbind_t)(int val);  /* OES game bind type - function pointer to a function that takes one integer parameter. */

#define OESKEYMAPSIZE 512
typedef oesbind_t oeskeymap_t[OESKEYMAPSIZE];

/* game binding names (from config file) */
struct oes_xlat_t {
  const char *symbol;
  oesbind_t binding;
};

typedef struct oes_xlat_t  oes_xlat_t;



oeskeymap_t *oeskeymap_init (oeskeymap_t *);
int oeskeymap_set (oeskeymap_t *, int, oesbind_t, float scale);
oesbind_t oeskeymap_get (oeskeymap_t *, int);
int oeskeymap_load (oeskeymap_t *, const char *bindfile);
int oeskeymap_resolve (const char *);
const char * oeskeymap_lookup (int);


/* Globals. */
extern oeskeymap_t oeskeymap;  /* keymap.  function binding to key. */
extern oes_xlat_t oesxlat[]; /* translate function name to function pointer. */
