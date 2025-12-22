/*
 	File:        Types.h 
  Description: Various basic types definitions
  Program:     BlockOut
  Author:      Jean-Luc PONS

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.
*/

#include "GLApp/GLApp.h"

#ifndef TYPESH
#define TYPESH

//-----------------------------------------------------------------------------
// Global definitions
//-----------------------------------------------------------------------------

#define PI                 3.1415926535f
#define STARTZ             0.87f
#define FAR_DISTANCE       10.0f
#define MAX_CUBE           50
#define NB_POLYCUBE        41

// Vertex format
#define VERTEX_FORMAT      (D3DFVF_XYZ)
#define FACEVERTEX_FORMAT  (D3DFVF_XYZ | D3DFVF_NORMAL)
#define TFACEVERTEX_FORMAT  (D3DFVF_XYZ | D3DFVF_NORMAL | D3DFVF_TEX1)

// Max pit dimension
#define MAX_PITWIDTH       7
#define MAX_PITHEIGHT      7
#define MAX_PITDEPTH       18

// Min pit dimension
#define MIN_PITWIDTH       3
#define MIN_PITHEIGHT      3
#define MIN_PITDEPTH       6

// Block set
#define BLOCKSET_FLAT      0
#define BLOCKSET_BASIC     1
#define BLOCKSET_EXTENDED  2

// Animation speed
#define ASPEED_SLOW        0
#define ASPEED_FAST        10

// Face transparency
#define FTRANS_MIN         0 
#define FTRANS_MAX         10

// Game state
#define GAME_PLAYING       1
#define GAME_PAUSED        2
#define GAME_OVER          3
#define GAME_DEMO          4

// Screen resoltion
#define RES_640x480        0
#define RES_800x600        1
#define RES_1024x768       2
#define RES_1280x1024      3

// Game style
#define STYLE_CLASSIC      0
#define STYLE_MARBLE       1
#define STYLE_ARCADE       2

// Game sound
#define SOUND_BLOCKOUT2    0
#define SOUND_BLOCKOUT     1

// Frame limiter
#define FR_NOLIMIT    0
#define FR_LIMIT50    1
#define FR_LIMIT60    2
#define FR_LIMIT75    3
#define FR_LIMIT100   4

//-----------------------------------------------------------------------------
// Structure definitions
//-----------------------------------------------------------------------------
typedef struct {

  int x;
  int y;

} POINT;

typedef struct  {

  float x;
  float y;
  float z;

} VERTEX;

typedef struct {

  int x;
  int y;
  int z;

} BLOCKITEM;

typedef struct SCORERECLINK {

  int   setupId;
  int   score;
  int   nbCube;
  int   nbLine1;
  int   nbLine2;
  int   nbLine3;
  int   nbLine4;
  int   nbLine5;
  int   startLevel;
  int   date;
  char  name[11];
  BYTE  emptyPit;
  int   scoreId;
  float gameTime;

  SCORERECLINK *next;

} SCOREREC;

typedef struct {

  char name[11];
  int  rank;
  int  highScore;

} PLAYER_INFO;

typedef struct {

  int rotate;
  int tx;
  int ty;
  int tz;

} AI_MOVE;

//-----------------------------------------------------------------------------
// Util functions
//-----------------------------------------------------------------------------

extern VERTEX v(float x,float y,float z);
extern void Normalize(VERTEX *v);
extern int fround(float x);
extern char *FormatTime(float seconds);
extern char *FormatDate(int time);
extern char *FormatDateShort(int time);
extern int CreateTexture(int width,int height,char *imgName,GLuint *hmap);
extern char GetChar(BYTE *keys);
extern void ZeroMemory(void *buff,int size);
extern BOOL DirExists(char *dirname);
extern BOOL CheckEnv();
extern char *LID(char *fileName);
extern char *LHD(char *fileName);


#endif /* TYPESH */
