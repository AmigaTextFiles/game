/*
          C4 Copyright © 1992 Danny Y. Wong  All rights reserved.

Version 1.0  Released October 28, 1992

This program is in the Public Domain; you have permission to 
redistribute it and/or modify it under the terms in the GNU
General Public License.  However, this program can not be sold except
for the cost of the media.

Any comments can be sent to:

Danny Y. Wong
131 64 Ave NW
Calgary, Alberta
T2K 0L9
CANADA

--------------------------------------------------------------------------

To compile in SAS/C:   lc -L c4

*/

#include <stdio.h>
#include "exec/types.h"
#include "intuition/intuition.h"
#include "graphics/gfxbase.h"

#define VERSION "C4 V1.0  Copyright © 1992 By Danny Y. Wong."
#define DEPTH   3      // spare page
#define WIDTH   320
#define HEIGHT  200

#define FWIDTH  320  // foreground
#define FHEIGHT 400

#define BWIDTH  320  // background
#define BHEIGHT 400

#define VPWIDTH  320
#define VPHEIGHT 200

#define JOY1DAT 0xDFF00C
#define PA0 0xBFE0FF

#define NOT_ENOUGH_MEMORY -1000
#define RED  1
#define BLUE 2
#define TIE  3
#define CROSS 1
#define DOWN  2
#define RDIAGONAL 3
#define LDIAGONAL 4

void remakeView(), swapPointers(), scrollit(), FreeMemory(), readthepic();
void setupjoystick(), readjoystick(), readthepic();
short do_menu(), get_box(), drop_peg(), check_win(), check_cross_win();
short comp_check_cross(), comp_check_down();
void move_peg(), game_loop(), read_qstick(), do_init_game();
void do_new_game(), do_about(), do_game_over();
void print_board(), do_random_move();
short do_block_player(), check_comp_rdiagonal(), check_comp_ldiagonal();

struct View     v;
struct ViewPort vp;
struct ColorMap *cm;   /* pointer to colormap structure, dynamic alloc */

struct BitMap   b,  b2, b3;
struct RastPort rp, rp2;
struct RasInfo  ri, ri2;

struct GfxBase *GfxBase;
struct View *oldview;      /* save pointer to old view so can restore */

UWORD colortable[] =  { 
	0x000, 0xbbb, 0x999, 0x777,  //foreground
   0x24c, 0xeb0, 0xf10, 0x0bb,

	0x000, 0xbbb, 0x999, 0x777,
   0x24c, 0xeb0, 0xf10, 0x0bb,
    };

UWORD  *colorpalette;
struct cprlist *LOF[2];
struct cprlist *SHF[2];

short w;
char joy_fire,button_status,*button_ptr;
short joy_status,joy_up,joy_down,joy_left,joy_right,*joy_ptr;
char *file;
short Redx=13, Redy=156, Bluex=37, Bluey=156, page=0, offsety=0,
      drop[9]={12, 37, 62, 87, 112, 137, 162, 187, 212},
      dropy[6]={26, 45 , 69, 93 ,116 ,140};
short board[8][11], total_pegs, game=1;

struct comp_turn
{
   short firstx, firsty, lastx, lasty;
}Comp_stuff;

