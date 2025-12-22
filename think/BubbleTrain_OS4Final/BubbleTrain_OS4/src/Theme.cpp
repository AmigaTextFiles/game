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
 
#include "Theme.h"

#undef LOG_THRESHOLD
#define LOG_THRESHOLD SV_WARNING

///////////////////////////////////////////////////////////////////
// Public Methods
///////////////////////////////////////////////////////////////////

Theme* Theme::_instance = (Theme*)NULL; /// initialize static instance pointer


Theme::Theme()
{
	this->filename 	= NULL;
	this->path		= NULL;
	this->screen	= NULL;
	this->music		= NULL;
	for (int c=0; c<MAX_GRAPHICS; c++)
	{
		this->graphics[c] = NULL;
		this->graphicFilenames[c] = NULL;
	}
		
	for (int f=0; f<MAX_FONTS; f++)
	{
		this->fonts[f] = NULL;
		this->fontFilenames[f] = NULL;
	}
	
	for (int s=0; s<MAX_SOUNDS; s++)
	{
		this->sounds[s] = NULL;
		this->soundFilenames[s] = NULL;
	}
	
	this->currentMusic = this->musicFilenames.GetIterator();
}

Theme::~Theme()
{
	// Delete the font array
	this->fontsList.DeleteAndRemove();
	this->musicFilenames.DeleteAndRemove();
	Theme::resetGraphics();
	Theme::resetFonts();
	delete[] this->filename;
	delete[] this->path;
	
	Theme::stopMusic();
}

Theme* Theme::Instance()
{
	if (_instance == NULL)
	{
		_instance = new Theme();	
	}
	return _instance;	
}

void Theme::initialise(SDL_Surface* screen)
{
	this->screen = screen;
}

void Theme::load(const char* path, const char* filename)
{
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Theme::load");
	xmlDocPtr doc = NULL;
	xmlNodePtr root = NULL;
	
	// Do an initial check for the theme filename
	// because if two levels use the same theme then don't need to refresh
	if (this->filename != NULL && !strcmp(filename, this->filename))
		return;
		
	Log::Instance()->log(LOG_THRESHOLD, SV_INFORMATION, "Theme::loading new theme");
	
	// make sure we store the filename
	//if (this->filename != NULL)
	//	delete[] this->filename;
	this->filename = strdup(filename);
	this->path = strdup(path);
	
	char fullFilename[512];
	//mergeFilename(path, filename, fullFilename);
	
	sprintf(fullFilename , themeFullPath, path, filename);
	
	doc = loadXMLDocument(fullFilename);
	if (doc == NULL)
		Log::Instance()->die(1, SV_ERROR, "Theme load failed loading file %s%s", path, filename);
	
    if (!checkRootNode(doc, "theme"))
    	Log::Instance()->die(1, SV_ERROR, "Theme load failed loading file %s%s [root node not theme]", path, filename);
	
	root = xmlDocGetRootElement(doc);
    if (root == NULL)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Theme load failed loading file %s [Empty Document]", filename);
		xmlFreeDoc(doc);
		return;
    }
    
    Theme::loadGraphics(doc, root);
    Theme::loadFonts(doc, root);
    Theme::loadSounds(doc, root);
    Theme::loadMusic(doc, root);
        
	xmlFreeDoc(doc);

}

void Theme::drawText(SDL_Surface* surf, FontRes fontID, Rect boundingBox, VerticalAlign valign, HorizontalAlign halign, char* text, ...)
{
	char string[1024];          // Temporary string
	
	va_list ap;               	// Pointer To List Of Arguments
	va_start(ap, text);         // Parses The String For Variables
	vsprintf(string, text, ap); // Converts Symbols To Actual Numbers
	va_end(ap);               	// Results Are Stored In Text
	
	Font* currentFont = Theme::getFont(fontID);
	if (currentFont != NULL)
		currentFont->drawText(surf, boundingBox, valign, halign, string);
		
}

void Theme::drawText(FontRes fontID, Rect boundingBox, VerticalAlign valign, HorizontalAlign halign, char* text, ...)
{
	char string[1024];          // Temporary string
	
	va_list ap;               	// Pointer To List Of Arguments
	va_start(ap, text);         // Parses The String For Variables
	vsprintf(string, text, ap); // Converts Symbols To Actual Numbers
	va_end(ap);               	// Results Are Stored In Text
	
	Font* currentFont = Theme::getFont(fontID);
	if (currentFont != NULL)
		currentFont->drawText(screen, boundingBox, valign, halign, string);
}

void Theme::textSize(FontRes fontID, Uint32* width, Uint32* height, const char* text, ...)
{
	char string[1024];          // Temporary string
	
	va_list ap;               	// Pointer To List Of Arguments
	va_start(ap, text);         // Parses The String For Variables
	vsprintf(string, text, ap); // Converts Symbols To Actual Numbers
	va_end(ap);               	// Results Are Stored In Text
	
	Font* currentFont = Theme::getFont(fontID);
	if (currentFont == NULL)
		return;

	if (width != NULL)
		*width = currentFont->textWidth(string);
	if (height != NULL)
		*height = currentFont->height();
}
 
void Theme::drawSurface (GfxRes resourceID, Point position, float rotation)
{
	Theme::drawOffsetSurface (resourceID, position, rotation, 0,0);
}

