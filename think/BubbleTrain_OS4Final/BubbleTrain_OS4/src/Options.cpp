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
 
#include "Options.h"

Options* Options::_instance = (Options*)NULL; /// initialize static instance pointer


Options* Options::Instance()
{
	if (_instance == NULL)
	{
		_instance = new Options();	
	}
	return _instance;
}

Options::Options()
{
	// load in the defaults for the options
	// Sound
	this->soundEnabled = true;
	this->musicVolume = MIX_MAX_VOLUME / 2; // Note the range for this is 0 -- MIX_MAX_VOLUME
	this->effectVolume = MIX_MAX_VOLUME / 2; // Note the range for this is 0 -- MIX_MAX_VOLUME
	// Game
	this->credits = 3;
	// Controls
	this->mouseEnabled = true;
	this->mouseSensitivity = 1;
	this->fireKey = SDLK_UP;
	this->cannonLeftKey = SDLK_LEFT;
	this->cannonRightKey = SDLK_RIGHT;
	Options::loadOptions();
}

Options::~Options()
{
	Options::saveOptions();
}

// Sound
void Options::setSoundEnabled(bool enabled)
{
	this->soundEnabled = enabled;
	Options::saveOptions();
}

bool Options::getSoundEnabled()
{
	return this->soundEnabled;
}

void Options::setMusicVolume(Uint8 vol)
{
	this->musicVolume = vol;
	Options::saveOptions();
}

Uint8 Options::getMusicVolume()
{
	return this->musicVolume;
}

void Options::setEffectVolume(Uint8 vol)
{
	this->effectVolume = vol;
	Options::saveOptions();
}

Uint8 Options::getEffectVolume()
{
	return this->effectVolume;
}

// Credits
void Options::setCredits(int newCredits)
{
	if (newCredits < 0 && newCredits != -1)
		newCredits = -1;
	else if (newCredits == 0)
		newCredits = 1;
		
	this->credits = newCredits;
	Options::saveOptions();
}

int Options::getCredits()
{
	return this->credits;
}

// Controls
// Mouse
void Options::setMouseEnabled(bool enabled)
{
	this->mouseEnabled = enabled;
	Options::saveOptions();
}

bool Options::getMouseEnabled()
{
	return this->mouseEnabled;
}

void Options::setMouseSensitivity(int sensitivity)
{
	if (sensitivity < 1)
		sensitivity = 1;
	else if (sensitivity > 100)
		sensitivity = 100;
		
	this->mouseSensitivity = sensitivity;
	Options::saveOptions();
}

int Options::getMouseSensitivity()
{
	return this->mouseSensitivity;
}

// Keys
void Options::setFireKey(int fire)
{
	this->fireKey = fire;
	Options::saveOptions();
}

int Options::getFireKey()
{
	return this->fireKey;
	Options::saveOptions();
}

void Options::setCannonLeftKey(int left)
{
	this->cannonLeftKey = left;
}

int Options::getCannonLeftKey()
{
	return this->cannonLeftKey;
}

void Options::setCannonRightKey(int right)
{
	this->cannonRightKey = right;
	Options::saveOptions();
}

int Options::getCannonRightKey()
{
	return this->cannonRightKey;
}


