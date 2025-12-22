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

#ifndef PICTUREFACTORY_H
#define PICTUREFACTORY_H

#include <SDL.h>

class PictureFactory {
public:
	PictureFactory();
	~PictureFactory();

	SDL_Surface* createTopBar();
	SDL_Surface* createGameBar();
	SDL_Surface* createValidPlace();
	SDL_Surface* createInvalidPlace();
	void drawFrame(SDL_Surface* Pic, unsigned int DecorationType, SDL_Rect* dest=NULL);
	SDL_Surface* createBackground();
	SDL_Surface* createMainBackground();
	SDL_Surface* createFrame(unsigned int DecorationType,int width, int height,bool UseBackground);
	SDL_Surface* createMenu(SDL_Surface* CaptionPic,int y);
	SDL_Surface* createOptionsMenu();
	SDL_Surface* createMessageBoxBorder();
	SDL_Surface* createHouseSelect(SDL_Surface* HouseChoice);
	SDL_Surface* createMapChoiceScreen(int House);

	enum {
		SimpleFrame,
		DecorationFrame1,
		DecorationFrame2,
		NUM_DECORATIONFRAMES
	} DecorationFrame;

private:
	struct DecorationBorderType {
		SDL_Surface *ball;
		SDL_Surface *hspacer;
		SDL_Surface *vspacer;
		SDL_Surface *hborder;
		SDL_Surface *vborder;
	} DecorationBorder;

	struct BorderStyle {
		SDL_Surface* LeftUpperCorner;
		SDL_Surface* RightUpperCorner;
		SDL_Surface* LeftLowerCorner;
		SDL_Surface* RightLowerCorner;
		SDL_Surface* hborder;
		SDL_Surface* vborder;
	} Frame[NUM_DECORATIONFRAMES];

	SDL_Surface* Background;
	SDL_Surface* CreditsBorder;

	SDL_Surface* HarkonnenLogo;
	SDL_Surface* AtreidesLogo;
	SDL_Surface* OrdosLogo;

	SDL_Surface* MessageBoxBorder;
};

#endif // PICTUREFACTORY_H
