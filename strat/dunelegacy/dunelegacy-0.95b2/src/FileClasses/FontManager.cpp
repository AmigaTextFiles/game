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

#include <FileClasses/FontManager.h>

#include <globals.h>

#include <FileClasses/FileManager.h>
#include <FileClasses/Fntfile.h>
#include <FileClasses/PictureFont.h>

FontManager::FontManager() {
	for(int i = 0; i < NUM_FONTS; i++) {
		Fonts[i] = NULL;
	}

	SDL_Surface* Font10Surface = SDL_LoadBMP_RW(pFileManager->OpenFile("Font10.bmp"),true);

	if(Font10Surface == NULL) {
		fprintf(stderr,"FontManager::FontManager(): Cannot open Font10.bmp!\n");
		exit(EXIT_FAILURE);
	}

	if((Fonts[FONT_STD10] = new PictureFont(Font10Surface)) == NULL) {
		fprintf(stderr,"FontManager::FontManager(): Cannot open Font10.bmp!\n");
		exit(EXIT_FAILURE);
	}
	SDL_FreeSurface(Font10Surface);

	SDL_Surface* Font12Surface = SDL_LoadBMP_RW(pFileManager->OpenFile("Font12.bmp"),true);
	if(Font12Surface == NULL) {
		fprintf(stderr,"FontManager::FontManager(): Cannot open Font12.bmp!\n");
		exit(EXIT_FAILURE);
	}
	if((Fonts[FONT_STD12] = new PictureFont(Font12Surface)) == NULL) {
		fprintf(stderr,"FontManager::FontManager(): Cannot open Font12.bmp!\n");
		exit(EXIT_FAILURE);
	}
	SDL_FreeSurface(Font12Surface);

	SDL_Surface* Font24Surface = SDL_LoadBMP_RW(pFileManager->OpenFile("Font24.bmp"),true);
	if(Font24Surface == NULL) {
		fprintf(stderr,"FontManager::FontManager(): Cannot open Font24.bmp!\n");
		exit(EXIT_FAILURE);
	}
	if((Fonts[FONT_STD24] = new PictureFont(Font24Surface)) == NULL) {
		fprintf(stderr,"FontManager::FontManager(): Cannot open Font24.bmp!\n");
		exit(EXIT_FAILURE);
	}
	SDL_FreeSurface(Font24Surface);

}

FontManager::~FontManager() {
	for(int i = 0; i < NUM_FONTS; i++) {
		if(Fonts[i] != NULL) {
			delete Fonts[i];
			Fonts[i] = NULL;
		}
	}
}

void FontManager::DrawText(SDL_Surface* pSurface, const char* text, unsigned char color, unsigned int FontNum) {
	if((FontNum >= NUM_FONTS) || (Fonts[FontNum] == NULL)) {
		return;
	}

	Fonts[FontNum]->DrawText(pSurface,text,color);
}

int	FontManager::getTextWidth(const char* text, unsigned int FontNum) {
	if((FontNum >= NUM_FONTS) || (Fonts[FontNum] == NULL)) {
		return 0;
	}

	return Fonts[FontNum]->getTextWidth(text);
}

int FontManager::getTextHeight(unsigned int FontNum) {
	if((FontNum >= NUM_FONTS) || (Fonts[FontNum] == NULL)) {
		return 0;
	}

	return Fonts[FontNum]->getTextHeight();
}

SDL_Surface* FontManager::createSurfaceWithText(const char* text, unsigned char color, unsigned int FontNum) {
	if((FontNum >= NUM_FONTS) || (Fonts[FontNum] == NULL)) {
		return 0;
	}

	SDL_Surface* pic;

	int width = Fonts[FontNum]->getTextWidth(text);
	int height = Fonts[FontNum]->getTextHeight();

	// create new picture surface
	if((pic = SDL_CreateRGBSurface(SDL_SWSURFACE,width,height,8,0,0,0,0))== NULL) {
		return NULL;
	}

	SDL_SetColors(pic, palette->colors, 0, palette->ncolors);
	SDL_SetColorKey(pic, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);

	Fonts[FontNum]->DrawText(pic,text,color);

	return pic;
}
