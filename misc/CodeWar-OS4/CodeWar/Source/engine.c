// INCLUDES---------------------------------------------------------------

#if defined(_lint) || defined(__VBCC__)
    #define AMIGA
#endif

#ifdef WIN32
    #include <windows.h>
#endif
#ifdef AMIGA
    #define __USE_OLD_TIMEVAL__
    #include <exec/types.h>
    #include <intuition/intuition.h>
#endif

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#ifdef AMIGA
     #include "amiga.h"
#endif
#ifdef WIN32
     #include "ibm.h"
     #include "resource.h"
#endif
#include "cw.h"
#include "codewar.h"
#include "pixmaps.h"

// DEFINES----------------------------------------------------------------

// #define OUTLINE
// whether to draw a square outline around robots

#define VELOCITY_MAX_ROBOT     (15.0)
#define VELOCITY_MAX_WEAPON    (20.0)
/* VELOCITY_MAX_#? is per axis.
  The pythagorized (combined) velocity of X=10,Y=10 is approx. 14.14.
  The pythagorized (combined) velocity of X=15,Y=15 is approx. 21.21.
  The pythagorized (combined) velocity of X=20,Y=20 is approx. 28.28. */
#define TIME_INT                ((float) interval / 1000.0) // in seconds
#define FPS                     (1000.0 / interval)
#define CW_BATTLE_X             (100)
#define CW_BATTLE_Y             (100)
#define GFX_WIDTH               (512)
#define GFX_HEIGHT              (512)

/* wall types:
 *     RUBBER - X-Craft bounce off walls on contact.
 *      STONE - X-Craft velocity stopped upon wall contact/damage.
 *      ABYSS - X-Craft are destroyed by wall contact.
 *   TWILIGHT - X-Craft transport to other side of battlefield.
 */

#define DMG_RANGE_ATOMIC   (25.0)
#define DMG_RANGE_BOMB     (25.0)
#define DMG_RANGE_CANNON   ( 5.0)
#define DMG_RANGE_MISSILE  (10.0)

#define DMG_FACTOR_ATOMIC  (30.0)
#define DMG_FACTOR_BOMB    (25.0)
#define DMG_FACTOR_CANNON   (5.0)
#define DMG_FACTOR_MISSILE (10.0)

#define DFT_ATOMICS            5
#define DFT_BOMBS             10
#define DFT_CANNONS           20
#define DFT_MISSILES          50

#define DFT_BOUNDARY         RUBBER
#define DFT_DAMAGE_MAX          100
#define DFT_ENERGY              100
#define DFT_FORCE              1000
#define DFT_INTERVAL             40 // in milliseconds (1000 ms / 40 ms = 25 FPS)
#define DFT_MASS                 10
#define DFT_SHIELDS             100
// Maximum acceleration is force / mass = 1000 / 10 = 100
// Maximum velocity = 10

#define SETPOINT(x,y,colour) display[corner + (x) + ((y) * battle.width)] = (colour)

// EXPORTED VARIABLES-----------------------------------------------------

EXPORT FLAG        hangon               = FALSE,
                   keydown[ROBOTS],
                   paused               = FALSE,
                   show_stars           = TRUE,
                   sound                = TRUE,
                   turbo                = FALSE;
EXPORT TEXT        globalstring[ROBOTS][256 + 1],
                   output_buffer[256 + 1];
EXPORT ULONG       animframe            = 0;
#ifdef WIN32
    EXPORT ULONG  *BodyPtr[ROBOTS],
                  *display              = NULL,
                  *stars                = NULL;
#endif
#ifdef AMIGA
    EXPORT UBYTE  *BodyPtr[ROBOTS],
                  *display              = NULL,
                  *stars                = NULL;
#endif

EXPORT int         dft_atomics          = DFT_ATOMICS,
                   dft_bombs            = DFT_BOMBS,
                   dft_cannons          = DFT_CANNONS,
                   dft_energy           = DFT_ENERGY,
                   dft_force            = DFT_FORCE,
                   dft_mass             = DFT_MASS,
                   dft_missiles         = DFT_MISSILES,
                   dft_shields          = DFT_SHIELDS,
                   damage_max           = DFT_DAMAGE_MAX,
                   interval             = DFT_INTERVAL,
                   speedup              = SPEED_4QUARTERS,
                   wall_type            = DFT_BOUNDARY;
EXPORT Player      player[ROBOTS];
EXPORT Weapon      weapon[WEAPONS];
EXPORT Config      config;
EXPORT game_window battle;

// IMPORTED VARIABLES-----------------------------------------------------

#ifdef AMIGA
IMPORT LONG                  pens[PENS];
IMPORT struct CodeWarSglMsg* SglMsgPtr;
#endif
#ifdef WIN32
IMPORT struct
{   BITMAPINFOHEADER Header;
    DWORD            Colours[3];
} TheBitMapInfo;
#endif

// MODULE VARIABLES-------------------------------------------------------

MODULE float                 max_acc;
#ifdef WIN32
MODULE int                   mt,
                             rw;
MODULE const ULONG dim_colour[] =
{   0x020207, // #1: blue
    0x070202, // #2: red
    0x020702, // #3: green
    0x070702, // #4: yellow
    0x070402, // #5: orange
    0x070207, // #6: purple
    0x020707, // #7: cyan
    0x070404  // #8: pink
}, bright_colour[8] =
{   0x4040FF, // #1: blue
    0xFF4040, // #2: red
    0x40FF40, // #3: green
    0xFFFF40, // #4: yellow
    0xFF8040, // #5: orange
    0xFF40FF, // #6: purple
    0x40FFFF, // #7: cyan
    0xFF8080  // #8: pink
};
#endif

MODULE const UBYTE digits[10][5] = {
{ 0x0E, // .000.
  0x11, // 0...0
  0x11, // 0...0
  0x11, // 0...0
  0x0E  // .000.
},
{ 0x04, // ..1..
  0x0C, // .11..
  0x04, // ..1..
  0x04, // ..1..
  0x0E  // .111.
},
{ 0x1E, // 2222.
  0x01, // ....2
  0x0E, // .222.
  0x10, // 2....
  0x1F  // 22222
},
{ 0x1E, // 3333
  0x01, // ....3
  0x0E, // .333.
  0x01, // ....3
  0x1E  // 3333.
},
{ 0x06, // ..44.
  0x0A, // .4.4.
  0x1F, // 44444
  0x02, // ...4.
  0x02  // ...4.
},
{ 0x1F, // 55555
  0x10, // 5....
  0x1E, // 5555.
  0x01, // ....5
  0x1E  // 5555.
},
{ 0x0F, // .6666
  0x10, // 6....
  0x1E, // 6666.
  0x11, // 6...6
  0x0E  // .666.
},
{ 0x1F, // 77777
  0x02, // ...7.
  0x04, // ..7..
  0x08, // .7...
  0x10  // 7....
},
{ 0x0E, // .888.
  0x11, // 8...8
  0x0E, // .888.
  0x11, // 8...8
  0x0E  // .888.
},
{ 0x0E, // .999.
  0x11, // 9...9
  0x0F, // .9999
  0x01, // ....9
  0x1E  // 9999.
}
};

