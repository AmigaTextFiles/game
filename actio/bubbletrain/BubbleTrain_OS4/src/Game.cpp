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

#include "Game.h"

Game::Game(SDL_Surface* screen)
{
	this->screen = screen;
	Theme::Instance()->initialise(screen);
	Game::newGame();
	this->credits = Options::Instance()->getCredits();
	this->msgBox = NULL;
	this->active = true;
	this->enableFPS = false;
}

Game::~Game()
{
	if (this->currentLevel != NULL)
	{
		delete this->currentLevel;
		this->currentLevel = NULL;
	}
}

void Game::newGame()
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::newGame");
	
	Game::deletePlayers();
	Game::deleteLevels();
	this->currentLevel = NULL;
	this->totalTime = 0;
	List<Cannon> cannons;
	
	this->currentLevel = new Level(this->screen);

}

void Game::load(const char* path, const char* filename)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::load");
	
	this->gameFilename = strdup(filename);
	this->path = strdup(path);
	
	char fullFilename[512];
	mergeFilename(path, filename, fullFilename);

	xmlDocPtr doc;
	xmlNodePtr root;

    doc = loadXMLDocument(fullFilename);
    if (!checkRootNode(doc, "game"))
    	Log::Instance()->die(1, SV_ERROR, "Game load failed loading file %s [root node not game]", filename);
	
	root = xmlDocGetRootElement(doc);
    if (root == NULL)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Game load failed loading file %s [Empty Document]", filename);
		xmlFreeDoc(doc);
		return;
    }
    
    Game::load(doc, root);

	xmlFreeDoc(doc);
}

void Game::load(xmlDocPtr doc, xmlNodePtr cur)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::load");
	
	int num = 1;
	
    // For now load all of the level file names into the level array and then load
    // the first level
	cur = cur->xmlChildrenNode;
	while (cur != NULL)
	{
		if (strcmp((const char*)cur->name, "level"))
		{
			cur = cur->next;
			continue;
		}
       
		char* filenameText = (char*)xmlGetProp(cur, (const xmlChar*)"src");
		if (filenameText == NULL or strcmp(filenameText, "") == 0)
			Log::Instance()->die(1, SV_ERROR, "Game::load failed level src not found");
			
		char* themeText = (char*)xmlGetProp(cur, (const xmlChar*)"theme");
		if (themeText == NULL or strcmp(themeText, "") == 0)
		{
			strcpy(themeText, "default");
			Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Game::load theme not found, using default");
		}
		
		this->levels.Append(new LevelDetails(filenameText, themeText, num++));	
		cur = cur->next;
    }
    this->currentLevelDetails = this->levels.GetIterator();
    this->currentLevelDetails.Start();
    
    // Now load the first level
    Game::loadLevel(this->path, this->currentLevelDetails.Item());
    
}

void Game::save(xmlDocPtr doc, xmlNodePtr cur)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::save");
}

void Game::save(const char* path, const char* filename)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::save");
}

void Game::setActive(bool active)
{

	Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Game::setActive %d", active);
	// only allow the game to pause the user must phyiscally unpause
	// Also only allow the game to pause when the level is running.
	if (this->currentLevel->getState() != LS_RUNNING)
		return;
		
	if (active == false)
		Game::overrideActive(active);
}

void Game::overrideActive(bool active)
{
	this->active = active;
	this->currentLevel->setActive(active);
}

void Game::animate()
{
	if (this->currentLevel != NULL)
		this->currentLevel->animate();
	
	// Update the frame rate
	// Frame rate stuff
	static Uint32 Ticks=0;
	static int Frames=0;
	
	// Draw out the frame rate
	Frames++;
	if(SDL_GetTicks() > Ticks + 1000)
	{
		this->fps = Frames;
		Frames = 0;
		Ticks = SDL_GetTicks();
	}
}

bool Game::pollKeyStates()
{
	// Only process the keystates when the game is running.
	if (this->currentLevel->getState() != LS_RUNNING)
		return false;
		
	return this->currentLevel->pollKeyStates();
}

