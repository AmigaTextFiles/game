/* Amiga Glk implementation, based on GlkTerm */

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#if defined __AROS__
#include <string.h>
#endif

#if defined __AROS__
#include <proto/asl.h>
#include <proto/dos.h>
#include <proto/exec.h>
#include <proto/gadtools.h>
#include <proto/icon.h>
#include <intuition/intuition.h>
#include <proto/intuition.h>
#include <proto/locale.h>
#include <proto/graphics.h>
#else
#include <clib/asl_protos.h>
#include <clib/dos_protos.h>
#include <clib/exec_protos.h>
#include <clib/gadtools_protos.h>
#include <clib/icon_protos.h>
#include <clib/intuition_protos.h>
#include <clib/locale_protos.h>
#endif
#include <clib/macros.h>
#include <graphics/videocontrol.h>
#include <libraries/locale.h>
#include <utility/date.h>
#include <proto/intuition.h>

#define QUAL_SHIFT (IEQUALIFIER_LSHIFT|IEQUALIFIER_RSHIFT)
#define QUAL_CTRL (IEQUALIFIER_CONTROL)

#include "glk.h"
#include "glkterm.h"
#include "curses.h"
#include "bn/bn.h"

int stdscr = 0, curscr = 0;
int init_cols = 0, init_lines = 0;
int COLS = 0, LINES = 0;

int pref_printversion = 0;
int pref_screenwidth = 0;
int pref_screenheight = 0;
int pref_messageline = 0;
int pref_reverse_textgrids = 0;
int pref_override_window_borders = 0;
int pref_window_borders = 0;
int pref_precise_timing = 0;
int pref_historylen = 20;
int pref_prompt_defaults = 1;

int UseScreen = 1;
#if defined __AROS__
#define __autoexit
//extern struct IntuitionBase* IntuitionBase;
struct LocaleBase* LocaleBase;
extern void gli_sig_winsize(int val);
#else
extern struct Library* IntuitionBase;
struct Library* LocaleBase;
#endif
struct Screen* Screen = 0;
struct Screen* DefaultPubScreen = 0;
struct Window* Window = 0;
struct Window* OldWindowPtr = 0;
struct RastPort* RPort = 0;
struct Menu* Menus = 0;
struct Process* ThisProcess = 0;
struct DiskObject* Icon = 0;
struct FileRequester* FileReq = 0;

APTR Visual = 0;
#ifndef __AROS__
BPTR StartLock = 0, OldLock = 0;
#endif

struct NewMenu NewMenus[] = {
  { NM_TITLE,"Project",0,0,0,0 },
  { NM_ITEM,"About...","?",0,0,0 },
  { NM_ITEM,"Quit","Q",0,0,0 },
  { NM_END,0,0,0,0,0 }
};

char* TextArray = 0;
char* TextAttrArray = 0;
char* TextDirty = 0;
int TextX = 0, TextY = 0, TextAttr = 0;
int ItalicUsed = 0;

extern char TitleBar[], AboutText[], InitReqTitle[], InitReqPattern[];

__autoexit void amiga_close(void)
{
  if (Menus)
    FreeMenus(Menus);
  if (Visual)
    FreeVisualInfo(Visual);
  if (ThisProcess)
    ThisProcess->pr_WindowPtr = OldWindowPtr;
  if (Window)
    CloseWindow(Window);
  if (Screen)
    CloseScreen(Screen);
  if (Icon)
    FreeDiskObject(Icon);
  if (FileReq)
    FreeAslRequest(FileReq);
  if (DefaultPubScreen)
    UnlockPubScreen(0,DefaultPubScreen);
#ifndef __AROS__
  if (StartLock)
  {
    CurrentDir(OldLock);
    UnLock(StartLock);
  }
#endif
  if (TextArray)
  {
    free(TextArray);
    free(TextAttrArray);
    free(TextDirty);
  }
  if (LocaleBase)
    CloseLibrary((struct Library *) LocaleBase);
}

void amiga_cursor(void)
{
  SetDrMd(RPort,COMPLEMENT);
  int x = Window->BorderLeft+(TextX*RPort->TxWidth);
  int y = Window->BorderTop+(TextY*RPort->TxHeight);
  RectFill(RPort,x,y,x+RPort->TxWidth-1,y+RPort->TxHeight-1);
  SetDrMd(RPort,JAM2);
}

