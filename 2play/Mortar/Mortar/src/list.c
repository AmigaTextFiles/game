/* 
 * MORTAR
 * 
 * -- item/list handling
 * 
 * This is free software; you can redistribute it and/or modify it
 * under the terms specified in the GNU Public Licence (GPL).
 *
 * Copyright (C) 1998-1999 by Eero Tamminen
 */

#include <stdio.h>
#include <stdlib.h>
#include "mortar.h"

#define MAX_LIST  ((MAX_ITEMS + 1) * MAX_PLAYERS)

static m_list_t *List;


int list_init(void)
{
  m_list_t *ptr;
  int idx;

  /* different items + one active shield per player */
  ptr = malloc(MAX_LIST * sizeof(m_list_t));
  if (!ptr) {
    msg_print(ERR_ALLOC);
    return 0;
  }
  List = ptr;

  idx = MAX_LIST - 1;
  while (--idx >= 0) {
    ptr->next = ptr + 1;
    ptr++;
  }
  ptr->next = NULL;

  return 1;
}


m_list_t *list_search(m_list_t *list, int type)
{
  m_list_t *item;

  if (list->type == type) {
    return list;
  }

  item = list->next;
  while (item != list) {
    if (item->type == type) {
      return item;
    }
    item = item->next;
  }
  return NULL;
}


m_list_t *list_add(m_list_t *list, int type)
{
  m_list_t *ptr;

#ifdef DEBUG
  if (!List) {
    win_exit();
    fprintf(stderr, "list.c/list_add(): no items available!\n");
    exit(-1);
  }
#endif

  if (list) {
    ptr = list_search(list, type);
    if (ptr) {
      ptr->count++;
      return ptr;
    }
    ptr = List;
    List = List->next;
    ptr->prev = list;
    ptr->next = list->next;
    list->next->prev = ptr;
    list->next = ptr;
  } else {
    ptr = List;
    List = List->next;
    ptr->prev = ptr;
    ptr->next = ptr;
  }

  ptr->type = type;
  ptr->count = 1;
  return ptr;
}


m_list_t *list_free(m_list_t *item)
{
  m_list_t *ptr;

#ifdef DEBUG
  if (!item) {
    win_exit();
    fprintf(stderr, "list.c/list_free(): no item!\n");
    exit(-1);
  }
#endif
  if (--item->count <= 0) {

    ptr = item->prev;
    if (ptr == item) {
      ptr = NULL;
    } else {
      ptr->next = item->next;
      item->next->prev = ptr;
    }
    item->next = List;
    List = item;

    return ptr;
  }
  return item;
}
