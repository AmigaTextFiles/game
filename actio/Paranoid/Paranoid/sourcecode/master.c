#include <intuition/intuition.h>
#include <graphics/gfxbase.h>
#include <graphics/view.h>
#include <exec/memory.h>

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
char *OpenLibrary();
short menubreite;
APTR AllocMem();

struct  GFill
{
   SHORT    LeftEdge,TopEdge;
   UBYTE    FrontPen,BackPen,DrawMode;
   BYTE     Count;
   SHORT    *XY;
   struct   Border *NextBorder;
   SHORT    data[10];
   UBYTE    FPen,BPen,DMode;
   SHORT    LEdge,TEdge;
   struct   TextAttr *ITextFont;
   UBYTE    *IText;
   struct   IntuiText *NextText;
};

OpenMaster ()
{
 if (!(IntuitionBase=(struct IntuitionBase *)
       OpenLibrary ("intuition.library",0l)))
 return (FALSE);
 if (!(GfxBase=(struct GfxBase *) 
       OpenLibrary ("graphics.library",0l)))
 { CloseLibrary (IntuitionBase); return (FALSE); }
 menubreite=20;
 return (TRUE);
}

CloseMaster (scr,win)
struct Screen *scr;
struct Window *win;
{
 if (win)           CloseWindow (win);
 if (scr)           CloseScreen (scr);
 if (GfxBase)       CloseLibrary (GfxBase);
 if (IntuitionBase) CloseLibrary (IntuitionBase);
 exit(TRUE);
}

struct Screen *MasterScreen (xweite,yweite,farbzahl,title)
short xweite,yweite,farbzahl;   UBYTE title[];
{
 struct NewScreen nws;
 struct Screen *scr,*OpenScreen();
 short modus=0,tiefe=1;
 if (farbzahl>2)  tiefe=2; if (farbzahl>4)  tiefe=3;
 if (farbzahl>8)  tiefe=4; if (farbzahl>16) tiefe=5;
 if (farbzahl>32) { tiefe=6; modus=EXTRA_HALFBRITE; }
 if (farbzahl>64) { tiefe=6; modus=HAM; }
 if ((xweite>330)&&(tiefe>4)) return (FALSE);
 if (xweite>330) modus|=HIRES;
 if (yweite>256) modus|=LACE; /* oder INTERLACE !!!!!*/
 if ((title[0]==0)||(title==0)) nws.BlockPen=0; else nws.BlockPen=1;
  nws.LeftEdge=0;                 nws.TopEdge=0;
  nws.Width=xweite;               nws.Height=yweite;
  nws.Depth=tiefe;                nws.DetailPen= 0;
  nws.ViewModes=modus | SPRITES;  
  nws.Type=CUSTOMSCREEN;
  nws.Font=NULL;                  nws.DefaultTitle=title;
  nws.Gadgets=NULL;               nws.CustomBitMap=NULL;
 if (!(scr=OpenScreen(&nws))) return (FALSE);
 if ((title[0]==0)||(title==0)) SetRast (&(scr->RastPort),0l);
 return(scr);
}
struct Window *MasterWindow (scr,x,y,xlaenge,ylaenge,idcmp,flags,title)
struct Screen *scr;
short x,y,xlaenge,ylaenge;
long idcmp,flags;
UBYTE title[];
{
 struct NewWindow nww;
 struct Window *win,*OpenWindow();
 nww.LeftEdge=x;           nww.TopEdge=y;
 nww.Width=xlaenge;        nww.Height=ylaenge;
 nww.DetailPen=0;          nww.BlockPen=1;
 nww.IDCMPFlags=idcmp | MOUSEBUTTONS | CLOSEWINDOW | MENUPICK; 
 if (flags&WINDOWSIZING)   nww.IDCMPFlags|=NEWSIZE;
 nww.Flags=flags | REPORTMOUSE;
 nww.FirstGadget=NULL;     nww.CheckMark=NULL;
 nww.Title=title;          nww.Screen=scr;
 nww.BitMap=NULL;          nww.MinWidth=xlaenge/10;
 nww.MinHeight=ylaenge/10; nww.MaxWidth=scr->Width;
 nww.MaxHeight=scr->Height;
 if ((scr->Flags)&CUSTOMSCREEN) nww.Type=CUSTOMSCREEN;
 else nww.Type=WBENCHSCREEN;
 if (!(win=OpenWindow(&nww))) return (FALSE);
 return(win);
}

