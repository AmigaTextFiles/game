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
 
#include "FastestTime.h"

FastestTime* FastestTime::_instance = (FastestTime*)NULL; /// initialize static instance pointer


FastestTime* FastestTime::Instance()
{
	if (_instance == NULL)
	{
		_instance = new FastestTime();	
	}
	return _instance;
}

FastestTime::FastestTime()
{
	this->count = 0;
	for (int i = 0; i < HS_MAX_NUM; i++)
		this->hScores[i] = NULL;
	
	FastestTime::load();
}

FastestTime::~FastestTime()
{
	FastestTime::save();
	
	for (int i = 0; i < this->count; i++)
		if (this->hScores[i])
			delete this->hScores[i];

	this->_instance = NULL;
}

bool FastestTime::checkAddHS(const char* game, int level, int score)
{
	if (this->count < HS_MAX_NUM)
		return true;
	
	if (FastestTime::compareValues(this->count-1, level, score) > 0)
		return false;
	else
		return true;
}

void FastestTime::addHS(const char* name, const char* game, int level, int score)
{

	if (!FastestTime::checkAddHS(game, level, score))
		return;

	// If the last item then make sure we delete it
	if (this->count == HS_MAX_NUM)
	{
		// Move the count back to Max_num - 1 otherwise we will be inserting in the wrong place
		this->count--;
		delete this->hScores[this->count];
	}

	FastestTimeST* hsEntry = new FastestTimeST();
	hsEntry->name = strdup(name);
	hsEntry->game = strdup(game);
	hsEntry->level = level;
	hsEntry->score = score;
	this->hScores[this->count] = hsEntry;

	// Only increment count if it hasn't reached the end of the list
	if (this->count < HS_MAX_NUM)
		this->count++;
	
	FastestTime::sort();
	
	FastestTime::save();
}

// Widget
void FastestTime::draw(SDL_Surface* screenDest)
{
	// Write out the FastestTime in a tabbed format
	int namePos = 50;
	int nameWidth = 250;
	int gamePos = namePos + nameWidth + 10;
	int gameWidth = 150;
	int levelPos = gamePos + gameWidth + 10;
	int levelWidth = 50;
	int scorePos = levelPos + levelWidth + 10;
	int scoreWidth = 100;
	
	// Write out the name header
	Rect rlevel(namePos,80,namePos + nameWidth,100);
	Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "Name");
	
	rlevel.topLeft.x = gamePos;
	rlevel.bottomRight.x = gamePos + gameWidth;
	Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "Game");
	
	rlevel.topLeft.x = levelPos;
	rlevel.bottomRight.x = levelPos + levelWidth;
	Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "Level");

	rlevel.topLeft.x = scorePos;
	rlevel.bottomRight.x = scorePos + scoreWidth;
	Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "Time");
	
	int top = 100;
	int vertSpace = 20;
	for (int i = 0; i < this->count; i++)
	{
		rlevel.topLeft.x = namePos - 20;
		rlevel.topLeft.y = top;
		rlevel.bottomRight.x = namePos - 20 + nameWidth;
		rlevel.bottomRight.y = top + 20;
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "%d)", i + 1);
		
		rlevel.topLeft.x = namePos;
		rlevel.bottomRight.x = namePos + nameWidth;
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "%s", this->hScores[i]->name);

		rlevel.topLeft.x = gamePos;
		rlevel.bottomRight.x = gamePos + gameWidth;
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "%s", this->hScores[i]->game);

		rlevel.topLeft.x = levelPos;
		rlevel.bottomRight.x = levelPos + levelWidth;
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "%d" ,this->hScores[i]->level);

		rlevel.topLeft.x = scorePos;
		rlevel.bottomRight.x = scorePos + scoreWidth;
		Theme::Instance()->drawText(screenDest, FONT_SCORE, rlevel, Top, Left, "%d", this->hScores[i]->score);

		top += vertSpace;
	}
	
}

bool FastestTime::mouseDown(int x, int y)
{
	return false;
}

bool FastestTime::keyPress(SDLKey key, SDLMod mod, Uint16 character)
{
	return false;
}

///////////////////////////////////////////////////
// Private
///////////////////////////////////////////////////

int FastestTime::compare(int a, int b)
{
	// When comparing the one with the highest level should be ordered first
	// and the one with the lowest time should be ordered first.
	
	// Check the levels first
	if (this->hScores[a]->level != this->hScores[b]->level)
		return (this->hScores[a]->level - this->hScores[b]->level);
	
	// Check the score
	// Reverse the order it is checked in compared to the level because the lower
	// score is the better
	return (this->hScores[b]->score - this->hScores[a]->score);
	
}

