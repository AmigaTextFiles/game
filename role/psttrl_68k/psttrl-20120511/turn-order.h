#ifndef __KSMN_TURN_ORDER_H__
#define __KSMN_TURN_ORDER_H__

/* type */
#define TURN_ORDER_CREATURE 0

struct _turn_order
{
  int id;
  int type;
  int which;
  int wait;
};
typedef struct _turn_order turn_order;

turn_order *turn_order_new(void);
void turn_order_delete(turn_order *p);

#endif /* not __KSMN_TURN_ORDER_H__ */
