/* IntuiMines ©1992 Jørgen K.	*/
/* This is v. 1.0 				*/

#include <stdio.h>
#include <intuition/intuition.h>
#include <libraries/dos.h>
#include <math.h>
#include <limits.h>
#include <proto/all.h>
#include "images.h"

#define HORIZ 30
#define VERT 15
#define TOTAL ((HORIZ+2)*(VERT+2))

/* Images: */
#define BLANK 40
#define FLAG 42
#define QMARK 43

/* Contents: */
#define NONE 44		/* no content, else a number or BOMBHERE */
#define BOMBHERE 45	/* ! */
#define BLOCKED 46	/* No content in the shadow-border of the matrix */


struct fieldstruct
	{
		char content;
		char image;
		char beenhere;
		char up;		/* Up or down? */
		int corrindex;	/* The corresponding index to the gadgets */
		int myindex;	/* It's own index */
	};

struct fieldstruct thematrix[TOTAL];

struct IntuitionBase *IntuitionBase = NULL;
struct IntuiMessage *AMessage = NULL;
struct NewWindow MyNewWindow =
	{
		2,
		10,
		632,
		242,								/* Placement & size	*/
		0,1,								/* Pens			*/
		CLOSEWINDOW|MOUSEBUTTONS|GADGETUP|
		INTUITICKS|REQCLEAR,				/* IDCMPFlags	*/
		WINDOWDEPTH|WINDOWCLOSE|WINDOWDRAG|
			SMART_REFRESH|RMBTRAP|ACTIVATE,	/* Flags	*/
		NULL,
		NULL,
		"IntuiMines v.1.0 ©1992 Jørgen K.\0",
		NULL,
		NULL,
		0,0,0,0,
		WBENCHSCREEN
	};

struct Window *TheWindow = NULL;

struct Gadget gadgets[450];

struct Gadget smile =
	{
		gadgets,		/* Link to the others */
		310,10,
		21,
		15,
		GADGIMAGE|GADGHIMAGE,
		GADGIMMEDIATE|RELVERIFY,
		BOOLGADGET,
		(APTR) &start1Image,
		(APTR) &start2Image,
		NULL,
		0,
		NULL,
		666,
		NULL
	};

char bombstext[3] = "99";
char bleft[] = "Bombs left:";
char tgone[] = "Time:";
char hitext[] = "Hi:";
char name[7] = "Tonje";
char hitime[4] = "999";
int hiscore = 999;
char time[] = "000";


struct IntuiText timestruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		time,
		NULL
	};
struct IntuiText histruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		hitext,
		NULL
	};
struct IntuiText namestruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		name,
		NULL
	};
struct IntuiText hitimestruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		hitime,
		NULL
	};
struct IntuiText bombstextstruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		bombstext,
		NULL
	};
struct IntuiText bleftstruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		bleft,
		NULL
	};
struct IntuiText timegstruct =
	{
		3,0,		/* colors */
		JAM2,
		0,0,		/* le & te */
		NULL,
		tgone,
		NULL
	};

int bombsleft,opened;	/* The flagcounter and the counter for how many */
						/* opened gadgets there are.					*/
int count;				/* A timecounter - until an interrupt routine is*/
						/* added. */
UBYTE namebuffer[8];	/* Buffer for the stringgadget.					*/

/* ********************************************************************** */

/* Here come the protos: */
void dohi(void);
void create_matrix(void);
int gimmearand(void);
void openblanks (int center);
void opencell (int index);
char between(int index);
void revealall(void);
void clearall(void);
void printtext(void);
void printtime(void);

/* ********************************************************************** */