MasterRequest(win,htext,ltext,rtext)
struct Window *win;
UBYTE htext[],ltext[],rtext[];
{
 struct IntuiText ht,lt,rt;
 ht.FrontPen=0;  ht.BackPen=1;  ht.DrawMode=JAM1;
 ht.LeftEdge=10; ht.TopEdge=10; ht.ITextFont=NULL;
 ht.IText=htext; ht.NextText=NULL; 

 lt.FrontPen=0;  lt.BackPen=1;  lt.DrawMode=JAM1;
 lt.LeftEdge=5;  lt.TopEdge=3;  lt.ITextFont=NULL;
 lt.IText=ltext; lt.NextText=NULL;

 rt.FrontPen=0;  rt.BackPen=1;  rt.DrawMode=JAM1;
 rt.LeftEdge=5;  rt.TopEdge=3;  rt.ITextFont=NULL;
 rt.IText=rtext; rt.NextText=NULL;
 return (AutoRequest(win,&ht,&lt,&rt,0l,0l,(long)(10*strlen(htext)),70l));
}

AddMenu (win,title)
struct Window *win;
BYTE title[];
{
 struct Menu *menu,**wo;
 if (menubreite+10*strlen(title)+20>(win->WScreen->Width)) return(FALSE);
 if (!(menu=(struct Menu *) AllocMem((long)(sizeof(struct Menu)),
                     MEMF_CLEAR | MEMF_CHIP | MEMF_PUBLIC ))) return(FALSE);
 Forbid();
 menu->LeftEdge=menubreite;      menu->Width=10*strlen(title);
 menu->Height=10;                menu->Flags=1;
 menu->MenuName=title;
 menubreite+=10*strlen(title)+20;
 wo=&(win->MenuStrip);
 while (*wo!=NULL) wo= &((*wo)->NextMenu);
 *wo=menu;
 SetMenuStrip (win,win->MenuStrip);
 Permit();
 return(TRUE);
}

