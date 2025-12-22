/* ==== tri-interp.h ==== */

/* Function takes a grid, returns a bigger grid with triangularly
   interpolated points (using barycentric coordinates). */


/* We should eventually change these to take a *scale*, rather
   than assuming 10:1 */
d2byte *do_tri_interp(d2byte *orig);

