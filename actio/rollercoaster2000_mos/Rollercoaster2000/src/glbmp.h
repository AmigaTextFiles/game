/*
 *	RollerCoaster2000
 *	Copyright (C) 2003 Plusplus (plusplus@free.fr)
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; either version 2 of the License, or
 *	(at your option) any later version.
 *
 *	This program is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with this program; if not, write to the Free Software
 *	Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

#ifndef __CGLBMP__
#define __CGLBMP__

#ifdef _WIN32
#include <windows.h>
#endif

#include <GL/gl.h>

#ifndef _WIN32
/*
 * the following definitions replaces windows headers definition
 * for BMP manipulation
 */
#define BI_RGB 0
#define BI_BITFIELDS 3

#ifndef __MORPHOS__
typedef unsigned char UBYTE;
typedef unsigned short UWORD;
#endif
typedef unsigned long USLONG;
typedef long SLONG;

typedef struct
{
	UBYTE rgbBlue;
	UBYTE rgbGreen;
	UBYTE rgbRed;
	UBYTE rgbReserved;
} RGBQUAD;

typedef struct
{
	UBYTE rgbtBlue;
	UBYTE rgbtGreen;
	UBYTE rgbtRed;
} RGBTRIPLE;

typedef struct
{
	UWORD bfType __attribute__((packed));
	USLONG bfSize __attribute__((packed));
	UWORD bfReserved1 __attribute__((packed));
	UWORD bfReserved2 __attribute__((packed));
	USLONG bfOffBits __attribute__((packed));
} BITMAPFILEHEADER;

typedef struct
{
	USLONG biSize __attribute__((packed));
	SLONG biWidth __attribute__((packed));
	SLONG biHeight __attribute__((packed));
	UWORD biPlanes __attribute__((packed));
	UWORD biBitCount __attribute__((packed));
	USLONG biCompression __attribute__((packed));
	USLONG biSizeImage __attribute__((packed));
	SLONG biXPelsPerMeter __attribute__((packed));
	SLONG biYPelsPerMeter __attribute__((packed));
	USLONG biClrUsed __attribute__((packed));
	USLONG biClrImportant __attribute__((packed));
} BITMAPINFOHEADER;

typedef struct
{
	USLONG bcSize;
	UWORD bcWidth;
	UWORD bcHeight;
	UWORD bcPlanes;
	UWORD bcBitCount;
} BITMAPCOREHEADER;

#endif /* #ifndef _WIN32 */

typedef struct
{
	UBYTE red;
	UBYTE green;
	UBYTE blue;
} GLRGBTRIPLE;

typedef struct
{
	UBYTE red;
	UBYTE green;
	UBYTE blue;
	UBYTE alpha;
} GLRGBQUAD;

typedef struct
{
	UBYTE tfType;
	UBYTE tfColorMapType;
	UBYTE tfImageType;
	UBYTE tfColorMapSpec[5];
	UBYTE tfOrigX[2];
	UBYTE tfOrigY[2];
	UBYTE tfWidth[2];
	UBYTE tfHeight[2];
	UBYTE tfBpp;
	UBYTE tfImageDes;
} TGAHEADER;


typedef struct
{
	GLuint texID;
	int width;
	int height;
	int colorDepth;

	GLRGBQUAD *pData;
	RGBQUAD colors[256];

	USLONG redMask;
	USLONG greenMask;
	USLONG blueMask;

	GLint texWrapS;
	GLint texWrapT;
	GLint minFilter;
	GLint magFilter;

	int imageSize;
} glBmpImage;


void glBmpInit(glBmpImage* img);

int glBmpLoadImage(glBmpImage* img, char szFileName[]);
//    bool SaveImage(char szFileName[]);

int glBmpSaveScreen(glBmpImage* img);

int glBmpInvert(glBmpImage* img);
int glBmpFlipVert(glBmpImage* img);
int glBmpFlipHorz(glBmpImage* img);
int glBmpRotate180(glBmpImage* img);

void glBmpGenTexture(glBmpImage* img);
void glBmpGenTextureMipMap(glBmpImage* img);
void glBmpSetTextureWrap(glBmpImage* img, GLint s, GLint y);
void glBmpSetFilter(glBmpImage* img, GLint min, GLint mag);
void glBmpBind(glBmpImage* img);

int glBmpGetWidth(glBmpImage* img);
int glBmpGetHeight(glBmpImage* img);
int glBmpGetColorDepth(glBmpImage* img);

int glBmpLoadBMP(glBmpImage* img, char *filename);
int glBmpLoadTGA(glBmpImage* img, char *filename);

int glBmpMemLoadBMP(glBmpImage* img, char *filePtr);
int glBmpMemLoadTGA(glBmpImage* img, char *filePtr);

int glBmpSaveBMP(glBmpImage* img, char *filename);
int glBmpSaveTGA(glBmpImage* img, char *filename);

int glBmpSaveGLBuffer(glBmpImage* img, char szFileName[]);

#endif /* #ifndef __CGLBMP__ */
