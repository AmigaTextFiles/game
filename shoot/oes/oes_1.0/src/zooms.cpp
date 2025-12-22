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

void zoom(SDL_Surface * src, float ofsx, float ofsy, float scale)
{
    if ( SDL_LockSurface(src) < 0 ) 
        return;
    if ( SDL_LockSurface(Game.Screen) < 0 ) 
    {
        SDL_UnlockSurface(src);
        return;
    }

    int i, j, c, d, yofs, xofs, imgwidth;
    int xinc, yinc;
    imgwidth = (int)((639 << SHIFT_AMOUNT) * scale);
    yinc = (int)(scale * (1 << SHIFT_AMOUNT));
    xinc = (int)(scale * (1 << SHIFT_AMOUNT));
    yofs = (int)((1 << SHIFT_AMOUNT) * ofsy);
    xofs = (int)((1 << SHIFT_AMOUNT) * ofsx);
    d = (yofs >> SHIFT_AMOUNT) * (src->pitch / 2);
    d <<= SHIFT_AMOUNT;
    d += xofs;
    short *t = (short*)Game.Screen->pixels; 
    for (i = 0; i < 480; i++)
    {
        c = d;
        // top and down clip
        if (yofs < (1 << SHIFT_AMOUNT) || yofs > (598 << SHIFT_AMOUNT))
        {
            for (j = 0; j < 640; j++)
            {
                *t = 0x01e0;
                t++;
            }
        }
        else // x min clip
        if (xofs < (1 << SHIFT_AMOUNT))
        {
            int count = -(xofs / xinc);
            for (j = 0; j < count; j++)
            {
                *t = 0x01e0;
                t++;
            }
            c += xinc * count;
            for (j = count; j < 640; j++)
            {
                *t = ((short*)src->pixels)[(c) >> SHIFT_AMOUNT];
                t++;
                c += xinc;
            }
        }
        else // x max clip
        if (xofs + imgwidth > (800 << SHIFT_AMOUNT))
        {            
            int count = 640 - (((xofs + imgwidth) - (800 << SHIFT_AMOUNT)) / xinc);

            for (j = 0; j < count; j++)
            {
                *t = ((short*)src->pixels)[(c) >> SHIFT_AMOUNT];
                t++;
                c += xinc;
            }
            for (j = count; j < 640; j++)
            {
                *t = 0x01e0;
                t++;
            }            
        }
        else // no clipping
        {
            for (j = 0; j < 640; j++)
            {
                *t = ((short*)src->pixels)[(c) >> SHIFT_AMOUNT];
                t++;
                c += xinc;
            }
        }
        t += (Game.Screen->pitch / 2) - 640;
        yofs += yinc;
        d = (yofs >> SHIFT_AMOUNT) * (src->pitch / 2);
        d <<= SHIFT_AMOUNT;
        d += xofs;

    }

    SDL_UnlockSurface(src);
    SDL_UnlockSurface(Game.Screen);

}

/*
          (X&1)==0        (X&1==1)
         +---------------------------------
(Y&1)==0 | u+=.25,v+=.00  u+=.50,v+=.75
(Y&1)==1 | u+=.75,v+=.50  u+=.00,v+=.25
*/
int unreal_dither[8] =
{
    (int)((1 << SHIFT_AMOUNT) * 0.25),
    (int)((1 << SHIFT_AMOUNT) * 0.00),

    (int)((1 << SHIFT_AMOUNT) * 0.50),
    (int)((1 << SHIFT_AMOUNT) * 0.75),

    (int)((1 << SHIFT_AMOUNT) * 0.75),
    (int)((1 << SHIFT_AMOUNT) * 0.50),

    (int)((1 << SHIFT_AMOUNT) * 0.00),
    (int)((1 << SHIFT_AMOUNT) * 0.25)
};


