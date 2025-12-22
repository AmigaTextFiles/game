/* ==== tri-interp.c ==== */

/* Function takes a grid, returns a bigger grid with triangularly
   interpolated points (using barycentric coordinates). */

#include "coords.h" /* Yow! */
#include "C-2darray.h"

/* We should eventually change these to take a *scale*, rather
   than assuming 10:1 */

/* The interpolation function */
d2byte *do_tri_interp(d2byte *orig)
{
   d2byte *new;
   int OX,OY, x,y, sx,sy,  ix,iy,nix,niy;
   byte nw,ne,sw,se,cen, point;

   OX=orig->Xsize; OY=orig->Ysize;
   new=create_d2byte(10*OY,10*OX);

   for (y=0;y<OY;y++)
     for (x=0;x<OX;x++)
     {
       nw=get_d2byte(orig,y,x);
       ne=get_d2byte(orig,y,(x+1)%OX);
       sw=get_d2byte(orig,(y+1)%OY,x);
       se=get_d2byte(orig,(y+1)%OY,(x+1)%OX);
       /* Average of these for central point */
       cen=(nw+ne+sw+se)/4;
       /* Now find all the other points, and get their barycentric
          coords. */
       for (sy=0;sy<10;sy++)
       {
         iy=sy; /* iy=cosmap[sy];*/
         niy=10-iy;
         for (sx=0;sx<10;sx++)
         {
           ix=sx; /* ix=cosmap[sx];*/
           nix=10-ix;
           if (5==sx==sy) point=cen;
           elseif (0==sx&& 0==sy) point=nw;
           elseif (sx<5)
           {
              /* is either left tri, or top or bottom.*/

     /* NO: First do sy 0 -> 4, sx 0 -> 4. Then sy=5, sx=0->4.
        Then sy=6->9 sx=0->4. Then sx=5, sy=0->4, then sx=5, sy=5,
        then sx=5, sy=6->9.
        Then sy=0->4, sx=6->9,  sy=5, sx=6->9. Then sy=6->9, sx=6->9. */