void amiga_line(char* str, int len, int x, int y, char attr)
{
  int text = 0;
  int i;
  for (i = 0; i < len; i++)
  {
    if (str[i] != ' ')
    {
      text = 1;
      break;
    }
  }
  if (text)
  {
    Move(RPort,
      Window->BorderLeft+(x*RPort->TxWidth),
      Window->BorderTop+(y*RPort->TxHeight)+RPort->TxBaseline);
    if (attr & A_REVERSE)
    {
      SetAPen(RPort,2);
      SetBPen(RPort,1);
    }
    else
    {
      SetAPen(RPort,1);
      SetBPen(RPort,0);
    }
    if (attr & A_BOLD)
    {
      while ((RPort->AlgoStyle & FSF_BOLD) == 0)
        SetSoftStyle(RPort,RPort->AlgoStyle|FSF_BOLD,AskSoftStyle(RPort));
    }
    if (attr & A_UNDERLINE)
    {
      while ((RPort->AlgoStyle & FSF_ITALIC) == 0)
        SetSoftStyle(RPort,RPort->AlgoStyle|FSF_ITALIC,AskSoftStyle(RPort));
      ItalicUsed = 1;
    }
    Text(RPort,str,len);
    while (RPort->AlgoStyle != 0)
      SetSoftStyle(RPort,FS_NORMAL,AskSoftStyle(RPort));
  }
  else
  {
    if (attr & A_REVERSE)
      SetAPen(RPort,1);
    else
      SetAPen(RPort,0);
    RectFill(RPort,
      Window->BorderLeft+(x*RPort->TxWidth),
      Window->BorderTop+(y*RPort->TxHeight),
      Window->BorderLeft+((x+len)*RPort->TxWidth)-1,
      Window->BorderTop+((y+1)*RPort->TxHeight)-1);
  }
}

void amiga_redraw(void)
{
  int y;
  for (y = 0; y < LINES; y++)
  {
    if (TextDirty[y] == 0)
      continue;

    int off = y*COLS;
    int x1 = 0, x2 = 0;
    int attr = TextAttrArray[off];
    while (x1+x2 <= COLS)
    {
      if ((x1+x2 < COLS) && (attr == TextAttrArray[off+x1+x2]))
      {
        x2++;
        continue;
      }
      amiga_line(TextArray+off+x1,x2,x1,y,attr);
      x1 += x2;
      x2 = 1;
      if (x1 < COLS)
        attr = TextAttrArray[off+x1];
    }
  }
}

void amiga_busy(int busy)
{
#if !defined __AROS__
  if (IntuitionBase->lib_Version >= 39)
#endif
    SetWindowPointer(Window,WA_BusyPointer,busy,TAG_DONE);
}

void amiga_about(void)
{
  struct EasyStruct req = {
    sizeof(struct EasyStruct),0,TitleBar,AboutText,"Continue"
  };
  amiga_busy(1);
  EasyRequestArgs(Window,&req,0,0);
  amiga_busy(0);
}

int amiga_filereq(char *buffer, int len, ...)
{
va_list args;
LONG result;

  if (FileReq == 0)
  {
    if ((FileReq = AllocAslRequestTags(ASL_FileRequest,
      ASLFR_SleepWindow,1,
      ASLFR_RejectIcons,1,TAG_DONE)) == 0)
    {
      return 0;
    }
  }

  va_start(args,len);
  result = AslRequest(FileReq,(struct TagItem *)args);
  va_end(args);

  if (result)
  {
    strncpy(buffer,FileReq->fr_Drawer,len);
    AddPart(buffer,FileReq->fr_File,len);
    return 1;
  }
  return 0;
}

