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
  * Abstract class for track components. This hides the type of the 
  * track components and also provides basic properties for track components.
  */
 
#ifndef TRACKSECTION_H
#define TRACKSECTION_H

// System includes
#include <math.h>

// Game includes
#include "General.h"
#include "ILoadSave.h"

// Constants for error rates when using doubles
#define ROUND_ERROR 1
#define ANGLE_ROUND_ERROR M_PI / 360

// Defines whether the bubble should be inserted before or after 
// the carriage it hit
enum InsertPoint
{
	BEFORE,
	AFTER	
};

// Defines the type of track component
enum TrackType
{
	TT_LINE,
	TT_ARC,
	TT_SPIRAL	
};

class TrackSection : public ILoadSave
{

protected:
    Point startPos;						// The start / end points which must be joined to the next item
    Point endPos;
    SDL_Surface* trackSurface;			// Cached drawing surface for the track
    SDL_Rect dst;						// Used for drawing the cached object to screen
    SDL_Rect src;
    TrackType type;						// Type of track
    Uint32 colour;						// Colour of the track component

public:
	TrackSection(TrackType type)
	{
		this->type = type;
		this->startPos.set(0,0);
		this->endPos.set(0,0);
		this->trackSurface = NULL;
		this->dst.x = 0;
		this->dst.y = 0;
		this->dst.h = 0;
		this->dst.w = 0;
		this->colour = 20;
	}
	
  	TrackSection(TrackType type, Point startPos, Point endPos)
  	{
  		this->type = type;
		this->startPos = startPos;
  		this->endPos = endPos;
  		this->trackSurface = NULL;
  		this->dst.x = 0;
		this->dst.y = 0;
		this->dst.h = 0;
		this->dst.w = 0;
		this->colour = 20;
  	}
  	
  	virtual ~TrackSection()
  	{
  		if (this->trackSurface != NULL)
			SDL_FreeSurface(this->trackSurface);	
  	}
  	
  	Point getStartPosition()
  	{
  		return this->startPos;	
  	}
  	
  	virtual void setStartPosition(Point pos)
	{
		this->startPos = pos;
	}
  	
  	Point getEndPosition()
  	{
  		return this->endPos;	
  	}
  	
	virtual void setEndPosition(Point pos)
	{
		this->endPos = pos;
	}
  	
  	TrackType getType()
  	{
  		return this->type;	
  	}
  	
  	Uint32 getColour()
  	{
  		return this->colour;
  	}
  	
  	void setColour(Uint32 colour)
  	{
  		this->colour = colour;
  		// Reset the cache for the track so that it will redraw in a difference colour
		TrackSection::resetTrackSurface();
  	}
  	
  	void resetTrackSurface()
  	{
		if (this->trackSurface != NULL)
		{
			SDL_FreeSurface(this->trackSurface);
  			this->trackSurface = NULL;
		}
  	}
  
    virtual double move(Point* pos, Direction dir, double dist) = 0;
    virtual void draw(SDL_Surface*) = 0;
    virtual bool onTrack(Point pos) = 0;
    virtual InsertPoint bulletInsertPosition(Point bulletPos, Point targetPos) = 0;
    
};

#endif
