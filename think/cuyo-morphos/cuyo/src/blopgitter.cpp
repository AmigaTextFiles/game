/***************************************************************************
                          blopgitter.cpp  -  description
                             -------------------
    begin                : Thu Jul 12 2001
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

#include "fehler.h"
#include "blopgitter.h"

/** re: true bei rechtem Spieler */
BlopGitter::BlopGitter(bool re, Spielfeld * spf) : BlopBesitzer(spf) {
  mSpf = spf;
  for (int x = 0; x < grx; x++)
    for (int y = 0; y <= gry; y++)
      mDaten[x][y].setBesitzer(this, ort_absolut(absort_feld, re, x, y));
  /* Bevor das BlopGitter benutzt wird, muss noch init() aufgerufen werden. */
}
BlopGitter::~BlopGitter() {
}


/** Lˆscht alles (am Level-Anfang) */
void BlopGitter::init() {
  for (int x = 0; x < grx; x++)
    for (int y = 0; y <= gry; y++)
      mDaten[x][y] = Blop(blopart_keins);

  mRueberReihe = false;
  //mTestPlatz = false;

}


/** Liefert true, wenn was am platzen ist */
bool BlopGitter::getWasAmPlatzen() const {

  for (int x = 0; x < grx; x++)
    for (int y = 0; y < getGrY(); y++)
      if (mDaten[x][y].getAmPlatzen())
	return true;
	
  return false;
}


/** Sendet allen Blops init-Events. Innerhalb einer Gleichzeit aufrufen. */
// void BlopGitter::initEvents() {
//   for (int x = 0; x < grx; x++)
//     for (int y = 0; y < getGrY(); y++)
//       mDaten[x][y].execEvent(event_init);
// }



/** Animiert alle Blops. Innerhalb einer Gleichzeit aufrufen. */
void BlopGitter::animiere() {
  //CASSERT(Blop::gGleichZeit);

  //mNeuePunkte = 0;

  for (int x = 0; x < grx; x++)
    for (int y = 0; y < getGrY(); y++)
      mDaten[x][y].animiere();
}


/** Liefert ein Feldinhalt zur¸ck */
const Blop & BlopGitter::getFeld(int x, int y) const {
  CASSERT(koordOK(x, y));
  return mDaten[x][y];
}



/** Liefert ein Feldinhalt zur¸ck */
Blop & BlopGitter::getFeld(int x, int y) {
  CASSERT(koordOK(x, y));
  return mDaten[x][y];
}


/** liefert true, wenn der Blob bei x, y sich mit b verbinden kann. */
bool BlopGitter::getFeldVerbindbar(int x, int y, const Blop & b) const {
  if (!koordOK(x, y)) {
    /* Auﬂerhalb vom Rand genau dann verbinden, wenn die Sorte das
       Special hat */
    bool ret = true;
    if (x < 0) ret &= b.verbindetMitRand(rand_links);
    if (x >= grx) ret &= b.verbindetMitRand(rand_rechts);
    if (y < 0) ret &= b.verbindetMitRand(rand_oben);
    if (y >= getGrY()) ret &= b.verbindetMitRand(rand_unten);
    return ret;
  } else
    return b.verbindetMit(mDaten[x][y]);
		
  return false; // Um keine Warnung zu bekommen
}




/*
void BlopGitter::verschiebBlop(int x1, int y1, int x2, int y2,
              bool hinterlasseLeer) {
  mDaten[x2][y2] = mDaten[x1][y1];
  mDaten[x1][y1] = Blop(blopart_keins);
}
*/



/** liefert die Feldart bei x, y; (d. h. grau oder gras oder leer
    oder normaler Stein oder auﬂerhalb vom Spielfeld). */
int BlopGitter::getFeldArt(int x, int y) const {
  if (x < 0 || x >= grx || y >= getGrY())
    return blopart_ausserhalb;
  else if (y < 0)
    return blopart_keins;
  else
    return mDaten[x][y].getArt();
}


/** Testet das Verhalten des Blobs bei x,y. Liefert false, wenn es den
    Blob gar nicht gibt. */
