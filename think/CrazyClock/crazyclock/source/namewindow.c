/*
 * namewindow.c V1.1
 *
 * name window handling
 *
 * (c) 1992-1993 Holger Brunst
 */

#include <CClock.h>

/* Window data */
#define WIN_X   192
#define WIN_Y   68      
#define WIN_W   256
#define WIN_H   64
#define WINDOW_IDCMP (IDCMP_REFRESHWINDOW|STRINGIDCMP) 
static struct Window *win;

/* Gadget data */
#define GAD_W   200
#define GAD_H   15
#define GAD_X   (WIN_W-GAD_W)/2
#define GAD_Y   (WIN_H-GAD_H)/2

#define GAD_NAME 0
#define GAD_NUM  1
static const struct TagItem nametags[] = {GTST_String, "MrS. Anonymous",
                                          GTST_MaxChars, HIGH_STRLEN,
                                          TAG_DONE};
static struct Gadget *gadlist;
static struct GadgetData gads[] = {
 { "Enter your Name", STRING_KIND, PLACETEXT_ABOVE, nametags,
    GAD_X, GAD_Y, GAD_W, GAD_H, NULL}
};

/* Name buffer */
static char name[HIGH_STRLEN+1];

BOOL OpenNameWindow(void)
{
 /* Create gadgets */
 if (gadlist = CreateGadgetList(gads, GAD_NUM, 0)) {
  /* Open Window */
  if (win = OpenWindowTags(NULL, WA_Left, WIN_X,
                                 WA_Top, WIN_Y,
                                 WA_Width, WIN_W,
                                 WA_Height, WIN_H,
                                 WA_PubScreen, Screen,
                                 WA_Flags, WFLG_SMART_REFRESH|WFLG_ACTIVATE|
                                           WFLG_RMBTRAP,
                                 TAG_DONE)) {

   /* Add gadgets to window */
   AddGList(win, gadlist, ~0, ~0, NULL);
   RefreshGList(gadlist, win, NULL, ~0);
   GT_RefreshWindow(win, NULL);

   /* Acvtivate name gadget */
   ActivateGadget(gads[GAD_NAME].gadget, win, NULL);

   /* Set IDCMPPort */
   win->UserPort = IDCMPPort;
   win->UserData = HandleNameWindowIDCMP;
   ModifyIDCMP(win, WINDOW_IDCMP);
   
   /* O.K. */
   return (TRUE);
  }
  FreeGadgets(gadlist);
 }
 /* failure */
 return (FALSE);
}

static void CloseNameWindow(void)
{
 RemoveGList(win, gadlist, ~0);
 CloseWindowSafely(win);
 FreeGadgets(gadlist);
}

void *HandleNameWindowIDCMP(struct IntuiMessage *msg)
{
 switch (msg->Class) {
  case IDCMP_GADGETUP: {
                        USHORT   gad = (((struct Gadget *) msg->IAddress)->GadgetID);

                        /* Close window? */
                        if (gad == GAD_NAME) {
                         /* Copy string gadget buffer to internal buffer */ 
                         strcpy(name,
                                ( (struct StringInfo *)
                                 ( (struct Gadget *)
                                  msg->IAddress
                                 )->SpecialInfo
                                )->Buffer);                        

                         /* Yes. Don't forget to reply message! */
                         GT_ReplyIMsg(msg);
                         CloseNameWindow();
                         return (name);
                        }
                        break;
                       }

  case IDCMP_REFRESHWINDOW: GT_BeginRefresh(win);
                            GT_EndRefresh(win, TRUE);
                            break;
 }
 return (NULL);
}
