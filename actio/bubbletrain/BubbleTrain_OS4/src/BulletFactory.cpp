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
 
#include "BulletFactory.h"

BulletFactory::BulletFactory()
{
	this->numberOfColours = 0;
}

BulletFactory::~BulletFactory()
{
	// Nothing to tidy up
}

void BulletFactory::resetFactory(int numberOfColours)
{
	this->numberOfColours = numberOfColours;
	// Default the coloursNum to -1 to mean infinite
	// or 0 if smaller than the colourNum
	for (int i=0; i < (MAX_COLOUR + MAX_SFX); i++)
	{
		if (i < numberOfColours)
			this->coloursNum[i] = -1;
		else
			this->coloursNum[i] = 0;
	}
	
	// Reset the SFX_NORMAL item because we don't want to include it
	coloursNum[MAX_COLOUR] = 0;
}

// load all of the details about the type / number of each bullet
// of an xml dom.
void BulletFactory::load(xmlDocPtr doc, xmlNodePtr cur)
{
	int number	= 0;
	bool isSpecial	= false;
	Colour col	= COL_RED;
	SFX sfx		= SFX_NORMAL;
	
	char* colourNumText = (char*)xmlGetProp(cur, (const xmlChar*)"colour-num");
	if (colourNumText != NULL || strcmp(colourNumText, ""))
		BulletFactory::resetFactory(atoi(colourNumText));	
	
	// Build up the count found for each type of bubble
	// move through each child element and build up the list.
	cur = cur->xmlChildrenNode;
	while (cur != NULL) {
		if (strcmp((const char*)cur->name, "bullet"))
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
			Log::Instance()->die(1,SV_ERROR,"BulletFactory: Colour not found for carriage\n");
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
			this->coloursNum[MAX_COLOUR + (int)sfx] += number;
		else
			this->coloursNum[(int)col] += number;
		cur = cur->next;
	}

	// Reset the SFX_NORMAL item
	// because all of the colour ones are normal so no point in including it.
	coloursNum[MAX_COLOUR] = 0;
}

// Get the next bullet from the list to load into the cannon.
Bullet* BulletFactory::popBullet()
{
	Bullet* bullet;
	int randBubble;
	// Generate a bubble which is a valid random one.
	while (true)
	{
		randBubble = rand() % (MAX_COLOUR + MAX_SFX);
		if (coloursNum[randBubble] != 0)
			break;
	}
	
	// Descrease the bubble num
	coloursNum[randBubble]--;
	
	// Create the bullet
	if (randBubble >= MAX_COLOUR)// special bubble
		bullet = new Bullet((SFX)(randBubble - MAX_COLOUR));
	else // normal bubble
		bullet = new Bullet((Colour)randBubble);
		
	bullet->bubble->setMaxColour(this->numberOfColours);

	return bullet;
}
