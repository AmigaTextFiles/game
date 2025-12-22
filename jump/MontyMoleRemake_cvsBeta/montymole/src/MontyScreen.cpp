
/*!

	\author Kevan Thurstans

	\brief Main video surface
	This object creates all the main game objects within.

						

	\date 03/12/01
	\note	29/02/02 - Added helper objects and collection by Monty.<BR>
				07/03/02 - Added slider detection and killer collision.<BR>
				15/03/02 - Found monty was bumping into disabled killers.
									 I am now testing to see if object has been disabled
									 Before collision...<BR>
				21/03/02 - Add new object 'house', which is the miners house.
									 This is the last to be drawn, so anything under neath 
									 is hidden. This is hidden in any other room.<BR>
				25/03/02 - Added flags & FLAG_BUCKET.. These set points in game.
									 MMROOMTEST array holds tests to run in specified rooms
									 which will check these flags and change killers status
									 if true...<BR>

*/


#include <string.h>
#include "MontyScreen.h"
#include "KFile.h"
#include "MontyMap.h"
#include "KSurface.h"
#include "MMRoomTests.h"
#include "MMRoom.h"

#ifdef ISS_OS
#include <stdio.h>
#endif


//////////////////////////////////////////////////////////////////////
// Construction/Destruction
//////////////////////////////////////////////////////////////////////

MontyScreen::MontyScreen()
{
		keyPressed=false;
		roomData = NULL;

		lpRoom = NULL;
		lpCrusher = NULL;
		lpHelper = NULL;
		lpSlider = NULL;
		lpMonty = NULL;

		hiScore=0;
		strcpy(hiStr, "HI-000000");
}

MontyScreen::~MontyScreen()
{
	if(lpRoom)
		delete lpRoom;

	if(roomData != NULL)			// Delete Room Data (includes wall data too)
		delete roomData;
}


/*!
		\brief Create all of the game objects.

		@return bool - everything created ok.
*/

bool MontyScreen::Create()
{
	KFile		file;
	int			l;
	bool bSuccess = false;

	lastError = ERR_CANT_CREATE_SURFACE;

#ifdef ISS_OS
	printf("MontyScreen::Create()\n");
#endif

	if(KScreen::Create(WINDOW_WIDTH, WINDOW_HEIGHT, 16, SDL_HWSURFACE |  SDL_DOUBLEBUF | SDL_NOFRAME /*| SDL_FULLSCREEN*/))
	{
		lastError = ERR_NO_ERROR;		// assume no errors....

																// For each group of objects we attempt to create
		if(    (lpRoom = new MMRoom()) == NULL
			  || (lpCrusher = new MMCrusher()) == NULL
		    || (lpHelper = new MMHelper()) == NULL
		    || (lpSlider = new MMSlider()) == NULL
		    || (lpMonty = new MMMonty()) == NULL
				|| (lpHouse = new MMObject()) == NULL
       )
		{
			lastError = ERR_OUT_OF_MEMORY;
		}
		else
		{

			if(lpRoom->Create(lpSurface) == false)
			{
				lastError = ERR_NO_ROOM;
#ifdef ISS_OS
				printf("Unable to create Room data\n");
#endif
			}
			else
			{
				if(lpHelper->Create(lpSurface, "data/helpers.bmp"))
				{
					 AddPtr((long)lpHelper);
				}
				else
					 lastError = ERR_NO_HELPER;

				if(lpSlider->Create(lpSurface, "data/slider.bmp"))
				{
					AddPtr((long)lpSlider);
				}
				else
					lastError = ERR_NO_SLIDER;

				if(lpMonty->Create(lpSurface, "data/monty.bmp"))
				{
					AddPtr((long)lpMonty);
					lpMonty->Init();
				}
				else
					lastError = ERR_NO_MONTY;
		 
				if(lpCrusher->Create(lpSurface, "data/crusher.bmp"))
				{
					 AddPtr((long)lpCrusher);
				}
				else
					 lastError = ERR_NO_CRUSHER;

				for(l=0; l<MM_ORIG_COALS; l++)
				{
					if( (lpCoal[l] = new MMCoal()) != NULL)
					{
					  if(lpCoal[l]->Create(lpSurface, ((KSurface*)lpRoom->GetAt(0))->GetSurface()))
					  {
							AddPtr((long)lpCoal[l]);
						}
						else
						{
							delete lpCoal[l];
						 lastError = ERR_NO_COAL;
						}
					}
					else
						lastError = ERR_OUT_OF_MEMORY;
				}
				/******************** CREATE KILLERS AND ADD TO LIST ************************/
				if( (lpKiller[0] = new MMKiller()) != NULL)
				{
					if(lpKiller[0]->Create(lpSurface, "data/killers.bmp"))
					{
						AddPtr((long)lpKiller[0]);

						for(l=1; l<MM_KILLERS_PER_ROOM; l++)
							if( (lpKiller[l] = new MMKiller()) != NULL)
							{ /************************************************************/
								if(lpKiller[l]->Create(lpSurface, lpKiller[0]->GetSurface()))
								{
									AddPtr((long)lpKiller[l]);
								}
								else
								{ ///////////////////////////////
									delete lpKiller[l];
									lastError = ERR_NO_KILLERS;
								} ///////////////////////////////
							} /************************************************************/
							else
								lastError = ERR_OUT_OF_MEMORY;
					} // END new killer
				}
				else
					lastError = ERR_NO_KILLERS;
				/***************************************************************************/
				
				// Create object for the miners house.. Using BMP loaded
				// into lpRoom object. This must be last object added
				// So it is the last to be drawn
				SDL_Rect rect = {MM_SCREEN_POS_X+0x20, MM_SCREEN_POS_Y, 0x38, 0xE0}; 
				if(lpHouse->Create(lpSurface, ((KSurface*)(lpRoom->GetAt(1)))->GetSurface() , &rect))
					AddPtr((long)lpHouse);
				else
					lastError = ERR_NO_HOUSE;

				if(file.Open("data/mm.bin", KFile::READONLY))
				{
					lpDataBank = (char*)file.LoadAll();
					roomData = (PCROOM*)lpDataBank;
					char	*lp = (char*)((PCROOM*)(roomData+MM_NO_OF_ROOMS));
					noOfWalls = *(Uint16*)(lp);
					lpWalls = (MMWALLDATA*)(lp+sizeof(Uint16));
					noOfRoomTests = *(Uint16*)((MMWALLDATA*)(lpWalls+noOfWalls));
					MMROOMTEST *lpRoomTestData = (MMROOMTEST*)((char*)
						                             ((MMWALLDATA*)(lpWalls+noOfWalls))
																				 +(sizeof(Uint16)));
					lpRoomTests = new MMRoomTests(noOfRoomTests, lpRoomTestData);
				}
				else
					lastError = ERR_NO_DATA;

				if(lastError == ERR_NO_ERROR)
					bSuccess = true;
			}
		 }
	}
	
	return bSuccess;
}




