///////////////////////////////////////////////
// 
//  Snipe2d ludum dare 48h compo entry
//
//  Jari Komppa aka Sol 
//  http://iki.fi/sol
// 
///////////////////////////////////////////////
// License
///////////////////////////////////////////////
// 
//     This software is provided 'as-is', without any express or implied
//     warranty.    In no event will the authors be held liable for any damages
//     arising from the use of this software.
// 
//     Permission is granted to anyone to use this software for any purpose,
//     including commercial applications, and to alter it and redistribute it
//     freely, subject to the following restrictions:
// 
//     1. The origin of this software must not be misrepresented; you must not
//        claim that you wrote the original software. If you use this software
//        in a product, an acknowledgment in the product documentation would be
//        appreciated but is not required.
//     2. Altered source versions must be plainly marked as such, and must not be
//        misrepresented as being the original software.
//     3. This notice may not be removed or altered from any source distribution.
// 
// (eg. same as ZLIB license)
//
///////////////////////////////////////////////
//
// Houses are taken from a satellite picture of glasgow.
//
// The sources are a mess, as I didn't even try to do anything
// really organized here.. and hey, it's a 48h compo =)
//
#include "snipe2d.h"

#define PI 3.1415926535897932384626433832795f

void drawSprite(int aX, int aY, int aSize, int aSprite)
{
    if ( SDL_LockSurface(Game.Screen) < 0 ) 
        return;
    if ( SDL_LockSurface(Game.CharSprite) < 0 ) 
    {
        SDL_UnlockSurface(Game.Screen);
        return;
    }

    int i, j, x, yp, y, sx, sy, spriterow;
    int xinc, yinc;
    xinc = (32 << SHIFT_AMOUNT) / aSize;
    yinc = (32 << SHIFT_AMOUNT) / aSize;
    int spriteofs = aSprite * (Game.CharSprite->pitch / 2) * 32;
    spriterow = spriteofs;
    yp = (aY * (Game.Screen->pitch / 2));
    y = aY;
    sy = 0;
    for (i = 0; i < aSize; i++)
    {
        x = aX; 
        sx = 0;
        for (j = 0; j < aSize; j++)
        {
            x++;
            sx += xinc;
            if (y >= 0 && x >= 0 && y < 480 && x < 640) 
            {
                // The sprite sequence uses green as alpha; new green is
                // synthesized as average of red and blue
                short pix = ((short *)Game.Screen->pixels)[x + yp];
                short tex = ((short *)Game.CharSprite->pixels)[spriterow + (sx >> SHIFT_AMOUNT)];
                int alpha = (tex & 0x7E0) >> 5;
                int alpha1 = 64 - alpha;
                int r = (((pix >> 11) & 0x1f) * alpha1 + ((tex >> 11) & 0x1f) * alpha) >> 6;
                int g;
                if (aSprite == 33)
                    g = (((pix >>  5) & 0x3f) * alpha1) >> 6;
                else
                    g = (((pix >>  5) & 0x3f) * alpha1 + (((tex >> 11) & 0x1f) + ((tex >> 0) & 0x1f)) * alpha) >> 6;
                int b = (((pix >>  0) & 0x1f) * alpha1 + ((tex >>  0) & 0x1f) * alpha) >> 6;
                ((short *)Game.Screen->pixels)[x + yp] = (r << 11) + (g << 5) + b;
            }
        
        }
        yp += Game.Screen->pitch / 2;
        sy += yinc;
        spriterow = spriteofs + (sy >> SHIFT_AMOUNT) * (Game.CharSprite->pitch / 2);
        y++;
    }

    SDL_UnlockSurface(Game.CharSprite);
    SDL_UnlockSurface(Game.Screen);
}

void worldtoscreen(int &x, int &y)
{
    x = (int)((x - (Game.MouseX + Game.CenterX)) / Game.CoordScale);
    y = (int)((y - (Game.MouseY + Game.CenterY)) / Game.CoordScale);
}