void Theme::drawOffsetSurface (GfxRes resourceID, Point position, float rotation, Point offset)
{
	position -= offset;
	Theme::drawSurface (resourceID, position, rotation);
}	

void Theme::drawOffsetSurface (GfxRes resourceID, Point position, float rotation, int xOffsetPct, int yOffsetPct)
{
	int xOffset=0;
	int yOffset=0;
	int xOffsetC=0;
	int yOffsetC=0;
	int distCentre=0;
	
	// Re-adjust the percents if out of bounds.
	if (xOffsetPct > 100) 	xOffsetPct = 100;
	if (xOffsetPct < 0) 	xOffsetPct = 0;
	if (yOffsetPct > 100) 	yOffsetPct = 100;
	if (yOffsetPct < 0) 	yOffsetPct = 0;	
	
	SDL_Surface* resGraphic = Theme::getGraphic(resourceID);
	SDL_Surface* rotResGraphic;
	
	if (rotation == 0.0)
		rotResGraphic = resGraphic;
	else
		rotResGraphic = Theme::getRotatedGraphic(resourceID, rotation, resGraphic);

	// Calculate the offset of the image relative to the centre of the image.
	// This is where the image is going to be rotated about. Then calculate the 
	// new position based on the rotation of the image. Then last of all relate
	// this new offset back to the 0,0 position of the new image.
	if (xOffsetPct > 0 || yOffsetPct > 0)
	{
	
		// Calculate where the offset is relative to 0,0 top left
		if (xOffsetPct > 0)
			xOffset		= resGraphic->w * xOffsetPct / 100;
		if (yOffsetPct > 0)
			yOffset		= resGraphic->h * yOffsetPct / 100;
	
		// Find them reltative to the centre of the old image.
		xOffsetC 	= xOffset - (resGraphic->w >> 1);
		yOffsetC	= yOffset - (resGraphic->h >> 1);
	
		// Adjust the Offset for the rotation.
		// Use the distance from the centre multiplied by the angle
		if (rotation != 0.0)
		{
			distCentre  = (int)round(sqrt ((xOffsetC * xOffsetC) + (yOffsetC * yOffsetC)));
			xOffsetC 	= (int)round(sin(rotation) * distCentre);
			yOffsetC 	= (int)round(cos(rotation) * distCentre);
		}
		
		// Re-align the offset relative to the centre of the new image.
		xOffset 	= xOffsetC + (rotResGraphic->w >> 1);
		yOffset 	= yOffsetC + (rotResGraphic->h >> 1);
	}
		
	SDL_Rect src, dst;
	src.x=0;
	src.y=0;
	src.h=rotResGraphic->h;
	src.w=rotResGraphic->w;
	
	dst = src;
	dst.x=(short int)round(position.x) - xOffset;
	dst.y=(short int)round(position.y) - yOffset;
	
	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "pos (%d,%d), (%f,%f)", dst.x, dst.y, position.x - xOffset, position.y - yOffset); 
	
	#ifdef DRAW_BOUNDING
		Rect size(dst.x, dst.y, dst.x + dst.w, dst.y + dst.h);
		SDL_Colour Colour = {0xff, 0,0,0};
		Theme::drawRect(screen, Colour, size); 
	#endif
	
	SDL_BlitSurface(rotResGraphic, &src, screen, &dst);
	
}
	 

void Theme::playSound (SndRes ResourceID)
{
	// Exit if sound is disabled
	if (!Options::Instance()->getSoundEnabled())
		return;
	
	// Read in the sound from a file.
	// Might be worth caching sounds like graphics if they are used a lot
	Mix_Chunk* sound = Theme::getSound(ResourceID);
	
	if (!sound)
	{
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Sound for resource %d not found", ResourceID);
		return;
	}
	
	// Set the volume for the sound effect
	Mix_VolumeChunk(sound, Options::Instance()->getEffectVolume());	
	
	// Start the sound playing on any available channel
	// and only play for a single loop
	if (Mix_PlayChannel(-1, sound, 0) < 0)
		Log::Instance()->log(LOG_THRESHOLD, SV_WARNING, "Problem playing sound for resource %d", ResourceID);
		
}

void Theme::pauseSounds(bool pause)
{
	// Pause or unpause all channels running
	if (pause)
		Mix_Pause(-1);
	else
		Mix_Resume(-1);
}

void Theme::playThemeMusic()
{
	
	if (this->musicFilenames.Size() == 0)
		return;
	
	this->currentMusic.Forth();

	// Reset to the beginning of the music list	
	if (!this->currentMusic.Valid())
		this->currentMusic.Start();
	
	// Play the music		
	Theme::playMusic(this->currentMusic.Item());
	
	// Add the callback so the next track is played
	Mix_HookMusicFinished(&musicFinished);
	 
}

void Theme::playMusic(const char* filename)
{
	
	// Exit if sound is disabled
	if (!Options::Instance()->getSoundEnabled())
		return;
	
	Theme::stopMusic();
	
	// Load up the music before we start playing it.
	music=Mix_LoadMUS(filename);
	if(!music)
	{
	    Log::Instance()->die(2, SV_FATALERROR, "Mix_LoadMUS: [FAILED LOAD %s] %s\n", filename, Mix_GetError());
	    return;
	}
	
	// Set the volume
	Mix_VolumeMusic(Options::Instance()->getMusicVolume());
	
	// play music 
	if(Mix_PlayMusic(music,0)==-1)
	    Log::Instance()->die(2, SV_FATALERROR, "Mix_PlayMusic: [FAILED LOAD] %s\n", Mix_GetError());
	
}