EXPORT const int speedupnum[SPEED_MAX - SPEED_MIN + 1] =
{    25,
     50,
     75,
    100,
    125,
    150,
    200,
    400,
    800
};

// MODULE FUNCTIONS-------------------------------------------------------

MODULE void add_explosion(int whichweapon);
MODULE void add_weapon(int robot, short weapon_type, float velocity, float direction, float detonate);
MODULE void check_collide(void);
MODULE void damage_calc(int robot, float distance, float range, float factor);
MODULE void damage_check_players(short weapon, float x, float y, int robot);
MODULE void draw_pain(int robot);
MODULE void hurt_robot(int robot, int damage);
MODULE float scan(int robot, float angle, float precision);
MODULE void simulate(void);
MODULE int weapon_update(int whichweapon);

// CODE-------------------------------------------------------------------

MODULE void damage_check_players(short weapon, float x, float y, int robot)
{   int   localrobot;
    float distance,
          factor   = 0.0,
          range    = 0.0;

    switch (weapon)
    {
    case WP_MISSILE:
        range = DMG_RANGE_MISSILE;
        factor = DMG_FACTOR_MISSILE;
    acase WP_ATOMIC:
        range = DMG_RANGE_ATOMIC;
        factor = DMG_FACTOR_ATOMIC;
    acase WP_CANNON:
        range = DMG_RANGE_CANNON;
        factor = DMG_FACTOR_CANNON;
    acase WP_BOMB:
        range = DMG_RANGE_BOMB;
        factor = DMG_FACTOR_BOMB;
    }

    for (localrobot = 0; localrobot < ROBOTS; localrobot++)
    {   if (player[localrobot].alive)
        {   if
            (   (distance = (float) pythagoras
                            (   (x - player[localrobot].position[X_AXIS]),
				                (y - player[localrobot].position[Y_AXIS])
                )           )
                < range
            )
            {   player[localrobot].conqueror = robot;
                damage_calc(localrobot, distance, range, factor);
}   }   }   }

/* damage_calc - Robot damage calculation function. Damage is calculated
 * by consideration of two main factors:
 *   1. How far away from the center of the explosion the robot was
 *      compared to the range of the weapon.
 *   2. A division factor which is designed to represent the relative
 *      power of the explosion (ie. the evilness of the weapon).

robot:            the victim.
range:            radius of the explosion, in metres.
distance:         distance of the victim from the centre of the explosion, in metres.
factor:           evilness of weapon (intrinsic power of the explosion)
range - distance: distance of the victim from the edge of the explosion.
*/
MODULE void damage_calc(int robot, float distance, float range, float factor)
{   int damage;

    damage = (int) ((factor / (range / (range - distance))) + 0.5);

    if (damage == 0)
    {   damage = 1; // always at least one point of damage from being hit
    }

    hurt_robot(robot, damage);
}

MODULE void add_explosion(int whichweapon)
{   int   leftx, rightx,
          topy, bottomy,
          pixelradius;
    float radius = 0.0; // initialized to prevent spurious SAS/C optimizer warnings

    play_sample(weapon[whichweapon].weapon);

    switch (weapon[whichweapon].weapon)
    {
    case WP_MISSILE:
        radius = DMG_RANGE_MISSILE;
    acase WP_ATOMIC:
        radius = DMG_RANGE_ATOMIC;
    acase WP_CANNON:
        radius = DMG_RANGE_CANNON;
    acase WP_BOMB:
        radius = DMG_RANGE_BOMB;
    }

    leftx   = (int) x_to_gfx((float) (weapon[whichweapon].position[X_AXIS] - radius));
    topy    = (int) y_to_gfx((float) (weapon[whichweapon].position[Y_AXIS] - radius));
    rightx  = (int) x_to_gfx((float) (weapon[whichweapon].position[X_AXIS] + radius));
    bottomy = (int) y_to_gfx((float) (weapon[whichweapon].position[Y_AXIS] + radius));

    if (battle.scale[X_AXIS] < battle.scale[Y_AXIS])
    {   pixelradius = x_to_gfx(radius);
    } else
    {   pixelradius = y_to_gfx(radius);
    }
    hangon = TRUE;

    draw_explosion(weapon[whichweapon].robot, pixelradius, leftx, rightx, topy, bottomy);
}

/* scan - performs a check for other robots within the angle and range
 * specified. Returns the distance to the nearest target, or -1.0 if
 * nothing was found.
 */
MODULE float scan(int robot, float angle, float precision)
{   int   victim;
    float plr_angle,
          delta_x,
          delta_y,
          distance,
          ret_val = -1.0;

    for (victim = 0; victim < ROBOTS; victim++)
    {   if (victim != robot && player[victim].alive)
        {   delta_x = (float) (player[victim].position[X_AXIS] - player[robot].position[X_AXIS]);
            delta_y = (float) (player[victim].position[Y_AXIS] - player[robot].position[Y_AXIS]);
            if (delta_x != 0.0 || delta_y != 0.0)
            {   // calculate angle from oppressor to victim
                plr_angle = (float) rad_2_deg(atan2((double) delta_y, (double) delta_x));
                if (plr_angle < 0.0)
                {   plr_angle += 360.0;
                }
                distance = (float) pythagoras(delta_x, delta_y);
                if
                (   angle - plr_angle >= -precision
                 && angle - plr_angle <=  precision
                )
                {   if (ret_val == -1.0)
                    {   ret_val = distance;
                    } elif (distance < ret_val)
                    {   ret_val = distance;
    }   }   }   }   }

    return ret_val;
}

/* simulate - this is the main processing routine called from the simulation
 * timer expiring.  It is responsible for updating all player positions,
 * weapons, and resulting consequences.
 *
 * this routine works out where the player's X-Craft is
 * based upon their last "cw_power()" call and their current position,
 * heading etc.  Acceleration is generated by the config.h setting for the
 * maximum X-Craft force (F) and the weight of the X-Craft, which is related
 * to the number of weapons used.
 *
 * Main equations:    Force = Mass * Acceleration
 *                 Velocity = Initial_Velocity + Acceration * Time_Interval
 *     Pos_Final - Pos_Init = 1/2 * (Init_Vel + Final_Vel) * Time_Interval
 */
