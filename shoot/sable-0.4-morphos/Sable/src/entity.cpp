/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  entity.cpp: "AI" and rendering directives for the free objects in
 *  the game.
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
#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "entity.h"
#include "models.h"
#include "input.h"
#include "entityfarm.h"
#include "sound.h"

#define OFFSCREEN -100

Entity::Entity(int numFineOBBs)
{
	_fineCount = numFineOBBs;
	_fine = new OBB[numFineOBBs];
	_doomed = false;
	_mask = 0;
}

Entity::~Entity(void) 
{
	delete[] _fine;
}

const OBB *
Entity::getOBB (void) const
{
	return &_coarse;
}

int
Entity::getNumFineOBBs (void) const
{
	return _fineCount;
}

const OBB *
Entity::getFineOBB (int index) const
{
	if ((index < 0) || (index > _fineCount))
		return NULL;
	return &_fine[index];
}

void
Entity::updateMask (GLfloat min, GLfloat max)
{
	int iMin = (int)floor((min + 512.0f) / 32.0f);
	int iMax = (int)floor((max + 512.0f) / 32.0f);
	_mask = 0;
	for (int i = iMin; i <= iMax; i++)
	{
		_mask |= (1 << i);
	}
}

void
Entity::dumpMatrix (FILE *f) const
{
	fprintf (f, "+-                                         -+\n");
	for (int i = 0; i < 4; i++) {
		fprintf (f, "| %8.3f   %8.3f   %8.3f   %8.3f |\n", _matrix[i], _matrix[i+4], _matrix[i+8], _matrix[i+12]);
	}
	fprintf (f, "+-                                         -+\n\n");
}

void
Entity::render (void) const
{
	glPushMatrix ();
	glMultMatrixf (_matrix);
	geom->render ();
	glPopMatrix ();
}


bool
Entity::collision (const Entity &o) const {
	if (!(_mask & o._mask))
		return false;
	if (!_coarse.intersects (o._coarse)) {
		return false;
	}
	int myOBBcount = _fineCount;
	int otherOBBcount = o._fineCount;
	for (int i = 0; i < myOBBcount; i++) {
		OBB *myOBB = _fine+i;
		for (int j = 0; j < otherOBBcount; j++) {
			OBB *otherOBB = o._fine+j;
			if (myOBB->intersects (*otherOBB)) {
				return true;
			}
		}
	}
	return false;
}

Player::Player(EntityFarm *sf) : Entity(2)
{
	geom = &geomPlayer;
	_x = -40;
	_y = -15;
	_z = -100;
	_dy = _dz = 0;
	invincible = 0;
	player_alive = true;
	death_count = 0;
	updateMatrix (0);
	shot_count = 15;
	shotfarm = sf;
}

void
Player::updateMatrix (GLfloat bank)
{
	glMatrixMode (GL_MODELVIEW);
	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glRotatef (-90.0f, 0.0f, 0.0f, 1.0f);
	glRotatef (-90.0f+bank, 0.0f, 1.0f, 0.0f);

	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
}

bool
Player::update (void)
{
	if (player_alive) {
		int target_dy = 0, target_dz = 0;
		GLfloat old_y = _y, old_z = _z;
		int old_dz = _dz;
		playerInput.getDirection (&target_dz, &target_dy);

		if (_dy < target_dy) ++_dy;
		else if (_dy > target_dy) --_dy;
		if (_dz < target_dz) ++_dz;
		else if (_dz > target_dz) --_dz;

		_y += (_dy * 0.5f / 20.0f);
		_z += (_dz * 0.5f / 20.0f);

		if (_y > 20) _y = 20;
		if (_y < -20) _y = -20;
		if (_z < -130) _z = -130;
		if (_z > -70) _z = -70;

		if ((_y != old_y) || (_z != old_z) || (old_dz != _dz)) 
		{
			updateMatrix (_dz * 45.0f / 20.0f);
		}
		if (invincible > 0) {
			invincible--;
		}

		/* Take shots */
		if (shot_count > 0) {
			shot_count--;
		} else if (playerInput.fire()) {
			Entity *shot = new HeroBullet (_y, _z);
			if (!shotfarm->registerEntity(shot))
			{
				delete shot;
			}
			else
			{
				shot_count = 15;
				play_sfx (PLAYER_SHOT_SOUND);
			}
		}
	} else {
		if (death_count > 0) {
			death_count--;
		} else {
			player_alive = true;

			_x = -40;
			_y = -15;
			_z = -100;
			_dy = _dz = 0;
			updateMatrix (0.0f);
			invincible = 300;
		}
	}

	return true;
}