void Theme::pauseMusic(bool pause)
{
	if (pause)
		Mix_PauseMusic();
	else
		Mix_ResumeMusic();
}

void Theme::stopMusic()
{
	if (music)
	{
		Mix_HaltMusic();
		Mix_FreeMusic(music);
		music=NULL; // so we know we freed it.	
	}
}


///////////////////////////////////////////////////////////////////
// General drawing functions
///////////////////////////////////////////////////////////////////

void Theme::vertGradient(SDL_Surface * surf, SDL_Rect dest, SDL_Color c1, SDL_Color c2)
{
     int y, width, height;
     Uint8 r, g, b;
     //SDL_Rect dest;
     Uint32 pixelcolor;

     width = dest.w;//  surf->w;
     height = dest.h; //surf->h;

     for (y = 0; y < height; y++)
     {
       r = (c2.r * y / height) + (c1.r * (height - y) / height);
       g = (c2.g * y / height) + (c1.g * (height - y) / height);
       b = (c2.b * y / height) + (c1.b * (height - y) / height);

       //dest.x = 0;
       dest.y += 1;
       dest.w = width;
       dest.h = 1;

       pixelcolor = SDL_MapRGB(surf->format, r, g, b);

       SDL_FillRect(surf, &dest, pixelcolor);
     }
}

void Theme::drawArc(SDL_Surface* surf, Uint32 colour, Point centre, Point startPos, Point endPos, Rotation rot)
{
	int radius = (int)centre.distanceFrom(startPos);
	
	Point startDiff = startPos;
	startDiff -= centre;
	double startAngle = quadrantise(startDiff.x, startDiff.y, false);
	
	Point endDiff = endPos;
	endDiff -= centre;
	double endAngle = quadrantise(endDiff.x, endDiff.y, false);
	
	Theme::drawArc(surf, colour, centre, startAngle, endAngle, radius, rot);
	
}

void Theme::drawArc(SDL_Surface* surf, Uint32 colour, Point centre, double startAngle, double endAngle, double radius, Rotation rot)
{
	double aStep = 0.0;            // Angle Step (rad)
    double a = 0.0;                // Current Angle (rad)
    double minAngle = 0.0;
    double maxAngle = 0.0;
    int x_last, x_next, y_last, y_next;
    int x,y;

	// Adjust the smallest angle if the arc crosses the zero boundary
	// this saves having to cross the 2PI mark
	if (rot == ROT_CLOCKWISE && startAngle < endAngle)
		startAngle += 2*M_PI;		
    else if(rot == ROT_ANTI_CLOCKWISE && endAngle < startAngle)
   		endAngle += 2*M_PI;
   	
   	// Now the angles are correct then move from the smallest angle to the largest
   	if (startAngle < endAngle)
   	{
   		minAngle = startAngle;
   		maxAngle = endAngle;
   	}
   	else
   	{
   		minAngle = endAngle;
   		maxAngle = startAngle;
   	}
   		
	aStep = M_PI / 180;
	
	// Cache the start x and y positions
	x = (int)centre.x;
	y = (int)centre.y;

    x_last = (int)round(x + cos(minAngle) * radius);
    y_last = (int)round(y - sin(minAngle) * radius);

    for(a=minAngle + aStep; a <= maxAngle; a += aStep)
    {
      x_next = x + (int)round(cos(a) * radius);
      y_next = y - (int)round(sin(a) * radius);
      Theme::drawLine(surf, colour, x_last, y_last, x_next, y_next);
      x_last = x_next;
      y_last = y_next;
    }
}

void Theme::drawCircle(SDL_Surface* surf, Uint32 colour, Point centre, int radius)
{
	int x = 0;
    int y = radius;
    int p = (5 - radius*4)/4;
    	// Cache the start x and y positions
	int xCentre = (int)centre.x;
	int yCentre = (int)centre.y;

    Theme::circlePoints(surf, colour, xCentre, yCentre, x, y);
    while (x < y) {
        x++;
        if (p < 0) {
            p += 2*x+1;
        } else {
            y--;
            p += 2*(x-y)+1;
        }
        Theme::circlePoints(surf, colour, xCentre, yCentre, x, y);
    }
        
	/*
	 * Old and slow method
	double aStep = 0.0;            // Angle Step (rad)
    double a = 0.0;                // Current Angle (rad)
    int x_last, x_next, y_last, y_next;
    int x,y;

	aStep = M_PI / 180;
	
	// Cache the start x and y positions
	x = (int)centre.x;
	y = (int)centre.y;

    x_last = (int)round(x + radius);
    y_last = (int)round(y);

    for(a=0 + aStep; a <= 360; a += aStep)
    {
      x_next = x + (int)round(cos(a) * radius);
      y_next = y - (int)round(sin(a) * radius);
      Theme::drawLine(surf, colour, x_last, y_last, x_next, y_next);
      x_last = x_next;
      y_last = y_next;
    }
    */
}

