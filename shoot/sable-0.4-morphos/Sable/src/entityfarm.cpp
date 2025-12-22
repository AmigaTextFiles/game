/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  entityfarm.cpp: a resource bank for Entity objects.
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

#include "entityfarm.h"

EntityFarm::EntityFarm (int size)
{
	_size = size;
	_farm = new Entity *[size];
	for (int i = 0; i < size; i++) 
	{
		_farm[i] = NULL;
	}
}

EntityFarm::~EntityFarm (void)
{
	reset ();
	delete[] _farm;
}

bool
EntityFarm::registerEntity (Entity *e)
{
	for (int i = 0; i < _size; i++)
	{
		if (_farm[i] == NULL)
		{
			_farm[i] = e;
			return true;
		}
	}
	delete e;
	printf ("Farm full!\n");
	return false;
}

void 
EntityFarm::operate (EntityActor *actor)
{
	for (int i = 0; i < _size; i++)
	{
		if ((_farm[i] != NULL) && (!_farm[i]->beingRemoved()))
		{
			actor->act(_farm[i]);
		}
	}
}

void 
EntityFarm::collisionCheck (EntityFarm *other, EntityActor *onMe, EntityActor *onOther)
{
	for (int i = 0; i < _size; i++)
	{
		if (_farm[i] == NULL)
			continue;
		for (int j = 0; j < other->_size; j++)
		{
			if (other->_farm[j] == NULL)
				continue;
			if (_farm[i]->collision (*other->_farm[j]))
			{
				onMe->act(_farm[i]);
				onOther->act(other->_farm[j]);
			}
		}
	}
}

void 
EntityFarm::clean (void)
{
	for (int i = 0; i < _size; i++)
	{
		if ((_farm[i] != NULL) && (_farm[i]->beingRemoved())) {
			delete _farm[i];
			_farm[i] = NULL;
		}
	}
}

void
EntityFarm::reset (void)
{
	for (int i = 0; i < _size; i++)
	{
		if (_farm[i] != NULL)
		{
			delete (_farm[i]);
			_farm[i] = NULL;
		}
	}
}
