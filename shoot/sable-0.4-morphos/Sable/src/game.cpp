/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  game.cpp: The game logic itself
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

#include "sable.h"
#include <SDL.h>
#include <stdlib.h>
#include <stdio.h>

#include "sound.h"
#include "environment.h"
#include "game.h"
#include "entity.h"
#include "input.h"
#include "textures.h"
#include "ground.h"

static int dummy; /* For during gameover */

/* The EntityActors. */

class EntityUpdater : public EntityActor {
public:
	virtual void act (Entity *e);
};

void
EntityUpdater::act (Entity *e)
{
	if (!e->update())
	{
		e->kill();
	}
}

class PylonUpdater : public EntityActor {
public:
	virtual void act (Entity *e);
	int *score;
};

void
PylonUpdater::act(Entity *e) {
	if (!e->update()) {
		e->kill();
	} else {
		Pylon *p = dynamic_cast<Pylon *>(e);
		if (p && p->checkPass()) {
			*score += 25;
		}
	}
}

class EnemyUpdater : public EntityActor {
public:
	virtual void act (Entity *e);
	EntityFarm *shotfarm;
};

void
EnemyUpdater::act (Entity *e)
{
	if (!e->update()) {
		e->kill();
	}
}

class EntityRenderer : public EntityActor {
public:
	virtual void act (Entity *e) { e->render(); }
};

class RadarRender : public EntityActor {
public:
	RadarRender () { zofs = 0.0f; }
	virtual void act (Entity *e) {
		GLfloat x1 = e->getZ() + 688.0f+zofs, x2 = e->getZ() + 698.0f+zofs;
		GLfloat y1 = e->getX() + 36.0f, y2 = e->getX() + 46.0f;
		if (x1 > 638) x1 = 638;
		if (x2 > 638) x2 = 638;
		if (x1 < 548) x1 = 548;
		if (x2 < 548) x2 = 548;
		if (y1 > 201) y1 = 201;
		if (y2 > 201) y2 = 201;
		if (y1 < 1) y1 = 1;
		if (y2 < 1) y2 = 1;

		glVertex2f (x1, y1); glVertex2f (x2, y1); glVertex2f (x2, y2); glVertex2f (x1, y2);
	}
	GLfloat zofs;
};

class NoEffect : public EntityActor {
public:
	virtual void act (Entity *e) {}
};

class EntityCanceller : public EntityActor {
public:
	virtual void act (Entity *e) { expl_farm->registerEntity (new Explosion (e->getX(), e->getY(), e->getZ(), 100, 0.25f)); e->kill (); }
	EntityFarm *expl_farm;
};

class EntityStrike : public EntityActor {
public:
	virtual void act (Entity *e);
	int *score;
	int pointValue;
	EntityFarm *expl_farm;
};

void
EntityStrike::act (Entity *e)
{
	if (e->takeHit(expl_farm)) {
		*score += pointValue;
	}
}

class PlayerStrike : public EntityActor {
public:
	virtual void act (Entity *e) { if (e->takeHit(expl_farm)) { (*lives)--; }}
	int *lives;
	EntityFarm *expl_farm;
};

static EntityUpdater entityUpdater;
static PylonUpdater pylonUpdater;
static EnemyUpdater enemyUpdater;
static EntityRenderer entityRenderer;
static RadarRender radarRender;
static NoEffect noEffect;
static EntityCanceller entityCanceller;
static EntityStrike entityStrike;
static PlayerStrike playerStrike;

Game::Game (void) : player(1), enemies(250), pylons(50), hero_shots(200), enemy_shots(200), explosions(200)
{
}

Game::~Game (void)
{
}