void Theme::circlePoints(SDL_Surface* surf, Uint32 colour, int cx, int cy, int x, int y)
{
    if (x == 0) {
        putPixel(surf, cx, cy + y, colour);
        putPixel(surf, cx, cy - y, colour);
        putPixel(surf, cx + y, cy, colour);
        putPixel(surf, cx - y, cy, colour);
    } else 
    if (x == y) {
    	putPixel(surf, cx + x, cy + y, colour);
    	putPixel(surf, cx - x, cy + y, colour);
    	putPixel(surf, cx + x, cy - y, colour);
    	putPixel(surf, cx - x, cy - y, colour);
    } else 
    if (x < y) {
    	putPixel(surf, cx + x, cy + y, colour);
    	putPixel(surf, cx - x, cy + y, colour);
    	putPixel(surf, cx + x, cy - y, colour);
    	putPixel(surf, cx - x, cy - y, colour);
    	
    	putPixel(surf, cx + y, cy + x, colour);
    	putPixel(surf, cx - y, cy + x, colour);
    	putPixel(surf, cx + y, cy - x, colour);
    	putPixel(surf, cx - y, cy - x, colour);
    }
}

void Theme::drawDisc(SDL_Surface* surf, Uint32 colour, Point centre, int radius)
{
	int x,y;
    int x_comp, y_comp;
    double r2 = radius * radius;
    
	// Cache the start x and y positions
	x = (int)centre.x;
	y = (int)centre.y;

	// Start at the top of the disc i.e. y = radius
	// work our way down to the centre a pixel at a time and calculate the x component
	// then draw a horizonal line to at y and -y within the bounds of x, -x	
	for (y_comp = radius; y_comp >=0; y_comp--)
	{
		x_comp = (int)round(sqrt(r2 - y_comp * y_comp));
		
		Theme::drawLine(surf, colour, x - x_comp, y + y_comp, x + x_comp, y + y_comp);
      	Theme::drawLine(surf, colour, x - x_comp, y - y_comp, x + x_comp, y - y_comp);
	}
}	

void Theme::drawLine(SDL_Surface* surf, Uint32 colour, Point startPos, Point endPos)
{
	Theme::drawLine(surf, colour, (int)startPos.x, (int)startPos.y, (int)endPos.x, (int)endPos.y);
}

void Theme::drawLine(SDL_Surface* surf, Uint32 colour, int x, int y, int x2, int y2)
{
	bool yLonger=false;
	int shortLen=y2-y;
	int longLen=x2-x;
	if (abs(shortLen)>abs(longLen)) {
		int swap=shortLen;
		shortLen=longLen;
		longLen=swap;				
		yLonger=true;
	}
	int decInc;
	if (longLen==0) decInc=0;
	else decInc = (shortLen << 16) / longLen;

	if (yLonger) {
		if (longLen>0) {
			longLen+=y;
			for (int j=0x8000+(x<<16);y<=longLen;++y)
			{
				putPixel(surf,j >> 16, y, colour);	
				j+=decInc;
			}
			return;
		}
		longLen+=y;
		for (int j=0x8000+(x<<16);y>=longLen;--y)
		{
			putPixel(surf,j >> 16, y, colour);	
			j-=decInc;
		}
		return;	
	}

	if (longLen>0)
	{
		longLen+=x;
		for (int j=0x8000+(y<<16);x<=longLen;++x)
		{
			putPixel(surf, x, j >> 16, colour);
			j+=decInc;
		}
		return;
	}
	longLen+=x;
	for (int j=0x8000+(y<<16);x>=longLen;--x)
	{
		putPixel(surf, x, j >> 16, colour);
		j-=decInc;
	}
}

void Theme::drawRect(SDL_Surface* surf, Uint32 colour, Point topLeft, Point bottomRight)
{
	Theme::drawLine(surf, colour, (int)topLeft.x, (int)topLeft.y, (int)bottomRight.x, (int)topLeft.y);
	Theme::drawLine(surf, colour, (int)bottomRight.x, (int)topLeft.y, (int)bottomRight.x, (int)bottomRight.y);
	Theme::drawLine(surf, colour, (int)topLeft.x, (int)bottomRight.y, (int)bottomRight.x, (int)bottomRight.y);
	Theme::drawLine(surf, colour, (int)topLeft.x, (int)topLeft.y, (int)topLeft.x, (int)bottomRight.y);
}

void Theme::drawRect(SDL_Surface* surf, Uint32 colour, Rect size)
{
	Theme::drawRect(surf, colour, size.topLeft, size.bottomRight);	
}

SDL_Surface* Theme::newsurf_fromsurf(SDL_Surface* surf, int width, int height)
{
	SDL_Surface* newsurf;

	if(surf->format->BytesPerPixel <= 0 || surf->format->BytesPerPixel > 4)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Create surface. Unsupported Surface bit depth for transform");
		return NULL;
    }
      
	newsurf = SDL_CreateRGBSurface(surf->flags, width, height, surf->format->BitsPerPixel,
	surf->format->Rmask, surf->format->Gmask, surf->format->Bmask, surf->format->Amask);
	if(!newsurf)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Create surface failed %s", SDL_GetError());
		return NULL; 
    }

	/* Copy palette, colorkey, etc info */
	if(surf->format->BytesPerPixel==1 && surf->format->palette)
		SDL_SetColors(newsurf, surf->format->palette->colors, 0, surf->format->palette->ncolors);
	if(surf->flags & SDL_SRCCOLORKEY)
		SDL_SetColorKey(newsurf, (surf->flags&SDL_RLEACCEL)|SDL_SRCCOLORKEY, surf->format->colorkey);

	return newsurf;
}
 
