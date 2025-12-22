/* Labyrinth, a game from Ventzislav Tzvetkov © 2002 The maze algorythm*/
/* is from an old computer magazine.                                   */
/* All this source is free to use. I am not responsible for any damage */
/* this product may make.                                              */


#include <intuition/intuition.h>

#include <hardware/custom.h> /* These twos  are  for  */
#include <hardware/cia.h>   /*  the Joystick handler */
#include <stdio.h>

#include <libraries/asl.h>

int x[]={2,0,-2,0};
int y[]={0,-2,0,2};

#define FIRE   1
#define RIGHT  2
#define LEFT   4
#define DOWN   8
#define UP    16

UBYTE Joystick();

/* This will automatically be linked to the Custom structure: */
extern struct Custom custom;

/* This will automatically be linked to the CIA A (8520) chip: */
extern struct CIA ciaa;

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

struct Screen *my_screen;
struct Window *my_window;

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
  "Copyright 1988-2002", /* IText, the text . */
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

struct NewWindow my_new_window=
{
  0,            /* LeftEdge    x position of the window. */
  0,            /* TopEdge     y position of the window. */
  320,           /* Width      320 pixels wide. */
  256,           /* Height     256 lines high. */
  0,             /* DetailPen  Text should be drawn with colour reg. 0 */
  1,             /* BlockPen   Blocks should be drawn with colour reg. 1 */
  MENUPICK|RAWKEY, /* IDCMPFlags. */
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
    struct ScreenModeRequester *ScreenRequest;
ULONG ModeID;
BOOL close=FALSE,NewGame=FALSE;
int h=0,w=14,dx,dy,c,d,a,b,s,sw,code;
UBYTE k;

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


