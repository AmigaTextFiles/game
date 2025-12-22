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
  *  Container for the train, track and the carriage factory.
  *  As part of moveTrain call the train.move
  *  and then call for all of the carriages which
  *  are stationed.
  */
  
#ifndef TRAINSTATION_H
#define TRAINSTATION_H

#include "IWidget.h"
#include "ILoadSave.h"
#include "Train.h"
#include "CarriageFactory.h"
#include "Bubble.h"
#include "General.h"

class TrainStation : public IWidget, public ILoadSave
{

private:
	Train* train;
	Track* track;
	CarriageFactory* carriageFactory;
  
public:
	TrainStation();
	virtual ~TrainStation();
	
	TrainState getTrainState();
	bool isStationEmpty();
	bool checkCollisionAndAdd(Bubble* bubble);
	
	// ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void load(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);
	
	// IWidget methods
	virtual void animate(LevelState state);
	virtual void draw(SDL_Surface* screenDest);
	virtual bool mouseDown(int x, int y);
	virtual bool keyPress( SDLKey key, SDLMod mod, Uint16 character );

};

#endif
