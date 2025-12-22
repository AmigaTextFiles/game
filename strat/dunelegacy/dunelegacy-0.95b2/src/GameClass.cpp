/*
 *  This file is part of Dune Legacy.
 *
 *  Dune Legacy is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  Dune Legacy is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Dune Legacy.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <GameClass.h>

#include <globals.h>

#include <FileClasses/DataManager.h>
#include <FileClasses/FontManager.h>
#include <FileClasses/INIFile.h>
#include <FileClasses/music/MusicPlayer.h>
#include <SoundPlayer.h>
#include <misc/FileStream.h>
#include <misc/fnkdat.h>

#include <RadarView.h>
#include <GUI/dune/InGameMenu.h>
#include <Menu/MentatHelp.h>
#include <Menu/BriefingMenu.h>
#include <Menu/MapChoice.h>

#include <AiPlayerClass.h>
#include <PlayerClass.h>
#include <MapClass.h>
#include <BulletClass.h>
#include <Explosion.h>
#include <GameInitClass.h>
#include <ScreenBorder.h>
#include <sand.h>

#include <structures/StructureClass.h>
#include <units/UnitClass.h>
#include <structures/BuilderClass.h>

#include <MapSeed.h>
#include <MapGenerator.h>

#include <SDL.h>

/**
    Default constructor. Afterwards InitGame() or InitReplay() should be called
*/
GameClass::GameClass()
{
	whatNextParam = GAME_NOTHING;

	concreteRequired = true;
	finished = false;

	gameType = ORIGINAL;

	localPlayerName[0] = '\0';
	mapFilename[0] = '\0';

	maxPathSearch = 400;


	attackMoveMode = false;
	builderSelectMode = false;
	groupCreateMode = false;
	messageMode = false;
	moveDownMode = false;
	moveLeftMode = false;
	moveRightMode = false;
	moveUpMode = false;
	placingMode = false;
	shift = false;

	bShowFPS = false;

	radarMode = false;
	selectionMode = false;

	bQuitGame = false;

	bReplay = false;

	indicatorFrame = NONE;
	indicatorTime = 5;
	indicatorTimer = 0;

    pInterface = NULL;
	pInGameMenu = NULL;
	pInGameMentat = NULL;

	InitSettings = NULL;
	NextGameInitSettings = NULL;

	unitList.clear();   	//holds all the units
	structureList.clear();	//all the structures
	bulletList.clear();

	for(int i=0;i<MAX_PLAYERS;i++) {
		player[i] = NULL;
	}

	gamespeed = 15;

	gamebarSurface = pDataManager->getUIGraphic(UI_GameBar);
	gameBarPos.w = gamebarSurface->w;
	gameBarPos.h = gamebarSurface->h;
	gameBarPos.x = screen->w - gameBarPos.w;
	gameBarPos.y = 0;

	topBarSurface = pDataManager->getUIGraphic(UI_TopBar);
	topBarPos.w = topBarSurface->w;
	topBarPos.h = topBarSurface->h;
	topBarPos.x = 0;
	topBarPos.y = 0;

    gameState = START;

	GameCycleCount = 0;
	SkipToGameCycle = 0;

	fps = 0;
	debug = false;

	builderSelectMode = groupCreateMode = messageMode = moveDownMode = moveLeftMode = moveRightMode = moveUpMode = placingMode = shift = bShowFPS = radarMode = selectionMode = bQuitGame = false;

	for(int i = 0; i < MESSAGE_BUFFER_SIZE; i++)	//clear in game messages
		messageBuffer[i][0] = '\0';
	typingMessage[0] = '\0';

	powerIndicatorPos.x = 14;
	powerIndicatorPos.y = 146;
	spiceIndicatorPos.x = 20;
	spiceIndicatorPos.y = 146;
	powerIndicatorPos.w = spiceIndicatorPos.w = 4;
	powerIndicatorPos.h = spiceIndicatorPos.h = settings.Video.Height - 146 - 2;

	musicPlayer->changeMusic(MUSIC_PEACE);
	//////////////////////////////////////////////////////////////////////////
	SDL_Rect gameBoardRect = { 0, topBarPos.h, gameBarPos.x, screen->h - topBarPos.h };
	screenborder = new ScreenBorder(gameBoardRect);
	radarView = new RadarView();

	//create surface for fog overlay (full fogged square)
	fogSurf = SDL_CreateRGBSurface(
			SDL_HWSURFACE,
			256,/*width*/
			16,/*height*/
			32,
			0,0,0,0);/*r,g,b,*/
//
	SDL_SetAlpha(fogSurf, SDL_SRCALPHA, 40);

	hiddenSurf = pDataManager->getObjPic(ObjPic_Terrain_Hidden);

	//set up pixelmap for neighbours of fogged terrain
	SDL_LockSurface(hiddenSurf);
	for(int x=0;x<256;x++)
		for(int y=0;y<16;y++)
			fogMAP[x][y] = getpixel(hiddenSurf,x,y);
	SDL_UnlockSurface(hiddenSurf);
}

/**
    The destructor frees up all the used memory.
*/
GameClass::~GameClass()
{
	if(pInGameMenu != NULL) {
		delete pInGameMenu;
		pInGameMenu = NULL;
	}

	if(pInterface != NULL) {
		delete pInterface;
		pInterface = NULL;
	}

    for(RobustList<StructureClass*>::const_iterator iter = structureList.begin(); iter != structureList.end(); ++iter) {
        delete *iter;
    }
    structureList.clear();

    for(RobustList<UnitClass*>::const_iterator iter = unitList.begin(); iter != unitList.end(); ++iter) {
        delete *iter;
    }
    unitList.clear();

	for(RobustList<BulletClass*>::const_iterator iter = bulletList.begin(); iter != bulletList.end(); ++iter) {
	    delete *iter;
	}
	bulletList.clear();

    for(RobustList<Explosion*>::const_iterator iter = explosionList.begin(); iter != explosionList.end(); ++iter) {
	    delete *iter;
	}
	explosionList.clear();

	for(int i=0;i<MAX_PLAYERS;i++) {
		delete player[i];
		player[i] = NULL;
	}

	delete currentGameMap;
	currentGameMap = NULL;
	delete screenborder;
	screenborder = NULL;
	delete radarView;
	radarView = NULL;


	if(InitSettings != NULL) {
		delete InitSettings;
	}
}



/**
	This method processes all objects in the current game. It should be executed exactly once per game tick.
*/
void GameClass::ProcessObjects()
{
	// Update the windtrap palette animation
	pDataManager->DoWindTrapPalatteAnimation();

	// update all tiles
    for(int y = 0; y < currentGameMap->sizeY; y++) {
		for(int x = 0; x < currentGameMap->sizeX; x++) {
            currentGameMap->cell[x][y].update();
		}
	}


    for(RobustList<StructureClass*>::iterator iter = structureList.begin(); iter != structureList.end(); ++iter) {
        StructureClass* tempStructure = *iter;
        tempStructure->update();
    }

	if (placingMode && selectedList.empty()) {
		placingMode = false;
	}

	for(RobustList<UnitClass*>::iterator iter = unitList.begin(); iter != unitList.end(); ++iter) {
		UnitClass* tempUnit = *iter;
		tempUnit->update();
	}

    for(RobustList<BulletClass*>::iterator iter = bulletList.begin(); iter != bulletList.end(); ++iter) {
        (*iter)->update();
	}

    for(RobustList<Explosion*>::iterator iter = explosionList.begin(); iter != explosionList.end(); ++iter) {
        (*iter)->update();
	}
}

