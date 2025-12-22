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
 
#include "Level.h"

#undef LOG_THRESHOLD
#define LOG_THRESHOLD SV_WARNING

Level::Level(SDL_Surface* screen)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::constructor");
	
	this->screen = screen;
	this->theme = Theme::Instance();
	this->active = true;

	// Get the players keys from the option file.
	this->keys[0][PLAY_LEFT] = Options::Instance()->getCannonLeftKey();
	this->keys[0][PLAY_RIGHT] = Options::Instance()->getCannonRightKey();
	this->keys[0][PLAY_FIRE] = Options::Instance()->getFireKey();
	
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::constructor end");
}

Level::~Level()
{
	this->cannons.DeleteAndRemove();
	this->trainStations.DeleteAndRemove();
	this->activeBullets.DeleteAndRemove();
}


void Level::load(xmlDocPtr doc, xmlNodePtr cur)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level:: load node");
	Level::loadCannons(doc, cur);
	Level::loadTrainstations(doc, cur); 
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level:: Finsihed load node");
}

void Level::load(const char* path, const char* filename)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level:: load filename");
	Level::initialise();
	
	xmlDocPtr doc;
	xmlNodePtr root;
	
	char fullFilename[512];
	mergeFilename(path, filename, fullFilename);
	
	doc = loadXMLDocument(fullFilename);
	if (!checkRootNode(doc, "level"))
		Log::Instance()->die(1, SV_ERROR, "Level load failed loading file %s%s [root node not level]", path, filename);
	
	root = xmlDocGetRootElement(doc);
	if (root == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Level load failed loading file %s [Empty Document]", filename);
		xmlFreeDoc(doc);
		return;
	}
	
	Level::load(doc, root);
	
	xmlFreeDoc(doc);
	
	Theme::Instance()->playThemeMusic();
	
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level:: Finsihed load filename");
}

void Level::save(xmlDocPtr doc, xmlNodePtr cur)
{
	// Nothing to save
}

void Level::save(const char* path, const char* filename)
{
	// Nothing to save
}

void Level::animate()
{
	if (!this->active)
		return;
	
	// Figure out the size of the screen
	Rect screenSize(0,0,this->screen->w, this->screen->h);
	
	// Cannons
	this->cannonIter.Start();
	while (cannonIter.Valid())
	{
		this->cannonIter.Item()->animate(this->state);
		this->cannonIter.Forth();
	}
	
	// Move all of the trains around the screen;
	this->trainIter.Start();
	while (this->trainIter.Valid())
	{
		this->trainIter.Item()->animate(this->state);
		this->trainIter.Forth();
	}
	
	// Move all of the active bullets around the screen;
	this->bulletIter.Start();
	while (this->bulletIter.Valid())
	{
		Bullet* bullet = this->bulletIter.Item();
		bullet->animate();
		// Check if the bubble has gone off the screen
		// if so then remove from the list
		if (!bullet->onScreen(screenSize, 0))
			activeBullets.Remove(this->bulletIter);

		this->bulletIter.Forth();
	}
	
	if (this->state != LS_RUNNING)
		return;
	
	// Update the level timer to show how long we have been running this level
	LevelTimer::Instance()->increment();
	
	// Check if any bullets have hit their targets
	Level::checkBulletHits();
	
	// Update the level state
	// If all trains and stations are empty then we have won
	// If any train has crashed then game over
	this->trainIter.Start();
	int emptyStationTrainCount = 0;
	while (this->trainIter.Valid())
	{
		TrainState tState = this->trainIter.Item()->getTrainState();
		if (tState == TS_CRASHED)
		{
			this->state = LS_GAMEOVER;
			Theme::Instance()->playSound(SND_GAMEOVER);
			break;
		} else if (tState == TS_EMPTY && this->trainIter.Item()->isStationEmpty())
			emptyStationTrainCount++;
		this->trainIter.Forth();
	}
	if (emptyStationTrainCount == this->trainStations.Size())
	{
		this->state = LS_WON;
		Theme::Instance()->playSound(SND_GAMEWON);
	}
}

void Level::bulletFired(Bullet* bullet)
{
	this->activeBullets.Append(bullet);
}

bool Level::canFireBullet()
{
	// for now only allow one bullet at a time be fired
	return (this->activeBullets.Size() <= 10);
}

LevelState Level::getState()
{
	return this->state;
}

void Level::setNum(const int num)
{
	this->num = num;
}

int Level::getNum()
{
	return this->num;
}

void Level::startLevel()
{
	this->state = LS_RUNNING;
	LevelTimer::Instance()->reset();
}

bool Level::pollKeyStates()
{
	if (this->keyStates == NULL)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "KeyStates NULL");
	}
	
	if (Level::getState() != LS_RUNNING)
		return false;

	// Cannons
	this->cannonIter.Start();
	int player=0;
	while (this->cannonIter.Valid())
	{
		if (!this->cannonIter.Item()->getUseMouse())
		{
			if (this->keyStates[this->keys[player][PLAY_LEFT]])
				this->cannonIter.Item()->rotateLeft();

			if (this->keyStates[this->keys[player][PLAY_RIGHT]])
				this->cannonIter.Item()->rotateRight();

			if (this->keyStates[this->keys[player][PLAY_FIRE]])
			{
				// Check the level to make sure that we can fire a bullet
				if (Level::canFireBullet() && cannonIter.Item()->canFireBullet())
				{
					Bullet* firedBullet = this->cannonIter.Item()->fireBullet();
					Level::bulletFired(firedBullet); 
				}
			}
		}
		this->cannonIter.Forth();
		player++;
	}
	return true;
}