int amiga_getkey(void)
{
  static int nextKey = 0;
  if (nextKey != 0)
  {
    int key = nextKey;
    nextKey = 0;
    return key;
  }

  if (!UseScreen && ItalicUsed)
  {
    RefreshWindowFrame(Window);
    ItalicUsed = 0;
  }

  for (;;)
  {
    struct IntuiMessage* imsg;
    while (imsg = (struct IntuiMessage*)GetMsg(Window->UserPort))
    {
      ULONG msgClass = imsg->Class;
      ULONG msgCode = imsg->Code;
      UWORD msgQual = imsg->Qualifier;
      ReplyMsg((struct Message*)imsg);
      switch (msgClass)
      {
	    case IDCMP_CLOSEWINDOW:
        glk_exit();
	      break;
      case IDCMP_CHANGEWINDOW:
        COLS = (Window->Width-Window->BorderLeft-Window->BorderRight)/
          RPort->TxWidth;
        COLS = MIN(COLS,init_cols);
        LINES = (Window->Height-Window->BorderTop-Window->BorderBottom)/
          RPort->TxHeight;
        LINES = MIN(LINES,init_lines);
        SetAPen(RPort,0);
        RectFill(RPort,
          Window->BorderLeft,Window->BorderTop,
          Window->Width-Window->BorderRight-1,
          Window->Height-Window->BorderBottom-1);
        gli_sig_winsize(0);
        nextKey = KEY_END;
        return ERR;
    	case IDCMP_VANILLAKEY:
        if (msgCode == 127) /* Delete */
          return 4;
    	  return msgCode;
	    case IDCMP_RAWKEY:
	      switch (msgCode)
	      {
	      case 0x4C:
          if (msgQual & QUAL_CTRL) 
            return KEY_HOME;
          if (msgQual & QUAL_SHIFT) 
            return KEY_PPAGE;
          return KEY_UP;
	      case 0x4D:
          if (msgQual & QUAL_CTRL) 
            return KEY_END;
          if (msgQual & QUAL_SHIFT) 
            return KEY_NPAGE;
	        return KEY_DOWN;
	      case 0x4F:
	        return KEY_LEFT;
	      case 0x4E:
	        return KEY_RIGHT;
        }
	      break;
      case IDCMP_MENUPICK:
    	  if (msgCode != MENUNULL)
    	  {
	        if (MENUNUM(msgCode) == 0)
    	    {
	          switch (ITEMNUM(msgCode))
    	      {
		        case 0:
        		  amiga_about();
        		  break;
        		case 1:
              glk_exit();
        		  break;
    	      }
	        }
	      }
	      break;
      }
    }
    WaitPort(Window->UserPort);
  }
}

