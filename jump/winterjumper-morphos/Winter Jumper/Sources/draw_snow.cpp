#include "_variables.h"

SDL_Rect SnowTempRect[SNOWFLAKES];
int SnowPositionX[SNOWFLAKES];
int SnowPositionY[SNOWFLAKES];
int HorizontalSnowMovement;
int LeftRight;

void drawSnow()
{
int x;
for(x=0; x<SNOWFLAKES;x++)
{
SnowPositionY[x]++;
if(SnowPositionY[x] > 240){SnowPositionY[x] = 0;}

LeftRight = rand()%2;
if(LeftRight == 0){SnowPositionX[x]--;}
if(LeftRight == 1){SnowPositionX[x]++;}
if(SnowPositionX[x]<-4)
{
SnowPositionX[x] = rand()%320;
SnowPositionY[x] = 0;
}
if(SnowPositionX[x]>324)
{
SnowPositionX[x] = rand()%320;
SnowPositionY[x] = 0;
}

SnowTempRect[x].x = SnowPositionX[x];
SnowTempRect[x].y = SnowPositionY[x]; 
SnowTempRect[x].w = 8;
SnowTempRect[x].h = 8;
SDL_BlitSurface(TilesSurface,&TileSrcRect[151],DisplaySurface,&SnowTempRect[x]);
}



//**********************
}
