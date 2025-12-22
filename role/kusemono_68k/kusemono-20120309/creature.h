#ifndef __KSMN_CREATURE_H__
#define __KSMN_CREATURE_H__

#define ACT_SIZE 4

/* attitude */
#define ATTITUDE_PLAYER_SEARCHING 0
#define ATTITUDE_PLAYER_RUNNING 1
#define ATTITUDE_MONSTER_UNINTERESTED 2
#define ATTITUDE_MONSTER_CONCERNED 3
#define ATTITUDE_MONSTER_ACTIVE 4
#define ATTITUDE_MONSTER_LOST 5

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
  int hp;
  int successive_run;
  int attitude;
  int timer_attitude;
  int enchant_type;
  int enchant_duration;
  int *act;
  /* for monster decision only */
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
const char *creature_attitude_name(int attitude);

#endif /* not __KSMN_CREATURE_H__ */
