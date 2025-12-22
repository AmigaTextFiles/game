

#ifndef __MMROOMTESTS_H
#define __MMROOMTESTS_H

#include "MMDataDefs.h"
#include "MMKiller.h"

class MMRoomTests 
{

public:

	MMRoomTests(Uint16 maxTests, MMROOMTEST* lpRoomTestData);
	~MMRoomTests();

	enum {NO_ROOM_FOUND = -1 };
	int		TestRoom(int room);

	bool	TestFlag(int index, Uint16 flags);
	void	DoKillers(int index, MMKiller *lpKillers[]);

protected:
	Uint16			noOfTests;
	MMROOMTEST	*lpRoomTests;
};

#endif
