/***************************************************************************
                          fall.h  -  description
                             -------------------
    begin                : Sat Aug 18 2001
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

#ifndef FALL_H
#define FALL_H

#include <SDL.h>

#include "blop.h"
#include "blopbesitzer.h"
#include "bilddatei.h"
#include "leveldaten.h"


// wie das Fallende sein kann
#define richtung_keins 0
#define richtung_einzel 1
#define richtung_waag 2
#define richtung_senk 3

// Wert für get_X bis get_YY, wenn das Blop nicht existiert
#define blop_pos_nix -1



struct FallPos {
  /** x-Koord vom Fall in Feldern */
  int x;
  /** y-Koord vom Fall in Pixeln (absolut, und nicht relativ zum ggf.
      wegen Rüberreihen verschobenen Spielfeld) */
  int yy;
  /** Richtung und Anzahl der Blops. Siehe Konstanten. */
  int r;
	
  /** Liefert die Anzahl der Blops vom Fall zurück. */
  int getAnz() const {
    if (r == richtung_keins)
      return 0;
    else if (r == richtung_einzel)
      return 1;
    else
      return 2;
  }
	
  int getX(int a) const {
    return x + a * (r == richtung_waag);
  }

  /** ... hv = aktuelle Hochverschiebung... */
  int getY(int a, int hv) const {
    int y0 = yy + gric - 1 + hv;
    /* Korrektur bei ungeraden Spalten im Sechseck-Modus... */
    if (ld->mSechseck && (getX(a) & 1))
      y0 += gric / 2;
			
    return y0 / gric + a * (r == richtung_senk);
  }

};


class Spielfeld;

/** Enthält alle Informationen über das Fall: Existenz, Position
		(inkl. genaue Drehpos), Farben, ...
  *@author Immi
  */

class Fall: public BlopBesitzer {
 public:

  /** Konstruktor... */
  Fall(Spielfeld * sp, bool re);


  /** Position vom Fall. */
  FallPos mPos;

 private:
  /** True, wenn rechter Spieler (für Sound nötig) */
  bool mRechterSpieler;
  /** Schnell fallen? */
  bool mSchnell;
  /** Ist es noch nicht ganz fertiggedreht? */
  int mExtraDreh;
  /** Ist es noch nicht ganz fertig waagrecht verschoben? */
  int mExtraX;
  /** Wurde Taste links bzw. rechts gedrückt? */
  int mExtraLinks, mExtraRechts;
  /** Die Blops */
  Blop mBlop[2];
  /** Rechteck, das den Bereich ueberdeckt, wo das Fall im Moment
      hingemalt ist (fuer Grafik-Updates). */
  int mRectX, mRectY, mRectW, mRectH;

	
  /** kopiert einen fallenden Blop nach mDaten und liefert den
      Zielblop in mDaten zurück (als Referenz), damit man einen
      land-Event senden kann. Sendet den land-Event nicht selbst,
      weil Cual-Code erwarten könnte, dass erst beide Blops
      gefestigt werden und dann erst die Events kommen.
      Kann 0 zurückliefern (wenn der Blop keinen Platz auf
      dem Bildschirm hat). */
  Blop * festige(int n);
	
  /** Liefert true, wenn das Fall grade auf Tastendrücke reagiert */
  bool steuerbar() {
    return mPos.r == richtung_waag || mPos.r == richtung_senk;
  }
	
  /** Prueft, ob an Position p schon was im Weg ist oder nicht.
      Wenn irgendwo drüber in der Spalte was ist, zählt das auch
      als im Weg.
      @return eine Konstante belegt_... */
  int testBelegt(FallPos p) const;

  /** Liefert die Anzahl der Bklops vom Fall zurück. */
  int getAnz() const {
    return mPos.getAnz();
  }
	
  /** Liefert true, wenn das Fallende senkrecht ist */
  bool istSenkrecht() const;
	
  /** Lässt nur noch Blop a übrig */
  void halbiere(int a);
	
  int getX(int a) const;
  int getY(int a) const;

  int getXX(int a) const;
  int getYY(int a) const;

  /** Kodiert alle Informationen des Drehens in eine Zahl.
      Ist für getXX und getYY da */
  int getDrehIndex(int a) const;

  /** Bestimm mFallRect neu (Fall-ueberdeckendes Rechteck) */
  void calcFallRect();

  /** Setzt den Bereich, der durch mFallRect angegeben ist, auf
      upzudaten */
  void setUpdateFallRect();

 public:
 
  /**  Muß einmal aufgerufen werden */
  void initialisiere();

  /** Erzeugt ein neues Fall. Liefert false, wenn dafür kein Platz ist */
  bool erzeug();
  /** Entfernt das Fall ganz */
  void zerstoere();

	
 private:
  /** Macht alles von spielSchritt ausser Grafik-Update  markieren */
  void spielSchrittIntern();
  
 public:
  /** Bewegt das Fall ggf. nach unten und kümmert sich ggf. um
      Verwandlungen. */
  void spielSchritt();
  
  /** Führt die Animationen durch. Innerhalb einer Gleichzeit aufrufen. */
  void  animiere();

  /** Bewegt das Fall eins nach links. Wird in einer Gleichzeit aufgerufen. */
  void tasteLinks();
  /** Bewegt das Fall eins nach rechts. Wird in einer Gleichzeit aufgerufen. */
  void tasteRechts();
  /** Dreht das Fall.
      Version 1 wird in einer Gleichzeit aufgerufen,
      Version 2 danach außerhalb von Gleichzeiten. */
  void tasteDreh1();
  void tasteDreh2();
  /** Ändert die Fallgeschwindigkeit vom Fall.
      Wird in einer Gleichzeit aufgerufen. */
  void tasteFall();

  /** Liefert true, wenn das Fall (noch) am Platzen ist
      (wg. Spielende) */
  bool getAmPlatzen() const;
  /** Liefert einen Pointer auf die Blops zurück. Wird vom
      KIPlayer und von ort_absolut::finde() benötigt. */
  const Blop * getBlop() const;
  Blop * getBlop();
  /** Lässt alle Blops vom Fall platzen (Spielende). */
  void lassPlatzen();
  /** Malt das Fall. */
  void malen() const;
  /** Liefert true, wenn das Fall existiert.
      Mit Argument: Wenn diese Hälfte existiert. */
  bool existiert(int a=0) const;
  /** Liefert true, wenn das Fall aus grade am zerfallen ist
      (d. h. existiert, aber aus nur noch einem Blop besteht).
      In dieser Zeit darf nämlich keine Explosion gezündet
      werden. (Erst warten, bis der andere Blop auch angekommen
      ist.) */
  bool istEinzel() const;
  void playSample(int nr) const;

  virtual int getSpezConst(int vnr) const;

};

#endif

