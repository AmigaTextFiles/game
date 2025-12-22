/*===================================================*
  This code is freeware !    You don't have to pay a
  penny for it. No restrictions are made of any kind.
  Nevertheless: Please keep the code working and re-
  distribute the program together with the source.
  Try a fair play with this lines. If you feel a bit
  guilty when playing without paying  send an amount
  of useful things (-: may include money ;-) to:
		Andreas Neuper
		++49 +921 64278 (data)
		++49 +921 62440 (voice/answering machine)
		2:2400/80.33    (fido)
		andreas.neuper@iris6.uni-bayreuth.de (internet)
		Emil-Warburg-Weg 34  8580 Bayreuth (yellowmail)
		no responsibility is taken     (no blackmail !)
 *===================================================*/

/*###################################################*
  TO FIX
   * distinguish between chipmem and fastmem parts
   * include doc file
   * single step bomb amount prop gadget
	  (actual commented lines haven't satisfied the author)
   * finer icons
  BUG REPORT:
	* fixed dim-16 borderbomb bug
	* screen colour moderated to grey
	* tightened wbstartupcode
	* play on after aim is reached
	* Gridsize 0 cancelled (guru)
  ADDITIONS:
	* added mark on right mousebutton
	* added mark of last selected field
	* enlarged to gridsize 17
  VERSION 1.0
	* full key/numboard support
	* full mouse support
	* 4 colour screen
	* very fast except new game
	* title line for comments
	* full workbench support
	* full cli support
	* variable size 1 -- 256 fields
	* variable bomb amount ( higher than percolation )
	* 3 languages available
	* source and makefile included
	* no copyright or other restrictions
	* no responsibility (perfectly hidden viruses ß-)
 *###################################################*/

/*-------------------Makefile------------------------*
# ©1992 JAN Andreas Neuper --- ANSI C  AMIGA KS 1.3
# Version V1.01            08.07.1992
# Language-selection:
#   minen           ---    erzeuge deutschen Code
#   mines           ---    generate english Code
#   minas           ---    procrea codigó español
minen: minen.o
	ln +q -o minen +cdb minen.o -lcl

mines: mines.o
	ln +q -o mines +cdb mines.o -lcl

minas: minas.o
	ln +q -o minas +cdb minas.o -lcl

minen.o: minen.c
	cc -md -o minen.o minen.c

mines.o: minen.c
	cc -md -DENGLISH -o mines.o minen.c

minas.o: minen.c
	cc -md -DESPANOL -o minas.o minen.c
 *------------------AZTEC-5.0a-----------------------*/
#include <stdio.h>
#include <time.h>
#include <exec/types.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <intuition/intuition.h>
#include <libraries/dosextens.h>
#include <clib/reqbase.h>
#include <graphics/view.h>
#include <workbench/workbench.h>
#include <workbench/startup.h>
#include <workbench/icon.h>
#include <functions.h>
#define MAXMAX  17

int	bomben[MAXMAX][MAXMAX];
int	besuch[MAXMAX][MAXMAX];
int	xsize=36, xoffset=20;
int	ysize=18, yoffset=20;
int	bombs=20,max=10; /*bombs global wg. workbenchstartup*/
void *IconBase;

void	_wb_parse(prozess,wbm)
register struct Process *prozess;
struct WBStartup *wbm;
{	register struct DiskObject *diskobj;
	register	struct WBArg *arglist;
	register	char *str;

	arglist = wbm->sm_ArgList;
	arglist++;
	if((arglist->wa_Name)[0]==0)	--arglist;
	CurrentDir((struct FileLock *)arglist->wa_Lock);
	if ((IconBase = OpenLibrary("icon.library", 0L)) == 0)	return;
	if ((diskobj = GetDiskObject(arglist->wa_Name)) == 0)	goto close_icon_lib;
	if (str = FindToolType(diskobj->do_ToolTypes, "BOMB"))
		if(atoi(str)>0) bombs=atoi(str);
	if (str = FindToolType(diskobj->do_ToolTypes, "DIM"))
		if(atoi(str)>0) max=atoi(str);
	FreeDiskObject(diskobj);
close_icon_lib:
	CloseLibrary(IconBase);
	IconBase = 0;
	return;
}

