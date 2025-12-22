/****************************************************************************

				Main Object of:
				-= Miga Mind =-
								1-5-90
								 Ekke
****************************************************************************/

#include <exec/types.h>
#include <intuition/intuition.h>
#include <graphics/gfxbase.h>
#include <graphics/gfxmacros.h>
#include <stdio.h>
#include <proto/all.h>
#include "Gads.h"
#include "MM_Proto.h"

#define VERSION 	"MigaMind v1.0\nEkke Verheul\n"
#define DATE 		"dd 1-5-'90\n"
#define IDCMP_FLAG 	MOUSEBUTTONS
#define WB_OUTFILE 	"CON:10/10/200/40/ MigaMind "
#define XPOS 		(Window->LeftEdge)
#define YPOS		(Window->TopEdge)
#define M_WIDTH		(Window->WScreen->Width - Window->Width)
#define M_HEIGHT	(Window->WScreen->Height - Window->Height)
#define SMX		(Window->WScreen->MouseX)
#define SMY		(Window->WScreen->MouseY)

struct  NewWindow 	NewWindow =	
	{ 271,20,98,153,-1,-1,IDCMP_FLAG,		
	SMART_REFRESH|BORDERLESS|RMBTRAP|ACTIVATE|REPORTMOUSE,
	NULL,NULL,NULL,NULL,NULL,-1,-1,-1,-1,WBENCHSCREEN };

struct GfxBase 		*GfxBase 	= NULL;
struct IntuitionBase 	*IntuitionBase 	= NULL;
struct Window		*Window		= NULL;

int CXBRK(void) {  return(0); }

/* only this: */
BYTE Value[46] ;


/*::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:::::::::::: void MAIN() :::::::::::::::::::::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::*/
void main(int argc,char **argv)
{
BOOL 	buzy = 2;
struct 	IntuiMessage *message ;
USHORT 	code,x,y;
ULONG 	class;
int 	fromwb = 0;
int 	lastsys = -1,turn,i;
int 	sel[2] = { -1,-1 };
int 	colors,positions,ready;
BYTE 	MMCode[4];

/* WORKBENCH ? */
	if (argc == 0) fromwb = 1;

/* VERSION */
	if ((argc > 1) && (*argv[1] == '?')) Nop("?",fromwb);

/* LIBRARIES:  */ 
	if ((IntuitionBase = (struct IntuitionBase *) OpenLibrary
				("intuition.library",0 )) == 0 )      
				Nop("intuition.library not found.",fromwb);
	if ((GfxBase = (struct GfxBase *)OpenLibrary
				("graphics.library",0)) == NULL)
				Nop("graphics.library not found.",fromwb);
/* WINDOW */
	if ((Window = OpenWindow (&NewWindow)) == NULL )
				Nop("Can't open Window.\n",fromwb);
	
/* LETS GET TO WORK */
	while(buzy)
	{   if (buzy == 2)	/* start (again) */
	    {   LayOut(Window->RPort);
		for (i=0; i<46; i++)
		{	if (i<6) Value[i] = i;
			else Value[i] = -1;
		}
		GetCode(MMCode);
		turn = 1;
		buzy = 1;
		ready = 0;
	    }
	    else if (buzy == 3) /* show hidden code */
	    {   if (CheckValue(turn))
		{   colors = WrightColor(turn,MMCode);
		    positions = WrightPosition(turn,MMCode);
		    PaintWright(Window->RPort,turn,colors,positions);
		    if (positions == 4 || ++turn > 10) 
		    {	ready = 1;
			DrawSysGad(Window->RPort,1,0,1);
			ShowAnswer(Window->RPort,MMCode);
			DisplayBeep(Window->WScreen);
		    }
		}
		buzy = 1;
	    }

	    Wait (1<<Window->UserPort->mp_SigBit);
            while (message= (struct IntuiMessage *)GetMsg(Window->UserPort)) 
    	    {	class = message->Class  ;
		code  =	message->Code   ;
                x     = message->MouseX ;
                y     = message->MouseY ;
        	ReplyMsg((struct Message *)message);

                switch(class)
                {   case MOUSEBUTTONS:
                    {   if (code == SELECTDOWN)
			{   if (y < 136 && ready == 0) 
			    {	HandleSD(Window->RPort,x,y,turn,sel);
			    }
			    else lastsys = HandleSysD(Window->RPort,x,y,ready);
			}
                        else if (code == SELECTUP)
			{   buzy = HandleSysU(Window->RPort,x,y,lastsys,ready);
			    lastsys = -1;
			}
                        else if (code == MENUDOWN)
		    	{   if ((x = SMX) > M_WIDTH) x = M_WIDTH;
			    if ((y = SMY) > M_HEIGHT) y = M_HEIGHT;
			    x -= XPOS;
			    y -= YPOS;
			    MoveWindow(Window,x,y);
			}
	}   }	}   }
	Nop(NULL,fromwb);
}/* end of main() */
		    /******************************************************
*******************/	/* close-all & err-mess */
void Nop(char *err,int fromwb)
{
FILE *outfile;

	if (Window) CloseWindow (Window);
	if (err && *err)
	{   if (fromwb) 
	    {	outfile = fopen(WB_OUTFILE,"r+");
	    }
	    else
	    {	outfile = fopen("*","r+");
	    }
	    if (NULL != outfile) 
	    {	if (*err == '?')
	    	{   fprintf(outfile, VERSION );
	            fprintf(outfile, DATE    );
	    	}
	    	else
	    	{   fprintf(outfile,"%s\n",err);
	    	}
	    	if (fromwb) Delay(300);
	    	fclose(outfile);
	    }
	}
	if (GfxBase)		CloseLibrary((struct Library *)GfxBase);
	if (IntuitionBase)	CloseLibrary((struct Library *)IntuitionBase);
	XCEXIT(0);
}