    if (ScreenRequest=(struct ScreenModeRequester *)AllocAslRequestTags(
                                 ASL_ScreenModeRequest,
                                 ASLSM_TitleText, (ULONG) "Pick 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 8,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
    {
    if (!AslRequestTags(ScreenRequest,    ASLSM_TitleText, (ULONG) "Pick 4Bit 320x256 Screenmode ",
                                 ASLSM_PositiveText, (ULONG) "Ok",
                                 ASLSM_NegativeText, (ULONG) "Cancel",
                                 ASLSM_MinWidth, 320,
                                 ASLSM_MinHeight, 256,
                                 ASLSM_MinDepth, 4,
                                 ASLSM_MaxDepth, 8,
                                 TAG_DONE))
        {
        printf("Error: Invalid ScreenMode\n");
        exit(-1);
        } else {
            ModeID=ScreenRequest->sm_DisplayID;}
    }


 my_screen = (struct Screen *)
 OpenScreenTags( NULL, SA_DisplayID,ModeID,SA_Width,320,
 SA_Height, 256, SA_Depth,     4, SA_Title,"Labyrinth by Ventzislav Tzvetkov",TAG_DONE );

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
 SetRGB4( &my_screen->ViewPort, 8,  6,11,0  );
 SetRGB4( &my_screen->ViewPort, 9,  1,7,0   );
 SetRGB4( &my_screen->ViewPort,10,  5,11,12 );
 SetRGB4( &my_screen->ViewPort,11,  3,6,7   );
 SetRGB4( &my_screen->ViewPort,12,  0,7,11  );
 SetRGB4( &my_screen->ViewPort,13,  0,4,8   );
 SetRGB4( &my_screen->ViewPort,14,  14,8,8  );
 SetRGB4( &my_screen->ViewPort,15,  15,15,15  );
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
while (close==FALSE){NewGame=FALSE;
SetAPen(my_window->RPort,w);
RectFill(my_window->RPort,0,0,319,254);
a=1;
b=12;

 SetRGB4( &my_screen->ViewPort, 1,  0,0,0 );
 SetRGB4( &my_screen->ViewPort, 2, 0,0,0 );
 SetRGB4( &my_screen->ViewPort, 3,  0,0,0 );
 SetRGB4( &my_screen->ViewPort, 4, 0,0,0 );
 SetRGB4( &my_screen->ViewPort,14,  0,0,0 );
k=0;
while (1)
{
c=a+2*x[k];d=b+2*y[k];
sw=ReadPixel( my_window->RPort, c,d);
if (!(c<1 || c>319 || d<12 || d>255)) if (sw==w) {SetAPen(my_window->RPort,k+1);
 WritePixel( my_window->RPort, c,d );
 SetAPen(my_window->RPort,h);
 WritePixel( my_window->RPort, a+x[k],b+y[k]);
 WritePixel( my_window->RPort, a+x[k]+1,b+y[k]);
 WritePixel( my_window->RPort, a+x[k],b+y[k]+1);
 WritePixel( my_window->RPort, a+x[k]+1,b+y[k]+1);
 a=c;b=d;k=(rand() % 4000)/1000;s=k;continue;}
 k=(k+1)*(k<3);
if (k!=s) continue;
k=ReadPixel( my_window->RPort,a,b);k--;
SetAPen(my_window->RPort,h);
WritePixel( my_window->RPort, a,b );
WritePixel( my_window->RPort, a+1,b );
WritePixel( my_window->RPort, a,b+1 );
WritePixel( my_window->RPort, a+1,b+1 );
if (k<4) {a=a-2*x[k]; b=b-2*y[k];k=(rand() % 400)/100;s=k; continue;}
SetAPen(my_window->RPort,h);
break;
}
 SetRGB4( &my_screen->ViewPort, 1,  8,0,0 );
 SetRGB4( &my_screen->ViewPort, 2, 15,0,0 );
 SetRGB4( &my_screen->ViewPort, 3,  0,8,0 );
 SetRGB4( &my_screen->ViewPort, 4, 15,1,5 );
 SetRGB4( &my_screen->ViewPort,14,  14,8,8  );
a=1,b=12;
SetAPen(my_window->RPort,7);
WritePixel( my_window->RPort, 317,12 );
WritePixel( my_window->RPort, 318,12 );
WritePixel( my_window->RPort, 317,13 );
WritePixel( my_window->RPort, 318,13 );
SetAPen(my_window->RPort,15);

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {
WritePixel( my_window->RPort, a,b );
WritePixel( my_window->RPort, a+1,b );
WritePixel( my_window->RPort, a,b+1 );
WritePixel( my_window->RPort, a+1,b+1 );

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */
  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   {
    if (close)
       break;

      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if((my_message->Class == MENUPICK && my_message->Code == 63552) ||
 my_message->Code==69)
       close=TRUE;

if(my_message->Class == MENUPICK && my_message->Code == 63520)
AutoRequest( my_window, &my_body_text, NULL, &my_ok_text, NULL, NULL, 220, 72);

if(my_message->Class == MENUPICK && my_message->Code == 63488)
{ NewGame=TRUE;} /* New */
code=my_message->Code;
ReplyMsg( my_message );
}
if ((Joystick() & LEFT)  || code==79) dx=-2;
if ((Joystick() & RIGHT) || code==78) dx=2;
if ((Joystick() & DOWN) || code==77) dy=2;
if ((Joystick() & UP) || code==76) dy=-2;
Delay(1);
k=ReadPixel( my_window->RPort,a+dx,b+dy);
if (k==w || a+dx<0 || a+dx>319 || b+dy<12 || b+dy>254) dx=dy=0;else {SetAPen(my_window->RPort,0);WritePixel( my_window->RPort, a,b );
WritePixel( my_window->RPort, a+1,b );
WritePixel( my_window->RPort, a,b+1 );
WritePixel( my_window->RPort, a+1,b+1 );
a+=dx;b+=dy;SetAPen(my_window->RPort,15);}
if (a==317 && b==12) NewGame=TRUE;
if (close||NewGame) break;
  }
if (close) break;
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

UBYTE Joystick()
{
  UBYTE data = 0;
  UWORD joy;
  /* PORT 2 ("JOYSTICK PORT") */
    joy = custom.joy1dat;
    data += !( ciaa.ciapra & 0x0080 ) ? FIRE : 0;

  data += joy & 0x0002 ? RIGHT : 0;
  data += joy & 0x0200 ? LEFT : 0;
  data += (joy >> 1 ^ joy) & 0x0001 ? DOWN : 0;
  data += (joy >> 1 ^ joy) & 0x0100 ? UP : 0;

  return( data );
}