void initscr(void)
{
  if (Window != 0)
    return;

#ifndef __AROS__
  if (IntuitionBase->lib_Version < 37)
    exit(0);
#endif
	
  if (Icon == 0)
  {
    char progName[256];
    if (GetProgramName(progName,256))
      Icon = GetDiskObject(progName);
  }
  if (Icon != 0)
  {
    if (FindToolType(Icon->do_ToolTypes,"WINDOW"))
      UseScreen = 0;
  }

  if ((DefaultPubScreen = LockPubScreen(0)) == 0)
    exit(0);

  static struct TextAttr topaz8 = { "topaz.font",8,FS_NORMAL,0 };
  if (UseScreen)
  {
    WORD pens[] = { -1 };
    if ((Screen = OpenScreenTags(0,
      SA_Interleaved,1,
      SA_Pens,pens,
      SA_DisplayID,GetVPModeID(&DefaultPubScreen->ViewPort),
      SA_Overscan,OSCAN_TEXT,
      SA_Depth,2,
      SA_Type,CUSTOMSCREEN|AUTOSCROLL,
      SA_Title,TitleBar,
      SA_Font,&topaz8,
      TAG_DONE)) == 0)
      exit(0);
    UnlockPubScreen(0,DefaultPubScreen);
    DefaultPubScreen = 0;

    if ((Window = OpenWindowTags(0,
      WA_Left,0,
      WA_Top,2,
      WA_Width,Screen->Width,
      WA_Height,Screen->Height-2,
      WA_SmartRefresh,1,
      WA_NewLookMenus,1,
      WA_AutoAdjust,0,
      WA_Borderless,1,
      WA_Backdrop,1,
      WA_Activate,1,
      WA_Title,TitleBar,
      WA_ScreenTitle,TitleBar,
      WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_RAWKEY|IDCMP_MENUPICK,
      WA_CustomScreen,Screen,
      TAG_DONE)) == 0)
      exit(0);
  }
  else
  {
    if ((Window = OpenWindowTags(0,
      WA_Left,0,
      WA_Top,DefaultPubScreen->BarHeight+1,
      WA_Width,DefaultPubScreen->Width,
      WA_Height,DefaultPubScreen->Height-DefaultPubScreen->BarHeight-1,
      WA_SmartRefresh,1,
      WA_NewLookMenus,1,
      WA_AutoAdjust,1,
      WA_Activate,1,
      WA_CloseGadget,1,
      WA_DragBar,1,
      WA_DepthGadget,1,
      WA_SizeGadget,1,
      WA_SizeBBottom,1,
      WA_Title,TitleBar,
      WA_ScreenTitle,TitleBar,
      WA_IDCMP,IDCMP_VANILLAKEY|IDCMP_RAWKEY|IDCMP_MENUPICK|IDCMP_CLOSEWINDOW|IDCMP_CHANGEWINDOW,
      WA_PubScreen,DefaultPubScreen,
      TAG_DONE)) == 0)
      exit(0);
  }

  RPort = Window->RPort;
  SetDrMd(RPort,JAM2);

  ThisProcess = (struct Process*)FindTask(0);
  OldWindowPtr = ThisProcess->pr_WindowPtr;
  ThisProcess->pr_WindowPtr = Window;

  if ((Visual = GetVisualInfo(Window->WScreen,TAG_DONE)) == 0)
    exit(0);
  if ((Menus = CreateMenus(NewMenus,GTMN_NewLookMenus,TRUE,TAG_DONE)) == 0)
    exit(0);
  LayoutMenus(Menus,Visual,GTMN_NewLookMenus,TRUE,TAG_DONE);
  SetMenuStrip(Window,Menus);
  if (Screen)
    ScreenToFront(Screen);

  COLS = (Window->Width-Window->BorderLeft-Window->BorderRight)/
    RPort->TxWidth;
  LINES = (Window->Height-Window->BorderTop-Window->BorderBottom)/
    RPort->TxHeight;
  init_cols = COLS;
  init_lines = LINES;

  TextArray = malloc(COLS * LINES);
  TextAttrArray = malloc(COLS * LINES);
  TextDirty = calloc(LINES,1);
  clear();
  amiga_redraw();
}

void endwin(void)
{
}

void clear(void)
{
  int i;
  for (i = 0; i < COLS*LINES; i++)
  {
    TextArray[i] = ' ';
    TextAttrArray[i] = 0;
  }
  for (i = 0; i < LINES; i++)
    TextDirty[i] = 1;
}

void refresh(void)
{
}

void wrefresh(int s)
{
}

void cbreak(void)
{
}

void noecho(void)
{
}

void nonl(void)
{
}

int getch(void)
{
  amiga_redraw();
  amiga_cursor();
  WindowLimits(Window,
    Window->BorderLeft+Window->BorderRight+(RPort->TxWidth*8),
    Window->BorderTop+Window->BorderBottom+(RPort->TxHeight*2),
    ~0,~0);

  int key = amiga_getkey();
  WindowLimits(Window,
    Window->Width,Window->Height,Window->Width,Window->Height);
  amiga_cursor();
  return key;
}

void move(int y, int x)
{
  if ((x >= 0) && (x < COLS))
    TextX = x;
  if ((y >= 0) && (y < LINES))
    TextY = y;
}

void clrtoeol(void)
{
  int x;
  for (x = TextX; x < COLS; x++)
  {
    int i = (TextY*COLS)+x;
    TextArray[i] = ' ';
    TextAttrArray[i] = 0;
  }
  TextDirty[TextY] = 1;
}

void addch(char c)
{
  int i = (TextY*COLS)+TextX;
  TextArray[i] = c;
  TextAttrArray[i] = TextAttr;
  TextDirty[TextY] = 1;
  TextX++;
  if (TextX >= COLS)
    TextX = COLS-1;
}

void mvaddch(int y, int x, char c)
{
}

void addstr(char* s)
{
  while (*s != 0)
  {
    addch(*s);
    s++;
  }
}

int attron(int a)
{
  if ((TextAttr & a) != a)
    TextAttr |= a;
  return TextAttr;
}