/**
	This method draws a complete frame.
*/
void GameClass::drawScreen()
{
	SDL_Rect	source,	drawLocation;

	/* clear whole screen */
	SDL_FillRect(screen,NULL,0);

    Coord TopLeftTile = screenborder->getTopLeftTile();
    Coord BottomRightTile = screenborder->getBottomRightTile();

    // extend the view a little bit to avoid graphical glitches
    TopLeftTile.x = std::max(0, TopLeftTile.x - 1);
    TopLeftTile.y = std::max(0, TopLeftTile.y - 1);
    BottomRightTile.x = std::min(currentGameMap->sizeX-1, BottomRightTile.x + 1);
    BottomRightTile.y = std::min(currentGameMap->sizeY-1, BottomRightTile.y + 1);

    Coord currentTile;

    /* draw ground/structures */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitGround( screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                      screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}

    /* draw underground units */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitUndergroundUnits( screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                                screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}

    /* draw dead objects */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitDeadObjects( screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                           screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}

    /* draw infantry */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitInfantry( screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                        screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}

    /* draw non-infantry ground units */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitNonInfantryGroundUnits( screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                                      screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}

	/* draw bullets */
    for(RobustList<BulletClass*>::const_iterator iter = bulletList.begin(); iter != bulletList.end(); ++iter) {
        BulletClass* pBullet = *iter;

		if(screenborder->isInsideScreen( Coord( (int) pBullet->getRealX(), (int) pBullet->getRealY()), pBullet->getImageSize()))
		{
			if(debug || !shade) {
				pBullet->blitToScreen();
			} else {
				int xpos = (int) (*iter)->getRealX()/BLOCKSIZE;
				int ypos = (int) (*iter)->getRealY()/BLOCKSIZE;

				if( (currentGameMap->cellExists(xpos,ypos)) &&
					(currentGameMap->cell[xpos][ypos].isExplored(thisPlayer->getPlayerNumber())
					|| !currentGameMap->cell[xpos][ypos].isFogged(thisPlayer->getPlayerNumber()))) {
					pBullet->blitToScreen();
                }
			}
		}
	}


	/* draw explosions */
	for(RobustList<Explosion*>::const_iterator iter = explosionList.begin(); iter != explosionList.end(); ++iter) {
        (*iter)->blitToScreen();
	}

    /* draw air units */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitAirUnits(   screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                          screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}

    /* draw selection rectangles */
	for(currentTile.y = TopLeftTile.y; currentTile.y <= BottomRightTile.y; currentTile.y++) {
		for(currentTile.x = TopLeftTile.x; currentTile.x <= BottomRightTile.x; currentTile.x++) {

			if (currentGameMap->cellExists(currentTile))	{
				TerrainClass* cell = &currentGameMap->cell[currentTile.x][currentTile.y];

				if(debug || !shade || cell->isExplored(thisPlayer->getPlayerNumber())) {
					cell->blitSelectionRects(   screenborder->world2screenX(currentTile.x*BLOCKSIZE),
                                                screenborder->world2screenY(currentTile.y*BLOCKSIZE));
				}
			}
		}
	}


//////////////////////////////draw unexplored/shade

	if(shade && !debug) {
		source.y = 0;
		source.w = source.h = drawLocation.w = drawLocation.h = BLOCKSIZE;
		for(int x = screenborder->getTopLeftTile().x; x <= screenborder->getBottomRightTile().x; x++) {
			for (int y = screenborder->getTopLeftTile().y; y <= screenborder->getBottomRightTile().y; y++) {

				if((x >= 0) && (x < currentGameMap->sizeX) && (y >= 0) && (y < currentGameMap->sizeY)) {
					TerrainClass* cell = &currentGameMap->cell[x][y];

					if(cell->isExplored(thisPlayer->getPlayerNumber())) {
						if(cell->isNextToHidden()) {
							source.x = cell->getHideTile()*BLOCKSIZE;
							drawLocation.x = screenborder->world2screenX(x*BLOCKSIZE);
							drawLocation.y = screenborder->world2screenY(y*BLOCKSIZE);
							SDL_BlitSurface(hiddenSurf, &source, screen, &drawLocation);
						}

						if((cell->isNextToFogged()) || (cell->isFogged(thisPlayer->getPlayerNumber()))) {
							source.x = cell->getFogTile()*BLOCKSIZE;
							drawLocation.x = screenborder->world2screenX(x*BLOCKSIZE);
							drawLocation.y = screenborder->world2screenY(y*BLOCKSIZE);

					    	SDL_Rect mini;
							mini.x = mini.y  = 0;
							mini.h = mini.w = 1;
							SDL_Rect drawLoc = drawLocation;
							drawLoc.h = drawLoc.w = 0;

							for (int i=0;i<BLOCKSIZE; i++) {
								for (int j=0;j<BLOCKSIZE; j++) {
									if(fogMAP[source.x+i][source.y+j] == 12) {
										drawLoc.x = drawLocation.x + i;
										drawLoc.y = drawLocation.y + j;
										SDL_BlitSurface(fogSurf,&mini,screen,&drawLoc);
									};
								}
							}

						}
					} else {
						source.x = BLOCKSIZE*15;
                        drawLocation.x = screenborder->world2screenX(x*BLOCKSIZE);
						drawLocation.y = screenborder->world2screenY(y*BLOCKSIZE);
						SDL_BlitSurface(hiddenSurf, &source, screen, &drawLocation);
					}
				}
			}
		}
	}

/////////////draw placement position

	int mouse_x, mouse_y;

	SDL_GetMouseState(&mouse_x, &mouse_y);

	if(placingMode) {
		//if user has selected to place a structure

		if (mouse_x < gameBarPos.x)	//if mouse is not over game bar
		{
			int	xPos = screenborder->screen2MapX(mouse_x);
			int yPos = screenborder->screen2MapY(mouse_y);

			bool withinRange = false;
			int i, j;

			BuilderClass* builder = NULL;
			if(selectedList.size() == 1) {
			    builder = dynamic_cast<BuilderClass*>(objectManager.getObject(*selectedList.begin()));
			}

			int placeItem = builder->GetCurrentProducedItem();
			Coord structuresize = getStructureSize(placeItem);

			SDL_Surface	*image,
						*validPlace = pDataManager->getUIGraphic(UI_ValidPlace),
						*invalidPlace = pDataManager->getUIGraphic(UI_InvalidPlace);

			for (i = xPos; i < (xPos + structuresize.x); i++)
				for (j = yPos; j < (yPos + structuresize.y); j++)
					if (currentGameMap->isWithinBuildRange(i, j, builder->getOwner()))
						withinRange = true;			//find out if the structure is close enough to other buildings

			for (i = xPos; i < (xPos + structuresize.x); i++)
				for (j = yPos; j < (yPos + structuresize.y); j++)
				{
					if (!withinRange || !currentGameMap->cellExists(i,j) || !currentGameMap->getCell(i,j)->isRock() || currentGameMap->getCell(i,j)->isMountain() || currentGameMap->getCell(i,j)->hasAGroundObject())
						image = invalidPlace;
					else
						image = validPlace;

					drawLocation.x = screenborder->world2screenX(i*BLOCKSIZE);
					drawLocation.y = screenborder->world2screenY(j*BLOCKSIZE);

					SDL_BlitSurface(image, NULL, screen, &drawLocation);
				}
		}
	}

///////////draw game selection rectangle
	if (selectionMode) {

		int finalMouseX = mouse_x;
		if(finalMouseX >= gameBarPos.x) {
		    //this keeps the box on the map, and not over game bar
			finalMouseX = gameBarPos.x-1;
		}

        // draw the mouse selection rectangle
		drawrect( screen,
                  screenborder->world2screenX(selectionRect.x),
                  screenborder->world2screenY(selectionRect.y),
                  finalMouseX,
                  mouse_y,
                  COLOUR_WHITE);
	}



///////////draw action indicator

	if ((indicatorFrame != NONE) && (screenborder->isInsideScreen(indicatorPosition, Coord(BLOCKSIZE,BLOCKSIZE)) == true)) {
		source.w = drawLocation.w = pDataManager->getUIGraphic(UI_Indicator)->w/3;
		source.h = drawLocation.h = pDataManager->getUIGraphic(UI_Indicator)->h;
		source.x = indicatorFrame*source.w;
		source.y = 0;
		drawLocation.x = screenborder->world2screenX(indicatorPosition.x) - source.w/2;
		drawLocation.y = screenborder->world2screenY(indicatorPosition.y) - source.h/2;
		SDL_BlitSurface(pDataManager->getUIGraphic(UI_Indicator), &source, screen, &drawLocation);
	}


///////////draw game bar
	pInterface->Draw(screen, Point(0,0));
	pInterface->DrawOverlay(screen, Point(0,0));

	SDL_Surface* surface;

/////////draw radar
    radarView->draw();

////////draw messages
	int pos = 0;
	for(int count = MESSAGE_BUFFER_SIZE-1; count >= 0; count--) {
		if (messageTimer[count] > 0) {
			surface = pFontManager->createSurfaceWithText(messageBuffer[count], COLOUR_WHITE, FONT_STD12);
			drawLocation.x = 0;
			drawLocation.y = pFontManager->getTextHeight(FONT_STD12)*pos++;
			SDL_BlitSurface(surface, NULL, screen, &drawLocation);
			SDL_FreeSurface(surface);
			if (--messageTimer[count] <= 0) {
				messageBuffer[count][0] = '\0';
			}
		}
	}


	//draw message currently creating
	if (messageMode) {
	    int xCount, yCount;
		if (strlen(typingMessage) > 0) {

			surface = pFontManager->createSurfaceWithText(typingMessage, COLOUR_WHITE, FONT_STD12);
			xCount = surface->w;	//store for later
			yCount = surface->h;
			drawLocation.x = (screen->w - surface->w)/2;
			drawLocation.y = (screen->h - pFontManager->getTextHeight(FONT_STD12))/2 + screen->h/5;
			SDL_BlitSurface(surface, NULL, screen, &drawLocation);
			SDL_FreeSurface(surface);
		} else {
			xCount = 0;
		}

		surface = pFontManager->createSurfaceWithText("_", COLOUR_WHITE, FONT_STD12);

		drawLocation.x = (screen->w + xCount)/2;
		drawLocation.y = (screen->h - pFontManager->getTextHeight(FONT_STD12))/2 + screen->h/5;
		SDL_BlitSurface(surface, NULL, screen, &drawLocation);
		SDL_FreeSurface(surface);
	}

	if (bShowFPS) {
		char	temp[50];

		#ifdef _WIN32
			/* we have no snprintf under windows */
			sprintf(temp,"fps: %.2f frameTimer: %d GameCycle: %d",fps,frameTimer,GameCycleCount);
		#else
			snprintf(temp,50,"fps: %.2f frameTimer: %d GameCycle: %d",fps,frameTimer,GameCycleCount);
		#endif

		surface = pFontManager->createSurfaceWithText(temp, COLOUR_WHITE, FONT_STD12);
		drawLocation.x = screen->w - surface->w;
		drawLocation.y = 0;
		SDL_BlitSurface(surface, NULL, screen, &drawLocation);
		SDL_FreeSurface(surface);
	}

	//show ingame menu
	if (bPause || finished) {
		char*	finishMessage[] = { "You Have Completed Your Mission.", "You Have Failed Your Mission." };
		char*	pausedMessage = "Paused";

		char*	message;

		if (finished) {
			if (won) {
				message = finishMessage[0];
			} else {
				message = finishMessage[1];
			}

			/*end timer in here*/
			endTimer--;

			if(endTimer <= 0) {
				finishedLevel = true;
			}
		} else {
			message = pausedMessage;
		}

		surface = pFontManager->createSurfaceWithText(message, COLOUR_WHITE, FONT_STD24);

		drawLocation.x = screen->w/2 - surface->w/2;
		drawLocation.y = screen->h/2 - surface->h/2;
		drawLocation.w = surface->w;
		drawLocation.h = surface->h;

		SDL_BlitSurface(surface, NULL, screen, &drawLocation);
		SDL_FreeSurface(surface);
	}

	if(pInGameMenu != NULL) {
		pInGameMenu->Draw(screen);
	} else if(pInGameMentat != NULL) {
		pInGameMentat->draw();
	}

	drawCursor();
}

