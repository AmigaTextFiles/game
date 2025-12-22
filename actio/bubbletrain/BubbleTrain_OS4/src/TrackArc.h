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
  * Track component which is an arc. It defines the centre of the arc,
  * starting / ending angles, rotation etc.
  */
 
#ifndef TRACKARC_H
#define TRACKARC_H

#include "TrackSection.h"
#include "Theme.h"

class TrackArc : public TrackSection
{

private:
	Point centre;				// Centre of the arc
	Rotation rot;				// Roation
	double startAngle;			// Angles used for bounds checking
	double endAngle;
	bool crossesZero;			// Check if the arc crosses the zero angle
	double radius;				
	bool flip;

	void initialise();
	bool inAngleBounds(double angle);
	void calcCentrePoint(double radius);

public:
	TrackArc();
 	TrackArc(Point startPos, Point endPos, Point centre, Rotation rot);
 	TrackArc(Point startPos, Point endPos, double radius, Rotation rot);
	virtual ~TrackArc();
	
	// Accessor properties
	void setStartPosition(Point pos);
	void setEndPosition(Point pos);
	Point getCentrePosition();
	void setCentrePosition(Point pos);
	Rotation getRotation();
	void setRotation(Rotation rot);
	double getRadius();
	void setRadius(double rad);
	bool getFlip();
	void setFlip(bool flip);

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