int attrset(int a)
{
  if (TextAttr != a)
    TextAttr = a;
  return TextAttr;
}

void intrflush(int s, int b)
{
}

void keypad(int s, int b)
{
}

void scrollok(int s, int b)
{
}

void* newterm(char* t, FILE* out, FILE* in)
{
  return 0;
}

#ifndef __AROS__
__sigfunc signal(int s, __sigfunc sf)
{
}
#endif

int amiga_startup_code(char* path);

#ifdef __AROS__
int real_main(int argc, char* argv[])
#else
int main(int argc, char* argv[])
#endif
{
  if (argc < 2)
    return 0;

#if defined __AROS__
  atexit(amiga_close);
#endif
	
  gli_setup_curses();
  gli_initialize_misc();
  gli_initialize_windows();
  gli_initialize_events();

  if (!amiga_startup_code(argv[1]))
    glk_exit();

  glk_main();
  glk_exit();
  return 0;
}

int wbmain(struct WBStartup *wbstart)
{
  char dir[256], path[256];
  strcpy(dir,"");
  if (Icon = GetDiskObject(wbstart->sm_ArgList[0].wa_Name))
  {
    char* tooltype;
    if (tooltype = FindToolType(Icon->do_ToolTypes,"DIR"))
      strcpy(dir,tooltype);
  }

  if (amiga_filereq(path,256,
    ASLFR_TitleText,InitReqTitle,
    ASLFR_InitialPattern,InitReqPattern,
    ASLFR_DoPatterns,1,
    ASLFR_InitialDrawer,dir,TAG_DONE))
  {
#ifndef __AROS__
	if (StartLock = Lock(FileReq->fr_Drawer,ACCESS_READ))
      OldLock = CurrentDir(StartLock);
#endif
    FreeAslRequest(FileReq);
    FileReq = 0;

    char* args[2];
    args[0] = "GlkApp";
    args[1] = path;
#if defined __AROS__
	return real_main(2,args);
#else
    return main(2,args);
#endif	
  }
  return 0;
}

#ifdef __AROS__
int main(int argc, char* argv[])
{   
	if (!argc)
		wbmain((struct WBStartup *) argv);
	else
		real_main(argc,argv);
}
#endif

struct InternalTime
{
  BIGNUM* secs;
  unsigned long micros;
};

void amiga_internal_init(struct InternalTime* t)
{
  t->secs = BN_new();
}

void amiga_internal_clear(struct InternalTime* t)
{
  BN_free(t->secs);
}

int amiga_tz_offset(void)
{
  static int tz_offset = -1;

  if (tz_offset == -1)
  {
    tz_offset = 0;

    if (LocaleBase == NULL)
#ifdef __AROS__
      LocaleBase = (struct LocaleBase *) OpenLibrary("locale.library",38);
#else
      LocaleBase = OpenLibrary("locale.library",38);
#endif
    if (LocaleBase != NULL)
    {
      struct Locale* locale = OpenLocale(NULL);
      if (locale != NULL)
      {
        tz_offset = locale->loc_GMTOffset;
        CloseLocale(locale);
      }
    }
  }

  return tz_offset * 60;
}

void amiga_time_now(struct InternalTime* t)
{
  ULONG s,ms;
  CurrentTime(&s,&ms);

  BN_set_word(t->secs,s);
  t->micros = ms;

  // Convert to seconds since the start of 1970
  BN_add_word(t->secs,252460800);

  // Convert to UTC
  int tz_offset = amiga_tz_offset();
  if (tz_offset >= 0)
    BN_add_word(t->secs,tz_offset);
  else
    BN_sub_word(t->secs,-1 * tz_offset);
}

void amiga_to_local(struct InternalTime* t)
{
  int tz_offset = amiga_tz_offset();
  if (tz_offset >= 0)
    BN_sub_word(t->secs,tz_offset);
  else
    BN_add_word(t->secs,-1 * tz_offset);
}

void amiga_negate_64(unsigned long* hi, unsigned long* lo)
{
  // Take the twos complement
  *hi = ~(*hi);
  *lo = ~(*lo);
  (*lo)++;
  if (*lo == 0)
    (*hi)++;
}

