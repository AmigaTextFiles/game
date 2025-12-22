/*
 * xboard.c -- X front end for XBoard
 * $Id: xboard.c,v 1.48 1995/07/28 05:23:42 mann Exp $
 *
 * Copyright 1991 by Digital Equipment Corporation, Maynard, Massachusetts.
 * Enhancements Copyright 1992-95 Free Software Foundation, Inc.
 *
 * The following terms apply to Digital Equipment Corporation's copyright
 * interest in XBoard:
 * ------------------------------------------------------------------------
 * All Rights Reserved
 *
 * Permission to use, copy, modify, and distribute this software and its
 * documentation for any purpose and without fee is hereby granted,
 * provided that the above copyright notice appear in all copies and that
 * both that copyright notice and this permission notice appear in
 * supporting documentation, and that the name of Digital not be
 * used in advertising or publicity pertaining to distribution of the
 * software without specific, written prior permission.
 *
 * DIGITAL DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
 * ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
 * DIGITAL BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
 * ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
 * WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
 * ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
 * SOFTWARE.
 * ------------------------------------------------------------------------
 *
 * The following terms apply to the enhanced version of XBoard distributed
 * by the Free Software Foundation:
 * ------------------------------------------------------------------------
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 * ------------------------------------------------------------------------
 *
 * See the file ChangeLog for a revision history.
 */

#include <config.h>

#include <stdio.h>
#include <ctype.h>
#include <signal.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pwd.h>

#if !OMIT_SOCKETS
# if HAVE_SYS_SOCKET_H
#  include <sys/socket.h>
#  include <netinet/in.h>
#  include <netdb.h>
# else /* not HAVE_SYS_SOCKET_H */
#  if HAVE_LAN_SOCKET_H
#   include <lan/socket.h>
#   include <lan/in.h>
#   include <lan/netdb.h>
#  else /* not HAVE_LAN_SOCKET_H */
#   define OMIT_SOCKETS 1
#  endif /* not HAVE_LAN_SOCKET_H */
# endif /* not HAVE_SYS_SOCKET_H */
#endif /* !OMIT_SOCKETS */

#if STDC_HEADERS
# include <stdlib.h>
# include <string.h>
#else /* not STDC_HEADERS */
extern char *getenv();
# if HAVE_STRING_H
#  include <string.h>
# else /* not HAVE_STRING_H */
#  include <strings.h>
# endif /* not HAVE_STRING_H */
#endif /* not STDC_HEADERS */

#if HAVE_SYS_FCNTL_H
# include <sys/fcntl.h>
#else /* not HAVE_SYS_FCNTL_H */
# if HAVE_FCNTL_H
#  include <fcntl.h>
# endif /* HAVE_FCNTL_H */
#endif /* not HAVE_SYS_FCNTL_H */

#if HAVE_SYS_SYSTEMINFO_H
# include <sys/systeminfo.h>
#endif /* HAVE_SYS_SYSTEMINFO_H */

#if HAVE_UNISTD_H
# include <unistd.h>
#endif

#if HAVE_SYS_WAIT_H
# include <sys/wait.h>
#endif

#include <X11/Intrinsic.h>
#include <X11/StringDefs.h>
#include <X11/Shell.h>
#include <X11/Xaw/Dialog.h>
#include <X11/Xaw/Form.h>
#include <X11/Xaw/List.h>
#include <X11/Xaw/Label.h>
#include <X11/Xaw/SimpleMenu.h>
#include <X11/Xaw/SmeBSB.h>
#include <X11/Xaw/SmeLine.h>
#include <X11/Xaw/Box.h>
#include <X11/Xaw/MenuButton.h>
#include <X11/cursorfont.h>
#include <X11/Xaw/Text.h>
#include <X11/Xaw/AsciiText.h>

#include "common.h"
#include "frontend.h"
#include "backend.h"
#include "moves.h"
#include "xboard.h"
#include "childio.h"
#include "bitmaps.h"
#include "xgamelist.h"
#include "xedittags.h"

typedef struct {
    String string;
    XtActionProc proc;
} MenuItem;

typedef struct {
    String name;
    MenuItem *mi;
} Menu;

void main P((int argc, char **argv));
RETSIGTYPE CmailSigHandler P((int sig));
RETSIGTYPE IntSigHandler P((int sig));
void CreateGCs P((void));
void CreatePieces P((void));
void CreatePieceMenus P((void));
Widget CreateMenuBar P((Menu *mb));
Widget CreateButtonBar P ((MenuItem *mi));
char *FindFont P((char *pattern, int targetPxlSize));
void PieceMenuPopup P((Widget w, XEvent *event,
		       String *params, Cardinal *num_params));
static void PieceMenuSelect P((Widget w, ChessSquare piece, caddr_t junk));
void ReadBitmap P((Pixmap *pm, String name, unsigned char bits[],
		   u_int wreq, u_int hreq));
void CreateGrid P((void));
int EventToSquare P((int x));
void DrawSquare P((int row, int column, ChessSquare piece));
void EventProc P((Widget widget, caddr_t unused, XEvent *event));
void HandleUserMove P((Widget w, XEvent *event,
		     String *prms, Cardinal *nprms));
void WhiteClock P((Widget w, XEvent *event,
		   String *prms, Cardinal *nprms));
void BlackClock P((Widget w, XEvent *event,
		   String *prms, Cardinal *nprms));
void DrawPositionProc P((Widget w, XEvent *event,
		     String *prms, Cardinal *nprms));
void XDrawPosition P((Widget w, /*Boolean*/int repaint, 
		     Board board));
void CommentPopUp P((char *title, char *label));
void CommentPopDown P((void));
void CommentCallback P((Widget w, XtPointer client_data,
			XtPointer call_data));
void FileNamePopUp P((char *label, char *def,
		      FileProc proc, char *openMode));
void FileNameCallback P((Widget w, XtPointer client_data,
			 XtPointer call_data));
void FileNameAction P((Widget w, XEvent *event,
		       String *prms, Cardinal *nprms));
void PromotionPopUp P((void));
void PromotionCallback P((Widget w, XtPointer client_data,
			  XtPointer call_data));
void EditCommentPopDown P((void));
void EditCommentCallback P((Widget w, XtPointer client_data,
			    XtPointer call_data));
void SelectCommand P((Widget w, XtPointer client_data, XtPointer call_data));
void ResetProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void LoadGameProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void LoadNextGameProc P((Widget w, XEvent *event, String *prms,
			 Cardinal *nprms));
void LoadPrevGameProc P((Widget w, XEvent *event, String *prms,
			 Cardinal *nprms));
void ReloadGameProc P((Widget w, XEvent *event, String *prms,
		       Cardinal *nprms));
void LoadPositionProc P((Widget w, XEvent *event,
			 String *prms, Cardinal *nprms));
void SaveGameProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void SavePositionProc P((Widget w, XEvent *event,
			 String *prms, Cardinal *nprms));
void MailMoveProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void ReloadCmailMsgProc P((Widget w, XEvent *event, String *prms,
			    Cardinal *nprms));
void QuitProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void PauseProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void MachineBlackProc P((Widget w, XEvent *event, String *prms,
			 Cardinal *nprms));
void MachineWhiteProc P((Widget w, XEvent *event,
			 String *prms, Cardinal *nprms));
void TwoMachinesProc P((Widget w, XEvent *event, String *prms,
			Cardinal *nprms));
void IcsClientProc P((Widget w, XEvent *event, String *prms,
		      Cardinal *nprms));
void EditGameProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void EditPositionProc P((Widget w, XEvent *event,
			 String *prms, Cardinal *nprms));
void EditCommentProc P((Widget w, XEvent *event,
			String *prms, Cardinal *nprms));
void AcceptProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void DeclineProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void CallFlagProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void DrawProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void AbortProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void AdjournProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void ResignProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void StopObservingProc P((Widget w, XEvent *event, String *prms,
			  Cardinal *nprms));
void StopExaminingProc P((Widget w, XEvent *event, String *prms,
			  Cardinal *nprms));
void BackwardProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void ForwardProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void ToStartProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void ToEndProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void RevertProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void TruncateGameProc P((Widget w, XEvent *event, String *prms,
			 Cardinal *nprms));
void RetractMoveProc P((Widget w, XEvent *event, String *prms,
			Cardinal *nprms));
void MoveNowProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void AlwaysQueenProc P((Widget w, XEvent *event, String *prms,
			Cardinal *nprms));
void AutocommProc P((Widget w, XEvent *event, String *prms,
		     Cardinal *nprms));
void AutoflagProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void AutobsProc P((Widget w, XEvent *event, String *prms,
			Cardinal *nprms));
void AutosaveProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void BellProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void FlipViewProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void OldSaveStyleProc P((Widget w, XEvent *event, String *prms,
			 Cardinal *nprms));
void QuietPlayProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void ShowCoordsProc P((Widget w, XEvent *event, String *prms,
		       Cardinal *nprms));
void ShowThinkingProc P((Widget w, XEvent *event, String *prms,
			 Cardinal *nprms));
void HintProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void BookProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void AboutGameProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void AboutProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void NothingProc P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void Iconify P((Widget w, XEvent *event, String *prms, Cardinal *nprms));
void DisplayMove P((int moveNumber));
void DisplayTitle P((char *title));
void Usage P((void));
void ICSInitScript P((void));
int LoadGamePopUp P((FILE *f, int gameNumber, char *title));
void ErrorPopDown P((void));

/*
* XBoard depends on Xt R4 or higher
*/
int xtVersion = XtSpecificationRelease;

int xScreen;
Display *xDisplay;
Window xBoardWindow;
Pixel lightSquareColor, darkSquareColor, whitePieceColor, blackPieceColor;
GC lightSquareGC, darkSquareGC, lineGC, wdPieceGC, wlPieceGC,
  bdPieceGC, blPieceGC, wbPieceGC, bwPieceGC, coordGC;
Pixmap solidPawnBitmap, solidRookBitmap, solidKnightBitmap,
  solidBishopBitmap, solidQueenBitmap, solidKingBitmap,
  outlinePawnBitmap, outlineRookBitmap, outlineKnightBitmap,
  outlineBishopBitmap, outlineQueenBitmap, outlineKingBitmap,
  iconPixmap, wIconPixmap, bIconPixmap, xMarkPixmap;
Widget shellWidget, formWidget, boardWidget, messageWidget, titleWidget,
  whiteTimerWidget, blackTimerWidget, titleWidget, widgetList[16], 
  commentShell, promotionShell, whitePieceMenu, blackPieceMenu,
  menuBarWidget, buttonBarWidget, editShell, errorShell;
XSegment gridSegments[(BOARD_SIZE + 1) * 2];
Font clockFontID, coordFontID;
XFontStruct *clockFontStruct, *coordFontStruct;
XtAppContext appContext;

FileProc fileProc;
char *fileOpenMode;

Position commentX = -1, commentY = -1;
Dimension commentW, commentH;
static BoardSize boardSize = Large;

int squareSize = LARGE_SQUARE_SIZE, fromX = -1,
  fromY = -1, toX, toY, commentUp = False, filenameUp = False,
  promotionUp = False, pmFromX = -1, pmFromY = -1, editUp = False,
  errorUp = False, errorExitStatus = -1, lineGap;
Pixel timerForegroundPixel, timerBackgroundPixel;
Pixel buttonForegroundPixel, buttonBackgroundPixel;
char *chessDir, *programName;

MenuItem fileMenu[] = {
    {"Reset Game", ResetProc},
    {"----", NothingProc},
    {"Load Game", LoadGameProc},
    {"Load Next Game", LoadNextGameProc},
    {"Load Previous Game", LoadPrevGameProc},
    {"Reload Same Game", ReloadGameProc},
    {"Load Position", LoadPositionProc},
    {"----", NothingProc},
    {"Save Game", SaveGameProc},
    {"Save Position", SavePositionProc},
    {"----", NothingProc},
    {"Mail Move", MailMoveProc},
    {"Reload CMail Message", ReloadCmailMsgProc},
    {"----", NothingProc},
    {"Exit", QuitProc},
    {NULL, NULL}
};

MenuItem modeMenu[] = {
    {"Machine White", MachineWhiteProc},
    {"Machine Black", MachineBlackProc},
    {"Two Machines", TwoMachinesProc},
    {"ICS Client", IcsClientProc},
    {"Edit Game", EditGameProc},
    {"Edit Position", EditPositionProc},
    {"----", NothingProc},
    {"Show Game List", ShowGameListProc},
    {"Edit Tags", EditTagsProc},
    {"Edit Comment", EditCommentProc},
    {"Pause", PauseProc},
    {NULL, NULL}
};

MenuItem actionMenu[] = {
    {"Accept", AcceptProc},
    {"Decline", DeclineProc},
    {"----", NothingProc},    
    {"Call Flag", CallFlagProc},
    {"Draw", DrawProc},
    {"Adjourn", AdjournProc},
    {"Abort", AbortProc},
    {"Resign", ResignProc},
    {"----", NothingProc},    
    {"Stop Observing", StopObservingProc},
    {"Stop Examining", StopExaminingProc},
    {NULL, NULL}
};

MenuItem stepMenu[] = {
    {"Backward", BackwardProc},
    {"Forward", ForwardProc},
    {"Back to Start", ToStartProc},
    {"Forward to End", ToEndProc},
    {"Revert", RevertProc},
    {"Truncate Game", TruncateGameProc},
    {"----", NothingProc},    
    {"Move Now", MoveNowProc},
    {"Retract Move", RetractMoveProc},
    {NULL, NULL}
};    

MenuItem optionsMenu[] = {
    {"Always Queen", AlwaysQueenProc},
    {"Auto Comment", AutocommProc},
    {"Auto Flag", AutoflagProc},
    {"Auto Observe", AutobsProc},
    {"Auto Save", AutosaveProc},
    {"Bell", BellProc},
    {"Flip View", FlipViewProc},
    {"Old Save Style", OldSaveStyleProc},
    {"Quiet Play", QuietPlayProc},
    {"Show Coords", ShowCoordsProc},
    {"Show Thinking", ShowThinkingProc},
    {NULL, NULL}
};

MenuItem helpMenu[] = {
    {"Hint", HintProc},
    {"Book", BookProc},
    {"----", NothingProc},
    {"About XBoard", AboutProc},
    {NULL, NULL}
};

Menu menuBar[] = {
    {"File", fileMenu},
    {"Mode", modeMenu},
    {"Action", actionMenu},
    {"Step", stepMenu},
    {"Options", optionsMenu},
    {"Help", helpMenu},
    {NULL, NULL}
};

#define PAUSE_BUTTON "P"
MenuItem buttonBar[] = {
    {"<<", ToStartProc},
    {"<", BackwardProc},
    {PAUSE_BUTTON, PauseProc},
    {">", ForwardProc},
    {">>", ToEndProc},
    {NULL, NULL}
};

#define PIECE_MENU_SIZE 10
String pieceMenuStrings[PIECE_MENU_SIZE] = {
    "----", "Pawn", "Knight", "Bishop", "Rook", "Queen", "King",
    "----", "Empty square", "Clear board"
  };
/* must be in same order as PieceMenuStrings! */
ChessSquare pieceMenuTranslation[2][PIECE_MENU_SIZE] = {
    { (ChessSquare) 0, WhitePawn, WhiteKnight, WhiteBishop,
	WhiteRook, WhiteQueen, WhiteKing,
	(ChessSquare) 0, EmptySquare, ClearBoard },
    { (ChessSquare) 0, BlackPawn, BlackKnight, BlackBishop,
	BlackRook, BlackQueen, BlackKing,
	(ChessSquare) 0, EmptySquare, ClearBoard },
};

Arg shellArgs[] = {
    { XtNwidth, 0 },
    { XtNheight, 0 },
    { XtNminWidth, 0 },
    { XtNminHeight, 0 },
    { XtNmaxWidth, 0 },
    { XtNmaxHeight, 0 }
};

Arg boardArgs[] = {
    { XtNborderWidth, 0 },
    { XtNwidth, 0 },
    { XtNheight, 0 }
};

Arg titleArgs[] = {
    { XtNjustify, (XtArgVal) XtJustifyRight },
    { XtNlabel, (XtArgVal) "starting..." },
    { XtNresizable, (XtArgVal) True },
    { XtNresize, (XtArgVal) False }
};

Arg messageArgs[] = {
    { XtNjustify, (XtArgVal) XtJustifyLeft },
    { XtNlabel, (XtArgVal) "starting..." },
    { XtNresizable, (XtArgVal) True },
    { XtNresize, (XtArgVal) False }
};

Arg timerArgs[] = {
    { XtNborderWidth, 0 },
    { XtNjustify, (XtArgVal) XtJustifyLeft }
};

