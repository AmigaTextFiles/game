/*****************************************************************************

	CLASS		: MontyMap
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Converts Monty Mole data to PC version.

	CREATED	:	21/10/01
	UPDATES	: 25/03/02	-	Added Room Test data.. Allows me to add some of the
												hard coded stuff from the original game...

*****************************************************************************/

#include <SDL/SDL.h>
#include "MontyMap.h"
#include "MMKiller.h"


#define		MM_MEM		0x3fe5
#define		MM_ROOMOFFSET		0x9A2A - MM_MEM

MontyMap::MontyMap()
{
	lpSnap =NULL;
	LoadSnap("data/monty.sna");
}


MontyMap::~MontyMap()
{
	if(lpSnap)
		delete lpSnap;
}


bool MontyMap::LoadSnap(const char *szFilename)
{
	FILE	*fptr;
	bool	fSuccess = false;

	if(fptr = fopen(szFilename, "rb"))
	{
		if(lpSnap = new Uint8[MONTYMOLE_SNAP_SIZE])
		{
			if(fread(lpSnap, sizeof(char), MONTYMOLE_SNAP_SIZE, fptr)>0)
			{
				fSuccess = true;
			}
			else
				delete lpSnap;
		}

	}

	return fSuccess;
}



MMROOM*	MontyMap::GetRoomData(int roomIndex)
{
	MMROOM	*room = NULL;
	
	if(lpSnap != NULL)
		room = (MMROOM*) &lpSnap[0x9A2A - MM_MEM];

	return &room[roomIndex];
}