///////////////////////////////////////////////////////////////////
// Private Methods
///////////////////////////////////////////////////////////////////

Mix_Chunk* Theme::getSound(SndRes sndID)
{
	// Search the cache for the sound
	if (sounds[sndID] != NULL)
		return sounds[sndID];
		
	// Check if there is a filename for this resource just to make sure
	if (soundFilenames[sndID] == NULL)
		Log::Instance()->die(1, SV_FATALERROR, "Theme::getSound no filename found for resouce %d", sndID);
	
	// Load the sound into the cache
	Mix_Chunk* snd = Mix_LoadWAV(soundFilenames[sndID]);
	if(!snd)
	    Log::Instance()->die(1, SV_FATALERROR, "Theme::getSound Mix_LoadWAV FAILED Loading (%s) Error %s\n", soundFilenames[sndID], Mix_GetError());
	
	return (sounds[sndID] = snd);
	
}

Font* Theme::getFont(FontRes fontID)
{
	// Search the cache for the graphic
	if (fonts[fontID] != NULL)
		return fonts[fontID];
	
	// Check if there is a filename for this resource just to make sure
	if (fontFilenames[fontID] == NULL)
		Log::Instance()->die(1, SV_FATALERROR, "Theme::getFont no filename found for resouce");
	
	// Draw the contents of each control onto the menu
	DListIterator<Font*> ctrlIter = fontsList.GetIterator();
	ctrlIter.Start();
	while (ctrlIter.Valid())
	{
		if (strcmp(ctrlIter.Item()->fontName(), fontFilenames[fontID]) == 0)
		{
			fonts[fontID] = ctrlIter.Item();
			return fonts[fontID];
		}
		ctrlIter.Forth();	
	}
	
	// Haven't found the font already loaded so try to load it now
	Font* newfont = new Font(fontFilenames[fontID]);
	fontsList.Append(newfont);
	fonts[fontID] = newfont;
	return newfont;
}

SDL_Surface* Theme::getGraphic(GfxRes resourceID)
{
	// Search the cache for the graphic
	if (graphics[resourceID] != NULL)
		return graphics[resourceID];

	// Check if there is a filename for this resource just to make sure
	if (graphicFilenames[resourceID] == NULL)
		Log::Instance()->die(1, SV_FATALERROR, "Theme::getGraphic no filename found for resouce %d", resourceID);
		
	// Cache Item not found so load it into the cache and return it
	switch (resourceID)
	{	
		case GFX_BACKGROUND:
			graphics[resourceID] = IMG_Load(graphicFilenames[resourceID]);
	
			if (graphics[resourceID] == NULL)
			{
	            Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Theme::getGraphic file %s", graphicFilenames[resourceID]);
				Log::Instance()->die(1, SV_FATALERROR, "Theme::getGraphic unable to load file %s", graphicFilenames[resourceID]);
            }
			return graphics[resourceID];
		default:
			return (graphics[resourceID] = Theme::loadTransparentBitmap(graphicFilenames[resourceID]));
	}
	return NULL;
}

SDL_Surface* Theme::getRotatedGraphic(GfxRes resourceID, float rotation, SDL_Surface* resGraphic)
{
	int roundRotation = (int)(rotation*100);
	// Draw the contents of each control onto the menu
	DListIterator<RotatedGfx*> rotGfxIter = this->rotatedGraphics.GetIterator();
	rotGfxIter.Start();
	while (rotGfxIter.Valid())
	{
		if (rotGfxIter.Item()->graphic == resourceID && rotGfxIter.Item()->rotation == roundRotation)
		{
			return rotGfxIter.Item()->surface;
		}
		rotGfxIter.Forth();	
	}
	
	// Haven't found the rotated graphic so load it and add it to the list
	RotatedGfx* rotResGraphic = new RotatedGfx;
	rotResGraphic->graphic = resourceID;
	rotResGraphic->rotation = roundRotation;
	
	rotResGraphic->surface = Theme::rotate(resGraphic, degrees(rotation));
		
	this->rotatedGraphics.Append(rotResGraphic);
	return rotResGraphic->surface;
}

SDL_Surface* Theme::loadTransparentBitmap(const char* filename)
{
	
	SDL_Surface* surface = IMG_Load(filename);
	
	if (surface == NULL)
	{
    	Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "Theme::loadTransparentBitmap file %s", filename);
    	Log::Instance()->die(1, SV_FATALERROR, "Theme::loadTransparentBitmap unable to load file %s", filename);
	}

	// Get the colour at (0,0) and use this as the blank colour.
    Uint32 blankColour = getPixel(surface, 0, 0);

    // Set the transparency colour to the blank colour above.
    if (SDL_SetColorKey (surface, SDL_SRCCOLORKEY, blankColour))
    	Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Theme::loadTransparentBitmap Unable to set transparency on file %s", filename);
  
    return surface;
}