XtResource clientResources[] = {
    { "whitePieceColor", "whitePieceColor", XtRString, sizeof(String),
	XtOffset(AppDataPtr, whitePieceColor), XtRString,
	WHITE_PIECE_COLOR },
    { "blackPieceColor", "blackPieceColor", XtRString, sizeof(String),
	XtOffset(AppDataPtr, blackPieceColor), XtRString,
	BLACK_PIECE_COLOR },
    { "lightSquareColor", "lightSquareColor", XtRString,
	sizeof(String), XtOffset(AppDataPtr, lightSquareColor),
	XtRString, LIGHT_SQUARE_COLOR }, 
    { "darkSquareColor", "darkSquareColor", XtRString, sizeof(String),
	XtOffset(AppDataPtr, darkSquareColor), XtRString,
	DARK_SQUARE_COLOR },
    { "movesPerSession", "movesPerSession", XtRInt, sizeof(int),
	XtOffset(AppDataPtr, movesPerSession), XtRImmediate,
	(XtPointer) MOVES_PER_SESSION },
    { "initString", "initString", XtRString, sizeof(String),
	XtOffset(AppDataPtr, initString), XtRString, INIT_STRING },
    { "whiteString", "whiteString", XtRString, sizeof(String),
	XtOffset(AppDataPtr, whiteString), XtRString, WHITE_STRING },
    { "blackString", "blackString", XtRString, sizeof(String),
	XtOffset(AppDataPtr, blackString), XtRString, BLACK_STRING },
    { "firstChessProgram", "firstChessProgram", XtRString,
	sizeof(String), XtOffset(AppDataPtr, firstChessProgram),
	XtRString, FIRST_CHESS_PROGRAM },
    { "secondChessProgram", "secondChessProgram", XtRString,
	sizeof(String), XtOffset(AppDataPtr, secondChessProgram),
	XtRString, SECOND_CHESS_PROGRAM },
    { "noChessProgram", "noChessProgram", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, noChessProgram),
	XtRImmediate, (XtPointer) False },
    { "firstHost", "firstHost", XtRString, sizeof(String),
	XtOffset(AppDataPtr, firstHost), XtRString, FIRST_HOST },
    { "secondHost", "secondHost", XtRString, sizeof(String),
	XtOffset(AppDataPtr, secondHost), XtRString, SECOND_HOST },
    { "bitmapDirectory", "bitmapDirectory", XtRString,
	sizeof(String), XtOffset(AppDataPtr, bitmapDirectory),
	XtRString, "" },
    { "remoteShell", "remoteShell", XtRString, sizeof(String),
	XtOffset(AppDataPtr, remoteShell), XtRString, REMOTE_SHELL },
    { "remoteUser", "remoteUser", XtRString, sizeof(String),
	XtOffset(AppDataPtr, remoteUser), XtRString, "" },
    { "timeDelay", "timeDelay", XtRFloat, sizeof(float),
	XtOffset(AppDataPtr, timeDelay), XtRString,
	(XtPointer) TIME_DELAY_QUOTE },
    { "timeControl", "timeControl", XtRString, sizeof(String),
	XtOffset(AppDataPtr, timeControl), XtRString,
	(XtPointer) TIME_CONTROL },
    { "internetChessServerMode", "internetChessServerMode",
	XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, icsActive), XtRImmediate,
	(XtPointer) False },
    { "internetChessServerHost", "internetChessServerHost",
	XtRString, sizeof(String),
	XtOffset(AppDataPtr, icsHost),
	XtRString, (XtPointer) ICS_HOST },
    { "internetChessServerPort", "internetChessServerPort",
	XtRString, sizeof(String),
	XtOffset(AppDataPtr, icsPort), XtRString,
	(XtPointer) ICS_PORT },
    { "internetChessServerCommPort", "internetChessServerCommPort",
	XtRString, sizeof(String),
	XtOffset(AppDataPtr, icsCommPort), XtRString,
	ICS_COMM_PORT },
    { "internetChessServerLogonScript", "internetChessServerLogonScript",
	XtRString, sizeof(String),
	XtOffset(AppDataPtr, icsLogon), XtRString,
	ICS_LOGON },
    { "useTelnet", "useTelnet", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, useTelnet), XtRImmediate,
	(XtPointer) False },
    { "telnetProgram", "telnetProgram", XtRString, sizeof(String),
	XtOffset(AppDataPtr, telnetProgram), XtRString, TELNET_PROGRAM },
    { "gateway", "gateway", XtRString, sizeof(String),
	XtOffset(AppDataPtr, gateway), XtRString, "" },
    { "loadGameFile", "loadGameFile", XtRString, sizeof(String),
	XtOffset(AppDataPtr, loadGameFile), XtRString, "" },
    { "loadGameIndex", "loadGameIndex",
	XtRInt, sizeof(int),
	XtOffset(AppDataPtr, loadGameIndex), XtRImmediate,
	(XtPointer) 0 },
    { "saveGameFile", "saveGameFile", XtRString, sizeof(String),
	XtOffset(AppDataPtr, saveGameFile), XtRString, "" },
    { "autoSaveGames", "autoSaveGames", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, autoSaveGames),
	XtRImmediate, (XtPointer) False },
    { "loadPositionFile", "loadPositionFile", XtRString,
	sizeof(String), XtOffset(AppDataPtr, loadPositionFile),
	XtRString, "" },
    { "loadPositionIndex", "loadPositionIndex",
	XtRInt, sizeof(int),
	XtOffset(AppDataPtr, loadPositionIndex), XtRImmediate,
	(XtPointer) 1 },
    { "savePositionFile", "savePositionFile", XtRString,
	sizeof(String), XtOffset(AppDataPtr, savePositionFile),
	XtRString, "" },
    { "matchMode", "matchMode", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, matchMode), XtRImmediate, (XtPointer) False },
    { "monoMode", "monoMode", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, monoMode), XtRImmediate,
	(XtPointer) False },
    { "debugMode", "debugMode", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, debugMode), XtRImmediate,
	(XtPointer) False },
    { "clockMode", "clockMode", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, clockMode), XtRImmediate,
	(XtPointer) True },
    { "boardSize", "boardSize", XtRString, sizeof(String),
	XtOffset(AppDataPtr, boardSize), XtRString, "" },
    { "searchTime", "searchTime", XtRString, sizeof(String),
	XtOffset(AppDataPtr, searchTime), XtRString,
	(XtPointer) "" },
    { "searchDepth", "searchDepth", XtRInt, sizeof(int),
	XtOffset(AppDataPtr, searchDepth), XtRImmediate, 
	(XtPointer) 0 },
    { "showCoords", "showCoords", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, showCoords), XtRImmediate,
	(XtPointer) False },
    { "showThinking", "showThinking", XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, showThinking), XtRImmediate,
	(XtPointer) False },
    { "clockFont", "clockFont", XtRString, sizeof(String),
	XtOffset(AppDataPtr, clockFont), XtRString, CLOCK_FONT },
    { "coordFont", "coordFont", XtRString, sizeof(String),
	XtOffset(AppDataPtr, coordFont), XtRString, COORD_FONT },
    { "ringBellAfterMoves", "ringBellAfterMoves",
	XtRBoolean, sizeof(Boolean),
	XtOffset(AppDataPtr, ringBellAfterMoves),
	XtRImmediate, (XtPointer) False	},
    { "autoCallFlag", "autoCallFlag", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, autoCallFlag),
	XtRImmediate, (XtPointer) False },
    { "autoObserve", "autoObserve", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, autoObserve),
	XtRImmediate, (XtPointer) False },
    { "autoComment", "autoComment", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, autoComment),
	XtRImmediate, (XtPointer) False },
    { "flipView", "flipView", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, flipView),
	XtRImmediate, (XtPointer) False },
    { "cmail", "cmailGameName", XtRString, sizeof(String),
	XtOffset(AppDataPtr, cmailGameName), XtRString, "" },
    { "alwaysPromoteToQueen", "alwaysPromoteToQueen", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, alwaysPromoteToQueen),
	XtRImmediate, (XtPointer) False },
    { "oldSaveStyle", "oldSaveStyle", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, oldSaveStyle),
	XtRImmediate, (XtPointer) False },
    { "quietPlay", "quietPlay", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, quietPlay),
	XtRImmediate, (XtPointer) False },
    { "borderXoffset", "borderXoffset", XtRInt, sizeof(int),
	XtOffset(AppDataPtr, borderXoffset), XtRImmediate,
	(XtPointer) BORDER_X_OFFSET },
    { "borderYoffset", "borderYOffset", XtRInt, sizeof(int),
	XtOffset(AppDataPtr, borderYoffset), XtRImmediate,
	(XtPointer) BORDER_Y_OFFSET },
    { "titleInWindow", "titleInWindow", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, titleInWindow),
	XtRImmediate, (XtPointer) False },
#ifdef ZIPPY
    { "zippyTalk", "zippyTalk", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, zippyTalk),
	XtRImmediate, (XtPointer) False },
    { "zippyPlay", "zippyPlay", XtRBoolean,
	sizeof(Boolean), XtOffset(AppDataPtr, zippyPlay),
	XtRImmediate, (XtPointer) False },
#endif
};

Pixmap *pieceToSolid[] = {
    &solidPawnBitmap, &solidRookBitmap, &solidKnightBitmap,
    &solidBishopBitmap, &solidQueenBitmap, &solidKingBitmap,
    &solidPawnBitmap, &solidRookBitmap, &solidKnightBitmap,
    &solidBishopBitmap, &solidQueenBitmap, &solidKingBitmap
  };

Pixmap *pieceToOutline[] = {
    &outlinePawnBitmap, &outlineRookBitmap, &outlineKnightBitmap,
    &outlineBishopBitmap, &outlineQueenBitmap, &outlineKingBitmap,
    &outlinePawnBitmap, &outlineRookBitmap, &outlineKnightBitmap,
    &outlineBishopBitmap, &outlineQueenBitmap, &outlineKingBitmap
  };

XrmOptionDescRec shellOptions[] = {
    { "-whitePieceColor", "whitePieceColor", XrmoptionSepArg, NULL },
    { "-blackPieceColor", "blackPieceColor", XrmoptionSepArg, NULL },
    { "-lightSquareColor", "lightSquareColor", XrmoptionSepArg, NULL },
    { "-darkSquareColor", "darkSquareColor", XrmoptionSepArg, NULL },
    { "-movesPerSession", "movesPerSession", XrmoptionSepArg, NULL },
    { "-mps", "movesPerSession", XrmoptionSepArg, NULL },
    { "-initString", "initString", XrmoptionSepArg, NULL },
    { "-whiteString", "whiteString", XrmoptionSepArg, NULL },
    { "-blackString", "blackString", XrmoptionSepArg, NULL },
    { "-firstChessProgram", "firstChessProgram", XrmoptionSepArg, NULL },
    { "-fcp", "firstChessProgram", XrmoptionSepArg, NULL },
    { "-secondChessProgram", "secondChessProgram", XrmoptionSepArg, NULL },
    { "-scp", "secondChessProgram", XrmoptionSepArg, NULL },
    { "-noChessProgram", "noChessProgram", XrmoptionSepArg, NULL },
    { "-ncp", "noChessProgram", XrmoptionNoArg, "True" },
    { "-xncp", "noChessProgram", XrmoptionNoArg, "False" },
    { "-firstHost", "firstHost", XrmoptionSepArg, NULL },
    { "-fh", "firstHost", XrmoptionSepArg, NULL },
    { "-secondHost", "secondHost", XrmoptionSepArg, NULL },
    { "-sh", "secondHost", XrmoptionSepArg, NULL },
    { "-bitmapDirectory", "bitmapDirectory", XrmoptionSepArg, NULL },
    { "-bm", "bitmapDirectory", XrmoptionSepArg, NULL },
    { "-remoteShell", "remoteShell", XrmoptionSepArg, NULL },
    { "-rsh", "remoteShell", XrmoptionSepArg, NULL },
    { "-remoteUser", "remoteUser", XrmoptionSepArg, NULL },
    { "-ruser", "remoteUser", XrmoptionSepArg, NULL },
    { "-timeDelay", "timeDelay", XrmoptionSepArg, NULL },
    { "-td", "timeDelay", XrmoptionSepArg, NULL },
    { "-timeControl", "timeControl", XrmoptionSepArg, NULL },
    { "-tc", "timeControl", XrmoptionSepArg, NULL },
    { "-internetChessServerMode", "internetChessServerMode",
	XrmoptionSepArg, NULL },
    { "-ics", "internetChessServerMode", XrmoptionNoArg, "True" },
    { "-xics", "internetChessServerMode", XrmoptionNoArg, "False" },
    { "-internetChessServerHost", "internetChessServerHost",
	XrmoptionSepArg, NULL },
    { "-icshost", "internetChessServerHost", XrmoptionSepArg, NULL },
    { "-internetChessServerPort", "internetChessServerPort",
	XrmoptionSepArg, NULL },
    { "-icsport", "internetChessServerPort", XrmoptionSepArg, NULL },
    { "-internetChessServerCommPort", "internetChessServerCommPort",
	XrmoptionSepArg, NULL },
    { "-icscomm", "internetChessServerCommPort", XrmoptionSepArg, NULL },
    { "-internetChessServerLogonScript", "internetChessServerLogonScript",
	XrmoptionSepArg, NULL },
    { "-icslogon", "internetChessServerLogonScript", XrmoptionSepArg, NULL },
    { "-useTelnet", "useTelnet", XrmoptionSepArg, NULL },
    { "-telnet", "useTelnet", XrmoptionNoArg, "True" },
    { "-xtelnet", "useTelnet", XrmoptionNoArg, "False" },
    { "-telnetProgram", "telnetProgram", XrmoptionSepArg, NULL },
    { "-gateway", "gateway", XrmoptionSepArg, NULL },
    { "-loadGameFile", "loadGameFile", XrmoptionSepArg, NULL },
    { "-lgf", "loadGameFile", XrmoptionSepArg, NULL },
    { "-loadGameIndex", "loadGameIndex", XrmoptionSepArg, NULL },
    { "-lgi", "loadGameIndex", XrmoptionSepArg, NULL },
    { "-saveGameFile", "saveGameFile", XrmoptionSepArg, NULL },
    { "-sgf", "saveGameFile", XrmoptionSepArg, NULL },
    { "-autoSaveGames", "autoSaveGames", XrmoptionSepArg, NULL },
    { "-autosave", "autoSaveGames", XrmoptionNoArg, "True" },
    { "-xautosave", "autoSaveGames", XrmoptionNoArg, "False" },
    { "-loadPositionFile", "loadPositionFile", XrmoptionSepArg, NULL },
    { "-lpf", "loadPositionFile", XrmoptionSepArg, NULL },
    { "-loadPositionIndex", "loadPositionIndex", XrmoptionSepArg, NULL },
    { "-lpi", "loadPositionIndex", XrmoptionSepArg, NULL },
    { "-savePositionFile", "savePositionFile", XrmoptionSepArg, NULL },
    { "-spf", "savePositionFile", XrmoptionSepArg, NULL },
    { "-matchMode", "matchMode", XrmoptionSepArg, NULL },
    { "-mm", "matchMode", XrmoptionNoArg, "True" },
    { "-xmm", "matchMode", XrmoptionNoArg, "False" },
    { "-monoMode", "monoMode", XrmoptionSepArg, NULL },
    { "-mono", "monoMode", XrmoptionNoArg, "True" },
    { "-xmono", "monoMode", XrmoptionNoArg, "False" },
    { "-debugMode", "debugMode", XrmoptionSepArg, NULL },
    { "-debug", "debugMode", XrmoptionNoArg, "True" },
    { "-xdebug", "debugMode", XrmoptionNoArg, "False" },
    { "-clockMode", "clockMode", XrmoptionSepArg, NULL },
    { "-clock", "clockMode", XrmoptionNoArg, "True" },
    { "-xclock", "clockMode", XrmoptionNoArg, "False" },
    { "-boardSize", "boardSize", XrmoptionSepArg, NULL },
    { "-size", "boardSize", XrmoptionSepArg, NULL },
    { "-searchTime", "searchTime", XrmoptionSepArg, NULL },
    { "-st", "searchTime", XrmoptionSepArg, NULL },
    { "-searchDepth", "searchDepth", XrmoptionSepArg, NULL },
    { "-sd", "searchDepth", XrmoptionSepArg, NULL },
    { "-showCoords", "showCoords", XrmoptionSepArg, NULL },
    { "-coords", "showCoords", XrmoptionNoArg, "True" },
    { "-xcoords", "showCoords", XrmoptionNoArg, "False" },
    { "-showThinking", "showThinking", XrmoptionSepArg, NULL },
    { "-thinking", "showThinking", XrmoptionNoArg, "True" },
    { "-xthinking", "showThinking", XrmoptionNoArg, "False" },
    { "-clockFont", "clockFont", XrmoptionSepArg, NULL },
    { "-coordFont", "coordFont", XrmoptionSepArg, NULL },
    { "-ringBellAfterMoves", "ringBellAfterMoves", XrmoptionSepArg, NULL },
    { "-bell", "ringBellAfterMoves", XrmoptionNoArg, "True" },
    { "-xbell", "ringBellAfterMoves", XrmoptionNoArg, "False" },
    { "-autoCallFlag", "autoCallFlag", XrmoptionSepArg, NULL },
    { "-autoflag", "autoCallFlag", XrmoptionNoArg, "True" },
    { "-xautoflag", "autoCallFlag", XrmoptionNoArg, "False" },
    { "-autoObserve", "autoObserve", XrmoptionSepArg, NULL },
    { "-autobs", "autoObserve", XrmoptionNoArg, "True" },
    { "-xautobs", "autoObserve", XrmoptionNoArg, "False" },
    { "-autoComment", "autoComment", XrmoptionSepArg, NULL },
    { "-autocomm", "autoComment", XrmoptionNoArg, "True" },
    { "-xautocomm", "autoComment", XrmoptionNoArg, "False" },
    { "-flipView", "flipView", XrmoptionSepArg, NULL },
    { "-flip", "flipView", XrmoptionNoArg, "True" },
    { "-xflip", "flipView", XrmoptionNoArg, "False" },
    { "-cmail", "cmailGameName", XrmoptionSepArg, NULL },
    { "-alwaysPromoteToQueen", "alwaysPromoteToQueen",
	XrmoptionSepArg, NULL },
    { "-queen", "alwaysPromoteToQueen", XrmoptionNoArg, "True" },
    { "-xqueen", "alwaysPromoteToQueen", XrmoptionNoArg, "False" },
    { "-oldSaveStyle", "oldSaveStyle", XrmoptionSepArg, NULL },
    { "-oldsave", "oldSaveStyle", XrmoptionNoArg, "True" },
    { "-xoldsave", "oldSaveStyle", XrmoptionNoArg, "False" },
    { "-quietPlay", "quietPlay", XrmoptionSepArg, NULL },
    { "-quiet", "quietPlay", XrmoptionNoArg, "True" },
    { "-xquiet", "quietPlay", XrmoptionNoArg, "False" },
    { "-borderXoffset", "borderXoffset", XrmoptionSepArg, NULL },
    { "-borderYoffset", "borderYoffset", XrmoptionSepArg, NULL },
    { "-titleInWindow", "titleInWindow", XrmoptionSepArg, NULL },
    { "-title", "titleInWindow", XrmoptionNoArg, "True" },
    { "-xtitle", "titleInWindow", XrmoptionNoArg, "False" },
#ifdef ZIPPY
    { "-zippyTalk", "zippyTalk", XrmoptionSepArg, NULL },
    { "-zt", "zippyTalk", XrmoptionNoArg, "True" },
    { "-xzt", "zippyTalk", XrmoptionNoArg, "False" },
    { "-zippyPlay", "zippyPlay", XrmoptionSepArg, NULL },
    { "-zp", "zippyPlay", XrmoptionNoArg, "True" },
    { "-xzp", "zippyPlay", XrmoptionNoArg, "False" },
#endif
};


