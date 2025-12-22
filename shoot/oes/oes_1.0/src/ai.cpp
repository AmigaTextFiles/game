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
//#define DRAW_DEBUGLINES

int route(int x1,int y1,int x2, int y2)
{
    if ( SDL_LockSurface(Game.AIMap) < 0 ) 
        return 0;
    
    char *t = (char*)Game.AIMap->pixels;
    
    int x, y;
    int xinc;
    int yinc;
    int len,i;
    
    len = abs(x2 - x1);
    i = abs(y2 - y1);
    if (i > len) len = i;
    if (len == 0) return 0;

    xinc = ((x2 - x1) << SHIFT_AMOUNT) / len;
    yinc = ((y2 - y1) << SHIFT_AMOUNT) / len;

    x = (x1 << SHIFT_AMOUNT) + ((1 << SHIFT_AMOUNT) / 2); 
    y = (y1 << SHIFT_AMOUNT) + ((1 << SHIFT_AMOUNT) / 2);

    for (i = 1; i <= len; i++) 
    {
        if ((t[(x >> SHIFT_AMOUNT) + 
               (y >> SHIFT_AMOUNT) * 
               (Game.AIMap->pitch)] & 0xff) == 1)
            return 0;
        x = x + xinc;
        y = y + yinc;
    }

    SDL_UnlockSurface(Game.AIMap);
    return len;
}

void drawLine(SDL_Surface * aTarget, int x1,int y1,int x2, int y2, int clr) 
{
    if ( SDL_LockSurface(aTarget) < 0 ) 
        return;

    short *t = (short*)aTarget->pixels;
        
    int x, y;
    int xinc;
    int yinc;
    int len,i;
    
    len = abs(x2 - x1);
    i = abs(y2 - y1);
    if (i > len) len = i;
    if (len == 0) return;

    xinc = ((x2 - x1) << SHIFT_AMOUNT) / len;
    yinc = ((y2 - y1) << SHIFT_AMOUNT) / len;

    x = (x1 << SHIFT_AMOUNT) + ((1 << SHIFT_AMOUNT) / 2); 
    y = (y1 << SHIFT_AMOUNT) + ((1 << SHIFT_AMOUNT) / 2);

    for (i = 1; i <= len; i++) 
    {
        t[(x >> SHIFT_AMOUNT) + 
          (y >> SHIFT_AMOUNT) * 
          (aTarget->pitch / 2)] = clr;
            
        x = x + xinc;
        y = y + yinc;
    }

    SDL_UnlockSurface(aTarget);
}



