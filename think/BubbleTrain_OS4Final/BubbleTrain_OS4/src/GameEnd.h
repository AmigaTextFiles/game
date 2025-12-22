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
  * Game end is an animation to congratulate the player when they have completed
  * the game.
  *
  * Display a message to the player using bubble text which explode after a couple
  * of seconds.
  */
 
#ifndef GAMEEND_H
#define GAMEEND_H

#include "General.h"
#include "IWidget.h"
#include "List.h"
#include "ExplodingBubble.h"
#include "TextExplodingBubble.h"
#include "Theme.h"
#include "MainMenu.h"
#include "FastestTime.h"
#include "Window.h"
#include "WindowManager.h"

// Number of bubbles to display in the bubble fountain
#define MAX_GAME_END_BUBBLES 10

class GameEnd : public Window
{
private:

	// Game / time details
	char* game;
	int level;
	int score;

	// Animation
	List<char*> bubbleText;
	DListIterator<char*> currentBubbleText;
	List<TextExplodingBubble *> textBubbles;
	List<ExplodingBubble *> bubbleTextBubbles;
	List<ExplodingBubble *> flyingBubbles;
	Uint32 startTime;
	Uint32 delayTime;
	
	// Functions for creating text out of bubbles
	void writeBubbleText(List<TextExplodingBubble *>* bubbleList, const char* text, Point pos);

public:

	GameEnd(SDL_Surface* screen, const char* game, int level, int score);
	virtual ~GameEnd();

	// IWidget methods
	virtual void animate();
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character);
};

#endif // GAMEEND_H
