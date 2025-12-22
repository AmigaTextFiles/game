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

#include <FileClasses/Icnfile.h>

#include <SDL_endian.h>
#include <stdlib.h>
#include <string.h>

#define	SIZE_X	16
#define SIZE_Y	16

extern SDL_Palette* palette;

/// Constructor
/**
	The constructor reads from IcnRWop and MapRWop all data and saves them internal. The SDL_RWops can be readonly but
	must support seeking. Immediately after the Icnfile-Object is constructed both RWops can be closed. All data is saved
	in the class.
	\param	IcnRWop	SDL_RWops to the icn-File. (can be readonly)
	\param	MapRWop	SDL_RWops to the map-File. (can be readonly)
*/
Icnfile::Icnfile(SDL_RWops* IcnRWop, SDL_RWops* MapRWop)
{
	int MapFilesize;
	unsigned char* MapFiledata;
	int i;

	if(IcnRWop == NULL) {
		fprintf(stdout, "Icnfile: IcnRWop == NULL!\n");
		exit(EXIT_FAILURE);
	}

	if(MapRWop == NULL) {
		fprintf(stdout, "Icnfile: MapRWop == NULL!\n");
		exit(EXIT_FAILURE);
	}

	IcnFilesize = SDL_RWseek(IcnRWop,0,SEEK_END);
	if(IcnFilesize <= 0) {
		fprintf(stdout,"Icnfile: Cannot determine size of this *.icn-File!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWseek(IcnRWop,0,SEEK_SET) != 0) {
		fprintf(stdout,"Icnfile: Seeking in this *.icn-File failed!\n");
		exit(EXIT_FAILURE);
	}

	MapFilesize = SDL_RWseek(MapRWop,0,SEEK_END);
	if(MapFilesize <= 0) {
		fprintf(stdout,"Icnfile: Cannot determine size of this *.map-File!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWseek(MapRWop,0,SEEK_SET) != 0) {
		fprintf(stdout,"Icnfile: Seeking in this *.map-File failed!\n");
		exit(EXIT_FAILURE);
	}


	if( (IcnFiledata = (unsigned char*) malloc(IcnFilesize)) == NULL) {
		fprintf(stdout,"Icnfile: Allocating memory failed!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWread(IcnRWop, IcnFiledata, IcnFilesize, 1) != 1) {
		fprintf(stdout,"Icnfile: Reading this *.icn-File failed!\n");
		exit(EXIT_FAILURE);
	}

	if( (MapFiledata = (unsigned char*) malloc(MapFilesize)) == NULL) {
		fprintf(stdout,"Mapfile: Allocating memory failed!\n");
		exit(EXIT_FAILURE);
	}

	if(SDL_RWread(MapRWop, MapFiledata, MapFilesize, 1) != 1) {
		fprintf(stdout,"Mapfile: Reading this *.map-File failed!\n");
		exit(EXIT_FAILURE);
	}

	// now we can start creating the Tilesetindex
	if(MapFilesize < 2) {
		fprintf(stdout,"Mapfile: This *.map-File is too short!\n");
		exit(EXIT_FAILURE);
	}

	NumTilesets = SDL_SwapLE16( *((Uint16 *) MapFiledata));

	if(MapFilesize < NumTilesets * 2) {
		fprintf(stdout,"Mapfile: This *.map-File is too short!\n");
		exit(EXIT_FAILURE);
	}

	if((Tileset = (MapfileEntry*) malloc(sizeof(MapfileEntry)*NumTilesets)) == NULL) {
		fprintf(stdout,"Mapfile: Allocating memory failed!\n");
		exit(EXIT_FAILURE);
	}

	// calculate size for all entries
	Uint16 index = SDL_SwapLE16( ((Uint16*) MapFiledata)[0]);
	for(i = 1; i < NumTilesets; i++) {
		Uint16 tmp = SDL_SwapLE16( ((Uint16*) MapFiledata)[i]);
		Tileset[i-1].NumTiles = tmp - index;
		index = tmp;
	}
	Tileset[NumTilesets-1].NumTiles = (MapFilesize/2) - index;

	for(i = 0; i < NumTilesets; i++) {

		if((Tileset[i].TileIndex = (Uint16*) malloc(sizeof(Uint16)*Tileset[i].NumTiles)) == NULL) {
			fprintf(stdout,"Mapfile: Allocating memory failed!\n");
			exit(EXIT_FAILURE);
		}

		index = SDL_SwapLE16( ((Uint16*) MapFiledata)[i]);

		if((unsigned int)MapFilesize < (index+Tileset[i].NumTiles)*2 ) {
			fprintf(stdout,"Mapfile: This *.map-File is too short!\n");
			exit(EXIT_FAILURE);
		}

		// now we can read in
		for(unsigned int j = 0; j < Tileset[i].NumTiles; j++) {
			Tileset[i].TileIndex[j] = SDL_SwapLE16( ((Uint16*) MapFiledata)[index+j]);
		}
	}
	free(MapFiledata);
	// reading MAP-File is now finished

	// check if we can access first section in ICN-File
	if(IcnFilesize < 0x20) {
		fprintf(stdout, "ERROR: Invalid ICN-File: No SSET-Section found!\n");
		exit(EXIT_FAILURE);
	}

	SSET = IcnFiledata+0x18;

	// check SSET-Section
	if(		(SSET[0] != 'S')
		||	(SSET[1] != 'S')
		||	(SSET[2] != 'E')
		||	(SSET[3] != 'T')) {
		fprintf(stdout, "ERROR: Invalid ICN-File: No SSET-Section found!\n");
		exit(EXIT_FAILURE);
	}

	SSET_Length = SDL_SwapBE32( *((Uint32*) (SSET + 4))) - 8;
	SSET += 16;

	if(IcnFiledata + IcnFilesize < SSET + SSET_Length) {
		fprintf(stdout, "ERROR: Invalid ICN-File: SSET-Section is bigger than ICN-File!\n");
		exit(EXIT_FAILURE);
	}

	RPAL = SSET + SSET_Length;

	// check RPAL-Section
	if(		(RPAL[0] != 'R')
		||	(RPAL[1] != 'P')
		||	(RPAL[2] != 'A')
		||	(RPAL[3] != 'L')) {
		fprintf(stdout, "ERROR: Invalid ICN-File: No RPAL-Section found!\n");
		exit(EXIT_FAILURE);
	}

	RPAL_Length = SDL_SwapBE32( *((Uint32*) (RPAL + 4)));
	RPAL += 8;

	if(IcnFiledata + IcnFilesize < RPAL + RPAL_Length) {
		fprintf(stdout, "ERROR: Invalid ICN-File: RPAL-Section is bigger than ICN-File!\n");
		exit(EXIT_FAILURE);
	}

	RTBL = RPAL + RPAL_Length;

	// check RTBL-Section
	if(		(RTBL[0] != 'R')
		||	(RTBL[1] != 'T')
		||	(RTBL[2] != 'B')
		||	(RTBL[3] != 'L')) {
		fprintf(stdout, "ERROR: Invalid ICN-File: No RTBL-Section found!\n");
		exit(EXIT_FAILURE);
	}

	RTBL_Length = SDL_SwapBE32( *((Uint32*) (RTBL + 4)));
	RTBL += 8;

	if(IcnFiledata + IcnFilesize < RTBL + RTBL_Length) {
		fprintf(stdout, "ERROR: Invalid ICN-File: RTBL-Section is bigger than ICN-File!\n");
		exit(EXIT_FAILURE);
	}

	NumFiles = SSET_Length / ((SIZE_X * SIZE_Y) / 2);

	if(RTBL_Length < NumFiles) {
		fprintf(stdout, "ERROR: Invalid ICN-File: RTBL-Section is too small!\n");
		exit(EXIT_FAILURE);
	}
}

/// Destructor
/**
	Frees all memory.
*/
Icnfile::~Icnfile()
{
	for(int i = 0; i < NumTilesets; i++) {
		free(Tileset[i].TileIndex);
	}
	free(Tileset);

	free(IcnFiledata);
}

/// Returns one tile in the icn-File
/**
	This method returns a SDL_Surface containing the nth tile/picture in the icn-File.
	The returned SDL_Surface should be freed with SDL_FreeSurface() if no longer needed.
	\param	IndexOfFile	specifies which tile/picture to return (zero based)
	\return	nth tile/picture in this icn-File
*/
SDL_Surface* Icnfile::getPicture(Uint32 IndexOfFile) {
	SDL_Surface * pic;

	if(IndexOfFile >= NumFiles) {
		return NULL;
	}

	// check if palette is in range
	if(RTBL[IndexOfFile] >= RPAL_Length / 16) {
		return NULL;
	}

	unsigned char* palettestart = RPAL + (16 * RTBL[IndexOfFile]);

	unsigned char * filestart = SSET + (IndexOfFile * ((SIZE_X * SIZE_Y)/2));

	// create new picture surface
	if((pic = SDL_CreateRGBSurface(SDL_HWSURFACE,SIZE_X,SIZE_Y,8,0,0,0,0))== NULL) {
		return NULL;
	}

	SDL_SetColors(pic, palette->colors, 0, palette->ncolors);
	SDL_LockSurface(pic);

	//Now we can copy to surface
	unsigned char *dest = (unsigned char*) (pic->pixels);
	unsigned char pixel;
	for(int y = 0; y < SIZE_Y;y++) {
		for(int x = 0; x < SIZE_X; x+=2) {
			pixel = filestart[ (y*SIZE_X + x) / 2];
			pixel = pixel >> 4;
			dest[x] = palettestart[pixel];

			pixel = filestart[ (y*SIZE_X + x) / 2];
			pixel = pixel & 0x0F;
			dest[x+1] = palettestart[pixel];
		}
		dest += pic->pitch;
	}

	SDL_UnlockSurface(pic);

	return pic;
}

/// Returns an array of pictures in the icn-File
/**
	This method returns a SDL_Surface containing multiple tiles/pictures. Which tiles to include is specified by MapfileIndex. The
	MapfileIndex specifies the tileset. One tileset constists of multiple tiles of the icn-File.
	The last 3 parameters specify how to arrange the tiles:
	 - If all 3 parameters are 0 then a "random" layout is choosen, which should look good.
	 - If tilesX and tilesY is set to non-zero values then the result surface contains tilesX*tilesY tiles and this tilesN-times side by side.
	 - If all there parameters are non-zero then the result surface is exactly in this arrangement.

	tilesX*tilesY*tilesN must always the number of tiles in this tileset. Otherwise NULL is returned.<br><br>
	Example:
	\code
	Tileset = 10,11,12,13,14,15,16,17,18,19,20,21
	tilesX = 2; tilesY = 2; tilesN = 3

	returned picture:
	 10 11 14 15 18 19
	 12 13 16 17 20 21
	\endcode
	<br>
	The returned SDL_Surface should be freed with SDL_FreeSurface() if no longer needed.
	\param	MapfileIndex	specifies which tileset to use (zero based)
	\param	tilesX			how many tiles in x direction
	\param	tilesY			how many tiles in y direction
	\param	tilesN			how many tilesX*tilesY blocks in a row
	\return	the result surface with tilesX*tilesY*tilesN tiles
*/
SDL_Surface* Icnfile::getPictureArray(Uint32 MapfileIndex, int tilesX, int tilesY, int tilesN) {
	SDL_Surface * pic;

	if(MapfileIndex >= NumTilesets) {
		return NULL;
	}

	if((tilesX == 0) && (tilesY == 0) && (tilesN == 0)) {
		// guest what is best
		int tmp = Tileset[MapfileIndex].NumTiles;
		if(tmp == 24) {
			// special case (radar station and light factory)
			tilesX = 2;
			tilesY = 2;
			tilesN = 6;
		} else if((tmp % 9) == 0) {
			tilesX = 3;
			tilesY = 3;
			tilesN = tmp / 9;
		} else if((tmp % 6) == 0) {
			tilesX = 3;
			tilesY = 2;
			tilesN = tmp / 6;
		} else if((tmp % 4) == 0) {
			tilesX = 2;
			tilesY = 2;
			tilesN = tmp / 4;
		} else if((tmp>=40) && ((tmp % 5) == 0)) {
			tilesX = tmp/5;
			tilesY = 5;
			tilesN = 1;
		} else {
			tilesX = 1;
			tilesY = 1;
			tilesN = tmp;
		}

	} else if( ((tilesX == 0) || (tilesY == 0)) && (tilesN == 0)) {
		// not possible
		return NULL;
	} else if((tilesX == 0) && (tilesY == 0) && (tilesN != 0)) {
		if(Tileset[MapfileIndex].NumTiles % tilesN == 0) {
			// guest what is best
			int tmp = Tileset[MapfileIndex].NumTiles / tilesN;
			if((tmp % 3) == 0) {
				tilesX = tmp/3;
				tilesY = 3;
			} else if((tmp % 2) == 0) {
				tilesX = tmp/2;
				tilesY = 2;
			} else {
				tilesX = tmp;
				tilesY = 1;
			}
		} else {
			// not possible
			return NULL;
		}
	} else {
		if((unsigned int)tilesX*tilesY*tilesN != Tileset[MapfileIndex].NumTiles) {
			return NULL;
		}
	}

	// create new picture surface
	if((pic = SDL_CreateRGBSurface(SDL_HWSURFACE,SIZE_X*tilesX*tilesN,SIZE_Y*tilesY,8,0,0,0,0))== NULL) {
		return NULL;
	}

	SDL_SetColors(pic, palette->colors, 0, palette->ncolors);
	SDL_LockSurface(pic);

	int Tileidx=0;
	for(int n = 0; n < tilesN; n++) {
		for(int y = 0; y < tilesY; y++) {
			for(int x = 0; x < tilesX; x++) {
				int IndexOfFile = Tileset[MapfileIndex].TileIndex[Tileidx];

				// check if palette is in range
				if(RTBL[IndexOfFile] >= RPAL_Length / 16) {
					SDL_UnlockSurface(pic);
					SDL_FreeSurface(pic);
					return NULL;
				}

				unsigned char* palettestart = RPAL + (16 * RTBL[IndexOfFile]);
				unsigned char * filestart = SSET + (IndexOfFile * ((SIZE_X * SIZE_Y)/2));

				//Now we can copy to surface
				unsigned char *dest = (unsigned char*) (pic->pixels) + (pic->pitch)*y*SIZE_Y + (x+n*tilesX) * SIZE_X;
				unsigned char pixel;
				for(int y = 0; y < SIZE_Y;y++) {
					for(int x = 0; x < SIZE_X; x+=2) {
						pixel = filestart[ (y*SIZE_X + x) / 2];
						pixel = pixel >> 4;
						dest[x] = palettestart[pixel];

						pixel = filestart[ (y*SIZE_X + x) / 2];
						pixel = pixel & 0x0F;
						dest[x+1] = palettestart[pixel];
					}
					dest += pic->pitch;
				}

				Tileidx++;
			}
		}
	}

	SDL_UnlockSurface(pic);

	return pic;
}

/// Returns a row of pictures in the icn-File
/**
	This method returns a SDL_Surface containing multiple tiles/pictures. The returned surface contains all
	tiles from StartIndex to EndIndex.
	The returned SDL_Surface should be freed with SDL_FreeSurface() if no longer needed.
	\param	StartIndex		The first tile to use
	\param	EndIndex		The last tile to use
	\return	the result surface with (EndIndex-StartIndex+1) tiles. NULL on errors.
*/
SDL_Surface* Icnfile::getPictureRow(Uint32 StartIndex, Uint32 EndIndex) {
	SDL_Surface * pic;

	if((StartIndex >= NumFiles)||(EndIndex >= NumFiles)||(StartIndex > EndIndex)) {
		return NULL;
	}

	Uint32 NumTiles = EndIndex - StartIndex + 1;
	// create new picture surface
	if((pic = SDL_CreateRGBSurface(SDL_HWSURFACE,SIZE_X*NumTiles,SIZE_Y,8,0,0,0,0))== NULL) {
		return NULL;
	}

	SDL_SetColors(pic, palette->colors, 0, palette->ncolors);
	SDL_LockSurface(pic);

	for(Uint32 i = 0; i < NumTiles; i++) {
		int IndexOfFile = i+StartIndex;

		// check if palette is in range
		if(RTBL[IndexOfFile] >= RPAL_Length / 16) {
			SDL_UnlockSurface(pic);
			SDL_FreeSurface(pic);
			return NULL;
		}

		unsigned char* palettestart = RPAL + (16 * RTBL[IndexOfFile]);
		unsigned char * filestart = SSET + (IndexOfFile * ((SIZE_X * SIZE_Y)/2));

		//Now we can copy to surface
		unsigned char *dest = (unsigned char*) (pic->pixels) + i*SIZE_X;
		unsigned char pixel;
		for(int y = 0; y < SIZE_Y;y++) {
			for(int x = 0; x < SIZE_X; x+=2) {
				pixel = filestart[ (y*SIZE_X + x) / 2];
				pixel = pixel >> 4;
				dest[x] = palettestart[pixel];

				pixel = filestart[ (y*SIZE_X + x) / 2];
				pixel = pixel & 0x0F;
				dest[x+1] = palettestart[pixel];
			}
			dest += pic->pitch;
		}
	}

	SDL_UnlockSurface(pic);
	return pic;
}