void precalc_ai()
{
    if ( SDL_LockSurface(Game.AIMap) < 0 ) 
        return;
    // Count waypoints

    Game.num_waypoints = 0;
    Game.num_spawnpoints = 0;
    int i,j;
    for (j = 0; j < 600; j++)
    {
        int ofs = j * Game.AIMap->pitch;
        for (i = 0; i < 800; i++)
        {
            switch (*((char*)Game.AIMap->pixels + ofs) & 0xff)
            {
            case 0: // street
                break;
            case 1: // house
                break;
            case 2: // bad guys spawn points
                Game.num_spawnpoints++;
                Game.baddy.spawn++;
                break;
            case 3: // VIP spawn points
                Game.num_spawnpoints++;
                Game.vip.spawn++;
                break;
            case 4: // waypoints
                Game.num_waypoints++;
                break;
            case 5: // neutral spawn points
                Game.num_spawnpoints++;
                Game.pedestrian.spawn++;
                break;
            }
            ofs++;
        }    
    }
    Game.spawnpoints= (SPAWNPOINT*)calloc(Game.num_spawnpoints, sizeof(SPAWNPOINT));
    Game.waypoints = (WAYPOINT*)calloc(Game.num_waypoints, sizeof(WAYPOINT));
    int waypoint = 0;
    int spawnpoint = 0;
    for (j = 0; j < 600; j++)
    {
        int ofs = j * Game.AIMap->pitch;
        for (i = 0; i < 800; i++)
        {
            switch (*((char*)Game.AIMap->pixels + ofs) & 0xff)
            {
            case 0: // street
                break;
            case 1: // house
                break;
            case 2: // bad guys spawn points
                Game.spawnpoints[spawnpoint].mX = i;
                Game.spawnpoints[spawnpoint].mY = j;
                Game.spawnpoints[spawnpoint].mType = CHAR_BADGUY;
                spawnpoint++;
                break;
            case 3: // VIP spawn points
                Game.spawnpoints[spawnpoint].mX = i;
                Game.spawnpoints[spawnpoint].mY = j;
                Game.spawnpoints[spawnpoint].mType = CHAR_VIP;
                spawnpoint++;
                break;
            case 4: // waypoints
                Game.waypoints[waypoint].mX = i;
                Game.waypoints[waypoint].mY = j;
                waypoint++;
                break;
            case 5: // neutral spawn points
                Game.spawnpoints[spawnpoint].mX = i;
                Game.spawnpoints[spawnpoint].mY = j;
                Game.spawnpoints[spawnpoint].mType = 2;
                spawnpoint++;
                break;
            }
            ofs++;
        }    
    }

    // Find and store connections

    for (i = 0; i < Game.num_waypoints; i++)
    {
        waypoint = 0;
        for (j = 0; j < Game.num_waypoints; j++)
            if (route(Game.waypoints[i].mX, Game.waypoints[i].mY, Game.waypoints[j].mX, Game.waypoints[j].mY))
                waypoint++;
        
        Game.waypoints[i].mConnections = waypoint;        
        Game.waypoints[i].mConnection = (int*)calloc(waypoint, sizeof(int));

        waypoint = 0;
        for (j = 0; j < Game.num_waypoints; j++)
            if (route(Game.waypoints[i].mX, Game.waypoints[i].mY, Game.waypoints[j].mX, Game.waypoints[j].mY))
            {
#ifdef DRAW_DEBUGLINES
                drawLine(Game.Map, Game.waypoints[i].mX, Game.waypoints[i].mY, Game.waypoints[j].mX, Game.waypoints[j].mY, 0xffff);
#endif
                Game.waypoints[i].mConnection[waypoint] = j;
                waypoint++;
            }
    }

    for (i = 0; i < Game.num_spawnpoints; i++)
    {
        int spawndist = 10000;
        for (j = 0; j < Game.num_waypoints; j++)
        {
            int newdist = route(Game.spawnpoints[i].mX, Game.spawnpoints[i].mY, Game.waypoints[j].mX, Game.waypoints[j].mY);
            if (newdist && newdist < spawndist)
            {
                spawndist = newdist;
                Game.spawnpoints[i].mClosestWaypoint = j;
            }
        }
    }
#ifdef DRAW_DEBUGLINES
    for (i = 0; i < Game.num_spawnpoints; i++)
        drawLine(Game.Map, Game.spawnpoints[i].mX, Game.spawnpoints[i].mY, Game.waypoints[Game.spawnpoints[i].mClosestWaypoint].mX, Game.waypoints[Game.spawnpoints[i].mClosestWaypoint].mY, 0xf << (Game.spawnpoints[i].mType * 6));
#endif

    SDL_UnlockSurface(Game.AIMap);
}

float distance(float aX1, float aY1, float aX2, float aY2)
{
    return (float)sqrt((aX2 - aX1) * (aX2 - aX1) + (aY2 - aY1) * (aY2 - aY1));
}

float distance_wp(int aWaypoint, float aX, float aY)
{
    return distance((float)Game.waypoints[aWaypoint].mX, (float)Game.waypoints[aWaypoint].mY, aX, aY);
}

float distance_wpwp(int aWaypoint1, int aWaypoint2)
{
    return distance((float)Game.waypoints[aWaypoint1].mX, (float)Game.waypoints[aWaypoint1].mY, (float)Game.waypoints[aWaypoint2].mX, (float)Game.waypoints[aWaypoint2].mY);
}

void validateWaypoint(CHARACTER &c, int &next)
{
    int valid = 0;
    int candidate = next;
    while (!valid)
    {
        valid = 1;
        int i;
        for (i = 0; i < 7; i++)
            if (c.mLastWaypoints[i] == Game.waypoints[c.mNextWaypoint].mConnection[candidate])
                valid = 0;
        if (!valid)
        {
            candidate++;
            if (candidate >= Game.waypoints[c.mNextWaypoint].mConnections)
                candidate = 0;
            if (candidate == next) // no valid waypoints
                return;
        }
    }
    next = candidate;
}