/**
	This method proccesses all the user input.
*/
void GameClass::doInput()
{
	ObjectClass* tempObject;
	SDL_Event event;
	while(SDL_PollEvent(&event))	//check for a key press
	{
		// first of all update mouse
		if(event.type == SDL_MOUSEMOTION) {
			SDL_MouseMotionEvent* mouse = &event.motion;
			drawnMouseX = mouse->x;
			drawnMouseY = mouse->y;
		}

		if(pInGameMenu != NULL) {
			pInGameMenu->HandleInput(event);

			if(bPause == false) {
				if(pInGameMenu != NULL) {
					delete pInGameMenu;
					pInGameMenu = NULL;
				}
			}

		} else if(pInGameMentat != NULL) {
			pInGameMentat->doInput(event);

			if(bPause == false) {
				if(pInGameMentat != NULL) {
					delete pInGameMentat;
					pInGameMentat = NULL;
				}
			}

		} else {
			/* Look for a keypress */
			switch (event.type)
			{
			case (SDL_KEYDOWN):
				if(messageMode) {
					if (event.key.keysym.sym == SDLK_ESCAPE)
						messageMode = false;
					else if (event.key.keysym.sym == SDLK_RETURN)
					{
						/*
						if (strlen(typingMessage) > 0)
						{
								SendChatMessage(thisPlayer->getPlayerNumber(), typingMessage);
						}*/

						messageMode = false;
					}
					else if (event.key.keysym.sym == SDLK_BACKSPACE)
					{
						if (strlen(typingMessage) > 0)
							typingMessage[strlen(typingMessage) - 1] = '\0';
					}
					else if (strlen(typingMessage) < (MAX_MSGLENGTH - 3))
					{
						if ((event.key.keysym.unicode < 0x80) && (event.key.keysym.unicode > 0))
						{
							typingMessage[strlen(typingMessage) + 1] = '\0';
							typingMessage[strlen(typingMessage)] = (char)event.key.keysym.unicode;
						}
					}
				}
				else
				{
					switch( event.key.keysym.sym )
					{
						case SDLK_0:	//if ctrl and 0 remove selected units from all groups
							if(groupCreateMode) {
								std::set<Uint32>::iterator iter;
								for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {
								    ObjectClass* object = objectManager.getObject(*iter);
								    object->setSelected(false);
								    object->removeFromSelectionLists();
								}
								selectedList.clear();
								placingMode = false;
							} else {
                                std::set<Uint32>::iterator iter;
								for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {
								    ObjectClass* object = objectManager.getObject(*iter);
								    object->setSelected(false);
								}
								selectedList.clear();
								placingMode = false;
							}
							pInterface->UpdateObjectInterface();

							break;	//for SDLK_1 to SDLK_9 select group with that number, if ctrl create group from selected obj

						case SDLK_1:
						case SDLK_2:
						case SDLK_3:
						case SDLK_4:
						case SDLK_5:
						case SDLK_6:
						case SDLK_7:
						case SDLK_8:
						case SDLK_9:
							if(groupCreateMode)	{
								selectedLists[event.key.keysym.sym - SDLK_1] = selectedList;

								pInterface->UpdateObjectInterface();
							} else {
								if(!shift)	{
									unselectAll(selectedList);
									selectedList.clear();
								}

                                std::set<Uint32>::iterator iter;
								for(iter = selectedLists[event.key.keysym.sym - SDLK_1].begin(); iter != selectedLists[event.key.keysym.sym - SDLK_1].end(); ++iter) {
								    ObjectClass* object = objectManager.getObject(*iter);
								    object->setSelected(true);
								    selectedList.insert(object->getObjectID());
								}

								pInterface->UpdateObjectInterface();
							}
							placingMode = false;
							break;

						case SDLK_MINUS:
						{
							if (++gamespeed > 100)
								gamespeed = 100;
							char temp[20];
							sprintf(temp, "GameSpeed:%d", gamespeed);
							currentGame->AddToNewsTicker(temp);
							break;
						}

						case SDLK_EQUALS://PLUS
						{
							if (--gamespeed <= 0)
								gamespeed = 1;
							char temp[20];
							sprintf(temp, "GameSpeed:%d", gamespeed);
							currentGame->AddToNewsTicker(temp);
							break;
						}

						case SDLK_a:	//set object on attack move
                            if(!attackMoveMode) {
                                std::set<Uint32>::iterator iter;
								for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {

								    tempObject = objectManager.getObject(*iter);
								   	if(tempObject->isAUnit() && (tempObject->getOwner() == thisPlayer)
										&& tempObject->isRespondable() && tempObject->canAttack()) {

										attackMoveMode = true;
										cursorFrame = CURSOR_TARGET;
										break;
									}
								}
                            }
							break;

						case SDLK_f:
							/*switch fog of war*/
							fog_wanted = !fog_wanted;
							break;

						case SDLK_DOWN:
							moveDownMode = true;
							break;

						case SDLK_ESCAPE:
							OnOptions();
							break;
	//#ifdef _DEBUG
						case SDLK_F1:

							if (gameType != MULTIPLAYER)
								debug = !debug;
							break;

						case SDLK_F2:

							if (gameType != MULTIPLAYER)
							{
								won = true;
								finished = true;
							}
							break;

						case SDLK_F3:
							thisPlayer->returnCredits(10000.0);
							break;

                        case SDLK_F9:
                            // skip a few seconds
                            SkipToGameCycle = GameCycleCount + 1000;
                            break;

                        case SDLK_F10:
                            // skip a few minutes
                            SkipToGameCycle = GameCycleCount + 10000;
                            break;
	//#endif
						case SDLK_F11:
							bShowFPS = !bShowFPS;
							break;

						case SDLK_F12:
							soundPlayer->toggleSound();
							musicPlayer->toggleSound();
							break;

						case SDLK_LCTRL:
							groupCreateMode = true;
							break;

						case SDLK_LEFT:
							moveLeftMode = true;
							break;

						case SDLK_LSHIFT:
							shift = true;
							break;

						case SDLK_m:
							musicPlayer->changeMusic(MUSIC_RANDOM);
							break;

						case SDLK_PRINT:
						case SDLK_SYSREQ:
							SDL_SaveBMP(screen, "screenshot.bmp");
							currentGame->AddToNewsTicker("screenshot.bmp saved");

							break;

						case SDLK_r:
                        {
                            std::set<Uint32>::iterator iter;
                            for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {
							    ObjectClass *tempObject = objectManager.getObject(*iter);
							    if(tempObject->isAStructure()) {
										((StructureClass*)tempObject)->HandleRepairClick();
                                }
                            }
                        } break;

						case SDLK_RETURN:
							typingMessage[0] = '\0';
							messageMode = true;
							break;

						case SDLK_RIGHT:
							moveRightMode = true;
							break;

						case SDLK_SPACE:
							bPause = !bPause;
							break;

						case SDLK_UP:
							moveUpMode = true;
							break;

						default:
							break;
					}
					break;
				}
			case (SDL_KEYUP):
				switch( event.key.keysym.sym )
				{
					case SDLK_DOWN:
						moveDownMode = false;
						break;
					case SDLK_LCTRL:
						groupCreateMode = false;
						break;
					case SDLK_LEFT:
						moveLeftMode = false;
						break;
					case SDLK_LSHIFT:
						shift = false;
						break;
					case SDLK_RIGHT:
						moveRightMode = false;
						break;
					case SDLK_UP:
						moveUpMode = false;
						break;
					default:
						 break;
				}
				break;
			case SDL_MOUSEBUTTONDOWN:
			{
				SDL_MouseButtonEvent* mouse = &event.button;

				if((pInGameMenu == NULL) && (pInGameMentat==NULL)) {
					if(mouse->button == SDL_BUTTON_LEFT) {
						pInterface->HandleMouseLeft(mouse->x, mouse->y,true);
					} else if(mouse->button == SDL_BUTTON_RIGHT) {
						pInterface->HandleMouseRight(mouse->x, mouse->y,true);
					}
				}

				switch (mouse->button)
				{
					case (SDL_BUTTON_LEFT):
					{
						if (placingMode) {
							if(mouse->x < gameBarPos.x && mouse->y >= topBarPos.h) {
							    //if mouse is not over game bar

							    int xPos = screenborder->screen2MapX(mouse->x);
                                int	yPos = screenborder->screen2MapY(mouse->y);

                                BuilderClass* builder = NULL;
                                if(selectedList.size() == 1) {
                                    builder = dynamic_cast<BuilderClass*>(objectManager.getObject(*selectedList.begin()));
                                }

								int placeItem = builder->GetCurrentProducedItem();
								Coord structuresize = getStructureSize(placeItem);

								if (placeItem == Structure_Slab4) {
									if(	(currentGameMap->isWithinBuildRange(xPos, yPos, builder->getOwner()) || currentGameMap->isWithinBuildRange(xPos+1, yPos, builder->getOwner())
											|| currentGameMap->isWithinBuildRange(xPos+1, yPos+1, builder->getOwner()) || currentGameMap->isWithinBuildRange(xPos, yPos+1, builder->getOwner()))
										&& ((currentGameMap->okayToPlaceStructure(xPos, yPos, 1, 1, false, builder->getOwner())
											|| currentGameMap->okayToPlaceStructure(xPos+1, yPos, 1, 1, false, builder->getOwner())
											|| currentGameMap->okayToPlaceStructure(xPos+1, yPos+1, 1, 1, false, builder->getOwner())
											|| currentGameMap->okayToPlaceStructure(xPos, yPos, 1, 1+1, false, builder->getOwner())))) {

										GetCommandManager().addCommand(Command(CMD_PLACE_STRUCTURE,builder->getObjectID(), placeItem, xPos, yPos));
										//the user has tried to place and has been successful
										soundPlayer->playSound(PlaceStructure);
										placingMode = false;
									} else {
										//the user has tried to place but clicked on impossible point
										currentGame->AddToNewsTicker("You cannot place it here.");
										soundPlayer->playSound(InvalidAction);	//can't place noise
									}
								} else {
									if(currentGameMap->okayToPlaceStructure(xPos, yPos, structuresize.x, structuresize.y, false, builder->getOwner())) {
										GetCommandManager().addCommand(Command(CMD_PLACE_STRUCTURE,builder->getObjectID(), placeItem, xPos, yPos));
										//the user has tried to place and has been successful
										soundPlayer->playSound(PlaceStructure);
										placingMode = false;
									} else {
										//the user has tried to place but clicked on impossible point
										currentGame->AddToNewsTicker("You cannot place it here.");
										soundPlayer->playSound(InvalidAction);	//can't place noise
									}
								}
							}
						} else if(attackMoveMode) {

						    int xPos = INVALID_POS;
						    int yPos = INVALID_POS;

							if(mouse->x < gameBarPos.x && mouse->y >= topBarPos.h) {
                                xPos = screenborder->screen2MapX(mouse->x);
                                yPos = screenborder->screen2MapY(mouse->y);
							} else if(radarView->isOnRadar(mouse->x, mouse->y) == true) {
							    Coord position = radarView->getWorldCoords(mouse->x, mouse->y);

							    xPos = position.x / BLOCKSIZE;
							    yPos = position.y / BLOCKSIZE;
							}

							if((xPos != INVALID_POS) && (yPos != INVALID_POS)) {

                                UnitClass* responder = NULL;

                                std::set<Uint32>::iterator iter;
                                for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {
                                    ObjectClass *tempObject = objectManager.getObject(*iter);
                                    if (tempObject->isAUnit() && (tempObject->getOwner() == thisPlayer)) {
                                        responder = (UnitClass*) tempObject;
                                        responder->HandleAttackMoveClick(xPos,yPos);
                                    }
                                }

                                if(responder) {
                                    responder->playConfirmSound();
                                }

                                attackMoveMode = false;
                                cursorFrame = CURSOR_NORMAL;
							}
						} else {
							//if not placingMode

							if (mouse->x < gameBarPos.x && mouse->y >= topBarPos.h) {
								// it isn't on the gamebar

								if(!selectionMode) {
								    // if we have started the selection rectangle
                                    // the starting point of the selection rectangele
									selectionRect.x = screenborder->screen2worldX(mouse->x);
									selectionRect.y = screenborder->screen2worldY(mouse->y);
								}
								selectionMode = true;

							} else if (!selectionMode) {

								if(radarView->isOnRadar(mouse->x,mouse->y) == true) {
									//if on the radar
									screenborder->SetNewScreenCenter(radarView->getWorldCoords(mouse->x,mouse->y));

                                    //stay within the box
									radarMode = true;
								}
							}
						}
						break;
					}	//end of SDL_BUTTON_LEFT
					case (SDL_BUTTON_MIDDLE):
					{

					}
					case (SDL_BUTTON_RIGHT):	//if the right mouse button is pressed
					{
						if (attackMoveMode)
						{	//cancel attackmove
							attackMoveMode = false;
							cursorFrame = CURSOR_NORMAL;
						}
						else if ((!selectedList.empty()	//if user has a controlable unit selected
							&& (((objectManager.getObject(*selectedList.begin()))->getOwner() == thisPlayer)/* || debug*/))
							&& ((mouse->x < gameBarPos.x)
								|| (radarView->isOnRadar(mouse->x,mouse->y))))
						{
                            //coordinate on map
						    int	xPos = INVALID_POS;
                            int yPos = INVALID_POS;

							if(mouse->x < gameBarPos.x && mouse->y >= topBarPos.h) {
							    //if mouse isn't on the gamebar
								xPos = screenborder->screen2MapX(mouse->x);
								yPos = screenborder->screen2MapY(mouse->y);

								indicatorPosition.x = screenborder->screen2worldX(mouse->x);
								indicatorPosition.y = screenborder->screen2worldY(mouse->y);
							} else if(radarView->isOnRadar(mouse->x, mouse->y) == true) {
							    //if on the radar
                                indicatorPosition = radarView->getWorldCoords(mouse->x, mouse->y);

                                // calculate map coordinates
                                xPos = indicatorPosition.x / BLOCKSIZE;
                                yPos = indicatorPosition.y / BLOCKSIZE;
							}

							if((xPos != INVALID_POS) && (yPos != INVALID_POS)) {

                                indicatorFrame = 0;

                                //let unit handle right click on map or target
                                double speedCap = -1.0;
                                ObjectClass	*responder = NULL;
                                ObjectClass	*tempObject = NULL;

                                std::set<Uint32>::iterator iter;
                                for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {
                                    tempObject = objectManager.getObject(*iter);

                                    if(tempObject->getOwner() == thisPlayer) {
                                        tempObject->HandleActionClick(xPos, yPos);

                                        //if this object obey the command
                                        if ((responder == NULL) && tempObject->isRespondable())
                                            responder = tempObject;

                                        //find slowest speed of all units
                                        if (shift && tempObject->isAUnit() && ((speedCap < 0.0) || (((UnitClass*)tempObject)->getMaxSpeed() < speedCap)))
                                            speedCap = ((UnitClass*)tempObject)->getMaxSpeed();
                                    }
                                }

                                if(responder) {
                                    responder->playConfirmSound();
                                }

                                for(iter = selectedList.begin(); iter != selectedList.end(); ++iter) {
                                    tempObject = objectManager.getObject(*iter);
                                    if((tempObject->isAUnit()) && (tempObject->getOwner() == thisPlayer)) {
                                        ((UnitClass*)tempObject)->setSpeedCap(speedCap);
                                    }
                                }
							}

						}
						placingMode = false;
						break;
					}	//end of SDL_BUTTON_RIGHT
					break;
				}
			}
			case SDL_MOUSEMOTION:
			{
				SDL_MouseMotionEvent* mouse = &event.motion;

				if((pInGameMenu==NULL) && (pInGameMentat==NULL)) {
					pInterface->HandleMouseMovement(mouse->x,mouse->y);
				}

				moveDownMode =  (mouse->y >= screen->h-1);	//if user is trying to move view down
				moveLeftMode = (mouse->x <= 0);	//if user is trying to move view left
				moveRightMode = (mouse->x >= screen->w-1);	//if user is trying to move view right
				moveUpMode = (mouse->y <= 0);	//if user is trying to move view up


				if(radarMode) {
				    if(radarView->isOnRadar(mouse->x,mouse->y) == true) {
						//if on the radar
						screenborder->SetNewScreenCenter(radarView->getWorldCoords(mouse->x,mouse->y));
				    }
				}

				drawnMouseX = mouse->x;
				drawnMouseY = mouse->y;
				break;
			}
			case SDL_MOUSEBUTTONUP:
			{
				SDL_MouseButtonEvent* mouse = &event.button;
				if ((mouse->button == SDL_BUTTON_LEFT) || (mouse->button == SDL_BUTTON_RIGHT))
				{
					if((pInGameMenu==NULL) && (pInGameMentat==NULL)) {
						if(mouse->button == SDL_BUTTON_LEFT) {
							pInterface->HandleMouseLeft(mouse->x, mouse->y,false);
						} else if(mouse->button == SDL_BUTTON_RIGHT) {
							pInterface->HandleMouseRight(mouse->x, mouse->y,false);
						}
					}

					if (selectionMode && (mouse->button == SDL_BUTTON_LEFT))
					{
					    //this keeps the box on the map, and not over game bar
						int finalMouseX = mouse->x;
                        int finalMouseY = mouse->y;

						if(finalMouseX >= gameBarPos.x) {
							finalMouseX = gameBarPos.x-1;
						}

						int rectFinishX = screenborder->screen2MapX(finalMouseX);
						if(rectFinishX > (currentGameMap->sizeX-1)){
							rectFinishX = currentGameMap->sizeX-1;
						}

						int rectFinishY = screenborder->screen2MapY(finalMouseY);

						// convert start also to map coordinates
						int rectStartX = selectionRect.x/BLOCKSIZE;
						int	rectStartY = selectionRect.y/BLOCKSIZE;

						currentGameMap->selectObjects(  thisPlayer->getPlayerNumber(),
                                                        rectStartX, rectStartY, rectFinishX, rectFinishY,
                                                        screenborder->screen2worldX(finalMouseX),
                                                        screenborder->screen2worldY(finalMouseY),
                                                        shift);

						pInterface->UpdateObjectInterface();
					}

					radarMode = selectionMode = false;

				}

				break;
			}
			case (SDL_QUIT):
				bQuitGame = true;
				break;
			default:
				break;
			}
		}
	}

	if(moveLeftMode) {
	    if(screenborder->scrollLeft()) {
            cursorFrame = CURSOR_LEFT;
	    } else {
	        moveLeftMode = false;
	    }
	} else if(moveRightMode) {
	    if(screenborder->scrollRight()) {
            cursorFrame = CURSOR_RIGHT;
	    } else {
	        moveRightMode = false;
	    }
	}

	if(moveDownMode) {
	    if(screenborder->scrollDown()) {
            cursorFrame = CURSOR_DOWN;
	    } else {
	        moveDownMode = false;
	    }
	} else if(moveUpMode) {
	    if(screenborder->scrollUp()) {
            cursorFrame = CURSOR_UP;
	    } else {
	        moveUpMode = false;
	    }
	}

	if(!moveLeftMode && !moveRightMode && !moveUpMode && !moveDownMode) {
		if(attackMoveMode) {
			cursorFrame = CURSOR_TARGET;
		} else {
			cursorFrame = CURSOR_NORMAL;
		}
	}
}


