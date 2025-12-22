/* ==== genmap.c ==== */
/* Creates an 8x8 grid of random points, values of 0-63 */

#include "C-2darray.h" /* Our 2darray types */
#include <stdlib.h>

/* d2byte *randmap; */

d2byte *gen_randmap(int dims)
{
    int x,y;
    byte c;
/*    dXrng_roller *uni_die;
    dXrng_roller *dec_die; */
    d2byte *randmap;

/*  initialise_dXrng(); */
/*   uni_die=new_dX(10); dec_die=new_dX(10);  Those should end up different?*/
    randmap=create_d2byte(dims,dims);
    for (y=0;y<dims;y++)
      for (x=0;x<dims;x++)
      {
        c=(rand()%10)+10*(rand()%10);
        printf("%d ",c);
        set_d2byte(randmap,y,x,c);
      }
    /* Er, is that all */
    return randmap;
}
