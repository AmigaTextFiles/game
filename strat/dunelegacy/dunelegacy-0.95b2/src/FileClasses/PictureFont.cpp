/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <FileClasses/PictureFont.h>

#include <stdlib.h>
#include <string.h>

extern SDL_Palette* palette;

/// Constructor
/**
	The constructor reads from the surface all data and saves them internal. Immediately after the PictureFont-Object is
	constructed pic can be freed. All data is saved in the class.
	\param	pic	The picture which contains the font
*/
PictureFont::PictureFont(SDL_Surface* pic)
{
	if(pic == NULL) {
		fprintf(stdout,"PictureFont::PictureFont(): pic == NULL!\n");
		exit(EXIT_FAILURE);
	}

	SDL_LockSurface(pic);

	CharacterHeight = pic->h - 2;

	int curXPos = 1;
	int oldXPos = curXPos;
	char* secondLine = ((char*) pic->pixels) + pic->pitch;
	for(int i = 0; i < 256; i++) {
		while((curXPos < pic->w) && (*(secondLine + curXPos) != 14)) {
			curXPos++;
		}

		if(curXPos >= pic->w) {
			fprintf(stdout,"PictureFont::PictureFont(): No valid surface for loading font!\n");
			exit(EXIT_FAILURE);
		}

		Character[i].width = curXPos - oldXPos;

		if((Character[i].data = (unsigned char*) malloc(Character[i].width * CharacterHeight)) == NULL) {
			fprintf(stdout,"PictureFont::PictureFont(): Cannot allocate memory for new character!\n");
			exit(EXIT_FAILURE);
		}

		int mempos = 0;
		for(int y = 1; y < pic->h - 1; y++) {
			for(int x = oldXPos; x < curXPos; x++) {
				unsigned char col = *(((unsigned char*) pic->pixels) + y*pic->pitch + x);
				if(col != 0) {
					col = 1;
				}

				Character[i].data[mempos] = col;
				mempos++;
			}
		}
		curXPos++;
		oldXPos = curXPos;
	}

	SDL_UnlockSurface(pic);
}

/// Destructor
/**
	Frees all memory.
*/
PictureFont::~PictureFont()
{
	for(int i = 0; i < 256; i++) {
		if(Character[i].data != NULL) {
			free(Character[i].data);
		}
	}
}




void PictureFont::DrawText(SDL_Surface* pSurface, const char* text, char BaseColor) {
	if(text == NULL) {
		return;
	}

	SDL_LockSurface(pSurface);

	int CurXPos = 0;
	const unsigned char* pText = (unsigned char*) text;
	while(*pText != '\0') {
		int index = *pText;

		//Now we can copy pixel by pixel
		for(int y = 0; y < CharacterHeight; y++) {
			for(int x = 0; x < Character[index].width; x++) {
				char color = Character[index].data[y*Character[index].width+x];
				if(color != 0) {
					*(((char*) pSurface->pixels) + y*pSurface->pitch + x + CurXPos) = BaseColor;
				}

			}
		}

		CurXPos += Character[index].width;
		pText++;
	}


	SDL_UnlockSurface(pSurface);
}

/// Returns the number of pixels a text needs
/**
		This methods returns the number of pixels this text would need if printed.
		\param	text	The text to be checked for it's length in pixel
		\return Number of pixels needed
*/
int	PictureFont::getTextWidth(const char* text) {
	if(text == NULL) {
		return 0;
	}

	int width = 0;
	const unsigned char* pText = (unsigned char*) text;
	while(*pText != '\0') {
		width += Character[*pText].width;
		pText++;
	}

	return width;
}