void amiga_to_glktime(const struct InternalTime* t, glktimeval_t *time)
{
  int binLen = BN_num_bytes(t->secs);
  if (binLen <= 8)
  {
    unsigned long binNum[2] = {0};
    BN_bn2bin(t->secs,(char*)binNum+(8-binLen));
    if (BN_is_negative(t->secs))
      amiga_negate_64(binNum,binNum+1);

    time->high_sec = (glsi32)binNum[0];
    time->low_sec = (glui32)binNum[1];
    time->microsec = t->micros;
  }
  else
  {
    time->high_sec = 0;
    time->low_sec = 0;
    time->microsec = 0;
  }
}

void amiga_from_glktime(struct InternalTime* t, const glktimeval_t *time)
{
  unsigned long hi = (unsigned long)time->high_sec;
  unsigned long lo = (unsigned long)time->low_sec;
  if (time->high_sec < 0)
    amiga_negate_64(&hi,&lo);

  char binNum[8] = {0};
  *((glsi32*)binNum) = hi;
  *((glui32*)(binNum+4)) = lo;
  BN_bin2bn(binNum,8,t->secs);
  BN_set_negative(t->secs,(time->high_sec < 0) ? 1 : 0);
  t->micros = time->microsec;
}

glsi32 amiga_to_simpletime(const struct InternalTime* t, glui32 factor)
{
  BIGNUM* secs = BN_dup(t->secs);
  glsi32 st = 0;

  if (BN_is_negative(secs))
  {
    BN_set_negative(secs,0);
    BN_sub_word(secs,1);
    BN_div_word(secs,factor);
    BN_add_word(secs,1);
    st = BN_get_word(secs);
    if (!BN_is_negative(secs))
      st *= -1; // Negate
  }
  else
  {
    BN_div_word(secs,factor);
    st = BN_get_word(secs);
  }

  BN_free(secs);
  return st;
}

void amiga_from_simpletime(struct InternalTime* t, glsi32 time, glui32 factor)
{
  BN_set_word(t->secs,abs(time));
  BN_set_negative(t->secs,(time < 0) ? 1 : 0);
  BN_mul_word(t->secs,factor);
  t->micros = 0;
}

#define LEAPYEAR(year) (!((year) % 4) && (((year) % 100) || !((year) % 400)))
#define YEARSIZE(year) (LEAPYEAR(year) ? 366 : 365)

static const int _ytab[2][12] =
{
  { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 },
  { 31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }
};

void amiga_to_glkdate(const struct InternalTime* t, glkdate_t* date)
{
  BIGNUM* secs = BN_dup(t->secs);
  long dayclock = BN_div_word(secs,24*60*60);
  long dayno = BN_get_word(secs);
  if (BN_is_negative(secs))
  {
    dayno *= -1;
    dayno -= 1;
    dayclock = (24*60*60) - dayclock;
  }
  BN_free(secs);

  date->microsec = t->micros;
  date->second = dayclock % 60;
  date->minute = (dayclock % 3600) / 60;
  date->hour = dayclock / 3600;

  date->weekday = (dayno + 4) % 7;
  if (date->weekday < 0)
    date->weekday += 7;

  int year = 1970;
  while (dayno < 0)
  {
    dayno += YEARSIZE(year);
    year--;
  }
  while (dayno >= YEARSIZE(year))
  {
    dayno -= YEARSIZE(year);
    year++;
  }
  date->year = year;

  date->month = 1;
  while (dayno >= _ytab[LEAPYEAR(year)][date->month-1])
  {
    dayno -= _ytab[LEAPYEAR(year)][date->month-1];
    date->month++;
  }
  date->day = dayno + 1;
}

