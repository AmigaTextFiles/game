#include <stdio.h>
/* malloc */
#include <stdlib.h>

#include "list-int.h"

list_int *
list_int_new(int n)
{
  list_int *p = NULL;

  p = (list_int *) malloc(sizeof(list_int));
  if (p == NULL)
  {
    fprintf(stderr, "list_int_new: malloc failed\n");
    return NULL;
  }

  p->prev = NULL;
  p->next = NULL;
  p->n = n;

  return p;
}

list_int *
list_int_unlink(list_int *p)
{
  list_int *q = NULL;

  if (p == NULL)
    return NULL;

  q = NULL;
  if (p->next != NULL)
  {
    q = p->next;
    p->next->prev = p->prev;
  }
  if (p->prev != NULL)
  {
    q = p->prev;
    p->prev->next = p->next;
  }

  p->next = NULL;
  p->prev = NULL;

  return q;
}

void
list_int_delete_all(list_int *p)
{
  list_int *q = NULL;
  list_int *q_temp = NULL;

  if (p == NULL)
    return;

  q = p;
  while (q != NULL)
  {
    q_temp = list_int_unlink(q);
    free(q);
    q = q_temp;
  }

  p = NULL;
}

/* return the new list on success, NULL on error */
list_int *
list_int_insert_after(list_int *where, int n)
{
  list_int *p = NULL;

  p = list_int_new(n);
  if (p == NULL)
  {
    fprintf(stderr, "list_int_insert_after: list_int_new failed\n");
    return NULL;
  }

  if (where == NULL)
    return p;

  if (where->next != NULL)
  {
    where->next->prev = p;
    p->next = where->next;
  }

  where->next = p;
  p->prev = where;

  return p;
}

/* return the new list on success, NULL on error */
list_int *
list_int_insert_before(list_int *where, int n)
{
  list_int *p = NULL;

  p = list_int_new(n);
  if (p == NULL)
  {
    fprintf(stderr, "list_int_insert_before: list_int_new failed\n");
    return NULL;
  }

  if (where == NULL)
    return p;

  if (where->prev != NULL)
  {
    where->prev->next = p;
    p->prev = where->prev;
  }

  where->prev = p;
  p->next = where;

  return p;
}