void MontyMap::InitRoom2C()
{
	static	int	room2c = MM_ROOM_2C;

	newData[room2c].tiles[TILE_ZERO]=0;
	newData[room2c].tiles[TILE_SOLID]=1;
	newData[room2c].tiles[TILE_SOLID_EXTRA]=8;
	newData[room2c].tiles[TILE_KILLER]=5;
	newData[room2c].tiles[TILE_ROPE]=6;
	newData[room2c].tiles[TILE_ROPE_EXTRA]=7;

	newData[room2c].slider.leftX = 0;
	newData[room2c].slider.leftY = 0;
	newData[room2c].slider.rightX = 0;
	newData[room2c].slider.rightY = 0;
	// Bucket
	newData[room2c].killers[0].status = MMKiller::STATUS_NO_KILL;
	newData[room2c].killers[0].frame[MM_KILLERS_UP] = 0x00;
	newData[room2c].killers[0].frame[MM_KILLERS_DN] = 0x00;
	newData[room2c].killers[0].frame[MM_KILLERS_LEFT] = 0x3f;
	newData[room2c].killers[0].frame[MM_KILLERS_RIGHT] = 0x3f;
	newData[room2c].killers[0].x = 0x30;
	newData[room2c].killers[0].y = 0x4F;
	newData[room2c].killers[0].linkObj=0;
	newData[room2c].killers[0].direction=0;
	newData[room2c].killers[0].countStart = 0x20;
	newData[room2c].killers[0].animCounter=0;
	newData[room2c].killers[0].counter=0x20;
	newData[room2c].killers[0].velocity=0;
	// Squirrel
	newData[room2c].killers[1].frame[MM_KILLERS_UP] = 0x05;
	newData[room2c].killers[1].frame[MM_KILLERS_DN] = 0x05;
	newData[room2c].killers[1].frame[MM_KILLERS_LEFT] = 0x05;
	newData[room2c].killers[1].frame[MM_KILLERS_RIGHT] = 0x05;
	newData[room2c].killers[1].x = 0x84;
	newData[room2c].killers[1].y = 0xAF;
	newData[room2c].killers[1].status = 0;
	newData[room2c].killers[1].linkObj=0;
	newData[room2c].killers[1].direction=2;
	newData[room2c].killers[1].countStart = 0x06;
	newData[room2c].killers[1].animCounter=0;
	newData[room2c].killers[1].counter=0x06;
	newData[room2c].killers[1].velocity=1;

	// Acorn
	newData[room2c].killers[2].frame[MM_KILLERS_UP] = 0x06;
	newData[room2c].killers[2].frame[MM_KILLERS_DN] = 0x06;
	newData[room2c].killers[2].frame[MM_KILLERS_LEFT] = 0x04;
	newData[room2c].killers[2].frame[MM_KILLERS_RIGHT] = 0x04;
	newData[room2c].killers[2].x = 0x68;
	newData[room2c].killers[2].y = 0xA8;
	newData[room2c].killers[2].status = MMKiller::STATUS_NO_ANIM | MMKiller::STATUS_LINKED;
	newData[room2c].killers[2].linkObj=3;
	newData[room2c].killers[2].direction=1;
	newData[room2c].killers[2].countStart = 0x58;
	newData[room2c].killers[2].animCounter=0;
	newData[room2c].killers[2].counter=0x58;
	newData[room2c].killers[2].velocity=1;

	// Acorn smash
	newData[room2c].killers[3].frame[MM_KILLERS_UP] = 0x06;
	newData[room2c].killers[3].frame[MM_KILLERS_DN] = 0x06;
	newData[room2c].killers[3].frame[MM_KILLERS_LEFT] = 0x04;
	newData[room2c].killers[3].frame[MM_KILLERS_RIGHT] = 0x04;
	newData[room2c].killers[3].x = 0x68;
	newData[room2c].killers[3].y = 0x50;
	newData[room2c].killers[3].status = 3;
	newData[room2c].killers[3].linkObj=2;
	newData[room2c].killers[3].direction=1;
	newData[room2c].killers[3].countStart = 0x06;
	newData[room2c].killers[3].animCounter=0;
	newData[room2c].killers[3].counter=0x06;
	newData[room2c].killers[3].velocity=0;
	
	// Miner upper
	newData[room2c].killers[4].frame[MM_KILLERS_UP] = 0x01;
	newData[room2c].killers[4].frame[MM_KILLERS_DN] = 0x01;
	newData[room2c].killers[4].frame[MM_KILLERS_LEFT] = 0x01;
	newData[room2c].killers[4].frame[MM_KILLERS_RIGHT] = 0x01;
	newData[room2c].killers[4].x = 0x10;
	newData[room2c].killers[4].y = 0x60;
	newData[room2c].killers[4].status = 3;
	newData[room2c].killers[4].linkObj=0;
	newData[room2c].killers[4].direction=3;
	newData[room2c].killers[4].countStart = 0xD0;
	newData[room2c].killers[4].animCounter=0;
	newData[room2c].killers[4].counter=newData[room2c].killers[4].countStart;
	newData[room2c].killers[4].velocity=1;
	// Miner lower
	newData[room2c].killers[5].frame[MM_KILLERS_UP] = 0x02;
	newData[room2c].killers[5].frame[MM_KILLERS_DN] = 0x02;
	newData[room2c].killers[5].frame[MM_KILLERS_LEFT] = 0x02;
	newData[room2c].killers[5].frame[MM_KILLERS_RIGHT] = 0x02;
	newData[room2c].killers[5].x = 0x10;
	newData[room2c].killers[5].y = 0x50;
	newData[room2c].killers[5].status = 3;
	newData[room2c].killers[5].linkObj=0;
	newData[room2c].killers[5].direction=3;
	newData[room2c].killers[5].countStart = 0xD0;
	newData[room2c].killers[5].animCounter=0;
	newData[room2c].killers[5].counter=newData[room2c].killers[5].countStart;
	newData[room2c].killers[5].velocity=1;

	newData[room2c].exit[0]=0x00;
	newData[room2c].exit[1]=0x00;
	newData[room2c].exit[2]=0x00;
	newData[room2c].exit[3]=0x00;
	

}


#define	  MM_PIXEL_WIDTH					0x02		// no of pixels on PC per pixel on spectrum
#define   MM_PIXEL_HEIGHT					0x02
#define		MM_SHIFT_PIXEL_WIDTH		0x01		// shift for quick calculation
#define		MM_SHIFT_PIXEL_HEIGHT		0x01

