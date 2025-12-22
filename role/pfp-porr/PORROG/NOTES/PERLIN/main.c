/* ==== main.c ==== */

#include "C-2darray.h"
#include "genmap.h"
#include "drawmap.h"
#include "ortho-interp.h"

int main()
{
   d2byte *orthmap;
   d2byte *trimap;
   d2byte *randmap;
   randmap= gen_randmap(10);
/*   drawmap(randmap); */
   printf("Interpolating.\n");
   orthmap=do_ortho_interp(randmap,36);
   printf("Drawing.\n");
   drawmap(orthmap);
}