void _main()
{
   short i;
   
	GfxBase = (struct GfxBase *)OpenLibrary("graphics.library",0);
	if (GfxBase == NULL) exit(1);
	oldview = GfxBase->ActiView; /* save current view to restore later */
	/* example steals screen from Intuition if started from WBench */

	/* init bitmap structures */
	InitBitMap(&b,DEPTH,FWIDTH,FHEIGHT);
	InitBitMap(&b2,DEPTH,BWIDTH,BHEIGHT);
	InitBitMap(&b3,DEPTH,WIDTH,HEIGHT);

	/* allocate and clear bitplanes */
	for(i=0; i<DEPTH; i++)
	{
		b.Planes[i] = (PLANEPTR)AllocRaster(FWIDTH,FHEIGHT);  // foreground
		if(b.Planes[i] == NULL) exit(NOT_ENOUGH_MEMORY);
		BltClear(b.Planes[i],RASSIZE(FWIDTH,FHEIGHT),0);

		b3.Planes[i] = (PLANEPTR)AllocRaster(WIDTH,HEIGHT); //spare
		if(b3.Planes[i] == NULL) exit(NOT_ENOUGH_MEMORY);
		BltClear(b3.Planes[i],RASSIZE(WIDTH,HEIGHT),0);

		b2.Planes[i] = (PLANEPTR)AllocRaster(BWIDTH,BHEIGHT); //big
		if(b2.Planes[i] == NULL) exit(NOT_ENOUGH_MEMORY);
		BltClear(b2.Planes[i],RASSIZE(BWIDTH,BHEIGHT),0);
	}

	/* init RasInfo structures */
	ri.BitMap   = &b;
	ri.RxOffset = 0;   
	ri.RyOffset = 0;
	ri.Next = &ri2;

	ri2.BitMap = &b2;
	ri2.RxOffset = 0;
	ri2.RyOffset = 0;
	ri2.Next = 0;

	InitView(&v);        /* initialize view */
	v.ViewPort = &vp;    /* link view into viewport */

	InitVPort(&vp);      /* init view port */

	/* First color reg for 2nd playfield is register 8 */
	cm = (struct ColorMap * )GetColorMap(16);
	colorpalette = (UWORD *)cm->ColorTable;
	for(i=0; i<16; i++)
		*colorpalette++ = colortable[i];
	/* copy my colors into this data structure */
	vp.ColorMap = cm;   /* link it with the viewport */

	/* now specify critical characteristics */
	vp.DWidth  = VPWIDTH;   /* this is how much you will SEE */
	vp.DHeight = VPHEIGHT;
	vp.RasInfo = &ri;
	vp.Modes   = DUALPF;

	MakeVPort( &v, &vp );   /* construct copper instr (prelim) list */
	MrgCop( &v );      /* merge prelim lists together into a real 
	             * copper list in the view structure. */

	InitRastPort(&rp);   /* first playfield's rastport */
	rp.BitMap = &b;      /* link to its bitmap */

	InitRastPort(&rp2);  /* second playfield's rastport */
	rp2.BitMap = &b2;    /* link to its bitmap */

	SetRast(&rp,0);
	SetRast(&rp2,0);
	LoadView(&v);
	setupjoystick ();

   file="board.pic";   //foreground gfx 1
   readthepic();
   BltBitMap(&b3,0,0,&b,0,0,WIDTH,HEIGHT,0xC0,0xff,NULL);

   file="about.pic";   //foreground gfx 2
   readthepic();
   BltBitMap(&b3,0,0,&b,0,200,WIDTH,HEIGHT,0xC0,0xff,NULL);

   file="tools.pic";  // spare page
   readthepic();

	LOF[1] = NULL;   
	SHF[1] = NULL;
   do_init_game();
   do_about(0);
   do_about(1);
   i=do_menu();
   if (i==1)
       game=1;
   else
   if (i==2)
      game=2;
   game_loop();
	LoadView(oldview);       /* put back the old view  */
	FreeMemory();            /* exit gracefully */
	CloseLibrary(GfxBase);   /* since opened library, close it */

}   /* end of main() */


/* return allocated memory */
void FreeMemory()
{
   short i;

	/* free drawing area */
	for(i=0; i<DEPTH; i++)
   {
		if (b.Planes[i]) FreeRaster(b.Planes[i],FWIDTH,FHEIGHT); 
		if (b3.Planes[i]) FreeRaster(b3.Planes[i],WIDTH,HEIGHT); 
		if (b2.Planes[i]) FreeRaster(b2.Planes[i],BWIDTH,BHEIGHT); 
	}   

	/* free the color map created by GetColorMap() */
	if (cm) FreeColorMap(cm);

	/* free dynamically created structures */
	FreeVPortCopLists(&vp);         
	FreeCprList(LOF[0]);
	FreeCprList(LOF[1]);
}   

