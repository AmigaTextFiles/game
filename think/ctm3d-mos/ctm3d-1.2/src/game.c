/*
        ColorTileMatch 3D
      Written by Bl0ckeduser
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "libraries.h"

#include "BlastTiles.h"
#include "Config.h"
#include "DrawTiles.h"
#include "game.h"
#include "mouse.h"
#include "engine.h"
#include "SDL_events.h"

int game_intro_done = 0;
int tiles[4*R_TILE_QTY][3*R_TILE_QTY];
int tile_data[4*R_TILE_QTY][3*R_TILE_QTY];

void RunGame(SDL_Surface **GameScreen)
{
	MouseState theMouse;
	short QuitRequest;
	short GameLoop;
	short WaitForNewTile;
	short MouseFreed;
	short currentTileDelay = NEW_TILE_DELAY;
	long execSpeed;
	Uint32 ticks, start_ticks, end_ticks;
	char customText[32];

	WaitForNewTile = 0;
	theMouse.down = 0;
	QuitRequest = 0;
	GameLoop = 1;
	MouseFreed = 0;

	while(GameLoop)
	{
		if (ticks-start_ticks<1000/FPS && FPSOn)
		{
			ticks=SDL_GetTicks();
		}
		else
		{
			ticks=SDL_GetTicks();
			start_ticks=SDL_GetTicks();

			// Game Events
			ManageGameEvents(&theMouse, &QuitRequest);
			GameLoop = !QuitRequest;

			// Graphics
			DrawTileSet(GameScreen);

			// Game Engine
			MoveTilesDown();
			if(WaitForNewTile++ > currentTileDelay)
			{
				WaitForNewTile = 0;
				CreateNewTile();
			}

			// Eliminating groups of connected tiles
			if(theMouse.down && game_intro_done)
			{
				if(MouseFreed)
				{
					BlastTilesFromMouse(theMouse.x, theMouse.y);
					MouseFreed = 0;
				}
			}
			else
			{
				MouseFreed = 1;
			}
		}

		if(SHOW_FPS)
		{
			end_ticks=SDL_GetTicks();
			execSpeed = end_ticks - start_ticks;
			sprintf(customText,"%ld/%d", 1000/execSpeed, FPS);
			SDL_WM_SetCaption(customText, NULL);
		}
	}
}


/* Accessing and modifying the tile data */

int getTileData(int x, int y)
{
	return tile_data[x][y];
}

int getTileColor(int x, int y)
{
	return tiles[x][y];
}

void setTileData(int x, int y, int val)
{
	tile_data[x][y] = val;
}

void setTileColor(int x, int y, int val)
{
	tiles[x][y] = val;
}

void introIsDone(void)
{
	game_intro_done = 1;	
}
