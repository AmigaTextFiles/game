/***
***  muiclass.c         -- MUI chessboard class for AmyBoard
***  Copyright(C) 1995  Free Software Foundation
***
***  ------------------------------------------------------------------------
***  This program is free software; you can redistribute it and/or modify
***  it under the terms of the GNU General Public License as published by
***  the Free Software Foundation; either version 2 of the License, or
***  (at your option) any later version.
***
***  This program is distributed in the hope that it will be useful,
***  but WITHOUT ANY WARRANTY; without even the implied warranty of
***  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
***  GNU General Public License for more details.
***
***  You should have received a copy of the GNU General Public License
***  along with this program; if not, write to the Free Software
***  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
***  ------------------------------------------------------------------------
***
***
***  Computer: Amiga 1200
***  Compiler: Dice 3.01
***
***  Author:     Jochen Wiedmann
***              Am Eisteich 9
***              72555 Metzingen
***              Germany
***              Phone: (0049) +7123 / 14881
***              Internet: wiedmann@neckar-alb.de
**/
/**/


/*** Include section
**/
#include "amyboard.h"

#include <exec/memory.h>
#include <libraries/iffparse.h>
#include <graphics/gfx.h>
#include <graphics/rpattr.h>
#include <proto/graphics.h>

/**/


/*** Data section
**/
struct Library *MUIMasterBase       = NULL;
Class *SuperClass                   = NULL;
Class *ThisClass                    = NULL;

typedef struct
{ ULONG reqSquareWidth;
  ULONG reqSquareHeight;
  ULONG squareWidth;
  ULONG squareHeight;
  ULONG lightSquarePen;
  ULONG darkSquarePen;
  ULONG whitePiecePen;
  ULONG blackPiecePen;
  ULONG reqLightSquarePen;
  ULONG reqDarkSquarePen;
  ULONG reqWhitePiecePen;
  ULONG reqBlackPiecePen;
  LONG fromX;
  LONG fromY;
  LONG toX;
  LONG toY;
  LONG pieceX;
  LONG pieceY;
  UBYTE *reqPawnBitmap;
  UBYTE *reqKnightBitmap;
  UBYTE *reqBishopBitmap;
  UBYTE *reqRookBitmap;
  UBYTE *reqQueenBitmap;
  UBYTE *reqKingBitmap;
  UBYTE *solidPawnBitmap;
  UBYTE *solidKnightBitmap;
  UBYTE *solidBishopBitmap;
  UBYTE *solidRookBitmap;
  UBYTE *solidQueenBitmap;
  UBYTE *solidKingBitmap;
  APTR promotionUp;
  APTR piecePopUp;
  STRPTR bitmapDirectory;
  Board oldBoard;
  Board currentBoard;
  BOOL flipView;
  BOOL showCoords;
  BOOL oldBoardValid;
  BOOL alwaysPromoteToQueen;
  BOOL editPosition;
  BOOL menuDisabled;
} XBoardClassData;

extern Board initialPosition;
/**/


/***  Class dispatcher
**/
Object *xboardmNew(Class *, Object *, struct opSet *);
VOID xboardmDispose(Class *, Object *, Msg);
ULONG xboardmSet(Class *, Object *obj, struct opSet *);
ULONG xboardmGet(Class *, Object *obj, struct opGet *);
ULONG xboardmAskMinMax(Class *, Object *, struct MUIP_AskMinMax *);
ULONG xboardmDraw(Class *, Object *, struct MUIP_Draw *);
ULONG xboardmDrawPosition(Class *, Object *, Msg);
ULONG xboardmHandleInput(Class *, Object *, struct MUIP_HandleInput *);
ULONG xboardmSetup(Class *, Object *, struct MUIP_Setup *);
ULONG xboardmCleanup(Class *, Object *, Msg);
_HOOK_FUNC(ULONG, XBoardClassDispatcher, Class *cl,
					 Object *obj,
					 Msg msg)

{ switch(msg->MethodID)
  { case OM_NEW:
      return((ULONG) xboardmNew(cl, obj, (struct opSet *) msg));
    case OM_DISPOSE:
      xboardmDispose(cl, obj, msg);
      return(TRUE);
    case OM_SET:
      return(xboardmSet(cl, obj, (struct opSet *) msg));
    case OM_GET:
      return(xboardmGet(cl, obj, (struct opGet *) msg));
    case MUIM_AskMinMax:
      return(xboardmAskMinMax(cl, obj, (struct MUIP_AskMinMax *) msg));
    case MUIM_XBoard_DrawPosition:
      return(xboardmDrawPosition(cl, obj, msg));
    case MUIM_Draw:
      return(xboardmDraw(cl, obj, (struct MUIP_Draw *) msg));
    case MUIM_HandleInput:
      return(xboardmHandleInput(cl, obj, (struct MUIP_HandleInput *) msg));
    case MUIM_Setup:
      return(xboardmSetup(cl, obj, (struct MUIP_Setup *) msg));
    case MUIM_Cleanup:
      return(xboardmCleanup(cl, obj, msg));
  }
  return(DoSuperMethodA(cl, obj, msg));
}
/**/


/*** Bitmap handling functions
**/
VOID XBoardFreeBitmap(UBYTE *bitmap)

{ FreeVec(bitmap);
}

UBYTE *XBoardAllocBitmap(ULONG sizex, ULONG sizey)

{ return(AllocVec(MEMF_CHIP, RASSIZE(sizex, sizey)));
}

UBYTE *XBoardLoadBitmap(XBoardClassData *data, char c)

{ UBYTE bitmapName[30];
  UBYTE pathName[512];
  BPTR file;

  sprintf((char *) bitmapName, "b%ldx%ld%c.bm",
	  data->reqSquareWidth, data->reqSquareHeight, c);
  strcpy((char *) bitmapName, (char *) data->bitmapDirectory);
  AddPart(pathName, bitmapName, sizeof(pathName));
  if ((file = Open(pathName, MODE_OLDFILE)))
  { UBYTE *bitmap;

    if ((bitmap = XBoardAllocBitmap(data->reqSquareWidth, data->reqSquareHeight)))
    { int size = RASSIZE(data->reqSquareWidth, data->reqSquareHeight);

      if (Read(file, bitmap, size) == size)
      { Close(file);
	return(bitmap);
      }
      XBoardFreeBitmap(bitmap);
    }
    Close(file);
  }
  return(NULL);
}





