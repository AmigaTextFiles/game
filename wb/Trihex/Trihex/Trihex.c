/* Trihex by Ventzislav Tzvetkov © 2002                                */
/* All this source is free to use. I am not responsible for any damage */
/* this product may make. Version 1.1 Fixes some graphic bugs.         */
/* vc Trihex.c -o Trihex to compile it.                                */

#include <stdio.h> /* I use sprintf() for the statistics. */

#include <intuition/intuition.h> /* Intuition for the display */

#define Win 1

#define Draw 2

#define Human 0

#define Amiga 1

struct IntuitionBase *IntuitionBase;

struct GfxBase *GfxBase;

struct Window *my_window;

struct IntuiMessage *my_message;

struct TextAttr my_font=
{
  "topaz.font",                 /* Topaz font. */
  8,                            /*                 */
    0,
 FPF_ROMFONT                   /* Exist in ROM. */
};

/* Function Protos: */

/* Draws pul at position i for PlayerNo. */
char Pul(char i, BOOL PlayerNo); 

/* Makes decision for PlayerNo */
char ComputerMove(BOOL PlayerNo);

BOOL Player=0; /* First Player for 2 players BOOL variable is possible.*/

/* Some coordinates, x and y at 1 place in 1 variable. */
UBYTE XY[]={0,0,70,82,90,82,80,98,65,125,15,125,55,55,80,15,120,82,
145,125};

/* These are for the possible win matches A+B+C */
char A[]={0,2,5,4,7,1,5,1,6,7},B[]={0,3,6,5,8,2,3,3,2,1},
C[]={0,4,7,9,9,8,8,6,9,4},Z[]={0,0,0,0,0,0,0,0,0,0},i=0;

/* Texts */
char *Mext[]={"Player 1 Wins","Player 2 Wins","Draw Game","I Play at 0","$VER: Trihex V1.0 (29.7.2002)","BuferBuferBuferBuferBuferBuferBufer"};

/* Image Data */

