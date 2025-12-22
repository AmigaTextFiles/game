/*
 	File:        BotPlayer.cpp
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
#include "BotPlayer.h"

#define FLT_MAX 3.402823e+38f

// All possible 90 deg rotations

const int allRot[] = { 0,0,0,0,
                       1,0,0,0,
                       1,1,0,0,
                       4,0,0,0,
                       2,0,0,0,
                       2,1,0,0,
                       2,1,1,0,
                       2,4,0,0,
                       2,2,0,0,
                       2,2,1,0,
                       2,2,1,1,
                       2,2,4,0,
                       5,0,0,0,
                       5,1,0,0,
                       5,1,1,0,
                       5,4,0,0,
                       3,0,0,0,
                       3,1,0,0,
                       3,1,1,0,
                       3,4,0,0,
                       6,0,0,0,
                       6,1,0,0,
                       6,1,1,0,
                       6,4,0,0 };

BotPlayer::BotPlayer() {

    matrix = NULL;
														
    matRotOx.Init33( 1.0f , 0.0f , 0.0f ,
                     0.0f , 0.0f ,-1.0f ,
                     0.0f , 1.0f , 0.0f );

    matRotOy.Init33( 0.0f , 0.0f ,-1.0f ,
                     0.0f , 1.0f , 0.0f ,
                     1.0f , 0.0f , 0.0f );

    matRotOz.Init33( 0.0f ,-1.0f , 0.0f ,
                     1.0f , 0.0f , 0.0f ,
                     0.0f , 0.0f , 1.0f );
                           
    matRotNOx.Init33( 1.0f , 0.0f , 0.0f ,
                      0.0f , 0.0f , 1.0f ,
                      0.0f ,-1.0f , 0.0f );

    matRotNOy.Init33( 0.0f , 0.0f , 1.0f ,
                      0.0f , 1.0f , 0.0f ,
                     -1.0f , 0.0f , 0.0f );

    matRotNOz.Init33( 0.0f , 1.0f , 0.0f ,
                     -1.0f , 0.0f , 0.0f ,
                      0.0f , 0.0f , 1.0f );

}

void BotPlayer::Init(int w,int h,int d) {

  width  = w;
  height = h;
  depth  = d;

  if( matrix ) { 
    free( matrix );
    matrix = NULL;
  }
  mSize = width * height * depth;
  if( mSize == 0 ) {
    // Invalid dimension
    return;
  }

  matrix = (int *)malloc( mSize*sizeof(int) );
  area = width*height;

}

void BotPlayer::SetValue(int x,int y,int z,int value) {

  if( x>=0 && x<width && y>=0 && y<height && z>=0 && z<depth ) {
    matrix[x + y*width + z*area] = value;
  }

}

int BotPlayer::GetValue(int x,int y,int z) {

  if( x<0 || x>=width || y<0 || y>=height || z<0 || z>=depth )
    return 1;
  else
    return matrix[x + y*width + z*area];

}

void BotPlayer::RestorePit(Pit *pit) {

  memset(matrix,0,mSize*sizeof(int));
  for(int i=0;i<width;i++) {
    for(int j=0;j<height;j++) {
      for(int k=0;k<depth;k++) {
        if( pit->GetValue(i,j,k) ) SetValue(i,j,k,1);
      }
    }
  }

}

void BotPlayer::GetMoves(Pit *pit,PolyCube *p,int x,int y,int z,AI_MOVE *moves,int *nbMove) {

  int xmin,ymin,zmin,xmax,ymax,zmax;
  int tx,ty,tz;
  BOOL validMove;

  // Initialise default
  block  = p;
  nbBestPath = 0;
  bestNote = -FLT_MAX;
  RestorePit(pit);
 
  // Intialise bounds
  matBlock.Identity();
  xBlock = x;
  yBlock = y;
  zBlock = z;
  TransformCube();
  GetBounds(&xmin,&ymin,&zmin,&xmax,&ymax,&zmax);

  // Analyse
  for(int ar=0;ar<24;ar++) {

     nbCurPath = 0;
     matBlock.Identity();
     validMove = TRUE;
     xBlock = x;
     yBlock = y;
     zBlock = z;

     // Rotate
     for(int r=0;r<4 && allRot[ar*4+r]!=0 && validMove;r++) {

			 GLMatrix tmp;
			 tmp = matBlock;
       switch( allRot[ar*4+r] ) {
         case 1:
           matBlock.Multiply(&tmp,&matRotOx);
           break;
         case 2:
           matBlock.Multiply(&tmp,&matRotOy);
           break;
         case 3:
           matBlock.Multiply(&tmp,&matRotOz);
           break;
         case 4:
           matBlock.Multiply(&tmp,&matRotNOx);
           break;
         case 5:
           matBlock.Multiply(&tmp,&matRotNOy);
           break;
         case 6:
           matBlock.Multiply(&tmp,&matRotNOz);
           break;
       }

       TransformCube();
       GetBounds(&xmin,&ymin,&zmin,&xmax,&ymax,&zmax);
       tx = ty = tz = 0;
       if( xmin<0 ) tx = -xmin;
       if( ymin<0 ) ty = -ymin;
       if( zmin<0 ) tz = -zmin;
       if( xmax>=width  ) tx = width  - xmax - 1;
       if( ymax>=height ) ty = height - ymax - 1;
       if( zmax>=depth  ) tz = depth  - zmax - 1;

       xBlock += tx;
       yBlock += ty;
       zBlock += tz;
       if( tx || ty || tz ) {
         TransformCube();
         GetBounds(&xmin,&ymin,&zmin,&xmax,&ymax,&zmax);
       }

       validMove = IsValidPos();

       if( validMove ) {
         curPath[nbCurPath].rotate = allRot[ar*4+r];
         curPath[nbCurPath].tx = tx;
         curPath[nbCurPath].ty = ty;
         curPath[nbCurPath].tz = tz;
         nbCurPath++;
       }

     }

     if( validMove ) {
       AnalysePlane(pit,-xmin,-ymin,width-xmax-1,height-ymax-1);
     }

  }
    

  // Return best path
  *nbMove=nbBestPath;
  memcpy(moves,bestPath,nbBestPath * sizeof(AI_MOVE));

}

int BotPlayer::GetDelta(int x) {
  if( x<0 ) return -1;
  if( x==0) return 0;
  return 1;
}

void BotPlayer::AnalysePlane(Pit *pit,int sX,int sY,int eX,int eY) {

  int xOrg = xBlock;
  int yOrg = yBlock;
  int zOrg = zBlock;
  int nb = nbCurPath;
  BOOL validMove;

  // Evaluate all possible translation
  for(int x=sX;x<=eX;x++) {
    for(int y=sY;y<=eY;y++) {

      nbCurPath = nb;
      xBlock = xOrg;
      yBlock = yOrg;
      zBlock = zOrg;
      TransformCube();

      // Compute translation to reach desired position
      int dX = GetDelta(x);
      int dY = GetDelta(y);
      int x1 = 0;
      int y1 = 0;
      validMove = TRUE;

      while( (x1!=x || y1!=y) && validMove ) {

        memset(curPath + nbCurPath , 0 , sizeof(AI_MOVE));       
        if( x1!=x ) { x1 += dX;  curPath[nbCurPath].tx = dX; }
        if( y1!=y ) { y1 += dY;  curPath[nbCurPath].ty = dY; }
        xBlock = xOrg + x1;
        yBlock = yOrg + y1;
        TransformCube();
        validMove = IsValidPos();
        if( validMove ) nbCurPath++;

      }
      
      if( validMove ) {

        // Evaluate
        float note = Evaluate();
        if( (note>bestNote) || (note==bestNote && nbCurPath<nbBestPath) ) {
          // Stored best path
          memcpy(bestPath,curPath,nbCurPath * sizeof(AI_MOVE));
          nbBestPath = nbCurPath;
          bestNote = note;
        }

        // Restore Pit
        RestorePit(pit);

      }

    }
  }

}

BOOL BotPlayer::IsValidPos() {

    BOOL overlap = FALSE;

    // Check overlap between the polycube and the pit
    for(int i=0;i<nbCube && !overlap;i++) {
      if( GetValue( transCube[i].x , transCube[i].y , transCube[i].z ) )
        overlap = TRUE;
    }
    return !overlap;

}

void BotPlayer::AddBlock() {

  for(int i=0;i<nbCube;i++) 
    SetValue( transCube[i].x , transCube[i].y , transCube[i].z , 2 );

}

void BotPlayer::TransformCube() {

   block->CopyCube(transCube,&nbCube);
   BLOCKITEM center = block->GetICenter();
   for(int i=0;i<nbCube;i++) {
		 
     float rx,ry,rz,rw;
     matBlock.TransfomVec( (float)(transCube[i].x - center.x) + 0.5f,
                           (float)(transCube[i].y - center.y) + 0.5f,
                           (float)(transCube[i].z - center.z) + 0.5f,
                           1.0f, &rx,&ry,&rz,&rw);

     transCube[i].x = fround( rx - 0.5f ) + center.x + xBlock;
     transCube[i].y = fround( ry - 0.5f ) + center.y + yBlock;
     transCube[i].z = fround( rz - 0.5f ) + center.z + zBlock;

   }

}

void BotPlayer::GetBounds(int *xmin,int *ymin,int *zmin,int *xmax,int *ymax,int *zmax) {

   *xmin = 100;
   *ymin = 100;
   *zmin = 100;
   *xmax = -100;
   *ymax = -100;
   *zmax = -100;

   for(int i=0;i<nbCube;i++) {
     if( transCube[i].x > *xmax ) *xmax = transCube[i].x;
     if( transCube[i].x < *xmin ) *xmin = transCube[i].x;
     if( transCube[i].y > *ymax ) *ymax = transCube[i].y;
     if( transCube[i].y < *ymin ) *ymin = transCube[i].y;
     if( transCube[i].z > *zmax ) *zmax = transCube[i].z;
     if( transCube[i].z < *zmin ) *zmin = transCube[i].z;
   }

}

BOOL BotPlayer::IsLineFull(int z) {

  BOOL full = TRUE;
  for(int i=0;i<width && full;i++)
    for(int j=0;j<height && full;j++)
      full = full && (GetValue(i,j,z)>=1);
  return full;

}

void BotPlayer::RemoveLine(int idx) {

  for(int k=idx;k>0;k--) {
    for(int i=0;i<width;i++)
      for(int j=0;j<height;j++)
        SetValue(i,j,k, GetValue(i,j,k-1) );
  }

  // Clear last line
  for(int i=0;i<width;i++)
    for(int j=0;j<height;j++)
      SetValue(i,j,0,0);

}

float BotPlayer::RemoveLines() {

  int nbRemoved = 0;
  int k=depth-1;

  while(k>=0) {
    if( IsLineFull(k) ) {
      RemoveLine(k);
      nbRemoved++;
    } else {
      k--;
    }
  }

  return (float)nbRemoved;

}

float  BotPlayer::GetNbHole() {

  int nbHole = 0;

  for(int i=0;i<width;i++)
   for(int j=0;j<height;j++) {
    BOOL columnEmpty = TRUE;
    for(int k=0;k<depth;k++) {
      if( GetValue(i,j,k) ) {
        columnEmpty = FALSE;
      } else {
        if( !columnEmpty ) nbHole++;
      }
    }
  }

  return (float)nbHole;

}

int  BotPlayer::GetFreeDepth() {

  int fDepth = 0;

  for(int k=0;k<depth;k++) {

    BOOL lineEmpty = TRUE;
    for(int i=0;i<width && lineEmpty;i++)
     for(int j=0;j<height && lineEmpty;j++)
        lineEmpty = lineEmpty && ( GetValue(i,j,k)==0 );

    if( lineEmpty ) fDepth++;

  }

  return fDepth;

}

float BotPlayer::DropBlock() {

  // Drop the block
  int dropPos = 0;
  do {
    zBlock++;
    dropPos++;
    TransformCube();
  } while( IsValidPos() );
  zBlock--;
  dropPos--;
  TransformCube();

  return float(dropPos)/(float)(depth);

}

void BotPlayer::CountEdge(int x,int y,int z,int *common,int *edge) {

  int v = GetValue(x,y,z);

  if( v==0 ) { 
    *edge = *edge + 1; 
  } else if( v==1 ) {
    *edge = *edge + 1; 
    *common = *common + 1;
  }

}

float BotPlayer::GetCommonEdge() {

  int nbCommon = 0;
  int nbEdge   = 0;

  for(int i=0;i<nbCube;i++) {
    
    int x = transCube[i].x;
    int y = transCube[i].y;
    int z = transCube[i].z;
    CountEdge(x-1,y,z,&nbCommon,&nbEdge);
    CountEdge(x+1,y,z,&nbCommon,&nbEdge);
    CountEdge(x,y-1,z,&nbCommon,&nbEdge);
    CountEdge(x,y+1,z,&nbCommon,&nbEdge);
    CountEdge(x,y,z-1,&nbCommon,&nbEdge);
    CountEdge(x,y,z+1,&nbCommon,&nbEdge);

  }

  return (float)nbCommon/(float)nbEdge;

}

// --------------------------------------------------
// Evaluation function
// --------------------------------------------------

float BotPlayer::Evaluate() {

  // Free depth (free space at the top of the pit)
  int freeDepth = GetFreeDepth();

  // Drop the block
  float descent = DropBlock();

  // Number of hole before adding the block
  float nbHole0 = GetNbHole();
  
  // Add the block to the pit
  AddBlock();

  // Get the ratio of common edge between the block and the pit
  // This greatly increase the building efficiency
  float commonEdge = GetCommonEdge();

  // Remove lines
  float nbLines = RemoveLines();

  // Number of hole after the move
  float nbHole1 = GetNbHole();

  // Number of added Hole (can be negative)
  float addedHole = nbHole1 - nbHole0;

  // Evaluation function
	if( freeDepth>=6 ) {
		// Building mode
	  return nbLines - 2.0f * addedHole + commonEdge + descent;
	} else {
		// Emergency mode
		return 2.0f * nbLines - 0.1f * addedHole + 2.0f * commonEdge + descent;
	}
  
}
