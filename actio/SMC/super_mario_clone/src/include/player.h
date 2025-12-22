/***************************************************************************
                player.h  -  header for the corresponding cpp file
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

#ifndef __PLAYER_H__
#define __PLAYER_H__

// ### - Mario states

// normal
#define MARIO_DEAD 0
#define MARIO_SMALL 1
#define MARIO_BIG 2
#define MARIO_FIRE 3

// todo :with Yoshi
#define MARIO_YOSHI_SMALL 11

// todo : with dog
#define MARIO_DOG_SMALL 21

// ###

#include "include/globals.h"

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

// cFireball class
class cFireball : public cSprite
{
public:
	cFireball( double x, double y, double fvelx );
	virtual ~cFireball( void );

	virtual void Update( void );
	
	// the fireball got destroyed
	bool bDestroy;

	// The firball image pointer	
	SDL_Surface *img[4];

	// used for the rotation animation
	double counter;
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

// The Player class
class cPlayer : public cSprite
{
public:
	cPlayer( double x, double y );
	virtual ~cPlayer( void );

	// lets the Player walk, this->direction sets the direction
	void Walk( double velwalk, double maxvel, double velwrongway );

	// lets the Player hold in
	void Hold( void );

	// Lets the Player duck
	void Duck( void );

	// updates everything, called every frame
	void Update( void );

	// draws the player with the imgnr ( see images[] )
	void DrawP( int imgnr );

	// loads the images depending on -> iSize
	void LoadImages( bool preload = 0 );

	// Starts a jump with the given values
	void StartJump( double Power = 17.0, double Acc_up = 4.0, double vel_deAcc = 0.06 );

	// lets the Player jump
	void JumpStep( void );

	void Die( void );

	/*	The Player gets the following Item.
	 *	if force is true the player will use the item directly
	 *	and it will not be placed in the Itembox
	 */
	void Get_Item( unsigned int Item_type, bool force = 0 );
	
	// Adds an Fireball
	void Add_Fireball( void );

	// Destroys all Fireballs
	void Unload_Fireballs( void );
	
	// Resets the complete game state
	void ResetSave( void );

	// resets only mario's state
	void Reset( void );

	// Exits the level and walks to the next Overwold waypoint
	void GotoNextLevel( void );
	
	/*		Marios current Size
	 *  0 : MARIO_DEAD
	 *  1 : MARIO_SMALL
	 *  2 : MARIO_BIG
	 *  3 : MARIO_SUPER
	 */
	int iSize; 

	// true if player debugging is active	
	bool debugmode; 

	// The time mario gets invincible
	double invincible;
	// The invincible drawing modifier
	double invincible_mod; 

	// for mario's walking animation
	double walk_count;
	int state, lives;
	// Images of mario pointer
	SDL_Surface *images[15];

	// the jump activator
	bool startjump, start_enemyjump;
	// Acceleration if Up key is pressed
	double jump_Acc_up; 
	// Vely De Acceleration use 0.05 - 0.08.
	double jump_vel_deAcc; 

	// if mario is ducked
	bool ducked;
	// the current goldpieces collected
	int goldpieces;
	// the current points collected
	long points;
	/// the next jump power
	double jump_power;

	// Mario's Fireballs
	cFireball *fire[2]; 
};

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

#endif
