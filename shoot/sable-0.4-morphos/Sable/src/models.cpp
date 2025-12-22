/*
 *  SABLE
 *  Copyright (C) 2003 Michael C. Martin.
 *
 *  models.cpp: The actual geometric data for the objects in the game.
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
#include "models.h"

GeomPlayer geomPlayer;
GeomEnemy geomEnemy;
GeomPylon geomPylon;
GeomTransparentPylon geomTransparentPylon;
GeomBullet geomBullet;
GeomDeathBlossom geomDeathBlossom;

static GLfloat ego_v[] = {
	 0.0f,   7.0f,  1.0f, // 0
	-2.0f,   1.0f,  1.0f, // 1
	-1.0f,   1.0f,  1.0f, // 2
	 0.0f,   2.0f,  1.0f, // 3
	 0.0f,   1.0f,  2.0f, // 4
	 1.0f,   1.0f,  1.0f, // 5
	 2.0f,   1.0f,  1.0f, // 6
	 8.0f,  -7.0f, -2.0f, // 7
	 0.0f,  -5.0f,  1.0f, // 8
	-8.0f,  -7.0f, -2.0f, // 9
	-1.0f,  -5.0f, -1.0f, // 10
	 1.0f,  -5.0f, -1.0f, // 11
	 0.0f,   5.0f,  0.0f, // 12
};

static GLfloat ego_n[] = {
	 0.0f,  2.0f,  1.0f, // 0
	-1.0f,  1.0f,  0.0f, // 1
	-1.0f,  0.5f,  1.0f, // 2
	 0.0f,  1.0f,  1.0f, // 3
	 0.0f,  0.0f,  1.0f, // 4
	 1.0f,  0.5f,  1.0f, // 5
	 1.0f,  1.0f,  0.0f, // 6
	 1.0f, -0.5f,  0.0f, // 7
	 0.0f, -1.0f,  1.0f, // 8
	-1.0f, -0.5f,  0.0f, // 9
	-0.2f, -1.0f, -1.0f, // 10
	 0.2f, -1.0f, -1.0f, // 11
	 0.0f,  0.5f, -1.0f, // 12		
};

static GLuint ego_i[] = {
	0,1,2,  0,2,3,  0,3,5,  0,5,6,  1,8,2,  2,8,4,   4,8,5,    5,8,6,
	8,7,6,  1,9,8,  0,12,1, 0,6,12, 12,6,7, 12,7,11, 12,11,10, 12,10,9,
	12,9,1, 9,10,8, 11,7,8,

	2,4,3,  4,5,3,

	10,11,8
};

GeomPlayer::GeomPlayer (void) : Geometry(13, ego_v, ego_n, 66, ego_i)
{
}

void
GeomPlayer::render (void)
{
	static GLfloat frame_color[] = { 0.3f, 0.1f, 0.5f, 1.0f };
	static GLfloat cockpit_color[] = { 0.25f, 0.0f, 0.75f, 1.0f };
	static GLfloat thrust_color[] = { 0.5f, 0.5f, 0.5f, 1.0f };
	static GLfloat no_light[] = { 0.0f, 0.0f, 0.0f, 1.0f };
	static GLfloat thrust_light[] = { 1.0f, 1.0f, 0.0f, 1.0f };
	static GLfloat white_color[] = {0.8f, 0.8f, 0.8f, 1.0f};

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, frame_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, frame_color);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, no_light);
	glDrawElements( GL_TRIANGLES, 57, GL_UNSIGNED_INT, _indices );

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, cockpit_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, white_color);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 100.0);
	glDrawElements( GL_TRIANGLES, 6, GL_UNSIGNED_INT, _indices+57 );
	
	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, thrust_color);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, thrust_light);
	glDrawElements( GL_TRIANGLES, 3, GL_UNSIGNED_INT, _indices+63 );
}

static GLfloat enm_v[] = {
		0, -4, 0, 
		5, -1, 1, 
		-5, -1, 1,
		-5, -1, -1,
		5, -1, -1,
		-6, -7, -3,
		-6, -7, 3,
		-8,0,0,
		6,-7,-3,
		8,0,0,
		6,-7,3,
		0,4,0,
		-5,1,1,
		5,1,1,
		5,1,-1,
		-5,1,-1,
		6,7,-3,
		6,7,3,
		-6,7,-3,
		-6,7,3,
		0,0,2,
		0,-1,1,
		2,0,1,
		-2,0,1,
		0,1,1
};

static GLfloat enm_n[] = {
		0.0f, -1.0f, 0.0f,  // 0
		-1.0f, -2.0f, 0.5f, // 1
		1.0f, -2.0f, 0.5f,  // 2
		1.0f, -2.0f, -0.5f,  // 3
		-1.0f, -2.0f, -0.5f, // 4
		0.5f, -5.0f, -3.0, // 5
		0.5f, -5.0f, 3.0, // 6
		-1.0f, 0.0f, 0.0f, // 7
		-0.5f, -5.0f, -3.0, // 8
		1.0f, 0.0f, 0.0f, // 9
		-0.5f, -5.0f, 3.0, // 10
		0.0f, 1.0f, 0.0f,  // 11
		1.0f, 2.0f, 0.5f,  // 12
		-1.0f, 2.0f, 0.5f, // 13
		-1.0f, 2.0f, -0.5f, // 14
		1.0f, 2.0f, -0.5f,  // 15
		-0.5f, 5.0f, -3.0f, // 16
		-0.5f, 5.0f, 3.0f, // 17
		0.5f, 5.0f, -3.0f, // 18
		0.5f, 5.0f, 3.0f, // 19
		0.0f, 0.0f, 1.0f, // 20
		0.0f, -1.0f, 1.0f, // 21
		1.0f, 0.0f, 1.0f, // 22
		-1.0f, 0.0f, 1.0f, // 23
		0.0f, 1.0f, 1.0f, // 24		
};

static GLuint enm_i[] = {
	0,1,2,    1,13,2,   2,13,12,  11,12,13, 0,3,4,    3,15,4,
	4,15,14,  11,14,15, 0,4,1,    0,2,3,    11,15,12, 11,13,14,
	2,5,3,    2,6,5,    5,6,7,    7,6,19,   6,2,12,   6,12,19,
	7,18,5,   3,5,15,   15,5,18,  12,18,19, 15,18,12, 19,18,7,
	1,8,10,   4,8,1,    14,13,16, 16,13,17, 16,17,9,  8,9,10,
	1,10,13,  13,10,17, 10,9,17,  4,14,8,   8,14,16,  8,16,9,

	20,21,22, 20,23,21, 20,22,24, 20,24,23
};

GeomEnemy::GeomEnemy (void) : Geometry(25, enm_v, enm_n, 120, enm_i)
{
}

void
GeomEnemy::render (void)
{
	static GLfloat frame_color[] = { 0.9f, 0.1f, 0.1f, 1.0f };
	static GLfloat cockpit_color[] = { 0.25f, 0.0f, 0.75f, 1.0f };
	static GLfloat no_light[] = { 0.0f, 0.0f, 0.0f, 1.0f };
	static GLfloat white_color[] = {0.8f, 0.8f, 0.8f, 1.0f};

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, frame_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, frame_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, no_light);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);
	glDrawElements( GL_TRIANGLES, 108, GL_UNSIGNED_INT, _indices );

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, cockpit_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, white_color);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 100.0);
	glDrawElements( GL_TRIANGLES, 12, GL_UNSIGNED_INT, _indices+108 );
}

static GLfloat pylon_v[] = {
	-5,-75,-5, 5,-75,-5, 5,-75,5, -5,-75,5,
	-5,75,-5, 5,75,-5, 5,75,5, -5,75,5 };

static GLfloat pylon_n[] = {
	-1,1,-1, 1,1,-1, 1,1,1, -1,1,1,
	-1,1,-1, 1,1,-1, 1,1,1, -1,1,1 };

static GLuint pylon_i[] = {
	0,3,7,4, 3,2,6,7, 2,1,5,6, 4,5,1,0, 7,6,5,4
};

GeomPylon::GeomPylon (void) : Geometry(8, pylon_v, pylon_n, 20, pylon_i)
{
}

void
GeomPylon::render (void)
{
	static GLfloat pylon_color[] = { 0.5, 0.5, 0.5, 1.0 };
	static GLfloat no_light[] = { 0.0, 0.0, 0.0, 1.0 };

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, pylon_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, pylon_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, no_light);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);
	glDrawElements( GL_QUADS, 20, GL_UNSIGNED_INT, _indices );
}

GeomTransparentPylon::GeomTransparentPylon (void) : Geometry(8, pylon_v, pylon_n, 20, pylon_i)
{
}

void
GeomTransparentPylon::render (void)
{

	static GLfloat pylon_color[] = { 0.5, 0.5, 0.5, 0.5 };
	static GLfloat no_light[] = { 0.0, 0.0, 0.0, 1.0 };

	glEnable (GL_BLEND);
	glBlendFunc (GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, pylon_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, pylon_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, no_light);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);

	glDrawElements( GL_QUADS, 20, GL_UNSIGNED_INT, _indices );
	glDisable (GL_BLEND);
}

static GLfloat bullet_v[] = {
	 0.00f,  1.00f,  1.00f,
	 0.00f, -1.00f,  1.00f,
	 0.00f, -1.00f, -1.00f,
	 0.00f,  1.00f, -1.00f,
	-4.00f,  0.00f,  0.00f };

static GLfloat bullet_n[] = {
	1, 1, 1,
	1, -1, 1,
	1, -1, 1,
	1, -1, -1,
	1, 1, -1,
	-1, 0, 0 };

static GLuint bullet_i[] = {
	0,1,3, 1,2,3, 4,1,0, 1,4,2, 0,3,4, 3,2,4 };

GeomBullet::GeomBullet (void) : Geometry (5, bullet_v, bullet_n, 18, bullet_i)
{
}

void
GeomBullet::render (void)
{
	static GLfloat color[] = { 0.5, 0.5, 0.5, 1.0 };

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, color);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);
	glDrawElements( GL_TRIANGLES, 18, GL_UNSIGNED_INT, _indices );
}

static GLfloat blossom_v[] = {
	-1,4,-4,
	-1,2,0,
	-1,4,4,
	-1,0,2,
	-1,-4,4,
	-1,-2,0,
	-1,-4,-4,
	-1,0,-2,
	-2,1,0,
	-2,0,1,
	-2,0,-1,
	-2,-1,0,
	-4,1,0,
	-4,0,1,
	-4,0,-1,
	-4,-1,0,
	4,1,0,
	4,0,1,
	4,-1,0,
	4,0,-1 };

static GLfloat blossom_n[] = {
	-1,-1,-1,
	-1,1,0,
	-1,-1,1,
	-1,0,1,
	-1,-1,1,
	-1,-1,0,
	-1,-1,-1
	-1,0,1,
	-1,1,0,
	-1,0,1,
	-1,0,-1,
	-1,-1,0,
	-1,1,0,
	-1,0,1,
	-1,0,-1,
	-1,-1,0,
	1,1,0,
	1,0,1,
	1,-1,0,
	1,0,-1 };

static GLuint blossom_i[] = {
	0,7,1, 2,1,3, 4,3,5, 6,5,7, 1,7,8, 1,8,3, 3,8,9, 3,9,11,
	5,3,11, 5,11,7, 7,11,10, 7,10,8, 0,19,7, 0,16,19, 0,1,16,
	2,16,1, 2,17,16, 2,3,17, 4,17,3, 4,18,17, 4,5,18, 6,18,5,
	6,19,18, 6,7,19, 

	12,9,8, 13,9,12, 13,11,9, 13,15,11, 
	12,8,9, 13,12,9, 13,9,11, 13,11,15,
	12,8,10, 12,10,14, 10,15,14, 10,11,15, 
	12,10,8, 12,14,10, 10,14,15, 10,15,11,

	8,11,9, 8,10,11, 16,17,18, 16,18,19 };

GeomDeathBlossom::GeomDeathBlossom (void) : Geometry(20, blossom_v, blossom_n, 132, blossom_i)
{
}

void
GeomDeathBlossom::render (void)
{
	static GLfloat frame_color[] = { 0.5f, 0.3f, 0.1f, 1.0f };
	static GLfloat cannon_color[] = { 0.5f, 0.2f, 0.2f, 1.0f };
	static GLfloat thrust_color[] = { 0.5f, 0.5f, 0.5f, 1.0f };
	static GLfloat no_light[] = { 0.0f, 0.0f, 0.0f, 1.0f };
	static GLfloat thrust_light[] = { 1.0f, 1.0f, 0.0f, 1.0f };

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, frame_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, frame_color);
	glMaterialf  (GL_FRONT_AND_BACK, GL_SHININESS, 50.0);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, no_light);
	glDrawElements( GL_TRIANGLES, 72, GL_UNSIGNED_INT, _indices );

	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, cannon_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_SPECULAR, cannon_color);
	glDrawElements( GL_TRIANGLES, 48, GL_UNSIGNED_INT, _indices+72 );
	
	glMaterialfv (GL_FRONT_AND_BACK, GL_AMBIENT_AND_DIFFUSE, thrust_color);
	glMaterialfv (GL_FRONT_AND_BACK, GL_EMISSION, thrust_light);
	glDrawElements( GL_TRIANGLES, 12, GL_UNSIGNED_INT, _indices+120 );
}
