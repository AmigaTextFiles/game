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

void target()
{
    static int lastBadGuys = -1;
    static int lastVIPs = -1;
    static int badGuysChangeTick = 0;
    static int VIPsChangeTick = 0;

    int tick = SDL_GetTicks();

    if (lastBadGuys != Game.baddy.count)
    {
        lastBadGuys = Game.baddy.count;
        badGuysChangeTick = tick;
    }
    if (lastVIPs != Game.vip.count)
    {
        lastVIPs = Game.vip.count;
        VIPsChangeTick = tick;
    }
    
    if ( SDL_LockSurface(Game.Screen) < 0 ) 
        return;

    int i;
    short *tgt = (short*)Game.Screen->pixels;

    if (Game.Reloading)    
    {
        float distance = Game.Reloading / (float)Game.ReloadTime;
        distance = distance * distance * distance;

        int ofs = (Game.Screen->pitch / 2) * 240;
        for (i = 0; i < 640; i++, ofs++)
            tgt[ofs] = (short)0;

        ofs = 320;
        for (i = 0; i < 480; i++, ofs += Game.Screen->pitch / 2)
            tgt[ofs] = (short)0;

        ofs = (Game.Screen->pitch / 2) * (int)(240 + distance * 200);
        for (i = 0; i < 640; i++, ofs++)
            tgt[ofs] = (short)0xC000;
        
        ofs = (Game.Screen->pitch / 2) * (int)(240 - distance * 200);
        for (i = 0; i < 640; i++, ofs++)
            tgt[ofs] = (short)0xC000;

        ofs = (int)(320 + distance * 300);
        for (i = 0; i < 480; i++, ofs += Game.Screen->pitch / 2)
            tgt[ofs] = (short)0xC000;

        ofs = (int)(320 - distance * 300);
        for (i = 0; i < 480; i++, ofs += Game.Screen->pitch / 2)
            tgt[ofs] = (short)0xC000;

        SDL_UnlockSurface(Game.Screen);

    }
    else // not reloading
    {
        int ofs = (Game.Screen->pitch / 2) * 240;
        for (i = 0; i < 640; i++, ofs++)
            tgt[ofs] = (short)0xff00;

        ofs = 320;
        for (i = 0; i < 480; i++, ofs += Game.Screen->pitch / 2)
            tgt[ofs] = (short)0xff00;

        SDL_UnlockSurface(Game.Screen);
    }
    
    int row;
    row = 196;
    if(Game.verbosity >= 1) print(324, row, COLOR_YELLOW, "time:    %02d:%02d", ((SDL_GetTicks() -
    Game.GameStartTick) / 60000), ((SDL_GetTicks() - Game.GameStartTick) / 1000)%60);
    row += 7;
    if(Game.verbosity >= 1) {
    if ((tick - VIPsChangeTick) < 500)
        print(324, row, COLOR_GREEN, "VIPs    %6d", Game.vip.count);
    else
        print(324, row, COLOR_YELLOW, "VIPs    %6d", Game.vip.count);
    }
    row += 7;
    if(Game.verbosity >= 2) {
    if ((tick - badGuysChangeTick) < 500)
        print(324, row, COLOR_RED, "Threat  %6d", Game.baddy.count);
    else
        print(324, row, COLOR_YELLOW, "Threat  %6d", Game.baddy.count);
    }
    row += 7;
    if(Game.verbosity >= 2) print(324, row, COLOR_YELLOW, "Score%09.8d", Game.Score);
    row += 7;
    if(Game.verbosity >= 2) print(324, row, COLOR_YELLOW, "FPS     %3.3f", (Game.FrameCount * 1000.0f) / (tick - Game.StartTick));
    row += 7;
    if(Game.verbosity >= 1) print(324, row, COLOR_YELLOW, "Zoom  %7.0fx", (1.0f / Game.CoordScale) * 100);
    row = 244;
    if(Game.verbosity >= 2) {
	if (Game.SightedCharacter == NULL) {
        print(278, row, COLOR_YELLOW, "%10x", (tick >> 4) *  700);
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (tick >> 3) *  1337);
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (tick >> 2) *  4);
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (tick >> 1) *  4935);
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (int)(Game.MouseX * 0xc0c4c01a) - (tick >> 3));
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (int)(Game.MouseY * 0xb4be2b3d) - (tick >> 4));
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (tick << 4) *  4095);
        row += 7;
        print(278, row, COLOR_YELLOW, "%10x", (int)(Game.MouseZ * 0xf00ba573) - (tick >> 5));
    }
        else {
        print(238, row, COLOR_YELLOW, "%20s", "Citizen profile");
        row += 7;
        row += 7;
        print(238, row, COLOR_YELLOW, "%20s", "Coordinates");
        row += 7;
        print(238, row, COLOR_YELLOW, "     %6.2f - %6.2f", Game.SightedCharacter->mX, Game.SightedCharacter->mY);
        row += 7;
        row += 7;
        print(238, row, COLOR_YELLOW, "%20s", "Classification");
        row += 7;
        switch (Game.SightedCharacter->mType)
        {
        case 0:
            print(239, row + 1, COLOR_BLACK, "%20s", "** THREAT **");
            print(238, row, COLOR_RED, "%20s", "** THREAT **");
            row += 7;
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "Destination");
            row += 7;
            if (Game.SightedCharacter->mTarget != -1)
            {
                print(238, row, COLOR_YELLOW, "     %6.2f - %6.2f", Game.characters[Game.SightedCharacter->mTarget].mX, Game.characters[Game.SightedCharacter->mTarget].mY);
                row += 7;
                row += 7;
                print(238, row, COLOR_YELLOW, "%20s", "Distance");
                row += 7;
                print(238, row, COLOR_YELLOW, "     %15.2f", distance(Game.characters[Game.SightedCharacter->mTarget].mX, Game.characters[Game.SightedCharacter->mTarget].mY, Game.SightedCharacter->mX, Game.SightedCharacter->mY));
            }
            else
            print(238, row, COLOR_YELLOW, "%20s", "Unknown");
            row += 7;
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "VPB file ID");
            row += 7;
            print(238, row, COLOR_YELLOW, "      %03X-%07X/%02X", 
                        ((((unsigned int)Game.SightedCharacter) * 7001337) & 0xfff),
                        (((unsigned int)Game.SightedCharacter) * 1337357) & 0xfffffff,
                        (((unsigned int)Game.SightedCharacter) * 70741)  & 0xff);


            break;
        case 1:
            print(239, row + 1, COLOR_BLACK, "%20s", "- VIP -");
            print(238, row, COLOR_GREEN, "%20s", "- VIP -");
            row += 7;
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "Destination");
            row += 7;
            print(238, row, COLOR_YELLOW, "     %6.2f - %6.2f", (float)Game.spawnpoints[Game.SightedCharacter->mTarget].mX, (float)Game.spawnpoints[Game.SightedCharacter->mTarget].mY);
            row += 7;
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "Distance");
            row += 7;
            print(238, row, COLOR_YELLOW, "     %15.2f", distance((float)Game.spawnpoints[Game.SightedCharacter->mTarget].mX, (float)Game.spawnpoints[Game.SightedCharacter->mTarget].mY, Game.SightedCharacter->mX, Game.SightedCharacter->mY));
            row += 7;
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "Net worth");
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "Classified");
            break;
        case 2:
            print(238, row, COLOR_YELLOW, "%20s", "Citizen");
            row += 7;
            row += 7;
            print(238, row, COLOR_YELLOW, "%20s", "Net worth");
            row += 7;
            print(238, row, COLOR_YELLOW, "%17u KC", (((unsigned int)Game.SightedCharacter) * 1337357) % 71937);
            break;
        case 3:
            print(238, row, COLOR_YELLOW, "%20s", "Splat.");
            break;
        case 4:
            print(238, row, COLOR_BLACK, "%20s", "Missed shot");
            break;
        }
        row += 7;

    	}
    }

    if (Game.FrameCount > 100)
    {
        Game.FrameCount = 0;
        Game.StartTick = tick;
    }
    
}

