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

#include <FileClasses/Cpsfile.h>

#include <SDL_endian.h>
#include <stdlib.h>
#include <string.h>

#define	SIZE_X	320
#define SIZE_Y	200

extern SDL_Palette* palette;

/// Constructor
/**
	The constructor reads from the RWop all data and saves them internal. The SDL_RWops can be readonly but must support
	seeking. Immediately after the Cpsfile-Object is constructed RWop can be closed. All data is saved in the class.
	\param	RWop	SDL_RWops to the cps-File. (can be readonly)
*/
Cpsfile::Cpsfile(SDL_RWops* RWop) : Decode()
{
	if(RWop == NULL) {
		fprintf(stdout, "Cpsfile: RWop == NULL!\n");
		exit(EXIT_FAILURE);
	}

	CpsFilesize = SDL_RWseek(RWop,0,SEEK_END);
	if(CpsFilesize <= 0) {
		fprintf(stdout,"Cpsfile: Cannot determine size of this *.cps-File!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWseek(RWop,0,SEEK_SET) != 0) {
		fprintf(stdout,"Cpsfile: Seeking in this *.cps-File failed!\n");
		exit(EXIT_FAILURE);
	}

	if( (Filedata = (unsigned char*) malloc(CpsFilesize)) == NULL) {
		fprintf(stdout,"Cpsfile: Allocating memory failed!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWread(RWop, Filedata, CpsFilesize, 1) != 1) {
		fprintf(stdout,"Cpsfile: Reading this *.cps-File failed!\n");
		exit(EXIT_FAILURE);
	}
}

/// Destructor
/**
	Frees all memory.
*/
Cpsfile::~Cpsfile()
{
	free(Filedata);
}

/// Returns the picture in this CPS-File
/**
	This method returns a SDL_Surface containing the picture of this CPS-File.
	The returned SDL_Surface should be freed with SDL_FreeSurface() if no longer needed.
	\return	Picture in this CPS-File
*/
SDL_Surface* Cpsfile::getPicture()
{
	unsigned char * ImageOut;
	SDL_Surface *pic = NULL;

	// check for valid file
	if( SDL_SwapLE16(*(unsigned short *)(Filedata + 2)) != 0x0004) {
		return NULL;
	}

	if( SDL_SwapLE16(*(unsigned short *)(Filedata + 4)) != 0xFA00) {
		return NULL;
	}

	Uint16 PaletteSize = SDL_SwapLE16(*((unsigned short *)(Filedata + 8)));

	if( (ImageOut = (unsigned char*) calloc(1,SIZE_X*SIZE_Y)) == NULL) {
		return NULL;
	}

	if(decode80(Filedata + 10 + PaletteSize,ImageOut,0) == -2) {
		fprintf(stdout,"Error: Cannot decode Cps-File\n");
	}

	// create new picture surface
	if((pic = SDL_CreateRGBSurface(SDL_HWSURFACE,SIZE_X,SIZE_Y,8,0,0,0,0))== NULL) {
		return NULL;
	}

	SDL_SetColors(pic, palette->colors, 0, palette->ncolors);
	SDL_LockSurface(pic);

	//Now we can copy line by line
	for(int y = 0; y < SIZE_Y;y++) {
		memcpy(	((char*) (pic->pixels)) + y * pic->pitch , ImageOut + y * SIZE_X, SIZE_X);
	}

	SDL_UnlockSurface(pic);

	free(ImageOut);

	return pic;
}
