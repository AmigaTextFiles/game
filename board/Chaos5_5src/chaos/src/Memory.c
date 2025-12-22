/*  Chaos:                  The Chess HAppening Organisation System     V5.3
    Copyright (C)   1993    Jochen Wiedmann

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.


    $RCSfile: Memory.c,v $
    $Revision: 3.1 $
    $Date: 1994/03/23 15:45:41 $

    This file contains the memory functions.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


/*
    Memory is organized in a list of lists. The elements of the latter lists
    are memory chunks obtained by a call to GetMem. This allows us to return
    either
	- one memory chunk  (by a call to PutMem)
	- a memory list for example when deleting a tournament (by a call to
	  PutMemList)
	- all memory ever occupied when the program terminates (by a call to
	  PutMemAll)

    These functions are shouldn't be system dependent as there are no
    differences except for using AllocMem() on the Amiga and calloc() on
    other systems.
*/


/*
    Include files we need.
*/
#ifndef CHAOS_H
#include "Chaos.h"
#endif  /*  !CHAOS_H                */

#ifndef AMIGA
#include <stdlib.h>
#define AllocMem(size,flags) calloc((size),1)
#define FreeMem(ptr,size) free(ptr)
#endif  /*  !AMIGA                  */


/*
    The structures we deal with.
*/
#ifndef AMIGA
struct MinList {
   struct  MinNode *mlh_Head;
   struct  MinNode *mlh_Tail;
   struct  MinNode *mlh_TailPred;
};      /* longword aligned */
struct MinNode {
    struct MinNode *mln_Succ;
    struct MinNode *mln_Pred;
};
#endif

struct MyMemChunk
{ struct MinNode node;
  ULONG Size;
};
struct MyMemList
{ struct MinNode node;
  struct MinList list;
};


/*
    There's only one static variable, initialized with NULL.
*/
static struct MinList *MainMemList    = NULL;




/*
    The GetMem() function occupies one chunk of memory.

    Inputs: Key -   A pointer to a list pointer. If the latter pointer is
		    NULL, a list is allocated and inserted into the list
		    of memory lists. The latter pointed gets modified in
		    that case. (That's why we need a pointer to a pointer.)
	    Size -  The number of bytes the memory chunk should have.

    Results:        A pointer to a memory chunk or NULL indicating an error.
		    Note that the chunk is guaranteed to be at least long
		    word bounded!
*/
void *GetMem(void **List, ULONG Size)

{ struct MyMemChunk *mmc;
  struct MyMemList *mml;

  /*    Check if MainMemList was already initialized and allocate it        */
  /*    otherwise.                                                          */
  if (MainMemList == NULL)
  { if ((MainMemList = AllocMem(sizeof(struct MinList), MEMF_CLEAR|MEMF_ANY))
		     ==  NULL)
    { MemError();
      return(NULL);
    }
    NewList((struct List *) MainMemList);
  }

  /*    Check if the list was already allocated and allocate it otherwise.  */
  if ((mml = (struct MyMemList *) *List) == NULL)
  { *List = mml = AllocMem(sizeof(*mml), MEMF_ANY|MEMF_CLEAR);
    if (!mml)
    { MemError();
      return(NULL);
    }
    NewList((struct List *) &mml->list);
    AddTail((struct List *) MainMemList, (struct Node *) mml);
  }

  if ((mmc = AllocMem(sizeof(*mmc)+Size, MEMF_ANY|MEMF_CLEAR))  ==  NULL)
  { MemError();
    return(NULL);
  }
  AddTail((struct List *) &mml->list, (struct Node *) mmc);
  mmc->Size = Size;
  return(mmc+1);
}




/*
    The GetStringMem() function occupies memory for a string and copies the
    string into it.

    Inputs: Key -   See GetMem()
	    str -   pointer to a NUL terminated string

    Results: See GetMem()
*/
char *GetStringMem(void **Key, char *str)

{ char *result;

  if ((result = GetMem(Key, strlen(str)+1))  !=  NULL)
  { strcpy (result, str);
  }
  return(result);
}




/*
    The PutMem() function returns one chunk of memory to the system.

    Inputs: ptr - a pointer to a memory chunk obtained by a recent call
		  to GetMem(); NULL is a valid argument indicating that
		  the function should do nothing.
*/
void PutMem(void *ptr)

{ struct MyMemChunk *mmc;

  if (ptr != NULL)
  { mmc = ((struct MyMemChunk *) ptr) - 1;
    Remove((struct Node *) mmc);
    FreeMem(mmc, sizeof(*mmc)+mmc->Size);
  }
}




/*
    The PutMemList() function returns a list of memory chunks to the system.

    Inputs: list - a pointer to a pointer to a memory list; the latter may
		   be NULL indicating that the list was never used and
		   the function should do nothing.
		   The latter pointer will be set to NULL after the function
		   is executed. (That's why we need a pointer to a pointer.)
*/
void PutMemList(void **List)

{ struct MyMemList *mml = *List;
  struct MyMemChunk *mmc;

  if (mml != NULL)
  { while ((mmc = (struct MyMemChunk *) mml->list.mlh_Head)->node.mln_Succ
								!=  NULL)
    { PutMem(mmc+1);
    }
    Remove((struct Node *) mml);
    FreeMem(mml, sizeof(*mml));
    *List = NULL;
  }
}




/*
    The PutMemAll() function returns all memory to the system that was
    occupied before. (This should normally only be called when the program
    terminates.
*/
void PutMemAll(void)

{ struct MyMemList *mml;

  if (MainMemList != NULL)
  { while((mml = (struct MyMemList *) MainMemList->mlh_Head)->node.mln_Succ
								    !=  NULL)
    { PutMemList((void **) &mml);
    }
    FreeMem(MainMemList, sizeof(struct MinList));
  }
  MainMemList = NULL;
}




/*
    The MoveMemList() function transfers the allocated memory from one list
    to the other.

    Inputs: source - the list, from where the memory will be removed
	    dest   - the list, where it will be enqueued
*/
void MoveMemList(void **source, void **dest)

{ struct MyMemList *src = *source;
  struct MyMemList *dst = *dest;
  struct MyMemChunk *mmc;

  /*
      Make sure, that dst is not NULL. (Additionally a VERY fast
      possibility, if it is...
  */
  if (dst == NULL)
  { *dest = src;
    *source = NULL;
  }
  else
  { while ((mmc = (struct MyMemChunk *) src->list.mlh_Head)->node.mln_Succ
								    !=  NULL)
    { Remove((struct Node *) mmc);
      AddTail((struct List *) &dst->list, (struct Node *) mmc);
    }
    PutMemList(source);
  }
}
