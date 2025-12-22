/*
 * Amtris © 1991-94 David Kinder
 *
 * A game which is almost, but not quite, entirely unlike Tetris.
 *
 * Written using NorthC v1.3
 *
 */

#include <intuition/intuition.h>
#include "amtris.h"

char *_WBConsole="CON:0/0/1/1//AUTO";
extern APTR _fromWB,_stdout;

UBYTE done,keya,keys,keyr;
UBYTE map[150];
UBYTE lives = 3;
UBYTE level = 1;
UBYTE rows;
SHORT x,y;
SHORT timer,speed;
USHORT score,hisc;
LONG col,nextcol,txtoff = 0;
int newrot,piece,newpiece,rot;

SHORT *CurrPiece;
SHORT *NextPiece;
struct Window *MyWindow;
struct IntuiMessage *MyMessage;
struct RastPort *MyRPort;

UBYTE HandleIDCMP();
UBYTE CheckStop();
UBYTE CheckOver();
SHORT *GetIt();

main()
{
   OpenDisp();
   while(!done)
   {
      WaitPort(MyWindow->UserPort);
      done = HandleIDCMP();
   }
   CleanExit();
}

UBYTE HandleIDCMP()
/* Process messages arriving at window */
{
UBYTE flag = FALSE;
UBYTE move;
USHORT code;
ULONG class;

   while(MyMessage = (struct IntuiMessage *)GetMsg(MyWindow->UserPort))
   {
      class = MyMessage->Class;
      code = MyMessage->Code;
      ReplyMsg((struct Message *)MyMessage);

      switch(class)
      {
	 case CLOSEWINDOW:
	    flag = TRUE;
	    break;

	 case INTUITICKS:
	    if (!(timer--))
	    {
	       timer = speed;
	       move = TRUE;
	       while (CheckStop())
	       {
		  MapPiece(CurrPiece,col,x,y);
		  StartNewPiece();
		  move = FALSE;
	       }
	       if (move)
	       {
		  DrawPiece(CurrPiece,0L,x,y);
		  y++;
		  DrawPiece(CurrPiece,col,x,y);
	       }
	    }
	    break;

	 case RAWKEY:
	    switch(code)
	    {
	       case 0x0020:
		  if (keya == 0)
		  {
		     keya = 1;
		     if (x)
		     {
			if (!CheckOver(CurrPiece,x-1,y))
			{
			   DrawPiece(CurrPiece,0L,x,y);
			   x--;
			   DrawPiece(CurrPiece,col,x,y);
			}
		     }
		  }
		  break;
	       case 0x00a0:
		  keya = 0;
		  break;
	       case 0x0021:
		  if (keys == 0)
		  {
		     keys = 1;
		     if (x+CurrPiece[0] < 9)
		     {
			if (!CheckOver(CurrPiece,x+1,y))
			{
			   DrawPiece(CurrPiece,0L,x,y);
			   x++;
			   DrawPiece(CurrPiece,col,x,y);
			}
		     }
		  }
		  break;
	       case 0x00a1:
		  keys = 0;
		  break;
	       case 0x0040:
		  DropPiece();
		  break;
	       case 0x0044:
		  if (keyr == 0)
		  {
		     RotatePiece();
		     keyr = 1;
		  }
		  break;
	       case 0x00c4:
		  keyr = 0;
		  break;
	       case 0x005f:
		  DoHelp(0);
		  RedrawMap();
		  DrawPiece(CurrPiece,col,x,y);
		  break;
	    }
	    break;
      }
   }
   return(flag);
}

OpenDisp()
/* Open window and prepare display */
{
APTR ScrBuf;

   if (NULL==OpenLibrary("intuition.library",0L)) CleanExit();
   if (NULL==OpenLibrary("graphics.library",0L)) CleanExit();

   if ((ScrBuf = (APTR)AllocMem(sizeof(struct Screen),NULL))!=NULL)
   {
      GetScreenData(ScrBuf,sizeof(struct Screen),WBENCHSCREEN,NULL);
      txtoff = (LONG)(((struct Screen *)ScrBuf)->Font->ta_YSize)-8;
      MyNewWindow.Height = MyNewWindow.Height+txtoff+
	 ((struct Screen *)ScrBuf)->WBorBottom;
      FreeMem(ScrBuf,sizeof(struct Screen));
   }

   if (!(MyWindow = (struct Window *)OpenWindow(&MyNewWindow)))
   {
      MyNewWindow.TopEdge = 0;
      if (!(MyWindow = (struct Window *)OpenWindow(&MyNewWindow)))
	 CleanExit();
   }
   MyRPort = MyWindow->RPort;
   srand(VBeamPos() * 33333);
   if (_fromWB)
   {
      Close(_stdout);
      _stdout = NULL;
   }

   SetWindowTitles(MyWindow,~0L,
      "Amtris (c) 1991-94 David Kinder. Press 'Help' for instructions.");
   DrawBorder(MyRPort,&MyBorder,WINX,txtoff+WINY);
   PrintIText(MyRPort,&NextText,WINX,txtoff+WINY);
   PrintIText(MyRPort,&StartText3,WINX,txtoff+WINY);
   SetLevel();
   ShowScore();

   WaitKey(TRUE,1);
   SetLevel2();
   RandNewPiece();
   StartNewPiece();
}