void Options::loadOptions()
{
	xmlDocPtr doc;
	xmlNodePtr root;
	
	if (!fileExist(OPTIONS_FILENAME))
		return;
	
	doc = loadXMLDocument(OPTIONS_FILENAME);
	// Doesn't matter if there aren't any options yet just carry on and use the defaults
	if (!doc)
		return;
		
    if (!checkRootNode(doc, "options"))
    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Options load failed [root node not options]");
	
	root = xmlDocGetRootElement(doc);
    if (root == NULL)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Options load failed [Empty Document]");
		xmlFreeDoc(doc);
		return;
    }
    
    // Load the sound options
	xmlXPathObjectPtr xpathObj = searchDocXpath(doc, root, "sound");
	xmlNodePtr foundNode = NULL;
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr != 1)
    {
    	Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"Options: failed to find the sound option\n");
    } 
    else
    {
    
		foundNode = xpathObj->nodesetval->nodeTab[0];
		// Sound options
	    // Enabled
		char* enabledText = (char*)xmlGetProp(foundNode, (const xmlChar*)"enabled");
		if (enabledText != NULL && strcmp(enabledText, "") != 0)
	        this->soundEnabled = atoi(enabledText);

		// Music volume
		char* musicVolText = (char*)xmlGetProp(foundNode, (const xmlChar*)"musicvolume");
		if (musicVolText != NULL && strcmp(musicVolText, "") != 0)
	        this->musicVolume = atoi(musicVolText);

		// Effect volume
		char* effectVolText = (char*)xmlGetProp(foundNode, (const xmlChar*)"effectvolume");
		if (effectVolText != NULL && strcmp(effectVolText, "") != 0)
	        this->effectVolume = atoi(effectVolText);
		
	}
	
	xmlXPathFreeObject(xpathObj);
		
    // Load the game options
	xpathObj = searchDocXpath(doc, root, "game");
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr != 1)
    {
    	Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"Options: failed to find the game option\n");
    } 
    else
    {
    	foundNode = xpathObj->nodesetval->nodeTab[0];
		// Game options
	    // Credits
		char* creditsText = (char*)xmlGetProp(foundNode, (const xmlChar*)"credits");
		if (creditsText != NULL && strcmp(creditsText, "") != 0)
		    this->credits = atoi(creditsText);
	    		    
    }
    xmlXPathFreeObject(xpathObj);
    
    // Load the mouse options
	xpathObj = searchDocXpath(doc, root, "mouse");
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr != 1)
    {
    	Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"Options: failed to find the mouse option\n");
    } 
    else
    {
    	foundNode = xpathObj->nodesetval->nodeTab[0];
		// Mouse options
	    // Enabled
		char* enabledText = (char*)xmlGetProp(foundNode, (const xmlChar*)"enabled");
		if (enabledText != NULL && strcmp(enabledText, "") != 0)
	        this->mouseEnabled = atoi(enabledText);

		// Mouse sensitivity
		char* sensText = (char*)xmlGetProp(foundNode, (const xmlChar*)"sensitivity");
		if (sensText != NULL && strcmp(sensText, "") != 0)
	        this->mouseSensitivity = atoi(sensText);
	}
	
	xmlXPathFreeObject(xpathObj);
		
	// Load the key options
	xpathObj = searchDocXpath(doc, root, "key");
    
    if (xpathObj == NULL || xpathObj->nodesetval == NULL || xpathObj->nodesetval->nodeNr != 1)
    {
    	Log::Instance()->log(LOG_THRESHOLD, SV_WARNING,"Options: failed to find the key option\n");
    } 
    else
    {
    	foundNode = xpathObj->nodesetval->nodeTab[0];
		// Key options
	    // Fire
		char* fireText = (char*)xmlGetProp(foundNode, (const xmlChar*)"fire");
		if (fireText != NULL && strcmp(fireText, "") != 0)
	        this->fireKey = atoi(fireText);

		// left key
		char* leftText = (char*)xmlGetProp(foundNode, (const xmlChar*)"left");
		if (leftText != NULL && strcmp(leftText, "") != 0)
	        this->cannonLeftKey = atoi(leftText);
		
		// Right key
		char* rightText = (char*)xmlGetProp(foundNode, (const xmlChar*)"right");
		if (rightText != NULL && strcmp(rightText, "") != 0)
	        this->cannonRightKey = atoi(rightText);
	}
	
	xmlXPathFreeObject(xpathObj);
	
    xmlFreeDoc(doc);
}

void Options::saveOptions()
{
	xmlDocPtr doc = NULL;
    xmlNodePtr root_node = NULL;
    char buffer[256];

    LIBXML_TEST_VERSION;

    // Creates a new document, a node and set it as a root node
    doc = xmlNewDoc(BAD_CAST "1.0");
    root_node = xmlNewNode(NULL, BAD_CAST "options");
    xmlDocSetRootElement(doc, root_node);
    
    // Sound options
    xmlNodePtr nodeSnd = xmlNewChild(root_node, NULL, BAD_CAST "sound", NULL);
	// Enabled
	sprintf (buffer, "%d", this->soundEnabled);
	xmlNewProp(nodeSnd, BAD_CAST "enabled", BAD_CAST buffer);
	// Music volume
	sprintf (buffer, "%d", this->musicVolume);
	xmlNewProp(nodeSnd, BAD_CAST "musicvolume", BAD_CAST buffer);
	// Effect volume
	sprintf (buffer, "%d", this->effectVolume);
	xmlNewProp(nodeSnd, BAD_CAST "effectvolume", BAD_CAST buffer);
	
	// Game options
    xmlNodePtr nodeGame = xmlNewChild(root_node, NULL, BAD_CAST "game", NULL);
	// Credits
	sprintf (buffer, "%d", this->credits);
	xmlNewProp(nodeGame, BAD_CAST "credits", BAD_CAST buffer);
	  
	// Control options
	// Mouse
    xmlNodePtr nodeMouse = xmlNewChild(root_node, NULL, BAD_CAST "mouse", NULL);
	// Mouse Enabled
	sprintf (buffer, "%d", this->mouseEnabled);
	xmlNewProp(nodeMouse, BAD_CAST "enabled", BAD_CAST buffer);
	// Mouse Sensitivity
	sprintf (buffer, "%d", this->mouseSensitivity);
	xmlNewProp(nodeMouse, BAD_CAST "sensitivity", BAD_CAST buffer);
	
	// Key
	xmlNodePtr nodeKey = xmlNewChild(root_node, NULL, BAD_CAST "key", NULL);
	// FireKey
	sprintf (buffer, "%d", this->fireKey);
	xmlNewProp(nodeKey, BAD_CAST "fire", BAD_CAST buffer);
	// Left
	sprintf (buffer, "%d", this->cannonLeftKey);
	xmlNewProp(nodeKey, BAD_CAST "left", BAD_CAST buffer);
	// Right
	sprintf (buffer, "%d", this->cannonRightKey);
	xmlNewProp(nodeKey, BAD_CAST "right", BAD_CAST buffer);
	
    // Save as utf-8 and indented
    if (xmlSaveFormatFileEnc(OPTIONS_FILENAME, doc, "UTF-8", 1) == -1)
    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Problem saving options table [Failed to save file]");
    
    // free the document
    xmlFreeDoc(doc);
    
    Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "options::end saving");
}