void Game::draw(SDL_Surface* screenDest)
{	
	// Current Level
	if (this->currentLevel != NULL)
		this->currentLevel->draw(screenDest);

	// Total Time
	Rect rTotalTime(180,575, 310, 591);
	Theme::Instance()->drawText(screenDest, FONT_SCORE, rTotalTime, Middle, Left, "Total Time - %d", this->totalTime);

	// Credits
	Rect rFPS(655,575,785,591);
	if (this->credits == -1)
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rFPS, Middle, Left, "Credits - infinite");
	else
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rFPS, Middle, Left, "Credits - %d", this->credits);

	// FPS
	if (this->enableFPS)
	{
		Rect rFPS(2, 2, 132, 17);
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rFPS, Middle, Left, "FPS - %d", this->fps);
	}
	
	// Paused
	if (!this->active)
	{
		if (msgBox == NULL)
			msgBox = new MessageBox(screenDest, "Paused");
			
		msgBox->draw(screenDest);
		
		return;
	}
	
	// Display a msg based on the state of the level
	switch (this->currentLevel->getState())
	{
		case LS_NOTSTARTED:
		{
			// Start of the level
			if (msgBox == NULL)
				msgBox = new MessageBox(screenDest, "Level - %d", this->currentLevel->getNum());
			
			msgBox->draw(screenDest);
			
			break;
		}
		case LS_RUNNING:
			break;
		case LS_GAMEOVER:
		{
			if (msgBox == NULL)
			{
				// Game over if only 1 credit left 
				// Else give them another change to complete the level
				if (this->credits == 1)
					msgBox = new MessageBox(screenDest, "Game Over");
				else
					msgBox = new MessageBox(screenDest, "You suck - Try again");
			}
			
			msgBox->draw(screenDest);
			
			break;
		}
		case LS_WON:
		{
			if (msgBox == NULL)
			{
				// Level completed
				msgBox = new MessageBox(screenDest, "Cool - Time %d", LevelTimer::Instance()->getTime());
			}
			
			msgBox->draw(screenDest);
			
			break;
		}
	}
}

bool Game::mouseDown(int x, int y)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::click");

	// If Game paused then make sure it doesn't stay paused
	if (!this->active)
	{
		Game::overrideActive(true);
		return true;
	}

	if (Game::gameProcessEvents())
		return true;
	
	if (this->currentLevel != NULL)
		return this->currentLevel->mouseDown(x,y);
	
	return false;
}

bool Game::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::keypress");
	
	switch (key)
	{
		case SDLK_ESCAPE:
		{
			Game::endGame();
			return true;
		}
		case SDLK_KP_PLUS:
		{
			// Move onto the next level
			this->currentLevelDetails.Forth();
			if (this->currentLevelDetails.Valid())
				Game::loadLevel(this->path,this->currentLevelDetails.Item());
			else
				this->currentLevelDetails.End();
			
			// Clear out the current message
			if (this->msgBox != NULL)
			{
				delete this->msgBox;
				this->msgBox = NULL;
			}				
			return true;
		}
		case SDLK_KP_MINUS:
		{
			// Move onto the next level
			this->currentLevelDetails.Back();
			if (this->currentLevelDetails.Valid())
				Game::loadLevel(this->path,this->currentLevelDetails.Item());
			else
				this->currentLevelDetails.Start();				
			
			// Clear out the current message
			if (this->msgBox != NULL)
			{
				delete this->msgBox;
				this->msgBox = NULL;
			}			
			return true;
		}
		case SDLK_F1:
		{
			char filename[100];
			sprintf(filename, "%d.bmp", SDL_GetTicks());
			SDL_SaveBMP( SDL_GetVideoSurface(), filename );
			return true;
		}
		case SDLK_F2:
		{
			this->enableFPS = !this->enableFPS;
			return true;
		}
		case SDLK_p:
		{
			Log::Instance()->log("Paused by the game because of SDLK_P being pressed");
			// pause the game, but only if the game is running
			if (this->currentLevel->getState() == LS_RUNNING)
			{
				Game::overrideActive(!this->active);
			}
			else
			{	
				// If not running then make sure that it isn't paused
				Game::overrideActive(true);
			}
			return true;	
		}
		default:
			break;
	}
	
	if (Game::gameProcessEvents())
		return true;
	
	// If the game hasn't processed the key event then pass on down to the level.
	if (this->currentLevel)
		return this->currentLevel->keyPress(key, mod, character);
	
	return false;
}

