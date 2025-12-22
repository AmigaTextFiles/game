/*
** gibbet.c
**
** (C) Copyright 2004 by Imax.
**  All other rights reserved.
** This information is provided "as is"; no warranties are made.  All
** use is at your own risk. No liability or responsibility is assumed.
*/

#include <stdio.h>
#include <stdlib.h>
#include <exec/types.h>
#include <exec/memory.h>
#include <dos/dos.h>
#include <intuition/intuition.h>
#include <intuition/gadgetclass.h>
#include <intuition/icclass.h>
#include <intuition/classes.h>
#include <libraries/gadtools.h>
#include <graphics/gfx.h>
#include <libraries/dos.h>
#include <time.h>
#include <datatypes/datatypes.h>
#include <datatypes/pictureclass.h>
#include <datatypes/pictureclass.h>
#include <utility/tagitem.h>
#include <workbench/icon.h>
#include <workbench/startup.h>
#include <workbench/workbench.h>

#include <clib/dos_protos.h>
#include <clib/wb_protos.h>

#include <proto/exec.h>
#include <proto/graphics.h>
#include <proto/diskfont.h>
#include <proto/intuition.h>
#include <proto/gadtools.h>
#include <proto/dos.h>
#include <proto/icon.h>
#include <proto/datatypes.h>
#include <proto/utility.h>
#include <proto/wb.h>

/*------------------------------------------------------------------------*/
char *ID = "$VER: aGibbet v1.52 (07.08.04)\r\n";


int main(int argc, char **argv);
void bail_out(int, STRPTR);
struct Gadget *CreateAllGadgets(struct Gadget **, void *, UWORD, APTR);
struct TextAttr Gibbet15 =
{
    "Gibbet.font",  /* Name */
    15,         /* YSize */
    0,          /* Style */
    0,          /* Flags */
};

extern struct Library *SysBase;
struct GfxBase *GfxBase = NULL;
struct IntuitionBase *IntuitionBase = NULL;
struct Library *DiskfontBase = NULL;
struct Library *GadToolsBase = NULL;
struct Library *DataTypesBase = NULL;
struct Library *UtilityBase = NULL;
struct Library *IconBase = NULL;
struct TextFont *font = NULL;
struct Screen *mysc = NULL;
struct Gadget *glist = NULL;
struct Window *mywin = NULL;
void *vi = NULL;

BOOL terminated = FALSE;

    Object *dtobj;
    BPTR fileimg,filewords;
    UBYTE imgfilename[]="PROGDIR:pics/gibbet0.pic";
    ULONG lengthimg,lengthwords;
    ULONG sigr;
    ULONG cntwords, cnt1;
    ULONG rndword;
    APTR imagearray, wordsarray;
    UBYTE *addr1, *addr2;
    UWORD wrongcnt;
    UBYTE selword[21], guidword[21];
    struct Gadget *fistgad, *gadword, *gadstat;
    UBYTE textwin[]="WINNER! -->";
    UBYTE textgib[]="HANGING! -->";
    UBYTE textgdst[]="            ";
    UBYTE textgdwd[]="                    ";

    struct RDArgs *rdargs;
    struct DiskObject *dob=NULL;
    BOOL flagnb=FALSE;
    #define TEMPLATE    "NAME/A"
    #define OPT_NAME    0
    #define NUM_OPTS    1
    BOOL FromWb;

