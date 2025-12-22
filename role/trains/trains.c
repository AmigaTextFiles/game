/* ************************************************************************
*   File: trains.c                                                        *
*  Usage: Transporter handling functions for CircleMUD                    *
*     By: Carl Tashian [Guru Meditation]                                  *
*         [tashiacm@ctrvax.vanderbilt.edu]                                *
************************************************************************ */

#include <stdio.h>
#include <string.h>
#include <ctype.h>
#include <sys/types.h>
#include <time.h>

#include "structs.h"
#include "utils.h"
#include "comm.h"
#include "interpreter.h"
#include "handler.h"
#include "db.h"
#include "limits.h"

/*   external vars  */
extern struct room_data *world;
int transpath = 0;
char curstat1[100], curstat2[100];

void enter_stat(int station, char wherefrom[100], int which);
void leave_stat(int station, char whereto[100], int which);

void train_upd(void)
{
int wdoor, edoor, station[5];
station[0] = real_room(3069); /* room of Midgaard Station */
station[1] = real_room(3142); /* room of South Midgaard Station */
station[2] = real_room(12068); /* room of Rome Station */
station[3] = real_room(9941); /* room of Wayhouse Station */
station[4] = real_room(17153); /* room of Kerofk station */
wdoor = 3; /* west dir number */
edoor = 1; /* east dir number */
switch (transpath)
{
case 0:
   /* leave from VVVVVV to  VVVVVV */
   leave_stat(station[0], "Southern Midgaard", 1);
   leave_stat(station[3], "Kerofk Station", 2);
   break;
case 1:
   /* enter station VVVV from VVVV */
   enter_stat(station[1], "Midgaard Station", 1);
   enter_stat(station[4], "Wayhouse Station", 2);
   break;
case 2:
   leave_stat(station[1], "Rome Station", 1);
   leave_stat(station[4], "Midgaard Station", 2);
   break;
case 3:
   enter_stat(station[2], "Southern Midgaard", 1);
   enter_stat(station[0], "Kerofk Station", 2);
   break;
case 4:
   leave_stat(station[2], "Wayhouse Station", 1);
   leave_stat(station[0], "Southern Midgaard", 2);
   break;
case 5:
   enter_stat(station[3], "Rome Station", 1);
   enter_stat(station[1], "Midgaard Station", 2);
   break;
case 6:
   leave_stat(station[3], "Kerofk Station", 1);
   leave_stat(station[1], "Rome Station", 2);
   break;
case 7:
   enter_stat(station[4], "Wayhouse Station", 1);
   enter_stat(station[2], "Southern Midgaard", 2);
   break;
case 8:
   leave_stat(station[4], "Midgaard Station", 1);
   leave_stat(station[2], "Wayhouse Station", 2);
   break;
case 9:
   enter_stat(station[0], "Kerofk Station", 1);
   enter_stat(station[3], "Rome Station", 2);
   break;
/* then back to the case 0 again.. */
default:
   log("SYSERR: Big problem with the transporter!");
   break;
} /* switch */
transpath++;
if (transpath==6) transpath=0;
return;
} /* funct */

void enter_stat(int station, char wherefrom[100],
                int which)
{
int transroom, wdoor, edoor;
char buf[MAX_STRING_LENGTH];
char whereat[100];
if (which == 1) {
  transroom = real_room(3070); /* this MUST be the transporter itself (room) */
  strcpy(whereat, curstat1);
  }
if (which == 2) {
  strcpy(whereat, curstat2);
  transroom = real_room(3072); /* transporter room 2 */
  }
wdoor = 3; /* west dir number */
edoor = 1; /* east dir number */
world[transroom].dir_option[wdoor]->to_room = station;
world[station].dir_option[edoor]->to_room = transroom;
send_to_room("The transporter slows to a halt, and the doors to your west open..\n\r", transroom);
sprintf(buf, "The conductor announces, 'Welcome to %s'\n\r", whereat);
send_to_room(buf, transroom);
sprintf(buf, "Without a sound, the transporter from %s pulls into\n\r", wherefrom);
send_to_room(buf, station);
send_to_room("the station, and the doors to your east open.\n\r", station);
return;
}

void leave_stat(int station, char whereto[100], int which)
{
int transroom, wdoor, edoor;
char buf[MAX_STRING_LENGTH];

if (which == 1) {
  strcpy(curstat1, whereto);
  transroom = real_room(3070); /* this MUST be the transporter itself (room) */
  }
if (which == 2) {
  strcpy(curstat2, whereto);
  transroom = real_room(3072); /* train 2 */
  }
wdoor = 3; /* west dir number */
edoor = 1; /* east dir number */

world[transroom].dir_option[wdoor]->to_room = NOWHERE;
world[station].dir_option[edoor]->to_room = NOWHERE;
sprintf(buf, "The conductor announces, 'Next stop: %s'\n\r", whereto);
send_to_room(buf, transroom);
send_to_room("The transporter doors close, and the transporter starts it's journey\n\r", transroom);
send_to_room("The transporter doors close, and it instantly disappears into the tunnel..\n\r", station);
return;
} /* move_from */
