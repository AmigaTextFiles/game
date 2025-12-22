#include "WBTRIS.h"

struct HiscorePart {
   int  Position;
   char Name[40];
   int  Score;
   int  Rows;
   int  Level;
};

struct RastPort       *HiscoreRP = NULL;
struct HiscorePart     Hiscore[10];
struct Window         *HiscoreWindow = NULL;

short                  win_width;
short                  win_height;

extern BOOL            UseLace;
extern struct Screen  *myscreen;
extern struct TextAttr helvetica13;
extern struct TextAttr topaz8;

void HiscoreList(char *Name, int Level, int Score, int Rows, int XOffset, int YOffset, BOOL ShowHiscore)
{
   struct IntuiMessage *imsg = NULL;
   BOOL                 terminated = FALSE;

   if (UseLace) {
      win_width = MY_WIN_WIDTH;
      win_height = MY_WIN_HEIGHT + 7;
   } else {
      win_width = MY_WIN_WIDTH+32;
      win_height = MY_WIN_HEIGHT - 10;
   }

   if (HiscoreWindow = OpenWindowTags(NULL,
                                WA_Left,       XOffset,
                                WA_Top,        YOffset+(myscreen->Font->ta_YSize)+3,
                                WA_Width,      win_width,
                                WA_Height,     win_height+(myscreen->Font->ta_YSize),
                                WA_Title,      "<-- Click to close!",
                                WA_Flags,      WFLG_CLOSEGADGET | WFLG_ACTIVATE | WFLG_DRAGBAR | WFLG_DEPTHGADGET,
                                WA_IDCMP,      IDCMP_CLOSEWINDOW | IDCMP_RAWKEY,
                                TAG_END))
      {
      HiscoreRP = HiscoreWindow->RPort;

      LoadFile();
      UpdateHiscore(Name, Score, Rows, Level);
      OutHiscoreList();
      if (!ShowHiscore) {
         if (SaveFile() == FALSE)
            CloseWindow(HiscoreWindow);
      }

   while (!terminated) {
      Wait (1 << HiscoreWindow->UserPort->mp_SigBit);

      while (imsg = GT_GetIMsg(HiscoreWindow->UserPort)) {
         switch (imsg->Class) {
            case IDCMP_RAWKEY:
               if (imsg->Code == '\x45')
                  terminated = TRUE;
               break;

            case IDCMP_CLOSEWINDOW:
               terminated = TRUE;
               break;
         }
         GT_ReplyIMsg(imsg);
      }
   }
   CloseWindow(HiscoreWindow);
   }
}



/*
** Ausgabe der Liste ins Fenster
*/
void OutHiscoreList(void)
{
   int              i;
   char             s[80];
   struct IntuiText Zeile;
   short            Step = 0;

   if (UseLace)
      Step = 2;
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

   strcpy(s, "Pos.");
   Zeile.IText = s;
   PrintIText(HiscoreRP, &Zeile, 12, 8+(myscreen->Font->ta_YSize));

   strcpy(s, "Name");
   Zeile.IText = s;
   if (UseLace)
      PrintIText(HiscoreRP, &Zeile, 40, 8+(myscreen->Font->ta_YSize));
   else
      PrintIText(HiscoreRP, &Zeile, 50, 8+(myscreen->Font->ta_YSize));

   strcpy(s, "Score");
   Zeile.IText = s;
   PrintIText(HiscoreRP, &Zeile, 210, 8+(myscreen->Font->ta_YSize));

   strcpy(s, "Rows");
   Zeile.IText = s;
   if (UseLace)
      PrintIText(HiscoreRP, &Zeile, 250, 8+(myscreen->Font->ta_YSize));
   else
      PrintIText(HiscoreRP, &Zeile, 265, 8+(myscreen->Font->ta_YSize));

   strcpy(s, "Level");
   Zeile.IText = s;
   if (UseLace)
      PrintIText(HiscoreRP, &Zeile, 290, 8+(myscreen->Font->ta_YSize));
   else
      PrintIText(HiscoreRP, &Zeile, 313, 8+(myscreen->Font->ta_YSize));

   SetAPen(HiscoreRP, 1);
   if (UseLace) {
      Move(HiscoreRP, 10, 23+(myscreen->Font->ta_YSize));
      Draw(HiscoreRP, win_width - 10, 23+(myscreen->Font->ta_YSize));
   }
   else {
      Move(HiscoreRP, 10, 20+(myscreen->Font->ta_YSize));
      Draw(HiscoreRP, win_width - 10, 20+(myscreen->Font->ta_YSize));
   }

   for (i=0; i<10; i++) {
      sprintf(s, "%2d", i+1);
      Zeile.IText = s;
      PrintIText(HiscoreRP, &Zeile, 12, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));

      sprintf(s, "%-23s", Hiscore[i].Name);
      Zeile.IText = s;
      if (UseLace)
         PrintIText(HiscoreRP, &Zeile, 40, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));
      else
         PrintIText(HiscoreRP, &Zeile, 50, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));

      sprintf(s, "%6d", Hiscore[i].Score);
      Zeile.IText = s;
      PrintIText(HiscoreRP, &Zeile, 203, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));

      sprintf(s, "%5d", Hiscore[i].Rows);
      Zeile.IText = s;
      PrintIText(HiscoreRP, &Zeile, 250, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));

      sprintf(s, "%3d", Hiscore[i].Level);
      Zeile.IText = s;
      if (UseLace)
         PrintIText(HiscoreRP, &Zeile, 290, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));
      else
         PrintIText(HiscoreRP, &Zeile, 313, 26+(11 + Step)*i+(myscreen->Font->ta_YSize));

   }
}



