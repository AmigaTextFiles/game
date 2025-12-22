/***************************************************************************
                          ccreature.cpp  -  description
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

#define X_ACCEL 490.0
#define Y_ACCEL 490.0

#include <iostream>
#include <math.h>
 
#include "ccreature.h"

CCreature::CCreature() {}
CCreature::~CCreature() {}

/** Initalize the creature */
int CCreature::init(CSDL *sdl, CCreatureBase *creatureBase, int x, int y, int direction, int player, CTileLayer *tiles, float speed)
{
  mX = x;
  mY = y;
  mVx = 0;
  mVy = 0;
  mBase = creatureBase;
  mWidth = mBase->getWidth();
  mHeight = mBase->getHeight();
  mSDL = sdl;
  mDirection = direction;
  mPlayer = player;
  mTiles = tiles;
  mSpecial = 0;
  mSpeed = speed;
	mDead = 0;
  mAlive = 1;
  mMoving = 1;
  mJumping = 0;
  mLastDirection = 0;
  mLastWalk = 0;
  mTurnStart = 0;
  mTurnDir = 0;
  mWalkFrame = 0;
  if(mBase->hasTurn())
  {
    mTurnFrames = mBase->getTurnFrames(0);
    mTurnDelay = mTurnFrames*60;
    if(mTurnDelay < 80) mTurnDelay = 80;
  }
	mSpecialAbilities = new int[SPECIAL_ABILITY_COUNT];
	for(int i=0;i<SPECIAL_ABILITY_COUNT;i++)
  {
    mSpecialAbilities[i] = -1;
  }
  
  return 0;
}

/** Draw the creature on the screen */
void CCreature::render(int offsetX, int offsetY)
{
  if(mBase->hasTurn() && SDL_GetTicks() - mTurnStart < (Uint32)mTurnDelay)
  {
    if(mTurnFrames > 1)
    {
      if(mTurnDir>0)
      {
        mBase->draw((int)(mX-offsetX), int(mY-offsetY), TURN, (SDL_GetTicks() - mTurnStart)/60, mSpecial);
      } else if(mTurnDir<0) {
        mBase->draw((int)(mX-offsetX), int(mY-offsetY), TURN, mTurnFrames - 1 - (SDL_GetTicks() - mTurnStart)/60, mSpecial);
      } else {
        mBase->draw((int)(mX-offsetX), int(mY-offsetY), TURN, mTurnFrames/2, mSpecial);
      }
    } else {
      mBase->draw((int)(mX-offsetX), int(mY-offsetY), TURN, 0, mSpecial);
    }
  } else if(mDirection == -1) {
    Uint32 sdlgt = SDL_GetTicks();
    if(mVx > -3.5*mSpeed)
    {
      mWalkFrame = 0;
      mLastWalk = sdlgt;
    } else {
      mWalkFrame += (sdlgt - mLastWalk)/((int)(60.0/mSpeed));
      mWalkFrame %= mBase->getWalkLeftFrames(mSpecial);
      mLastWalk = sdlgt - (sdlgt - mLastWalk)%((int)(60.0/mSpeed));
    }
    mBase->draw((int)(mX-offsetX), int(mY-offsetY), WALK_LEFT, mWalkFrame, mSpecial);
  } else if(mDirection == 1) {
    Uint32 sdlgt = SDL_GetTicks();
    if(mVx < 3.5*mSpeed)
    {
      mWalkFrame = 0;
      mLastWalk = sdlgt;
    } else {
      mWalkFrame += (sdlgt - mLastWalk)/((int)(60.0/mSpeed));
      mWalkFrame %= mBase->getWalkRightFrames(mSpecial);
      mLastWalk = sdlgt - (sdlgt - mLastWalk)%((int)(60.0/mSpeed));
    }
    mBase->draw((int)(mX-offsetX), int(mY-offsetY), WALK_RIGHT, mWalkFrame, mSpecial);
  }
}

