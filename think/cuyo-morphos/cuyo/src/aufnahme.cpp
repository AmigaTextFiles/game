/***************************************************************************
                          record.cpp  -  description
                             -------------------
    begin                : Thu Jul 20 2000
    copyright            : (C) 2000 by Immi
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

#include <cstdlib>
#include <cstdio>
#include <vector>
#include <ctime>

#include "cuyointl.h"

#include "aufnahme.h"
#include "spielfeld.h"
#include "leveldaten.h"
#include "fehler.h"


//#define datum_rnd 1 /* Wird nicht mehr benutzt */
#define datum_taste 2
#define datum_schritt 3
#define datum_randseed 4


namespace Aufnahme {


struct tDatum {
  int mArt;
  int mD1;
  int mD2;
  
  tDatum(int a = 0, int d1 = 0, int d2 = 0): mArt(a), mD1(d1), mD2(d2) {}
};




/***** Globale Variablen *****/

/** Name des Levels, für den die Aufnahme ist. */
Str gLevelName;
/** Anzahl der Spieler, für die diese Aufnahme ist. (= spielermodus_computer, falls für
    gegen KI.) */
int gSpielerModus;

/** Das Haupt-Daten-Array der Aufnahme. (Ist evtl. größer als nötig.) */
static std::vector<tDatum> gAufnahme;
/** Wie lang ist die Aufnahme wirklich: */
static int gAufnahmeAnz;

/** True, wenn grade eine Aufnahme abgespielt wird. */
static bool gAbspielen;
/** Akt. Position beim abspielen. */
int gAbspielenBei;







/***** Werkzeuge *****/


void DatAusgeben(int n) {
  fprintf(stderr, "%3d.: %d,%d,%d\n", n,
          gAufnahme[n].mArt, gAufnahme[n].mD1, gAufnahme[n].mD2);
}



void speichere(const tDatum & d) {
  /* GGf. Array vergrößern */
  if ((int) gAufnahme.size() <= gAufnahmeAnz)
    gAufnahme.resize(gAufnahmeAnz * 2 + 16);
  
  
  gAufnahme[gAufnahmeAnz++] = d;
  //DatAusgeben(gAufnahmeAnz - 1);
}



/** Schaltet mitten während des Abspielens auf Aufnahme um. Wenn true
    übergeben wird, wird dabei der zuletzt abgespielte Datensatz
    überschrieben (üblicherweise weil der nicht mehr gepasst hatte). */
void abspielenUnterbrechen(bool letztenUeberschreiben = false) {
  gAufnahmeAnz = gAbspielenBei - letztenUeberschreiben;
  gAbspielen = false;
}











/** Am Anfang eines Levels aufrufen.
    Allerdings erst *nach* ladLevel(), weil der
    Levelname schon zur Verfügung stehen muss.
    spz gibt die Anzahl der Spieler an (bzw. = spielermodus_computer falls gegen KI). */
void init(bool abspielen, int spz) {
  gAbspielen = abspielen;
  gAbspielenBei = 0;

  if (gAbspielen) {
    const tDatum & d = gAufnahme[gAbspielenBei++];
    if (gLevelName != ld->mIntLevelName) {
      abspielenUnterbrechen();
      fprintf(stderr, "Abspielen gestoppt. Wäre für Level %s gewesen.\n",
              gLevelName.data());
    } else if (gSpielerModus != spz) {
      abspielenUnterbrechen();
      fprintf(stderr, "Abspielen gestoppt. Wäre für %d Spieler gewesen.\n",
              gSpielerModus);
    } else if (d.mArt != datum_randseed) {
      abspielenUnterbrechen();
      fprintf(stderr, "Abspielen gestoppt, weil unpassend (?).\n");
    } else {
      srand(d.mD1);
      return;
    }
  }
  
  /* Nicht abspielen, oder beim Abspielen ist jetzt schon was
     schief gelaufen. */

  /* Level, Spielerzahl abspeichern */
  gLevelName = ld->mIntLevelName;
  gSpielerModus = spz;

  /* Alles löschen */
  gAufnahmeAnz = 0;
  
  /* Randseed abspeichern */
  int seed = time(0);
  srand(seed);
  speichere(tDatum(datum_randseed, seed));
}







/***** "public" Zeug *****/


/** Liefert eine Zufallszahl... evtl. eine aufgenommene. (Im Moment bemerkt
    man die Tatsache, dass es sich um eine aufgenommene Zufallszahl handelt,
    gar nicht, weil das über das randseed geht.) */
int rnd(int bis) {
  return (int) ((double) bis * rand() / (RAND_MAX + 1.0));
}




/** Wird nicht mehr benutzt: */
// int rnd_alt(int bis) {
//   /* Aufnahme abspielen? */
//   if (gAbspielen) {
//     if (gAbspielenBei >= gAufnahmeAnz) {
//       fprintf(stderr, "Aufnahme zu Ende.\n");
//       gAbspielen = false;
//       
//     } else {
//       const tDatum & d = gAufnahme[gAbspielenBei++];
//       
//       if (d.mArt == datum_rnd && d.mD1 == bis) {
// 	return d.mD2;
//       } else {
// 	fprintf(stderr, "Abspielen gestoppt, weil unpassend.\n");
// 	gAufnahmeAnz = gAbspielenBei - 1;
// 	gAbspielen = false;
//       }
//     }
//   }
// 
//   int ret = (int) ((double) bis * rand() / (RAND_MAX + 1.0));
//   speichere(tDatum(datum_rnd, bis, ret));
//   return ret;
// }




/** Nimmt ggf. den Tastendruck t von Spieler sp auf.
    Muss bei jedem Tastendruck aufgerufen werden. */
void recTaste(int sp, int t) {
  if (gAbspielen) {
    fprintf(stderr, "Abspielen gestoppt, wegen Tastendruck.\n");
    abspielenUnterbrechen();
  }
  speichere(tDatum(datum_taste, sp, t));
}



/** Muss einmal vor jedem Spielschritt aufgerufen werden. Spielt ggf.
    Tastendrücke ab.
    spf muss das Haupt-Spielfeld-Array sein, damit Tastendrücke
    ausgeführt werden können. */
void recSchritt(Spielfeld ** spf) {
  /* Aufnahme abspielen? Die Schleife wird so lange ausgeführt, bis
     aus irgend einem Grund das Abpsielen abgebrochen wird, oder bis
     recSchritt() ganz verlassen wird, weil ein datum_schritt gefunden
     wurde. (D. h. das Abspielen läuft jetzt normal weiter. */
  while (gAbspielen) {
    
    if (gAbspielenBei >= gAufnahmeAnz) {
      fprintf(stderr, "Aufnahme zu Ende.\n");
      abspielenUnterbrechen();
      
    } else {
      const tDatum & d = gAufnahme[gAbspielenBei++];
      
      /* Schritt? Dann fertig. */
      if (d.mArt == datum_schritt)
        return;
	
      if (d.mArt == datum_taste) {
        /* Tastendruck ausführen */
        spf[d.mD1]->taste(d.mD2);
      } else {
        /* War wohl nix. */
	fprintf(stderr, "Abspielen gestoppt, weil unpassend.\n");
	abspielenUnterbrechen(true);
      }
    }
  }

  speichere(tDatum(datum_schritt));
}


void laden(Str pfad) {
  gAufnahmeAnz = 0;
  FILE * f = fopen(pfad.data(), "r");
  if (!f)
    throw Fehler(_("Could not open log file \"%s\" for reading."),
                 pfad.data());
  char cvers[222], lna[222];
  int spz;
  if (fscanf(f, "%200[^\n]\n%200[^\n]\n%d", cvers, lna, &spz) != 3)
    throw Fehler(_("Parse Error at the beginning of the log file \"%s\"."), 
                 pfad.data());
  if (strcmp(cvers, VERSION) != 0) {
    fprintf(stderr, "Warnung: Logdatei-Version: %s - Cuyo-Version: %s\n",
            cvers, VERSION);
  }
  gLevelName = lna;
  gSpielerModus = spz;
  int a, d1, d2;
  while (fscanf(f, "%d%d%d", &a, &d1, &d2) == 3) {
    if (a == datum_schritt) {
      /* Alte Version der Log-Datei: */
      if (d2 == 0) d2 = 1;
      
      for (int i = 0; i < d2; i++)
        speichere(tDatum(a, d1, 0));
    } else
      speichere(tDatum(a, d1, d2));
  }
  fclose(f);
}


void speichern(Str pfad) {
  FILE * f = fopen(pfad.data(), "w");
  if (!f)
    throw Fehler(_("Could not open log file \"%s\" for writing."),
                 pfad.data());

  /* Cuyo-Version ausgeben */
  fprintf(f, "%s\n", VERSION);

  /* Level-Name und Spielerzahl ausgeben */
  fprintf(f, "%s\n%d\n", gLevelName.data(), gSpielerModus);

  /* Eigentliche Daten ausgeben */
  int schritte = 0;
  for (int i = 0; i < gAufnahmeAnz; i++) {
    const tDatum & d = gAufnahme[i];
    if (d.mArt == datum_schritt)
      schritte++;
    else {
      if (schritte > 0) {
        fprintf(f, "%d %d %d\n", datum_schritt, 0, schritte);
	schritte = 0;
      }
    
      fprintf(f, "%d %d %d\n", d.mArt, d.mD1, d.mD2);
    }
  }

  if (schritte > 0)
    fprintf(f, "%d %d %d\n", datum_schritt, 0, schritte);

  fclose(f);  
}



/** Liefert den Level-Namen zurück, für den die aktuelle Aufnahme ist. */
Str getLevelName() {
  return gLevelName;
}

/** Liefert die Spielerzahl zurück, für die die aktuelle Aufnahme ist. */
int getSpielerModus() {
  return gSpielerModus;
}



} // namespace Aufnahme
