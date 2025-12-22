#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "turn-order.h"

turn_order *
turn_order_new(void)
{
  turn_order *p = NULL;

  p = (turn_order *) malloc(sizeof(turn_order));
  if (p == NULL)
  {
    fprintf(stderr, "turn_order_new: malloc failed\n");
    return NULL;
  }

  p->id = -1;
  p->type = -1;
  p->which = -1;
  p->wait = 0;

  return p;
}

void
turn_order_delete(turn_order *p)
{
  if (p == NULL)
    return;

  free(p);
  p = NULL;
}
