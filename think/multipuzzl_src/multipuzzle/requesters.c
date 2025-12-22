/*
 * requesters.c
 * ============
 * Some usefull functions for handling requesters.
 *
 * Copyright (C) 1994-1998 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <exec/types.h>
#include <exec/libraries.h>
#include <intuition/intuition.h>
#include <libraries/gadtools.h>
#include <string.h>

#include <clib/exec_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>

#include "requesters.h"


extern struct Library  *IntuitionBase;


BOOL
window_sleep (
   struct Window     *win,
   struct Requester  *req)
{
   InitRequester (req);
   if (Request (req, win))
   {
      if (IntuitionBase->lib_Version >= 39L)
         SetWindowPointer (win, WA_BusyPointer, TRUE, TAG_DONE);
      
      return TRUE;
   }
   
   return FALSE;
}

void
window_wakeup (
   struct Window     *win,
   struct Requester  *req)
{
   if (IntuitionBase->lib_Version >= 39L)
      SetWindowPointer (win, WA_Pointer, NULL, TAG_DONE);
   EndRequest (req, win);
}

LONG
msg_requester (
   struct Window  *win,
   char           *title,
   char           *gad_title,
   char           *message)
{
   struct EasyStruct   msg_req;
   struct Requester    req;
   BOOL   win_sleep = FALSE;
   LONG   retval;

   msg_req.es_StructSize = sizeof (msg_req);
   msg_req.es_Flags = 0;
   msg_req.es_Title = title;
   msg_req.es_TextFormat = message;
   msg_req.es_GadgetFormat = gad_title;
   
   if (win != NULL)
      win_sleep = window_sleep (win, &req);
   retval = EasyRequest (win, &msg_req, NULL, NULL);
   if (win_sleep)
      window_wakeup (win, &req);

   return retval;
}
