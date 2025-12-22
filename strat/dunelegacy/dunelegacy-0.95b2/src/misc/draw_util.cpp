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

#include <misc/draw_util.h>

#include <globals.h>

void putpixel(SDL_Surface *surface, int x, int y, Uint32 colour)
{
	if (x >= 0 && x < surface->w && y >=0 && y < surface->h)
	{
		int bpp = surface->format->BytesPerPixel;
		/* Here p is the address to the pixel want to set */
		Uint8 *p = (Uint8 *)surface->pixels + y * surface->pitch + x * bpp;

		switch(bpp) {
		case 1:
			*p = colour;
			break;

		case 2:
			*(Uint16 *)p = colour;
			break;

		case 3:
			if(SDL_BYTEORDER == SDL_BIG_ENDIAN) {
				p[0] = (colour>> 16) & 0xff;
				p[1] = (colour>> 8) & 0xff;
				p[2] = colour& 0xff;
			} else {
				p[0] = colour& 0xff;
				p[1] = (colour>> 8) & 0xff;
				p[2] = (colour>> 16) & 0xff;
			}
			break;

		case 4:
			*(Uint32 *)p = colour;
			break;
		}
	}
}

void hlineNoLock(SDL_Surface *surface, int x1, int y, int x2, Uint32 colour)
{
	int	min = x1,
		max = x2;

	if (min > max)
	{
		int temp = max;
		max = min;
		min = temp;
	}

	for (int i = min; i <= max; i++)
		putpixel(surface, i, y, colour);
}

void vlineNoLock(SDL_Surface *surface, int x, int y1, int y2, Uint32 colour)
{
	int	min = y1,
		max = y2;

	if (min > max)
	{
		int temp = max;
		max = min;
		min = temp;
	}

	for (int i = min; i <= max; i++)
		putpixel(surface, x, i, colour);
}

void drawhline(SDL_Surface *surface, int x1, int y, int x2, Uint32 colour)
{
	if (!SDL_MUSTLOCK(surface) || (SDL_LockSurface(surface) == 0))
	{
		hlineNoLock(surface, x1, y, x2, colour);

		if (SDL_MUSTLOCK(surface))
			SDL_UnlockSurface(surface);
	}
}

void drawvline(SDL_Surface *surface, int x, int y1, int y2, Uint32 colour)
{
	if (!SDL_MUSTLOCK(surface) || (SDL_LockSurface(surface) == 0))
	{
		vlineNoLock(surface, x, y1, y2, colour);

		if (SDL_MUSTLOCK(surface))
			SDL_UnlockSurface(surface);
	}
}

void drawrect(SDL_Surface *surface, int x1, int y1, int x2, int y2, Uint32 colour)
{
	if (!SDL_MUSTLOCK(surface) || (SDL_LockSurface(surface) == 0))
	{
		int	min = x1,
			max = x2;
		if (min > max)
		{
			int temp = max;
			max = min;
			min = temp;
		}

		for (int i = min; i <= max; i++)
		{
			putpixel(surface, i, y1, colour);
			putpixel(surface, i, y2, colour);
		}

		min = y1+1;
		max = y2;
		if (min > max)
		{
			int temp = max;
			max = min;
			min = temp;
		}

		for (int j = min; j < max; j++)
		{
			putpixel(surface, x1, j, colour);
			putpixel(surface, x2, j, colour);
		}

		if (SDL_MUSTLOCK(surface))
			SDL_UnlockSurface(surface);
	}
}

void mapImageHouseColourBase(SDL_Surface* graphic, int house, int baseCol)
{
	if (settings.Video.DoubleBuffered && (graphic->format->BitsPerPixel == 8)) {
		if (!SDL_MUSTLOCK(graphic) || (SDL_LockSurface(graphic) >= 0)) {
			Uint8	*pixel;
			int		i, j;
			for (i = 0; i < graphic->w; i++) {
				for (j = 0; j < graphic->h; j++) {
					pixel = &((Uint8*)graphic->pixels)[j * graphic->pitch + i];
					if ((*pixel >= baseCol) && (*pixel < baseCol + 7))
						*pixel = *pixel - baseCol + houseColour[house];
				}
			}
			SDL_UnlockSurface(graphic);
		}
	} else {
		SDL_SetColors(graphic, &palette->colors[houseColour[house]], baseCol, 7);
	}
}


