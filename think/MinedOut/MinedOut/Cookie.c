
/*
 * Cookie.c
 *
 * Call it with: dcc Mined_Out.c About.c Cookie.c Graphics.c Highscore.c
 *                   Opal_12.c Play_Game.c Sound.c
 *                   -o Mined_Out
 *               Mined_Out [-Test] [Columns Rows]
 */

/*
 * This loads the Cookie.dat file and prints some Cookies.
 * If you think the list generated here is mindbreaking than you are righ&%$#ß$%ß$"$
 * Cookie.dat should not contain lines with Buffer_Size characters!!!
 */

/*
 * Copyright by: Dieter Seidel
 *               Einsteinstraﬂe 19
 *          7410 Reutlingen
 *               Germany
 */

#include <exec/types.h>
#include <stdio.h>                           /* For fgets()
#include <string.h>                          /* For strcmp(), strlen() */
#include <intuition/intuition.h>


extern BOOL   Test_Modus;                    /* Declared in Mined_Out.c */
extern UWORD  WBenchScreen_Width,            /* Declared in Mined_Out.c */
              WBenchScreen_Height;
extern struct TextFont *TopazFont_9;         /* Declared in Mined_Out.c */
extern struct TextFont *TopazFont_8;         /* Declared in Mined_Out.c */
extern struct TextFont  OpalFont;            /* Declared in Opal_12.c   */

extern struct IntuitionBase *IntuitionBase;  /* Declared in Mined_Out.c */
extern struct GfxBase       *GfxBase;        /* Declared in Mined_Out.c */

const int Letter_Delay_Time  = 2;            /* 2 Tics delay for every Letter */
const int General_Delay_Time = 300;          /* Give 6 secs for searching     */
                                             /* Cookie window                 */

int Quantity_Cookies;                 /* Number of Cookies in file Cookie.dat */

struct Cookie                                /* Contains the Cookies */
       {
         char          *Text;                /* 1st, 2nd 3rd Line, and so on */
         struct Cookie *Next_Line;
       };

struct Cookie_List
       {
         struct Cookie      *Text_List;
         struct Cookie_list *Next_Cookie;
       };

struct Cookie_List *Cookies;


#define Buffer_Size 80          /* Only lines with <> 80 characters are read */
                                /* correctly (inclusive newline characters). */
                                /* Otherwise fgets(...) fools me.            */


struct Window    *Cookie_Window;                 /* Shows the Fortune Cookie */
struct NewWindow  Cookie_New_Window =
{
  0,                /* LeftEdge    */
  0,                /* TopEdge     */
  0,                /* Width       */
  0,                /* Height      */
  0,                /* DetailPen   */
  1,                /* BlockPen    */
  NULL,             /* IDCMPFlags  */
  SMART_REFRESH|    /* Flags       */
  WINDOWDRAG,
  NULL,             /* FirstGadget */
  NULL,             /* CheckMark   */
  (char *)"",       /* Title       */
  NULL,             /* Screen      */
  NULL,             /* BitMap      */
  0,                /* MinWidth    */
  0,                /* MinHeight   */
  0,                /* MaxWidth    */
  0,                /* MaxHeight   */
  WBENCHSCREEN      /* Type        */
};


extern void Close_Libraries(void);           /* Declared in Mined_Out.c */
extern void Close_Fonts(void);               /* Declared in Mined_Out.c */


