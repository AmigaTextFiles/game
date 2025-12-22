/*
->===========================================================<-
->= Snakee - © Copyright 2003,2009 OnyxSoft                 =<-
->===========================================================<-
->= Version  : 0.2 - Public MUI-version                     =<-
->= Author   : Stefan Blixth                                =<-
->= Compiled : 2009-01-24                                   =<-
->= Info     : A small MUI-based wormgame                   =<-
->===========================================================<-
*/

#include "Snakee.h"

/*=----------------------------- Patches() -----------------------------------*
 * Patching some incompatible functions                                       *
 *----------------------------------------------------------------------------*/

#ifndef __MORPHOS__
Object * VARARGS68K DoSuperNew(struct IClass *cl, Object *obj, ...)
{
  Object *rc;
  VA_LIST args;

  VA_START(args, obj);
  rc = (Object *)DoSuperMethod(cl, obj, OM_NEW, VA_ARG(args, IPTR), NULL);
  VA_END(args);

  return rc;
}
#endif

/*=*/

/*=----------------------------- snakee_new() --------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

//static ULONG snakee_new(struct IClass *cl, Object *obj, struct opSet *msg)
static ULONG snakee_new(struct IClass *cl, Object *obj, Msg msg)
{
   struct snakee_data *data;
/*
   obj = DoSuperNew(cl, obj,
         InnerSpacing(0,0),
         MUIA_Frame,    MUIV_Frame_Virtual,
         MUIA_FillArea, FALSE,
         TAG_MORE,      INITTAGS);  //(struct opSet *)msg->ops_AttrList);

   if (!obj)
   {
      return(0);
   }
*/

	if (!(obj = (Object *)DoSuperMethodA(cl, obj, msg)))
		return(0);


   data = (struct snakee_data *)INST_DATA(cl, obj);

   /* Default values for our Application... */
   data->food        = 0;
   data->level       = 1;
   data->points      = 0;
   data->delay       = GAME_DELAY;
   data->wormlen     = GAME_WGROW;
   data->len         = 0;
   data->way         = DIRECTION_NONE;
   data->waytemp     = DIRECTION_NONE;
   data->sleep       = TRUE;

   if ((data->port = CreateMsgPort()))
   {
      if ((data->req = (struct timerequest *)CreateIORequest(data->port, sizeof(struct timerequest))))
      {
         if (!OpenDevice(TIMERNAME, UNIT_MICROHZ, (struct IORequest *)data->req, 0))
         {
            data->ihnode.ihn_Object  = obj;
            data->ihnode.ihn_Method  = MUIM_TriggerRedraw;
            data->ihnode.ihn_Signals = IO_SIGMASK(data->req);
            data->ihnode.ihn_Flags   = 0;
            return((ULONG)obj);
         }
      }
   }

   CoerceMethod(cl, obj, OM_DISPOSE);
   return(0);
}

/*=*/

/*=----------------------------- snakee_dispose() ----------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_dispose(struct IClass *cl, Object *obj, Msg msg)
{
   struct snakee_data *data = (struct snakee_data *)INST_DATA(cl, obj);

   if (data->req)
   {
      if (data->req->tr_node.io_Device)
      {
         CloseDevice((struct IORequest *)data->req);
      }

      DeleteIORequest((struct IORequest *)data->req);
   }

   if (data->port)
      DeleteMsgPort(data->port);


   return (DoSuperMethodA(cl, obj, msg));
}

/*=*/

/*=----------------------------- snakee_setup() ------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_setup(struct IClass *cl, Object *obj, Msg msg)
{
   struct snakee_data *data = (struct snakee_data *)INST_DATA(cl, obj);

   if (!DoSuperMethodA(cl, obj, msg))
      return(FALSE);

   /* Add timer handler... */
   data->req->tr_node.io_Command = TR_ADDREQUEST;
   data->req->tr_time.tv_secs    = 0;
   data->req->tr_time.tv_micro   = data->delay;
   SendIO((struct IORequest *)data->req);

   DoMethod(_app(obj), MUIM_Application_AddInputHandler, &data->ihnode);

   /* Add event handler for IDCMP-stuff... */
   data->ehnode.ehn_Object = obj;
   data->ehnode.ehn_Class  = cl;
   data->ehnode.ehn_Events = IDCMP_RAWKEY | IDCMP_VANILLAKEY | IDCMP_INACTIVEWINDOW;

   DoMethod(_win(obj), MUIM_Window_AddEventHandler, &data->ehnode);

   return(TRUE);
}

