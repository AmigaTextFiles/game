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
 
#include "CarriageFactory.h"

CarriageFactory::CarriageFactory()
{
	
}

CarriageFactory::~CarriageFactory()
{
	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Clearing up carriagefactory");
	this->carriages.DeleteAndRemove();
}

void CarriageFactory::reset(int numOfBubbles, int numOfColours)
{
	this->maxColours = numOfColours;
	this->carriages.DeleteAndRemove();
	Carriage* carriage;
	// Create the list of bubbles for the carriage
	for(int i = 0; i < numOfBubbles; i++)
	{
		// Make sure you never get three of the same colour bubbles
		if (i >=2)
		{
			while (true)
			{
				carriage = new Carriage((Colour)(rand() % numOfColours));
				if (this->carriages.m_tail->m_data->bubble->getColour() != carriage->bubble->getColour() ||
					this->carriages.m_tail->m_previous->m_data->bubble->getColour() != carriage->bubble->getColour())
					break;
				else
					delete carriage;
			}
		}
		else
			carriage = new Carriage((Colour)(rand() % numOfColours));
		this->carriages.Append(carriage);
	}
}

void CarriageFactory::load(xmlDocPtr doc, xmlNodePtr cur)
{
	bool random		= false;
	int colourNum	= 0;
	int carriageNum	= 0;
	//<carriages random="1 or 0 (Optional)" colour-num="number of colours(Optional ignored if random not set)" carriage-num="number of carriages (Optional ignored if random and colour-num not set)">
	// <carriage type="(colour of the carriage with is to come out) or (the type of special carriage if the special flag is enabled)" special="flag if the carriage is special or not (Optional)" number="of this carriage type in this sequence or the total number if random(Optional only if random is not set)" />
	/*
	Example 1 a random list of carriages with number of colours not set
	This produces a list of 30 carriages in a random order which are made up of 10 each of red, blue and orange

	<carriages random="1">
		<carriage type="red" number="10"/>
		<carriage type="blue" number="10"/>
		<carriage type="orange" number="10"/>
	</carriages>
	*/
	// Make sure this is a carriages node
	if (strcmp((const char*)cur->name, "carriages"))
		Log::Instance()->die(1,SV_ERROR,"Carriages: node trying to load is not carriages but %s\n", (const char*)cur->name);
		
	// Find the random
	char* randomText = (char*)xmlGetProp(cur, (const xmlChar*)"random");
	if (randomText != NULL || !strcmp(randomText, "1"))
		random = true;
		
	if (random)
	{
		// Find colour Num
		char* colourText = (char*)xmlGetProp(cur, (const xmlChar*)"colour-num");
		if (colourText != NULL || strcmp(colourText, ""))
		{
			colourNum = atoi(colourText);
			this->maxColours = colourNum;
		}
			
		// Find carriage Num
		char* carriageText = (char*)xmlGetProp(cur, (const xmlChar*)"carriage-num");
		if (carriageText != NULL || strcmp(carriageText, ""))
			carriageNum = atoi(carriageText);
			
		CarriageFactory::loadRandom(cur, colourNum, carriageNum);
	}
	else
		loadSetSequence(cur);
	
}

void CarriageFactory::load(const char* path, const char* filename)
{
	// We don't support this type of load 
}

void CarriageFactory::save(xmlDocPtr doc, xmlNodePtr cur)
{
	// We don't need to save anything but must support the interface
}

void CarriageFactory::save(const char* path, const char* filename)
{
	// We don't need to save anything but must support the interface
}

Carriage* CarriageFactory::popCarriage()
{
	if (!carriages.Size())
		return NULL;
	Carriage* head = this->carriages.m_head->m_data;
	this->carriages.RemoveHead();
	return head;
}

int CarriageFactory::count()
{
	return this->carriages.Size();
}

void CarriageFactory::pushCarriage(Carriage* carriage)
{
	this->carriages.Prepend(carriage);
}

int CarriageFactory::getMaxColours()
{
	return this->maxColours;
}

void CarriageFactory::loadSetSequence(xmlNodePtr cur)
{
	Carriage* carriage=NULL;
	Colour col=COL_RED;
	int number=0;
	
	// move through each child element and build up the list.
	cur = cur->xmlChildrenNode;
	while (cur != NULL) {
		if (strcmp((const char*)cur->name, "carriage"))
		{
			cur = cur->next;
			continue;
		}

		// Find the colour
		char* colourText = (char*)xmlGetProp(cur, (const xmlChar*)"type");
		if (colourText != NULL || strcmp(colourText, ""))
			col = mapColour(colourText);
		else
			Log::Instance()->die(1,SV_ERROR,"CarriageFactory: Colour not found for carriage\n");
		
		// Find the number
		char* numberText = (char*)xmlGetProp(cur, (const xmlChar*)"number");
		if (numberText != NULL || strcmp(numberText, ""))
			number = atoi(numberText);
		else
			number = 1;
		
		for(int i=0; i < number; i++)
		{
			carriage = new Carriage(col);
			this->carriages.Append(carriage);
		}
		cur = cur->next;
    }
}