bool
Player::takeHit (EntityFarm *farm) {
	if (!invincible) {
		player_alive = false;
		death_count = 300;
		farm->registerEntity (new Explosion (_x, _y, _z, 1000, 0.75f));
		/* Hide from collisions. */
		_x = -700;
		updateMatrix (0.0f);
		play_sfx (LARGE_EXPLOSION_SOUND);
		return true;
	}
	return false;
}

void
Player::render (void) const
{
	if (player_alive && !((invincible / 10) % 2))
	{
		Entity::render();
	}
}

void
Player::updateOBB (void)
{
	static GLfloat halfwidths[] = { 
		8.0f, 7.0f, 2.0f,
		2.0f, 7.0f, 1.0f,
		8.0f, 2.0f, 1.0f
	};
	static GLfloat offsets[] = {
		0.0f, 0.0f, 0.0f,
		0.0f, 0.0f, 1.0f,
		0.0f, -5.0f, -1.0f
	};
	_coarse.update(_matrix, halfwidths, offsets);
	_fine[0].update(_matrix, halfwidths+3, offsets+3);
	_fine[1].update(_matrix, halfwidths+6, offsets+6);
	updateMask (_x - 8, _x + 8);
}

Enemy::Enemy(EntityFarm *sf) : Entity(3)
{
	geom = &geomEnemy;
	_x = 500;
	_y = (random () % 40) - 20.0f;
	_z = (random () % 50) - 125.0f;
	_bank = (GLfloat)(random () % 360);
	shotfarm = sf;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glRotatef (-60.0f, 0.0f, 0.0f, 1.0f);
	glRotatef (-90.0f+_bank, 0.0f, 1.0f, 0.0f);

	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
}

bool
Enemy::update(void)
{
	_x -= 0.5 + ground_speed;
	_bank = _bank + 3.0f;
	if (_bank > 360.0f) _bank -= 360.0f;

	if (_x < 200 && !(random () % 250)) {
		Entity *shot = new EnemyBullet (_x, _y, _z);
		shotfarm->registerEntity(shot);
	}

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
        glRotatef (-60.0f, 0.0f, 0.0f, 1.0f);
	glRotatef (-90.0f+_bank, 0.0f, 1.0f, 0.0f);

	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();

	return (_x > OFFSCREEN);
	
}

void
Enemy::updateOBB (void)
{
	static GLfloat halfwidths[] = { 
		8.0f, 7.0f, 3.0f,
		5.0f, 4.0f, 1.0f,
		1.5f, 7.0f, 3.0f
	};
	static GLfloat offsets[] = {
		 0.0f, 0.0f, 0.0f,
		-6.5f, 0.0f, 0.0f,
		 6.5f, 0.0f, 0.0f
	};
	_coarse.update(_matrix, halfwidths, offsets);
	_fine[0].update(_matrix, halfwidths+3, offsets);
	_fine[1].update(_matrix, halfwidths+6, offsets+3);
	_fine[2].update(_matrix, halfwidths+6, offsets+6);
	updateMask (_x - 8, _x + 8);
}

bool
Enemy::takeHit (EntityFarm *expl_farm) {
	kill ();
	expl_farm->registerEntity (new Explosion (_x, _y, _z, 500, 0.5f));
	play_sfx (MEDIUM_EXPLOSION_SOUND);
	return true;
}

Pylon::Pylon(void) : Entity(1)
{
	geom = &geomPylon;
	_x = 500.0;
	_y = 10.0;
	_z = (GLfloat)(random () % 200) - 200;
	hp = 20;
	scored = false;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
}