/**
***  Builtin bitmaps
**/
#define XBOARD_MAXWIDTH 80
#define XBOARD_MAXHEIGHT 80
#define XBOARD_MINWIDTH 44
#define XBOARD_MINHEIGHT 19

typedef struct
{ UBYTE *bits;
} builtinBitmap;
struct builtinBitmapTable
{ builtinBitmap bitmaps[6];
  int width, height;
};

extern UBYTE p80s_bits[], r80s_bits[], n80s_bits[],
	     b80s_bits[], q80s_bits[], k80s_bits[],
	     p64s_bits[], r64s_bits[], n64s_bits[],
	     b64s_bits[], q64s_bits[], k64s_bits[],
	     p40s_bits[], r40s_bits[], n40s_bits[],
	     b40s_bits[], q40s_bits[], k40s_bits[],
	     p44x22s_bits[], r44x22s_bits[], n44x22s_bits[],
	     b44x22s_bits[], q44x22s_bits[], k44x22s_bits[],
	     p44x19s_bits[], r44x19s_bits[], n44x19s_bits[],
	     b44x19s_bits[], q44x19s_bits[], k44x19s_bits[];

const struct builtinBitmapTable XBOARD_BUILTIN_BITMAPS [] =
{ { { { p80s_bits }, { r80s_bits }, { n80s_bits },
      { b80s_bits }, { q80s_bits }, { k80s_bits } }, 80, 80 },
  { { { p64s_bits }, { r64s_bits }, { n64s_bits },
      { b64s_bits }, { q64s_bits }, { k64s_bits } }, 64, 64 },
  { { { p40s_bits }, { r40s_bits }, { n40s_bits },
      { b40s_bits }, { q40s_bits }, { k40s_bits } }, 40, 40 },
  { { { p44x22s_bits }, { r44x22s_bits }, { n44x22s_bits },
      { b44x22s_bits }, { q44x22s_bits }, { k44x22s_bits } }, 44, 22 },
  { { { p44x19s_bits }, { r44x19s_bits }, { n44x19s_bits },
      { b44x19s_bits }, { q44x19s_bits }, { k44x19s_bits } }, 44, 19 },
  { { { NULL      }, { NULL      }, { NULL      },
      { NULL      }, { NULL      }, { NULL      } }, 0,  0  }
};

void InitBuiltinBitmaps(void)

{ /**
  ***  X holds the bits of a byte in reversed order. We need to
  ***  rearrange this.
  **/
  struct builtinBitmapTable *bbmt;

  for (bbmt = (struct builtinBitmapTable *) XBOARD_BUILTIN_BITMAPS;
       bbmt->width;
       bbmt++)
  { int i;

    for (i = 0;  i < 6;  i++)
    { UBYTE *ptr = bbmt->bitmaps[i].bits;
      int j;

      for (j = RASSIZE(bbmt->width, bbmt->height);  j;  --j)
      { UBYTE c;

	c = *ptr;
	*ptr++ = ((c & 0x80) >> 7) |
		 ((c & 0x40) >> 5) |
		 ((c & 0x20) >> 3) |
		 ((c & 0x10) >> 1) |
		 ((c & 0x08) << 1) |
		 ((c & 0x04) << 3) |
		 ((c & 0x02) << 5) |
		 ((c & 0x01) << 7);
      }
    }
  }
}

struct builtinBitmapTable *XBoardAskBuiltinBitmap(ULONG width, ULONG height)

{ struct builtinBitmapTable *bbmt;

  for (bbmt = (struct builtinBitmapTable *) XBOARD_BUILTIN_BITMAPS;
       bbmt->width;
       bbmt++)
  { if ((bbmt->width << 3) <= width  &&
	(bbmt->height << 3) <= height)
    { return(bbmt);
    }
  }
  return(NULL);
}
UBYTE *XBoardGetBuiltinBitmap(struct builtinBitmapTable *bbmt, char piece)

{ builtinBitmap *bitmaps = bbmt->bitmaps;

  switch (piece)
  { case 'p':
      return(bitmaps[0].bits);
    case 'r':
      return(bitmaps[1].bits);
    case 'n':
      return(bitmaps[2].bits);
    case 'b':
      return(bitmaps[3].bits);
    case 'q':
      return(bitmaps[4].bits);
    case 'k':
      return(bitmaps[5].bits);
  }
  return(NULL);
}
/**/


