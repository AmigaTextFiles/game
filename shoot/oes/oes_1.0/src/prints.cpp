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
#include <stdarg.h>

void print(int aXofs, int aYofs, int aColor, const char *aString, ...)
{
    va_list arglist;
    char cbuf[4096];
    char *cp = cbuf;
    va_start(arglist,aString);
    vsprintf(cbuf,aString,arglist);
    va_end(arglist);

    SDL_Rect srcRect, tgtRect;
    tgtRect.x = aXofs;
    tgtRect.y = aYofs;
    tgtRect.w = srcRect.w = 4;
    tgtRect.h = srcRect.h = 6;
    srcRect.x = 0;
    while (*cp)
    {
        srcRect.y = (*cp - 32) * 6;
        SDL_BlitSurface(Game.Font[aColor], &srcRect, Game.Screen, &tgtRect);
        cp++;
        tgtRect.x += 4;
    }
}

void printShadow(int aXofs, int aYofs, const char *aString, ...)
{
    va_list arglist;
    char cbuf[4096];
    char *cp = cbuf;
    va_start(arglist,aString);
    vsprintf(cbuf,aString,arglist);
    va_end(arglist);

    SDL_Rect srcRect, tgtRect;
    tgtRect.x = aXofs + 1;
    tgtRect.y = aYofs + 1;
    tgtRect.w = srcRect.w = 4;
    tgtRect.h = srcRect.h = 6;
    srcRect.x = 0;
    while (*cp)
    {
        srcRect.y = (*cp - 32) * 6;
        SDL_BlitSurface(Game.Font[0], &srcRect, Game.Screen, &tgtRect);
        cp++;
        tgtRect.x += 4;
    }
    tgtRect.x = aXofs;
    tgtRect.y = aYofs;
    cp = cbuf;
    while (*cp)
    {
        srcRect.y = (*cp - 32) * 6;
        SDL_BlitSurface(Game.Font[1], &srcRect, Game.Screen, &tgtRect);
        cp++;
        tgtRect.x += 4;
    }

}