void handle_ai(CHARACTER &c)
{
    // is this AI inactive?
    if (c.mType == -1) 
        return;
    
    // Kludge: hit position sign
    if (c.mType == 3 || c.mType == 4)
    {
        
        c.mTTL--;
        if (c.mTTL < 0)
            c.mType = -1;
        return;
    }

    // Pedestrian AI
    // Pedestrians just walk around, and try not to walk
    // in circles.
    if (c.mType == 2)
    {
        float dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
        // Have we arrived at waypoint?
        if (dist < 4)
        {
            
#ifdef RECYCLE_PEDESTRIANS
            // Reduce time to live..
            c.mTTL--;
            if (c.mTTL <= 0)
            {
                // Wipe and recycle..
                spa(2);
                c.mType = -1;
                return;
            }
#endif
            // Store current waypoint in old waypoints list..
            c.mLastWaypoints[c.mLastWaypoint] = c.mNextWaypoint;
            c.mLastWaypoint++;
            if (c.mLastWaypoint >= 7)
                c.mLastWaypoint = 0;
            // Find a new waypoint
         
            int next = rand() % Game.waypoints[c.mNextWaypoint].mConnections;
            validateWaypoint(c, next);
            c.mNextWaypoint = Game.waypoints[c.mNextWaypoint].mConnection[next];
            // Calculate vector..
            dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
            c.mXi = ((Game.waypoints[c.mNextWaypoint].mX - c.mX) / dist) * c.mSpeed;
            c.mYi = ((Game.waypoints[c.mNextWaypoint].mY - c.mY) / dist) * c.mSpeed;        
            
        }
    }

    // VIP AI
    // VIPs try to find their way to their exit point.
    if (c.mType == CHAR_VIP)
    {
        if (c.mNextWaypoint == -1)
        {
            // Have we arrived home?
            float dist = distance((float)Game.spawnpoints[c.mTarget].mX, (float)Game.spawnpoints[c.mTarget].mY, c.mX, c.mY);
            if (dist < 4)
            {
                // arrived safely.
                c.mType = -1;
                Game.Score += (int)((float)5000*Game.ScoreMod);
                Game.vip.count--;
                Game.vip.goal++;
            }
        }
        else
        {
            float dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
            // Have we arrived at waypoint?
            if (dist < 4)
            {            
                // Store current waypoint in old waypoints list..
                c.mLastWaypoints[c.mLastWaypoint] = c.mNextWaypoint;
                c.mLastWaypoint++;
                if (c.mLastWaypoint >= 7)
                    c.mLastWaypoint = 0;
                // Find a new waypoint
                
                // Can we get to the final destination from here?
                if (route((int)c.mX, (int)c.mY, Game.spawnpoints[c.mTarget].mX, Game.spawnpoints[c.mTarget].mY))
                {
                    // Yep, calculate vector to home
                    c.mNextWaypoint = -1;
                    dist = distance((float)Game.spawnpoints[c.mTarget].mX, (float)Game.spawnpoints[c.mTarget].mY, c.mX, c.mY);
                    c.mXi = ((Game.spawnpoints[c.mTarget].mX - c.mX) / dist) * c.mSpeed;
                    c.mYi = ((Game.spawnpoints[c.mTarget].mY - c.mY) / dist) * c.mSpeed;
                }
                else
                {   
                    // Nope, try to figure out the closest waypoint to target that's connected from here
                    int next = 0;
                    dist = distance_wp(Game.waypoints[c.mNextWaypoint].mConnection[0], (float)Game.spawnpoints[c.mTarget].mX, (float)Game.spawnpoints[c.mTarget].mY);
                    int i;
                    for (i = 1; i < Game.waypoints[c.mNextWaypoint].mConnections; i++)
                    {
                        float newdist = distance_wp(Game.waypoints[c.mNextWaypoint].mConnection[i], (float)Game.spawnpoints[c.mTarget].mX, (float)Game.spawnpoints[c.mTarget].mY);
                        if (newdist < dist)
                        {
                            dist = newdist;
                            next = i;
                        }
                    }
                    // Make sure we're not walking in circles:
                    validateWaypoint(c, next);
                    c.mNextWaypoint = Game.waypoints[c.mNextWaypoint].mConnection[next];
                    // Calculate vector..
                    dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
                    c.mXi = ((Game.waypoints[c.mNextWaypoint].mX - c.mX) / dist) * c.mSpeed;
                    c.mYi = ((Game.waypoints[c.mNextWaypoint].mY - c.mY) / dist) * c.mSpeed;        
                }
            
            }
        }
    }

    // Bad guy AI
    // Bad guys try to find their way to a VIP.
    if (c.mType == CHAR_BADGUY)
    {
        if (c.mTarget != -1 && Game.characters[c.mTarget].mType != 1)
        {
            // Lost target
            c.mTarget = -1;
        }

        if (c.mTarget == -1) // Bad guy without a target
        {
            if (Game.vip.count == 0)
            {
                // No VIPs to pester, walk around randomly
                
                if (c.mNextWaypoint == -1)
                {
                    // We were walking towards a VIP last time, so
                    // we'll need to find the closest waypoint and walk to that.
                    c.mNextWaypoint = 0;
                    int i;
                    float dist = distance_wp(0, c.mX, c.mY);
                    for (i = 1; i < Game.num_waypoints; i++)
                    {
                        float newdist = distance_wp(i, c.mX, c.mY);
                        if (newdist < dist && route(Game.waypoints[i].mX, Game.waypoints[i].mY, (int)c.mX, (int)c.mY))
                        {
                            dist = newdist;
                            c.mNextWaypoint = i;
                        }
                    }
                    // Calculate vector towards the closest waypoint
                    c.mXi = ((Game.waypoints[c.mNextWaypoint].mX - c.mX) / dist) * c.mSpeed;
                    c.mYi = ((Game.waypoints[c.mNextWaypoint].mY - c.mY) / dist) * c.mSpeed;
                }
                else // just walk towards the next waypoint normally
                {
                    float dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
                    // Have we arrived at waypoint?
                    if (dist < 4)
                    {
                        int next = rand() % Game.waypoints[c.mNextWaypoint].mConnections;
                        // Bad guys have nowhere to go, so they might
                        // as well walk in circles.. (hence, no validatewaypoint)
                        c.mNextWaypoint = Game.waypoints[c.mNextWaypoint].mConnection[next];
                        // Calculate vector..
                        dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
                        c.mXi = ((Game.waypoints[c.mNextWaypoint].mX - c.mX) / dist) * c.mSpeed;
                        c.mYi = ((Game.waypoints[c.mNextWaypoint].mY - c.mY) / dist) * c.mSpeed;        
                    }
                }
            }
            else // target a VIP
            {
                int t = rand() % Game.vip.count;
                int i = 0;
                while (t > 0 || Game.characters[i].mType != CHAR_VIP)
                {
                    if (Game.characters[i].mType == CHAR_VIP)
                        t--;
                    i++;
                }                
                c.mTarget = i;
                // Avoid sudden death:
                if (distance(c.mX, c.mY, Game.characters[c.mTarget].mX, Game.characters[c.mTarget].mY) < 20)
                {
                    c.mTarget = -1;
                    if (c.mNextWaypoint == -1)
                    {
                        c.mXi = 0;
                        c.mYi = 0;
                    }
                }
            }
        }
        
        int nolineofsight = 1;

        // Do we have line of sight to the VIP?
        if (route((int)c.mX, (int)c.mY, (int)Game.characters[c.mTarget].mX, (int)Game.characters[c.mTarget].mY))
        {
            nolineofsight = 0;
            // Calculate new vector to it
            float dist = distance(Game.characters[c.mTarget].mX, Game.characters[c.mTarget].mY, c.mX, c.mY);
            c.mXi = ((Game.characters[c.mTarget].mX - c.mX) / dist) * c.mSpeed;
            c.mYi = ((Game.characters[c.mTarget].mY - c.mY) / dist) * c.mSpeed;
            c.mNextWaypoint = -1;
        }


        if (c.mNextWaypoint == -1)
        {
            // Caught up with the VIP?
            float dist = distance((float)Game.characters[c.mTarget].mX, (float)Game.characters[c.mTarget].mY, c.mX, c.mY);
            if (dist < 3)
            {
                // arrived safely.
                c.mType = -1;
                Game.Score -= (int)((float)10000*Game.ScoreMod); // +game over
                Game.vip.count--;
                Game.baddy.count--;
                Game.characters[c.mTarget].mType = -1;
#ifdef DISPLAY_GAMEOVER_SCREEN
//                gameoverscreen(2);
                Game.GameOverReason = OESREASON_NEGLIGENT;
//                draw_gameoverscreen(Game.Screen);
                return;
#endif
            }
            else
            {
                if (nolineofsight)
                {
                    // Lost the VIP. Find closest accessible waypoint.
                    c.mNextWaypoint = 0;
                    int i;
                    float dist = distance_wp(0, Game.characters[c.mTarget].mX, Game.characters[c.mTarget].mY);
                    for (i = 1; i < Game.num_waypoints; i++)
                    {
                        float newdist = distance_wp(i, Game.characters[c.mTarget].mX, Game.characters[c.mTarget].mY);
                        if (newdist < dist && route(Game.waypoints[i].mX, Game.waypoints[i].mY, (int)c.mX, (int)c.mY))
                        {
                            dist = newdist;
                            c.mNextWaypoint = i;
                        }
                    }
                    // Calculate vector towards the closest waypoint
                    dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
                    c.mXi = ((Game.waypoints[c.mNextWaypoint].mX - c.mX) / dist) * c.mSpeed;
                    c.mYi = ((Game.waypoints[c.mNextWaypoint].mY - c.mY) / dist) * c.mSpeed;        
                }
            }
        }
        else
        {
            float dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
            // Have we arrived at waypoint?
            if (dist < 4)
            {            
                // Find a new waypoint
                
                if (nolineofsight)
                {   
                    // Can't see the VIP, try to figure out the closest waypoint to target that's connected from here
                    int next = 0;
                    dist = distance_wp(Game.waypoints[c.mNextWaypoint].mConnection[0], Game.characters[c.mTarget].mX, Game.characters[c.mTarget].mY);
                    int i;
                    for (i = 1; i < Game.waypoints[c.mNextWaypoint].mConnections; i++)
                    {
                        float newdist = distance_wp(Game.waypoints[c.mNextWaypoint].mConnection[i], Game.characters[c.mTarget].mX, Game.characters[c.mTarget].mY);
                        if (newdist < dist)
                        {
                            dist = newdist;
                            next = i;
                        }
                    }
                    // Note: bad guys MAY run in circles.                    
                    c.mNextWaypoint = Game.waypoints[c.mNextWaypoint].mConnection[next];
                    // Calculate vector..
                    dist = distance_wp(c.mNextWaypoint, c.mX, c.mY);
                    c.mXi = ((Game.waypoints[c.mNextWaypoint].mX - c.mX) / dist) * c.mSpeed;
                    c.mYi = ((Game.waypoints[c.mNextWaypoint].mY - c.mY) / dist) * c.mSpeed;        
                }
            
            }
        }
    }


    // Make 'em walk
    c.mX += c.mXi;
    c.mY += c.mYi;    
}