XtActionsRec boardActions[] = {
    { "DrawPosition", DrawPositionProc },
    { "HandleUserMove", HandleUserMove },
    { "FileNameAction", FileNameAction },
    { "PieceMenuPopup", PieceMenuPopup },
    { "WhiteClock", WhiteClock },
    { "BlackClock", BlackClock },
    { "Iconify", Iconify },
    { "ResetProc", ResetProc },
    { "LoadGameProc", LoadGameProc },
    { "LoadNextGameProc", LoadNextGameProc },
    { "LoadPrevGameProc", LoadPrevGameProc },
    { "LoadSelectedProc", LoadSelectedProc },
    { "ReloadGameProc", ReloadGameProc },
    { "LoadPositionProc", LoadPositionProc },
    { "SaveGameProc", SaveGameProc },
    { "SavePositionProc", SavePositionProc },
    { "MailMoveProc", MailMoveProc },
    { "ReloadCmailMsgProc", ReloadCmailMsgProc },
    { "QuitProc", QuitProc },
    { "MachineWhiteProc", MachineWhiteProc },
    { "MachineBlackProc", MachineBlackProc },
    { "TwoMachinesProc", TwoMachinesProc },
    { "IcsClientProc", IcsClientProc },
    { "EditGameProc", EditGameProc },
    { "EditPositionProc", EditPositionProc },
    { "ShowGameListProc", ShowGameListProc },
    { "EditTagsProc", EditCommentProc },
    { "EditCommentProc", EditCommentProc },
    { "PauseProc", PauseProc },
    { "AcceptProc", AcceptProc },
    { "DeclineProc", DeclineProc },
    { "CallFlagProc", CallFlagProc },
    { "DrawProc", DrawProc },
    { "AdjournProc", AdjournProc },
    { "AbortProc", AbortProc },
    { "ResignProc", ResignProc },
    { "StopObservingProc", StopObservingProc },
    { "StopExaminingProc", StopExaminingProc },
    { "BackwardProc", BackwardProc },
    { "ForwardProc", ForwardProc },
    { "ToStartProc", ToStartProc },
    { "ToEndProc", ToEndProc },
    { "RevertProc", RevertProc },
    { "TruncateGameProc", TruncateGameProc },
    { "MoveNowProc", MoveNowProc },
    { "RetractMoveProc", RetractMoveProc },
    { "AlwaysQueenProc", AlwaysQueenProc },
    { "AutoflagProc", AutoflagProc },
    { "AutobsProc", AutobsProc },
    { "AutosaveProc", AutosaveProc },
    { "BellProc", BellProc },
    { "FlipViewProc", FlipViewProc },
    { "OldSaveStyleProc", OldSaveStyleProc },
    { "QuietPlayProc", QuietPlayProc },
    { "ShowCoordsProc", ShowCoordsProc },
    { "ShowThinkingProc", ShowThinkingProc },
    { "HintProc", HintProc },
    { "BookProc", BookProc },
    { "AboutGameProc", AboutGameProc },
    { "AboutProc", AboutProc },
    { "NothingProc", NothingProc },
};
     
char globalTranslations[] =
  "Shift<Key>r: ResignProc() \n \
   <Key>r: ResetProc() \n \
   <Key>g: LoadGameProc() \n \
   Shift<Key>n: LoadNextGameProc() \n \
   Shift<Key>p: LoadPrevGameProc() \n \
   <Key>q: QuitProc() \n \
   Shift<Key>f: ToEndProc() \n \
   <Key>f: ForwardProc() \n \
   Shift<Key>b: ToStartProc() \n \
   <Key>b: BackwardProc() \n \
   <Key>p: PauseProc() \n \
   <Key>d: DrawProc() \n \
   <Key>t: CallFlagProc() \n \
   <Key>i: Iconify() \n \
   <Key>c: Iconify() \n";

char boardTranslations[] =
  "<Expose>: DrawPosition() \n \
   <Btn1Down>: HandleUserMove() \n \
   <Btn1Up>: HandleUserMove() \n \
   <Btn2Down>: XawPositionSimpleMenu(menuW) PieceMenuPopup(menuW) \n \
   <Btn3Down>: XawPositionSimpleMenu(menuB) PieceMenuPopup(menuB) \n \
   <Message>WM_PROTOCOLS: QuitProc() \n";
     
char whiteTranslations[] = "<BtnDown>: WhiteClock()\n";
char blackTranslations[] = "<BtnDown>: BlackClock()\n";
     
String xboardResources[] = {
    DEFAULT_FONT,
    "*Dialog*value.translations: #override \\n <Key>Return: FileNameAction()",
    NULL
  };
     
void main(argc, argv)
     int argc;
     char **argv;
{
    int i, j, clockFontPxlSize, coordFontPxlSize;
    XSetWindowAttributes window_attributes;
    Arg args[16];
    Dimension timerWidth, boardWidth, w, h, sep, bor, wr, hr;
    XrmValue vFrom, vTo;
    XtTranslations tr;
    XtGeometryResult gres;

    setbuf(stdout, NULL);
    setbuf(stderr, NULL);
    fromUserFP = stdin;
    toUserFP = stdout;
    debugFP = stderr;
    
    programName = strrchr(argv[0], '/');
    if (programName == NULL)
      programName = argv[0];
    else
      programName++;
    
    shellWidget =
      XtAppInitialize(&appContext, "XBoard", shellOptions,
		      XtNumber(shellOptions),
		      &argc, argv, xboardResources, NULL, 0);
    if (argc > 1)
      Usage();
    
    if ((chessDir = (char *) getenv("CHESSDIR")) == NULL) {
	chessDir = ".";
    } else {
	if (chdir(chessDir) != 0) {
	    fprintf(stderr, "%s: can't cd to CHESSDIR: ", programName);
	    perror(chessDir);
	    exit(1);
	}
    }
    
    XtGetApplicationResources(shellWidget, (XtPointer) &appData,
			      clientResources, XtNumber(clientResources),
			      NULL, 0);
 
    InitBackEnd1();

    xDisplay = XtDisplay(shellWidget);
    xScreen = DefaultScreen(xDisplay);

    /*
     * Determine boardSize
     */
    if (*appData.boardSize == NULLCHAR) {
	if (((DisplayWidth(xDisplay, xScreen) < 800) ||
	     (DisplayHeight(xDisplay, xScreen) < 800)))
	  boardSize = Medium;
	else
	  boardSize = Large;
    } else if (StrCaseCmp(appData.boardSize, "Large") == 0) {
	boardSize = Large;
    } else if (StrCaseCmp(appData.boardSize, "Medium") == 0) {
	boardSize = Medium;
    } else if (StrCaseCmp(appData.boardSize, "Small") == 0) {
	boardSize = Small;
    } else {
	fprintf(stderr, "%s: bad boardSize option %s\n",
		programName, appData.boardSize);
	Usage();
    }
    switch (boardSize) {
      case Small:
	squareSize = SMALL_SQUARE_SIZE;
	lineGap = SMALL_LINE_GAP;
	clockFontPxlSize = 20;
	coordFontPxlSize = 10;
	break;
      case Medium:
	squareSize = MEDIUM_SQUARE_SIZE;
	lineGap = MEDIUM_LINE_GAP;
	clockFontPxlSize = 34;
	coordFontPxlSize = 12;
	break;
      case Large:
      default:
	squareSize = LARGE_SQUARE_SIZE;
	lineGap = LARGE_LINE_GAP;
	clockFontPxlSize = 34;
	coordFontPxlSize = 14;
	break;
    }
    boardWidth = lineGap + BOARD_SIZE * (squareSize + lineGap);
    XtSetArg(boardArgs[1], XtNwidth, boardWidth);
    XtSetArg(boardArgs[2], XtNheight,
	     lineGap + BOARD_SIZE * (squareSize + lineGap));

    /*
     * Determine what fonts to use.
     */
    appData.clockFont = FindFont(appData.clockFont, clockFontPxlSize);
    clockFontID = XLoadFont(xDisplay, appData.clockFont);
    clockFontStruct = XQueryFont(xDisplay, clockFontID);
    appData.coordFont = FindFont(appData.coordFont, coordFontPxlSize);
    coordFontID = XLoadFont(xDisplay, appData.coordFont);
    coordFontStruct = XQueryFont(xDisplay, coordFontID);

    /*
     * Detect if there are not enough colors are available and adapt.
     */
    if (DefaultDepth(xDisplay, xScreen) <= 2)
      appData.monoMode = True;

    if (!appData.monoMode) {
	vFrom.addr = (caddr_t) appData.lightSquareColor;
	vFrom.size = strlen(appData.lightSquareColor);
	XtConvert(shellWidget, XtRString, &vFrom, XtRPixel, &vTo);
	if (vTo.addr == NULL)
	  appData.monoMode = True;
	else
	  lightSquareColor = *(Pixel *) vTo.addr;
    }
    if (!appData.monoMode) {
	vFrom.addr = (caddr_t) appData.darkSquareColor;
	vFrom.size = strlen(appData.darkSquareColor);
	XtConvert(shellWidget, XtRString, &vFrom, XtRPixel, &vTo);
	if (vTo.addr == NULL)
	  appData.monoMode = True;
	else
	  darkSquareColor = *(Pixel *) vTo.addr;
    }
    if (!appData.monoMode) {
	vFrom.addr = (caddr_t) appData.whitePieceColor;
	vFrom.size = strlen(appData.whitePieceColor);
	XtConvert(shellWidget, XtRString, &vFrom, XtRPixel, &vTo);
	if (vTo.addr == NULL)
	  appData.monoMode = True;
	else
	  whitePieceColor = *(Pixel *) vTo.addr;
    }
    if (!appData.monoMode) {
	vFrom.addr = (caddr_t) appData.blackPieceColor;
	vFrom.size = strlen(appData.blackPieceColor);
	XtConvert(shellWidget, XtRString, &vFrom, XtRPixel, &vTo);
	if (vTo.addr == NULL)
	  appData.monoMode = True;
	else
	  blackPieceColor = *(Pixel *) vTo.addr;
    }

    if (appData.monoMode && appData.debugMode) {
	fprintf(stderr, "white pixel = 0x%lx, black pixel = 0x%lx\n",
		(unsigned long) XWhitePixel(xDisplay, xScreen),
		(unsigned long) XBlackPixel(xDisplay, xScreen));
    }
    
    XtAppAddActions(appContext, boardActions, XtNumber(boardActions));
    
    /*
     * widget hierarchy
     */
    formWidget =
      XtCreateManagedWidget("form", formWidgetClass, shellWidget, NULL, 0);
    XtSetArg(args[0], XtNdefaultDistance, &sep);
    XtGetValues(formWidget, args, 1);
    
    j = 0;
    widgetList[j++] = menuBarWidget = CreateMenuBar(menuBar);

    widgetList[j++] = whiteTimerWidget =
      XtCreateWidget("whiteTime", labelWidgetClass,
		     formWidget, timerArgs, XtNumber(timerArgs));
    XtSetArg(args[0], XtNfont, clockFontStruct);
    XtSetValues(whiteTimerWidget, args, 1);
    
    widgetList[j++] = blackTimerWidget =
      XtCreateWidget("blackTime", labelWidgetClass,
		     formWidget, timerArgs, XtNumber(timerArgs));
    XtSetArg(args[0], XtNfont, clockFontStruct);
    XtSetValues(blackTimerWidget, args, 1);
    
    if (appData.titleInWindow) {
	widgetList[j++] = titleWidget = 
	  XtCreateWidget("title", labelWidgetClass, formWidget,
			 titleArgs, XtNumber(titleArgs));
    }

    widgetList[j++] = buttonBarWidget = CreateButtonBar(buttonBar);

    widgetList[j++] = messageWidget =
      XtCreateWidget("message", labelWidgetClass, formWidget,
		     messageArgs, XtNumber(messageArgs));
    
    widgetList[j++] = boardWidget =
      XtCreateWidget("board", widgetClass, formWidget, boardArgs,
		     XtNumber(boardArgs));
    
    XtManageChildren(widgetList, j);
    
    timerWidth = (boardWidth - sep) / 2;
    XtSetArg(args[0], XtNwidth, timerWidth);
    XtSetValues(whiteTimerWidget, args, 1);
    XtSetValues(blackTimerWidget, args, 1);
    
    XtSetArg(args[0], XtNbackground, &timerBackgroundPixel);
    XtSetArg(args[1], XtNforeground, &timerForegroundPixel);
    XtGetValues(whiteTimerWidget, args, 2);
    
    XtSetArg(args[0], XtNbackground, &buttonBackgroundPixel);
    XtSetArg(args[1], XtNforeground, &buttonForegroundPixel);
    XtGetValues(XtNameToWidget(buttonBarWidget, PAUSE_BUTTON), args, 2);

    /*
     * formWidget uses these constraints but they are stored
     * in the children.
     */
    i = 0;
    XtSetArg(args[i], XtNfromHoriz, 0); i++;
    XtSetValues(menuBarWidget, args, i);
    if (appData.titleInWindow) {
	if (boardSize == Small) {
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, menuBarWidget); i++;
	    XtSetValues(whiteTimerWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, menuBarWidget); i++;
	    XtSetArg(args[i], XtNfromHoriz, whiteTimerWidget); i++;
	    XtSetValues(blackTimerWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, whiteTimerWidget); i++;
            XtSetArg(args[i], XtNjustify, XtJustifyLeft); i++;
	    XtSetValues(titleWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, titleWidget); i++;
	    XtSetValues(messageWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, titleWidget); i++;
	    XtSetArg(args[i], XtNfromHoriz, messageWidget); i++;
	    XtSetValues(buttonBarWidget, args, i);
	} else {
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, titleWidget); i++;
	    XtSetValues(whiteTimerWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, titleWidget); i++;
	    XtSetArg(args[i], XtNfromHoriz, whiteTimerWidget); i++;
	    XtSetValues(blackTimerWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromHoriz, menuBarWidget); i++;
	    XtSetValues(titleWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, whiteTimerWidget); i++;
	    XtSetValues(messageWidget, args, i);
	    i = 0;
	    XtSetArg(args[i], XtNfromVert, whiteTimerWidget); i++;
	    XtSetArg(args[i], XtNfromHoriz, messageWidget); i++;
	    XtSetValues(buttonBarWidget, args, i);
	}
    } else {
	i = 0;
	XtSetArg(args[i], XtNfromVert, menuBarWidget); i++;
	XtSetValues(whiteTimerWidget, args, i);
	i = 0;
	XtSetArg(args[i], XtNfromVert, menuBarWidget); i++;
	XtSetArg(args[i], XtNfromHoriz, whiteTimerWidget); i++;
	XtSetValues(blackTimerWidget, args, i);
	i = 0;
	XtSetArg(args[i], XtNfromVert, whiteTimerWidget); i++;
	XtSetValues(messageWidget, args, i);
	i = 0;
	XtSetArg(args[i], XtNfromVert, whiteTimerWidget); i++;
	XtSetArg(args[i], XtNfromHoriz, messageWidget); i++;
	XtSetValues(buttonBarWidget, args, i);
    }
    i = 0;
    XtSetArg(args[0], XtNfromVert, messageWidget);
    XtSetValues(boardWidget, args, 1);
    
    XtRealizeWidget(shellWidget);

    /*
     * Correct the width of the message and title widgets.
     * It is not known why some systems need the extra fudge term.
     * The value "2" is probably larger than needed.
     */