void drawCharacter(CHARACTER &c)
{
    if (c.mType == -1) return;
    int sx = (int)((c.mX - (Game.MouseX + Game.CenterX)) / Game.CoordScale);
    int sy = (int)((c.mY - (Game.MouseY + Game.CenterY)) / Game.CoordScale);
    int ax = (int)((c.mX - (Game.MouseX + Game.WobbleX + Game.CenterX)) / Game.CoordScale);
    int ay = (int)((c.mY - (Game.MouseY + Game.WobbleY + Game.CenterY)) / Game.CoordScale);
    int size = (int)(2 / Game.CoordScale);
    if (size < 2)
        size = 2;

    int mode = 0;
    if (Game.CoordScale >= 1)
    {
        if (c.mType == 2)
            return; // don't draw pedestrians in big scale
        mode = 1;
        size *= 2;
    }
    else
    if (Game.CoordScale <= 0.25f)
    {
        mode = -1;
        if (sx - size < 320 &&
            sx + size > 320 &&
            sy - size < 240 &&
            sy + size > 240)
        {
            Game.SightedCharacter = &c;
        }
    }
    
    sx -= size;
    sy -= size;

    if (sx > -size*2 && sx < 640+size*2 &&
        sy > -size*2 && sy < 480+size*2)
    {
        int color;
        SDL_Rect r;
        switch (c.mType)
        {
        case 0: // bad guy
            color = SDL_MapRGB(Game.Screen->format, 0xc0 + (((SDL_GetTicks() >> 8)&1)?0:0x3f), 0, 0);
            break;
        case 1: // VIP
            color = SDL_MapRGB(Game.Screen->format, 0, 0, 0x9f);
            break;
        case 2: // pedestrian
            color = SDL_MapRGB(Game.Screen->format, 0x9f, 0x9f, 0x9f);
            break;
        case 3: // hit
            color = SDL_MapRGB(Game.Screen->format, 0x9f, 0, 0);
            break;
        case 4: // miss
            color = SDL_MapRGB(Game.Screen->format, 0,0,0);
            break;
        }
        if (mode == 0 || mode == 1)
        {
            r.x = sx;
            r.y = sy;
            r.w = size * 2;
            r.h = size * 2;
            SDL_FillRect(Game.Screen, &r, color);
        }
        if (mode == -1)
        {

            // draw actual position
            if (c.mType == 3)
            {
                drawSprite(ax - size / 2,
                           ay - size / 2,
                           size,
                           33);
            }
            else
            if (c.mType == 4)
            {
                drawSprite(ax - size / 2,
                           ay - size / 2,
                           size,
                           32);
            }
            else
            {
                drawSprite(ax - size / 2,
                           ay - size / 2,
                           size,
                           ((int)floor(32-((atan2(c.mXi,c.mYi))/PI)*16+32))%32);
            }

            int linewidth = (size / 8) + 1;
            int segmentsize = (size / 2) + 1;
            int bottomright = (size * 2) - segmentsize + linewidth;

            // draw box
            r.x = sx;
            r.y = sy;
            r.w = segmentsize;
            r.h = linewidth;
            SDL_FillRect(Game.Screen, &r, color);
            r.x = sx;
            r.y = sy;
            r.w = linewidth;
            r.h = segmentsize;
            SDL_FillRect(Game.Screen, &r, color);
            
            r.x = sx + bottomright;
            r.y = sy;
            r.w = segmentsize;
            r.h = linewidth;
            SDL_FillRect(Game.Screen, &r, color);
            r.x = sx;
            r.y = sy + bottomright;
            r.w = linewidth;
            r.h = segmentsize;
            SDL_FillRect(Game.Screen, &r, color);

            r.x = sx;
            r.y = sy + size * 2;
            r.w = segmentsize;
            r.h = linewidth;
            SDL_FillRect(Game.Screen, &r, color);
            r.x = sx + size * 2;
            r.y = sy;
            r.w = linewidth;
            r.h = segmentsize;
            SDL_FillRect(Game.Screen, &r, color);

            r.x = sx + bottomright;
            r.y = sy + size * 2;
            r.w = segmentsize;
            r.h = linewidth;
            SDL_FillRect(Game.Screen, &r, color);
            r.x = sx + size * 2;
            r.y = sy + bottomright;
            r.w = linewidth;
            r.h = segmentsize;
            SDL_FillRect(Game.Screen, &r, color);
 
        }
        if (mode == 1)
        {
            // draw connecting lines to targets or horizontal & vertical
            // ones if not possible
            if (c.mType == 1 || c.mType == 0)
            {
                int x, y;
                if (c.mType == CHAR_BADGUY)
                {
                    if (c.mTarget == -1)
                    {
                        r.x = 0;
                        r.y = sy + size;
                        r.w = 640;
                        r.h = 1;
                        SDL_FillRect(Game.Screen, &r, color);
                        r.x = sx + size;
                        r.y = 0;
                        r.w = 1;
                        r.h = 480;
                        SDL_FillRect(Game.Screen, &r, color);
                        return;
                    }
                    x = (int)Game.characters[c.mTarget].mX;
                    y = (int)Game.characters[c.mTarget].mY;
                }
                else
                {
                    x = Game.spawnpoints[c.mTarget].mX;
                    y = Game.spawnpoints[c.mTarget].mY;
                }
                worldtoscreen(x, y);
                if (x > 1 && x < 639 && y > 1 && y < 479 &&
                    sx + size > 1 && sx + size < 639 && sy + size > 1 && sy + size < 479)
                    drawLine(Game.Screen, sx + size, sy + size, x, y, color);
                else
                {
                    r.x = 0;
                    r.y = sy + size;
                    r.w = 640;
                    r.h = 1;
                    SDL_FillRect(Game.Screen, &r, color);
                    r.x = sx + size;
                    r.y = 0;
                    r.w = 1;
                    r.h = 480;
                    SDL_FillRect(Game.Screen, &r, color);
                }

            }
        }
    }
    else // not on screen
    {
        if (c.mType == 0 || c.mType == 1)
        {
            sx += size;
            sy += size;
            if (sx > 640-5) sx = 640 - 5;
            if (sy > 480-5) sy = 480 - 5;
            if (sx < 5) sx = 5;
            if (sy < 5) sy = 5;

            int color;
            SDL_Rect r;
            switch (c.mType)
            {
            case 0: // bad guy
                color = SDL_MapRGB(Game.Screen->format, 0xff, 0, 0);
                break;
            case 1: // VIP
                color = SDL_MapRGB(Game.Screen->format, 0, 0, 0x9f);
                break;
            }
            r.x = sx - 5;
            r.y = sy - 5;
            r.w = 10;
            r.h = 10;
            SDL_FillRect(Game.Screen, &r, color);
        }
    }
}