WaitKey(help,count)
/* Wait for any key to be pressed */
UBYTE help,count;

{
ULONG class;
USHORT code;
UBYTE wdone = FALSE;

   while(!wdone)
   {
      WaitPort(MyWindow->UserPort);
      while(MyMessage = (struct IntuiMessage *)GetMsg(MyWindow->UserPort))
      {
	 class = MyMessage->Class;
	 code = MyMessage->Code;
	 ReplyMsg((struct Message *)MyMessage);

	 switch(class)
	 {
	    case CLOSEWINDOW:
	       CleanExit();
	       break;

	    case RAWKEY:
	       if (code == 0x005f)
	       {
		  if (help) DoHelp(count);
	       }
	       else
	       {
		  if (code < 0x0080) wdone = TRUE;
	       }
	       break;
	 }
      }
   }
   SetAPen(MyRPort,0L);
   RectFill(MyRPort,WINX+5L,txtoff+WINY+5L,WINX+155L,txtoff+WINY+115L);
}

CleanExit()
/* Tidy up and leave */
{
   if (MyWindow) CloseWindow(MyWindow);
   exit(0L);
}

DrawPiece(Piece,Colour,x,y)
/* Draw given piece at given location */
SHORT *Piece;
LONG Colour,x,y;

{
SHORT i;

   SetAPen(MyRPort,Colour);
   WaitTOF();
   for(i=2;Piece[i]!=-1;i+=2) PlotPoint(x+Piece[i],y+Piece[i+1]);
}

PlotPoint(x,y)
/* Plot a block at (x,y) */
LONG x,y;

{
   x = WINX+(x<<4);
   y = WINY+(y<<3);
   RectFill(MyRPort,x,txtoff+y,x+15L,txtoff+y+7L);
}

StartNewPiece()
/* Put a new piece together */
{
   TestLineFull();
   StartNewPiece2();

   if (CheckOver(CurrPiece,x,y))
   {
      LoseLife();
      StartNewPiece2();
   }
   DrawPiece(CurrPiece,col,x,y);
}

StartNewPiece2()
/* SNP subroutine */
{
   col = nextcol;
   CurrPiece = NextPiece;
   piece = newpiece;
   rot = newrot;
   RandNewPiece();
   DrawPiece(CurrPiece,0L,12L,2L);
   DrawPiece(NextPiece,nextcol,12L,2L);

   y=0;
   for(x=10;x+CurrPiece[0] > 9;x = rand() & 15);
}

RandNewPiece()
/* Randomly choose a new piece */
{
   if (4L == ++nextcol) nextcol = 1L;
   for(newpiece=6;newpiece > 5;newpiece = (rand()>>2) & 7);
   newrot = (rand()>>2) & 3;
   NextPiece = GetIt(newpiece,newrot);
}

UBYTE CheckStop()
/* Can this piece move any further? */
{
UBYTE flag = FALSE;

   if (y+CurrPiece[1] == 14) flag = TRUE;
   if (CheckOver(CurrPiece,x,y+1)) flag = TRUE;
   return(flag);
}

UBYTE CheckOver(Piece,x,y)
/* Is the given position occupied? */
SHORT *Piece;
LONG x,y;

{
UBYTE flag = FALSE;
SHORT i;

   for(i=2;Piece[i]!=-1;i+=2)
   {
      if (map[(10*(y+Piece[i+1]))+(x+Piece[i])] != 0) flag = TRUE;
   }
   return(flag);
}

MapPiece(Piece,Colour,x,y)
/* Store piece in internal map */
SHORT *Piece;
LONG Colour,x,y;