struct RastPort	*rp;
struct Window	*window;
struct Screen	*screen;
struct Gadget Gadgets[MAXMAX][MAXMAX];
struct IntuiText nummer[MAXMAX*MAXMAX];
char	ziffer[MAXMAX*MAXMAX][2];
SHORT Gadget_pairs0[] = { 0,0,0,14,1,14,1,0,29,0 };
SHORT Gadget_pairs1[] = { 1,14,29,14,29,1,30,0,30,14 };
SHORT Mark_pairs[] = { -3,-2, -3,14, 30,14, 30,-2, -3,-2 };
#define CONTAINER 145

struct Border Gadget_umark[] = {
  0,0,0,0,JAM2,5,(SHORT *)&Mark_pairs,&Gadget_umark[1],
  1,0,0,0,JAM2,5,(SHORT *)&Mark_pairs,NULL };

struct Border Gadget_mark[] = {
  0,0,2,1,JAM2,5,(SHORT *)&Mark_pairs,&Gadget_mark[1],
  1,0,2,1,JAM2,5,(SHORT *)&Mark_pairs,NULL };

struct Border Gadget_bord[] = {
  0,0,1,0,JAM1,5,(SHORT *)&Gadget_pairs0,&Gadget_bord[1],
  0,0,3,0,JAM1,5,(SHORT *)&Gadget_pairs1,NULL };

SHORT G_pairs0[] = { 0,0,0,28,1,28,1,0,147,0 };
SHORT G_pairs1[] = { 1,28,147,28,147,1,148,0,148,28 };

struct Border G_bord[] = {
  0,0,1,0,JAM1,5,(SHORT *)&G_pairs0,&G_bord[1],
  0,0,3,0,JAM1,5,(SHORT *)&G_pairs1,NULL };

SHORT B_pairs0[] = { 0,0,0,14,1,14,1,0,147,0 };
SHORT B_pairs1[] = { 1,14,147,14,147,1,148,0,148,14 };

struct Border B_bord[] = {
  0,0,1,0,JAM1,5,(SHORT *)&B_pairs0,&B_bord[1],
  0,0,3,0,JAM1,5,(SHORT *)&B_pairs1,NULL };

struct Gadget PGadget = {
  NULL,40,10,31,15,GADGHNONE,
  RELVERIFY|GADGIMMEDIATE,BOOLGADGET,
  (APTR)&Gadget_bord[0],NULL,
  NULL,(BPTR)NULL,(APTR)NULL,0,NULL };

struct PropInfo BombG_info = {
  PROPBORDERLESS|FREEHORIZ,0x0100,0x0100,0x0100,0x0100,0,0,0,0,0,0 };

USHORT Knopf[]={
  0xCCCC, 0x6666, 0x3333, 0x9999,
  0xCCCC, 0x6666, 0x3333, 0x9999,
  0xCCCC, 0x6666, 0x3333, 0x9999,
  0xCCCC, 0x6666, 0x3333, 0x9999
 };

struct Image BombG_image = {
  0,0,16,13,1,&Knopf[0],0x01,0x00,NULL };

#ifdef ESPANOL
UBYTE nbomb[]  = "Nº de bombas:   ";
UBYTE nbombf[] = "Nº de bombas:%3d";
#elif ENGLISH
UBYTE nbomb[]  = " Nº of bombs:   ";
UBYTE nbombf[] = " Nº of bombs:%3d";
#else
UBYTE nbomb[]  = "Bombenanzahl:   ";
UBYTE nbombf[] = "Bombenanzahl:%3d";
#endif

struct IntuiText BombG_text = {
  1,0,JAM2,12,21,NULL,nbomb,NULL };

struct Gadget BombG = {
  &(Gadgets[0][0]),473,121,CONTAINER,13,
  GADGHNONE|GADGIMAGE,RELVERIFY,PROPGADGET,
  (APTR)&BombG_image,NULL,
  &BombG_text,(BPTR)NULL,(APTR)&BombG_info,1002,NULL };

