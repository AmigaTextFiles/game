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
 
#include "TrackLine.h"

TrackLine::TrackLine() : TrackSection(TT_LINE)
{
	this->angle 		= 0;
	this->gradient 		= 0;
	this->yIntersection = 0;
    this->normal 		= 0;
}

TrackLine::TrackLine(Point startPos, Point endPos) : TrackSection(TT_LINE, startPos, endPos)
{
	TrackLine::initialise();
}

TrackLine::~TrackLine()
{

}

void TrackLine::load(xmlDocPtr doc, xmlNodePtr cur)
{
	// <line startpos="450,300" endpos="450,300" />
	// Make sure this is a line node
	if (strcmp((const char*)cur->name, "line"))
		Log::Instance()->die(1,SV_ERROR,"Track Line: node trying to load is not line but %s\n", (const char*)cur->name);
	
	// Find the start position
	char* startposText = (char*)xmlGetProp(cur, (const xmlChar*)"startpos");
	if (startposText != NULL or !strcmp(startposText, ""))
		TrackSection::startPos.set(startposText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Line: Start position not found\n");
	
	// Find the end position
	char* endposText = (char*)xmlGetProp(cur, (const xmlChar*)"endpos");
	if (endposText != NULL or !strcmp(endposText,""))
		TrackSection::endPos.set(endposText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Line: End position not found\n");
	
	/*Log::Instance()->log(SV_ERROR,"Track Line: start %f,%f end %f,%f",
										this->startPos.x, this->startPos.y,
										this->endPos.x, this->endPos.y);
										*/
	TrackLine::initialise();
}

void TrackLine::load(const char* path, const char* filename)
{
	
}

void TrackLine::save(xmlDocPtr doc, xmlNodePtr cur)
{
	char buffer[256];
	xmlNodePtr node = xmlNewChild(cur, NULL, BAD_CAST "line", NULL);
	if (!node)
 		Log::Instance()->die(1, SV_ERROR, "Problem saving trackline[Failed to create node]");

	sprintf (buffer, "%d,%d", (int)this->startPos.x, (int)this->startPos.y); 		
	xmlNewProp(node, BAD_CAST "startpos", BAD_CAST buffer);
	sprintf (buffer, "%d,%d", (int)this->endPos.x, (int)this->endPos.y); 		
	xmlNewProp(node, BAD_CAST "endpos", BAD_CAST buffer);
}

void TrackLine::save(const char* path, const char* filename)
{
	
}

// Accessor properties
void TrackLine::setStartPosition(Point pos)
{
	this->startPos = pos;
	TrackSection::resetTrackSurface();
	TrackLine::initialise();	
}
void TrackLine::setEndPosition(Point pos)
{
	this->endPos = pos;
	TrackSection::resetTrackSurface();
	TrackLine::initialise();
}

double TrackLine::move(Point* pos, Direction dir, double dist)
{
	Point target;
	// If we've moving from the start of the path to the end (forward)
	if (dir == D_FORWARD)
		target = this->getEndPosition();	// Moving towards the end of the path
	else
		target = this->getStartPosition();	// Moving towards the start of the path
	
	double distToEnd = target.distanceFrom(*pos);
	
	/*if (this->vertical && dir == D_BACKWARD)
	{
		Log::Instance()->log("TrackLine:: Moving backwards on vertical line target pos (%f,%f), current pos (%f,%f)", target.x, target.y, pos->x, pos->y);	
		Log::Instance()->log("TrackLine:: Moving backwards on vertical line distance from end %f, dist to move %f", distToEnd, dist);	
	}*/
	
	// Check if move past the target point
	// If so then simply move to the target and return the remainder
	if (dist >= fabs(distToEnd))
	{
		*pos = target;
		/*if (this->vertical && dir == D_BACKWARD)
		{
			Log::Instance()->log("TrackLine:: Moving backwards on vertical line reached end of line remaining dist %f", fabs(dist) - fabs(distToEnd));	
		}*/
		return fabs(dist) - fabs(distToEnd);
	}
	
	// Move the poing along the line
	double sign = (dir == D_FORWARD) ? 1 : -1;
	double xInc = dist*cos(this->angle)*sign;
	double yInc = dist*sin(this->angle)*sign;
	pos->x += xInc;
	pos->y += yInc;	
	/*
	if (this->vertical && dir == D_BACKWARD)
	{
		Log::Instance()->log("TrackLine:: Moving backwards on vertical new pos (%f,%f)", pos->x, pos->y);	
		Log::Instance()->log("TrackLine:: Moving backwards on vertical distance from end %f, distance moved %f", target.distanceFrom(*pos), fabs(target.distanceFrom(*pos)) - fabs(distToEnd));	
	}
	*/
	return 0.0;
	
}

void TrackLine::draw(SDL_Surface* surf)
{
	if (this->trackSurface == NULL)
	{
		int width = (int)fabs(this->startPos.x - this->endPos.x);
		int height = (int)fabs(this->startPos.y - this->endPos.y);
		
		// Check for horizontal or vertical lines
		if (width==0)
			width = 1;
		
		if (height==0)
			height = 1;
			
		// Create the cached surface
		this->trackSurface = Theme::Instance()->newsurf_fromsurf(surf, width + 1, height + 1);
		if (this->trackSurface == NULL)
			Log::Instance()->die(1, SV_ERROR, "TrackLine:draw failed to create a surface to draw on");
	    
		// Calculate where on the screen the surface should be drawn
		this->dst.x = (short int)min(this->startPos.x, this->endPos.x);
		this->dst.y = (short int)min(this->startPos.y, this->endPos.y);
		this->dst.w = width;
		this->dst.h = height;
		
		// Adjust the coordinates so they are relative to the cache surface
		Point tempStart = startPos;
		Point tempEnd = endPos;
		tempStart.x -= this->dst.x;
		tempStart.y -= this->dst.y;
		tempEnd.x -= this->dst.x;
		tempEnd.y -= this->dst.y;
		
		// Find the back ground witha colour which isn't the same as the line
		Uint32 colourBackground = this->colour + 10;
		SDL_FillRect(this->trackSurface, NULL, colourBackground);
		
		Theme::Instance()->drawLine(this->trackSurface, this->colour, tempStart, tempEnd);

		// Set the transparency colour to the blank colour above.
	    if (SDL_SetColorKey (this->trackSurface, SDL_SRCCOLORKEY, colourBackground))
	    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Unable to set transparency on trackLine");
	    
   	}
	
	SDL_BlitSurface(this->trackSurface, NULL, surf, &this->dst);
		
}

bool TrackLine::onTrack(Point pos)
{
	//Log::Instance()->log(SV_DEBUG, SV_DEBUG, "TrackLine: on track");
	 
	  
	// Check if the point lies in the same plane
	// Take special consideration to the vertical lines because these have infinite y intersections
	// so simply check the x component.
	if ((fabs(pos.y - (this->gradient * pos.x) - this->yIntersection) > ROUND_ERROR) ||
		(this->vertical && fabs(this->startPos.x - pos.x) > ROUND_ERROR))
		return false;
	
	// The point should appear after the start and before the end
	if (this->startPos.distanceFrom(pos) > this->length + ROUND_ERROR)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "TrackLine: start dist check %f >= %f, diff = %f", this->startPos.distanceFrom(pos) , this->length, this->startPos.distanceFrom(pos) - this->length - ROUND_ERROR);
		Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Failed on the distance from the START pos");
		return false;
	}
	
	if (this->endPos.distanceFrom(pos) > this->length + ROUND_ERROR)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "TrackLine: end dist check %f >= %f, diff = %f", this->endPos.distanceFrom(pos) , this->length, this->endPos.distanceFrom(pos) - this->length - ROUND_ERROR);
		Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Failed on the distance from the END pos");
		return false;
	}