MODULE void simulate(void)
{   TRANSIENT int   i,
                    robot;
    PERSIST   float newpos[2],
                    prevtime = 0;

    config.elapsed_time += config.time_int;

    for (robot = 0; robot < ROBOTS; robot++)
    {   if (player[robot].alive)
        {   if ((int) config.elapsed_time > (int) prevtime)
            {   i = goodrand() % 4;
                switch (i)
                {
                case WP_ATOMIC:
                    if (player[robot].atomics  == 0) player[robot].atomics  = 1;
                acase WP_BOMB:
                    if (player[robot].bombs    == 0) player[robot].bombs    = 1;
                acase WP_CANNON:
                    if (player[robot].cannons  == 0) player[robot].cannons  = 1;
                acase WP_MISSILE:
                    if (player[robot].missiles == 0) player[robot].missiles = 1;
            }   }

            for (i = 0; i < 2; i++)
            {   player[robot].velocity[i] += player[robot].acc[i] * (float) config.time_int;
                if (player[robot].velocity[i] < -VELOCITY_MAX_ROBOT)
                {   player[robot].velocity[i] = -VELOCITY_MAX_ROBOT;
                } elif (player[robot].velocity[i] > VELOCITY_MAX_ROBOT)
                {   player[robot].velocity[i] = VELOCITY_MAX_ROBOT;
                }
                newpos[i] = (float)
                (   player[robot].position[i]
                  + (      player[robot].velocity[i] * config.time_int)
                  + (0.5 * player[robot].acc[i]      * config.time_int * config.time_int)
                );
                if (newpos[i] < 0.0 || newpos[i] >= config.field[i])
                {   switch (wall_type)
                    {
                    case RUBBER:
                        player[robot].velocity[i] =  -player[robot].velocity[i];
                        player[robot].position[i] += (float) (player[robot].velocity[i] * config.time_int);
                    acase STONE:
                        if (newpos[i] >= config.field[i])
                        {   player[robot].position[i] = (float) (config.field[i] - 1.0);
                            player[robot].velocity[i] = 0.0;
 	                    }
                        if (newpos[i] < 0.0)
                        {   player[robot].position[i] = 0.0;
                            player[robot].velocity[i] = 0.0;
  	                    }
                    acase ABYSS:
                        remove_player(robot, TRUE);
                    acase TWILIGHT:
                        if (newpos[i] >= config.field[i])
                        {   player[robot].position[i] = newpos[i] - config.field[i];
                        } elif (newpos[i] < 0.0)
    	                {   player[robot].position[i] = newpos[i] + config.field[i];
                }   }   }
                else
                {   player[robot].position[i] = newpos[i];
    }   }   }   }

    prevtime = config.elapsed_time;
}

EXPORT void srv_Print_Buffer(int robot)
{
#ifdef WIN32
    read_clip(robot);
#endif
    if (globalstring[robot][0] != '~')
    {   garbled(robot, 1);
        return;
    }

    strcpy(player[robot].message, &globalstring[robot][1]);
    updatemessage(robot);
}

EXPORT void set_name(int robot)
{
#ifdef WIN32
    read_clip(robot);
#endif

    if (globalstring[robot][0] != '*')
    {   garbled(robot, 2);
        return;
    }

    strcpy(player[robot].name, &globalstring[robot][1]);
    updatename(robot);
}

EXPORT void srv_Power(int robot)
{   int   i;
    float acceleration,
          direction,
          max_axis_acc[2];
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    acceleration = zatof(strfloat1);
    direction    = zatof(strfloat2);
    if (rw != (int) player[robot].window || mt != MT_POWER)
    {   garbled(robot, 3);
        return;
    }
#endif
#ifdef AMIGA
    acceleration = SglMsgPtr->cw_Single1;
    direction    = SglMsgPtr->cw_Single2;
#endif

    player[robot].heading     = (float)           deg_2_rad(direction);
    player[robot].accel       =                   acceleration;
    player[robot].acc[X_AXIS] = (float) ((double) acceleration *         cos((double) player[robot].heading));
    player[robot].acc[Y_AXIS] = (float) ((double) acceleration *         sin((double) player[robot].heading));

    max_axis_acc[X_AXIS]      = (float)           max_acc      * (float) cos((double) player[robot].heading);
    max_axis_acc[Y_AXIS]      = (float)           max_acc      * (float) sin((double) player[robot].heading);
    for (i = 0; i < 2; i++)
    {   if
        (   fabs((double) player[robot].acc[i])
          > fabs((double) max_axis_acc[i])
        )
        {   if (player[robot].acc[i] >= 0.0)
	        {   player[robot].acc[i] =  max_axis_acc[i];
            } else
	        {   player[robot].acc[i] = -max_axis_acc[i];
}   }   }   }

EXPORT void srv_Halt(int robot)
{   if (player[robot].energy >= 1)
    {   player[robot].energy--;
        player[robot].velocity[X_AXIS] =
        player[robot].velocity[Y_AXIS] =
        player[robot].acc[X_AXIS]      =
        player[robot].acc[Y_AXIS]      =
        player[robot].accel            = 0.0;
}   }

