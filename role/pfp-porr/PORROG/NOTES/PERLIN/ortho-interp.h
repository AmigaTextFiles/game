/* ==== ortho-interp.h ==== */

/* Function takes a grid, returns a bigger grid with orthogonally
   interpolated points. */


/* scale was added to describe the magnification/wavelength. */
d2byte *do_ortho_interp(d2byte *orig,int scale);