SDL_Surface* Theme::rotate(SDL_Surface* surf, float angle)
{
	SDL_Surface* newsurf;

	double radangle, sangle, cangle;
	double x, y, cx, cy, sx, sy;
	int nxmax,nymax;
	Uint32 bgcolor;

	if(surf->format->BytesPerPixel <= 0 || surf->format->BytesPerPixel > 4)
    {
        Log::Instance()->log(LOG_THRESHOLD, SV_ERROR, "Unsupported surface bit depth for transform");
        return NULL;
    }
		
    if(!(((int)angle)%90))
    {
        SDL_LockSurface(surf);
        newsurf = rotate90(surf, (int)angle);
        SDL_UnlockSurface(surf);
        if(!newsurf) return NULL;
        return newsurf;
    }
        
	radangle = angle*.01745329251994329;
	sangle = sin(radangle);
	cangle = cos(radangle);

	x = surf->w;
	y = surf->h;
	cx = cangle*x;
	cy = cangle*y;
	sx = sangle*x;
	sy = sangle*y;
    nxmax = (int)(max(max(max(fabs(cx+sy), fabs(cx-sy)), fabs(-cx+sy)), fabs(-cx-sy)));
	nymax = (int)(max(max(max(fabs(sx+cy), fabs(sx-cy)), fabs(-sx+cy)), fabs(-sx-cy)));

	newsurf = newsurf_fromsurf(surf, nxmax, nymax);
	if(!newsurf) return NULL;

	/* get the background color */
	if(surf->flags & SDL_SRCCOLORKEY)
	{
		bgcolor = surf->format->colorkey;
	}
	else
	{
		switch(surf->format->BytesPerPixel)
		{
		case 1: bgcolor = *(Uint8*)surf->pixels; break;
		case 2: bgcolor = *(Uint16*)surf->pixels; break;
		case 4: bgcolor = *(Uint32*)surf->pixels; break;
		default: /*case 3:*/
#if SDL_BYTEORDER == SDL_LIL_ENDIAN
			bgcolor = (((Uint8*)surf->pixels)[0]) + (((Uint8*)surf->pixels)[1]<<8) + (((Uint8*)surf->pixels)[2]<<16);
#else
			bgcolor = (((Uint8*)surf->pixels)[2]) + (((Uint8*)surf->pixels)[1]<<8) + (((Uint8*)surf->pixels)[0]<<16);
#endif
		}
		bgcolor &= ~surf->format->Amask;
	}

	SDL_LockSurface(newsurf);
	SDL_LockSurface(surf);

	rotate(surf, newsurf, bgcolor, sangle, cangle);

	SDL_UnlockSurface(surf);
	SDL_UnlockSurface(newsurf);

	return newsurf;
}





SDL_Surface* Theme::rotate90(SDL_Surface *src, int angle)
{
    int numturns = (angle / 90) % 4;
    int dstwidth, dstheight;
    SDL_Surface* dst;
    char *srcpix, *dstpix, *srcrow, *dstrow;
    int srcstepx, srcstepy, dststepx, dststepy;
    int loopx, loopy;

    if(numturns<0)
        numturns = 4+numturns;
    if(!(numturns % 2))
    {
        dstwidth = src->w;
        dstheight = src->h;
    }
    else
    {
        dstwidth = src->h;
        dstheight = src->w;
    }
    
    dst = newsurf_fromsurf(src, dstwidth, dstheight);
    if(!dst)
        return NULL;
    SDL_LockSurface(dst);
    srcrow = (char*)src->pixels;
    dstrow = (char*)dst->pixels;
    srcstepx = dststepx = src->format->BytesPerPixel;
    srcstepy = src->pitch;
    dststepy = dst->pitch;
    
    switch(numturns)
    {
    /*case 0: we don't need to change anything*/
    case 1:
        srcrow += ((src->w-1)*srcstepx);
        srcstepy = -srcstepx;
        srcstepx = src->pitch;
        break;
    case 2:
        srcrow += ((src->h-1)*srcstepy) + ((src->w-1)*srcstepx);
        srcstepx = -srcstepx;
        srcstepy = -srcstepy;
        break;
    case 3:
        srcrow += ((src->h-1)*srcstepy);
        srcstepx = -srcstepy;
        srcstepy = src->format->BytesPerPixel;
        break;
    }

    switch(src->format->BytesPerPixel)
    {
    case 1:
        for(loopy=0; loopy<dstheight; ++loopy)
        {
            dstpix = dstrow; srcpix = srcrow;
            for(loopx=0; loopx<dstwidth; ++loopx)
            {
                *dstpix = *srcpix;
                srcpix += srcstepx; dstpix += dststepx;
            }
            dstrow += dststepy; srcrow += srcstepy;
        }break;
    case 2:
        for(loopy=0; loopy<dstheight; ++loopy)
        {
            dstpix = dstrow; srcpix = srcrow;
            for(loopx=0; loopx<dstwidth; ++loopx)
            {
                *(Uint16*)dstpix = *(Uint16*)srcpix;
                srcpix += srcstepx; dstpix += dststepx;
            }
            dstrow += dststepy; srcrow += srcstepy;
        }break;
    case 3:
        for(loopy=0; loopy<dstheight; ++loopy)
        {
            dstpix = dstrow; srcpix = srcrow;
            for(loopx=0; loopx<dstwidth; ++loopx)
            {
                dstpix[0] = srcpix[0]; dstpix[1] = srcpix[1]; dstpix[2] = srcpix[2];
                srcpix += srcstepx; dstpix += dststepx;
            }
            dstrow += dststepy; srcrow += srcstepy;
        }break;
    case 4:
        for(loopy=0; loopy<dstheight; ++loopy)
        {
            dstpix = dstrow; srcpix = srcrow;
            for(loopx=0; loopx<dstwidth; ++loopx)
            {
                *(Uint32*)dstpix = *(Uint32*)srcpix;
                srcpix += srcstepx; dstpix += dststepx;
            }
            dstrow += dststepy; srcrow += srcstepy;
        }
    }
	SDL_UnlockSurface(dst);
    return dst;
}


