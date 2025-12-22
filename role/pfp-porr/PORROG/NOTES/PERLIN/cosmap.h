/* ==== cosmap.h ==== */

/* They're not really cosines, but scaled translated half-cosines! */
extern int cosmap[];

/* with degscale=2,  deg 0=0, deg 1=hgtscale/2.
   with degscale=10, deg 0=0, deg 5=hgtscale/2
   with hgtscale=10, deg degscale=10. */
unsigned int calc_cos(int degscale, int hgtscale, int deg);