struct Image GridG_image = {
  0,0,16,13,1,&Knopf[0],0x01,0x00,NULL };

struct PropInfo GridG_info = {
  PROPBORDERLESS|FREEHORIZ,0x8000,0x8000,0x1000,0x0800,0,0,0,0,0,0 };

#ifdef ESPANOL
UBYTE ngrid[]  = " dimensión :   ";
UBYTE ngridf[] = " dimensión :%3d";
#elif ENGLISH
UBYTE ngrid[]  = "  Gridsize :   ";
UBYTE ngridf[] = "  Gridsize :%3d";
#else
UBYTE ngrid[]  = "Gittergröße:   ";
UBYTE ngridf[] = "Gittergröße:%3d";
#endif

struct IntuiText GridG_text = {
  1,0,JAM2,16,21,NULL,ngrid,NULL };

struct Gadget GridG = {
  &BombG,473,161,CONTAINER,13,
  GADGHNONE|GADGIMAGE,RELVERIFY,PROPGADGET,
  (APTR)&GridG_image,NULL,
  &GridG_text,(BPTR)NULL,(APTR)&GridG_info,1003,NULL };

struct IntuiText NewG_text = {
#ifdef ESPANOL
  1,0,JAM1,30,11,NULL,(UBYTE *)"Juego Nuevo",NULL };
#elif ENGLISH
  1,0,JAM1,42,11,NULL,(UBYTE *)"New Game",NULL };
#else
  1,0,JAM1,30,11,NULL,(UBYTE *)"Neues Spiel",NULL };
#endif

struct Gadget NewG = {
  &GridG,471,71,149,29,
  GADGHCOMP,RELVERIFY|GADGIMMEDIATE,BOOLGADGET,
  (APTR)&G_bord[0],NULL,
  &NewG_text,(BPTR)NULL,NULL,1001,NULL };

struct IntuiText QuitG_text = {
#ifdef ESPANOL
  1,0,JAM1,41,11,NULL,(UBYTE *)"Terminar",NULL };
#elif ENGLISH
  1,0,JAM1,57,11,NULL,(UBYTE *)"Quit",NULL };
#else
  1,0,JAM1,45,11,NULL,(UBYTE *)"Beenden",NULL };
#endif

struct Gadget QuitG = {
  &NewG,471,21,149,29,
  GADGHCOMP,RELVERIFY|GADGIMMEDIATE,BOOLGADGET,
  (APTR)&G_bord[0],NULL,
  &QuitG_text,(BPTR)NULL,NULL,1000,NULL };

#ifdef ESPANOL
UBYTE titel[]=(UBYTE*)"                                "
							 "  M I N A S    "
							 "                                ";
#elif ENGLISH
UBYTE titel[]=(UBYTE*)"                                "
							 "  M I N E S    "
							 "                                ";
#else
UBYTE titel[]=(UBYTE*)"                                "
							 "  M I N E N    "
							 "                                ";
#endif

struct NewScreen ns = {
  0,0,640,276,2,1,0,HIRES,CUSTOMSCREEN,NULL,NULL,NULL,NULL };

struct IntuiText copy_text = {
  1,0,JAM1,0,0,NULL,(UBYTE *)"©1992 JAN",NULL };

struct NewWindow mainframe = {
  0,10,640,246,1,2,GADGETDOWN|GADGETUP|MENUPICK|RAWKEY,
  NOCAREREFRESH|SMART_REFRESH|BACKDROP|ACTIVATE|BORDERLESS,
  &QuitG,NULL,titel,NULL,NULL,150,40,640,276,CUSTOMSCREEN };

struct	IntuitionBase	*IntuitionBase;
struct	GfxBase			*GfxBase;
struct	IntuiMessage	*message;
struct	Message			*GetMsg();
struct	Gadget			*GadgetPtr;
ULONG 	MessageClass;
USHORT	code;