/*=*/

/*=----------------------------- snakee_cleanup() ----------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_cleanup(struct IClass *cl, Object *obj, struct MUIP_HandleInput *msg)
{
   struct snakee_data *data = (struct snakee_data *)INST_DATA(cl, obj);

   /* Remove the handler for the IDCMP-stuff */
   DoMethod(_win(obj), MUIM_Window_RemEventHandler, &data->ehnode);

   /* Remove the timer handler */
   DoMethod(_app(obj), MUIM_Application_RemInputHandler, &data->ihnode);

   /* Remove the opened device/port/request */
   if (!CheckIO((struct IORequest *)data->req))
      AbortIO((struct IORequest *)data->req);

   WaitIO((struct IORequest *)data->req);

   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

/*=*/

/*=----------------------------- snakee_handler() ----------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_handler(struct IClass *cl, Object *obj, struct MUIP_HandleInput *msg)
{
   struct snakee_data *data = (struct snakee_data *)INST_DATA(cl, obj);

   if (msg->imsg)
   {
      switch (msg->imsg->Class)
      {
         case IDCMP_RAWKEY:
         {
            switch (msg->imsg->Code)
            {
               case CURSORUP:
               {
                  if (data->sleep) pausestart(data);
                  if (data->way != DIRECTION_DOWN) data->way = DIRECTION_UP;
               }  break;

               case CURSORDOWN:
               {
                  if (data->sleep) pausestart(data);
                  if (data->way != DIRECTION_UP) data->way = DIRECTION_DOWN;
               }  break;

               case CURSORRIGHT:
               {
                  if (data->sleep) pausestart(data);
                  if (data->way != DIRECTION_LEFT) data->way = DIRECTION_RIGHT;
               }  break;

               case CURSORLEFT:
               {
                  if (data->sleep) pausestart(data);
                  if (data->way != DIRECTION_RIGHT) data->way = DIRECTION_LEFT;
               }  break;
            }

         }  break;

         case IDCMP_VANILLAKEY:
         {
            //if (msg->imsg->Code == 27) going = FALSE;
            //if (msg->imsg->Code == 112) pause();
         }  break;

         case IDCMP_INACTIVEWINDOW:
         {
            if (!data->sleep) pausestart(data);
         }  break;
      }
   }

   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

/*=*/

/*=----------------------------- snakee_askminmax() --------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_askminmax(struct IClass *cl, Object *obj, struct MUIP_AskMinMax *msg)
{
   DoSuperMethodA(cl, obj, (Msg)msg);

   msg->MinMaxInfo->MinWidth  += GAME_WIDTH;
   msg->MinMaxInfo->DefWidth  += GAME_WIDTH;
   msg->MinMaxInfo->MaxWidth  += GAME_WIDTH;

   msg->MinMaxInfo->MinHeight += GAME_HEIGHT;
   msg->MinMaxInfo->DefHeight += GAME_HEIGHT;
   msg->MinMaxInfo->MaxHeight += GAME_HEIGHT;

   return(0);
}

/*=*/

