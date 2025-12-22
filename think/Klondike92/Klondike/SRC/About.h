/* The coordinates for the box: */
SHORT gadget_border_points[]=
{
   0, 10, /* Start at position (0,0) */
   0,  0, /* Draw a line to the right to position (70,0) */
   22, 0  /* Draw a line down to position (70,10) */
};
SHORT gadget_border_points2[]=
{
  22,  0, /* Draw a line to the right to position (70,0) */
  22, 10, /* Draw a line down to position (70,10) */
   0, 10, /* Draw a line to the right to position (0,10) */
};

/* The Border structure: */
struct Border gadget_border=
{
  0, 0,        /* LeftEdge, TopEdge. */
  1,	       /* FrontPen, colour register 1. */
  0,	       /* BackPen, for the moment unused. */
  JAM1,        /* DrawMode, draw the lines with colour 1. */
  3,	       /* Count, 5 pair of coordinates in the array. */
  gadget_border_points, /* XY, pointer to the array with the coord. */
  NULL	      /* NextBorder, no other Border structures are connected. */
};
struct Border gadget_border2=
{
  0, 0,        /* LeftEdge, TopEdge. */
  2,	       /* FrontPen, colour register 1. */
  0,	       /* BackPen, for the moment unused. */
  JAM1,        /* DrawMode, draw the lines with colour 1. */
  3,	       /* Count, 5 pair of coordinates in the array. */
  gadget_border_points2, /* XY, pointer to the array with the coord. */
  &gadget_border	/* NextBorder, no other Border structures are connected. */
};


/* The IntuiText structure: */
struct IntuiText gadget_text=
{
  1,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, colour register 0. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  4, 2,      /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "OK",/* IText, the text that will be printed. */
  NULL	    /* NextText, no other IntuiText structures are connected. */
};

struct Gadget requester_gadget=
{
  NULL, 	 /* NextGadget, no more gadgets in the list. */
 280,		 /* LeftEdge, 40 pixels out. */
  80,		 /* TopEdge, 20 lines down. */
  23,		 /* Width, 71 pixels wide. */
  11,		 /* Height, 11 pixels lines heigh. */
  GADGHCOMP,	 /* Flags, when this gadget is highlighted, the gadget */
		 /* will be rendered in the complement colours. */
		 /* (Colour 0 (00) will be changed to colour 3 (11) */
		 /* (Colour 1 (01)	     - " -           2 (10) */
		 /* (Colour 2 (10)	     - " -           1 (01) */
		 /* (Colour 3 (11)	     - " -           0 (00) */
  GADGIMMEDIATE| /* Activation, our program will recieve a message when */
  RELVERIFY|	 /* the user has selected this gadget, and when the user */
		 /* has released it. */
  ENDGADGET,	 /* When the user has selected this gadget, the */
		 /* requester is satisfied, and is deactivated. */
		 /* IMPORTANT! At least one gadget per requester */
		 /* must have the flag ENDGADGET set. If not, the */
		 /* requester would never be deactivated! */

  BOOLGADGET|	 /* GadgetType, a Boolean gadget which is connected to */
  REQGADGET,	 /* a requester. IMPORTANT! Every gadget which is */
		 /* connectd to a requester must have the REQGADGET flsg */
		 /* set in the GadgetType field. */
  (APTR) &gadget_border2, /* GadgetRender, a pointer to our Border struc. */
  NULL, 	 /* SelectRender, NULL since we do not supply the gadget */
		 /* with an alternative image. (We complement the */
		 /* colours instead) */
  &gadget_text,  /* GadgetText, a pointer to our IntuiText structure. */
		 /* (See chapter 3 GRAPHICS for more information) */
  NULL, 	 /* MutualExclude, no mutual exclude. */
  NULL, 	 /* SpecialInfo, NULL since this is a Boolean gadget. */
		 /* (It is not a Proportional/String or Integer gdget) */
  0,		 /* GadgetID, no id. */
  NULL		 /* UserData, no user data connected to the gadget. */
};

/************************************/
/* THE BORDER AROUND THE REQUESTER: */
/************************************/

/* The coordinates for the box around the requester: */
SHORT requester_border_points[]=
{
     0, 99,   /* Start at bottom left  */
     0,  0,   /* Go to top left  */
   319,  0    /* Then to top right  */
};
SHORT requester_border_points2[]=
{
   319,  0,   /* Start at top right  */
   319, 99,   /* Go to bottom right  */
   0,	99    /* Then to bottom left  */
};