// +Ve means the index item is the greater
// -Ve means the new item is greater
int FastestTime::compareValues(int index, int level, int score)
{
	// Check the levels first
	if (this->hScores[index]->level != level)
		return (this->hScores[index]->level - level);
	
	// Check the score
	return (score - this->hScores[index]->score);
}

void FastestTime::sort()
{
	if (this->count <= 1)
		return;
		
	// Just use a double nested loop for sorting for now because it isn't that important
	// and the list will only ever contain 10 items.
	for(int i=this->count-1; i>0; --i)
		for(int j=0; j<i; ++j)
		{
			if (FastestTime::compare(j, j+1) < 0)
			{
				FastestTimeST* temp = this->hScores[j];
				this->hScores[j] = this->hScores[j+1];
				this->hScores[j+1] = temp;
			}	
			
		}
}

void FastestTime::load()
{
	xmlDocPtr doc;
	xmlNodePtr root;
	
	doc = loadXMLDocument(HS_FILENAME);
	// Doesn't matter if there aren't any FastestTimes yet just carry on and someone
	// one day might be good enough to get on the table
	if (!doc)
		return;
		
    if (!checkRootNode(doc, "fastesttimes"))
    	Log::Instance()->die(1, SV_ERROR, "FastestTime load failed [root node not fastesttimes]");
	
	root = xmlDocGetRootElement(doc);
    if (root == NULL)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "FastestTime load failed [Empty Document]");
		xmlFreeDoc(doc);
		return;
    }
    
    // Loop through each child and add to the score table.
    xmlNodePtr cur = root->xmlChildrenNode;
    while (cur != NULL) {
        if (strcmp((const char*)cur->name, "fastesttime"))
        {
        	cur = cur->next;
        	continue;
        }
        
        // Find the name
		char* nameText = (char*)xmlGetProp(cur, (const xmlChar*)"name");
		if (nameText == NULL || !strcmp(nameText, ""))
			Log::Instance()->die(1, SV_ERROR, "FastestTime: Failed to load attribute name");
        
        // Find the name
		char* gameText = (char*)xmlGetProp(cur, (const xmlChar*)"game");
		if (gameText == NULL || !strcmp(gameText, ""))
			Log::Instance()->die(1, SV_ERROR, "FastestTime: Failed to load attribute game");
        		
        // Find the level
		char* levelText = (char*)xmlGetProp(cur, (const xmlChar*)"level");
		if (levelText == NULL || !strcmp(levelText, ""))
			Log::Instance()->die(1, SV_ERROR, "FastestTime: Failed to load attribute level");
		
		// Find the number
		char* scoreText = (char*)xmlGetProp(cur, (const xmlChar*)"score");
		if (scoreText == NULL || !strcmp(scoreText, ""))
			Log::Instance()->die(1, SV_ERROR, "FastestTime: Failed to load attribute score");
		
		// Add the scores to the table using add function this way it will always be ordered
		FastestTime::addHS(nameText, gameText, atoi(levelText), atoi(scoreText));
		
		cur = cur->next;
    }
   
    xmlFreeDoc(doc);
}

void FastestTime::save()
{
	xmlDocPtr doc = NULL;
    xmlNodePtr root_node = NULL;
    xmlNodePtr node = NULL;
    char buffer[256];

    LIBXML_TEST_VERSION;

    // Creates a new document, a node and set it as a root node
    doc = xmlNewDoc(BAD_CAST "1.0");
    root_node = xmlNewNode(NULL, BAD_CAST "fastesttimes");
    xmlDocSetRootElement(doc, root_node);
    
    for (int i = 0; i < this->count; i++)	
	{
		node = xmlNewChild(root_node, NULL, BAD_CAST "fastesttime", NULL);
 		if (!node)
 			Log::Instance()->die(1, SV_ERROR, "Problem saving high score table [Failed to create node]");
 		xmlNewProp(node, BAD_CAST "name", BAD_CAST this->hScores[i]->name);
 		xmlNewProp(node, BAD_CAST "game", BAD_CAST this->hScores[i]->game);
 		sprintf (buffer, "%d", this->hScores[i]->level);
		xmlNewProp(node, BAD_CAST "level", BAD_CAST buffer);
		sprintf (buffer, "%d", this->hScores[i]->score);
		xmlNewProp(node, BAD_CAST "score", BAD_CAST buffer);
	}
    
    // Save as utf-8 and indented
    if (!xmlSaveFormatFileEnc(HS_FILENAME,doc, "UTF-8", 1))
    	Log::Instance()->die(1, SV_ERROR, "Problem saving high score table [Failed to save file]");
    
    // free the document
    xmlFreeDoc(doc);
    
}
