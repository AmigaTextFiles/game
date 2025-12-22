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


    $RCSfile: NonAmiga.c $
    $Revision: 1.1 $
    $Date: 1994/01/26 22:47:25 $

    This file contains some functions which are Amiga specific and which
    I used in the system independent source, as I like them very much and
    its rather easy to rebuild them on other systems.

    Some of this functions will be similar or even quite the same as other
    functions on other systems. It depends on you, to use either yours or
    mine.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef NONAMIGA_H
#include <NonAmiga.h>
#endif


#ifndef AMIGA


/*
    Stricmp is like strcmp, except that it ignores Upper-/Lowercase
    and handles local letters (for example the german "Umlaute") too
    on the Amiga. We ignore this here.
*/
int Stricmp(const char *str1, const char *str2)

{ char c1, c2;

  for(;;)
  { c1 = tolower(*str1);
    c2 = tolower(*str2);
    if (c1 == '\0'  ||  c1 != c2)
    { return(c1-c2);
    }
  }
}





/*
    Strnicmp is like strnicmp, except that it ignores Upper-/Lowercase
    and handles local letters (for example the german "Umlaute") too
    on the Amiga. We ignore this here.
*/
int Strnicmp(const char *str1, const char *str2, int len)

{ char c1, c2;

  for(;;)
  { if (len-- == 0)
    { return(0);
    }
    c1 = tolower(*str1);
    c2 = tolower(*str2);
    if (c1 == '\0'  ||  c1 != c2)
    { return(c1-c2);
    }
  }
}




/*
    StrToLong is similar to atol, except that it ignores leading blanks and
    tabs.

    Inputs: string  - the string holding the number to be converted.
	    value   - a pointer to an int receiving the value found.

    Result: The number of characters that were read (the leading blanks and
	    the value itself) or 0, if no decimal value was found.
*/
int StrToLong(char *str, int *value)

{ int len;
  int val;

  len = 0;
  while(*str == ' '  &&  *str == '\t')  /*  Ignore leading blanks   */
  { ++str;
    ++len;
  }
  if (*str < '0'  ||  *str > '9')
  { *value = -1;
    return(0);
  }

  val = 0;
  while (*str >= '0'  &&  *str <= '9')
  { val = val*10 + *str - '0';
    ++str;
    ++len;
  }
  *value = val;
  return(len);
}






/*
    Here come the list functions. The elements of the list are called
    nodes.

    Lists are always double linked lists and seem to have at least two
    elements: The head and the tail. (See NewList for details.) The
    elements of the (This is strange and I don't know, why the Amiga-OS
    is implemented in that way. I suppose it is used to avoid if's and
    hence fast. Additionally it allows to find the list, if you have
    the node only.)
*/


/*
    NewList is used to initialize a list. The lh_Head and lh_Tail
    fields are used as the head of the list and the lh_Tail and
    lh_TailPred fields work as the tail of the list.

    Inputs: list    - a pointer to the list to be initialized.
*/
void NewList(struct List *list)

{
  list->lh_Head = (struct Node *) &(list->lh_Tail);
  list->lh_Tail = NULL;
  list->lh_TailPred = (struct Node *) list;
}





/*
    AddHead is used to add a node to the head of a list.

    Inputs: list    - the list, where a node should be added
	    node    - the node to add.
*/
void AddHead(struct List *list, struct Node *node)

{ node->ln_Succ = list->lh_Head;
  node->ln_Pred = (struct Node *) list;
  list->lh_Head = node;
  node->ln_Succ->ln_Pred = node;
}




/*
    AddTail is used to add a node to the end of the list.

    Inputs: list    - the list, where a node should be added
	    node    - the node to add.
*/
void AddTail(struct List *list, struct Node *node)

{ node->ln_Pred = list->lh_TailPred;
  node->ln_Succ = (struct Node *) &(list->lh_Tail);
  list->lh_TailPred = node;
  node->ln_Pred->ln_Succ = node;
}




/*
    The Insert() functions is used to add a node to a certain position in
    the list.

    Inputs: list        - the list where a node should be added.
	    node        - the node that should be added
	    listnode    - the node, after which to insert. (May be NULL or
			  equal to list, in which case this is the same
			  as AddHead().)
*/
void Insert(struct List *list, struct Node *node, struct Node *listnode)

{
  if (listnode == NULL)
  { listnode = (struct Node *) list;
  }
  node->ln_Succ = listnode->ln_Succ;
  listnode->ln_Succ = node;
  node->ln_Pred = listnode;
  node->ln_Succ->ln_Pred = node;
}




/*
    The Remove() function allows to remove a node from a list.
    This is done by linking the ln_Succ field of the nodes predecessor
    to the nodes successor and, vice versa, the ln_Pred field of the nodes
    predecessor to the successor.

    Inputs: node    - the node, that should be removed
*/
void Remove(struct Node *node)

{
  node->ln_Succ->ln_Pred = node->ln_Pred;
  node->ln_Pred->ln_Succ = node->ln_Succ;
}
#endif /* !AMIGA */