/**
	Draws the cursor.
*/
void GameClass::drawCursor()
{
	SDL_Rect dest, src;

	SDL_Surface* surface = pDataManager->getUIGraphic(UI_CursorShape);

	dest.x = drawnMouseX;
	dest.y = drawnMouseY;
	dest.w = src.w = surface->w/NUM_CURSORS;
	dest.h = src.h = surface->h;

	src.x = src.w * cursorFrame;
	src.y = 0;

	//reposition image so pointing on right spot

	if (cursorFrame == CURSOR_RIGHT) {
		dest.x -= dest.w/2;
	} else if (cursorFrame == CURSOR_DOWN) {
		dest.y -= dest.h/2;
	}

	if ((cursorFrame == CURSOR_TARGET) || (cursorFrame == CURSOR_SELECTION)) {
		dest.x -= dest.w/2;
		dest.y -= dest.h/2;
	}

	SDL_BlitSurface(surface, &src, screen, &dest);
}

/**
	This method sets up the view. The start position is the center point of all owned units/structures
*/
void GameClass::setupView()
{
	int i = 0;
	int j = 0;
	int count = 0;

	//setup start location/view
	i = j = count = 0;

    RobustList<UnitClass*>::const_iterator unitIterator;
	for(unitIterator = unitList.begin(); unitIterator != unitList.end(); unitIterator++) {
		UnitClass* pUnit = *unitIterator;
		if(pUnit->getOwner() == thisPlayer) {
			i += pUnit->getX();
			j += pUnit->getY();
			count++;
		}
	}

    RobustList<StructureClass*>::const_iterator structureIterator;
	for(structureIterator = structureList.begin(); structureIterator != structureList.end(); structureIterator++) {
		StructureClass* pStructure = *structureIterator;
		if(pStructure->getOwner() == thisPlayer) {
			i += pStructure->getX();
			j += pStructure->getY();
			count++;
		}
	}

	if(count == 0) {
		i = currentGameMap->sizeX*BLOCKSIZE/2-1;
		j = currentGameMap->sizeY*BLOCKSIZE/2-1;
	} else {
		i = i*BLOCKSIZE/count;
		j = j*BLOCKSIZE/count;
	}

	screenborder->SetNewScreenCenter(Coord(i,j));
}

