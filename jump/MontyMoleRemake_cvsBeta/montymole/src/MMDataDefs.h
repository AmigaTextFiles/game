/*****************************************************************************

	CLASS		: MMdataDefs.h
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Main header file for monty mole..
						

	CREATED	:	03/12/01
	UPDATES	:	25/03/2	-	Add MMROOMTEST structure for certain room cases..

*****************************************************************************/


#ifndef __MMDATADEFS_H
#define __MMDATADEFS_H

#include <SDL/SDL.h>

#define	VERSION_STRING				"V1.2.8"
#define	MONTYMOLE_SNAP_SIZE		0xFFFF

#define	WINDOW_WIDTH					640
#define WINDOW_HEIGHT					480
#define	WINDOW_SPECCY_WIDTH		0x200
#define WINDOW_SPECCY_HEIGHT	0x180

#define	MM_SCREEN_POS_X				(WINDOW_WIDTH - WINDOW_SPECCY_WIDTH)/2
#define MM_SCREEN_POS_Y				((WINDOW_HEIGHT - WINDOW_SPECCY_HEIGHT)/2)+0x10

#define	MM_EXIT_LEFT					62		// Pixel position of exits
#define	MM_EXIT_UP						62
#define	MM_EXIT_RIGHT					544
#define	MM_EXIT_DOWN					356
enum	{ MM_EXIT_UP_VAL = 1,			// values set when testing for exit
	  MM_EXIT_DOWN_VAL,
	  MM_EXIT_LEFT_VAL,
	  MM_EXIT_RIGHT_VAL
	};

#define   MM_SPECCY_HEIGHT			WINDOW_SPECCY_HEIGHT
#define   MM_SPECCY_WIDTH				WINDOW_SPECCY_WIDTH
#define	  MM_SCREEN_ADJUST_Y		MM_SPECCY_HEIGHT-0x20

#define	  MM_ROOM_WIDTH					WINDOW_SPECCY_WIDTH
#define	  MM_ROOM_HEIGHT				0x140

																// CONVERT ORIGINAL SPECTRUM POSITIONS TO SDL SURFACE
																// STANDARD
#define		MM_Y_POS_TO_SDL(y)		(MM_SCREEN_POS_Y-3) + (MM_SCREEN_ADJUST_Y - ((int)(y)<<1))
#define   MM_X_POS_TO_SDL(x)		(MM_SCREEN_POS_X+ (int(x)<<1))

																// CONVERT OBJECTS POSITION INTO TILE POSITIONS
#define		MM_MAIN_SURFACE_X_POS_TO_TILE_POS(x)	( ( ((Sint16)x)-MM_SCREEN_POS_X)/MM_TILE_WIDTH)
#define		MM_MAIN_SURFACE_Y_POS_TO_TILE_POS(y)	( ( ((Sint16)y)-MM_SCREEN_POS_Y-0x20)/MM_TILE_HEIGHT)


#define		MM_SCORE_POS_X				MM_SCREEN_POS_X
#define		MM_SCORE_POS_Y				MM_SCREEN_POS_Y - 0x20
#define		MM_HI_POS_X						MM_SCREEN_POS_X + 0x170
#define		MM_HI_POS_Y						MM_SCORE_POS_Y
#define		MM_LIVES_X						MM_SCREEN_POS_X+(MM_SPECCY_WIDTH>>1)-(0x10*4);
#define		MM_LIVES_Y						MM_SCREEN_POS_Y+MM_SPECCY_HEIGHT-0x30;

#define		MM_TILE_WIDTH					0x10			// width of PC tile in pixels
#define		MM_TILE_HEIGHT				0x10			// height
	
#define		MM_HELPER_WIDTH				0x20
#define		MM_HELPER_HEIGHT			0x20

#define		MM_NO_OF_ROOMS				0x16		// number of rooms
#define		MM_ROOM_TILES_ACROSS	0x20			// matrix size of room
#define		MM_ROOM_TILES_DOWN		0x14
#define		MM_TILE_WIDTH					0x10			// width of PC tile in pixels
#define		MM_TILE_HEIGHT				0x10			// height
#define		MM_TILES_PER_ROOM			MM_ROOM_TILES_ACROSS*MM_ROOM_TILES_DOWN
#define		MM_ROOM_2C						0x15
#define		MM_ROOM_2C_DATA				0xb5C8
#define		MM_ROOM_2C_YSTART			MM_SCREEN_POS_Y+0xC0
#define		MM_ROOM_00_XSTART			MM_SCREEN_POS_X+0x20
#define		MM_ROOM_00_YSTART			MM_SCREEN_POS_Y+0x110

enum {																		// ***** KILLERS *****
					MM_KILLERS_PER_ROOM	=	0x06,			// Max number of Killers per room
					MM_KILLERS_SP_ADDR	=	0x6000,		// Spectrum start address of killers bitmaps
					MM_KILLERS_UP				= 0,				// The directions that the killers can move in
					MM_KILLERS_DN,
					MM_KILLERS_LEFT,
					MM_KILLERS_RIGHT,
					MM_KILLER_WIDTH_SHIFT = 0x05,
					MM_KILLER_WIDTH = 0x20,
					MM_KILLER_HEIGHT = 0x20,
					MM_KILLER_NO_LINK = -1,

					MM_SLIDER_OPENING = 0x80,
					MM_SLIDER_CLOSING = 0x00,
					MM_COALS_IN_TOTAL = 61,
					MM_COALS_PER_ROOM = 0x05,

					MM_WALLS_MAX = 0x04
			};

																				// Sizes in original data
