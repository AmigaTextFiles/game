#ifndef __MONTYSCREEN_H
#define __MONTYSCREEN_H


#include "KScreen.h"
#include "KSurface.h"
#include "MontyMap.h"
#include "MMDataDefs.h"
#include "MontyMap.h"
#include "MMRoom.h"
#include "MMCrusher.h"
#include "MMHelper.h"
#include "MMKiller.h"
#include "MMSlider.h"
#include "MMCoal.h"
#include "MMMonty.h"
#include "MMRoomTests.h"



class MontyScreen : public KScreen  
{
public:
	MontyScreen();
	virtual ~MontyScreen();

	bool	Create();
	void	NewGame();
	void	Update();
	void	NewRoom(int iRoom);	
	void	HandleEvent(SDL_Event *event);


	enum { ERR_NO_CRUSHER = KScreen::ERR_USER_DEFINE,
				 ERR_NO_HELPER,
				 ERR_NO_SLIDER,
				 ERR_NO_KILLERS,
				 ERR_NO_COAL,
				 ERR_NO_MONTY,
				 ERR_NO_ROOM,
				 ERR_NO_DATA,
				 ERR_NO_HOUSE
	};


private:

	void		CollectCoal(int index);		// Collect a coal and do checks


	MMRoom			*lpRoom;
	MMCrusher		*lpCrusher;
	MMHelper		*lpHelper;
	MMSlider		*lpSlider;
	MMKiller		*lpKiller[MM_KILLERS_PER_ROOM];
	MMCoal			*lpCoal[MM_COALS_PER_ROOM];
	MMMonty			*lpMonty;
	MMObject		*lpHouse;	// Miners house

	MMRoomTests	*lpRoomTests;
	Uint16			noOfRoomTests;
	bool				keyPressed,
							death;							//  Has been touched by the kiss of death 
	int					room;


	enum {													// FLAGS USED BY GAME
							FLAG_BUCKET=1				// MONY HAS BUCKET FLAG
				};
	Uint16			flags;							// above describes flags

	inline	void	SetFlag(Uint16 flag) { flags |= flag; };
	inline  void  ClrFlag(Uint16 flag) { flags &= ~flag; };
	inline  bool  TestFlag(Uint16 flag) { return (flags & flag)!=0x00; };


	bool				coalCollected[MM_COALS_IN_TOTAL];
	Uint16			noOfCoalsCollected;
	char				*lpDataBank;
	PCROOM			*roomData;							// Room Data converted from original MM
	PCROOM			currentRoom;
	Uint16			noOfWalls;
	MMWALLDATA	*lpWalls;								// Dissapearing wall data
	Uint8				nextWall;								// index of wall to check next..

	Uint16	score,
					hiScore;
	char		scoreStr[0x20],
					hiStr[0x20];

	void		UpdateScore(char *scoreStr);
};

#endif