EXPORT void srv_Turn(int robot)
{   float direction;
#ifdef WIN32
    TEXT  strfloat[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s", &rw, &mt, strfloat);
    direction = zatof(strfloat);
    if (rw != (int) player[robot].window || mt != MT_TURN)
    {   garbled(robot, 9);
        return;
    }
#endif
#ifdef AMIGA
    direction = SglMsgPtr->cw_Single1;
#endif

    if (player[robot].energy >= 2)
    {   player[robot].energy -= 2;
        player[robot].heading          = (float) deg_2_rad(direction);
        player[robot].acc[X_AXIS]      = (float) ((double) player[robot].accel * cos((double) player[robot].heading));
        player[robot].acc[Y_AXIS]      = (float) ((double) player[robot].accel * sin((double) player[robot].heading));
        player[robot].velocity[X_AXIS] = player[robot].acc[X_AXIS];
        player[robot].velocity[Y_AXIS] = player[robot].acc[Y_AXIS];
}   }

EXPORT void srv_Teleport(int robot)
{   FLAG  ok;
    float x, y;
    int   i;
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    x = zatof(strfloat1);
    y = zatof(strfloat2);
    if (rw != (int) player[robot].window || mt != MT_TELEPORT)
    {   garbled(robot, 10);
        return;
    }
#endif
#ifdef AMIGA
    x = SglMsgPtr->cw_Single1;
    y = SglMsgPtr->cw_Single2;
#endif

    if (x == -1.0 && y == -1.0)
    {   if (player[robot].energy >= 2)
        {   player[robot].energy -= 2;
            do
            {   x = (float) (goodrand() % (int) config.field[X_AXIS]);
                y = (float) (goodrand() % (int) config.field[Y_AXIS]);
                ok = TRUE;
                for (i = 0; i < ROBOTS; i++)
                {   if
                    (   player[robot].alive
                     && player[robot].position[X_AXIS] >= x - BODY_RADIUS
                     && player[robot].position[X_AXIS] <= x + BODY_RADIUS
                     && player[robot].position[Y_AXIS] >= y - BODY_RADIUS
                     && player[robot].position[Y_AXIS] <= y + BODY_RADIUS
                    )
                    {   ok = FALSE;
                        break; // for speed
            }   }   }
            while (!ok);
    }   }
    else
    {   if
        (   player[robot].energy >= 3
         && x >= 0.0
         && x <  config.field[X_AXIS]
         && y >= 0.0
         && y <  config.field[Y_AXIS]
        )
        {   player[robot].energy -= 3; // perhaps we should penalize them for passing invalid coordinates?
            player[robot].position[X_AXIS] = x;
            player[robot].position[Y_AXIS] = y;
}   }   }

EXPORT void srv_Scan(int robot)
{   float direction,
          precision;
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s %s", &rw, &mt, strfloat1, strfloat2);
    direction = zatof(strfloat1);
    precision = zatof(strfloat2);
    if (rw != (int) player[robot].window || mt != MT_SCAN)
    {   garbled(robot, 4);
        return;
    }
#endif
#ifdef AMIGA
    direction = SglMsgPtr->cw_Single1;
    precision = SglMsgPtr->cw_Single2;
#endif

    player[robot].scan_dir       = (float) deg_2_rad(direction);
    player[robot].scan_precision = precision;
    player[robot].scan           = scan(robot, direction, precision);
}

EXPORT void srv_Atomic(int robot)
{   float velocity,
          direction,
          detonate;
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1],
          strfloat3[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s %s %s", &rw, &mt, strfloat1, strfloat2, strfloat3);
    velocity  = zatof(strfloat1);
    direction = zatof(strfloat2);
    detonate  = zatof(strfloat3);
    if (rw != (int) player[robot].window || mt != MT_ATOMIC)
    {   garbled(robot, 5);
        return;
    }
#endif
#ifdef AMIGA
    velocity  = SglMsgPtr->cw_Single1;
    direction = SglMsgPtr->cw_Single2;
    detonate  = SglMsgPtr->cw_Single3;
#endif

    if (player[robot].atomics >= 1)
    {   player[robot].atomics--;
        add_weapon
        (   robot,
            WP_ATOMIC,
            velocity,
            (float) deg_2_rad(direction),
            detonate
        );
}   }

EXPORT void srv_Bomb(int robot)
{   float detonate;
#ifdef WIN32
    TEXT  strfloat[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s", &rw, &mt, strfloat);
    detonate = zatof(strfloat);
    if (rw != (int) player[robot].window || mt != MT_BOMB)
    {   garbled(robot, 7);
        return;
    }
#endif
#ifdef AMIGA
    detonate = SglMsgPtr->cw_Single1;
#endif

    if (player[robot].bombs >= 1)
    {   player[robot].bombs--;
        add_weapon
        (   robot,
            WP_BOMB,
            (float) 0.0,
            (float) deg_2_rad(player[robot].heading),
            detonate
        );
}   }

EXPORT void srv_Cannon(int robot)
{   float velocity,
          direction,
          detonate;
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1],
          strfloat3[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s %s %s", &rw, &mt, strfloat1, strfloat2, strfloat3);
    velocity  = zatof(strfloat1);
    direction = zatof(strfloat2);
    detonate  = zatof(strfloat3);
    if (rw != (int) player[robot].window || mt != MT_CANNON)
    {   garbled(robot, 6);
        return;
    }
#endif
#ifdef AMIGA
    velocity  = SglMsgPtr->cw_Single1;
    direction = SglMsgPtr->cw_Single2;
    detonate  = SglMsgPtr->cw_Single3;
#endif

    if (player[robot].cannons >= 1)
    {   player[robot].cannons--;
        add_weapon
        (   robot,
            WP_CANNON,
            velocity,
            (float) deg_2_rad(direction),
            detonate
        );
}   }

EXPORT void srv_Missile(int robot)
{   float velocity,
          direction,
          detonate;
#ifdef WIN32
    TEXT  strfloat1[20 + 1],
          strfloat2[20 + 1],
          strfloat3[20 + 1];

    read_clip(robot);
    sscanf(globalstring[robot], "%d %d %s %s %s", &rw, &mt, strfloat1, strfloat2, strfloat3);
    velocity  = zatof(strfloat1);
    direction = zatof(strfloat2);
    detonate  = zatof(strfloat3);
    if (rw != (int) player[robot].window || mt != MT_MISSILE)
    {   garbled(robot, 8);
        return;
    }
#endif
#ifdef AMIGA
    velocity  = SglMsgPtr->cw_Single1;
    direction = SglMsgPtr->cw_Single2;
    detonate  = SglMsgPtr->cw_Single3;
#endif

    if (player[robot].missiles >= 1)
    {   player[robot].missiles--;
        add_weapon
        (   robot,
            WP_MISSILE,
            velocity,
            (float) deg_2_rad(direction),
            detonate
        );
}   }

EXPORT int cw_server_process(void)
{   int i;

    max_acc = (float) dft_force / (float) dft_mass;

    for (;;)
    {   msgpump();

        if (!paused)
        {   if (!turbo)
            {   thewait();
            }
            setup_backdrop();
            simulate();
            animframe++;

            check_collide();

            for (i = 0; i < WEAPONS; i++)
            {   if (weapon[i].alive)
                {   if (!weapon_update(i))
                    {   weapon[i].alive = FALSE;
                    } elif (weapon[i].detonate == 0)
                    {   add_explosion(i);
                        damage_check_players
                        (   weapon[i].weapon,
                            weapon[i].position[X_AXIS],
                            weapon[i].position[Y_AXIS],
                            weapon[i].robot
                        );
                        weapon[i].alive = FALSE;
            }   }   }

            draw_player_positions();
            /* if (paused)
            {   draw_glyph(GLYPHPOS_PAUSED);
            } */
            if (turbo)
            {   draw_glyph(GLYPHPOS_TURBO);
            }
            if (sound)
            {   draw_glyph(GLYPHPOS_SOUND);
            }
            updatescreen();
    }   }

    return 0; // we never reach here
}

MODULE int weapon_update(int whichweapon)
{   int   i,
          victim;
    float newpos[2];

    for (i = 0; i < 2; i++)
    {   newpos[i] = (float)
        (    weapon[whichweapon].position[i]
         +  (weapon[whichweapon].velocity[i] * config.time_int)
        );
        if (newpos[i] < 0.0 || newpos[i] >= config.field[i])
        {   switch (wall_type)
            {
            case RUBBER:
                weapon[whichweapon].velocity[i] =  -weapon[whichweapon].velocity[i];
                weapon[whichweapon].position[i] += (float) (weapon[whichweapon].velocity[i] * config.time_int);
            acase STONE:
            case ABYSS:
                return FALSE;
            acase TWILIGHT:
                if (newpos[i] >= config.field[i])
                {   weapon[whichweapon].position[i] = newpos[i] - config.field[i];
                } elif (newpos[i] < 0.0)
    	        {   weapon[whichweapon].position[i] = newpos[i] + config.field[i];
        }   }   }
        else
        {   weapon[whichweapon].position[i] = newpos[i];
    }   }

    if (weapon[whichweapon].detonate)
    {   weapon[whichweapon].detonate--;
    }
    if
    (   weapon[whichweapon].weapon == WP_CANNON
     || weapon[whichweapon].weapon == WP_MISSILE
    )
    {   for (victim = 0; victim < ROBOTS; victim++)
        {   if
            (   player[victim].alive
             && weapon[whichweapon].robot != victim
             && pythagoras
                (   player[victim].position[X_AXIS] - weapon[whichweapon].position[X_AXIS],
                    player[victim].position[Y_AXIS] - weapon[whichweapon].position[Y_AXIS]
                ) < ROBOTSIZE
            )
            {   weapon[whichweapon].detonate = 0;
    }   }   }

    return TRUE;
}

MODULE void add_weapon(int robot, short weapon_type, float velocity, float direction, float detonate)
{   int i;

    if (detonate < 0)
    {   return;
    }

    for (i = 0; i < WEAPONS; i++)
    {   if (!weapon[i].alive)
        {   weapon[i].alive            = TRUE;
            weapon[i].detonate         = (int) ((float) detonate * (float) FPS);
            weapon[i].weapon           = weapon_type;
            if (weapon_type == WP_BOMB)
            {   weapon[i].velocity[X_AXIS] = player[robot].velocity[X_AXIS];
                weapon[i].velocity[Y_AXIS] = player[robot].velocity[Y_AXIS];
            } else
            {   weapon[i].velocity[X_AXIS] = (float) ((double) velocity * cos((double) direction));
                weapon[i].velocity[Y_AXIS] = (float) ((double) velocity * sin((double) direction));
            }
            if (weapon[i].velocity[X_AXIS] < -VELOCITY_MAX_WEAPON)
            {   weapon[i].velocity[X_AXIS] = -VELOCITY_MAX_WEAPON;
            } elif (weapon[i].velocity[X_AXIS] > VELOCITY_MAX_WEAPON)
            {   weapon[i].velocity[X_AXIS] = VELOCITY_MAX_WEAPON;
            }
            if (weapon[i].velocity[Y_AXIS] < -VELOCITY_MAX_WEAPON)
            {   weapon[i].velocity[Y_AXIS] = -VELOCITY_MAX_WEAPON;
            } elif (weapon[i].velocity[Y_AXIS] > VELOCITY_MAX_WEAPON)
            {   weapon[i].velocity[Y_AXIS] = VELOCITY_MAX_WEAPON;
            }
            weapon[i].position[X_AXIS] = player[robot].position[X_AXIS];
            weapon[i].position[Y_AXIS] = player[robot].position[Y_AXIS];
            weapon[i].robot            = robot;
            play_sample(FX_FIRE);
            return;
}   }   }

// CodeWar robot calls----------------------------------------------------

EXPORT void srv_Boost_Shields(int robot, int energy)
{   if (player[robot].energy < energy)
    {   energy = player[robot].energy;
    }
    player[robot].shields += energy;
    player[robot].energy  -= energy;
    if (player[robot].shields > 100)
    {   player[robot].shields = 100;
}   }

EXPORT void handlekybd(ULONG scancode)
{   switch (scancode)
    {
    case SCAN_B:
        show_stars = show_stars ? FALSE : TRUE;
        updateticks();
        if (paused)
        {   updatescreen();
        }
    acase SCAN_P:
        paused     = paused     ? FALSE : TRUE;
        updateticks();
    acase SCAN_A1:
        keydown[0] = TRUE;
    acase SCAN_A2:
        keydown[1] = TRUE;
    acase SCAN_A3:
        keydown[2] = TRUE;
    acase SCAN_A4:
        keydown[3] = TRUE;
    acase SCAN_A5:
        keydown[4] = TRUE;
    acase SCAN_A6:
        keydown[5] = TRUE;
    acase SCAN_A7:
        keydown[6] = TRUE;
    acase SCAN_A8:
        keydown[7] = TRUE;
    acase SCAN_A:
        rearm();
    acase SCAN_E:
        energize();
    acase SCAN_H:
        heal();
    acase SCAN_R:
        reposition();
    acase SCAN_S:
        sound      = sound      ? FALSE : TRUE;
#ifdef AMIGA
        if (sound)
        {   start_sounds();
        } else
        {   stop_sounds();
        }
#endif
        updateticks();
    acase SCAN_T:
        turbo      = turbo      ? FALSE : TRUE;
        updateticks();
#ifdef AMIGA
    acase SCAN_LEFT:
        page_left();
    acase SCAN_RIGHT:
        page_right();
#endif
}   }

EXPORT void draw_player_positions(void)
{   int robot,
        which;

    for (robot = 0; robot < ROBOTS; robot++)
    {   if (player[robot].alive)
        {   draw_robot
            (   robot,
                x_to_gfx(player[robot].position[X_AXIS]) - BODY_RADIUS,
			    y_to_gfx(player[robot].position[Y_AXIS]) - BODY_RADIUS
            );
    }   }

    for (which = 0; which < WEAPONS; which++)
    {   if (weapon[which].alive)
        {   draw_weapon
            (   weapon[which].robot,
                x_to_gfx(weapon[which].position[X_AXIS]) - (WEAPONWIDTH  / 2),
			    y_to_gfx(weapon[which].position[Y_AXIS]) - (WEAPONHEIGHT / 2),
                weapon[which].weapon,
                weapon[which].detonate
            );
    }   }

    for (robot = 0; robot < ROBOTS; robot++)
    {   if (player[robot].alive)
        {   draw_pain(robot);

#ifdef WIN32
            sprintf
            (   output_buffer,
                "Acc: %0.2f (%0.2f,%0.2f)",
                pythagoras
                (   player[robot].acc[X_AXIS],
                    player[robot].acc[Y_AXIS]
                ),
                player[robot].acc[X_AXIS],
                player[robot].acc[Y_AXIS]
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE3), output_buffer);

            sprintf
            (   output_buffer,
                "Vel: %0.2f (%0.2f,%0.2f)",
                pythagoras
                (   player[robot].velocity[X_AXIS],
                    player[robot].velocity[Y_AXIS]
                ),
                player[robot].velocity[X_AXIS],
                player[robot].velocity[Y_AXIS]
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE4), output_buffer);

            sprintf
            (   output_buffer,
                "X,Y: %d,%d",
                (int) player[robot].position[X_AXIS],
                (int) player[robot].position[Y_AXIS]
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE5), output_buffer);

/*          sprintf
            (   output_buffer,
                "Hd: %.0f Sn: %.2f Sd: %.2f",
                rad_2_deg(player[robot].heading),
                player[robot].scan,
                rad_2_deg(player[robot].scan_dir)
            );
            sprintf
            (   output_buffer,
                "Scan result: %.2f",
                player[robot].scan
            ); */

            sprintf
            (   output_buffer,
                "%d",
                player[robot].atomics
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE6), output_buffer);

            sprintf
            (   output_buffer,
                "%d",
                player[robot].bombs
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE7), output_buffer);

            sprintf
            (   output_buffer,
                "%d",
                player[robot].cannons
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE8), output_buffer);

            sprintf
            (   output_buffer,
                "%d",
                player[robot].missiles
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE9), output_buffer);

            sprintf
            (   output_buffer,
                "Damage: %d/%d",
                player[robot].damage,
                damage_max
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE10), output_buffer);

            sprintf
            (   output_buffer,
                "Shields: %d/%d",
                player[robot].shields,
                dft_shields
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE11), output_buffer);

            sprintf
            (   output_buffer,
                "Energy: %d/%d",
                player[robot].energy,
                dft_energy
            );
            SetWindowText(GetDlgItem(player[robot].window, IDC_LINE12), output_buffer);
