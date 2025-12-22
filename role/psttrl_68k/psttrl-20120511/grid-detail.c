#include <stdio.h>
/* COLOR_PAIR */
#include <pdcurses/curses.h>

#include "color-pair.h"

#include "grid-detail.h"

int
grid_detail_get(int type, struct grid_detail *grd)
{
  int type_masked;

  if (grd == NULL)
  {
    fprintf(stderr, "grid_detail_get: grd is NULL\n");
    return 1;
  }

  type_masked = type & GRID_TERRAIN_MASK;
  if (type_masked != type)
  {
    fprintf(stderr, "grid_detail_get: type is not masked (%d)\n", type);
  }
  
  (*grd).type = type_masked;
  switch (type_masked)
  {
  case GR_FLOOR:
    (*grd).name = "floor";
    (*grd).symbol = ".";
    (*grd).attr = COLOR_PAIR(CPAIR_BLUE);
    break;
  case GR_WALL:
    (*grd).name = "wall";
    (*grd).symbol = "#";
    (*grd).attr = COLOR_PAIR(CPAIR_WHITE);
    break;
  case GR_GLASS_WALL:
    (*grd).name = "glass wall";
    (*grd).symbol = "%";
    (*grd).attr = COLOR_PAIR(CPAIR_CYAN);
    break;
  case GR_STAIR_DOWN_0:
  case GR_STAIR_DOWN_1:
  case GR_STAIR_DOWN_2:
  case GR_STAIR_DOWN_3:
    (*grd).name = "stair down";
    (*grd).symbol = ">";
    (*grd).attr = COLOR_PAIR(CPAIR_WHITE) | A_BOLD;
    break;
  case GR_STAIR_UP_0:
  case GR_STAIR_UP_1:
  case GR_STAIR_UP_2:
  case GR_STAIR_UP_3:
    (*grd).name = "stair up";
    (*grd).symbol = "<";
    (*grd).attr = COLOR_PAIR(CPAIR_WHITE) | A_BOLD;
    break;
  default:
    (*grd).name = "undefined grid";
    (*grd).symbol = "~";
    (*grd).attr = COLOR_PAIR(CPAIR_MAGENTA) | A_BOLD;
    break;
  }

  return 0;
}
