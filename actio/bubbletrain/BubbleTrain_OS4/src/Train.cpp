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
 
#include "Train.h"

#undef LOG_THRESHOLD
#define LOG_THRESHOLD SV_WARNING

Train::Train(Track* track)
{
	this->track = track;
	this->state = TS_EMPTY;
	this->speed = 2;
	this->speedMultiplier = 1;
	this->carriageIter = this->carriages.GetIterator();
}

Train::~Train()
{
	this->explodingCarriages.DeleteAndRemove();
	this->carriages.DeleteAndRemove();
}

void Train::load(xmlDocPtr doc, xmlNodePtr cur)
{
	// Find the train speed from the xml file
	char* speedText = (char*)xmlGetProp(cur, (const xmlChar*)"speed");
	if (speedText != NULL || !strcmp(speedText, ""))
		this->speed = atof(speedText);
}

void Train::load(const char* path, const char* filename)
{
	// Not implemented but needs to support the ILoadSave interface
}

void Train::save(xmlDocPtr doc, xmlNodePtr cur)
{
	// Not implemented but needs to support the ILoadSave interface	
}

void Train::save(const char* path, const char* filename)
{
	// Not implemented but needs to support the ILoadSave interface	
}

void Train::draw(SDL_Surface* screenDest)
{
	// Move all of the active carriages around the screen;
	this->carriageIter.Start();
	while (this->carriageIter.Valid())
	{
		this->carriageIter.Item()->draw(screenDest);
		this->carriageIter.Forth();
	}
	
	// Move the exploding carriages
	DListIterator<ExplodingBubble*> expCarIter = explodingCarriages.GetIterator();
	expCarIter.Start();
	while (expCarIter.Valid())
	{
		expCarIter.Item()->draw(screenDest);
		expCarIter.Forth();
	}
	
}

void Train::animate(LevelState state)
{
	Train::animateExplosion();
	
	if (state != LS_RUNNING)
		return;
	
	if (this->state == TS_EMPTY)
		return;
	
	// Move the train forward
	Train::updateSpeedMultiplier();
	if (this->speedMultiplier < 0)
	{
		// Don't reset the carriageIter for this. Base it on the fact that it points to 
		// where the split on the train is and so should move from there.
		// If the iterator isn't valid then it must have reached the start of the train.
		// so reset back to the start.
		this->carriageIter.Forth();
		if (!this->carriageIter.Valid())
			this->carriageIter.Start();
		Train::rippleMove(this->carriageIter, D_BACKWARD, fabs(this->speed * this->speedMultiplier));
	}
	else
	{
		this->carriageIter.End();
		Train::rippleMove(this->carriageIter, D_FORWARD, this->speed * this->speedMultiplier);
	}
	
	// Animate the carriages
	this->carriageIter.Start();
	while (this->carriageIter.Valid())
	{
		this->carriageIter.Item()->animate();
		this->carriageIter.Forth();	
	}
	
	Train::removeGroupedCarriages();
}
  
TrainState Train::getState()
{
	return this->state;
}

bool Train::checkCollisionAndAdd(Bubble* bubble)
{
	// Move the train forward
	this->carriageIter.Start();
	while (this->carriageIter.Valid())
	{
		if (this->carriageIter.Item()->checkCollision(bubble->getPosition()))
		{
			// Insert the bubble into the train
			Train::insertBubble(bubble, this->carriageIter);
			return true;
		}
		this->carriageIter.Forth();	
	}
	return false;
}

bool Train::clearedStation()
{
	// Check the last carriage position relative to the start point
    if (this->carriages.Size() == 0)
    	return true;
    
    Point lastCarriagePos = this->carriages.m_tail->m_data->bubble->getPosition();
    double distance = lastCarriagePos.distanceFrom(track->getTrackStartPosition());
        
	return (distance > BUBBLE_SIZE);
}

void Train::addCarriage(Carriage* carriage)
{
	carriage->bubble->setPosition(track->getTrackStartPosition());
	carriage->state = CS_ON_TRACK;
	this->carriages.Append(carriage);
	// Make sure that the state of the train is running now that we have some carriages
	this->state = TS_RUNNING;
	
}

Carriage* Train::returnStationedCarriages()
{
	if (this->carriages.Size() == 0)
		return NULL;
		
	Carriage* carriage = NULL;
	if (this->carriages.m_tail->m_data->state == CS_IN_STATION)
	{
		// Remove the last item
		carriage = this->carriages.m_tail->m_data;
		// Reset speed sfx bubbles when coming out of the station
		if (carriage->bubble->getType() == SFX_SPEED)
			carriage->bubble->resetToNormal();
		
		this->carriages.RemoveTail();
	}
	return carriage;
}

