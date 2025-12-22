/*! 
	\defgroup MontyMole
	@{
*/

/*!
	\author Kevan Thurstans

	\brief Surface class handling the MONTY MOLE.
						

	\date 03/12/01
	\notes	23/01/02 - Started to add new improved collition for Monty...<BR>
					07/03/02 - Added slider detection and helper object info.<BR>
					19/09/02 - Added Monty's ability to hang onto pipes...<BR>

*/

#include "MMDataDefs.h"
#include "KJ.h"
#include "KJText.h"
#include "MMMonty.h"

#define MM_FIRST_HANGING_ROOM	6
#define MM_LAST_HANGING_ROOM	10


/*!

	\brief Monty constructor.
				 Initilise monty from to first room....

*/

MMMonty::MMMonty()
{
	state = INIT;
	jumpCnt = 0x00;
	jumpState = NOT_JUMPING;
	keys = NO_KEY_PRESSED;
	for(int test=0; test<TILE_TEST_SIZEOF; test++)
		tileTest[test] = 0;
}




/*!

		\brief Init.
					 Initialise Monty's position an start frame

*/

void MMMonty::Init()
{
	animRow = MONTY_ROW_LEFT;
	animCounter=0;
	rcDest.x= MM_X_POS_TO_SDL(MM_MONTY_START_X);	
	rcDest.y = MM_Y_POS_TO_SDL(MM_MONTY_START_Y)-1;
	rcDest.w= MM_MONTY_WIDTH;
	rcDest.h= MM_MONTY_HEIGHT;

	rcSrc.x = animRow;
	rcSrc.y = 0;
	rcSrc.w= MM_MONTY_WIDTH;
	rcSrc.h= MM_MONTY_HEIGHT;
	flag = 0;
	longFall = false;
}


/*!

	\brief Move.
				 Handles crusher movement & timings
				 XX & YY have been set from the event function.
				 This method actually tests to see if we can movein the direction
				 required.

	@param	MontyPCRoom		*lpRoom - address of room object...
	@param	bool					onSlider - TRUE is standing on slider

	@return int

*/

