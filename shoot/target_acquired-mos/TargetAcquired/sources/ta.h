/**************************************************************************
 * TARGET ACQUIRED, (c) 1995, 2002 Michael Martin                         *
 *                                                                        *
 * You may use, distribute, or modify this code in accordance with the    *
 * BSD license: see LICENSE.txt for details.                              *
 **************************************************************************/

#ifndef __TA_H__
#define __TA_H__

typedef unsigned char byte;

/* Global variables */
extern byte godlike;  /* Is invulnerability on? */
extern byte momentumconserved;
extern char *speeds[]; /* The names of the speed levels */
extern byte speed;

/* Top-level main-game routines */
int do_main_menu(void);
void do_graphics_test(void);
void do_short_credits(void);
void do_briefing(void);
void do_long_credits(void);

#endif
