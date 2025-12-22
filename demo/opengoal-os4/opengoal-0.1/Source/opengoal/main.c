/***************************************************************************
                          main.c  -  Main Program
                             -------------------
    begin                : Sat Jul 20 19:21:13 BST 2002
    copyright            : (C) 2002 by Paul Robson
    email                : autismuk@autismuk.freeserve.co.uk
 ***************************************************************************/

#include <opengoal.h>

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include <stdio.h>
#include <stdlib.h>

DRAWINFO d;

int main(int argc, char *argv[])
{
    GAME *g;
    int n = 0;
    if (INITDraw(&d,argc,argv) != 0) ERROR();

    g = GAMECreate(&d);
    SPRCreateSprites(&d,0x00FF00,0xFF0000,0x00FFFF);

    GAMEAddTeam(g,TEAMA,433,100);
    GAMEAddTeam(g,TEAMB,433,100);

    GAMESetupMoveToKickOff(g,1);

    g->PList->Controller = 1;
    g->TeamHasBall[0] = 0;
    g->TeamHasBall[1] = 1;

    while (d.KeyState[SDLK_ESCAPE] == 0)
    {
        GAMESetBallPosDribble(g);
        GAMEMoveAllPlayers(g);
        if (++n % 8 == 0) GAMERepaint(g);
        UTLPollKeyboard(&d);
    }
    GAMEDestroy(g);
    return EXIT_SUCCESS;
}


