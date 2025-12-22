/***************************************************************************
                          csdl.cpp  -  description
                             -------------------
    begin                : Sat Jun 14 2003
    copyright            : (C) 2003 by Marius Andra
    email                : marius@hot.ee
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <iostream>
 
#include "csdl.h"

CSDL::CSDL() {}
CSDL::~CSDL() {}

/** Initalize the SDL Library */
int CSDL::init(int audio, int joystick)
{
  cout << "Initializing SDL" << endl;
  if(SDL_Init(SDL_INIT_VIDEO) < 0)
  {
    cout << "ERROR! Unable to init SDL video: " << SDL_GetError() << endl;
    return 1;
  }

  mAudio = audio;
  if(audio == 1)
  {
    if(SDL_Init(SDL_INIT_VIDEO) < 0)
    {
      cout << "WARNING! Unable to init audio: " << SDL_GetError() << endl;
      mAudio = 0;
    }
  }

  mJoystick = joystick;
  if(joystick == 1)
  {
    if(SDL_Init(SDL_INIT_JOYSTICK) < 0)
    {
      cout << "WARNING! Unable to init joystick: " << SDL_GetError() << endl;
      mJoystick = 0;
    } else {
      cout << SDL_NumJoysticks() << " joysticks were found." << endl;
      if(SDL_NumJoysticks() > 0)
      {
        cout << "The names of the joysticks are:" << endl;

        for(int i=0;i<SDL_NumJoysticks();i++)
        {
          cout << "  " << SDL_JoystickName(i) << endl;
        }
      } else {
        mJoystick = 0;
      }
    }
  }
  return 0;
}

/** Initalize a video mode */
int CSDL::setVideoMode(int width, int height, int depth, int fullscreen)
{
  cout << "Initializing " << width << "x" << height << "x" << depth
      << " video mode" << (fullscreen?" at fullscreen":"") << endl;
//  mScreen = SDL_SetVideoMode(width, height, depth, SDL_SWSURFACE|(fullscreen?SDL_FULLSCREEN:0));
  mScreen = SDL_SetVideoMode(width, height, depth,
    SDL_HWSURFACE|SDL_DOUBLEBUF|(fullscreen?SDL_FULLSCREEN:0));

  if(mScreen == NULL)
  {
    cout << "ERROR! Unable to set video mode: " << SDL_GetError() << endl;
    return 1;
  }

  mWidth = width;
  mHeight = height;
  mDepth = depth;
  mFullscreen = fullscreen;
/*  
  // let's create the black surface used for the fake transparency effect.
  Uint32 rmask, gmask, bmask, amask;

  // SDL interprets each pixel as a 32-bit number, so our masks must depend
  // on the endianness (byte order) of the machine
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
    rmask = 0xff000000;
    gmask = 0x00ff0000;
    bmask = 0x0000ff00;
    amask = 0x000000fff;
#else
    rmask = 0x000000ff;
    gmask = 0x0000ff00;
    bmask = 0x00ff0000;
    amask = 0xff000000;
#endif

  mBlackSurface = SDL_CreateRGBSurface(SDL_HWSURFACE, width, height, 24, rmask, gmask, bmask, amask);
*/  
  mBlackSurface = loadImage("data/black.bmp");
  if(mBlackSurface == NULL)
  {
    cout << "Error creating black surface" << endl;
    mBlackSurfaceInfo = 0;
  } else {
    if(SDL_FillRect(mBlackSurface, NULL, 0x000000)==-1)
    {
      mBlackSurfaceInfo = 0;
    } else {
      mBlackSurfaceInfo = 1;
    }
  }
  cout << "mBlackSurfaceInfo: " << mBlackSurfaceInfo << endl;

  return 0;
}

/** Load an image file (currently only .bmp files are supported) */
SDL_Surface * CSDL::loadImage(string filename)
{
  SDL_Surface *temp, *image;
  temp = SDL_LoadBMP(filename.c_str());
  image = SDL_DisplayFormat(temp);
  SDL_FreeSurface(temp);
  return image;
}

/** Load an image file (currently only .bmp files are supported) */
SDL_Surface * CSDL::loadImageAlpha(string filename)
{
  SDL_Surface *temp, *image;
  temp = SDL_LoadBMP(filename.c_str());
  image = SDL_DisplayFormatAlpha(temp);
  SDL_FreeSurface(temp);
  return image;
}

/** Load an image file (currently only .bmp files are supported) with transparency */
SDL_Surface * CSDL::loadImage(string filename, int r, int g, int b)
{
  SDL_Surface *temp, *image;
  temp = SDL_LoadBMP(filename.c_str());
  SDL_SetColorKey(temp, SDL_SRCCOLORKEY, SDL_MapRGB(temp->format, r, g, b));
  image = SDL_DisplayFormat(temp);
  SDL_FreeSurface(temp);
  return image;
}

/** Draw an SDL_Surface on an other SDL_Surface */
int CSDL::drawSurface(SDL_Surface *surface, int x, int y, SDL_Surface *to)
{
  mDest.x = x;
  mDest.y = y;
  return SDL_BlitSurface(surface, NULL, (to==NULL)?mScreen:to, &mDest)==-1;
}

/** Draw part of an SDL_Surface onto an other SDL_Surface */
int CSDL::drawSurface(SDL_Surface *surface, int x, int y, int part_x, int part_y, int part_w, int part_h, SDL_Surface *to)
{
  mDest.x = x;
  mDest.y = y;
  mSrc.x = part_x;
  mSrc.y = part_y;
  mSrc.w = part_w;
  mSrc.h = part_h;
  return SDL_BlitSurface(surface, &mSrc, (to==NULL)?mScreen:to, &mDest)==-1;
}

/** Swap the buffers */
int CSDL::flush()
{
  return SDL_Flip(mScreen)==-1;
}

/** Draw a black layer over the entire screen. Gives the illusion of fading. */
int CSDL::drawBlackLayer(Uint8 alpha)
{
  if(mBlackSurfaceInfo)
  {
    SDL_SetAlpha(mBlackSurface, SDL_SRCALPHA|SDL_RLEACCEL, alpha);
    return SDL_BlitSurface(mBlackSurface, NULL, mScreen, NULL)==-1;
  }
  return 0;
}

/** Free memory occupied by a SDL_Surface. */
void CSDL::disposeSurface(SDL_Surface *surface)
{
  SDL_FreeSurface(surface);
}

/** Clear the screen with a color */
void CSDL::clearScreen(Uint32 color)
{
  SDL_FillRect(mScreen, NULL, color);
}

/** Clean everything up */
void CSDL::cleanUp()
{
  SDL_Quit();
}

/** Clip the screen... */
void CSDL::clip(int x, int y, int w, int h)
{
	mDest.x = x; mDest.y = y; mDest.w = w; mDest.h = h;
	SDL_SetClipRect(mScreen, &mDest);
}

/** Get the width of the screen */
int CSDL::getWidth()
{
	return mWidth;
}

/** Get the height of the screen */
int CSDL::getHeight()
{
	return mHeight;
}

/** Clear a part of the screen */
void CSDL::clearArea(int x, int y, int w, int h, Uint32 color)
{
	mDest.x = x; mDest.y = y; mDest.w = w; mDest.h = h;
  SDL_FillRect(mScreen, &mDest, color);
}

/** Toggle the fullscreen display */
void CSDL::toggleFullScreen()
{
  SDL_WM_ToggleFullScreen(mScreen);
}
