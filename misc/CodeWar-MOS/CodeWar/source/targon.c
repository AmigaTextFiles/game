/* Rhett D. Jacobs <rdj@cea.com.au>
 *
 * Targon aka Silverune is a fairly simple robot as a "proof of concept"
 * for the CodeWar system. I am still yet to fully document it, which may
 * be part of the CodeWar manual as a guide to robot creation.
 *
 * Essentially, silverune simply scans the world until it finds a target.
 * At this point, it attempts to lock onto the target and continually
 * fire missiles into it until it has been destroyed.  Once this is
 * complete, it continues searching and the process continues.
 *
 * Silverune also performs the housekeeping function of ensuring that it
 * always has its shields up to full if it detects damage has occurred.
 * At this point it also attempts evasive action (as it is probably being
 * attacked) for a few moments, before attempts to stop itself and begin
 * rescanning. There are still bugs in this section of the robot.
 *
 * It should also be noted that I've implemented a fairly simple priority
 * scheduler to perform these tasks.  This tends to work well for tasks
 * such as those required by an robot, as actions such as determing
 * shield status are not required as often as scans of certain areas of the
 * battlefield.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "codewar.h"

#ifndef FALSE
   #define FALSE (0)
#endif

#ifndef TRUE
   #define TRUE (!FALSE)
#endif

#define VERSION (1.6)

#define acase break; case

char output_buffer[255];

typedef struct {
  int priority;
  int current_priority;
  int(*f_ptr)(void);
} f_type;

int main(int argc, char** argv);
void schedule_function_list(f_type *f_list, int f_size);
int schedule_next_function(f_type *f_list, int f_size);

void(*func_ptr)(void) = NULL;

/* scan_field - simple target strategy of performing a circular scan of
 * the entire playfield and shooting at any tagets found.  To speed up the
 * operation a fixed interval of scan is given.
 */
int scan_field(void)
{          int   ret_val   = TRUE,
                 therand;
           float distance;
    static int   iq        = 0;
    static float precision = 5.0,
                 direction = 0.0;

    if ((distance = cw_scan(direction, precision)) > 0.0)
    {   iq = TRUE;
        therand = rand() % 4;
        // switch has been replaced with if/elif chain, as a workaround for a Visual C 5.0 internal compiler error
        if (therand == 0)
        {   cw_atomic( (float) 100.0, direction, (float) (sqrt((2.0 * (double) distance) / 10.0)));
        } else if (therand == 1)
        {   cw_bomb(                             (float) (sqrt((2.0 * (double) distance) / 10.0)));
        } else if (therand == 2)
        {   cw_cannon( (float) 100.0, direction, (float) (sqrt((2.0 * (double) distance) / 10.0)));
        } else
        {   // assert(therand == 3);
            cw_missile((float) 100.0, direction, (float) (sqrt((2.0 * (double) distance) / 10.0)));
    }   }

    if (iq)
    {   direction -= precision;
        if (direction < 0.0)
        {   direction += 360.0;
        }
        iq = FALSE;
    } else
    {   direction += precision;
        if (direction > 360.0)
        {   direction -= 360.0;
    }   }

    return ret_val;
}

/* check_shields - this function is called periodically to ensure that the
 * robot's shields are in good condition.  When the robot no longer
 * has any energy reserves, a FALSE return value is given so that the
 * function no longer wastes time checking.  The energy variable is
 * not retrieved from the CodeWar server each time as this is a waste of
 * "bandwidth" when it can be more quickly keep track of by the robot.
 */
int check_shields(void)
{
  int shields, damage, ret_val = TRUE;

  static int first = TRUE;
  static int energy;
  static int prev_shields;
  static int prev_damage;
  static float direction = -1.0;

  if (first) {
    first = FALSE;
    energy = cw_get_energy();
    prev_shields = cw_get_shields();
    prev_damage = cw_get_damage();
  }

  if (direction != -1.0) {
    cw_power((float) 100.0, (float) (direction + 180.0));
    cw_print_buffer("Stop");
    direction = -1.0;

    shields = cw_get_shields();

    if (shields < 100) {
      cw_boost_shields(100-shields);
      energy -= (100-shields);
    }
  } else {
    cw_power((float) 0.0, (float) 0.0);
    cw_print_buffer("Done");

    damage = cw_get_damage();

    shields = cw_get_shields();

    if (shields < 100) {
      cw_boost_shields(100-shields);
      energy -= (100-shields);
    }

    if (prev_shields != shields ||
	prev_damage != damage) {
      direction = (float)(rand()%360);
      cw_power((float) 100.0, direction);
      cw_print_buffer("Start");

      prev_shields = shields;
      prev_damage = damage;
    }
  }

  return(ret_val);
}

/* service_function_list - to facilitate a range of functions being
 * periodically called, the func_ptr is set to point to this function
 * which in turn calls the functions registered in its f_list[].  These
 * functions are called as priority scheduled using routines from
 * schedule.c.
 */
void service_function_list(void)
{
  static f_type f_list[] = {{10, 10, scan_field}, {1, 1, check_shields}};
  static int    f_size   = sizeof(f_list) / sizeof(f_type);

  schedule_function_list(f_list, f_size);
}

/* init - simple setup routine.  Assigns a periodic handler pointer for
 * use by the utils.c functions, and registers the robot with the
 * CodeWar server.
 */
int init(int argc, char **argv)
{
  char *hostname = (char *)NULL;
  int ret_val = FALSE;
#ifdef AMIGA
    int number;
#endif

  func_ptr = service_function_list;

#ifdef WIN32
    sprintf(output_buffer, "Silverune V%0.2f", VERSION);
#endif
#ifdef AMIGA
    number = (int) (VERSION * 100.0);
    sprintf
    (   output_buffer,
        "Silverune V%d.%02d",
        (int) number / 100,
        (int) number % 100
    );
#endif

  if (argc > 1)
    hostname = argv[1];

  if (cw_register_network_program(output_buffer, hostname))
    ret_val = TRUE;

  return(ret_val);
}

void schedule_function_list(f_type *f_list, int f_size)
{
  int i, count;

  count = schedule_next_function(f_list, f_size);

  /* decrease the scheduled priority of this function */
  f_list[count].current_priority--;

  if (!(f_list[count].f_ptr())) {

    /* if a FALSE return value is returned from the called function,
     * then this function should no longer be called.  Therefore, all
     * "higher" functions need to be shifted down and the called function
     * removed.
     */
    for (i = count; i < f_size - 1; i++)
      f_list[i] = f_list[i+1];
    // f_size--;
  }
}

/* schedule_next_function - this routines handles the priority scheduling.
 */
int schedule_next_function(f_type *f_list, int f_size)
{
  int ret_val, i, index = 0, count = 0;

  /* find the highest priority task */
  for (i = 0; i < f_size; i++)
    if (f_list[i].current_priority > count) {
      count = f_list[i].current_priority;
      index = i;
    }

  ret_val = index;

  /* check if priorities require refreshing */
  if (count == 0) {
    for (i = 0; i < f_size; i++)
      f_list[i].current_priority = f_list[i].priority;

    ret_val = schedule_next_function(f_list, f_size);
  }

  return(ret_val);
}

int main(int argc, char** argv)
{
  if (init(argc, argv)) {
    for (;;) {
      func_ptr();
    }
  }

  return 0;
}