int findspawnpoint(int aIndex, int aType)
{
    int i, j;
    j = 0;
    i = 0;
    while (i < Game.num_spawnpoints)
    {
        if (Game.spawnpoints[i].mType == aType)
            j++;
        if (j > aIndex) 
            return i;
        i++;
    }
    return i;
}

int spawn_ai(int aType)
{
    
    // find empty slot
    int slot = 0;
    while (slot < Game.num_characters && Game.characters[slot].mType != -1) slot++;
    Game.characters[slot].mType = -1; // Overwrite the last slot if all slots were in use
    Game.characters[slot].mLastWaypoint = 0;
    int i;
    for (i = 0; i < 7; i++)
        Game.characters[slot].mLastWaypoints[i] = -1;

    if (aType == CHAR_BADGUY)
    {
        Game.baddy.count++;
        // spawn a bad guy
        int spawnpoint = 0;
        int i = rand() % Game.baddy.spawn;
        spawnpoint = findspawnpoint(i, CHAR_BADGUY);

        Game.characters[slot].mType = CHAR_BADGUY;
        Game.characters[slot].mX = (float)Game.spawnpoints[spawnpoint].mX;
        Game.characters[slot].mY = (float)Game.spawnpoints[spawnpoint].mY;
        Game.characters[slot].mTarget = -1; // find target at next handle_ai pass
        Game.characters[slot].mNextWaypoint = Game.spawnpoints[spawnpoint].mClosestWaypoint;
    }

    if (aType == CHAR_VIP)
    {
        if (Game.vip.count >= 3)
            return 0; // 3 vips at a time, thanks
        Game.vip.count++;
        // spawn a VIP
        int spawnpoint = 0;
        int i = rand() % Game.vip.spawn;
        spawnpoint = findspawnpoint(i, CHAR_VIP);

        Game.characters[slot].mType = CHAR_VIP;
        Game.characters[slot].mX = (float)Game.spawnpoints[spawnpoint].mX;
        Game.characters[slot].mY = (float)Game.spawnpoints[spawnpoint].mY;
        Game.characters[slot].mNextWaypoint = Game.spawnpoints[spawnpoint].mClosestWaypoint;        

        int targetspawnpoint = 0;
        float dist = 0;
        // find target waypont, avoiding free score
        while (dist < 20)
        {
            i = rand() % Game.vip.spawn;
            targetspawnpoint = findspawnpoint(i, 1);
            dist = distance(Game.characters[slot].mX, Game.characters[slot].mY, (float)Game.spawnpoints[targetspawnpoint].mX, (float)Game.spawnpoints[targetspawnpoint].mY);
        }
        Game.characters[slot].mTarget = targetspawnpoint;
    }

    if (aType == CHAR_PEDESTRIAN)
    {
        // spawn a pedestrian
        int spawnpoint = 0;
        int i = rand() % Game.pedestrian.spawn;
        spawnpoint = findspawnpoint(i, CHAR_PEDESTRIAN);
        Game.characters[slot].mType = CHAR_PEDESTRIAN;
        Game.characters[slot].mX = (float)Game.spawnpoints[spawnpoint].mX;
        Game.characters[slot].mY = (float)Game.spawnpoints[spawnpoint].mY;
        Game.characters[slot].mTTL = rand() % 10 + 5;
        Game.characters[slot].mNextWaypoint = Game.spawnpoints[spawnpoint].mClosestWaypoint;        
    }
    float dist = distance_wp(Game.characters[slot].mNextWaypoint, Game.characters[slot].mX, Game.characters[slot].mY);
    Game.characters[slot].mSpeed = (((((rand()%32768)/32768.0)) + 0.5f) * 0.5f) /
    5.0f;
    // slow down pedestrians, they're not in a hurry..
    if (aType == CHAR_PEDESTRIAN) Game.characters[slot].mSpeed *= 0.5f;
    Game.characters[slot].mXi = ((Game.waypoints[Game.characters[slot].mNextWaypoint].mX - Game.characters[slot].mX) / dist) * Game.characters[slot].mSpeed;
    Game.characters[slot].mYi = ((Game.waypoints[Game.characters[slot].mNextWaypoint].mY - Game.characters[slot].mY) / dist) * Game.characters[slot].mSpeed;
    return slot;
}



