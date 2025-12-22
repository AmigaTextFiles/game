/* Rhett D.  Jacobs <rdj@cea.com.au>
 * Gumby is a fodder robot.
 */

#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <time.h>

#include "codewar.h"

#ifndef FALSE
   #define FALSE (0)
#endif

#ifndef TRUE
   #define TRUE (!FALSE)
#endif

#define DISCARD (void)
#define EXPORT
#define MODULE  static

#define VERSION (1.61)

#define rad_2_deg(val)  ((val) / (2.0 * M_PI) * 360.0)
#define pythagoras(X,Y) (sqrt((X) * (X) + (Y) * (Y)))
#define STOP_TOLERANCE  (float) (0.25)

MODULE char output_buffer[255];

MODULE void cw_stop(float tolerance);
MODULE void cw_go(float x, float y);

MODULE void cw_stop(float tolerance)
{   float velocity,
          x_val, y_val;

    if ((velocity = cw_get_velocity(&x_val, &y_val)) < tolerance)
    {   cw_print_buffer("Already stopped");
        return;
    }

    cw_print_buffer("Stopping...");

    do
    {   velocity = cw_get_velocity(&x_val, &y_val);
        cw_power
        (   (float) 1.0,
            (float) (180.0 + rad_2_deg((float) atan2(y_val, x_val)))
        );
    }
    while (velocity > tolerance);

    cw_power
    (   (float) 0.0,
        (float) 0.0
    );
    cw_print_buffer("Stopped");
}

MODULE void cw_go(float x, float y)
{   float angle,
          current_x, current_y,
          delta_time,
          delta_x, delta_y,
          distance,
          waittill;

    cw_stop(STOP_TOLERANCE);

    cw_get_position(&current_x, &current_y);
    delta_x = (float) (x - current_x);
    delta_y = (float) (y - current_y);
    angle   = (float) rad_2_deg(atan2((double) delta_y, (double) delta_x));
    if (angle < 0.0)
    {   angle += 360.0;
    }
    distance = (float) pythagoras((float) current_y - y, (float) current_x - x);
    delta_time = (float) sqrt((double) distance);

    sprintf
    (   output_buffer,
        "To %0.1f, %0.1f (%0.1f°), %0.1fs, %0.1fm",
        x, y,
        angle,
        delta_time,
        distance
    );
    cw_print_buffer(output_buffer);

    cw_power((float) 1.0, angle);

    waittill = cw_get_elapsed_time() + delta_time;
    while (cw_get_elapsed_time() < waittill);

    cw_stop(STOP_TOLERANCE);
}

EXPORT int main(int argc, char **argv)
{   float max_x, max_y;

    srand(time(NULL) % RAND_MAX);

    sprintf(output_buffer, "Gumby V%0.1f", VERSION);
    if (cw_register_program(output_buffer))
    {   cw_get_field_limits(&max_x, &max_y);

        for (;;)
        {   cw_go((float) (rand() % (int) max_x), (float) (rand() % (int) max_y));
    }   }

    return 20;
}