/** Move the creature. Gets called 100 times in a second. */
int CCreature::update(float dt, CItem *items, int numItems, CCreature *creatures, int numCreatures, int me)
{
  if(mAlive)
  {
    mNewX = -1; mNewY = -1;
    float xf = mVx*dt + mMoving*((float)mDirection)*X_ACCEL*mSpeed*dt*dt/2;
    float yf = mVy*dt + Y_ACCEL*dt*dt/2;

    if(mJumping==1 && checkVerticalCollision(yf)==2)
    {
      mVy=-250.0-(mVx>0?mVx:-mVx)*0.3;
      yf = mVy*dt + Y_ACCEL*dt*dt/2;
    }

    int h = checkHorizontalCollision(xf);
    int v = checkVerticalCollision(yf);
		int hh = 0;

		int asd;
		for(int i=0;i<numCreatures;i++)
		{
      if(i != me && creatures[i].isAlive())
			{
				asd = this->collidesWith(&creatures[i], xf, yf);
       	if(asd == 1 && mVx * creatures[i].getVx() > 0.1)
				{
					if(mVx < 0 && creatures[i].getX() < mX)
					{
						mVx = 0;
	 					return 0;
					} else if(mVx > 0 && mX < creatures[i].getX()) {
						mVx = 0;
						return 0;
					}
       	} else if(asd == 1) {
         	if(!mPlayer) this->turn(); else this->halt();
					if(!creatures[i].isPlayer() && fabs(creatures[i].getVx()) > 0.1) creatures[i].turn(); else creatures[i].halt();
					hh = 1;
				} else if(asd == 2) {
         	mVy=(mJumping?-200:0)-100.0-(mVx>0?mVx:-mVx)*0.3;
					return 0;
				} else if(asd == 3) {
					v = 1;
				}
			}
		}

		if(h || hh)
		{
			mVx=0;
		} else {
			mVx+=X_ACCEL*dt*mMoving*mDirection;
			mVx-=mVx*3.3*dt/mSpeed;
			mX+=xf;
		}

    if(v)
		{
			mVy=0;
		} else {
			mVy+=Y_ACCEL*dt;
			mY+=yf;
		}
  
    if(!mPlayer && h)
    {
      mLastDirection = mDirection;
      mTurnStart = SDL_GetTicks();
      mDirection = -mDirection;
    }

    if(h && mNewX!=-1) {mX=mNewX;}
    if(v && mNewY!=-1) {mY=mNewY;}

    if(mY>=mTiles->getHeight()*16-mHeight)
    {
      mAlive=0;
      mVx=((rand()%2==0)?-1:+1)*100;
      mVy=-200;
		}

		for(int i=0;i<numItems;i++)
		{
     	if(items[i].isThere() && this->collidesWith(&items[i], xf, yf))
			{
       	items[i].pickUp();
				int special = mBase->getSpecialID(items[i].getName());
				this->doSpecial(items[i].getEffect(),items[i].getValue());
				if(special != -1)
				{
         	mSpecial = special+1;
				}
			}
		}
  } else {
    mVy+=600*dt;
    mX+=mVx*dt;
    mY+=mVy*dt;
    if(mY>mTiles->getHeight()*16) mDead=1;
	}
  
  return 0;
}

/** Check if the item collides with the tiles horizontally. */
int CCreature::checkHorizontalCollision(float xf)
{
  for(int i=(int)(mY+1)/16;i<=(int)(mY+mHeight-1)/16;i++)
  {
    if(xf<0)
    {
      for(int j=(int)(mX+1)/16;j>=(int)(mX+xf-1)/16;j--)
      {
        if(mTiles->getTile(j,i)>=0) { mNewX=(j+1)*16; return 1; }
      }
    } else {
      for(int j=(int)(mX+mWidth-1)/16;j<=(int)(mX+mWidth+xf+1)/16;j++)
      {
        if(mTiles->getTile(j,i)>=0) { mNewX=(j-1)*16-mWidth+15; return 2; }
      }
    }
  }
  return 0;
}

/** Check if the creature collides with the tiles vertically. */
int CCreature::checkVerticalCollision(float yf)
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

/** Cleanup */
void CCreature::dispose()
{
	delete [] mSpecialAbilities;
}

/** Return the X coordinate of the creature */
float CCreature::getX()
{
  return mX;
}

/** Return the Y coordinate of the creature */
float CCreature::getY()
{
  return mY;
}

/** Move the creature left */
void CCreature::moveLeft()
{
  mLastDirection = mDirection;
  mDirection = -1;
  if(mLastDirection != mDirection)
  {
    mTurnStart = SDL_GetTicks();
    mTurnDir = -1;
  }
  mMoving = 1;
}

