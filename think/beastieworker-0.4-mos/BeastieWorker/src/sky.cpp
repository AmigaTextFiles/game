#include "sky.h"

//----------------------------------------------//
class_sky::class_sky ()
{
   offsetX= 0.0f;
   offsetY= 0.0f;
   x= 1;
   y= 1;
   z= -1;
   texture= NULL;
}
//----------------------------------------------//
class_sky::~class_sky ()
{
   if (texture)
      delete texture;
}
//----------------------------------------------//
int class_sky::load (char *input_fileName)
{
   texture= new class_texture;
   if (texture->loadBMP (input_fileName))
   {
	   printf ("ERROR: file \"%s\" is not found\n", input_fileName);
	   return _ERR_;
   }

   return _OK_;
}
//----------------------------------------------//
int class_sky::draw ()
{
   if (!texture)
      return _ERR_;
   glTranslatef (0, 0, z);
   texture->use ();
   offsetX+= 0.0005;
   offsetY+= 0.0001;

   glBegin(GL_QUADS);
      glTexCoord2f (       offsetX,      - offsetY); glVertex2i (-x, -y);
      glTexCoord2f (1.0f + offsetX,      - offsetY); glVertex2i ( x, -y);
      glTexCoord2f (1.0f + offsetX, 1.0f - offsetY); glVertex2i ( x,  y);
      glTexCoord2f (       offsetX, 1.0f - offsetY); glVertex2i (-x,  y);
   glEnd();

   return _OK_;
}
//----------------------------------------------//