bool
Pylon::update(void)
{
	_x -= ground_speed;

	if (_x < -45)
		geom = &geomTransparentPylon;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();

	return (_x > OFFSCREEN);
}

bool
Pylon::checkPass(void)
{
	if (!scored && _x < -50) {
		scored = true;
		return true;
	}
	return false;
}

void
Pylon::updateOBB (void)
{
	static GLfloat halfwidths[] = { 5.0f, 75.0f, 5.0f };
	static GLfloat offsets[] = {0.0f, 0.0f, 0.0f };
	_coarse.update(_matrix, halfwidths, offsets);
	_fine[0].update(_matrix, halfwidths, offsets);
	updateMask (_x - 5, _x + 5);
}

bool
Pylon::takeHit (EntityFarm *expl_farm) {
	if (--hp < 1) {
		kill ();
		expl_farm->registerEntity (new Explosion (_x, _y, _z, 750, 0.5f));
		expl_farm->registerEntity (new Explosion (_x, _y+40.0f, _z, 750, 0.5f));
		expl_farm->registerEntity (new Explosion (_x, _y+80.0f, _z, 750, 0.5f));
		expl_farm->registerEntity (new Explosion (_x, _y-40.0f, _z, 750, 0.5f));
		play_sfx (LARGE_EXPLOSION_SOUND);
		return true;
	} else {
		play_sfx (SMALL_EXPLOSION_SOUND);
	}
	return false;
}

HeroBullet::HeroBullet(GLfloat y, GLfloat z) : Entity(1)
{
	geom = &geomBullet;
	_x = -40;
	_y = y;
	_z = z;
	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
}

bool
HeroBullet::update(void)
{
	_x += 3;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
	return (_x < 300);
}

void
HeroBullet::render (void) const
{
	static GLfloat color[] = { 1.0, 0.5, 0.0, 1.0 };

	glPushMatrix ();
	glMultMatrixf (_matrix);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, color);
	geom->render ();
	glPopMatrix ();
}

void
HeroBullet::updateOBB (void)
{
	static GLfloat halfwidths[] = { 0.5f, 0.5f, 1.0f };
	static GLfloat offsets[] = {1.0f, 0.0f, 0.0f };
	_coarse.update(_matrix, halfwidths, offsets);
	_fine[0].update(_matrix, halfwidths, offsets);
	updateMask (_x + 0.5, _x + 1.5);
}


EnemyBullet::EnemyBullet(GLfloat x, GLfloat y, GLfloat z) : Entity(1)
{
	geom = &geomBullet;
	_x = x;
	_y = y;
	_z = z;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glRotatef (180.0, 0.0, 1.0, 0.0);
	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
}

bool
EnemyBullet::update(void)
{
	_x -= 1.5 + ground_speed;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glRotatef (180.0, 0.0, 1.0, 0.0);
	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
	return (_x > OFFSCREEN);
}

void
EnemyBullet::render (void) const
{
	static GLfloat color[] = { 0.0, 1.0, 0.0, 1.0 };

	glPushMatrix ();
	glMultMatrixf (_matrix);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, color);
	geom->render ();
	glPopMatrix ();
}

void
EnemyBullet::updateOBB (void)
{
	static GLfloat halfwidths[] = { 0.5f, 0.5f, 1.0f };
	static GLfloat offsets[] = {1.0f, 0.0f, 0.0f };
	_coarse.update(_matrix, halfwidths, offsets);
	_fine[0].update(_matrix, halfwidths, offsets);
	updateMask (_x - 0.5, _x - 1.5);
}