void MontyMap::DrawTile(SDL_Surface *lpSurf, int x, int y, int w, int h, Uint8 *data)
{
	int					px, py, chr, col, 
							plotX,
							iBmpW = w<<MM_SHIFT_PIXEL_WIDTH,
							iBmpH = h<<MM_SHIFT_PIXEL_WIDTH;
	Uint8				byte,
							mask;
	SDL_Rect		plot;

	for(py=0; py<iBmpH; py+=2)
	{
		plotX = x;
		for(chr=0; chr<(w>>3); chr++)
		{
			byte = *data++;
			mask= (char)0x80;

			for(px=0; px<0x10; px+=2)
			{
				plot.x = plotX;
				plot.y = y+py;
				plot.w = 2;
				plot.h = 2;

				plotX+=2;
				if(byte & mask)
					col = 0xFFFF;
				else
					col = 0x00;

				SDL_FillRect(lpSurf, &plot, col);
				mask =mask>>1;
			}
		}
	}
}


/*****************************************************************************

	NAME	: Expand Layout

	DESCR.: Expand room layout data into bytes.
					Monty Mole use 3 bits per tile to encode it's layout data.
					We don't need to do this as we aren't limited in memory.

	ENTRY	:

	EXIT	:

*****************************************************************************/

// Masks used when extracting encoded tiles data
enum { 
				MM_TILE1 = 0xE0, 
				MM_TILE2 = 0x1C,
				MM_TILE3 = 0x03,
				MM_TILE3a= 0x80,
				MM_TILE4 = 0x70,
				MM_TILE5 = 0x0E,
				MM_TILE6 = 0x01,
				MM_TILE6a= 0xC0,
				MM_TILE7 = 0x38,
				MM_TILE8 = 0x07,

				MM_TILE_SHIFT1 = 5,
				MM_TILE_SHIFT2 = 2,
				MM_TILE_SHIFT3 = 1,
				MM_TILE_SHIFT3a= 7,
				MM_TILE_SHIFT4 = 4,
				MM_TILE_SHIFT5 = 1,
				MM_TILE_SHIFT6 = 2,
				MM_TILE_SHIFT6a= 6,
				MM_TILE_SHIFT7 = 3,
 };



void MontyMap::CopyCrusher(MMCRUSHER *crusher, MMCRUSHER *src)
{
	crusher->x = src->x;
	crusher->y = src->y;
	crusher->lowY= src->lowY;								// Y pos when at lowest
	crusher->countdown=src->countdown;					// count down to next crush
	crusher->direction = src->direction;						// direction of movement
	crusher->startY = src->startY;								// Y start position
}


void MontyMap::CopyHelper(MMHELPER *helper, MMHELPER *src)
{
	helper->x = src->x;
	helper->y = src->y;
	helper->index = src->index;
}


void MontyMap::CopyKillers(PCKILLER *killer, MMKILLER *src)
{
	killer->status = src->status;
	killer->frame[MM_KILLERS_UP] = MM_KILLER_FRAME_TO_INDEX(src->frame[0],src->frame[1]);
	killer->frame[MM_KILLERS_DN] = MM_KILLER_FRAME_TO_INDEX(src->frame[2],src->frame[3]);
	killer->frame[MM_KILLERS_LEFT] = MM_KILLER_FRAME_TO_INDEX(src->frame[4],src->frame[5]);
	killer->frame[MM_KILLERS_RIGHT] = MM_KILLER_FRAME_TO_INDEX(src->frame[6],src->frame[7]);
	killer->linkObj = src->linkObj;
	killer->direction = src->direction;
	killer->x=src->x;
	killer->y=src->y;
	killer->countStart=src->countStart;
	killer->animCounter=src->animCounter;
	killer->counter=src->counter;
	killer->velocity=src->velocity;
}


void MontyMap::CopySlider(PCSLIDER *slider, MMSLIDER *src)
{
  slider->direction = src->direction;
  slider->leftX= src->leftX;
  slider->leftY= src->leftY;
  slider->leftStartX= src->leftStartX;
  slider->leftEndX= src->leftEndX;
  slider->rightX= src->rightX;
  slider->rightY= src->rightY;

}


void MontyMap::CopyCoals(PCCOAL *coal, MMCOAL *src)
{
	coal->x = src->x;
	coal->y = src->y;
	coal->index = src->index;
}



