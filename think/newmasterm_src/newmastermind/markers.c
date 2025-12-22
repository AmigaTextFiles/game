/*
 * markers.c
 * =========
 * The markers.
 *
 * Copyright (C) 1994-2000 Håkan L. Younes (lorens@hem.passagen.se)
 */

#include <intuition/screens.h>
#include <graphics/gfxbase.h>

#include <proto/graphics.h>

#include "markers.h"


static BOOL colorDisplay;
static BOOL useColors;

#define NUM_GAMEPENS 8

static LONG gamePens[NUM_GAMEPENS];
static ULONG gameColors[NUM_GAMEPENS][3] = {
  { 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF },
  { 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000 },
  { 0xFFFFFFFF, 0x88888888, 0x00000000 },
  { 0xFFFFFFFF, 0x00000000, 0x00000000 },
  { 0x00000000, 0xDDDDDDDD, 0x00000000 },
  { 0x00000000, 0xAAAAAAAA, 0xFFFFFFFF },
  { 0x88888888, 0x00000000, 0xFFFFFFFF },
  { 0x00000000, 0x00000000, 0x00000000 }
};

static struct TextFont *romFont = NULL;
static struct TextAttr topaz8 = {
  "topaz.font", 8, 0, FPF_ROMFONT
};


static VOID ReleaseGamePens(struct Screen *scr) {
  UBYTE i;

  for (i = 0; i < NUM_GAMEPENS; i++) {
    ReleasePen(scr->ViewPort.ColorMap, gamePens[i]);
  }
}


static VOID Line(struct RastPort *rp, LONG x1, LONG y1, LONG x2, LONG y2) {
  Move(rp, x1, y1);
  Draw(rp, x2, y2);
}


static VOID DrawLargeEllipse(struct RastPort *rp, struct DrawInfo *dri,
			     LONG x, LONG y, BOOL recessed) {
  UWORD shine = (dri->dri_Pens[SHINEPEN] != dri->dri_Pens[SHADOWPEN]) ?
    SHINEPEN : BACKGROUNDPEN;

  SetAPen(rp, (ULONG)dri->dri_Pens[(recessed ? SHADOWPEN : shine)]);
  Line(rp, x + 12, y + 1, x + 11, y + 1);
  Line(rp, x + 10, y, x + 6, y);
  Line(rp, x + 5, y + 1, x + 4, y + 1);
  Line(rp, x + 3, y + 2, x + 2, y + 2);
  Line(rp, x + 1, y + 3, x + 1, y + 4);
  Line(rp, x, y + 5, x, y + 9);
  Line(rp, x + 1, y + 10, x + 1, y + 11);
  SetAPen(rp, (ULONG)dri->dri_Pens[(recessed ? shine : SHADOWPEN)]);
  Line(rp, x + 4, y + 13, x + 5, y + 13);
  Line(rp, x + 6, y + 14, x + 10, y + 14);
  Line(rp, x + 11, y + 13, x + 12, y + 13);
  Line(rp, x + 13, y + 12, x + 14, y + 12);
  Line(rp, x + 15, y + 11, x + 15, y + 10);
  Line(rp, x + 16, y + 9, x + 16, y + 5);
  Line(rp, x + 15, y + 4, x + 15, y + 3);
  SetAPen(rp, (ULONG)dri->dri_Pens[BACKGROUNDPEN]);
  Line(rp, x + 14, y + 2, x + 13, y + 2);
  Line(rp, x + 2, y + 12, x + 3, y + 12);
}


static VOID DrawSmallEllipse(struct RastPort *rp, struct DrawInfo *dri,
			     LONG x, LONG y, BOOL recessed) {
  UWORD shine = (dri->dri_Pens[SHINEPEN] != dri->dri_Pens[SHADOWPEN]) ?
    SHINEPEN : BACKGROUNDPEN;

  SetAPen(rp, (ULONG)dri->dri_Pens[(recessed ? SHADOWPEN : shine)]);
  Line(rp, x + 4, y, x + 2, y);
  WritePixel(rp, x + 1, y + 1);
  Line(rp, x, y + 2, x, y + 4);
  SetAPen(rp, (ULONG)dri->dri_Pens[(recessed ? shine : SHADOWPEN)]);
  Line(rp, x + 2, y + 6, x + 4, y + 6);
  WritePixel(rp, x + 5, y + 5);
  Line(rp, x + 6, y + 4, x + 6, y + 2);
  SetAPen(rp, (ULONG)dri->dri_Pens[BACKGROUNDPEN]);
  WritePixel(rp, x + 5, y + 1);
  WritePixel(rp, x + 1, y + 5);
}