__chip UWORD Board_data[1098] =
{  0x0000,0x0000,0x0000,0x0000,0x0780,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x0fe0,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x1ff0,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x3070,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x7f78,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x7ef8,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x7df8,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x7bf8,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x3bf0,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x3be0,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x1fc0,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x0f20,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x1210,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x1210,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x2208,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x2208,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x4204,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x8204,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0000,0x8402,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0001,0x0401,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0001,0x0401,0x0000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0002,0x0400,0x8000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0004,0x0400,0x8000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0004,0x0400,0x4000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0008,0x0400,0x2000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0008,0x0800,0x2000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0010,0x0800,0x1000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0020,0x0800,0x1000,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0020,0x0800,0x0800,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0040,0x0800,0x0400,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0040,0x0800,0x0400,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0080,0x0800,0x0200,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0080,0x0800,0x0200,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0100,0x1000,0x0100,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0200,0x1000,0x0080,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0200,0x1000,0x0080,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0400,0x1000,0x0040,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0400,0x1000,0x0040,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x0800,0x1000,0x0020,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0000,0x1000,0x1000,0x0020,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x000f,0x1000,0x2000,0x0010,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x001f,0xe000,0x2000,0x0008,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x003f,0xe000,0x2000,0x0008,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x0079,0xe000,0x2000,0x0004,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x00f7,0xf000,0x2000,0x0004,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x00ef,0xf000,0x2000,0x0002,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x00e1,0xf000,0x2000,0x0001,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x00ee,0xf000,0x2000,0x0001,0x0000,0x0000,0x0000,
   0x0000,0x0000,0x006e,0xe000,0x4000,0x0000,0x8000,0x0000,0x0000,
   0x0000,0x0000,0x0071,0xe000,0x4000,0x0000,0x8000,0x0000,0x0000,
   0x0000,0x0000,0x003f,0x9000,0x4000,0x0000,0x4000,0x0000,0x0000,
   0x0000,0x0000,0x000e,0x4c00,0x4000,0x0000,0x2000,0x0000,0x0000,
   0x0000,0x0000,0x0008,0x4200,0x4000,0x0000,0x2000,0x0000,0x0000,
   0x0000,0x0000,0x0010,0x2100,0x4000,0x0000,0x1000,0x0000,0x0000,
   0x0000,0x0000,0x0010,0x1080,0x4000,0x0000,0x1000,0x0000,0x0000,
   0x0000,0x0000,0x0020,0x1060,0x8000,0x0000,0x0800,0x0000,0x0000,
   0x0000,0x0000,0x0040,0x0810,0x8000,0x0000,0x0800,0x0000,0x0000,
   0x0000,0x0000,0x0040,0x0808,0x8000,0x0000,0x0400,0x0000,0x0000,
   0x0000,0x0000,0x0080,0x0406,0x8000,0x0000,0x0200,0x0000,0x0000,
   0x0000,0x0000,0x0080,0x0201,0x8000,0x0000,0x0200,0x0000,0x0000,
   0x0000,0x0000,0x0100,0x0200,0x8000,0x0000,0x0100,0x0000,0x0000,
   0x0000,0x0000,0x0200,0x0100,0xc000,0x0000,0x0100,0x0000,0x0000,
   0x0000,0x0000,0x0200,0x0100,0xb000,0x0000,0x0080,0x0000,0x0000,
   0x0000,0x0000,0x0400,0x0081,0x0800,0x0000,0x0040,0x0000,0x0000,
   0x0000,0x0000,0x0400,0x0081,0x0400,0x0000,0x0040,0x0000,0x0000,
   0x0000,0x0000,0x0800,0x0041,0x0300,0x0000,0x0020,0x0000,0x0000,
   0x0000,0x0000,0x1000,0x0021,0x0080,0x0000,0x0020,0x0000,0x0000,
   0x0000,0x0000,0x1000,0x003f,0x0041,0xe000,0x0017,0x8000,0x0000,
   0x0000,0x0000,0x2000,0x003f,0x8023,0xf800,0x000f,0xe000,0x0000,
   0x0000,0x0000,0x2000,0x007f,0xc01f,0xfc00,0x001f,0xf000,0x0000,
   0x0000,0x0000,0x4000,0x00f7,0xc00e,0x3c00,0x0038,0xf000,0x0000,
   0x0000,0x0000,0x4000,0x01e7,0xe01d,0xde00,0x0077,0x7800,0x0000,
   0x0000,0x0000,0x8000,0x01f7,0xe01f,0xde00,0x0077,0x7800,0x0000,
   0x0000,0x0001,0x0000,0x01f7,0xffff,0xbfff,0xfff8,0xf800,0x0000,
   0x0000,0x0001,0x0000,0x01f7,0xe01f,0x7e00,0x0077,0x7800,0x0000,
   0x0000,0x0002,0x0000,0x00f7,0xc00e,0xfc00,0x0037,0x7000,0x0000,
   0x0000,0x0002,0x0000,0x00e3,0x800c,0x1c00,0x00f8,0xe000,0x0000,
   0x0000,0x0004,0x0000,0x007f,0x8007,0xf200,0x071f,0xc000,0x0000,
   0x0000,0x0008,0x0000,0x001c,0x4003,0xc100,0x1807,0x4000,0x0000,
   0x0000,0x0008,0x0000,0x0004,0x4004,0x00c0,0xe000,0x2000,0x0000,
   0x0000,0x0010,0x0000,0x0004,0x2004,0x0023,0x0000,0x1000,0x0000,
   0x0000,0x0010,0x0000,0x0004,0x2008,0x001c,0x0000,0x1000,0x0000,
   0x0000,0x0020,0x0000,0x0004,0x1008,0x0068,0x0000,0x0800,0x0000,
   0x0000,0x0040,0x0000,0x0004,0x1790,0x0386,0x0000,0x0800,0x0000,
   0x0000,0x0040,0x0000,0x0004,0x0ff0,0x0c01,0x0000,0x0400,0x0000,
   0x0000,0x0080,0x0000,0x0004,0x1ff0,0x3000,0x8000,0x0200,0x0000,
   0x0000,0x0080,0x0000,0x0008,0x3071,0xc000,0x6000,0x0200,0x0000,
   0x0000,0x0100,0x0000,0x0008,0x7f7e,0x0000,0x1000,0x0100,0x0000,
   0x0000,0x0100,0x0000,0x0008,0x7ef8,0x0000,0x0800,0x0100,0x0000,
   0x0000,0x0200,0x0000,0x0008,0x7cf8,0x0000,0x0400,0x0080,0x0000,
   0x0000,0x0400,0x0000,0x0008,0x7f78,0x0000,0x0300,0x0040,0x0000,
   0x0000,0x0400,0x0000,0x0008,0x3770,0x0000,0x0080,0x0040,0x0000,
   0x0000,0x0800,0x0000,0x0008,0xf8e0,0x0000,0x0040,0x0020,0x0000,
   0x0000,0x0800,0x0000,0x0013,0x1fc0,0x0000,0x0030,0x0020,0x0000,
   0x0000,0x1000,0x0000,0x001c,0x0700,0x0000,0x0008,0x0010,0x0000,
   0x0000,0x2000,0x0000,0x0070,0x0800,0x0000,0x0004,0x0010,0x0000,
   0x0000,0x2000,0x0000,0x0390,0x0800,0x0000,0x0002,0x0008,0x0000,
   0x0000,0x4000,0x0000,0x0c10,0x1000,0x0000,0x0001,0x8004,0x0000,
   0x0000,0x4000,0x0000,0x3010,0x2000,0x0000,0x0000,0x4004,0x0000,
   0x0000,0x8000,0x0001,0xc010,0x2000,0x0000,0x0000,0x2002,0x0000,
   0x0001,0x0000,0x0006,0x0010,0x4000,0x0000,0x0000,0x1802,0x0000,
   0x0001,0x0000,0x0038,0x0020,0x4000,0x0000,0x0000,0x0401,0x0000,
   0x0002,0x0000,0x00c0,0x0020,0x8000,0x0000,0x0000,0x0200,0x8000,
   0x0002,0x0000,0x0700,0x0020,0x8000,0x0000,0x0000,0x0100,0x8000,
   0x0004,0x0000,0x1800,0x0021,0x0000,0x0000,0x0000,0x00c0,0x4000,
   0x0008,0x0000,0xe000,0x0022,0x0000,0x0000,0x0000,0x0020,0x4000,
   0x0008,0x0003,0x0000,0x0022,0x0000,0x0000,0x0000,0x0010,0x2000,
   0x0010,0x001c,0x0000,0x0024,0x0000,0x0000,0x0000,0x000c,0x1000,
   0x0010,0x0060,0x0000,0x0044,0x0000,0x0000,0x0000,0x0002,0x1000,
   0x0020,0x0380,0x0000,0x0048,0x0000,0x0000,0x0000,0x0001,0x0800,
   0x0f20,0x0c00,0x0000,0x03d0,0x0000,0x0000,0x0000,0x0000,0x8bc0,
   0x1fc0,0x3000,0x0000,0x07f0,0x0000,0x0000,0x0000,0x0000,0x67f0,
   0x3fe1,0xc000,0x0000,0x0ff8,0x0000,0x0000,0x0000,0x0000,0x1ff8,
   0x60e6,0x0000,0x0000,0x1f78,0x0000,0x0000,0x0000,0x0000,0x1c78,
   0xeff8,0x0000,0x0000,0x3e7c,0x0000,0x0000,0x0000,0x0000,0x3bbc,
   0xe1f0,0x0000,0x0000,0x3d7c,0x0000,0x0000,0x0000,0x0000,0x3bbc,
   0xfeff,0xffff,0xffff,0xfb7f,0xffff,0xffff,0xffff,0xffff,0xfc3c,
   0xfef0,0x0000,0x0000,0x383c,0x0000,0x0000,0x0000,0x0000,0x3fbc,
   0x6ee0,0x0000,0x0000,0x1f78,0x0000,0x0000,0x0000,0x0000,0x1f78,
   0x71c0,0x0000,0x0000,0x1f70,0x0000,0x0000,0x0000,0x0000,0x1cf0,
   0x3f80,0x0000,0x0000,0x0fe0,0x0000,0x0000,0x0000,0x0000,0x0fe0,
   0x0e00,0x0000,0x0000,0x0380,0x0000,0x0000,0x0000,0x0000,0x0380,
};