void Game::loadLevel(const char* path, LevelDetails* details)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::loadLevel");
	
	if (this->currentLevel == NULL)
		this->currentLevel = new Level(this->screen);
	
	Theme::Instance()->load(path, details->theme);
	
	// Now load the game
    this->currentLevel->load(path, details->filename);
    this->currentLevel->setNum(details->num);
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game:: finished loadLevel");
}

void Game::deletePlayers()
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Game::deletePlayers");
}

void Game::deleteLevels()
{
	this->levels.DeleteAndRemove();
}

bool Game::gameProcessEvents()
{
	if (msgBox != NULL)
	{
		delete msgBox;
		msgBox = NULL;
	}
	
	switch (this->currentLevel->getState())
	{
		case LS_NOTSTARTED:
		{
			this->currentLevel->startLevel();
			SDL_ShowCursor(SDL_DISABLE);
			return true;	
		}
		case LS_RUNNING:
			break;
		case LS_GAMEOVER:
		{
			if (this->credits == 1)
			{
				// Game over go and do the right thing
				Game::endGame();
			}
			else
			{
				// Player failed to finish the level so let them replay
				if (this->credits != -1)
					this->credits--;
					
				// replay the same level again
				Game::loadLevel(this->path,this->currentLevelDetails.Item());
				SDL_ShowCursor(SDL_ENABLE);
			}
			return true;
		}
		case LS_WON:
		{
			// Increment the score
			this->totalTime += LevelTimer::Instance()->getTime();
			LevelTimer::Instance()->reset();
			
			// Move onto the next level
			this->currentLevelDetails.Forth();
			if (this->currentLevelDetails.Valid())
			{
				Game::loadLevel(this->path,this->currentLevelDetails.Item());
			}
			else
			{
				// This is really the end of the game. Give them their score and 
				// add to high score if nesseary?
				this->currentLevelDetails.End();
				Game::endGame();
			}
			return true;
		}
	}
	
	return false;
}


void Game::endGame()
{
	SDL_ShowCursor(SDL_ENABLE);
	
	// The player has had enough check their score to see if they have reached the
	// fastest time table.
	// If we haven't finished the current level then the level num for the score is the previous
	// level.
	int scoreLevel = this->currentLevelDetails.Item()->num;
	if (this->currentLevel->getState() != LS_WON)
		scoreLevel--;
	
	// 3 states - they have completed the game, run out of credits and 
	// have reached the fastest time or neither of the above.
	if (this->levels.Size() == scoreLevel && this->currentLevel->getState() == LS_WON)
	{
		// Note let the game end sort out if they should enter the fastest time
		WindowManager::Instance()->clear();
		WindowManager::Instance()->push(new GameEnd(SDL_GetVideoSurface(), this->gameFilename, scoreLevel, this->totalTime));
	}
	else if (this->totalTime > 0 && FastestTime::Instance()->checkAddHS(this->gameFilename, scoreLevel, this->totalTime))
	{
		// Haven't completed level but should add fastest time
		this->currentLevel->setActive(false);
		WindowManager::Instance()->push(new FastestTimeText(SDL_GetVideoSurface(), this->gameFilename, scoreLevel, this->totalTime));
	}
	else
	{
		// Go back to the main menu
		WindowManager::Instance()->clear();
		WindowManager::Instance()->push(new MainMenu(SDL_GetVideoSurface()));
	}	
}
