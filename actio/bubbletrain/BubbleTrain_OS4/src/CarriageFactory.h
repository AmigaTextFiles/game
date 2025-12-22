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
  * Carriage factory produces carriages to be added onto the end of a train when 
  * it leaves the train station. Or accepts carriage back from the train when the
  * end of the train moves back into the train station.
  * 
  * It produces carriages either in a random pattern or from a provided pattern.
  * It checks that three of the same colour are not produced in sequence.
  */
 
#ifndef CARRIAGEFACTORY_H
#define CARRIAGEFACTORY_H

#include "Carriage.h"
#include "ILoadSave.h"
#include "List.h"

class CarriageFactory: public ILoadSave
{
private:
	List<Carriage*> carriages;			// The carriages produced, ready to be added onto the train
	int maxColours;						// Colour range for the carriages produced. i.e. defines the difficulty of the level
	
	void loadSetSequence(xmlNodePtr cur);
	void loadRandom(xmlNodePtr cur, int colourNum, int carriageNum);
	bool colourAllowed(Colour col);
	
public:
  	CarriageFactory();
  	virtual ~CarriageFactory();
  	
  	void reset(int numOfBubbles, int numOfColours);
  	int count();
	Carriage* popCarriage();
	void pushCarriage(Carriage* carriage);
	int getMaxColours();
  	
  	// ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void load(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);
	
};

#endif
