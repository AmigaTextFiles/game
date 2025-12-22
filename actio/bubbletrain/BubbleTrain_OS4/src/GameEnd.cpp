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

#include "GameEnd.h"

GameEnd::GameEnd(SDL_Surface* screen, const char* game, int level, int score)  : Window(screen, Rect(0,0,screen->w, screen->h))
{
	// reload the default theme so we know the correct fonts etc will be used
	Theme::Instance()->load("", "default");

	// Setup the back ground image
	Window::loadBackgroundImage("../gfx/endgame.png");
	
	// Set the score/level
	this->score = score;
	this->level = level;
	this->game = strdup(game);
	
	// Initialise the bubble text
	char buffer[255];
	this->bubbleText.Append("Congratulations");
	sprintf(buffer, "Level\n%s\nCompleted", game);
	this->bubbleText.Append(strdup(buffer));
	this->bubbleText.Append("Your\nGood");
	sprintf(buffer, "Total Time %d", score);
	this->bubbleText.Append(strdup(buffer));
	this->bubbleText.Append("Brought to you\nby");
	this->bubbleText.Append("Adam Child\nof\nDwarf City");
	this->bubbleText.Append("and Craig Marshall");
	this->bubbleText.Append("OS4 Port By ToAks");
	this->bubbleText.Append("Thank you for playing\nBubble Train Amiga OS4");
	
	this->currentBubbleText = this->bubbleText.GetIterator();
	this->currentBubbleText.Start();
			
	
	this->startTime = SDL_GetTicks();
	this->delayTime = 3000;
}

GameEnd::~GameEnd()
{
	delete this->game;
}


void GameEnd::animate()
{
	// Figure out the size of the screen
	Rect screenSize(0,0,SDL_GetVideoSurface()->w, SDL_GetVideoSurface()->h);
		
	// Bubble Text
	// ------------------------------------------------
	// Make sure we only start to move the text after the elapsed time
	if (this->startTime + this->delayTime < SDL_GetTicks())
	{
		DListIterator<ExplodingBubble*> textBubIter = this->bubbleTextBubbles.GetIterator();
		textBubIter.Start();
		while (textBubIter.Valid())
		{
			textBubIter.Item()->animate();
			if (!textBubIter.Item()->onScreen(screenSize, 0))
			{
				delete textBubIter.Item();
				this->bubbleTextBubbles.Remove(textBubIter);
			}
			textBubIter.Forth();
		}
		
		DListIterator<TextExplodingBubble*> textExplodinBubIter = this->textBubbles.GetIterator();
		textExplodinBubIter.Start();
		while (textExplodinBubIter.Valid())
		{
			textExplodinBubIter.Item()->animate();
			if (!textExplodinBubIter.Item()->onScreen(screenSize, 0))
			{
				delete textExplodinBubIter.Item();
				this->textBubbles.Remove(textExplodinBubIter);
			}
			textExplodinBubIter.Forth();
		}
	}
	
	// For testing just add a couple of characters and keep reseting it
	// after all of the bubbles have moved off screen
	if (this->bubbleTextBubbles.Size() == 0 && this->textBubbles.Size() == 0)
	{
		Point startPos(10,10);
		
		startPos.x = screenSize.width() / 2;
		startPos.y = screenSize.height() / 2;
		
		if (this->currentBubbleText.Valid())
		{
			GameEnd::writeBubbleText(&this->textBubbles, this->currentBubbleText.Item(), startPos);
			this->currentBubbleText.Forth();
		}
		else
		{
			if (FastestTime::Instance()->checkAddHS(this->game, this->level, this->score))
			{
				Log::Instance()->log("GameEnd::Displaying fastest time name entry box");
				// Remove ourselves and display the high score 
				WindowManager::Instance()->remove(this);
				WindowManager::Instance()->push(new FastestTimeText(SDL_GetVideoSurface(), this->game, this->level, this->score));
			}
			else
			{
				Log::Instance()->log("GameEnd::Your rubbish displaying the main menu");
				// Go back to the main menu
				WindowManager::Instance()->clear();
				WindowManager::Instance()->push(new MainMenu(SDL_GetVideoSurface()));
			}
			return;
		}	
		
		// Reset the timer
		this->startTime = SDL_GetTicks();
	}
	

	// Flying bubbles
	// ------------------------------------------------
	
	// Make sure we always have the maximum number of bubbles on screen
	Point startPos(SDL_GetVideoSurface()->w / 2, SDL_GetVideoSurface()->h / 2);
	while (this->flyingBubbles.Size() < MAX_GAME_END_BUBBLES)
	{
		ExplodingBubble* expBub = new ExplodingBubble((Colour)random(MAX_COLOUR - 1), startPos);
		this->flyingBubbles.Append(expBub);
	}
		
	// Move all of the flying bubbles and remove any that have gone off screen
	DListIterator<ExplodingBubble*> flyBubIter = this->flyingBubbles.GetIterator();
	flyBubIter.Start();
	while (flyBubIter.Valid())
	{
		flyBubIter.Item()->animate();
		if (!flyBubIter.Item()->onScreen(screenSize, 0))
		{
			delete flyBubIter.Item();
			this->flyingBubbles.Remove(flyBubIter);
		}
		flyBubIter.Forth();
	}

}

