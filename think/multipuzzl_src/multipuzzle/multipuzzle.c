/*
 * multipuzzle.c
 * =============
 * Main module.
 *
 * Copyright (C) 1994-1998 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <exec/types.h>
#include <intuition/intuition.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/intuition_protos.h>
#include <clib/icon_protos.h>

#include "puzzle.h"
#include "displayinit.h"
#include "requesters.h"
#include "localize.h"

#ifdef SAS_C
void __regargs _CXBRK (void) {}
#endif


STRPTR version = "$VER: MultiPuzzle 1.2 (13.12.98)";

struct Library  *DataTypesBase = NULL;
struct Library  *GfxBase = NULL;
struct Library  *IntuitionBase = NULL;
struct Library  *AslBase = NULL;
struct Library  *GadToolsBase = NULL;
struct Library  *UtilityBase = NULL;
struct Library  *IconBase;

extern struct Window  *puzzle_win;
extern struct Menu    *puzzle_menu;

static char    pubscr_name[256];
static char    pict_name[256];
static UBYTE   cols = 5, rows = 5;


void handle_events (void);
BOOL process_menus (UWORD code);
void handle_startup_msg (char **arg, BOOL from_wb);
void read_tooltypes (char *prg_name);
BOOL initialize (void);
void finalize (void);


int
main (
   int    argc,
   char  *argv[])
{
   pubscr_name[0] = '\0';
   strncpy (pict_name, "beach.ilbm", 255);
   
   handle_startup_msg (argv, (argc == 0));

   init_locale ("multipuzzle.catalog");
   if (initialize ())
      handle_events ();
   finalize ();
   finalize_locale ();

   return 0;
}


void
handle_events (void)
{
   struct IntuiMessage  *msg;
   BOOL    quit = FALSE;
   
   while (!quit)
   {
      WaitPort (puzzle_win->UserPort);
      while (msg = (struct IntuiMessage *)GetMsg (puzzle_win->UserPort))
      {
         switch (msg->Class)
         {
         case IDCMP_MOUSEBUTTONS:
            if (!puzzle_done ())
            {
               switch (msg->Code)
               {
               case SELECTDOWN:
                  if (is_inside_puzzle (msg->MouseX, msg->MouseY))
                  {
                     play_puzzle (coords2piece (msg->MouseX, msg->MouseY),
                                  TRUE);
                  }
                  break;
               case MIDDLEDOWN:
                  draw_numbers ();
                  break;
               }
               break;
            }
            break;
         case IDCMP_VANILLAKEY:
            switch (msg->Code)
            {
            case 'n':
            case 'N':
               if (!puzzle_done ())
                  draw_numbers ();
               break;
            }
            break;
         case IDCMP_RAWKEY:
            switch (msg->Code)
            {
            case CURSORUP:
            case CURSORDOWN:
            case CURSORRIGHT:
            case CURSORLEFT:
               if (!puzzle_done ())
                  play_puzzle (key2piece (msg->Code), TRUE);
               break;
            }
            break;
         case IDCMP_MENUPICK:
            quit = process_menus (msg->Code);
            break;
         case IDCMP_CLOSEWINDOW:
            quit = TRUE;
            break;
         }
         ReplyMsg ((struct Message *)msg);
      }
   }
}


BOOL
process_menus (
   UWORD   code)
{
   UWORD   menu_num, item_num;
   struct MenuItem  *item;
   BOOL   quit = FALSE;
   char   buf_1[81], buf_2[256];

   while (code != MENUNULL)
   {
      item = ItemAddress (puzzle_menu, code);
      menu_num = MENUNUM (code);
      item_num = ITEMNUM (code);
      switch (menu_num)
      {
      case MENU_GAME:
         switch (item_num)
         {
         case ITEM_NEW:
            if (!quit)
               shuffle_puzzle ();
            break;
         case ITEM_ABOUT:
            sprintf (buf_1, localized_string (MSG_ABOUT_REQTITLE), PRG_NAME);
            sprintf (buf_2, localized_string (MSG_ABOUT_REQMSG),
                     PRG_NAME, VERSION_NO, AUTHOR, MAIL_ADDRESS,
                     CREATION_YEAR, AUTHOR);
            msg_requester (puzzle_win, buf_1,
                           localized_string (MSG_CONTINUE_GAD), buf_2);
            break;
         case ITEM_QUIT:
            quit = TRUE;
            break;
         }
         break;
      case MENU_SETTINGS:
         switch (item_num)
         {
         case ITEM_PICTURE:
            if (!quit)
            {
               if (request_picture (pict_name))
                  define_puzzle (rows, cols);
               else if (IoErr () == FILE_ERROR)
                  msg_requester (puzzle_win, "File Error", "OK", "Couldn't open file!");
            }
            break;
         }
         break;
      }
      code = item->NextSelect;
   }
   
   return quit;
}


void
handle_startup_msg (
   char **arg,
   BOOL   from_wb)
{
   BPTR   old_dir = -1;
   struct WBStartup  *wb_arg;
   
   if (from_wb)
   {
      wb_arg = (struct WBStartup *)arg;
      if (wb_arg->sm_ArgList->wa_Lock)
         old_dir = CurrentDir (wb_arg->sm_ArgList->wa_Lock);
      read_tooltypes (wb_arg->sm_ArgList->wa_Name);
      if (old_dir != -1)
         CurrentDir (old_dir);
   }
   else
      read_tooltypes (arg[0]);
}


void
read_tooltypes (
   char  *prg_name)
{
   struct DiskObject  *disk_obj;
   char  *tool_value;
   
   if (IconBase = OpenLibrary ("icon.library", 37L))
   {
      if (disk_obj = GetDiskObject (prg_name))
      {
         if (tool_value = FindToolType (disk_obj->do_ToolTypes, "PUBSCREEN"))
            strncpy (pubscr_name, tool_value, 255);
         if (tool_value = FindToolType (disk_obj->do_ToolTypes, "PICTURE"))
            strncpy (pict_name, tool_value, 255);
         if (tool_value = FindToolType (disk_obj->do_ToolTypes, "ROWS"))
            rows = atoi (tool_value);
         if (tool_value = FindToolType (disk_obj->do_ToolTypes, "COLUMNS"))
            cols = atoi (tool_value);
         FreeDiskObject (disk_obj);
      }
      CloseLibrary (IconBase);
   }
}


BOOL
initialize (void)
{
   if ((DataTypesBase = OpenLibrary ("datatypes.library", 39L)) &&
       (GfxBase = OpenLibrary ("graphics.library", 39L)) &&
       (IntuitionBase = OpenLibrary ("intuition.library", 39L)) &&
       (GadToolsBase = OpenLibrary ("gadtools.library", 37L)) &&
       (UtilityBase = OpenLibrary ("utility.library", 37L)) &&
       (AslBase = OpenLibrary ("asl.library", 37L)) &&
       (init_display (pubscr_name, pict_name)) &&
       (define_puzzle (rows, cols)))
   {
      return TRUE;
   }
   
   return FALSE;
}


void
finalize (void)
{
   finalize_puzzle ();
   finalize_display ();
   if (AslBase)
      CloseLibrary (AslBase);
   if (UtilityBase)
      CloseLibrary (UtilityBase);
   if (GadToolsBase)
      CloseLibrary (GadToolsBase);
   if (IntuitionBase)
      CloseLibrary (IntuitionBase);
   if (GfxBase)
      CloseLibrary (GfxBase);
   if (DataTypesBase)
      CloseLibrary (DataTypesBase);
}