/****** XBoard.mcc/MUIA_XBoard_SquareWidth *********************************
*
*   NAME
*       MUIA_XBoard_SquareWidth - set square width [I.G], ULONG
*
*   FUNCTION
*       This attribute determines the width of one chessboard square.
*       The chessboards width will be the square width multiplied by
*       8, the number of squares.
*
*       If you don't set this attribute, the chessboard gadget will
*       use reasonable defaults. Otherwise you should additionally set
*       the attributes MUIA_XBoard_SquareHeight and
*       MUIA_XBoard_BitmapDirectory too, because in that case the
*       bitmaps are loaded from the disk.
*
*       Note, that these settings can be overwritten, if the window
*       gets resized too small.
*
*   SEE ALSO
*       MUIA_XBoard_SquareHeight, MUIA_XBoard_BitmapDirectory
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_SquareHeight ********************************
*
*   NAME
*       MUIA_XBoard_SquareHeight - set square height [I.G], ULONG
*
*   FUNCTION
*       This attribute determines the height of one chessboard square.
*       The chessboards height will be the square height multiplied by
*       8, the number of squares.
*
*       If you don't set this attribute, the chessboard gadget will
*       use reasonable defaults. Otherwise you should additionally set
*       the attributes MUIA_XBoard_SquareWidth and
*       MUIA_XBoard_BitmapDirectory too, because in that case the
*       bitmaps are loaded from the disk.
*
*       Note, that these settings can be overwritten, if the window
*       gets resized too small.
*
*   SEE ALSO
*       MUIA_XBoard_SquareWidth, MUIA_XBoard_BitmapDirectory
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_BitmapDirectory *****************************
*
*   NAME
*       MUIA_BitmapDirectory - set bitmap directory [I..], STRPTR
*
*   FUNCTION
*       By setting this attribute you can use your own bitmaps
*       for the chessboard gadget. These bitmaps must be stored
*       as separate files called "xns.bm", where x means
*           p   pawn
*           r   rook
*           n   knight
*           b   bishop
*           q   queen
*           k   king
*       and n is the square size as supplied with
*       MUIA_XBoard_SquareSize. Thus a filename like "q64s.bm"
*       means "Queen, square size 64 pixels".
*
*       Actually the only supported format is X11 bitmap format.
*
*   BUGS
*       The string will not be copied and has to remain valid as
*       long as the object lives.
*
*   SEE ALSO
*       MUIA_XBoard_SquareSize
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_FlipView ************************************
*
*   NAME
*       MUIA_XBoard_Flipview - set chessboard direction [ISG], BOOL
*
*   FUNCTION
*       Usually the chessboard displays the white pieces at the
*       bottom moving to the top of the board. By setting this
*       attribute to TRUE (typically, if the user has the black
*       pieces), you get the white pieces at the top of the
*       chessboard.
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_ShowCoords **********************************
*
*   NAME
*       MUIA_XBoard_ShowCoords - show square coordinates [ISG], BOOL
*
*   FUNCTION
*       This attribute displays coordinates at the bottom and the
*       right side of the chessboard, respectively.
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_LightSquarePen ******************************
*
*   NAME
*       MUIA_XBoard_LightSquarePen - white squares pen [I.G], ULONG
*
*   FUNCTION
*       Pen of the light squares on the chessboard
*
*   SEE ALSO
*       MUIA_XBoard_DarkSquarePen, MUIA_XBoard_WhitePiecePen,
*       MUIA_XBoard_BlackPiecePen
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_DarkSquarePen *******************************
*
*   NAME
*       MUIA_XBoard_DarkSquarePen - black squares pen [I.G], ULONG
*
*   FUNCTION
*       Pen of the dark squares on the chessboard
*
*   SEE ALSO
*       MUIA_XBoard_LightSquarePen, MUIA_XBoard_WhitePiecePen,
*       MUIA_XBoard_BlackPiecePen
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_WhitePiecePen *******************************
*
*   NAME
*       MUIA_XBoard_WhitePiecePen - white pieces pen [I.G], ULONG
*
*   FUNCTION
*       Pen of the white squares on the chessboard
*
*   SEE ALSO
*       MUIA_XBoard_LightSquarePen, MUIA_XBoard_DarkSquarePen,
*       MUIA_XBoard_BlackPiecePen
*
***************************************************************************/
/**/
/****** XBoard.mcc/MUIA_XBoard_BlackPiecePen *******************************
*
*   NAME
*       MUIA_XBoard_BlackPiecePen - black pieces pen [I.G], ULONG
*
*   FUNCTION
*       Pen of the black pieces on the chessboard
*
*   SEE ALSO
*       MUIA_XBoard_LightSquarePen, MUIA_XBoard_DarkSquarePen,
*       MUIA_XBoard_WhitePiecePen
*
***************************************************************************/
/**/
/***** XBoard.mcc/MUIA_XBoard_AlwaysPromoteToQueen *************************
*
*   NAME
*       MUIA_XBoard_AlwaysPromoteToQueen - force queen
*                                       promotion [ISG], ULONG
*
*   FUNCTION
*       Setting this attribute to TRUE disables the promotion
*       requester. Pawns will always be promoted to queens
*       instead.
*
***************************************************************************/
/**/
/***** XBoard.mcc/MUIA_XBoard_EditPosition *********************************
*
*   NAME
*       MUIA_XBoard_EditPosition - edit a position [ISG], ULONG
*
*   FUNCTION
*       If this attribute is TRUE, user inputs will be handled
*       differently: A mouseclick on a square will popup a
*       requester, that allows the user to select a piece which
*       will be placed on that square.
*
***************************************************************************/
/**/


/*** OM_New method
**/
Object *xboardmNew(Class *cl, Object *obj, struct opSet *msg)

{ Object *newobj;
  XBoardClassData *data;

  if (!(newobj = (Object *) DoSuperMethodA(cl, obj, (Msg) msg)))
  { return(NULL);
  }

  data = INST_DATA(cl, newobj);

  data->reqSquareWidth = 0;
  data->reqSquareHeight = 0;
  data->squareWidth = 0;
  data->squareHeight = 0;
  data->reqPawnBitmap = NULL;
  data->reqRookBitmap = NULL;
  data->reqKnightBitmap = NULL;
  data->reqBishopBitmap = NULL;
  data->reqQueenBitmap = NULL;
  data->reqKingBitmap = NULL;
  data->solidPawnBitmap = NULL;
  data->solidRookBitmap = NULL;
  data->solidKnightBitmap = NULL;
  data->solidBishopBitmap = NULL;
  data->solidQueenBitmap = NULL;
  data->solidKingBitmap = NULL;
  data->bitmapDirectory = NULL;
  data->flipView = FALSE;
  data->showCoords = FALSE;
  data->oldBoardValid = FALSE;
  data->lightSquarePen = -1;
  data->darkSquarePen = -1;
  data->whitePiecePen = -1;
  data->blackPiecePen = -1;
  data->reqLightSquarePen = -1;
  data->reqDarkSquarePen = -1;
  data->reqWhitePiecePen = -1;
  data->reqBlackPiecePen = -1;
  data->fromX = -1;
  data->fromY = -1;
  data->toX = -1;
  data->toY = -1;
  data->promotionUp = NULL;
  data->alwaysPromoteToQueen = FALSE;
  data->editPosition = FALSE;
  data->piecePopUp = NULL;
  CopyMem(&initialPosition, &data->currentBoard, sizeof(Board));

  set(newobj, MUIA_Font, MUIV_Font_Tiny);
  DoMethod(newobj, OM_SET, msg->ops_AttrList);

  /**
  ***  Try to load the requested bitmaps from disk.
  **/
  if (data->bitmapDirectory  &&
      data->reqSquareWidth  &&
      data->reqSquareHeight)
  { if (!(data->reqPawnBitmap = XBoardLoadBitmap(data, 'p'))    ||
	!(data->reqRookBitmap = XBoardLoadBitmap(data, 'r'))    ||
	!(data->reqKnightBitmap = XBoardLoadBitmap(data, 'n'))  ||
	!(data->reqBishopBitmap = XBoardLoadBitmap(data, 'b'))  ||
	!(data->reqQueenBitmap = XBoardLoadBitmap(data, 'q'))   ||
	!(data->reqKingBitmap = XBoardLoadBitmap(data, 'k')))
    { XBoardFreeBitmap(data->reqPawnBitmap);
      XBoardFreeBitmap(data->reqRookBitmap);
      XBoardFreeBitmap(data->reqKnightBitmap);
      XBoardFreeBitmap(data->reqBishopBitmap);
      XBoardFreeBitmap(data->reqKingBitmap);
      XBoardFreeBitmap(data->reqQueenBitmap);
      data->reqPawnBitmap = NULL;
      data->reqRookBitmap = NULL;
      data->reqKnightBitmap = NULL;
      data->reqBishopBitmap = NULL;
      data->reqKingBitmap = NULL;
      data->reqQueenBitmap = NULL;
    }
  }

  return(newobj);
}
/**/


