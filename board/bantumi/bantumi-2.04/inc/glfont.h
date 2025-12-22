/*
    Bantumi
    Copyright 2005 - 2007 Martin Storsjö

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA

    Martin Storsjö
    martin@martin.st
*/

#ifndef __GLFONT_H
#define __GLFONT_H

#include "glwrapper.h"

class CharInfo;

class GLFont {
public:
	virtual ~GLFont() {};
	virtual void draw(const char *str, GLTYPE h, GLTYPE offX, GLTYPE offY, const GLTYPE *col) = 0;
	virtual void setClipping(int x1, int y1, int x2, int y2) {}
};

class TexGLFont : public GLFont {
public:
	TexGLFont(int offset, int n);
	~TexGLFont();

	void setImage(void *ptr, int w, int h);
	void setParams(unsigned char c, int x, int y, int w, int h, int adv, int drawX, int drawY);
	void setAllowScaling(bool allow);
	void draw(const char *str, GLTYPE h, GLTYPE offX, GLTYPE offY, const GLTYPE *color);

private:
	CharInfo *chars;
	int maxHeight;
	int offset, last;
	GLuint tex;
	int texW, texH;
	short *faces;
	GLTYPE *vertices;
	GLTYPE *texCoords;
	int bufSize;
	bool allowScaling;
};

GLFont* makeGLFont(const char *name, int size, int w, int h, unsigned char first, unsigned char last, unsigned char skipstart = 0, unsigned char skiplast = 0);

#endif