/*!

		\brief New Game.

		Resets certain stats and scores for a new game.

*/

void MontyScreen::NewGame()
{

	// Reset all coals to not collected
	for(int coals=0; coals < MM_COALS_IN_TOTAL; coals++)
		coalCollected[coals] = false; 
	

	lpMonty->Init();

	room = MM_ROOM_2C; // Where we start from
	score = 0;			// reset score	
	strcpy(scoreStr, "SCORE-000000");
	noOfCoalsCollected = 29;
	nextWall = 0;
	flags = 0;
	death = false;
	NewRoom(room);

}


/*!

	\brief Handle Events.

	Handle any events passed from main function.

	@param SDL_Event			*event - Event structure

*/

void  MontyScreen::HandleEvent(SDL_Event *event)
{
	static int keyDn = 0;
	int					key = event->key.keysym.sym;

	lpMonty->KeyDn(event);

	if(event->type == SDL_KEYDOWN && keyDn!=key )
	{
		keyDn = key;
		if(key == SDLK_F1)
		{
			room++;
			if(room>21)
				room=0;
			NewRoom(room);
		}

		if(key == SDLK_F2)
			death=false;
	}

	if(event->type == SDL_KEYUP && key == keyDn)
		keyDn=0;
}


/*
		\brief Main update method
*/

