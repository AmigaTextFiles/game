/*
 * highwindow.c V1.1
 *
 * highscore window handling
 *
 * (c) 1992-1993 Holger Brunst
 */

#include <CClock.h>

/* HighScore structure */
struct HighEntry {
                  char  name[HIGH_STRLEN+1];
                  ULONG time;
                 };

#define HIGH_ENTRIES    10
struct HighScore {
                  struct HighEntry     entry[HIGH_ENTRIES];
                  long                 checksum;
                 };

/* Window data */
#define WIN_X   128
#define WIN_Y   38      
#define WIN_W   384
#define WIN_H   124
#define WINDOW_IDCMP (IDCMP_REFRESHWINDOW|IDCMP_CLOSEWINDOW) 
static struct Window    *win;
static struct RastPort  *rast;

/* Highscore data */
static struct HighScore     score;
static struct TextExtent    textex;
static char                 time[8];
static char *numbers[10] = {
                            " 1.", " 2.", " 3.", " 4.", " 5.",
                            " 6.", " 7.", " 8.", " 9.", "10." 
                           };

/* Calculate & draw a highscore list */ 
static void DisplayHighScore(void)
{
 short  i, yoffset = 24, len;
 long   sec;

 SetAPen(rast, 1);
 /* Draw highscore list */
 for (i = 0; i < HIGH_ENTRIES; i++) {
  /* convert seconds to time string */
  sec = score.entry[i].time;

  /* Last entry if time less than 0 */
  if (sec == ~0) break;
  sprintf(time, "%01ld:%02ld:%02ld", sec/3600, sec/60 - (sec/3600) * 60, sec % 60); 

  /* Cut off names that are too long */
  len = TextFit(rast,
                score.entry[i].name,
                strlen(score.entry[i].name),
                &textex, NULL,
                +1, 240, 9);

  /* Draw highscore */
  Move(rast, 40-TextLength(rast, numbers[i], 3), yoffset);  
  Text(rast, numbers[i], 3); 
  Move(rast, 48, yoffset);  
  Text(rast, score.entry[i].name, len);
  Move(rast, 296+(62-TextLength(rast, time, 7))/2, yoffset);  
  Text(rast, time, 7);
  yoffset += 10;
 }
}

BOOL OpenHighWindow(void)
{
 /* Open Window */
 if (win = OpenWindowTags(NULL, WA_Left, WIN_X,
                                WA_Top, WIN_Y,
                                WA_Width, WIN_W,
                                WA_Height, WIN_H,
                                WA_Title,  GAME_NAME" Highscore",
                                WA_PubScreen, Screen,
                                WA_Flags, WFLG_SMART_REFRESH|WFLG_ACTIVATE|
                                          WFLG_DRAGBAR|WFLG_DEPTHGADGET|
                                          WFLG_CLOSEGADGET|WFLG_RMBTRAP,
                                TAG_DONE)) {

  /* Get rast-port */
  rast = win->RPort;

  /* Show highscore */
  DisplayHighScore();

  /* Set IDCMPPort */
  win->UserPort = IDCMPPort;
  win->UserData = HandleHighWindowIDCMP;
  ModifyIDCMP(win, WINDOW_IDCMP);

  /* Ok. */
  return (TRUE);
 }
 /* failure */
 return (FALSE);
}

static void CloseHighWindow(void)
{
 CloseWindowSafely(win);
}

void *HandleHighWindowIDCMP(struct IntuiMessage *msg)
{
 switch (msg->Class) {
  case IDCMP_CLOSEWINDOW: /* First reply message */
                          GT_ReplyIMsg(msg);
                          CloseHighWindow();
                          return (TRUE);
                          break;

  case IDCMP_REFRESHWINDOW: GT_BeginRefresh(win);
                            GT_EndRefresh(win, TRUE);
                            break;
 }
 return (NULL);
}

/* Ask whether a score is a highscore or not */ 
BOOL AskHighScore(ULONG time)
{
 /* Highscore? */
 if (time < score.entry[HIGH_ENTRIES-1].time)
  /* Yes */
  return (TRUE);
 /* No */
 return (FALSE);
}

/* Insert a highscore */
void InsertHighScore(char *name, ULONG time)
{
 short i = HIGH_ENTRIES, ins;

 /* Find position to insert highscore */
 while ((i > 0) && (time < score.entry[i-1].time)) --i;

 /* Is it a highscore? */
 if (i < HIGH_ENTRIES) {
  /* Yes, craete space by shifting worse scores down */
  ins = i;
  for (i = HIGH_ENTRIES-1; i > ins; i--) {
   strcpy(score.entry[i].name, score.entry[i-1].name);
   score.entry[i].time = score.entry[i-1].time;
  }
  /* Copy new entry to correct postion */
  strcpy(score.entry[ins].name, name);
  score.entry[ins].time = time;
 }
}

/* Load highscore list */
void LoadHighScore(void)
{
 short i;
 struct FileHandle	*doshandle;

 /* Open highscore */
 if (doshandle = (struct FileHandle *) Open(HIGH_NAME, MODE_OLDFILE)) {
  /* Read highscore */
  if (Read((BPTR) doshandle, &score, sizeof (score)) == sizeof (score)) {
   Close((BPTR) doshandle);
   return();
  }  
  Close((BPTR) doshandle);
 }

 /* Default highscore */
 sprintf(score.entry[0].name, "Holger Brunst");
 score.entry[0].time = 40;
 for (i = 1; i < HIGH_ENTRIES; i++) {
  score.entry[i].name[0] = NULL;
  score.entry[i].time = ~0;
 }
}

/* Save highscore list */
void SaveHighScore(void)
{
 struct FileHandle	*doshandle;

 /* Open highscore */
 if (doshandle = (struct FileHandle *) Open(HIGH_NAME, MODE_NEWFILE)) {
  /* Write highscore */
  Write((BPTR) doshandle, &score, sizeof (score));
  Close((BPTR) doshandle);
 }
} 
