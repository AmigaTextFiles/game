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
  * A track component which is a sprial. Basically an arc which has a 
  * decreasing radius. This component must be the last item in the list
  * because there can't be overlapping components and this always starts
  * at the outer radius and works towards the centre
  */
 
#ifndef TRACKSPIRAL_H
#define TRACKSPIRAL_H

#include "TrackSection.h"
#include "Theme.h"

class TrackSpiral : public TrackSection
{

private:
	Point centrePos;		// Centre of the sprial
	Rotation rot;			// The direction of rotation
	double startAngle;		// The starting / ending angles
	double endAngle;
	double startRadius;		// Start radius
    double endRadius;		// End radius
    double numOfTurns;		// Number of complete turns from start to end
    
	void initialise();
    double calcRadius(double angle);
    double adjustAngleFromRadius(double angle, double radius);
    void calcEndPosFromTurns();

public:
	TrackSpiral();
	TrackSpiral(Point startPos, Point endPos, Point centre, Rotation rot);
	TrackSpiral(Point startPos, Point centre, double numberOfTurns, Rotation rot);
	virtual ~TrackSpiral();
	
	// Accessor properties
	void setStartPosition(Point pos);
	void setEndPosition(Point pos);
	Point getCentrePosition();
	void setCentrePosition(Point pos);
	void setRotation(Rotation rot);
	Rotation getRotation();
	void setNumberOfTurns(double turns);
	double getNumberOfTurns();
	void setRadius(double rad);
	double getRadius();	

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