int main(int argc, char **argv)
{
    struct WBStartup *wbMsg = NULL;
    struct IntuiMessage *imsg;
    struct Gadget *gad, *crntgad;
    ULONG imsgClass;
    UWORD imsgCode;
    UWORD topborder;
    int i;
    UBYTE gadgsel,koda,gadnum=0;
    BOOL guidflag, ngflag;
    ULONG options[NUM_OPTS]={0};
    STRPTR namebw;


    if (!(GfxBase = (struct GfxBase *)
    OpenLibrary("graphics.library", 36L)))
    bail_out(20, "Requires V36 graphics.library");

    if (!(IntuitionBase = (struct IntuitionBase *)
    OpenLibrary("intuition.library", 36L)))
    bail_out(20, "Requires V36 intuition.library");

    if (!(GadToolsBase = OpenLibrary("gadtools.library", 36L)))
    bail_out(20, "Requires V36 gadtools.library");

    if (!(DataTypesBase = OpenLibrary ("datatypes.library", 39L)))
    bail_out(20, "Requires V39 datatypes.library");

    if (!(UtilityBase = OpenLibrary ("utility.library", 39L)))
    bail_out(20, "Requires V39 utility.library");

     if (!(DiskfontBase = (struct Library *)
        OpenLibrary("diskfont.library", 37L) ))
    bail_out(20, "Couldn't open Diskfont V37");

    if (!(font = OpenDiskFont(&Gibbet15)))
    bail_out(20, "Failed to open Gibbet 15");

    if (!(mysc = LockPubScreen(NULL)))
    bail_out(20, "Couldn't lock default public screen");

    if (!(vi = GetVisualInfo(mysc,
    TAG_DONE)))
    bail_out(20, "GetVisualInfo() failed");

    topborder = mysc->WBorTop + (mysc->Font->ta_YSize + 1);

    FromWb = (argc==0) ? TRUE : FALSE;

    if(!(IconBase = OpenLibrary("icon.library",33)))
    bail_out(20, "Requires V33 icon.library");

    if(FromWb)
    {  wbMsg = (struct WBStartup *)argv;
       if (dob = GetDiskObject (wbMsg->sm_ArgList->wa_Name))
       {namebw=FindToolType (dob->do_ToolTypes, "NAME");
       }
    }
    else
    {
    rdargs = ReadArgs (TEMPLATE, (LONG *)options, NULL);
    if (options[OPT_NAME]!=0) namebw = (STRPTR) options[OPT_NAME];
    }

   filewords=Open(namebw, MODE_OLDFILE);

  if(filewords) {
    Seek(filewords, 0, OFFSET_END);
    lengthwords = Seek(filewords, 0, OFFSET_BEGINNING);
    wordsarray = AllocMem(lengthwords, MEMF_ANY);
    if(wordsarray) {
      Read(filewords, wordsarray, lengthwords);
      }
    } else  bail_out(20, "Open Wordsbase failed");
    Close(filewords);

    if (!CreateAllGadgets(&glist, vi, topborder, wordsarray))
    {
    bail_out(20, "CreateAllGadgets() failed");
    }

    if (!(mywin = OpenWindowTags(NULL,
    WA_Width, 326,
    WA_InnerHeight, 172,
    WA_Top,((mysc->Height)-172)>>2,
    WA_Left,((mysc->Width)-326)>>1,
    WA_Activate, TRUE,
    WA_DragBar, TRUE,
    WA_DepthGadget, TRUE,
    WA_CloseGadget, TRUE,
    WA_SizeGadget, FALSE,
    WA_SimpleRefresh, TRUE,
    WA_IDCMP, IDCMP_IDCMPUPDATE | CLOSEWINDOW | REFRESHWINDOW | BUTTONIDCMP,
    WA_Title, "aGibbet",
    WA_Gadgets, glist,
    TAG_DONE)))
    bail_out(20, "OpenWindow() failed");

    GT_RefreshWindow(mywin, NULL);

    srand (time(0));
    addr1=(UBYTE*)wordsarray;
    while (*addr1++!=0x0A)
     gadnum++;

startnew:
    wrongcnt=0;
    imgfilename[19]=48;

    if (!(dtobj=NewDTObject(imgfilename,DTA_GroupID,GID_PICTURE,PDTA_Remap,TRUE,TAG_DONE)))
    {   bail_out(20, "OpenDT failed");}

    SetDTAttrs (dtobj, NULL, NULL,
                GA_Left,12,
                GA_Top,topborder+12,
                GA_Width,80,
                GA_Height,150,
                ICA_TARGET, ICTARGET_IDCMP,
                TAG_DONE);

    AddDTObject (mywin, NULL, dtobj, -1);

    RefreshDTObjects (dtobj, mywin, NULL, NULL);

    ngflag=FALSE;

    for(i=0;i<12;i++)
    textgdst[i]=' ';

    GT_SetGadgetAttrs(gadstat, mywin, NULL, GTTX_Text, textgdst, TAG_DONE);

    cntwords=1;
    cnt1=lengthwords;
    addr1=(UBYTE*)wordsarray;
    while (cnt1>0)
     {if (*addr1==0x0A) cntwords++;
     addr1++;
     cnt1--;
     }
    cntwords-=2;
    rndword=rand() % cntwords;

    rndword++;
    addr1=(UBYTE*)wordsarray;
    while (rndword>0)
     {if (*addr1==10) rndword--;
      addr1++;
     }
    i=0;
    while (*addr1!=10)
     selword[i++]=(*addr1++);
     selword[i]=0;
//    printf("%s\n",selword);

    for(i=0;i<21;i++)
    {if (selword[i]!=0) guidword[i]=42;
     else guidword[i]=0;}

    i=0;
    while (selword[i]!=0) i++;
    i--;
    rndword=rand() % i;
    koda=selword[rndword];

    i=0;
    while (selword[i]!=0)
    {if (koda==selword[i]) guidword[i]=koda;
     i++;}

    crntgad=fistgad;
    koda=selword[rndword];
    for (i=0;i<gadnum;i++)
     {crntgad=crntgad->NextGadget;
     if (koda==crntgad->GadgetID) {GT_SetGadgetAttrs(crntgad, mywin, NULL, GA_Disabled, TRUE, NULL); break;}
     }

   i=0;
   while(guidword[i]!=0)
   {textgdwd[i]=guidword[i];i++;}
   while(i<20)
    {textgdwd[i++]=' ';}

   GT_SetGadgetAttrs(gadword, mywin, NULL, GTTX_Text, textgdwd, TAG_DONE);

    while (!terminated)
    {
    sigr=Wait ((1 << mywin->UserPort->mp_SigBit) | SIGBREAKF_CTRL_C);
   if (sigr & SIGBREAKF_CTRL_C) terminated = TRUE;

    while ((!terminated) && (imsg = GT_GetIMsg(mywin->UserPort)))
    {
        imsgClass = imsg->Class;
        imsgCode = imsg->Code;

        gad = (struct Gadget *)imsg->IAddress;

        GT_ReplyIMsg(imsg);
        switch (imsgClass)
        {
        case GADGETUP:

    gadgsel=(UBYTE)(gad->GadgetID);

       if (gadgsel==1)
       {crntgad=fistgad;
       for (i=0;i<gadnum;i++)
        {crntgad=crntgad->NextGadget;
        GT_SetGadgetAttrs(crntgad, mywin, NULL, GA_Disabled, FALSE, NULL);
        }
       RemoveDTObject (mywin,dtobj);
       DisposeDTObject(dtobj);
       GT_RefreshWindow(mywin, NULL);
       goto startnew;
       }

       if (ngflag==FALSE)
      {
       GT_SetGadgetAttrs(gad, mywin, NULL, GA_Disabled, TRUE, NULL);
       GT_RefreshWindow(mywin, NULL);

       koda=gadgsel;
       guidflag=FALSE;
       i=0;
       while (selword[i]!=0)
       {if (selword[i]==koda)
         {guidword[i]=koda;
          guidflag=TRUE;}
        i++;
       }

       if (guidflag==FALSE)
       { wrongcnt++;
       RemoveDTObject (mywin,dtobj);
       DisposeDTObject(dtobj);
       imgfilename[19]=wrongcnt+48;
    if (!(dtobj=NewDTObject(imgfilename,DTA_GroupID,GID_PICTURE,PDTA_Remap,TRUE,TAG_DONE)))
    {   bail_out(20, "OpenDT failed");}

    SetDTAttrs (dtobj, NULL, NULL,
                GA_Left,12,
                GA_Top,topborder+12,
                GA_Width,80,
                GA_Height,150,
                ICA_TARGET, ICTARGET_IDCMP,
                TAG_DONE);

    AddDTObject (mywin, NULL, dtobj, -1);
    RefreshDTObjects (dtobj, mywin, NULL, NULL);

        if(wrongcnt>6)
        {i=0;
         while(selword[i]!=0)
         {textgdwd[i]=selword[i]; i++;}
         while(i<20)
         {textgdwd[i++]=' ';}

        GT_SetGadgetAttrs(gadword, mywin, NULL, GTTX_Text, textgdwd, TAG_DONE);

        for(i=0;i<12;i++)
        textgdst[i]=textgib[i];

        GT_SetGadgetAttrs(gadstat, mywin, NULL, GTTX_Text, textgdst, TAG_DONE);

        ngflag=TRUE;
        }            //wrongcnt>6
       } else       //guidflag=TRUE
        {
         i=0;
         while(guidword[i]!=0)
         {textgdwd[i]=guidword[i]; i++;}
         while(i<20)
         {textgdwd[i++]=' ';}

         GT_SetGadgetAttrs(gadword, mywin, NULL, GTTX_Text, textgdwd, TAG_DONE);

         i=0;
         ngflag=TRUE;
         while(guidword[i]!=0)
          {if (guidword[i++]==42) ngflag=FALSE;}
         if (ngflag==TRUE)
          {
          for(i=0;i<12;i++)
          textgdst[i]=textwin[i];

          GT_SetGadgetAttrs(gadstat, mywin, NULL, GTTX_Text, textgdst, TAG_DONE);

          }

        }          // else guidflag=true
      }           // if ngflag=FALSE
            break;  // case gadgetup

        case CLOSEWINDOW:
            terminated = TRUE;
            break;

        case IDCMPUPDATE:
         if (FindTagItem (DTA_Sync, (struct TagItem *)imsg->IAddress))
         RefreshGList ((struct Gadget *) dtobj, mywin, NULL, 1);
         break;

        case REFRESHWINDOW:
            GT_BeginRefresh(mywin);
            GT_EndRefresh(mywin, TRUE);
            break;
        }
    }
    }
    bail_out(0, NULL);
return 0;
}


