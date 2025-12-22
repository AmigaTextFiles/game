/* Functions */

void ScreenLevel(char Level);
int Title();
UBYTE Joystick();
void Sub9980();
void Jump();
void AreaShow(char c);
void Dead();
void GameOver();
void DrawAlex(char downcolor,char upcolor,char x,char y);
void Car();

char A=20,B,K1,K2,BI,C,ZZZ,KO1,KO2,KO3,GA,GB,FLASH,CAR,Level=1;
BOOL NewGame=FALSE;

#define FIRE   1
#define RIGHT  2
#define LEFT   4
#define DOWN   8
#define UP    16

/* This will automatically be linked to the Custom structure: */
extern struct Custom custom;

/* This will automatically be linked to the CIA A (8520) chip: */
extern struct CIA ciaa;

struct IntuitionBase *IntuitionBase;
struct GfxBase *GfxBase;

struct Screen *my_screen;
struct Window *my_window;

struct IntuiMessage *my_message;


struct IntuiText my_body_text5=
{
  2,       /* FrontPen, colour 2. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  5,       /* LedtEdge, 5 pixels out. */
  61,      /* TopEdge, 61 lines down. */
  NULL,    /* ITextFont, default font. */
  "Amiga music by Flapjack/Madwizards", /* IText, the text . */
  NULL,    /* NextText, no more IntuiText structures link. */
};

struct IntuiText my_body_text4=
{
  2,       /* FrontPen, colour 2. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  5,       /* LedtEdge, 5 pixels out. */
  47,      /* TopEdge, 47 lines down. */
  NULL,    /* ITextFont, default font. */
  "Amiga port by drHirudo", /* IText, the text . */
  &my_body_text5, /* NextText. */ };

struct IntuiText my_body_text3=
{
  2,       /* FrontPen, colour 2. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  5,       /* LedtEdge, 5 pixels out. */
  33,      /* TopEdge, 33 lines down. */
  NULL,    /* ITextFont, default font. */
  "By Equinox <eq@cl4.org>", /* IText, the text . */
  &my_body_text4, /* NextText. */
};

struct IntuiText my_body_text2=
{
  2,       /* FrontPen, colour 2. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  5,       /* LedtEdge, 5 pixels out. */
  19,      /* TopEdge, 19 lines down. */
  NULL,    /* ITextFont, default font. */
  "Original Sinclair 128K game", /* IText, the text . */
  &my_body_text3,    /* NextText. */
};

/* The body text for the about info: */
struct IntuiText my_body_text=
{
  0,       /* FrontPen, colour 0. */
  0,       /* BackPen, not used since JAM1. */
  JAM1,    /* DrawMode, do not change the background. */
  5,       /* LedtEdge, 5 pixels out. */
  5,       /* TopEdge, 5 lines down. */
  NULL,    /* ITextFont, default font. */
  "Alex in Town V1.2 © 1992-2003", /* IText, the text . */
  &my_body_text2,    /* NextText. */
};

/* The OK text: */
struct IntuiText my_ok_text=
{
  0,       /* FrontPen, colour 0. */
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
    0,
 FPF_ROMFONT                   /* Exist in ROM. */
};
 
struct IntuiText my_intui_text=
{
  5,         /* FrontPen, colour register 5. */
  0,         /* BackPen, colour register 0. */
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
  MENUPICK, /* IDCMPFlags. */
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
  82,            /* Width, 82 pixels wide. */
  0,             /* Height, for the moment ignored by Intuition. */
  MENUENABLED,   /* Flags, this menu will be enabled. */
  "AlexInTown",  /* MenuName, the string. */
  &my_first_item /* FirstItem, pointer to the first item in the list. */
};