bool BlopGitter::getFeldVerhalten(int x, int y, int verhalten) const {
  if (x < 0 || x >= grx || y < 0 || y >= getGrY())
    return false;
  else
    return mDaten[x][y].getVerhalten(verhalten);
}


/** liefert eine VerbindungsBitliste f¸r den Blop bei x, y. */
int BlopGitter::getBesitzVerbindungen(int x, int y) const {
  int verb = 0;
  const Blop & b = mDaten[x][y];
	
  /* Sonderf‰lle bei Sechseck-Muster:
     os = obenschr‰g; 1, wenn die Verbinung nach lo / ro wirklich
     schr‰g ist...*/
  int os = !ld->mSechseck | (x & 1);
  /* Dito f¸r unten */
  int us = !ld->mSechseck | !(x & 1);

  /* Bei Sechtsecken keine waag. Verbindung */
  if (!ld->mSechseck) {
    if (getFeldVerbindbar(x - 1, y, b)) verb += verbindung_links;
    if (getFeldVerbindbar(x + 1, y, b)) verb += verbindung_rechts;
  }
  if (getFeldVerbindbar(x, y - 1, b)) verb += verbindung_oben;
  if (getFeldVerbindbar(x, y + 1, b)) verb += verbindung_unten;
  			
  if (getFeldVerbindbar(x - 1, y - os, b)) verb += verbindung_lo;
  if (getFeldVerbindbar(x - 1, y + us, b)) verb += verbindung_lu;
  if (getFeldVerbindbar(x + 1, y - os, b)) verb += verbindung_ro;
  if (getFeldVerbindbar(x + 1, y + us, b)) verb += verbindung_ru;

  /* Bits an Spiegelung anpassen */
  if (ld->mSpiegeln) {
#define TAUSCH_BITS(b1, b2) if ((verb & (b1+b2)) != 0 && (verb & (b1+b2)) != b1+b2) verb ^= b1+b2;
    TAUSCH_BITS(verbindung_oben, verbindung_unten);
    TAUSCH_BITS(verbindung_lo, verbindung_lu);
    TAUSCH_BITS(verbindung_ro, verbindung_ru);
#undef TAUSCH_BITS
  }


  return verb;
}


/** liefert true, wenn (x,y) im Spielfeld liegt */
bool BlopGitter::koordOK(int x, int y) const {
  return x >= 0 && x < grx && y >= 0 && y < getGrY();
}



/** Setzt, ob die R¸berreihe existiert. */
void BlopGitter::setRueberReihe(bool ex){
  mRueberReihe = ex;
  //mTestPlatz = true;
  /* ... Ist fast sicher unnˆtig, weil beim Reihe r¸bergeben
     sowieso genug passiert, was mTestPlatz auf true setzt */
}


/** Liefert die Anzahl der Zeilen zur¸ck, d. h. normalerweise
gry; aber wenn die R¸bergebreihe existiert, dann eins mehr. */
int BlopGitter::getGrY() const{
  return mRueberReihe ? gry + 1 : gry;
}


/** Liefert true, wenn man mal wieder testen sollte, ob was
platzt. Achtung: Das Flag wird bei diesem Aufruf gleich
gelˆscht. */
/*
bool BlopGitter::getTestPlatz(){
  bool r = mTestPlatz;
  mTestPlatz = false;
  return r;
}*/


/** Liefert true, wenn (x, y) und alle dar¸ber liegenden
Felder frei sind. Wird von Fall benˆtigt. */
bool BlopGitter::testPlatzSpalte(int x, int y){
  if (!koordOK(x, y))
    return false;
  /* Das Fall mˆchte nicht in die R¸berreihe fallen. */
  if (y == gry)
    return false;
  while (y >= 0) {
    if (mDaten[x][y].getArt() != blopart_keins)
      return false;
    y--;
  }
  return true;
}



/** Sendet an alle Blops das connect-Event. */
void BlopGitter::sendeConnectEvent() {
  for (int x = 0; x < grx; x++)
    for (int y = 0; y < gry; y++)
      mDaten[x][y].execEvent(event_connect);
}