void bail_out( int code, STRPTR error)
{   if (rdargs) FreeArgs (rdargs);

    if (dob) FreeDiskObject (dob);

    if (dtobj)
    {RemoveDTObject (mywin,dtobj);
     DisposeDTObject(dtobj);}

    if (DataTypesBase) CloseLibrary(DataTypesBase);

    if (mywin) CloseWindow(mywin);

    if (GadToolsBase)
    {
    FreeVisualInfo(vi);
    FreeGadgets(glist);
    CloseLibrary(GadToolsBase);
    }

   if (wordsarray) FreeMem(wordsarray,lengthwords);

    if (mysc) UnlockPubScreen(NULL, mysc);

    if (font) CloseFont(font);

    if (DiskfontBase) CloseLibrary(DiskfontBase);

    if (IntuitionBase) CloseLibrary( ( struct Library *)IntuitionBase);

    if (GfxBase) CloseLibrary( ( struct Library *)GfxBase);

    if (IconBase) CloseLibrary( ( struct Library *)IconBase);

    if (UtilityBase) CloseLibrary( ( struct Library *)UtilityBase);

    if (error) printf("Error: %s\n", error);

    exit(code);
}

struct Gadget *CreateAllGadgets( struct Gadget **glistptr, void *vi, UWORD topborder, APTR wordsarray)
{
    struct NewGadget ng;
    struct Gadget *gad;
    UBYTE *addr,*addr1,i,textgdarr[100],gadnum=0;
    ULONG x,y,x0=135;

