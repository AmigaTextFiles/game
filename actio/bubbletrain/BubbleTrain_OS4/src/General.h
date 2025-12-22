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
  * General items defined in here
  */
  
#ifndef GENERAL_H
#define GENERAL_H

// System includes
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>
#include <math.h>
#include <string.h>
#include <iostream>
#include <fstream>
#include <libxml/parser.h>
#include <libxml/xmlmemory.h>
#include <libxml/xpath.h>

// Game includes
#include "Log.h"

// Constanst
#define APP_WIDTH 	800
#define APP_HEIGHT 	600
#define LOG_THRESHOLD 	SV_WARNING

// Define NULL
#ifndef NULL
#define NULL		((void *)0)
#endif

// Macros
#define max(a,b)	(((a)>(b))?(a):(b))
#define min(a,b)	(((a)<(b))?(a):(b))
#define radians(a)	((a) * M_PI / 180)
#define degrees(a) 	((a) * 180 / M_PI)
#define round(a) 	(floor((a) + 0.5))
#define random(a) 	((a) * rand() / RAND_MAX)

struct Point;

// Enumberated types
//------------------


// Colours used for the bubbles
#define MAX_COLOUR 5
enum Colour
{
	COL_BLUE,
	COL_RED,
	COL_GREEN,
	COL_YELLOW,
	COL_ORANGE
};

// Roation a track section moves in.
// e.g. if an arc starts at 0 and ends at PIE then this defines if the arc is 
// at the top anti_clockwise or at the bottom clockwise
enum Rotation
{
	ROT_CLOCKWISE,
	ROT_ANTI_CLOCKWISE,
};

// The state of the level.
enum LevelState
{
	LS_NOTSTARTED,
	LS_RUNNING,
	LS_GAMEOVER,
	LS_WON
};

// The state of an individual train
enum TrainState
{
	TS_CRASHED,
	TS_RUNNING,
	TS_EMPTY
};

// Indicates the direction a carriage is moving along the track.
enum Direction
{
	D_FORWARD,
	D_BACKWARD
};

// The different types of graphics which can be displayed to the 
// screen. All of these must be implemented in the theme files
#define MAX_GRAPHICS 11
enum GfxRes
{
	GFX_BUBBLE_RED,
	GFX_BUBBLE_ORANGE,
	GFX_BUBBLE_GREEN,
	GFX_BUBBLE_BLUE,
	GFX_BUBBLE_YELLOW,
	GFX_BUBBLE_BOMB,
	GFX_BUBBLE_COLOURBOMB,
	GFX_BUBBLE_SPEED,
	GFX_CANNON,
	GFX_BACKGROUND,
	GFX_HUD
};

// Define some basic types of fonts to be used. Which are defined
// in the theme files. This means you don't have to hard encode
// the exact font.
#define MAX_FONTS 7
enum FontRes
{
	FONT_DEFAULT_LARGE,
	FONT_DEFAULT,
	FONT_DEFAULT_SMALL,
	FONT_SCORE,
	FONT_MENU,
	FONT_BUTTON,
	FONT_DIALOG
};

// Define the sound effects for the game. These also have to be 
// implemeneted by the theme files.
#define MAX_SOUNDS 9
enum SndRes
{
	SND_FIREBULLET,
	SND_CANNONMOVE,
	SND_CANNONRELOAD,
	SND_REMOVEDGROUP,
	SND_GAMEOVER,
	SND_GAMEWON,
	SND_BOMB,
	SND_COLOURBOMB,
	SND_CLICK
};

// Define the different types of special bubble which can occur during the game
#define MAX_SFX 5
enum SFX {
	SFX_NORMAL,		// Normal bubble
	SFX_RAINBOW,	// Colours rotate while in the carriage
	SFX_SPEED,		// Adjusts the speed of the train as a multiplier 
					// e.g. +ve > 1 speed up the train 
					// +ve < 1 slows down 
					// -ve reverse the train
					// zero stops
	SFX_BOMB,		// Blows up the carriage hit + 2 surrounding
	SFX_COLOUR_BOMB	// Removes all carriages of the same colour hit
};

