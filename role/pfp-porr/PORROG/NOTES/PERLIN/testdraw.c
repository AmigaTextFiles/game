/* ==== testdraw.c ==== */

#include "C-2darray.h"
#include "genmap.h"
#include "drawmap.h"
#include "ortho-interp.h"

int main()
{
   d2byte *randmap;
   d2byte *orthmap;
   d2byte *trimap;
   randmap=gen_randmap(64);
/*   drawmap(randmap); */
   orthmap=do_ortho_interp(randmap,4);
   drawmap(orthmap);
   free_d2byte(randmap);
}