int MMMonty::Move(PCROOM *lpRoom, bool onSlider)
{
	int			exitRight = (lpRoom->id==MM_ROOM_2C)?MM_EXIT_RIGHT-0x20:MM_EXIT_RIGHT;

	static int jumpVector[] = {																				// Holds direction & speed
															4,4,4,4,2,2,4,2,0,2,2,0,2,						// for each move during
															0,0,0,0,0,-2,-2,-2,-2,-2,-2,-2,-2,		// the time monty is jumping.
															-4,-2,-4,-4,-2//															4,4,4,4,2,2,4,2,0,2,2,0,2,						// for each move during
														};

	int		cellModLeft = rcDest.x % 0x10,	// see which edge monty is on within a 8x8 cell
				cellModTop = rcDest.y % 0x10;

	KJPoint	oldPos;
	oldPos.x = rcDest.x;
	oldPos.y = rcDest.y;

	int		xx=0, yy=0;

	if(state & FALLING)					// If state == FALLING
	{
		yy = FALLING_SPEED;
		fallCnt++;
	}
	else
	{
		if(state & JUMPING)
		{
			yy = -jumpVector[jumpCnt++];
			if(jumpCnt == 0x1F)
				state &= ~JUMPING;
			xx = ((jumpState == RIGHT)-(jumpState == LEFT))<<1; //<<SPEED;
		}
		else
			if((keys & KEY_JUMP) && (state & JUMPING)== BIT_CLEAR)
			{
				jumpState = UP+((keys & KEY_RIGHT)!=NO_KEY_PRESSED)-((keys & KEY_LEFT)!=NO_KEY_PRESSED);
				if(jumpState == UP)
					rcSrc.y = MONTY_ROW_JUMP;

				jumpCnt = 0;
				state |= JUMPING;
			}


		if((state & JUMPING)==0)
		{
			if((state & ROPE) || (state & HANGING))	// Override any states if we are on a ROPE / PIPE
			{
				rcSrc.y = MONTY_ROW_JUMP;							// Set monty to jumping graphics
																							// This gets overridden if he is on a PIPE (HANGING)
				if(keys & KEY_DN)											// Allow movement in the Y axis
					yy = 2;
				else
					if(keys & KEY_UP)
						yy = -2;
			}

			if(yy==0)
				xx = (((keys & KEY_RIGHT)!=NO_KEY_PRESSED)-((keys & KEY_LEFT)!=NO_KEY_PRESSED))<<SPEED;
		}


	}// ---- END NOT FALLING ----

	rcDest.x += xx;
	rcDest.y += yy;

	Uint8 exitDir = ((rcDest.x<MM_EXIT_LEFT)*MM_EXIT_LEFT_VAL)
								+ ((rcDest.x>exitRight)*MM_EXIT_RIGHT_VAL)
								+ ((rcDest.y<MM_EXIT_UP)*MM_EXIT_UP_VAL)
								+ ((rcDest.y>MM_EXIT_DOWN)*MM_EXIT_DOWN_VAL);

	// ----- CHECK TO SEE IF MONTY IS LEAVING THE ROOM -----
	if(exitDir)
	{
		int exit = lpRoom->exit[exitDir-1];
		switch(exitDir)
		{
		case MM_EXIT_LEFT_VAL:
			rcDest.x = MM_EXIT_RIGHT;
			break;
		case MM_EXIT_RIGHT_VAL:
			rcDest.x = MM_EXIT_LEFT;
			break;
		case MM_EXIT_UP_VAL:
			rcDest.y = MM_EXIT_DOWN-MM_MONTY_HEIGHT;
			break;
		case MM_EXIT_DOWN_VAL:
			rcDest.y = MM_EXIT_UP;
			break;
		}
		
		if(lpRoom->id == MM_ROOM_2C && exit == 0x00)
		{
			rcDest.y = MM_ROOM_00_YSTART;
			rcDest.x = MM_ROOM_00_XSTART;
		}

		if(exit == MM_ROOM_2C)						// If we are entering room 2c
		{
			rcDest.y = MM_ROOM_2C_YSTART;		// move monty up some
			rcDest.x -= 0x20;								// and move in as well as room 2c is shorter
		}

		return exit;
	}

  GetBehind(lpRoom);						// Set up tileTest variable with what's behind monty

	state &= (JUMPING | OBJECT );	// Reset states that need retesting



	// ----- TEST TO SEE IF ANYTHING IS UNDER MONTY'S FEET -----
	if(tileTest[TILE_UNDER_FEET] == TILE_ZERO && onSlider==false)
	{
	  if((state & JUMPING)==0)
		{
			state |= FALLING;
			longFall |= (fallCnt > MAX_FALL);
			fallCnt=FALLING_ZERO;
		}
	}

	// ----- TEST FOR ROPE -----
	if(tileTest[TILE_TEST_HEAD] == TILE_ROPE || 
		 tileTest[TILE_TEST_HEAD] == TILE_ROPE_EXTRA ||
		 tileTest[TILE_TEST_FEET] == TILE_ROPE || 
		 tileTest[TILE_TEST_FEET] == TILE_ROPE_EXTRA    )
	{
		state |= ROPE;
	}

	// ----- TEST FOR HANGERS -----
	// Certain rooms
	if(lpRoom->id >= MM_FIRST_HANGING_ROOM && lpRoom->id <= MM_LAST_HANGING_ROOM)
	{
		if(tileTest[TILE_TEST_HEAD] == TILE_HANG || 
			 tileTest[TILE_TEST_HEAD] == TILE_HANG_EXTRA ||
			 tileTest[TILE_TEST_LEFT] == TILE_HANG || 
			 tileTest[TILE_TEST_LEFT] == TILE_HANG_EXTRA ||
			 tileTest[TILE_UNDER_FEET] == TILE_HANG || 
			 tileTest[TILE_UNDER_FEET] == TILE_HANG_EXTRA    )
		{
			state = (state & ~FALLING) | HANGING;	// Stop any falling and allow monty to hang...
		}
	}

	// ------ CHECK FOR SOLID WALLS WHEN MOVING LEFT & RIGHT -----
	if( (xx < 0 && (tileTest[TILE_TEST_LEFT] == TILE_SOLID || 
		              tileTest[TILE_TEST_LEFT] == TILE_SOLID_EXTRA)) 
	    ||
		  (xx > 0 && (tileTest[TILE_TEST_RIGHT] == TILE_SOLID || 
			            tileTest[TILE_TEST_RIGHT] == TILE_SOLID_EXTRA))  )
	{
		xx=0;
	}

	// ----- CHECK IF LANDING ON SOMETHING SOLID WHEN -----
	// -----          COMING DOWN FROM A JUMP         -----
		if((state & JUMPING) && jumpCnt>0x0E && (tileTest[TILE_UNDER_FEET] > TILE_ZERO || onSlider==true))
		{
			yy=0;
			state &= ~JUMPING;
		}
		else
			if(
				  (yy>0 && (tileTest[TILE_TEST_FEET] == TILE_SOLID || tileTest[TILE_TEST_FEET] == TILE_SOLID_EXTRA))
				||
					(yy<0 && (tileTest[TILE_TEST_HEAD] == TILE_SOLID || tileTest[TILE_TEST_HEAD] == TILE_SOLID_EXTRA))
				//|| 
				//   onSlider==true
				)
					yy=0;

	// ----- IF WE HAVE MOVEMENT ANIMATE MONTY -----
	if(xx!=0 || yy!=0)
	{
		if(xx < MONTY_DIR_STATIONARY)
			rcSrc.y = MONTY_ROW_LEFT;
		else
			if(xx> MONTY_DIR_STATIONARY)
			rcSrc.y = MONTY_ROW_RIGHT;

		animCounter = (animCounter+1) & 0x01;
		if(animCounter)
		{
			rcSrc.x += MM_MONTY_WIDTH;
			if(rcSrc.x >= MM_MONTY_FRAMES_MAX)
				rcSrc.x=0;
		}

		if(state & HANGING)
			rcSrc.y = MONTY_ROW_HANG;
	}

	// ----- IF SOMETHING STOPS MONTY THEN SET BACK TO OLD POSITION -----
	if(xx==0)
		rcDest.x = oldPos.x;
	if(yy==0)
		rcDest.y = oldPos.y;

	//rcSrc.w= MM_MONTY_WIDTH;
	//rcSrc.h= MM_MONTY_HEIGHT;
	return -1;
}



