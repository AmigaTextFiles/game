/*!

	\author Kevan Thurstans

	\brief Surface class handling the MONTY MOLE.
						
	\date 03/12/01
*/

#ifndef __MMMONTY_H
#define __MMMONTY_H


#include "MMObject.h"
#include "MMDataDefs.h"

#define	MM_MONTY_WIDTH				0x20	// Size in pixels
#define MM_MONTY_HEIGHT				0x20
#define MM_MONTY_FRAMES				0x04	// Number of frames per animation
#define	MM_MONTY_FRAMES_START	0x00	// start of frame graphic on surface
#define MM_MONTY_FRAMES_MAX		MM_MONTY_WIDTH * MM_MONTY_FRAMES
#define MM_MONTY_START_X			0xE0
#define MM_MONTY_START_Y			0x4E

#define MM_MONTY_MOVE_MULTIPLY		0x01	// amount to shift vector by..

#define	MM_MONTY_JUMP_LEN					0x1F		// number of counts monty jumps for..
#define MM_MONTY_JUMP_HALFWAY			MM_MONTY_JUMP_LEN/2

class MMMonty : public MMObject
{

public:

	MMMonty();
	void Init();
	int	 Move(PCROOM *lpRoom, bool onSlider);											
	void KeyDn(SDL_Event *event);
	void CheckBG();										// test background against monty

	void		debug(KJText *iostream);

	void		SetObjectFlag(bool set=true);
	bool		ObjectCollected() { return (flag & OBJECT)!=0; };

	KJLine	GetBaseline();				// get points under monty's feet

	inline	void		StopFalling() { state &= ~FALLING; };
					void		StopDownJumping();
	inline  bool		FallingFromJump() { return ((state & JUMPING) && jumpCnt>0x0E); };
					bool		StandingOnWater();
	inline	bool		FallenToDeath() { return longFall ; };
  inline  void		StopJumping()		{ state &= ~JUMPING; };

protected:

	void	GetBehind(PCROOM *lpRoom);		// pass room data to create behind map

	enum		 {	// *** MONTY'S CURRENT STATE / FLAGS***
							BIT_CLEAR = 0x00,
							INIT = 0x00,
							FALLING = 0x01,
							JUMPING = 0x02,
							ROPE = 0x04,
							HANGING = 0x08,
							OBJECT = 0x10,
							ATTR_RIGHT = 0x20,
							ATTR_LEFT = 0x40,
							ATTR_FEET = 0x80,
							ATTR_HEAD = 0x100,
							// KEY BITS
							NO_KEY_PRESSED = 0,
							KEY_UP = 0x01,
							KEY_DN = 0x02,
							KEY_LEFT = 0x04,
							KEY_RIGHT = 0x08,
							KEY_JUMP = 0x10,
							KEY_MASK = 0x0F,

							MAX_FALL = 0x20,
							SPEED = 1  // number of shifts to speed up monty
	};

	enum			{ // JUMPING DATA 
							NOT_JUMPING =  0,
							LEFT = 3,		// BEST NOT CHANGE THE ORDER OF THESE!!!!
							UP = 4,
							RIGHT = 5
	};



	int					animRow,				// which row of animation frames to use
							animCounter;

	int					keys;						// last keys pressed
	int					jumpState;
	int					jumpCnt;				// Frame count when jumping

	// ----- FALLING DATA -----
	enum				{ FALLING_ZERO, FALLING_SPEED=2, FALLING_DEATH=0x10 };
	int					fallCnt;				// Count how far we have fallen

	int					state;					// current state of movement
	Uint16			flag;
	bool				longFall;

	// Array for storing which collitions monty is having
	        // Normal testing behind body...
	enum	{ TILE_TEST_HEAD, TILE_TEST_FEET, TILE_TEST_LEFT, TILE_TEST_RIGHT, TILE_TEST_COUNT,
					// These are for testing under the feet
		      TILE_UNDER_FEET = TILE_TEST_COUNT, TILE_UNDER_FEET1, TILE_UNDER_FEET2, 
					TILE_UNDER_FEET3, TILE_UNDER_FEET4,
					// size of whole array
					TILE_TEST_SIZEOF };
	int		tileTest[TILE_TEST_SIZEOF];

	
	enum { 
					MONTY_DIR_STATIONARY = 0,
					MONTY_DIR_LEFT = -1,
					MONTY_DIR_RIGHT = 1,
					MONTY_DIR_UP = -1,
					MONTY_DIR_DOWN=1,
					MONTY_ROW_JUMP = 0,
					MONTY_ROW_CLIMB = 0,
					MONTY_ROW_LEFT = MM_MONTY_HEIGHT, 
					MONTY_ROW_RIGHT = MM_MONTY_HEIGHT*2,
					MONTY_ROW_HANG = MM_MONTY_HEIGHT*3,		// 19/09/02 - Added Monty's ability to hang onto pipes...

					MONTY_ANIM_COUNT = 4,
	
					BH_TOP_LEFT = 0x00,		// indexes of tiles behind array..
					BH_LEFT_1 = 0x04,
					BH_TOP_HEAD1 = 0x01,	// tiles above the head
					BH_TOP_HEAD2,
					BH_BODY_RIGHT_TOP = 0x06,
					BH_BODY_RIGHT_BOTTOM = 0x0A,
					BH_RIGHT_1 = 0x07,
					BH_LEFT_2 = 0x08,
					BH_RIGHT_2 = 0x0B,
					BH_BOTTOM_LEFT = 0x0C,
					BH_BOTTOM_FEET1,
					BH_BOTTOM_FEET2,
					BH_BOTTOM_RIGHT
			};

	int	iDebug;
};

#endif

/*!@}*/
