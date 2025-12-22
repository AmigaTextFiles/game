/* Seachess by Ventzislav Tzvetkov © 1995-2002                         */
/* All this source is free to use. I am not responsible for any damage */
/* this product may make.                                              */
/* This new version now compiles with VBCC 0.8 so here it need the     */
/* functions to be predefined.                                         */

#include <intuition/intuition.h>

void table();
void check();
void drawx();
void drawcer();
void chm();

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

struct Screen *my_screen;
struct Window *my_window;

UBYTE playerpoints=48,computerpoints=48,ca[3][3]={0,0,0,0,0,0,0,0,0},moves;
BOOL coma,close;
UBYTE cx[]={0,1,2,3,4,5,6,7,8,9,10,11,12,12,13,14,14,15,15,16,16,16,17,17,17,17},
   cy[]={14,14,14,14,13,13,13,12,12,11,11,10,10,9,8,7,6,6,5,4,3,3,2,1,0,0};

SHORT my_points[]=
{
 260,20,260,200,50,200,50,20,260,20,120,20,120,200,190,200,190,20,260,20,260,80,50,80,50,140,260,140
};
struct IntuiMessage *my_message;

/* The body text for the about info: */
struct IntuiText my_body_text=
{
  0,       /* FrontPen, colour 0 (blue). */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  15,      /* LedtEdge, 15 pixels out. */
  5,       /* TopEdge, 5 lines down. */
  NULL,    /* ITextFont, default font. */
  "Copyright 1995-2002", /* IText, the text . */
  NULL,    /* NextText, no more IntuiText structures link. */
};

/* The OK text: */
struct IntuiText my_ok_text=
{
  0,       /* FrontPen, colour 0 (blue). */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  6,       /* LedtEdge, 6 pixels out. */
  3,       /* TopEdge, 3 lines down. */
  NULL,    /* ITextFont, default font. */
  "OK",    /* IText, the text that will be printed. */
  NULL,    /* NextText, no more IntuiText structures link. */
};
 
struct Border my_border=
{
  0, 15,        /* LeftEdge, TopEdge. */
  3,           /* FrontPen, colour register 3. */
  0,           /* BackPen, for the moment unused. */
  JAM1,        /* DrawMode, draw the lines with colour 3. */
  14,           /* Count, 14 pair of coordinates in the array. */
  my_points,   /* XY, pointer to the array with the coordinates. */
  NULL,        /* NextBorder, no other Border structures are connected. */
};
 
struct TextAttr my_font=
{
  "topaz.font",                 /* Topaz font. */
  8,                            /*                 */
    NULL,
 FPF_ROMFONT                   /* Exist in ROM. */
};
 
struct IntuiText my_intui_text=
{
  5,         /* FrontPen, colour register 2. */
  0,         /* BackPen, colour register 3. */
  JAM2,      /* DrawMode, draw the characters with colour 2, */
             /* on a colour 3 background. */
  0, 0,      /* LeftEdge, TopEdge. */
  &my_font,  /* ITextFont, use my_font. */
  NULL,   /* IText, the text that will be printed. */
             /* (Remember my_text = &my_text[0].) */
  NULL       /* NextText, no other IntuiText structures are */
             /* connected. */
};
 
struct NewScreen my_new_screen=
{
  0,            /* LeftEdge  Should always be 0. */
  0,            /* TopEdge   Top of the display.*/
  320,          /* Width     We are using a low-resolution screen. */
  256,          /* Height    Non-Interlaced PAL (European) display. */
  3,            /* Depth     8 colours. */
  0,            /* DetailPen Text should be drawn with colour reg. 0 */
  1,            /* BlockPen  Blocks should be drawn with colour reg. 1 */
  NULL,         /* ViewModes No special modes. (Low-res, Non-Interlaced) */
  CUSTOMSCREEN, /* Type      Your own customized screen. */
  NULL,         /* Font      Default font. */
  "Seachess by Ventzislav Tzvetkov",/* Title The screen' title. */
  NULL,         /* Gadget    Must for the moment be NULL. */
  NULL          /* BitMap    No special CustomBitMap. */
};

