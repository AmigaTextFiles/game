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

#include <FileClasses/PictureFactory.h>

#include <globals.h>

#include <config.h>

#include <FileClasses/FileManager.h>
#include <FileClasses/FontManager.h>
#include <FileClasses/Cpsfile.h>

#include <misc/draw_util.h>

PictureFactory::PictureFactory() {
	SDL_Surface* ScreenPic;
	SDL_Surface* FamePic;
	SDL_Surface* ChoamPic;

	Cpsfile *_Screen;
	Cpsfile *Fame;
	Cpsfile *Choam;
	SDL_RWops *Screen_cps;
	SDL_RWops *Fame_cps;
	SDL_RWops *Choam_cps;

	Screen_cps = pFileManager->OpenFile("SCREEN.CPS");
	if((_Screen = new Cpsfile(Screen_cps)) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory(): Cannot open SCREEN.CPS!\n");
		exit(EXIT_FAILURE);
	}
	if((ScreenPic = _Screen->getPicture()) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory(): Cannot read SCREEN.CPS!\n");
		exit(EXIT_FAILURE);
	}

	Fame_cps = pFileManager->OpenFile("FAME.CPS");
	if((Fame = new Cpsfile(Fame_cps)) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory(): Cannot open FAME.CPS!\n");
		exit(EXIT_FAILURE);
	}
	if((FamePic = Fame->getPicture()) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory(): Cannot read FAME.CPS!\n");
		exit(EXIT_FAILURE);
	}

	Choam_cps = pFileManager->OpenFile("CHOAM.CPS");
	if((Choam = new Cpsfile(Choam_cps)) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory(): Cannot open CHOAM.CPS!\n");
		exit(EXIT_FAILURE);
	}
	if((ChoamPic = Choam->getPicture()) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory(): Cannot read CHOAM.CPS!\n");
		exit(EXIT_FAILURE);
	}

	CreditsBorder = GetSubPicture(ScreenPic,257,2,63,13);

	// background
	if((Background = SDL_CreateRGBSurface(SDL_HWSURFACE,settings.Video.Width,settings.Video.Height,8,0,0,0,0)) == NULL) {
		fprintf(stdout,"PictureFactory::PictureFactory: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}
	SDL_SetColors(Background, palette->colors, 0, palette->ncolors);

	SDL_Surface* PatternNormal = GetSubPicture(FamePic,0,1,63,67);
	SDL_Surface* PatternHFlipped = FlipHPicture(GetSubPicture(FamePic,0,1,63,67));
	SDL_Surface* PatternVFlipped = FlipVPicture(GetSubPicture(FamePic,0,1,63,67));
	SDL_Surface* PatternHVFlipped = FlipHPicture(FlipVPicture(GetSubPicture(FamePic,0,1,63,67)));

	SDL_Rect dest;
	dest.w = 63;
	dest.h = 67;
	for(dest.y = 0; dest.y < settings.Video.Height; dest.y+= 67) {
		for(dest.x = 0; dest.x < settings.Video.Width; dest.x+= 63) {
			if((dest.x % (63*2) == 0) && (dest.y % (67*2) == 0)) {
				SDL_BlitSurface(PatternNormal,NULL,Background,&dest);
			} else if((dest.x % (63*2) != 0) && (dest.y % (67*2) == 0)) {
				SDL_BlitSurface(PatternHFlipped,NULL,Background,&dest);
			} else if((dest.x % (63*2) == 0) && (dest.y % (67*2) != 0)) {
				SDL_BlitSurface(PatternVFlipped,NULL,Background,&dest);
			} else /*if((dest.x % (63*2) != 0) && (dest.y % (67*2) != 0))*/ {
				SDL_BlitSurface(PatternHVFlipped,NULL,Background,&dest);
			}
		}
	}

	SDL_FreeSurface(PatternNormal);
	SDL_FreeSurface(PatternHFlipped);
	SDL_FreeSurface(PatternVFlipped);
	SDL_FreeSurface(PatternHVFlipped);

	// decoration border
	DecorationBorder.ball = GetSubPicture(ScreenPic,241,124,12,11);
	DecorationBorder.vspacer = GetSubPicture(ScreenPic,241,118,12,5);
	DecorationBorder.hspacer = RotatePictureRight(copySurface(DecorationBorder.vspacer));
	DecorationBorder.vborder = GetSubPicture(ScreenPic,241,71,12,13);
	DecorationBorder.hborder = RotatePictureRight(copySurface(DecorationBorder.vborder));

	// simple Frame
	Frame[SimpleFrame].LeftUpperCorner = GetSubPicture(ChoamPic,120,17,8,8);
	putpixel(Frame[SimpleFrame].LeftUpperCorner,7,7,0);
	putpixel(Frame[SimpleFrame].LeftUpperCorner,6,7,0);
	putpixel(Frame[SimpleFrame].LeftUpperCorner,7,6,0);

	Frame[SimpleFrame].RightUpperCorner = GetSubPicture(ChoamPic,312,17,8,8);
	putpixel(Frame[SimpleFrame].RightUpperCorner,0,7,0);
	putpixel(Frame[SimpleFrame].RightUpperCorner,0,6,0);
	putpixel(Frame[SimpleFrame].RightUpperCorner,1,7,0);

	Frame[SimpleFrame].LeftLowerCorner = GetSubPicture(ChoamPic,120,31,8,8);
	putpixel(Frame[SimpleFrame].LeftLowerCorner,7,0,0);
	putpixel(Frame[SimpleFrame].LeftLowerCorner,6,0,0);
	putpixel(Frame[SimpleFrame].LeftLowerCorner,7,1,0);

	Frame[SimpleFrame].RightLowerCorner = GetSubPicture(ChoamPic,312,31,8,8);
	putpixel(Frame[SimpleFrame].RightLowerCorner,0,0,0);
	putpixel(Frame[SimpleFrame].RightLowerCorner,1,0,0);
	putpixel(Frame[SimpleFrame].RightLowerCorner,0,1,0);

	Frame[SimpleFrame].hborder = GetSubPicture(ChoamPic,128,17,1,4);
	Frame[SimpleFrame].vborder = GetSubPicture(ChoamPic,120,25,4,1);

	// Decoration Frame 1
	Frame[DecorationFrame1].LeftUpperCorner = GetSubPicture(ChoamPic,2,57,11,12);
	putpixel(Frame[DecorationFrame1].LeftUpperCorner,10,11,0);
	putpixel(Frame[DecorationFrame1].LeftUpperCorner,9,11,0);
	putpixel(Frame[DecorationFrame1].LeftUpperCorner,10,10,0);

	Frame[DecorationFrame1].RightUpperCorner = GetSubPicture(ChoamPic,44,57,11,12);
	putpixel(Frame[DecorationFrame1].RightUpperCorner,0,11,0);
	putpixel(Frame[DecorationFrame1].RightUpperCorner,0,10,0);
	putpixel(Frame[DecorationFrame1].RightUpperCorner,1,11,0);

	Frame[DecorationFrame1].LeftLowerCorner = GetSubPicture(ChoamPic,2,132,11,11);
	putpixel(Frame[DecorationFrame1].LeftLowerCorner,10,0,0);
	putpixel(Frame[DecorationFrame1].LeftLowerCorner,9,0,0);
	putpixel(Frame[DecorationFrame1].LeftLowerCorner,10,1,0);

	Frame[DecorationFrame1].RightLowerCorner = GetSubPicture(ChoamPic,44,132,11,11);
	putpixel(Frame[DecorationFrame1].RightLowerCorner,0,0,0);
	putpixel(Frame[DecorationFrame1].RightLowerCorner,1,0,0);
	putpixel(Frame[DecorationFrame1].RightLowerCorner,0,1,0);

	Frame[DecorationFrame1].hborder = GetSubPicture(ChoamPic,13,57,1,4);
	Frame[DecorationFrame1].vborder = GetSubPicture(ChoamPic,2,69,4,1);

	// Decoration Frame 2
	Frame[DecorationFrame2].LeftUpperCorner = GetSubPicture(ChoamPic,121,41,9,9);
	drawhline(Frame[DecorationFrame2].LeftUpperCorner,6,6,8,0);
	drawhline(Frame[DecorationFrame2].LeftUpperCorner,6,7,8,0);
	drawhline(Frame[DecorationFrame2].LeftUpperCorner,6,8,8,0);

	Frame[DecorationFrame2].RightUpperCorner = GetSubPicture(ChoamPic,309,41,10,9);
	drawhline(Frame[DecorationFrame2].RightUpperCorner,0,6,3,0);
	drawhline(Frame[DecorationFrame2].RightUpperCorner,0,7,3,0);
	drawhline(Frame[DecorationFrame2].RightUpperCorner,0,8,3,0);

	Frame[DecorationFrame2].LeftLowerCorner = GetSubPicture(ChoamPic,121,157,9,10);
	drawhline(Frame[DecorationFrame2].LeftLowerCorner,6,0,8,0);
	drawhline(Frame[DecorationFrame2].LeftLowerCorner,6,1,8,0);
	drawhline(Frame[DecorationFrame2].LeftLowerCorner,6,2,8,0);
	drawhline(Frame[DecorationFrame2].LeftLowerCorner,7,3,8,0);

	Frame[DecorationFrame2].RightLowerCorner = GetSubPicture(ChoamPic,309,158,10,9);
	drawhline(Frame[DecorationFrame2].RightLowerCorner,0,0,3,0);
	drawhline(Frame[DecorationFrame2].RightLowerCorner,0,1,3,0);
	drawhline(Frame[DecorationFrame2].RightLowerCorner,0,2,3,0);

	Frame[DecorationFrame2].hborder = GetSubPicture(ChoamPic,133,41,1,4);
	Frame[DecorationFrame2].vborder = GetSubPicture(ChoamPic,121,51,4,1);

	for(int i=0; i < NUM_DECORATIONFRAMES; i++) {
		SDL_SetColorKey(Frame[i].LeftUpperCorner, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
		SDL_SetColorKey(Frame[i].LeftLowerCorner, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
		SDL_SetColorKey(Frame[i].RightUpperCorner, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
		SDL_SetColorKey(Frame[i].RightLowerCorner, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
		SDL_SetColorKey(Frame[i].hborder, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
		SDL_SetColorKey(Frame[i].vborder, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	}

	// House Logos
	HarkonnenLogo = GetSubPicture(FamePic,10,137,53,54);
	AtreidesLogo = GetSubPicture(FamePic,66,137,53,54);
	OrdosLogo = GetSubPicture(FamePic,122,137,53,54);

	MessageBoxBorder = GetSubPicture(ScreenPic,0,17,320,22);

	delete _Screen;
	delete Fame;
	delete Choam;
	SDL_RWclose(Screen_cps);
	SDL_RWclose(Fame_cps);
	SDL_RWclose(Choam_cps);

	SDL_FreeSurface(ScreenPic);
	SDL_FreeSurface(FamePic);
	SDL_FreeSurface(ChoamPic);
}

PictureFactory::~PictureFactory() {
	SDL_FreeSurface(DecorationBorder.ball);
	SDL_FreeSurface(DecorationBorder.vspacer);
	SDL_FreeSurface(DecorationBorder.hspacer);
	SDL_FreeSurface(DecorationBorder.vborder);
	SDL_FreeSurface(DecorationBorder.hborder);
	SDL_FreeSurface(Background);
	SDL_FreeSurface(CreditsBorder);

	for(int i=0; i < NUM_DECORATIONFRAMES; i++) {
		SDL_FreeSurface(Frame[i].LeftUpperCorner);
		SDL_FreeSurface(Frame[i].LeftLowerCorner);
		SDL_FreeSurface(Frame[i].RightUpperCorner);
		SDL_FreeSurface(Frame[i].RightLowerCorner);
		SDL_FreeSurface(Frame[i].hborder);
		SDL_FreeSurface(Frame[i].vborder);
	}

	SDL_FreeSurface(HarkonnenLogo);
	SDL_FreeSurface(AtreidesLogo);
	SDL_FreeSurface(OrdosLogo);
	SDL_FreeSurface(MessageBoxBorder);
}

SDL_Surface* PictureFactory::createTopBar() {
	SDL_Surface* TopBar;
	TopBar = GetSubPicture(Background,0,0,settings.Video.Width-GAMEBARWIDTH,32+12);
	SDL_Rect dest1 = {0,31,TopBar->w,12};
	SDL_FillRect(TopBar,&dest1,0);

	SDL_Rect dest2 = {0,32,DecorationBorder.hborder->w,DecorationBorder.hborder->h};
	for(dest2.x = 0; dest2.x < TopBar->w; dest2.x+=DecorationBorder.hborder->w) {
		SDL_BlitSurface(DecorationBorder.hborder,NULL,TopBar,&dest2);
	}

	drawvline(TopBar,TopBar->w-7,32,TopBar->h-1,96);

	SDL_Rect dest3 = {TopBar->w - 6,TopBar->h-12,12,5};
	SDL_BlitSurface(DecorationBorder.hspacer,NULL,TopBar,&dest3);

	drawvline(TopBar,TopBar->w-1,0,TopBar->h-1,0);

	return TopBar;
}

SDL_Surface* PictureFactory::createGameBar() {
	SDL_Surface* GameBar;
	GameBar = GetSubPicture(Background,0,0,GAMEBARWIDTH,settings.Video.Height);
	SDL_Rect dest1 = {0,0,13,GameBar->h};
	SDL_FillRect(GameBar,&dest1,0);


	SDL_Rect dest2 = {0,0,DecorationBorder.vborder->w,DecorationBorder.vborder->h};
	for(dest2.y = 0; dest2.y < GameBar->h; dest2.y+=DecorationBorder.vborder->h) {
		SDL_BlitSurface(DecorationBorder.vborder,NULL,GameBar,&dest2);
	}

	SDL_Rect dest3 = {0,32-DecorationBorder.vspacer->h-1,DecorationBorder.vspacer->w,DecorationBorder.vspacer->h};
	SDL_BlitSurface(DecorationBorder.vspacer,NULL,GameBar,&dest3);

	drawhline(GameBar,0,32-DecorationBorder.vspacer->h-2,DecorationBorder.vspacer->w-1,96);
	drawhline(GameBar,0,31,DecorationBorder.vspacer->w-1,0);

	SDL_Rect dest4 = {0,32,DecorationBorder.ball->w,DecorationBorder.ball->h};
	SDL_BlitSurface(DecorationBorder.ball,NULL,GameBar,&dest4);

	drawhline(GameBar,0,43,DecorationBorder.vspacer->w-1,0);
	SDL_Rect dest5 = {0,44,DecorationBorder.vspacer->w,DecorationBorder.vspacer->h};
	SDL_BlitSurface(DecorationBorder.vspacer,NULL,GameBar,&dest5);
	drawhline(GameBar,0,44+DecorationBorder.vspacer->h,DecorationBorder.vspacer->w-1,96);

	SDL_Rect dest6 = {13,0,GameBar->w-1,132};
	SDL_FillRect(GameBar,&dest6,0);
	drawrect(GameBar,13,1,GameBar->w-2,130,115);

	SDL_Rect dest7 = {0,132-DecorationBorder.vspacer->h-1,DecorationBorder.vspacer->w,DecorationBorder.vspacer->h};
	SDL_BlitSurface(DecorationBorder.vspacer,NULL,GameBar,&dest7);

	drawhline(GameBar,0,132-DecorationBorder.vspacer->h-2,DecorationBorder.vspacer->w-1,96);
	drawhline(GameBar,0,131,DecorationBorder.vspacer->w-1,0);

	SDL_Rect dest8 = {0,132,DecorationBorder.ball->w,DecorationBorder.ball->h};
	SDL_BlitSurface(DecorationBorder.ball,NULL,GameBar,&dest8);

	drawhline(GameBar,0,143,DecorationBorder.vspacer->w-1,0);
	SDL_Rect dest9 = {0,144,DecorationBorder.vspacer->w,DecorationBorder.vspacer->h};
	SDL_BlitSurface(DecorationBorder.vspacer,NULL,GameBar,&dest9);
	drawhline(GameBar,0,144+DecorationBorder.vspacer->h,DecorationBorder.vspacer->w-1,96);

	SDL_Rect dest10 = {13,132,DecorationBorder.hspacer->w,DecorationBorder.hspacer->h};
	SDL_BlitSurface(DecorationBorder.hspacer,NULL,GameBar,&dest10);

	drawvline(GameBar,18,132,132+DecorationBorder.hspacer->h-1,96);
	drawhline(GameBar,13,132+DecorationBorder.hspacer->h,GameBar->w-1,0);

	SDL_Rect dest11 = {0,132,DecorationBorder.hborder->w,DecorationBorder.hborder->h};
	for(dest11.x = 19; dest11.x < GameBar->w; dest11.x+=DecorationBorder.hborder->w) {
		SDL_BlitSurface(DecorationBorder.hborder,NULL,GameBar,&dest11);
	}

	SDL_Rect dest12 = {46,132,CreditsBorder->w,CreditsBorder->h};
	SDL_BlitSurface(CreditsBorder,NULL,GameBar,&dest12);

	return GameBar;
}

SDL_Surface* PictureFactory::createValidPlace() {
	SDL_Surface* ValidPlace;
	if((ValidPlace = SDL_CreateRGBSurface(SDL_HWSURFACE,16,16,8,0,0,0,0)) == NULL) {
		fprintf(stdout,"PictureFactory::createValidPlace: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}
	SDL_SetColors(ValidPlace, palette->colors, 0, palette->ncolors);

	if (!SDL_MUSTLOCK(ValidPlace) || (SDL_LockSurface(ValidPlace) == 0))
	{
		for(int y = 0; y < 16; y++) {
			for(int x = 0; x < 16; x++) {
				if(x%2 == y%2) {
					*((Uint8 *)ValidPlace->pixels + y * ValidPlace->pitch + x) = 4;
				} else {
					*((Uint8 *)ValidPlace->pixels + y * ValidPlace->pitch + x) = 0;
				}
			}
		}

		if (SDL_MUSTLOCK(ValidPlace))
			SDL_UnlockSurface(ValidPlace);
	}

	SDL_SetColorKey(ValidPlace, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);

	return ValidPlace;
}

SDL_Surface* PictureFactory::createInvalidPlace() {
	SDL_Surface* InvalidPlace;
	if((InvalidPlace = SDL_CreateRGBSurface(SDL_HWSURFACE,16,16,8,0,0,0,0)) == NULL) {
		fprintf(stdout,"PictureFactory::createInvalidPlace: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}
	SDL_SetColors(InvalidPlace, palette->colors, 0, palette->ncolors);

	if (!SDL_MUSTLOCK(InvalidPlace) || (SDL_LockSurface(InvalidPlace) == 0))
	{
		for(int y = 0; y < 16; y++) {
			for(int x = 0; x < 16; x++) {
				if(x%2 == y%2) {
					*((Uint8 *)InvalidPlace->pixels + y * InvalidPlace->pitch + x) = 8;
				} else {
					*((Uint8 *)InvalidPlace->pixels + y * InvalidPlace->pitch + x) = 0;
				}
			}
		}

		if (SDL_MUSTLOCK(InvalidPlace))
			SDL_UnlockSurface(InvalidPlace);
	}

	SDL_SetColorKey(InvalidPlace, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);

	return InvalidPlace;
}

void PictureFactory::drawFrame(SDL_Surface* Pic, unsigned int DecorationType, SDL_Rect* dest) {
	if(Pic == NULL)
		return;

	if(DecorationType >= NUM_DECORATIONFRAMES)
		return;

	SDL_Rect tmp;
	if(dest == NULL) {
		tmp.x = 0;
		tmp.y = 0;
		tmp.w = Pic->w;
		tmp.h = Pic->h;
		dest = &tmp;
	}

	//corners
	SDL_Rect dest1 = {	dest->x,
						dest->y,
						Frame[DecorationType].LeftUpperCorner->w,
						Frame[DecorationType].LeftUpperCorner->h};
	SDL_BlitSurface(Frame[DecorationType].LeftUpperCorner,NULL,Pic,&dest1);

	SDL_Rect dest2 = {	dest->w - Frame[DecorationType].RightUpperCorner->w,
						dest->y,
						Frame[DecorationType].RightUpperCorner->w,
						Frame[DecorationType].RightUpperCorner->h};
	SDL_BlitSurface(Frame[DecorationType].RightUpperCorner,NULL,Pic,&dest2);

	SDL_Rect dest3 = {	dest->x,
						dest->h - Frame[DecorationType].LeftLowerCorner->h,
						Frame[DecorationType].LeftLowerCorner->w,
						Frame[DecorationType].LeftLowerCorner->h};
	SDL_BlitSurface(Frame[DecorationType].LeftLowerCorner,NULL,Pic,&dest3);

	SDL_Rect dest4 = {	dest->w - Frame[DecorationType].RightLowerCorner->w,
						dest->h - Frame[DecorationType].RightLowerCorner->h,
						Frame[DecorationType].RightLowerCorner->w,
						Frame[DecorationType].RightLowerCorner->h};
	SDL_BlitSurface(Frame[DecorationType].RightLowerCorner,NULL,Pic,&dest4);

	//hborders
	SDL_Rect dest5 = { dest->x,dest->y,Frame[DecorationType].hborder->w,Frame[DecorationType].hborder->h};
	for(dest5.x = Frame[DecorationType].LeftUpperCorner->w + dest->x;
		dest5.x <= dest->w - Frame[DecorationType].RightUpperCorner->w - 1;
		dest5.x += Frame[DecorationType].hborder->w) {
		SDL_BlitSurface(Frame[DecorationType].hborder,NULL,Pic,&dest5);
	}

	SDL_Rect dest6 = { 	dest->x,dest->h - Frame[DecorationType].hborder->h,
						Frame[DecorationType].hborder->w, Frame[DecorationType].hborder->h};
	for(dest6.x = Frame[DecorationType].LeftLowerCorner->w + dest->x;
		dest6.x <= dest->w - Frame[DecorationType].RightLowerCorner->w - 1;
		dest6.x += Frame[DecorationType].hborder->w) {
		SDL_BlitSurface(Frame[DecorationType].hborder,NULL,Pic,&dest6);
	}

	//vborders
	SDL_Rect dest7 = { dest->x,dest->y,Frame[DecorationType].vborder->w,Frame[DecorationType].vborder->h};
	for(dest7.y = Frame[DecorationType].LeftUpperCorner->h + dest->y;
		dest7.y <= dest->h - Frame[DecorationType].LeftLowerCorner->h - 1;
		dest7.y += Frame[DecorationType].vborder->h) {
		SDL_BlitSurface(Frame[DecorationType].vborder,NULL,Pic,&dest7);
	}

	SDL_Rect dest8 = { 	dest->w - Frame[DecorationType].vborder->w,dest->y,
						Frame[DecorationType].vborder->w,Frame[DecorationType].vborder->h};
	for(dest8.y = Frame[DecorationType].RightUpperCorner->h + dest->y;
		dest8.y <= dest->h - Frame[DecorationType].RightLowerCorner->h - 1;
		dest8.y += Frame[DecorationType].vborder->h) {
		SDL_BlitSurface(Frame[DecorationType].vborder,NULL,Pic,&dest8);
	}

}

SDL_Surface* PictureFactory::createFrame(unsigned int DecorationType,int width, int height,bool UseBackground) {
	SDL_Surface* Pic;
	if(UseBackground) {
		Pic = GetSubPicture(Background,0,0,width,height);
	} else {
		if((Pic = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0)) == NULL) {
			fprintf(stdout,"PictureFactory::createFrame: Cannot create new Picture!\n");
			exit(EXIT_FAILURE);
		}
		SDL_SetColors(Pic, palette->colors, 0, palette->ncolors);
		SDL_SetColorKey(Pic, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);
	}

	drawFrame(Pic,DecorationType);

	return Pic;
}

SDL_Surface* PictureFactory::createBackground() {
	return copySurface(Background);
}

SDL_Surface* PictureFactory::createMainBackground() {
	SDL_Surface* Pic;
	Pic = copySurface(Background);

	SDL_Rect dest0 = { 3,3,Pic->w-3,Pic->h-3};
	drawFrame(Pic,DecorationFrame2,&dest0);

	SDL_Rect dest1 = {11,11,HarkonnenLogo->w,HarkonnenLogo->h};
	SDL_BlitSurface(HarkonnenLogo,NULL,Pic,&dest1);

	SDL_Rect dest2 = {Pic->w - 11 - AtreidesLogo->w,11,AtreidesLogo->w,AtreidesLogo->h};
	SDL_BlitSurface(AtreidesLogo,NULL,Pic,&dest2);

	SDL_Rect dest3 = {11,Pic->h - 11 - OrdosLogo->h,OrdosLogo->w,OrdosLogo->h};
	SDL_BlitSurface(OrdosLogo,NULL,Pic,&dest3);

	SDL_Surface* Version = GetSubPicture(Background,0,0,75,32);

	char versionString[100];
	sprintf(versionString, "%s", VERSION);

	SDL_Surface *VersionText = pFontManager->createSurfaceWithText(versionString, COLOUR_BLACK, FONT_STD12);

	SDL_Rect dest4 = {	(Version->w - VersionText->w)/2, (Version->h - VersionText->h)/2 + 2,
						VersionText->w,VersionText->h};
	SDL_BlitSurface(VersionText,NULL,Version,&dest4);

	SDL_FreeSurface(VersionText);

	drawFrame(Version,SimpleFrame);

	SDL_Rect dest5 = {Pic->w - 11 - Version->w,Pic->h - 11 - Version->h,Version->w,Version->h};
	SDL_BlitSurface(Version,NULL,Pic,&dest5);

	SDL_FreeSurface(Version);

	return Pic;
}

SDL_Surface* PictureFactory::createMenu(SDL_Surface* CaptionPic,int y) {
	if(CaptionPic == NULL)
		return NULL;

	SDL_Surface* Pic = GetSubPicture(Background, 0,0,CaptionPic->w,y);

	SDL_Rect dest1 = {0,0,CaptionPic->w,CaptionPic->h};
	SDL_BlitSurface(CaptionPic, NULL,Pic,&dest1);

	drawFrame(Pic,SimpleFrame,&dest1);

	SDL_Rect dest2 = {0,dest1.h,Pic->w,Pic->h};
	drawFrame(Pic,DecorationFrame1,&dest2);

	return Pic;
}

SDL_Surface* PictureFactory::createOptionsMenu() {
	SDL_Surface* tmp;
	if((tmp = SDL_LoadBMP_RW(pFileManager->OpenFile("UI_OptionsMenu.bmp"),true)) == NULL) {
		fprintf(stdout,"PictureFactory::createOptionsMenu(): Cannot load UI_OptionsMenu.bmp!\n");
		exit(EXIT_FAILURE);
	}
	SDL_SetColorKey(tmp, SDL_SRCCOLORKEY | SDL_RLEACCEL, 0);

	SDL_Surface* Pic = GetSubPicture(Background,0,0,tmp->w,tmp->h);
	SDL_BlitSurface(tmp,NULL,Pic,NULL);

	SDL_Rect dest1 = {0,0,Pic->w,27};
	drawFrame(Pic,SimpleFrame,&dest1);

	SDL_Rect dest2 = {0,dest1.h,Pic->w,Pic->h};
	drawFrame(Pic,DecorationFrame1,&dest2);

	SDL_FreeSurface(tmp);
	return Pic;
}

SDL_Surface* PictureFactory::createMessageBoxBorder() {
	return copySurface(MessageBoxBorder);
}

SDL_Surface* PictureFactory::createHouseSelect(SDL_Surface* HouseChoice) {

	unsigned char index2greyindex[] = {
		0, 0, 0, 13, 233, 127, 0, 131, 0, 0, 0, 0, 0, 13, 14, 15,
		0, 127, 0, 0, 0, 14, 0, 130, 24, 131, 131, 0, 0, 29, 0, 183,
		0, 128, 128, 0, 14, 14, 14, 130, 130, 0, 0, 0, 0, 13, 0, 29,
		0, 0, 30, 0, 0, 183, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		126, 0, 0, 126, 128, 0, 0, 0, 0, 0, 0, 0, 14, 0, 0, 0,
		0, 14, 0, 0, 0, 0, 0, 14, 0, 0, 130, 0, 131, 0, 13, 29,
		0, 30, 183, 175, 175, 0, 0, 0, 0, 0, 0, 0, 0, 233, 0, 0,
		14, 0, 14, 130, 24, 0, 0, 0, 131, 0, 175, 0, 24, 0, 0, 0,
		0, 14, 130, 131, 29, 133, 134, 0, 233, 0, 14, 24, 131, 13, 29, 183,
		30, 30, 183, 183, 175, 175, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		24, 13, 29, 183, 175, 0, 0, 30, 0, 0, 13, 0, 0, 30, 174, 175,
		14, 24, 131, 13, 30, 183, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 30, 0, 175, 175, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 29, 0, 0, 0, 0,
		0, 0, 131, 13, 30, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
		0, 0, 0, 0, 13, 0, 0, 30, 183, 0, 0, 0, 0, 0, 0, 0 };


	SDL_Surface* Pic;
	Pic = copySurface(HouseChoice);

	for(int y = 50; y < Pic->h; y++) {
		for(int x = 0; x < Pic->w; x++) {
			unsigned char inputIndex = *( ((unsigned char*) (Pic->pixels)) + y*Pic->pitch + x);
			unsigned char outputIndex = index2greyindex[inputIndex];
			*( ((unsigned char*) (Pic->pixels)) + y*Pic->pitch + x) = outputIndex;
		}
	}

	drawFrame(Pic,SimpleFrame,NULL);

	return Pic;
}

SDL_Surface* PictureFactory::createMapChoiceScreen(int House) {
	SDL_Surface* MapChoiceScreen;
	Cpsfile *mapmach;
	SDL_RWops *mapmach_cps;

	mapmach_cps = pFileManager->OpenFile("MAPMACH.CPS");
	if((mapmach = new Cpsfile(mapmach_cps)) == NULL) {
		fprintf(stdout,"PictureFactory::createMapChoiceScreen(): Cannot open MAPMACH.CPS!\n");
		exit(EXIT_FAILURE);
	}

	if((MapChoiceScreen = mapmach->getPicture()) == NULL) {
		fprintf(stdout,"PictureFactory::createMapChoiceScreen(): Cannot read MAPMACH.CPS!\n");
		exit(EXIT_FAILURE);
	}

	delete mapmach;
	SDL_RWclose(mapmach_cps);

	SDL_Rect LeftLogo = {2,145,HarkonnenLogo->w,HarkonnenLogo->h};
	SDL_Rect RightLogo = {266,145,HarkonnenLogo->w,HarkonnenLogo->h};

	switch(House) {
		case HOUSE_ATREIDES:
		case HOUSE_FREMEN:
		{
			SDL_BlitSurface(AtreidesLogo,NULL,MapChoiceScreen,&LeftLogo);
			SDL_BlitSurface(AtreidesLogo,NULL,MapChoiceScreen,&RightLogo);
		} break;

		case HOUSE_ORDOS:
		case HOUSE_MERCENARY:
		{
			SDL_BlitSurface(OrdosLogo,NULL,MapChoiceScreen,&LeftLogo);
			SDL_BlitSurface(OrdosLogo,NULL,MapChoiceScreen,&RightLogo);
		} break;

		case HOUSE_HARKONNEN:
		case HOUSE_SARDAUKAR:
		default:
		{
			SDL_BlitSurface(HarkonnenLogo,NULL,MapChoiceScreen,&LeftLogo);
			SDL_BlitSurface(HarkonnenLogo,NULL,MapChoiceScreen,&RightLogo);
		} break;
	}

	switch(settings.General.Language) {
		case LNG_GER:
		{
			SDL_Surface* tmp = GetSubPicture(MapChoiceScreen,8,120, 303, 23);
			SDL_Rect dest = {8,0,303,23};
			SDL_BlitSurface(tmp,NULL,MapChoiceScreen,&dest);
			SDL_FreeSurface(tmp);
		} break;
		case LNG_FRE:
		{
			SDL_Surface* tmp = GetSubPicture(MapChoiceScreen,8,96, 303, 23);
			SDL_Rect dest = {8,0,303,23};
			SDL_BlitSurface(tmp,NULL,MapChoiceScreen,&dest);
			SDL_FreeSurface(tmp);
		} break;
		case LNG_ENG:
		default:
		{
			; // Nothing to do
		} break;
	}

	// clear everything in the middle
	SDL_Rect clearRect = {8,24,304,119};
	SDL_FillRect(MapChoiceScreen,&clearRect,0);

	MapChoiceScreen = DoublePicture(MapChoiceScreen);
	return MapChoiceScreen;
}