/*** CloseMuiWindow() function
**/
_HOOK_FUNC(void, windowCloseCallback, struct Hook *hook,
				      Object *app,
				      va_list args)
{ Object *window;

  window = va_arg(args, Object *);
  DoMethod(app, OM_REMMEMBER, window);
  MUI_DisposeObject(window);
}
struct Hook windowCloseCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) windowCloseCallback,
  NULL,
  NULL
};

   
VOID CloseMuiWindow(Object *win)

{ set(win, MUIA_Window_Open, FALSE);
  DoMethod(_app(win), MUIM_Application_PushMethod,
	   _app(win), 3, MUIM_CallHook, &windowCloseCallbackHook, win);
}
/**/


/*** OM_Dispose method
**/
VOID PromotionPopDown(Class *cl, Object *obj)

{ XBoardClassData *data = INST_DATA(cl, obj);

  if (data->promotionUp)
  { CloseMuiWindow(data->promotionUp);
    data->promotionUp = NULL;
  }
  data->fromX = -1;
  data->fromY = -1;
  data->toX = -1;
  data->toY = -1;
}

VOID PiecePopDown(Class *cl, Object *obj)

{ XBoardClassData *data = INST_DATA(cl, obj);

  if (data->piecePopUp)
  { CloseMuiWindow(data->piecePopUp);
    data->piecePopUp = NULL;
  }
  data->fromX = -1;
  data->fromY = -1;
}

VOID xboardmDispose(Class *cl, Object *obj, Msg msg)

{ XBoardClassData *data = INST_DATA(cl, obj);

  PromotionPopDown(cl, obj);
  PiecePopDown(cl, obj);

  XBoardFreeBitmap(data->reqPawnBitmap);
  XBoardFreeBitmap(data->reqRookBitmap);
  XBoardFreeBitmap(data->reqKnightBitmap);
  XBoardFreeBitmap(data->reqBishopBitmap);
  XBoardFreeBitmap(data->reqQueenBitmap);
  XBoardFreeBitmap(data->reqKingBitmap);
  DoSuperMethodA(cl, obj, msg);
}
/**/


/*** OM_Set method
**/
ULONG xboardmSet(Class *cl, Object *obj, struct opSet *msg)

{ XBoardClassData *data = INST_DATA(cl, obj);
  struct TagItem *tiptr, *ti;

  tiptr = msg->ops_AttrList;
  while((ti = NextTagItem(&tiptr)))
  { switch(ti->ti_Tag)
    { case MUIA_XBoard_SquareWidth:
	data->reqSquareWidth = ti->ti_Data;
	break;
      case MUIA_XBoard_SquareHeight:
	data->reqSquareHeight = ti->ti_Data;
	break;
      case MUIA_XBoard_BitmapDirectory:
	data->bitmapDirectory = (STRPTR) ti->ti_Data;
	break;
      case MUIA_XBoard_FlipView:
	{ BOOL oldflipView = data->flipView;

	  data->flipView = (BOOL) ti->ti_Data;
	  if (data->flipView != oldflipView)
	  { MUI_Redraw(obj, MADF_DRAWOBJECT);
	  }
	}
	break;
      case MUIA_XBoard_ShowCoords:
	{ BOOL oldShowCoords = data->showCoords;

	  data->showCoords = (BOOL) ti->ti_Data;
	  if (data->showCoords != oldShowCoords)
	  { MUI_Redraw(obj, MADF_DRAWOBJECT);
	  }
	}
	break;
      case MUIA_XBoard_LightSquarePen:
	data->reqLightSquarePen = ti->ti_Data;
	break;
      case MUIA_XBoard_DarkSquarePen:
	data->reqDarkSquarePen = ti->ti_Data;
	break;
      case MUIA_XBoard_WhitePiecePen:
	data->reqWhitePiecePen = ti->ti_Data;
	break;
      case MUIA_XBoard_BlackPiecePen:
	data->reqBlackPiecePen = ti->ti_Data;
	break;
      case MUIA_XBoard_AlwaysPromoteToQueen:
	data->alwaysPromoteToQueen = ti->ti_Data;
	break;
      case MUIA_XBoard_EditPosition:
	data->editPosition = ti->ti_Data;
	break;
    }
  }
  return(DoSuperMethodA(cl, obj, (Msg) msg));
}
/**/


/*** OM_Get method
**/
ULONG xboardmGet(Class *cl, Object *obj, struct opGet *msg)

