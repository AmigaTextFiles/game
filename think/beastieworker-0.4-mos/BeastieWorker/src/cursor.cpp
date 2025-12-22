#include "cursor.h"

char *cursorFileName=      "cursor.bmp";
char *cursorFileNameMask=  "cursorm.bmp";

//----------------------------------------------//
class_cursor::class_cursor ()
{
   texture= new class_texture;
   textureMask= new class_texture;
   loadTexture= false;
   loadTextureMask= false;
}
//----------------------------------------------//
class_cursor::~class_cursor ()
{
   if (loadTexture)
      delete texture;
   if (loadTextureMask)
      delete textureMask;
}
//----------------------------------------------//
int class_cursor::load (char *input_fileDir)
{
   int returnValues= _OK_;
   char fileName[256];
   strcpy (fileName, input_fileDir);
   strcat (fileName, cursorFileName); 
   if (!(texture->loadBMP (fileName)))
      loadTexture= true;
   else
   {
      printf ("ERROR: file \"%s\" is not found\n", fileName);
      returnValues= _ERR_;
   }
   strcpy (fileName, input_fileDir);
   strcat (fileName, cursorFileNameMask); 
   if (!(textureMask->loadBMP (fileName)))
      loadTextureMask= true;
   else
   {
      printf ("ERROR: file \"%s\" is not found\n", fileName);
      returnValues= _ERR_;
   }
   if (!returnValues)
      SDL_ShowCursor (0);
   return returnValues;
}
//----------------------------------------------//
int class_cursor::draw (unsigned input_x, unsigned input_y)
{
   if (!loadTexture || !loadTextureMask)
      return _ERR_;
   int x, y;
   SDL_GetMouseState (&x, &y);
//   glEnable (GL_COLOR_MATERIAL);
 	glEnable (GL_BLEND);
	glDisable (GL_DEPTH_TEST);
	glBlendFunc (GL_DST_COLOR, GL_ZERO);
	glMatrixMode (GL_PROJECTION);
	glPushMatrix ();
	glLoadIdentity ();
	glOrtho (0, input_x, 0, input_y, -1, 1);
	glMatrixMode (GL_MODELVIEW);
	glPushMatrix ();
	glLoadIdentity ();
	glTranslated (x, input_y - y, 0);
	glScaled (35, 35, 0);

   textureMask->use ();
   glBegin (GL_QUADS);
		glTexCoord2d (1, 0); glVertex2d (1, -1);
		glTexCoord2d (0, 0); glVertex2d (0, -1);
		glTexCoord2d (0, 1); glVertex2d (0,  0);
		glTexCoord2d (1, 1); glVertex2d (1,  0);
	glEnd ();

	glBlendFunc (GL_ONE, GL_ONE);

	texture->use ();
	glBegin (GL_QUADS);
		glTexCoord2d (1, 0); glVertex2d (1, -1);
		glTexCoord2d (0, 0); glVertex2d (0, -1);
		glTexCoord2d (0, 1); glVertex2d (0,  0);
		glTexCoord2d (1, 1); glVertex2d (1,  0);
	glEnd ();

	glMatrixMode (GL_PROJECTION);
	glPopMatrix ();
	glMatrixMode (GL_MODELVIEW);
	glPopMatrix ();
	glEnable (GL_DEPTH_TEST);
	glDisable (GL_BLEND);
 //  glDisable (GL_COLOR_MATERIAL);
   return _OK_;
}
//----------------------------------------------//