void CarriageFactory::loadRandom(xmlNodePtr cur, int colourNum, int carriageNum)
{
	/* Random: 	1) If the number of colours and carriages is defined then use these.
			2) If there are carriages defined as above then make sure you include these,
				the number for each carriage refers to the maximum of that type.
	 examples
	 
	<carriages random="1" color-num="3" carriage-num="10" />
	
	<carriages random="1" color-num="3" carriage-num="20">
		<carriage type="rainbow" special="true" number="1" />
	</carriages>
	 
	<carriages random="1" color-num="3" carriage-num="30">
	 	<carriage type="rainbow" special="true" number="1" />
	 	<carriage type="red" number="10" />
	</carriages>
	
	<carriages random="1">
		<carriage type="red" number="5" />
		<carriage type="blue" number="5" />
		<carriage type="green" number="5" />
	</carriages>
		
	*/
	
	// Move through each of the carriages and keep a record of the max number for each type.
	// Then use these to help generate the list.
	int coloursNum[MAX_COLOUR + MAX_SFX];
	int totalNum	= 0;
	int number 	= 0;
	bool isSpecial 	= false;
	Colour col 	= COL_RED;
	SFX sfx 	= SFX_NORMAL;
	
	// Clear out the current list
	this->carriages.DeleteAndRemove();
	
	// Default the coloursNum to -1 to mean infinite
	// or 0 if smaller than the colourNum
	for (int i=0; i < (MAX_COLOUR + MAX_SFX); i++)
	{
		if (i < colourNum)
			coloursNum[i] = -1;
		else
			coloursNum[i] = 0;
	}
	
	// Build up the count found for each type of bubble
	// move through each child element and build up the list.
	cur = cur->xmlChildrenNode;
	while (cur != NULL) {
		if (strcmp((const char*)cur->name, "carriage"))
		{
			cur = cur->next;
			continue;
		}

		// Find if the carriage is a special type
		char* sfxText = (char*)xmlGetProp(cur, (const xmlChar*)"special");
		if (sfxText != NULL || strcmp(sfxText, ""))
			isSpecial = true;
		else
			isSpecial = false;		

		// Find the colour or special type
		char* colourText = (char*)xmlGetProp(cur, (const xmlChar*)"type");
		if (colourText == NULL || !strcmp(colourText, ""))
			Log::Instance()->die(1,SV_ERROR,"CarriageFactory: Colour not found for carriage\n");
		else if (isSpecial)
			sfx = mapSfxResourceID(colourText);
		else
			col = mapColour(colourText);
		
		// Find the number
		char* numberText = (char*)xmlGetProp(cur, (const xmlChar*)"number");
		if (numberText != NULL || strcmp(numberText, ""))
			number = atoi(numberText);
		else
			number = 1;
		
		// Assign the number found for that type
		if (isSpecial)
		{
			coloursNum[MAX_COLOUR + (int)sfx] += number;
		}
		else
		{
			coloursNum[(int)col] += number;
			totalNum += number;  // keep a count of the total normal bubbles
		}
		cur = cur->next;
	}

	// If no carriage-num set then use the total normal bubbles found
	if (carriageNum == 0)
		carriageNum = totalNum;
		
	// Check to make sure that we are generating some carriages otherwise throw a wobbla
	if (carriageNum == 0)
		Log::Instance()->die(1,SV_ERROR,"CarriageFactory: No carriages found to generate\n");
	
	Carriage* carriage;
	int randBubble = 0;
	// Create the list of bubbles for the carriage
	for(int i = 0; i < carriageNum; i++)
	{
		// Find a valid carriage
		do 
		{
			// Generate a bubble which is a valid random one.
			while (true)
			{
				randBubble = rand() % (MAX_COLOUR + MAX_SFX);
				if (coloursNum[randBubble] != 0)
					break;
			}
		
			// Create the carriage
			if (randBubble > MAX_COLOUR) // special bubble
				carriage = new Carriage((SFX)(randBubble - MAX_COLOUR));
			else // normal bubble
				carriage = new Carriage((Colour)randBubble);
			
			// Check the generated carriage is a valid one
			if (CarriageFactory::colourAllowed(carriage->bubble->getColour()))
				break;
			else
				delete carriage;
			
		} while (true);
		
		coloursNum[randBubble]--; // Decrease the number of this type of bubble
		this->carriages.Append(carriage);
	}
}

bool CarriageFactory::colourAllowed(Colour col)
{
	if (this->carriages.Size() < 2)
		return true;
		
	// You can't have 3 carriages of the same colour in a row otherwise they will be removed
	// as soon as they hit the track
	if (this->carriages.m_tail->m_data->bubble->getColour() != col ||
		this->carriages.m_tail->m_previous->m_data->bubble->getColour() != col)
		return true;
	else
		return false;
}
