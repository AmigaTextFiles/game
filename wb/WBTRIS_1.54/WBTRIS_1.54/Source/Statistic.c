#include "WBTRIS.h"

#define beveloff       50


__chip UWORD tileData[] = {
    0x0080,0x7F80,0x7F80,0x7F80,0x7F80,0x7F80,0x7F80,
    0xFF00,0xFF00,0xFF00,0xFF00,0xFF00,0xFF00,0x8000,
};

struct Image tile = {
    0, 0,
    9, 7, 2,
    tileData,
    0x0003, 0x0000,
    NULL
};

extern BOOL            UseLace;
extern struct TextAttr helvetica13;
extern struct TextAttr topaz8;


void statistic(WORD WBTRIS_Window_Left, WORD WBTRIS_Window_Top, int ob1, int ob2, int ob3, int ob4, int ob5, int ob6, int ob7)
{
   extern APTR           VisualInfo;
   extern struct Screen *myscreen;

   struct Window        *win = NULL;
   int                   i;
   double                max=0.0;
   double                laenge;
   double                objects[7];
   struct IntuiText      Zeile;
   char                  s[80];
   double                summe = 0;

   objects[0] = ob2;
   objects[1] = ob6;
   objects[2] = ob7;
   objects[3] = ob3;
   objects[4] = ob4;
   objects[5] = ob5;
   objects[6] = ob1;

   Zeile.FrontPen = 1;
   Zeile.BackPen = 0;
   Zeile.DrawMode = JAM2;
   Zeile.LeftEdge = 0;
   Zeile.TopEdge = 0;
   if (UseLace)
      Zeile.ITextFont = &helvetica13;
   else
      Zeile.ITextFont = &topaz8;
   Zeile.NextText = NULL;

   s[0] = '\0';

   if (win = OpenWindowTags(NULL,
                            WA_Left,         WBTRIS_Window_Left,
                            WA_Top,          WBTRIS_Window_Top+(myscreen->Font->ta_YSize)+3,
                            WA_Width,        337,
                            WA_Height,       265+(myscreen->Font->ta_YSize),
                            WA_CloseGadget,  TRUE,
                            WA_Title,        "<-- Click to close",
                            WA_DragBar,      TRUE,
                            WA_Activate,     TRUE,
                            WA_Flags,        WFLG_DRAGBAR | WFLG_DEPTHGADGET | WFLG_WINDOWACTIVE,
                            WA_IDCMP,        IDCMP_CLOSEWINDOW | IDCMP_RAWKEY,
                            TAG_END)) {
      DrawWin(win,VisualInfo);
      for (i=0;i<7;i++) {
         if (objects[i] > max)
            max = objects[i];
         summe = summe + objects[i];
      }
      if (summe == 0)
         summe = 0.00000001;
      if (max == 0)
         max = 1;
      for (i=0;i<7;i++) {
         laenge = 172*objects[i]/max;
         SetAPen(win->RPort,3);
         RectFill(win->RPort, 72, 35*i+23+(myscreen->Font->ta_YSize), (short)(72+laenge), 35*i+34+(myscreen->Font->ta_YSize));
         sprintf(s, "%5.1f%%", 100*objects[i]/summe);
         Zeile.IText = s;
         PrintIText(win->RPort, &Zeile, 255, 35*i+23+(myscreen->Font->ta_YSize));
         s[0] = '\0';
      }
      WaitPort(win->UserPort);
      CloseWindow(win);
   }
}



void DrawWin(struct Window *win,APTR  VisualInfo)
{
   int i,j;
   extern struct obj {
     BOOL objData[4][4];
     int color;
   };
   extern struct obj objects[8];
   short ObjNumber = 1;

   while (ObjNumber<=7) {
      for (i=0;i<4;i++)
         for (j=0;j<4;j++)
            if (objects[ObjNumber].objData[j][i] == 1)
               DrawImage(win->RPort,&tile,9*i+18,35*ObjNumber+7*j-20+(myscreen->Font->ta_YSize));
      DrawBevelBox(win->RPort, 15 , 35*ObjNumber-22+(myscreen->Font->ta_YSize) , 43, 32 ,GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);
      DrawBevelBox(win->RPort, 70 , 35*ObjNumber-13+(myscreen->Font->ta_YSize) , 177, 14 ,GTBB_Recessed, TRUE, GT_VisualInfo, VisualInfo);
      ObjNumber++;
   }
}