void Load_Cookies(void)
{
  FILE *Cookie_File;                         /* Local variables for Load_Cookies */
  char *File_Name = "Data/Cookie.dat";
  struct Cookie_List *New_Cookie_List;
  struct Cookie      *New_String_List;
  BOOL Buffer_Inserted;                      /* Detects the end of a cookie      */
  char Buffer[Buffer_Size];                  /* Be sure that Cookie.dat contains */
                                        /* no lines with Buffer_Size characters. */
  Cookies          = NULL;
  Quantity_Cookies = 0;                      /* No Cookies loaded */
  New_Cookie_List  = NULL;
  New_String_List  = NULL;
  Buffer_Inserted  = FALSE;

  Cookie_File = fopen(File_Name, "r");       /* Read Cookie.dat */
  if (!Cookie_File)
    if (Test_Modus)
      printf("Unable to open Cookies.dat.\n");
    else
      ;                                      /* I hate this. Really. */
  else
  {                                          /* Now reading Cookie.dat */
    while (fgets(Buffer, sizeof(Buffer), Cookie_File))
    {
      if (strlen(Buffer) == 1)               /* Empty line readed. Next Cookie expected */
      {
        if (Buffer_Inserted)
          Quantity_Cookies++;
        Buffer_Inserted = FALSE;
      }
      else                                   /* Insert String */
      {
        if (New_Cookie_List == NULL)
        {
          New_Cookie_List = (struct Cookie_List *) malloc(sizeof(struct Cookie_List));
          Cookies = New_Cookie_List;         /* Set start of Cookie List */
          New_Cookie_List->Next_Cookie = NULL;
          New_String_List = (struct Cookie *) malloc(sizeof(struct Cookie));
          New_Cookie_List->Text_List = New_String_List;
          New_String_List->Next_Line = NULL;
          New_String_List->Text = (char *) malloc(strlen(Buffer));
          strcpy(New_String_List->Text, Buffer);
          Buffer_Inserted = TRUE;
        }
        else
        {
          if (Buffer_Inserted)
          {
            New_String_List->Next_Line = (struct Cookie *)
                                         malloc(sizeof(struct Cookie));
            New_String_List->Next_Line->Next_Line = NULL;
            New_String_List->Next_Line->Text = (char *) malloc(strlen(Buffer));
            strcpy(New_String_List->Next_Line->Text, Buffer);
            New_String_List = New_String_List->Next_Line;
          }
          else
          {
            New_Cookie_List->Next_Cookie = (struct Cookie_List *)
                                           malloc(sizeof(struct Cookie_List));
            New_String_List = (struct Cookie *) malloc(sizeof(struct Cookie));
            New_String_List->Next_Line = NULL;
            New_String_List->Text = (char *) malloc(strlen(Buffer));
            strcpy(New_String_List->Text, Buffer);
            New_Cookie_List = New_Cookie_List->Next_Cookie;
            New_Cookie_List->Next_Cookie = NULL;
            New_Cookie_List->Text_List = New_String_List;
            Buffer_Inserted = TRUE;
          }
        }
      }
    }
    if (Buffer_Inserted)                     /* Cookie.dat does not end with */
      Quantity_Cookies++;                    /* an newline character.        */
    fclose(Cookie_File);                     /* All readed from Cookie.dat.  */

    if (Test_Modus)
    {
      printf("%d Cookies readed. Now printing them.\n\n",Quantity_Cookies);
      New_Cookie_List = Cookies;
      if (New_Cookie_List)
        New_String_List = Cookies->Text_List;
      else
        New_String_List = NULL;           /* No Cookies loaded, so don't print them */
      printf("Cookie:\n");
      while (New_String_List)
      {
        printf("%s", New_String_List->Text);
        New_String_List = New_String_List->Next_Line;
        if (New_String_List == NULL)
        {
          printf("\nCookie:\n");
          New_Cookie_List = New_Cookie_List->Next_Cookie;
          if (New_Cookie_List)
            New_String_List = New_Cookie_List->Text_List;
        }
      }
    }   /* Of Test_Modus */
  }
}


void Remove_Cookie_List(void)
{
}


                          /* Get the Pointer to the n.th Cookie. */
struct Cookie_List *Get_Cookie_Pointer(void)
{
  struct Cookie_List *Cookie_Pointer;
  int Random_Number = rand();

  if (Quantity_Cookies == 0)
    return(NULL);                     /* No Cookies available */
  else
  {
    Random_Number %= (Quantity_Cookies + 1);
    Cookie_Pointer = Cookies;
    while ((Random_Number > 1) && (Cookie_Pointer))
    {
      Cookie_Pointer = Cookie_Pointer->Next_Cookie;
      Random_Number--;            /* C Hackers would put this in the while Condition */
    }
    return(Cookie_Pointer);
  }
}


int Get_Lines(struct Cookie_List *Cookie_To_Print)
{
  int Count_Lines = 0;            /* No lines countet */
  struct Cookie *Next_Line;

  if (Cookie_To_Print)            /* Prevent Guru Meditation */
  {
    Next_Line = Cookie_To_Print->Text_List;
    while (Next_Line)
    {
      Count_Lines++;
      Next_Line = Next_Line->Next_Line;
    }
  }
  return(Count_Lines);
}


int Count_Letters(struct Cookie_List *Cookie_To_Print)
{
  int Count_Letters = 0;
  struct Cookie *Next_Line;

  if (Cookie_To_Print)
  {
    Next_Line = Cookie_To_Print->Text_List;
    while (Next_Line)
    {
      Count_Letters += strlen(Next_Line->Text);
      Next_Line = Next_Line->Next_Line;
    }
  }
  return(Count_Letters);
}