void shoot()
{
    Game.WobbleIndex += 2048;
    Game.Reloading = Game.ReloadTime;
#ifdef CAMERA_RECOIL    
    if (Game.MouseZ < 0.25f) Game.MouseZ = 0.25f;
#ifndef CAMERA_STEPS
    Game.CoordScale = Game.MouseZ;
#else
    Game.CoordScale = ((int)(Game.MouseZ * 4)) / 4.0f;
    if (Game.CoordScale < 0.05f) Game.CoordScale = 0.05f;
#endif
#endif
    int slot = 0;
    while (Game.characters[slot].mType != -1) slot++;
    Game.characters[slot].mLastWaypoint = 0;

    float worldx = Game.MouseX + Game.WobbleX + Game.CenterX + 320 * Game.CoordScale;
    float worldy = Game.MouseY + Game.WobbleY + Game.CenterY + 240 * Game.CoordScale;

    int hit = 0;
    int gameover = 0;
    int i;
    for (i = 0; i < Game.num_characters; i++)
    {
        if (Game.characters[i].mType != -1)
        {
            if (Game.characters[i].mX > worldx - 1 &&
                Game.characters[i].mX < worldx + 1 &&
                Game.characters[i].mY > worldy - 1 &&
                Game.characters[i].mY < worldy + 1)
            {
                if (Game.characters[i].mType == CHAR_BADGUY)
                {
                    Game.Score += (int)((float)1000*Game.ScoreMod);
                    Game.baddy.count--;
                    Game.baddy.dead++;
                }
                if (Game.characters[i].mType == CHAR_VIP)
                {
                    Game.Score -= (int)((float)100000*Game.ScoreMod); // +game over
                    gameover = 1;
                    Game.vip.count--;
                }
                if (Game.characters[i].mType == CHAR_PEDESTRIAN)
                {
                    Game.pedestrian.dead++;
                    Game.Score -= (int)((float)100*Game.ScoreMod);
#ifdef RECYCLE_PEDESTRIANS
                   spawn_ai(2); // spawn a new pedestrian
#endif
                }
                Game.characters[i].mType = -1;
                hit = 1;
            }
        }
    }
#ifdef DISPLAY_GAMEOVER_SCREEN
    if (gameover)
    {
//        gameoverscreen(1);
        Game.GameOverReason = OESREASON_FRAG;
//        draw_gameoverscreen(Game.Screen);
    }
#endif

    Game.characters[slot].mType = hit?3:4; // hit marker
    Game.characters[slot].mX = worldx;
    Game.characters[slot].mY = worldy;
    Game.characters[slot].mTTL = 100;
}
