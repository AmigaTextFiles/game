/***************************************************************************
                          cspacepartition.h  -  description
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

#ifndef CSPACEPARTITION_H
#define CSPACEPARTITION_H

#include <vector>

using namespace std;

/**
  *@author Marius
  */

class CSpacePartition
{
  public: 
  CSpacePartition();
  ~CSpacePartition();


  private:
  vector<int> mList;
  int mListSize;
  int mX, mY;
};

#endif