/** Move the creature right */
void CCreature::moveRight()
{
  mLastDirection = mDirection;
  mDirection = 1;
  if(mLastDirection != mDirection)
  {
    mTurnStart = SDL_GetTicks();
    mTurnDir = 1;
  }
  mMoving = 1;
}

/** Move the creature left AND right */
void CCreature::moveLeftRight()
{
  mVx-=mVx*0.033/mSpeed; 
  mTurnStart = SDL_GetTicks();
  mTurnDir = 0;
  mMoving = 0;
}

/** Move the creature stop */
void CCreature::stop()
{
  mMoving = 0;
}

/** Make the creature jump */
void CCreature::jump()
{
  mJumping = 1;
}

/** Make the creature not jump */
void CCreature::unjump()
{
  mJumping = 0;
}

/** Do two creatures collide? */
int CCreature::collidesWith(CCreature *creature, float xf, float yf)
{
  double left1, left2;
  double right1, right2;
  double top1, top2;
  double bottom1, bottom2;

  left1 =   mX + ( xf < 0 ? xf : 0 );
  top1 =    mY + ( yf < 0 ? yf : 0 );
  right1 =  mX + mWidth + ( xf > 0 ? xf : 0 );
  bottom1 = mY + mHeight + ( yf > 0 ? yf : 0 );

  left2 =   creature->getX();
  top2 =    creature->getY();
  right2 =  creature->getX()+creature->getWidth();
  bottom2 = creature->getY()+creature->getHeight();

  if (bottom1 < top2) return 0;
  if (top1 > bottom2) return 0;
  if (right1 < left2) return 0;
  if (left1 > right2) return 0;

	// if we fell and bumped onto the other creature
  if (yf>0 && bottom1 >= top2 && bottom1-yf < top2) return 2;
	// if the other creature fell and bumped onto us
  if (yf<=0 && bottom2 >= top1 && bottom2 < top1-yf) return 3;

  return 1;
}

/** Do we collide with an item? */
int CCreature::collidesWith(CItem *item, float xf, float yf)
{
  double left1, left2;
  double right1, right2;
  double top1, top2;
  double bottom1, bottom2;

  left1 =   mX + ( xf < 0 ? xf : 0 );
  top1 =    mY + ( yf < 0 ? yf : 0 );
  right1 =  mX + mWidth + ( xf > 0 ? xf : 0 );
  bottom1 = mY + mHeight + ( yf > 0 ? yf : 0 );

  left2 =   item->getX();
  top2 =    item->getY();
  right2 =  item->getX()+item->getWidth();
  bottom2 = item->getY()+item->getHeight();

  if (bottom1 < top2) return 0;
  if (top1 > bottom2) return 0;
  if (right1 < left2) return 0;
  if (left1 > right2) return 0;

  return 1;
}

/** Return the width of the creature */
int CCreature::getWidth()
{
	return mWidth;
}

/** Return the height of the creature */
int CCreature::getHeight()
{
	return mHeight;
}

/** Is the creature dead? */
int CCreature::isDead()
{
	return mDead;
}

/** Is the creature alive? If not then he's currently dying. */
int CCreature::isAlive()
{
	return mAlive;
}

/** Change the special ability of the creature. */
int CCreature::doSpecial(string special, int value)
{
  if(special == "bullets")
	{
    mSpecialAbilities[BULLETS] += value;
	} else if(special == "speed") {
    mSpecialAbilities[SPEED] += value;
/*
	} else if(special == "lives") {
  } else if(special == "blast") {
  } else if(special == "bomb") {
  } else if(special == "cash") {
  } else if(special == "boots") {
  } else if(special == "shield") {
*/
  }
  return 0;
}

/** Turn around */
void CCreature::turn()
{
  mDirection = -mDirection;
  mTurnStart = SDL_GetTicks();
  mTurnDir = mDirection;
	mStop = 1;
	mMoving = 1;
	mVx = 1*mDirection;
}

/** Return the X velocity */
float CCreature::getVx()
{
	return mVx;
}

/** Is the character controlled by a human? */
int CCreature::isPlayer()
{
	return mPlayer;
}

/** Stop moving */
void CCreature::halt()
{
	mVx = 0;
}
