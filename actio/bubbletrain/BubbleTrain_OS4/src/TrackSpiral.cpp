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

#include "TrackSpiral.h"

#undef LOG_THRESHOLD
#define LOG_THRESHOLD SV_DEBUG

TrackSpiral::TrackSpiral() : TrackSection(TT_SPIRAL)
{
	this->centrePos.set(0,0);
	this->rot = ROT_CLOCKWISE;
	this->startAngle  = 0;
	this->endAngle    = 0;
	this->startRadius = 0;
    this->endRadius   = 0;
    this->numOfTurns  = 0;
}

TrackSpiral::TrackSpiral(Point startPos, Point endPos, Point centre, Rotation rot) : TrackSection(TT_SPIRAL, startPos, endPos)
{
	this->centrePos   = centre;
	this->rot         = rot;
	
	TrackSpiral::initialise();
	
}

TrackSpiral::TrackSpiral(Point startPos, Point centre, double numberOfTurns, Rotation rot) : TrackSection(TT_SPIRAL, startPos, Point(0,0))
{
	this->centrePos = centre;
	this->rot		= rot;
	this->numOfTurns = numberOfTurns;
	
	TrackSpiral::calcEndPosFromTurns();
	TrackSpiral::initialise();	
}
	

TrackSpiral::~TrackSpiral()
{

}