void GameEnd::draw(SDL_Surface* screenDest)
{
	Window::draw(screenDest);
		
	// Flying bubbles
	DListIterator<ExplodingBubble*> flyBubIter = this->flyingBubbles.GetIterator();
	flyBubIter.Start();
	while (flyBubIter.Valid())
	{
		flyBubIter.Item()->draw(screenDest);
		flyBubIter.Forth();
	}
	
	// The bubble text
	DListIterator<ExplodingBubble*> textBubIter = this->bubbleTextBubbles.GetIterator();
	textBubIter.Start();
	while (textBubIter.Valid())
	{
		textBubIter.Item()->draw(screenDest);
		textBubIter.Forth();
	}
	
	// The bubble with text on
	DListIterator<TextExplodingBubble*> textExplodingBubIter = this->textBubbles.GetIterator();
	textExplodingBubIter.Start();
	while (textExplodingBubIter.Valid())
	{
		textExplodingBubIter.Item()->draw(screenDest);
		textExplodingBubIter.Forth();
	}
	
	
}

bool GameEnd::mouseDown(int x, int y)
{
	WindowManager::Instance()->clear();
	WindowManager::Instance()->push(new MainMenu(SDL_GetVideoSurface()));
	return true;
}

bool GameEnd::keyPress( SDLKey key, SDLMod mod, Uint16 character)
{
	WindowManager::Instance()->clear();
	WindowManager::Instance()->push(new MainMenu(SDL_GetVideoSurface()));
	return true;
}

void GameEnd::writeBubbleText(List<TextExplodingBubble *>* bubbleList, const char* text, Point pos)
{
	// Create text, made up of bubble with text in the middle
	// All lines are centred and each word uses a different colour;
	int textLength = strlen(text);
	char buffer[2];
	Point currentPos;
	char* newline = NULL;
	int charactersInLine = 0;
	Colour currentColour = (Colour)random(MAX_COLOUR);
	
	// The pos is the centre of the complete text string. so shift the start position
	// to the left by the number of bubbles. Make sure we take care of new lines
	newline = strchr(text, '\n');
	if (newline != NULL)
		charactersInLine = newline - text;
	else
		charactersInLine = textLength;
	
	currentPos.y = pos.y;	
	currentPos.x = pos.x - BUBBLE_SIZE * charactersInLine / 2 + BUBBLE_RAD;
	
	for (int i = 0; i < textLength; i++)
	{
		if (text[i] == '\n')
		{
			// Find the end of the line to reset the current position to allow
			// for this line to be centred.
			newline = strchr(text + i + 1, '\n');
			if (newline != NULL)
				charactersInLine = newline - text - i - 1;
			else
				charactersInLine = textLength - i - 1;
				
			currentPos.x = pos.x - BUBBLE_SIZE * charactersInLine / 2 + BUBBLE_RAD;
			currentPos.y += BUBBLE_SIZE;
			
			// Change the colour for the next word
			currentColour = (Colour)random(MAX_COLOUR);
			
			continue;
		}
		else if (text[i] == ' ')
		{
			// Leave a gap for spaces
			currentPos.x += BUBBLE_SIZE;
	
			// Change the colour for the next word
			currentColour = (Colour)random(MAX_COLOUR);
			
			continue;	
		}
		
		// Create a new text bubble to add to the list
		TextExplodingBubble* teb = new TextExplodingBubble( currentColour, currentPos);
		sprintf(buffer, "%c", text[i]);
		teb->setText(buffer);
		bubbleList->Append(teb);
		
		currentPos.x += BUBBLE_SIZE;
	}
}