void zoom_unreal(SDL_Surface * src, float ofsx, float ofsy, float scale)
{
    if ( SDL_LockSurface(src) < 0 ) 
        return;
    if ( SDL_LockSurface(Game.Screen) < 0 ) 
    {
        SDL_UnlockSurface(src);
        return;
    }

    int i, j, c, yofs, xofs, imgwidth;
    int xinc, yinc;
    int srcpitch = src->pitch / 2;
    imgwidth = (int)((640 << SHIFT_AMOUNT) * scale);
    yinc = (int)(scale * (1 << SHIFT_AMOUNT));
    xinc = (int)(scale * (1 << SHIFT_AMOUNT));
    yofs = (int)((1 << SHIFT_AMOUNT) * ofsy);
    xofs = (int)((1 << SHIFT_AMOUNT) * ofsx);
    short *t = (short*)Game.Screen->pixels; 
    for (i = 0; i < 480; i++)
    {
        // top and down clip
        if (yofs < (1 << SHIFT_AMOUNT) || yofs > (598 << SHIFT_AMOUNT))
        {
            c = xofs;
            for (j = 0; j < 640; j++)
            {
                if (((c >> SHIFT_AMOUNT) & 31) == 0 || ((yofs >> SHIFT_AMOUNT) & 31) == 0)
                    *t = 0x0300;
                else
                    *t = 0x01e0;
                t++;
                c += xinc;
            }
        }
        else // x min clip
        if (xofs < (1 << SHIFT_AMOUNT))
        {
            int count = -(xofs / xinc) + 1;
            if (count < 0) count = 0; // kludge
            c = xofs;
            for (j = 0; j < count; j++)
            {
                if (((c >> SHIFT_AMOUNT) & 31) == 0 || ((yofs >> SHIFT_AMOUNT) & 31) == 0)
                    *t = 0x0300;
                else
                    *t = 0x01e0;
                t++;
                c += xinc;
            }
            for (j = count; j < 640; j++)
            {
                int p = ((i & 1) + ((j & 1) << 1)) << 1;
                int v = (((yofs + unreal_dither[p]) >> SHIFT_AMOUNT) * srcpitch) << SHIFT_AMOUNT;
                v += c + unreal_dither[p+1];
                *t = ((short*)src->pixels)[(v) >> SHIFT_AMOUNT];
                t++; 
                c += xinc;
            }
        }
        else // x max clip
        if (xofs + imgwidth > (800 << SHIFT_AMOUNT))
        {            
            int count = 638 - (((xofs + imgwidth) - (800 << SHIFT_AMOUNT)) / xinc);
            
            c = xofs;
            for (j = 0; j < count; j++)
            {
                int p = ((i & 1) + ((j & 1) << 1)) << 1;
                int v = (((yofs + unreal_dither[p]) >> SHIFT_AMOUNT) * srcpitch) << SHIFT_AMOUNT;
                v += c + unreal_dither[p+1];
                *t = ((short*)src->pixels)[(v) >> SHIFT_AMOUNT];
                t++; 
                c += xinc;
            }
            for (j = count; j < 640; j++)
            {
                if (((c >> SHIFT_AMOUNT) & 31) == 0 || ((yofs >> SHIFT_AMOUNT) & 31) == 0)
                    *t = 0x0300;
                else
                    *t = 0x01e0;
                t++;
                c += xinc;
            }            
        }
        else // no clipping
        {
            c = xofs;
            for (j = 0; j < 640; j++)
            {
                int p = ((i & 1) + ((j & 1) << 1)) << 1;
                int v = (((yofs + unreal_dither[p]) >> SHIFT_AMOUNT) * srcpitch) << SHIFT_AMOUNT;
                v += c + unreal_dither[p+1];
                *t = ((short*)src->pixels)[(v) >> SHIFT_AMOUNT];
                t++; 
                c += xinc;
            }
        }
        t += (Game.Screen->pitch / 2) - 640;
        yofs += yinc;
    }


    SDL_UnlockSurface(src);
    SDL_UnlockSurface(Game.Screen);

}
