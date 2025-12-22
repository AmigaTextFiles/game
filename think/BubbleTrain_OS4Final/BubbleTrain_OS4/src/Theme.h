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
  * Manage / Control the use of themes / fonts / sounds etc. Basically
  * the game engine for bubble train.
  * 
  * Implemented using the singleton pattern.
  */
 
#ifndef THEME_H
#define THEME_H

// System Includes
#include <SDL/SDL.h>
#include <SDL/SDL_image.h>
#include <SDL/SDL_mixer.h>
#include <string.h>
#include <math.h>

// Game Includes
#include "List.h"
#include "Font.h"
#include "Options.h"

// Define regular expressions for the paths for the theme
const char themePath[] = "%s../themes/%s/%s";
const char themeFullPath[] = "%s../themes/%s/theme.xml";
	
#define sdlColour2Uint32(col) (col.r + col.g << 8 + col.b << 16)

// Calculate rotated graphics on the fly and cache
// in the following struct for later use.
struct RotatedGfx
{
	GfxRes graphic;			// The graphic reference we rotated
	int rotation;			// degrees
	SDL_Surface* surface;	// The rotated graphic
	~RotatedGfx()
	{
		SDL_FreeSurface(surface);
	}	
};

// A call back function used when the music finishes.
void musicFinished();

class Theme
{
	
protected:
	Theme();
private:
	static Theme* _instance;				// Static Singleton instance

	char* filename;							// Reference to the actual theme
	char* path;
	
	SDL_Surface* screen;					// reference to the main screen.
	
	// Graphics
	SDL_Surface* graphics[MAX_GRAPHICS];	// Cached theme images
	List<RotatedGfx*> rotatedGraphics;		// Cached rotated theme images
	char* graphicFilenames[MAX_GRAPHICS];	// Mapping of graphics id to physical graphic file
	
	// Sound effects
	Mix_Chunk* sounds[MAX_SOUNDS];			// Cached sounds
	char* soundFilenames[MAX_SOUNDS];		// Mapping of sound id to sound files
	
	// Music
	Mix_Music *music;						// Reference to the music mixer
	List<char*> musicFilenames;				// List of music files
	DListIterator<char*> currentMusic;		// Reference to the current playing item
	
	// Fonts
	List<Font*> fontsList;					// Cache of all loaded fonts
	Font* fonts[MAX_FONTS];					// Cache mapping font id to fonts in the above list
	char* fontFilenames[MAX_FONTS];			// Mapping of fonts to font graphics
	
  	// Functions
  	// Lookup functions for retriving items from the cache
	Mix_Chunk* getSound(SndRes resourceID);
	Font* getFont(FontRes fontID);
	SDL_Surface* getGraphic(GfxRes resourceID);
	SDL_Surface* getRotatedGraphic(GfxRes resourceID, float rotation, SDL_Surface* resGraphic);
	
	// Graphic functions
	SDL_Surface* rotate(SDL_Surface* surf, float angle);
	SDL_Surface* rotate90(SDL_Surface *src, int angle);
	void rotate(SDL_Surface *src, SDL_Surface *dst, Uint32 bgcolor, double sangle, double cangle);
	void circlePoints(SDL_Surface* surf, Uint32 colour, int cx, int cy, int x, int y);
	
	// Reset the caches / mapping lists when a new theme is loaded
	void resetGraphics();
	void resetFonts();
	void resetSounds();
	
	// Load a new theme
	void loadGraphics(xmlDocPtr doc, xmlNodePtr cur);
	void loadFonts(xmlDocPtr doc, xmlNodePtr cur);
	void loadSounds(xmlDocPtr doc, xmlNodePtr cur);
	void loadMusic(xmlDocPtr doc, xmlNodePtr cur);
  
public:
	static Theme* Instance();

	~Theme();
	void initialise(SDL_Surface* screen);

	void load(const char* path, const char* filename);
	
	// Text functions
	void drawText(FontRes fontID, Rect boundingBox, VerticalAlign valign, HorizontalAlign halign, char* text, ...); 
	void drawText(SDL_Surface* surf, FontRes fontID, Rect boundingBox, VerticalAlign valign, HorizontalAlign halign, char* text, ...); 
	void textSize(FontRes fontID, Uint32* width, Uint32* height, const char* text, ...);
	
	// Draw graphics based on the graphic id
	void drawSurface(GfxRes resourceID, Point position, float rotation);
	void drawOffsetSurface(GfxRes resourceID, Point position, float rotation, Point offset);	
	void drawOffsetSurface(GfxRes resourceID, Point position, float rotation, int xOffsetPct, int yOffsetPct);
	
	// Sound functions
	void playSound(SndRes ResourceID);
	void pauseSounds(bool pause);
	
	// Musci functions
	void playThemeMusic();
	void playMusic(const char* filename);
	void pauseMusic(bool pause);
	void stopMusic();
	
	// General drawing functions
	void vertGradient(SDL_Surface* surf, SDL_Rect dest, SDL_Color c1, SDL_Color c2);
	void drawArc(SDL_Surface* surf, Uint32 colour, Point centre, Point startPos, Point endPos, Rotation rot);
	void drawArc(SDL_Surface* surf, Uint32 colour, Point centre, double startAngle, double endAngle, double radius, Rotation rot);
	void drawCircle(SDL_Surface* surf, Uint32 colour, Point centre, int radius);
	void drawDisc(SDL_Surface* surf, Uint32 colour, Point centre, int radius);
	void drawLine(SDL_Surface* surf, Uint32 colour, Point startPos, Point endPos);
	void drawLine(SDL_Surface* surf, Uint32 colour, int x1, int y1, int x2, int y2);
	void drawRect(SDL_Surface* surf, Uint32 colour, Point topLeft, Point bottomRight);
	void drawRect(SDL_Surface* surf, Uint32 colour, Rect size);
	SDL_Surface* newsurf_fromsurf(SDL_Surface* surf, int width, int height);
	SDL_Surface* loadTransparentBitmap(const char* filename);
	
};

#endif
