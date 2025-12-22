/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */
 
#include "GameSelect.h"

GameSelect::GameSelect(SDL_Surface* screen) : Window(screen)
{
	// Define the base directory to search for games to play
	this->directory = "../levels/";
	
	// Default the window to zero until we have set the size
	// Make the window 300x150 and centred
	int winWidth = 300;
	int winHeight = 300;
	int border = 12;
	int buttonWidth = 80;
	int buttonHeight = 20;
	
	// Display the window centred on the game window
	int startPosx = (int)(APP_WIDTH - winWidth) / 2;
	int startPosy = (int)(APP_HEIGHT - winHeight) / 2;
	
	Rect windowSize(startPosx, startPosy, startPosx + winWidth, startPosy + winHeight);
	Window::setSize(windowSize);
	
	// Load callback
	Callback0<GameSelect> loadCallBack(*this,&GameSelect::loadGameClick);
    
	// Add a label to tell what the hell is going on in here.
	Label* FastestTimeLabel = new Label(Point(border, border), Point(winWidth - 2 * border, 2 * border));
	FastestTimeLabel->setLabelText("Game Select");
	FastestTimeLabel->setFont(FONT_MENU);
	Window::addControl(FastestTimeLabel);
	
	// Add a list box
	Rect rList(border, 3*border, winWidth - border, winHeight - buttonHeight - 2*border);
	this->gameList = new ListBox(rList);
	GameSelect::getGameFiles();
	this->gameList->addDoubleClickEvent(loadCallBack);
	this->gameList->setActiveColour(SDL_MapRGB(SDL_GetVideoSurface()->format, 0x99, 0x99, 0x99));
	this->gameList->setHighLightColour(SDL_MapRGB(SDL_GetVideoSurface()->format, 0x66, 0x66, 0x66));
	Window::addControl(this->gameList);
	
	// Add a cancel button
	Rect rbtnCancel(winWidth - buttonWidth - border, winHeight - buttonHeight - border, winWidth - border, winHeight - border );
	Callback0<GameSelect> cancelCallBack(*this,&GameSelect::cancel);
	Button* btnCancel = new Button(cancelCallBack, "Cancel", rbtnCancel);
	btnCancel->setAccessKey(SDLK_ESCAPE);
	btnCancel->setActiveColour(SDL_MapRGB(screen->format, 0x70, 0xB7, 0xFE));
	Window::addControl(btnCancel);

	// Add a button for the load
	Rect rbtnLoad(rbtnCancel.topLeft.x - buttonWidth - border, rbtnCancel.topLeft.y, rbtnCancel.topLeft.x - border, rbtnCancel.bottomRight.y );
	Button* btnLoad = new Button(loadCallBack, "Load", rbtnLoad);
	btnLoad->setAccessKey(SDLK_RETURN);
	btnLoad->setActiveColour(SDL_MapRGB(screen->format, 0x70, 0xB7, 0xFE));
	Window::addControl(btnLoad);

	// Set the background colour to the red
	Window::setBackgroundColour(SDL_MapRGB(screen->format, 0x9A, 0x35, 0x68));
	Window::setInnerBevel(true);
	Window::setBorderThickness(2);
}

GameSelect::~GameSelect()
{
	// Nothing to tidy up
}

void GameSelect::getGameFiles()
{
	struct dirent *entryp = NULL;
	char* nameEnd = NULL;
	char* nameEndTemp = NULL;
	char* niceName = NULL;
	DIR *dp = NULL;
	
	// Search the game directory for games to play
	// Only display items which end in .gms
	if ((dp = opendir(directory)) == NULL)
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "GameSelect:: Failed to open %s directory for reading game files", directory);	
	
	while ((entryp = readdir(dp)) != NULL)
	{
		// filter out any filenames which don't end in .gms
		if (strlen(entryp->d_name) < 5)
			continue;
		
		nameEnd = entryp->d_name;
		nameEnd += strlen(nameEnd) - 4;
		
		// Make the extension lower case so the comparison below works
		nameEndTemp = nameEnd;
		while(*nameEndTemp != '\0')
		{
			*nameEndTemp = tolower(*nameEndTemp);
			nameEndTemp++;	
		}
		
		// Make sure we have a valid game file ignore everything else.
		if (!strcmp(nameEnd, ".gms") == 0)
			continue;
		
		// Create cleaned up version of the game filename with out the extension
		// to be displayed as the description and use the actual name as the value
		niceName = strdup(entryp->d_name);
		nameEndTemp = niceName;
		nameEndTemp += strlen(niceName) - 4;
		*nameEndTemp = '\0';
		
		// Item must be valid so add to the list
		this->gameList->addItem(niceName, entryp->d_name);
		
		// Clean up the memory allocated
		delete[] niceName;
	}

	closedir(dp);
}

// Load the new game
void GameSelect::loadGame(const char* gameFile)
{
	// Create a new game to play and update the window list throught the window manager
	Game* game = new Game(Window::rootScreen);
	game->load(directory, gameFile);
	WindowManager::Instance()->clear();
	WindowManager::Instance()->push(game);
}

void GameSelect::loadGameClick()
{
	// Load the selected game from the menu
	if (!this->gameList->itemSelected())
	{
		GameSelect::cancel();
		return;
	}
	
	GameSelect::loadGame(this->gameList->getSelectedValue());
}

// Cancel the current window
void GameSelect::cancel()
{
	WindowManager::Instance()->remove(this);
}