#endif
#ifdef AMIGA
            sprintf
            (   output_buffer,
                "%0.2f",
                pythagoras
                (   player[robot].acc[X_AXIS],
                    player[robot].acc[Y_AXIS]
            )   );
            updatestring(GID_ST25 + robot);

            sprintf
            (   output_buffer,
                "%0.2f",
                pythagoras
                (   player[robot].velocity[X_AXIS],
                    player[robot].velocity[Y_AXIS]
            )   );
            updatestring(GID_ST17 + robot);

            updateinteger(GID_IN1  + robot, (int) player[robot].position[X_AXIS]);
            updateinteger(GID_IN9  + robot, (int) player[robot].position[X_AXIS]);

            updateinteger(GID_IN17 + robot, (int) player[robot].atomics);
            updateinteger(GID_IN25 + robot, (int) player[robot].bombs);
            updateinteger(GID_IN33 + robot, (int) player[robot].cannons);
            updateinteger(GID_IN41 + robot, (int) player[robot].missiles);

            updateinteger(GID_IN49 + robot, (int) player[robot].damage);
            updateinteger(GID_IN57 + robot, (int) damage_max);

            updateinteger(GID_IN65 + robot, (int) player[robot].shields);
            updateinteger(GID_IN73 + robot, (int) dft_shields);

            updateinteger(GID_IN81 + robot, (int) player[robot].energy);
            updateinteger(GID_IN89 + robot, (int) dft_energy);
