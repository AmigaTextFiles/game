/*
 *  Bubble Train
 *  Copyright (C) 2004  
 *  					Adam Child (adam@dwarfcity.co.uk)
 * 						Craig Marshall (craig@craigmarshall.org)
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *
 */

/*
 * The cannon uses a bullet factory to load a stream of bullet into the cannon
 * before the user fires a bullet at the train.
 * Can be used with either the mouse or keys
 */
 
#ifndef CANNON_H
#define CANNON_H

// System includes
#include <math.h>

// Game includes
#include "General.h"
#include "Bullet.h"
#include "BulletFactory.h"
#include "ILoadSave.h"

// Constansts
#define ROTATION_STEP 	M_PI_2 / 30			// Define the amount moved in radians when using the keys
#define LEFT_LIMIT 		M_PI_2				// Define the angle limits
#define RIGHT_LIMIT 	-M_PI_2
#define CANNON_ROUND_ERROR		M_PI / 360	// Define an error rate when comparing floats
#define CANNON_LENGTH	45					// Define the length of cannon for position the loaded bullet

class Cannon: public ILoadSave
{
private:
	
	float angle; 							// zero angle is pointing upwards
    Point position;							// The position the cannon is rotated around
    Uint32 bulletSpeed;						// speed in pixels per frame
    Uint32 bulletRate;  					// amount of time (ms) between firing
    Uint32 lastBulletFired;					// time the last bullet was fired in ticks - used for reload timings
    BulletFactory* cannonMagazine;			// Bullet feed for the cannon
    Bullet* loadedBullet;					// The bullet loaded into the cannon
    Bullet* nextBullet;   					// The bullet which is next in line to be loaded
    bool useMouse;							// Flag on whether using the mouse or the keys
    int mouseSensitivity;					// Sensitivity of the mouse in the distance travelled to the amount moved

    void setLoadedBulletPos();				// Set the position of the loaded bullet for when the cannon is moving
    void setNextBulletPos();				// Set the position of the next bullet next to the cannon
    void moveMouse();						// Move the cannon relative to the mouse position
public:

	Cannon();
	Cannon(Point position);
	virtual ~Cannon();
	
	float getAngle();
	Point getPosition();
	bool canFireBullet(); // This gives the cannon time to reload
	void setBulletRate(Uint32 rate);
	void setBulletSpeed(Uint32 speed);
	void animate(LevelState state);
	bool getUseMouse();
	void setUseMouse(bool mouse);
	
	// ILoad save
	virtual void load(xmlDocPtr doc, xmlNodePtr cur);
	virtual void load(const char* path, const char* filename);
	virtual void save(xmlDocPtr doc, xmlNodePtr cur);
	virtual void save(const char* path, const char* filename);
	
	void draw(SDL_Surface* screen);
	
	Bullet* peakNextBullet();
	Bullet* fireBullet();
    void rotateLeft();
    void rotateRight();
};

#endif // CANNON_H
