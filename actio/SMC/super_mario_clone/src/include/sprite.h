/***************************************************************************
                sprite.h  -  header for the corresponding cpp file
                             -------------------
    copyright            : (C) 2003-2004 by Artur Hallmann, (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

#ifndef __SPRITE_H__
#define __SPRITE_H__

#include "include/globals.h"

/* *** *** *** *** *** *** *** ## Types ## *** *** *** *** *** *** *** *** *** *** */

// global
#define TYPE_SPRITE 1
#define TYPE_ENEMY 2
#define TYPE_PLAYER 3
#define TYPE_ACTIVESPRITE 4
#define TYPE_HALFMASSIVE 5

// Level objects
#define TYPE_LEVELEXIT 18
#define TYPE_ENEMYSTOPPER 20
#define TYPE_BONUSBOX_MUSHROOM_FIRE 26
#define TYPE_BONUSBOX_LIVE 31
#define TYPE_GOLDBOX 21
#define TYPE_SPINBOX 27

// other
#define TYPE_FIREBALL 28
#define TYPE_CLOUD 7

// Enemy
#define TYPE_GOOMBA_BROWN 10
#define TYPE_GOOMBA_RED 11
#define TYPE_TURTLE_RED 19
#define TYPE_JPIRANHA 29
#define TYPE_BANZAI_BILL 30
#define TYPE_REX 36

// Items
#define TYPE_POWERUP 23
#define TYPE_MUSHROOM_DEFAULT 25
#define TYPE_MUSHROOM_LIVE_1 35
#define TYPE_FIREPLANT 24
#define TYPE_BOUNCINGGOLDPIECE 22
#define TYPE_GOLDPIECE 8
#define TYPE_MOON 37

// Hud
#define TYPE_STATUSTEXT 9
#define TYPE_POINTDISPLAY 12
#define TYPE_GAMETIMEDISPLAY 13
#define TYPE_DEBUGDISPLAY 14
#define TYPE_LIFEDISPLAY 15
#define TYPE_GOLDDISPLAY 16
#define TYPE_MENUBG 17
#define TYPE_ITEMBOXDISPLAY 32

// ## Array ##
#define ARRAY_MASSIVE 1
#define ARRAY_PASSIVE 2
#define ARRAY_ENEMY 3
#define ARRAY_ACTIVE 4
#define ARRAY_HUD 5
#define ARRAY_ANIM 6

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cSprite
{
public:
	cSprite( SDL_Surface *new_image, double x, double y );
	virtual ~cSprite( void );

	void SetImage( SDL_Surface *new_image, bool new_Startimage = 0 );
	void SetPos( double x, double y );

	// returns the Collision direction if not forced
	int Move( double move_x, double move_y, bool real = 0, bool force = 0 );
	void AddVel( double move_x, double move_y, bool real = 0 );
	
	virtual void Draw( SDL_Surface *target );

	// Checks if the Sprite is Visible on the Screen
	bool Visible_onScreen( void ); 

	// Checks if the given Position is valid
	bool PosValid( int x, int y, int w = 0, int h = 0, bool only_check = 0, bool Debug_Draw = 0 );

	// Default Collision Routine
	int CollideMove( void );
	
	// Sets the collision direction
	void GetCollid( SDL_Rect *r2 );

	virtual void Update( void );
	
	virtual void PlayerCollision( int cdirection );
	virtual void EnemyCollision( int cdirection );
	virtual void BoxCollision( int cdirection, SDL_Rect *r2 );

	virtual void Die( void );

	SDL_Surface *image;
	SDL_Surface *StartImage;
	SDL_Rect rect;

	double velx, vely, posx, posy, startposx, startposy;

	// the sprite type
	int type;
	
	/* Sprite Array type
	 * 1 = ARRAY_MASSIVE
	 * 2 = ARRAY_PASSIVE
	 * 3 = ARRAY_ENEMY
	 * 4 = ARRAY_ACTIVE
	 * 5 = ARRAY_HUD
	 * 6 = ARRAY_ANIM
	 */
	int Array;

	// The current direction
	int direction;

	// 0 : falling , 1 : onground massive , 2 : onground halfmassive	
	int onGround;

	// the collision direction	
	int collid;

	// The collision directions
	bool collidtop, collidbottom, collidright, collidleft;

	/*	The Colliding Object type
	 * 1 : Massive
	 * 2 : Active
	 * 3 : Enemy
	 * 4 : Player
	 * 5 : Passive
	 * 6 : Leveleditor Item Object
	 * 7 : Leveleditor Main Menu Object
	 * 8 : Leveleditor Item Object Scroller
	 * 10 : A Dialog Box
	 */	
	int iCollisionType;

	// The Colliding Object number	
	int iCollisionNumber;

	// is it halfmassive	
	bool halfmassive;

	// is it massive
	bool massive;

	// is it visible	
	bool visible;

	// if this Object got spawned it shouldn't be saved !
	bool spawned; 

	// the different states e.g. walking,running and flying
	int state;

	// the unique random ID
	int ID;
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cActiveSprite : public cSprite
{
public:
	cActiveSprite( double x, double y );
	virtual ~cActiveSprite( void );

	virtual void PlayerCollision( int direction );
	virtual void EnemyCollision( int direction );
	virtual void BoxCollision( int direction, SDL_Rect *r2 );

	virtual void Update( void );
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cMouseCursor : public cSprite
{
public:
	cMouseCursor( double x, double y );
	virtual ~cMouseCursor( void );

	bool CollsionCheck ( double x, double y );

	// Updates the Mousecursor
	virtual void Update( void );

	// Updates the Mouse Position
	void Update_Position( void );

	// Updates the Double Click event
	void Update_Doubleclick( void );

	// Updates the Mouseobject position
	void MouseObject_Update( void );

	// The user double clicked
	void Double_Click( void );

	// Sets the active Object
	void Set_Active( unsigned int type, unsigned int number );

	// Resets the active Object
	void Reset_Active( void );

	// Copies the Object
	void Copy( cSprite *nCopyObject, double x, double y );

	// Deletes the current colliding Object
	void Delete( void );

	// Draws lines around the currently hoverd Object
	void Draw_HoveredObject( void );

	// Updates the Mover Mode
	void Mover_Update( Sint16 move_x, Sint16 move_y );

	// Updates the Leveleditor Mouse
	void Editor_Update( void );
	
	// The image if in mover mode
	SDL_Surface *Mover_mouse;
	
	// The Hoverobject Rect
	SDL_Rect HoveredObject;
	
	// if activated the mouscursor movement moves the screen	
	bool mover_mode;

	// The currently colliding Object
	cSprite *MouseObject;

	// The Object selected for copying
	cSprite *CopyObject;

	// The Additional Mouse Object Position
	int mouse_W, mouse_H;

	// The Pressed Buttons
	bool MousePressed_left, MousePressed_right;

	// fastcopy mode
	bool fastCopyMode;

	// The conter for catching double-clicks
	double clickcounter;

	// The Active Object information
	int active_type, active_number;
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

class cEnemyStopper : public cSprite
{
public:
	cEnemyStopper( double x, double y );
	virtual ~cEnemyStopper( void );
	
	virtual void Draw( SDL_Surface *target );
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