{ XBoardClassData *data = INST_DATA(cl, obj);
  ULONG *store = msg->opg_Storage;

  switch (msg->opg_AttrID)
  { case MUIA_XBoard_SquareWidth:
      *store = data->squareWidth;
      break;
    case MUIA_XBoard_SquareHeight:
      *store = data->squareHeight;
      break;
    case MUIA_XBoard_BitmapDirectory:
      *store = (ULONG) data->bitmapDirectory;
      break;
    case MUIA_XBoard_FlipView:
      *store = (ULONG) data->flipView;
      break;
    case MUIA_XBoard_ShowCoords:
      *store = (ULONG) data->showCoords;
      break;
    case MUIA_XBoard_LightSquarePen:
      *store = data->reqLightSquarePen;
      break;
    case MUIA_XBoard_DarkSquarePen:
      *store = data->reqDarkSquarePen;
      break;
    case MUIA_XBoard_WhitePiecePen:
      *store = data->reqWhitePiecePen;
      break;
    case MUIA_XBoard_BlackPiecePen:
      *store = data->reqBlackPiecePen;
      break;
    case MUIA_XBoard_AlwaysPromoteToQueen:
      *store = data->alwaysPromoteToQueen;
      break;
    case MUIA_XBoard_EditPosition:
      *store = data->editPosition;
      break;
    default:
      return(DoSuperMethodA(cl, obj, (Msg) msg));
  }
  return(TRUE);
}
/**/


/*** MUIM_AskMinMax method
**/
ULONG xboardmAskMinMax(Class *cl, Object *obj, struct MUIP_AskMinMax *msg)

{ XBoardClassData *data = INST_DATA(cl, obj);

  DoSuperMethodA(cl, obj, (Msg) msg);

  if (!data->reqPawnBitmap)
  { data->reqSquareWidth = XBOARD_MAXWIDTH;
    data->reqSquareHeight = XBOARD_MAXHEIGHT;
  }
  msg->MinMaxInfo->MinWidth += MIN(XBOARD_MINWIDTH, data->reqSquareWidth) << 3;
  msg->MinMaxInfo->MinHeight += MIN(XBOARD_MINHEIGHT, data->reqSquareHeight) << 3;
  msg->MinMaxInfo->DefWidth += data->reqSquareWidth << 3;
  msg->MinMaxInfo->DefHeight += data->reqSquareHeight << 3;
  msg->MinMaxInfo->MaxWidth += data->reqSquareWidth << 3;
  msg->MinMaxInfo->MaxHeight += data->reqSquareHeight << 3;
  return(0);
}
/**/


/*** XBoardDrawSquare() function
**/
VOID XBoardDrawSquare(Object *obj, XBoardClassData *data, int i, int j,
		      ChessSquare cs, struct RastPort *rp)

{ ULONG left = _left(obj);
  ULONG top = _top(obj);
  ULONG width = _width(obj);
  ULONG height = _height(obj);
  ULONG sizex = data->squareWidth;
  ULONG sizey = data->squareHeight;
  BOOL whiteSquare = ((i + j) % 2) != 0;
  ULONG colorA, colorB;
  UBYTE *bitmap;
  int cI, cJ;

  cI = i;
  cJ = j;
  if (data->flipView)
  { i = 7-i;
    j = 7-j;
  }

  left += ((width - (sizex << 3)) >> 2) + j * sizex;
  top += ((height - (sizey << 3)) >> 2) + (7-i) * sizey;

  colorB = whiteSquare ? data->lightSquarePen : data->darkSquarePen;
  colorA = colorB;  /*  Suppress warnings on uninitialized variables */
  bitmap = data->solidPawnBitmap;

  switch(cs)
  { case WhitePawn:
      colorA = data->whitePiecePen;
      bitmap = data->solidPawnBitmap;
      break;
    case WhiteRook:
      colorA = data->whitePiecePen;
      bitmap = data->solidRookBitmap;
      break;
    case WhiteKnight:
      colorA = data->whitePiecePen;
      bitmap = data->solidKnightBitmap;
      break;
    case WhiteBishop:
      colorA = data->whitePiecePen;
      bitmap = data->solidBishopBitmap;
      break;
    case WhiteQueen:
      colorA = data->whitePiecePen;
      bitmap = data->solidQueenBitmap;
      break;
    case WhiteKing:
      colorA = data->whitePiecePen;
      bitmap = data->solidKingBitmap;
      break;
    case BlackPawn:
      colorA = data->blackPiecePen;
      bitmap = data->solidPawnBitmap;
      break;
    case BlackRook:
      colorA = data->blackPiecePen;
      bitmap = data->solidRookBitmap;
      break;
    case BlackKnight:
      colorA = data->blackPiecePen;
      bitmap = data->solidKnightBitmap;
      break;
    case BlackBishop:
      colorA = data->blackPiecePen;
      bitmap = data->solidBishopBitmap;
      break;
    case BlackQueen:
      colorA = data->blackPiecePen;
      bitmap = data->solidQueenBitmap;
      break;
    case BlackKing:
      colorA = data->blackPiecePen;
      bitmap = data->solidKingBitmap;
      break;
    default:
      break;
  }

  SetABPenDrMd(rp, colorA, colorB, JAM2);
  BltTemplate(bitmap, 0, ((data->squareWidth+15)>>3)&0xFFFE, rp, left, top, sizex, sizey);

  if (data->showCoords)
  { char coords[3];
    struct TextExtent te;

    coords[0] = 'A'+cJ;
    coords[1] = '1'+cI;
    coords[2] = '\0';

    SetABPenDrMd(rp, whiteSquare ? data->darkSquarePen : data->lightSquarePen,
		 colorB, JAM1);
    TextExtent(rp, (STRPTR) coords, 2, &te);
    Move(rp, left + sizex - te.te_Width - 1, top + sizey - te.te_Height);
    Text(rp, (STRPTR) coords, 2);
  }
}
/**/


/*** MUIM_Draw method
**/
ULONG xboardmDraw(Class *cl, Object *obj, struct MUIP_Draw *msg)

