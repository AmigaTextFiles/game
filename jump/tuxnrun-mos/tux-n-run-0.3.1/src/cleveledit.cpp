/***************************************************************************
                          cleveledit.cpp  -  description
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

#include "cbase.h"
#include "cleveledit.h"

CLevelEdit::CLevelEdit() {}
CLevelEdit::~CLevelEdit() {}

/** Initialize */
int CLevelEdit::init(map < string , string > & arguments, CBase *base)
{
  mBase = base;
  mSDL = mBase->getSDL();
  return 0;
}

/** Clean up */
void CLevelEdit::cleanUp()
{

}

/** Render the display */
int CLevelEdit::render()
{
  return 0;
}

/** Update */
void CLevelEdit::update(CInput & Input)
{

}