/*!

		\brief Key down.
					 Pass keyboard events onto object for moving

		@param SDL_Event		*event - event structure

*/

void MMMonty::KeyDn(SDL_Event *event)
{
	switch(event->type)
	{
		case SDL_KEYDOWN:
			switch(event->key.keysym.sym)
			{
			case 'p':
				keys |= KEY_RIGHT;
				break;

			case 'o':
				keys |= KEY_LEFT;
				break;

			case 'q':
				keys |= KEY_UP;
				break;

			case 'a':
				keys |= KEY_DN;
				break;

			case ' ':
				keys |= KEY_JUMP;
			}
			break;

		case SDL_KEYUP:
			switch(event->key.keysym.sym)
			{
			case 'p':
				keys &= ~KEY_RIGHT;
				break;

			case 'o':
				keys &= ~KEY_LEFT;
				break;

			case 'q':
				keys &= ~KEY_UP;
				break;

			case 'a':
				keys &= ~KEY_DN;
				break;

			case ' ':
				keys &= ~KEY_JUMP;
			}
			break;
	}

}




/*!

		\brief Get Behind.

						Test certain points of monty for background tiles.
		        This fills up the tileTest[] array with tiles indexes.
						telling us which tiles are behind monty....
						

		@param PCROOM	*lproom - data to current room

*/