void do_new_game()
{
  	  short i;
	  w=0;
     
     if (!page)
     {
       for (i=0; i < 200; i++)
       {
         swapPointers();
         ri2.RxOffset = 0;
         ri2.RyOffset = i;
	      remakeView();
	      w ^= 1;
       }
       page=1;
     }
     else
     {
       for (i=0; i < 200; i++)
       {
         swapPointers();
         ri2.RxOffset = 0;
         ri2.RyOffset = 199-i;
	      remakeView();
	      w ^= 1;
       }
       page=0;
     }
     SetRast(&rp2, 0);
}  


void swapPointers()      /* provided for double buffering of copper lists */
{
	LOF[w] = v.LOFCprList;
	SHF[w] = v.SHFCprList;
	v.LOFCprList = LOF[(w^1)];
	v.SHFCprList = SHF[(w^1)];
	/* swap the pointers so that they can reuse existing space */
}

void remakeView()
{
	MakeVPort(&v, &vp);
	MrgCop(&v);
	LoadView(&v);      /* and show it */
	WaitTOF();      /* slow things down so we can see it move */
}

void setupjoystick()
{
  button_ptr=(char *)PA0; joy_ptr=(short *)JOY1DAT;
}

void readjoystick()
{
  button_status=*button_ptr; joy_status=*joy_ptr;
  joy_fire=((button_status & 128) >> 7) ^ 1;
  joy_right=(joy_status & 2) >> 1;
  joy_left=(joy_status & 512) >> 9;
  joy_down=((joy_status & 2) >> 1) ^ (joy_status & 1);
  joy_up=((joy_status & 512) >> 9) ^ ((joy_status & 256) >> 8);
}

void readthepic()
{
 char *newbyte[8], code, goodbyte, counter;
 short Height, Plane, bytes_read, bytes_per_row=WIDTH>>3;
 FILE *IFFfile;

 IFFfile=fopen(file,"r");
 for (Plane=0; Plane<DEPTH; Plane++)        
 {
    newbyte[Plane]=(char *)(b3.Planes[Plane]); 
 }
 for (Height=0; Height<HEIGHT; Height++)
  { for (Plane=0; Plane<DEPTH; Plane++)
    { bytes_read=0;
      do
      { fread(&code,1,1,IFFfile);
        if (code>=0) 
        { code++;
          fread(newbyte[Plane],(long)code,1,IFFfile);
          newbyte[Plane] += code;
          bytes_read += code;
        }
        else if (code != -127) 
         { code = -code;
           code++;
           fread(&goodbyte,1,1,IFFfile);
           for (counter=0; counter<code; counter++)
           { *newbyte[Plane]=goodbyte;
              newbyte[Plane]++;
           }
           bytes_read += code;
         }
      }
      while ((bytes_read<bytes_per_row) && feof(IFFfile)==0);
    }
  }
 fclose(IFFfile);
}

void read_qstick()
{
 readjoystick();
 while (joy_fire || joy_left || joy_right || joy_up || joy_down)
   readjoystick();
}   