void	init_gadget_array(int n)
{	int	i,j;

	xsize=440/n;
	ysize=((xsize+1)>>1);
	Gadget_pairs0[3]=Gadget_pairs0[5]=Gadget_pairs1[1]=Gadget_pairs1[3]=Gadget_pairs1[9]=ysize-4;
	Gadget_pairs0[8]=Gadget_pairs1[2]=Gadget_pairs1[4]=xsize-7;
	Gadget_pairs1[6]=Gadget_pairs1[8]=xsize-6;
	Mark_pairs[3] = Mark_pairs[5] = ysize-2;
	Mark_pairs[4] = Mark_pairs[6] = xsize-4;
	for(i=0;i<n;i++)
	{	for(j=0;j<n;j++)
		{	(Gadgets[i][j]).TopEdge  = yoffset + ysize * i;
			(Gadgets[i][j]).LeftEdge = xoffset + xsize * j;
			(Gadgets[i][j]).Width = xsize-6;
			(Gadgets[i][j]).Height = ysize-3;
			(Gadgets[i][j]).Flags = PGadget.Flags;
			(Gadgets[i][j]).Activation = PGadget.Activation;
			(Gadgets[i][j]).GadgetType = PGadget.GadgetType;
			(Gadgets[i][j]).GadgetRender = PGadget.GadgetRender;
			(Gadgets[i][j]).SelectRender = PGadget.SelectRender;
			(Gadgets[i][j]).GadgetText = &nummer[i+j*n];
				nummer[i+j*n].IText=(UBYTE*)ziffer[i+j*n];
				nummer[i+j*n].FrontPen=1;
				nummer[i+j*n].BackPen=0;
				nummer[i+j*n].DrawMode=JAM2;
				nummer[i+j*n].LeftEdge=(xsize>>1)-6;
				nummer[i+j*n].TopEdge =(ysize>>1)-5;
				nummer[i+j*n].ITextFont=NULL;
				nummer[i+j*n].NextText=NULL;
			(Gadgets[i][j]).GadgetID = i + j * n;
			(Gadgets[i][j]).NextGadget = ((j+1)!=(n))?&(Gadgets[i][j+1]):&(Gadgets[i+1][0]);
		}
	}	(Gadgets[n-1][n-1]).NextGadget = (struct	Gadget *)NULL;
	return;
}

void  close_all(int end_value)
{  extern void CloseLibrary();
   extern void CloseWindow();

   if (screen)        CloseScreen(screen);
   if (window)        CloseWindow(window);
   if (GfxBase)       CloseLibrary(GfxBase);
   if (IntuitionBase) CloseLibrary(IntuitionBase);
   if (end_value)		 fprintf(stderr,"EXIT: %d\n",end_value);
   exit(end_value);
}

void	reopenwindow(int n)
{	extern struct  Window   *OpenWindow();

   if (window)        CloseWindow(window);
	init_gadget_array(n);
   if (!(window = (struct Window *) OpenWindow(&mainframe))) close_all(217);
	rp = window->RPort;
	SetDrMd(rp,JAM2);  /* Drawmode:  ÜBERSCHREIBEN  setzen  */
	SetAPen(rp,1); /* Farbregister zum Zeichnen setzen  */
	DrawBorder(rp,B_bord,471,120);
	DrawBorder(rp,B_bord,471,160);
	PrintIText(rp,&copy_text,540,228);
	return;
}

void	open_all(void)
{	void                    *OpenLibrary();
	extern struct  Window   *OpenWindow();

   if (!(GfxBase = (struct GfxBase *)
      OpenLibrary("graphics.library", (long)0)))
      close_all(204);

   if (!(IntuitionBase = (struct IntuitionBase *)
      OpenLibrary("intuition.library", (long)0)))
      close_all(205);

   if (!(screen = (struct Screen *) OpenScreen(&ns))) close_all(206);
	SetRGB4(&screen->ViewPort,0,0x7,0x7,0x7);
	SetRGB4(&screen->ViewPort,1,0xE,0xE,0xE);
	SetRGB4(&screen->ViewPort,2,0x0,0x0,0x0);
	SetRGB4(&screen->ViewPort,3,0x2,0x2,0xD);
	mainframe.Screen = screen;
   if (!(window = (struct Window *) OpenWindow(&mainframe))) close_all(207);
	(void) SetTaskPri(FindTask((char *) 0), 1) ;

	Delay(5L);
	rp = window->RPort;
	SetDrMd(rp,JAM2);  /* Drawmode:  ÜBERSCHREIBEN  setzen  */
	SetAPen(rp,1); /* Farbregister zum Zeichnen setzen  */
	DrawBorder(rp,B_bord,471,120);
	DrawBorder(rp,B_bord,471,160);
	PrintIText(rp,&copy_text,540,228);
	return;
}