int Get_Max_Line_Length(struct Cookie_List *Cookie_To_Print)
{
  int Max_Line_Length = 0;    /* Set minimum length */
  struct Cookie *Next_Line;

  if (Cookie_To_Print)
  {
    Next_Line = Cookie_To_Print->Text_List;
    while (Next_Line)
    {
      if (strlen(Next_Line->Text) > Max_Line_Length)
        Max_Line_Length = strlen(Next_Line->Text);
      Next_Line = Next_Line->Next_Line;
    }
  }
  return(Max_Line_Length);
}


BOOL Print_Cookie(void)
{
  struct Cookie_List *Cookie_To_Print;                           /* Local variables */

  Cookie_New_Window.Title = (char *) "Fortune Cookie";          /* Set Window Title */
  Cookie_To_Print = Get_Cookie_Pointer();
  if (Cookie_To_Print == NULL)
  {                                       /* Print `All Cookies are broken' */
    Cookie_New_Window.Width    = 330;     /* 31 Letters * 10 Fontsize + 2*10 Border */
    Cookie_New_Window.Height   = 30;
    Cookie_New_Window.LeftEdge = (WBenchScreen_Width  - 303) / 2;
    Cookie_New_Window.TopEdge  = (WBenchScreen_Height - 28 ) / 2;

    Cookie_Window = (struct Window *) OpenWindow(&Cookie_New_Window);
    if (Cookie_Window == NULL)
    {
      printf("Could not open Fortune Cookie Window\n");
      Close_Libraries();
      Close_Fonts();
      exit(1000);
    }
    SetAPen(Cookie_Window->RPort, 1);
    SetDrMd(Cookie_Window->RPort, JAM1);
    SetFont(Cookie_Window->RPort, TopazFont_9);
    Move(Cookie_Window->RPort, 10, 22);
    Text(Cookie_Window->RPort, "All Fortune Cookies are broken.", 31);
    Delay(Letter_Delay_Time * 31 + General_Delay_Time);
    if (Cookie_Window)
      CloseWindow(Cookie_Window);
  }
  else
  {                                                              /* Print Cookie */
    int How_Many_Lines   = Get_Lines(Cookie_To_Print);           /* Local variables */
    int How_Many_Letters = Count_Letters(Cookie_To_Print);
    int Max_Line_Length  = Get_Max_Line_Length(Cookie_To_Print);
    int Display_Row      = 22;         /* Row of the first line from the Cookie ... */
    struct Cookie *Next_Line;

    Cookie_New_Window.Width    = Max_Line_Length * 8 + 2 * 10;
    if (Cookie_New_Window.Width > WBenchScreen_Width)
    {
      if (Test_Modus)
        printf("The width of the Cookie is to large. Can't open Window!\n");
      return(FALSE);
    }
    Cookie_New_Window.Height   = 21 + 8 * How_Many_Lines;
    if (Cookie_New_Window.Height > WBenchScreen_Height)
    {
      if (Test_Modus)
        printf("The height of the Cookie is to large. Can't open Window!\n");
      return(FALSE);
    }
    Cookie_New_Window.LeftEdge = (WBenchScreen_Width  - Cookie_New_Window.Width ) / 2;
    Cookie_New_Window.TopEdge  = (WBenchScreen_Height - Cookie_New_Window.Height) / 2;

    Cookie_Window = (struct Window *) OpenWindow(&Cookie_New_Window);
    if (Cookie_Window == NULL)
    {
      printf("Could not open Fortune Cookie Window\n");
      Close_Libraries();
      Close_Fonts();
      exit(1000);
    }
    SetAPen(Cookie_Window->RPort, 1);
    SetDrMd(Cookie_Window->RPort, JAM1);
    SetFont(Cookie_Window->RPort, TopazFont_8);
    Next_Line = Cookie_To_Print->Text_List;
    while (Next_Line)
    {
      Move(Cookie_Window->RPort, 10, Display_Row);
      Text(Cookie_Window->RPort, Next_Line->Text, strlen(Next_Line->Text) - 1);
      Next_Line = Next_Line->Next_Line;
      Display_Row += 8;
    }
    Delay(Letter_Delay_Time * How_Many_Letters + General_Delay_Time);
    if (Cookie_Window)
      CloseWindow(Cookie_Window);
  }
  return(TRUE);
}


