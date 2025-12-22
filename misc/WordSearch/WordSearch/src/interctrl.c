#include <exec/types.h>
#include <exec/libraries.h>
#include <math.h>
#include "wsearch.h"
#include "interface.h"
#include <proto/Req.h>

extern BOOL LWActive, DispKey;
extern char *file;
char copy[MAXSIZE+1] = "";

int LINK=0;

void UpdateDisplay()
{
	int i,top,bottom;
	
	if(rot<5)
	{
		top = ReadLocation(py,DPWin->Height/fontheight-3,yp.VertPot);
		bottom = top + DPWin->Height / fontheight;
		if(bottom>py) bottom = py;
	}
	else
	{
		top = ReadLocation(px,DPWin->Height/fontheight-3,yp.VertPot);
		bottom = top + DPWin->Height / fontheight;
		if(bottom>px) bottom = px;
	}
	if(bottom-top>=MAXROWS) bottom = top+MAXROWS-1;
	for(i=top;i<=bottom;i++)
		IText[i-top].IText = &Display(i,0);	
	for(i=bottom+1-top;i<MAXROWS;i++)
		IText[i].IText = " ";

	if(rot<5)
	          PrintIText(DPRP,IText,
                  -ReadLocation(px,DPWin->Width/fontwidth-3,xp.HorizPot)*fontwidth,0L);
	else
	          PrintIText(DPRP,IText,
                  -ReadLocation(py,DPWin->Width/fontwidth-3,xp.HorizPot)*fontwidth,0L);
}

void puzdisplay()
{
  BOOL fix_window;

  fix_window=FALSE;

      switch( Msg.Class )
      {
        case MOUSEMOVE:
               fix_window=TRUE;
               break;

        case NEWSIZE:
	       if(rot<5)
	       {
               	ModifyProp(&y,DPWin,NULL,yp.Flags,0,yp.VertPot,0,
                 (ULONG) SetSize(py,DPWin->Height/fontheight-3));
               	ModifyProp(&x,DPWin,NULL,xp.Flags,xp.HorizPot,0,
                 (ULONG) SetSize(px,DPWin->Width/fontwidth-3),0);
	       }
	       else
	       {
               	ModifyProp(&y,DPWin,NULL,yp.Flags,0,yp.VertPot,0,
                 (ULONG) SetSize(px,DPWin->Height/fontheight-3));
               	ModifyProp(&x,DPWin,NULL,xp.Flags,xp.HorizPot,0,
                 (ULONG) SetSize(py,DPWin->Width/fontwidth-3),0);
	       }
	       UpdateDisplay();
               break;

        case GADGETDOWN:
               fix_window=TRUE;
               break;

        case GADGETUP:
               fix_window=TRUE;
               break;

        case REFRESHWINDOW:
                BeginRefresh(DPWin);
		if(rot<5)
		          PrintIText(DPRP,IText,
                	  -ReadLocation(px,DPWin->Width/fontwidth-3,xp.HorizPot)*FONTWIDTH,0L);
		else
		          PrintIText(DPRP,IText,
                	  -ReadLocation(py,DPWin->Width/fontwidth-3,xp.HorizPot)*FONTWIDTH,0L);
                EndRefresh(DPWin,0);
                break;
      }

    if(fix_window)
    {
      fix_window=FALSE;

        SetDrMd(DPRP,JAM1);
        SetAPen(DPRP,0);
        RectFill(DPRP,0,0,DPWin->Width,DPWin->Height);
	UpdateDisplay();
    }
}

void wordlist()
{
BOOL fix_window;

int yoff,i;

   fix_window=FALSE;

     switch( Msg.Class )
      {
        case MOUSEMOVE:
               fix_window=TRUE;
	       LWActive = FALSE;
               break;

        case NEWSIZE:
               ModifyProp(&z,WLWin,NULL,zp.Flags,0,zp.VertPot,0,
                 (ULONG) SetSize(MAXWORD,WLWin->Height/(FONTHEIGHT+2)-3));
               RefreshGadgets(&Words[0],WLWin,0);
               break;

        case GADGETDOWN:
               if(((struct Gadget *)Msg.IAddress)->GadgetID == 0)
	       {
                    fix_window=TRUE;
		    LWActive = FALSE;
	       }	    
               else
	       {
                    LastWord = (struct Gadget *)Msg.IAddress;
	       	    LWActive = TRUE;
	       }
	       break;

        case GADGETUP:
               if(((struct Gadget *)Msg.IAddress)->GadgetID == 0)
	       {
                    fix_window=TRUE;
		    LWActive = FALSE;
	       }
	       else if(LastWord->NextGadget!=NULL)
                {
                    LastWord=LastWord->NextGadget;
                    ActivateGadget(LastWord,WLWin,NULL);
		    LWActive = TRUE;
                }
               break;

        case REFRESHWINDOW:
                BeginRefresh(WLWin);
                RefreshGadgets(&Words[0],WLWin,0);
                EndRefresh(WLWin,0);
                break;
      }

    if(fix_window)
    {
      fix_window=FALSE;
	yoff = ReadLocation(MAXWORD,WLWin->Height/(FONTHEIGHT+2)-3,zp.VertPot)*(FONTHEIGHT+2);
        for(i=0;i<MAXWORD;i++)
            Words[i].TopEdge = i*(FONTHEIGHT+2) - yoff;
        SetDrMd(WLRP,JAM1);
        SetAPen(WLRP,0);
        RectFill(WLRP,0,0,WLWin->Width,WLWin->Height);

        RefreshGadgets(&Words[0],WLWin,0);
    }
}