#endif
}   }   }

EXPORT int x_to_gfx(float x)
{   return (int) (battle.scale[X_AXIS] * x);
}
EXPORT int y_to_gfx(float y)
{   return (int) (battle.scale[Y_AXIS] * y);
}

EXPORT int valid(int x, int y)
{   if
    (   x >= 0
     && x <  battle.width
     && y >= 0
     && y <  battle.height
    )
    {   return TRUE;
    } else
    {   return FALSE;
}   }

MODULE void check_collide(void)
{   float delta_x, delta_y,
          distance,
          tempvel;
    int   j,
          robot1,
          robot2;
    FLAG  done[ROBOTS][ROBOTS];

    for (robot1 = 0; robot1 < ROBOTS; robot1++)
    {   for (robot2 = 0; robot2 < ROBOTS; robot2++)
        {   done[robot1][robot2] = FALSE;
    }   }

    for (robot1 = 0; robot1 < ROBOTS; robot1++)
    {   if (player[robot1].alive)
        {   for (robot2 = 0; robot2 < ROBOTS; robot2++)
            {   if (robot1 != robot2 && player[robot2].alive && !done[robot1][robot2] && !done[robot2][robot1])
                {   delta_x  = (float) (player[robot2].position[X_AXIS] - player[robot1].position[X_AXIS]);
                    delta_y  = (float) (player[robot2].position[Y_AXIS] - player[robot1].position[Y_AXIS]);
                    distance = (float) pythagoras(delta_x, delta_y);
                    if (distance < ROBOTSIZE)
                    {   play_sample(FX_BOUNCE);
                        hurt_robot(robot1, (int) pythagoras(player[robot2].velocity[X_AXIS], player[robot2].velocity[Y_AXIS]));
                        hurt_robot(robot2, (int) pythagoras(player[robot1].velocity[X_AXIS], player[robot1].velocity[Y_AXIS]));

                        for (j = 0; j < 2; j++)
                        {   tempvel = player[robot1].velocity[j];
                            player[robot1].velocity[j] =  player[robot2].velocity[j];
                            player[robot2].velocity[j] =  tempvel;

                            player[robot1].position[j] += player[robot1].velocity[j] * (float) config.time_int;
                            player[robot2].position[j] += player[robot2].velocity[j] * (float) config.time_int;
/* The full algorithm is:
newVelX1 = ( firstBall.speed.x * (firstBall.mass - secondBall.mass) + (2 * secondBall.mass * secondBall.speed.x)) / (firstBall.mass + secondBall.mass);
newVelY1 = ( firstBall.speed.y * (firstBall.mass - secondBall.mass) + (2 * secondBall.mass * secondBall.speed.y)) / (firstBall.mass + secondBall.mass);
newVelX2 = (secondBall.speed.x * (secondBall.mass - firstBall.mass) + (2 *  firstBall.mass *  firstBall.speed.x)) / (firstBall.mass + secondBall.mass);
newVelY2 = (secondBall.speed.y * (secondBall.mass - firstBall.mass) + (2 *  firstBall.mass *  firstBall.speed.y)) / (firstBall.mass + secondBall.mass);
*/
                        }

                        done[robot1][robot2] = TRUE;
}   }   }   }   }   }

MODULE void draw_pain(int robot)
{   TEXT damagestring[13 + 1];
    int  corner,
         i,
         x, xx, y, yy;

    if (!player[robot].pain)
    {   return;
    }

    player[robot].paintime--;
    if (!player[robot].paintime)
    {   player[robot].pain = 0;
        return;
    }

    x = x_to_gfx(player[robot].position[X_AXIS]) - BODY_RADIUS;
    y = y_to_gfx(player[robot].position[Y_AXIS]) - BODY_RADIUS;
    corner = x + (y * battle.width);
    sprintf(damagestring, "%d", player[robot].pain);

    for (i = 0; i < (int) strlen(damagestring); i++)
    {   for (yy = 0; yy < 5; yy++)
        {   for (xx = 0; xx < 5; xx++)
            {   if (valid(x + (i * 6) + xx + 1, y + yy + 1) && digits[damagestring[i] - '0'][yy] & (16 >> xx))
                {
#ifdef WIN32
                    display[corner + (i * 6) + xx + 1 + ((yy + 1) * battle.width)] = PENS_BLACK;
#endif
#ifdef AMIGA
                    display[corner + (i * 6) + xx + 1 + ((yy + 1) * battle.width)] = PENS_BLACK;
#endif
    }   }   }   }

    for (i = 0; i < (int) strlen(damagestring); i++)
    {   for (yy = 0; yy < 5; yy++)
        {   for (xx = 0; xx < 5; xx++)
            {   if (valid(x + (i * 6) + xx, y + yy) && digits[damagestring[i] - '0'][yy] & (16 >> xx))
                {
#ifdef WIN32
                    display[corner + (i * 6) + xx + (yy * battle.width)] = bright_colour[player[robot].conqueror];
#endif
#ifdef AMIGA
                    display[corner + (i * 6) + xx + (yy * battle.width)] = pens[player[robot].conqueror];
#endif
}   }   }   }   }

MODULE void hurt_robot(int robot, int damage)
{   player[robot].pain     = damage;
    player[robot].paintime = (int) FPS;
    player[robot].shields -= damage;
    if (player[robot].shields <= 0)
    {   damage = -player[robot].shields;
        player[robot].shields = 0;
        player[robot].damage += damage;
        if (player[robot].damage >= damage_max)
        {   player[robot].damage = damage_max;
            remove_player(robot, TRUE);
}   }   }

EXPORT void engine_setup(void)
{   int i;

    config.elapsed_time  = 0.0;
    config.time_int      = (float) TIME_INT;
    config.field[X_AXIS] = CW_BATTLE_X;
    config.field[Y_AXIS] = CW_BATTLE_Y;
    battle.width         = GFX_WIDTH;
    battle.height        = GFX_HEIGHT;

    for (i = 0; i < ROBOTS; i++)
    {   player[i].alive = FALSE;
    }
    for (i = 0; i < WEAPONS; i++)
    {   weapon[i].alive = FALSE;
}   }

EXPORT void rearm(void)
{   FLAG ok = FALSE;
    int  i;

    for (i = 0; i < ROBOTS; i++)
    {   if (keydown[i])
        {   ok = TRUE;
            player[i].atomics  = dft_atomics;
            player[i].bombs    = dft_bombs;
            player[i].cannons  = dft_cannons;
            player[i].missiles = dft_missiles;
    }   }
    if (!ok)
    {   for (i = 0; i < ROBOTS; i++)
        {   player[i].atomics  = dft_atomics;
            player[i].bombs    = dft_bombs;
            player[i].cannons  = dft_cannons;
            player[i].missiles = dft_missiles;
}   }   }

