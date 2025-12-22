/*
 * menustrip.h
 * ===========
 * The menustrip.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#ifndef MENUSTRIP_H
#define MENUSTRIP_H

#include <exec/types.h>
#include <intuition/intuition.h>


#define MENU_ITEM_COLOR_DISPLAY 7
#define MENU_ITEM_OPPONENT      9
#define MENU_ITEM_CORRECTION    12
#define MENU_ITEM_NUM_COLORS    15

#define MENU_Game         0
#define ITEM_New          0
#define ITEM_About        2
#define ITEM_Quit         4
#define MENU_Settings     1
#define ITEM_ColorDisplay 0
#define ITEM_Opponent     2
#define ITEM_Correction   3
#define ITEM_NumColors    4
#define ITEM_SaveSettings 6


extern VOID PreDisableMenuItem(ULONG index);
extern VOID PreCheckMenuItem(ULONG index);
extern BOOL CreateMenuStrip(struct Window *win);
extern VOID DisposeMenuStrip(struct Window *win);

#endif /* MENUSTRIP_H */