/*=----------------------------- zoomit_draw() -------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_draw(struct IClass *cl, Object *obj, struct MUIP_Draw *msg)
{
   struct snakee_data *data = (struct snakee_data *)INST_DATA(cl, obj);

   DoSuperMethodA(cl, obj, (Msg)msg);

   if ((msg->flags & MADF_DRAWUPDATE)) // Triggered draw update from function
   {
      data->mccrp = _rp(obj);
      data->mccx  = _mleft(obj);
      data->mccy  = _mtop(obj);
      data->mccw  = _mright(obj);
      data->mcch  = _mbottom(obj);

      if (!data->sleep)
      {
         switch(data->way)
         {
            case DIRECTION_UP:
               data->ypos--;
               break;

            case DIRECTION_DOWN:
               data->ypos++;
               break;

            case DIRECTION_RIGHT:
               data->xpos++;
               break;

            case DIRECTION_LEFT:
               data->xpos--;
               break;
         }

         if (data->len < (data->wormlen - 1))
         {
            data->len++;
            data->pos[data->len].x = data->xpos;
            data->pos[data->len].y = data->ypos;

            SetAPen(data->mccrp, 1);
            WritePixel(data->mccrp, data->xpos, data->ypos);
         }
         else
         {
            SetAPen(data->mccrp, 0);
            WritePixel(data->mccrp, data->pos[0].x, data->pos[0].y);

            for (data->cntr = 0; data->cntr <= (data->wormlen - 2); data->cntr++)
            {
               data->pos[data->cntr].x = data->pos[data->cntr+1].x;
               data->pos[data->cntr].y = data->pos[data->cntr+1].y;
            }

            data->pos[data->len].x = data->xpos;
            data->pos[data->len].y = data->ypos;

            SetAPen(data->mccrp, 1);
            WritePixel(data->mccrp, data->xpos, data->ypos);
         }

         checkwalls(data);
         checksnake(data);
         checkfood(data);
      }

      return(0);
   }
   else if ((msg->flags & MADF_DRAWOBJECT))  // Initial draw of the object!
   {
      data->mccrp = _rp(obj);
      data->mccx  = _mleft(obj);
      data->mccy  = _mtop(obj);
      data->mccw  = _mright(obj);
      data->mcch  = _mbottom(obj);

      createframe(data);
      initgame(data);
      gethighscore(data);

      return(0);
   }

   return(0);
}

/*=*/

/*=----------------------------- snakee_show() -------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_show(struct IClass *cl, Object *obj, struct MUIP_Draw *msg)
{
   return(DoSuperMethodA(cl, obj, (Msg)msg));
}

/*=*/

/*=----------------------------- snakee_trigger() ----------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

static ULONG snakee_trigger(struct IClass *cl, Object *obj)
{
   struct snakee_data *data = (struct snakee_data *)INST_DATA(cl, obj);

	if (CheckIO((struct IORequest *)data->req))
	{
		WaitIO((struct IORequest *)data->req);

		data->req->tr_node.io_Command = TR_ADDREQUEST;
		data->req->tr_time.tv_secs    = 0;
		data->req->tr_time.tv_micro   = data->delay;
		SendIO((struct IORequest *)data->req);
	}

    MUI_Redraw(obj, MADF_DRAWUPDATE);
    return (TRUE);
}

/*=*/

/*=----------------------------- snakee_dispatcher() -------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

DISPATCHER(Snakee)
{
   switch (msg->MethodID)
   {
      case OM_NEW             : return snakee_new       (cl, obj, (APTR)msg); break;
      case OM_DISPOSE         : return snakee_dispose   (cl, obj, (APTR)msg); break;
      case MUIM_Setup         : return snakee_setup     (cl, obj, (APTR)msg); break;
      case MUIM_Cleanup       : return snakee_cleanup   (cl, obj, (APTR)msg); break;
      case MUIM_HandleEvent   : return snakee_handler   (cl, obj, (APTR)msg); break;
      case MUIM_AskMinMax     : return snakee_askminmax (cl, obj, (APTR)msg); break;
      case MUIM_Draw          : return snakee_draw      (cl, obj, (APTR)msg); break;
      case MUIM_Show          : return snakee_show      (cl, obj, (APTR)msg); break;
      case MUIM_TriggerRedraw : return snakee_trigger   (cl, obj);            break;
   }

   return DoSuperMethodA(cl, obj, msg);

}

/*=*/

/*=----------------------------- cleanup() -----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void cleanup(void)
{ 

#ifdef __amigaos4__
   if(IMUIMaster) DropInterface((struct Interface*)IMUIMaster);
   if(IIntuition) DropInterface((struct Interface*)IIntuition);
   if(IIcon) DropInterface((struct Interface*)IIcon);
   if(IGraphics) DropInterface((struct Interface*)IGraphics);
#endif

   if (app) MUI_DisposeObject(app);
   if (snakee_mcc) MUI_DeleteCustomClass(snakee_mcc);
   if (MUIMasterBase) CloseLibrary(MUIMasterBase);
   if (IntuitionBase) CloseLibrary((struct Library *) IntuitionBase);
   if (IconBase) CloseLibrary((struct Library *) IconBase);
   if (GfxBase) CloseLibrary((struct Library *) GfxBase);
   if (snakee_icon) FreeDiskObject(snakee_icon);
}

/*=*/

