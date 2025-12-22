/* ==== coords.c ==== */

/* stuff for converting from barycentric to cartesian (easy) and
   cartesian to barycentric (not easy this way) coordinates */

#include "coords.h"


carte_coord_t baryc_to_cartesian(baryc_coord_t pos, enum tri_type_t type)
{
   carte_coord_t constr;
   unsigned short ax,ay, bx,by, cx,cy;
   switch (type)
   {
      case TOP_TRI: /* top triangle, A=0,0; B=10,0; C=5,5; */
       ax=0,ay=0;
       bx=2,by=0;
       cx=1,cy=1;
       break;
      case LEFT_TRI: /* left triangle, A=0,0; B=0,10; C=5,5; */
       ax=0,ay=0;
       bx=0,by=2;
       cx=1,cy=1;
       break;
      case RGHT_TRI: /* right triangle, A=10,0; B=10,10; C=5,5; */
       ax=2,ay=0;
       bx=2,by=2;
       cx=1,cy=1;
       break;
      case BOT_TRI: /* bottom triangle, A=0,10; B=10,10; C=5,5; */
       ax=0,ay=2;
       bx=2,by=2;
       cx=1,cy=1;
       break;
      default:
       printf("AARGH! No such triangle in tri-interpolate.c\n");
       exit(1);
   }
   constr.x_val=((ax*pos->coeff_a)+(bx*pos->coeff_b)+(cx*pos->coeff_c))>>34;
   constr.y_val=((ay*pos->coeff_a)+(by*pos->coeff_b)+(cy*pos->coeff_c))>>34;
   return constr;
}


