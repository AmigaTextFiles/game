/*
 	File:        PolyCube.cpp
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

#include "PolyCube.h"

//-----------------------------------------------------------------------------

PolyCube::PolyCube() {

  lineList  = 0;
  ghostList = 0;
  nbCube = 0;
  hScore = 0;
  lScore = 0;  
  isFlat = FALSE;
  isBasic = FALSE;
  hasGhost = FALSE;

}

//-----------------------------------------------------------------------------

void PolyCube::SetInfo(int highScore,int lowScore,BOOL flat,BOOL basic) {

  hScore = highScore;
  lScore = lowScore;
  isFlat = flat;
  isBasic = basic;

}

//-----------------------------------------------------------------------------

void PolyCube::AddCube(int x,int y,int z) {

  if( nbCube<MAX_CUBE ) {
    cubes[nbCube].x = x;
    cubes[nbCube].y = y;
    cubes[nbCube].z = z;
    nbCube++;
  }

}

//-----------------------------------------------------------------------------

int PolyCube::GetHighScore() {

  return hScore;

}

//-----------------------------------------------------------------------------

int PolyCube::GetLowScore() {

  return lScore;

}

//-----------------------------------------------------------------------------

BOOL PolyCube::IsInSet(int set) {

  switch(set) {
    case BLOCKSET_EXTENDED:
      return TRUE;
    case BLOCKSET_BASIC:
      return isBasic;
    case BLOCKSET_FLAT:
      return isFlat;
  }

  return FALSE;

}

//-----------------------------------------------------------------------------

int PolyCube::GetNbCube() {

  return nbCube;

}

//-----------------------------------------------------------------------------

int PolyCube::GetWidth() {
  int maxW = 0;
  for(int i=0;i<nbCube;i++)
    if(cubes[i].x > maxW) maxW = cubes[i].x;
  return maxW + 1;
}

//-----------------------------------------------------------------------------

int PolyCube::GetHeight() {
  int maxH = 0;
  for(int i=0;i<nbCube;i++)
    if(cubes[i].y > maxH) maxH = cubes[i].y;
  return maxH + 1;
}

//-----------------------------------------------------------------------------

int PolyCube::GetDepth() {
  int maxD = 0;
  for(int i=0;i<nbCube;i++)
    if(cubes[i].z > maxD) maxD = cubes[i].z;
  return maxD + 1;
}

//-----------------------------------------------------------------------------

int PolyCube::GetMaxDim() {
  int w = GetWidth();
  int h = GetHeight();
  int d = GetDepth();
  int maxDim = w;
  if( h > maxDim ) maxDim = h;
  if( d > maxDim ) maxDim = d;
  return maxDim;
}

//-----------------------------------------------------------------------------

int PolyCube::Create(float cSide,VERTEX org,int ghost) {

  cubeSide = cSide;
  origin = org;

  // Create edge

  lineList = glGenLists(1);
	glNewList(lineList,GL_COMPILE);
	glBegin(GL_LINES);

  for(int i=0;i<nbCube;i++) {

    if(IsEdgeVisible(i,0)) { 
		  glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 0
		  glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 1
		}

    if(IsEdgeVisible(i,1)) { 
		  glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 1
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 2
		}

    if(IsEdgeVisible(i,2)) { 
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 2
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 3
		}

    if(IsEdgeVisible(i,3)) { 
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 3
		  glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 0
		}

    if(IsEdgeVisible(i,4)) { 
		  glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 0
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z); // 4
		}

    if(IsEdgeVisible(i,5)) { 
		  glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 1
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z); // 5
		}

    if(IsEdgeVisible(i,6)) {
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 2

      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z); // 6
		}

    if(IsEdgeVisible(i,7)) { 
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+0) * cubeSide + origin.z); // 3
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z); // 7
		}

    if(IsEdgeVisible(i,8)) { 
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 4
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 5
		}

    if(IsEdgeVisible(i,9)) { 
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 5
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 6
		}

    if(IsEdgeVisible(i,10)) { 
      glVertex3f((cubes[i].x+1) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 6
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 7
		}

    if(IsEdgeVisible(i,11)) { 
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+0) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 7
      glVertex3f((cubes[i].x+0) * cubeSide + origin.x,
                 (cubes[i].y+1) * cubeSide + origin.y,
                 (cubes[i].z+1) * cubeSide + origin.z);  // 4
		}

  }

	glEnd();
	glEndList();

	// Init material
  memset (&whiteMaterial, 0, sizeof (GLMATERIAL));
	whiteMaterial.Diffuse.r = 1.0f;
	whiteMaterial.Diffuse.g = 1.0f;
	whiteMaterial.Diffuse.b = 1.0f;
	whiteMaterial.Ambient.r = 1.0f;
	whiteMaterial.Ambient.g = 1.0f;
	whiteMaterial.Ambient.b = 1.0f;

  memset (&redMaterial, 0, sizeof (GLMATERIAL));
	redMaterial.Diffuse.r = 1.0f;
	redMaterial.Diffuse.g = 0.0f;
	redMaterial.Diffuse.b = 0.0f;
	redMaterial.Ambient.r = 1.0f;
	redMaterial.Ambient.g = 0.0f;
	redMaterial.Ambient.b = 0.0f;

  memset (&ghostMaterial, 0, sizeof (GLMATERIAL));

  // Emulate "BlockOut original" rotation center
  iCenter.x = GetWidth() - 1;
  iCenter.y = 1;
  iCenter.z = GetDepth() - 1;

  center.x = iCenter.x * cubeSide + origin.x;
  center.y = iCenter.y * cubeSide + origin.y;
  center.z = iCenter.z * cubeSide + origin.z;

  // Ghost
  hasGhost = (ghost!=0);
  if( hasGhost ) {
    if( !CreateGhost(ghost) ) return GL_FAIL;
  }

  return GL_OK;
}

//-----------------------------------------------------------------------------

void PolyCube::gV(int cubeIdx,int x,int y,int z,float nx,float ny,float nz) {

  glNormal3f(nx,ny,nz);
	glVertex3f((cubes[cubeIdx].x+x) * cubeSide + origin.x,
             (cubes[cubeIdx].y+y) * cubeSide + origin.y,
             (cubes[cubeIdx].z+z) * cubeSide + origin.z);

}

//-----------------------------------------------------------------------------

int PolyCube::CreateGhost(int value) {

  // Create face

  ghostList = glGenLists(1);
	glNewList(ghostList,GL_COMPILE);
	glBegin(GL_QUADS);

	for(int i=0;i<nbCube;i++) {

    // Face 0
    if( IsFaceVisible(i,0) ) {
      gV(i,0,0,0, 0.0f,0.0f,-1.0f);
      gV(i,0,1,0, 0.0f,0.0f,-1.0f);
      gV(i,1,1,0, 0.0f,0.0f,-1.0f);
      gV(i,1,0,0, 0.0f,0.0f,-1.0f);
    }

    // Face 1
    if( IsFaceVisible(i,1) ) {
      gV(i,0,0,1, -1.0f,0.0f,0.0f);
      gV(i,0,1,1, -1.0f,0.0f,0.0f);
      gV(i,0,1,0, -1.0f,0.0f,0.0f);
      gV(i,0,0,0, -1.0f,0.0f,0.0f);
    }

    // Face 2
    if( IsFaceVisible(i,2) ) {
      gV(i,1,0,1, 0.0f,0.0f,1.0f);
      gV(i,1,1,1, 0.0f,0.0f,1.0f);
      gV(i,0,1,1, 0.0f,0.0f,1.0f);
      gV(i,0,0,1, 0.0f,0.0f,1.0f);
    }

    // Face 3
    if( IsFaceVisible(i,3) ) {
      gV(i,1,0,0, 1.0f,0.0f,0.0f);
      gV(i,1,1,0, 1.0f,0.0f,0.0f);
      gV(i,1,1,1, 1.0f,0.0f,0.0f);
      gV(i,1,0,1, 1.0f,0.0f,0.0f);
    }

    // Face 4
    if( IsFaceVisible(i,4) ) {
      gV(i,0,1,0, 0.0f,1.0f,0.0f);
      gV(i,0,1,1, 0.0f,1.0f,0.0f);
      gV(i,1,1,1, 0.0f,1.0f,0.0f);
      gV(i,1,1,0, 0.0f,1.0f,0.0f);
    }

    // Face 5
    if( IsFaceVisible(i,5) ) {
      gV(i,1,0,0, 0.0f,-1.0f,0.0f);
      gV(i,1,0,1, 0.0f,-1.0f,0.0f);
      gV(i,0,0,1, 0.0f,-1.0f,0.0f);
      gV(i,0,0,0, 0.0f,-1.0f,0.0f);
    }

  }

	glEnd();
	glEndList();

	// Ghost material
  float trans = ((float)value / (float)FTRANS_MAX) * 0.4f;

	ghostMaterial.Diffuse.r = 0.5f;
	ghostMaterial.Diffuse.g = 0.5f;
	ghostMaterial.Diffuse.b = 0.5f;
	ghostMaterial.Diffuse.a = trans;
	ghostMaterial.Ambient.r = 0.5f;
	ghostMaterial.Ambient.g = 0.5f;
	ghostMaterial.Ambient.b = 0.5f;
	ghostMaterial.Ambient.a = trans;

  return GL_OK;

}

//-----------------------------------------------------------------------------

void PolyCube::CopyCube(BLOCKITEM *c,int *nb) {

  for(int i=0;i<nbCube;i++) {
    c[i] = cubes[i];
  }
  *nb = nbCube;

}

//-----------------------------------------------------------------------------

VERTEX PolyCube::GetRCenter() {

  return center;

}

//-----------------------------------------------------------------------------

BLOCKITEM PolyCube::GetICenter() {

  return iCenter;

}

//-----------------------------------------------------------------------------

BOOL PolyCube::FindCube(int x,int y,int z) {

  BOOL found = FALSE;
  int i = 0;
  while(i<nbCube && !found) {
    found = (cubes[i].x == x) && (cubes[i].y == y) && (cubes[i].z == z);
    if(!found) i++;
  }

  return found;

}

//-----------------------------------------------------------------------------

BOOL PolyCube::IsFaceVisible(int cubeIdx,int face) {

  int x = cubes[cubeIdx].x;
  int y = cubes[cubeIdx].y;
  int z = cubes[cubeIdx].z;

  switch(face) {
    case 0:
      return !FindCube(x,y,z-1);
      break;
    case 1:
      return !FindCube(x-1,y,z);
      break;
    case 2:
      return !FindCube(x,y,z+1);
      break;
    case 3:
      return !FindCube(x+1,y,z);
      break;
    case 4:
      return !FindCube(x,y+1,z);
      break;
    case 5:
      return !FindCube(x,y-1,z);
      break;
  }

  return FALSE;

}

//-----------------------------------------------------------------------------

BOOL PolyCube::IsEdgeVisible(int cubeIdx,int edge) {

  int nb = 0;
  BOOL e1,e2,e3;

  int x = cubes[cubeIdx].x;
  int y = cubes[cubeIdx].y;
  int z = cubes[cubeIdx].z;

  switch(edge) {

    case 0:
      e1 = FindCube(x,y,z-1);e2 = FindCube(x,y+1,z-1);e3 = FindCube(x,y+1,z);
      break;
    case 1:
      e1 = FindCube(x,y,z-1);e2 = FindCube(x+1,y,z-1);e3 = FindCube(x+1,y,z);
      break;
    case 2:
      e1 = FindCube(x,y,z-1);e2 = FindCube(x,y-1,z-1);e3 = FindCube(x,y-1,z);
      break;
    case 3:
      e1 = FindCube(x,y,z-1);e2 = FindCube(x-1,y,z-1);e3 = FindCube(x-1,y,z);
      break;

    case 4:
      e1 = FindCube(x,y+1,z);e2 = FindCube(x-1,y+1,z);e3 = FindCube(x-1,y,z);
      break;
    case 5:
      e1 = FindCube(x,y+1,z);e2 = FindCube(x+1,y+1,z);e3 = FindCube(x+1,y,z);
      break;
    case 6:
      e1 = FindCube(x+1,y,z);e2 = FindCube(x+1,y-1,z);e3 = FindCube(x,y-1,z);
      break;
    case 7:
      e1 = FindCube(x,y-1,z);e2 = FindCube(x-1,y-1,z);e3 = FindCube(x-1,y,z);
      break;

    case 8:
      e1 = FindCube(x,y+1,z);e2 = FindCube(x,y+1,z+1);e3 = FindCube(x,y,z+1);
      break;
    case 9:
      e1 = FindCube(x+1,y,z);e2 = FindCube(x+1,y,z+1);e3 = FindCube(x,y,z+1);
      break;
    case 10:
      e1 = FindCube(x,y-1,z);e2 = FindCube(x,y-1,z+1);e3 = FindCube(x,y,z+1);
      break;
    case 11:
      e1 = FindCube(x-1,y,z);e2 = FindCube(x-1,y,z+1);e3 = FindCube(x,y,z+1);
      break;

  }

  return !( (!e1 && !e2 && e3) || (e1 && !e2 && !e3) || (e1 && e2 && e3) );

}

//-----------------------------------------------------------------------------

void PolyCube::Render(BOOL redMode) {

	glEnable(GL_LIGHTING);
  glDisable(GL_DEPTH_TEST);
  glDisable(GL_TEXTURE_2D);

  if( hasGhost ) {

    // Alpha texture
	  glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    GLApplication::SetMaterial(&ghostMaterial);

    // Draw back face first
	  glEnable(GL_CULL_FACE);
    glCullFace(GL_FRONT);
		glCallList(ghostList);

    // Draw front face
    glCullFace(GL_BACK);
		glCallList(ghostList);

  }

  glDisable(GL_TEXTURE_2D);
	glDisable(GL_LIGHTING);
  glDisable(GL_BLEND);
  glDisable(GL_CULL_FACE);

  // Draw the polycube
  if(redMode)
    GLApplication::SetMaterial (&redMaterial);		
  else
    GLApplication::SetMaterial (&whiteMaterial);		

	glCallList(lineList);

}

//-----------------------------------------------------------------------------

void PolyCube::InvalidateDeviceObjects() {

  DELETE_LIST(lineList);
  DELETE_LIST(ghostList);
  nbCube = 0;

}
