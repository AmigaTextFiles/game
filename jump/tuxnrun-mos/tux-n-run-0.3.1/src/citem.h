/***************************************************************************
                          citem.h  -  description
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

#ifndef CITEM_H
#define CITEM_H

#include "citembase.h"
#include "ctilelayer.h"

/**
  *@author Marius
  */

class CItem
{
	public:
	CItem();
	~CItem();
  /** Initalize the item. */
  int init(CSDL *sdl, CItemBase *base, CTileLayer *tileLayer, float x, float y, int grav, string effect, int value, int respawn);
  /** Update the item: if it has gravity applied to it, move it down. */
  void update(float dt);
  /** Clean up */
  void dispose();
  /** Render the item. */
  void render(float offsetX, float offsetY);
	/** Check if the item collides with the tiles vertically. */
	int checkVerticalCollision(float yf);
  /** Is the item still in the level? */
  int isThere();
  /** Return the X coordinate of the item */
  float getX();
  /** Return the Y coordinate of the item */
  float getY();
  /** Return the width of the item */
  int getWidth();
  /** Return the height of the item */
  int getHeight();
  /** Pick up the item */
  int pickUp();
  /** Return the name of the type of item */
  string getName();
  /** Return the effect the item has */
  string getEffect();
  /** Return the value of the item */
  int getValue();

	private:
	float mX, mY;
	float mVy;
	float mNewY;
	int mHeight, mWidth;
	int mAnimFrame, mAnimFrames;
	Uint32 mLastAnim;
	int mGravity;
	CItemBase *mBase;
	CSDL *mSDL;
	CTileLayer *mTiles;
	string mEffect;
	int mValue;
	int mDelay;
	int mThere;
	int mRespawn;
	Uint32 mPickUpTime;
};

#endif