void Train::removeGroupedCarriages()
{
	// Don't bother calculating if we haven't got enough carriages
	if (this->carriages.Size() < 3)
		return;
	
	int count = 1;
	Carriage* currentCarriage;
	Carriage* previousCarriage;
	
	this->carriageIter.End();
	previousCarriage = this->carriageIter.Item();
	
	this->carriageIter.Back();
	while (this->carriageIter.Valid())
	{
		currentCarriage = this->carriageIter.Item();
		
		// Check if we have are touching the next carriage and it is the same colour
		// can only remove groups of touching carriages which are the same colour.
		if (currentCarriage->bubble->getType() != SFX_SPEED && currentCarriage->bubble->getColour() == previousCarriage->bubble->getColour() && 
			Train::touchingCarriages(currentCarriage, previousCarriage))
		{
			count++;
		}
		else
		{
			if (count >= 3)
			{
				// To make it easier move the iterator to the item to remove,
				// and then back again
				this->carriageIter.Forth();
				Train::removeCarriageGroup(count);
				if (!this->carriageIter.Valid())
					this->carriageIter.End();
				else
					this->carriageIter.Back();
					
				Theme::Instance()->playSound(SND_REMOVEDGROUP);
			}
			count = 1;
		}
		previousCarriage = currentCarriage;
		this->carriageIter.Back();
	}
	
	if (count >= 3)
	{
		this->carriageIter.Start();
		Train::removeCarriageGroup(count);
		Theme::Instance()->playSound(SND_REMOVEDGROUP);
	}
	
	Train::updateStatus();
	
}

void Train::rippleMove(DListIterator<Carriage*> carriageIter, Direction dir, double dist)
{
	CarriageMoveState moveState;
	Carriage* currentCarriage;
	Point curCarPos;
	Point nextCarPos;
	double carriageOverlap;
	double carriageGap;
	while (carriageIter.Valid())
	{
		currentCarriage = carriageIter.Item();
		moveState = track->move(currentCarriage, dir, dist);
		switch (moveState)
		{
			case CMS_CRASHED:
				currentCarriage->state = CS_ON_TRACK;
				this->state = TS_CRASHED;
				break;
			case CMS_RETURN_TO_STATION:
				currentCarriage->state = CS_IN_STATION;
				Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Carriage moved back into the station");
				break;
			default:
				break;
		}
		// move onto the next carriage
		if (dir == D_FORWARD)
			carriageIter.Back();
		else
			carriageIter.Forth();
		
		// Check for collision with the next carriage
		// If so then move it along the track otherwise stop
		if (carriageIter.Valid())
		{
			curCarPos = currentCarriage->bubble->getPosition();
			nextCarPos = carriageIter.Item()->bubble->getPosition();
			carriageGap = curCarPos.distanceFrom(nextCarPos);
			
			// The next carriage is too far away to be moved so stop
			if (carriageGap > BUBBLE_SIZE)
				break;					
			
			carriageOverlap = BUBBLE_SIZE - carriageGap;

			dist = min(dist, carriageOverlap);
		}
	}
}

void Train::insertBubble(Bubble* bubble, DListIterator<Carriage*> carriageIter)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Inserting bubble");
	switch (bubble->getType())
	{
		case SFX_BOMB:
			Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Processing bomb");
			Train::triggerBomb(bubble, carriageIter);
			return;
		case SFX_COLOUR_BOMB:
			Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Processing colourbomb");
			Train::triggerColourBomb(bubble, carriageIter);
			return;	
		default:
			break;
	}
	
	// Find out wether to insert the new bubble before or after the one it collided with 
	InsertPoint insertPosition;
	Point bulletPos = bubble->getPosition();
	Point targetPos = carriageIter.Item()->bubble->getPosition();
	
	insertPosition = this->track->bulletInsertPosition(bulletPos, targetPos);
		
	// Create the new carriage
	Carriage* carriage = new Carriage(bubble);
	carriage->state = CS_ON_TRACK;
	carriage->bubble->setPosition(targetPos);
	
	DListIterator<Carriage*> carriageIterStored = NULL;
	if (insertPosition == BEFORE)	
	{
		this->carriages.InsertBefore(carriageIter, carriage);
		
		carriageIterStored = carriageIter;
		carriageIter.Back();
	}
	else
	{
		this->carriages.InsertAfter(carriageIter, carriage);

		carriageIterStored = carriageIter;
		carriageIterStored.Forth();	
	}
	
	// Move the surround carriages to make space for the new addition
	Train::rippleMove(carriageIter, D_FORWARD, BUBBLE_RAD);
	Train::rippleMove(carriageIterStored, D_BACKWARD, BUBBLE_RAD);
}

