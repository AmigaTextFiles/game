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

#include <GUI/dune/DuneStyle.h>
#include <misc/draw_util.h>
#include <GUI/Widget.h>
#include <FileClasses/FontManager.h>
#include <FileClasses/DataManager.h>


#if !defined(lround)
#define lround(x) (int)(x+(x<0? -0.5 : 0.5)) 
#endif


#include <iostream>
#include <cmath>

extern SDL_Palette* palette;
extern FontManager* pFontManager;
extern DataManager* pDataManager;


SDL_Surface* DuneStyle::CreateSurfaceWithText(const char* text, unsigned char color, unsigned int fontsize) {
	if(pFontManager != NULL) {
		return pFontManager->createSurfaceWithText(text, color, fontsize);
	} else {
		SDL_Surface* surface;

		// create surfaces
		if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,strlen(text)*10,12,8,0,0,0,0))== NULL) {
			return NULL;
		}
		SDL_SetColors(surface, palette->colors, 0, palette->ncolors);

		return surface;
	}
}

unsigned int DuneStyle::GetTextHeight(unsigned int FontNum) {
	if(pFontManager != NULL) {
		return pFontManager->getTextHeight(FontNum);
	} else {
		return 12;
	}
}

unsigned int DuneStyle::GetTextWidth(const char* text, unsigned int FontNum)  {
	if(pFontManager != NULL) {
		return pFontManager->getTextWidth(text,FontNum);
	} else {
		return strlen(text)*10;
	}
}


Point DuneStyle::GetMinimumLabelSize(std::string text) {
	return Point(GetTextWidth(text.c_str(),FONT_STD12) + 20,GetTextHeight(FONT_STD12) + 8);
}

SDL_Surface* DuneStyle::CreateLabelSurface(Uint32 width, Uint32 height, std::list<std::string> TextLines, Alignment_Enum alignment, int color) {
	SDL_Surface* surface;

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);

	std::list<SDL_Surface*> TextSurfaces;
	std::list<std::string>::const_iterator iter;
	for(iter = TextLines.begin(); iter != TextLines.end() ; ++iter) {
		std::string text = *iter;

		if(color == -1) {
			// create text background
			TextSurfaces.push_back(CreateSurfaceWithText(text.c_str(), 110, FONT_STD12));
			// create text foreground
			TextSurfaces.push_back(CreateSurfaceWithText(text.c_str(), 147, FONT_STD12));
		} else  {
			// create text background
			TextSurfaces.push_back(CreateSurfaceWithText(text.c_str(), color, FONT_STD12));
		}
	}

	int fontheight = GetTextHeight(FONT_STD12);
	int spacing = 2;

	int textheight = fontheight * TextLines.size() + spacing * (TextLines.size() - 1);

	int textpos_y = (height - textheight) / 2;

	std::list<SDL_Surface*>::const_iterator surfiter = TextSurfaces.begin();
	while(surfiter != TextSurfaces.end()) {
		SDL_Rect textRect;
		SDL_Surface* textSurface;

		textSurface = *surfiter;
		switch(alignment) {
			case Alignment_Left: {
				textRect.x = 4;
			} break;

			case Alignment_Right: {
				textRect.x = width - textSurface->w - 4;
			}

			default: {
				textRect.x = ((surface->w - textSurface->w) / 2)+3;
			} break;
		}
		textRect.y = textpos_y + 3;
		textRect.w = textSurface->w;
		textRect.h = textSurface->h;
		SDL_BlitSurface(textSurface,NULL,surface,&textRect);
		SDL_FreeSurface(textSurface);
		++surfiter;

		if(color == -1) {
			textSurface = *surfiter;
			switch(alignment) {
				case Alignment_Left: {
					textRect.x = 3;
				} break;

				case Alignment_Right: {
					textRect.x = width - textSurface->w - 3;
				}

				default: {
					textRect.x = ((surface->w - textSurface->w) / 2)+2;
				} break;
			}
			textRect.y = textpos_y + 2;
			textRect.w = textSurface->w;
			textRect.h = textSurface->h;
			SDL_BlitSurface(textSurface,NULL,surface,&textRect);
			SDL_FreeSurface(textSurface);
			++surfiter;
		}

		textpos_y += fontheight + spacing;
	}


	SDL_SetColorKey(surface, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	return surface;
}