int	wie_viele(int	x,int	y)
{	int	b=0;

	if(x>0 &&   y>0   && bomben[x-1][y-1]) b++;
	if(x>0 && y+1<max && bomben[x-1][y+1]) b++;
	if(y>0 && x+1<max && bomben[x+1][y-1]) b++;
	if(x>0 && bomben[x-1][y]) b++;
	if(y>0 && bomben[x][y-1]) b++;
	if(x+1<max && y+1<max && bomben[x+1][y+1]) b++;
	if(x+1<max && bomben[x+1][y]) b++;
	if(y+1<max && bomben[x][y+1]) b++;
	return(b);
}

int	erlaubt(int	x,int	y)
{	int	b=0;

	if(x>0 && y>0 && besuch[x-1][y-1]) b++;
	if(x>0 && besuch[x-1][y+1]) b++;
	if(y>0 && besuch[x+1][y-1]) b++;
	if(x>0 && besuch[x-1][y]) b++;
	if(y>0 && besuch[x][y-1]) b++;
	if(besuch[x+1][y+1]) b++;
	if(besuch[x+1][y]) b++;
	if(besuch[x][y+1]) b++;
	if(x==0&&y==0)
	{	SetWindowTitles(window,(char*)titel,
#ifdef ESPANOL
			"¡Empieza! Hasta la casilla abajo a la derecha."
			"Lee la quantidad de minas.");
#elif ENGLISH
			"Go to the lower right Edge ! "
			"The digit tells you howmany bombs are around.");
#else
			"Zur rechten unteren Ecke ! "
			"Die Zahl sagt Dir wieviel Minen Dich umgeben.");
#endif
		b++;
	}
	return(b);
}

void	init_bomben(int	n)
{	int i,j;
	time_t timer;

	for(i=0;i<MAXMAX;i++)
	{	for(j=0;j<MAXMAX;j++)
		{	bomben[i][j]=0;
			besuch[i][j]=0;
			ziffer[i+j*MAXMAX][0]=' ';
	}	}
	SetWindowTitles(window,(char*)titel,
#ifdef ESPANOL
		"¡ Empieza ! con la casilla arriba a la izquierda. ");
#elif ENGLISH
		"Come on, make your mind up and play !     Upper left square !");
#else
		"Komm und fang endlich an !     Das Feld oben links !");
#endif
	time(&timer);
	srand((unsigned int)timer);
	for(i=0;i<n;i++)
	{	if( bomben[rand()%max][rand()%max]++ ) i--;
	}
	RefreshGadgets(&Gadgets[0][0],window,NULL);
	Delay(5L);
	return;
}

#define MAXBOMB (max*max)

