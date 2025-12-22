#ifndef __PSTTRL_ITEM_H__
#define __PSTTRL_ITEM_H__

/* type */
#define ITEM_TYPE_WEAPON 0
#define ITEM_TYPE_SCROLL 1

/* where */
#define ITEM_NOWHERE 0
#define ITEM_FLOOR 1
#define ITEM_SHEATH 2

struct _item
{
  int id;
  int type;
  int which;
  int quantity;
  int where;
  int owner;
  int z;
  int x;
  int y;
  int thrown;
};
typedef struct _item item;

item *item_new(void);
void item_delete(item *p);

#endif /* not __PSTTRL_ITEM_H__ */
