
#ifndef __AEVENT_H
#define __AEVENT_H

/* note: include level.h, not this. */

/* Defines the types of animation events that can
   occur. These are returned by level::move_animate
   if animation is enabled. */

/* as a result of a move, a list of animation events
   (avent) will be returned. Each event describes
   something that happened in a level (ie, a block
   was pushed from one square to another, a series
   of tiles were flipped from 'up' state to 'down,' 
   or the player was shot by a laser). The 
   responsibility for how these events should be 
   portrayed lies in whatever interprets the event
   list. In this sense animation also includes
   sound effects.
   
   Events have time stamps, given as serial numbers.
   Events with the same serial number happen at the
   same time. The event list should always be sorted
   with earlier serial numbers at the beginning of
   the list, and the numbers have no particular
   significance outside of ordering the list. 

   For each kind of event, there is an atag (tag_event),
   a structure describing the kind of data it contains
   (event_t) and a field in the aevent union (event).

*/

typedef int dir;

enum atag { tag_fly, tag_push, tag_jiggle, tag_breaks, tag_swap, 
	    tag_walk, tag_press, tag_stand, tag_toggle, tag_button, 
	    tag_trap, tag_pushgreen, tag_litewire, tag_liteup,
	    tag_opendoor, tag_lasered, tag_winner, tag_botexplode,
};


/* a tile (ie, gold block) flies from one location, horizontally or
   vertically for n tiles, and stops there (or is zapped). */
struct fly_t { int what; int srcx; int srcy; dir d; int distance; 
               bool zapped; int whatunder; };
/* Player steps into srcx, srcy from direction d, pushing the block
   there one square. */
struct push_t { int what; int under; int srcx; int srcy; 
                dir d; bool zap; bool hole; };

/* green can only be pushed from floor to floor */
struct pushgreen_t { int srcx; int srcy; dir d; };

/* jiggle some spheres in a row */
struct jiggle_t { int startx; int starty; int num; dir d; };

/* destroy a breakable block */
struct breaks_t { int x; int y; };

/* swap from pressing a panel */
struct swap_t { int x; int y; int was; int now; };

/* player walking */
struct walk_t { int srcx; int srcy; dir d; bool pushing; 
                int whatunder; bot entt; };

/* player pressing in some direction 
   it's a kick if the player is moving a gold block
   or sphere. Otherwise, it's a press (of a button). */
struct press_t { int x; int y; dir d; bool kick; };

/* stand facing in a direction. This event can only
   arise from multi-serial moves (ie, walk from one
   panel to another; while the second is flipping we
   are just standing still.) Bots also stand when
   they can't make a move. */
struct stand_t { int x; int y; dir d; bot entt; };

/* for colored floors, sliders, and electricity.
   delay is just for colored floors */
struct toggle_t { int x; int y; int whatold; int delay; };

/* for buttons (on, 0/1, wirebutton) */
struct button_t { int x; int y; int whatold; };

struct trap_t { int x; int y; int whatold; };

/* count goes 0...n, where n is the length of the connection */
struct litewire_t { int x; int y; int what; int count; };

struct liteup_t { int x; int y; int what; int delay; };

struct opendoor_t { int x; int y; };

/* player is lasered at x,y from laser at lx, ly
   (which is in direction 'from' relative to him) */
struct lasered_t { int x; int y; dir from; int lx; int ly; };

/* player wins at x,y */
struct winner_t { int x; int y; };

struct botexplode_t { int x; int y; };

struct aevent {
  unsigned int serial;

  atag t;
  union {
    fly_t fly;
    push_t push;
    breaks_t breaks;
    jiggle_t jiggle;
    swap_t swap;
    walk_t walk;
    press_t press;
    stand_t stand;
    toggle_t toggle;
    button_t button;
    trap_t trap;
    pushgreen_t pushgreen;
    litewire_t litewire;
    liteup_t liteup;
    opendoor_t opendoor;
    lasered_t lasered;
    winner_t winner;
    botexplode_t botexplode;
  } u;
};

#endif
