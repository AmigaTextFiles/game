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
 
#include "TrackArc.h"

TrackArc::TrackArc() : TrackSection(TT_ARC)
{
	this->centre.set(0,0);
	this->rot 		  = ROT_CLOCKWISE;
	this->radius 	  = 0;
	this->startAngle  = 0;
	this->endAngle 	  = 0;
	this->crossesZero = false;
}

TrackArc::TrackArc(Point startPos, Point endPos, Point centre, Rotation rot) : TrackSection(TT_ARC, startPos, endPos)
{
	this->centre = centre;
	this->rot = rot;
	
	TrackArc::initialise();

}

TrackArc::TrackArc(Point startPos, Point endPos, double radius, Rotation rot) : TrackSection(TT_ARC, startPos, endPos)
{
	this->rot = rot;
	this->flip = false;
	TrackArc::calcCentrePoint(radius);
	
	TrackArc::initialise();	
}

TrackArc::~TrackArc()
{

}

void TrackArc::load(xmlDocPtr doc, xmlNodePtr cur)
{
	// <arc startpos="450,300" endpos="450,300" centre="425,250" rotation="clockwise" />
	// Make sure this is a arc node
	if (strcmp((const char*)cur->name, "arc"))
		Log::Instance()->die(1,SV_ERROR,"Track Arc: node trying to load is not arc but %s\n", (const char*)cur->name);
	
	// Find the start position
	char* startposText = (char*)xmlGetProp(cur, (const xmlChar*)"startpos");
	if (startposText != NULL || strcmp(startposText, ""))
		TrackSection::startPos.set(startposText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Arc: Start position not found\n");
	
	// Find the end position
	char* endposText = (char*)xmlGetProp(cur, (const xmlChar*)"endpos");
	if (endposText != NULL || strcmp(endposText,""))
		TrackSection::endPos.set(endposText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Arc: End position not found\n");
	
	// Find the centre position
	char* centreText = (char*)xmlGetProp(cur, (const xmlChar*)"centre");
	if (centreText != NULL || strcmp(centreText, ""))
		this->centre.set(centreText);
	else
		Log::Instance()->die(1,SV_ERROR,"Track Arc: Centre position not found\n");
	
	// Find the rotation
	char* rotText = (char*)xmlGetProp(cur, (const xmlChar*)"rotation");
	if (rotText == NULL || !strcmp(rotText, ""))
		Log::Instance()->die(1,SV_ERROR,"Track Arc: Rotation not found\n");
	else if (!strcmp(rotText,"clockwise"))
		this->rot = ROT_CLOCKWISE;
	else if (!strcmp(rotText,"anticlockwise"))
		this->rot = ROT_ANTI_CLOCKWISE;
	else
		Log::Instance()->die(1,SV_ERROR,"Track Arc: Incorrect value [%s] for Rotation \n", rotText);
	
	/*Log::Instance()->log(SV_ERROR,"Track Arc: start %f,%f end %f,%f centre %f,%f rotation %d",
										this->startPos.x, this->startPos.y,
										this->endPos.x, this->endPos.y,
										this->centre.x, this->centre.y,
										(int)this->rot);
										*/
	TrackArc::initialise();	
}

void TrackArc::load(const char* path, const char* filename)
{
	
}

void TrackArc::save(xmlDocPtr doc, xmlNodePtr cur)
{
	char buffer[256];
	xmlNodePtr node = xmlNewChild(cur, NULL, BAD_CAST "arc", NULL);
	if (!node)
 		Log::Instance()->die(1, SV_ERROR, "Problem saving trackarc[Failed to create node]");

	sprintf (buffer, "%d,%d", (int)this->startPos.x, (int)this->startPos.y); 		
	xmlNewProp(node, BAD_CAST "startpos", BAD_CAST buffer);
	sprintf (buffer, "%d,%d", (int)this->endPos.x, (int)this->endPos.y); 		
	xmlNewProp(node, BAD_CAST "endpos", BAD_CAST buffer);
	sprintf (buffer, "%d,%d", (int)this->centre.x, (int)this->centre.y); 		
	xmlNewProp(node, BAD_CAST "centre", BAD_CAST buffer);
	
	if (this->rot == ROT_CLOCKWISE)
		xmlNewProp(node, BAD_CAST "rotation", BAD_CAST "clockwise");
	else
		xmlNewProp(node, BAD_CAST "rotation", BAD_CAST "anticlockwise");
	
}

void TrackArc::save(const char* path, const char* filename)
{
	
}

// Accessor properties
void TrackArc::setStartPosition(Point pos)
{
	this->startPos = pos;
	TrackArc::calcCentrePoint(radius);
	TrackSection::resetTrackSurface();
	TrackArc::initialise();
}

void TrackArc::setEndPosition(Point pos)
{
	this->endPos = pos;
	TrackArc::calcCentrePoint(radius);
	TrackSection::resetTrackSurface();
	TrackArc::initialise();
}

Point TrackArc::getCentrePosition()
{
	return this->centre;	
}

void TrackArc::setCentrePosition(Point pos)
{
	this->centre = pos;
	TrackSection::resetTrackSurface();
	TrackArc::initialise();
}

Rotation TrackArc::getRotation()
{
	return this->rot;
}	

void TrackArc::setRotation(Rotation rot)
{
	this->rot = rot;
	TrackSection::resetTrackSurface();
	TrackArc::initialise();
}

double TrackArc::getRadius()
{
	return this->radius;
}

void TrackArc::setRadius(double rad)
{
	TrackArc::calcCentrePoint(rad);
	TrackSection::resetTrackSurface();
	TrackArc::initialise();
}

bool TrackArc::getFlip()
{
	return this->flip;	
}

void TrackArc::setFlip(bool flip)
{
	this->flip = flip;
	TrackArc::calcCentrePoint(this->radius);
	TrackSection::resetTrackSurface();
	TrackArc::initialise();
}

	
double TrackArc::move(Point* pos, Direction dir, double dist)
{
	// Assume that the input point is at the right radius.
	double currentAngle = quadrantise(this->centre, *pos, true);
	double targetAngle	= 0.0;
	double angleToMove	= 0.0;
	double angleAvailable = 0.0;
	double newAngle = 0.0;
	int multiplier = 0;
	Point targetPoint;
	
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
	
	// Adjust the target angles when the arc crosses the zero boundary
	if (this->crossesZero)
	{
		if (currentAngle < targetAngle && multiplier == -1)
			currentAngle += M_PI*2;
		else if (targetAngle < currentAngle && multiplier == 1)
			targetAngle += M_PI*2;	
	}
	
	angleToMove = dist / this->radius * multiplier;
	angleAvailable = targetAngle - currentAngle;
	
	// Move off the end of the arc
	if (fabs(angleAvailable) < fabs(angleToMove))
	{
		dist = (fabs(angleToMove) - fabs(angleAvailable)) * this->radius;
		*pos = targetPoint;
		return dist;	
	}
		
	// Don't move off the end of the arc. Return new midpoint and 0
    newAngle = currentAngle + angleToMove;
    
    double xInc = this->radius*cos(newAngle);
    double yInc = this->radius*sin(newAngle);
    
    pos->x = this->centre.x + xInc;
    pos->y = this->centre.y - yInc;
    
    return 0.0;
}

void TrackArc::draw(SDL_Surface* surf)
{
	if (this->trackSurface == NULL)
	{
		int width = (int)(this->radius + 2) * 2;
		int height = width;
		 
		// Create the cached surface
		this->trackSurface = Theme::Instance()->newsurf_fromsurf(surf, width, height);
	
		// Calculate where on the screen the surface should be drawn
		this->dst.x = (short int)(this->centre.x - this->radius);
		this->dst.y = (short int)(this->centre.y - this->radius);
		this->dst.w = width;
		this->dst.h = height;
		
		this->src.x = 0;
		this->src.y = 0;
		this->src.w = width;
		this->src.h = height;
		
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
		
		// Adjust the coordinates so they are relative to the cache surface
		Point adjCentre = this->centre;
		adjCentre.x -= this->dst.x;
		adjCentre.y -= this->dst.y;
		
		// Find the back ground witha colour which isn't the same as the line
		Uint32 colourBackground = this->colour + 10;
		SDL_FillRect(this->trackSurface, NULL, colourBackground);
		
		Theme::Instance()->drawArc(this->trackSurface, this->colour, adjCentre, this->startAngle, this->endAngle, this->radius, this->rot);
		
		// Set the transparency colour to the blank colour above.
	    if (SDL_SetColorKey (this->trackSurface, SDL_SRCCOLORKEY, colourBackground))
	    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Unable to set transparency on trackArc");
	    
	}
	
	SDL_BlitSurface(this->trackSurface, &this->src, surf, &this->dst);
	
}

bool TrackArc::onTrack(Point pos)
{
	double distCentre = pos.distanceFrom(this->centre);
	if (fabs(distCentre - this->radius) > ROUND_ERROR)
		return false;
	
	double angle = quadrantise(centre, pos, true);
	
	return TrackArc::inAngleBounds(angle);
}


InsertPoint TrackArc::bulletInsertPosition(Point bulletPos, Point targetPos)
{
	double bulletAngle = quadrantise(this->centre, bulletPos, false);
	double targetAngle = quadrantise(this->centre, targetPos, false);
	
	// If the arc crosses the zero boundary
	// then we could have one angle in the first quadarnt and one in the last
	// quadrant making all of the calculations out.
	// So if the angles are different quadrants then adjust the smallest
	if (this->crossesZero && fabs(targetAngle - bulletAngle) > M_PI_2 * 3)
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
 	
bool TrackArc::inAngleBounds(double angle)
{
	// Check if the given angle lies with the arc
	
    if (this->rot == ROT_CLOCKWISE)
    {
	  if (	!this->crossesZero && 
      	 	angle >= this->endAngle && 
      	 	angle <= this->startAngle)
        return true;
      
      else if (	this->crossesZero && 
      			((angle >= 0 && angle <= this->startAngle) ||
				(angle <= M_PI*2 && angle >= this->endAngle)))
	    return true;
	
	} else {
	
      if (	!this->crossesZero && 
      		angle >= this->startAngle && 
      		angle <= this->endAngle)
        return true;
    
      else if (	this->crossesZero && 
      			((angle >= 0 && angle <= this->endAngle) ||
				(angle <= M_PI*2 && angle >= this->startAngle)))
      	  return true;
        
    }
    return false;
}

void TrackArc::calcCentrePoint(double radius)
{
	// Calculate where the centre point is based on the radius
	// and the start / end points.
	// The centre should appear on a line which is at tangent
	// to the mid point of the line between the start / end points
	double xdiff = this->endPos.x - this->startPos.x;
	double ydiff = this->endPos.y - this->startPos.y;
	double angle = quadrantise(xdiff, ydiff, false);
	double dist_2  = endPos.distanceFrom(this->startPos) / 2;
	
	// Check to make sure the radius isn't too small otherwise the centre
	// won't be realistic
	if (radius < dist_2)
		radius = dist_2;
	
	// Find where the mid point between the start / end points
	Point middlePos;
	middlePos.x = startPos.x + (dist_2)*cos(angle);
	middlePos.y = startPos.y + (dist_2)*sin(angle);

	// Now find the centre
	// Calculate the distance the centre should be away from the connecting line
	double distIn = sqrt(radius * radius - dist_2 * dist_2);
	
	// If the arc has been flipped then maintain it.
	if (this->flip)
		distIn *= -1;
	this->centre.x = middlePos.x + distIn * cos(angle - M_PI_2);
	this->centre.y = middlePos.y + distIn * sin(angle - M_PI_2);
}

void TrackArc::initialise()
{
	this->radius = centre.distanceFrom(this->startPos);
	this->startAngle = quadrantise(this->centre, this->startPos, true);
	this->endAngle = quadrantise(this->centre, this->endPos, true);
	
	if ((this->rot == ROT_CLOCKWISE && this->startAngle < this->endAngle) ||
       (this->rot == ROT_ANTI_CLOCKWISE && this->endAngle < this->startAngle))
		this->crossesZero = true;
    else
   		this->crossesZero = false;
   		
   //	Log::Instance()->log("TrackArc::Initialise raidus %f, angles s = %f, e = %f, crosseszero %d", this->radius, this->startAngle, this->endAngle, this->crossesZero);
}