BOOL Print_Cookie_Dead(void)
{
  struct Cookie_List *Cookie_To_Print;       /* Local variables */

  Cookie_New_Window.Title = (char *) "You are DEAD!";        /* Set Window Title */
  Cookie_To_Print = Get_Cookie_Pointer();
  if (Cookie_To_Print == NULL)
  {                                       /* Print `All Cookies are broken' */
    Cookie_New_Window.Width    = 330;     /* 31Letters * 10Fontsize + 2*10Border */
    Cookie_New_Window.Height   = 30;
    Cookie_New_Window.LeftEdge = (WBenchScreen_Width  - 303) / 2;
    Cookie_New_Window.TopEdge  = (WBenchScreen_Height - 28 ) / 2;

    Cookie_Window = (struct Window *) OpenWindow(&Cookie_New_Window);
    if (Cookie_Window == NULL)
    {
      printf("Could not open Fortune Cookie Window\n");
      Close_Libraries();
      Close_Fonts();
      exit(1000);
    }
    SetAPen(Cookie_Window->RPort, 1);
    SetDrMd(Cookie_Window->RPort, JAM1);
    SetFont(Cookie_Window->RPort, TopazFont_9);
    Move(Cookie_Window->RPort, 10, 22);
    Text(Cookie_Window->RPort, "All Fortune Cookies are broken.", 31);
    Delay(Letter_Delay_Time * 31 + General_Delay_Time);
    if (Cookie_Window)
      CloseWindow(Cookie_Window);
  }
  else
  {                                                              /* Print Cookie */
    int How_Many_Lines   = Get_Lines(Cookie_To_Print);           /* Local variables */
    int How_Many_Letters = Count_Letters(Cookie_To_Print);
    int Max_Line_Length  = Get_Max_Line_Length(Cookie_To_Print);
    int Display_Row      = 22 + 36;    /* Row of the first line from the Cookie ... */
    struct Cookie *Next_Line;

    Cookie_New_Window.Width    = Max_Line_Length * 8 + 2 * 10;
    if (Cookie_New_Window.Width > WBenchScreen_Width)
    {
      if (Test_Modus)
        printf("The width of the Cookie is to large. Can't open Window!\n");
      return(FALSE);
    }
    if (Cookie_New_Window.Width < (42 * 9 + 2 * 10 + 40))
      Cookie_New_Window.Width = 42 * 9 + 2 * 10 + 40;
                        /* 44 characters for the text from god * 9 character size */
                        /* + 2 * 10 Border + 2 * 20 extra border.                 */
    Cookie_New_Window.Height  = 21 + 36 + 8 * How_Many_Lines;
    if (Cookie_New_Window.Height > WBenchScreen_Height)
    {
      if (Test_Modus)
        printf("The height of the Cookie is to large. Can't open Window!\n");
      return(FALSE);
    }
    Cookie_New_Window.LeftEdge = (WBenchScreen_Width  - Cookie_New_Window.Width ) / 2;
    Cookie_New_Window.TopEdge  = (WBenchScreen_Height - Cookie_New_Window.Height) / 2;

    Cookie_Window = (struct Window *) OpenWindow(&Cookie_New_Window);
    if (Cookie_Window == NULL)
    {
      printf("Could not open Fortune Cookie Window\n");
      Close_Libraries();
      Close_Fonts();
      exit(1000);
    }
    SetAPen(Cookie_Window->RPort, 1);
    SetDrMd(Cookie_Window->RPort, JAM1);
    SetFont(Cookie_Window->RPort, &OpalFont);
    Move(Cookie_Window->RPort, 30, 22);
    Text(Cookie_Window->RPort, "After you reached heaven, God speaks to you:", 44);
    Move(Cookie_Window->RPort, 66, 34);
    Text(Cookie_Window->RPort, "`I give you another chance on earth'", 36);
    Move(Cookie_Window->RPort, 30, 46);
    Text(Cookie_Window->RPort, "and hands an Fortune Cookie to you.", 35);

    SetAPen(Cookie_Window->RPort, 1);
    SetDrMd(Cookie_Window->RPort, JAM1);
    SetFont(Cookie_Window->RPort, TopazFont_8);
    Next_Line = Cookie_To_Print->Text_List;
    while (Next_Line)
    {
      Move(Cookie_Window->RPort, 10, Display_Row);
      Text(Cookie_Window->RPort, Next_Line->Text, strlen(Next_Line->Text) - 1);
      Next_Line = Next_Line->Next_Line;
      Display_Row += 8;
    }
    Delay(Letter_Delay_Time * How_Many_Letters + General_Delay_Time);
    if (Cookie_Window)
      CloseWindow(Cookie_Window);
  }
  return(TRUE);
}