bool Train::touchingCarriages(Carriage* carriage1, Carriage* carriage2)
{
	Point pos1 = carriage1->bubble->getPosition();
	Point pos2 = carriage2->bubble->getPosition();
	double dist = fabs(pos1.distanceFrom(pos2));
    return dist <= (BUBBLE_SIZE + 1);
}

void Train::removeCarriageGroup(int count)
{
	while (count > 0)
	{
		if (this->carriageIter.Valid())
		{
			Train::addExplodedCarriage(this->carriageIter.Item()->bubble);
			delete this->carriageIter.Item();
			this->carriages.Remove(this->carriageIter);
		}
		else
		{
			Log::Instance()->log(SV_INFORMATION, SV_INFORMATION, "RemoveCarriageGroup: CarriageIter not valid");
		}
		count--;
	}
	
}
  
void Train::addExplodedCarriage(Bubble* carriagebubble)
{
	ExplodingBubble* expCar = new ExplodingBubble(carriagebubble->getColour(), carriagebubble->getPosition());
	explodingCarriages.Append(expCar);
}

void Train::animateExplosion()
{
	// Figure out the size of the screen
	Rect screenSize(0,0,SDL_GetVideoSurface()->w, SDL_GetVideoSurface()->h);
	
	DListIterator<ExplodingBubble*> expCarIter = explodingCarriages.GetIterator();
	expCarIter.Start();
	while (expCarIter.Valid())
	{
		expCarIter.Item()->animate();
		if (!expCarIter.Item()->onScreen(screenSize, 0))
		{
			delete expCarIter.Item();
			explodingCarriages.Remove(expCarIter);
		}
		expCarIter.Forth();
	}	
}

void Train::triggerBomb(Bubble* bubble, DListIterator<Carriage*> carriageIter)
{
	
	Theme::Instance()->playSound(SND_BOMB);
	
	// Get bombs to blow up carriages in the blast radius
	Point bombPos = bubble->getPosition();
	carriageIter.Start();
	while(carriageIter.Valid())
	{
		if (bombPos.distanceFrom(carriageIter.Item()->bubble->getPosition()) < BOMB_BLAST_RAD)
        {
			Train::addExplodedCarriage(carriageIter.Item()->bubble);
			delete carriageIter.Item();	
			carriages.Remove(carriageIter);
        }
		else
			carriageIter.Forth();	
	}
	Train::updateStatus();
	
}

void Train::triggerColourBomb(Bubble* bubble, DListIterator<Carriage*> carriageIter)
{
	Theme::Instance()->playSound(SND_COLOURBOMB);
	
	// Remove all of the carriages which are the same colour as the carriage hit
	Colour col = carriageIter.Item()->bubble->getColour();
	carriageIter.Start();
	while(carriageIter.Valid())
	{
		if (carriageIter.Item()->bubble->getColour() == col)
        {
            Train::addExplodedCarriage(carriageIter.Item()->bubble);
           	delete carriageIter.Item();		
	        carriages.Remove(carriageIter);
        }
		else
			carriageIter.Forth();	
	}
	
	Train::updateStatus();
}

void Train::updateStatus()
{
	if (this->carriages.Size() == 0)
		this->state = TS_EMPTY;
}


void Train::updateSpeedMultiplier()
{
	this->speedMultiplier = 1;
	
	if (this->carriages.Size() == 0)
		return;
	
	// Move through the train to and calculate the speed multiplier from 
	// only the carriages which are joined to the driving section.
	
	Carriage* currentCarriage;
	Carriage* previousCarriage;
	
	this->carriageIter.End();
	previousCarriage = this->carriageIter.Item();
	Train::tweakSpeedMultiplier(previousCarriage->bubble->getSpeedMultiplier());
	this->carriageIter.Back();
	if (this->carriageIter.Valid())
	{
		while (this->carriageIter.Valid())
		{
			currentCarriage = this->carriageIter.Item();
			// Check if we have are touching the next carriage and it is the same colour
			// can only remove groups of touching carriages which are the same colour.
			if (Train::touchingCarriages(currentCarriage, previousCarriage))
				Train::tweakSpeedMultiplier(currentCarriage->bubble->getSpeedMultiplier());
			else
				break;
			
			previousCarriage = currentCarriage;
			this->carriageIter.Back();	
		}
	}
}

void Train::tweakSpeedMultiplier(double speedAdjust)
{
	// No need to do anything if the multiplier is 1
	if (speedAdjust == 1.0)
		return;

	this->speedMultiplier += speedAdjust;
}