/**
	Loads a map from an INI-File.
	\param mapname  the name of the INI-File
	\return true if loaded successful, false if failed
*/
bool GameClass::loadINIMap(std::string mapname)
{
	bool	ok = false;
	bool	done = false;	//this will be set to false if any errors, so level won't load

	SDL_RWops* mapiniFile;
	if( (mapiniFile = pFileManager->OpenFile(mapname)) == NULL) {
		fprintf(stdout,"GameClass::loadINIMap(): Cannot load %s!\n",mapname.c_str());
		return false;
	}

	INIFile myINIFile(mapiniFile);

	SDL_RWclose(mapiniFile);

	currentGameMap = new MapClass(64, 64);
	currentGameMap->setWinFlags(myINIFile.getIntValue("BASIC","WinFlags",3));

	int SeedNum = myINIFile.getIntValue("MAP","Seed",-1);

	if(SeedNum == -1) {
		fprintf(stdout,"GameClass::loadINIMap(): Cannot find Seednum in %s!\n",mapname.c_str());
		delete currentGameMap;
		return false;
	}

	unsigned short SeedMap[64*64];
	createMapWithSeed(SeedNum,SeedMap);


	for (int j = 0; j < currentGameMap->sizeY; j++)
	{
		for (int i = 0; i < currentGameMap->sizeX; i++)
		{
			int type = Terrain_Sand;
			unsigned char seedmaptype = SeedMap[j*64+i] >> 4;
			switch(seedmaptype) {
				case 0x7:
					/* Sand */
					type = Terrain_Sand;
					break;
				case 0x9:
					/* Dunes */
					type = Terrain_Dunes;
					break;
				case 0x2:
					/* Building */
				case 0x8:
					/* Rock */
					type = Terrain_Rock;
					break;
				case 0xb:
					/* Spice */
					type = Terrain_Spice;
					break;
				case 0xc:
					/* ThickSpice */
					type = Terrain_ThickSpice;
					break;
				case 0xa:
					/* Mountain */
					type = Terrain_Mountain;
					break;
				default:
					printf("Unknown maptype %x\n",type);
					exit(EXIT_FAILURE);
			}

			currentGameMap->cell[i][j].setType(type);
			currentGameMap->cell[i][j].setTile(Terrain_a1);
		}

	}

	done = true;


	currentGameMap->createSandRegions();

	std::string BloomString = myINIFile.getStringValue("MAP","Bloom");
	if(BloomString != "") {
		std::vector<std::string> BloomPositions  = SplitString(BloomString);

		for(unsigned int i=0; i < BloomPositions.size();i++) {
			// set bloom
			int BloomPos = atol(BloomPositions[i].c_str());
			if((BloomPos != 0) || (BloomPositions[i] == "0")) {
				int xpos = BloomPos % currentGameMap->sizeX;
				int ypos = BloomPos / currentGameMap->sizeX;
				if(currentGameMap->cellExists(xpos,ypos)) {
					currentGameMap->cell[xpos][ypos].setTile(RandomGen.rand(Terrain_a2,Terrain_a3));
				} else {
					fprintf(stdout,"Cannot set bloom at %d, %d\n",xpos, ypos);
				}
			}
		}
	}

	std::string FieldString = myINIFile.getStringValue("MAP","Field");
	if(FieldString != "") {
		std::vector<std::string> FieldPositions  = SplitString(FieldString);

		for(unsigned int i=0; i < FieldPositions.size();i++) {
			// set bloom
			int FieldPos = atol(FieldPositions[i].c_str());
			if((FieldPos != 0) || (FieldPositions[i] == "0")) {
				int xpos = FieldPos % currentGameMap->sizeX;
				int ypos = FieldPos / currentGameMap->sizeX;
				if(currentGameMap->cellExists(xpos,ypos)) {
					for (int x = -5; x <= 5; x++) {
						for (int y = -5; y <= 5; y++) {
							if (currentGameMap->cellExists(xpos + x, ypos + y)
                                && !currentGameMap->getCell(xpos + x, ypos + y)->isBloom()
								&& (distance_from(xpos, ypos, xpos + x, ypos + y) <= 5))
							{
								TerrainClass *cell = currentGameMap->getCell(xpos + x, ypos + y);
								if ((cell != NULL) & (cell->isSand()))
									cell->setType(Terrain_Spice);
							}
						}
					}

					for(int x = xpos - 7; x <= xpos + 7; x++) {
						for(int y = ypos - 7; y <= ypos + 7; y++) {
							if (currentGameMap->cellExists(x, y)) {
								smooth_spot(x, y);
							}
						}
					}
				} else {
					fprintf(stdout,"Cannot set field at %d, %d\n",xpos, ypos);
				}
			}
		}
	}

	smooth_terrain();

	// now set up all the players
	addPlayer(ATREIDES,(InitSettings->House == ATREIDES) ? false : true, (InitSettings->House == ATREIDES) ? 1 : 2);
	addPlayer(ORDOS,(InitSettings->House == ORDOS) ? false : true, (InitSettings->House == ORDOS) ? 1 : 2);
	addPlayer(HARKONNEN,(InitSettings->House == HARKONNEN) ? false : true, (InitSettings->House == HARKONNEN) ? 1 : 2);
	addPlayer(SARDAUKAR,(InitSettings->House == SARDAUKAR) ? false : true, (InitSettings->House == SARDAUKAR) ? 1 : 2);
	addPlayer(FREMEN,(InitSettings->House == FREMEN) ? false : true, (InitSettings->House == FREMEN) ? 1 : 2);
	addPlayer(MERCENERY,(InitSettings->House == MERCENERY) ? false : true, (InitSettings->House == MERCENERY) ? 1 : 2);

	INIFile::KeyListHandle myListHandle;
	myListHandle = myINIFile.KeyList_Open("UNITS");

	while(!myINIFile.KeyList_EOF(myListHandle)) {
		std::string tmpkey = myINIFile.KeyList_GetNextKey(&myListHandle);
		std::string tmp = myINIFile.getStringValue("UNITS",tmpkey);
		std::string HouseStr, UnitStr, health, PosStr, rotation, mode;
		SplitString(tmp,6,&HouseStr,&UnitStr,&health,&PosStr,&rotation,&mode);

        int house = getHouseByName(HouseStr);
        if(house == INVALID) {
            fprintf(stdout,"GameClass::loadINIMap: Invalid house string: %s\n",HouseStr.c_str());
            house = HOUSE_ATREIDES;
        }

		int pos = atol(PosStr.c_str());

		if(pos <= 0) {
			fprintf(stdout,"GameClass::loadINIMap: Invalid position string: %s\n",PosStr.c_str());
			pos = 0;
		}

		int Num2Place = 1;
		int unitID;

		if(UnitStr == "Infantry")	{
			//make three
			unitID = Unit_Soldier;
			Num2Place = 3;
		} else if (UnitStr == "Troopers") {
			//make three
			unitID = Unit_Trooper;
			Num2Place = 3;
		} else {
            unitID = getItemIDByName(UnitStr);
            if((unitID == ItemID_Invalid) || !isUnit(unitID)) {
                fprintf(stdout,"GameClass::loadINIMap: Invalid unit string: %s\n",UnitStr.c_str());
                unitID = Unit_Quad;
            }
		}

		if(player[(int)house] == NULL) {
			fprintf(stdout,"player[%d]== NULL\n",(int) house); fflush(stdout);
			exit(EXIT_FAILURE);
		}

		for(int i = 0; i < Num2Place; i++) {
			UnitClass* newUnit = player[(int) house]->placeUnit(unitID, pos%64, pos/64);
			if(newUnit == NULL) {
				fprintf(stdout, "This file is not a valid unit entry: %d. (invalid unit position)\n", pos);
			} else {
                if(newUnit->getOwner() == thisPlayer) {
                    newUnit->DoSetAttackMode(STANDGROUND);
                }
			}
		}
	}

	myINIFile.KeyList_Close(&myListHandle);


	myListHandle = myINIFile.KeyList_Open("STRUCTURES");

	while(!myINIFile.KeyList_EOF(myListHandle)) {
		std::string tmpkey = myINIFile.KeyList_GetNextKey(&myListHandle);
		std::string tmp = myINIFile.getStringValue("STRUCTURES",tmpkey);

		if(tmpkey.find("GEN") == 0) {
			// Gen Object/Structure
			std::string PosStr = tmpkey.substr(3,tmpkey.size()-3);
			int pos = atol(PosStr.c_str());

			std::string HouseStr, BuildingStr;
			SplitString(tmp,2,&HouseStr,&BuildingStr);

			int house = getHouseByName(HouseStr);
			if(house == INVALID) {
				fprintf(stdout,"GameClass::loadINIMap: Invalid house string: %s\n",HouseStr.c_str());
				house = HOUSE_ATREIDES;
			}

			if(player[(int)house] == NULL) {
				fprintf(stdout,"player[%d]== NULL\n",(int) house); fflush(stdout);
				exit(EXIT_FAILURE);
			}

			if(BuildingStr == "Concrete") {
				player[house]->placeStructure(NONE, Structure_Slab1, pos%64, pos/64);
			} else if(BuildingStr == "Wall") {
				player[house]->placeStructure(NONE, Structure_Wall, pos%64, pos/64);
			} else {
				fprintf(stdout,"GameClass::loadINIMap: Invalid building string: %s\n",BuildingStr.c_str());
			}
		} else {
			// other structure
			std::string HouseStr, BuildingStr, health, PosStr;
			SplitString(tmp,6,&HouseStr,&BuildingStr,&health,&PosStr);

			int pos = atol(PosStr.c_str());

			int house = getHouseByName(HouseStr);
			if(house == INVALID) {
				fprintf(stdout,"GameClass::loadINIMap: Invalid house string: %s\n",HouseStr.c_str());
				house = HOUSE_ATREIDES;
			}

			int itemID = getItemIDByName(BuildingStr);

			if((itemID == ItemID_Invalid) || !isStructure(itemID)) {
				fprintf(stdout,"GameClass::loadINIMap: Invalid building: %s\n",BuildingStr.c_str());
				itemID = Structure_Barracks;
			}

			if ((player[house] != NULL) && (itemID != 0)) {
				ObjectClass* newStructure = player[house]->placeStructure(NONE, itemID, pos%64, pos/64);
				if(newStructure == NULL) {
					fprintf(stdout,"GameClass::loadINIMap: Invalid position: %s\n",PosStr.c_str());
				}
			}
		}
	}

	myINIFile.KeyList_Close(&myListHandle);

	for(int i=0;i<MAX_PLAYERS;i++) {
        if(!player[i]->isAlive() && !player[i]->hasSandworm()) {
            delete player[i];
            player[i] = NULL;
        }
	}

    setupView();

	return ok;
}

