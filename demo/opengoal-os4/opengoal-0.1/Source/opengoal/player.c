/***************************************************************************
                          player.c  -  player actions
                             -------------------
    begin                : Sun Jul 28 2002
    copyright            : (C) 2002 by Paul Robson
    email                : autismuk@autismuk.freeserve.co.uk
 ***************************************************************************/

#include "opengoal.h"

static void _PLAYERChaseTarget(GAME *g,PLAYER *p);
static void _PLAYERSelectNewTarget(GAME *g,PLAYER *p);
static void _PLAYERControllerCheck(GAME *g,int TeamID);
static void _PLAYERRiggedControl(GAME *g,PLAYER *p);
static void _PLAYERCalculateNewTarget(GAME *g,TEAMROLE Role,POINT3D *Tgt,POINT3D *Pos,
                                                                POINT3D *Init,POINT3D *Ball,int HasBall);
static void _PLAYERCheckSwitchSides(GAME *g);

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
//                              Move a single player
//
//
void PLAYERAction(GAME *g,PLAYER *p)
{
    int Time,Moved = 0;
    PLAYER *p2;
    ASSERT(g != NULL);
    ASSERT(p != NULL);
    Time = UTLClock();                          // Timing
    if (p->NextMove >= Time) return;            // Not time yet
    p->NextMove = Time+p->Speed;                // Next move


    if (p->Action == A_DRIBBLE)                 // Dribbling, copy pos
                        g->Ball = p->Pos;
    if (p->Action == A_DRIBBLE ||               // If in the game
        p->Action == A_MOVING)
    {
        _PLAYERControllerCheck(g,TEAMA);        // Check controllers
        _PLAYERControllerCheck(g,TEAMB);
        _PLAYERCheckSwitchSides(g);             // The flipping.....
        if (p->Controller)                      // If player controlled
        {
            Moved = 1;
            _PLAYERRiggedControl(g,p);
        }
        else                                    // Computer controlled - intelligence
        {
            if (rand()% p->Intelligence == 0)
                                p->Action = A_WAITING;
        }
    }

    if (Moved) return;                          // Under player control, exit

    switch(p->Action)                           // What to do ?
    {
        case A_TAKEDEADBALLKICK:
            _PLAYERChaseTarget(g,p);
            if (UTLDistance(&(p->Target),&(p->Pos)) == 0)
            {
                p2 = g->PList;                  // Set all players to waiting
                while (p2 != NULL)
                {
                    p2->Action = A_WAITING;
                    p2 = p2->Next;
                }
                p->Action = A_DRIBBLE;          // Player with ball is dribbling
            }
            break;

        case A_WAITING:                         // New instructions
            _PLAYERSelectNewTarget(g,p);
            break;

        case A_DRIBBLE:
            // TODO: Dribbling code
            break;

        case A_MOVING:                          // Moving to a new target
            _PLAYERChaseTarget(g,p);
            break;

        case A_MOVETOKICKOFF:
            _PLAYERChaseTarget(g,p);            // Move towards target
            if (p->Pos.x == p->Target.x &&      // Reached kick off point
              p->Pos.y == p->Target.y)
                p->Action = A_WAITFORDEADBALL;  // Wait for dead ball kick off.
            break;

        case A_WAITFORDEADBALL:
            p->Rotate = (p->Pos.y < 0 ? 0 : 4); // Set orientation correctly
            break;

        case A_CHASEBALL:                       // Chase the ball
            p->Target = g->Ball;
            _PLAYERChaseTarget(g,p);
            break;

        default:
            ERROR();
    }
}

