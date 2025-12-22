/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#include "BlastTiles.h"
#include "Config.h"
#include "game.h"

void BlastTilesFromMouse(int MouseHitX, int MouseHitY)
{
    int tileWidth = SCREEN_WIDTH / (R_TILE_QTY*4);
    int tileHeight = SCREEN_HEIGHT / (R_TILE_QTY*3);
    
    int hitTileRow, hitTileColumn;
    
    hitTileRow =  MouseHitX / tileWidth;
    hitTileColumn = MouseHitY / tileHeight;
    
    InitBlastTilesFrom(hitTileRow, hitTileColumn);
}

void InitBlastTilesFrom(int row, int column)
{
    int color;
    
    color = getTileColor(row, column);
    
    if(color != 0)
    {
	if((row>0 && getTileColor(row-1,column)==color)
	||(column>0 && getTileColor(row,column-1)==color)
	||(row<(R_TILE_QTY*4) && getTileColor(row+1,column)==color)
	||(column<(R_TILE_QTY*3) && getTileColor(row,column+1)==color))
	{
	 	// Adjacent tiles of same color must exist if you want
		// to blast (new as of v1.1)
		
        	/* Blast the tile itself */
        	BlastTile(row, column);

       		/* Recursively destroy adjacent tiles of same color */
      		RecursiveTileBlastFrom(row, column, color);
	}
    }
}

void BlastTilesFrom(int row, int column)
{
    int color;
    
    color = getTileColor(row, column);
    
    if(color != 0)
    {
        	/* Blast the tile itself */
        	BlastTile(row, column);

       		/* Recursively destroy adjacent tiles of same color */
      		RecursiveTileBlastFrom(row, column, color);
    }
}

void RecursiveTileBlastFrom(int row, int column, int color)
{
    
    if(row>0 && getTileColor(row-1,column)==color)
    {
        // Blast tile to the left
        BlastTilesFrom(row-1, column);
    }
    
    if(column>0 && getTileColor(row,column-1)==color)
    {
        // Blast tile above
        BlastTilesFrom(row, column-1);
    }
    
    if(row<(R_TILE_QTY*4) && getTileColor(row+1,column)==color)
    {
        // Blast tile to the right
        BlastTilesFrom(row+1,column);
    }
    
    if(column<(R_TILE_QTY*3) && getTileColor(row,column+1)==color)
    {
        // Blast tile below
        BlastTilesFrom(row, column+1);
    }
    
}

void BlastTile(int row, int column)
{
    setTileColor(row,column, 0);
}