void mapImageHouseColour(SDL_Surface* graphic, int house)
{
	mapImageHouseColourBase(graphic, house, COLOUR_HARKONNEN);
}

SDL_Surface* MapImageHouseColor(SDL_Surface* source, int house, int baseCol)
{
	SDL_Surface *retPic;

	if((retPic = SDL_ConvertSurface(source,source->format,SDL_HWSURFACE)) == NULL) {
		fprintf(stdout,"MapImageHouseColor: Cannot copy image!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_LockSurface(retPic) != 0) {
		fprintf(stdout,"MapImageHouseColor: Cannot lock image!\n");
		exit(EXIT_FAILURE);
	}

	Uint8	*pixel;
	int		i, j;
	for (i = 0; i < retPic->w; i++) {
		for (j = 0; j < retPic->h; j++) {
			pixel = &((Uint8*)retPic->pixels)[j * retPic->pitch + i];
			if ((*pixel >= baseCol) && (*pixel < baseCol + 7))
				*pixel = *pixel - baseCol + houseColour[house];
		}
	}
	SDL_UnlockSurface(retPic);

	return retPic;
}

SDL_Surface* DoublePicture(SDL_Surface* inputPic) {
	if(inputPic == NULL) {
		return NULL;
	}

	SDL_Surface *returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,inputPic->w * 2,inputPic->h * 2,8,0,0,0,0))== NULL) {
		fprintf(stdout,"DoublePicture: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, inputPic->format->palette->colors, 0, inputPic->format->palette->ncolors);
	SDL_LockSurface(returnPic);
	SDL_LockSurface(inputPic);

	//Now we can copy pixel by pixel
	for(int y = 0; y < inputPic->h;y++) {
		for(int x = 0; x < inputPic->w; x++) {
			char val = *( ((char*) (inputPic->pixels)) + y*inputPic->pitch + x);
			*( ((char*) (returnPic->pixels)) + 2*y*returnPic->pitch + 2*x) = val;
			*( ((char*) (returnPic->pixels)) + 2*y*returnPic->pitch + 2*x+1) = val;
			*( ((char*) (returnPic->pixels)) + (2*y+1)*returnPic->pitch + 2*x) = val;
			*( ((char*) (returnPic->pixels)) + (2*y+1)*returnPic->pitch + 2*x+1) = val;
		}
	}

	SDL_UnlockSurface(inputPic);
	SDL_UnlockSurface(returnPic);

	SDL_FreeSurface(inputPic);
	return returnPic;
}

SDL_Surface* RotatePictureLeft(SDL_Surface* inputPic) {
	if(inputPic == NULL) {
		return NULL;
	}

	SDL_Surface *returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,inputPic->h,inputPic->w,8,0,0,0,0))== NULL) {
		fprintf(stdout,"RotatePictureLeft: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, inputPic->format->palette->colors, 0, inputPic->format->palette->ncolors);
	SDL_LockSurface(returnPic);
	SDL_LockSurface(inputPic);

	//Now we can copy pixel by pixel
	for(int y = 0; y < inputPic->h;y++) {
		for(int x = 0; x < inputPic->w; x++) {
			char val = *( ((char*) (inputPic->pixels)) + y*inputPic->pitch + x);
			*( ((char*) (returnPic->pixels)) + (returnPic->h - x - 1)*returnPic->pitch + y) = val;
		}
	}

	SDL_UnlockSurface(inputPic);
	SDL_UnlockSurface(returnPic);

	SDL_FreeSurface(inputPic);
	return returnPic;
}

SDL_Surface* RotatePictureRight(SDL_Surface* inputPic) {
	if(inputPic == NULL) {
		return NULL;
	}

	SDL_Surface *returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,inputPic->h,inputPic->w,8,0,0,0,0))== NULL) {
		fprintf(stdout,"RotatePictureRight: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, inputPic->format->palette->colors, 0, inputPic->format->palette->ncolors);
	SDL_LockSurface(returnPic);
	SDL_LockSurface(inputPic);

	//Now we can copy pixel by pixel
	for(int y = 0; y < inputPic->h;y++) {
		for(int x = 0; x < inputPic->w; x++) {
			char val = *( ((char*) (inputPic->pixels)) + y*inputPic->pitch + x);
			*( ((char*) (returnPic->pixels)) + x*returnPic->pitch + (returnPic->w - y - 1)) = val;
		}
	}

	SDL_UnlockSurface(inputPic);
	SDL_UnlockSurface(returnPic);

	SDL_FreeSurface(inputPic);
	return returnPic;
}

SDL_Surface* GetSubPicture(SDL_Surface* Pic, unsigned int left, unsigned int top,
											unsigned int width, unsigned int height) {
	if(Pic == NULL) {
		return NULL;
	}

	if(((int) (left+width) > Pic->w) || ((int) (top+height) > Pic->h)) {
		return NULL;
	}

	SDL_Surface *returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,width,height,8,0,0,0,0))== NULL) {
		fprintf(stdout,"GetSubPicture: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, Pic->format->palette->colors, 0, Pic->format->palette->ncolors);

	SDL_Rect srcRect = {left,top,width,height};
	SDL_BlitSurface(Pic,&srcRect,returnPic,NULL);

	return returnPic;
}

SDL_Surface* FlipHPicture(SDL_Surface* inputPic) {
	if(inputPic == NULL) {
		return NULL;
	}

	SDL_Surface *returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,inputPic->w,inputPic->h,8,0,0,0,0))== NULL) {
		fprintf(stdout,"FlipHPicture: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, inputPic->format->palette->colors, 0, inputPic->format->palette->ncolors);
	SDL_LockSurface(returnPic);
	SDL_LockSurface(inputPic);

	//Now we can copy pixel by pixel
	for(int y = 0; y < inputPic->h;y++) {
		for(int x = 0; x < inputPic->w; x++) {
			char val = *( ((char*) (inputPic->pixels)) + y*inputPic->pitch + x);
			*( ((char*) (returnPic->pixels)) + (returnPic->h - y - 1)*returnPic->pitch + x) = val;
		}
	}

	SDL_UnlockSurface(inputPic);
	SDL_UnlockSurface(returnPic);

	SDL_FreeSurface(inputPic);
	return returnPic;
}

SDL_Surface* FlipVPicture(SDL_Surface* inputPic) {
	if(inputPic == NULL) {
		return NULL;
	}

	SDL_Surface *returnPic;

	// create new picture surface
	if((returnPic = SDL_CreateRGBSurface(SDL_HWSURFACE,inputPic->w,inputPic->h,8,0,0,0,0))== NULL) {
		fprintf(stdout,"FlipVPicture: Cannot create new Picture!\n");
		exit(EXIT_FAILURE);
	}

	SDL_SetColors(returnPic, inputPic->format->palette->colors, 0, inputPic->format->palette->ncolors);
	SDL_LockSurface(returnPic);
	SDL_LockSurface(inputPic);

	//Now we can copy pixel by pixel
	for(int y = 0; y < inputPic->h;y++) {
		for(int x = 0; x < inputPic->w; x++) {
			char val = *( ((char*) (inputPic->pixels)) + y*inputPic->pitch + x);
			*( ((char*) (returnPic->pixels)) + y*returnPic->pitch + (inputPic->w - x - 1)) = val;
		}
	}

	SDL_UnlockSurface(inputPic);
	SDL_UnlockSurface(returnPic);

	SDL_FreeSurface(inputPic);
	return returnPic;
}

void clearMessage()
{
	int i;
	for (i = 0; i < MESSAGE_BUFFER_SIZE; i++)
	{
		messageBuffer[i][0] = '\0';
		messageTimer[i] = 0;
	}
}

SDL_Surface* copySurface(SDL_Surface* inSurface)
{
	//return SDL_DisplayFormat(inSurface);
	return SDL_ConvertSurface(inSurface, inSurface->format, inSurface->flags);
}

SDL_Surface* scaleSurface(SDL_Surface *surf, double ratio)
{
	SDL_Surface *scaled = SDL_CreateRGBSurface(SDL_HWSURFACE, (int) (surf->w * ratio),(int) (surf->h * ratio),32,0,0,0,0);

	SDL_LockSurface(scaled);
	SDL_LockSurface(surf);

	int X2 = (int)(surf->w * ratio);
	int Y2 = (int)(surf->h * ratio);

	for(int x = 0;x < X2;++x)
		for(int y = 0;y < Y2;++y)
			putpixel(scaled,x,y,getpixel(surf,(int) (x/ratio), (int) (y/ratio)));

	SDL_UnlockSurface(scaled);
	SDL_UnlockSurface(surf);

	return scaled;
}