#define WIDTH_FUDGE 2
    i = 0;
    XtSetArg(args[i], XtNwidth, &w);  i++;
    XtGetValues(buttonBarWidget, args, i);
    i = 0;
    XtSetArg(args[i], XtNborderWidth, &bor);  i++;
    XtSetArg(args[i], XtNheight, &h);  i++;
    XtGetValues(messageWidget, args, i);

    w = boardWidth - w - sep - 2*bor - WIDTH_FUDGE;
    gres = XtMakeResizeRequest(messageWidget, w, h, &wr, &hr);
    if (gres != XtGeometryYes) {
	fprintf(stderr, "%s: messageWidget geometry error %d %d %d %d %d\n",
		programName, gres, w, h, wr, hr);
    }

    if (appData.titleInWindow) {
	i = 0;
	XtSetArg(args[i], XtNborderWidth, &bor); i++;
	XtSetArg(args[i], XtNheight, &h);  i++;
	XtGetValues(titleWidget, args, i);
	if (boardSize == Small) {
	    w = boardWidth - 2*bor;
	} else {
	    XtSetArg(args[0], XtNwidth, &w);
	    XtGetValues(menuBarWidget, args, 1);
	    w = boardWidth - w - sep - 2*bor - WIDTH_FUDGE;
	}

	gres = XtMakeResizeRequest(titleWidget, w, h, &wr, &hr);
	if (gres != XtGeometryYes) {
	    fprintf(stderr,
		    "%s: titleWidget geometry error %d %d %d %d %d\n",
		    programName, gres, w, h, wr, hr);
	}
    }
    xBoardWindow = XtWindow(boardWidget);
    
    /* 
     * Create X checkmark bitmap and initialize option menu checks.
     */
    ReadBitmap(&xMarkPixmap, "checkmark.bm",
	       checkmark_bits, checkmark_width, checkmark_height);
    XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    if (appData.alwaysPromoteToQueen) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Always Queen"),
		    args, 1);
    }
    if (appData.autoComment) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Comment"),
		    args, 1);
    }
    if (appData.autoCallFlag) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Flag"),
		    args, 1);
    }
    if (appData.autoObserve) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Observe"),
		    args, 1);
    }
    if (appData.autoSaveGames) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Save"),
		    args, 1);
    }
    if (appData.saveGameFile[0] != NULLCHAR) {
	/* Can't turn this off from menu */
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Save"),
		    args, 1);
	XtSetSensitive(XtNameToWidget(menuBarWidget, "menuOptions.Auto Save"),
		       False);

    }
    if (appData.ringBellAfterMoves) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Bell"),
		    args, 1);
    }
    if (appData.showCoords) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Show Coords"),
		    args, 1);
    }
    if (appData.showThinking) {
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Show Thinking"),
		    args, 1);
    }
    if (appData.oldSaveStyle) {
	XtSetValues(XtNameToWidget(menuBarWidget,
				   "menuOptions.Old Save Style"), args, 1);
    }
    if (appData.quietPlay) {
	XtSetValues(XtNameToWidget(menuBarWidget,
				   "menuOptions.Quiet Play"), args, 1);
    }

    /*
     * Create an icon.
     */
    ReadBitmap(&wIconPixmap, "icon_white.bm",
	       icon_white_bits, icon_white_width, icon_white_height);
    ReadBitmap(&bIconPixmap, "icon_black.bm",
	       icon_black_bits, icon_black_width, icon_black_height);
    iconPixmap = wIconPixmap;
    i = 0;
    XtSetArg(args[i], XtNiconPixmap, iconPixmap);  i++;
    XtSetValues(shellWidget, args, i);
    
    /*
     * Create a cursor for the board widget.
     */
    window_attributes.cursor = XCreateFontCursor(xDisplay, XC_hand2);
    XChangeWindowAttributes(xDisplay, xBoardWindow,
			    CWCursor, &window_attributes);
    
    /*
     * Inhibit shell resizing.
     */
    shellArgs[0].value = (XtArgVal) &w;
    shellArgs[1].value = (XtArgVal) &h;
    XtGetValues(shellWidget, shellArgs, 2);
    shellArgs[4].value = shellArgs[2].value = w;
    shellArgs[5].value = shellArgs[3].value = h;
    XtSetValues(shellWidget, &shellArgs[2], 4);
    
    CreateGCs();
    CreateGrid();
    CreatePieces();
    CreatePieceMenus();
    
    tr = XtParseTranslationTable(globalTranslations);
    XtAugmentTranslations(formWidget, tr);
    XtSetArg(args[0], XtNtranslations, &tr);
    XtGetValues(formWidget, args, 1);
    XtSetArg(args[0], XtNtranslations, tr);
    XtSetValues(boardWidget, args, 1);
    XtAugmentTranslations(boardWidget,
			  XtParseTranslationTable(boardTranslations));
    XtAugmentTranslations(whiteTimerWidget,
			  XtParseTranslationTable(whiteTranslations));
    XtAugmentTranslations(blackTimerWidget,
			  XtParseTranslationTable(blackTranslations));
    
    XtAddEventHandler(boardWidget, ExposureMask | ButtonPressMask
		      | ButtonReleaseMask | Button1MotionMask | KeyPressMask,
		      False, (XtEventHandler) EventProc, NULL);
    
    InitBackEnd2();
    
    if (errorExitStatus == -1) {
	if (appData.icsActive) {
	    ICSInitScript();
	}

	signal(SIGINT, IntSigHandler);
	signal(SIGTERM, IntSigHandler);
	if (*appData.cmailGameName != NULLCHAR) {
	    signal(SIGUSR1, CmailSigHandler);
	}
    }

    XtAppMainLoop(appContext);
}

RETSIGTYPE
IntSigHandler(sig)
     int sig;
{
    ExitEvent(sig);
}

RETSIGTYPE
CmailSigHandler(sig)
     int sig;
{
    int dummy = 0;
    int error;

    signal(SIGUSR1, SIG_IGN);			  /* suspend handler     */

    /* Activate call-back function CmailSigHandlerCallBack()             */
    OutputToProcess(cmailPR, (char *)(&dummy), sizeof(int), &error);

    signal(SIGUSR1, CmailSigHandler);		  /* re-activate handler */
}

void CmailSigHandlerCallBack(isr, message, count, error)
     InputSourceRef isr;
     char *message;
     int count;
     int error;
{
    XtMapWidget(shellWidget);                       /* Open if iconified */
    XtPopup(shellWidget, XtGrabNone);               /* Raise if lowered  */

    ReloadCmailMsgEvent(TRUE);			    /* Reload cmail msg  */

}
/**** end signal code ****/

void Usage()
{
    fprintf(stderr, "Usage: %s\n", programName);
    fprintf(stderr, "\t-timeControl (or -tc) minutes[:seconds]\n");
    fprintf(stderr, "\t-movesPerSession (or -mps) number\n");
    fprintf(stderr, "\t-clockMode (True | False), or -[x]clock\n");
    fprintf(stderr, "\t-searchTime (or -st) minutes[:seconds]\n");
    fprintf(stderr, "\t-searchDepth (or -sd) number\n");
    fprintf(stderr, "\t-matchMode (True | False), or -[x]mm\n");
    fprintf(stderr, "\t-internetChessServerMode (True | False), or -[x]ics\n");
    fprintf(stderr, "\t-internetChessServerHost (or -icshost) host_name\n");
    fprintf(stderr, "\t-loadGameFile (or -lgf) file_name\n");
    fprintf(stderr, "\t-loadGameIndex (or -lgi) number\n");
    fprintf(stderr, "\t-boardSize (or -size) (Large | Medium | Small)\n");
    fprintf(stderr, "\t-noChessProgram (True | False), or -[x]ncp\n");
    fprintf(stderr, "\t-debugMode (True | False), or -[x]debug\n");
    fprintf(stderr, "See the man page for more options and information\n");
    exit(2);
}

void ICSInitScript()
{
    FILE *f;
    char buf[MSG_SIZ];
    char *p;

    f = fopen(appData.icsLogon, "r");
    if (f == NULL) {
	p = getenv("HOME");
	if (p != NULL) {
	    strcpy(buf, p);
	    strcat(buf, "/");
	    strcat(buf, appData.icsLogon);
	    f = fopen(buf, "r");
	}
    }
    if (f != NULL)
      ProcessICSInitScript(f);
}

void ResetFrontEnd()
{
    CommentPopDown();
    EditCommentPopDown();
    TagsPopDown();
    return;
}

typedef struct {
    char *name;
    Boolean value;
} Sensitivity;

void SetMenuSensitivity(sens)
     Sensitivity *sens;
{
    while (sens->name != NULL) {
	XtSetSensitive(XtNameToWidget(menuBarWidget, sens->name), sens->value);
	sens++;
    }
}

Sensitivity icsSensitivity[] = {
    { "menuFile.Mail Move", False },
    { "menuFile.Reload CMail Message", False },
    { "menuMode.Machine Black", False },
    { "menuMode.Machine White", False },
    { "menuMode.Two Machines", False },
#ifndef ZIPPY
    { "menuHelp.Hint", False },
    { "menuHelp.Book", False },
    { "menuStep.Move Now", False },
    { "menuOptions.Show Thinking", False },
#endif
    { NULL, False }
};

void SetICSMode()
{
    SetMenuSensitivity(icsSensitivity);
}

Sensitivity ncpSensitivity[] = {    
    { "menuFile.Mail Move", False },
    { "menuFile.Reload CMail Message", False },
    { "menuMode.Machine White", False },
    { "menuMode.Machine Black", False },
    { "menuMode.Two Machines", False },
    { "menuMode.ICS Client", False },
    { "Action", False },
    { "menuStep.Revert", False },
    { "menuStep.Move Now", False },
    { "menuStep.Retract Move", False },
    { "menuOptions.Auto Comment", False },
    { "menuOptions.Auto Flag", False },
    { "menuOptions.Auto Observe", False },
    { "menuOptions.Bell", False },
    { "menuOptions.Quiet Play", False },
    { "menuOptions.Show Thinking", False },
    { "menuHelp.Hint", False },
    { "menuHelp.Book", False },
    { NULL, False }
};

void SetNCPMode()
{
    SetMenuSensitivity(ncpSensitivity);
}

Sensitivity gnuSensitivity[] = {    
    { "menuMode.ICS Client", False },
    { "menuAction.Accept", False },
    { "menuAction.Decline", False },
    { "menuAction.Draw", False },
    { "menuAction.Adjourn", False },
    { "menuAction.Stop Examining", False },
    { "menuAction.Stop Observing", False },
    { "menuStep.Revert", False },
    { "menuOptions.Auto Comment", False },
    { "menuOptions.Auto Flag", False },
    { "menuOptions.Auto Observe", False },
    { "menuOptions.Quiet Play", False },

    /* The next two options rely on SetCmailMode being called *after*    */
    /* SetGNUMode so that when GNU is being used to give hints these     */
    /* menu options are still available                                  */

    { "menuFile.Mail Move", False },
    { "menuFile.Reload CMail Message", False },
    { NULL, False }
};

void SetGNUMode()
{
    SetMenuSensitivity(gnuSensitivity);
}

Sensitivity cmailSensitivity[] = {    
    { "Action", True },
    { "menuAction.Call Flag", False },
    { "menuAction.Draw", True },
    { "menuAction.Adjourn", False },
    { "menuAction.Abort", False },
    { "menuAction.Stop Observing", False },
    { "menuAction.Stop Examining", False },
    { "menuFile.Mail Move", True },
    { "menuFile.Reload CMail Message", True },
    { NULL, False }
};

void SetCmailMode()
{
    SetMenuSensitivity(cmailSensitivity);
}

#define Abs(n) ((n)<0 ? -(n) : (n))

/*
 * Find a font that matches "pattern" that is as close as
 * possible to the targetPxlSize.  Prefer fonts that are k
 * pixels smaller to fonts that are k pixels larger.  The
 * pattern must be in the X Consortium standard format, 
 * e.g. "-*-helvetica-bold-r-normal--*-*-*-*-*-*-*-*".
 * The return value should be freed with XtFree when no
 * longer needed.
 */
char *FindFont(pattern, targetPxlSize)
     char *pattern;
     int targetPxlSize;
{
    char **fonts, *p, *best;
    int i, j, nfonts, minerr, err, pxlSize;
    char errbuf[MSG_SIZ];

    fonts = XListFonts(xDisplay, pattern, 999999, &nfonts);
    if (nfonts < 1) {
	sprintf(errbuf, "No fonts match pattern %s\n", pattern);
	DisplayFatalError(errbuf, 0, 2);
    }
    best = "";
    minerr = 999999;
    for (i=0; i<nfonts; i++) {
	j = 0;
	p = fonts[i];
	if (*p != '-') continue;
	while (j < 7) {
	    if (*p == NULLCHAR) break;
	    if (*p++ == '-') j++;
	}
	if (j < 7) continue;
	pxlSize = atoi(p);
	if (pxlSize == targetPxlSize) {
	    best = fonts[i];
	    break;
	}
	err = pxlSize - targetPxlSize;
	if (Abs(err) < Abs(minerr) ||
	    (minerr > 0 && err < 0 && -err == minerr)) {
	    best = fonts[i];
	    minerr = err;
	}
    }
    p = (char *) XtMalloc(strlen(best) + 1);
    strcpy(p, best);
    XFreeFontNames(fonts);
    return p;
}

void CreateGCs()
{
    XtGCMask value_mask = GCLineWidth | GCLineStyle | GCForeground
      | GCBackground | GCFunction | GCPlaneMask;
    XGCValues gc_values;
    GC copyInvertedGC;
    
    gc_values.plane_mask = AllPlanes;
    gc_values.line_width = lineGap;
    gc_values.line_style = LineSolid;
    gc_values.function = GXcopy;
    
    gc_values.foreground = XBlackPixel(xDisplay, xScreen);
    gc_values.background = XBlackPixel(xDisplay, xScreen);
    lineGC = XtGetGC(shellWidget, value_mask, &gc_values);
    
    gc_values.background = XWhitePixel(xDisplay, xScreen);
    coordGC = XtGetGC(shellWidget, value_mask, &gc_values);
    XSetFont(xDisplay, coordGC, coordFontID);
    
    if (appData.monoMode) {
	gc_values.foreground = XWhitePixel(xDisplay, xScreen);
	gc_values.background = XBlackPixel(xDisplay, xScreen);
	lightSquareGC = wbPieceGC 
	  = XtGetGC(shellWidget, value_mask, &gc_values);

	gc_values.foreground = XBlackPixel(xDisplay, xScreen);
	gc_values.background = XWhitePixel(xDisplay, xScreen);
	darkSquareGC = bwPieceGC
	  = XtGetGC(shellWidget, value_mask, &gc_values);

	if (DefaultDepth(xDisplay, xScreen) == 1) {
	    /* Avoid XCopyPlane on 1-bit screens to work around Sun bug */
	    gc_values.function = GXcopyInverted;
	    copyInvertedGC = XtGetGC(shellWidget, value_mask, &gc_values);
	    gc_values.function = GXcopy;
	    if (XBlackPixel(xDisplay, xScreen) == 1) {
		bwPieceGC = darkSquareGC;
		wbPieceGC = copyInvertedGC;
	    } else {
		bwPieceGC = copyInvertedGC;
		wbPieceGC = lightSquareGC;
	    }
	}
    } else {
	gc_values.foreground = lightSquareColor;
	gc_values.background = darkSquareColor;
	lightSquareGC = XtGetGC(shellWidget, value_mask, &gc_values);
	
	gc_values.foreground = darkSquareColor;
	gc_values.background = lightSquareColor;
	darkSquareGC = XtGetGC(shellWidget, value_mask, &gc_values);
	
	gc_values.foreground = whitePieceColor;
	gc_values.background = darkSquareColor;
	wdPieceGC = XtGetGC(shellWidget, value_mask, &gc_values);
	
	gc_values.foreground = whitePieceColor;
	gc_values.background = lightSquareColor;
	wlPieceGC = XtGetGC(shellWidget, value_mask, &gc_values);
	
	gc_values.foreground = blackPieceColor;
	gc_values.background = darkSquareColor;
	bdPieceGC = XtGetGC(shellWidget, value_mask, &gc_values);
	
	gc_values.foreground = blackPieceColor;
	gc_values.background = lightSquareColor;
	blPieceGC = XtGetGC(shellWidget, value_mask, &gc_values);
    }
}

