/*
 * displayinit.c
 * =============
 * Display initialization.
 *
 * Copyright (C) 1994-1998 Håkan L. Younes (lorens@hem.passagen.se)
 */

/*
 * Need
 *  DataTypesBase 39
 *  GfxBase 39
 *  IntuitionBase 37
 *
 * Inits
 *  pub_screen = LockPubScreen (NULL);
 *  pict_rp.BitMap = NULL;
 */
#include <exec/types.h>
#include <datatypes/datatypesclass.h>
#include <graphics/rastport.h>
#include <intuition/intuition.h>
#include <intuition/screens.h>
#include <intuition/icclass.h>
#include <libraries/asl.h>
#include <libraries/gadtools.h>
#include <string.h>
#include "requesters.h"
#include "puzzle.h"
#include "displayinit.h"
#include "localize.h"

#include <clib/asl_protos.h>
#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/datatypes_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <clib/utility_protos.h>


struct Window    *puzzle_win = NULL;   /* huvudfönstret */
struct Menu      *puzzle_menu;
struct RastPort   pict_rp;             /* innehåller en kopia av bilden */

static struct NewMenu   new_puzzle_menu[] = {
   { NM_TITLE, (STRPTR)MSG_GAME_MENU, 0, 0, 0, 0 },
   {  NM_ITEM, (STRPTR)MSG_GAME_NEW, 0, 0, 0, 0 },
   {  NM_ITEM, NM_BARLABEL, 0, 0, 0, 0 },
   {  NM_ITEM, (STRPTR)MSG_GAME_ABOUT, 0, 0, 0, 0 },
   {  NM_ITEM, NM_BARLABEL, 0, 0, 0, 0 },
   {  NM_ITEM, (STRPTR)MSG_GAME_QUIT, 0, 0, 0, 0 },
   { NM_TITLE, (STRPTR)MSG_SETTINGS_MENU, 0, 0, 0, 0 },
   {  NM_ITEM, (STRPTR)MSG_SETTINGS_PICTURE, 0, 0, 0, 0 },
   { NM_END,   NULL, 0, 0, 0, 0 }
};

static APTR            visual_info;
static struct Screen  *pub_screen;      /* skärmen som skall användas */
static char            scr_title[81];   /* huvudfönstrets skärmnamn */


static BOOL init_puzzle_win (ULONG width, ULONG height);
static BOOL make_rastport (void);


static BOOL
init_puzzle_win (
   ULONG   width,
   ULONG   height)
{
   strncpy (scr_title, PRG_NAME, 80);
   strncat (scr_title, " v", 80);
   strncat (scr_title, VERSION_NO, 80);
   strncat (scr_title, " - © ", 80);
   strncat (scr_title, CREATION_YEAR, 80);
   strncat (scr_title, " ", 80);
   strncat (scr_title, AUTHOR, 80);
   
   puzzle_win = OpenWindowTags (NULL,
                                WA_Left, (pub_screen->Width - width -
                                          pub_screen->WBorLeft -
                                          pub_screen->WBorRight) / 2,
                                WA_Top, (pub_screen->Height - height -
                                         pub_screen->WBorTop -
                                         pub_screen->Font->ta_YSize -
                                         pub_screen->WBorBottom) / 2,
                                WA_InnerWidth, width,
                                WA_InnerHeight, height,
                                WA_AutoAdjust, TRUE,
                                WA_DepthGadget, TRUE,
                                WA_DragBar, TRUE,
                                WA_CloseGadget, TRUE,
                                WA_IDCMP, IDCMP_CLOSEWINDOW |
                                          IDCMP_MOUSEBUTTONS |
                                          IDCMP_VANILLAKEY |
                                          IDCMP_RAWKEY |
                                          IDCMP_MENUPICK |
                                          IDCMP_CHANGEWINDOW |
                                          IDCMP_IDCMPUPDATE,
                                WA_Title, PRG_NAME,
                                WA_ScreenTitle, scr_title,
                                WA_PubScreen, pub_screen,
                                WA_Activate, TRUE,
                                WA_BusyPointer, TRUE,
                                WA_SmartRefresh, TRUE,
                                WA_NewLookMenus, TRUE,
                                TAG_DONE);
   
   if ((visual_info = GetVisualInfo (puzzle_win->WScreen, TAG_END)) &&
       (puzzle_menu = CreateLocMenus (new_puzzle_menu, visual_info, TAG_END)) &&
       (LayoutMenus (puzzle_menu, visual_info,
                     GTMN_NewLookMenus, TRUE, TAG_END)) &&
       (SetMenuStrip (puzzle_win, puzzle_menu)))
   {
      return TRUE;
   }
   
   return FALSE;
}