    addr=(UBYTE*)wordsarray;
    while (*addr++!=0x0A)
     gadnum++;

    addr=&textgdarr[0];
    addr1=(UBYTE*)wordsarray;

     for(i=0;i<gadnum;i++)
     {*addr++=*addr1++;
      *addr++=0;}

    gad = CreateContext(glistptr);

    ng.ng_TextAttr = &Gibbet15;
    ng.ng_VisualInfo = vi;

    ng.ng_LeftEdge = 245;
    ng.ng_TopEdge = topborder+9;
    ng.ng_Width = 40;
    ng.ng_Height = 20;
    ng.ng_GadgetText = "NEW";
    ng.ng_GadgetID = 1;
    ng.ng_Flags = 0;
    gad = CreateGadget(BUTTON_KIND, gad, &ng,TAG_DONE);

    ng.ng_Height = 15;
    ng.ng_TopEdge = topborder+12;
    ng.ng_LeftEdge = 135;
    ng.ng_GadgetText = NULL;
    ng.ng_GadgetID = 2;
    gad = CreateGadget(TEXT_KIND, gad, &ng,
    GTTX_Text,textgdst,
    GTTX_BackPen,0,
    GTTX_CopyText,TRUE,
     TAG_DONE);

    gadstat=gad;

    ng.ng_Height = 15;
    ng.ng_TopEdge = topborder+44;
    ng.ng_LeftEdge = 125;
    ng.ng_GadgetText = NULL;
    ng.ng_GadgetID = 3;
    gad = CreateGadget(TEXT_KIND, gad, &ng,
    GTTX_Text,textgdwd,
    GTTX_BackPen,0,
    GTTX_CopyText,TRUE,
     TAG_DONE);

    gadword=gad;

    fistgad=gad;
    i=1;
    addr=&textgdarr[0];
    if (gadnum>32) x0=125;
     if (gadnum>36) x0=105;

    for (y=85;y<=145;y+=20)
    {for (x=x0; x<=290; x+=20)
     {ng.ng_LeftEdge = x;
    ng.ng_TopEdge = y;
    ng.ng_Width = 20;
    ng.ng_Height = 20;
    ng.ng_GadgetText = addr;
    ng.ng_GadgetID = *addr;
    ng.ng_Flags = 0;
    gad = CreateGadget(BUTTON_KIND, gad, &ng,TAG_DONE);
    i++;
    if (i>gadnum) break;
    addr+=2;
     }
    if (i>gadnum) break;
    }

    return(gad);
}



/*------------------------------------------------------------------------*/