void MMMonty::GetBehind(PCROOM *lpRoom)
{
	int			width = 2+((rcDest.x & 0x0F)!=0),
					height = 2+((rcDest.y & 0x0F)!=0);
	Uint8		*layout = lpRoom->layout;

	int			column  = MM_MAIN_SURFACE_X_POS_TO_TILE_POS(rcDest.x),
					row = MM_MAIN_SURFACE_Y_POS_TO_TILE_POS(rcDest.y),
					tn = column + ( row * MM_ROOM_TILES_ACROSS);

	int		tile;
	int		count;

	// Test by Monty's head, to see if we have collided with a tile
	tileTest[TILE_TEST_HEAD] = TILE_NONE;
	for(count=0; count<width; count++)
		for(tile=TILE_SOLID; tile<TILE_SIZEOF; tile++)
			if(layout[tn+count] == lpRoom->tiles[tile])
			{
				tileTest[TILE_TEST_HEAD] = tile;
				count = width;
				break;
			}

	tileTest[TILE_TEST_FEET] = TILE_NONE;
	int vert = MM_ROOM_TILES_ACROSS << (height-2);
	for(count=0; count<width; count++)
		for(tile=TILE_SOLID; tile<TILE_SIZEOF; tile++)
			if(layout[tn+vert+count] == lpRoom->tiles[tile])
			{
				tileTest[TILE_TEST_FEET] = tile;
				count = width;
				break;
			}

	tileTest[TILE_TEST_LEFT] = TILE_NONE;
	for(count=0; count<height; count++)
		for(tile=TILE_SOLID; tile<TILE_SIZEOF; tile++)
			if(layout[tn+(count*MM_ROOM_TILES_ACROSS)] == lpRoom->tiles[tile])
			{
				tileTest[TILE_TEST_LEFT] = tile;
				count = width;
				break;
			}

	tileTest[TILE_TEST_RIGHT] = TILE_NONE;
	int tn1 = tn+(width-1);
	for(count=0; count<height; count++)
		for(tile=TILE_SOLID; tile<TILE_SIZEOF; tile++)
			if(layout[tn1+(count*MM_ROOM_TILES_ACROSS)] == lpRoom->tiles[tile])
			{
				tileTest[TILE_TEST_RIGHT] = tile;
				count = width;
				break;
			}

	// NOW WE NEED TO SEE WHAT'S UNDER MONTY'S FEET
	tileTest[TILE_UNDER_FEET1] = TILE_ZERO;
	tn+=MM_ROOM_TILES_ACROSS<<1;
	tn1 = tn;
	for(count=0; count<width; count++)	
		for(tile=TILE_SOLID; tile<TILE_SIZEOF; tile++)
			if(layout[tn1+(count*MM_ROOM_TILES_ACROSS)] == lpRoom->tiles[tile])
			{
				tileTest[TILE_UNDER_FEET1+count] = tile;
				count = width;
				break;
			}

	tileTest[TILE_UNDER_FEET] = TILE_ZERO;
	for(count=0; count<width; count++)	
		tileTest[TILE_UNDER_FEET] |= layout[tn++];
}





/*!

	\brief debug
				 Output data through the iostream for debug purposes.

		@param KJText	*iostream - output

*/

void MMMonty::debug(KJText *iostream)
{

	KJPos pos = { 0x20, 0x30 };

	iostream->Print(tileTest[TILE_UNDER_FEET], &pos);
	iostream->Print(" ");
	iostream->Print(tileTest[TILE_UNDER_FEET1]);
	iostream->Print(" ");
	iostream->Print(TILE_KILLER);
	iostream->Print(" : ");
	iostream->Print(ObjectCollected());
	
}



/*!

	\brief Set Object Flag.

	Set / Clears object flag.

	@param bool set: true - set flag <BR> false - clear flag
*/

void MMMonty::SetObjectFlag(bool set /*=true*/)
{
	if(set)
		flag = flag | OBJECT;
	else
		flag = flag & (~OBJECT);
}

																		 


/*!

	\brief Get Base Line.

	Gets the points under monty's feet, as a KJLine object.

	@return KJLine

*/

KJLine MMMonty::GetBaseline()
{
	KJLine	line = {
										rcDest.x,             rcDest.y + rcDest.h+1,
										rcDest.x + rcDest.w,  rcDest.y+rcDest.h+1
									};

	return line;
}


/*!

	\brief Test if standing on water

	Using the tileTest array, this checks for monty on water..

	@return bool true if monty is on water

*/

bool MMMonty::StandingOnWater()
{
	return tileTest[TILE_UNDER_FEET1] == TILE_KILLER;
}



/*!

	\brief Stop Down Jumping.

	See if monty is on way down from jump. If so then stop the jump.

	@param int index - coal object we want

*/

void MMMonty::StopDownJumping()
{
	if((state & JUMPING) && jumpCnt>0x0E)
	{
		StopJumping();
	}
}

/*!@}*/