short do_menu()
{
 short menu=1;
 
 joy_fire=0;
 SetAPen(&rp2,7);                 
 RectFill(&rp2,247,34+offsety,316,45+offsety);

 read_qstick();
 while (!joy_fire)
 {
     readjoystick();
     if (joy_down && menu==1) //two player
     {
     	 SetAPen(&rp2,0);                 
	    RectFill(&rp2,247,34+offsety,316,45+offsety);

     	 SetAPen(&rp2,7);                 
	    RectFill(&rp2,247,52+offsety,316,63+offsety);
       ++menu;
     }
     else
     if (joy_down && menu==2)
     {
     	 SetAPen(&rp2,0);                 
	    RectFill(&rp2,247,52+offsety,316,63+offsety);

     	 SetAPen(&rp2,7);                 
	    RectFill(&rp2,247,70+offsety,316,81+offsety);
       ++menu;
     }
     else
     if (joy_down && menu==3)
     {
     	 SetAPen(&rp2,0);                 
	    RectFill(&rp2,247,70+offsety,316,81+offsety);

     	 SetAPen(&rp2,7);                 
	    RectFill(&rp2,247,89+offsety,316,100+offsety);
       ++menu;
     }
     else
     if (joy_down && menu==4)
     {
     	 SetAPen(&rp2,0);                 
	    RectFill(&rp2,247,89+offsety,316,100+offsety);

     	 SetAPen(&rp2,7);                 
	    RectFill(&rp2,247,108+offsety,316,119+offsety);
       ++menu;
     }
     else
     if (joy_down && menu==5)
     {
     	 SetAPen(&rp2,0);                 
	    RectFill(&rp2,247,108+offsety,316,119+offsety);

       SetAPen(&rp2,7);                 
       RectFill(&rp2,247,34+offsety,316,45+offsety);
       menu=1;
     }
     Delay(5);
   }
	SetAPen(&rp2,0);                 
	RectFill(&rp2,247,30+offsety,316,130+offsety);
   return(menu); 
}

void move_peg(color, cord)
short color, cord;
{
    SetAPen(&rp2,0);                 
    RectFill(&rp2,10,10+offsety,240,40+offsety);
    if (color==RED)
       BltBitMap(&b3,13,156,&b2,drop[cord],14+offsety,22,15,0xC0,0xff,NULL);
    else
    if (color==BLUE)
       BltBitMap(&b3,37,156,&b2,drop[cord],14+offsety,22,15,0xC0,0xff,NULL);
    read_qstick();
}

void game_loop()
{
 short done=0, cord=4, color=RED, valid=0, win;
 
 move_peg(color, cord);
 while (!done)
 {
     readjoystick();
     if (joy_fire && joy_down)  // end game
       done=1;
     else
     if (joy_fire && joy_up)   // menu
     {
        done=do_menu();
        if (done==1)
        {
           game=1;
           done=0;
        }
        else
        if (done==2)
        {
           game=2;
           done=0;
        }
        else
        if (done==5)    //about
        {
           do_about(0);
           do_about(1);
           done=0;
        }
        else
        if (done==4)    // quit
          done=1;
        else
        if (done==3)    //new game
        {
          do_new_game();
          do_init_game();
          read_qstick();
          color=RED;
          cord=4;
          done=0;
          if (offsety==0)
             offsety=199;
          else
             offsety=0;
          move_peg(color, cord);  
        }
        else
          done=0;  
        read_qstick();
        joy_fire=joy_up=0;
     }
     else
     if (joy_right)
     {
       ++cord;
       if (cord > 8)
         cord=0;
       move_peg(color, cord);  
     }
     else
     if (joy_left)
     {
       --cord;
       if (cord < 0)
         cord=8;
       move_peg(color, cord);  
     }
     else
     if (joy_fire && !joy_left && !joy_right && !joy_up && !joy_down)
     {
       valid=drop_peg(cord, color);
       if (valid != -1)
       {
         --total_pegs;
         win=check_win(color);      // check for a win
         if (win !=-1)
             do_game_over(win);
         else
         {
            win=check_cross_win(color);
            if (win !=-1)
               do_game_over(win);
         }

         if (total_pegs == 0)
         {
           do_game_over(TIE);
           cord=4;
         }
         else
         {
           if (color==RED)
             color=BLUE;
           else
             color=RED;
           cord=4;
           if (game==1 && color== BLUE)   // computer's mind
           { 
             win=comp_check_cross(3);
             if (win != -1)
               win=do_block_player(CROSS);
             if (win == -1)
             {
               win=comp_check_down(3);
               if (win != -1)
                 win=do_block_player(DOWN);
               else
               {
                 win=check_comp_rdiagonal(3);
                 if (win != -1)
                   win=do_block_player(RDIAGONAL);
                 if (win==-1)
                 {
                   win=check_comp_ldiagonal(3);
                   if (win != -1)
                     win=do_block_player(LDIAGONAL);
                 }
               }
             }               
             
             if (win==-1)
             {
               win=comp_check_cross(2);
               if (win != -1)
                 win=do_block_player(CROSS);
               if (win == -1)
               {
                 win=comp_check_down(2);
                 if (win != -1)
                   win=do_block_player(DOWN);
               }
             }               

             if (win==-1)
               do_random_move();
             win=check_win(BLUE);      // check for computer win
             if (win !=-1)
               do_game_over(win);
             else
             {
               win=check_cross_win(BLUE);
               if (win !=-1)
                 do_game_over(win);
             }
             cord=4;
             color=RED;
           }   
         move_peg(color, cord);
         }
       }  
     }
  }
}  