struct NewWindow my_new_window=
{
  0,            /* LeftEdge    x position of the window. */
  0,            /* TopEdge     y position of the window. */
  320,           /* Width      320 pixels wide. */
  256,           /* Height     256 lines high. */
  0,             /* DetailPen  Text should be drawn with colour reg. 0 */
  1,             /* BlockPen   Blocks should be drawn with colour reg. 1 */
  MOUSEMOVE|MENUPICK|MOUSEBUTTONS, /* IDCMPFlags. */
  SMART_REFRESH|BACKDROP|BORDERLESS|ACTIVATE, /* Flags       Intuition should refresh the window. */ 
  NULL,          /* FirstGadget No Custom Gadgets. */
  NULL,          /* CheckMark   Use Intuition's default CheckMark (v). */
  NULL,          /* Title       Title of the window. */
  NULL,          /* Screen      Connected to the Workbench Screen. */
  NULL,          /* BitMap      No Custom BitMap. */
  0,0,0,0,
  CUSTOMSCREEN   /* Type        Connected to custom Screen. */
};

struct IntuiText my_third_text=
{
  2,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  NULL,       /* TextAttr, default font. */
  "Quit",     /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_third_item=
{
  NULL,            /* NextItem, not linked anymore. */
  0,               /* LeftEdge, 0 pixels out. */
  20,              /* TopEdge, 10 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude. NONE */
  (APTR) &my_third_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'Q',               /* Command, no command-key sequence. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText my_second_text=
{
  2,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  NULL,       /* TextAttr, default font. */
  "About",    /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_second_item=
{
  &my_third_item,  /* NextItem, linked to the third item. */
  0,               /* LeftEdge, 0 pixels out. */
  10,              /* TopEdge, 10 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, mutualexclude the first item only. */
  (APTR) &my_second_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'A',               /* Command, no command-key sequence. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText my_first_text=
{
  2,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  NULL,       /* TextAttr, default font. */
  "New Game", /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_first_item=
{
  &my_second_item, /* NextItem, linked to the second item. */
  0,               /* LeftEdge, 0 pixels out. */
  0,               /* TopEdge, 0 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &my_first_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'N',               /* Command, no command-key sequence. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct Menu my_menu=
{
  NULL,          /* NextMenu, no more menu structures. */
  0,             /* LeftEdge, left corner. */
  0,             /* TopEdge, for the moment ignored by Intuition. */
  65,            /* Width, 50 pixels wide. */
  0,             /* Height, for the moment ignored by Intuition. */
  MENUENABLED,   /* Flags, this menu will be enabled. */
  "Seachess",    /* MenuName, the string. */
  &my_first_item /* FirstItem, pointer to the first item in the list. */
};


main()
{

  UBYTE h,loop;

  SHORT x,y;
 
/* Open the Intuition library: */
  IntuitionBase = (struct IntuitionBase *)
    OpenLibrary( "intuition.library", 0 );
  if( !IntuitionBase )
    exit();
/* Open the Graphics library: */
  GfxBase = (struct GfxBase *)
    OpenLibrary( "graphics.library", 0 );
  if( !GfxBase )
  {
  CloseLibrary( IntuitionBase );
  exit();    
  }
/* We will now try to open the screen: */


 my_screen = (struct Screen *) OpenScreen (&my_new_screen);
  if( !my_screen )
  {
   CloseLibrary( GfxBase );
   CloseLibrary( IntuitionBase );
   exit();
   }
 SetRGB4( &my_screen->ViewPort, 0,  0,0,0 );
 SetRGB4( &my_screen->ViewPort, 1,  8,0,0 );
 SetRGB4( &my_screen->ViewPort, 2, 15,0,0 );
 SetRGB4( &my_screen->ViewPort, 3,  0,8,0 );
 SetRGB4( &my_screen->ViewPort, 4, 15,1,5 );
 SetRGB4( &my_screen->ViewPort, 5,  0,0,8 );
 SetRGB4( &my_screen->ViewPort, 6,12,12,12);
 SetRGB4( &my_screen->ViewPort, 7,15,11,0 );

 my_new_window.Screen = my_screen;
 my_window = (struct Window *) OpenWindow( &my_new_window );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    
    /* Close the Intuition Library since we have opened it: */
   CloseScreen( my_screen );
   CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase );
   exit();  
  }
SetMenuStrip( my_window, &my_menu );
 table();

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
        if (coma)
        chm();    

    /* Wait until we have recieved a message: */
    Wait( 1 << my_window->UserPort->mp_SigBit );

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    if (close)
       break;

    if (coma)
        chm();    


      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */
              
        x     = my_message->MouseX; /* X position of the mouse. */
        y     = my_message->MouseY; /* Y position of the mouse. */   

if(my_message->Class == MENUPICK && my_message->Code == 63552)
       close=TRUE;

if(my_message->Class == MENUPICK && my_message->Code == 63520)
AutoRequest( my_window, &my_body_text, NULL, &my_ok_text, NULL, NULL, 220, 72);

if(my_message->Class == MENUPICK && my_message->Code == 63488)
{
playerpoints=computerpoints=48;
table();
}
if(x>50 && x<262 && y>35 && y<216 && (my_message->Code == SELECTDOWN))
{
   if(x<120)       /* Check on which square you pressed the button */
   h=0;
   if(x>119 && x<191)
   h=1;
   if(x>190)
   h=2;
   if(y<95)
   loop=0;
   if(y>94 && y<156)
   loop=1;
   if(y>155)
   loop=2;
   if (!ca[h][loop])
   drawx(h,loop);
   }
break;
}
  }

