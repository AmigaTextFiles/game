/***************************************************************************
                          redraw.c  -  redraw the display
                             -------------------
    begin                : Mon Jul 22 2002
    copyright            : (C) 2002 by Paul Robson
    email                : autismuk@autismuk.freeserve.co.uk
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include "opengoal.h"

void REDRepaint(DRAWINFO *g)
{
    SDL_Rect rc,rc2;
    POINT3D pc;
    int n,x,y;

    ASSERT(g != NULL);
    pc = g->SpritePos[0];                         // Centre on the ball
    INITConvert(&pc,g->PitchSize);              // Convert the centre position to physical coords on pitch
    pc.x = pc.x - g->VPSize.x/2;                // this is the position of the top left of the display on the pitch
    pc.y = pc.y - g->VPSize.y/2;

    if (pc.x < 0) pc.x = 0;                     // Force into range - can't scroll off pitch
    if (pc.y < 0) pc.y = 0;                     // must be in range (0,0) -> (xp-xv,yp-yv)
    n = g->PitchSize.x - g->VPSize.x;
    if (pc.x > n) pc.x = n;
    n = g->PitchSize.y - g->VPSize.y;
    if (pc.y > n) pc.y = n;

    g->PitchTL = pc;                            // Save the top left physical pixel position

    rc.x = pc.x;rc.y = pc.y;                    // Save in rectangle structure
    rc.w = g->VPSize.x;
    rc.h = g->VPSize.y;
    rc2.x = rc2.y = 0;                          // Blit to 0,0
    SDL_BlitSurface(g->Pitch,&rc,               // Blit the pitch onto the screen
                            g->ViewPort,&rc2);

    for (n = 0;n < g->SpriteCount;n++)          // Draw the sprites
        SPRDraw(g,&(g->SpritePos[n]),g->SpriteID[n],g->Rotate[n]);

    rc = g->rcScanner;                          // Copy the scanner to the screen
    SDL_BlitSurface(g->Scanner,
                NULL,g->ViewPort,&rc);

    for (n = 0;n < g->SpriteCount;n++)          // Copy the graphics onto the viewport over the scanner
    {
        x = g->SpritePos[n].x+XEXT;
        y = YEXT-g->SpritePos[n].y;
        rc.x = x * (g->rcScanner.w)/(XEXT*2)+g->rcScanner.x-2;
        rc.y = y * (g->rcScanner.h)/(YEXT*2)+g->rcScanner.y-2;
        rc.w = rc.h = 4;
        if (g->SpriteID[n] != SPRID_MARKER)
                SDL_FillRect(g->ViewPort,&rc,g->SpriteCol[g->SpriteID[n]]);
    }
//    rc.x = rc.y = 0;                            // Uncommenting blits sprites onto display
//    SDL_BlitSurface(g->Sprites,NULL,g->ViewPort,&rc);

    SDL_UpdateRect(g->ViewPort,0,0,             // Update the display
                            g->VPSize.x,g->VPSize.y);
}

//
//
//          Convert pitch position to viewport position. Return 1 if can be drawn
//
//
int REDLogicalToViewPort(POINT3D *p,DRAWINFO *hw)
{
    ASSERT(p != NULL);
    ASSERT(hw != NULL);
    INITConvert(p,hw->PitchSize);               // Convert to pitch coordinates
    p->x = p->x - hw->PitchTL.x;                // Pixel offset from top left
    p->y = p->y - hw->PitchTL.y;
    if (p->x < 0 || p->x >= hw->VPSize.x) return 0;
    if (p->y < 0 || p->y >= hw->VPSize.y) return 0;
    return 1;
}