void MontyMap::CopyRoom(MMROOM *roomSrc, int room)
{
	int loop;
	// Copy other bits of room data across to new data
	CopyCrusher(&(newData[room].crusher), &roomSrc->crusher);
	CopyHelper(&(newData[room].helper), &roomSrc->helper);
	CopySlider(&(newData[room].slider), &roomSrc->slider);

	for(loop=0; loop< MM_KILLERS_PER_ROOM; loop++)
		CopyKillers(&(newData[room].killers[loop]), &(roomSrc->killers[loop]));

	// Corrections...
	if(room == 0x0A)
	{
		newData[room].killers[0x02].x = 40;
		newData[room].killers[0x02].y = 111;
		newData[room].killers[0x03].y = 0xAF;
	}

	for(loop=0; loop<MM_ORIG_COALS; loop++)
		CopyCoals(&(newData[room].coal[loop]), &(roomSrc->coal[loop]));

	for(loop=0; loop<4; loop++)
	{
		if(roomSrc->exit[loop] == 44)
			newData[room].exit[loop] = 21;
		else
			newData[room].exit[loop] = roomSrc->exit[loop];
	}	

	{
		/*! 
				\brief which tile is of which type
				Each row is a room and each column is the
				index of the tile that evals to the type.
				( 0xFF = IGNORE }
		*/
		const int type[][TILE_SIZEOF] = 
		{
				{ 0,1,2,5,7,6,0xff,0xff }, /* 0 */
				{ 0,1,2,5, 0xFF ,6, 4, 7 },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff }, /* 10 */
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,1,2,5,7,6,0xff,0xff },
				{ 0,3,4,5,7,6,0xff,0xff },
				{ 0,3,4,5,7,6,0xff,0xff },
				{ 0,3,4,5,7,6,0xff,0xff },
				{ 0,3,4,5,7,6,0xff,0xff },
				{ 0,3,4,5,7,6,0xff,0xff },
				{ 0,3,4,5,7,6,0xff,0xff }, /* 20 */
				{ 0,1,2,3,4,5,0xff,0xff },
				/*Z S S K R R H    H */
		};			 

		newData[room].tiles[TILE_ZERO]= type[room][0];
		newData[room].tiles[TILE_SOLID]=type[room][1];
		newData[room].tiles[TILE_SOLID_EXTRA]=type[room][2];
		newData[room].tiles[TILE_KILLER]= type[room][3];
		newData[room].tiles[TILE_ROPE]=type[room][4];
		newData[room].tiles[TILE_ROPE_EXTRA]=type[room][5];
		newData[room].tiles[TILE_HANG] = type[room][6];		
		newData[room].tiles[TILE_HANG_EXTRA] = type[room][7];
		newData[room].id = room;
	}


}


void MontyMap::ExpandLayout()
{
	Uint32	b1,b2,b3;				// original data
	Uint16	count;
	Uint8		*dataSrc,
					*dataDest;
	MMROOM	*roomSrc;
	int	room;

	for(room = 0; room < MM_NO_OF_ROOMS-1; room++)
	{
		count = 0x00;											// number of bytes so far;
		roomSrc = GetRoomData(room);
		newData[room].tileIndex = room;
		CopyRoom (roomSrc, room);

		dataDest = newData[room].layout;
		dataSrc =	roomSrc->layout;	// Get room data

		while(count < MM_PC_ROOM_BYTES)
		{
			b1 = *dataSrc++ ;		// Get next three bytes in layout
			b2 = *dataSrc++;
			b3 = *dataSrc++;

			dataDest[count++] =	(b1 & MM_TILE1) >> MM_TILE_SHIFT1; 
			dataDest[count++] =	(b1 & MM_TILE2) >> MM_TILE_SHIFT2; 
			dataDest[count++] =	((b1 & MM_TILE3) << MM_TILE_SHIFT3) 
				                | ((b2 & MM_TILE3a) >> MM_TILE_SHIFT3a); 
			dataDest[count++] =	(b2 & MM_TILE4) >> MM_TILE_SHIFT4; 
			dataDest[count++] =	(b2 & MM_TILE5) >> MM_TILE_SHIFT5;											
			dataDest[count++] =	(b2 & MM_TILE6) << MM_TILE_SHIFT6
				                | (b3 & MM_TILE6a) >> MM_TILE_SHIFT6a;
			dataDest[count++] =	(b3 & MM_TILE7) >> MM_TILE_SHIFT7; 
			dataDest[count++] =	(b3 & MM_TILE8); 
		}
	}

	// Recreate room 2C....
	int data[] = { 
									0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
									0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,2,3,3,0,0,0,0,3,4,0,0,0,0,0,0,
									0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,1,1,1,1,1,0,0,
									0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,5,5,5,5,5,5,5,1,1,1,1,1,0,0,
									0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
									0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
									0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,
									0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0   };

	newData[room].tileIndex = room;
	newData[room].crusher.x=0;
	newData[room].crusher.y=0;
	newData[room].helper.index=0;

	if(lpSnap != NULL)
	{
		dataSrc = &lpSnap[MM_ROOM_2C_DATA];
		CopyRoom((MMROOM*)dataSrc, room);
	}

	for(int y=0; y< MM_TILES_PER_ROOM; y++)
	{ 
		newData[room].layout[y]=data[y];
	}

	CreateWalls();
	CreateRoomTests();
	Corrections();
}


