/*
 	File:        PolyCube.h
  Description: PolyCube management
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

#include "Types.h"

#ifndef POLYCUBEH
#define POLYCUBEH

class PolyCube
{
  public:
    PolyCube();

    // Add a cube to the polycube
    void AddCube(int x,int y,int z);

    // Set polycube info
    void SetInfo(int highScore,int lowScore,BOOL flat,BOOL basic);

    // Create polycube device objects
    int Create(float cubeSide,VERTEX origin,int ghost);

    // Render the polycube
    void Render(BOOL redMode);

    // Release device objects
    void InvalidateDeviceObjects();

    // Return the rotation center
    VERTEX      GetRCenter();
    BLOCKITEM   GetICenter();

    // Copy the polycube cube coordinates
    void CopyCube(BLOCKITEM *c,int *nb);

    // Get number of cube
    int GetNbCube();

    // Get High score
    int GetHighScore();

    // Get Low score
    int GetLowScore();

    // Check if the polycube belongs to the set
    BOOL IsInSet(int set);

    // Get dimension
    int GetWidth();
    int GetHeight();
    int GetDepth();
    int GetMaxDim();

  private:

    int  hScore;    // score (dropped from top position)
    int  lScore;    // score (non dropped)
    BOOL isFlat;    // Into the flat set
    BOOL isBasic;   // Into the basic set
    BOOL hasGhost;  // PolyCube transparent side
    float cubeSide; // Cube side length
    VERTEX origin;  // Origin
    VERTEX center; // Rotation center (space coordinates)
    BLOCKITEM iCenter;  // Rotation center (cube coordinates)

    // Cube coordinates
    BLOCKITEM cubes[MAX_CUBE];
    int nbCube;

    // Graphics stuff
		GLuint  lineList;
    GLuint  ghostList;

    GLMATERIAL whiteMaterial;
    GLMATERIAL ghostMaterial;
    GLMATERIAL redMaterial;

    int  CreateGhost(int value);
    BOOL IsEdgeVisible(int cubeIdx,int edge);
    BOOL IsFaceVisible(int cubeIdx,int face);
    BOOL FindCube(int x,int y,int z);
    void gV(int cubeIdx,int x,int y,int z,float nx,float ny,float nz);

};

#endif /* POLYCUBEH */
