/***************************************************************************
                     game.c  -  handles game/player creation etc.
                             -------------------
    begin                : Tue Jul 23 2002
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

GAME *GAMECreate(DRAWINFO *d)
{
    GAME *g;
    ASSERT(d != NULL);
    g = (GAME *)malloc(sizeof(GAME));           // Create a game object
    if (g == NULL) ERROR();                     // Shouldn't fail !
    g->PList = (PLAYER *)NULL;                  // No players
    g->DrawInfo = d;                            // Draw information pointer
    g->Ball.x = g->Ball.y = g->Ball.z = 0;      // Ball on centre spot
    g->TeamHasBall[0] = g->TeamHasBall[1] = 0;  // Neither side has the ball.
    return g;
}

//
//
//                          Destroy a game structure
//
//
void GAMEDestroy(GAME *g)
{
    PLAYER *p,*p2;
    ASSERT(g != NULL);
    p = g->PList;                               // Delete the players
    while (p != NULL)                           // Work down the list of players
    {
        p2 = p->Next;free(p);p = p2;            // Delete them as you go
    }
    free(g);                                    // Erase the end structure
}


//
//
//                           Add a team to the player list
//
//

void GAMEAddTeam(GAME *g,int Team,int Formation,int Skill)
{
    NEWPLAYER pi;
    int i;

    ASSERT(g != NULL);
    ASSERT(Team == TEAMA || Team == TEAMB);
    ASSERT(Skill >= 50 && Skill <= 150);
    pi.Role = TR_GOALKEEPER;                    // Everyone has a goalie (except Bordeaux v Nantes)
    pi.xPercent = 50;
    pi.Intelligence = DEF_IQ;
    pi.Speed = DEF_SPEED;
    GAMEAddPlayer(g,Team,&pi);

    for (i = 0;i < 4;i++)                       // TODO: Proper formation (for later)
    {
        pi.Role = TR_DEFENDER;
        pi.xPercent = i*25+12;
        GAMEAddPlayer(g,Team,&pi);
    }
    for (i = 0;i < 3;i++)
    {
        pi.Role = TR_MIDFIELD;
        pi.xPercent = i*30+20;
        GAMEAddPlayer(g,Team,&pi);
        pi.Role = TR_STRIKER;
        pi.xPercent = i*20+30;
        GAMEAddPlayer(g,Team,&pi);
    }
}

//
//
//                          Add a player to the player list
//
//
void GAMEAddPlayer(GAME *g,int Team,NEWPLAYER *Info)
{
    PLAYER *p;
    ASSERT(g != NULL);
    ASSERT(Team == TEAMA || Team == TEAMB);
    ASSERT(Info != NULL);
    p = (PLAYER *)malloc(sizeof(PLAYER));       // Allocate memory for the player
    if (p == NULL) ERROR();                     // Check memory
    p->Next = g->PList;                         // Insert player into the player list
    g->PList = p;
    p->Team = Team;                             // Team number
    p->Action = A_MOVETOKICKOFF;                // Set to move to kick off

    p->KickOffPos.x = (XEXT*2)*Info->xPercent/100-XEXT;

    switch(Info->Role)                          // Work out vertical position
    {
        case TR_GOALKEEPER: p->KickOffPos.y = YEXT*92/100;break;
        case TR_DEFENDER:   p->KickOffPos.y = YEXT*(72-abs(50-Info->xPercent)/3)/100;break;
        case TR_MIDFIELD:   p->KickOffPos.y = YEXT*35/100;break;
        case TR_STRIKER :   p->KickOffPos.y = YEXT*5/100;break;
        default:            ERROR();            // Not positioned your new role
    }

    if (abs(p->KickOffPos.x) < CSRAD &&         // Force strikers outside centre circle
                p->KickOffPos.y < CSRAD)
                        p->KickOffPos.y = sqrt(CSRAD*CSRAD-p->KickOffPos.x*p->KickOffPos.x)+CSRAD/8;

    if (Team == TEAMB)                          // Team 2 plays up by default
            p->KickOffPos.y *= -1;
    p->Pos = p->Target = p->KickOffPos;         // Set the target and current pos to same
    p->Role = Info->Role;                       // Set the role of the player
    p->HaveBall =                               // Set pointer to team has ball flag
            &(g->TeamHasBall[Team == TEAMA ? 0 : 1]);
    p->Intelligence = Info->Intelligence;       // Copy player characteristics
    p->Speed = Info->Speed;
    p->NextMove = UTLClock();                   // Set next move to current clock
    p->Rotate =(Team == TEAMA) ? 4:0;           // Rotation to zero (up) four (down)
    p->Controller = 0;
    p->AnimFrame = 0;
}

//
//
//    Copy the ball information and player list to the sprite structures then repaint
//
//
void GAMERepaint(GAME *g)
{
    DRAWINFO *d;
    PLAYER *p;
    int n;
    ASSERT(g != NULL);
    d = g->DrawInfo;
    ASSERT(d != NULL);
    GAMESetBallPosDribble(g);
    p = g->PList;                               // Add the player list to the sprite list
    while (p != NULL)                           // Work through all defined players
    {
        if (p->Controller != 0)                 // Highlight if player controlled.
        {
            n = d->SpriteCount++;
            d->SpritePos[n] = p->Pos;           // Copy position over
            d->Rotate[n] = 0;                   // Copy rotation
            d->SpriteID[n] = SPRID_MARKER;      // Decide on the sprite
        }

        n = d->SpriteCount++;
        d->SpritePos[n] = p->Pos;               // Copy position over
        d->Rotate[n] = p->Rotate;               // Copy rotation
        d->SpriteID[n] = SPRID_GOALIE;          // Decide on the sprite
        if (p->Role != TR_GOALKEEPER)
            d->SpriteID[n] = (p->Team == TEAMA) ? SPRID_TEAM1:SPRID_TEAM2;
        p = p->Next;                            // Next player
    }
    REDRepaint(g->DrawInfo);
}

//
//
//      If a player is dribbling glue the ball to his feet - can be called anywhere
//
//
void GAMESetBallPosDribble(GAME *g)
{
    PLAYER *p;
    DRAWINFO *d;
    POINT3D Dir;
    int c,n = 0;
    ASSERT(g != NULL);
    p = g->PList;d = g->DrawInfo;
    ASSERT(d != NULL);
    d->SpriteCount = 1;                         // 1 sprite
    d->SpritePos[0] = g->Ball;                  // Copy ball position
    d->SpriteID[0] = SPRID_BALL;                // a ball sprite
    d->Rotate[0] = 0;                           // on the ground TODO:: Ball in air.
    while (p != NULL)                           // Look for dribbling players
    {
        if (p->Action == A_DRIBBLE)
        {
            ASSERT(n == 0);                     // Check only one, work out new position
            UTLGetDirection(p->Rotate & 7,&Dir);
            c = (p->Rotate & 1) ? 90 : 120;
            d->SpritePos[0].x = p->Pos.x+Dir.x*DEF_XSPC*c/200;
            d->SpritePos[0].y = p->Pos.y+Dir.y*DEF_YSPC*c/200;
            n++;                                // Set counter
        }
        p = p->Next;
    }
}

//
//
//      Set up for march to kick off position, optionally resetting to left side
//
//
void GAMESetupMoveToKickOff(GAME *g,int MoveEdge)
{
    PLAYER *p;
    ASSERT(g != NULL);
    p = g->PList;
    ASSERT(p != NULL);
    while (p != NULL)                           // Work down the list
    {
        p->Target = p->KickOffPos;              // Target is the kick off position
        p->Action = A_MOVETOKICKOFF;            // Move to the kick off position
        if (MoveEdge)                           // Fix to left edge ?
        {
            p->Pos.x = -XEXT*6/5;               // lhs
            p->Pos.y = 0;
            p->Rotate = 2;                      // facing right
        }
        p = p->Next;
    }
}

//
//
//          Move all players. Randomly choose which team moves first
//
//
void GAMEMoveAllPlayers(GAME *g)
{
    PLAYER *p,*pn;
    int Side,Flag;
    ASSERT(g != NULL);
    p = g->PList;                               // List of players
    Side = (rand()%2) ? TEAMA:TEAMB;            // Random which side moves first
    while (p != NULL)                           // Do one side
    {
        if (p->Team == Side)
                    PLAYERAction(g,p);
        p = p->Next;
    }
    p = g->PList;                               // Now do the others
    while (p != NULL)
    {
        if (p->Team != Side)
                    PLAYERAction(g,p);
        p = p->Next;
    }
    if (g->PList->Action == A_WAITFORDEADBALL)  // All waiting for dead ball ?
    {
        Flag = 0;p = g->PList;                  // Check they all are
        while (p != NULL)
        {
            if (p->Action != A_WAITFORDEADBALL) Flag = 1;
            p = p->Next;
        }
        if (Flag == 0)                          // All waiting ?
        {
            pn = PLAYERFindNearest(g,&(g->Ball),NULL,g->TeamHasBall[0] ? TEAMA:TEAMB);
            pn->Action = A_TAKEDEADBALLKICK;
            pn->Target = g->Ball;
            pn->Target.y += DEF_YSPC/2 * ((pn->KickOffPos.y < 0) ? -1 : 1);
        }
    }
}