void MontyScreen::Update()
{
	static int top = 0;
	int killer,
			linkObj;
	int	exit=-1;

	KJLine		montyBase = lpMonty->GetBaseLine();

	// Here we need to check for a room test and
	// act on it if the flag condition matches too...
	int roomTest = lpRoomTests->TestRoom(room);

	if(roomTest != MMRoomTests::NO_ROOM_FOUND)
	{
		if(lpRoomTests->TestFlag(roomTest, flags))
		{
			lpRoomTests->DoKillers(roomTest, lpKiller);
		}
	}

	lpCrusher->Move();
	lpSlider->Move();

	exit = lpMonty->Move(&currentRoom, lpSlider->Collision( montyBase ));

	if(exit>-1)
	{
		room=exit;
		NewRoom(exit);
	}

	lpRoom->Update();

	UpdateScore(scoreStr);

	KJPos	pos={MM_SCORE_POS_X, MM_SCORE_POS_Y};
	textStream.Print(scoreStr, &pos);
	pos.x = MM_HI_POS_X;
	pos.y = MM_HI_POS_Y;
	if(score>hiScore)
		hiScore=score;
	UpdateScore(hiStr);
	textStream.Print(hiStr, &pos);
	pos.x = MM_LIVES_X;
	pos.y = MM_LIVES_Y;
	textStream.Print("LIVES : 3     ROOM : ", &pos);
	textStream.Print(currentRoom.id);

  pos.x = 0x30;
	pos.y = MM_LIVES_Y;
  textStream.Print(VERSION_STRING, &pos);
	textStream.Print(" ");
	textStream.Print(death);
	lpMonty->debug(&textStream);
	//textStream.Print("M:",&pos);
	//textStream.Print(montyBase.y1);
	//textStream.Print("-");
	//textStream.Print(lpKiller[0x00]->Under(montyBase));

	KScreen::Update();

	SDL_Rect	Rect = lpMonty->GetDestRect();

	for(killer=0;killer<MM_KILLERS_PER_ROOM; killer++)
	{
		if((linkObj = lpKiller[killer]->Move()) != MM_KILLER_NO_LINK)
			lpKiller[linkObj]->SetStatus(MMKiller::STATUS_LINKED);

		// See if monty has landed directly on top of an object
		if(lpKiller[killer]->Under(montyBase))
		{
			lpMonty->StopFalling();
			lpMonty->StopDownJumping();
		}
		else
			// TEST COLLISION BETWEEN KILLER AND MONTY
			if(lpKiller[killer]->InRect(&Rect) && 
				 (lpKiller[killer]->GetStatus() & 0x03) != MMKiller::STATUS_DISABLED)	
			{																			// Monty has touched a killer
				if(lpMonty->ObjectCollected() || (lpKiller[killer]->GetStatus() & MMKiller::STATUS_NO_KILL))			
				{																		// Monty has the helper so we are immune
					if(room == MM_ROOM_2C)
						SetFlag(FLAG_BUCKET);

					lpKiller[killer]->Kill();
					lpMonty->SetObjectFlag(false);
				}
				else
				{
					//! \todo Add monty's death animation and loss of life.
					death = true;
				}
			} // ENDIF test collision
			/////////////////////////////////////////////
	}

	// TEST FOR CRUSHER COLLISION
	death |= (lpCrusher->InRect(&Rect) && lpCrusher->GetDirection() == MMCrusher::DOWN);

	// TEST FOR WATER ................... AND FALLEN A LONG WAY
	death |= lpMonty->StandingOnWater() | lpMonty->FallenToDeath();


	for(int coal=0; coal<MM_COALS_PER_ROOM; coal++)
		if(lpCoal[coal]->InRect(&Rect))
		{
			CollectCoal(coal);
		}

	if(lpHelper->InRect(&Rect))			// if Monty picks up helper object
	{
		lpHelper->Show(false);				// set helper to be hidden.. Which tells us
		lpMonty->SetObjectFlag();			// we now have collected object
																	// this gives us tempory immunity to killers
		score+=30;										// monty has the helper when needed
	}
}




/*!

	\brief New Room

	We have moved to a new room, so update all the info...

	@param int			iRoom - room number we are now in

*/

void MontyScreen::NewRoom(int iRoom)
{
	int killer;

	cls();
	currentRoom = roomData[iRoom];

	lpRoom->DrawLayout(&currentRoom);
	lpHelper->Init(&(currentRoom.helper));
	lpSlider->Init(&(currentRoom.slider));

	// Check for each coal has not been collected..
	// If not initialise it to display
	// else hide it away
	// Only do if monty has the bucket...
	if(TestFlag(FLAG_BUCKET))
		for(int coal=0; coal<MM_ORIG_COALS; coal++)
		{
			lpCoal[coal]->Init(&(currentRoom.coal[coal]), iRoom);
			if(lpCoal[coal]->Visible() == KSurface::MODE_SHOW)
				lpCoal[coal]->Show( !coalCollected[ lpCoal[coal]->GetIndex()] );
		}

	lpCrusher->Init(&(currentRoom.crusher));

	for(killer=0;killer<MM_KILLERS_PER_ROOM; killer++)
		lpKiller[killer]->Init(&(currentRoom.killers[killer]));

	lpMonty->SetObjectFlag(false);	// clear object flag when entering room

	// Check for need of house...
	lpHouse->Show(iRoom == MM_ROOM_2C);
		
}




/*!

		\brief Update Score

		Update score into string and display.

		@param char *scoreStr - string conataining new score value. 

*/

void MontyScreen::UpdateScore(char *scoreStr)
{
	char					zeroStr[] = "***********";
	int						zeroLen,
								scoreLen;

	sprintf(zeroStr, "%d", score);
	scoreLen = strlen(scoreStr);
	zeroLen = strlen(zeroStr);
	scoreStr[scoreLen-zeroLen]=(char)0;
	strcat(scoreStr, zeroStr);



}



/*!

		\brief	Collect Coal.
						Pickup a coal and check for any walls to destroy.

		@param int			index - coal object we want

*/

void MontyScreen::CollectCoal(int index)
{
	coalCollected[ lpCoal[index]->GetIndex() ] = true;
	noOfCoalsCollected++;
	lpCoal[index]->Show(false);
	score +=10;

	// Check for walls
	if(lpWalls[nextWall].room == room &&  noOfCoalsCollected > lpWalls[nextWall].noOfCoals )
	{
		int		tilePos = lpWalls[nextWall].wall.x+(MM_ROOM_TILES_ACROSS * lpWalls[nextWall].wall.y);

		for(int dn=0; dn<lpWalls[nextWall].wall.h; dn++, tilePos += MM_ROOM_TILES_ACROSS)
			currentRoom.layout[tilePos] = 0x00;
		
		nextWall++;

		lpRoom->DrawLayout(&currentRoom);
	}

}

