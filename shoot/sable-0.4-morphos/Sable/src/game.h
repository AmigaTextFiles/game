/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  game.h: The environment representing a game
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

#ifndef _GAME_H_
#define _GAME_H_

#include "sable.h"
#include "environment.h"
#include "entity.h"
#include "entityfarm.h"

class Game : public Environment {
 public:
	Game (void);
	virtual ~Game (void);
	virtual void init (void);
	virtual void uninit (void);
	virtual EnvID processEvents (void);
	virtual void frameAdvance (void);
	virtual void renderScreen (void);
 private:
	int h_rotate, v_rotate;

	Entity *playerEntity;
	EntityFarm player, enemies, pylons, hero_shots, enemy_shots, explosions;
	GLfloat offset;
	bool paused, radar_active;
	bool player_active, enemy_spawn, pylon_spawn;
	int _score, _lives;
	bool game_over;
	int game_over_timer;
	int frame_count, enemy_spawn_chance;
};

#endif