struct Image Board =
{   0,0,            /* LeftEdge, TopEdge  */
    142,122,1,      /* Width, Height, Depth */
    &Board_data[0], /* Pointer to Image data */
    1,0,            /* PlanePick, PlaneOnOff */
    NULL,           /* NextImage pointer */};

__chip UWORD Pul1[12] =
{0x0f00,0x1fc0,0x3fe0,0x7fe0,0xfff0,0xfff0,0xfff0,0xfff0,0x7fe0,
0x7fc0,0x3f80,0x0e00,};

__chip UWORD Pul2[12] =
{0x0f00,0x18c0,0x2060,0x4020,0xc010,0x8010,0x8010,0x8030,0x4020,
0x6040,0x3180,0x0e00,};

struct Image pul[] =
{0,0,12,12,3,&Pul1[0],1,0,NULL,0,0,12,12,1,&Pul2[0],1,0,NULL,};


/* The body text for the about info: */
struct IntuiText my_body_text=
{
  0,       /* FrontPen, colour 0. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  15,      /* LedtEdge, 15 pixels out. */
  5,       /* TopEdge, 5 lines down. */
  &my_font,/* ITextFont. */
  "Copyright © 2002 by Ventzislav Tzvetkov", /* IText, the text . */
  NULL,    /* NextText, no more IntuiText structures link. */
};

/* The OK text: */
struct IntuiText my_ok_text=
{
  0,       /* FrontPen, colour 0. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  6,       /* LedtEdge, 6 pixels out. */
  3,       /* TopEdge, 3 lines down. */
  &my_font,/* ITextFont. */
  "OK",    /* IText, the text that will be printed. */
  NULL,    /* NextText, no more IntuiText structures link. */
};