// General Methods
Uint32 getPixel(SDL_Surface *surface, int x, int y);		// Get a pixel colour from a surface
void putPixel(SDL_Surface *surface, int x, int y, Uint32 pixel);// Set a pixel colour on a surface
double quadrantise(double x, double y, bool screen);		// Calculate the angle between the two points
double quadrantise(Point start, Point end, bool screen);	
void mergeFilename(const char* path, const char* filename, char* fullFilename); // Combine a filename / path into one string

// XML Methods
xmlDocPtr loadXMLDocument(const char* filename);
bool checkRootNode(xmlDocPtr doc, const char* rootName);
xmlXPathObjectPtr searchDocXpath(xmlDocPtr doc, xmlNodePtr node, char* xPath);

// Map strings to enums
Colour mapColour(const char* col);
GfxRes mapGfxResourceID(const char* res);
FontRes mapFontResourceID(const char* res);
SndRes mapSndResourceID(const char* res);
SFX mapSfxResourceID(const char* res);

// Map keys to strings
const char* getKeyText(int key);

// General
bool fileExist(const char* filename);

// Sort
int compareChars (const void * a, const void * b);

// Basic Structures
//-----------------

// A single point (i.e. x, y position) with in 2D space
struct Point
{
	float x, y;

	inline Point(){};
	inline Point(float x, float y)
	{
		set(x, y);
	}

	inline void set(float x, float y)
	{
		this->x = x;
		this->y = y;
	}

	inline void set(char* value)
	{
		// set a point from a string of the format "400,400"
		char* ptemp= NULL; 
		ptemp = strchr(value,',');
		if (ptemp==NULL)
			return;
		*ptemp=0;
		this->x = atof(value);
		ptemp++;
		this->y = atof(ptemp);
	}

	inline Point& operator-= (Point& point)
	{
		this->x = this->x - point.x;
		this->y = this->y - point.y;
		return *this;
	}

	inline double distanceFrom(Point point)
	{
		float xDiff = this->x - point.x;
		float yDiff = this->y - point.y;
		float distSqrd = (yDiff * yDiff) + (xDiff * xDiff);
		if (distSqrd > 0)
			return sqrt(distSqrd);
		else
			return 0;
	}

};

// Defines a region with in 2D space
struct Rect
{
	Point topLeft, bottomRight;

	inline Rect() {};
	
	inline Rect (Point topLeft, Point bottomRight)
	{
		this->topLeft = topLeft;
		this->bottomRight = bottomRight;
	}

	inline Rect (float xTop, float yTop, float xBottom, float yBottom)
	{
		this->topLeft.set(xTop, yTop);
		this->bottomRight.set(xBottom, yBottom);
	}

	inline float width()
	{
		if (this->bottomRight.x > this->topLeft.x)
			return this->bottomRight.x - this->topLeft.x;
		else
			return this->topLeft.x - this->bottomRight.x;
	}

	inline float height()
	{
		if (this->topLeft.y > this->bottomRight.y)
			return this->topLeft.y - this->bottomRight.y;	
		else
			return this->bottomRight.y - this->topLeft.y;	
	}
};

// Define a vector for velocity defined in both carteasion(?) and angular formats
class Velocity
{
private:
	double xComponent;
	double yComponent;
	double speed, angle;

	inline void setComponents()
	{
		this->xComponent = speed * cos(angle);
		this->yComponent = speed * sin(angle);
	}
	
	inline void setAttributes()
	{
		this->angle = quadrantise(xComponent, yComponent, false);
		this->speed = sqrt(xComponent * xComponent + yComponent * yComponent);
	}

public:

	Velocity()
	{
		this->speed = this->angle = this->xComponent = this->yComponent = 0.0;	
	}
	
	Velocity(double speed, double angle)
	{
		this->speed = speed;
		this->angle = angle;
		Velocity::setComponents();
	}
	
	inline double getSpeed() { return this->speed; }
	inline void setSpeed(double speed)
	{ 
		this->speed = speed; 
		Velocity::setComponents();
	}
	
	inline double getAngle() { return this->angle; }
	inline void setAngle(double angle) 
	{ 
		this->angle = angle; 
		Velocity::setComponents();
	}
	
	inline double getXComp() { return this->xComponent; }
	inline void setXComp(double x)
	{
		this->xComponent = x;
		Velocity::setAttributes();
	}
	inline double getYComp() { return this->yComponent; }
	inline void setYComp(double y)
	{
		this->yComponent = y;
		Velocity::setAttributes();
	}
};

#endif
