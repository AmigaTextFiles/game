/***************************************************************************
                          blopbesitzer.cpp  -  description
                             -------------------
    begin                : Sat Jul 14 2001
    copyright            : (C) 2001 by Immi
    email                : cuyo@karimmi.de
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

#include "cuyointl.h"
#include "blopbesitzer.h"
#include "fehler.h"
#include "spielfeld.h"

BlopBesitzer::BlopBesitzer(Spielfeld * spf) : mSpf(spf) {}

/** Liefert - bei Blopgittern - den Blop an der entsprechenden
    Koordinate. Darf sonst nicht aufgerufen werden. Darf auch
    nicht mit falschen Koordinaten aufgerufen werden. Wird benötigt
    bei Variablen mit relativen Koordinaten. */
const Blop & BlopBesitzer::getFeld(int /*x*/, int /*y*/) const {
  throw iFehler(_("Internal error in const BlopBesitzer::getFeld()"));
}

/** Dito */
Blop & BlopBesitzer::getFeld(int /*x*/, int /*y*/) {
  throw iFehler(_("Internal error in BlopBesitzer::getFeld()"));
}

const Blop * BlopBesitzer::getFall(int a) const {
  return mSpf->getFall()+a;
}

Blop * BlopBesitzer::getFall(int a) {
  return mSpf->getFall()+a;
}

int BlopBesitzer::getSpezConst(int /*vnr*/) const {
  return spezconst_defaultwert;
}