//	Log::Instance()->log(SV_DEBUG, SV_DEBUG, "TrackLine: IS on track");
	
	return true;
}


InsertPoint TrackLine::bulletInsertPosition(Point bulletPos, Point targetPos)
{
	if (this->angle == 0.0)
	{
		 if (bulletPos.x >= targetPos.x) // Right
        	return BEFORE;
	     else
	        return AFTER;
	}
	else if (this->angle == (double)M_PI)
	{
		if (bulletPos.x <= targetPos.x) // Left
        	return BEFORE;
      	else
	        return AFTER;
	}
	else if (this->angle == (double)M_PI * 3 / 2)
	{
		if (bulletPos.y >= targetPos.y) // Down
        	return BEFORE;
      	else
	        return AFTER;
	}
	else if (this->angle == (double)M_PI / 2)
	{
		if (bulletPos.y <= targetPos.y) // Up
        	return BEFORE;
        else
	        return AFTER;
	}
	else // Not horizontal or vertical
	{
		// Compare where the the normal lines cross the y axis to figure
		// which side the bullet hit.
		double bulletCrosses = bulletPos.y - this->normal * bulletPos.x;
     	double targetCrosses = targetPos.y - this->normal * targetPos.x;
     	
     	if (this->angle > 0 and this->angle < M_PI) // Above the x axis
     	{
     		if (bulletCrosses > targetCrosses)
     			return BEFORE;
     		else
     			return AFTER;
     	}
     	else // Below the x axis
     	{
     		if (bulletCrosses > targetCrosses)
     			return AFTER;
     		else
     			return BEFORE;
     	}
	}
}

void TrackLine::initialise()
{
	
	double xdiff = this->endPos.x - this->startPos.x;
	double ydiff = this->endPos.y - this->startPos.y;
	
	this->angle = quadrantise(this->endPos.x - this->startPos.x, this->endPos.y - this->startPos.y, false);
	this->gradient = ydiff / xdiff;
	this->yIntersection = this->startPos.y - (this->gradient * this->startPos.x);
	
	// Cache whether the line is vertical or not.
	if (xdiff == 0.0)
		this->vertical = true;
	else
		this->vertical = false;
		
	//Log::Instance()->log("TrackLine::initialise startPos (%f,%f), endPos(%f,%f), angle %f, gradient %f, y intersect %f, vertical %d",
	//		this->startPos.x, this->startPos.y, this->endPos.x, this->endPos.y, this->angle, this->gradient, this->yIntersection, this->vertical);
	
	// Find the normal to the line for when calculating where a bullet interects the line
	if (ydiff == 0)
		this->normal = - M_PI * 0.5;
	else if (xdiff ==0)
		this->normal = 0;  
	else
		this->normal = -(xdiff/ydiff);
	
	this->length = this->startPos.distanceFrom(this->endPos);
	
}