static BOOL
make_rastport (void)
{
   if (pict_rp.BitMap)
      FreeBitMap (pict_rp.BitMap);
   InitRastPort (&pict_rp);
   pict_rp.BitMap = AllocBitMap (puzzle_win->Width - 
                                 puzzle_win->BorderLeft -
                                 puzzle_win->BorderRight,
                                 puzzle_win->Height -
                                 puzzle_win->BorderTop -
                                 puzzle_win->BorderBottom,
                                 puzzle_win->RPort->BitMap->Depth,
                                 0, puzzle_win->RPort->BitMap);
   if (pict_rp.BitMap)
      return TRUE;
   
   return FALSE;
}


static void
sync_window (void)
{
   BOOL   going = TRUE;
   struct IntuiMessage *msg;
   
   while (going)
   {
      WaitPort (puzzle_win->UserPort);
      while (msg = (struct IntuiMessage *)GetMsg (puzzle_win->UserPort))
      {
         if (msg->Class == IDCMP_CHANGEWINDOW)
            going = FALSE;
         ReplyMsg ((struct Message *) msg);
      }
   }
}
         

static void
sync_picture (
   Object  *dto)
{
   BOOL going = TRUE;
   struct IntuiMessage *msg;
   struct TagItem *tstate, *tag;
   struct TagItem *tags;
   ULONG tidata;
   
   while (going)
   {
      WaitPort (puzzle_win->UserPort);
      while (msg = (struct IntuiMessage *)GetMsg (puzzle_win->UserPort))
      {
         switch (msg->Class)
         {
         case IDCMP_IDCMPUPDATE:
            tstate = tags = (struct TagItem *) msg->IAddress;
            while (tag = NextTagItem (&tstate))
            {
               tidata = tag->ti_Data;
               switch (tag->ti_Tag)
               {
               /* Change in busy state */
               case DTA_Busy:
                  if (tidata)
                     SetWindowPointer (puzzle_win, WA_BusyPointer, TRUE, TAG_DONE);
                  else
                     SetWindowPointer (puzzle_win, WA_Pointer, NULL, TAG_DONE);
                  break;
               /* Time to refresh */
               case DTA_Sync:
                  /* Refresh the DataType object */
                  RefreshDTObjects (dto, puzzle_win, NULL, NULL);
                  going = FALSE;
                  break;
               }
            }
            break;
         }
         ReplyMsg ((struct Message *) msg);
      }
   }
}


#define ASM      __asm __saveds
#define REG(x)   register __ ## x

ULONG ASM filter_files (
   REG (a0) struct Hook  *h,
   REG (a2) struct FileRequester  *fr,
   REG (a1) struct AnchorPath  *ap)
{
   struct DataType  *dtn;
   ULONG   use = FALSE;
   UBYTE   buffer[300];
   BPTR    lock;
   
   strncpy (buffer, fr->fr_Drawer, sizeof (buffer));
   AddPart (buffer, ap->ap_Info.fib_FileName, sizeof (buffer));
   if (lock = Lock (buffer, ACCESS_READ))
   {
      if (dtn = ObtainDataTypeA (DTST_FILE, (APTR)lock, NULL))
      {
         if (dtn->dtn_Header->dth_GroupID == GID_PICTURE)
            use = TRUE;
         ReleaseDataType (dtn);
      }
      UnLock (lock);
   }
   
   return use;
}