{ XBoardClassData *data = INST_DATA(cl, obj);
  ULONG width = _width(obj);
  ULONG height = _height(obj);
  struct RastPort *rp = _rp(obj);
  struct TextFont *tf;
  ULONG drMd, aPen, bPen;

  DoSuperMethodA(cl, obj, (Msg) msg);

  if (((struct Library *) GfxBase)->lib_Version >= 39)
  { GetRPAttrs(rp, RPTAG_Font, &tf,
		   RPTAG_DrMd, &drMd,
		   RPTAG_APen, &aPen,
		   RPTAG_BPen, &bPen,
		   TAG_DONE);
  }
  else
  { tf = rp->Font;
    drMd = rp->DrawMode;
    aPen = rp->FgPen;
    bPen = rp->BgPen;
  }
  SetFont(rp, _font(obj));

  if (!(msg->flags & MADF_DRAWUPDATE))
  { int i,j;

    if (data->reqPawnBitmap  &&
	(width >= data->reqSquareWidth << 3)  &&
	(height >= data->reqSquareHeight << 3))
    { data->solidPawnBitmap = data->reqPawnBitmap;
      data->solidRookBitmap = data->reqRookBitmap;
      data->solidKnightBitmap = data->reqKnightBitmap;
      data->solidBishopBitmap = data->reqBishopBitmap;
      data->solidQueenBitmap = data->reqQueenBitmap;
      data->solidKingBitmap = data->reqKingBitmap;
      data->squareWidth = data->reqSquareWidth;
      data->squareHeight = data->reqSquareHeight;
    }
    else
    { struct builtinBitmapTable *bbmt = XBoardAskBuiltinBitmap(width, height);
      data->solidPawnBitmap = XBoardGetBuiltinBitmap(bbmt, 'p');
      data->solidRookBitmap = XBoardGetBuiltinBitmap(bbmt, 'r');
      data->solidKnightBitmap = XBoardGetBuiltinBitmap(bbmt, 'n');
      data->solidBishopBitmap = XBoardGetBuiltinBitmap(bbmt, 'b');
      data->solidQueenBitmap = XBoardGetBuiltinBitmap(bbmt, 'q');
      data->solidKingBitmap = XBoardGetBuiltinBitmap(bbmt, 'k');
      data->squareWidth = bbmt->width;
      data->squareHeight = bbmt->height;
    }

    for (i = BOARD_SIZE-1;  i >= 0;  i--)
    { for (j = BOARD_SIZE-1;  j >= 0;  j--)
      { XBoardDrawSquare(obj, data, i, j, data->currentBoard[i][j], rp);
      }
    }
  }
  else
  { int i, j;

    for (i = BOARD_SIZE-1;  i >= 0;  i--)
    { for (j = BOARD_SIZE-1;  j >= 0;  j--)
      { ChessSquare cs = data->currentBoard[i][j];

	if (data->oldBoard[i][j] != cs)
	{ XBoardDrawSquare(obj, data, i, j, cs, rp);
	}
      }
    }
  }

  CopyMem(data->currentBoard, data->oldBoard, sizeof(Board));
  data->oldBoardValid = TRUE;

  if (((struct Library *) GfxBase)->lib_Version >= 39)
  { SetRPAttrs(rp, RPTAG_Font, tf,
		   RPTAG_DrMd, drMd,
		   RPTAG_APen, aPen,
		   RPTAG_BPen, bPen,
		   TAG_DONE);
  }
  else
  { SetFont(rp, tf);
    SetABPenDrMd(rp, aPen, bPen, drMd);
  }   

  return(0);
}
/**/


/*** Chessboard editing functions
**/
_HOOK_FUNC(ULONG, pieceCallback, struct Hook *hook,
				 Object *obj,
				 va_list args)

{ ChessSquare selection;
  XBoardClassData *data;
  LONG pieceX, pieceY;

  selection = va_arg(args, int);
  data = INST_DATA(ThisClass, obj);

  pieceX = data->pieceX;
  pieceY = data->pieceY;
  data->pieceX = -1;
  data->pieceY = -1;
  if (pieceX >= 0  &&  pieceX <= 7  &&  pieceY >= 0  &&  pieceY <= 7  &&
      selection != (ChessSquare) -1)
  { EditPositionMenuEvent(selection, pieceX, pieceY);
  }
  PiecePopDown(ThisClass, obj);
  return(0);
}

const struct Hook pieceCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) pieceCallback,
  NULL,
  NULL
};

VOID PiecePopUp(Class *cl, Object *obj)

