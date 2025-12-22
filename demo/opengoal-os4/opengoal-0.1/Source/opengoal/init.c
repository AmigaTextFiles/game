/***************************************************************************
                          init.c  -  all the setup routines
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

static void _INITRect(SDL_Surface *s,SDL_Rect *r,int Colour);
static void _INITLine(SDL_Surface *s,int x1,int y1,int x2,int y2,int Width,int Colour,POINT3D Size);
static void _INITLine_2(SDL_Surface *s,int x1,int y1,int x2,int y2,int Width,int Colour,POINT3D Size);
static void _INITPoint(SDL_Surface *s,int x,int y,int Colour,POINT3D Size);

//
//
//      Initialise the game - set up hardware and threads, draw the pitch
//
//
int INITDraw(DRAWINFO *g,int argc,char **argv)
{
    char Title[128];
    POINT3D p1,p2;
    SDL_Rect rc;
    int n;
    ASSERT(g != NULL);
    if (SDL_Init(SDL_INIT_VIDEO) == -1) return 1;
    atexit(SDL_Quit);
    g->VPSize.x = DEF_XVP;                      // Set default viewport size
    g->VPSize.y = DEF_YVP;
    g->PitchSize.x = DEF_XPC;                   // Default pitch size
    g->PitchSize.y = DEF_YPC;
    g->Depth = 16;                              // Default depth

//    g->VPSize.x = 640;                          // Fix for testing - all on one pitch:)
//    g->VPSize.y = 880;
//    g->PitchSize = g->VPSize;

    g->ViewPort =                               // Create the viewport
        SDL_SetVideoMode(g->VPSize.x,
                         g->VPSize.y,
                         g->Depth,
                         SDL_HWSURFACE|SDL_ANYFORMAT);
    if (g->ViewPort == NULL) return 2;          // Couldn't set video mode

    g->Pitch =
            SDL_CreateRGBSurface(SDL_SWSURFACE,
                                 g->PitchSize.x,
                                 g->PitchSize.y,
                                 g->ViewPort->format->BitsPerPixel,
                                 0,0,0,0);

    if (g->Pitch == NULL) return 3;             // No pitch

    INITDrawPitch(g->Pitch,g->PitchSize);       // Draw the pitch

    p1.x = p1.y = 0;                            // Convert (0,0) to pixels
    INITConvert(&p1,g->PitchSize);
    p2.x = DEF_XSPC;p2.y = DEF_YSPC;            // Convert sprite unit size to pixels
    INITConvert(&p2,g->PitchSize);
    g->SpriteSize.x = abs(p1.x-p2.x);           // Calculate sprite object size
    g->SpriteSize.y = abs(p1.y-p2.y);

    g->Sprites =                                // Create sprites
            SDL_CreateRGBSurface(SDL_SWSURFACE|SDL_SRCCOLORKEY,
                                 g->SpriteSize.x * DEF_SPCOL,
                                 g->SpriteSize.y * DEF_SPROW,
                                 g->ViewPort->format->BitsPerPixel,
                                 0,0,0,0);
    if (g->Sprites == NULL) return 4;           // No sprites


    g->rcScanner.x = g->VPSize.x*SCAN_X/100;    // Set up scanner rectangle
    g->rcScanner.y = g->VPSize.y*SCAN_Y/100;
    g->rcScanner.w = g->VPSize.x*SCAN_W/100;
    g->rcScanner.h = g->VPSize.y*SCAN_H/100;

    g->Scanner =                                // Create scanner
        SDL_CreateRGBSurface(SDL_SWSURFACE|SDL_SRCCOLORKEY,
                             g->rcScanner.w,g->rcScanner.h,
                             g->ViewPort->format->BitsPerPixel,
                             0,0,0,0);
    if (g->Scanner == NULL) return 5;           // No sprites

    rc.x = rc.y = 0;                            // Draw Scanner
    rc.w = g->rcScanner.w;
    rc.h = g->rcScanner.h;
    SDL_FillRect(g->Scanner,&rc,SDL_MapRGB(g->Scanner->format,255,255,0));
    n = SDL_MapRGB(g->Scanner->format,0,0,0);
    rc.x = rc.y = 1;rc.w-=2;rc.h = g->rcScanner.h/2-2;
    SDL_FillRect(g->Scanner,&rc,n);
    rc.y = g->rcScanner.h/2;rc.h++;
    SDL_FillRect(g->Scanner,&rc,n);
    SDL_SetColorKey(g->Scanner,SDL_SRCCOLORKEY,n);

    sprintf(Title,"OpenGoal %s by %s",          // Set caption of main window
                                VERSION,AUTHOR);
    SDL_WM_SetCaption(Title,NULL);
    g->SpriteCount = 1;                         // One sprite (ball is sprite 0)
    g->SpritePos[0].x = g->SpritePos[0].y = 0;  // Fix up dummy ball
    g->SpriteID[0] = SPRID_BALL;
    g->Rotate[0] = 0;
    for (n = 0;n < MAXKEY;n++)                  // Clear key states
                        g->KeyState[n] = 0;
    return 0;
}

//
//
//                      Draw the pitch on the given surface
//
//
void INITDrawPitch(SDL_Surface *s,POINT3D Size)
{
    SDL_Rect r;
    int i,x,y,h,White;
    ASSERT(s != NULL);
    r.x = r.y = 0;r.w = Size.x;r.h = Size.y;    // Draw the grass, which is green (surprise !)
    _INITRect(s,&r,SDL_MapRGB(s->format,0,128,0));
    White = SDL_MapRGB(s->format,255,255,255);  // Pitch line colour
    _INITLine(s,0,YEXT,XEXT,YEXT,2,White,Size); // Edge of the pitch
    _INITLine(s,XEXT,0,XEXT,YEXT,2,White,Size);
    _INITLine(s,0,0,XEXT,0,1,White,Size);       // Centre line then penalty area
    _INITLine(s,XPENALTY,YEXT,XPENALTY,YPENALTY,1,White,Size);
    _INITLine(s,0,YPENALTY,XPENALTY,YPENALTY,1,White,Size);
    h = YEXT*(100+YPCB*2-1)/100;                // Depth of goal from spare space
    _INITLine(s,XGOAL,YEXT,XGOAL,h,3,White,Size);
    for (i = 0;i <= 8;i++)                      // Netting grid
    {
        y = (h-YEXT)*i/8+YEXT;
        _INITLine(s,XGOAL,y,0,y,(i == 0 || i == 8) ? 3 :1,White,Size);
    }
    for (i = 0;i <= 12;i++)
    {
        x = XGOAL*i/12;
        _INITLine(s,x,YEXT,x,h,1,White,Size);
    }
    for (i = 0;i < CSRAD;i++)                   // Centre circle
        _INITPoint(s,i,sqrt(CSRAD*CSRAD-i*i),White,Size);
    for (i = 0;i < PSRAD;i++)                   // Penalty area circle
        _INITPoint(s,i*3/2,YPENALTY-sqrt(PSRAD*PSRAD-i*i),White,Size);
}


//
//
//              Convert the point in logical coordinates to physical ones
//
//
void INITConvert(POINT3D *p,POINT3D Size)
{
    SDL_Rect r;
    ASSERT(p != NULL);
    r.x = Size.x * XPCB / 100;                  // Left hand border
    r.y = Size.y * YPCB / 100;                  // Bottom hand border
    r.w = Size.x - r.x * 2;                     // Width
    r.h = Size.y - r.y * 2;                     // Height
    p->x = (p->x + XEXT)*r.w/(XEXT*2)+r.x;      // Convert the x-coordinate
    p->y = (YEXT-p->y)*r.h/(YEXT*2)+r.y;        // Convert the y-coordinate
}

//
//
//      Draw a filled rectange - works with -ve height and widths. Or would if the
//      types weren't unsigned int - they are big nums, that's why > 16384.
//
//
static void _INITRect(SDL_Surface *s,SDL_Rect *r,int Colour)
{
    ASSERT(s != NULL);
    ASSERT(r != NULL);
    if (r->w > 16384)
    {
        r->x += r->w;r->w = -r->w;
    }
    if (r->h > 16384)
    {
        r->y += r->h;r->h = -r->h;
    }
    SDL_FillRect(s,r,Colour);
}

//
//
//      Draw a line (horizontal/vertical only), reflect in all four quadrants as
//      the pitch is symmetrical about x and y
//
//
static void _INITLine(SDL_Surface *s,int x1,int y1,int x2,int y2,int Width,int Colour,POINT3D Size)
{
    ASSERT(s != NULL);
    _INITLine_2(s,x1,y1,x2,y2,Width,Colour,Size);// Draw in all four quadrants
    _INITLine_2(s,x1,-y1,x2,-y2,Width,Colour,Size);
    _INITLine_2(s,-x1,y1,-x2,y2,Width,Colour,Size);
    _INITLine_2(s,-x1,-y1,-x2,-y2,Width,Colour,Size);
}

static void _INITLine_2(SDL_Surface *s,int x1,int y1,int x2,int y2,int Width,int Colour,POINT3D Size)
{
    POINT3D p1,p2;
    SDL_Rect rc;
    ASSERT(s != NULL);
    p1.x = x1;p1.y = y1;p2.x = x2;p2.y = y2;    // Set up points
    INITConvert(&p1,Size);                      // Convert to physical coordinates
    INITConvert(&p2,Size);
    rc.x = p1.x;rc.y = p1.y;
    if (y1 == y2)                               // Horizontal line
    {
        rc.w = p2.x-p1.x;
        rc.h = Width;
        rc.y -= Width/2;
    }
    if (x1 == x2)                               // Vertical line
    {
        rc.h = p2.y-p1.y;
        rc.w = Width;
        rc.x -= Width/2;
    }
    _INITRect(s,&rc,Colour);
}
//
//
//                      Draw a point in all four quadrants
//
//
static void _INITPoint(SDL_Surface *s,int x,int y,int Colour,POINT3D Size)
{
    SDL_Rect rc;
    POINT3D p;
    int i;
    ASSERT(s != NULL);
    rc.w = rc.h = 1;
    for (i = 0;i < 4;i++)
    {
        p.x = x;p.y = y;
        if (i & 1) p.x = -p.x;
        if (i & 2) p.y = -p.y;
        INITConvert(&p,Size);
        rc.x = p.x;rc.y = p.y;
        SDL_FillRect(s,&rc,Colour);
    }
}