//
//
//                      Player moves towards his (her!) target point
//
//
static void _PLAYERChaseTarget(GAME *g,PLAYER *p)
{
    int xMove,yMove,Scaler,n;
    double r;
    ASSERT(g != NULL);
    ASSERT(p != NULL);
    xMove = p->Target.x - p->Pos.x;             // Movement value
    yMove = p->Target.y - p->Pos.y;

    if (abs(xMove/XMOVE) > abs(yMove/YMOVE))    // Is the |x| scale > |y| scale ?
        Scaler = xMove/XMOVE;                   // This is what we divide it by
    else
        Scaler = yMove/YMOVE;

    Scaler = abs(Scaler);                       // Keep the signs after scaling :)
    if (p->Action == A_DRIBBLE)                 // Slow if dribbling
            Scaler = Scaler * 100 / DRIBPC;
    if (Scaler == 0) return;                    // At the target point
    xMove = xMove / Scaler;                     // Work out the moves
    yMove = yMove / Scaler;
    p->Pos.x += xMove;                          // Move the player
    p->Pos.y += yMove;
    p->AnimFrame++;                             // Animate his little legs :)
    p->Rotate = 0;
    if (p->AnimFrame & 2) p->Rotate = 8;
    r = atan2((double)yMove,(double)abs(xMove));// Work out angle. The abs is because -x didn't work !
    r = r * 360.0 / 2 / 3.1415;                 // Convert to degrees
    r = (r-22) / 45;                            // Convert to 0-7
    n = ((int)(2-r)) & 7;
    if (xMove < 0 && n != 0 && n != 4) n = 8-n; // Fix for left moves !
    p->Rotate |= n;
}

//
//
//                          Find nearest player to a point
//
//
PLAYER *PLAYERFindNearest(GAME *g,POINT3D *Target,PLAYER *pExclude,int TeamReq)
{
    PLAYER *pSearch,*pFound;
    int d,BestDistance;
    ASSERT(g != NULL);
    BestDistance = XEXT*XEXT*4;                 // The whole pitch size
    pFound = NULL;
    pSearch = g->PList;
    while (pSearch != NULL)                     // Scan through players
    {
        d = UTLDistance(Target,&(pSearch->Pos));// Calculate distance
        if (d < BestDistance &&                 // if best
            pSearch->Team == TeamReq &&         // right team
            pExclude != pSearch &&              // and not the excluded one !
            pSearch->Role != TR_GOALKEEPER)     // and not the goalkeeper
            {
                BestDistance = d;               // Remember it
                pFound = pSearch;
            }
        pSearch = pSearch->Next;
    }
    ASSERT(pFound != NULL);                     // Check ones been found
    return pFound;
}

static void _PLAYERSelectNewTarget(GAME *g,PLAYER *p)
{
    POINT3D pt,pn,bl,ko;
    ASSERT(g != NULL);
    ASSERT(p != NULL);
    pt = p->Pos;                                // Get the position
    bl = g->Ball;
    ko = p->KickOffPos;
    if (p->KickOffPos.y > 0)                    // Convert to always moving up screen -ve to +ve
    {
        pt.y *= -1;
        bl.y *= -1;
        ko.y *= -1;
    }
    _PLAYERCalculateNewTarget(g,p->Role,&pn,&pt,&ko,&bl,*(p->HaveBall));
    if (p->KickOffPos.y > 0) pn.y *= -1;        // Convert for playing direction
    p->Target = pn;                             // Copy into target
    p->Action = A_MOVING;
}

