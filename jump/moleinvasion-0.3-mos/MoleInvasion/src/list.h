/* MoleInvasion 0.1 - Copyright (C) 2004 - Guillaume Chambraud (linuxprocess@free.fr)

  This program is free software; you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation; either version 2 of the License, or
  (at your option) any later version. */

#ifndef LIST_H
#define LIST_H

#include <stdlib.h>

typedef struct myElt
{	void * value;
	struct myElt * next;
}myElt;

typedef struct
{	unsigned int size;
	myElt* elt;
}myList;

myList * InitList();
void FreeList(myList * list);

void AddToList(myList * list,void * value,unsigned int sizeofvalue);

/* démarre à 0 */
int RemoveFromList(myList * list,unsigned int pos);
void * GetPosList(myList * list,unsigned int pos);

#endif
