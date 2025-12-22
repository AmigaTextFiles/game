/***************************************************************************
                          citem.cpp  -  description
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

#define Y_ACCEL 490.0

#include "citem.h"

CItem::CItem() {}
CItem::~CItem() {}

/** Initalize the item. */
int CItem::init(CSDL *sdl, CItemBase *base, CTileLayer *tileLayer, float x, float y, int grav, string effect, int value, int respawn)
{
	mBase = base;
	mSDL = sdl;
	mAnimFrames = mBase->getFrames();
	mDelay = mBase->getDelay();
	mAnimFrame = 0;
	mLastAnim = 0;
	mThere = 1;
	mTiles = tileLayer;
	mRespawn = respawn;
	mHeight = mBase->getHeight();
	mWidth = mBase->getWidth();
	mGravity = (grav == -1 ? mBase->hasGravity() : grav);
	mX = x;
	mY = y;
	mNewY = mY;
	mEffect = effect;
	mValue = value;
	mVy = 0;
	return 0;
}

/** Update the item: if it has gravity applied to it, move it down. */
void CItem::update(float dt)
{
	if(mThere)
	{
	  float yf = mVy*dt + Y_ACCEL*dt*dt/2;
	  int v = checkVerticalCollision(yf);
	  if(v) { mVy=0; } else { mVy+=Y_ACCEL*dt; mY+=yf; }
	  if(v && mNewY != -1) {mY=mNewY;}
	}	else if(mRespawn != -1) {
    if(SDL_GetTicks()-mPickUpTime > (Uint32)mRespawn)
		{
     	mThere = 1;
		}
	}
}

/** Render the item. */
void CItem::render(float offsetX, float offsetY)
{
	Uint32 sdlgt = SDL_GetTicks();
  mAnimFrame += (sdlgt - mLastAnim)/(mDelay);
  mAnimFrame %= mAnimFrames;
  mLastAnim = sdlgt - (sdlgt - mLastAnim)%(mDelay);
  mBase->render((int)(mX-offsetX), (int)(mY-offsetY), mAnimFrame);
}

/** Clean up */
void CItem::dispose()
{

}

/** Check if the item collides with the tiles vertically. */
int CItem::checkVerticalCollision(float yf)
{
  for(int i=(int)(mX+1)/16;i<=(int)(mX+mWidth-1)/16;i++)
  {
    if(yf<0)
    {
      for(int j=(int)(mY+1)/16;j>=(int)(mY+yf-1)/16;j--)
      {
        if(mTiles->getTile(i,j)>=0) { mNewY=(j+1)*16; return 1; }
      }
    } else {
      for(int j=(int)(mY+mHeight-1)/16;j<=(int)(mY+mHeight+yf+1)/16;j++)
      {
        if(mTiles->getTile(i,j)>=0) { mNewY=(j-1)*16-mHeight+15; return 2; }
      }
    }
  }
  return 0;
}

/** Is the item still in the level? */
int CItem::isThere()
{
	return mThere;
}

/** Return the X coordinate of the item */
float CItem::getX()
{
	return mX;
}

/** Return the Y coordinate of the item */
float CItem::getY()
{
	return mY;
}

/** Return the width of the item */
int CItem::getWidth()
{
	return mWidth;
}

/** Return the height of the item */
int CItem::getHeight()
{
	return mHeight;
}

/** Pick up the item */
int CItem::pickUp()
{
	if(mRespawn != 0)
	{
		mThere = 0;
		mPickUpTime = SDL_GetTicks();
	}
	return 0;
}

/** Return the name of the type of item */
string CItem::getName()
{
	return mBase->getName();
}

/** Return the value of the item */
int CItem::getValue()
{
	return mValue;
}

/** Return the effect the item has */
string CItem::getEffect()
{
	return mEffect;
}
