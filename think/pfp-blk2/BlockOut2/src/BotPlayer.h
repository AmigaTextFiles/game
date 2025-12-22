/*
 	File:        BotPlayer.h
  Description: AI player
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

#ifndef BOTPLAYERH
#define BOTPLAYERH

#include "Pit.h"
#include "GLApp/GLMatrix.h"

#define MAX_MOVE 256

class BotPlayer
{
  public:
    BotPlayer();

    // Initialise the bot player
    void Init(int w,int h,int d);

    // Compute the best moves for the given block
    void GetMoves(Pit *pit,PolyCube *p,int x,int y,int z,AI_MOVE *moves,int *nbMove);

  private:

    // Pit and transformation model
    void      AnalysePlane(Pit *pit,int sX,int sY,int eX,int eY);
    void      TransformCube();
    BOOL      IsValidPos();
    void      GetBounds(int *xmin,int *ymin,int *zmin,int *xmax,int *ymax,int *zmax);
    int       GetValue(int x,int y,int z);
    void      SetValue(int x,int y,int z,int value);
    int       GetDelta(int x);
    void      AddBlock();
    BOOL      IsLineFull(int z);
    void      RemoveLine(int idx);
    void      RestorePit(Pit *pit);

    // Evaluation 
    float     Evaluate();       // Main evaluation function
    float     DropBlock();      // Drop the block
    float     RemoveLines();    // Remove lines
    float     GetNbHole();      // Total number of holes
    int       GetFreeDepth();   // 0 to depth
    float     GetCommonEdge();  // 0 to 1
    void      CountEdge(int x,int y,int z,int *common,int *edge);

    // Global
    PolyCube  *block;
    GLMatrix  matRotOx;
    GLMatrix  matRotOy;
    GLMatrix  matRotOz;
    GLMatrix  matRotNOx;
    GLMatrix  matRotNOy;
    GLMatrix  matRotNOz;

    // Block position
    GLMatrix    matBlock;
    int         xBlock;
    int         yBlock;
    int         zBlock;
    BLOCKITEM   transCube[5];
    int         nbCube;

    // Analysed paths
    AI_MOVE curPath[MAX_MOVE];  // Current path
    int     nbCurPath;          // Current path

    AI_MOVE bestPath[MAX_MOVE];  // Best path
    int     nbBestPath;          // Best path
    float   bestNote;            // Best path note

    // Pit
    int width;
    int height;
    int depth;
    int area;
    int mSize;
    int *matrix;

};

#endif /* BOTPLAYERH */
