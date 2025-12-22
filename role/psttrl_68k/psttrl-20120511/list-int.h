#ifndef __LIST_INT_H__
#define __LIST_INT_H__

struct _list_int
{
  struct _list_int *prev;
  struct _list_int *next;
  int n;
};
typedef struct _list_int list_int;

list_int *list_int_new(int n);
list_int *list_int_unlink(list_int *p);
void list_int_delete_all(list_int *p);
list_int *list_int_insert_after(list_int *where, int n);
list_int *list_int_insert_before(list_int *where, int n);

#endif /* not __LIST_INT_H__ */
