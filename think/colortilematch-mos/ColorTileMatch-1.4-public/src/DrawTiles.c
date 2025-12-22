/*
================================
        ColorTileMatch
    Puzzle game written in C
         and with SDL
================================
    Written by BL0CKEDUSER
*/

#include "DrawTiles.h"
#include "game.h"
#include "Config.h"
#include <stdio.h>
#include "TileColors.h"

void DrawTileSet(SDL_Surface **screen)
{
    int i, j, colorID;
    SDL_Rect TileRect;
    SDL_PixelFormat *ScreenFormat = (*screen)->format;
    Uint32 TileColor;

    for(i=0; i<(R_TILE_QTY*3); i++)
    {
        for(j=0; j<(R_TILE_QTY*4); j++)
        {
            colorID = getTileColor(j,i);
            
            TileColor = SDL_MapRGB(ScreenFormat, TileR[colorID], TileG[colorID],
                TileB[colorID]);
            
            TileRect.x = (*screen)->w/(R_TILE_QTY*4) * j;
            TileRect.y = (*screen)->h/(R_TILE_QTY*3) * i;
            TileRect.w = (*screen)->w/(R_TILE_QTY*4);
            TileRect.h = (*screen)->h/(R_TILE_QTY*3);
            
            SDL_FillRect((*screen), &TileRect, TileColor);
            
        }
    }
}

