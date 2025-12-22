

#ifndef __MONTYMAP_H
#define __MONTYMAP_H

#include "MMDataDefs.h"

#define		MM_MEM		0x3fe5
#define		MM_NO_OF_ROOM_TESTS		0x02

class MontyMap
{

public:
	MontyMap();
	~MontyMap();

	bool	LoadSnap(const char *szFilename);	// Load original image of game.
	void	ExpandLayout();
	bool	ConvertRoomTilesToBMP(const char *strFileName);
	bool	ConvertSpectrumSpritesToBMP(int iAddr, const char *strFilename, 
																		int iNoOfSprites, 
																		int iNoOfFrames, 
																		int w, int h);

	MMROOM*	GetRoomData(int roomIndex);

	void	DrawTile(SDL_Surface *lpSurf, int x, int y, int w, int h, Uint8 *data);
	void	TestDraw(SDL_Surface *lpSurface, int iRoom);
	void	Save();

	void	CreateWalls();
	void CopyRoom(MMROOM *roomSrc, int room);
	void CopyCrusher(MMCRUSHER *crusher, MMCRUSHER *src);
	void CopyHelper(MMHELPER *helper, MMHELPER *src);
	void CopyKillers(PCKILLER *killers, MMKILLER *src);
	void CopySlider(PCSLIDER *slider, MMSLIDER *src);
	void CopyCoals(PCCOAL *coal, MMCOAL *src);

	void		InitRoom2C();
	void		CreateRoomTests();
	void		Corrections();

private:

	Uint8*				lpSnap;		// snap image of original game
	PCROOM				newData[MM_NO_OF_ROOMS];
	Uint16				noOfWalls;
	MMWALLDATA		wall[MM_WALLS_MAX];
	Uint16				noOfRoomTests;
	MMROOMTEST		roomTests[MM_NO_OF_ROOM_TESTS];

};


#endif
