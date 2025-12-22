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

#ifndef MAPCHOICE_H
#define MAPCHOICE_H

#include "MenuClass.h"
#include <DataTypes.h>
#include <misc/draw_util.h>
#include <mmath.h>
#include <vector>
#include <SDL.h>

#define MAPCHOICESTATE_BLENDING		0
#define MAPCHOICESTATE_FASTBLENDING	1
#define MAPCHOICESTATE_ARROWS		2
#define MAPCHOICESTATE_BLINKING		3

class MapChoice : public MenuClass
{
public:
	MapChoice(int newHouse, unsigned int LastMission);
	~MapChoice();

	void DrawSpecificStuff();
	bool doInput(SDL_Event &event);

private:
	void PrepareMapSurface();
	void LoadINI();

private:
	struct TGroup {
		std::vector<int> newRegion[NUM_HOUSES];

		struct TAttackRegion {
			int RegionNum;
			int ArrowNum;
			Coord ArrowPosition;
		} AttackRegion[4];

		struct TText {
			std::string Message;
			int Region;		//< when this region is changed, this message will appear.
		};

		std::vector<TText> Text;
	} Group[9];

	// Step by step one more pixel of the source image is blitted to the destination image
	class BlendBlitter {
	public:
		BlendBlitter(SDL_Surface* SrcPic, SDL_Surface* DestPic,SDL_Rect DestPicRect) {
			src = SrcPic;
			dest = DestPic;
			destRect = DestPicRect;

			StepsLeft = 40;
		}

		~BlendBlitter() {
		}

		/**
			Blits the next pixel to the destination surface
			\return The number of steps to do
		*/
		int nextStep() {
			const int offsets[] = {	32,29,17,30,19,25,12,3,38,20,
									11,27,23,2,31,16,36,7,26,28,
									4,34,18,6,39,15,8,22,33,24,
									10,21,5,13,35,0,14,37,9,1};

			if(StepsLeft <= 0) {
				return 0;
			}
			StepsLeft--;

			if(SDL_LockSurface(dest) != 0) {
				fprintf(stderr,"BlendBlitter::nextStep(): Cannot lock image!\n");
				exit(EXIT_FAILURE);
			}

			if(SDL_LockSurface(src) != 0) {
				fprintf(stderr,"BlendBlitter::nextStep(): Cannot lock image!\n");
				exit(EXIT_FAILURE);
			}

			int PixelCount = 0;
			int x,y;
			for (x = 0; x < src->w; x++) {
				for (y = 0; y < src->h; y++) {
					if( ((Uint8*)src->pixels)[y * src->pitch + x] != 0) {
						if((PixelCount % 40) == offsets[StepsLeft]) {
							if(	(destRect.x + x < dest->w) && (destRect.x + x >= 0) &&
								(destRect.x + x <= destRect.x + destRect.w) &&
								(destRect.y + y < dest->h) && (destRect.y + y >= 0) &&
								(destRect.y + y <= destRect.y + destRect.h) ) {
								// is inside destRect and the destination surface
								Uint8* pSrcPixel = &((Uint8*)src->pixels)[y * src->pitch + x];
								Uint8* pDestPixel = &((Uint8*)dest->pixels)[(destRect.y + y) * dest->pitch + (destRect.x + x)];

								*pDestPixel = *pSrcPixel;
							}
						}
						PixelCount++;
					}
				}
			}


			SDL_UnlockSurface(src);
			SDL_UnlockSurface(dest);
			return StepsLeft;
		}


	private:
		SDL_Surface* src;
		SDL_Surface* dest;
		SDL_Rect	destRect;
		int StepsLeft;
	};

	int house;
	unsigned int LastScenario;
	SDL_Surface* MapSurface;
	Coord PiecePosition[28];
	BlendBlitter* curBlendBlitter;
	unsigned int curHouse2Blit;
	unsigned int curRegion2Blit;
	int MapChoiceState;
	int selectedRegion;
	Uint32	selectionTime;
};

#endif //MAPCHOICE_H