{ XBoardClassData *data = INST_DATA(cl, obj);
  APTR win, whiteKing, blackKing, whiteQueen, blackQueen,
       whiteBishop, blackBishop, whiteKnight, blackKnight,
       whiteRook, blackRook, whitePawn, blackPawn,
       emptySquare, clearBoard, whiteToPlay, blackToPlay;
  extern struct Library *MUIMasterBase;

  data->pieceX = data->fromX;
  data->pieceY = data->fromY;
  PiecePopDown(cl, obj);

  win = WindowObject,
	    MUIA_Window_ID, MAKE_ID('P','I','E','C'),
	    MUIA_Window_Title, "Piece requester",
	    WindowContents, VGroup,
		Child, ColGroup(2),
		    Child, whiteKing = MUI_MakeObject(MUIO_Button, "White King"),
			Child, blackKing = MUI_MakeObject(MUIO_Button, "Black King"),
		    Child, whiteQueen = MUI_MakeObject(MUIO_Button, "White Queen"),
			Child, blackQueen = MUI_MakeObject(MUIO_Button, "Black Queen"),
		    Child, whiteBishop = MUI_MakeObject(MUIO_Button, "White Bishop"),
			Child, blackBishop = MUI_MakeObject(MUIO_Button, "Black Bishop"),
		    Child, whiteKnight = MUI_MakeObject(MUIO_Button, "White Knight"),
			Child, blackKnight = MUI_MakeObject(MUIO_Button, "Black Knight"),
		    Child, whiteRook = MUI_MakeObject(MUIO_Button, "White Rook"),
			Child, blackRook = MUI_MakeObject(MUIO_Button, "Black Rook"),
		    Child, whitePawn = MUI_MakeObject(MUIO_Button, "White Pawn"),
			Child, blackPawn = MUI_MakeObject(MUIO_Button, "Black Pawn"),
		End,
		Child, MUI_MakeObject(MUIO_HBar, 0),
		Child, ColGroup(2),
		    Child, emptySquare = MUI_MakeObject(MUIO_Button, "Empty Square"),
			Child, clearBoard = MUI_MakeObject(MUIO_Button, "Clear Borard"),
		End,
		Child, MUI_MakeObject(MUIO_HBar, 0),
		Child, ColGroup(2),
		    Child, whiteToPlay = MUI_MakeObject(MUIO_Button, "White to play"),
			Child, blackToPlay = MUI_MakeObject(MUIO_Button, "Black to play"),
		End,
	    End,
	End;

  if (win)
  { ULONG open;
    APTR app = _app(obj);

    DoMethod(app, OM_ADDMEMBER, win);
    set(win, MUIA_Window_Open, TRUE);
    get(win, MUIA_Window_Open, &open);

    if (open)
    { DoMethod(win, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, -1);
      DoMethod(emptySquare, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, EmptySquare);
      DoMethod(clearBoard, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, ClearBoard);

      DoMethod(whiteKing, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhiteKing);
      DoMethod(whiteQueen, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhiteQueen);
      DoMethod(whiteBishop, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhiteBishop);
      DoMethod(whiteKnight, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhiteKnight);
      DoMethod(whiteRook, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhiteRook);
      DoMethod(whitePawn, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhitePawn);
      DoMethod(whiteToPlay, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, WhitePlay);
      DoMethod(blackKing, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackKing);
      DoMethod(blackQueen, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackQueen);
      DoMethod(blackBishop, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackBishop);
      DoMethod(blackKnight, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackKnight);
      DoMethod(blackRook, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackRook);
      DoMethod(blackPawn, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackPawn);
      DoMethod(blackToPlay, MUIM_Notify, MUIA_Pressed, FALSE,
	       obj, 3, MUIM_CallHook, &pieceCallbackHook, BlackPlay);

      data->piecePopUp = win;

      return;
    }
    else
    { DoMethod(_app(obj), OM_REMMEMBER, win);
      MUI_DisposeObject(win);
    }
  }

  DisplayFatalError("Out of memory", 0, 10);
}
/**/


/*** Promotion functions
**/
_HOOK_FUNC(ULONG, promotionCallback, struct Hook *hook,
				     Object *obj,
				     va_list args)

{ XBoardClassData *data = INST_DATA(ThisClass, obj);
  int c;
  LONG fromX, fromY, toX, toY;

  c = va_arg(args, int);

  fromX = data->fromX;
  fromY = data->fromY;
  toX = data->toX;
  toY = data->toY;

  set(_win(obj), MUIA_Window_Sleep, FALSE);

  if (fromX >= 0  &&  fromX <=7   &&  fromY >= 0  &&  fromY <= 7  &&
      toX >= 0    &&  toX   <= 7  &&  toY >= 0    &&  toY <= 7    &&
      c != NULLCHAR)
  { UserMoveEvent(fromX, fromY, toX, toY, c);
  }
  PromotionPopDown(ThisClass, obj);
  return(0);
}

struct Hook promotionCallbackHook =
{ { NULL, NULL },
  (HOOKFUNC) promotionCallback,
  NULL,
  NULL
};

VOID PromotionPopUp(Class *cl, Object *obj)

{ XBoardClassData *data = INST_DATA(cl, obj);
  APTR win, queenButton, knightButton, rookButton, bishopButton;
  APTR app = _app(obj);
  ULONG open;

  if (data->promotionUp)
  { return;
  }

  win = WindowObject,
	    MUIA_Window_ID, MAKE_ID('P','R','O','M'),
	    MUIA_Window_Title, "Promotion requester",
	    WindowContents, VGroup,
		Child, TextObject,
		    MUIA_Text_Contents, "Promote piece to what?",
		End,
		Child, ColGroup(2),
		    Child, queenButton = KeyButton("Queen", 'q'),
			Child, rookButton = KeyButton("Rook", 'r'),
		    Child, bishopButton = KeyButton("Bishop", 'b'),
			Child, knightButton = KeyButton("Knight", 'k'),
		End,
	    End,
	End;

  if (!win)
  { return;
  }
  DoMethod(app, OM_ADDMEMBER, win);
  set(win, MUIA_Window_Open, TRUE);
  get(win, MUIA_Window_Open, &open);
  if (!open)
  { DoMethod(app, OM_REMMEMBER, win);
    MUI_DisposeObject(win);
    return;
  }

  data->promotionUp = win;

  DoMethod(win, MUIM_Notify, MUIA_Window_CloseRequest, TRUE,
	   obj, 3, MUIM_CallHook, &promotionCallbackHook, (int) '\0');
  DoMethod(queenButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   obj, 3, MUIM_CallHook, &promotionCallbackHook, (int) 'q');
  DoMethod(rookButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   obj, 3, MUIM_CallHook, &promotionCallbackHook, (int) 'r');
  DoMethod(bishopButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   obj, 3, MUIM_CallHook, &promotionCallbackHook, (int) 'b');
  DoMethod(knightButton, MUIM_Notify, MUIA_Pressed, FALSE,
	   obj, 3, MUIM_CallHook, &promotionCallbackHook, (int) 'n');
  set(_win(obj), MUIA_Window_Sleep, TRUE);
}
/**/


/*** MUIM_HandleInput method
**/
ULONG xboardmHandleInput(Class *cl, Object *obj, struct MUIP_HandleInput *msg)

