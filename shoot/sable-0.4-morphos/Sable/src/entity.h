/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  entity.h: classes for in-game and rendering behavior of the
 *  objects in the game
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be entertaining,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.  A copy of the
 *  General Public License is included in the file COPYING.
 */

#ifndef _ENTITY_H_
#define _ENTITY_H_

#include <GL/gl.h>
#include <stdio.h>
#include "SDL.h"
#include "geometry.h"
#include "obb.h"

class EntityFarm;

class Entity {
 public:
	Entity (int numFineOBBs);
	virtual ~Entity(void);
	virtual bool update (void) = 0;
	virtual void render (void) const;
	virtual GLfloat getX (void) const { return _x; }
	virtual GLfloat getY (void) const { return _y; }
	virtual GLfloat getZ (void) const { return _z; }
	void dumpMatrix (FILE *o) const;
	virtual const OBB * getOBB (void) const;
	virtual int getNumFineOBBs (void) const;
	virtual const OBB * getFineOBB (int index) const;
	virtual void updateOBB (void) = 0;
	bool collision (const Entity &o) const;
	bool beingRemoved (void) const { return _doomed; }
	void kill (void) { _doomed = true; }
	virtual bool takeHit (EntityFarm *farm) { return false; }
	void updateMask (GLfloat min, GLfloat max);
 protected:
	Geometry *geom;
	GLfloat _matrix[16];
	GLfloat _x, _y, _z;
	bool _doomed;
	OBB _coarse;
	OBB *_fine;
	int _fineCount;
	Uint32 _mask;
};

class Player : public Entity {
 public:
	Player (EntityFarm *sf);
	virtual ~Player(void) { }
	virtual bool update (void);
	virtual void updateOBB (void);
	virtual void render (void) const;
	virtual bool takeHit (EntityFarm *farm);
 private:
	void updateMatrix (GLfloat bank);
	int _dy, _dz;
	bool player_alive;
	int invincible;
	int death_count;
	int shot_count;
	EntityFarm *shotfarm;
};

class Enemy : public Entity {
 public:
	Enemy (EntityFarm *sf);
	virtual ~Enemy(void) { }
	virtual bool update (void);
	virtual void updateOBB (void);
	virtual bool takeHit (EntityFarm *farm);
private:
	GLfloat _bank;
	EntityFarm *shotfarm;
};

class DeathBlossom : public Entity {
 public:
	DeathBlossom (EntityFarm *sf);
	virtual ~DeathBlossom(void) { }
	virtual bool update (void);
	virtual void updateOBB (void);
	virtual bool takeHit (EntityFarm *farm);
private:
	GLfloat _dz;
	EntityFarm *shotfarm;
};

class Pylon : public Entity {
 public:
	Pylon (void);
	virtual ~Pylon(void) {}
	virtual bool update (void);
	virtual void updateOBB (void);
	virtual bool takeHit (EntityFarm *farm);
	virtual bool checkPass (void);
private:
	int hp;
	bool scored;
};

class HeroBullet : public Entity {
 public:
	HeroBullet (GLfloat y, GLfloat z);
	virtual ~HeroBullet(void) {}
	virtual bool update (void);
	virtual void render (void) const;
	virtual void updateOBB (void);
};

class EnemyBullet : public Entity {
 public:
	EnemyBullet(GLfloat x, GLfloat y, GLfloat z);
	virtual ~EnemyBullet (void) {}
	virtual bool update (void);
	virtual void render (void) const;
	virtual void updateOBB (void);
};

class Explosion : public Entity {
public:
	Explosion (GLfloat x, GLfloat y, GLfloat z, int particles, GLfloat speed);
	virtual ~Explosion (void);
	virtual bool update (void);
	virtual void render (void) const;
	virtual void updateOBB (void);
private:
	int size;
	GLfloat *xs, *ys, *zs, *xso, *yso, *zso;
	GLfloat *dxs, *dys, *dzs;
	int frame;
};

#endif