void Level::draw(SDL_Surface* screenDest)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::draw");

	// Start off by drawing the background
	this->theme->drawSurface(GFX_BACKGROUND, Point(0,0), 0);

	// Draw the hud
	this->theme->drawSurface(GFX_HUD, Point(0,screenDest->h - HUD_HEIGHT), 0);
	
	// Draw all of the trains
	this->trainIter.Start();
	while (trainIter.Valid())
	{
		this->trainIter.Item()->draw(screenDest);
		this->trainIter.Forth();
	}

	// Paint all of the active bullets around the screen;
	this->bulletIter.Start();
	while (this->bulletIter.Valid())
	{
		this->bulletIter.Item()->draw(screenDest);
		this->bulletIter.Forth();
	}

	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::Cannons");

	// Cannons
	this->cannonIter.Start();
	while (cannonIter.Valid())
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::draw Cannons");
		this->cannonIter.Item()->draw(screenDest);
		Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::finsihed draw Cannons");
		this->cannonIter.Forth();
	}

	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::Name");

	if (this->num)
	{
		Rect rlevel(485,575,615,591);
		Theme::Instance()->drawText(FONT_SCORE, rlevel, Middle, Left, "Level - %d", this->num);
	}

	// Display the time for this level
	Rect rtime(12,575,142,591);
	Theme::Instance()->drawText(FONT_SCORE, rtime, Middle, Left, "Time - %d", LevelTimer::Instance()->getTime());

	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level::Finished draw");
}

bool Level::mouseDown(int x, int y)
{
	// Cannons
	this->cannonIter.Start();
	while (this->cannonIter.Valid())
	{
		if (this->cannonIter.Item()->getUseMouse())
		{
			// Check the level to make sure that we can fire a bullet
			if (Level::canFireBullet() && cannonIter.Item()->canFireBullet())
			{
				Bullet* firedBullet = this->cannonIter.Item()->fireBullet();
				Level::bulletFired(firedBullet); 
			}
		}
		this->cannonIter.Forth();
	}
	return false;
}

bool Level::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	switch (key)
	{
		case SDLK_k:
		{
			// Cannons
			this->cannonIter.Start();
			while (this->cannonIter.Valid())
			{
				// Toggle mouse / keyboard support
				this->cannonIter.Item()->setUseMouse(!this->cannonIter.Item()->getUseMouse());
				Options::Instance()->setMouseEnabled(!Options::Instance()->getMouseEnabled());
				this->cannonIter.Forth();
			}
			return true;
		}
		default:
			break;
	}
	return false;
}

void Level::initialise()
{
	this->num = 0;
	this->state = LS_NOTSTARTED;
	this->cannons.DeleteAndRemove();
	this->trainStations.DeleteAndRemove();
	this->activeBullets.DeleteAndRemove();
	this->cannonIter 	= this->cannons.GetIterator();
	this->trainIter 	= this->trainStations.GetIterator();
	this->bulletIter 	= this->activeBullets.GetIterator();
}

void Level::checkBulletHits()
{
	// Loop through each bullet and check it against each train station.
	this->bulletIter.Start();
	while (bulletIter.Valid())
	{
		this->trainIter.Start();
		while (this->trainIter.Valid())
		{
			if (this->trainIter.Item()->checkCollisionAndAdd(this->bulletIter.Item()->bubble))
			{
				delete this->bulletIter.Item();
				this->activeBullets.Remove(this->bulletIter);
				break;
			}
			this->trainIter.Forth();
		}
		this->bulletIter.Forth();
	}
}

void Level::loadCannons(xmlDocPtr doc, xmlNodePtr cur)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level:: loadCannons");

	xmlXPathObjectPtr xpathObj;
	Cannon* can;

	// There must be at least 1 cannon.
	// So keep a count if not correct then blow up
	xpathObj = searchDocXpath(doc, cur, "cannons/cannon");

	if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr == 0)
	{
		xmlXPathFreeObject(xpathObj);
		Log::Instance()->die(1,SV_ERROR,"Level: Need at least one cannon to play a level\n");
	}

	for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
	{
		if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
			continue;

		cur = xpathObj->nodesetval->nodeTab[i];
		can = new Cannon();
		can->load(doc,cur);
		this->cannons.Append(can);
	}
	xmlXPathFreeObject(xpathObj);

	if (this->cannons.Size() == 0)
	{
		Log::Instance()->die(1,SV_ERROR,"Level: Need at least one cannon to play a level\n");
	}
}

void Level::loadTrainstations(xmlDocPtr doc, xmlNodePtr cur)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Level:: loadTrainStations");
	
	xmlXPathObjectPtr xpathObj;
	TrainStation* trainStat;
	
	xpathObj = searchDocXpath(doc, cur, "trainstations/train");

	if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr == 0)
	{
		xmlXPathFreeObject(xpathObj);
		Log::Instance()->die(1,SV_ERROR,"Level: Need at least one train station to play a level\n");
	}

	for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
	{
		if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
			continue;

		cur = xpathObj->nodesetval->nodeTab[i];
		trainStat = new TrainStation();
		trainStat->load(doc,cur);
		this->trainStations.Append(trainStat);
	}
	xmlXPathFreeObject(xpathObj);

	if (this->trainStations.Size() == 0)
	{
		Log::Instance()->die(1,SV_ERROR,"Level: Need at least one train station to play a level\n");
	}
}