void CreatePieces()
{
    u_int ss = squareSize;
    XSynchronize(xDisplay, True); /* Work-around for xlib/xt
				     buffering bug */
    
    switch (boardSize) {
      case Small:
	ReadBitmap(&solidPawnBitmap,   "p40s.bm", p40s_bits, ss, ss);
	ReadBitmap(&solidKnightBitmap, "n40s.bm", n40s_bits, ss, ss);
	ReadBitmap(&solidBishopBitmap, "b40s.bm", b40s_bits, ss, ss);
	ReadBitmap(&solidRookBitmap,   "r40s.bm", r40s_bits, ss, ss);
	ReadBitmap(&solidQueenBitmap,  "q40s.bm", q40s_bits, ss, ss);
	ReadBitmap(&solidKingBitmap,   "k40s.bm", k40s_bits, ss, ss);
        break;
      case Medium:
	ReadBitmap(&solidPawnBitmap,   "p64s.bm", p64s_bits, ss, ss);
	ReadBitmap(&solidKnightBitmap, "n64s.bm", n64s_bits, ss, ss);
	ReadBitmap(&solidBishopBitmap, "b64s.bm", b64s_bits, ss, ss);
	ReadBitmap(&solidRookBitmap,   "r64s.bm", r64s_bits, ss, ss);
	ReadBitmap(&solidQueenBitmap,  "q64s.bm", q64s_bits, ss, ss);
	ReadBitmap(&solidKingBitmap,   "k64s.bm", k64s_bits, ss, ss);
        break;
      case Large:
	ReadBitmap(&solidPawnBitmap,   "p80s.bm", p80s_bits, ss, ss);
	ReadBitmap(&solidKnightBitmap, "n80s.bm", n80s_bits, ss, ss);
	ReadBitmap(&solidBishopBitmap, "b80s.bm", b80s_bits, ss, ss);
	ReadBitmap(&solidRookBitmap,   "r80s.bm", r80s_bits, ss, ss);
	ReadBitmap(&solidQueenBitmap,  "q80s.bm", q80s_bits, ss, ss);
	ReadBitmap(&solidKingBitmap,   "k80s.bm", k80s_bits, ss, ss);
        break;
    }
    
    if (appData.monoMode) {
	switch (boardSize) {
	  case Small:
	    ReadBitmap(&outlinePawnBitmap,   "p40o.bm", p40o_bits, ss, ss);
	    ReadBitmap(&outlineKnightBitmap, "n40o.bm", n40o_bits, ss, ss);
	    ReadBitmap(&outlineBishopBitmap, "b40o.bm", b40o_bits, ss, ss);
	    ReadBitmap(&outlineRookBitmap,   "r40o.bm", r40o_bits, ss, ss);
	    ReadBitmap(&outlineQueenBitmap,  "q40o.bm", q40o_bits, ss, ss);
	    ReadBitmap(&outlineKingBitmap,   "k40o.bm", k40o_bits, ss, ss);
	    break;
	  case Medium:
	    ReadBitmap(&outlinePawnBitmap,   "p64o.bm", p64o_bits, ss, ss);
	    ReadBitmap(&outlineKnightBitmap, "n64o.bm", n64o_bits, ss, ss);
	    ReadBitmap(&outlineBishopBitmap, "b64o.bm", b64o_bits, ss, ss);
	    ReadBitmap(&outlineRookBitmap,   "r64o.bm", r64o_bits, ss, ss);
	    ReadBitmap(&outlineQueenBitmap,  "q64o.bm", q64o_bits, ss, ss);
	    ReadBitmap(&outlineKingBitmap,   "k64o.bm", k64o_bits, ss, ss);
	    break;
	  case Large:
	    ReadBitmap(&outlinePawnBitmap,   "p80o.bm", p80o_bits, ss, ss);
	    ReadBitmap(&outlineKnightBitmap, "n80o.bm", n80o_bits, ss, ss);
	    ReadBitmap(&outlineBishopBitmap, "b80o.bm", b80o_bits, ss, ss);
	    ReadBitmap(&outlineRookBitmap,   "r80o.bm", r80o_bits, ss, ss);
	    ReadBitmap(&outlineQueenBitmap,  "q80o.bm", q80o_bits, ss, ss);
	    ReadBitmap(&outlineKingBitmap,   "k80o.bm", k80o_bits, ss, ss);
	    break;
	}
    }
    
    XSynchronize(xDisplay, False); /* Work-around for xlib/xt
				      buffering bug */
}

void ReadBitmap(pm, name, bits, wreq, hreq)
     Pixmap *pm;
     String name;
     unsigned char bits[];
     u_int wreq, hreq;
{
    int x_hot, y_hot;
    u_int w, h;
    int errcode;
    char msg[MSG_SIZ], fullname[MSG_SIZ];
    
    if (*appData.bitmapDirectory == NULLCHAR) {
	*pm = XCreateBitmapFromData(xDisplay, xBoardWindow, (char *) bits,
				    wreq, hreq);
    } else {
        strcpy(fullname, appData.bitmapDirectory);
	strcat(fullname, "/");
	strcat(fullname, name);
	errcode = XReadBitmapFile(xDisplay, xBoardWindow, fullname,
				  &w, &h, pm, &x_hot, &y_hot);
	if (errcode != BitmapSuccess) {
	    switch (errcode) {
	      case BitmapOpenFailed:
		sprintf(msg, "Can't open bitmap file %s", fullname);
		break;
	      case BitmapFileInvalid:
		sprintf(msg, "Invalid bitmap in file %s", fullname);
		break;
	      case BitmapNoMemory:
		sprintf(msg, "Ran out of memory reading bitmap file %s",
			fullname);
		break;
	      default:
		sprintf(msg, "Unknown XReadBitmapFile error %d on file %s",
			errcode, fullname);
		break;
	    }
	    DisplayFatalError(msg, 0, 1);
	}
	if (w != wreq || h != hreq) {
	    sprintf(msg, "Bitmap is %dx%d, should be %dx%d; file %s",
		    w, h, wreq, hreq, fullname);
	    DisplayFatalError(msg, 0, 1);
	}
    }
}

void CreateGrid()
{
    int i;
    
    for (i = 0; i < BOARD_SIZE + 1; i++) {
	gridSegments[i].x1 = gridSegments[i + BOARD_SIZE + 1].y1 = 0;
	gridSegments[i].y1 = gridSegments[i].y2
	  = lineGap / 2 + (i * (squareSize + lineGap));
	gridSegments[i].x2 = lineGap + BOARD_SIZE *
	  (squareSize + lineGap);
	gridSegments[i + BOARD_SIZE + 1].x1 =
	  gridSegments[i + BOARD_SIZE + 1].x2 = lineGap / 2
	    + (i * (squareSize + lineGap));
	gridSegments[i + BOARD_SIZE + 1].y2 =
	  BOARD_SIZE * (squareSize + lineGap);
    }
}

static void MenuBarSelect(w, addr, index)
     Widget w;
     caddr_t addr;
     caddr_t index;
{
    XtActionProc proc = (XtActionProc) addr;

    (proc)(NULL, NULL, NULL, NULL);
}

void CreateMenuBarPopup(parent, name, mb)
     Widget parent;
     String name;
     Menu *mb;
{
    int j;
    Widget menu, entry;
    MenuItem *mi;
    Arg args[16];

    menu = XtCreatePopupShell(name, simpleMenuWidgetClass,
			      parent, NULL, 0);
    j = 0;
    XtSetArg(args[j], XtNleftMargin, 20);   j++;
    XtSetArg(args[j], XtNrightMargin, 20);  j++;
    mi = mb->mi;
    while (mi->string != NULL) {
	if (strcmp(mi->string, "----") == 0) {
	    entry = XtCreateManagedWidget(mi->string, smeLineObjectClass,
					  menu, args, j);
	} else {
	    entry = XtCreateManagedWidget(mi->string, smeBSBObjectClass,
					  menu, args, j);
	    XtAddCallback(entry, XtNcallback,
			  (XtCallbackProc) MenuBarSelect,
			  (caddr_t) mi->proc);
	}
	mi++;
    }
}	

Widget CreateMenuBar(mb)
     Menu *mb;
{
    int j;
    Widget anchor, menuBar;
    Arg args[16];
    char menuName[MSG_SIZ];

    j = 0;
    XtSetArg(args[j], XtNorientation, XtorientHorizontal);  j++;
    XtSetArg(args[j], XtNvSpace, 0);                        j++;
    XtSetArg(args[j], XtNborderWidth, 0);                   j++;
    menuBar = XtCreateWidget("menuBar", boxWidgetClass,
			     formWidget, args, j);

    while (mb->name != NULL) {
	strcpy(menuName, "menu");
	strcat(menuName, mb->name);
	j = 0;
	XtSetArg(args[j], XtNmenuName, XtNewString(menuName));  j++;
	XtSetArg(args[j], XtNborderWidth, 0);                   j++;
	anchor = XtCreateManagedWidget(mb->name, menuButtonWidgetClass,
				       menuBar, args, j);
	CreateMenuBarPopup(menuBar, menuName, mb);
	mb++;
    }
    return menuBar;
}

Widget CreateButtonBar(mi)
     MenuItem *mi;
{
    int j;
    Widget button, buttonBar;
    Arg args[16];

    j = 0;
    XtSetArg(args[j], XtNorientation, XtorientHorizontal);  j++;
    XtSetArg(args[j], XtNvSpace, 0);                        j++;
    XtSetArg(args[j], XtNborderWidth, 0);                   j++;
    buttonBar = XtCreateWidget("buttonBar", boxWidgetClass,
			       formWidget, args, j);

    while (mi->string != NULL) {
	j = 0;
	button = XtCreateManagedWidget(mi->string, commandWidgetClass,
				       buttonBar, args, j);
	XtAddCallback(button, XtNcallback,
		      (XtCallbackProc) MenuBarSelect,
		      (caddr_t) mi->proc);
	mi++;
    }
    return buttonBar;
}     

void CreatePieceMenus()
{
    int i;
    Widget entry;
    Arg args[16];
    ChessSquare selection;
    
    XtSetArg(args[0], XtNlabel, "White");
    whitePieceMenu = XtCreatePopupShell("menuW", simpleMenuWidgetClass,
					boardWidget, args, 1);
    for (i = 0; i < PIECE_MENU_SIZE; i++) {
	String item = pieceMenuStrings[i];
	
	if (strcmp(item, "----") == 0) {
	    entry = XtCreateManagedWidget(item, smeLineObjectClass,
					  whitePieceMenu, NULL, 0);
	} else {
	    entry = XtCreateManagedWidget(item, smeBSBObjectClass,
					  whitePieceMenu, NULL, 0);
	    selection = pieceMenuTranslation[0][i];
	    XtAddCallback(entry, XtNcallback,
			  (XtCallbackProc) PieceMenuSelect,
			  (caddr_t) selection);
	    if (selection == WhitePawn) {
		XtSetArg(args[0], XtNpopupOnEntry, entry);
		XtSetValues(whitePieceMenu, args, 1);
	    }
	}
    }
    
    XtSetArg(args[0], XtNlabel, "Black");
    blackPieceMenu = XtCreatePopupShell("menuB", simpleMenuWidgetClass,
					boardWidget, args, 1);
    for (i = 0; i < PIECE_MENU_SIZE; i++) {
	String item = pieceMenuStrings[i];
	
	if (strcmp(item, "----") == 0) {
	    entry = XtCreateManagedWidget(item, smeLineObjectClass,
					  blackPieceMenu, NULL, 0);
	} else {
	    entry = XtCreateManagedWidget(item, smeBSBObjectClass,
					  blackPieceMenu, NULL, 0);
	    selection = pieceMenuTranslation[1][i];
	    XtAddCallback(entry, XtNcallback,
			  (XtCallbackProc) PieceMenuSelect,
			  (caddr_t) selection);
	    if (selection == BlackPawn) {
		XtSetArg(args[0], XtNpopupOnEntry, entry);
		XtSetValues(blackPieceMenu, args, 1);
	    }
	}
    }
    
    XtRegisterGrabAction(PieceMenuPopup, True,
			 (unsigned)(ButtonPressMask|ButtonReleaseMask),
			 GrabModeAsync, GrabModeAsync);
}	

void PieceMenuPopup(w, event, params, num_params)
     Widget w;
     XEvent *event;
     String *params;
     Cardinal *num_params;
{
    if (event->type != ButtonPress) return;
    if (gameMode != EditPosition && gameMode != IcsExamining) return;
    
    if (((pmFromX = EventToSquare(event->xbutton.x)) < 0) ||
	((pmFromY = EventToSquare(event->xbutton.y)) < 0)) {
	pmFromX = pmFromY = -1;
	return;
    }
    if (flipView)
      pmFromX = BOARD_SIZE - 1 - pmFromX;
    else
      pmFromY = BOARD_SIZE - 1 - pmFromY;
    
    XtPopupSpringLoaded(XtNameToWidget(boardWidget, params[0]));
}

static void PieceMenuSelect(w, piece, junk)
     Widget w;
     ChessSquare piece;
     caddr_t junk;
{
    if (pmFromX < 0 || pmFromY < 0) return;
    EditPositionMenuEvent(piece, pmFromX, pmFromY);
}

void WhiteClock(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    if (gameMode == EditPosition) {
	SetWhiteToPlayEvent();
    } else if (gameMode == IcsPlayingBlack || gameMode == MachinePlaysWhite) {
	CallFlagEvent();
    }
}

void BlackClock(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    if (gameMode == EditPosition) {
	SetBlackToPlayEvent();
    } else if (gameMode == IcsPlayingWhite || gameMode == MachinePlaysBlack) {
	CallFlagEvent();
    }
}


/*
 * If the user selects on a border boundary, return -1; if off the board,
 *   return -2.  Otherwise map the event coordinate to the square.
 */
int EventToSquare(x)
     int x;
{
    if (x <= 0) 
      return -2;
    if (x < lineGap)
      return -1;
    x -= lineGap;
    if ((x % (squareSize + lineGap)) >= squareSize)
      return -1;
    x /= (squareSize + lineGap);
    if (x >= BOARD_SIZE)
      return -2;
    return x;
}

