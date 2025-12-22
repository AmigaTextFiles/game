#include <exec/types.h>
#include <libraries/dos.h>
#include <intuition/intuition.h>
#include <graphics/gfxmacros.h>

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;
struct DigitalBase *DigitalBase;
struct WindowsBase *WindowsBase;
struct Window *win;
struct RastPort *rp;
struct Screen *scr;
struct Gadget *moneyGadget,*ovGadget;
UBYTE *city;
UBYTE *name;
UBYTE *cash;
BOOL loaded,lowMem;
ULONG inLength;
struct IntuiMessage *msg;
struct Element
{
 UBYTE Farbe;
 UBYTE Code1;
 UBYTE Code2;
 UBYTE Pad;
} el;

VOID OpenAll();
VOID CloseAll();
VOID Speichern();
VOID Laden();
VOID Neu();
VOID DisplayCity();
VOID WaterToClean();
VOID CleanToWater();
VOID ParkToClean();
VOID CleanToPark();
VOID ParkToWater();
VOID WaterToPark();
BOOL Frage();
VOID ElementNeu();
VOID Information();

VOID main(argc,argv)
 LONG argc;
 UBYTE *argv[];
{
 REGISTER ULONG Class,id,menu,item;
 REGISTER BOOL bool,mouse;
 UWORD x,y;
 UWORD fx,fy;
 LONG pos,i;
 lowMem=FALSE;
 if(argc>1)
  {
   for(i=1;i<argc;i++)
    {
     if(!(strncmp(argv[i],"?",2)))
      {
       printf("\nSimCity Terrain-Editor Version 1.0\n");
       printf("==================================\n\n");
       printf("Argument   Funktion\n");
       printf("  ?        Hilfe zu Argumenten\n");
       printf("  -l       Geringerer Speicherbedarf,\n");
       printf("           einfachere Oberfläche\n\n");
       exit(0);
      }
     if(!(strncmp(argv[i],"-l",2))) lowMem=TRUE;
     if(!(strncmp(argv[i],"-L",2))) lowMem=TRUE;
    }
  }
 OpenAll(lowMem);
 mouse=FALSE;
 for(;;)
  {
   msg=WaitMessage(win);
   Class=msg->Class;
   switch(Class)
    {
     case CLOSEWINDOW:
      if((Frage("Programm beenden?",NULL,"Ende","Zurück")))
       {
        CloseAll();
       }
      break;
     case MOUSEBUTTONS:
       if(loaded==TRUE)
        {
         if(mouse==FALSE)
          {
           mouse=TRUE;
           x=GetMouseX(msg);
           y=GetMouseY(msg);
           if( (x>20) && (x<501) && (y>15) && (y<215) )
            {
             fx=(x-21)/4;
             fy=(y-16)/2;
             pos=(((fx*100)+fy)*2)+3248;
             bool=FALSE;
             if(ovGadget->Flags & SELECTED)
              {
               bool=TRUE;
               goto drawIt;
              }
             if(city[pos]==0)
              {
               if((city[pos+1]==0)||(city[pos+1]==2)||(city[pos+1]==4))
                {
                 bool=TRUE; goto drawIt;
                }
              }
             if(city[pos]==16)
              {
               if((city[pos+1]>39)||(city[pos+1]<44))
                {
                 bool=TRUE; goto drawIt;
                }
              }
             if((city[pos]==59)&&(city[pos+1]==72))
              {
               bool=TRUE; goto drawIt;
              }
drawIt:
             if(bool==TRUE)
              {
               SetAPen(rp,el.Farbe);
               city[pos]=el.Code1;
               city[pos+1]=el.Code2;
               RectFill(rp,(fx*4)+21,(fy*2)+16,(fx*4)+24,(fy*2)+17);
              }
             else
              {
               DisplayBeep(scr);
              }
            }
          }
         else
          {
           mouse=FALSE;
          }
        }
      break;
     case MOUSEMOVE:
       if((loaded==TRUE)&&(mouse==TRUE))
        {
         x=GetMouseX(msg);
         y=GetMouseY(msg);
         if( (x>20) && (x<501) && (y>15) && (y<215) )
          {
           fx=(x-21)/4;
           fy=(y-16)/2;
           pos=(((fx*100)+fy)*2)+3248;
           bool=FALSE;
           if(ovGadget->Flags & SELECTED)
            {
             bool=TRUE;
             goto displayIt;
            }
           if(city[pos]==0)
            {
             if((city[pos+1]==0)||(city[pos+1]==2)||(city[pos+1]==4))
              {
               bool=TRUE; goto displayIt;
              }
            }
           if(city[pos]==16)
            {
             if((city[pos+1]>39)||(city[pos+1]<44))
              {
               bool=TRUE; goto displayIt;
              }
            }
           if((city[pos]==59)&&(city[pos+1]==72))
            {
             bool=TRUE; goto displayIt;
            }
displayIt:
           if(bool==TRUE)
            {
             SetAPen(rp,el.Farbe);
             city[pos]=el.Code1;
             city[pos+1]=el.Code2;
             RectFill(rp,(fx*4)+21,(fy*2)+16,(fx*4)+24,(fy*2)+17);
            }
           else
            {
             DisplayBeep(scr);
            }
          }
        }
      break;
     case MENUPICK:
       menu=GetMenuNum(msg);
       item=GetItemNum(msg);
       switch(menu)
        {
         case 0:
           switch(item)
            {
             case 5:
               if((Frage("Umwandlung:","Wasser in Freifläche","Okay","Abbruch")))
                {
                 WaterToClean();
                }
              break;
             case 4:
               if((Frage("Umwandlung:","Freifläche in Wasser","Okay","Abbruch")))
                {
                 CleanToWater();
                }
              break;
             case 3:
               if((Frage("Umwandlung:","Park in Freifläche","Okay","Abbruch")))
                {
                 ParkToClean();
                }
              break;
             case 2:
               if((Frage("Umwandlung:","Freifläche in Park","Okay","Abbruch")))
                {
                 CleanToPark();
                }
              break;
             case 1:
               if((Frage("Umwandlung:","Park in Wasser","Okay","Abbruch")))
                {
                 ParkToWater();
                }
              break;
             case 0:
               if((Frage("Umwandlung:","Wasser in Park","Okay","Abbruch")))
                {
                 WaterToPark();
                }
              break;
            }
          break;
         case 1:
           switch(item)
            {
             case 0:
               if((Frage("Programm beenden?",0L,"Ende","Zurück")))
                {
                 CloseAll();
                }
              break;
             case 1:
               Information();
              break;
             case 2:
               Speichern();
              break;
             case 3:
               Laden();
              break;
             case 4:
               Neu();
              break;
            }   
          break;
        }
      break;
     case GADGETUP:
       id=GetGadgetID(msg);
       switch(id)
        {
         case 1:
           Neu();
          break;
         case 2:
           Laden();
          break;
         case 3:
           Speichern();
          break;
         case 20:
           if(loaded==FALSE) { Laden(); }
          break;
         default:
           if((id>=4)&&(id<=9)) ElementNeu(id);
          break;
        }
     default:
      break;
    }
  }
}