Point DuneStyle::GetMinimumButtonSize(std::string text) {
	return Point(GetTextWidth(text.c_str(),FONT_STD10)+2,GetTextHeight(FONT_STD10));
}

SDL_Surface* DuneStyle::CreateButtonSurface(Uint32 width, Uint32 height, std::string text, bool pressed, bool activated) {
	SDL_Surface* surface;

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);


	// create button background
	if(pressed == false) {
		// normal mode
		SDL_FillRect(surface, NULL, 115);
		drawrect(surface, 0, 0, surface->w-1, surface->h-1, 229);
		drawhline(surface, 1, 1, surface->w-2, 108);
		drawvline(surface, 1, 1, surface->h-2, 108);
		drawhline(surface, 1, surface->h-2, surface->w-2, 226);
		drawvline(surface, surface->w-2, 1, surface->h-2, 226);
	} else {
		// pressed button mode
		SDL_FillRect(surface, NULL, 116);
		drawrect(surface, 0, 0, surface->w-1, surface->h-1, 229);
		drawrect(surface, 1, 1, surface->w-2, surface->h-2, 226);

	}

	// create text on this button
	int fontsize;
	if(	(width < GetTextWidth(text.c_str(),FONT_STD12) + 2) ||
		(height < GetTextHeight(FONT_STD12) + 2)) {
		fontsize = FONT_STD10;
	} else {
		fontsize = FONT_STD12;
	}

	SDL_Surface* textSurface;
	SDL_Rect textRect;
	textSurface = CreateSurfaceWithText(text.c_str(), 110, fontsize);
	textRect.x = ((surface->w - textSurface->w) / 2)+3;
	textRect.y = ((surface->h - textSurface->h) / 2)+3;
	textRect.w = textSurface->w;
	textRect.h = textSurface->h;
	SDL_BlitSurface(textSurface,NULL,surface,&textRect);
	SDL_FreeSurface(textSurface);

	textSurface = CreateSurfaceWithText(text.c_str(), (activated == true) ? 145 : 147, fontsize);
	textRect.x = ((surface->w - textSurface->w) / 2)+2;
	textRect.y = ((surface->h - textSurface->h) / 2)+2;
	textRect.w = textSurface->w;
	textRect.h = textSurface->h;
	SDL_BlitSurface(textSurface,NULL,surface,&textRect);
	SDL_FreeSurface(textSurface);

	return surface;
}




Point DuneStyle::GetMinimumTextBoxSize() {
	return Point(10,GetTextHeight(FONT_STD10) + 12);
}