/* The font data: */
static UWORD AlexTownData[512]=
{
  /* Row 0: */
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x143C,
  0x0FF0,0xFF00,0x0FF0,0xFF00,0x0FF0,0xFF00,0x0F07,0xF0FF,
  0xAA18,0x0000,0xAAFF,0x0180,0x7618,0x3C7C,0x06FF,0xAA00,
  /* Row 1: */
  0x0010,0x2424,0x0862,0x1008,0x0420,0x0000,0x0000,0x0000,
  0x3C18,0x3C3C,0x087E,0x3C7E,0x3C3C,0x0000,0x0000,0x003C,
  0x3C3C,0x7C3C,0x787E,0x7E3C,0x423E,0x0244,0x4042,0x423C,
  0x7C3C,0x7C3C,0xFE42,0x4242,0x4282,0x7E0E,0x0070,0x1000,
  0x1C00,0x2000,0x0400,0x0C00,0x4010,0x0420,0x1000,0x0000,
  0x0000,0x0000,0x1000,0x0000,0x0000,0x000E,0x0870,0x2842,
  0x0FF0,0xFF00,0x0FF0,0xFF00,0x0FF0,0xFF00,0x0F07,0xF0FF,
  0xAA7E,0x7EEF,0xAAFF,0x03C0,0x7F18,0x7EFE,0x06FF,0x5500,
  /* Row 2: */
  0x0010,0x247E,0x3E64,0x2810,0x0810,0x1408,0x0000,0x0002,
  0x4628,0x4242,0x1840,0x4002,0x4242,0x0010,0x0400,0x1042,
  0x4A42,0x4242,0x4440,0x4042,0x4208,0x0248,0x4066,0x6242,
  0x4242,0x4240,0x1042,0x4242,0x2444,0x0408,0x4010,0x3800,
  0x2238,0x201C,0x0438,0x103C,0x4000,0x0028,0x1068,0x7838,
  0x783C,0x1C38,0x3844,0x4444,0x4444,0x7C08,0x0810,0x0099,
  0x0FF0,0xFF00,0x0FF0,0xFF00,0x0FF0,0xFF00,0x0F07,0xF0FF,
  0xFFBD,0x7EEF,0xAA33,0x07E0,0xFF18,0xFF06,0x06C3,0xAA00,
  /* Row 3: */
  0x0010,0x0024,0x2808,0x1000,0x0810,0x0808,0x0000,0x0004,
  0x4A08,0x020C,0x287C,0x7C04,0x3C42,0x1000,0x083E,0x0804,
  0x5642,0x7C40,0x427C,0x7C40,0x7E08,0x0270,0x405A,0x5242,
  0x4242,0x423C,0x1042,0x4242,0x1828,0x0808,0x2010,0x5400,
  0x7804,0x3C20,0x3C44,0x1844,0x7830,0x0430,0x1054,0x4444,
  0x4444,0x2040,0x1044,0x4454,0x2844,0x0830,0x080C,0x00A1,
  0x0FF0,0xFF00,0x0FF0,0xFF00,0x0FF0,0xFF00,0x0F07,0xF0FF,
  0x99BD,0x7EEF,0xFF33,0x0FF0,0xFE18,0x81F6,0x0681,0x5500,
  /* Row 4: */
  0x0010,0x0024,0x3E10,0x2A00,0x0810,0x3E3E,0x083E,0x0008,
  0x5208,0x3C02,0x4802,0x4208,0x423E,0x0000,0x1000,0x0408,
  0x5E7E,0x4240,0x4240,0x404E,0x4208,0x4248,0x4042,0x4A42,
  0x7C52,0x7C02,0x1042,0x4242,0x1810,0x1008,0x1010,0x1000,
  0x203C,0x2220,0x4478,0x1044,0x4410,0x0430,0x1054,0x4444,
  0x4444,0x2038,0x1044,0x2854,0x1044,0x1008,0x0810,0x00A1,
  0x0000,0x000F,0x0F0F,0x0FF0,0xF0F0,0xF0FF,0xFFFF,0xFFFF,
  0xBDBD,0x7E00,0xFF33,0x1FF8,0x7F18,0x81F6,0x0681,0xAA00,
  /* Row 5: */
  0x0000,0x007E,0x0A26,0x4400,0x0810,0x0808,0x0800,0x1810,
  0x6208,0x4042,0x7E42,0x4210,0x4202,0x0010,0x083E,0x0800,
  0x4042,0x4242,0x4440,0x4042,0x4208,0x4244,0x4042,0x4642,
  0x404A,0x4442,0x1042,0x245A,0x2410,0x2008,0x0810,0x1000,
  0x2044,0x2220,0x4440,0x103C,0x4410,0x0428,0x1054,0x4444,
  0x783C,0x2004,0x1044,0x2854,0x283C,0x2008,0x0810,0x0099,
  0x0000,0x000F,0x0F0F,0x0FF0,0xF0F0,0xF0FF,0xFFFF,0xFFFF,
  0xEF3C,0x7EFE,0xFF33,0x3FFC,0xFF18,0xFF06,0x0681,0x5500,
  /* Row 6: */
  0x0010,0x0024,0x3E46,0x3A00,0x0420,0x1408,0x1000,0x1820,
  0x3C3E,0x7E3C,0x083C,0x3C10,0x3C3C,0x1010,0x0400,0x1008,
  0x3C42,0x7C3C,0x787E,0x403C,0x423E,0x3C42,0x7E42,0x423C,
  0x403C,0x423C,0x103C,0x1824,0x4210,0x7E0E,0x0470,0x1000,
  0x7E3C,0x3C1C,0x3C3C,0x1004,0x4438,0x2424,0x0C54,0x4438,
  0x4004,0x2078,0x0C38,0x1028,0x4404,0x7C0E,0x0870,0x0042,
  0x0000,0x000F,0x0F0F,0x0FF0,0xF0F0,0xF0FF,0xFFFF,0xFFFF,
  0xE724,0x7EFE,0xFF33,0x7FFE,0xFF18,0xFF06,0x0681,0xAA00,
  /* Row 7: */
  0x0000,0x0000,0x0800,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0020,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,
  0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x00FF,
  0x0000,0x0000,0x0000,0x0038,0x0000,0x1800,0x0000,0x0000,
  0x4006,0x0000,0x0000,0x0000,0x0038,0x0000,0x0000,0x003C,
  0x0000,0x000F,0x0F0F,0x0FF0,0xF0F0,0xF0FF,0xFFFF,0xFFFF,
  0x7E66,0x00FE,0xFF33,0xFFFF,0x6E18,0xFF06,0x0681,0x5500
};

