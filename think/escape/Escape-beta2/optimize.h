
#ifndef __OPTIMIZE_H
#define __OPTIMIZE_H
#include "level.h"

/* solution optimization. */

struct optimize {

  /* starting with a (legal) solution, try to optimize it to a shorter
     solution, and return that. Neither argument is destroyed (and the
     return will be newly allocated, even if it no different from the
     input s). */

  static solution * opt(level * l, solution * s);

};

#endif