/* I si postroi menu */
struct IntuiText my_fourth_text=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
  "Quit",     /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_fourth_item=
{
  NULL,            /* NextItem, not linked anymore. */
  0,               /* LeftEdge, 0 pixels out. */
  30,              /* TopEdge, 10 lines down. */
  150,             /* Width, 150 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude. NONE */
  (APTR) &my_fourth_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  'Q',               /* Command. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText my_third_text=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
  "Stat",     /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct MenuItem my_third_item=
{
  &my_fourth_item, /* NextItem, not linked anymore. */
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
  'S',               /* Command. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText my_second_text=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0,          /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
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
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
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
  'N',               /* Command. */
  NULL,            /* SubItem, no subitem list. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct IntuiText Player2_text=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
  "Player 2", /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};
struct IntuiText Players_text=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
  "Player 1", /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};

struct IntuiText Player1_Subtext=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
  "Human", /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};


struct IntuiText Player2_Subtext=
{
  1,          /* FrontPen, black. */
  0,          /* BackPen, not used since JAM1. */
  JAM1,       /* DrawMode, do not change the background. */
  0, /* LeftEdge, CHECKWIDTH amount of pixels out. */
              /* This will leave enough space for the check mark. */
  1,          /* TopEdge, 1 line down. */
  &my_font,   /* TextAttr. */
  "Amiga", /* IText, the string. */
  NULL        /* NextItem, no link to other IntuiText structures. */
};
struct MenuItem Player2_Subitem2=
{
  NULL, /* NextItem, linked to the second item. */
  73,              /* LeftEdge, 0 pixels out. */
  10,              /* TopEdge, 10 lines down. */
  90,              /* Width, 90 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &Player2_Subtext, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  '4',            /* Command. */
  NULL,
  MENUNULL,        /* NextSelect, no items selected. */
};

struct MenuItem Player2_Subitem=
{
  &Player2_Subitem2, /* NextItem. */
  73,              /* LeftEdge, 0 pixels out. */
  0,               /* TopEdge, 0 lines down. */
  90,              /* Width, 90 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &Player1_Subtext, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  '3',            /* Command. */
  NULL,
  MENUNULL,        /* NextSelect, no items selected. */
};

struct MenuItem Players_item2=
{
  NULL, /* NextItem. */
  0,               /* LeftEdge, 0 pixels out. */
  10,              /* TopEdge, 10 lines down. */
  72,              /* Width, 72 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &Player2_text,/* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  0,            /* Command. */
  &Player2_Subitem,/* SubItem. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct MenuItem Player1_Subitem2=
{
  NULL, /* NextItem, linked to the second item. */
  73,              /* LeftEdge, 0 pixels out. */
  10,              /* TopEdge, 10 lines down. */
  90,              /* Width, 90 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &Player2_Subtext, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  '2',            /* Command. */
  NULL,
  MENUNULL,        /* NextSelect, no items selected. */
};
struct MenuItem Player1_Subitem=
{
  &Player1_Subitem2, /* NextItem. */
  73,               /* LeftEdge, 0 pixels out. */
  0,               /* TopEdge, 0 lines down. */
  90,              /* Width, 90 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  COMMSEQ|         /*        accessible from the keyboard. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &Player1_Subtext, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  '1',            /* Command. */
  NULL,
  MENUNULL,        /* NextSelect, no items selected. */
};

struct MenuItem Players_item=
{
  &Players_item2, /* NextItem, linked to the second item. */
  0,               /* LeftEdge, 0 pixels out. */
  0,               /* TopEdge, 0 lines down. */
  72,              /* Width, 72 pixels wide. */
  10,              /* Height, 10 lines high. */
  ITEMTEXT|        /* Flags, render this item with text. */
  ITEMENABLED|     /*        this item will be enabled. */
  HIGHCOMP,        /*        complement the colours when highlihted. */
  0x00000000,      /* MutualExclude, , no mutualexclude. */
  (APTR) &Players_text, /* ItemFill, pointer to the text. */
  NULL,            /* SelectFill, nothing since we complement the col. */
  0,               /* Command. */
  &Player1_Subitem,            /* SubItem. */
  MENUNULL,        /* NextSelect, no items selected. */
};

struct Menu my_menu2=
{
  NULL,          /* NextMenu, no more menu structures. */
  57,            /* LeftEdge, left corner. */
  0,             /* TopEdge, for the moment ignored by Intuition. */
  62,            /* Width, 62 pixels wide. */
  0,             /* Height, for the moment ignored by Intuition. */
  MENUENABLED,   /* Flags, this menu will be enabled. */
  "Players",  /* MenuName, the string. */
  &Players_item /* FirstItem, pointer to the first item in the list. */};
struct Menu my_menu=
{
  &my_menu2,     /* NextMenu. */
  0,             /* LeftEdge, left corner. */
  0,             /* TopEdge, for the moment ignored by Intuition. */
  56,            /* Width, 38 pixels wide. */
  0,             /* Height, for the moment ignored by Intuition. */
  MENUENABLED,   /* Flags, this menu will be enabled. */
  "Trihex",  /* MenuName, the string. */
  &my_first_item /* FirstItem, pointer to the first item in the list. */
};