void TrackSpiral::load(xmlDocPtr doc, xmlNodePtr cur)
{
	// spiral startpos="400,0" endpos="400,302" centre="400,250" rotation="anticlockwise" />
	// Make sure this is a arc node
	if (strcmp((const char*)cur->name, "spiral"))
		Log::Instance()->die(1,SV_ERROR,"Track Spiral: node trying to load is not spiral but %s\n", (const char*)cur->name);
	
	// Find the start position
	char* startposText = (char*)xmlGetProp(cur, (const xmlChar*)"startpos");
	if (startposText != NULL || strcmp(startposText, ""))
		TrackSection::startPos.set(startposText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Spiral: Start position not found\n");
	
	// Find the end position
	char* endposText = (char*)xmlGetProp(cur, (const xmlChar*)"endpos");
	if (endposText != NULL || strcmp(endposText,""))
		TrackSection::endPos.set(endposText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Spiral: End position not found\n");
	
	// Find the centre position
	char* centreText = (char*)xmlGetProp(cur, (const xmlChar*)"centre");
	if (centreText != NULL || strcmp(centreText, ""))
		this->centrePos.set(centreText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Spiral: Centre position not found\n");
	
	// Find the rotation
	char* rotText = (char*)xmlGetProp(cur, (const xmlChar*)"rotation");
	if (rotText == NULL || !strcmp(rotText, ""))
		Log::Instance()->die(1,SV_ERROR,"Track Spiral: Rotation not found\n");
	else if (!strcmp(rotText,"clockwise"))
		this->rot = ROT_CLOCKWISE;
	else if (!strcmp(rotText,"anticlockwise"))
		this->rot = ROT_ANTI_CLOCKWISE;
	else
		Log::Instance()->die(1,SV_ERROR,"Track Spiral: Incorrect value [%s] for Rotation \n", rotText);
	
	TrackSpiral::initialise();	
}

void TrackSpiral::load(const char* path, const char* filename)
{
	
}

void TrackSpiral::save(xmlDocPtr doc, xmlNodePtr cur)
{
	char buffer[256];
	xmlNodePtr node = xmlNewChild(cur, NULL, BAD_CAST "spiral", NULL);
	if (!node)
 		Log::Instance()->die(1, SV_ERROR, "Problem saving trackSpiral[Failed to create node]");

	sprintf (buffer, "%d,%d", (int)this->startPos.x, (int)this->startPos.y); 		
	xmlNewProp(node, BAD_CAST "startpos", BAD_CAST buffer);
	sprintf (buffer, "%d,%d", (int)this->endPos.x, (int)this->endPos.y); 		
	xmlNewProp(node, BAD_CAST "endpos", BAD_CAST buffer);
	sprintf (buffer, "%d,%d", (int)this->centrePos.x, (int)this->centrePos.y); 		
	xmlNewProp(node, BAD_CAST "centre", BAD_CAST buffer);
	
	if (this->rot == ROT_CLOCKWISE)
		xmlNewProp(node, BAD_CAST "rotation", BAD_CAST "clockwise");
	else
		xmlNewProp(node, BAD_CAST "rotation", BAD_CAST "anticlockwise");
}

void TrackSpiral::save(const char* path, const char* filename)
{
	
}

// Accessor properties
void TrackSpiral::setStartPosition(Point pos)
{
	this->startPos = pos;
	TrackSection::resetTrackSurface();
	TrackSpiral::calcEndPosFromTurns();
	TrackSpiral::initialise();
}

void TrackSpiral::setEndPosition(Point pos)
{
	this->endPos = pos;
	TrackSection::resetTrackSurface();
	TrackSpiral::initialise();
}

void TrackSpiral::setCentrePosition(Point pos)
{
	this->centrePos = pos;
	TrackSection::resetTrackSurface();
	TrackSpiral::calcEndPosFromTurns();
	TrackSpiral::initialise();
}

Point TrackSpiral::getCentrePosition()
{
	return this->centrePos;	
}

void TrackSpiral::setRotation(Rotation rot)
{
	this->rot = rot;
	TrackSection::resetTrackSurface();
	TrackSpiral::calcEndPosFromTurns();
	TrackSpiral::initialise();
}

Rotation TrackSpiral::getRotation()
{
	return this->rot;
}

void TrackSpiral::setNumberOfTurns(double turns)
{
	this->numOfTurns = turns;
	
	TrackSection::resetTrackSurface();
	TrackSpiral::calcEndPosFromTurns();
	TrackSpiral::initialise();
}

double TrackSpiral::getNumberOfTurns()
{
	return this->numOfTurns;
}

void TrackSpiral::setRadius(double rad)
{
	
}

double TrackSpiral::getRadius()
{
	return this->startRadius;
}

double TrackSpiral::move(Point* pos, Direction dir, double dist)
{
	double currentAngle     = 0.0;
	double currRadius       = 0.0;
	double targetAngle		= 0.0;
	double angleToMove		= 0.0;
	double angleAvailable   = 0.0;
	double newAngle         = 0.0;
	int multiplier 			= 0;
	Point targetPoint;

	currRadius = this->centrePos.distanceFrom(*pos);
	currentAngle = quadrantise(this->centrePos, *pos, true);

	// Adjust angle to -Ve domain for clockwise
	if (this->rot == ROT_CLOCKWISE)
		currentAngle -= 2*M_PI;

	currentAngle = TrackSpiral::adjustAngleFromRadius(currentAngle , currRadius);

	if (dir == D_FORWARD)
    {
		targetAngle = this->endAngle;
        targetPoint = this->endPos;
    } else {
    	targetAngle = this->startAngle;
    	targetPoint = this->startPos;	
    }
    
    if (this->rot == ROT_CLOCKWISE && dir == D_FORWARD)
      multiplier = -1;
    else if (this->rot == ROT_CLOCKWISE && dir == D_BACKWARD)
      multiplier = 1;
    else if (this->rot == ROT_ANTI_CLOCKWISE && dir == D_FORWARD)
      multiplier = 1;
    else if (this->rot == ROT_ANTI_CLOCKWISE && dir == D_BACKWARD)
      multiplier = -1;
      
	// Treat the distance to move as a simple arc.
	angleToMove = dist / currRadius * multiplier;
	angleAvailable = targetAngle - currentAngle;
      
    // Move off the end of the arc
    if (fabs(angleAvailable) < fabs(angleToMove))
    {
    	dist = (fabs(angleToMove) - fabs(angleAvailable)) * currRadius;
		*pos = targetPoint;
		return dist;	
	}
	
	newAngle = currentAngle + angleToMove;
	currRadius = TrackSpiral::calcRadius(newAngle - this->startAngle);
    
    double xInc = currRadius * cos(newAngle);
    double yInc = currRadius * sin(newAngle);

    pos->x = this->centrePos.x + xInc;
    pos->y = this->centrePos.y - yInc;

    return 0.0;
}

void TrackSpiral::draw(SDL_Surface* surf)
{
	if (this->trackSurface == NULL)
	{
		int width = (int)(this->startRadius + 1) * 2;
		int height = width;
			
		// Create the cached surface
		this->trackSurface = Theme::Instance()->newsurf_fromsurf(surf, width, height);
	
		// Calculate where on the screen the surface should be drawn
		this->dst.x = (short int)(this->centrePos.x - this->startRadius);
		this->dst.y = (short int)(this->centrePos.y - this->startRadius);		
		this->dst.w = width;
		this->dst.h = height;
		
		this->src.x = 0;
		this->src.y = 0;
		this->src.w = width;
		this->src.h = height;
		
		// Adjust the source / dest rects if the image goes out of bounds in 
		// either the top or left of the screen.
		// This stops the whole image shifting onto the screen in the wrong location.
		if (this->dst.x < 0)
		{
			this->src.w += this->dst.x;
			this->dst.x = 0;
		}
		if (this->dst.y < 0)
		{
			this->src.h += this->dst.y;
			this->dst.y = 0;
		}
		
		// Find the back ground witha colour which isn't the same as the line
		Uint32 colourBackground = this->colour + 10;
		SDL_FillRect(this->trackSurface, NULL, colourBackground);
		
		// Calculate points on the spiral for drawing purposes
	    // Anti-clockwise: 	moves in the same direction as the angle increases so easy
	    // Clockwise:		moves in the opposite direction. 
	    // 					So reverse the angle i.e. instead of increasing the angle descrease it.
	
	
		// Start at the smallest angle and increase to the largest angle.
		// This means a clockwise spiral is drawn backwards
		double min = min(this->startAngle, this->endAngle);
		double max = max(this->startAngle, this->endAngle);
		
	    double currentRadius = 0.0;
	    double increment = M_PI/180;
		Point lastPosition;

		// Figure out which is the last pos depending on which way the spiral
		// is drawn.		
		if (this->startAngle < this->endAngle)
			lastPosition = this->startPos;
		else
			lastPosition = this->endPos;
			
	    lastPosition.x -= this->dst.x;
		lastPosition.y -= this->dst.y;
		Point currentPosition(0,0);
		
		for (double angle = min + increment; angle <= max; angle += increment)
	    {
			currentRadius = TrackSpiral::calcRadius(angle - this->startAngle);
			
			// Calculate the actual screen position and then offset for the image 
			currentPosition.x = this->centrePos.x + currentRadius * cos(angle) - this->dst.x;
			currentPosition.y = this->centrePos.y - currentRadius * sin(angle) - this->dst.y;
	      
	      	Theme::Instance()->drawLine(this->trackSurface, this->colour, lastPosition, currentPosition);
		    lastPosition = currentPosition;
	    }
	    /*
	    // Draw the start / end positions so we know what we are doing
	    lastPosition = this->startPos;
	    lastPosition.x -= this->dst.x;
	    lastPosition.y -= this->dst.y;
	    Theme::Instance()->drawCircle(this->trackSurface, this->colour, lastPosition, 3);

	    // Draw the start / end positions so we know what we are doing
	    lastPosition = this->endPos;
	    lastPosition.x -= this->dst.x;
	    lastPosition.y -= this->dst.y;
	    Theme::Instance()->drawCircle(this->trackSurface, this->colour, lastPosition, 3);
		*/
	    
		// Set the transparency colour to the blank colour above.
	    if (SDL_SetColorKey (this->trackSurface, SDL_SRCCOLORKEY, colourBackground))
	    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Unable to set transparency on trackSpiral");
	    
	}
	
	SDL_BlitSurface(this->trackSurface, &this->src, surf, &this->dst);
	
}

bool TrackSpiral::onTrack(Point pos)
{
	// First check the radius to the point if between the start / end radius then possible
	double currRadius = pos.distanceFrom(this->centrePos);
	if (currRadius - this->startRadius > ROUND_ERROR || this->endRadius - currRadius > ROUND_ERROR)
		return false;
	
	// Check the angle is in range        
	double currentAngle = quadrantise(centrePos, pos, true);
	
	// Adjust angle to -Ve domain for clockwise
	if (this->rot == ROT_CLOCKWISE)
		currentAngle -= 2*M_PI;
		
	currentAngle = TrackSpiral::adjustAngleFromRadius(currentAngle, currRadius);
	
	if ((this->rot == ROT_ANTI_CLOCKWISE && (currentAngle < this->startAngle || currentAngle > this->endAngle))
		|| (this->rot == ROT_CLOCKWISE && (currentAngle > this->startAngle || currentAngle < this->endAngle)))
	    return false;

	// Check the radius generated from the angle. If this is the same as the actual radius then we must be on the path
    double calculatedRadius = TrackSpiral::calcRadius(currentAngle - this->startAngle);
    return (fabs(currRadius - calculatedRadius) < ROUND_ERROR*3);
}


InsertPoint TrackSpiral::bulletInsertPosition(Point bulletPos, Point targetPos)
{
	
	double bulletAngle = 0.0;
	double targetAngle = 0.0;

	bulletAngle = quadrantise(this->centrePos, bulletPos, false);
	targetAngle = quadrantise(this->centrePos, targetPos, false);
	
	// We are not concerned with what the actual angles are we only care what the difference
	// between the two angles are. So not neccessary to adjust the angles for the radius
	
	// If the angles are in different quadrants,
	// i.e. one angle in the first quadrant and one in the last
	// quadrant making all of the calculations out.
	// So if the angles are different quadrants then adjust the smallest
	if (fabs(targetAngle - bulletAngle) > M_PI_2 * 3)
	{
		if (targetAngle < bulletAngle)
			targetAngle += M_PI * 2;
		else
			bulletAngle += M_PI * 2;
	}
	
	if (this->rot == ROT_CLOCKWISE)
	{
		if (bulletAngle > targetAngle)
			return BEFORE;
		else
			return AFTER;			
	}
	else
	{
		if (targetAngle > bulletAngle)
			return BEFORE;
		else
			return AFTER;
	}
	
}
 	
double TrackSpiral::calcRadius(double angle)
{
       return this->startRadius * exp(-fabs(angle)/10);
}

double TrackSpiral::adjustAngleFromRadius(double angle, double radius)
{
	// Need to check this for the rotation again not sure this works for both directions
	// Adjust the endangle for the correct number of turns in the spiral
	while (TrackSpiral::calcRadius(fabs(angle)) >= radius)
		if (this->rot == ROT_CLOCKWISE)
			angle -= M_PI * 2;
		else
			angle += M_PI * 2;

	return angle;
}

void TrackSpiral::initialise()
{
	this->startAngle  = quadrantise(centrePos, startPos, true);
	this->endAngle    = quadrantise(centrePos, endPos, true);
	this->startRadius = centrePos.distanceFrom(startPos);
    this->endRadius   = centrePos.distanceFrom(endPos);
    
    // We are using all -Ve angles for clockwise so make every thing -Ve before we start
    if (this->rot == ROT_CLOCKWISE)
    {
    	this->startAngle -= 2*M_PI;
    	this->endAngle -= 2*M_PI;	
    }
	
	// Adjust the endangle for the correct number of turns in the spiral
    this->endAngle = TrackSpiral::adjustAngleFromRadius(this->endAngle, this->endRadius);
    
    this->numOfTurns  = fabs(this->endAngle - this->startAngle) / (M_PI * 2);
	
}

void TrackSpiral::calcEndPosFromTurns()
{
	// Make sure the numOfTurns is in bounds
	if (this->numOfTurns < 0)
		this->numOfTurns = 1.0;
	else if (this->numOfTurns > 20)
		this->numOfTurns = 20.0;	
		
	// Make sure we initialise the start angles
	this->startAngle  = quadrantise(centrePos, startPos, true);
	this->startRadius = centrePos.distanceFrom(startPos);
    
    // Adjust the endAngle depending on rotation
    if (this->rot == ROT_CLOCKWISE)
		this->endAngle = this->startAngle - this->numOfTurns * 2 * M_PI;
	else
		this->endAngle = this->startAngle + this->numOfTurns * 2 * M_PI;
	
	double currentRadius = TrackSpiral::calcRadius(this->numOfTurns * 2 * M_PI);
	
	this->endPos.x = this->centrePos.x + currentRadius * cos(this->endAngle);
	this->endPos.y = this->centrePos.y - currentRadius * sin(this->endAngle);
}