void DrawSquare(row, column, piece)
     int row, column;
     ChessSquare piece;
{
    int square_color, x, y, direction, font_ascent, font_descent;
    char string[2];
    XCharStruct overall;
    
    if (flipView) {
	x = lineGap + ((BOARD_SIZE-1)-column) * 
	  (squareSize + lineGap);
	y = lineGap + row * (squareSize + lineGap);
    } else {
	x = lineGap + column * (squareSize + lineGap);
	y = lineGap + ((BOARD_SIZE-1)-row) * 
	  (squareSize + lineGap);
    }
    
    square_color = ((column + row) % 2) == 1;
    
    if (piece == EmptySquare) {
	XFillRectangle(xDisplay, xBoardWindow,
		       square_color ? lightSquareGC : darkSquareGC,
		       x, y, squareSize, squareSize);
    } else if (appData.monoMode) {
	if (DefaultDepth(xDisplay, xScreen) == 1) {
	    /* Avoid XCopyPlane on 1-bit screens to work around Sun bug */
	    if (square_color)
	      XCopyArea(xDisplay, (int) piece < (int) BlackPawn
			 ? *pieceToOutline[(int) piece]
			 : *pieceToSolid[(int) piece],
			 xBoardWindow, bwPieceGC, 0, 0,
			 squareSize, squareSize, x, y);
	    else
	      XCopyArea(xDisplay, (int) piece < (int) BlackPawn
			 ? *pieceToSolid[(int) piece]
			 : *pieceToOutline[(int) piece],
			 xBoardWindow, wbPieceGC, 0, 0,
			 squareSize, squareSize, x, y);
	} else {
	    if (square_color)
	      XCopyPlane(xDisplay, (int) piece < (int) BlackPawn
			 ? *pieceToOutline[(int) piece]
			 : *pieceToSolid[(int) piece],
			 xBoardWindow, bwPieceGC, 0, 0,
			 squareSize, squareSize, x, y, 1);
	    else
	      XCopyPlane(xDisplay, (int) piece < (int) BlackPawn
			 ? *pieceToSolid[(int) piece]
			 : *pieceToOutline[(int) piece],
			 xBoardWindow, wbPieceGC, 0, 0,
			 squareSize, squareSize, x, y, 1);
	}
    } else {
	if (square_color)
	  XCopyPlane(xDisplay, *pieceToSolid[(int) piece],
		     xBoardWindow, (int) piece < (int) BlackPawn
		     ? wlPieceGC : blPieceGC, 0, 0,
		     squareSize, squareSize, x, y, 1);
	else
	  XCopyPlane(xDisplay, *pieceToSolid[(int) piece],
		     xBoardWindow, (int) piece < (int) BlackPawn
		     ? wdPieceGC : bdPieceGC, 0, 0,
		     squareSize, squareSize, x, y, 1);
    }
    string[1] = NULLCHAR;
    if (appData.showCoords && row == (flipView ? 7 : 0)) {
	string[0] = 'a' + column;
	XTextExtents(coordFontStruct, string, 1, &direction, 
		     &font_ascent, &font_descent, &overall);
	if (appData.monoMode) {
	    XDrawImageString(xDisplay, xBoardWindow, coordGC,
			     x + squareSize - overall.width - 2, 
			     y + squareSize - font_descent - 1, string, 1);
	} else {
	    XDrawString(xDisplay, xBoardWindow, coordGC,
			x + squareSize - overall.width - 2, 
			y + squareSize - font_descent - 1, string, 1);
	}
    }
    if (appData.showCoords && column == (flipView ? 7 : 0)) {
	string[0] = '1' + row;
	XTextExtents(coordFontStruct, string, 1, &direction, 
		     &font_ascent, &font_descent, &overall);
	if (appData.monoMode) {
	    XDrawImageString(xDisplay, xBoardWindow, coordGC,
			     x + 2, y + font_ascent + 1, string, 1);
	} else {
	    XDrawString(xDisplay, xBoardWindow, coordGC,
			x + 2, y + font_ascent + 1, string, 1);
	}	    
    }   
}

void EventProc(widget, unused, event)
     Widget widget;
     caddr_t unused;
     XEvent *event;
{
    if (event->type == MappingNotify) {
	XRefreshKeyboardMapping((XMappingEvent *) event);
	return;
    }
    
    if (!XtIsRealized(widget))
      return;
    
    if ((event->type == ButtonPress) || (event->type == ButtonRelease))
      if (event->xbutton.button != Button1)
	return;
    
    switch (event->type) {
      case Expose:
	DrawPositionProc(widget, event, NULL, NULL);
	break;
      default:
	return;
    }
}


void DrawPosition(fullRedraw, board)
     /*Boolean*/int fullRedraw;
     Board board;
{
    XDrawPosition(boardWidget, fullRedraw, board);
}

/*
 * event handler for redrawing the board
 */
void XDrawPosition(w, repaint, board)
     Widget w;
     /*Boolean*/int repaint;
     Board board;
{
    int i, j;
    static int lastFlipView = 0;
    static int lastBoardValid = 0;
    static Board lastBoard;
    Arg args[16];
    
    if (board == NULL) {
	if (!lastBoardValid) return;
	board = lastBoard;
    }

    /*
     * It would be simpler to clear the window with XClearWindow()
     * but this causes a very distracting flicker.
     */
    
    if (!repaint && lastBoardValid && lastFlipView == flipView) {
	for (i = 0; i < BOARD_SIZE; i++)
	  for (j = 0; j < BOARD_SIZE; j++)
	    if (board[i][j] != lastBoard[i][j])
	      DrawSquare(i, j, board[i][j]);
    } else {
	XDrawSegments(xDisplay, xBoardWindow, lineGC,
		      gridSegments, (BOARD_SIZE + 1) * 2);
	
	for (i = 0; i < BOARD_SIZE; i++)
	  for (j = 0; j < BOARD_SIZE; j++)
	    DrawSquare(i, j, board[i][j]);
    }
    
    if (!lastBoardValid || lastFlipView != flipView) {
	XtSetArg(args[0], XtNleftBitmap, (flipView ? xMarkPixmap : None));
	XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Flip View"),
		    args, 1);
    }

    CopyBoard(lastBoard, board);
    lastBoardValid = 1;
    lastFlipView = flipView;
    
    XSync(xDisplay, False);
}

/*
 * event handler for redrawing the board
 */
void DrawPositionProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    XDrawPosition(w, True, NULL);
}


/*
 * event handler for parsing user moves
 */
void HandleUserMove(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    int x, y;
    
    if (w != boardWidget)
      return;
    
    if (promotionUp) {
	XtPopdown(promotionShell);
	XtDestroyWidget(promotionShell);
	promotionUp = False;
	fromX = fromY = -1;
    }
    
    x = EventToSquare(event->xbutton.x);
    y = EventToSquare(event->xbutton.y);
    if (!flipView && y >= 0) {
	y = BOARD_SIZE - 1 - y;
    }
    if (flipView && x >= 0) {
	x = BOARD_SIZE - 1 - x;
    }

    switch (event->type) {
      case ButtonPress:
	if (errorExitStatus != -1) return;
	if (errorUp) ErrorPopDown();
	if (OKToStartUserMove(x, y)) {
	    fromX = x;
	    fromY = y;
	} else {
	    fromX = fromY = -1;
	}
	break;

      case ButtonRelease:
	toX = x;
	toY = y;
	if (IsPromotion(fromX, fromY, toX, toY)) {
	    if (appData.alwaysPromoteToQueen) {
		UserMoveEvent(fromX, fromY, toX, toY, 'q');
		fromX = fromY = -1;
	    } else {
		PromotionPopUp();
	    }
	} else {
	    UserMoveEvent(fromX, fromY, toX, toY, NULLCHAR);
	    fromX = fromY = -1;
	}
	break;
    }

}

Widget CommentCreate(name, text, mutable, callback)
     char *name, *text;
     int /*Boolean*/ mutable;
     XtCallbackProc callback;
{
    Arg args[16];
    Widget shell, form, edit, b_ok, b_cancel, b_clear, b_close, b_edit;
    Dimension fw_width;
    int j;

    j = 0;
    XtSetArg(args[j], XtNwidth, &fw_width);  j++;
    XtGetValues(formWidget, args, j);

    j = 0;
    XtSetArg(args[j], XtNresizable, True);  j++;
#if TOPLEVEL
    shell =
      XtCreatePopupShell(name, topLevelShellWidgetClass,
			 shellWidget, args, j);
#else
    shell =
      XtCreatePopupShell(name, transientShellWidgetClass,
			 shellWidget, args, j);
#endif
    j = 0;
    form =
      XtCreateManagedWidget("form", formWidgetClass, shell, args, j);

    j = 0;
    if (mutable) {
	XtSetArg(args[j], XtNeditType, XawtextEdit);  j++;
	XtSetArg(args[j], XtNuseStringInPlace, False);  j++;
    }
    XtSetArg(args[j], XtNstring, text);  j++;
    XtSetArg(args[j], XtNtop, XtChainTop);  j++;
    XtSetArg(args[j], XtNbottom, XtChainBottom);  j++;
    XtSetArg(args[j], XtNleft, XtChainLeft);  j++;
    XtSetArg(args[j], XtNright, XtChainRight);  j++;
    XtSetArg(args[j], XtNresizable, True);  j++;
    XtSetArg(args[j], XtNwidth, fw_width);  j++;  /*force wider than buttons*/
    XtSetArg(args[j], XtNscrollVertical, XawtextScrollWhenNeeded);  j++;
    XtSetArg(args[j], XtNautoFill, True);  j++;
    edit =
      XtCreateManagedWidget("text", asciiTextWidgetClass, form, args, j);

    if (mutable) {
	j = 0;
	XtSetArg(args[j], XtNfromVert, edit);  j++;
	XtSetArg(args[j], XtNtop, XtChainBottom); j++;
	XtSetArg(args[j], XtNbottom, XtChainBottom); j++;
	XtSetArg(args[j], XtNleft, XtChainLeft); j++;
	XtSetArg(args[j], XtNright, XtChainLeft); j++;
	b_ok =
	  XtCreateManagedWidget("ok", commandWidgetClass, form, args, j);
	XtAddCallback(b_ok, XtNcallback, callback, (XtPointer) 0);

	j = 0;
	XtSetArg(args[j], XtNfromVert, edit);  j++;
	XtSetArg(args[j], XtNfromHoriz, b_ok);  j++;
	XtSetArg(args[j], XtNtop, XtChainBottom); j++;
	XtSetArg(args[j], XtNbottom, XtChainBottom); j++;
	XtSetArg(args[j], XtNleft, XtChainLeft); j++;
	XtSetArg(args[j], XtNright, XtChainLeft); j++;
	b_cancel =
	  XtCreateManagedWidget("cancel", commandWidgetClass, form, args, j);
	XtAddCallback(b_cancel, XtNcallback, callback, (XtPointer) 0);

	j = 0;
	XtSetArg(args[j], XtNfromVert, edit);  j++;
	XtSetArg(args[j], XtNfromHoriz, b_cancel);  j++;
	XtSetArg(args[j], XtNtop, XtChainBottom); j++;
	XtSetArg(args[j], XtNbottom, XtChainBottom); j++;
	XtSetArg(args[j], XtNleft, XtChainLeft); j++;
	XtSetArg(args[j], XtNright, XtChainLeft); j++;
	b_clear =
	  XtCreateManagedWidget("clear", commandWidgetClass, form, args, j);
	XtAddCallback(b_clear, XtNcallback, callback, (XtPointer) 0);
    } else {
	j = 0;
	XtSetArg(args[j], XtNfromVert, edit);  j++;
	XtSetArg(args[j], XtNtop, XtChainBottom); j++;
	XtSetArg(args[j], XtNbottom, XtChainBottom); j++;
	XtSetArg(args[j], XtNleft, XtChainLeft); j++;
	XtSetArg(args[j], XtNright, XtChainLeft); j++;
	b_close =
	  XtCreateManagedWidget("close", commandWidgetClass, form, args, j);
	XtAddCallback(b_close, XtNcallback, callback, (XtPointer) 0);

	j = 0;
	XtSetArg(args[j], XtNfromVert, edit);  j++;
	XtSetArg(args[j], XtNfromHoriz, b_close);  j++;
	XtSetArg(args[j], XtNtop, XtChainBottom); j++;
	XtSetArg(args[j], XtNbottom, XtChainBottom); j++;
	XtSetArg(args[j], XtNleft, XtChainLeft); j++;
	XtSetArg(args[j], XtNright, XtChainLeft); j++;
	b_edit =
	  XtCreateManagedWidget("edit", commandWidgetClass, form, args, j);
	XtAddCallback(b_edit, XtNcallback, callback, (XtPointer) 0);
    }

    if (commentX == -1) {
	Position y1, y2;
	int xx, yy;
	Window junk;

	j = 0;
	XtSetArg(args[j], XtNy, &y1); j++;
	XtGetValues(menuBarWidget, args, j);
	y1 -= appData.borderYoffset; /* offset by banner height */
	j = 0;
	XtSetArg(args[j], XtNy, &y2); j++;
	XtGetValues(messageWidget, args, j);
	commentW = fw_width - 16;
	commentH = y2 - y1;

	XSync(xDisplay, False);
#ifdef NOTDEF
	/* This code seems to tickle an X bug if it is executed too soon
	   after xboard starts up.  The coordinates get transformed as if
	   the main window was positioned at (0, 0).
	*/
	XtTranslateCoords(shellWidget, (fw_width - commentW) / 2, y1,
			  &commentX, &commentY);
#else /*!NOTDEF*/
        XTranslateCoordinates(xDisplay, XtWindow(shellWidget),
			      RootWindowOfScreen(XtScreen(shellWidget)),
			      (fw_width - commentW) / 2, y1,
			      &xx, &yy, &junk);
	commentX = xx;
	commentY = yy;
#endif /*!NOTDEF*/
    }
    j = 0;
    XtSetArg(args[j], XtNheight, commentH);  j++;
    XtSetArg(args[j], XtNwidth, commentW);  j++;
    XtSetArg(args[j], XtNx, commentX - appData.borderXoffset);  j++;
    XtSetArg(args[j], XtNy, commentY - appData.borderYoffset);  j++;
    XtSetValues(shell, args, j);

    XtRealizeWidget(shell);

    return shell;
}

static int savedIndex;  /* gross that this is global */

void EditCommentPopUp(index, title, text)
     int index;
     char *title, *text;
{
    Widget edit;
    Arg args[16];
    int j;

    savedIndex = index;
    if (text == NULL) text = "";

    if (editShell == NULL) {
	editShell =
	  CommentCreate(title, text, True, EditCommentCallback); 
    } else {
	edit = XtNameToWidget(editShell, "form.text");
	j = 0;
	XtSetArg(args[j], XtNstring, text); j++;
	XtSetValues(edit, args, j);
	j = 0;
	XtSetArg(args[j], XtNiconName, (XtArgVal) title);   j++;
	XtSetArg(args[j], XtNtitle, (XtArgVal) title);      j++;
	XtSetValues(editShell, args, j);
    }

    XtPopup(editShell, XtGrabNone);
    XtSetKeyboardFocus(shellWidget, editShell);

    editUp = True;
    j = 0;
    XtSetArg(args[j], XtNleftBitmap, xMarkPixmap); j++;
    XtSetValues(XtNameToWidget(menuBarWidget, "menuMode.Edit Comment"),
		args, j);
}

void EditCommentCallback(w, client_data, call_data)
     Widget w;
     XtPointer client_data, call_data;
{
    String name, val;
    Arg args[16];
    int j;
    Widget edit;

    j = 0;
    XtSetArg(args[j], XtNlabel, &name);  j++;
    XtGetValues(w, args, j);

    if (strcmp(name, "ok") == 0) {
	edit = XtNameToWidget(editShell, "form.text");
	j = 0;
	XtSetArg(args[j], XtNstring, &val); j++;
	XtGetValues(edit, args, j);
	ReplaceComment(savedIndex, val);
	EditCommentPopDown();
    } else if (strcmp(name, "cancel") == 0) {
	EditCommentPopDown();
    } else if (strcmp(name, "clear") == 0) {
	edit = XtNameToWidget(editShell, "form.text");
	XtCallActionProc(edit, "select-all", NULL, NULL, 0);
	XtCallActionProc(edit, "kill-selection", NULL, NULL, 0);
    }
}

void EditCommentPopDown()
{
    Arg args[16];
    int j;

    if (!editUp) return;
    j = 0;
    XtSetArg(args[j], XtNx, &commentX); j++;
    XtSetArg(args[j], XtNy, &commentY); j++;
    XtSetArg(args[j], XtNheight, &commentH); j++;
    XtSetArg(args[j], XtNwidth, &commentW); j++;
    XtGetValues(editShell, args, j);
    XtPopdown(editShell);
    XtSetKeyboardFocus(shellWidget, formWidget);
    editUp = False;
    j = 0;
    XtSetArg(args[j], XtNleftBitmap, None); j++;
    XtSetValues(XtNameToWidget(menuBarWidget, "menuMode.Edit Comment"),
		args, j);
}

void CommentPopUp(title, text)
     char *title, *text;
{
    Arg args[16];
    int j;
    Widget edit;

    if (commentShell == NULL) {
	commentShell =
	  CommentCreate(title, text, False, CommentCallback);
    } else {
	edit = XtNameToWidget(commentShell, "form.text");
	j = 0;
	XtSetArg(args[j], XtNstring, text); j++;
	XtSetValues(edit, args, j);
	j = 0;
	XtSetArg(args[j], XtNiconName, (XtArgVal) title);   j++;
	XtSetArg(args[j], XtNtitle, (XtArgVal) title);      j++;
	XtSetValues(commentShell, args, j);
    }

    XtPopup(commentShell, XtGrabNone);
    XSync(xDisplay, False);

    commentUp = True;
}

void CommentCallback(w, client_data, call_data)
     Widget w;
     XtPointer client_data, call_data;
{
    String name;
    Arg args[16];
    int j;

    j = 0;
    XtSetArg(args[j], XtNlabel, &name);  j++;
    XtGetValues(w, args, j);

    if (strcmp(name, "close") == 0) {
	CommentPopDown();
    } else if (strcmp(name, "edit") == 0) {
	CommentPopDown();
	EditCommentEvent();
    }
}