/*=----------------------------- init() --------------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void init(void)
{
   if (!(IconBase = (struct Library *)OpenLibrary("icon.library", 37L)))
   {
      puts("Error! - Could not open icon.library version 37 or later!");
      cleanup();
   }

   if (!(GfxBase = (struct GfxBase *)OpenLibrary("graphics.library", 37L)))
   {
      puts("Error! - Could not open graphics.library version 37 or later!");
      cleanup();
   }

   if (!(IntuitionBase = (struct IntuitionBase *)OpenLibrary("intuition.library", 37L)))
   {
      puts("Error! - Could not open intuition.library version 37 or later!");
      cleanup();
   }

   if (!(MUIMasterBase = OpenLibrary(MUIMASTER_NAME, MUIMASTER_VMIN)))
   {
      puts("Failed to open "MUIMASTER_NAME".");
      cleanup();
   }

#ifdef __amigaos4__
   if (!(IIcon = (struct IconIFace*)GetInterface(IconBase,"main",1,NULL)))
   {
      puts("Error! - Could not open icon interface!");
      cleanup();
   }

   if (!(IGraphics = (struct GraphicsIFace*)GetInterface((struct Library*)GfxBase,"main",1,NULL)))
   {
      puts("Error! - Could not open graphics interface!");
      cleanup();
   }

   if (!(IIntuition = (struct IntuitionIFace*)GetInterface((struct Library*)IntuitionBase,"main",1,NULL)))
   {
      puts("Error! - Could not open intuition interface!");
      cleanup();
   }

   if (!(IMUIMaster = (struct MUIMasterIFace*)GetInterface(MUIMasterBase,"main",1,NULL)))
   {
      puts("Error! - Could not open mui interface!");
      cleanup();
   }

#endif

   if (!(snakee_mcc = MUI_CreateCustomClass(NULL, MUIC_Area, NULL, sizeof(struct snakee_data), ENTRY(Snakee))))
   {
      puts("Failed to create snakee class!");
      cleanup();
   }

   snakee_icon = GetDiskObject("Snakee");

}

/*=*/