void main(void)
{
	int done = FALSE,index,matindex;
	ULONG class;
	USHORT code;
	SHORT mousex,mousey;
	APTR iadr;
	char thecontent;
	struct RastPort *rastport;
	int mytime=10;		/* A simple timer */
	char stop = FALSE;	/* stop counting */

	create_matrix();

	/* Open a window: */
	IntuitionBase=(struct IntuitionBase *) OpenLibrary("intuition.library",1);

	if(IntuitionBase == NULL) {printf("no lib\n");exit(0);}

	TheWindow = OpenWindow(&MyNewWindow);
	if(TheWindow == NULL) {printf("no window\n");exit(0);}

	AddGList(TheWindow,&smile,0,-1,NULL);
	RefreshGList(&smile,TheWindow,NULL,-1);
	/* Draw the "borders": */
	rastport=TheWindow->RPort;
	DrawImage(rastport,&onblankImage,550,10);
	DrawImage(rastport,&timeframeImage,400,10);
	printtext();
	/* Print the texts: */
	PrintIText(rastport,&bleftstruct,460,13);
	PrintIText(rastport,&timegstruct,355,13);
	PrintIText(rastport,&histruct,30,13);
	PrintIText(rastport,&namestruct,100,13);
	PrintIText(rastport,&hitimestruct,60,13);
	printtime();

	/* The loop: */
	while (!done)
	{
		Wait(1L<<TheWindow->UserPort->mp_SigBit);
		while(AMessage=(struct IntuiMessage *) GetMsg(TheWindow->UserPort))
		{
			class = AMessage->Class;
			code = AMessage->Code;
			mousex = AMessage->MouseX;
			mousey = AMessage->MouseY;
			iadr = AMessage->IAddress;

			ReplyMsg((struct Message *)AMessage);
			if(class == CLOSEWINDOW)
			{
				/* Do NOT close the window here! */
				done = TRUE;
			}

			if((class == INTUITICKS)&&(!stop))
			{
				if(!(--mytime))
				{
					mytime=10;
					if(count<999)
					{
						count++;
						printtime();
					}
				}
			}

			if((class == MOUSEBUTTONS)&&(code == MENUUP)&&(mousey>30)&&
				(mousey<240)&&(mousex>0)&&(mousex<630))
			{
				/* We gotta do some calculus... */
				mousey-=31;
				index=(mousex/21)+((mousey/14)*30);

				if((((struct fieldstruct*)gadgets[index].UserData)->image
					== BLANK)&&(bombsleft))
				{
					gadgets[index].GadgetRender=(APTR) &flagImage;
					((struct fieldstruct*)gadgets[index].UserData)->image
						= FLAG;

					bombsleft--;
					printtext();
					
				}
				else
				{
					if(((struct fieldstruct*)gadgets[index].UserData)->image
						== FLAG)
					{
						gadgets[index].GadgetRender=(APTR) &qmarkImage;
						((struct fieldstruct*)gadgets[index].UserData)->image
							= QMARK;
						bombsleft++;
						printtext();
					}
					else
					{
						gadgets[index].GadgetRender=(APTR) &offblankImage;
						((struct fieldstruct*)gadgets[index].UserData)->image
							= BLANK;
					}
				}
				RefreshGList(&gadgets[index],TheWindow,NULL,1);
			}

			if(class == GADGETUP)
			{
				if(((struct Gadget *) iadr)->GadgetID == 666)
				{
					/* Restart */
					clearall();
					stop = FALSE;
					RefreshGList(gadgets,TheWindow,NULL,-1);
					printtext();
				}
				else
				{
					/* An ordinary gadget */
					index = ((struct Gadget *) iadr)->GadgetID;

					thecontent=((struct fieldstruct*)gadgets[index].UserData)
						->content;
					matindex=((struct fieldstruct*)gadgets[index].UserData)
						->myindex;

					if( ((struct fieldstruct*)gadgets[index].UserData)
						->image == FLAG)
					{
						/* Update the flagcounter */
						bombsleft++;
						((struct fieldstruct*)gadgets[index].UserData)->image
							= BLANK;
						printtext();
					}

					if(thecontent == BOMBHERE)
					{
						/* Game over */
						stop = TRUE;
						revealall();
					}

					if(thecontent == NONE) openblanks(matindex);
					else
					{
						if(!thematrix[matindex].beenhere)
						{
							opened--;
							thematrix[matindex].beenhere=TRUE;
						}
					}

					if(!opened)
					{
						/* You have won! */
						stop = TRUE;
						revealall();
						if(count <= hiscore)
						{
							/* I do believe we've got a hiscore */
							/* Open the requester: */
							dohi();
							/* Go until we receive a REQCLEAR... */
							hiscore=count;
						}
					}
				}
			}/* gadgetup */

			if(class == REQCLEAR)
			{
				/* Name typed in (don't bother with other reqs... erm) */
				sprintf(name,"%s",namebuffer);
				PrintIText(rastport,&namestruct,100,13);
				if(hiscore<10)
					sprintf(hitime,"00%d\0",hiscore);
				else
					if(hiscore<100)
						sprintf(hitime,"0%d\0",hiscore);
					else
						sprintf(hitime,"%d\0",hiscore);

				PrintIText(rastport,&hitimestruct,60,13);
			}

		}/* while */
	}/* while !done */
	CloseWindow(TheWindow);
	CloseLibrary((struct Library *)IntuitionBase);
}

/* ********************************************************************** */

