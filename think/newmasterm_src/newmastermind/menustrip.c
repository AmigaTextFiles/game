/*
 * menustrip.c
 * ===========
 * The menustrip.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <proto/intuition.h>
#include <proto/gadtools.h>

#include <apputil.h>

#include "menustrip.h"
#include "menuactions.h"
#define CATCOMP_NUMBERS
#include "stringnumbers.h"


static struct NewMenu newMenu[] = {
  { NM_TITLE, (STRPTR)MSG_GAME_MENU, 0, 0, 0, NULL },
  {  NM_ITEM, (STRPTR)MSG_GAME_NEW, 0, 0, 0, New },
  {  NM_ITEM, NM_BARLABEL, 0, 0, 0, NULL },
  {  NM_ITEM, (STRPTR)MSG_GAME_ABOUT, 0, 0, 0, About },
  {  NM_ITEM, NM_BARLABEL, 0, 0, 0, NULL },
  {  NM_ITEM, (STRPTR)MSG_GAME_QUIT, 0, 0, 0, Quit },
  { NM_TITLE, (STRPTR)MSG_SETTINGS_MENU, 0, 0, 0, NULL },
  {  NM_ITEM, (STRPTR)MSG_SETTINGS_COLORDISPLAY, 0, CHECKIT | MENUTOGGLE, 0,
     ColorDisplay },
  {  NM_ITEM, NM_BARLABEL, 0, 0, 0, NULL },
  {  NM_ITEM, (STRPTR)MSG_SETTINGS_OPPONENT, 0, 0, 0, NULL },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_HUMAN, 0, CHECKIT, ~0x01, OpponentHuman },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_COMPUTER, 0, CHECKIT, ~0x02,
      OpponentComputer },
  {  NM_ITEM, (STRPTR)MSG_SETTINGS_CORRECTION, 0, 0, 0, NULL },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_CHILDREN, 0, CHECKIT, ~0x1,
      CorrectionChildren },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_ADULTS, 0, CHECKIT, ~0x2,
      CorrectionAdults },
  {  NM_ITEM, (STRPTR)MSG_SETTINGS_NUMCOLORS, 0, 0, 0, NULL },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_NUMCOLORS_4, 0, CHECKIT, ~0x01,
      NumColors4 },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_NUMCOLORS_6, 0, CHECKIT, ~0x02,
      NumColors6 },
  {   NM_SUB, (STRPTR)MSG_SETTINGS_NUMCOLORS_8, 0, CHECKIT, ~0x04,
      NumColors8 },
  {  NM_ITEM, NM_BARLABEL, 0, 0, 0, NULL },
  {  NM_ITEM, (STRPTR)MSG_SETTINGS_SAVE, 0, 0, 0, SaveSettingsAction },
  { NM_END,   NULL, 0, 0, 0, NULL }
};

static APTR vi = NULL;
static struct Menu *menuStrip = NULL;


VOID PreDisableMenuItem(ULONG index) {
  newMenu[index].nm_Flags |= NM_ITEMDISABLED;;
}


VOID PreCheckMenuItem(ULONG index) {
  newMenu[index].nm_Flags |= CHECKED;
}


BOOL CreateMenuStrip(struct Window *win) {
  vi = GetVisualInfoA(win->WScreen, NULL);
  if (vi == NULL) {
    return FALSE;
  }

  menuStrip = CreateLocMenusA(newMenu, vi, NULL);
  if (menuStrip == NULL) {
    return FALSE;
  }

  if (!SetMenuStrip(win, menuStrip)) {
    return FALSE;
  }

  return TRUE;
}


VOID DisposeMenuStrip(struct Window *win) {
  ClearMenuStrip(win);
  FreeMenus(menuStrip);
  FreeVisualInfo(vi);
}