void amiga_from_glkdate(struct InternalTime* t, const glkdate_t* date)
{
  glkdate_t d = *date;
  d.month--;

  d.second += d.microsec / 1000000;
  d.microsec %= 1000000;
  if (d.microsec < 0)
  {
    d.microsec += 1000000;
    d.second--;
  }
  d.minute += d.second / 60;
  d.second %= 60;
  if (d.second < 0)
  {
    d.second += 60;
    d.minute--;
  }
  d.hour += d.minute / 60;
  d.minute %= 60;
  if (d.minute < 0)
  {
    d.minute += 60;
    d.hour--;
  }
  long day = d.hour / 24;
  d.hour %= 24;
  if (d.hour < 0)
  {
    d.hour += 24;
    day--;
  }
  d.year += d.month / 12;
  d.month %= 12;
  if (d.month < 0)
  {
    d.month += 12;
    d.year--;
  }
  day += (d.day - 1);
  while (day < 0)
  {
    if (--d.month < 0)
    {
      d.year--;
      d.month = 11;
    }
    day += _ytab[LEAPYEAR(1900 + d.year)][d.month];
  }
  while (day >= _ytab[LEAPYEAR(1900 + d.year)][d.month])
  {
    day -= _ytab[LEAPYEAR(1900 + d.year)][d.month];
    if (++(d.month) == 12)
    {
      d.month = 0;
      d.year++;
    }
  }
  d.day = day + 1;

  day = 0;
  int year = d.year;
  while (year > 1970)
  {
    year--;
    day += YEARSIZE(year);
  }
  while (year < 1970)
  {
    day -= YEARSIZE(year);
    year++;
  }

  int yday = 0;
  int month = 0;
  while (month < d.month)
  {
    yday += _ytab[LEAPYEAR(d.year)][month];
    month++;
  }
  yday += (d.day - 1);
  day += yday;

  BN_set_word(t->secs,abs(day));
  BN_set_negative(t->secs,(day < 0) ? 1 : 0);
  BN_mul_word(t->secs,24);
  BN_add_word(t->secs,d.hour);
  BN_mul_word(t->secs,60);
  BN_add_word(t->secs,d.minute);
  BN_mul_word(t->secs,60);
  BN_add_word(t->secs,d.second);
  t->micros = d.microsec;
}

void glk_current_time(glktimeval_t *time)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_time_now(&t);
  amiga_to_glktime(&t,time);
  amiga_internal_clear(&t);
}

glsi32 glk_current_simple_time(glui32 factor)
{
  if (factor == 0)
    return 0;
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_time_now(&t);
  glsi32 st = amiga_to_simpletime(&t,factor);
  amiga_internal_clear(&t);
  return st;
}

void glk_time_to_date_utc(glktimeval_t *time, glkdate_t *date)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_glktime(&t,time);
  amiga_to_glkdate(&t,date);
  amiga_internal_clear(&t);
}

void glk_time_to_date_local(glktimeval_t *time, glkdate_t *date)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_glktime(&t,time);
  amiga_to_local(&t);
  amiga_to_glkdate(&t,date);
  amiga_internal_clear(&t);
}

void glk_simple_time_to_date_utc(glsi32 time, glui32 factor, glkdate_t *date)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_simpletime(&t,time,factor);
  amiga_to_glkdate(&t,date);
  amiga_internal_clear(&t);
}

void glk_simple_time_to_date_local(glsi32 time, glui32 factor, glkdate_t *date)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_simpletime(&t,time,factor);
  amiga_to_local(&t);
  amiga_to_glkdate(&t,date);
  amiga_internal_clear(&t);
}

void glk_date_to_time_utc(glkdate_t *date, glktimeval_t *time)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_glkdate(&t,date);
  amiga_to_glktime(&t,time);
  amiga_internal_clear(&t);
}

void glk_date_to_time_local(glkdate_t *date, glktimeval_t *time)
{
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_glkdate(&t,date);
  amiga_to_local(&t);
  amiga_to_glktime(&t,time);
  amiga_internal_clear(&t);
}

glsi32 glk_date_to_simple_time_utc(glkdate_t *date, glui32 factor)
{
  if (factor == 0)
    return 0;
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_glkdate(&t,date);
  glsi32 st = amiga_to_simpletime(&t,factor);
  amiga_internal_clear(&t);
  return st;
}

glsi32 glk_date_to_simple_time_local(glkdate_t *date, glui32 factor)
{
  if (factor == 0)
    return 0;
  struct InternalTime t;
  amiga_internal_init(&t);
  amiga_from_glkdate(&t,date);
  amiga_to_local(&t);
  glsi32 st = amiga_to_simpletime(&t,factor);
  amiga_internal_clear(&t);
  return st;
}
