/* ==== cosmap.c ==== */

#include <math.h>
#include "cosmap.h"
int cosmap[10]=
/*  0  1  2  3  4
    5  6  7  8  9 */
{   0, 0, 1, 2, 3,
    5, 7, 8, 9, 10}; /* I think... */


unsigned int calc_cos(int degscale, int hgtscale, int deg)
{
   /* degscale should be something like 10. deg <degscale.
      hgtscale would be 10 for compatibility with original,
      or 16 for a good choice. BOTH SCALES must be even numbers! */
      int psdeg;
      int reflex=degscale/2;
      int temp;
      if (0==deg) return 0;
      if (deg==reflex) return hgtscale/2;
      /* To avoid rounding problems, 2nd half is hgtscale-1st half. */
      if (deg>reflex)
      {
        psdeg=(degscale-deg);
        temp=hgtscale* (1-cos((psdeg*M_PI)/degscale)) /2;
        return hgtscale-temp;
      } else
      {
        psdeg=deg;
        temp=hgtscale* (1-cos((psdeg*M_PI)/degscale)) /2;
        return temp; /* awkward? yes! but makes sure it works. */
      }
}