BOOL
request_picture (
   char  *pict_name)
{
   struct FileRequester  *fr;
   struct Hook   filter;
   BOOL   ret_val = FALSE;
   
   filter.h_Entry = (HOOKFUNC)filter_files;
   if (fr = AllocAslRequestTags (ASL_FileRequest,
                                 ASLFR_Window, puzzle_win,
                                 (puzzle_win ?
                                  ASLFR_SleepWindow : TAG_IGNORE), TRUE,
                                 ASLFR_RejectIcons, TRUE,
                                 ASLFR_FilterFunc, &filter,
                                 TAG_DONE))
   {
      if (AslRequestTags (fr, TAG_DONE))
      {
         strncpy (pict_name, fr->rf_Dir, 255);
         AddPart (pict_name, fr->rf_File, 255);
         ret_val = load_picture (pict_name);
      }
      else
         SetIoErr (FILE_ABORT);
      FreeAslRequest (fr);
   }
   
   return ret_val;
}


BOOL
load_picture (
   char  *pict_name)
{
   Object  *pict_obj;
   ULONG    pict_w, pict_h;
   ULONG    win_w, win_h;
   
   if (pict_obj = NewDTObject (pict_name,
                               DTA_GroupID, GID_PICTURE,
                               TAG_DONE))
   {
      if (2 == GetDTAttrs (pict_obj,
                           DTA_NominalHoriz, &pict_w,
                           DTA_NominalVert, &pict_h,
                           TAG_DONE))
      {
         if (puzzle_win)
         {
            win_w = pict_w +
                    puzzle_win->BorderLeft + puzzle_win->BorderRight;
            win_h = pict_h +
                    puzzle_win->BorderTop + puzzle_win->BorderBottom;
            
            ChangeWindowBox (puzzle_win,
                             (pub_screen->Width - win_w) / 2,
                             (pub_screen->Height - win_h) / 2,
                             win_w, win_h);
            sync_window ();
         }
         
         if (puzzle_win || init_puzzle_win (pict_w, pict_h))
         {
            if (make_rastport ())
            {
               pict_w = puzzle_win->Width - puzzle_win->BorderLeft -
                        puzzle_win->BorderRight;
               pict_h = puzzle_win->Height - puzzle_win->BorderTop -
                        puzzle_win->BorderBottom;
               SetDTAttrs (pict_obj, NULL, NULL,
                           GA_Left, puzzle_win->BorderLeft,
                           GA_Top, puzzle_win->BorderTop,
                           GA_Width, pict_w,
                           GA_Height, pict_h,
                           ICA_TARGET, ICTARGET_IDCMP,
                           TAG_DONE);
               
               AddDTObject (puzzle_win, NULL, pict_obj, -1);
               sync_picture (pict_obj);
               
               ClipBlit (puzzle_win->RPort,
                         puzzle_win->BorderLeft, puzzle_win->BorderTop,
                         &pict_rp, 0, 0, pict_w, pict_h, 0xC0);
               
               RemoveDTObject (puzzle_win, pict_obj);
               DisposeDTObject (pict_obj);
               
               if (init_puzzle ())
                  return TRUE;
            }
         }
      }
   }
   else
      SetIoErr (FILE_ERROR);
   
   return FALSE;
}


BOOL
init_display (
   char  *pubscr_name,
   char  *pict_name)
{
   BOOL   ret_val = FALSE;
   
   pict_rp.BitMap = NULL;
   if ((pub_screen = LockPubScreen (pubscr_name)) ||
       (pub_screen = LockPubScreen (NULL)))
   {
      if (load_picture (pict_name))
         ret_val = TRUE;
      else if (!(ret_val = request_picture (pict_name)) &&
               IoErr () == FILE_ERROR)
      {
         msg_requester (NULL, "File Error", "OK", "Couldn't open file!");
      }
   }
   
   return ret_val;
}


void
finalize_display (void)
{
   if (pict_rp.BitMap)
      FreeBitMap (pict_rp.BitMap);
   if (puzzle_win)
   {
      ClearMenuStrip (puzzle_win);
      CloseWindow (puzzle_win);
   }
   FreeMenus (puzzle_menu);
   FreeVisualInfo (visual_info);
   if (pub_screen)
      UnlockPubScreen (NULL, pub_screen);
}
