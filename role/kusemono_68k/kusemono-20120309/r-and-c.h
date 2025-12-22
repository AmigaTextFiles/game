#ifndef __BUILD_H__
#define __BUILD_H__

/* segment plan */
#define SEGPLAN_SPARSE 0
#define SEGPLAN_DENSE 1

/* connect plan */
#define CONPLAN_BACKTRACK 0
#define CONPLAN_RANDOM 1

int build_room_and_corridor(int **grid, int size_x, int size_y,
                            int segment_plan);
int build_maze(int **grid, int size_x, int size_y,
               int stride, int connect_plan, int allow_dead_end);

#endif /* not __BUILD_H__ */
