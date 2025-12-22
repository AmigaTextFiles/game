#include "main.h"
#include "model3d.h"
#include "strings.h"

#ifndef __player_h_
#define __player_h_

class class_player
{
   private:

   class_model3d *player[_PLAYER_STATE_];
   unsigned int actionState;
   float angleRotate;

   public:

   class_player ();
   ~class_player ();
   int load (char *);
   float getAngle ();
   int getPlay ();
   int getPos (float *, float *, float *);
   int action (unsigned int);
   int draw ();
};

#endif
