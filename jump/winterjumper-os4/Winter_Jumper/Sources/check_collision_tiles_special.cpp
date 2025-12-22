#include "_variables.h"

int exitReached;

void checkLevelEnd()
{
	if(TileTypes[TileArray[CurrentTileRightX[1]][CurrentTileRightY[1]]].isexit == 1){exitReached = 1;}
	if(TileTypes[TileArray[CurrentTileRightX[2]][CurrentTileRightY[2]]].isexit == 1){exitReached = 1;}
	if(TileTypes[TileArray[CurrentTileRightX[3]][CurrentTileRightY[3]]].isexit == 1){exitReached = 1;}
	if(TileTypes[TileArray[CurrentTileRightX[4]][CurrentTileRightY[4]]].isexit == 1){exitReached = 1;}
	if(TileTypes[TileArray[CurrentTileRightX[5]][CurrentTileRightY[5]]].isexit == 1){exitReached = 1;}
}




void checkLethalTile()
{
	getCurrentTile();
	if(TileTypes[TileArray[CurrentTileBottomX[1]][CurrentTileBottomY[1]]].lethal == 1){GianaDied = 1;}
	if(TileTypes[TileArray[CurrentTileBottomX[2]][CurrentTileBottomY[2]]].lethal == 1){GianaDied = 1;}
	if(TileTypes[TileArray[CurrentTileBottomX[3]][CurrentTileBottomY[3]]].lethal == 1){GianaDied = 1;}
	if(TileTypes[TileArray[CurrentTileBottomX[4]][CurrentTileBottomY[4]]].lethal == 1){GianaDied = 1;}
}




void checkDiamondCollision()
{
getCurrentTile();

for(int i = 1;i<5;i +=3)
{
if(TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] == 3)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]+1] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileTopY[i]+1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] == 4)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]+1] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileTopY[i]+1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] == 27)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]-1] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileTopY[i]-1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] == 28)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileTopY[i]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileTopY[i]-1] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileTopY[i]-1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] == 3)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]+1] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileLeftY[4]+1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] == 4)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]+1] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileLeftY[4]+1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] == 27)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]-1] = 0;
	TileArray[CurrentTileTopX[i]+1][CurrentTileLeftY[4]-1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}

if(TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] == 28)
	{
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileLeftY[4]] = 0;
	TileArray[CurrentTileTopX[i]][CurrentTileLeftY[4]-1] = 0;
	TileArray[CurrentTileTopX[i]-1][CurrentTileLeftY[4]-1] = 0;
	intBonus++;
	intPoints += POINTSPERBLING;
	}
}

}