VOID Information()
{
 struct Window *w;
 ULONG i;
 UBYTE str[40];
 i=WINDOWCLOSE|ACTIVATE;
 if(!lowMem) i+=WINDOWDRAG;
 w=CreateWindow(scr,90,48,420,160,VANILLAKEY|CLOSEWINDOW,i,"Information");
 if(w!=NULL)
  {
   i=CreateConUnit(w);
   if(i==0)
    {
     ConWrite(w,"Sim City Terrain Editor Version 1.0\n");
     ConWrite(w,"Copyright (C) 1992 by T. Dreibholz\n\n");
     sprintf(&str,"Freier Chip-Speicher: %4ld KBytes\n",AskChipMem()/1024);
     ConWrite(w,&str);
     sprintf(&str,"Freier Fast-Speicher: %4ld KBytes\n",AskFastMem()/1024);
     ConWrite(w,&str);
     sprintf(&str,"Gesamt:               %4ld KBytes\n\n",AskMemory()/1024);
     ConWrite(w,&str);
     ConWrite(w,"Dieses Programm wird unter dem Shareware-Konzept\n");
     ConWrite(w,"vertrieben, d. h., daß bei öfterem Gebrauch eine\n");
     ConWrite(w,"Benutzungsgebühr von DM 10.00 an den Autor zu Ent-\n");
     ConWrite(w,"richten ist.\n");
     ConWrite(w,"\n");
     ConWrite(w,"Thomas Dreibholz\n");
     ConWrite(w,"Molbachweg 7\n");
     ConWrite(w,"D-5276 Wiehl 2\n\n");
     i=WaitMessage(w);
    }
   DeleteWindow(w);
  }
}

