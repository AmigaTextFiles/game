#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "item.h"

item *
item_new(void)
{
  item *p = NULL;

  p = (item *) malloc(sizeof(item));
  if (p == NULL)
  {
    fprintf(stderr, "item_new: malloc failed\n");
    return NULL;
  }

  p->id = -1;
  p->type = -1;
  p->which = -1;
  p->quantity = 0;
  p->where = ITEM_NOWHERE;
  p->owner = -1;
  p->z = -1;
  p->x = -1;
  p->y = -1;
  p->thrown = 0;

  return p;
}

void
item_delete(item *p)
{
  if (p == NULL)
    return;

  free(p);
  p = NULL;
}
