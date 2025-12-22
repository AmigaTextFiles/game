/***************************************************************************
                          csdl.h  -  description
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

#ifndef CSDL_H
#define CSDL_H

#include "SDL.h"

#include <string>

using namespace std;

/**
  *@author Marius
  */

class CSDL
{
  public: 
  CSDL();
  ~CSDL();

  /** Initalize the SDL Library */
  int init(int audio, int joystick);
  /** Initalize a video mode */
  int setVideoMode(int width, int height, int depth, int fullscreen);
  /** Load an image file (currently only .bmp files are supported) */
  SDL_Surface * loadImage(string filename);
  /** Load an image file (currently only .bmp files are supported) */
  SDL_Surface * loadImageAlpha(string filename);
  /** Load an image file (currently only .bmp files are supported) with color-key transparency */
  SDL_Surface * loadImage(string filename, int r, int g, int b);
  /** Draw an SDL_Surface on an other SDL_Surface */
  int drawSurface(SDL_Surface *surface, int x, int y, SDL_Surface *to = NULL);
  /** Draw part of an SDL_Surface onto an other SDL_Surface */
  int drawSurface(SDL_Surface *surface, int x, int y, int part_x, int part_y, int part_w, int part_h, SDL_Surface *to = NULL);
  /** Swap the buffers */
  int flush();
  /** Draw a black layer over the entire screen. Gives the illusion of fading. */
  int drawBlackLayer(Uint8 alpha);
  /** Free memory occupied by a SDL_Surface. */
  void disposeSurface(SDL_Surface *surface);
  /** Clear the screen with a color */
  void clearScreen(Uint32 color);
  /** Clean everything up */
  void cleanUp();
  /** Clip the screen... */
  void clip(int x, int y, int w, int h);
  /** Get the height of the screen */
  int getHeight();
  /** Get the width of the screen */
  int getWidth();
  /** Clear a part of the screen */
  void clearArea(int x, int y, int w, int h, Uint32 color);
  /** Toggle the fullscreen display */
  void toggleFullScreen();

  private:
  int mAudio;
  int mJoystick;
  int mWidth, mHeight, mDepth, mFullscreen;
  int mBlackSurfaceInfo;
  SDL_Surface *mScreen;
  SDL_Surface *mBlackSurface;
  SDL_Rect mDest, mSrc;
};

#endif