EXPORT void energize(void)
{   FLAG ok = FALSE;
    int  i;

    for (i = 0; i < ROBOTS; i++)
    {   if (keydown[i])
        {   ok = TRUE;
            player[i].energy = dft_energy;
    }   }
    if (!ok)
    {   for (i = 0; i < ROBOTS; i++)
        {   player[i].energy = dft_energy;
}   }   }

EXPORT void heal(void)
{   FLAG ok = FALSE;
    int  i;

    for (i = 0; i < ROBOTS; i++)
    {   if (keydown[i])
        {   ok = TRUE;
            player[i].damage    = 0;
            player[i].shields   = dft_shields;
    }   }
    if (!ok)
    {   for (i = 0; i < ROBOTS; i++)
        {   player[i].damage    = 0;
            player[i].shields   = dft_shields;
}   }   }

EXPORT void reposition(void)
{   FLAG ok = FALSE;
    int  i;

    for (i = 0; i < ROBOTS; i++)
    {   if (keydown[i])
        {   ok = TRUE;
            player[i].position[X_AXIS] = (float) (goodrand() % (int) (config.field[X_AXIS]));
            player[i].position[Y_AXIS] = (float) (goodrand() % (int) (config.field[Y_AXIS]));
    }   }
    if (!ok)
    {   for (i = 0; i < ROBOTS; i++)
        {   player[i].position[X_AXIS] = (float) (goodrand() % (int) (config.field[X_AXIS]));
            player[i].position[Y_AXIS] = (float) (goodrand() % (int) (config.field[Y_AXIS]));
}   }   }

EXPORT void initrobot(int robot)
{   player[robot].message[0]       =
    player[robot].name[0]          = EOS;
    player[robot].atomics          = dft_atomics;
    player[robot].cannons          = dft_cannons;
    player[robot].bombs            = dft_bombs;
    player[robot].missiles         = dft_missiles;
    player[robot].shields          = dft_shields;
    player[robot].energy           = dft_energy;
    player[robot].mass             = dft_mass;
    player[robot].damage           = 0;
    player[robot].velocity[X_AXIS] =
    player[robot].velocity[Y_AXIS] =
    player[robot].acc[X_AXIS]      =
    player[robot].acc[Y_AXIS]      =
    player[robot].accel            =
    player[robot].heading          = 0.0;
    player[robot].scan             =
    player[robot].scan_dir         = -1.0;
    player[robot].alive            = TRUE;
}

EXPORT void draw_robot(int robot, int x, int y)
{   PERSIST float radprecision;
    PERSIST int   corner,
                  x1, x2, x3, xx,
                  y1, y2, y3, yy; // PERSISTent for speed
#ifdef WIN32
    PERSIST HDC   RobotRastPtr;
#endif

    robot %= 8;
    corner = x + (y * battle.width);

    for (yy = 0; yy < BODY_DIAMETER; yy++)
    {   for (xx = 0; xx < BODY_DIAMETER; xx++)
        {   if
            (   valid(x + xx, y + yy)
#ifdef WIN32
             && *(BodyPtr[robot] + xx + (yy * BODY_DIAMETER))
            )
            {   display[corner + xx + (yy * battle.width)] =              *(BodyPtr[robot] + xx + (yy * BODY_DIAMETER)) ;
#endif
#ifdef AMIGA
             && *(BodyPtr[robot] + xx + (yy * BODY_DIAMETER)) != 255
            )
            {   display[corner + xx + (yy * battle.width)] = (UBYTE) pens[*(BodyPtr[robot] + xx + (yy * BODY_DIAMETER))];
#endif
    }   }   }

    x1 = x_to_gfx(player[robot].position[X_AXIS]);
    y1 = y_to_gfx(player[robot].position[Y_AXIS]);
    if
    (   player[robot].acc[X_AXIS] != 0.0
     || player[robot].acc[Y_AXIS] != 0.0
    )
    {   x2 = x1 + (int) (cos((double)  player[robot].heading                 ) * BODY_RADIUS);
        y2 = y1 + (int) (sin((double)  player[robot].heading                 ) * BODY_RADIUS);
        Line(x1, y1, x2, y2);
    }
    if (player[robot].scan_dir >= 0.0)
    {   radprecision = (float) deg_2_rad(player[robot].scan_precision);
        x2 = x1 + (int) (cos((double) (player[robot].scan_dir - radprecision)) * BODY_RADIUS);
        y2 = y1 + (int) (sin((double) (player[robot].scan_dir - radprecision)) * BODY_RADIUS);
        if (x2 < 0) x2 = 0; elif (x2 >= battle.width ) x2 = battle.width  - 1;
        if (y2 < 0) y2 = 0; elif (y2 >= battle.height) y2 = battle.height - 1;
        Line(x1, y1, x2, y2);
        x3 = x1 + (int) (cos((double) (player[robot].scan_dir + radprecision)) * BODY_RADIUS);
        y3 = y1 + (int) (sin((double) (player[robot].scan_dir + radprecision)) * BODY_RADIUS);
        if (x3 < 0) x3 = 0; elif (x3 >= battle.width ) x3 = battle.width  - 1;
        if (y3 < 0) y3 = 0; elif (y3 >= battle.height) y3 = battle.height - 1;
        Line(x1, y1, x3, y3);
        Line(x2, y2, x3, y3);
    }

#ifdef WIN32
    RobotRastPtr = GetDC(player[robot].window);
    DISCARD StretchDIBits
    (   RobotRastPtr,
        190,              // dest leftx
        100,              // dest topy
        BODY_DIAMETER,    // dest width
        BODY_DIAMETER,    // dest height
        (x1 - BODY_RADIUS), // source leftx
        battle.height - (y1 + BODY_RADIUS), // source topy
        BODY_DIAMETER,    // source width
        BODY_DIAMETER,    // source height
        display,          // pointer to the bits
        (const struct tagBITMAPINFO *) &TheBitMapInfo, // pointer to BITMAPINFO structure
        DIB_RGB_COLORS,   // format of data
        SRCCOPY           // blit mode
    );
    ReleaseDC(player[robot].window, RobotRastPtr);
#endif
}

EXPORT void draw_explosion(int whichrobot, int pixelradius, int leftx, int rightx, int topy, int bottomy)
{   int x, y;

    for (y = topy; y < bottomy; y++)
    {   for (x = leftx; x < rightx; x++)
        {   if
            (   valid(x, y)
             && (x - leftx - pixelradius) * (x - leftx - pixelradius)
              + (y - topy  - pixelradius) * (y - topy  - pixelradius)
              < pixelradius * pixelradius
            )
            {
#ifdef AMIGA
                display[(y * battle.width) + x] = pens[whichrobot];
#endif
#ifdef WIN32
                display[(y * battle.width) + x] = bright_colour[whichrobot];
#endif
}   }   }   }