VOID ElementNeu(num)
 LONG num;
{
 UBYTE *ename="";
 LONG left;
 switch(num)
  {
   case 4:
     ename="Wasser";
     el.Farbe=4;
     el.Code1=0;
     el.Code2=2;
    break;
   case 5:
     ename="Freifläche";
     el.Farbe=1;
     el.Code1=0;
     el.Code2=0;
    break;
   case 6:
     ename="Unplaniert";
     el.Farbe=2;
     el.Code1=16;
     el.Code2=44;
    break;
   case 7:
     ename="Park";
     el.Farbe=5;
     el.Code1=16;
     el.Code2=43;
    break;
   case 8:
     ename="Springbrunnen";
     el.Farbe=3;
     el.Code1=59;
     el.Code2=72;
    break;
   case 9:
     ename="Schiffslinie";
     el.Farbe=7;
     el.Code1=0;
     el.Code2=4;
    break;
  }
 SetAPen(rp,0);
 RectFill(rp,508,178,624,198);
 left=510+((120-TextLength(rp,ename,strlen(ename)))/2);
 PrintShadowText(win,ename,left,190,2,2);
}

BOOL Frage(a,b,ja,nein)
 UBYTE *a,*b,*ja,*nein;
{
 ULONG i;
 struct Window *w;
 struct IntuiMessage *m;
 if(lowMem) i=ACTIVATE; else i=WINDOWDRAG|WINDOWCLOSE|ACTIVATE;
 w=CreateWindow(scr,145,98,350,60,CLOSEWINDOW|VANILLAKEY|INACTIVEWINDOW|GADGETUP,i,"Requester");
 if(w==NULL) return(FALSE);
 if(!lowMem) i=CreatePenTable(w,1,0,1,2); else i=CreatePenTable(w,1,0,1,1);
 if(a) PrintShadowText(w,a,20,20,2,2);
 if(b) PrintShadowText(w,b,20,32,2,2);
 if(ja!=NULL) i=CreateBoolGadget(w,20,42,80,12,0L,RELVERIFY|GADGIMMEDIATE,
                                 ja,1);
 if(nein!=NULL) i=i+CreateBoolGadget(w,250,42,80,12,0L,RELVERIFY|GADGIMMEDIATE,
                                     nein,2);
 if(i==0)
  {
   i=0;
   while(i==0)
    {
     m=WaitMessage(w);
     switch(m->Class)
      {
       case GADGETUP:
         i=1;
        break;
       case VANILLAKEY:
       case CLOSEWINDOW:
         DeleteWindow(w);
         return(FALSE);
        break;
       default:
         WindowToFront(w);
         ActivateWindow(w);
        break;
      }
    }
   i=GetGadgetID(m);
   DeleteWindow(w);
   if(i==1) return(TRUE); else return(FALSE);
  }
 return(FALSE);
}

VOID Speichern()
{
 ULONG *lfeld;
 BOOL bool;
 struct FileHandle *fh;
 struct FileLock *lock;
 if(loaded==TRUE)
  {
   lock=Lock(name,ACCESS_READ);
   if(lock!=NULL)
    {
     UnLock(lock);
     bool=Frage("Eine Datei mit diesem Namen","existiert bereits!","Weiter","Abbruch");
     if(bool==FALSE) return;
    }
   fh=Open(name,MODE_NEWFILE);
   if(fh!=NULL)
    {
     lfeld=(ULONG *)city;
     lfeld[777]=atol(cash);
     Write(fh,city,inLength);
     Close(fh);
    }
   else
    {
     bool=Frage("Fehler beim Schreiben!",NULL,"Abbruch",NULL);
    }
  }
 else
  {
   bool=Frage("Es wurde noch kein Terrain","bearbeitet.","Abbruch",0L);
  }
}