/********************************* SELECT-DOWN ****************************/
int HandleSD(struct RastPort *rp,WORD x,WORD y,int turn,int *sel)
{ 
int t,id;

	t = GetGadTurn(y);
	if (turn != -1) id = GetGadID(t,x);
	if (t == -1 || id == -1) return(0);

	if (t < turn) 
	{   if (sel[0] != -1)
	    {	DrawGad(rp,sel[0],sel[1],Value[GadNr(sel[0],sel[1])],0);
	    }
	    DrawGad(rp,t,id,Value[GadNr(t,id)],1);
	    sel[0] = t;
	    sel[1] = id;
	}
	else if (t == turn && sel[0] != -1)
	{   DrawGad(rp,sel[0],sel[1],Value[GadNr(sel[0],sel[1])],0);
	    DrawGad(rp,t,id,Value[GadNr(sel[0],sel[1])],0);
	    Value[GadNr(t,id)] = Value[GadNr(sel[0],sel[1])];
	    sel[0] = -1;
	}
	return(0); 
}

/********************************* SYSTEM-DOWN *****************************/
int HandleSysD(struct RastPort *rp,WORD x,WORD y,int w)
{ 
int id;

	id = GetSysID(x,y);
	if (id != -1) DrawSysGad(rp,id,1,w);
	return(id); 
}

/********************************* SYSTEM-UP *******************************/
int HandleSysU(struct RastPort *rp,WORD x,WORD y,int lastid,int w)
{
	if (lastid != -1) DrawSysGad(rp,lastid,0,w);
	if (lastid == GetSysID(x,y)) 
	{   switch(lastid)
	    {	case QUIT:
		{    return(0);
		}
		case SHOW:
		{   if (w) return(2);
		    else return(3);
}	}   }	}
/******************************** RANDOM ***********************************/
void GetCode(BYTE *r)
{
unsigned int clock[2];
int i,j,same;

	timer(clock);
	srand(clock[0]*clock[1]);
	for (i=0; i<4; i++)
	{   same = 1;
	    while (same)
	    {	r[i] = rand() % 6;
		same = 0;
		for (j=0; j<i; j++)
	    	{   if (r[i] == r[j])
		    {	same = 1;
	}   }	}   }
}
/***************************************************************************/
int CheckValue(int turn)
{
int i;
	for (i=0; i<4; i++) if (Value[GadNr(turn,i)] == -1) return(0);
	return(1);
}
/***************************************************************************/
int IsIn(BYTE a,BYTE *b)
{
int i;
	for (i=0; i<4; i++) if(b[i] == a) return(1);
	return(0);
}
/***************************************************************************/
int WrightColor(int turn,BYTE *c)
{
int i,j,tot = 0,used;

	for (i=0; i<4; i++) 
	{   /* for the @%! who used the same char twice... */
	    used = 0;
	    for (j=0; j<i; j++) 
	    {   if (Value[GadNr(turn,i)] == Value[GadNr(turn,j)]) 
	        {   used = 1;
	    }	}
	    if (!used)
	    {	if (IsIn(Value[GadNr(turn,i)],c))
	    	{   tot++;
	}   }	}   
	return(tot);

}
/***************************************************************************/
int WrightPosition(int turn,BYTE *c)
{
int i,tot = 0;
	for (i=0; i<4; i++) if (c[i] == Value[GadNr(turn,i)]) tot++;
	return(tot);
}
/***************************************************************************/
void ShowAnswer(struct RastPort *rp,BYTE *a)
{
int i;

	SetAPen(rp,0);
	RectFill(rp,6,4,91,12);
	for (i=1; i<5; i++) DrawGad(rp,0,i,a[i-1],1);
}