/* The Border structure for the requester: */
struct Border requester_border=
{
  0, 0,        /* LeftEdge, TopEdge. */
  1,	       /* FrontPen, colour register 1. */
  0,	       /* BackPen, for the moment unused. */
  JAM1,        /* DrawMode, draw the lines with colour 1. */
  3,	       /* Count, 5 pair of coordinates in the array. */
  requester_border_points, /* XY, pointer to the array with the coord. */
  NULL	      /* NextBorder, no other Border structures are connected. */
};
/* The Border structure for the requester: */
struct Border requester_border2=
{
  0, 0,        /* LeftEdge, TopEdge. */
  2,	       /* FrontPen, colour register 1. */
  0,	       /* BackPen, for the moment unused. */
  JAM1,        /* DrawMode, draw the lines with colour 1. */
  3,	       /* Count, 5 pair of coordinates in the array. */
  requester_border_points2, /* XY, pointer to the array with the coord. */
  &requester_border	   /* NextBorder, no other Border structures are connected. */
};

/**********************************/
/* THE TEXT INSIDE THE REQUESTER: */
/**********************************/

/* The IntuiText structure used to print some text inside the requester: */
struct IntuiText requester_text=
{
  1,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, unused since JAM1. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  20, 10,      /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "<<Klondike>> by Desi Villaescusa", /* IText, the text that will be printed. */
  NULL	    /* NextText, no other IntuiText structures are connected. */
};
struct IntuiText requester_text2=
{
  3,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, unused since JAM1. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  36, 26,      /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "(c) 1992  Lilliput Software", /* IText, the text that will be printed. */
  &requester_text      /* NextText, no other IntuiText structures are connected. */
};
struct IntuiText requester_text3=
{
  2,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, unused since JAM1. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  20, 42,      /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "This program WAS almost SHAREWARE!", /* IText, the text that will be printed. */
  &requester_text2	/* NextText, no other IntuiText structures are connected. */
};
struct IntuiText requester_text4=
{
  2,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, unused since JAM1. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  20, 52,      /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "Let me know if you play this.", /* IText, the text that will be printed. */
  &requester_text3	/* NextText, no other IntuiText structures are connected. */
};
struct IntuiText requester_text5=
{
  1,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, unused since JAM1. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  36, 68,    /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "Desi Villaescusa (aka Dr.D.)", /* IText, the text that will be printed. */
  &requester_text4	/* NextText, no other IntuiText structures are connected. */
};
struct IntuiText requester_text6=
{
  1,	     /* FrontPen, colour register 1. */
  0,	     /* BackPen, unused since JAM1. */
  JAM1,      /* DrawMode, draw the characters with colour 1, do not */
	     /* change the background. */
  76, 78,    /* LeftEdge, TopEdge. */
  NULL,      /* ITextFont, use default font. */
  "desiv@mail.com", /* IText, the text that will be printed. */
  &requester_text5	/* NextText, no other IntuiText structures are connected. */
};




struct Requester my_requester=
{
  NULL, 	     /* OlderRequester, used by Intuition. */
  40, 20,	     /* LeftEdge, TopEdge, 40 pixels out, 20 lines down. */
  320, 100,	     /* Width, Height, 320 pixels wide, 100 lines high. */
  0, 0, 	     /* RelLeft, RelTop, Since POINTREL flag is not set, */
		     /* Intuition ignores these values. */
  &requester_gadget, /* ReqGadget, pointer to the first gadget. */
  &requester_border2, /* ReqBorder, pointer to a Border structure. */
  &requester_text6,   /* ReqText, pointer to a IntuiText structure. */
  NULL, 	     /* Flags, no flags set. */
  4,		     /* BackFill, draw everything on an orange backgr. */
  NULL, 	     /* ReqLayer, used by Intuition. Set to NULL. */
  NULL, 	     /* ReqPad1, used by Intuition. Set to NULL. */
  NULL, 	     /* ImageBMap, no predrawn Bitmap. Set to NULL. */
		     /* 	   (The PREDRAWN flag was not set) */
  NULL, 	     /* RWindow, used by Intuition. Set to NULL. */
  NULL		     /* ReqPad2, used by Intuition. Set to NULL. */
};
