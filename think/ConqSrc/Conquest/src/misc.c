/* Misc.c: Miscellaneous routines I didn't know where else to put. */
#include <stdio.h>
#include "defs.h"
#include "structs.h"
#include "vars.h"
#include "protos.h"

struct helpst 
{
  char *cmd, *does;
};

struct helpst help0[] =
{
{       "B",    "Bld Battlestar(s)    75"},
{       "C",    "Bld Cruiser(s)       16"},
{       "H",    "Help"                   },
{       "R",    "Range Research"         },
{       "S",    "Bld Scout(s)          6"},
{       "V",    "Velocity Research"      },
{       "W",    "Weapons Research"       },
{       ">M",   "Redraw Map"             },
{       ">R",   "Research summary"       },
{       0,      0                        }
};

struct helpst help1[] =
{
{       "B",    "Blast Planet"           },
{       "C",    "Colony summary"         },
{       "D",    "TaskForce Destination"  },
{       "G",    "Go on (done)"           },
{       "H",    "Help"                   },
{       "J",    "Join TaskForces"        },
{       "L",    "Land transports"        },
{       "M",    "Redraw Map"             },
{       "N",    "New TaskForce"          },
{       "Q",    "Quit"                   },
{       "R",    "Research summary"       },
{       "S",    "Star summary"           },
{       "T",    "TaskForce summary"      },
{       0,      0                        }
};

struct helpst help2[] =
{
{       "C",    "Colonies"               },
{       "G",    "Go on (done)"           },
{       "H",    "Help"                   },
{       "M",    "Map"                    },
{       "O",    "Odds"                   },
{       "R",    "Research summary"       },
{       "S",    "Star summary"           },
{       "T",    "TaskForce summary"      },
{       "W",    "Withdraw"               },
{       0,      0,                       }
};

struct helpst help3[] = 
{
{       "B",    "Break off Attack"       },
{       "C",    "Colony summary"         },
{       "G",    "Go on (done)"           },
{       "H",    "Help"                   },
{       "J",    "Join TFs"               },
{       "M",    "Redraw Map"             },
{       "N",    "New TF"                 },
{       "R",    "Research summary"       },
{       "S",    "Star summary"           },
{       "T",    "TaskForce summary"      },
{       0,      0                        }
};

struct helpst help4[] = 
{
{       "A",    "Bld Adv. Missle Base 35"},
{       "B",    "Bld Battlestar(s)    70"},
{       "C",    "Bld Cruiser(s)       16"},
{       "H",    "Help"                   },
{       "I",    "Invest                3"},
{       "M",    "Bld Missle Base(s)    8"},
{       "R",    "Range Research"         },
{       "S",    "Bld Scout(s)          6"},
{       "T",    "Bld Transports"         },
{       "V",    "Vel Research"           },
{       "W",    "Weapons Research"       },
{       "*x",   "Bld max. # of x"        },
{       "+",    "Bld max. offensive"     },
{       "-",    "Bld max. defensive"     },
{       ">C",   "Colony summary"         },
{       ">M",   "Redraw Map"             },
{       ">R",   "Research summary"       },
{       ">S",   "Star summary"           },
{       0,      0                        }
};

void help(int which)
{
  struct helpst *h;
  int j;
  
  j = 1;
  point(50, j++);
  if (which == 0) h = help0;
  if (which == 1) h = help1;
  if (which == 2) h = help2;
  if (which == 3) h = help3;
  if (which == 4) h = help4;
  while (h->cmd != 0) 
  {
    printf("%2s - %-25s", h->cmd, h->does);
    point(50, j++);
    h++;
  }
  clear_field();
}

void on_board(int x, int y)
{
  int i;
  int starnum;
  board[x][y].tf=' ';
  i=1;
  do 
  {
    if ( (tf[player][i].dest!=0) && (tf[player][i].x==x) 
	&& (tf[player][i].y==y
	    ) ) 
    {
      if ( board[x][y].tf==' ' )
	board[x][y].tf= i+'a'-1;
      else 
      {
	board[x][y].tf='*';
	i=27;
      }
    }
    i=i+1;
  } 
  while (i <= 26);
  if ( board[x][y].star != '.' ) 
  {
    board[x][y].enemy = ' ';
    starnum= board[x][y].star - 'A' +1;
    if ( col_stars[starnum][player] != 0 )
      board[x][y].enemy = '@';
  }
  update_board(x,y,both);
}

void pause()
{
  point(1,18);
  printf("Press any key to continue  ");
  get_char();
}