void
Game::init (void)
{
	play_music (GAME_MUSIC);

	player.reset();
	enemies.reset();
	pylons.reset();
	hero_shots.reset();
	enemy_shots.reset();
	explosions.reset();
	playerInput.reset();

	ground.init ();

	playerEntity = new Player (&hero_shots);
	player.registerEntity (playerEntity);
	
	/* Initialize game graphics */
	glShadeModel( GL_SMOOTH );

	/* Culling. */
	glCullFace( GL_BACK );
	glFrontFace( GL_CCW );
	glEnable( GL_CULL_FACE );

	/* Set the clear color. */
	GLfloat sky[] = { 0.2f, 0.2f, 0.8f, 0.0f };
	glClearColor ( 0.2f, 0.2f, 0.8f, 0.0f );

	glEnable (GL_FOG);
	glFogi (GL_FOG_MODE, GL_EXP2);
	glFogfv (GL_FOG_COLOR, sky);
	glFogf (GL_FOG_DENSITY, 0.004f);
	glFogf (GL_FOG_START, 200.0f);
	glFogf (GL_FOG_END, 1000.0f);
	glHint (GL_FOG_HINT, GL_NICEST);

	/* Initialize lighting */
	GLfloat light_position0[] = { 0.5, 1.0, 1.0, 0.0 };
	GLfloat white_light[] = {1.0, 1.0, 1.0, 1.0 };
	GLfloat lmodel_ambient[] = { 0.5, 0.5, 0.5, 1.0 };

	glLightfv(GL_LIGHT0, GL_POSITION, light_position0);
	glLightfv(GL_LIGHT0, GL_DIFFUSE, white_light);
	glLightfv(GL_LIGHT0, GL_SPECULAR, white_light);
	glLightModelfv(GL_LIGHT_MODEL_AMBIENT, lmodel_ambient);
	glEnable (GL_LIGHT0);

	glEnableClientState (GL_NORMAL_ARRAY);
	glEnableClientState (GL_VERTEX_ARRAY);

	/* Initialize game state. */
	h_rotate = 90;
	v_rotate = 0;
	offset = 0.0;
	paused = false;
	radar_active = true;
	player_active = false;
	enemy_spawn = false;
	pylon_spawn = true;

	_score = 0;
	_lives = 3;
	game_over = false;
	game_over_timer = 0;
	pylonUpdater.score = &_score;
	entityCanceller.expl_farm = &explosions;
	entityStrike.score = &_score;
	entityStrike.expl_farm = &explosions;
	playerStrike.lives = &_lives;
	playerStrike.expl_farm = &explosions;
	for (int i = 0; i < 300; i++) {
		frameAdvance ();
	}
	player_active = true;
	enemy_spawn = true;
	enemy_spawn_chance = 90;
	frame_count = 0;
}

void
Game::uninit (void)
{
	glDisableClientState (GL_NORMAL_ARRAY);
	glDisableClientState (GL_VERTEX_ARRAY);

	player.reset();
	enemies.reset();
	pylons.reset();
	hero_shots.reset();
	enemy_shots.reset();
	explosions.reset();
	
	last_score = _score;
	if (_score > high_score)
		high_score = _score;
	stop_music ();
	stop_sfx ();
}

EnvID
Game::processEvents (void)
{
	SDL_Event event;

	playerInput.frameAdvance();
	while( SDL_PollEvent( &event ) ) {
		switch( event.type ) {
		case SDL_QUIT:
			/* Handle quit requests (like Ctrl-c). */
			return ENVIRON_EXIT;
			break;
		default:
			break;
		}
		playerInput.process (&event);
	}
	if (playerInput.pulse_radar()) 
		radar_active = !radar_active;

	if (playerInput.pulse_pause()) 
		paused = !paused;

	if (game_over || playerInput.pulse_quit()) {
		return ENVIRON_MENU;
	} else {
		return ENVIRON_GAME;
	}
}

void
Game::frameAdvance (void)
{
	if (!paused) {
		/* Update all entities */
		enemies.operate(&enemyUpdater);
		pylons.operate(&pylonUpdater);
		enemy_shots.operate(&entityUpdater);
		hero_shots.operate(&entityUpdater);
		explosions.operate(&entityUpdater);

		/* Update player */
		if (player_active) {
			player.operate(&entityUpdater);
		}

		/* Spawn enemies and pylons */
		if (enemy_spawn && !(random()  % enemy_spawn_chance)) {
			Entity *e;
			if (random() % 6) {
				e = new Enemy (&enemy_shots);
			} else {
				e = new DeathBlossom (&enemy_shots);
			}
			enemies.registerEntity(e);
		}
		if (pylon_spawn && ((random() % 750) < (ground_speed * 10))) {
			Entity *e = new Pylon ();
			pylons.registerEntity(e);
		}
		/* Update ground */
		ground.scroll ();

		/* Collision detection. */
		entityStrike.pointValue = 200;
		hero_shots.collisionCheck (&pylons, &entityCanceller, &entityStrike);
		pylons.collisionCheck (&player, &entityStrike, &playerStrike);
		entityStrike.pointValue = 75;
		hero_shots.collisionCheck (&enemies, &entityCanceller, &entityStrike);
		enemies.collisionCheck (&player, &entityStrike, &playerStrike);
		entityStrike.pointValue = 0;
		enemy_shots.collisionCheck (&player, &entityCanceller, &playerStrike);
		enemy_shots.collisionCheck (&pylons, &entityCanceller, &noEffect);
		enemies.collisionCheck (&pylons, &entityStrike, &noEffect);

		/* Clean up our stuff.  The player can never be "cleaned". */
		enemies.clean ();
		pylons.clean ();
		enemy_shots.clean ();
		hero_shots.clean ();
		explosions.clean ();

		if ((_lives == 0) && (game_over_timer == 0)) {
			fade_music ();
			game_over_timer = 800;
			player_active = false;
			pylonUpdater.score = &dummy;
			entityStrike.score = &dummy;
		} else if (game_over_timer > 0) {
			game_over_timer--;
			if (game_over_timer == 0) {
				game_over = true;
			} else if (game_over_timer == 500) {
				play_music_once (GAME_OVER_MUSIC);
			}
		}
		frame_count++;
		if (frame_count > 2000)
		{
			frame_count -= 2000;
			if (ground_speed < 2.0)
				ground_speed += 0.05;
			if (enemy_spawn_chance > 45)
				enemy_spawn_chance -= 5;
		}
	}
}

