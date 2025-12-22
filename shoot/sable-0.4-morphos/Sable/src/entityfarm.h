/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  entityfarm.h: A bank of slots for Entities.
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

#ifndef _ENTITYFARM_H_
#define _ENTITYFARM_H_
#include "sable.h"
#include "entity.h"

class EntityActor {
public:
	virtual void act (Entity *entity) = 0;
};

class EntityFarm {
public:
	EntityFarm (int size);
	virtual ~EntityFarm (void);

	bool registerEntity (Entity *e);
	void operate (EntityActor *actor);
	void collisionCheck (EntityFarm *other, EntityActor *onMe, EntityActor *onOther);
	void clean (void);
	void reset (void);
private:
	int _size;
	Entity **_farm;
};

#endif