struct IntuiText my_intui_text=
{
  1,         /* FrontPen, colour register 1. */
  0,         /* BackPen, colour register 0. */
  JAM2,      /* DrawMode, */
  0, 0,      /* LeftEdge, TopEdge. */
  &my_font,  /* ITextFont, use my_font. */
  NULL,      /* IText, the text that will be printed. */
             /* (Remember my_text = &my_text[0].) */
  NULL       /* NextText, no other IntuiText structures are */
             /* connected. */
};

/* Gadgets */
struct Gadget Ninth_gadget=
{ NULL,145,125,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Eight_gadget=
{ &Ninth_gadget,120,82,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Seventh_gadget=
{ &Eight_gadget,80,15,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Sixth_gadget=
{ &Seventh_gadget,55,55,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Fifth_gadget=
{ &Sixth_gadget,15,125,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Fourth_gadget=
{ &Fifth_gadget,65,125,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Third_gadget=
{ &Fourth_gadget,80,98,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget Second_gadget=
{ &Third_gadget,90,82,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

struct Gadget First_gadget=
{ &Second_gadget,70,82,12,12,GADGHNONE,GADGIMMEDIATE,
  BOOLGADGET,0,0,0,0,0,0,0};

main()
{ /* Inits some switches: */
BOOL close=FALSE,Player1=Human,Player2=Amiga;
ULONG class,code;
APTR address;
char j;/* Stats: */
int StatWins[]={0,0},StatLoses[]={0,0},Games=0;
srand (class);

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
/* Open the window with OpenWindowTags (It's easier this way) */
my_window = (struct Window *) OpenWindowTags(NULL, WA_Left,0,WA_Top,0,WA_Width,180,WA_Height,160,
WA_IDCMP,GADGETDOWN|RAWKEY|MENUPICK|CLOSEWINDOW,WA_NewLookMenus, TRUE,
WA_Gadgets,&First_gadget,
WA_Flags,SMART_REFRESH|ACTIVATE|WINDOWCLOSE|WINDOWDEPTH|WINDOWDRAG,

WA_Title, "Trihex",WA_WBenchWindow,TRUE,
TAG_END,NULL );

if ( !my_window )
  {
    /* Could NOT open the Window! */
    /* Close the Intuition Library since we have opened it: */
   CloseLibrary( GfxBase );   
   CloseLibrary( IntuitionBase );
   exit();  
  }
SetAPen(my_window->RPort,0);
SetMenuStrip( my_window, &my_menu );
DrawImage (my_window->RPort, &Board,15,15);

  /* Stay in the while loop until the end */
  while( close == FALSE )
  {

Wait( 1 << my_window->UserPort->mp_SigBit );

    /* As long as we can collect messages successfully we stay in the */
    /* while-loop: */

  while(my_message = (struct IntuiMessage *) GetMsg(my_window->UserPort))
   { 
    if (close)
       break;
class=my_message->Class;
address=my_message->IAddress;
code=my_message->Code;
ReplyMsg(my_message);
      /* After we have successfully collected the message we can read */
      /* it, and save any important values which we maybe want to check */
      /* later: */

if( class == CLOSEWINDOW ||code==69 ) {close=TRUE;break;}

if(class == MENUPICK) {
if(code == 1)   { Player1 = Human; }
if(code == 2049){ Player1 = Amiga; }
if(code == 33)   { Player2 = Human; }
if(code == 2081){  Player2 = Amiga; }
if(code == 63584){close=TRUE;break;}
if(code == 63552){ 
RectFill(my_window->RPort,10,15,158,150);
sprintf(Mext[5],"%d Wins, %d Loses",StatWins[0],StatLoses[0]);
SetAPen(my_window->RPort,1);
Move(my_window->RPort,20,21);
Text(my_window->RPort,"Player 1:",9);
Move(my_window->RPort,20,31);
Text(my_window->RPort, Mext[5], strlen( Mext[5]));
SetAPen(my_window->RPort,2);
sprintf(Mext[5],"%d Wins, %d Loses",StatWins[1],StatLoses[1]);
Move(my_window->RPort,20,51);
Text(my_window->RPort,"Player 2:",9);
Move(my_window->RPort,20,61);
Text(my_window->RPort, Mext[5], strlen( Mext[5]));
SetAPen(my_window->RPort,6);
Move(my_window->RPort,20,81);
Text(my_window->RPort,"Total:",6);
sprintf(Mext[5],"%d Games %d Draws",Games,(Games-(StatWins[0]+StatLoses[0])));
Move(my_window->RPort,20,91);
Text(my_window->RPort, Mext[5], strlen( Mext[5]));
/*Stat */Delay(200);SetAPen(my_window->RPort,0);
RectFill(my_window->RPort,10,15,168,150);DrawImage (my_window->RPort, &Board,15,15);Player=0;
for (i=9;i>-1;i--) Z[i]=0;
}
if(code == 63520){ AutoRequest( my_window, &my_body_text, NULL, &my_ok_text, NULL, NULL, 220, 72);}
if(code == 63488){ DrawImage (my_window->RPort, &Board,15,15);Player=0;
for (i=9;i>-1;i--) Z[i]=0;}
 }

if ((Player==0 && Player1==Amiga) || (Player==1 && Player2==Amiga)){
i=Pul(j=ComputerMove(Player),Player);Mext[3][10]=j+'0';
my_intui_text.IText=Mext[3];
PrintIText( my_window->RPort, &my_intui_text ,15,140);
Delay(50);RectFill(my_window->RPort,10,140,160,155);break;
 }

if ( class==GADGETDOWN) {
if (address==(APTR) &First_gadget) i=Pul(1,Player);
if (address==(APTR) &Second_gadget) i=Pul(2,Player);
if (address==(APTR) &Third_gadget) i=Pul(3,Player);
if (address==(APTR) &Fourth_gadget) i=Pul(4,Player);
if (address==(APTR) &Fifth_gadget) i=Pul(5,Player);
if (address==(APTR) &Sixth_gadget) i=Pul(6,Player);
if (address==(APTR) &Seventh_gadget) i=Pul(7,Player);
if (address==(APTR) &Eight_gadget) i=Pul(8,Player);
if (address==(APTR) &Ninth_gadget) i=Pul(9,Player);}

if (class==RAWKEY) {
if (code == 1) i=Pul(1,Player);
if (code == 2) i=Pul(2,Player);
if (code == 3) i=Pul(3,Player);
if (code == 4) i=Pul(4,Player);
if (code == 5) i=Pul(5,Player);
if (code == 6) i=Pul(6,Player);
if (code == 7) i=Pul(7,Player);
if (code == 8) i=Pul(8,Player);
if (code == 9) i=Pul(9,Player);
}

if (!i) {if ((Player==0 && Player1==Amiga) || (Player==1 && Player2==Amiga)){
i=Pul(j=ComputerMove(Player),Player);Mext[3][10]=j+'0';
my_intui_text.IText=Mext[3];
PrintIText( my_window->RPort, &my_intui_text ,15,140);
Delay(50);RectFill(my_window->RPort,10,140,160,155);
 }if (i) break; } else break;}

if (i) {
if (i==Win) {my_intui_text.IText=Mext[Player];
PrintIText( my_window->RPort, &my_intui_text ,15,140);
StatWins[Player]++;StatLoses[!Player]++;}
if (i==Draw){my_intui_text.IText=Mext[Draw];
PrintIText( my_window->RPort, &my_intui_text ,15,140);}
for (i=9;i>-1;i--) {Z[i]=0;Delay(8);}
RectFill(my_window->RPort,10,140,160,155);
DrawImage (my_window->RPort, &Board,15,15);
Player=0;Games++;}

  }

/* We should always close the screens we have opened before we leave: */

 ClearMenuStrip( my_window );

 CloseWindow ( my_window ); 

/* Close the Graphics Library since we have opened it: */
  CloseLibrary( GfxBase );

  /* Close the Intuition Library since we have opened it: */
  CloseLibrary( IntuitionBase );

  /* THE END */
exit();
}

char Pul(char s, BOOL PlayerNo) {char w1,puls=0;
if (!Z[s]){DrawImage (my_window->RPort,&pul[PlayerNo],XY[s*2],XY[s*2+1]);
Z[s]=PlayerNo+1;
for (w1=1;w1<10;w1++) {
if (Z[A[w1]]==Z[s] && Z[B[w1]]==Z[s] && Z[C[w1]]==Z[s]) return Win;
if (Z[w1]) puls++;}
if (puls==9) return Draw;
Player=!Player;return 0;
}
return 0;
}

char ComputerMove(BOOL PlayerNu) {char w1,see=0;
for (w1=1;w1<10;w1++) {
if (Z[A[w1]]==PlayerNu+1 && Z[B[w1]]==PlayerNu+1 &&Z[C[w1]]==0)
return C[w1];
if (Z[A[w1]]==PlayerNu+1 && Z[B[w1]]==0 && Z[C[w1]]==PlayerNu+1)
return B[w1];
if (Z[A[w1]]==0 && Z[B[w1]]==PlayerNu+1 && Z[C[w1]]==PlayerNu+1) return A[w1];
if (Z[A[w1]]==(!PlayerNu)+1 && Z[B[w1]]==(!PlayerNu)+1 &&Z[C[w1]]==0)
return C[w1];
if (Z[A[w1]]==(!PlayerNu)+1 && Z[B[w1]]==0 && Z[C[w1]]==(!PlayerNu)+1)
return B[w1];
if (Z[A[w1]]==0 && Z[B[w1]]==(!PlayerNu)+1 && Z[C[w1]]==(!PlayerNu)+1) return A[w1];
if (Z[w1]) see++;
}
if (see<2) {do {w1=(rand()%3)+1;} while (Z[w1]);return w1;}
do {w1=(rand()%9)+1;} while (Z[w1]);return w1;
}

/* Here is the Oric BASIC version of the same game:
   Ето я и весията на играта за Правец-8Д
Програмата е написана на Бейсик. Използвана е възмоността на
компютъра да се пишат знакове в графичната страница (оператор CHAR).
Ето и кратки разяснения за действието на програмата:

  - редове  5 - 50  дефинират нужните масиви за работата на програмата
и извеждат на екрана заглавната страница;

  - редове  55 - 85  изискват потребителят да въведе името си, да избере
своя противник и да отговори на запитването, дали желае да започне пръв,
или не;

  - редове  90 - 175  реализират цикъла на игра на двамата играчи,
проверка, дали играта е свършила и, ако е така, се съобщава какъв е
резултатът - победа или равенство;

  - редове  180 - 250  - подпрограма, която подготвя игралното поле;

  - редове  255 - 350  - подпрограма, която извежда на екрана помощен
текст с инструкциите за игра;

  - редове  355 - 440  - подпрограма, която реализира въвеждането на ход
на един от играчите и проверява правилността му. Ако компютърът е на ход,
тази подпрограма преценява възможните ходове и избира един от тях;

  - редове  445 - 490  - подпрограма за проверка, дали е завършила играта
и какъв е резултатът;

  - редове  495 - 535  - подпрограма за зареждане на данните.

Тъй като някои редове съдържат повече от 80 знака, при набирането на
програмата изпозвайте ? вместо PRINT и не оставяйте интервали между
операторите.

Алтернативно можете да използвате програма като например txt2bas.exe,
която преобразува текстовия файл в достъпен за емулатори и истински
Правец-8Д формат. (.DAT файл за AmOric)

Самата програма е доста лошо написана, затова пренаписах почти всичко
наново при прехвърлянето и за Амига. Добавих и множество нови опции,
като статистически анализ, работа с мишка, по-добър интелект и т.н.

 0 'triheks(C)b.p.1990
 5 CLEAR:DIM A(9),B(9),C(9),X(9),Y(9),Z(9),T$(6)
 10 GOSUB 495:IF PEEK(#20C)=255 THEN PRINT CHR$(20)
 15 TEXT:CLS:PAPER 0:INK 2:CALL #F8D0
 20 PRINT:PRINT SPC(9)"sp. komp`tyr za was":PRINT
 25 FOR I=1 TO 10:PRINT@14+I,3;MID$("predstawq:",I,1):CALL #FB14:WAIT 11:NEXT
 30 PRINT@15,7;CHR$(4)CHR$(27)"Ntriheks"CHR$(4)
 35 PRINT@11,11;CHR$(27);"Winstrukciq (d/n)"CHR$(27)"P";
 40 GET A$
 45 IF A$="d" OR A$="D" THEN ELSE 55
 50 GOSUB 255
 55 PRINT:PRINT:INPUT "wywedete imeto si";P1$
 60 PRINT "izberete sypernika si:"
 65 PRINT "p)rawec-8d     d)rug igra~"
 70 GET A$:IF A$="p" OR A$="P" THEN P2$="prawec-8d":GOTO 80
 75 INPUT "igra~ 2, wywedete imeto si";P2$
 80 PRINT P1$", velaete li da zapo~nete pryw(d/n)?";:GET A$:IF A$="d"OR A$="D"THEN F=1
 85 GOSUB 180
 90 HD=0
 95 IF F<>1 THEN 120
 100 PL$=P1$:NO=1
 105 GOSUB 355
 110 GOSUB 445:IF WIN=TRUE THEN 145
 115 GOSUB 475:IF H=TRUE THEN ELSE 175
 120 PL$=P2$:NO=2
 125 GOSUB 355
 130 GOSUB 445:IF WIN=TRUE THEN 145
 135 GOSUB 475:IF H=TRUE THEN ELSE 175
 140 GOTO 100
 145 WAIT 50:TEXT:ZAP
 150 PRINT"pobedi ":PRINTPL$
 155 PRINT"o}e edna igra(d/n)";:
 160 GET A$:IF A$="d" OR A$="D" THEN RUN
 165 IF PEEK(#20C)<>255 THEN PRINTCHR$(20)
 170 END
 175 WAIT 50:TEXT:PRINT"rawenstwo":GOTO155
 180 'podprogrami
 185 HIRES
 190 CURSETX(5),Y(5),3:DRAW 65,-110,1:DRAW65,110,1:DRAW-130,0,1:DRAW105,-43,1
 195 DRAW -50,0,1:CURSET X(7),Y(7),3:DRAW-15,110,1
 200 CURSET X(9),Y(9),3:DRAW -90,-70,1:DRAW 25,43,1
 205 CURSET X(4),Y(4),1:DRAW25,-43,1
 210 FORI=1TO9
 215 CURSET X(I),Y(I),3:FOR J=1 TO 6:CIRCLEJ,1:NEXT
 220 CURSET X(I)-3,Y(I)-3,3:CHAR I+48,0,2:NEXT
 225 FORI=0TO6
 230 CURSET5,I*8+50,3:CHARASC(T$(I)),0,1:CURSET225,I*8+50,3:CHARASC(T$(I)),0,1
 235 NEXT
 240 CURSET 50,7,0:FORJ=1TO6:CIRCLEJ,1:NEXT
 245 CURSET 190,7,0:CIRCLE 6,1
 250 RETURN
 255 CLS
 260 PRINT"triheks e logi~eska igra"
 265 PRINT"za wa{ protiwnik movete da izberete"
 270 PRINT"komp`tyra ili drug igra~"
 275 PRINT"wie igraete s belite pionki,"
 280 PRINT"a sypernikyt wi s ~ernite"
 285 GOSUB 345
 290 GOSUB 185:PRINT"towa e igralnoto pole ";
 295 GOSUB 345:TEXT
 300 PRINT"wa{iqt hod/hodyt na sypernika wi"
 305 PRINT"se systoi w 'postawqneto' na pionka"
 310 PRINT"ot wa{iq/negowiq cwqt (bql/~eren)"
 315 PRINT"w edno ot nezaetite kryg~eta"
 320 PRINT"kato wywedete nomera mu (ot 0 do 9)"
 325 PRINT"pobevdawa tozi, kojto pryw 'postawi'"
 330 PRINT"swojte pionki na tri ot kryg~etata, "
 335 PRINT"leva}i na edna ot dewette prawi"
 340 PRINT
 345 PRINT:PRINT"natisnete nqkoj klawi{":GETA$
 350 RETURN
 355 PRINT:PRINT"na hod e "PL$
 360 GOSUB 475:IF H=TRUE THEN ELSE RETURN
 365 IF PL$="prawec-8d" THENGOSUB 395:GOTO 375
 370 PRINT:PRINT"wywedete nomera na kryg~eto";:GET N$:N=VAL(N$):IF N<1 THEN 365
 375 IF Z(N)<>0 THEN 360
 380 Z(N)=NO
 385 CURSET X(N),Y(N),3:FOR J=1TO6:CIRCLE J,ABS(NO-2):NEXT:CIRCLE 6,1
 390 RETURN
 395 NO=2:P=2:HO=HO+1
 400 W1=1:REPEAT
 405 IF Z(A(W1))=P AND Z(B(W1))=P AND Z(C(W1))=0 THEN N=C(W1):PULL:RETURN
 410 IF Z(B(W1))=P AND Z(C(W1))=P AND Z(A(W1))=0 THEN N=A(W1):PULL:RETURN
 415 IF Z(A(W1))=P AND Z(C(W1))=P AND Z(B(W1))=0 THEN N=B(W1):PULL:RETURN
 420 W1=W1+1:UNTIL W1>9
 425 IF P<>1 THEN P=1:GOTO 400
 430 IF HO=1 THEN Q=3 ELSE Q=9
 435 N=INT(RND(1)*Q+1):IF Z(N)=0 AND N<10 THEN ELSE 435
 440 RETURN
 445 P=2
 450 W1=1:REPEAT
 455 IF Z(A(W1))=P AND Z(B(W1))=P AND Z(C(W1))=P THEN WIN=TRUE:PULL:RETURN
 460 W1=W1+1:UNTILW1>9
 465 IF P<>1 THEN P=1:GOTO450
 470 RETURN
 475 S=0:FORG=1TO9
 480 IF Z(G)<>0 THEN S=S+1:NEXT
 485 IF S<9 THEN H=TRUE ELSE H=FALSE
 490 RETURN
 495 RESTORE:FOR I=1 TO 9
 500 READ X(I),Y(I)
 505 NEXT
 510 FOR I=0 TO 6:READ T$(I):NEXT
 515 FOR I=1TO9:READ A(I),B(I),C(I):NEXT
 520 DATA 110,112,130,112,120,128,105,155,55,155,95,85,120,45,160,112,185,155
 525 DATA t,r,i,h,e,k,s
 530 DATA 2,3,4,5,6,7,4,5,9,7,8,9,1,2,8,5,3,8,1,3,6,6,2,9,7,1,4
 535 RETURN
*/