void CommentPopDown()
{
    Arg args[16];
    int j;

    if (!commentUp) return;
    j = 0;
    XtSetArg(args[j], XtNx, &commentX); j++;
    XtSetArg(args[j], XtNy, &commentY); j++;
    XtSetArg(args[j], XtNwidth, &commentW); j++;
    XtSetArg(args[j], XtNheight, &commentH); j++;
    XtGetValues(commentShell, args, j);
    XtPopdown(commentShell);
    XSync(xDisplay, False);
    commentUp = False;
}


void FileNamePopUp(label, def, proc, openMode)
     char *label;
     char *def;
     FileProc proc;
     char *openMode;
{
    Arg args[16];
    Widget popup, dialog;
    Window root, child;
    int x, y;
    int win_x, win_y;
    unsigned int mask;
    
    fileProc = proc;          /* I can't see a way not */
    fileOpenMode = openMode;  /*   to use globals here */
    
    XtSetArg(args[0], XtNresizable, True);
    XtSetArg(args[1], XtNwidth, DIALOG_SIZE);
    
    popup =
      XtCreatePopupShell("File Name Prompt", transientShellWidgetClass,
			 shellWidget, args, 2);
    
    XtSetArg(args[0], XtNlabel, label);
    XtSetArg(args[1], XtNvalue, def);
    
    dialog = XtCreateManagedWidget("dialog", dialogWidgetClass,
				   popup, args, 2);
    
    XawDialogAddButton(dialog, "ok", FileNameCallback, (XtPointer) dialog);
    XawDialogAddButton(dialog, "cancel", FileNameCallback,
		       (XtPointer) dialog);
    
    XtRealizeWidget(popup);
    
    XQueryPointer(xDisplay, xBoardWindow, &root, &child,
		  &x, &y, &win_x, &win_y, &mask);
    
    XtSetArg(args[0], XtNx, x - 10);
    XtSetArg(args[1], XtNy, y - 10);
    XtSetValues(popup, args, 2);
    
    XtPopup(popup, XtGrabExclusive);
    filenameUp = True;
    
    XtSetKeyboardFocus(shellWidget, popup);
}

void FileNameCallback(w, client_data, call_data)
     Widget w;
     XtPointer client_data, call_data;
{
    String name;
    Arg args[16];
    
    XtSetArg(args[0], XtNlabel, &name);
    XtGetValues(w, args, 1);
    
    if (strcmp(name, "cancel") == 0) {
	XtPopdown(w = XtParent(XtParent(w)));
	XtDestroyWidget(w);
	filenameUp = False;
	ModeHighlight();
	return;
    }
    
    FileNameAction(w, NULL, NULL, NULL);
}

void FileNameAction(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    char buf[MSG_SIZ];
    String name;
    FILE *f;
    char *p;
    int index;

    name = XawDialogGetValueString(w = XtParent(w));
    
    if ((name != NULL) && (*name != NULLCHAR)) {
	strcpy(buf, name);
	XtPopdown(w = XtParent(w));
	XtDestroyWidget(w);
	filenameUp = False;

	p = strrchr(buf, ' ');
	if (p == NULL) {
	    index = 0;
	} else {
	    *p++ = NULLCHAR;
	    index = atoi(p);
	}
	f = fopen(buf, fileOpenMode);
	if (f == NULL) {
	    DisplayError("Failed to open file", errno);
	} else {
	    (void) (*fileProc)(f, index, buf);
	}
	ModeHighlight();
	XtSetKeyboardFocus(shellWidget, formWidget);
	return;
    }
    
    XtPopdown(w = XtParent(w));
    XtDestroyWidget(w);
    filenameUp = False;
    ModeHighlight();
    XtSetKeyboardFocus(shellWidget, formWidget);
}

void PromotionPopUp()
{
    Arg args[16];
    Widget dialog;
    Position x, y;
    Dimension bw_width, pw_width;
    int j;

    j = 0;
    XtSetArg(args[j], XtNwidth, &bw_width); j++;
    XtGetValues(boardWidget, args, j);
    
    j = 0;
    XtSetArg(args[j], XtNresizable, True); j++;
    promotionShell =
      XtCreatePopupShell("Promotion", transientShellWidgetClass,
			 shellWidget, args, j);
    
    j = 0;
    XtSetArg(args[j], XtNlabel, "Promote pawn to what?"); j++;
    dialog = XtCreateManagedWidget("promotion", dialogWidgetClass,
				   promotionShell, args, j);
    
    XawDialogAddButton(dialog, "Queen", PromotionCallback, 
		       (XtPointer) dialog);
    XawDialogAddButton(dialog, "Rook", PromotionCallback, 
		       (XtPointer) dialog);
    XawDialogAddButton(dialog, "Bishop", PromotionCallback, 
		       (XtPointer) dialog);
    XawDialogAddButton(dialog, "Knight", PromotionCallback, 
		       (XtPointer) dialog);
    XawDialogAddButton(dialog, "cancel", PromotionCallback, 
		       (XtPointer) dialog);
    
    XtRealizeWidget(promotionShell);
    
    j = 0;
    XtSetArg(args[j], XtNwidth, &pw_width); j++;
    XtGetValues(promotionShell, args, j);
    
    XtTranslateCoords(boardWidget, (bw_width - pw_width) / 2,
		      lineGap + squareSize/3 +
		      ((toY == 7) ^ (flipView) ?
		       0 : 6*(squareSize + lineGap)), &x, &y);
    
    j = 0;
    XtSetArg(args[j], XtNx, x); j++;
    XtSetArg(args[j], XtNy, y); j++;
    XtSetValues(promotionShell, args, j);
    
    XtPopup(promotionShell, XtGrabNone);
    
    promotionUp = True;
}

void PromotionCallback(w, client_data, call_data)
     Widget w;
     XtPointer client_data, call_data;
{
    String name;
    Arg args[16];
    int promoChar;
    
    XtSetArg(args[0], XtNlabel, &name);
    XtGetValues(w, args, 1);
    
    XtPopdown(w = XtParent(XtParent(w)));
    XtDestroyWidget(w);
    promotionUp = False;
    
    if (fromX == -1) return;
    
    if (strcmp(name, "cancel") == 0) {
	fromX = fromY = -1;
	return;
    } else if (strcmp(name, "Knight") == 0) {
	promoChar = 'n';
    } else {
	promoChar = ToLower(name[0]);
    }

    UserMoveEvent(fromX, fromY, toX, toY, promoChar);
}


void ErrorCallback(w, client_data, call_data)
     Widget w;
     XtPointer client_data, call_data;
{
    errorUp = False;
    XtPopdown(w = XtParent(XtParent(w)));
    XtDestroyWidget(w);
    if (errorExitStatus != -1) ExitEvent(errorExitStatus);
}


void ErrorPopDown()
{
    if (!errorUp) return;
    errorUp = False;
    XtPopdown(errorShell);
    XtDestroyWidget(errorShell);
}

void ErrorPopUp(title, label)
     char *title, *label;
{
    Arg args[16];
    Widget dialog;
    Position x, y;
    int xx, yy;
    Window junk;
    Dimension bw_width, pw_width;
    Dimension pw_height;
    int i;
    
    i = 0;
    XtSetArg(args[i], XtNresizable, True);  i++;
    errorShell = 
      XtCreatePopupShell(title, transientShellWidgetClass,
			 shellWidget, args, i);
    
    i = 0;
    XtSetArg(args[i], XtNlabel, label);  i++;
    dialog = XtCreateManagedWidget("dialog", dialogWidgetClass,
				   errorShell, args, i);
    
    XawDialogAddButton(dialog, "ok", ErrorCallback, (XtPointer) dialog);
    
    XtRealizeWidget(errorShell);
    
    i = 0;
    XtSetArg(args[i], XtNwidth, &bw_width);  i++;
    XtGetValues(boardWidget, args, i);
    i = 0;
    XtSetArg(args[i], XtNwidth, &pw_width);  i++;
    XtSetArg(args[i], XtNheight, &pw_height);  i++;
    XtGetValues(errorShell, args, i);

#ifdef NOTDEF
    /* This code seems to tickle an X bug if it is executed too soon
       after xboard starts up.  The coordinates get transformed as if
       the main window was positioned at (0, 0).
    */
    XtTranslateCoords(boardWidget, (bw_width - pw_width) / 2,
		      0 - pw_height - appData.borderYoffset
		      + squareSize / 3, &x, &y);
#else
    XTranslateCoordinates(xDisplay, XtWindow(boardWidget),
			  RootWindowOfScreen(XtScreen(boardWidget)),
			  (bw_width - pw_width) / 2,
			  0 - pw_height - appData.borderYoffset
			  + squareSize / 3, &xx, &yy, &junk);
    x = xx;
    y = yy;
#endif

    i = 0;
    XtSetArg(args[i], XtNx, x);  i++;
    XtSetArg(args[i], XtNy, y);  i++;
    XtSetValues(errorShell, args, i);

    errorUp = True;
    XtPopup(errorShell, XtGrabNone);
}


char *ModeToWidgetName(mode)
     GameMode mode;
{
    switch (mode) {
      case BeginningOfGame:
	if (appData.icsActive)
	  return "menuMode.ICS Client";
	else if (appData.noChessProgram ||
		 *appData.cmailGameName != NULLCHAR)
	  return "menuMode.Edit Game";
	else
	  return "menuMode.Machine Black";
      case MachinePlaysBlack:
	return "menuMode.Machine Black";
      case MachinePlaysWhite:
	return "menuMode.Machine White";
      case TwoMachinesPlay:
	return "menuMode.Two Machines";
      case EditGame:
	return "menuMode.Edit Game";
      case PlayFromGameFile:
	return "menuFile.Load Game";
      case EditPosition:
	return "menuMode.Edit Position";
      case IcsPlayingWhite:
      case IcsPlayingBlack:
      case IcsObserving:
      case IcsIdle:
      case IcsExamining:
	return "menuMode.ICS Client";
      default:
      case EndOfGame:
	return NULL;
    }
}     

void ModeHighlight()
{
    Arg args[16];
    static int oldPausing = FALSE;
    static GameMode oldmode = (GameMode) -1;
    char *wname;
    
    if (pausing != oldPausing) {
	oldPausing = pausing;
	if (pausing) {
	    XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
	} else {
	    XtSetArg(args[0], XtNleftBitmap, None);
	}
	XtSetValues(XtNameToWidget(menuBarWidget, "menuMode.Pause"),
		    args, 1);

	if (pausing) {
	    XtSetArg(args[0], XtNbackground, buttonForegroundPixel);
	    XtSetArg(args[1], XtNforeground, buttonBackgroundPixel);
	} else {
	    XtSetArg(args[0], XtNbackground, buttonBackgroundPixel);
	    XtSetArg(args[1], XtNforeground, buttonForegroundPixel);
	}
	XtSetValues(XtNameToWidget(buttonBarWidget, PAUSE_BUTTON), args, 2);
    }

    wname = ModeToWidgetName(oldmode);
    if (wname != NULL) {
	XtSetArg(args[0], XtNleftBitmap, None);
	XtSetValues(XtNameToWidget(menuBarWidget, wname), args, 1);
    }
    wname = ModeToWidgetName(gameMode);
    if (wname != NULL) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
	XtSetValues(XtNameToWidget(menuBarWidget, wname), args, 1);
    }
    oldmode = gameMode;
}


/*
 * Button/menu procedures
 */
void ResetProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ResetGameEvent();
}

int LoadGamePopUp(f, gameNumber, title)
     FILE *f;
     int gameNumber;
     char *title;
{
    cmailMsgLoaded = FALSE;
    if (gameNumber == 0) {
	int error = GameListBuild(f);
	if (error) {
	    DisplayError("Cannot build game list", error);
	} else if (!ListEmpty(&gameList) &&
		   ((ListGame *) gameList.tailPred)->number > 1) {
	    GameListPopUp(f, title);
	    return TRUE;
	}
	GameListDestroy();
	gameNumber = 1;
    }
    return LoadGame(f, gameNumber, title, FALSE);
}

void LoadGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    FileNamePopUp("Load game file name?", "", LoadGamePopUp, "r");
}

void LoadNextGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ReloadGame(1);
}

void LoadPrevGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ReloadGame(-1);
}

void ReloadGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ReloadGame(0);
}

void LoadPositionProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    FileNamePopUp("Load position file name?", "", LoadPosition, "r");
}

void SaveGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    FileNamePopUp("Save game file name?",
		  DefaultFileName(appData.oldSaveStyle ? "game" : "pgn"),
		  SaveGame, "a");
}

void SavePositionProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    FileNamePopUp("Save position file name?",
		  DefaultFileName(appData.oldSaveStyle ? "pos" : "fen"),
		  SavePosition, "a");
}

void ReloadCmailMsgProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ReloadCmailMsgEvent(FALSE);
}

void MailMoveProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    MailMoveEvent();
}

void AutoSaveGame()
{
    SaveGameProc(NULL, NULL, NULL, NULL);
}


void QuitProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ExitEvent(0);
}

void PauseProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    PauseEvent();
}


void MachineBlackProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    MachineBlackEvent();
}

void MachineWhiteProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    MachineWhiteEvent();
}


void TwoMachinesProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    TwoMachinesEvent();
}

void IcsClientProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    IcsClientEvent();
}

void EditGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    EditGameEvent();
}

void EditPositionProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    EditPositionEvent();
}

void EditCommentProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    if (editUp) {
	EditCommentPopDown();
    } else {
	EditCommentEvent();
    }
}

void AcceptProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    AcceptEvent();
}

void DeclineProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    DeclineEvent();
}

void CallFlagProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    CallFlagEvent();
}

void DrawProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    DrawEvent();
}

void AbortProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    AbortEvent();
}

void AdjournProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    AdjournEvent();
}

void ResignProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ResignEvent();
}

void StopObservingProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    StopObservingEvent();
}

void StopExaminingProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    StopExaminingEvent();
}


void ForwardProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ForwardEvent();
}


void BackwardProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    BackwardEvent();
}

void ToStartProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ToStartEvent();
}

void ToEndProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    ToEndEvent();
}

void RevertProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    RevertEvent();
}

void TruncateGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    TruncateGameEvent();
}
void RetractMoveProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    RetractMoveEvent();
}

void MoveNowProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    MoveNowEvent();
}


void AlwaysQueenProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.alwaysPromoteToQueen = !appData.alwaysPromoteToQueen;

    if (appData.alwaysPromoteToQueen) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Always Queen"),
		args, 1);
}

void AutocommProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.autoComment = !appData.autoComment;

    if (appData.autoComment) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Comment"),
		args, 1);
}


void AutoflagProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.autoCallFlag = !appData.autoCallFlag;

    if (appData.autoCallFlag) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Flag"),
		args, 1);
}

void AutobsProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.autoObserve = !appData.autoObserve;

    if (appData.autoObserve) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Observe"),
		args, 1);
}

void AutosaveProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.autoSaveGames = !appData.autoSaveGames;

    if (appData.autoSaveGames) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Auto Save"),
		args, 1);
}

void BellProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.ringBellAfterMoves = !appData.ringBellAfterMoves;

    if (appData.ringBellAfterMoves) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Bell"),
		args, 1);
}


void FlipViewProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    flipView = !flipView;
    DrawPosition(True, NULL);
}

void OldSaveStyleProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.oldSaveStyle = !appData.oldSaveStyle;

    if (appData.oldSaveStyle) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Old Save Style"),
		args, 1);
}

void QuietPlayProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.quietPlay = !appData.quietPlay;

    if (appData.quietPlay) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Quiet Play"),
		args, 1);
}

void ShowCoordsProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    appData.showCoords = !appData.showCoords;

    if (appData.showCoords) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Show Coords"),
		args, 1);

    DrawPosition(True, NULL);
}

void ShowThinkingProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];

    ShowThinkingEvent(!appData.showThinking);

    if (appData.showThinking) {
	XtSetArg(args[0], XtNleftBitmap, xMarkPixmap);
    } else {
	XtSetArg(args[0], XtNleftBitmap, None);
    }
    XtSetValues(XtNameToWidget(menuBarWidget, "menuOptions.Show Thinking"),
		args, 1);
}


void AboutProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    char buf[MSG_SIZ];

    sprintf(buf, "%s version %s, patchlevel %s\n\n%s\n%s\n\n%s\n%s",
	    PRODUCT, VERSION, PATCHLEVEL,
	    "Copyright 1991 Digital Equipment Corporation",
	    "Enhancements Copyright 1992-95 Free Software Foundation",
	    "This program is free software and carries NO WARRANTY;",
	    "see the file COPYING for more information.");
    ErrorPopUp("About XBoard", buf);
}

void HintProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    HintEvent();
}

void BookProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    BookEvent();
}

void AboutGameProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    AboutGameEvent();
}

void NothingProc(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    return;
}

