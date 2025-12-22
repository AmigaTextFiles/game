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
  * A track is a container for holding the individual track components and
  * for moving carriages along the track.
  */
 
#ifndef TRACK_H
#define TRACK_H

#include "ILoadSave.h"
#include "List.h"
#include "TrackSection.h"
#include "TrackLine.h"
#include "TrackArc.h"
#include "TrackSpiral.h"
#include "Carriage.h"

class Track: public ILoadSave
{

private:
	List<TrackSection*> trackSections;			// The track
	DListIterator<TrackSection*> trackIter;		// The current track node

public:
	Track();
	virtual ~Track();

	void draw(SDL_Surface* screenDest);
	CarriageMoveState move(Carriage* car, Direction dir, double dist);
	Point getTrackStartPosition();
	InsertPoint bulletInsertPosition(Point bulletPos, Point targetPos);

	// ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void load(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);

};

#endif
