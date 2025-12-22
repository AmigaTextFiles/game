/*****************************************************************************

	CLASS		: MMRoomTests
	AUTHOR	:	Kevan Thurstans

	DESCR.	:	Runs tests for occurence in certain rooms
						

	CREATED	:	25/03/02
	UPDATES	:	

*****************************************************************************/


#include "MMRoomTests.h"

MMRoomTests::MMRoomTests(Uint16 maxTests, MMROOMTEST* lpRoomTestData)
{
	lpRoomTests = lpRoomTestData;
	noOfTests = maxTests;
}



MMRoomTests::~MMRoomTests()
{

}


int MMRoomTests::TestRoom(int room)
{
	for(int i=0; i<noOfTests; i++)
		if(room == lpRoomTests[i].room)
			return i;

	return NO_ROOM_FOUND;
}


bool MMRoomTests::TestFlag(int index, Uint16 flags)
{
	// If the flag value stored in data has bee nset in flags
	// return true value
	return (flags & lpRoomTests[index].flagToTest) != 0;
}


void	MMRoomTests::DoKillers(int index, MMKiller *lpKillers[])
{
	Uint16		killer1 = lpRoomTests[index].killer1,
						killer2 = lpRoomTests[index].killer2;

	lpKillers[killer1]->SetStatus(lpRoomTests[index].newStatus1);
	lpKillers[killer1]->Show(true);
	lpKillers[killer2]->SetStatus(lpRoomTests[index].newStatus2);
	lpKillers[killer2]->Show(true);
}