void Iconify(w, event, prms, nprms)
     Widget w;
     XEvent *event;
     String *prms;
     Cardinal *nprms;
{
    Arg args[16];
    
    fromX = fromY = -1;
    
    XtSetArg(args[0], XtNiconic, False);
    XtSetValues(shellWidget, args, 1);
    XtSetArg(args[0], XtNiconic, True);
    XtSetValues(shellWidget, args, 1);
}

void DisplayMessage(message, extMessage)
     char *message, *extMessage;
{
    char buf[MSG_SIZ];
    Arg arg;
    
    if (extMessage) {
	if (*message) {
	    sprintf(buf, "%s  %s", message, extMessage);
	    message = buf;
	} else {
	    message = extMessage;
	}
    }
    XtSetArg(arg, XtNlabel, message);
    XtSetValues(messageWidget, &arg, 1);
}

void DisplayTitle(text)
     char *text;
{
    Arg args[16];
    int i;
    char title[MSG_SIZ];
    char *icon;

    if (text == NULL) text = "";

    if (appData.titleInWindow) {
	i = 0;
	XtSetArg(args[i], XtNlabel, text);   i++;
	XtSetValues(titleWidget, args, i);
    }

    if (*text != NULLCHAR) {
	icon = text;
	sprintf(title, "%s: %s", programName, icon);
    } else if (appData.icsActive) {
	icon = appData.icsHost;
	sprintf(title, "%s: %s", programName, icon);
    } else if (appData.cmailGameName[0] != NULLCHAR) {
	icon = "CMail";
	sprintf(title, "%s: %s", programName, icon);
    } else if (appData.noChessProgram) {
	icon = programName;
	sprintf(title, "%s", programName);
    } else {
	if (StrStr(appData.firstChessProgram, "gnuchess")) {
	    icon = "GNU Chess";
	    sprintf(title, "%s: %s", programName, icon);
	} else {
	    icon = strrchr(appData.firstChessProgram, '/');
	    if (icon == NULL)
	      icon = appData.firstChessProgram;
	    else
	      icon++;
	    sprintf(title, "%s: %s", programName, icon);
	}
    }
    i = 0;
    XtSetArg(args[i], XtNiconName, (XtArgVal) icon);    i++;
    XtSetArg(args[i], XtNtitle, (XtArgVal) title);      i++;
    XtSetValues(shellWidget, args, i);
}


void DisplayError(message, error)
     String message;
     int error;
{
    extern char *sys_errlist[];
    char buf[MSG_SIZ];

    if (error == 0) {
	if (appData.debugMode || appData.matchMode) {
	    fprintf(stderr, "%s: %s\n", programName, message);
	}
	ErrorPopUp("Error", message);
    } else {
	if (appData.debugMode || appData.matchMode) {
	    fprintf(stderr, "%s: %s: %s\n",
		    programName, message, sys_errlist[error]);
	}
	sprintf(buf, "%s: %s", message, sys_errlist[error]);
	ErrorPopUp("Error", buf);
    }	
}


void DisplayFatalError(message, error, status)
     String message;
     int error, status;
{
    extern char *sys_errlist[];
    char buf[MSG_SIZ];

    errorExitStatus = status;
    if (errorExitStatus != -1) {
	XtSetSensitive(menuBarWidget, False);
	XtSetSensitive(buttonBarWidget, False);
	XtUninstallTranslations(formWidget);
	XtUninstallTranslations(boardWidget);
	XtUninstallTranslations(whiteTimerWidget);
	XtUninstallTranslations(blackTimerWidget);
    }
    if (error == 0) {
	fprintf(stderr, "%s: %s\n", programName, message);
	ErrorPopUp("Fatal Error", message);
    } else {
	fprintf(stderr, "%s: %s: %s\n",
		programName, message, sys_errlist[error]);
	sprintf(buf, "%s: %s", message, sys_errlist[error]);
	ErrorPopUp("Fatal Error", buf);
    }
}


void DisplayInformation(message)
     String message;
{
    ErrorPopDown();
    ErrorPopUp("Information", message);
}

void RingBell()
{
    putc(BELLCHAR, stderr);
}

void EchoOn()
{
    system("stty echo\n");
}

void EchoOff()
{
    system("stty -echo\n");
}

char *UserName()
{
    return getpwuid(getuid())->pw_name;
}

char *HostName()
{
    static char host_name[MSG_SIZ];
    
#if HAVE_GETHOSTNAME
    gethostname(host_name, MSG_SIZ);
    return host_name;
#else /* not HAVE_GETHOSTNAME */
# if HAVE_SYSINFO && HAVE_SYS_SYSTEMINFO_H
    sysinfo(SI_HOSTNAME, host_name, MSG_SIZ);
    return host_name;
# else /* not (HAVE_SYSINFO && HAVE_SYS_SYSTEMINFO_H) */
    return "localhost";
# endif /* not (HAVE_SYSINFO && HAVE_SYS_SYSTEMINFO_H) */
#endif /* not HAVE_GETHOSTNAME */
}

XtIntervalId loadGameTimerXID = 0;

int LoadGameTimerRunning()
{
    return loadGameTimerXID != 0;
}

int StopLoadGameTimer()
{
    if (loadGameTimerXID != 0) {
	XtRemoveTimeOut(loadGameTimerXID);
	loadGameTimerXID = 0;
	return TRUE;
    } else {
	return FALSE;
    }
}

void LoadGameTimerCallback(arg, id)
     XtPointer arg;
     XtIntervalId *id;
{
    loadGameTimerXID = 0;
    LoadGameLoop();
}

void StartLoadGameTimer(millisec)
     long millisec;
{
    loadGameTimerXID =
      XtAppAddTimeOut(appContext, millisec,
		      (XtTimerCallbackProc) LoadGameTimerCallback,
		      (XtPointer) 0);
}

XtIntervalId clockTimerXID = 0;

int ClockTimerRunning()
{
    return clockTimerXID != 0;
}

int StopClockTimer()
{
    if (clockTimerXID != 0) {
	XtRemoveTimeOut(clockTimerXID);
	clockTimerXID = 0;
	return TRUE;
    } else {
	return FALSE;
    }
}

void ClockTimerCallback(arg, id)
     XtPointer arg;
     XtIntervalId *id;
{
    clockTimerXID = 0;
    DecrementClocks();
}

void StartClockTimer(millisec)
     long millisec;
{
    clockTimerXID =
      XtAppAddTimeOut(appContext, millisec,
		      (XtTimerCallbackProc) ClockTimerCallback,
		      (XtPointer) 0);
}

void DisplayTimerLabel(w, color, timer, highlight)
     Widget w;
     char *color;
     long timer;
     int highlight;
{
    char buf[MSG_SIZ];
    Arg args[16];
    
    if (appData.clockMode) {
	sprintf(buf, "%s: %s", color, TimeString(timer));
	XtSetArg(args[0], XtNlabel, buf);
    } else {
	sprintf(buf, "%s  ", color);
	XtSetArg(args[0], XtNlabel, buf);
    }
    
    if (highlight) {
	XtSetArg(args[1], XtNbackground, timerForegroundPixel);
	XtSetArg(args[2], XtNforeground, timerBackgroundPixel);
    } else {
	XtSetArg(args[1], XtNbackground, timerBackgroundPixel);
	XtSetArg(args[2], XtNforeground, timerForegroundPixel);
    }
    
    XtSetValues(w, args, 3);
}

void DisplayWhiteClock(timeRemaining, highlight)
     long timeRemaining;
     int highlight;
{
    Arg args[16];
    DisplayTimerLabel(whiteTimerWidget, "White", timeRemaining, highlight);
    if (highlight && iconPixmap == bIconPixmap) {
	iconPixmap = wIconPixmap;
	XtSetArg(args[0], XtNiconPixmap, iconPixmap);
	XtSetValues(shellWidget, args, 1);
    }
}

void DisplayBlackClock(timeRemaining, highlight)
     long timeRemaining;
     int highlight;
{
    Arg args[16];
    DisplayTimerLabel(blackTimerWidget, "Black", timeRemaining, highlight);
    if (highlight && iconPixmap == wIconPixmap) {
	iconPixmap = bIconPixmap;
	XtSetArg(args[0], XtNiconPixmap, iconPixmap);
	XtSetValues(shellWidget, args, 1);
    }
}

#define CPReal 1
#define CPComm 2
#define CPSock 3
#define CPLoop 4
typedef int CPKind;

typedef struct {
    CPKind kind;
    int pid;
    int fdTo, fdFrom;  
} ChildProc;


int StartChildProcess(cmdLine, pr)
     char *cmdLine; 
     ProcRef *pr;
{
    char *argv[64], *p;
    int i, pid;
    int to_prog[2], from_prog[2];
    ChildProc *cp;
    
    /* We do NOT feed the cmdLine to the shell; we just
       parse it into blank-separated arguments in the
       most simple-minded way possible.
    */
    i = 0;
    p = cmdLine;
    for (;;) {
	argv[i++] = p;
	p = strchr(p, ' ');
	if (p == NULL) break;
	*p++ = NULLCHAR;
    }
    argv[i] = NULL;

    SetUpChildIO(to_prog, from_prog);

    if ((pid = fork()) == 0) {
	/* Child process */
	dup2(to_prog[0], 0);
	dup2(from_prog[1], 1);
	close(to_prog[0]);
	close(to_prog[1]);
	close(from_prog[0]);
	close(from_prog[1]);
	dup2(1, fileno(stderr)); /* force stderr to the pipe */

        execvp(argv[0], argv);
	
	perror(argv[0]);
	exit(1);
    }
    
    /* Parent process */
    close(to_prog[0]);
    close(from_prog[1]);
    
    cp = (ChildProc *) calloc(1, sizeof(ChildProc));
    cp->kind = CPReal;
    cp->pid = pid;
    cp->fdFrom = from_prog[0];
    cp->fdTo = to_prog[1];
    *pr = (ProcRef) cp;
    return 0;
}

void DestroyChildProcess(pr)
     ProcRef pr;
{
    ChildProc *cp = (ChildProc *) pr;

    if (cp->kind != CPReal) return;
    if (kill(cp->pid, SIGTERM) == 0)
      wait((int *) 0);
    close(cp->fdFrom);
    close(cp->fdTo);
}

void InterruptChildProcess(pr)
     ProcRef pr;
{
    ChildProc *cp = (ChildProc *) pr;

    if (cp->kind != CPReal) return;
    (void) kill(cp->pid, SIGINT); /* stop it thinking */
}

int OpenTelnet(host, port, pr)
     char *host;
     char *port;
     ProcRef *pr;
{
    char cmdLine[MSG_SIZ];

    if (port[0] == NULLCHAR) {
	sprintf(cmdLine, "%s %s", appData.telnetProgram, host);
    } else {
	sprintf(cmdLine, "%s %s %s", appData.telnetProgram, host, port);
    }
    return StartChildProcess(cmdLine, pr);
}

int OpenTCP(host, port, pr)
     char *host;
     char *port;
     ProcRef *pr;
{
#if OMIT_SOCKETS
    DisplayFatalError("Socket support is not configured in", 0, 2);
#else /* !OMIT_SOCKETS */
    int s;
    struct sockaddr_in sa;
    struct hostent     *hp;
    unsigned short uport;
    ChildProc *cp;

    if ((s = socket(AF_INET, SOCK_STREAM, 6)) < 0) {
	return errno;
    }

    memset((char *) &sa, (int)0, sizeof(struct sockaddr_in));
    sa.sin_family = AF_INET;
    sa.sin_addr.s_addr = INADDR_ANY;
    uport = (unsigned short) 0;
    sa.sin_port = htons(uport);
    if (bind(s, (struct sockaddr *) &sa, sizeof(struct sockaddr_in)) < 0) {
	return errno;
    }

    memset((char *) &sa, (int)0, sizeof(struct sockaddr_in));
    if (!(hp = gethostbyname(host))) {
	int b0, b1, b2, b3;
	if (sscanf(host, "%d.%d.%d.%d", &b0, &b1, &b2, &b3) == 4) {
	    hp = (struct hostent *) calloc(1, sizeof(struct hostent));
	    hp->h_addrtype = AF_INET;
	    hp->h_length = 4;
	    hp->h_addr_list = (char **) calloc(2, sizeof(char *));
	    hp->h_addr_list[0] = (char *) malloc(4);
	    hp->h_addr_list[0][0] = b0;
	    hp->h_addr_list[0][1] = b1;
	    hp->h_addr_list[0][2] = b2;
	    hp->h_addr_list[0][3] = b3;
	} else {
	    return ENOENT;
	}
    }
    sa.sin_family = hp->h_addrtype;
    uport = (unsigned short) atoi(port);
    sa.sin_port = htons(uport);
    memcpy((char *) &sa.sin_addr, hp->h_addr, hp->h_length);

    if (connect(s, (struct sockaddr *) &sa, 
		sizeof(struct sockaddr_in)) < 0) {
	return errno;
    }

    cp = (ChildProc *) calloc(1, sizeof(ChildProc));
    cp->kind = CPSock;
    cp->pid = 0;
    cp->fdFrom = s;
    cp->fdTo = s;
    *pr = (ProcRef) cp;

#endif /* !OMIT_SOCKETS */

    return 0;
}

int OpenCommPort(name, pr)
     char *name;
     ProcRef *pr;
{
    int fd;
    ChildProc *cp;

    fd = open(name, 2, 0);
    if (fd < 0) return errno;

    cp = (ChildProc *) calloc(1, sizeof(ChildProc));
    cp->kind = CPComm;
    cp->pid = 0;
    cp->fdFrom = fd;
    cp->fdTo = fd;
    *pr = (ProcRef) cp;

    return 0;
}

int OpenLoopback(pr)
     ProcRef *pr;
{
    ChildProc *cp;
    int to[2], from[2];

    SetUpChildIO(to, from);

    cp = (ChildProc *) calloc(1, sizeof(ChildProc));
    cp->kind = CPLoop;
    cp->pid = 0;
    cp->fdFrom = to[0];  /* note not from[0]; we are doing a loopback */
    cp->fdTo = to[1];
    *pr = (ProcRef) cp;

    return 0;
}

int OpenRcmd(host, user, cmd, pr)
     char *host, *user, *cmd;
     ProcRef *pr;
{
    DisplayFatalError("internal rcmd not implemented for Unix", 0, 1);
    return -1;
}    

#define INPUT_SOURCE_BUF_SIZE 4096

typedef struct {
    CPKind kind;
    int fd;
    FILE *f;
    int lineByLine;
    InputCallback func;
    XtInputId xid;
    char buf[INPUT_SOURCE_BUF_SIZE];
} InputSource;

void DoInputCallback(closure, source, xid) 
     caddr_t closure;
     int *source;
     XtInputId *xid;
{
    InputSource *is = (InputSource *) closure;
    int count;
    int error;

    if (is->lineByLine) {
	if (fgets(is->buf, INPUT_SOURCE_BUF_SIZE, is->f) == NULL) {
	    error = ferror(is->f);
	    if (error == 0)
	      count = 0;
	    else
	      count = -1;
	    (is->func)((InputSourceRef) is, is->buf, count, error);
	} else {
	    (is->func)((InputSourceRef) is, is->buf, strlen(is->buf), 0);
	}
    } else {
	count = read(is->fd, is->buf, INPUT_SOURCE_BUF_SIZE);
	if (count == -1)
	  error = errno;
	else
	  error = 0;
	(is->func)((InputSourceRef) is, is->buf, count, error);
    }	
}

InputSourceRef AddInputSource(pr, lineByLine, func)
     ProcRef pr;
     int lineByLine;
     InputCallback func;
{
    InputSource *is;
    ChildProc *cp = (ChildProc *) pr;

    is = (InputSource *) calloc(1, sizeof(InputSource));
    is->lineByLine = lineByLine;
    is->func = func;
    if (pr == NoProc) {
	is->kind = CPReal;
	is->fd = fileno(stdin);
    } else {
	is->kind = cp->kind;
	is->fd = cp->fdFrom;
    }
    if (lineByLine) {
	is->f = fdopen(is->fd, "r");
	setbuf(is->f, NULL);
    }
    
    is->xid = XtAppAddInput(appContext, is->fd,
			    (XtPointer) (XtInputReadMask),
			    (XtInputCallbackProc) DoInputCallback,
			    (XtPointer) is);
    return (InputSourceRef) is;
}

void RemoveInputSource(isr)
     InputSourceRef isr;
{
    InputSource *is = (InputSource *) isr;

    if (is->xid == 0) return;
    XtRemoveInput(is->xid);
    if (is->lineByLine) {
	fclose(is->f);
    }
    is->xid = 0;
}

int OutputToProcess(pr, message, count, outError)
     ProcRef pr;
     char *message;
     int count;
     int *outError;
{
    ChildProc *cp = (ChildProc *) pr;
    int outCount;

    outCount = write(cp->fdTo, message, count);
    if (outCount == -1)
      *outError = errno;
    else
      *outError = 0;
    return outCount;
}