/*=----------------------------- opengui() -----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void opengui(void)
{
   app = ApplicationObject,
            MUIA_Application_Title      , NAME,
            MUIA_Application_Version    , VERSTAG_MUI,
            MUIA_Application_Copyright  , COPYRIGHT,
            MUIA_Application_Author     , AUTHOR,
            MUIA_Application_Description, "Snakee is a little MUI-based wormgame",
            MUIA_Application_Base       , "SNAKEE",
            MUIA_Application_HelpFile   , "Snakee.guide",
            MUIA_Application_DiskObject , snakee_icon,

#ifdef __MORPHOS__
            MUIA_Application_UsedClasses, UsedClasses,
            SubWindow, aboutbox = AboutboxObject,
               MUIA_Window_ID,            MAKE_ID('A','B','O','U'),
               MUIA_Aboutbox_Credits,     credits,
            End,
#endif

            SubWindow, win_main = WindowObject,
               NoFrame,
               MUIA_Window_ID,            MAKE_ID('M','A','I','N'),
               MUIA_Window_Title,         NAME,
               MUIA_Window_ScreenTitle,   VERSTAG_SCREEN,
               MUIA_Window_Menustrip,     mstrip = MUI_MakeObject(MUIO_MenustripNM, MenuData, MUIO_MenustripNM_CommandKeyCheck),

               WindowContents, VGroup,

                  Child, snakee_obj = NewObject(snakee_mcc->mcc_Class, NULL, GroupFrame, MUIA_InnerLeft, 0, MUIA_InnerRight, 0, MUIA_InnerTop, 0, MUIA_InnerBottom, 0, MUIA_Background, MUII_WindowBack, TAG_DONE),

                  Child, VGroup, GroupFrame,

                     Child, HGroup, NoFrame,

                        Child, str_status = TextObject,
                           NoFrame,
                           MUIA_Background, MUII_WindowBack,
                           MUIA_Text_Contents, "Go Go Go...",
                        End,

                     End,

                     Child, HGroup, NoFrame,

                        MUIA_Group_Columns, 4,

                        Child, Label("Level : "),
                        Child, str_level = TextObject,
                           NoFrame,
                           MUIA_Background, MUII_WindowBack,
                           MUIA_Text_Contents, "1",
                        End,
                        Child, Label("Best Level : "),
                        Child, str_blevel = TextObject,
                           NoFrame,
                           MUIA_Background, MUII_WindowBack,
                           MUIA_Text_Contents, "1",
                           MUIA_ObjectID, ID_OBJ_LEVEL,
                           MUIA_UserData, ID_OBJ_LEVEL,
                        End,

                        Child, Label("Points : "),
                        Child, str_points = TextObject,
                           NoFrame,
                           MUIA_Background, MUII_WindowBack,
                           MUIA_Text_Contents, "0",
                        End,
                        Child, Label("Highscore : "),
                        Child, str_bpoint = TextObject,
                           NoFrame,
                           MUIA_Background, MUII_WindowBack,
                           MUIA_Text_Contents, "0",
                           MUIA_ObjectID, ID_OBJ_SCORE,
                           MUIA_UserData, ID_OBJ_SCORE,
                        End,

                     End,

                  End,

               End,

            End,

         End;

   if (!app)
   {
      puts("Error! - Failed to create application.\n");
      cleanup();
   }


   DoMethod(win_main, MUIM_Notify, MUIA_Window_CloseRequest, TRUE, app, 2, MUIM_Application_ReturnID, MUIV_Application_ReturnID_Quit);

   DoMethod(app, MUIM_Application_Load, MUIV_Application_Load_ENVARC);
   set(win_main, MUIA_Window_Open, TRUE);
}
/*=*/

/*=----------------------------- handler() -----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void handler(void)
{
   while (going)
   {
      switch (DoMethod(app, MUIM_Application_NewInput, &muisig))
      {
         case MUIV_Application_ReturnID_Quit :
         {
            DoMethod(app, MUIM_Application_Save, MUIV_Application_Save_ENVARC);
            going = FALSE;
         }  break;

         case ID_BUTTON_START :
         {
         }  break;

         case ID_MENU_ABOUT :
         {
#if defined (__MORPHOS__)
            set(aboutbox, MUIA_Window_Open, TRUE);

#elif defined (__AROS__)
            MUI_Request(app, win_main, 0, "About...", "Ok", ABOUT, 0);
#else
            MUI_Request(app, win_main, 0, "About...", "Ok", ABOUT);
#endif
         }  break;

         case ID_MENU_ABOUTMUI :
         {
            DoMethod(app, MUIM_Application_AboutMUI, NULL);
         }  break;

         case ID_MENU_ICONIFY :
         {
            set(app, MUIA_Application_Iconified, TRUE);
         }  break;

         case ID_MENU_QUIT :
         {
            DoMethod(app, MUIM_Application_Save, MUIV_Application_Save_ENVARC);
            going = FALSE;
         }  break;
 
         case ID_MENU_SNAPSHOT :
         {
            DoMethod(win_main, MUIM_Window_Snapshot, TRUE);
         }  break;

         case ID_MENU_UNSNAPSHOT :
         {
            DoMethod(win_main, MUIM_Window_Snapshot, FALSE);
         }  break;

         case ID_MENU_MUIPREFS :
         {
            DoMethod(app, MUIM_Application_OpenConfigWindow, NULL);
         }  break;

         default:
            break;
      }

      if (going && muisig)
         Wait(muisig);
   }
}

/*=*/

