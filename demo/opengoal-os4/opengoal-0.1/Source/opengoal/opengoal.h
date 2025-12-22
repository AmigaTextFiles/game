/***************************************************************************
                          opengoal.h  -  description
                             -------------------
    begin                : Sat Jul 20 2002
    copyright            : (C) 2002 by Paul Robson
    email                : autismuk@autismuk.freeserve.co.uk
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <SDL.h>
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <math.h>

#ifdef HAVE_CONFIG_H
#include <config.h>
#endif

#define AUTHOR  "Paul Robson (autismuk@autismuk.freeserve.co.uk)"
#define XEXT    (8192)                      // Max Extent across pitch (centre of pitch is 0,0)
#define YEXT    (8192)                      // Max Extent up/down pitch
#define ZEXT    (8192)                      // Max extent up in the air

#define XPCB    (2)                         // Percent of width used for border (horizontally)
#define YPCB    (8)                         // Percent of width used for border/goal nets (vertically)

#define XPENALTY (XEXT/2)                   // Penalty area position (corner of area)
#define YPENALTY (YEXT*3/5)
#define XGOAL   (XEXT/4)                    // Goalpost position (horizontal)
#define CSRAD   (XEXT/7)                    // Centre circle radius
#define PSRAD   (XEXT/8)                    // Penalty area circle vertical radius

#define DEF_XVP (640)                       // Default viewport size (pels)
#define DEF_YVP (480)
#define DEF_XPC (DEF_XVP*2)                 // Default pitch size (pels)
#define DEF_YPC (DEF_YVP*9/2)

#define SCAN_X      (5)                     // Position and Size Scanner (as % of viewport)
#define SCAN_Y      (5)
#define SCAN_W      (20)
#define SCAN_H      (35)

#define DEF_XSPC    (XEXT/16)               // Size of player sprite in pitch units in X and Y axis
#define DEF_YSPC    (YEXT/20)

#define DEF_SPCOL   (16)                    // Number of sprite columns - 8 rotation,2 animation
#define DEF_SPROW   (5)                     // Sprite Rows (ball,goalie,team1,team2,marker)

#define TEAMA       (0)
#define TEAMB       (1)

#define SPRID_TEAM1  (0)                    // Team 1 (row 2)
#define SPRID_TEAM2  (1)                    // Team 2 (row 3)
#define SPRID_BALL   (2)                    // Ball (row 0)
#define SPRID_GOALIE (3)                    // GOalie (row 1)
#define SPRID_MARKER (4)                    // The marker
#define SPRBALLSC   (60)                    // Percent size of ball->Normal Sprite (grounded)

#define DEF_IQ      (20)                    // Default intelligence
#define DEF_SPEED   (50)                    // Default speed

#define DRIBPC      (66)                    // Percentage dribbling move of normal move
#define XMOVE       (XEXT/64)               // Maximum moves allowed per player move.
#define YMOVE       (YEXT/64)

#define MAXSPR      (24)                    // Max number of sprites
#define MAXKEY      (1024)                  // Max SDLKey value (is this anywhere ?)

typedef struct _Point3D                     // A 3 coord structure for allsorts
{
    int x,y,z;                              // often Z is ignored :)

} POINT3D;

typedef struct _DrawInfo
{
    SDL_Surface *ViewPort;                  // The screen display viewport
    POINT3D VPSize;                         // Size of the viewport in pixel units
    SDL_Surface *Pitch;                     // The pitch surface
    POINT3D PitchSize;                      // Size of the pitch in units
    int Depth;                              // Depth of display
    POINT3D PitchTL;                        // Physical pixel position of top left on viewport
    SDL_Surface *Sprites;                   // Display sprite grid
    POINT3D SpriteSize;                     // Size of player sprites
    int ColourKey;                          // Transparent Colour Key
    int SpriteCount;                        // Number of sprites
    POINT3D SpritePos[MAXSPR];              // The sprites available
    int     SpriteID[MAXSPR];               // Their display values
    int     Rotate[MAXSPR];                 // Their rotate values
    SDL_Rect rcScanner;                     // Scanner Rectangle
    SDL_Surface *Scanner;                   // Scanner surface
    int     KeyState[MAXKEY];               // Key states
    int     SpriteCol[DEF_SPROW];           // Colours for scanner
} DRAWINFO;

typedef enum _Action                        // What a player can be doing
{
    A_MOVETOKICKOFF,                        // I am moving back to assigned kick off position
    A_MOVING,                               // Moving towards a specific position
    A_CHASEBALL,                            // I am currently chasing the ball
    A_DRIBBLE,                              // I am currently dribbling (and have the ball)
    A_WAITFORDEADBALL,                      // I am waiting for dead ball kick.
    A_TAKEDEADBALLKICK,                     // I am going to take the dead ball kick
    A_WAITING,                              // I am waiting for a new state decision
    A_GOALKEEPER,                           // I am the goalkeeper and don't do the above
} ACTION;

typedef enum _TeamRole                      // The things i can do.... self explanatory expandable
{                                           // adding player types will cause ERROR() where code needs
    TR_GOALKEEPER,                          // to come in.
    TR_DEFENDER,
    TR_MIDFIELD,
    TR_STRIKER
} TEAMROLE;

typedef struct _Player                      // Defines a single player
{
    struct _Player *Next;                   // Next player in the list (or NULL)
    int    Team;                            // Team (SPRI_TEAM1 or SPRI_TEAM2)
    ACTION Action;                          // What I am now doing
    POINT3D Pos;                            // Where I am
    POINT3D KickOffPos;                     // Where I started at kick off
    POINT3D Target;                         // Where I am going
    TEAMROLE Role;                          // What I do in this team
    int     *HaveBall;                      // Do we have the ball
    int     Intelligence;                   // The chance of my action changing, per move.
    int     Speed;                          // How often I move (milliseconds)
    int     NextMove;                       // The time of my next move (millisecs/sys clock)
    int     Rotate;                         // My current rotation
    int     Controller;                     // Controller ID
    int     AnimFrame;                      // Animation Frame
} PLAYER;

typedef struct _NewPlayer                   // This structure is used to create a new player
{
    TEAMROLE Role;                          // role
    int xPercent;                           // horizontal % pos
    int Intelligence;                       // brains
    int Speed;                              // pace
} NEWPLAYER;

typedef struct _Game                        // Game descriptor
{
    PLAYER *PList;                          // List of players
    DRAWINFO *DrawInfo;                     // All the hardware information
    POINT3D Ball;                           // Ball current position on the pitch
    int TeamHasBall[2];                     // Does the team have the ball ?
} GAME;

int INITDraw(DRAWINFO *g,int argc,char **argv);
void INITDrawPitch(SDL_Surface *s,POINT3D Size);
void INITConvert(POINT3D *p,POINT3D Size);

void REDRepaint(DRAWINFO *g);
int  REDLogicalToViewPort(POINT3D *p,DRAWINFO *hw);

void SPRCreateSprites(DRAWINFO *g,int Keeper,int Team1,int Team2);
void SPRCreate(DRAWINFO *g,SDL_Surface *s,int Sprite,int Rotate,SDL_Rect *rc,int Colour);
void SPRDraw(DRAWINFO *g,POINT3D *Point,int Sprite,int Frame);

void UTLAbort(int Line,char *File);
void UTLPollKeyboard(DRAWINFO *d);
int  UTLClock(void);
void UTLGetDirection(int d,POINT3D *p);
int UTLDistance(POINT3D *p1,POINT3D *p2);


GAME *GAMECreate(DRAWINFO *d);
void GAMEDestroy(GAME *g);
void GAMEAddPlayer(GAME *g,int Team,NEWPLAYER *Info);
void GAMERepaint(GAME *g);
void GAMEAddTeam(GAME *g,int Team,int Formation,int Skill);
void GAMESetBallPosDribble(GAME *g);
void GAMESetupMoveToKickOff(GAME *g,int MoveEdge);
void GAMEMoveAllPlayers(GAME *g);

void PLAYERAction(GAME *p,PLAYER *g);
PLAYER *PLAYERFindNearest(GAME *g,POINT3D *Target,PLAYER *pExclude,int TeamReq);

#define ERROR()     UTLAbort(__LINE__,__FILE__)
#define ASSERT(x)   if (!(x)) ERROR()