static void _PLAYERCalculateNewTarget(GAME *g,TEAMROLE Role,POINT3D *Tgt,POINT3D *Pos,
                                                                POINT3D *Init,POINT3D *Ball,int HasBall)
{
    int n;
    Tgt->x = Init->x;
    Tgt->y = Pos->y;

    switch(Role)
    {
        case TR_GOALKEEPER:
            Tgt->y = Pos->y;
            break;

        case TR_DEFENDER:
            Tgt->y = Ball->y - (34+rand()%45)*YEXT/100;
            if (HasBall == 0 && Ball->y < -YEXT/3)
                Tgt->y = Ball->y - (5+rand()%12)*YEXT/100;
            if (HasBall) Tgt->y = -(10+rand()%20)*YEXT/100;
            if (HasBall && rand()%10 == 0) Tgt->y = (rand()%80)*YEXT/100;
            break;

        case TR_MIDFIELD:
            Tgt->y = HasBall ? YEXT/2 : -YEXT/3;
            if (HasBall == 0 && Ball->y < Pos->y && Ball->y < YEXT/2) Pos->y = Ball->y - YEXT/20;
            if (HasBall && Ball->y > Pos->y) Tgt->y = Ball->y + (rand()%25-12)*YEXT/100;
            if (HasBall && Ball->y < -YEXT/3) Tgt->y = (rand()%10-5)*YEXT/100;
            Tgt->y += (-5+rand()%10)*YEXT/100;
            break;

        case TR_STRIKER:
            Tgt->y = HasBall ? YEXT*7/10 : -YEXT/6;
            if (HasBall)
            {
                if (Ball->y > Tgt->y) Tgt->y = Ball->y;
                if (Ball->y < YEXT/3) Tgt->y = YEXT*2/3;
                if (Ball->y < -YEXT/3) Tgt->y = YEXT/3;
                if (Ball->y < -YEXT/5) Tgt->y = -YEXT/3;
            }
            Tgt->y += (-5+rand()%10)*YEXT/100;
            break;

        default:
            ERROR();
    }

    n = (rand()%25)*(rand()%2*2-1);
    Tgt->x += n;
    if (abs(Ball->x-Pos->x) > XEXT)
    {
        n = (rand()%22+10)*XEXT/100;
        if (abs(Ball->x-Pos->x) > XEXT*3/2) n = n * 2;
        if (Ball->x < Pos->x) n = -n;
        Tgt->x = Pos->x + n;
    }
}

static void _PLAYERControllerCheck(GAME *g,int TeamID)
{
    PLAYER *p,*p2;
    int PCtrl;
    ASSERT(g != NULL);
    ASSERT(TeamID == TEAMA || TeamID == TEAMB);
    p = PLAYERFindNearest(g,&(g->Ball),         // Find player nearest the ball.
                                NULL,TeamID);
    ASSERT(p != NULL);
    p2 = g->PList;
    PCtrl = -1;
    while (p2 != NULL)                          // Work through the team
    {
        if (p2->Team == TeamID)                 // Our team ?
        {
            if (p2->Controller != 0)            // Player controlled ?
            {
                PCtrl = p2->Controller;         // remember the controller
                if (p2->Action == A_DRIBBLE)    // if dribbling, change nothing at all
                    return;
            }
            p2->Controller = 0;                 // Not controlled
            if (p2->Action == A_CHASEBALL)      // No-one chasing the ball
                        p2->Action = A_WAITING;
        }
        p2 = p2->Next;
    }
    if (PCtrl != -1)                            // Controller found
        p->Controller = PCtrl;                  // Control player nearest the ball
    else
        p->Action = A_CHASEBALL;                // Chase the ball
}

static void _PLAYERRiggedControl(GAME *g,PLAYER *p)
{
    int x = p->Pos.x,y = p->Pos.y;
    DRAWINFO *d = g->DrawInfo;

    if (d->KeyState[SDLK_z]) x -= XMOVE*2;
    if (d->KeyState[SDLK_x]) x += XMOVE*2;
    if (d->KeyState[SDLK_k]) y += YMOVE*2;
    if (d->KeyState[SDLK_m]) y -= YMOVE*2;
    p->Target.x = x;
    p->Target.y = y;
    _PLAYERChaseTarget(g,p);

}

static void _PLAYERCheckSwitchSides(GAME *g)
{
    int i,n;
    PLAYER *p;
    if (g->DrawInfo->KeyState[SDLK_l] == 0) return;
    printf("Flip\n");
    g->DrawInfo->KeyState[SDLK_l] = 0;
    n = 0;
    p = g->PList;
    while (p != NULL)
    {
        n++;
        p->Action = A_WAITING;
        p->Controller = 0;
        p=p->Next;
    }
    do
    {
        i = rand() % n;p = g->PList;
        while (i-- > 0) p = p->Next;
    } while (p->Role == TR_GOALKEEPER || *(p->HaveBall) != 0);
    p->Controller = 1;
    p->Action = A_DRIBBLE;
    g->TeamHasBall[0] = g->TeamHasBall[1] = 0;
    *(p->HaveBall) = 1;
}