VOID Neu()
{
 BOOL bool;
 ULONG *lfeld;
 REGISTER LONG i;
 if(loaded==TRUE)
  {
   bool=Frage("Terrain löschen?",NULL,"Okay","Zurück");
   if(bool==TRUE)
    {
     lfeld=(ULONG *)city;
     for(i=0;i<10000;i++) lfeld[i]=NULL;
     SetAPen(rp,1);
     RectFill(rp,21,16,502,215);
    }
   else
    {
     DisplayBeep(scr);
    }
  }
 else
  {
   bool=Frage("Zum Löschen muß zuerst ein","Terrain geladen werden.","Abbruch",0L);
  }
}

VOID Laden()
{
 BOOL bool;
 ULONG *lfeld;
 REGISTER LONG i;
 REGISTER UWORD col;
 struct FileHandle *fh;
 loaded=TRUE;
 EnableMenu(win,0L,-1L,-1L);
 EnableMenu(win,1L,4L,-1L);
 EnableMenu(win,1L,2L,-1L);
 fh=Open(name,MODE_OLDFILE);
 if(fh!=NULL)
  {
   lfeld=(ULONG *)city;
   for(i=0;i<10000;i++) lfeld[i]=NULL;
   inLength=Read(fh,city,50000);
   Close(fh);
   sprintf(cash,"%ld",lfeld[777]);
   RefreshGadgets(moneyGadget,win,NULL);
   DisplayCity();
  }
 else
  {
   bool=Frage("Die Datei konnte nicht","geöffnet werden!","Abbruch",NULL); 
  }
}

VOID DisplayCity()
{
 REGISTER UWORD x,y,pos,col;
 pos=3248;
 SetAPen(rp,0);
 RectFill(rp,21,16,502,215);
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     col=6;
     if((city[pos]==0)&&(city[pos+1]==0))   { col=1; goto okay; }
     if((city[pos]==0)&&(city[pos+1]==2))   { col=4; goto okay; }
     if(city[pos]==16)
      {
       if((city[pos+1]>39)&&(city[pos+1]<44)) { col=5; goto okay; }
       }
     if((city[pos]==59)&&(city[pos+1]==72)) { col=3; goto okay; }
     if((city[pos]==0)&&(city[pos+1]==4))   { col=7; goto okay; }
     if((city[pos]==14)&&(city[pos+1]==44)) { col=2; goto okay; }
okay:
     SetAPen(rp,col);
     RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
     pos+=2;
    }
  }
}

VOID WaterToClean()
{
 REGISTER UWORD x,y,pos;
 pos=3248;
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     if((city[pos]==0)&&(city[pos+1]==2))
      {
       SetAPen(rp,1);
       city[pos+1]=0;
       RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
      }
      pos+=2;
    }
  }
}

VOID CleanToWater()
{
 REGISTER UWORD x,y,pos;
 pos=3248;
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     if((city[pos]==0)&&(city[pos+1]==0))
      {
       SetAPen(rp,4);
       city[pos+1]=2;
       RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
      }
      pos+=2;
    }
  }
}

VOID ParkToClean()
{
 REGISTER UWORD x,y,pos;
 REGISTER UBYTE paint;
 pos=3248;
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     paint=0;
     if((city[pos]==16)&&(city[pos+1]==43)) { paint=1; }
     if((city[pos]==16)&&(city[pos+1]==42)) { paint=1; }
     if((city[pos]==16)&&(city[pos+1]==41)) { paint=1; }
     if((city[pos]==16)&&(city[pos+1]==40)) { paint=1; }
     if((city[pos]==59)&&(city[pos+1]==72)) { paint=1; }
     if(paint==1)
      {
       SetAPen(rp,1);
       city[pos]=0;
       city[pos+1]=0;
       RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
      }
      pos+=2;
    }
  }
}