/* We should always close the screens we have opened before we leave: */
 ClearMenuStrip( my_window );

 CloseWindow ( my_window ); 

 CloseScreen( my_screen );
  
/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit();
}

void table()
{  
 SetAPen(my_window->RPort,0);
 RectFill(my_window->RPort,0,12,319,255);
 DrawBorder( my_window->RPort, &my_border, 0, 0 );
 my_intui_text.IText="Player";
 my_intui_text.FrontPen=5;
 PrintIText( my_window->RPort, &my_intui_text ,9,235);
 my_intui_text.IText=&playerpoints;
 my_intui_text.FrontPen=4;
 PrintIText( my_window->RPort, &my_intui_text ,63,235 );
 my_intui_text.IText="Computer";
 my_intui_text.FrontPen=7; 
 PrintIText( my_window->RPort, &my_intui_text ,232,235 );
 my_intui_text.IText=&computerpoints;
 my_intui_text.FrontPen=6;
 PrintIText( my_window->RPort, &my_intui_text ,303,235 );
 ca[0][0]=ca[0][1]=ca[0][2]=ca[1][0]=ca[1][1]=ca[1][2]=ca[2][0]=ca[2][1]=ca[2][2]=0;
moves=0;
return;
}

void drawx(k,l) /* Draws the X */
{
register UBYTE d=(k*70+85)-17,v=(l*60+65)-15;
   SetAPen(my_window->RPort,5);
   Move ( my_window->RPort,d,v);
   Draw ( my_window->RPort,d+30,v+30);
   Move ( my_window->RPort,d,v+30);
   Draw ( my_window->RPort,d+30,v);
ca[k][l]=2;
moves++;
coma=1;
check();
}
void drawo(a,e) /* Draws O */
{
register UBYTE d=a*70+85,v=e*60+65,i;
   SetAPen( my_window->RPort,7);
   for(i=0;i<26;i++)
   {
   WritePixel(my_window->RPort,d+cx[i],v+cy[i]);
   WritePixel(my_window->RPort,d-cx[i],v+cy[i]);
   WritePixel(my_window->RPort,d+cx[i],v-cy[i]);
   WritePixel(my_window->RPort,d-cx[i],v-cy[i]);
   }
   ca[a][e]=1;
   moves++;
   coma=0;
   check();
}

void check() /* Checks if someone win */
{
register UBYTE p,i,che=0;
   for (p=1;p<3;p++)
 {
     for(i=0;i<3;i++)
   {
      if (ca[i][0]==p && ca[i][1]==p && ca[i][2]==p)
   {
      drawcer(i,i,0,2);
     che=p;
   }
     if (ca[0][i]==p && ca[1][i]==p && ca[2][i]==p)
   {
      drawcer(0,2,i,i);
      che=p;
   }
      }
   if (ca[0][0]==p && ca[1][1]==p && ca[2][2]==p)
   {
      drawcer(0,2,0,2);
      che=p;
   }
   if (ca[2][0]==p && ca[1][1]==p && ca[0][2]==p)
   {
      drawcer(2,0,0,2);
      che=p;
   }
if (che)
break;
}
if (che==1)
   {
      SetAPen(my_window->RPort,4);
      Move(my_window->RPort,107,19);
      Text(my_window->RPort,"Computer win!",13);
      coma=0;
      computerpoints++;     
      Delay(50*3);     
      table();

}
if (che==2)
 {
    SetAPen(my_window->RPort,7);
    Move(my_window->RPort,128,19);
    Text(my_window->RPort,"You win!",8);
    for(i=0;i<110;i++)
    coma=1;
    playerpoints++;
    Delay(50*3);   
    table();
 }
if (moves==9)
 {
   SetAPen(my_window->RPort,2);
   Move(my_window->RPort,136,19);
   Text(my_window->RPort,"Draw!",5);
   Delay(50*3);
   coma=1;
   table();
 }

if (playerpoints>56)
 {
 SetAPen(my_window->RPort,10);
 Move(my_window->RPort,90,19);
 Text(my_window->RPort,"CONGRATULATIONS!",16);
 SetAPen(my_window->RPort,3);
 Move(my_window->RPort,72,27);
 Text(my_window->RPort,"You beat the Computer.",21);
 Delay(50*4);
 playerpoints=computerpoints=48;
 table(); }

if (computerpoints>56)
 {SetAPen(my_window->RPort,5);
 Move(my_window->RPort,68,19);
 Text(my_window->RPort,"The Computer beat You!",21);
 SetAPen(my_window->RPort,5);
 Move(my_window->RPort,68,27);
 Text(my_window->RPort,"Better luck next time",21);
 Delay(50*4);
 playerpoints=computerpoints=48;
 table();}
}

