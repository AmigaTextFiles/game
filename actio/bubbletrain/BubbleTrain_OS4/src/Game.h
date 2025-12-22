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
 
 /*
  * Game is the main controller for a game, managing the levels, scores
  * credits etc.
  */
 
#ifndef GAME_H
#define GAME_H

// System includes
#include <libxml/xpath.h>

// Game includes
#include "IWidget.h"
#include "ILoadSave.h"
#include "List.h"
#include "RecordReplayActions.h"
#include "Level.h"
#include "Bubble.h"
#include "Font.h"
#include "LevelTimer.h"
#include "WindowManager.h"
#include "MainMenu.h"
#include "FastestTimeText.h"
#include "MessageBox.h"
#include "GameEnd.h"

// Structure for defining a level
struct LevelDetails
{
	char* filename;
	char* theme;
	int num;
	
	LevelDetails (const char* filename, const char* theme, const int num)
	{
		this->filename 	= strdup(filename);
		this->theme 	= strdup(theme);
		this->num 		= num;
	}
};

class Game : public IWidget, public ILoadSave
{
private:
	SDL_Surface* screen;		// The main screen to draw to
	
	char* gameFilename;			// Filename of the game we are playing
	char* path;					// The path to where the game is stored
	
	List<LevelDetails*> levels;	// A list of the level in the current game
	DListIterator<LevelDetails*> currentLevelDetails;
	Level* currentLevel;		// The current level being played
	
	bool enableFPS;				// Define if displaying the fps and what it is
	int fps;
	
	int credits;				// Define the current number of credit remaining
	int totalTime;				// The total time taken so far - i.e. scoring
	
	MessageBox* msgBox;			// Display simple message boxes which 
								// aren't controlled by the window manager

	void loadLevel(const char* path, LevelDetails* details);
	bool gameProcessEvents();
	
	// End game and either enter highscore or go to the main menu
	void endGame();
	
	// Change the activeness of the level
	void overrideActive(bool active);
	
	// Clean up
	void deletePlayers();
	void deleteLevels();

public:
	Game(SDL_Surface* screen);
	virtual ~Game();
	
	void newGame();
	virtual void setActive(bool active);
	
	// ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void load(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);
	
	// IWidget methods
	virtual void animate();
	virtual bool pollKeyStates();	
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character);

};

#endif