VOID CleanToPark()
{
 REGISTER UWORD x,y,pos;
 pos=3248;
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     if((city[pos]==0)&&(city[pos+1]==0))
      {
       SetAPen(rp,5);
       city[pos]=16;
       city[pos+1]=43;
       RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
      }
      pos+=2;
    }
  }
}

VOID ParkToWater()
{
 REGISTER UWORD x,y,pos;
 REGISTER UBYTE paint;
 pos=3248;
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     paint=0;
     if((city[pos]==16)&&(city[pos+1]==43)) { paint=1; }
     if((city[pos]==16)&&(city[pos+1]==42)) { paint=1; }
     if((city[pos]==16)&&(city[pos+1]==41)) { paint=1; }
     if((city[pos]==16)&&(city[pos+1]==40)) { paint=1; }
     if((city[pos]==59)&&(city[pos+1]==72)) { paint=1; }
     if(paint==1)
      {
       SetAPen(rp,4);
       city[pos]=0;
       city[pos+1]=2;
       RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
      }
      pos+=2;
    }
  }
}

VOID WaterToPark()
{
 REGISTER UWORD x,y,pos;
 pos=3248;
 for(x=0;x<120;x++)
  {
   for(y=0;y<100;y++)
    {
     if((city[pos]==0)&&(city[pos+1]==2))
      {
       SetAPen(rp,5);
       city[pos]=16;
       city[pos+1]=43;
       RectFill(rp,(x*4)+21,(y*2)+16,(x*4)+24,(y*2)+17);
      }
      pos+=2;
    }
  }
}