void drawcer(f,s,t,c) /* Draws Line of won */
{
f=f*70+85;
t=t*60+65;
s=s*70+85;
c=c*60+65;
   SetAPen (my_window->RPort,6);
   Move( my_window->RPort,f,t);
   Draw( my_window->RPort,s,c);
   Move( my_window->RPort,f,t+1);
   Draw( my_window->RPort,s,c+1);
   Move( my_window->RPort,f+1,t);
   Draw( my_window->RPort,s+1,c);
}

void chm() /* Movings of computer */
{
register UBYTE loop,h=1,v=1;
   for(loop=0;loop<3;loop++)
   {

      if (ca[loop][0]==1 && ca[loop][1]==1 && !ca[loop][2])
      {
       drawo(loop,2);
       break;
        }
       if (ca[loop][0]==1 && ca[loop][2]==1 && !ca[loop][1])
       {
        drawo(loop,1);
       break;
        }
      if (ca[loop][1]==1 && ca[loop][2]==1 && !ca[loop][0])
      {
         drawo(loop,0);
         break;
      }

      if (ca[0][loop]==1 && ca[1][loop]==1 && !ca[2][loop])
   {
           drawo(2,loop);
           break;
   }
          if (ca[0][loop]==1 && ca[2][loop]==1 && !ca[1][loop])
    {
       drawo(1,loop);
       break;
    }
        if (ca[1][loop]==1 && ca[2][loop]==1 && !ca[0][loop])
        {
         drawo(0,loop);
         break;
         }
         if(ca[0][0]==1 && ca[1][1]==1 && !ca[2][2])
           {
            drawo(2,2);
            break;
         }
            if(ca[2][0]==1 && ca[1][1]==1 && !ca[0][2])
         {
           drawo(0,2);
           break;
         }
            if(ca[0][2]==1 && ca[1][1]==1 && !ca[2][0])
          {
           drawo(2,0);
           break;
         }
            if(ca[2][2]==1 && ca[1][1]==1 && !ca[0][0])
            {
               drawo(0,0);
               break;
              }
            }
            for(loop=0;loop<3;loop++)
 {
      if (ca[loop][0]==2 && ca[loop][1]==2 && !ca[loop][2])
      {
       drawo(loop,2);
       break;
        }
       if (ca[loop][0]==2 && ca[loop][2]==2 && !ca[loop][1])
       {
        drawo(loop,1);
       break;
        }
      if (ca[loop][1]==2 && ca[loop][2]==2 && !ca[loop][0])
      {
         drawo(loop,0);
         break;
      }

      if (ca[0][loop]==2 && ca[1][loop]==2 && !ca[2][loop])
   {
           drawo(2,loop);
           break;
   }
          if (ca[0][loop]==2 && ca[2][loop]==2 && !ca[1][loop])
    {
       drawo(1,loop);
       break;
    }
        if (ca[1][loop]==2 && ca[2][loop]==2 && !ca[0][loop])
        {
         drawo(0,loop);
         break;
         }
         if(ca[0][0]==2 && ca[1][1]==2 && !ca[2][2])
           {
            drawo(2,2);
            break;
         }
            if(ca[2][0]==2 && ca[1][1]==2 && !ca[0][2])
         {
           drawo(0,2);
           break;
         }
            if(ca[0][2]==2 && ca[1][1]==2 && !ca[2][0])
          {
           drawo(2,0);
           break;
         }
            if(ca[2][2]==2 && ca[1][1]==2 && !ca[0][0])
            {
               drawo(0,0);
               break;
                 }
      }
            while (coma)
            {
            if (!ca[h][v])
            drawo(h,v);
            h = rand() % 3;
            v = rand() % 3;
           }

}