void menuctrl()
{
    USHORT menu_number;
    struct MenuItem *item;
    UBYTE m,mi,si;
    BOOL fix_puz,fix_list;
    int i,j;

        fix_puz = FALSE;
        fix_list = FALSE;

        menu_number = Msg.Code;

        while( menu_number != MENUNULL )
        {
          item = (struct MenuItem *) ItemAddress( TheMenu, menu_number );

          m = MENUNUM(menu_number);
          mi = ITEMNUM(menu_number);
          si = SUBNUM(menu_number);
          if(m==0 && mi==0)
           {
            file[0] = 0;
            for(i=0;i<MAXWORD;i++)
                word[i][0] = 0;
            NewKey();
            NewPuzzle();
            fix_puz = TRUE;
            fix_list = TRUE;
           }
          else if(m==0 && mi==1)
           {
            if(loadfile()==TRUE)
             {
                fix_puz = TRUE;
                fix_list = TRUE;
             }
           }
          else if(m==0 && mi==2)
            savefile();
          else if(m==0 && mi==3)
            saveasfile();
          else if(m==0 && mi==4 && si==0)
            printlist();
          else if(m==0 && mi==4 && si==1)
            printpuz();
          else if(m==1 && mi==1 && si==0)
           {
            NewKey();
            NewPuzzle();
            fix_puz = TRUE;
           }
          else if(m==1 && mi==0)
           {
            if(Dimensions()==TRUE)
            {
                NewKey();
                NewPuzzle();
                fix_puz = TRUE;
            }
           }
          else if(m==1 && mi==1 && si==1)
           {
            NewPuzzle();
            fix_puz = TRUE;
           }
	  else if(m==1 && mi==1 && si==2)
	  {
		LINK = (M1I1[2].Flags&CHECKED)/CHECKED;
	  }
	  else if(m==1 && mi==2)
           {
            filter = 0;
            for(i=0;i<8;i++)
                if((M1I2[i].Flags&CHECKED)!=0)
                    filter = filter|(1<<i);
            if(filter==0)
                filter = 255;
           }
          else if(m==2 && mi==0)
           {
            DispKey = TRUE;
            fix_puz = TRUE;
           }
          else if(m==2 && mi==1)
           {
            DispKey = FALSE;
            fix_puz = TRUE;
           }
          else if(m==2 && mi==2)
           {
            rot = 0;
            for(i = 0;i<8;i++)
                if((M2I2[i].Flags&CHECKED)!=0)
                    rot = i + 1;
            if(rot==0)
                rot = 1;
            fix_puz = TRUE;
           }
          else if(m==3 && mi==0 && LWActive==TRUE)
	  {
            strncpy(copy,((struct StringInfo *)LastWord->SpecialInfo)->Buffer,MAXSIZE+1);
	    fix_list = TRUE;
	  }
          else if(m==3 && mi==1 && LWActive==TRUE)
	   {
            strncpy(((struct StringInfo *)LastWord->SpecialInfo)->Buffer,copy,MAXSIZE+1);
	    fix_list = TRUE;
	   }
          else if(m==3 && mi==2 && LWActive==TRUE)
           {
            j=(((struct StringInfo *)LastWord->SpecialInfo)->Buffer-word[0])/(MAXSIZE+1);
            for(i=MAXWORD-2;i>=j;i--)
                strncpy(word[i+1],word[i],MAXSIZE+1);
            word[j][0]=0;
            fix_list = TRUE;
           }
          else if(m==3 && mi==3 && LWActive==TRUE)
           {
            i=(((struct StringInfo *)LastWord->SpecialInfo)->Buffer-word[0])/(MAXSIZE+1);
            for(;i<MAXWORD-1;i++)
                strncpy(word[i],word[i+1],MAXSIZE+1);
            word[MAXWORD-1][0] = 0;
            fix_list = TRUE;
           }
          else if(m==3 && mi==4)
	   {
            CleanUp();
	    fix_list = TRUE;
	   }
          else if(m==3 && mi==5)
	   {
            UpperCase();
	    fix_list = TRUE;
	   }
          else if(m==3 && mi==6)
	   {
            Sort();
	    fix_list = TRUE;
	   }

          if(fix_list)
           {
            fix_list=FALSE;
            Msg.Class = NEWSIZE;
            wordlist();
	    if(LWActive) ActivateGadget(LastWord,WLWin,NULL);
           }
          if(fix_puz)
           {
            fix_puz=FALSE;
            NewDisplay();
            Msg.Class = GADGETUP;/* instead of NEWSIZE so window cleared*/
            puzdisplay();
            Msg.Class = NEWSIZE;/* but forgot props might need adjusting*/
            puzdisplay();
           }
           menu_number = item->NextSelect;
        }
}