/*=----------------------------- seedfood() ----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void seedfood(struct snakee_data *data)
{
   BOOL okidoki = FALSE;

   if (data->food <= 9)
   {
      srand(time(0));

      do
      {
         okidoki = FALSE;

         do
         {
            data->seedx = (data->mccx + 3) + (rand() % (data->mccw - 3));
         }  while((data->seedx <= (data->mccx + 3)) | (data->seedx >= (data->mccw - 3)));

         do
         {
            data->seedy = (data->mccy + 3) + (rand() % (data->mcch - 3));
         }  while((data->seedy <= (data->mccy + 3)) | (data->seedy >= (data->mcch - 3)));


         if (data->way != DIRECTION_NONE)
         {
            if (data->len > 0)
            {
               for(data->cntr = 0 ; data->cntr <= data->len - 1 ; data->cntr++)
               {
                  if ((data->pos[data->cntr].x >= (data->seedx - 2)) & (data->pos[data->cntr].x <= (data->seedx + 2)) & (data->pos[data->cntr].y >= (data->seedy - 2)) & (data->pos[data->cntr].y <= (data->seedy + 2)))
                     okidoki = TRUE;
               }
            }
         }

      }  while (okidoki);

      SetAPen(data->mccrp, 3);
      RectFill(data->mccrp, data->seedx - 2, data->seedy - 2, data->seedx + 2, data->seedy + 2);

   }
}
/*=*/

/*=----------------------------- checkwalls() --------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void checkwalls(struct snakee_data *data)
{
   if (data->way != DIRECTION_NONE)
   {
      if (data->xpos <= (data->mccx + 1) || data->xpos >= (data->mccw - 1))
      {
         data->way = DIRECTION_NONE;
         collide(data);
      }

      if (data->ypos <= (data->mccy + 1) || data->ypos >= (data->mcch - 1))
      {
         data->way = DIRECTION_NONE;
         collide(data);
      }

   }
}
/*=*/

/*=----------------------------- checksnake() --------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void checksnake(struct snakee_data *data)
{
   if (data->way != DIRECTION_NONE)
   {
      if (data->len > 0)
      {
         for(data->cntr = 0 ; data->cntr <= data->len - 1 ; data->cntr++)
         {
            if ((data->pos[data->cntr].x == data->xpos) & (data->pos[data->cntr].y == data->ypos))
            {
               data->way = DIRECTION_NONE;
               collide(data);
            }
         }
      }
   }
}
/*=*/

/*=----------------------------- checkfood() ---------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void checkfood(struct snakee_data *data)
{
   if (data->way != DIRECTION_NONE)
   {
      if ((data->xpos >= (data->seedx - 2)) & (data->xpos <= (data->seedx + 2)) & (data->ypos >= (data->seedy - 2)) & (data->ypos <= (data->seedy + 2)))
      {
         SetAPen(data->mccrp, 0);
         RectFill(data->mccrp, data->seedx - 2, data->seedy - 2, data->seedx + 2, data->seedy + 2);
         SetAPen(data->mccrp, 1);
         WritePixel(data->mccrp, data->xpos, data->ypos);

         data->food ++;
         data->points = data->points + (data->level * data->food);
         seedfood(data);

         updatescore(data);

         if (data->wormlen < GAME_WLENMAX)
            data->wormlen = data->wormlen + GAME_WGROW;

         if (data->food == GAME_FOODS - 1)
            setstatus("One to go until next level...");

         if (data->food == GAME_FOODS)
            nextlevel(data);
      }
   }
}
/*=*/

/*=----------------------------- pausestart() --------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void pausestart(struct snakee_data *data)
{
   if (data->sleep)
   {
      data->sleep = FALSE;
      setstatus("Snake on the run...");
      updatescore(data);
      data->way = data->waytemp;
   }
   else
   {
      data->sleep = TRUE;
      setstatus("Game paused...");
      data->waytemp = data->way;
      data->way = DIRECTION_NONE;
   }
}
/*=*/

/*=----------------------------- collide() -----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void collide(struct snakee_data *data)
{
   data->level    = 1;
   data->points   = 0;
   data->delay    = GAME_DELAY;
   setstatus("Ouch - Game over...");
   Delay(50); // 50 tics = 1 second delay...
   initgame(data);
}
/*=*/

