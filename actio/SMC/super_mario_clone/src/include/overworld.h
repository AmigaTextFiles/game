/***************************************************************************
                overworld.h  -  header for the corresponding cpp file
                             -------------------
    copyright            : (C) 2003-2005 by FluXy
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/ 

// OverWorld V.0.9.7

#ifndef __OVERWORLD_H__
#define __OVERWORLD_H__

// Maximum Waypoints per Overworld map
#define MAX_WAYPOINTS 200
#define MAX_OVERWORLDS 32

// Waypoint types
#define WAYPOINT_NORMAL 1
#define WAYPOINT_SPECIAL 2
#define WAYPOINT_SECRET 3


#include "include/globals.h"

/* *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** */

// The Waypoint class
class cWaypoint
{
public:
	cWaypoint( void );
	~cWaypoint( void );
	
	void Init( void );

	void Draw( void );

	SDL_Rect rect;

	int direction_back, direction_forward;
	/*	direction back and forward
	 * -1 = First
	 * -2 = Last
	 */ 

	SDL_Surface *arrow_white_l, *arrow_white_r, *arrow_white_u, *arrow_white_d; // Arrow White images
	SDL_Surface *arrow_blue_l, *arrow_blue_r, *arrow_blue_u, *arrow_blue_d; // Arrow Blue images

	SDL_Surface *water, *land; // The type images

	int type; // Normal ,Water ,Special ,etc...
	string levelname; // The Levelname

	int ID; // identifier

	bool access; // if Mario can go to there !

	int gcolor; // color for the glim effect
	bool glim; // glim effect variable
};

// The Layer class
class cLayer
{
public:
	cLayer( void );
	cLayer( char *filename );
	~cLayer( void );

	int x,y; // Todo
	SDL_Surface *image;
};

// The OverWorld class
class cOverWorld
{
public:
	cOverWorld( void );
	~cOverWorld( void );
	
	void Enter( void ); // Enters da OverWorld
	
	void LoadOverWorld( unsigned int overworld ); // Loads an OverWorld
	void UnloadOverWorld( void ); // Unloads an OverWorld
	void LoadMap( void ); // Todo : Loads an map from the current OverWorld
	
	void LoadMarioImages( void ); // Loads the Mario Animations
	void UnloadMarioImages( void ); // Unloads the Mario Animations

	bool SetMarioDirection( int direction ); // Sets the Mario direction returns 0 if the next level is not accessable or not available
	int SetMarioPos( int Waypoint ); // Sets Overworld Mario's Position on the given Waypoint

	void UpdateCamera( void ); // Updates the Camera

	int WaypointCollision( cSprite *s2 ); // Tests all Waypoints for an Collision
	
	// ToDo : The Secret Way
	int GotoNextLevel( bool Secretpath = 0 );

	// Settings
	int Nlevel; // The last Normal level Waypoint of the Map which the Player can access
	int Slevel; // Todo : Secret Waypoint
	
	int Map; // Current Overworld Map
	int last_Map; // The last Map of this OverWorld
	
	SDL_Surface *Debugimage; // The Debug Text
	SDL_Surface *Debugimage_shadow; // The Debug Text Shadow
	SDL_Surface *DebugWaypoint; // The DebugWaypoint Text
	SDL_Surface *DebugWaypoint_shadow; // The DebugWaypoint Text Shadow
	SDL_Surface *DebugNlevel; // The DebugWaypoint Text
	SDL_Surface *DebugNlevel_shadow; // The DebugWaypoint Text Shadow

	bool showlayer; // Draws the Layer if in Debugmode
	bool cameramode; // if User wants to scroll in the map
	
	// Waypoints
	cWaypoint *Waypoints[MAX_WAYPOINTS]; // Max WayPoints on the current map
	int Current_Waypoint; // The Current Waypoint of the Player
	int Waypointcount;// The last Waypoint of the current Map
	
	// OverWorld
	int Current_OverWorld; // The Current OverWorld
	int OverWorld_Count; // Available Overworlds
	char **OverWorlds; // OverWorld filenames
	
	cSprite **MapObjects; // All the Images
	int MapObjectCount; // Object Image Count
	
	cLayer *Layer; // The Current Color Layer
	
	// Mario
	cSprite *Mario; // The Mario animation
	
	SDL_Surface *Mario_Anims[5]; // Maximum of 5 animations
	int Mario_Anim_counter; // Animation counter
	int Mario_Anim_Max; // The Last/Max image available for the animation
	int Mario_Anim_Speed; // The Animation Speed
	bool Mario_fixed_walking; // if Mario touches an Waypoint ...
	
private:
	void GetMap( char *command, int line ); // Gets all the Map Items
	void AddMapObject( cSprite* obj ); // Adds an Sprite Map Object

	void UpdateMario( void ); // Update Mario

	void DrawMapObjects( void ); // Draws all Objects
	void DrawMario( void ); // Draw Mario
	void DrawWaypoints( void ); // Draw all Waypoints
	void DrawHUD( void ); // Draws the HUD
	void DrawDebug( void ); // Draws the Debug Stuff ( if Debugmode )

	void WaypointWalk( void ); // For fixed walking into the Waypoint
	void MarioWalk( int px, int py, int xspeed, int yspeed = 0 ); // Mario Walk
};

#endif
