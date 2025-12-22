/*
   FILE: Graphics.h
   PURPOSE: Structures needed for Spades graphics
   AUTHOR: Gregory M. Stelmack
*/

struct NewScreen NewScreenStructure = {
        0,0,
        320,200,
        DEPTH,
        BLKP,WHTP,
        NULL,
        CUSTOMSCREEN,
        NULL,
        "Spades 2.12 by Greg Stelmack",
        NULL,
        NULL
};

struct NewMenu SpadesNewMenu[] =
{
   {  NM_TITLE,"Project", NULL, NULL, NULL, NULL   },
   {     NM_ITEM,"New Game", NULL, NULL, NULL, NULL   },
   {     NM_ITEM,"Save Hand", NULL, CHECKIT | MENUTOGGLE, NULL, NULL },
   {     NM_ITEM,"Print Hand", NULL, NM_ITEMDISABLED, NULL, NULL     },
   {     NM_ITEM,"About", NULL, NULL, NULL, NULL   },
   {     NM_ITEM,"Quit", NULL, NULL, NULL, NULL    },
   {  NM_TITLE,"Game", NULL, NULL, NULL, NULL   },
   {     NM_ITEM,"Bags","b", CHECKIT | MENUTOGGLE, NULL, NULL     },
   {     NM_ITEM,"NIL Bids","n", CHECKIT | MENUTOGGLE, NULL, NULL },
   {     NM_ITEM,"Suggest","s", NULL, NULL, NULL   },
   {  NM_END, NULL, NULL, NULL, NULL, NULL   }
};

struct Menu *SpadesMenu;

struct NewWindow NewWindowStructure1 = {
        0,10,
        320,190,
        BLKP,WHTP,
        MOUSEBUTTONS+GADGETUP+MENUPICK,
        BORDERLESS+ACTIVATE+NOCAREREFRESH,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        5,5,
        -1,-1,
        CUSTOMSCREEN
};

USHORT Palette[] = {
   0x000F,
   0x0000,
   0x0F00,
   0x00F0,
   0x0FFF,
   0x0FF0,
   0x0F0F,
   0x00FF
};

struct Image CardImage =
{
   0, 0,
   42, 42, 3,
   NULL,
   7, 0,
   NULL
};
