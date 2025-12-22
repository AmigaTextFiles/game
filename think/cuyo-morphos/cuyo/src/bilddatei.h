/***************************************************************************
                          bilddatei.h  -  description
                             -------------------
    begin                : Fri Apr 20 2001
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

#ifndef BILDDATEI_H
#define BILDDATEI_H

#include <SDL.h>

#include "sdltools.h"

#include "stringzeug.h"

#define gric 32 // Größe der Bildchen

/* Zur Übergabe an malBildchen(): Welches Viertel soll gemalt werden?
   Entweder viertel_alle übergeben oder
   viertel_q** | viertel_z**
   Ersteres (Quelle) gibt an, welches Viertel aus der Datei genommen wird,
   zweiteres (Ziel) in welches Viertel gemalt wird.
*/
#define viertel_alle (-1)

/* Achtung: Wenn die nachfolgenden Konstanten geändert werden, muss
   auch const_werte in blop.cpp geändert werden. */
#define viertel_qlo 0
#define viertel_qro 1
#define viertel_qlu 2
#define viertel_qru 3

#define viertel_zlo 0
#define viertel_zro 4
#define viertel_zlu 8
#define viertel_zru 12

/* Bit-Masken... */
#define viertel_qr 1
#define viertel_qu 2
#define viertel_zr 4
#define viertel_zu 8

/* Für range-Check (siehe BildStapel::speichereBild()) */
#define viertel_min (-1)
#define viertel_max 15


class BildOriginal;

/**verwaltet ein xpm als Ansammlung von 16x16-Bildchen
  *@author Immi
  */

class Bilddatei {
 public: 
  Bilddatei();
  ~Bilddatei();
  
  void datenLoeschen();

  /* Für gleiche Quelle aber unabhängige Nachbearbeitung.
     Diese wird gleich schon mal in Form einer Umfärbung vollzogen. */
  Bilddatei(Bilddatei *, const Color &);


  /** Lädt das Bild mit dem angegebenen Namen. Sucht in verschiedenen
      Pfaden danach.Throwt ggf. */
  void laden(Str name);
  void klonen(Bilddatei & quelle);

  /** Macht aus dem Original-Bild die gefaerbte und auf Bildschirmformat
      gebrachte Version (mBild). Wird von laden() automatisch aufgerufen;
      muss aber nochmal aufgerufen werden, wenn sich die Farben geaendert
      haben. */
  void bildNachbearbeiten();
  void bildNachbearbeiten(const Color & faerbung);
		
  /** malt das k-te Viertel vom n-te Bildchen an xx,yy. Oder evtl. das
      ganze Bildchen */
  void malBildchen(int xx, int yy,
		   int n, int k = viertel_alle) const;
  /** liefert zurück, wie viele Bildchen in dieser Datei sind. */
  int anzBildchen() const;
  /** malt das gesamte Bild */
  void malBild(int xx, int yy) const;
  /** malt einen beliebigen Bildausschnitt */
  void malBildAusschnitt(int xx, int yy, const SDL_Rect & src) const;
  /** liefert die Gesamtbreite in Pixeln zurück */
  int getBreite() const;
  /** liefert die Gesamthoehe in Pixeln zurück */
  int getHoehe() const;

  /** liefert true, wenn das Bild (erfolgreich) geladen ist */
  bool istGeladen() const {return mBild != 0;}
  
  /** Nur zum anschauen, nicht zum veraendern! Liefert das Bild in unskaliert
      und 32 Bit. */
  SDL_Surface * getSurface() const;
	
 protected:
  /* Die interne Version von bildNachbearbeiten.
     Es sind zwei, damit man zwischen ihnen noch Zeug tun kann,
     wie etwa umfärben.
     Die erste erledigt das Skalieren, die zweite das Umformatieren. */
  SDL_Surface * bildNachbearbeiten1();
  void bildNachbearbeiten2(SDL_Surface *);

  BildOriginal * mBildOriginal;
  SDL_Surface * mBild;
  int mBreite, mHoehe;
  Str mName; // Fuer bessere Fehlermeldungen
};

#endif
