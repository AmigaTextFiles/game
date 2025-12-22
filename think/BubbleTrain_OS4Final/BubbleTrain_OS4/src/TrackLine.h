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
  * A track component which is a line. The simplest of track components
  */
 
#ifndef TRACKLINE_H
#define TRACKLINE_H

#include "TrackSection.h"
#include "Theme.h"

class TrackLine : public TrackSection
{

private:
	double angle;			// Define the angle between the start / end points
	double gradient;		// Gradient between the start / end points
	double yIntersection;	// The value the line crosses the y axis used for bounds checking
	double normal;			// The angle that is normal to the line
	double length;			// Length of the line
	bool vertical;			// Defines if the line is a special case of being vertical, then most of the above isn't needed
	
	void initialise();
		
public:
	TrackLine();
	TrackLine(Point startPos, Point endPos);
	virtual ~TrackLine();
	
	// Accessor properties
	virtual void setStartPosition(Point pos);
	virtual void setEndPosition(Point pos);

	// TrackSection methods
	virtual double move(Point* pos, Direction dir, double dist);
	virtual void draw(SDL_Surface* surf);
	virtual bool onTrack(Point pos);
	virtual InsertPoint bulletInsertPosition(Point bulletPos, Point targetPos);
	
	// ILoadSave methods
	virtual void load(const char* path, const char* filename);	
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
};

#endif