Explosion::Explosion (GLfloat x, GLfloat y, GLfloat z, int particles, GLfloat speed) : Entity (0)
{
	size = particles;
	frame = 0;
	xs = new GLfloat[size];
	ys = new GLfloat[size];
	zs = new GLfloat[size];
	xso = new GLfloat[size];
	yso = new GLfloat[size];
	zso = new GLfloat[size];
	dxs = new GLfloat[size];
	dys = new GLfloat[size];
	dzs = new GLfloat[size];
	for (int i = 0; i < size; i++)
	{
		xs[i] = x;
		ys[i] = y;
		zs[i] = z;
		GLfloat mag = ((random () % 1024 + 1024) / 2048.0f) * speed;
		GLfloat dx, dy, dz, one_over_norm;
		do {
			dx = ((random () % 1024) - 512) / 512.0f;
			dy = ((random () % 1024) - 512) / 512.0f;
			dz = ((random () % 1024) - 512) / 512.0f;
		} while ((dx == 0) && (dy == 0) && (dz == 0));
		one_over_norm = mag / sqrt(dx*dx + dy*dy + dz*dz);
		dxs[i] = (GLfloat)((dx * one_over_norm) - ground_speed);
		dys[i] = (GLfloat)(dy * one_over_norm);
		dzs[i] = (GLfloat)(dz * one_over_norm);
	}
	update ();
}

Explosion::~Explosion (void)
{
	delete[] xs;
	delete[] ys;
	delete[] zs;
	delete[] xso;
	delete[] yso;
	delete[] zso;
	delete[] dxs;
	delete[] dys;
	delete[] dzs;
}

bool
Explosion::update (void)
{
	for (int i = 0; i < size; i++)
	{
		xso[i] = xs[i];
		xs[i] += dxs[i];
		yso[i] = ys[i];
		ys[i] += dys[i];
		zso[i] = zs[i];
		zs[i] += dzs[i];

		dys[i] -= 0.004f;
	}
	frame++;
	return (frame < 100);
}

void
Explosion::render (void) const
{
	if (!_doomed) {
		GLfloat r = 1.0f, g = 1.0f;
		r -= (frame > 50) ? ((frame - 50) * 0.01f) : 0.0f;
		g -= (frame * 0.01f);

		glColor3f (r, g, 0.0f);
		glBegin (GL_LINES);
		for (int i = 0; i < size; i++) {
			glVertex3f (xso[i], yso[i], zso[i]);
			glVertex3f (xs[i], ys[i], zs[i]);
		}
		glEnd ();
	}
}

void
Explosion::updateOBB (void)
{
}

DeathBlossom::DeathBlossom(EntityFarm *sf) : Entity(2)
{
	geom = &geomDeathBlossom;
	_x = 500;
	_y = (random () % 40) - 20.0f;
	_z = -125.0f;
	_dz = 0.0f;
	shotfarm = sf;

	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glRotatef (90.0f+_dz*30.0f, 1.0f, 0.0f, 0.0f);

	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();
}

bool
DeathBlossom::update(void)
{
	_x -= ground_speed;
	if (_z < -100) _dz += 0.1f;
	if (_z > -100) _dz -= 0.1f;
	_z += _dz;

	if (_x < 200 && !(random () % 50)) {
		Entity *shot = new EnemyBullet (_x, _y, _z);
		shotfarm->registerEntity(shot);
	}
	glPushMatrix ();
	glLoadIdentity ();
	glTranslatef (_x, _y, _z);
	glRotatef (90.0f+_dz*30.0f, 1.0f, 0.0f, 0.0f);

	glGetFloatv (GL_MODELVIEW_MATRIX, _matrix);
	glPopMatrix ();
	updateOBB ();

	return (_x > OFFSCREEN);
	
}

void
DeathBlossom::updateOBB (void)
{
	static GLfloat halfwidths[] = { 
		4.0f, 4.0f, 4.0f,
		1.0f, 4.0f, 4.0f,
		4.0f, 1.0f, 1.0f
	};
	static GLfloat offsets[] = {
		 0.0f, 0.0f, 0.0f,
	};
	_coarse.update(_matrix, halfwidths, offsets);
	_fine[0].update(_matrix, halfwidths+3, offsets);
	_fine[1].update(_matrix, halfwidths+6, offsets);
	updateMask (_x - 6, _x + 6);
}

bool
DeathBlossom::takeHit (EntityFarm *expl_farm) {
	kill ();
	play_sfx (MEDIUM_EXPLOSION_SOUND);
	expl_farm->registerEntity (new Explosion (_x, _y, _z, 500, 0.5f));
	return true;
}