void dohi(void)
{
	/* Make'em static because otherwise they would be on the stack; */
	/* pointer problems! 											*/

	static char hiscoretxt[] = "Hiscore! Please type your name:";

	static struct IntuiText thetext =
		{
			3,1,		/* colors */
			JAM2,
			5,3,		/* le & te */
			NULL,
			hiscoretxt,
			NULL
		};

	static struct StringInfo string =
		{
			namebuffer,
			NULL,
			0,
			8,
			0,
			0,0,0,0,0,0,0,NULL
		};

	static SHORT vector1[] =
		{
			0,0,
			0,39,
			259,39,
			259,0,
			0,0
		};

	static SHORT vector2[] =
		{
			0,0,
			0,12,
			72,12,
			72,0,
			0,0
		};

	static struct Border border2=
		{
			79,24,
			3,3,JAM1,
			5,
			vector2,
			NULL
		};

	static struct Border border =
		{
			0,0,
			3,3,JAM1,
			5,
			vector1,
			&border2
		};

	static struct Gadget txtinput =
		{
			NULL,
			80,25,
			70,10,
			GADGHCOMP|SELECTED,
			ENDGADGET|STRINGCENTER,
			STRGADGET|REQGADGET,
			NULL,NULL,
			NULL,
			0L,
			(APTR) &string,
			777,
			NULL
		};

	static struct Requester hinamereq =
		{
			NULL,
			50,50,260,40,
			0,0,
			&txtinput,
			&border,
			&thetext,
			NULL,
			0,
			NULL,
			{NULL},
			NULL,
			NULL,
			{NULL},
		};

	sprintf(namebuffer,"%s",name);
	Request(&hinamereq,TheWindow);
}

/* ********************************************************************** */

void printtext(void)
{
	/* Prints # bombs left */

	struct RastPort *rastport;

	rastport = TheWindow->RPort;

	bombstext[0]=(bombsleft/10)+'0';
	bombstext[1]=bombsleft-((bombsleft/10)*10)+'0';
	PrintIText(rastport,&bombstextstruct,553,13);
}

/* ********************************************************************** */

void printtime(void)
{
	time[0]=(count/100)+'0';
	time[1]=(count-((count/100)*100))/10+'0';
	time[2]=count-((count/100)*100);
	time[2]=time[2]-((time[2]/10)*10)+'0';

	PrintIText(TheWindow->RPort,&timestruct,403,13);
}

/* ********************************************************************* */

void revealall(void)
{
	int x;
	USHORT flags;

	for(x=0;x<450;x++)
	{
		if((((struct fieldstruct*)gadgets[x].UserData)->image == FLAG) && 
			(((struct fieldstruct*)gadgets[x].UserData)->content != BOMBHERE))
			gadgets[x].SelectRender= (APTR) &bombcrossImage;

		flags=gadgets[x].Flags;
		gadgets[x].Flags=flags|SELECTED;
		RefreshGList(&gadgets[x],TheWindow,NULL,1);
	}
	/* Why not possible to refresh the whole list in one operation?? */
}

/* ********************************************************************** */

char between (int index)
{
	if((thematrix[index].content > 0) && (thematrix[index].content < 9))
		return (TRUE);
	else
		return (FALSE);
}

/* ********************************************************************* */

void opencell(int index)
{
	USHORT flags;

	if(!thematrix[index].beenhere)
	{
		opened--;	/* ! */
		thematrix[index].beenhere = TRUE;

		if(thematrix[index].image == FLAG)
		{
			bombsleft++;
			printtext();
		}
	}

	flags=gadgets[thematrix[index].corrindex].Flags;
	gadgets[thematrix[index].corrindex].Flags=flags|SELECTED;
	RefreshGList(&gadgets[thematrix[index].corrindex],TheWindow,NULL,1);
	thematrix[index].up=FALSE;
}

/* ******************************************************************** */

void openblanks(int center)
{
	if((center > TOTAL) || (center < 0)) return;

	if(thematrix[center].content == BOMBHERE) return;

	/* Take care not to crash: */
	if(thematrix[center].corrindex != -1)
	{
		/* Make the gadget selected... */
		opencell(center);
	}

	/* A number */
	if((thematrix[center].content>0) && (thematrix[center].content<9)) return;

	/* We have a blank; check for special case: */
	if( between(center-1) && between(center+32) &&
		between(center+31))
		opencell(center+31);

	if( between(center-1) && between(center-32) &&
		between(center-33))
		opencell(center-33);

	if( between(center+1) && between(center-32) &&
		between(center-31))
		opencell(center-31);

	if( between(center+1) && between(center+32) &&
		between(center+33))
		opencell(center+33);


	/* Blank */
	if((thematrix[center-32].up) && (thematrix[center-32].content != BLOCKED))
		openblanks(center-32);
	if((thematrix[center-1].up) && (thematrix[center-1].content != BLOCKED))
		openblanks(center-1);
	if((thematrix[center+1].up) && (thematrix[center+1].content != BLOCKED))
		openblanks(center+1);
	if((thematrix[center+32].up) && (thematrix[center+32].content != BLOCKED))
		openblanks(center+32);
}

/* ************************************************************************ */

