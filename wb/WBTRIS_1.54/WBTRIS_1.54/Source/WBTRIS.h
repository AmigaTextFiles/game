#include "WBTRIS_Include.h"

#define VERSION            " 1.54"
#define PROG_NAME          "WBTRIS"
#define AUTHOR             "Dirk Böhmer und Ralf Pieper"
#define GD_HighscoreGadget 0
#define GD_ScoreGadget     1
#define GD_LevelGadget     2
#define GD_LineGadget      3
#define GD_PauseGadget     4
#define GD_StatGadget      5
#define GD_OptGadget       6
#define GD_NewGadget       7
#define GD_ShowScoreGadget     8

/* Defines */

#define ABSTAND 2

#define MAINWINDOWLEFT 0
#define MAINWINDOWTOP 0
#define DEFAULTTICKS 40

#define SPACE '\x40'
#define QUICKSPACE '\x44'
#define CURSOR_RIGHT '\x4e'
#define CURSOR_LEFT '\x4f'
#define CURSOR_DOWN '\x4d'
#define CURSOR_UP '\x4c'

#define SPACE2 '\x0f'
#define QUICKSPACE2 '\x43'
#define CURSOR_RIGHT2 '\x2f'
#define CURSOR_LEFT2 '\x2d'
#define CURSOR_DOWN2 '\x1e'
#define CURSOR_UP2 '\x3e'

#define XSIZE 10
#define YSIZE 23
#define YOFFSET 8

#define MY_WIN_LEFT   (20)
#define MY_WIN_TOP    (10)
#define MY_WIN_WIDTH  (337)
#define MY_WIN_HEIGHT (157)
#define FILENAME "WBTRIS.scores"


/* our function prototypes */
int wbmain(struct WBStartup *wbs);
int main(void);
int Real_Main(void);
void openall(void);
void closeall(void);
void closeout(UBYTE *errstring, LONG rc);
BOOL CollisionRight(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y);
BOOL CollisionLeft (struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y);
BOOL CollisionDown(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y, BOOL RightOrLeft);
void Draw_Object(int x, int y, struct obj *objptr, BOOL malen, BOOL RightOrLeft);
BOOL Rotate_Matrixr(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y, BOOL RightOrLeft);
BOOL Rotate_Matrixl(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y, BOOL RightOrLeft);
void Draw_Box(int x,int y, int color, int malen, BOOL RightOrLeft);
struct obj *RandomObject(BOOL RightOrLeft);
void DrawWindow(void);
void SetNewMatrix(struct obj *objptr, int field[YSIZE+1][XSIZE+2], int x, int y);
void CleanUp(int field[YSIZE+1][XSIZE+2], BOOL RightOrLeft);
BOOL GameOver(int field[YSIZE+1][XSIZE+2],BOOL lockname);
void InitObjects(void);
void WaitForActivateWindow(void);
BOOL Pause(void);
void NewGame(int field[YSIZE+1][XSIZE+2], BOOL vongameover, BOOL vonoptions);
void QuitGame(void);
BOOL InFirstLine(struct obj *objptr);
void Draw_NextObject(struct obj *objptr, BOOL FieldRight);
void ClearNextField(BOOL FieldRight);
struct Gadget *CreateAllGadgets(struct Screen *myscreen);
int Loadhiscore(void);
BOOL AskContinue(void);
void UpdateStatistic(int objnumber);
void PutRows(int field[YSIZE+1][XSIZE+2], BOOL RightOrLeft, int NumberOfRows);
void ReDrawField(int field[YSIZE+1][XSIZE+2], BOOL RitghOrLeft);
void HideField(void);
void ClearAllMsgPorts(void);


/* Hiscore.c */
void HiscoreList(char *Name, int Level, int Score, int Rows, int XOffset, int YOffset, BOOL ShowHiscore);
void OutHiscoreList(void);
void UpdateHiscore(char *Name, int Score, int Rows, int Level);
void AddSpaces(int n, char *s);
BOOL SaveFile(void);
void LoadFile(void);

/* Options.c */
int OpenOptionsWindow(void);
void CloseOptionsWindow( void );
BOOL handleGadgetEvent(struct Window *win, struct Gadget *gad, UWORD code, struct Gadget *my_gads[]);
VOID process_window_events(struct Window *mywin, struct Gadget *my_gads[]);
void OpenOptions(WORD winxpos, WORD winypos);

/* Statistic.c */
void statistic(WORD WBTRIS_Window_Left, WORD WBTRIS_Window_Top, int ob1, int ob2, int ob3, int ob4, int ob5, int ob6, int ob7);
void DrawWin(struct Window *win,APTR  VisualInfo);

/* Name.c */
int OpenProject0Window(void);
void CloseProject0Window(void);
void AskForName(void);