void do_random_move()
{
   short i, j, low=0, num_pegs[9];
   
   for (i=0; i < 9; i++)
   {
     num_pegs[i]=0;
     for (j=0; j < 6; j++)
       if (board[j][i] > 0)
         ++num_pegs[i];
   }

   j=0;
pearl:
   i=0;   
   low=-1;
   while (i < 9)
   {
      if (num_pegs[i++] == j)
        low=i;
   }
   if (low == -1)
   {
     ++j;
     if (j==9)
       goto dead_game;
     goto pearl;
   }
   --low;
   move_peg(BLUE, low);  
   i=drop_peg(low, BLUE);
   goto next;
dead_game:
   do_game_over(TIE);
next: ;
}

short do_block_player(type)
short type;
{
    short cord;
    
    if (type==CROSS)
    {
      if (board[Comp_stuff.firstx][Comp_stuff.firsty-1] == 0 &&
          Comp_stuff.firsty-1 >= 0)
         cord=Comp_stuff.firsty-1;
      else
      if (board[Comp_stuff.lastx][Comp_stuff.lasty+1] == 0 &&
          Comp_stuff.lasty+1 < 9)
         cord=Comp_stuff.lasty+1;
      else
         return(-1);
    }
    else
    if (type==DOWN)
    {
      if (board[Comp_stuff.firstx-1][Comp_stuff.firsty] == 0 &&
          Comp_stuff.firstx-1 >= 0)
         cord=Comp_stuff.firsty;
      else
      if (board[Comp_stuff.lastx+1][Comp_stuff.lasty] == 0 && 
          Comp_stuff.lastx+1 < 6)
         cord=Comp_stuff.lasty;
      else
         return(-1);
    }
    else
    if (type==RDIAGONAL)
    {
      if (board[Comp_stuff.firstx-1][Comp_stuff.firsty+1] == 0 &&
          Comp_stuff.firstx-1 >= 0 &&
          board[Comp_stuff.firstx-1][Comp_stuff.firsty+2] != 0)
         cord=Comp_stuff.firsty+1;
      else
      if (board[Comp_stuff.lastx+1][Comp_stuff.lasty-1] == 0 && 
          Comp_stuff.lastx+1 < 6 && Comp_stuff.lasty-1 >=0 &&
          board[Comp_stuff.lastx+1][Comp_stuff.lasty-2] != 0)
         cord=Comp_stuff.lasty-1;
      else
         return(-1);
    }
    else
    if (type==LDIAGONAL)
    {
      if (board[Comp_stuff.firstx+1][Comp_stuff.firsty+1] == 0 &&
          Comp_stuff.firstx+1 < 6 && Comp_stuff.firsty+1 <9)
         cord=Comp_stuff.firsty+1;
      else
      if (board[Comp_stuff.lastx-1][Comp_stuff.lasty-1] == 0 && 
          Comp_stuff.lastx-1 >= 0 && Comp_stuff.lasty-1 >= 0)
         cord=Comp_stuff.lasty-1;
      else
         return(-1);
    }
    
    move_peg(BLUE, cord);  
    cord=drop_peg(cord, BLUE);
    return(0);
}    

