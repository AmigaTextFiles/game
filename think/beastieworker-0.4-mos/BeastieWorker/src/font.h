#include "main.h"
#include "texture.h"

#define _FONT_WIDTH_  11
#define _FONT_HEIGHT_ 15

#ifndef __font_h_
#define __font_h_

class class_font : private class_texture
{
	private:
	GLuint base;

	public:

	class_font ();
	~class_font ();
	int load (char *);
	int print (GLint, GLint, char *, GLfloat = 1.0f, GLfloat = 1.0f);
	int print (GLint, GLint, Uint32, GLfloat = 1.0f, GLfloat = 1.0f);
   int print (GLint, GLint, Uint32, Uint32, GLfloat = 1.0f, GLfloat = 1.0f);
	int print (GLint, GLint, char *, Uint32, GLfloat = 1.0f, GLfloat = 1.0f);
	int print (GLint, GLint, Uint32, char *, GLfloat = 1.0f, GLfloat = 1.0f);
	int printIfOrtho  (GLint, GLint, char *, GLint = 1, GLint = 1);
};

#endif