/* The location and width of each character: */
static ULONG AlexTownLoc[127]=
{
  0x00000008,0x00080008,0x00100008,0x00180008,
  0x00200008,0x00280008,0x00300008,0x00380008,
  0x00400008,0x00480008,0x00500008,0x00580008,
  0x00600008,0x00680008,0x00700008,0x00780008,
  0x00800008,0x00880008,0x00900008,0x00980008,
  0x00A00008,0x00A80008,0x00B00008,0x00B80008,
  0x00C00008,0x00C80008,0x00D00008,0x00D80008,
  0x00E00008,0x00E80008,0x00F00008,0x00F80008,
  0x01000008,0x01080008,0x01100008,0x01180008,
  0x01200008,0x01280008,0x01300008,0x01380008,
  0x01400008,0x01480008,0x01500008,0x01580008,
  0x01600008,0x01680008,0x01700008,0x01780008,
  0x01800008,0x01880008,0x01900008,0x01980008,
  0x01A00008,0x01A80008,0x01B00008,0x01B80008,
  0x01C00008,0x01C80008,0x01D00008,0x01D80008,
  0x01E00008,0x01E80008,0x01F00008,0x01F80008,
  0x02000008,0x02080008,0x02100008,0x02180008,
  0x02200008,0x02280008,0x02300008,0x02380008,
  0x02400008,0x02480008,0x02500008,0x02580008,
  0x02600008,0x02680008,0x02700008,0x02780008,
  0x02800008,0x02880008,0x02900008,0x02980008,
  0x02A00008,0x02A80008,0x02B00008,0x02B80008,
  0x02C00008,0x02C80008,0x02D00008,0x02D80008,
  0x02E00008,0x02E80008,0x02F00008,0x02F80008,
  0x03000008,0x03080008,0x03100008,0x03180008,
  0x03200008,0x03280008,0x03300008,0x03380008,
  0x03400008,0x03480008,0x03500008,0x03580008,
  0x03600008,0x03680008,0x03700008,0x03780008,
  0x03800008,0x03880008,0x03900008,0x03980008,
  0x03A00008,0x03A80008,0x03B00008,0x03B80008,
  0x03C00008,0x03C80008,0x03D00008,0x03D80008,
  0x03E00008,0x03E80008,0x03F00008
};

/* The text font structure: */
struct TextFont AlexTownFont=
{
  { /* Message */
    { /* Node */
      NULL,    /* ln_Succ */
      NULL,    /* ln_Pred */
      NT_FONT, /* ln_Type */
      0,       /* ln_Pri */
      "AlexTown.font" /* ln_Name */
    },
    NULL,      /* mn_ReplyPort */
     1536      /* mn_Length */
  },
      8, /* tf_YSize */
      0, /* tf_Style */
     66, /* tf_Flags */
      8, /* tf_XSize */
      6, /* tf_Baseline */
      1, /* tf_BoldSmear */
      0, /* tf_Accessors */
     32, /* tf_LoChar */
    158, /* tf_HiChar */
  (APTR) &AlexTownData,  /* tf_CharData */
    128, /* tf_Modulo */
  (APTR) &AlexTownLoc,   /* tf_CharLoc */
   NULL, /* tf_CharSpace */
   NULL, /* tf_CharKern */
};

/******************************************/


struct ColorSpec  ScreenColors[] = {
     0, 0,0,0,    1,0, 0, 204,
     2, 204,0,0,  3, 204, 0, 204,
     4, 0,204,0,  5, 0,204,204,
     6, 204,204,0,7, 204,204,204,
     8, 0,0,0,    9, 0,0,255,
    10, 255,0,0,  11, 255,0,255,
    12, 0,255,0,  13, 0,255,255,
    14, 255,255,0,15, 255,255,255,  ~0, 0, 0, 0 };