int gimmearand(void)
{
	/* Supposed to return a number (an index) */
	
	return((int)(drand48()*TOTAL));
}

/* ************************************************************************ */

void clearall(void)
{
	int x,y,bombs,center;


	for(x=0;x<TOTAL;x++)
	{
		thematrix[x].image=BLANK;
		thematrix[x].content=NONE;
		thematrix[x].up=TRUE;
		thematrix[x].beenhere=FALSE;
	}

	/* Block the "extra cells" out: */
	for(x=0;x<HORIZ+2;x++)
	{
		thematrix[x].content=BLOCKED;
		thematrix[x+((VERT+1)*32)].content=BLOCKED;
	}
	for(x=0;x<VERT+2;x++)
	{
		thematrix[x*32].content=BLOCKED;
		thematrix[(x*32)+31].content=BLOCKED;
	}

	/* Place the bombs: */
	for(x=0;x<99;x++)
	{
		y=gimmearand();
		while(thematrix[y].content==BOMBHERE||
			thematrix[y].content==BLOCKED)
			y=gimmearand();

		thematrix[y].content=BOMBHERE;
	}

	for(x=0;x<450;x++)
	{
		gadgets[x].Flags=(GADGIMAGE|GADGHIMAGE)&(~SELECTED);
		gadgets[x].GadgetRender=(APTR) &offblankImage;
		if(((struct fieldstruct*)gadgets[x].UserData)->content
			!= BOMBHERE)
			gadgets[x].SelectRender=(APTR) &onblankImage;
		else
			gadgets[x].SelectRender=(APTR) &bombImage;
	}

	/* Go thru the motions with counting the bombs: */
	for(x=0;x<450;x++)
	{
		center=((struct fieldstruct*)gadgets[x].UserData)->myindex;
		if(thematrix[center].content != BOMBHERE)
		{
			bombs=0;
			if(thematrix[center-33].content==BOMBHERE) bombs++;
			if(thematrix[center-32].content==BOMBHERE) bombs++;
			if(thematrix[center-31].content==BOMBHERE) bombs++;
			if(thematrix[center-1].content==BOMBHERE) bombs++;
			if(thematrix[center+1].content==BOMBHERE) bombs++;
			if(thematrix[center+31].content==BOMBHERE) bombs++;
			if(thematrix[center+32].content==BOMBHERE) bombs++;
			if(thematrix[center+33].content==BOMBHERE) bombs++;

			if(bombs) thematrix[center].content=bombs;

			switch(bombs)
			{
				case 1:	gadgets[x].SelectRender=(APTR) &nroneImage;
						break;
				case 2:	gadgets[x].SelectRender=(APTR) &nrtwoImage;
						break;
				case 3:	gadgets[x].SelectRender=(APTR) &nrthreeImage;
						break;
				case 4:	gadgets[x].SelectRender=(APTR) &nrfourImage;
						break;
				case 5:	gadgets[x].SelectRender=(APTR) &nrfiveImage;
						break;
				case 6:	gadgets[x].SelectRender=(APTR) &nrsixImage;
						break;
				case 7:	gadgets[x].SelectRender=(APTR) &nrsevenImage;
						break;
				case 8:	gadgets[x].SelectRender=(APTR) &nreightImage;
						break;
			}/* case */
		}/* if */
	}/* for */

	bombsleft = 99;
	opened = 450-99;
	count = 0;
}

/* ************************************************************************ */

void create_matrix(void)
{
	int x,y,z;

	/* Initialize: */
	for(x=0;x<TOTAL;x++)
	{
		thematrix[x].corrindex=-1;
		thematrix[x].myindex=x;
	}

	/* Set the corrindex: */
	z=0;
	for(x=33;x<=481;x+=32)
		for(y=0;y<30;y++)
		{
			/* Linking the suckers together: */
			thematrix[y+x].corrindex=z;
			gadgets[z].UserData=(APTR)&thematrix[y+x];
			z++;
		}

	clearall();	/* ...and place the bombs */

	/* Set up the gadgets: */
	for(x=0;x<450;x++)
	{
		gadgets[x].NextGadget=&gadgets[x+1];
		gadgets[x].LeftEdge=((x-(30*(x/30)))*21)+1;
		gadgets[x].TopEdge=((x/30)*14)+30;
		gadgets[x].Width=21;
		gadgets[x].Height=15;

		gadgets[x].Activation=TOGGLESELECT|RELVERIFY;
		gadgets[x].GadgetType=BOOLGADGET;

		gadgets[x].GadgetText=NULL;
		gadgets[x].MutualExclude=0;
		gadgets[x].SpecialInfo=0;
		gadgets[x].GadgetID=x;
	}
	gadgets[449].NextGadget=NULL;

}/* creatematrix() */
