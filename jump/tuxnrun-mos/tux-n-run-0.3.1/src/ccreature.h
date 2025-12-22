/***************************************************************************
                          ccreature.h  -  description
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

#ifndef CCREATURE_H
#define CCREATURE_H

#include "ccreaturebase.h"
#include "citem.h"
#include "ctilelayer.h"
#include "csdl.h"

/**
  *@author Marius
  */

class CCreature;

class CCreature
{
	enum special_ability{BULLETS, SPEED, SPECIAL_ABILITY_COUNT};

  public: 
  CCreature();
  ~CCreature();
  /** Initalize the creature */
  int init(CSDL *sdl, CCreatureBase *creatureBase, int x, int y, int direction, int player, CTileLayer *tiles, float speed);
  /** Draw the creature on the screen */
  void render(int offsetX, int offsetY);
  /** Move the creature. Gets called 100 times in a second. */
  int update(float dt, CItem *items, int numItems, CCreature *creatures, int numCreatures, int me);
  /** Check if the creature collides with the tiles horizontally. */
  int checkHorizontalCollision(float yf);
  /** Check if the creature collides with the tiles vertically. */
  int checkVerticalCollision(float yf);
  /** Cleanup */
  void dispose();
  /** Return the X coordinate of the creature */
  float getX();
  /** Return the Y coordinate of the creature */
  float getY();
  /** Move the creature left */
  void moveLeft();
  /** Move the creature right */
  void moveRight();
  /** Move the creature left AND right */
  void moveLeftRight();
  /** Make the creature stop */
  void stop();
  /** Make the creature jump */
  void jump();
  /** Make the creature not jump */
  void unjump();
  /** Do two creatures collide? */
  int collidesWith(CCreature *creature, float xf, float yf);
  /** Do we collide with an item? */
  int collidesWith(CItem *creature, float xf, float yf);
  /** Return the height of the creature */
  int getHeight();
  /** Return the width of the creature */
  int getWidth();
  /** Is the creature alive? If not then he's currently dying. */
  int isAlive();
  /** Is the creature dead? */
  int isDead();
  /** Change the special ability of the creature. */
  int doSpecial(string special, int value);
  /** Turn around */
  void turn();
  /** Return the X velocity */
  float getVx();
  /** Is the character controlled by a human? */
  int isPlayer();
  /** Stop moving */
  void halt();


  private:
  CSDL *mSDL;
  CCreatureBase *mBase;
  CTileLayer *mTiles;
  int mWidth, mHeight;
  float mX, mY;
  float mNewX, mNewY;
  float mVx, mVy;
  float mSpeed;
  int mDirection, mMoving, mPlayer;
  int mSpecial;
  int mAlive;
	int mDead;
  int mJumping;
  int mLastDirection;
  int mTurnDir;
  int mTurnDelay;
  int mTurnFrames;
  int mWalkFrame;
	char mStop;
  Uint32 mTurnStart;
  Uint32 mLastWalk;
	int *mSpecialAbilities;
};

#endif