{
SHORT i;

   for(i=2;Piece[i]!=-1;i+=2)
   {
      map[(10*(y+Piece[i+1]))+(x+Piece[i])] = (UBYTE)Colour;
   }
}

DropPiece()
/* Move current piece to it's final resting place */
{
   ModifyIDCMP(MyWindow,FLAGSOFF);
   while (!CheckStop())
   {
      DrawPiece(CurrPiece,0L,x,y);
      y++;
      DrawPiece(CurrPiece,col,x,y);
   }
   MapPiece(CurrPiece,col,x,y);
   StartNewPiece();
   ModifyIDCMP(MyWindow,FLAGSON);
}

TestLineFull()
/* Has player completed a line? */
{
UBYTE tmap[150];
SHORT i = 140;
LONG j,k,l,m,n;
int line;

   while (i!=0)
   {
      line = TRUE;
      for (j=0;j<10;j++)
      {
	 if (map[i+j] == 0) line = FALSE;
      }
      if (line)
      {
	 for (j=3;j>=0;j--)
	 {
	    SetAPen(MyRPort,j);
	    for (k=i;k<i+10;k++)
	    {
	       PlotPoint((k-(10*(k/10))),(k/10));
	       map[k] = (UBYTE)j;
	    }
	    Delay(2L);
	 }
	 for (k=0;k<150;k++) tmap[k] = map[k];
	 for (k=i+9;k>9;k--) map[k] = map[k-10];
	 for (k=0;k<10;k++) map[k] = 0;
	 for (k=0;k<150;k++)
	 {
	    if (map[k] != tmap[k])
	    {
	       SetAPen(MyRPort,(LONG)map[k]);
	       PlotPoint((k-(10*(k/10))),(k/10));
	    }
	 }
	 i = 140;
	 score += 2;
	 rows--;
	 ShowScore();

	 if (rows == 0)
	 {
	    level++;
	    score += 10;
	    SetLevel();

	    ModifyIDCMP(MyWindow,FLAGSOFF);
	    for (l=14;l>-1;l--)
	    {
	       for (m=3;m>=0;m--)
	       {
		  SetAPen(MyRPort,m);
		  for (n=0;n<10;n++) PlotPoint(n,l);
		  Delay(2L);
	       }
	    }
	    for (l=0;l<150;l++) map[l] = 0;
	    SetLevel2();
	    ModifyIDCMP(MyWindow,FLAGSON);
	    i = 0;
	 }
	 ShowScore();
      }
      else
      {
	 i -= 10;
      }
   }
}

LoseLife()
/* Piece cannot get on so player looses life */
{
LONG i,j,k;

   ModifyIDCMP(MyWindow,FLAGSOFF);
   for (i=3;i>=0;i--)
   {
      DrawPiece(CurrPiece,i,x,y);
      Delay(2L);
   }

   for (i=0;i<15;i++)
   {
      for (j=3;j>=0;j--)
      {
	 SetAPen(MyRPort,j);
	 for (k=0;k<10;k++) PlotPoint(k,i);
	 Delay(2L);
      }
   }

   for (i=0;i<150;i++) map[i] = 0;
   ModifyIDCMP(MyWindow,FLAGSON);

   if (lives-- == 0) GameOver();
   SetLevel();
   ShowScore();
   SetLevel2();
}

GameOver()
/* Wait for new game to be started */
{
   PrintIText(MyRPort,&StartText4,WINX,txtoff+WINY);
   lives = 0;
   if (score > hisc) hisc = score;
   ShowScore();

   WaitKey(TRUE,2);
   level = 1;
   lives = 3;
   score = 0;
}

RotatePiece()
/* Rotate piece if possible */
{
int t_rot;
SHORT *t_piece;
LONG t_x,t_y;

   t_rot = rot;
   if (++t_rot == 4) t_rot = 0;
   t_piece = GetIt(piece,t_rot);
   t_x = x-(t_piece[0]/2)+(CurrPiece[0]/2);
   if ((t_y = y-(t_piece[1]/2)+(CurrPiece[1]/2)) < 0) t_y = 0;

   if ((t_x+t_piece[0] < 10) && (t_y+t_piece[1] < 15) && (t_x >= 0))
   {
      if (!CheckOver(t_piece,t_x,t_y))
      {
	 DrawPiece(CurrPiece,0L,x,y);
	 x = t_x;
	 y = t_y;
	 rot = t_rot;
	 CurrPiece = t_piece;
	 DrawPiece(CurrPiece,col,x,y);
      }
   }
}

