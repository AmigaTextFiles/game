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
  * Level keep track of the current level including the cannon, trains stations,
  * bullets and the level timer and process the events for each of these.
  */
  
#ifndef LEVEL_H
#define LEVEL_H

// Game includes
#include "IWidget.h"
#include "ILoadSave.h"
#include "List.h"
#include "Theme.h"
#include "Cannon.h"
#include "General.h"
#include "TrainStation.h"
#include "BulletFactory.h"
#include "Bullet.h"
#include "LevelTimer.h"

#define HUD_HEIGHT 36	// Define the height of the hud graphic in the theme

// Defines the controls for the cannon
enum PlayActions
{
	PLAY_LEFT = 0,
	PLAY_RIGHT = 1,
	PLAY_FIRE = 2
};

class Level : public IWidget, public ILoadSave
{

private:
	int num;								// Level number, the order it appears in the game
	LevelState state;						// Current state of the level, i.e. won, lost, paused

	SDL_Surface* screen;					// Cache the main display
	Theme* theme;							// Reference to the current theme
	
	List<TrainStation*> trainStations;		// A list of train stations for the current level
	DListIterator<TrainStation*> trainIter;	
	
	List<Bullet*> activeBullets;			// Keeps track of the bullets fired
	DListIterator<Bullet*> bulletIter;
	
	List<Cannon*> cannons;					// A list of cannons - just incase more than one player
	DListIterator<Cannon*> cannonIter;
	
	Rect wallBound;							// Keep the bounds of the screen for calculating when bullets go off screen
	int keys[2][3]; 						// Have a 2D array of key stroke mappings. i.e. keys[player][action]
	
	void initialise();
	void checkBulletHits();
	void loadCannons(xmlDocPtr doc, xmlNodePtr cur);
	void loadTrainstations(xmlDocPtr doc, xmlNodePtr cur);
	
public:
	
	Level(SDL_Surface* screen);
	virtual ~Level();
	
	void bulletFired(Bullet* bullet);
	bool canFireBullet();
	LevelState getState();
	void setNum(const int num);
	int getNum();
	void startLevel();
	
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
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character );
};

#endif