#define		MM_ORIG_BITSPERSCAN		0x08			// number if bits per line of an original tile graphics
#define		MM_ORIG_ROOM_BYTES		0xF0			// number of bytes in room
#define		MM_ORIG_BLANK1				0x06
#define		MM_ORIG_EXITS					0x04
#define		MM_ORIG_BLANK2				0x0A
#define		MM_ORIG_COAL_BITMAP		0x08
#define		MM_ORIG_COALS					0x05
#define		MM_ORIG_TILES					0x08
#define		MM_ORIG_KILLERS				0x06			// Number of killers per room in original data
#define		MM_ORIG_BLANK3				0x14
											
																					// Size in PC data
#define		MM_PC_ROOM_BYTES			0x280
#define		MM_PC_ROOM_2C					0x15			// room 2c
#define		MM_PC_EXITS						0x04


// These are the tiles we are looking for when testing for collition
enum TILE_TYPES { TILE_ZERO=0, TILE_SOLID, TILE_SOLID_EXTRA, 
                  TILE_KILLER, TILE_ROPE, TILE_ROPE_EXTRA, 
									TILE_HANG, TILE_HANG_EXTRA,
									TILE_SIZEOF, TILE_NONE=0, 
									TILE_FALL_NO_TEST=0xFF };


#define   MM_16BIT_ENDIAN(word)   (Uint18)( (word & 0xFF00)>>0x08) | ((word & 0x00FF) << 0x08)

#define   MM_KILLER_FRAME_TO_INDEX(l,h) ((((Uint16)(h)<<0x08) | l)-0x6000) >> 7
/*****************************************************************************

	The following structures must be kept in the order given here.
	Each one maps to the original data taken from the Spectrum game.

*****************************************************************************/

typedef struct montyHelper								// Helper object data
{
	Uint8	x,y,															// Position on screen
				index;														// Which helper graphic to use
} MMHELPER;



typedef struct montyCrusher								// Crusher details
{
	Uint8	x,y,															// Position
				lowY,															// Y pos when at lowest
				countdown,												// count down to next crush
				direction,												// direction of movement
				startY;														// Y start position
} MMCRUSHER;


typedef struct montyCoal									// Coal data
{
	Uint8	index,
				x,y;
				
} MMCOAL;


typedef struct PCMontyCoal
{
	Uint8	index,
				x,y;
				
} PCCOAL;


typedef struct montyKiller								// KIller data
{
	Uint8		status;
	Uint8		frame[0x08];									// These are 4 words, but due to alignment they
																					// have to be broken up into bytes
	Uint8		attr,
					linkObj,
					direction,
					x,
					y,
					countStart,
					animCounter,
					counter,
					velocity;
	Uint8		padding[0x02];
} MMKILLER;


typedef struct PCmontyKiller						// PC version of data
{
	Uint8		status;
	Uint8		frame[0x08];									// These are 4 words, but due to alignment they
																					// have to be broken up into bytes
	Uint8		attr,
					linkObj,
					direction,
					x,
					y,
					countStart,
					animCounter,
					counter,
					velocity;
	Uint8		startX,
					startY;
} PCKILLER;



typedef struct montySlider								// Sliding floor data
{
	Uint8		leftX,
					leftY,
					leftStartX,
					leftEndX,
					rightX,
					rightY,
					direction;
} MMSLIDER;

typedef struct PCmontySlider								// Sliding floor data
{
	Uint8		leftX,
					leftY,
					leftStartX,
					leftEndX,
					rightX,
					rightY,
					direction,
					padding;
} PCSLIDER;


				
typedef struct montyTile									// room graphic tile data
{
	Uint8	attr,															// Coloured used on spectrum
				bitmap[0x08];											// 8 byte graphic data
} MMTILE;																	///////////////////////////////////////////


typedef struct montyWallData							// WALLS THAT REQUIRE REMOVING
{
	Uint16			room,												// Room to be in
							noOfCoals;									// Number of coals to be collected
	SDL_Rect		wall;												// Rect of wall in tile positions
} MMWALLDATA;															///////////////////////////////////////////



typedef struct montyRoom									// Original room data
{
	Uint8			layout[MM_ORIG_ROOM_BYTES],
						blank1[MM_ORIG_BLANK1],
						exit[MM_ORIG_EXITS];
	MMHELPER	helper;
	MMCRUSHER	crusher;
	Uint8			blank2[MM_ORIG_BLANK2],
						coalBitmap[MM_ORIG_COAL_BITMAP];
	MMCOAL		coal[MM_ORIG_COALS];
	MMTILE		tile[MM_ORIG_TILES];
	MMKILLER	killers[MM_ORIG_KILLERS];
	Uint8			blank3[MM_ORIG_BLANK3];
	MMSLIDER  slider;
	Uint8			padding;
} MMROOM;




typedef struct MontyPCRoom								// Converted Room data
{
	long			tileIndex;										// Which row of tile graphics to use
	Uint8			layout[32*20],
						exit[0x04];
	int				tiles[TILE_SIZEOF];					// Tiles for testing collition (tile index number)
	MMHELPER	helper;												// Structure to helper objects
	MMCRUSHER	crusher;											// Structure holding crusher details
	PCKILLER	killers[MM_KILLERS_PER_ROOM];	// Structure for killer objects
  PCSLIDER	slider;
	PCCOAL		coal[MM_ORIG_COALS];
	Uint8			id;														// Room number ID

} PCROOM;


typedef struct MontyRoomTest
{
	Uint8			room;							// Which room to be in to run test
	Uint16		flagToTest,				// MontyScreen::flags
						killer1,					// Which killer to change when test is true
						newStatus1,
						killer2,					// and another.. set to -1 for nothing
						newStatus2;
} MMROOMTEST;
			


#endif