void Theme::rotate(SDL_Surface *src, SDL_Surface *dst, Uint32 bgcolor, double sangle, double cangle)
{
	int x, y, dx, dy;
    
	Uint8 *srcpix = (Uint8*)src->pixels;
	Uint8 *dstrow = (Uint8*)dst->pixels;
	int srcpitch = src->pitch;
	int dstpitch = dst->pitch;

	int cy = dst->h / 2;
	int xd = ((src->w - dst->w) << 15);
	int yd = ((src->h - dst->h) << 15);
    
	int isin = (int)(sangle*65536);
	int icos = (int)(cangle*65536);
   
	int ax = ((dst->w) << 15) - (int)(cangle * ((dst->w-1) << 15));
	int ay = ((dst->h) << 15) - (int)(sangle * ((dst->w-1) << 15));

	int xmaxval = ((src->w) << 16) - 1;
	int ymaxval = ((src->h) << 16) - 1;
    
	switch(src->format->BytesPerPixel)
	{
	case 1:
		for(y = 0; y < dst->h; y++)
		{
			Uint8 *dstpos = (Uint8*)dstrow;
			dx = (ax + (isin * (cy - y))) + xd;
			dy = (ay - (icos * (cy - y))) + yd;
			for(x = 0; x < dst->w; x++)
			{
				if(dx<0 || dy<0 || dx>xmaxval || dy>ymaxval) *dstpos++ = bgcolor;
				else *dstpos++ = *(Uint8*)(srcpix + ((dy>>16) * srcpitch) + (dx>>16));
				dx += icos; dy += isin;
			}
			dstrow += dstpitch;
		}break;
        case 2:
		for(y = 0; y < dst->h; y++)
		{
			Uint16 *dstpos = (Uint16*)dstrow;
			dx = (ax + (isin * (cy - y))) + xd;
			dy = (ay - (icos * (cy - y))) + yd;
			for(x = 0; x < dst->w; x++)
			{
				if(dx<0 || dy<0 || dx>xmaxval || dy>ymaxval) *dstpos++ = bgcolor;
				else *dstpos++ = *(Uint16*)(srcpix + ((dy>>16) * srcpitch) + (dx>>16<<1));
				dx += icos; dy += isin;
			}
			dstrow += dstpitch;
		}break;
	case 4:
		for(y = 0; y < dst->h; y++) {
			Uint32 *dstpos = (Uint32*)dstrow;
			dx = (ax + (isin * (cy - y))) + xd;
			dy = (ay - (icos * (cy - y))) + yd;
			for(x = 0; x < dst->w; x++) {
				if(dx<0 || dy<0 || dx>xmaxval || dy>ymaxval) *dstpos++ = bgcolor;
				else *dstpos++ = *(Uint32*)(srcpix + ((dy>>16) * srcpitch) + (dx>>16<<2));
				dx += icos; dy += isin;
			}
			dstrow += dstpitch;
		}break;
	default: /*case 3:*/
		for(y = 0; y < dst->h; y++) {
			Uint8 *dstpos = (Uint8*)dstrow;
			dx = (ax + (isin * (cy - y))) + xd;
			dy = (ay - (icos * (cy - y))) + yd;
			for(x = 0; x < dst->w; x++) {
				if(dx<0 || dy<0 || dx>xmaxval || dy>ymaxval)
				{
					dstpos[0] = ((Uint8*)&bgcolor)[0]; dstpos[1] = ((Uint8*)&bgcolor)[1]; dstpos[2] = ((Uint8*)&bgcolor)[2];
					dstpos += 3;
				}
				else {
					Uint8* srcpos = (Uint8*)(srcpix + ((dy>>16) * srcpitch) + ((dx>>16) * 3));
					dstpos[0] = srcpos[0]; dstpos[1] = srcpos[1]; dstpos[2] = srcpos[2];
					dstpos += 3;
				}
				dx += icos; dy += isin;
			}
			dstrow += dstpitch;
		}break;
	}
}

void Theme::resetGraphics()
{
	this->rotatedGraphics.DeleteAndRemove();
	for (int c=0; c<MAX_GRAPHICS; c++)
	{
		if (this->graphics[c] != NULL)
		{
			SDL_FreeSurface(this->graphics[c]);	
			this->graphics[c] = NULL;
		}
		delete[] this->graphicFilenames[c];
	}
			
}

void Theme::resetFonts()
{
	this->fontsList.DeleteAndRemove();
	for (int i=0; i < MAX_FONTS; i++)
	{
		this->fonts[i]=NULL;
		delete[] this->fontFilenames[i];	
	}
}

void Theme::resetSounds()
{
	for (int i=0; i < MAX_SOUNDS; i++)
	{
		if (this->sounds[i] != NULL)
		{
			Mix_FreeChunk(this->sounds[i]);
			this->sounds[i] = NULL;
		}
		delete[] this->soundFilenames[i];	
	}
}