/*****************************************************************************

	NAME	: Convert Room tiles To Surface

	DESCR.: Converts the monty room tile graphics into a 16 bit
					surface bitmap

	ENTRY	:	const char		*strFilename	-	name of file to save as

	EXIT	: bool												- TRUE ok.

*****************************************************************************/
bool	MontyMap::ConvertRoomTilesToBMP(const char *strFilename)
{
	MMROOM				*room;							// struct of room data
	SDL_Surface		*lpBitmapSurf;			// surface to draw to and save
	bool					bSuccess = false;		// return value

	if(lpSnap == NULL)
		return false;

	if(lpBitmapSurf = SDL_CreateRGBSurface(SDL_HWSURFACE, 
																					(49)*MM_TILE_WIDTH, 
																					MM_NO_OF_ROOMS*MM_TILE_HEIGHT, 
																					16, 
																					0, 0, 0, 0)		)
	{	// created surface go on to draw...
		for(int i=0; i<MM_NO_OF_ROOMS-1; i++)
		{
			room = GetRoomData(i);
			DrawTile(lpBitmapSurf, 0,i*MM_TILE_WIDTH, 0x08, 0x08, room->coalBitmap);

			for(int l=0; l<MM_ORIG_BITSPERSCAN; l++)
				DrawTile(lpBitmapSurf, (l*MM_TILE_WIDTH)+MM_TILE_WIDTH, 
																			i*MM_TILE_HEIGHT, 
																			0x08, 0x08,
																			room->tile[l].bitmap);
		}

		// save room 2C tiles onto seperate bitmap...
		// add these to above surface...
		ConvertSpectrumSpritesToBMP(0x7c00, "tiles2.bmp", 1, 48, 0x08, 0x08); 

		// now attempt to save
		if(SDL_SaveBMP(lpBitmapSurf, strFilename) == 0)
			bSuccess = true;

		SDL_FreeSurface(lpBitmapSurf);
	}

	return bSuccess;
}



/*****************************************************************************

	NAME	: Convert Spectrum Sprites To BMP

	DESCR.: Convert a group of spectrum sprites into a BMP file.
					The BMP is made up of the different sprites in rows
					and the frames of each sprite laid out in columns.
					Sprites need to run consecutively and not have mask data
					embedded into it....
					Sprites are expanded to double width & height.

	ENTRY	: int			iAddr					- true address of data
									iNoOfSprites	-	no of sprites
									iNoOfFrames		- no of frames per sprite
									w							-	width &
									h							- height of each frame

	EXIT	: bool									- return value.

*****************************************************************************/