/**
	This method starts the game. Will return when the game is finished or aborted.
*/
void GameClass::startGame()
{
	int		i, count,
			frameStart, frameEnd, frameTime,
			frameTimeTotal, numFrames,
			tic;


	printf("Starting game...\n");
	fflush(stdout);

	// add interface
	if(pInterface == NULL) {
        pInterface = new GameInterface();
	}

	///////////////////////////
	//clear messages
	for(count = 0; count < MESSAGE_BUFFER_SIZE; count++)
		messageTimer[count] = 0;

	finished = false;
	bPause = false;
	won = false;
	gameState = BEGUN;

	//gamespeed = 10;
	tic = 0;
	frameTimeTotal = numFrames = 0;
	frameStart = SDL_GetTicks();

	//setup endlevel conditions
	endTimer = END_WAIT_TIMER;
	finishedLevel = false;


	// Check if a player has lost
	for(int j = 0; j < MAX_PLAYERS; j++) {
		if(player[j] != NULL) {
			if(!player[j]->isAlive()) {
				player[j]->lose();
			}
		}
	}

	if(bReplay) {
		CmdManager.setReadOnly(true);
	} else {
	    std::string mapname = InitSettings->mapname;

		char tmp[FILENAME_MAX];
		fnkdat("replay/auto.rpl", tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
		std::string replayname(tmp);

		FileStream* pStream = new FileStream();
		pStream->open(replayname.c_str(), "wb");
		InitSettings->save(*pStream);

        // when this game was loaded we have to save the old commands to the replay file first
		CmdManager.save(*pStream);

		// now all new commands might be added
		CmdManager.setStream(pStream);

		// flush stream
		pStream->flush();
	}

	//main game loop
//	try
//	{
		do {
			drawScreen();

			SDL_Flip(screen);
			frameEnd = SDL_GetTicks();

			if(frameEnd == frameStart) {
				SDL_Delay(1);
			}

			frameTime = frameEnd - frameStart; // find difference to get frametime
			frameStart = SDL_GetTicks();

			frameTimeTotal += frameTime;
			numFrames++;

			if (bShowFPS) {
				fps = ((double) 1000.0)/((double)frameTime);
				frameTimer = frameTime;
			}

			if(settings.Video.FrameLimit == true) {
				if(frameTime < 32) {
					SDL_Delay(32 - frameTime);
				}
			}

			while(frameTime || (!finished && (GameCycleCount < SkipToGameCycle)))	{
				if(frameTime > 0) {
                    frameTime--;
				}

				doInput();
				pInterface->UpdateObjectInterface();

				if (!finished && !bPause && (tic % gamespeed == 0))	{
				    radarView->update();
					CmdManager.executeCommands(GameCycleCount);

                    /*
					if((GameCycleCount % 10) == 0) {
                        char tmp[20];
                        sprintf(tmp, "cycle%d.dls", GameCycleCount);
                        saveGame(tmp);
					}//*/

                    if((GameCycleCount % 50) == 0) {
                        // add every 100 gamecycles one test sync command
                        if(bReplay == false) {
                            CmdManager.addCommand(Command(CMD_TEST_SYNC, RandomGen.getSeed()));
                        }
                    }

					for (i = 0; i < MAX_PLAYERS; i++) {
						if (player[i] != NULL) {
							player[i]->update();
						}
					}

					ProcessObjects();

					if ((indicatorFrame != NONE) && (--indicatorTimer <= 0)) {
						indicatorTimer = indicatorTime;

						if (++indicatorFrame > 2) {
							indicatorFrame = NONE;
						}
					}
					GameCycleCount++;
				}
				tic++;
			}
			musicPlayer->musicCheck();	//if song has finished, start playing next one
		} while (!bQuitGame && !finishedLevel);//not sure if we need this extra bool
//	}
//	catch (...)
//	{
//		fprintf(stdout, "Argghhh. Exception caught: main game loop\n");
//	}


	// Game is finished

	if(bReplay == false && currentGame->won == true) {
        // save replay
	    std::string mapname = InitSettings->mapname;

		char tmp[FILENAME_MAX];
		fnkdat(std::string("replay/" + mapname.substr(0, mapname.length() - 4) + ".rpl").c_str(), tmp, FILENAME_MAX, FNKDAT_USER | FNKDAT_CREAT);
		std::string replayname(tmp);

		FileStream* pStream = new FileStream();
		pStream->open(replayname.c_str(), "wb");
		InitSettings->save(*pStream);
		CmdManager.save(*pStream);
        delete pStream;
	}

	cursorFrame = CURSOR_NORMAL;

	if(fogSurf != NULL) {
		SDL_FreeSurface(fogSurf);
	}

	printf("Game finished!\n");
	fflush(stdout);
}

/**
    This method adds a new player.
    \param  House   the house of the new player
    \param  ai      true if ai, false if human player
    \param  team    the team number of the new player
*/
void GameClass::addPlayer(PLAYERHOUSE House, bool ai,int team)
{
	if(player[House] != NULL) {
		fprintf(stdout,"GameClass::addPlayer(): Trying to create already existing player!\n");
		exit(EXIT_FAILURE);
	}

	if(ai == true) {
		player[House] = new AiPlayerClass(House,House,House,DEFAULT_STARTINGCREDITS,InitSettings->Difficulty,team);
	} else {
		player[House] = new PlayerClass(House,House,House,DEFAULT_STARTINGCREDITS,team);
		thisPlayer = player[House];
	}
	player[House]->assignMapPlayerNum(House);
}

/**
    This method resumes the current paused game.
*/
void GameClass::ResumeGame()
{
	bPause = false;
}

/**
    This method is the callback method for the OPTIONS button at the top of the screen.
    It pauses the game and loads the in game menu.
*/
void GameClass::OnOptions()
{
    if(bReplay == true) {
        // don't show menu
        quit_Game();
    } else {
        pInGameMenu = new InGameMenu();
        bPause = true;
    }
}

/**
    This method is the callback method for the MENTAT button at the top of the screen.
    It pauses the game and loads the mentat help screen.
*/
void GameClass::OnMentat()
{
	if((pInGameMentat = new MentatHelp(InitSettings->House,InitSettings->mission)) == NULL) {
		fprintf(stdout,"GameClass::OnMentat(): Cannot create a MentatHelp object\n");
		exit(EXIT_FAILURE);
	}

	bPause = true;
}

/**
    This method initializes a replay.
    \param  filename    the file containing the replay
    \return true on success, false on failure
*/
bool GameClass::InitReplay(std::string filename) {
	bReplay = true;

	FileStream fs;

	if(fs.open(filename, "rb") == false) {
		perror("GameClass::loadSaveGame()");
		exit(EXIT_FAILURE);
	}

	// read GameInitClass
	GameInitClass* init = new GameInitClass();
	init->load(fs);

	// load all commands
	CmdManager.load(fs);

	return InitGame(init);

	// fs is closed by its destructor
}

/**
    This method is used for initialising a new GameClass object. The GameInitClass describes
    this new game.
    \param init describes the new game. Should be created with new and is deleted when this GameClass object is deleted.
    \return true on success, false on failure
*/
bool GameClass::InitGame(GameInitClass *init)
{
	if(InitSettings != NULL) {
		delete InitSettings;
	}

	InitSettings = init;

	if(init == NULL) {
		return false;
	}

	if(init->InitType == LOAD_GAME) {
		return loadSaveGame(init->mapname);
	} else {
		switch(init->gameType)
		{
			case SKIRMISH:
			case ORIGINAL:
			{
				gameType = init->gameType;
				techLevel = init->techlevel;
				RandomGen.setSeed(init->randomSeed);

				objectData.loadFromINIFile("ObjectData.ini");
				loadINIMap(init->mapname);

                if(bReplay == false) {
                    /* do briefing */
                    fprintf(stdout,"Briefing...");
                    fflush(stdout);
                    BriefingMenu* pBriefing = new BriefingMenu(init->House,init->mission,BRIEFING);
                    pBriefing->showMenu();
                    delete pBriefing;

                    fprintf(stdout,"\t\t\tfinished\n");
                    fflush(stdout);
                }
				return true;
			} break;

			default:
			{
				return false;
			} break;
		}
	}
}

/**
    This method should be called if whatNext() returns GAME_NEXTMISSION or GAME_LOAD. You should
    the destroy this GameClass and create a new one. Call GameClass::InitGame() with the GameInitClass
    that was returned previously by getNextGameInitClass().
    \return a GameInitClass-Object that describes the next game. (the object is created with new)
*/
GameInitClass* GameClass::getNextGameInitClass()
{
	if(NextGameInitSettings != NULL) {
		/* load game */
		return NextGameInitSettings;
	}

	GameInitClass *nextInit = new GameInitClass();

	switch(InitSettings->gameType)
	{
		case ORIGINAL:
		{
			/* do map choice */
			fprintf(stdout,"Map Choice...");
			fflush(stdout);
			MapChoice* pMapChoice = new MapChoice(InitSettings->House,InitSettings->mission);
			int newMission = pMapChoice->showMenu();
			delete pMapChoice;

			fprintf(stdout,"\t\t\tfinished\n");
			fflush(stdout);

			nextInit->setCampaign(InitSettings->House, newMission);
		} break;

		default:
		{
			delete nextInit;
			fprintf(stdout,"GameClass::getNextGameInitClass(): Wrong gameType for next Game.\n");
			fflush(stdout);
			return NULL;
		} break;
	}

	return nextInit;
}

/**
    This method should be called after startGame() has returned. whatNext() will tell the caller
    what should be done after the current game has finished.<br>
    Possible return values are:<br>
    GAME_RETURN_TO_MENU  - the game is finished and you should return to the main menu<br>
    GAME_NEXTMISSION     - the game is finished and you should load the next mission<br>
    GAME_LOAD			 - from inside the game the user requests to load a savegame and you should do this now<br>
    GAME_DEBRIEFING_WIN  - show debriefing (player has won) and call whatNext() again afterwards<br>
    GAME_DEBRIEFING_LOST - show debriefing (player has lost) and call whatNext() again afterwards<br>
    <br>
    \return one of GAME_RETURN_TO_MENU, GAME_NEXTMISSION, GAME_LOAD, GAME_DEBRIEFING_WIN, GAME_DEBRIEFING_LOST
*/
int GameClass::whatNext()
{
	if(whatNextParam != GAME_NOTHING) {
		int tmp = whatNextParam;
		whatNextParam = GAME_NOTHING;
		return tmp;
	}

	if(NextGameInitSettings != NULL) {
		return GAME_LOAD;
	}

	switch(gameType)
	{
		case ORIGINAL:
		{
			if(bQuitGame == true) {
				return GAME_RETURN_TO_MENU;
			} else if(won == true) {
				if(InitSettings->mission == 22) {
					// there is no mission after this mission
					whatNextParam = GAME_RETURN_TO_MENU;
				} else {
					// there is a mission after this mission
					whatNextParam = GAME_NEXTMISSION;
				}
				return GAME_DEBRIEFING_WIN;
			} else {
				whatNextParam = GAME_RETURN_TO_MENU;
				return GAME_DEBRIEFING_LOST;
			}
		} break;

		case SKIRMISH:
		{
			return GAME_RETURN_TO_MENU;
		} break;

		default:
		{
			return GAME_RETURN_TO_MENU;
		} break;
	}
}

/**
    This method loads a previously saved game.
    \param filename the name of the file to load from
    \return true on success, false on failure
*/
bool GameClass::loadSaveGame(std::string filename)
{
	short	mapSizeX, mapSizeY;
	int		i, x, magicNum;
	Coord		source, destination;

	FileStream fs;

	if(fs.open(filename.c_str(), "rb") == false) {
		perror("GameClass::loadSaveGame()");
		exit(EXIT_FAILURE);
	}

	gameState = LOADING;

	magicNum = fs.readUint32();
	if (magicNum != SAVEMAGIC) {
		fprintf(stdout,"GameClass::loadSaveGame(): No valid savegame: %s\n",filename.c_str());
		exit(EXIT_FAILURE);
	}

	//read map size
	mapSizeX = fs.readUint32();
	mapSizeY = fs.readUint32();

	//create the new map
	currentGameMap = new MapClass(mapSizeX, mapSizeY);

	//read GameCycleCount
	GameCycleCount = fs.readUint32();

	if(InitSettings != NULL) {
		delete InitSettings;
	}

	// read InitSettings
	InitSettings = new GameInitClass();
	InitSettings->load(fs);


	// read some settings
	gameType = (GAMETYPE) fs.readUint8();
	maxPathSearch = fs.readUint32();
	techLevel = fs.readUint8();;
	concreteRequired = fs.readBool();
	RandomGen.setSeed(fs.readUint32());

    // read in the unit/structure data
    objectData.load(fs);

	//load the player(s) info
	for (i=0; i<MAX_PLAYERS; i++) {
	    fs.readString();
		if (fs.readBool() == true) {
		    //player in game
		    if(fs.readBool() == true) {
		        //AI-Player
		        player[i] = new AiPlayerClass(fs, i);
		    } else {
		        player[i] = new PlayerClass(fs, i);
		    }
		}
		fs.readString();
	}

	debug = fs.readBool();

	winFlags = fs.readUint32();


    fs.readString();
	currentGameMap->load(fs);
	fs.readString();

	//load the structures and units
	objectManager.load(fs);

	setupView();

	x = fs.readUint32();
	for(i = 0; i < x; i++) {
	    fs.readString();
		bulletList.push_back(new BulletClass(fs));
		fs.readString();
	}

    x = fs.readUint32();
	for(i = 0; i < x; i++) {
	    fs.readString();
		explosionList.push_back(new Explosion(fs));
		fs.readString();
	}

	//load selection lists
	selectedList = fs.readUint32Set();

    for(int i=0;i< NUMSELECTEDLISTS; i++) {
        selectedLists[i] = fs.readUint32Set();
    }

	//load the screenborder info
    screenborder->load(fs);

    fs.readString();
	CmdManager.load(fs);

	fs.close();
	finished = false;

	return true;
}

/**
    This method saves the current running game.
    \param filename the name of the file to save to
    \return true on success, false on failure
*/
bool GameClass::saveGame(std::string filename)
{
	char	temp[256];
	int	i;

	FileStream fs;

	if( fs.open(filename.c_str(), "wb") == false) {
		perror("GameClass::saveGame()");
		sprintf(temp, "Game NOT saved: Cannot open \"%s\".", filename.c_str());
		currentGame->AddToNewsTicker(temp);
		return false;
	}

	fs.writeUint32(SAVEMAGIC);

	//write the map size
	fs.writeUint32(currentGameMap->sizeX);
	fs.writeUint32(currentGameMap->sizeY);

	// write GameCycleCount
	fs.writeUint32(GameCycleCount);

	// write InitSettings
	InitSettings->save(fs);

	// write some settings
	fs.writeUint8(gameType);
	fs.writeUint32(maxPathSearch);
	fs.writeUint8(techLevel);
	fs.writeBool(concreteRequired);
	fs.writeUint32(RandomGen.getSeed());

    // write out the unit/structure data
    objectData.save(fs);

	//write the player(s) info
	for (i=0; i<MAX_PLAYERS; i++) {
	    fs.writeString("<Player>");

		fs.writeBool(player[i] != NULL);

		if(player[i] != NULL) {
		    fs.writeBool(player[i]->isAI());
			player[i]->save(fs);
		}

		fs.writeString("</Player>");
	}

	fs.writeBool(debug);
	fs.writeUint32(winFlags);

    fs.writeString("<Map>");
	currentGameMap->save(fs);
    fs.writeString("</Map>");

	// save the structures and units
	objectManager.save(fs);

	fs.writeUint32(bulletList.size());
	for(RobustList<BulletClass*>::const_iterator iter = bulletList.begin(); iter != bulletList.end(); ++iter) {
	    fs.writeString("<Bullet>");
		(*iter)->save(fs);
		fs.writeString("</Buller>");
	}

	fs.writeUint32(explosionList.size());
	for(RobustList<Explosion*>::const_iterator iter = explosionList.begin(); iter != explosionList.end(); ++iter) {
	    fs.writeString("<Explosion>");
		(*iter)->save(fs);
		fs.writeString("</Explosion>");
	}

	// save selection lists

	// write out selected units list
	fs.writeUint32Set(selectedList);

	// write out selection groups (Key 1 to 9)
	for(int i=0; i < NUMSELECTEDLISTS; i++) {
	    fs.writeUint32Set(selectedLists[i]);
	}

	// write the screenborder info
	screenborder->save(fs);

    fs.writeString("CommandManager:");
	CmdManager.save(fs);

	fs.close();

	return true;
}

/**
    This method writes out an object to a stream.
    \param stream   the stream to write to
    \param obj      the object to be saved
*/
void GameClass::SaveObject(Stream& stream, ObjectClass* obj) {
	if(obj == NULL)
		return;

    stream.writeString("<Object>");
	stream.writeUint32(obj->getItemID());
	obj->save(stream);
    stream.writeString("</Object>");
}

/**
    This method loads an object from the stream.
    \param stream   the stream to read from
    \param ObjectID the object id that this unit/structure should get
    \return the read unit/structure
*/
ObjectClass* GameClass::LoadObject(Stream& stream, Uint32 ObjectID)
{
	Uint32 itemID;

    stream.readString();
	itemID = stream.readUint32();

	ObjectClass* newObject = ObjectClass::loadObject(stream, itemID, ObjectID);
	if(newObject == NULL) {
		fprintf(stdout,"GameClass::LoadObject(): ObjectClass::loadObject() returned NULL!\n");
		exit(EXIT_FAILURE);
	}
	stream.readString();

	return newObject;
}

/**
    This method selects all units/structures in the list aList.
    \param aList the list containing all the units/structures to be selected
*/
void GameClass::selectAll(std::set<Uint32>& aList)
{
    std::set<Uint32>::iterator iter;
    for(iter = aList.begin(); iter != aList.end(); ++iter) {
        ObjectClass *tempObject = objectManager.getObject(*iter);
        tempObject->setSelected(true);
    }
}

/**
    This method unselects all units/structures in the list aList.
    \param aList the list containing all the units/structures to be unselected
*/
void GameClass::unselectAll(std::set<Uint32>& aList)
{
    std::set<Uint32>::iterator iter;
    for(iter = aList.begin(); iter != aList.end(); ++iter) {
        ObjectClass *tempObject = objectManager.getObject(*iter);
        tempObject->setSelected(false);
    }
}
