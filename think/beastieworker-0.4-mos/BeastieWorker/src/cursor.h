#include "texture.h"


#ifndef __cursor_h_
#define __cursor_h_

class class_cursor
{
   private:

   class_texture *texture, *textureMask;
   bool loadTexture, loadTextureMask;

   public:

   class_cursor ();
   ~class_cursor ();
   int load (char *);
   int draw (unsigned, unsigned);
};

#endif
