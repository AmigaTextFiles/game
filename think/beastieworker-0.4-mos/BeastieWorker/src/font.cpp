#include <stdlib.h>
#include "font.h"

//----------------------------------------------//
class_font::class_font ()
{
   class_texture ();
}
//----------------------------------------------//
class_font::~class_font ()
{
   del ();
   glDeleteLists (base, 256);
}
//----------------------------------------------//
int class_font::load (char *input_fileName)
{
   if (loadBMP (input_fileName))
	   return _ERR_;
   float	cx;
   float	cy;
   const int const_numberChar= 16;
   const float const_ratio= 0.067f;
   base= glGenLists (256);
   glBindTexture (GL_TEXTURE_2D, texture[0]);
   for (int i= 0; i < 256; i++)
   {
      cx= (float) (i % const_numberChar) / const_numberChar;
      cy= (float) (i / const_numberChar) / const_numberChar;
      glNewList (base + i, GL_COMPILE);
      glBegin (GL_QUADS);
         glTexCoord2f (cx, 1 - cy - const_ratio);
         glVertex2i (0, 0);
         glTexCoord2f (cx + const_ratio, 1 - cy - const_ratio);
         glVertex2i (const_numberChar, 0);
         glTexCoord2f (cx + const_ratio, 1 - cy);
         glVertex2i (const_numberChar, const_numberChar);
         glTexCoord2f (cx, 1 - cy);
         glVertex2i (0, const_numberChar);
      glEnd ();
      glTranslated (10, 0, 0);
      glEndList ();
   }
   return _OK_;
}
//----------------------------------------------//
int class_font::print (GLint input_x, GLint input_y, char *input_string, GLfloat input_scaleX, GLfloat input_scaleY)
{
   glBindTexture (GL_TEXTURE_2D, texture[0]);
   glEnable (GL_BLEND);
   glDisable (GL_DEPTH_TEST);
   glBlendFunc (GL_ONE, GL_ONE);
   glMatrixMode (GL_PROJECTION);
   glPushMatrix ();
   glLoadIdentity ();
   glOrtho (0, 640, 0, 480, -1, 1);
   glMatrixMode (GL_MODELVIEW);
   glPushMatrix ();
   glLoadIdentity ();
   glTranslated (input_x, input_y, 0);
   glListBase (base);
   glScalef(input_scaleX, input_scaleY, 0.0f);
   glCallLists (strlen (input_string), GL_UNSIGNED_BYTE, input_string);
   glMatrixMode (GL_PROJECTION);
   glPopMatrix ();
   glMatrixMode (GL_MODELVIEW);
   glPopMatrix ();
   glBlendFunc (GL_ONE, GL_ZERO);
   glEnable (GL_DEPTH_TEST);
   glDisable (GL_BLEND);
   return _OK_;
}
//----------------------------------------------//
int class_font::print (GLint input_x, GLint input_y, Uint32 input_number, GLfloat input_scaleX, GLfloat input_scaleY)
{
   char str[25];
   sprintf (str, "%ld", input_number);
   print (input_x, input_y, str, input_scaleX, input_scaleY);
   return _OK_;
}
//----------------------------------------------//
int class_font::print (GLint input_x, GLint input_y, Uint32 input_number1, Uint32 input_number2, GLfloat input_scaleX, GLfloat input_scaleY)
{
   char str1[25], str2[25];
   if (input_number1 < 10)
      sprintf (str1, "0%ld:", input_number1);
   else
      sprintf (str1, "%ld:", input_number1);
   if (input_number2 < 10)
      sprintf (str2, "0%ld", input_number2);
   else
      sprintf (str2, "%ld", input_number2);
   print (input_x, input_y, strcat (str1, str2), input_scaleX, input_scaleY);
   return _OK_;
}
//----------------------------------------------//
int class_font::print (GLint input_x, GLint input_y, char *input_string, Uint32 input_number, GLfloat input_scaleX, GLfloat input_scaleY)
{
   char strs[256];
   char stri[25];
   sprintf (stri, "%ld", input_number);
   strcpy (strs, input_string);
   print (input_x, input_y, strcat (strs, stri), input_scaleX, input_scaleY);
   return _OK_;
}
//----------------------------------------------//
int class_font::print (GLint input_x, GLint input_y, Uint32 input_number, char *input_string, GLfloat input_scaleX, GLfloat input_scaleY)
{
   char strs[256];
   char stri[25];
   sprintf (stri, "%ld", input_number);
   strcpy (strs, input_string);
   print (input_x, input_y, strcat (stri, strs), input_scaleX, input_scaleY);
   return _OK_;
}
//----------------------------------------------//
int class_font::printIfOrtho (GLint input_x, GLint input_y, char *input_string, GLint input_scaleX, GLint input_scaleY)
{
   glEnable (GL_BLEND);
   glBindTexture (GL_TEXTURE_2D, texture[0]);
   glPushMatrix ();
   glBlendFunc (GL_ONE, GL_ONE);
   glTranslated (input_x, input_y, 0);
   glListBase (base);
   glScaled (input_scaleX, input_scaleY, 0);
   glCallLists (strlen (input_string), GL_UNSIGNED_BYTE, input_string);
   glBlendFunc (GL_ONE, GL_ZERO);
   glPopMatrix ();
   glDisable (GL_BLEND);
   return _OK_;
}
//----------------------------------------------//
