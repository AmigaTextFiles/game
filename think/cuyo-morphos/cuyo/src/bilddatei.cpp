/***************************************************************************
                          bilddatei.cpp  -  description
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

#include <cstdlib>
#include <cstdio>

#include "sdltools.h"

#include "cuyointl.h"
#include "bilddatei.h"
#include "fehler.h"
#include "pfaditerator.h"
#include "stringzeug.h"
#include "xpmladen.h"
#include "inkompatibel.h"
#include "global.h"


/**********************************************************************/

class BildOriginal {
 public:
  SDL_Surface * mBild;
 private:
  int mAnzUser;
  
 public:
  BildOriginal(SDL_Surface * b): mBild(b), mAnzUser(1) {}
  ~BildOriginal() { SDL_FreeSurface(mBild); }
  
  void anmelden() {
    mAnzUser++;
  }
  
  void abmelden() {
    mAnzUser--;
    if (mAnzUser == 0)
      delete this;
  }
  
};  // BildOriginal



/**********************************************************************/

bool gMod4Warnung = false;


/* s must be 32 bit... */
SDL_Surface * scaleSurface(SDL_Surface * s) {

  int w2 = s->w * 3 / 4;
  int h2 = s->h * 3 / 4;
  SDL_Surface * ret = SDLTools::createSurface32(w2, h2);

  SDL_LockSurface(s);
  SDL_LockSurface(ret);

  for (int y = 0; y < h2; y++) {
    for (int x = 0; x < w2; x++) {
      Uint8 * dst = (Uint8 *)ret->pixels + ret->pitch * y + 4 * x;
      Uint8 * src = (Uint8 *)s->pixels + s->pitch * (y * 4 / 3) + 4 * (x * 4 / 3);
      Uint32 srcpix[4]; // LO, RO, LU, RU
      srcpix[0] = * (Uint32*) src;
      srcpix[1] = * (Uint32*) (src + 4);
      srcpix[2] = * (Uint32*) (src + s->pitch);
      srcpix[3] = * (Uint32*) (src + s->pitch + 4);
      Uint32 anteil[4];
      anteil[0] = (3 - x % 3) * (3 - y % 3);
      anteil[1] = (1 + x % 3) * (3 - y % 3);
      anteil[2] = (3 - x % 3) * (1 + y % 3);
      anteil[3] = (1 + x % 3) * (1 + y % 3);
      /* Hier ist erstmal Summe der Anteile = 16 */
      
      /* Alpha-Kanal einrechnen */
      Uint32 gesAlpha = 0;
      for (int j = 0; j < 4; j++) {
	Uint32 sp = srcpix[j];
	anteil[j] *= ((Uint8 *) &sp)[3];
	gesAlpha += anteil[j];
      }
      
      Uint8 dstpix[4];
      dstpix[3] = gesAlpha / 16;
      if (dstpix[3] > 0) {
	for (int i = 0; i < 3; i++) {
          Uint32 komponente = 0;
	  for (int j = 0; j < 4; j++) {
	    Uint32 sp = srcpix[j];
            komponente += anteil[j] * ((Uint8 *) &sp)[i];
	  }
	  komponente /= gesAlpha;
	  dstpix[i] = komponente;
	}
      }     
      * (Uint32*) dst = *((Uint32 *) &dstpix);
    }
  }

  SDL_UnlockSurface(s);
  SDL_UnlockSurface(ret);

  return ret;
}



/**********************************************************************/


Bilddatei::Bilddatei(): mBildOriginal(0), mBild(0) {
}
Bilddatei::~Bilddatei() {
  datenLoeschen();
}

Bilddatei::Bilddatei(Bilddatei * quelle, const Color & faerbung) :
    mBildOriginal(quelle->mBildOriginal), mBild(0), mBreite(quelle->mBreite), mHoehe(quelle->mHoehe),
    mName(quelle->mName) {
  CASSERT(mBildOriginal); // Kein Bild klonen, das selbst grad nicht geladen ist
  mBildOriginal->anmelden();
  bildNachbearbeiten(faerbung);
}



void Bilddatei::datenLoeschen() {
  if (mBild) {
    SDL_FreeSurface(mBild);
    mBild = 0;
  }
  if (mBildOriginal) {
    mBildOriginal->abmelden();
    mBildOriginal = 0;
  }
}


/** Lädt das Bild mit dem angegebenen Namen. Sucht in verschiedenen
    Pfaden danach.Throwt ggf. */
void Bilddatei::laden(Str name) {

  datenLoeschen();
  
  mName = name;
  
  Str s = _sprintf("pics/%s", name.data());

  /* Bild in verschiedenen Pfaden suchen... (Der Pfaditerator throwt ggf.)
     ladXPM kann auch throwen: Wenn eine .xpm.gz-Datei existiert, die
     von meiner Routine nicht geladen werden kann. */
  SDL_Surface * bild;
  for (PfadIterator pi(s,true); !(bild = ladXPM(pi.pfad())); ++pi) {}
  
  /* Ich will mit 32-Bit arbeiten */
  SDLTools::convertSurface32(bild);
  mBreite = bild->w;
  mHoehe = bild->h;
  
  mBildOriginal = new BildOriginal(bild);

  bildNachbearbeiten();
}


