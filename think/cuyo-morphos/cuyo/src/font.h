/***************************************************************************
                          font.h  -  description
                             -------------------
    begin                : Fri Jul 21 2006
    copyright            : (C) 2000 by Immi
                           Part of the code is stolen from supertux 0.1.2
                           (which is under GPL)
    email                : cuyo@pcpool.mathematik.uni-freiburg.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef FONT_H
#define FONT_H


#include <SDL.h>
#include "bilddatei.h"

class Str;

enum TextAlign {
  AlignCenter = 0,

  AlignHCenter = 0,
  AlignLeft = 1,
  AlignRight = 2,
  AlignHMask = 3,

  AlignVCenter = 0,
  AlignTop = 4,
  AlignBottom = 8,
  AlignVMask = 12,
  
  AlignTopLeft = AlignTop | AlignLeft,
  AlignTopRight = AlignTop | AlignRight,
  AlignBottomLeft = AlignBottom | AlignLeft,
  AlignBottomRight = AlignBottom | AlignRight
};


class Font {

  Bilddatei mChars;
  int mCharsPerLine;
  int mWidth;
  int mHeight;
  int (*mChar2Pos)(char);
  int mCharLeft[256], mCharWidth[256];
 
 public:
  Font(const Str & filename, int w, int h, int (*c2p)(char),
       bool varWidth, int addToWidth = 0);

  /* Lift von Bilddatei::Bilddatei(Bilddatei *, const Color &) */
  Font(Font *, const Color &);
  
  int getFontHeight() const;
  
  void drawText(const Str & text, int x, int y, TextAlign align = AlignCenter) const;
  /* Increments x by charWidth */
  void drawChar(char c, int & x, int y) const;
  
  void wordBreak(Str & text, int width) const;

  /* Returns only the width of the first line of text */
  int getLineWidth(const char * text) const;
  
  int getTextHeight(const char * text) const;


  static Font * gMenu;
  static Font * gBright;
  static Font * gDimmed;
  static Font * gBrightDimmed;
  static Font * gTitle;
  static Font * gData;
  static Font * gGame;
  static Font * gDbg;

  static void init();
  static void destroy();
  static void setGameColor(const Color & c);
  
};




#endif
