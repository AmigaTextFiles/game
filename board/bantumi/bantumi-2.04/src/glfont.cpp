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

#include "glfont.h"
#include <string.h>
#include <stdio.h>

class CharInfo {
public:
	int x, y;
	int w, h;
	int adv;
	int drawX, drawY;
	unsigned char c;
};

TexGLFont::TexGLFont(int offset, int n) {
	chars = new CharInfo[n];
	memset(chars, 0, sizeof(CharInfo)*n);
	this->offset = offset;
	last = offset + n - 1;
	bufSize = 45;
	faces = new short[3*2*bufSize];
	vertices = new GLTYPE[4*2*bufSize];
	texCoords = new GLTYPE[4*2*bufSize];
	maxHeight = 0;
	tex = 0;
	allowScaling = true;
}

TexGLFont::~TexGLFont() {
	delete [] chars;
	delete [] faces;
	delete [] vertices;
	delete [] texCoords;
	if (tex != 0)
		glDeleteTextures(1, &tex);
}

void TexGLFont::setAllowScaling(bool allow) {
	allowScaling = allow;
}

void TexGLFont::setImage(void *ptr, int w, int h) {
	glGenTextures(1, &tex);
	glBindTexture(GL_TEXTURE_2D, tex);
	GLubyte *data = new GLubyte[w*h];
	for (int i = 0; i < w*h; i++)
		data[i] = ((GLubyte*)ptr)[4*i+3];
	glTexImage2D(GL_TEXTURE_2D, 0, GL_ALPHA, w, h, 0, GL_ALPHA, GL_UNSIGNED_BYTE, data);
	delete [] data;
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	texW = w;
	texH = h;
}

void TexGLFont::setParams(unsigned char c, int x, int y, int w, int h, int adv, int drawX, int drawY) {
	CharInfo *ci = &chars[c - offset];
	ci->x = x;
	ci->y = y;
	ci->w = w;
	ci->h = h;
	ci->adv = adv;
	ci->drawX = drawX;
	ci->drawY = drawY;
	ci->c = c;
//	if (drawY + h > maxHeight)
//		maxHeight = drawY + h;
	if (c == '0' || c == 'A')
		maxHeight = h;
}

void TexGLFont::draw(const char *str, GLTYPE height, GLTYPE offX, GLTYPE offY, const GLTYPE *color) {
	if (tex == 0) return;
	int face = 0;
	int vert = 0;
	int n = 0;
	int x = 0;
	int iw = 0;
	int len = strlen(str);
	for (int i = 0; i < len-1; i++)
		iw += chars[(str[i]&0xFF) - offset].adv;
	iw += chars[(str[len-1]&0xFF) - offset].w;

	GLTYPE scale = height/maxHeight;
	GLTYPE fw = iw*scale;
	GLTYPE addOffX = -fw/2;
	GLTYPE addOffY = -height/2;

	glBindTexture(GL_TEXTURE_2D, tex);
	if (!allowScaling || (F(maxHeight) >= MUL(height, F(0.85)) && F(maxHeight) <= MUL(height, F(1.5)))) {
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
		addOffX = F(int(-iw/2));
		addOffY = F(int(-maxHeight/2));
		scale = F(1);
	} else {
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	}
	glColor4v(color);

	offX += addOffX;
	offY += addOffY;

	const char *ptr = str;
	while (n < bufSize && *ptr != '\0') {
		faces[face+0] = vert+0;
		faces[face+1] = vert+1;
		faces[face+2] = vert+3;
		faces[face+3] = vert+1;
		faces[face+4] = vert+2;
		faces[face+5] = vert+3;
		CharInfo *ci = &chars[(*ptr&0xFF) - offset];
		vertices[2*(vert+0)+0] = offX + scale*(x + ci->drawX);
		vertices[2*(vert+0)+1] = offY + scale*(ci->drawY);
		vertices[2*(vert+1)+0] = offX + scale*(x + ci->drawX + ci->w);
		vertices[2*(vert+1)+1] = offY + scale*(ci->drawY);
		vertices[2*(vert+2)+0] = offX + scale*(x + ci->drawX + ci->w);
		vertices[2*(vert+2)+1] = offY + scale*(ci->drawY + ci->h);
		vertices[2*(vert+3)+0] = offX + scale*(x + ci->drawX);
		vertices[2*(vert+3)+1] = offY + scale*(ci->drawY + ci->h);
		texCoords[2*(vert+0)+0] = F(ci->x)/texW;
		texCoords[2*(vert+0)+1] = F(ci->y + ci->h)/texH;
		texCoords[2*(vert+1)+0] = F(ci->x + ci->w)/texW;
		texCoords[2*(vert+1)+1] = F(ci->y + ci->h)/texH;
		texCoords[2*(vert+2)+0] = F(ci->x + ci->w)/texW;
		texCoords[2*(vert+2)+1] = F(ci->y)/texH;
		texCoords[2*(vert+3)+0] = F(ci->x)/texW;
		texCoords[2*(vert+3)+1] = F(ci->y)/texH;
		x += ci->adv;
		face += 6;
		vert += 4;
		n++;
		ptr++;
	}
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_NORMAL_ARRAY);
	glDisableClientState(GL_COLOR_ARRAY);
	glDisable(GL_LIGHTING);
	glEnable(GL_TEXTURE_2D);
	glBindTexture(GL_TEXTURE_2D, tex);
	glEnable(GL_BLEND);
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

	glVertexPointer(2, GLTYPETOKEN, 0, vertices);
	glTexCoordPointer(2, GLTYPETOKEN, 0, texCoords);
	glDrawElements(GL_TRIANGLES, face, GL_UNSIGNED_SHORT, faces);

	glDisable(GL_TEXTURE_2D);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glEnableClientState(GL_NORMAL_ARRAY);
	glEnable(GL_LIGHTING);
	glDisable(GL_BLEND);
}



