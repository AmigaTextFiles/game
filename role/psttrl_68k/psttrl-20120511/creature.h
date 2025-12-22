#ifndef __KSMN_CREATURE_H__
#define __KSMN_CREATURE_H__

#define ACT_SIZE 4

/* attitude */
#define ATTITUDE_PLAYER 0
#define ATTITUDE_MONSTER_UNINTERESTED 1
#define ATTITUDE_MONSTER_ACTIVE 3

/* decision_flag
 * these values must be one of 2^n
 */
#define DCSN_NO_MORE_STAIR 1
#define DCSN_NO_MORE_HOME 2

struct _creature
{
  int id;
  int type;
  int z;
  int x;
  int y;
  int level;
  int hp;
  int weapon_id;
  int attitude;
  int timer_attitude;
  int *act;
  /* for monster decision only */
  /* path_size is not saved */
  int path_size;
  int *path_x;
  int *path_y;
  int path_z;
  int path_num;
  int path_now;
  int home_z;
  int home_x;
  int home_y;
  int timer_stuck;
  int decision_flag;
};
typedef struct _creature creature;

creature *creature_new(void);
void creature_delete(creature *p);

int creature_append_path(creature *who, int x, int y);

#endif /* not __KSMN_CREATURE_H__ */
