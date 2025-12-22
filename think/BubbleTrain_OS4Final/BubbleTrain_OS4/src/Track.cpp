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
 
#include "Track.h"

Track::Track()
{
	this->trackIter = this->trackSections.GetIterator();
}

Track::~Track()
{
	this->trackSections.DeleteAndRemove();
}

void Track::load(xmlDocPtr doc, xmlNodePtr cur)
{
	// Load items into the track from an xml document
	xmlXPathObjectPtr xpathObj;
	TrackSection* trackSect;
	xmlNodePtr curTrack;
	
	// Find all items under the track item, these could be line, arc or spiral
	xpathObj = searchDocXpath(doc, cur, "*");
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr == 0)
    {
		Log::Instance()->die(1,SV_ERROR,"Track: Need at least one track section for a track\n");
    }
    
    // Add each of the items found.
    // This should add them in the order they were found in the xml file
	for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
    {
    	if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
    		continue;
    	
    	trackSect = NULL;
    	curTrack = xpathObj->nodesetval->nodeTab[i];
    	if (!strcmp((const char*)curTrack->name, "line"))
			trackSect = new TrackLine();
		else if (!strcmp((const char*)curTrack->name, "arc"))
			trackSect = new TrackArc();
		else if	(!strcmp((const char*)curTrack->name, "spiral"))
		    trackSect = new TrackSpiral();		
    			
    	if (trackSect != NULL)
    	{
    		trackSect->load(doc, curTrack);
	    	this->trackSections.Append(trackSect);
    	}
    }
    
    if (this->trackSections.Size() == 0)
    {
    	Log::Instance()->die(1,SV_ERROR,"Track: Need at least one track section for a track\n");
    }
    
    // Find the track colour
	char* colourText = (char*)xmlGetProp(cur, (const xmlChar*)"colour");
	if (colourText != NULL && strlen(colourText) == 7)
	{
		// Convert the colour from rgb hex format to the sdl int format
		char buffer[5] = "0x00";
		buffer[2] = colourText[1];
		buffer[3] = colourText[2];
		Uint8 r = (Uint8)strtol ( buffer, NULL, 16);
		buffer[2] = colourText[3];
		buffer[3] = colourText[4];
		Uint8 g = (Uint8)strtol ( buffer, NULL, 16);
		buffer[2] = colourText[5];
		buffer[3] = colourText[6];
		Uint8 b = (Uint8)strtol ( buffer, NULL, 16);
		
		Uint32 col = SDL_MapRGB(SDL_GetVideoSurface()->format, r, g, b);
		
		// Reset the colours for each track section loaded.
		this->trackIter.Start();
		while (this->trackIter.Valid())
		{
			this->trackIter.Item()->setColour(col);
			this->trackIter.Forth();	
		}
	}
	
}

void Track::load(const char* path, const char* filename)
{
	// Not implemented
}

void Track::save(xmlDocPtr doc, xmlNodePtr cur)
{
	// Not implemented
}

void Track::save(const char* path, const char* filename)
{
	// Not implemented
}

void Track::draw(SDL_Surface* screenDest)
{
	// Draw all of the track sections
	this->trackIter.Start();
	while (this->trackIter.Valid())
	{
		this->trackIter.Item()->draw(screenDest);
		this->trackIter.Forth();
	}
}

CarriageMoveState Track::move(Carriage* car, Direction dir, double dist)
{
	Point currentPos;
	bool foundTrack = false;
	// We are moving a carriage along the track. 
	// First we need to figure out which bit of track the carriage
	// is currently on. If the carriage is on track then just ask each track section
	// otherwise we need to be a bit more intelligent about it.
	//
	// If the carriage is travelling forward then start checking which track from the last
	// if the carriage is travelling backwards then start checking at the start.
	if (dir == D_FORWARD)
		this->trackIter.End();
	else
		this->trackIter.Start();
	currentPos = car->bubble->getPosition();
	
	//Log::Instance()->log("Moving bubble with position (%f,%f)", currentPos.x, currentPos.y);
		
	while (this->trackIter.Valid())
	{
		if (this->trackIter.Item()->onTrack(currentPos))
		{
			foundTrack = true;
			break;
		}
		if (dir == D_FORWARD)
			this->trackIter.Back();
		else
			this->trackIter.Forth();
	}
	if (!foundTrack)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Moving Carriage Failed, Couldn't find which track carriage is on, position (%f, %f)", currentPos.x, currentPos.y);
		return CMS_ON_TRACK;
	}
	
	while (dist > 0.0 )
	{
		// Move the carriage point along the track.
		dist = this->trackIter.Item()->move(&currentPos, dir, dist);
				
		// if we haven't finished moving then start along the next piece of track
		if (dist != 0.0)
		{
			if (dir == D_FORWARD)
			{
				this->trackIter.Forth();
				// We've reached the end of the track and are about to crash
				if (!trackIter.Valid())
					return CMS_CRASHED;	
			}
			else
			{
				this->trackIter.Back();
				// We've reversed a bit too much and have gone back into the carriage garage
				if (!trackIter.Valid())
					return CMS_RETURN_TO_STATION;	
			}
		}
	}

	// update the position of the carriage
	car->bubble->setPosition(currentPos);
	
    return CMS_ON_TRACK;
}

Point Track::getTrackStartPosition()
{
	if (this->trackSections.Size() > 0)
		return this->trackSections.m_head->m_data->getStartPosition();
	else
		return Point(0,0);
}

InsertPoint Track::bulletInsertPosition(Point bulletPos, Point targetPos)
{
	this->trackIter.End();
	while (this->trackIter.Valid())
	{
		if (this->trackIter.Item()->onTrack(targetPos))
		{
			return this->trackIter.Item()->bulletInsertPosition(bulletPos, targetPos);
		}
		this->trackIter.Back();
	}
	return BEFORE;
}
