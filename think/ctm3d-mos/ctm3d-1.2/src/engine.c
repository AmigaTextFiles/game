/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#include "game.h"
#include "engine.h"
#include "Config.h"
#include <stdlib.h>

int newTileCoord = 0;
int newTileColor = 1;
float RandomNumber;

void MoveTilesDown(void)
{
	int i, j, k;
	int current_type, below_type, current_data;

	// Note : temporary data assures tiles are only move once per frame

	/* Reset tile temporary data */
	for(i=0; i<(R_TILE_QTY*3); i++)
	{
		for(j=0; j<(R_TILE_QTY*4); j++)
		{
			setTileData(j,i, 0);
		}
	}

	/* Do actual moving */
	for(i=0; i<(R_TILE_QTY*3); i++)
	{
		for(j=0; j<(R_TILE_QTY*4); j++)
		{
			current_type = getTileColor(j,i);
			below_type = getTileColor(j,i+1);
			current_data = getTileData(j,i);

			if(current_type!=0 && below_type==0 && i<(R_TILE_QTY*3)-1
			        && current_data==0)
			{
				setTileColor(j,i,0);
				setTileColor(j,i+1,current_type);
				setTileData(j,i+1, 1);
				setTileData(j, i, 0);
			}
		}
	}
}

void CreateNewTile(void)
{
	// Spawns a tile with pseudo-randomly chosen attributes

	RandomNumber = rand();
	newTileColor = (TILE_TYPES*(RandomNumber/RAND_MAX));

	RandomNumber = rand();
	newTileCoord = ((R_TILE_QTY*4)*(RandomNumber/RAND_MAX));

	if(getTileColor(newTileCoord,0)==0)
	{
		/* Make sure chosen slot is empty and spawn the tile */
		setTileColor(newTileCoord,0,newTileColor);
	}
}