AddItem (win,menunummer,title,commseq)
struct Window *win;
short menunummer;
char title[],commseq;
{
 struct Menu *menu;
 struct MenuItem *mitem,**wo;
 struct IntuiText *itext;
 short count=0;
 menu=win->MenuStrip;
 while (menunummer--) { if (menu==NULL) return(FALSE); menu=menu->NextMenu; }
 if (menu==NULL) return(FALSE);
 if (!(mitem=(struct MenuItem *) AllocMem((long)(sizeof(struct MenuItem)),
                      MEMF_CLEAR | MEMF_CHIP | MEMF_PUBLIC ))) return(FALSE);
 if (!(itext=(struct IntuiText *) AllocMem((long)(sizeof(struct IntuiText)),
                      MEMF_CLEAR | MEMF_CHIP | MEMF_PUBLIC ))) return(FALSE);
 Forbid();
 wo=&(menu->FirstItem);
 if (!(*wo)) menu->FirstItem=mitem;
 else 
 { 
  count=1;
  while ((*wo)->NextItem) { count++; wo=&((*wo)->NextItem); }
  (*wo)->NextItem=mitem;
 }
 itext->BackPen=1;  itext->LeftEdge=5;   itext->TopEdge=3;
 itext->IText=(UBYTE *) title;
 mitem->LeftEdge=5;                mitem->TopEdge=count*13;
 mitem->Width=10*strlen(title)+30;  mitem->Height=12;
 mitem->Flags=ITEMTEXT | ITEMENABLED | HIGHBOX;
 if (commseq) mitem->Flags|=COMMSEQ;
 mitem->ItemFill=(APTR) itext;      mitem->Command=(BYTE) commseq;
 SetMenuStrip (win,win->MenuStrip);
 Permit();
 return(TRUE);
}
AddSubItem (win,menunummer,itemnummer,title,commseq)
struct Window *win;
short menunummer,itemnummer;
char title[],commseq;
{
 struct Menu *menu;
 struct MenuItem *mitem,*item,**wo;
 struct IntuiText *itext;
 short count=0;
 menu=win->MenuStrip;
 while (menunummer--) { if (menu==NULL) return(FALSE); menu=menu->NextMenu; }
 if (menu==NULL) return(FALSE);
 mitem=menu->FirstItem;
 while (itemnummer--) { if(mitem==NULL) return(FALSE); mitem=mitem->NextItem;}
 if (mitem==NULL) return(FALSE);
 if (!(item=(struct MenuItem *) AllocMem((long)(sizeof(struct MenuItem)),
                      MEMF_CLEAR | MEMF_CHIP | MEMF_PUBLIC ))) return(FALSE);
 if (!(itext=(struct IntuiText *) AllocMem((long)(sizeof(struct IntuiText)),
                      MEMF_CLEAR | MEMF_CHIP | MEMF_PUBLIC ))) return(FALSE);
 Forbid();
 mitem->Flags&=(~(HIGHBOX|COMMSEQ));
 wo=&(mitem->SubItem);
 if (!(*wo)) mitem->SubItem=item;
 else 
 { 
  count=1;
  while ((*wo)->NextItem) { count++; wo=&((*wo)->NextItem); }
  (*wo)->NextItem=item;
 }
 itext->BackPen=1;  itext->LeftEdge=5;   itext->TopEdge=3;
 itext->IText=(UBYTE *) title;
 item->LeftEdge=5+mitem->Width;   item->TopEdge=count*13;
 item->Width=10*strlen(title)+30;  item->Height=12;
 item->Flags=ITEMTEXT | ITEMENABLED | HIGHBOX;
 if (commseq) item->Flags|=COMMSEQ;
 item->ItemFill=(APTR) itext;      item->Command=(BYTE) commseq;
 SetMenuStrip (win,win->MenuStrip);
 Permit();
 return(TRUE);
}
ControlMenu (win,mn,in,sn,cflag,eflag)
struct Window *win;
short mn,in,sn,cflag,eflag;
{
 struct Menu *menu;
 struct MenuItem *item;
 menu=win->MenuStrip;
 while (mn--) { if (menu==NULL) return(FALSE); menu=menu->NextMenu; }
 if (menu==NULL) return(FALSE);
 if (in!=-1) 
 {
  item=menu->FirstItem;
  while (in--) { if(item==NULL) return(FALSE); item=item->NextItem;}
  if (item==NULL) return(FALSE);
  if (sn!=-1)
  {
   item=item->SubItem;
   while (sn--) { if(item==NULL) return(FALSE); item=item->NextItem;}
   if (item==NULL) return(FALSE);
  }
  if (eflag) item->Flags|=ITEMENABLED;
  else       item->Flags&=(~ITEMENABLED);
  if (cflag) item->Flags|=(CHECKED|CHECKIT);
  else       item->Flags&=(~(CHECKED|CHECKIT));
 }
 else menu->Flags=eflag;
 return (TRUE);
}
CloseMenu (win)
struct Window *win;
{
 struct MenuItem *item,*item1,*sitem,*sitem1;
 struct Menu *menu,*menu1;
 menu=win->MenuStrip;
 ClearMenuStrip(win);
 while (menu)
 {
  item=menu->FirstItem;
  while(item)
  {
   sitem=(item->SubItem);
   while (sitem)
   {
    sitem1=sitem;
    sitem=sitem->NextItem;
    FreeMem (sitem1,34l);
    FreeMem ((sitem1->ItemFill),20l);
   }
   item1=item;
   item=item->NextItem;
   FreeMem (item1,34l);
   FreeMem ((item1->ItemFill),20l);
  }
  menu1=menu;
  menu=menu->NextMenu;
  FreeMem (menu1,30l);
 }
} 
MasterSound (start,laenge,rate)
ULONG *start;
UWORD laenge,rate;
{
 USHORT *ctlw,*c0tl,*c0per,*c0vol;
 ULONG  *c0thi;
 c0thi = (ULONG  *) 0xdff0a0;
 c0tl  = (USHORT *) 0xdff0a4;
 c0per = (USHORT *) 0xdff0a6;
 c0vol = (USHORT *) 0xdff0a8;
 ctlw  = (USHORT *) 0xdff096;
 *ctlw =1;
 if (!(laenge)) return();
 *c0thi = (long) start;
 *c0tl  = laenge/2;
 *c0per = rate;
 *c0vol = 63;
 *ctlw  = 0x8201;
}

