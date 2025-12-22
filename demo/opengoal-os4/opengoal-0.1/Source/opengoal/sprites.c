/***************************************************************************
                       sprites.c  -  create/blit sprites
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

static int _Rotate;                             // These globals reduce junk for life of SPRCreate()
static SDL_Rect *_Rect;
static SDL_Surface *_Surface;
static double _sin,_cos;

static void _SPREllipse(int x,int y,int xr,int yr,int Colour);
static void _SPRPoint(int x,int y,int Colour);

//
//
//                            Create the game sprites
//
//
void SPRCreateSprites(DRAWINFO *g,int Keeper,int Team1,int Team2)
{
    SDL_Rect rc;
    int Spr,Rot,Colour;
    ASSERT(g != NULL);
    rc.x = rc.y = 0;                            // Erase the display
    rc.w = g->VPSize.x;rc.h = g->VPSize.y;
    g->ColourKey =                              // Transparency key
            SDL_MapRGB(g->Sprites->format,64,128,192);
    rc.x = rc.y = 0;                            // Erase to all transparent
    rc.w = g->Sprites->w;
    rc.h = g->Sprites->h;
    SDL_FillRect(g->Sprites,&rc,g->ColourKey);
    SDL_SetColorKey(g->Sprites,                 // Tell SDL the transparent colour
                    SDL_SRCCOLORKEY,g->ColourKey);
    for (Spr = 0;Spr < DEF_SPROW;Spr++)         // Create all the sprites
        for (Rot = 0;Rot < DEF_SPCOL;Rot++)
        {
            rc.w = g->SpriteSize.x;             // Work out the drawing rectangle
            rc.h = g->SpriteSize.y;
            rc.x = rc.w * Rot;
            rc.y = rc.h * Spr;
            switch(Spr)
            {
                case SPRID_TEAM1:   Colour = Team1;break;
                case SPRID_TEAM2:   Colour = Team2;break;
                case SPRID_GOALIE:  Colour = Keeper;break;
            }
            SPRCreate(g,g->Sprites,Spr,Rot,&rc,Colour);
        }
}

//
//
//                                      Create a program-drawn sprite
//
//
void SPRCreate(DRAWINFO *g,SDL_Surface *s,int Sprite,int Rotate,SDL_Rect *rc,int Colour)
{
    int b,n,y,c;
    double ang;

    ASSERT(g != NULL);
    ASSERT(s != NULL);
    ASSERT(Sprite >= 0 && Sprite < DEF_SPROW);
    ASSERT(Rotate >= 0 && Rotate <= DEF_SPCOL);
    ASSERT(rc != NULL);
    _Rotate = Rotate;                           // Set up globals
    _Rect = rc;
    _Surface = s;

    switch(Sprite)
    {
        case SPRID_BALL:                        // Draw the ball
            _Rotate = 0;                        // Cancel rotation for the ball
            n = 256 * SPRBALLSC / 100;          // Scale of whole ball
            n = n*(60+Rotate*35/DEF_SPCOL)/100; // Scale for being up
            y = -140*Rotate/DEF_SPCOL;          // Offset for ball (not shadow)
            _SPREllipse(0,0,n/2,n/2,            // Shadow
                            SDL_MapRGB(s->format,64,64,64));
            _SPREllipse(0,y,n,n,                // Black frame
                            SDL_MapRGB(s->format,0,0,0));
            n = n - 16;                         // Ball
            g->SpriteCol[SPRID_BALL] = SDL_MapRGB(s->format,255,255,255);
            _SPREllipse(0,y,n,n,g->SpriteCol[SPRID_BALL]);
            break;

        case SPRID_MARKER:
            if (Rotate == 0)
            {
                _Rotate = 0;
                b = SDL_MapRGB(s->format,0,0,0);    // Black colour
                n = SDL_MapRGB(s->format,255,255,0);// Marker colour
                _SPREllipse(0,0,255,255,b);
                _SPREllipse(0,0,240,240,n);
                _SPREllipse(0,0,180,180,b);
                _SPREllipse(0,0,170,170,g->ColourKey);
            }
            break;

        case SPRID_GOALIE:
        case SPRID_TEAM1:
        case SPRID_TEAM2:
            _Rotate = _Rotate & 7;              // Rotate part set.
            ang = (_Rotate*45.0)/360.0*2*3.1415;// Rotation in radians
            _sin = sin(ang);_cos = cos(ang);    // trig values
            c = SDL_MapRGB(s->format,(Colour >> 16) & 0xFF,(Colour >> 8) & 0xFF,Colour & 0xFF);
            g->SpriteCol[Sprite] = c;
            b = SDL_MapRGB(s->format,0,0,0);    // Black colour
            n = 60;if (Rotate & 8) n = 80-n;    // Foot alignment for alt. frames
            _SPREllipse(140,-n,50,120,b);       // One foot
            n = 80-n;
            _SPREllipse(-140,-n,50,120,b);      // Other foot
            _SPREllipse(0,0,255,112,b);         // Edge
            _SPREllipse(0,0,240,100,c);         // Body
            _SPREllipse(0,0,130,130,b);         // Head edge
            _SPREllipse(0,0,120,120,            // Hair (blond goalie, brown outfield)
                        (Sprite == SPRID_GOALIE) ? SDL_MapRGB(s->format,255,255,0):
                                                   SDL_MapRGB(s->format,148,105,63));
            break;

        default:
            ERROR();break;
    }
}

//
//
//                              Draw a filled ellipse
//
//
static void _SPREllipse(int x,int y,int xr,int yr,int Colour)
{
    int xc,x1,y1,s;
    s = 444/(_Rect->w+_Rect->h);                // Work out a step
    for (y1 = -yr;y1 <= yr;y1+=s)               // Work bottom to top
    {
        x1 = sqrt(yr*yr-y1*y1);                 // This if it is a circle
        x1 = x1 * xr / yr;                      // Scale for ellipse
        for (xc = -x1;xc <= x1;xc+=s)           // Draw the line
                    _SPRPoint(xc+x,y+y1,Colour);
    }
}

//
//
//          Draw a point on the current sprite (is rotated by this function)
//
//

static void _SPRPoint(int x,int y,int Colour)
{
    SDL_Rect rc;
    double xf,yf;
    int n;

    xf = (double)x;yf = (double)y;              // To float

    if (_Rotate % 2 != 0)                       // Angled rotation required
    {
        x = (int)(xf*_cos-yf*_sin+256.5);
        y = (int)(xf*_sin+yf*_cos+256.5);
    }
    else                                        // Square rotation
    {
        if (_Rotate & 2) { n = x;x = -y;y = n; }
        if (_Rotate == 4) y = -y;
        if (_Rotate == 6) x = -x;
        x = x + 256;
        y = y + 256;
    }
    rc.x = _Rect->w*x / 512 + _Rect->x;         // Convert to real points
    rc.y = _Rect->h*y / 512 + _Rect->y;

    rc.h = rc.w = 1;
    SDL_FillRect(_Surface,&rc,Colour);
}

//
//
//      Draw a sprite on the viewport - the point given is on the pitch and is converted
//
//
void SPRDraw(DRAWINFO *g,POINT3D *Point,int Sprite,int Frame)
{
    POINT3D pt = *Point;                        // So we can mess with it.
    int xs,ys;
    SDL_Rect rcSprites,rcView;
    ASSERT(g != NULL);
    ASSERT(Point != NULL);
    ASSERT(Sprite >= 0 && Sprite < DEF_SPROW);
    ASSERT(Frame >= 0 && Frame <= DEF_SPCOL);
    if (REDLogicalToViewPort(&pt,g))            // Can it be drawn ?
    {
        xs = g->SpriteSize.x;                   // Save sizes
        ys = g->SpriteSize.y;

        rcView.x = pt.x - xs/2;                 // Position of sprite
        rcView.y = pt.y - ys/2;
        rcSprites.x = Frame * xs;               // Sprite to copy
        rcSprites.y = Sprite * ys;
        rcSprites.w = xs;
        rcSprites.h = ys;
        SDL_BlitSurface(g->Sprites,&rcSprites,
                        g->ViewPort,&rcView);
    }
}
