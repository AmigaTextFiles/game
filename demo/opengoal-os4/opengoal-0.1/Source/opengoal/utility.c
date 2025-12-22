/***************************************************************************
                          utility.c  -  description
                             -------------------
    begin                : Mon Jul 22 2002
    copyright            : (C) 2002 by Paul Robson
    email                : autismuk@autismuk.freeserve.co.uk
 ***************************************************************************/

#include "opengoal.h"

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

//
//
//                              Abort/Assert utility
//
//
void UTLAbort(int Line,char *File)
{
    fprintf(stderr,"OpenGoal terminated : Error in %s line %d\n\n",File,Line);
    exit(0);
}

//
//
//      Poll Keyboard (and other events). Call periodically to update keystates
//
//
void UTLPollKeyboard(DRAWINFO *d)
{
    SDL_Event Event;
    int n;
    while (SDL_PollEvent(&Event))               // Poll events
    {
        if (Event.type == SDL_KEYUP ||          // Keyboard event ?
                        Event.type == SDL_KEYDOWN)
        {
            n = Event.key.keysym.sym;           // Get SDL Key Identity
            if (n >= 0 && n < MAXKEY)           // If legitimate, set the flag
                d->KeyState[n] = (Event.type == SDL_KEYDOWN);
        }
    }
}

int  UTLClock(void)
{
    return (int)SDL_GetTicks();
}

void UTLGetDirection(int d,POINT3D *p)
{
    p->x = p->y = p->z = 0;
    if (d != 0 && d != 4)
        p->x = (d < 4) ? 1 : -1;
    if (d != 2 && d != 6)
        p->y = (d == 7 || d < 2) ? 1 : -1;
}


int UTLDistance(POINT3D *p1,POINT3D *p2)
{
    int x,y;
    ASSERT(p1 != NULL);
    ASSERT(p2 != NULL);
    x = p1->x - p2->x;y = p1->y - p2->y;
    return (int)sqrt(x*x+y*y);
}
