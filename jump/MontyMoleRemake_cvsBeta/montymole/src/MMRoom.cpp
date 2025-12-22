/*****************************************************************************

	CLASS		: MMRoom
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	surface for creating and displaying MM room
						Holds a child surface which loads in the BMP "tiles.bmp"

	CREATED	:	26/10/01
	UPDATES	: 16/01/02 - 	Renamed from MMroom to MMRoom, as MS isn't case
											  sensitive.. Very slack..

*****************************************************************************/

#include "MMRoom.h"



/*****************************************************************************

	NAME	: Create

	DESCR.: Simple create to set up child surfaces

	ENTRY	:

	EXIT	:

*****************************************************************************/

bool MMRoom::Create(SDL_Surface *parent)
{
	bool		bSuccess = false;

	if(KSurface::Create(parent, SDL_HWSURFACE, 
											MM_SCREEN_POS_X, MM_SCREEN_POS_Y, 
											MM_ROOM_WIDTH,MM_ROOM_HEIGHT, 16))
	{
		if(CreateChildBMP("data/tiles.bmp") &&
			 CreateChildBMP("data/room2c.bmp")   )
			bSuccess = true;
	}

	return bSuccess;
}




/*****************************************************************************

	NAME	:

	DESCR.:

	ENTRY	:

	EXIT	:

*****************************************************************************/

bool MMRoom::DrawLayout(PCROOM *room)
{
	bool		bSuccess = false;
	int			x,y,
					posX, posY,
								tile;
	Uint8					*layout = room->layout;
	SDL_Surface		*lpTiles;
	SDL_Rect			rcTile,
								rcDest;

	lpTiles = ((KSurface*)GetAt(0))->GetSurface();
	SDL_FillRect(lpSurface, NULL, 0x111000);
	/*
			ROOM 2C IS BLITTED AS A SIMPLE SURFACE.. 
			THE TILES ARE ONLY USED FOR FLOOR DETECTION
	*/
	if(room->tileIndex == MM_PC_ROOM_2C)
	{
		SDL_Rect rc = {0x20, 0x00, 0,0};
		SDL_BlitSurface(((KSurface*)GetAt(1))->GetSurface(), NULL, lpSurface, &rc);
	}
	else
		/* WHERE AS THE OTHER ROOMS ARE DRAWING USING THE TILES */
	{	
		posY=0;
		for(y=0; y<MM_ROOM_TILES_DOWN*MM_TILE_HEIGHT; y+=MM_TILE_HEIGHT)
		{
			posX=0;
			for(x=0; x<MM_ROOM_TILES_ACROSS*MM_TILE_WIDTH; x+=MM_TILE_WIDTH)
			{
				tile = (*layout++)+1;		// add 1 as first tile is always the coal bitmap
				rcTile.x = tile * MM_TILE_WIDTH;
				rcTile.y = room->tileIndex * MM_TILE_HEIGHT;
				rcTile.w = MM_TILE_WIDTH;
				rcTile.h = MM_TILE_HEIGHT;

				rcDest.x = x;
				rcDest.y = y;
				SDL_BlitSurface(lpTiles, &rcTile, lpSurface, &rcDest);
			}
		}
	} /* END TEST FOR ROOM 2C */

	return bSuccess;
}