/*=----------------------------- nextlevel() ---------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void nextlevel(struct snakee_data *data)
{
   data->level++;
   data->delay = (data->delay * 95) / 100; // 5% speed add from previous delay...
   setstatus("Entering next level...");
   Delay(50);
   setlevel(data->level);
   initgame(data);
}
/*=*/

/*=----------------------------- initgame() ----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void initgame(struct snakee_data *data)
{
   SetAPen(data->mccrp, 0);
   RectFill(data->mccrp, data->mccx, data->mccy, data->mccw, data->mcch);
   createframe(data);

   data->food     = 0;
   data->xpos     = 50;
   data->ypos     = 50;
   data->wormlen  = GAME_WGROW;
   data->len      = 0;
   data->way      = data->waytemp = DIRECTION_NONE;
   data->sleep    = TRUE;

   data->pos[data->len].x  = data->xpos;
   data->pos[data->len].y  = data->ypos;

   SetAPen(data->mccrp, 1);
   WritePixel(data->mccrp, data->xpos, data->ypos);

   setstatus("Go Go Go...");
   updatescore(data);
   seedfood(data);
}
/*=*/

/*=----------------------------- createframe() -------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void createframe(struct snakee_data *data)
{
   SetAPen(data->mccrp, 1);
   RectFill(data->mccrp, data->mccx, data->mcch-1, data->mccw, data->mcch);
   RectFill(data->mccrp, data->mccw-1, data->mccy, data->mccw, data->mcch);

   SetAPen(data->mccrp, 2);
   RectFill(data->mccrp, data->mccx, data->mccy, data->mccw, data->mccy);
   RectFill(data->mccrp, data->mccx, data->mccy+1, data->mccw-1, data->mccy+1);
   RectFill(data->mccrp, data->mccx, data->mccy, data->mccx, data->mcch);
   RectFill(data->mccrp, data->mccx+1, data->mccy, data->mccx+1, data->mcch-1);
}
/*=*/

/*=----------------------------- gethighscore()-------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void gethighscore(struct snakee_data *data)
{
   char *xres;

   GetAttr(MUIA_Text_Contents, str_blevel, (unsigned long*)&xres);
   sprintf(txt_blevel, "%s", xres);
   data->bestlevel = (UWORD)atoi(txt_blevel);

   GetAttr(MUIA_Text_Contents, str_bpoint, (unsigned long*)&xres);
   sprintf(txt_bpoint, "%s", xres);
   data->bestpoints = (ULONG)atol(txt_bpoint);
}
/*=*/

/*=----------------------------- updatescore() -------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void updatescore(struct snakee_data *data)
{
   setpoints(data->points);
   setlevel(data->level);

   if (data->points > data->bestpoints)
   {
      data->bestpoints = data->points;
      data->bestlevel = data->level;

      setbpoints(data->bestpoints);
      setblevel(data->bestlevel);
   }
}
/*=*/

/*=----------------------------- setstatus() ---------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void setstatus(char *newstring)
{
   set(str_status, MUIA_Text_Contents, newstring);
}
/*=*/

/*=----------------------------- setpoints() ---------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void setpoints(ULONG newpoints)
{
   sprintf(txt_point, "%ld", newpoints);
   set(str_points, MUIA_Text_Contents, txt_point);
}
/*=*/

/*=----------------------------- setlevel() ----------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void setlevel(UWORD newlevel)
{
   sprintf(txt_level, "%d", newlevel);
   set(str_level, MUIA_Text_Contents, txt_level);
}
/*=*/

/*=----------------------------- setbpoints() --------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void setbpoints(ULONG newpoints)
{
   sprintf(txt_bpoint, "%ld", newpoints);
   set(str_bpoint, MUIA_Text_Contents, txt_bpoint);
}
/*=*/

/*=----------------------------- setblevel() ---------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

void setblevel(UWORD newlevel)
{
   sprintf(txt_blevel, "%d", newlevel);
   set(str_blevel, MUIA_Text_Contents, txt_blevel);
}
/*=*/

/*=----------------------------- main() --------------------------------------*
 *                                                                            *
 *----------------------------------------------------------------------------*/

int main(void)
{
   init();
   opengui();
   handler();
   cleanup();

   return 1;
}

/*=*/