void Bilddatei::klonen(Bilddatei & quelle) {
  datenLoeschen();

  mBildOriginal = quelle.mBildOriginal;
  CASSERT(mBildOriginal); // Kein Bild klonen, das selbst grad nicht geladen ist
  mBildOriginal->anmelden();
  
  mBreite = quelle.mBreite;
  mHoehe = quelle.mHoehe;
  mName = quelle.mName;
}



SDL_Surface * Bilddatei::bildNachbearbeiten1() {
  if (gKlein)
    return scaleSurface(mBildOriginal->mBild);
  else
    return mBildOriginal->mBild;
}


void Bilddatei::bildNachbearbeiten2(SDL_Surface * tmp) {
  if (mBild)
    SDL_FreeSurface(mBild);

  mBild = SDLTools::maskedDisplayFormat(tmp);

  if (tmp!=mBildOriginal->mBild)
    SDL_FreeSurface(tmp);
}


void Bilddatei::bildNachbearbeiten() {
  bildNachbearbeiten2(bildNachbearbeiten1());
}


void Bilddatei::bildNachbearbeiten(const Color & faerbung) {
  SDL_Surface* src = bildNachbearbeiten1();
  SDL_LockSurface(src);

  bool gleich = (src!=mBildOriginal->mBild);
    /* Nicht, ob src und mBildOriginal gleich sind,
       sondern ob src und dst gleich sein sollen. */

  SDL_Surface* dst;
  if (gleich)
    dst=src;
  else {
    dst = SDLTools::createSurface32(src->w,src->h);
    SDL_LockSurface(dst);
  }

  for (int x = 0; x < src->w; x++)
    for (int y = 0; y < src->h; y++) {
      Uint32 & srcpix = SDLTools::getPixel32(src, x, y);
      Uint32 & dstpix = (gleich
        ? srcpix
        : SDLTools::getPixel32(dst, x, y));
      Uint8 rgba[4], r, g, b;
      SDL_GetRGBA(srcpix, src->format, &r, &g, &b, &rgba[3]);
      
      for (int i = 0; i < 3; i++)
        rgba[i] = (faerbung[i] * r + (255 - faerbung[i]) * g + 127) / 255;
      dstpix = SDL_MapRGBA(dst->format, rgba[0], rgba[1], rgba[2], rgba[3]);
      
    }

  SDL_UnlockSurface(src);
  if (!gleich) SDL_UnlockSurface(dst);

  bildNachbearbeiten2(dst);
}



/** malt das k-te Viertel vom n-te Bildchen an xx,yy. Oder evtl. das
    ganze Bildchen */
void Bilddatei::malBildchen(int xx, int yy,
			    int n, int k /*= viertel_alle*/) const {

  /* Richtigen Bildausschnitt suchen */
  if (n >= anzBildchen())
    throw Fehler(_("Image '%s' too small for Icon %d"), mName.data(), n);
  int bpr = mBreite / gric; /* Bildchen pro Reihe... */
  SDL_Rect srcr = SDLTools::rect(gric * (n % bpr), gric * (n / bpr), gric, gric);
  
  if (k != viertel_alle) {
    /* Richtiges Viertel in Datei wählen */
    if (k & viertel_qr) srcr.x += gric/2;
    if (k & viertel_qu) srcr.y += gric/2;
    /* Richtiges Ziel-Viertel wählen */
    if (k & viertel_zr) xx += gric/2;
    if (k & viertel_zu) yy += gric/2;
    srcr.w = srcr.h = gric/2;
  }

  Area::blitSurface(mBild, srcr, xx, yy);
}

/** liefert zurück, wie viele Bildchen in dieser Datei sind. */
int Bilddatei::anzBildchen() const{
  return (mBreite / gric) * (mHoehe / gric);
}

/** liefert die Gesamthoehe in Pixeln zurück */
int Bilddatei::getBreite() const {
  return mBreite;
}

/** liefert die Gesamthoehe in Pixeln zurück */
int Bilddatei::getHoehe() const {
  return mHoehe;
}


/** Nur zum anschauen, nicht zum veraendern! Liefert das Bild in unskaliert
    und 32 Bit. */
SDL_Surface * Bilddatei::getSurface() const {
  return mBildOriginal->mBild;
}


/** malt das gesamte Bild */
void Bilddatei::malBild(int xx, int yy) const {
  Area::blitSurface(mBild, xx, yy);
}

/** malt einen beliebigen Bildausschnitt */
void Bilddatei::malBildAusschnitt(int xx, int yy, const SDL_Rect & src) const {
  if (gDebug && !gMod4Warnung)
    if (src.x % 4 != 0 || src.y % 4 != 0 || src.w % 4 != 0 || src.h % 4 != 0) {
      fprintf(stderr, "* Warnung: Male einen Teil von '%s' mit Koordinaten,\n"
              "* die nicht durch 4 teilbar sind. Das kann Graphikfehler in\n"
	      "* der kleinskalierten Version von Cuyo erzeugen.\n"
	      "* (Diese Warnung wird nur einmal ausgegeben)\n",
	      mName.data());
      gMod4Warnung = true;
    }
  Area::blitSurface(mBild, src, xx, yy);
}