void
Game::renderScreen (void)
{
	glClear( GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT );

	/* Set flight perspective. */
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluPerspective (60.0, 640.0 / 480.0, 1.0, 500.0);

	glEnable (GL_DEPTH_TEST);

	glEnable (GL_LIGHTING);
	glMatrixMode (GL_MODELVIEW);
	glLoadIdentity ();
	glTranslatef(0.0f, 0.0f, -100.0f);
	glRotatef((GLfloat)h_rotate,0.0f,1.0f,0.0f);
	glRotatef((GLfloat)v_rotate,0.0f,0.0f,1.0f);
	glTranslatef(0.0f, 0.0f, 100.0f);

	/* Render the entities */
	player.operate(&entityRenderer);
	enemies.operate(&entityRenderer);
	enemy_shots.operate(&entityRenderer);
	hero_shots.operate(&entityRenderer);

	glDisable (GL_LIGHTING);

	explosions.operate(&entityRenderer);

	/* Draw the ground. */
	ground.render ();

	/* Render pylons last, since some are transparent. */
	glEnable (GL_LIGHTING);
	pylons.operate(&entityRenderer);
	glDisable (GL_LIGHTING);

	glDisable (GL_DEPTH_TEST);

	/* Render the border. */
	glMatrixMode (GL_PROJECTION);
	glLoadIdentity ();
	gluOrtho2D (0, 640, 0, 480);
	glMatrixMode (GL_MODELVIEW);
	glLoadIdentity ();

	glBegin (GL_QUADS);
	glColor3f(0, 0, 0); 
	glVertex2i (0, 420); 
	glColor3f(0, 0.25, 0); 
	glVertex2i (640, 420);
	glColor3f(0, 0.5, 0);
	glVertex2i (640, 450); glVertex2i (0, 450);
	glVertex2i (0, 450); glVertex2i (640, 450);
	glColor3f(0,0.25,0);
	glVertex2i (640, 480); 
	glColor3f(0, 0.0, 0); 
	glVertex2i (0, 480);
	glColor3f(0, 0.4f, 0);
	glVertex2i(20,430); glVertex2i(620,430);
	glVertex2i(620,470); glVertex2i(20,470);
	glEnd ();

	glEnable (GL_BLEND);
	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable (GL_TEXTURE_2D);
	glTexEnvf (GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_REPLACE);
	
	select_texture(FONT_TEX);
	glBegin(GL_QUADS);
	draw_mosaic (40, 434,0,0,3,0);
	draw_mosaic (460, 434, 4,0, 7,0);
	draw_number (150, 434, 7, _score);
	draw_number (550, 434, 2, _lives);
	if ((game_over_timer > 0) && (game_over_timer < 500)) {
		draw_mosaic (192, 224, 0, 5, 7, 6);
	}
	glEnd ();
	glDisable (GL_TEXTURE_2D);
	
	if (radar_active) {
		glBegin(GL_QUADS);
		glColor4f (0.25, 0.5, 0.25, 0.5);
		glVertex2i(547, 0); glVertex2i (639, 0); glVertex2i(639, 202); glVertex2i (547, 202);
		glColor4f (0.0, 0.5, 0.0, 0.5);
		glVertex2i(548, 1); glVertex2i (638, 1); glVertex2i(638, 201); glVertex2i (548, 201);
		glColor4f (0.3, 0.1, 0.5, 0.5);
		glVertex2i(585, 1); glVertex2i (601, 1); glVertex2i(601, 7); glVertex2i (585, 7);
		glColor4f (0.5, 0.5, 0.5, 0.5);
		radarRender.zofs = -100 - playerEntity->getZ ();
		pylons.operate (&radarRender);
		glEnd ();
	}
	glDisable (GL_BLEND);

	SDL_GL_SwapBuffers ();
}