/*
** Sortiert Liste neu
*/
void UpdateHiscore(char *Name, int Score, int Rows, int Level)
{
   int i = 0;
   int j;
   BOOL equal = FALSE;

   while ((equal == FALSE) && (Score <= Hiscore[i].Score) && (i <= 9)) {
      if (Score == Hiscore[i].Score)
         equal = TRUE;
      else
         i++;
   }

   if (equal == TRUE) {
      while ((Score == Hiscore[i].Score) && (Rows <= Hiscore[i].Rows) && (i<=9))
         i++;
   }

   for (j = 9; j > i; j--) {
      Hiscore[j].Score = Hiscore[j-1].Score;
      strcpy(Hiscore[j].Name, Hiscore[j-1].Name);
      Hiscore[j].Rows  = Hiscore[j-1].Rows;
      Hiscore[j].Level  = Hiscore[j-1].Level;
   }

   Hiscore[i].Score = Score;
   strcpy(Hiscore[i].Name, Name);
   Hiscore[i].Rows  = Rows;
   Hiscore[i].Level = Level;
}



/*
** Speichert das Hiscorefile ab
*/
BOOL SaveFile(void)
{
   int   i;
   FILE *fp = NULL;
   char  FName[80];

   if (getenv("WBTRIS"))
      strcpy(FName, getenv("WBTRIS"));
   else
      strcpy(FName, FILENAME);

   if ((fp = fopen(FName, "w")) == NULL) {
      fprintf(stderr, "Couldn't open file '%s'.\n", FName);
      return(FALSE);
   }
   for (i=0; i<10; i++) {
      fprintf(fp, "%d/%s/%d/%d/%d\n", i+1, Hiscore[i].Name, Hiscore[i].Score, Hiscore[i].Rows, Hiscore[i].Level);
   }
   fclose(fp);
   return(TRUE);
}



/*
** Laedt das Hiscorefile ein
*/
void LoadFile(void)
{
   int i;
   FILE *fp;
   int c;
   char text[30];
   char *ptr;
   char FName[80];

   if (getenv("WBTRIS"))
      strcpy(FName, getenv("WBTRIS"));
   else
      strcpy(FName, FILENAME);

   if ((fp = fopen(FName, "r")) == NULL) {
      for (i=0; i<10; i++) {
         Hiscore[i].Position = i+1;
         strcpy(Hiscore[i].Name, "...");
         Hiscore[i].Score = 0;
         Hiscore[i].Rows = 0;
         Hiscore[i].Level = 0;
      }
   } else {
      i = 0;
      while ((c = fgetc(fp)) != EOF) {
         while (c != '/') {
            c = fgetc(fp);
         }
         Hiscore[i].Position = i+1;

         ptr = &text[0];
         *ptr = '\0';
         while ((c = fgetc(fp)) != '/') {
            *ptr = c;
            ptr++;
         }
         *ptr = '\0';
         strcpy(Hiscore[i].Name, text);

         ptr = &text[0];
         *ptr = '\0';
         while ((c = fgetc(fp)) != '/') {
            *ptr = c;
            ptr++;
         }
         *ptr = '\0';
         Hiscore[i].Score = atoi(text);

         ptr = &text[0];
         *ptr = '\0';
         while ((c = fgetc(fp)) != '/') {
            *ptr = c;
            ptr++;
         }
         *ptr = '\0';
         Hiscore[i].Rows = atoi(text);

         ptr = &text[0];
         *ptr = '\0';
         while ((c = fgetc(fp)) != '\n') {
            *ptr = c;
            ptr++;
         }
         *ptr = '\0';
         Hiscore[i].Level = atoi(text);
         i++;
      }
      fclose(fp);
   }
}