void Theme::loadGraphics(xmlDocPtr doc, xmlNodePtr cur)
{
	xmlXPathObjectPtr xpathObj;
	xmlNodePtr current = NULL;
	GfxRes res = GFX_BUBBLE_RED;
	
	Theme::resetGraphics();
	
	xpathObj = searchDocXpath(doc, cur, "graphics/graphic");
    
    for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
    {
    	if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
    		continue;
    	
    	current = xpathObj->nodesetval->nodeTab[i];
    	 // Find the resource
		char* resourceIDText = (char*)xmlGetProp(current, (const xmlChar*)"id");
		if (resourceIDText != NULL || strcmp(resourceIDText, ""))
			res = mapGfxResourceID(resourceIDText);
		else
			Log::Instance()->die(1,SV_ERROR,"Theme: Graphic ResourceID not found\n");
		
		// Find the filename
		char* filenameText = (char*)xmlGetProp(current, (const xmlChar*)"src");
		if (filenameText == NULL || strcmp(filenameText, "") == 0)
			Log::Instance()->die(1,SV_ERROR,"Theme: Graphic ResourceFilename not found\n");
		
		char resourceFilename[512];
//		strcpy(resourceFilename, this->path);
//		strcat(resourceFilename, filenameText); 
		sprintf(resourceFilename, themePath, this->path, this->filename, filenameText);
		graphicFilenames[res] = strdup(resourceFilename);
    }
}

void Theme::loadFonts(xmlDocPtr doc, xmlNodePtr cur)
{
	xmlXPathObjectPtr xpathObj;
	xmlNodePtr current = NULL;
	FontRes res = FONT_DEFAULT;
	
	Theme::resetFonts();
	
	xpathObj = searchDocXpath(doc, cur, "fonts/font");
    
    for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
    {
    	if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
    		continue;
    	
    	current = xpathObj->nodesetval->nodeTab[i];
    	 // Find the resource
		char* resourceIDText = (char*)xmlGetProp(current, (const xmlChar*)"id");
		if (resourceIDText != NULL || strcmp(resourceIDText, ""))
			res = mapFontResourceID(resourceIDText);
		else
			Log::Instance()->die(1,SV_ERROR,"Theme: Font ResourceID not found\n");
		
		// Find the filename
		char* filenameText = (char*)xmlGetProp(current, (const xmlChar*)"src");
		if (filenameText == NULL || strcmp(filenameText, "") == 0)
			Log::Instance()->die(1,SV_ERROR,"Theme: Font ResourceFilename not found\n");
		
		char resourceFilename[512];
		//strcpy(resourceFilename, this->path);
		//strcat(resourceFilename, filenameText); 
		sprintf(resourceFilename, themePath, this->path, this->filename, filenameText);
		
		fontFilenames[res] = strdup(resourceFilename);
    }
}

void Theme::loadSounds(xmlDocPtr doc, xmlNodePtr cur)
{
	xmlXPathObjectPtr xpathObj;
	xmlNodePtr current = NULL;
	SndRes res = SND_FIREBULLET;
	
	Theme::resetSounds();
	
	xpathObj = searchDocXpath(doc, cur, "sounds/sound");
    
    for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
    {
    	if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
    		continue;
    	
    	current = xpathObj->nodesetval->nodeTab[i];
    	 // Find the resource
		char* resourceIDText = (char*)xmlGetProp(current, (const xmlChar*)"id");
		if (resourceIDText != NULL || strcmp(resourceIDText, ""))
			res = mapSndResourceID(resourceIDText);
		else
			Log::Instance()->die(1,SV_ERROR,"Theme: Sound ResourceID not found\n");
		
		// Find the filename
		char* filenameText = (char*)xmlGetProp(current, (const xmlChar*)"src");
		if (filenameText == NULL || strcmp(filenameText, "") == 0)
			Log::Instance()->die(1,SV_ERROR,"Theme: Sound ResourceFilename not found\n");
		
		char resourceFilename[512];
		sprintf(resourceFilename, themePath, this->path, this->filename, filenameText);
		
		soundFilenames[res] = strdup(resourceFilename);
    }
}

void Theme::loadMusic(xmlDocPtr doc, xmlNodePtr cur)
{
	xmlXPathObjectPtr xpathObj;
	xmlNodePtr current = NULL;
	
	this->musicFilenames.DeleteAndRemove();
	
	xpathObj = searchDocXpath(doc, cur, "music/track");
    
    for (int i=0; i < xpathObj->nodesetval->nodeNr; i++)
    {
    	if(xpathObj->nodesetval->nodeTab[i]->type != XML_ELEMENT_NODE)
    		continue;
    	
    	current = xpathObj->nodesetval->nodeTab[i];
		// Find the filename
		// Doesn't matter if the filename doesn't exist simply skip this one
		char* filenameText = (char*)xmlGetProp(current, (const xmlChar*)"src");
		if (filenameText == NULL || strcmp(filenameText, "") == 0)
			continue;
			
		char resourceFilename[512];
		sprintf(resourceFilename, themePath, this->path, this->filename, filenameText);
	
		// Only add music files if they exist
		if (fileExist(resourceFilename))
		{
			Log::Instance()->log(LOG_THRESHOLD, SV_DEBUG, "found music %s", resourceFilename);
			this->musicFilenames.Append(strdup(resourceFilename));
		}
    }
    
    this->currentMusic.Start();
}

void musicFinished()
{
	// Play the next track
	Theme::Instance()->playThemeMusic();	
}