VOID DrawLargeMarker(struct RastPort *rp, struct DrawInfo *dri,
		     LONG x, LONG y, UBYTE color) {
  UBYTE numStr[2];

  if (color == 0) {
    SetAPen(rp, (ULONG)dri->dri_Pens[BACKGROUNDPEN]);
  } else if (useColors) {
    SetAPen(rp, gamePens[color - 1]);
  } else {
    SetAPen(rp, (ULONG)dri->dri_Pens[FILLPEN]);
  }
  Line(rp, x + 6, y + 1, x + 10, y + 1);
  Line(rp, x + 4, y + 2, x + 12, y + 2);
  Line(rp, x + 4, y + 12, x + 12, y + 12);
  Line(rp, x + 6, y + 13, x + 10, y + 13);
  Line(rp, x + 1, y + 5, x + 1, y + 9);
  Line(rp, x + 15, y + 5, x + 15, y + 9);
  RectFill(rp, x + 2, y + 3, x + 14, y + 11);
  DrawLargeEllipse(rp, dri, x, y, color == 0);
  if (!useColors && color != 0) {
    SetAPen(rp, (ULONG)dri->dri_Pens[FILLTEXTPEN]);
    SetBPen(rp, (ULONG)dri->dri_Pens[FILLPEN]);
    numStr[0] = color + '0';
    numStr[1] = '\0';
    SetFont(rp, romFont);
    Move(rp, x + (LMARKER_W - rp->TxWidth) / 2,
	 y + (LMARKER_H - rp->TxBaseline) / 2 + rp->TxBaseline);
    Text(rp, numStr, 1);
  }
}


VOID DrawSmallMarker(struct RastPort *rp, struct DrawInfo *dri,
		     LONG x, LONG y, UBYTE color) {
  if (color == 0) {
    SetAPen(rp, (ULONG)dri->dri_Pens[BACKGROUNDPEN]);
  } else if (useColors) {
    SetAPen(rp, gamePens[color - 1]);
  } else if (color == WHITE_COLOR) {
    if (dri->dri_Pens[HIGHLIGHTTEXTPEN] != dri->dri_Pens[TEXTPEN]) {
      SetAPen(rp, (ULONG)dri->dri_Pens[HIGHLIGHTTEXTPEN]);
    } else {
      SetAPen(rp, (ULONG)dri->dri_Pens[BACKGROUNDPEN]);
    }
  } else {
    SetAPen(rp, (ULONG)dri->dri_Pens[TEXTPEN]);
  }
  Line(rp, x + 2, y + 1, x + 4, y + 1);
  Line(rp, x + 2, y + 5, x + 4, y + 5);
  RectFill(rp, x + 1, y + 2, x + 5, y + 4);
  DrawSmallEllipse(rp, dri, x, y, color == 0);
}


BOOL InitMarkers(struct Screen *scr) {
  UBYTE i, j;

  romFont = OpenFont(&topaz8);
  if (romFont == NULL) {
    return FALSE;
  }

  for (i = 0; i < NUM_GAMEPENS; i++) {
    if (GfxBase->LibNode.lib_Version >= 39L) {
      gamePens[i] = ObtainBestPen(scr->ViewPort.ColorMap,
				  gameColors[i][0],
				  gameColors[i][1],
				  gameColors[i][2],
				  OBP_Precision, PRECISION_GUI,
				  TAG_DONE);
      for (j = 0; j < i - 1 && gamePens[i] != -1; j++) {
	if (gamePens[i] == gamePens[j]) {
	  ReleasePen(scr->ViewPort.ColorMap, gamePens[i]);
	  gamePens[i] = -1;
	}
      }
    } else {
      gamePens[i] = -1;
    }
  }

  colorDisplay = TRUE;
  for (i = 0; i < NUM_GAMEPENS && colorDisplay; i++) {
    if (gamePens[i] == -1) {
      colorDisplay = FALSE;
    }
  }
  useColors = colorDisplay;

  if (!colorDisplay) {
    ReleaseGamePens(scr);
  }

  return TRUE;
}


VOID FreeMarkers(struct Screen *scr) {
  if (romFont != NULL) {
    CloseFont(romFont);
    ReleaseGamePens(scr);
  }
}


BOOL UseColoredMarkers(VOID) {
  return useColors;
}


VOID SetColoredMarkers(BOOL b) {
  useColors = (b && colorDisplay);
}