void do_init_game()
{
   register short i, j;
   
   total_pegs=54;
   SetRast(&rp2, 0);
   for (i=0; i<8; i++)
     for (j=0; j<11; j++)
       board[i][j]=0;
}

short drop_peg(cord, color)
short cord, color;
{
   short i, box;
   
   box=get_box(cord, color);
   read_qstick();
   if (box == -1)
     return(-1);
   for (i=0; i< dropy[box]; i++)
      ScrollRaster(&rp2, 0, -1, drop[cord], 0+offsety, drop[cord]+25,
       dropy[box]+30+offsety);
   return(0);
}

short get_box(cord, color)
short cord, color;
{
   register short i;
   
   for (i=5; i > -1; i--)
     if (board[i][cord] == 0)
     {
       board[i][cord]=color;
       return(i);
     }
   return(-1);
}
   
void do_about(page)
short page;
{
  	  short i;
	  w=0;
     
     if (!page)
     {
       for (i=0; i < 200; i++)
       {
         swapPointers();
         ri.RxOffset = 0;
         ri.RyOffset = i;
	      remakeView();
	      w ^= 1;
       }
       read_qstick();
       while (!joy_fire)
          readjoystick();
     }
     else
     {
       for (i=0; i < 200; i++)
       {
         swapPointers();
         ri.RxOffset = 0;
         ri.RyOffset = 199-i;
	      remakeView();
	      w ^= 1;
       }
     }
}  

void do_game_over(type)
short type;
{
   short i;
   
   read_qstick();
   if (type==TIE)
   {
      SetAPen(&rp, 7);
      Move(&rp, 250, 138);
      Text(&rp, "Tie Game", 8);
   } 
   else
   if (type==RED)
   {
      SetAPen(&rp, 5);
      Move(&rp, 250, 138);
      Text(&rp, "Red  Win", 8);
   } 
   else
   if (type==BLUE)
   {
      SetAPen(&rp, 4);
      Move(&rp, 250, 138);
      Text(&rp, "Blue Win", 8);
   } 

   SetAPen(&rp2, 6);
   Move(&rp2, 250, 170+offsety);
   Text(&rp2, "Hit Fire", 8);

   joy_fire=0;
   while (!joy_fire)
   {
     readjoystick();
     i=0;
     while (!joy_fire && i++ < 31)
     {
      readjoystick();
      ScrollRaster(&rp,  0, -1, 248, 130, 315, 170);
      ScrollRaster(&rp2, 0,  1, 248, 130+offsety, 315, 170+offsety);
      Delay(1);
     }
     i=0;
     while (!joy_fire && i++ < 31)
     {
      readjoystick();
      ScrollRaster(&rp,  0,  1, 248, 130, 315, 170);
      ScrollRaster(&rp2, 0, -1, 248, 130+offsety, 315, 170+offsety);
      Delay(1);
     }
   }
   SetAPen(&rp2,0);                 
	RectFill(&rp2,247,130+offsety,316,170+offsety);
   SetAPen(&rp,0);                 
	RectFill(&rp,247,130,316,170);
   read_qstick();
   do_new_game();
   do_init_game();
   if (offsety==0)
        offsety=199;
   else
        offsety=0;
   move_peg(RED, 4);  
}