bool	MontyMap::ConvertSpectrumSpritesToBMP(int iAddr, const char *strFilename,
																						int iNoOfSprites, 
																						int iNoOfFrames, int w, int h)
{
	if(lpSnap == NULL)
		return false;


	int						iBmpW = (w<<1),
								iBmpH = (h<<1);
	Uint8					*lpSpData = &lpSnap[iAddr-MM_MEM];
	SDL_Surface		*lpBitmapSurf;			// surface to draw to and save
	bool			bSuccess = false;

	if(lpBitmapSurf = SDL_CreateRGBSurface(SDL_HWSURFACE, 
																					iNoOfFrames*(w<<1), 
																					iNoOfSprites*(h<<1), 
																					16, 
																					0, 0, 0, 0)		)
	{	// created surface go on to draw...
		for(int sprites=0x00; sprites<iNoOfSprites; sprites++)
			for(int frames=0x00; frames<iNoOfFrames; frames++)
			{
				DrawTile(lpBitmapSurf, frames*iBmpW,sprites*iBmpH, w, h, (Uint8*)lpSpData);
				lpSpData += (w>>3)*h;
			}

		// now attempt to save
		if(SDL_SaveBMP(lpBitmapSurf, strFilename) == 0)
			bSuccess = true;

		SDL_FreeSurface(lpBitmapSurf);
	}

	
	return bSuccess;
}


#include "KFile.h"

void MontyMap::Save()
{
	KFile		file;
	long		length = sizeof(PCROOM);

	if(lpSnap != NULL)
		if(file.Open("data/mm.bin", KFile::WRITE))
		{
			file.Save((char*)newData, sizeof(PCROOM)*MM_NO_OF_ROOMS);
			file.Save((char*)&noOfWalls, sizeof(Uint16));
			file.Save((char*)wall, sizeof(MMWALLDATA)*noOfWalls);
			file.Save((char*)&noOfRoomTests, sizeof(Uint16));
			file.Save((char*)roomTests, sizeof(MMROOMTEST)*noOfRoomTests);

			file.Close();
		}
}



/*****************************************************************************

		NAME	: Create Walls

		DESCR.: These are the walls that dissapear when the right amount of 
						coals have been collected...

		ENTRY	: 

		EXIT	: 

	*****************************************************************************/

void MontyMap::CreateWalls()
{
	noOfWalls = 0x04;

	wall[0x00].room = 6;
	wall[0x00].noOfCoals = 14;
	wall[0x00].wall.x = 16;
	wall[0x00].wall.y = 3;
	wall[0x00].wall.w = 1;
	wall[0x00].wall.h = 7;

	wall[0x01].room = 11;
	wall[0x01].noOfCoals = 31;
	wall[0x01].wall.x = 20;
	wall[0x01].wall.y = 4;
	wall[0x01].wall.w = 1;
	wall[0x01].wall.h = 5;

	wall[0x02].room = 15;
	wall[0x02].noOfCoals = 43;
	wall[0x02].wall.x = 31;
	wall[0x02].wall.y = 13;
	wall[0x02].wall.w = 1;
	wall[0x02].wall.h = 5;

	wall[0x03].room = 20;
	wall[0x03].noOfCoals = 56;
	wall[0x03].wall.x = 24;
	wall[0x03].wall.y = 7;
	wall[0x03].wall.w = 1;
	wall[0x03].wall.h = 4;

}



/*****************************************************************************

		NAME	: Create Room Tests

		DESCR.: Creates room test data...
						Each test happens in a specified room and tests against
						MontyScreen flags..

		ENTRY	: 

		EXIT	: 

	*****************************************************************************/

void MontyMap::CreateRoomTests()
{
	noOfRoomTests = MM_NO_OF_ROOM_TESTS;

	roomTests[0x00].room = MM_ROOM_2C;
	roomTests[0x00].flagToTest = 1;
	roomTests[0x00].killer1 = 4;
	roomTests[0x00].newStatus1 = 0;
	roomTests[0x00].killer2 = 5;
	roomTests[0x00].newStatus2 = 0;

	roomTests[0x01].room = 0;
	roomTests[0x01].flagToTest = 1;
	roomTests[0x01].killer1 = 2;
	roomTests[0x01].newStatus1 = 0;
	roomTests[0x01].killer2 = 3;
	roomTests[0x01].newStatus2 = 0;
}


void MontyMap::Corrections()
{
	// Miner in room 0
	newData[0x00].killers[0x02].y = 0x38;
	newData[0x00].killers[0x03].y = 0x28;
}
