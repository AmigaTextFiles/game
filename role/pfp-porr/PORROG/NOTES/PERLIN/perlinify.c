/* ==== perlinify.c ==== */

#include "C-2darray.h"
#include "genmap.h"
#include "drawmap.h"
#include "ortho-interp.h"

int main()
{
    int x,y;
    byte val;
    d2byte *randmap; /* gets recycled */
    d2byte *scale1,*scale2;
    d2byte *scale3,*scale4;
    d2byte *perlin;
    randmap=gen_randmap(16);
    scale1=do_ortho_interp(randmap,16);
    free_d2byte(randmap);

    randmap=gen_randmap(32);
    scale2=do_ortho_interp(randmap,8);
    free_d2byte(randmap);

    randmap=gen_randmap(64);
    scale3=do_ortho_interp(randmap,4);
    free_d2byte(randmap);

    randmap=gen_randmap(128);
    scale4=do_ortho_interp(randmap,2);
    free_d2byte(randmap);

    perlin=create_d2byte(scale4->Xsize, scale4->Ysize);

    for (y=0;y<scale4->Ysize;y++)
      for (x=0;x<scale4->Xsize;x++)
      {
          val=(get_d2byte(scale1,y,x))+(get_d2byte(scale2,y,x)/2)+(get_d2byte(scale3,y,x)/4)+(get_d2byte(scale4,y,x)/8) +11;
          set_d2byte(perlin,y,x,val/2);

      }
    drawmap(perlin);
}