short check_win(player)
short player;
{
   short i,j, count;
   
   for (i=0;i<6;i++)   // cross checking
   {
     count=0;
     for (j=0;j<9;j++)
     {
       if (board[i][j]==player)
          ++count;
       else
          count=0;

       if (count==4)
        return(player);
     }
   }

   for (i=0;i<9;i++)   // down checking
   {
     count=0;
     for (j=0;j<6;j++)
     {
       if (board[j][i]==player)
          ++count;
       else
          count=0;
       if (count==4)
        return(player);         
     }
   }
   return(-1);
}

void print_board()
{
   short i, j;
      
   for (i=0;i<6;i++)
   {
     for (j=0; j<9;j++)
       printf("%d ", board[i][j]);
     printf("\n");
   }
}  
   
short check_cross_win(player)
short player;
{
   short i,j, count, temp;
   
   for (i=4; i < 12; i++)  //  '/' right hatch check
   {
      count=0;
      temp=i;
      for (j=-1; j < 7; j++)
      {
         if (board[j+1][temp-1] == player)
           ++count;
         else
           count=0;
         --temp;
         if (count==4)
           return(player);
      }
    }

   for (i=4; i < 12; i++)  // '\' left hatch check
   {
      count=0;
      temp=i;
      for (j=6; j > -1; j--)
      {
         if (board[j-1][temp-1] == player)
           ++count;
         else
           count=0;
         --temp;
         if (count==4)
           return(player);
      }
    }
    return(-1);
}  

short comp_check_cross(num)  // num is the peg count
short num;
{
   short count, i, j, first=0;
   
   for (i=0;i<6;i++)   // cross checking
   {
     count=first=0;
     for (j=0;j<9;j++)
     {
       if (board[i][j]==RED)
       {
          ++count;
          if (!first)
          {
             Comp_stuff.firstx=i;
             Comp_stuff.firsty=j;
             first=1;
          }
          else
          {
            Comp_stuff.lastx=i;
            Comp_stuff.lasty=j;
          }
          if (count==num)
             return(num);
       }
       else
         count=0;
     }
   }
   return(-1);
}

short comp_check_down(num)  // num is the peg count
short num;
{
   short i, j, count, first;
   
   for (i=0;i<9;i++)   // down checking
   {
     count=first=0;
     for (j=0;j<6;j++)
     {
       if (board[j][i]==RED)
       {
          ++count;
          if (!first)
          {
             Comp_stuff.firstx=j;
             Comp_stuff.firsty=i;
             first=1;
          }
          else
          {
            Comp_stuff.lastx=j;
            Comp_stuff.lasty=i;
          }
          if (count==num)
            return(num);         
       }
       else
         count=0;
    }
   }
   return(-1);
}


short check_comp_rdiagonal(num)
short num;
{
   short i, j, count, first=0, temp;
   
   for (i=4; i < 12; i++)  //  '/' right hatch check
   {
      count=0;
      temp=i;
      for (j=-1; j < 7; j++)
      {
         if (board[j+1][temp-1] == RED)
         {
           ++count;
           if (!first)
           {
             Comp_stuff.firstx=j+1;
             Comp_stuff.firsty=temp-1;
             first=1;
           }
           else
           {
             Comp_stuff.lastx=j+1;
             Comp_stuff.lasty=temp-1;
           }
           if (count==num)
             return(num);         
         }
         else    
           count=0;
         --temp;
      }
   }
   return(-1);
}

short check_comp_ldiagonal(num)
short num;
{
   short i, j, count, first=0, temp;
   
   for (i=4; i < 12; i++)  // '\' left hatch check
   {
      count=0;
      temp=i;
      for (j=6; j > -1; j--)
      {
         if (board[j-1][temp-1] == RED)
         {
           ++count;
           if (!first)
           {
             Comp_stuff.firstx=j-1;
             Comp_stuff.firsty=temp-1;
             first=1;
           }
           else
           {
             Comp_stuff.lastx=j-1;
             Comp_stuff.lasty=temp-1;
           }
           if (count==num)
             return(num);         
         }
         else    
           count=0;
         --temp;
      }
   }
   return(-1);
}

