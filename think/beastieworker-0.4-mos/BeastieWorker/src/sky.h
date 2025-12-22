#include "main.h"
#include "texture.h"

#ifndef __sky_h_
#define __sky_h_

class class_sky
{
   private:

   class_texture *texture;
   GLfloat offsetX, offsetY;

   public:

   GLint x, y, z;

   class_sky ();
   ~class_sky ();
   int load (char *);
   int draw ();
};

#endif