SDL_Surface* DuneStyle::CreateTextBoxSurface(Uint32 width, Uint32 height, std::string text, bool carret) {
	SDL_Surface* surface;

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);

	SDL_FillRect(surface, NULL, 115);
	drawrect(surface,0,0,surface->w-1,surface->h-1,229);

	drawhline(surface,1,1,surface->w-2,226);
	drawhline(surface,1,2,surface->w-2,226);
	drawvline(surface,1,1,surface->h-2,226);
	drawvline(surface,2,1,surface->h-2,226);
	drawhline(surface,1,surface->h-2,surface->w-2,108);
	drawvline(surface,surface->w-2,1,surface->h-2,108);

	SDL_Rect cursorPos;

	// create text in this text box
	if(text.size() != 0) {
		SDL_Surface* textSurface;
		SDL_Rect textRect;
		textSurface = CreateSurfaceWithText(text.c_str(), 110, FONT_STD12);
		textRect.x = ((surface->w - textSurface->w) / 2)+3;
		textRect.y = ((surface->h - textSurface->h) / 2)+3;
		textRect.w = textSurface->w;
		textRect.h = textSurface->h;
		if(textRect.w > surface->w - 20) {
			textRect.x -= (textSurface->w - surface->w) / 2;
			textRect.x -= 10;
		}
		SDL_BlitSurface(textSurface,NULL,surface,&textRect);
		SDL_FreeSurface(textSurface);

		textSurface = CreateSurfaceWithText(text.c_str(), 147, FONT_STD12);
		textRect.x = ((surface->w - textSurface->w) / 2)+2;
		textRect.y = ((surface->h - textSurface->h) / 2)+2;
		textRect.w = textSurface->w;
		textRect.h = textSurface->h;
		if(textRect.w > surface->w - 20) {
			textRect.x -= (textSurface->w - surface->w) / 2;
			textRect.x -= 10;
		}
		cursorPos.x = textRect.x + textSurface->w + 2;
		SDL_BlitSurface(textSurface,NULL,surface,&textRect);
		SDL_FreeSurface(textSurface);

		cursorPos.w = 1;
	} else {
		cursorPos.x = surface->w / 2;
		cursorPos.w = 1;
	}

	cursorPos.y = surface->h / 2 - 8;
	cursorPos.h = 16;

	if(carret == true) {
		drawvline(surface,cursorPos.x,cursorPos.y,cursorPos.y+cursorPos.h,147);
		drawvline(surface,cursorPos.x+1,cursorPos.y,cursorPos.y+cursorPos.h,147);
	}

	return surface;
}




Point DuneStyle::GetMinimumScrollBarArrowButtonSize() {
	return Point(17,17);
}

SDL_Surface* DuneStyle::CreateScrollBarArrowButton(bool down, bool pressed, bool activated) {
	SDL_Surface* surface;

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,17,17,8,0,0,0,0))== NULL) {
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);


	// create button background
	if(pressed == false) {
		// normal mode
		SDL_FillRect(surface, NULL, 115);
		drawrect(surface, 0, 0, surface->w-1, surface->h-1, 229);
		drawhline(surface, 1, 1, surface->w-2, 108);
		drawvline(surface, 1, 1, surface->h-2, 108);
		drawhline(surface, 1, surface->h-2, surface->w-2, 226);
		drawvline(surface, surface->w-2, 1, surface->h-2, 226);
	} else {
		// pressed button mode
		SDL_FillRect(surface, NULL, 116);
		drawrect(surface, 0, 0, surface->w-1, surface->h-1, 229);
		drawrect(surface, 1, 1, surface->w-2, surface->h-2, 226);
	}

	int col = (pressed | activated) ? 145 : 147;

	// draw arrow
	if(down == true) {
		// down arrow
		drawhline(surface,3,4,13,col);
		drawhline(surface,4,5,12,col);
		drawhline(surface,5,6,11,col);
		drawhline(surface,6,7,10,col);
		drawhline(surface,7,8,9,col);
		drawhline(surface,8,9,8,col);
	} else {
		// up arrow
		drawhline(surface,8,5,8,col);
		drawhline(surface,7,6,9,col);
		drawhline(surface,6,7,10,col);
		drawhline(surface,5,8,11,col);
		drawhline(surface,4,9,12,col);
		drawhline(surface,3,10,13,col);
	}

	return surface;
}




Uint32 DuneStyle::GetListBoxEntryHeight() {
	return 16;
}

SDL_Surface* DuneStyle::CreateListBoxEntry(Uint32 width, std::string text, bool selected) {
	SDL_Surface* surface;

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,GetListBoxEntryHeight(),8,0,0,0,0))== NULL) {
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);
	if(selected == true) {
		SDL_FillRect(surface, NULL, 115);
	} else {
		SDL_SetColorKey(surface, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	}

	SDL_Surface* textSurface;
	SDL_Rect textRect;
	textSurface = CreateSurfaceWithText(text.c_str(), 147, FONT_STD10);
	textRect.x = 3;
	textRect.y = ((surface->h - textSurface->h) / 2) + 1;
	textRect.w = textSurface->w;
	textRect.h = textSurface->h;
	SDL_BlitSurface(textSurface,NULL,surface,&textRect);
	SDL_FreeSurface(textSurface);

	return surface;
}