int	main(int argc, char *argv[])
{	int	warten=TRUE,stop=FALSE,what=1;
	int	x = -1,y = -1,gameover=FALSE,oldmax=max;

	if(argc>3||argv[1][0]=='?'||argv[1][0]=='h'||argv[1][1]=='?'||argv[1][1]=='h')
#ifdef ESPANOL
	{	printf("\nSINTAXIS:  %s  <#bombas>  <#dimensión>\n\n",argv[0]);
#elif ENGLISH
	{	printf("\nSYNOPSIS:  %s  <#bombs>  <#dimension>\n\n",argv[0]);
#else
	{	printf("\nSYNTAX:  %s  <#bomben>  <#gitterdimension>\n\n",argv[0]);
#endif
		exit(0);
	}
	if(argc>1)	{ oldmax=atoi(argv[1]); if(oldmax>0) bombs=oldmax; oldmax = max; }
	if(argc>2)	{ oldmax=atoi(argv[2]); if(oldmax>0) max=oldmax; else oldmax=max;  }
	init_gadget_array(max);
	if(CONTAINER<bombs) bombs=CONTAINER;
/*	BombG_info.HorizPot = (bombs*MAXPOT)/((MAXBOMB>CONTAINER)?CONTAINER:MAXBOMB);
	  		Damit Einzelschritte moeglioch werden, statt der nächsten Zeile
*/	BombG_info.HorizPot = (bombs*MAXPOT)/(MAXBOMB);
	GridG_info.HorizPot = ((max-1)*MAXPOT) /(MAXMAX-1);
	sprintf((char*)nbomb,(char*)nbombf,bombs);
	sprintf((char*)ngrid,(char*)ngridf,max);
	open_all();
	do
	{	init_bomben(bombs);
		stop=FALSE;
		warten=TRUE;
		Delay(5L);
		do
		{	Wait(1 << window -> UserPort -> mp_SigBit);
			while (message = (struct IntuiMessage *) GetMsg(window->UserPort))
			{  code = message->Code;
				MessageClass = message->Class;
				ReplyMsg((struct Message *)message);
				GadgetPtr = (struct Gadget *) (message->IAddress);
				what=0;
				switch(MessageClass)
				{	case RAWKEY:
					{	what=1;
						if(code<0x60)
							DrawBorder(rp,Gadget_umark,x*xsize+xoffset,y*ysize+yoffset);
						switch(code)
						{	case 0x3D:	x--;	y--;	break;
							case 0x4C:
							case 0x3E:	y--;	break;
							case 0x3F:	x++;	y--;	break;
							case 0x4F:
							case 0x2D:	x--;	break;
							case 0x4E:
							case 0x2F:	x++;	break;
							case 0x1D:	x--;	y++;	break;
							case 0x4D:
							case 0x1E:	y++;	break;
							case 0x1F:	x++;	y++;	break;
							case 0x10:
							case 0x45:	GadgetPtr->GadgetID = 1000;	what=2;	break;
							case 0x44:
							case 0x5F:
							case 0x36:	GadgetPtr->GadgetID = 1001;	what=2;	break;
							default:	what=0;
						} if(!what) break;
						if(x<0) x=0;
						if(x>=max) x=max;
						if(y<0) y=0;
						if(y>=max) y=max;
						if(what!=2)	GadgetPtr->GadgetID = y+x*max;
					}
					case GADGETDOWN:
			      {
						DrawBorder(rp,Gadget_umark,x*xsize+xoffset,y*ysize+yoffset);
						if(GadgetPtr->GadgetID > 999)
						{	switch(GadgetPtr->GadgetID)
							{	case 1000: /*QUIT*/
									warten = FALSE;
									stop = TRUE;
									break;
   							case 1001: /*NEU*/
   								if(oldmax!=max)
   								{	oldmax=max;
   									reopenwindow(max);
   								}
									x = y = -1;
									warten = FALSE;
									stop = FALSE;
									gameover=FALSE;
									break;
								case 1002: /*BOMBEN*/
									break;
								case 1003: /*GITTER*/
									break;
								default:
									{	warten = FALSE;	stop = TRUE;	}
							} break;
						} else if(gameover)	DisplayBeep(screen);
						if(!gameover)
						{	y=(GadgetPtr->GadgetID)%max;
							x=(GadgetPtr->GadgetID)/max;
							if(!erlaubt(x,y)) break;
							besuch[x][y] = TRUE;
							DrawBorder(rp,Gadget_mark,x*xsize+xoffset,y*ysize+yoffset);
							if(bomben[x][y])
							{	gameover=TRUE;
								ziffer[(GadgetPtr->GadgetID)][0] = '*';
								DisplayBeep(screen);
#ifdef ESPANOL
								SetWindowTitles(window,(char*)titel,"¡ Ofendas te a una mina !");
#elif ENGLISH
								SetWindowTitles(window,(char*)titel,"Your last step - A Bomb detonated !");
#else
								SetWindowTitles(window,(char*)titel,"Voll draufgetreten !");
#endif
							} else
							ziffer[(GadgetPtr->GadgetID)][0] = wie_viele(x,y)+'0';

							PGadget.NextGadget = Gadgets[y][x].NextGadget;
							Gadgets[y][x].NextGadget = NULL;
							RefreshGadgets(&Gadgets[y][x],window,NULL);
							Gadgets[y][x].NextGadget = PGadget.NextGadget;
							if(x+1==max && y+1==max && !gameover)
#ifdef ESPANOL
							{	SetWindowTitles(window,(char*)titel,"¡ Congratulatiónes !  Muy bien.");
#elif ENGLISH
							{	SetWindowTitles(window,(char*)titel,"Congratulations ! You\'ve succeeded !");
#else
							{	SetWindowTitles(window,(char*)titel,"Gratulation ! Du hast es geschafft !");
#endif
/*								gameover=TRUE;*/
							}
						}	break;
					}
   				case GADGETUP:
						{	switch(GadgetPtr->GadgetID)
							{	case 1002: /*BOMB*/
									gameover=TRUE;
									SetWindowTitles(window,(char*)titel,
#ifdef ESPANOL
									"¡ Debes a empezar un juego nuevo !");
#elif ENGLISH
									"  Now you have to start a new game !");
#else
									"Jetzt muß ein neues Spiel begonnen werden !");
#endif
/*									bombs = (((MAXBOMB>CONTAINER)?CONTAINER:MAXBOMB)
									      * BombG_info.HorizPot)/MAXPOT;
  		Damit Einzelschritte moeglioch werden, statt der nächsten Zeile
*/									bombs = (MAXBOMB * BombG_info.HorizPot)/MAXPOT;
									sprintf((char*)nbomb,(char*)nbombf,bombs);
									PGadget.NextGadget = BombG.NextGadget;
									BombG.NextGadget = NULL;
									RefreshGadgets(&BombG,window,NULL);
									BombG.NextGadget = PGadget.NextGadget;
									break;
								case 1003: /*GRID*/
									gameover=TRUE;
									SetWindowTitles(window,(char*)titel,
#ifdef ESPANOL
									"  ¡ Debes a comenzar un juego nuevo !");
#elif ENGLISH
									"  Initialize a new game !");
#else
									"  Es muß ein neues Spiel gestartet werden !");
#endif
									max = ((MAXMAX-1)*GridG_info.HorizPot)/MAXPOT+1;
									sprintf((char*)ngrid,(char*)ngridf,max);
/*									bombs = (((CONTAINER>=MAXBOMB)?MAXBOMB:CONTAINER)
									      * BombG_info.HorizPot)/MAXPOT;
		Damit Einzelschritte moeglioch werden, statt der nächsten Zeile
*/									bombs = (MAXBOMB * BombG_info.HorizPot)/MAXPOT;
									sprintf((char*)nbomb,(char*)nbombf,bombs);
									PGadget.NextGadget = BombG.NextGadget;
									BombG.NextGadget = NULL;
									RefreshGadgets(&GridG,window,NULL);
									BombG.NextGadget = PGadget.NextGadget;
									break;
								default:
									;
							}				
						}	break;  				
						case MENUPICK:
						{	int	xtmp=(window->MouseX-xoffset)/xsize,
									ytmp=(window->MouseY-yoffset)/ysize;
							if(xtmp>=max||ytmp>=max||x<0||y<0)	break;
							ziffer[ytmp+xtmp*max][0] =
								('X'==ziffer[ytmp+xtmp*max][0])?' ':'X';
							PGadget.NextGadget = Gadgets[ytmp][xtmp].NextGadget;
							Gadgets[ytmp][xtmp].NextGadget = NULL;
							RefreshGadgets(&Gadgets[ytmp][xtmp],window,NULL);
							Gadgets[ytmp][xtmp].NextGadget = PGadget.NextGadget;
						}	break;  				
				}
			}
		} 	while(warten);
	}	while(!stop);
	close_all(0);
	return(0);
}
