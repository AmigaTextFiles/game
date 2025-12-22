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
  * Generates bullets which feed the cannon. Keeps a count on how many of each type
  * are still available. This doesn't have any knowledge of what colours are still
  * in the trains. But maybe it should?
  * 
  */
 
#ifndef BULLETFACTORY_H
#define BULLETFACTORY_H

#include "List.h"
#include "Bullet.h"

class BulletFactory
{
	
private:
    int numberOfColours;
    
    // This holds the number of each type of bullet.
    // With 0 -> MAX_COLOUR - 1 being normal bubbles with different colours
    // with MAX_COLOUR -> MAX_SFX being special bubbles.
    // note that the first special bubble is SFX_NORMAL which isn't a special bubble
    // so this should be excluded from any calculations
    int coloursNum[MAX_COLOUR + MAX_SFX];

public:
	BulletFactory();
	virtual ~BulletFactory();
	  	
  	// Reset the factory with the default number of colours
	void resetFactory(int numberOfColours);
	
	// Get the next bullet from the list
    Bullet* popBullet();
    
    // ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	
};

#endif
