#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define acase     break; case
#define elif      else if
#define MODULE    static
#define TRANSIENT auto
#define PERSIST   static

#define TRUE      -1
#define FALSE     0

typedef unsigned char TEXT;

#include "codewar.h"

#define TWO_PI                    ((double)2.0 * M_PI)
#define deg_2_rad(X)              ((double)X*(double)M_PI/(double)180.0)
#define rad_2_deg(X)              ((double)X*(double)180.0/(double)M_PI)
#define pythagoras(X,Y)           sqrt((X)*(X)+(Y)*(Y))

// MODULE float deltas_to_degrees(float sourcex, float sourcey, float destx, float desty);
MODULE void check_shields(void);

MODULE int energy;

int main(void)
{   float distance,
          fieldx, fieldy,
          px, py,
          scandir  = 0.0,
          movedir;
    int   choice,
          damage   = 0,
          olddamage;
    TEXT  stringbuffer[256 + 1];

    if (cw_register_program("XLJ 1.6"))
    {   cw_print_buffer("Initializing");
        cw_get_field_limits(&fieldx, &fieldy);
        movedir = (float) (rand() % 360);
        cw_power((float) 10.0, movedir);

        for (;;)
        {   cw_get_position(&px, &py);
            check_shields();
            olddamage = damage;
            damage = cw_get_damage();
            energy = cw_get_energy();

            if (damage > olddamage)
            {   // cw_halt();
                movedir = (float) (rand() % 360);
                cw_power((float) 100.0, movedir);
                if (cw_get_velocity(&px, &py) >= 2.0)
                {   cw_bomb((float) 3.0);
                    movedir += 180.0;
                    if (movedir >= 360.0)
                    {   movedir -= 360.0;
                    }
                    cw_power((float) 100.0, movedir);
                    cw_turn((float) (rand() % 360));
            }   }
            elif (px < 10)
            {   movedir =   0.0; // east
                cw_power((float) 100.0, (float) movedir);
            } elif (py < 10)
            {   movedir =  90.0; // south
                cw_power((float) 100.0, (float) movedir);
            } elif (px > fieldx - 10)
            {   movedir = 180.0; // west
                cw_power((float) 100.0, (float) movedir);
            } elif (py > fieldy - 10)
            {   movedir = 270.0; // north
                cw_power((float) 100.0, (float) movedir);
            } else
            {   distance = cw_scan(scandir, (float) 10.0);
                if (distance == -1.0)
                {   sprintf((char*) stringbuffer, "%d°", (int) scandir);
                } else
                {   sprintf((char*) stringbuffer, "%fm", distance);
                }
                cw_print_buffer((char*) stringbuffer);
                if (distance >= (float) 5.0 && distance <= (float) 50.0)
                {   choice = rand() % 3;
                    switch (choice)
                    {
                    case 0:
                        if (distance >= 10.0)
                        {   cw_atomic( (float) 20.0, scandir, (float) (distance / 28.28));
                        } else
                        {   cw_missile((float) 20.0, scandir, (float) (distance / 28.28));
                        }
                    acase 1:
                        cw_cannon(     (float) 20.0, scandir, (float) (distance / 28.28));
                    acase 2:
                        cw_missile(    (float) 20.0, scandir, (float) (distance / 28.28));
                    }
                    movedir = (float) (scandir + 180.0);
                    if (movedir >= 360.0)
                    {   movedir -= 360.0;
                    }
                    cw_power((float) 100.0, (float) movedir);
                } else
                {   scandir += 20.0;
                }
                if (scandir < 0.0)
                {   scandir += 360.0;
                } elif (scandir >= 360.0)
                {   scandir -= 360.0;
    }   }   }   }

    return 0;
}

/* MODULE float deltas_to_degrees(float sourcex, float sourcey, float destx, float desty)
{   float angle;
    float delta_x = destx - sourcex;
    float delta_y = desty - sourcey;

	if (delta_x != 0.0 && delta_y != 0.0) // shouldn't this be ||?
    {   angle = (float)atan2((double)delta_y, (double)delta_x);
	    return (float) rad_2_deg(angle);
    } else
    {   return 0;
}   } */

/* check_shields - this function is called periodically to ensure that the
 * robot's shields are in good condition. */
MODULE void check_shields(void)
{   TRANSIENT int shields;

    shields = cw_get_shields();
    if (shields < 100)
    {   cw_boost_shields(100 - shields);
        energy -= (100 - shields);
}   }