{ XBoardClassData *data = INST_DATA(cl, obj);

  if (msg->imsg)
  { LONG x, y;
    ULONG left = ((_width(obj) - (data->squareWidth << 3)) >> 2) + _mleft(obj);
    ULONG top = ((_height(obj) - (data->squareHeight << 3)) >> 2) + _mtop(obj);

    x = 7 - (msg->imsg->MouseX - left) / data->squareWidth;
    y = (msg->imsg->MouseY - top) / data->squareHeight;

    if (!data->flipView)
    { y = BOARD_SIZE - 1 - y;
      x = BOARD_SIZE - 1 - x;
    }

    if (x < 0  ||  x >= BOARD_SIZE  ||  y < 0  ||  y >= BOARD_SIZE)
    { x = -2;
      y = -2;
    }

    switch(msg->imsg->Class)
    { case IDCMP_MOUSEBUTTONS:
	if (data->promotionUp)
	{ PromotionPopDown(cl, obj);
	}

	if (msg->imsg->Code == SELECTDOWN)
	{ if ((msg->imsg->Qualifier &
	       (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT | IEQUALIFIER_CAPSLOCK))
	      ||  !OKToStartUserMove(x, y))
	  { data->fromX = -1;
	    data->fromY = -1;
	  }
	  else
	  { data->fromX = x;
	    data->fromY = y;
	  }
	}
	else if (msg->imsg->Code == SELECTUP)
	{ if (msg->imsg->Qualifier &
	      (IEQUALIFIER_LSHIFT | IEQUALIFIER_RSHIFT | IEQUALIFIER_CAPSLOCK))
	  { if (data->editPosition
		&&  x >= 0  &&  x < BOARD_SIZE
		&&  y >= 0  &&  y < BOARD_SIZE)
	    { data->fromX = x;
	      data->fromY = y;
	      PiecePopUp(cl, obj);
	    }
	  }
	  else
	  { if (IsPromotion(data->fromX, data->fromY, x, y))
	    { if (data->alwaysPromoteToQueen)
	      { UserMoveEvent(data->fromX, data->fromY, x, y, 'q');
		data->fromX = -1;
		data->fromY = -1;
	      }
	      else
	      { data->toX = x;
		data->toY = y;
		PromotionPopUp(cl, obj);
	      }
	    }
	    else
	    { UserMoveEvent(data->fromX, data->fromY, x, y, NULLCHAR);
	    }
	  }
	}
	break;
    }
  }
  return(0);
}
/**/


/*** MUIM_Setup method
**/
ULONG xboardmSetup(Class *cl, Object *obj, struct MUIP_Setup *msg)

{ XBoardClassData *data = INST_DATA(cl, obj);
  ULONG result;

  if ((result = DoSuperMethodA(cl, obj, (Msg) msg)))
  { MUI_RequestIDCMP(obj, IDCMP_MOUSEBUTTONS);

    if ((data->lightSquarePen = data->reqLightSquarePen) == -1)
    { data->lightSquarePen = muiRenderInfo(obj)->mri_Pens[MPEN_HALFSHINE];
    }
    if ((data->darkSquarePen = data->reqDarkSquarePen) == -1)
    { data->darkSquarePen = muiRenderInfo(obj)->mri_Pens[MPEN_HALFSHADOW];
    }
    if ((data->whitePiecePen = data->reqWhitePiecePen) == -1)
    { data->whitePiecePen = muiRenderInfo(obj)->mri_Pens[MPEN_SHINE];
    }
    if ((data->blackPiecePen = data->reqBlackPiecePen) == -1)
    { data->blackPiecePen = muiRenderInfo(obj)->mri_Pens[MPEN_SHADOW];
    }
  }
  return(result);
}
/**/


/*** MUIM_Cleanup method
**/
ULONG xboardmCleanup(Class *cl, Object *obj, Msg msg)

{ MUI_RejectIDCMP(obj, IDCMP_MOUSEBUTTONS);
  return(DoSuperMethodA(cl, obj, msg));
}
/**/


/****** XBoard.mcc/MUIM_XBoard_DrawPosition ********************************
*
*   NAME
*       MUIM_XBoard_DrawPosition - draw a position
*
*   SYNOPSIS
*       (VOID) DoMethod(Object *XBoardObj, MUIM_XBoard_DrawPosition,
*                       ULONG fullRedraw, Board *board);
*
*   FUNCTION
*       This method redraws the chessboard and sets up a certain
*       position.
*
*   INPUTS
*       fullRedraw - if this is FALSE, the gadget will redraw only
*           those parts of the chessboard which have changed since
*           the last position
*       board - the position to display; NULL is a valid argument
*           and means to display the last position again
*
***************************************************************************/
ULONG xboardmDrawPosition(Class *cl, Object *obj, Msg msg)

{ XBoardClassData *data = INST_DATA(cl, obj);
  int fullRedraw;
  Board *board;
  va_list args = (va_list) msg;

  (void) va_arg(args, ULONG);
  fullRedraw = va_arg(args, int);
  board = va_arg(args, Board *);

  if (board)
  { CopyMem(board, data->currentBoard, sizeof(*board));
  }
  MUI_Redraw(obj, fullRedraw ? MADF_DRAWOBJECT : MADF_DRAWUPDATE);
  return(TRUE);
}
/**/


/*** MuiClassInit() function
**/
VOID MuiClassInit(VOID)

{ if ((MUIMasterBase = OpenLibrary((STRPTR) "muimaster.library", 8)))
  { if ((SuperClass = MUI_GetClass(MUIC_Area)))
    { if ((ThisClass = MakeClass(NULL, NULL, SuperClass,
				 sizeof(XBoardClassData), 0)))
      { ThisClass->cl_Dispatcher.h_Entry = (HOOKFUNC) XBoardClassDispatcher;
	ThisClass->cl_Dispatcher.h_SubEntry = NULL;
	ThisClass->cl_Dispatcher.h_Data = NULL;

	InitBuiltinBitmaps();
	return;
      }
    }
  }
  exit(10);
}
/**/


/*** MuiClassClose() function
**/
VOID MuiClassClose(VOID)

{ if (ThisClass)
  { FreeClass((Class *) ThisClass);
  }
  if (SuperClass)
  { MUI_FreeClass(SuperClass);
  }
  if (MUIMasterBase)
  { CloseLibrary(MUIMasterBase);
  }
}
/**/


/*** XBoardObject() function
**/
APTR XBoardObject(Tag firsttag, ...)

{ return(NewObjectA(ThisClass, NULL, (struct TagItem *) &firsttag));
}
/**/