ShowScore()
/* Update score display */
{
   if (score < 2)
   {
      sprintf(ActScText.IText,"     ");
      PrintIText(MyRPort,&ActScText,WINX,txtoff+WINY);
   }
   sprintf(ActHiText.IText,"%d",hisc);
   sprintf(ActScText.IText,"%d",score);
   sprintf(ActLivText.IText,"%d",lives);
   sprintf(ActLevText.IText,"%d ",level);
   sprintf(ActRowText.IText,"%d ",rows);
   PrintIText(MyRPort,&ActScText,WINX,txtoff+WINY);
}

SetObstacle(setno)
/* Draw blocks already on display at start */
UBYTE setno;

{
int i;

   for (i=90;i<150;i++)
   {
      switch (setno)
      {
	 case 5: map[i] = obst0[i-90]; break;
	 case 6: map[i] = obst1[i-90]; break;
	 case 7: map[i] = obst2[i-90]; break;
	 case 8: map[i] = obst3[i-90]; break;
	 case 9: map[i] = obst4[i-90]; break;
      }
   }
   RedrawMap();
}

SetLevel()
/* Setup display according to level */
{
   if (level > 99) level -= 99;
   rows = ((level-1) % 5) + 9;
   if ((speed = 5 - ((level-1) % 5)) < 1) speed = 1;
}

SetLevel2()
/* More SetLevel() stuff */
{
   if (((level-1) % 10) > 4) SetObstacle(level-1);
}

SHORT *GetIt(PieceNo,RotNo)
/* Get specified piece */
int PieceNo,RotNo;

{
SHORT *ActPiece;

   switch(PieceNo)
   {
      case 0:
	 switch(RotNo)
	 {
	    case 0: ActPiece = Piece1a; break;
	    case 1: ActPiece = Piece1b; break;
	    case 2: ActPiece = Piece1a; break;
	    case 3: ActPiece = Piece1b; break;
	 }
	 break;

      case 1:
	 ActPiece = Piece2a;
	 break;

      case 2:
	 switch(RotNo)
	 {
	    case 0: ActPiece = Piece3a; break;
	    case 1: ActPiece = Piece3b; break;
	    case 2: ActPiece = Piece3c; break;
	    case 3: ActPiece = Piece3d; break;
	 }
	 break;

      case 3:
	 switch(RotNo)
	 {
	    case 0: ActPiece = Piece4a; break;
	    case 1: ActPiece = Piece4b; break;
	    case 2: ActPiece = Piece4a; break;
	    case 3: ActPiece = Piece4b; break;
	 }
	 break;

      case 4:
	 switch(RotNo)
	 {
	    case 0: ActPiece = Piece5a; break;
	    case 1: ActPiece = Piece5b; break;
	    case 2: ActPiece = Piece5c; break;
	    case 3: ActPiece = Piece5d; break;
	 }
	 break;

      case 5:
	 switch(RotNo)
	 {
	    case 0: ActPiece = Piece6a; break;
	    case 1: ActPiece = Piece6b; break;
	    case 2: ActPiece = Piece6a; break;
	    case 3: ActPiece = Piece6b; break;
	 }
	 break;
   }
   return(ActPiece);
}

DoHelp(count)
/* Bring up Help page on screen */
UBYTE count;

{
   SetAPen(MyRPort,0L);
   RectFill(MyRPort,5L,txtoff+12L,W_WIDE-8L,txtoff+W_HIGH-4L);
   PrintIText(MyRPort,&Help,0L,txtoff+20L);

   WaitKey(FALSE,0);
   RectFill(MyRPort,5L,txtoff+12L,W_WIDE-8L,txtoff+W_HIGH-4L);
   DrawBorder(MyRPort,&MyBorder,WINX,txtoff+WINY);
   PrintIText(MyRPort,&NextText,WINX,txtoff+WINY);
   ShowScore();
   if (NextPiece) DrawPiece(NextPiece,nextcol,12L,2L);
   if (count==1) PrintIText(MyRPort,&StartText3,WINX,txtoff+WINY);
   if (count==2) PrintIText(MyRPort,&StartText4,WINX,txtoff+WINY);
}

RedrawMap()
/* Repair main display */
{
int i,j;

   for(i=0;i<10;i++)
   {
      for(j=0;j<15;j++)
      {
	 if (map[(j*10)+i] != 0)
	 {
	    SetAPen(MyRPort,(LONG)map[(j*10)+i]);
	    PlotPoint(i,j);
	 }
      }
   }
}
