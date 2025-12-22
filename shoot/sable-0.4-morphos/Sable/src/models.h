/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  models.h: Definitions of the rigid-body geometry of the entities
 *  in the game.
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

#ifndef _MODELS_H_
#define _MODELS_H_

#include "geometry.h"

class GeomPlayer : public Geometry {
 public:
	GeomPlayer (void);
	virtual ~GeomPlayer (void) {}
	virtual void render (void);
};

class GeomEnemy : public Geometry {
 public:
	GeomEnemy (void);
	virtual ~GeomEnemy (void) {}
	virtual void render (void);
};

class GeomPylon : public Geometry {
 public:
	GeomPylon (void);
	virtual ~GeomPylon (void) {}
	virtual void render (void);
};

class GeomTransparentPylon : public Geometry {
 public:
	GeomTransparentPylon (void);
	virtual ~GeomTransparentPylon (void) {}
	virtual void render (void);
};

class GeomBullet : public Geometry {
 public:
	GeomBullet (void);
	virtual ~GeomBullet (void) {}
	virtual void render (void);
};

class GeomDeathBlossom : public Geometry {
 public:
	GeomDeathBlossom (void);
	virtual ~GeomDeathBlossom (void) {}
	virtual void render (void);
};

extern GeomPlayer geomPlayer;
extern GeomEnemy  geomEnemy;
extern GeomPylon  geomPylon;
extern GeomTransparentPylon geomTransparentPylon;
extern GeomBullet geomBullet;
extern GeomDeathBlossom geomDeathBlossom;

#endif
