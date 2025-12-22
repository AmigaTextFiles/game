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
  * The train is a container for carriages and the track and is responsible
  * for moving the carriages along the track.
  */
 
#ifndef TRAIN_H
#define TRAIN_H

#include "ILoadSave.h"
#include "List.h"
#include "Track.h"
#include "Carriage.h"
#include "General.h"
#include "ExplodingBubble.h"

// Bomb blast Area that carriages are blown up from a bomb bubble
#define BOMB_BLAST_RAD BUBBLE_SIZE * 2

class Train: public ILoadSave
{

private:
	List<Carriage*> carriages;					// Carriages running on the track
	DListIterator<Carriage*> carriageIter;		// Reference to current carriage
	List<ExplodingBubble*> explodingCarriages;  // List of carriages which have been removed from the train
	Track* track;								// Track the carriages are running on
	TrainState state;							// State of the train. i.e. crashed, running
	double speedMultiplier;						// The overall speed of the train after it has been adjusted for speed bubbles
	double speed;								// The initial speed of the train
	
	void rippleMove(DListIterator<Carriage*> carriageIter, Direction dir, double Distance);
	void insertBubble(Bubble* bubble, DListIterator<Carriage*> carriageIter);
	bool touchingCarriages(Carriage* carriage1, Carriage* carriage2);
	void removeCarriageGroup(int count);
	void addExplodedCarriage(Bubble* bubble);
	void animateExplosion();
	void updateStatus();
	void updateSpeedMultiplier();
	void tweakSpeedMultiplier(double speedMult);
	void triggerBomb(Bubble* bubble, DListIterator<Carriage*> carriageIter);
	void triggerColourBomb(Bubble* bubble, DListIterator<Carriage*> carriageIter);
  
public:
	Train(Track* track);
	virtual ~Train();
  
  	void animate(LevelState state);
  	void draw(SDL_Surface* screenDest);
  	
	TrainState getState();
	bool clearedStation();
	bool checkCollisionAndAdd(Bubble* bubble);
	void addCarriage(Carriage* carriage);
	Carriage* returnStationedCarriages();
	void removeGroupedCarriages();
	
	// ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void load(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);
};

#endif
