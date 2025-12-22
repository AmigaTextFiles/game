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
 
 #include "TrainStation.h"

TrainStation::TrainStation()
{
	this->track = new Track();
	this->train = new Train(this->track);
	// Reset the carriage factory to 10 carriages with 4 colours
	this->carriageFactory = new CarriageFactory();
	this->carriageFactory->reset(30, 3);
}
TrainStation::~TrainStation()
{
	if (this->track != NULL)
		delete this->track;
	if (this->train != NULL)
		delete this->train;
	if (this->carriageFactory != NULL)
		delete this->carriageFactory;
}

void TrainStation::load(xmlDocPtr doc, xmlNodePtr cur)
{
	// By this point we should have a train node
	/*<train speed="2">
			<track>
        			<line startpos="50,0" endpos="450,200" />
        		        <arc endpos="450,300" centre="425,250" rotation="clockwise" />
        			<line endpos="50,400" />        
			</track>
			<carriages random="1" colour-num="3" carriage-num="30"/>
       </train>
   */
	
	// Load the train
	this->train->load(doc, cur);
	
	// Load the track
	xmlXPathObjectPtr xpathObj;
	xpathObj = searchDocXpath(doc, cur, "track");
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr != 1)
    {
    	xmlXPathFreeObject(xpathObj);
		Log::Instance()->die(1,SV_ERROR,"Train: Need a track for a train\n");
    }
    
	xmlNodePtr foundNode = xpathObj->nodesetval->nodeTab[0];
	this->track->load(doc, foundNode);
	xmlXPathFreeObject(xpathObj);
	
	// Load the carriages
	xpathObj = searchDocXpath(doc, cur, "carriages");
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr != 1)
    {
    	xmlXPathFreeObject(xpathObj);
		Log::Instance()->die(1,SV_ERROR,"Train: Need carriages for a train\n");
    }
    
	foundNode = xpathObj->nodesetval->nodeTab[0];
	this->carriageFactory->load(doc, foundNode);
	xmlXPathFreeObject(xpathObj);
}

void TrainStation::load(const char* path, const char* filename)
{
	
}

void TrainStation::save(xmlDocPtr doc, xmlNodePtr cur)
{
	
}

void TrainStation::save(const char* path, const char* filename)
{
	
}

TrainState TrainStation::getTrainState()
{
	return this->train->getState();
}

bool TrainStation::checkCollisionAndAdd(Bubble* bubble)
{
	return this->train->checkCollisionAndAdd(bubble);
}

bool TrainStation::isStationEmpty()
{
	return !this->carriageFactory->count();
}

void TrainStation::animate(LevelState state)
{
	this->train->animate(state);
	
	if (state != LS_RUNNING)
		return;
	
	if (this->train->clearedStation() && this->carriageFactory->count())
		this->train->addCarriage(this->carriageFactory->popCarriage());
	
	// Check for any carriages which have been pushed back into the station
	Carriage* car= this->train->returnStationedCarriages();
	if (car != NULL)
		this->carriageFactory->pushCarriage(car);
}

void TrainStation::draw(SDL_Surface* screenDest)
{
	// Draw out the track
	this->track->draw(screenDest);
	
	// Draw out the train on the track
	this->train->draw(screenDest);
}

bool TrainStation::mouseDown(int x, int y)
{
	return false;
}

bool TrainStation::keyPress( SDLKey key, SDLMod mod, Uint16 character )
{
	return false;
}