SDL_Surface* DuneStyle::CreateProgressBarOverlay(Uint32 width, Uint32 height, double percent, int color) {
	SDL_Surface* pSurface;

	// create surfaces
	if((pSurface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
		return NULL;
	}

	SDL_SetColors(pSurface, palette->colors, 0, palette->ncolors);
	SDL_SetColorKey(pSurface, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);

	unsigned int max_i = lround(percent*((width - 4)/100.0));

	if(color == -1) {
		// default color

		if (!SDL_MUSTLOCK(pSurface) || (SDL_LockSurface(pSurface) == 0)) {
			for (unsigned int i = 2; i < max_i + 2; i++) {
				for (unsigned int j = (i % 2) + 2; j < height-2; j+=2) {
					putpixel(pSurface, i, j, COLOUR_BLACK);
				}
			}

			if (SDL_MUSTLOCK(pSurface))
				SDL_UnlockSurface(pSurface);
		}
	} else {
		SDL_Rect dest = { 2 , 2 , max_i , height - 4 };
	SDL_FillRect(pSurface, &dest, color);
	}

	return pSurface;
}



SDL_Surface* DuneStyle::CreateToolTip(std::string text) {
	SDL_Surface* surface;
	SDL_Surface* helpTextSurface;

	if((helpTextSurface = CreateSurfaceWithText(text.c_str(), COLOUR_YELLOW, FONT_STD10)) == NULL) {
		return NULL;
	}

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE, helpTextSurface->w + 4, helpTextSurface->h + 2,8,0,0,0,0)) == NULL) {
		SDL_FreeSurface(helpTextSurface);
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);

	SDL_FillRect(surface, NULL, COLOUR_BLACK);
	drawrect(surface, 0, 0, helpTextSurface->w + 4 - 1, helpTextSurface->h + 2 - 1, COLOUR_YELLOW);

	SDL_Rect textRect;

	textRect.x = 3;
	textRect.y = 3;
	textRect.w = helpTextSurface->w;
	textRect.h = helpTextSurface->h;

	SDL_BlitSurface(helpTextSurface, NULL, surface, &textRect);

	SDL_FreeSurface(helpTextSurface);
	return surface;
}



SDL_Surface* DuneStyle::CreateBackground(Uint32 width, Uint32 height) {
	SDL_Surface* pSurface;
	if(pDataManager != NULL) {
		pSurface = GetSubPicture(pDataManager->getUIGraphic(UI_Background), 0, 0, width, height);
		if(pSurface == NULL) {
			return NULL;
		}
	} else {
		// data manager not yet loaded
		if((pSurface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
			return NULL;
		}
		SDL_SetColors(pSurface, palette->colors, 0, palette->ncolors);
		SDL_FillRect(pSurface, NULL, 115);
	}


	drawrect(pSurface, 0, 0, pSurface->w-1, pSurface->h-1, 229);
	drawhline(pSurface, 1, 1, pSurface->w-2, 108);
	drawhline(pSurface, 2, 2, pSurface->w-3, 108);
	drawvline(pSurface, 1, 1, pSurface->h-2, 108);
	drawvline(pSurface, 2, 2, pSurface->h-3, 108);
	drawhline(pSurface, 1, pSurface->h-2, pSurface->w-2, 226);
	drawhline(pSurface, 2, pSurface->h-3, pSurface->w-3, 226);
	drawvline(pSurface, pSurface->w-2, 1, pSurface->h-2, 226);
	drawvline(pSurface, pSurface->w-3, 2, pSurface->h-3, 226);

	return pSurface;
}

SDL_Surface* DuneStyle::CreateWidgetBackground(Uint32 width, Uint32 height) {
	SDL_Surface* surface;

	// create surfaces
	if((surface = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
		return NULL;
	}
	SDL_SetColors(surface, palette->colors, 0, palette->ncolors);


	SDL_FillRect(surface, NULL, 116);
	drawrect(surface, 0, 0, surface->w-1, surface->h-1, 229);
	drawrect(surface, 1, 1, surface->w-2, surface->h-2, 226);

	return surface;
}
