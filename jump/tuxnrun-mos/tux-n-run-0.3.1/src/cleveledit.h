/***************************************************************************
                          cleveledit.h  -  description
                             -------------------
    begin                : Sat Jun 14 2003
    copyright            : (C) 2003 by Marius Andra
    email                : marius@hot.ee
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#ifndef CLEVELEDIT_H
#define CLEVELEDIT_H

#include <map>
#include <string>

#include "cinput.h"
#include "csdl.h"

class CBase;

using namespace std;

/**
  *@author Marius
  */

class CLevelEdit
{
  public: 
  CLevelEdit();
  ~CLevelEdit();
  /** Initialize */
  int init(map < string , string > & arguments, CBase *base);
  /** Update */
  void update(CInput & Input);
  /** Render the display */
  int render();
  /** Clean up */
  void cleanUp();

  private:
  CBase *mBase;
  CSDL *mSDL;
};

#endif