#ifdef AMIGA
EXPORT void draw_weapon(int robot, int x, int y, int kind, UNUSED int detonate)
#endif
#ifdef WIN32
EXPORT void draw_weapon(int robot, int x, int y, int kind, int detonate)
#endif
{   PERSIST int corner,
                firstglyph    = 0,
                howmanyglyphs = 0,
                xx, yy; // all PERSISTent for speed

    corner =  x + (y * battle.width);
    robot  %= 8;

    switch (kind)
    {
    case WP_ATOMIC:
        howmanyglyphs = GLYPHS_ATOMIC;
        firstglyph    = FIRSTGLYPH_ATOMIC;
    acase WP_BOMB:
        howmanyglyphs = GLYPHS_BOMB;
        firstglyph    = FIRSTGLYPH_BOMB;
    acase WP_CANNON:
        howmanyglyphs = GLYPHS_CANNON;
        firstglyph    = FIRSTGLYPH_CANNON;
    acase WP_MISSILE:
        howmanyglyphs = GLYPHS_MISSILE;
        firstglyph    = FIRSTGLYPH_MISSILE;
    }
    for (yy = 0; yy < WEAPONHEIGHT; yy++)
    {   for (xx = 0; xx < WEAPONWIDTH; xx++)
        {   if
            (   valid(x + xx, y + yy)
             && weaponglyph[firstglyph + (animframe % howmanyglyphs)][yy][xx] != '.'
            )
            {
#ifdef AMIGA
                display[    corner + xx + (yy * battle.width)] = (UBYTE) pens[robot];
#endif
#ifdef WIN32
                if (detonate < 32)
                {   display[corner + xx + (yy * battle.width)] = dim_colour[robot] * (17 + 16 - (detonate / 2));
                } else
                {   display[corner + xx + (yy * battle.width)] = dim_colour[robot] * 17;
                }
#endif
}   }   }   }

EXPORT void draw_glyph(int whichglyph)
{   PERSIST int corner, x, y, xx, yy; // PERSISTent for speed

    x      = 5 + (whichglyph * (STATUSGLYPHWIDTH + 5));
    y      = 5;
    corner = x + (y * battle.width);

    for (yy = 0; yy < STATUSGLYPHHEIGHT; yy++)
    {   for (xx = 0; xx < STATUSGLYPHWIDTH; xx++)
        {   if (valid(x + xx, y + yy))
            {   if (statusglyph[whichglyph][yy][xx] != '.')
                {   SETPOINT(xx, yy, PENS_WHITE);
                } else
                {   SETPOINT(xx, yy, PENS_BLACK);
}   }   }   }   }

EXPORT void make_bodies(void)
{   int   i, j,
          x, y;
#ifdef WIN32
    int   r;
    ULONG body_colour[32];
#endif

    for (i = 0; i < 8; i++)
    {
#ifdef AMIGA
        BodyPtr[i] = malloc(BODY_DIAMETER * BODY_DIAMETER * sizeof(UBYTE));
        for (j = 0; j < BODY_DIAMETER * BODY_DIAMETER * sizeof(UBYTE); j++)
        {   BodyPtr[i][j] = 255;
        }
#endif
#ifdef WIN32
        BodyPtr[i] = malloc(BODY_DIAMETER * BODY_DIAMETER * sizeof(ULONG));
        for (j = 0; j < 32; j++)
        {   body_colour[31 - j] = dim_colour[i] * (j + 1);
        }
#endif

        for (y = 0; y < BODY_DIAMETER; y++)
        {   for (x = 0; x < BODY_DIAMETER; x++)
            {
#ifdef OUTLINE
                if (x == 0 || y == 0 || x == BODY_DIAMETER - 1 || y == BODY_DIAMETER - 1)
#ifdef AMIGA
                {   *(BodyPtr[i] + x + (y * BODY_DIAMETER)) = i;
#endif
#ifdef WIN32
                {   *(BodyPtr[i] + x + (y * BODY_DIAMETER)) = body_colour[0];
#endif
                } else
#endif
                {   if
                    (   ((x - BODY_RADIUS) * (x - BODY_RADIUS))
                      + ((y - BODY_RADIUS) * (y - BODY_RADIUS))
                      < (BODY_RADIUS - 0.5) * (BODY_RADIUS - 0.5)
                    )
                    {
#ifdef AMIGA
                        *(BodyPtr[i] + x + (y * BODY_DIAMETER)) = i;
                    } else
                    {   *(BodyPtr[i] + x + (y * BODY_DIAMETER)) = 255;
#endif
#ifdef WIN32
                        r = (x - BODY_RADIUS) * (x - BODY_RADIUS)
                          + (y - BODY_RADIUS) * (y - BODY_RADIUS);
                        r = (int) (r * 32 / (1.25 * BODY_RADIUS) / (1.25 * BODY_RADIUS));
                        if (r > 31)
                        {   r = 31;
                        }
                        *(BodyPtr[i] + x + (y * BODY_DIAMETER)) = body_colour[r];
                    } else
                    {   *(BodyPtr[i] + x + (y * BODY_DIAMETER)) = 0;
#endif
}   }   }   }   }   }

EXPORT void setup_backdrop(void)
{   int corner,
        i,
        x, y,
        xx, yy,
        x_times, y_times,
        xy;

    if (!show_stars)
    {   x_times = battle.width  / BACKDROPWIDTH;
        y_times = battle.height / BACKDROPHEIGHT;
        if (battle.width % BACKDROPWIDTH)
        {   x_times++;
        }
        if (battle.height % BACKDROPHEIGHT)
        {   y_times++;
        }

        for (y = 0; y < y_times; y++)
        {   for (x = 0; x < x_times; x++)
            {   corner = (x * BACKDROPWIDTH) + ((y * battle.width) * BACKDROPHEIGHT);

                // bevels
                for (xx = 0; xx <= 63; xx++)
                {   SETPOINT(xx    ,  0    , PENS_LIGHTGREY); // 0..63, 0
                    SETPOINT(xx    , 63    , PENS_DARKGREY ); // 0..63,63
                }
                for (xx = 0; xx <= 62; xx++)
                {   SETPOINT(xx    ,  1    , PENS_LIGHTGREY); // 0..62, 1
                    SETPOINT(xx + 1, 62    , PENS_DARKGREY ); // 1..63,62
                }
                for (yy = 0; yy <= 62; yy++)
                {   SETPOINT( 0    , yy    , PENS_LIGHTGREY); //  0,0..62
                    SETPOINT(63    , yy + 1, PENS_DARKGREY ); // 63,0..62
                }
                for (yy = 0; yy <= 61; yy++)
                {   SETPOINT( 1    , yy    , PENS_LIGHTGREY); //  1,0..61
                    SETPOINT(62    , yy + 2, PENS_DARKGREY ); // 62,2..63
                }

                for (yy = 2; yy < BACKDROPHEIGHT - 2; yy++)
                {   for (xx = 2; xx < BACKDROPWIDTH - 2; xx++)
                    {   if
                        (   (x * BACKDROPWIDTH ) + xx < battle.width
                         && (y * BACKDROPHEIGHT) + yy < battle.height
                        )
                        {
#ifdef AMIGA
                            SETPOINT(xx, yy, pens[ 23 -             ((xx + yy) / 8)]);
#endif
#ifdef WIN32
                            SETPOINT(xx, yy, 0xFFFFFF - (0x010101 * ((xx + yy) * 2)));
#endif
        }   }   }   }   }

        return;
    }

    i = battle.width * battle.height;
    for (xy = 0; xy < i; xy++)
    {   display[xy] = stars[xy];
}   }
