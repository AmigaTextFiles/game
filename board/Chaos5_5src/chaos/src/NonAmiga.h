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


    $RCSfile: NonAmiga.h $
    $Revision: 1.1 $
    $Date: 1994/01/26 22:47:54 $

    This is the include-file of NonAmiga.c, which holds the prototypes of
    certain functions and defines the list structures.

    Computer:   Amiga 1200                  Compiler:   Dice 2.07.54 (3.0)

    Author:     Jochen Wiedmann
		Am Eisteich 9
	  72555 Metzingen
		Tel. 07123 / 14881
		Internet: jochen.wiedmann@zdv.uni-tuebingen.de
*/


#ifndef NONAMIGA_H
#define NONAMIGA_H


/*
    This is an excerpt from the Amiga includes and defines the list
    structures.
*/

/*
 *  List Node Structure.  Each member in a list starts with a Node
 */

struct Node {
    struct  Node *ln_Succ;      /* Pointer to next (successor) */
    struct  Node *ln_Pred;      /* Pointer to previous (predecessor) */
    unsigned char ln_Type;
    char    ln_Pri;             /* Priority, for sorting */
    char    *ln_Name;           /* ID string, null terminated */
};      /* Note: word aligned */

/* minimal node -- no type checking possible */
struct MinNode {
    struct MinNode *mln_Succ;
    struct MinNode *mln_Pred;
};

/*
 *  Full featured list header.
 */
struct List {
   struct  Node *lh_Head;
   struct  Node *lh_Tail;
   struct  Node *lh_TailPred;
   unsigned char lh_Type;
   char    l_pad;
};      /* word aligned */

/*
 * Minimal List Header - no type checking
 */
struct MinList {
   struct  MinNode *mlh_Head;
   struct  MinNode *mlh_Tail;
   struct  MinNode *mlh_TailPred;
};      /* longword aligned */




/*
    Function prototypes
*/
int Stricmp(const char *, const char *);
int Strnicmp(const char *, const char *, int);
int StrToLong(char *, int *);
void NewList(struct List *);
void AddHead(struct List *, struct Node *);
void AddTail(struct List *, struct Node *);
void Insert(struct List *, struct Node *, struct Node *);
void Remove(struct Node *);

#endif /* !NONAMIGA_H */
