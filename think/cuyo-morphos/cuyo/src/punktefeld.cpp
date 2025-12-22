/***************************************************************************
                          spielfeld.cpp  -  description
                             -------------------
    begin                : Sat Oct 2 1999
    copyright            : (C) 1999 by immi
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

#include <ctime>
#include <cstdio>

#include "punktefeld.h"
#include "leveldaten.h"


Bilddatei Punktefeld::gZiffernBild[2];


unsigned int Punktefeld::gRandSeed = (time(0) % 8191) | 1;


Punktefeld::Punktefeld():
        mPunkte(-1), mAugenZu(-1), mUpdateNoetig(true) {

}



void Punktefeld::setPunkte(int p) {
  mPunkte = p;
  mUpdateNoetig = true;
}



void Punktefeld::zwinkerSchritt() {
  if (mAugenZu >= 0) mUpdateNoetig = true;
  
  /* Hat mir mal jemand einen Pseudozufalls-Algorithmus? */
  gRandSeed = (gRandSeed * 2369) % 8191;
  
  //fprintf(stderr, "%d\n", gRandSeed);
  if (gRandSeed < 300) {
    mAugenZu = gRandSeed / 60;
    mUpdateNoetig = true;
  } else
    mAugenZu = -1;
}






/* Malt, falls noetig, die Punkte neu */
void Punktefeld::updateGraphik() {

  if (!mUpdateNoetig) return;
  mUpdateNoetig = false;

  Area::updateRect(0, 0, gric * grx, 32);
  Area::fillRect(0, 0, gric * grx, 32, Color(200, 200, 200));

  int x = gric * grx;
  if (mPunkte >= 0) {
    int pt = mPunkte;
    int n = 0;
    do {
      x -= 24;
      gZiffernBild[mAugenZu == n].malBildchen(x, 0, pt % 10);
      n++;
      pt /= 10;
    } while (pt > 0);

  }
} 



void Punktefeld::init() {
  gZiffernBild[0].laden("pktZiffern.xpm");
  gZiffernBild[1].laden("pktZiffern2.xpm");
}
