/* ==== ortho-interp.c ==== */

/* Function takes a grid, returns a bigger grid with orthogonally
   interpolated points. */
/* Added a cosine type smoothing */

#include "C-2darray.h"
#include "cosmap.h"


d2byte *do_ortho_interp(d2byte *orig, int scale)
{
    /* where we have scale, we used to have 10. */
    d2byte *new;
    int OX,OY,x,y,sx,sy,ix,iy,nix,niy;
    byte nw,ne,sw,se,point;

    OX=orig->Xsize; OY=orig->Ysize;
    new=create_d2byte(scale*OY,scale*OX);

    for (y=0;y<OY;y++)
      for (x=0;x<OX;x++)
      {
        nw=get_d2byte(orig,y,x);
        ne=get_d2byte(orig,y,(x+1)%OX);
        sw=get_d2byte(orig,(y+1)%OY,x);
        se=get_d2byte(orig,(y+1)%OY,(x+1)%OX);
        /* Now interpolate between those*/
        for (sy=0;sy<scale;sy++)
        {
          /* iy=cosmap[sy]; */
          iy=calc_cos(scale,16,sy); /* using hgt 16, we change the other vals*/
          niy=16-iy; /* was 10-iy*/
          for (sx=0;sx<scale;sx++)
          {
            /* ix=cosmap[sx]; */
            ix=calc_cos(scale,16,sx);
            nix=16-ix; /* was 10-ix*/
            point=( (nw*niy*nix)+(ne*niy*ix)+(sw*iy*nix)+(se*iy*ix))>>8;
            /* >>8 should be /256. */

            set_d2byte(new,sy+(scale*y),sx+(scale*x), point );
          }
        }
      }
    return new;
}