VOID OpenAll(lowMem)
 BOOL lowMem;
{
 ULONG i;
 struct Gadget *gad;
 struct StringInfo *si;
 IntuitionBase=OpenLibrary("intuition.library",0L);
 GfxBase=OpenLibrary("graphics.library",0L);
 DigitalBase=OpenLibrary("digital.library",0L);
 WindowsBase=OpenLibrary("windows.library",0L);
 if(DigitalBase==NULL)
  {
   printf("FEHLER #01: Digital-Library nicht verfügbar.\n");
   CloseAll();
  }
 if(WindowsBase==NULL)
  {
   printf("FEHLER #02: Windows-Library nicht verfügbar.\n");
   CloseAll();
  }
 city=AllocRMemory(28000);
 if(city==NULL)
  {
   printf("Fehler #03: Nicht genug Speicher für I/O.\n");
   CloseAll();
  }
 scr=CreateScreen(640,256,3,HIRES,CUSTOMSCREEN,NULL);
 if(scr==NULL)
  {
   printf("Fehler #04: Nicht genug Speicher für Bildschirm.\n");
   CloseAll();
  }
 win=CreateWindow(scr,0,0,640,256,MOUSEBUTTONS|MOUSEMOVE|CLOSEWINDOW|GADGETUP|MENUPICK,
                  WINDOWCLOSE|WINDOWDRAG|ACTIVATE|REPORTMOUSE,
                  "Sim City Terrain Editor - Copyright (C) 1992 by T. Dreibholz");
 if(win==NULL)
  {
   printf("Fehler #05: Nicht genug Speicher für Fenster.\n");
   CloseAll();
  }
 if(lowMem)
  {
   i=CreatePenTable(win,1,0,1,1);
  }
 else
  {
   i=CreatePenTable(win,1,0,1,2);
  }
 i+=CreateMenu(win,5,150,"Datei");
 i+=CreateItem(win,5,0,150,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Neu",'N');
 i+=CreateItem(win,5,10,150,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Laden",'L');
 i+=CreateItem(win,5,20,150,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Speichern",'S');
 i+=CreateItem(win,5,32,150,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Information",'I');
 i+=CreateItem(win,5,44,150,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Ende",'Q');
 i+=CreateMenu(win,160,210,"Umwandlungen");
 i+=CreateItem(win,5,0,210,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Wasser in Freifläche",'1');
 i+=CreateItem(win,5,10,210,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Freifläche in Wasser",'2');
 i+=CreateItem(win,5,22,210,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Park in Freifläche",'3');
 i+=CreateItem(win,5,32,210,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Freifläche in Park",'4');
 i+=CreateItem(win,5,44,210,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Park in Wasser",'5');
 i+=CreateItem(win,5,54,210,10,ITEMTEXT|HIGHCOMP|ITEMENABLED|COMMSEQ,"Wasser in Park",'6');
 DisplayMenu(win);
 DisableMenu(win,0L,-1L,-1L);
 DisableMenu(win,1L,4L,-1L);
 DisableMenu(win,1L,2L,-1L);
 rp=win->RPort;
 if(lowMem)
  {
   SetColor(win,0,0,2,15);
  }
 else
  {
   SetColor(win,0,7,7,7);
  }
 SetColor(win,1,15,15,15);  /* Clean    */
 SetColor(win,2,0,0,0);     /* Rubble   */
 SetColor(win,3,0,15,0);    /* Fountain */
 SetColor(win,4,0,0,10);    /* Water    */
 SetColor(win,5,0,10,0);    /* Park     */
 SetColor(win,6,10,10,10);  /* Used     */
 SetColor(win,7,0,0,15);    /* Ship     */
 if(!lowMem)
  {
   PositiveBorder(win,20,15,482,201);
   PositiveBorder(win,506,15,128,201);
   PositiveBorder(win,20,220,614,30);
  }
 i+=CreateBoolGadget(win,510,20,120,12,0,RELVERIFY|GADGIMMEDIATE,"Neu",1);
 i+=CreateBoolGadget(win,510,35,120,12,0,RELVERIFY|GADGIMMEDIATE,"Laden",2);
 i+=CreateBoolGadget(win,510,50,120,12,0,RELVERIFY|GADGIMMEDIATE,"Speichern",3);
 i+=CreateBoolGadget(win,510,90,120,12,0,RELVERIFY|GADGIMMEDIATE,"Wasser",4);
 i+=CreateBoolGadget(win,510,105,120,12,0,RELVERIFY|GADGIMMEDIATE,"Freifläche",5);
 i+=CreateBoolGadget(win,510,120,120,12,0,RELVERIFY|GADGIMMEDIATE,"Unplaniert",6);
 i+=CreateBoolGadget(win,510,135,120,12,0,RELVERIFY|GADGIMMEDIATE,"Park",7);
 i+=CreateBoolGadget(win,510,150,120,12,0,RELVERIFY|GADGIMMEDIATE,"Springbrunnen",8);
 i+=CreateBoolGadget(win,510,165,120,12,0,RELVERIFY|GADGIMMEDIATE,"Schiffslinie",9);
 i+=CreateBoolGadget(win,510,200,120,12,0,TOGGLESELECT|RELVERIFY|GADGIMMEDIATE,"Überschreiben",10);
 ovGadget=GetGadgetAddress(win);
 i+=CreateStringGadget(win,210,222,405,12,0,TOGGLESELECT|RELVERIFY|GADGIMMEDIATE,"DH0:Spiele/SimCity/Games/San Diego Plus",20);
 gad=GetGadgetAddress(win);
 si=gad->SpecialInfo;
 name=si->Buffer;
 i+=CreateStringGadget(win,210,236,405,12,0,LONGINT|TOGGLESELECT|RELVERIFY|GADGIMMEDIATE,"0",21);
 moneyGadget=GetGadgetAddress(win);
 si=moneyGadget->SpecialInfo;
 cash=si->Buffer;
 loaded=FALSE;
 if(i!=0)
  {
   printf("FEHLER #06: Nicht genug Speicher für Intuition-Elemente.\n");
   CloseAll();
  }
 PrintShadowText(win,"Name der Terraindatei:",30,230,2,2);
 PrintShadowText(win,"Aktueller Kontostand:",30,244,2,2);
 ElementNeu(5);
}

VOID CloseAll()
{
 if(win) DeleteWindow(win);
 if(scr) DeleteScreen(scr);
 if(WindowsBase) CloseLibrary(WindowsBase);
 if(DigitalBase)
  {
   FreeRMemory();
   CloseLibrary(DigitalBase);
  }
 CloseLibrary(IntuitionBase);
 CloseLibrary(GfxBase);
 exit(0);
}

