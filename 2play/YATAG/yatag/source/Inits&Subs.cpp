// Alle Sub-Routinen für das Game, ausgelagert wegen Übersichtlichkeit
// @1998 Dreamworlds Development / Stefan Schulze / Thomas Schulze

#include <stdlib.h>
#include <clib/rtgmaster_protos.h>

#ifndef __PPC__
    #include <pragma/rtgmaster_lib.h>
    #include <pragma/exec_lib.h>
#endif

#include <devices/ahi.h>
#include <proto/ahi.h>
#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>
#include <clib/exec_protos.h>
#include <clib/dos_protos.h>
#include <clib/lowlevel_protos.h>
#include <utility/tagitem.h>
#include <exec/memory.h>

#include "defines.h"

void  InitAlles();
void  LadeFile(STRPTR Datei, APTR ZielBuffer, LONG Laenge);
void  AllesZu(LONG FehlerCode);
void  Schwarz(LONG x1, LONG y1, LONG x2, LONG y2);
void  Umriss(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData, UBYTE Farbe);
void  PasteGfx(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
void  PasteGfxNoMask(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
void  PasteGfxNoMask2(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
void  RemoveGfx(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
void  Klatsch();
void  NeuesObjekt(UBYTE Type, LONG x, LONG y, LONG rx, LONG ry, LONG Pause);
void  MachMaObjekte();
void  Kawomm(LONG x, LONG y, UBYTE Dicke);
void  RefreshZahl();
void  RefreshREnerg();
void  MachMaRaumer();
void  SetzeKursGruen(LONG kx, LONG ky);
void  SetzeKursBlau(LONG kx, LONG ky);
void  RefreshWand();
void  NeueBombe(LONG x, LONG y, LONG rx, LONG ry, UBYTE Typ, UBYTE Seite);
void  MachMaBombe();
void  NeuerLaser(UBYTE Typ, LONG sx, LONG sy, LONG zx, LONG zy);
void  MachMaLaser();
UBYTE SucheZiel(LONG x, LONG y, UBYTE Seite, LONG MaxEntf);
BOOL  MachMaLaserSt();
void  MachMaBasis();
BOOL  OpenAHI();
void  CloseAHI();
BOOL  AllocAudio();
void  FreeAudio();
UWORD LoadSample(STRPTR filename, ULONG type);
void  UnloadSample(UWORD id);
void  SpielMaSample(WORD SampleID, ULONG Frequenz);
void  SpielMaSample2(WORD SampleID, LONG Freq);
void  MachMaSounds();

// ------------------------------------------------------------------------------------------------

extern struct Library *RTGMasterBase=NULL;
extern struct Library *LowLevelBase=NULL;

extern struct ScreenReq *sr=NULL;
extern struct RtgScreen *RScreen=NULL;
extern UBYTE *MapA;
extern int format=0;
extern LONG GlobTime=0;

extern LONG *Palette = NULL;
extern ULONG *Wurzel = NULL;
extern UBYTE *Buffer = NULL, *GameScr = NULL, *GfxTab = NULL, *Titel = NULL, *Pause = NULL, *Schaf=NULL;

extern struct Objekt Obj[500];
extern struct Raumer Fli[20];
extern struct KeyQuery kq[25];
extern struct Bombe Bo[10];
extern struct Laser La[20];
extern struct LaserSt LS[4];
extern LONG Basis[2];

extern UBYTE Kanal;
extern WORD SmpID[16];
extern BOOL SNDStation, SNDRungs, SNDFetz, SNDMiniLaser, SNDBigLaser, SNDBomm;

extern APTR samples[MAXSAMPLES] = { 0 };

extern struct Library      *AHIBase;
extern struct MsgPort      *AHImp     = NULL;
extern struct AHIRequest   *AHIio     = NULL;
extern BYTE                 AHIDevice = -1;
extern struct AHIAudioCtrl *actrl     = NULL;

extern LONG mixfreq = 0;

struct TagItem rtag[] = {
    smr_MinWidth,       640,
    smr_MinHeight,      480,
    smr_MaxWidth,       640,
    smr_MaxHeight,      512,
    smr_ChunkySupport,  LUT8,
    smr_PlanarSupport,  -1,
    smr_Buffers,1,
    TAG_DONE,           NULL
};

struct TagItem gtag[] = {
    grd_PixelLayout,    0,
    grd_ColorSpace,     0,
    TAG_DONE,           0
};

struct TagItem tacks[] = {
    rtg_Buffers,1,
    TAG_DONE,0
};

// ------------------------------------------------------------------------------------------------
// Refresht die Wände der Basen
//
// Parameter:     -Keine-
//
// globale Var's: -Keine-
//

void RefreshWand() {
  if (Basis[0]==100) {
    PasteGfx(3, 475, 6, 6, Mauer);
    PasteGfx(9, 475, 6, 6, Mauer);
    PasteGfx(15, 475, 6, 6, Mauer);
    PasteGfx(21, 475, 6, 6, Mauer);
    PasteGfx(27, 475, 6, 6, Mauer);
    PasteGfx(33, 475, 6, 6, Mauer);
    PasteGfx(39, 475, 6, 6, Mauer);

    PasteGfx(3, 375, 6, 6, Mauer);
    PasteGfx(9, 375, 6, 6, Mauer);
    PasteGfx(15, 375, 6, 6, Mauer);
    PasteGfx(21, 375, 6, 6, Mauer);
    PasteGfx(27, 375, 6, 6, Mauer);
    PasteGfx(33, 375, 6, 6, Mauer);
    PasteGfx(39, 375, 6, 6, Mauer);
    }

  if(Basis[1]==100) {
    PasteGfx(637, 28, 6, 6, Mauer);
    PasteGfx(631, 28, 6, 6, Mauer);
    PasteGfx(625, 28, 6, 6, Mauer);
    PasteGfx(619, 28, 6, 6, Mauer);
    PasteGfx(613, 28, 6, 6, Mauer);
    PasteGfx(607, 28, 6, 6, Mauer);
    PasteGfx(601, 28, 6, 6, Mauer);

    PasteGfx(637, 130, 6, 6, Mauer);
    PasteGfx(631, 130, 6, 6, Mauer);
    PasteGfx(625, 130, 6, 6, Mauer);
    PasteGfx(619, 130, 6, 6, Mauer);
    PasteGfx(613, 130, 6, 6, Mauer);
    PasteGfx(607, 130, 6, 6, Mauer);
    PasteGfx(601, 130, 6, 6, Mauer);
    }
  }

// ------------------------------------------------------------------------------------------------
// Verändert den Kurs aller aktivierten Raumer des grünen Spielers
//
// Parameter:     LONG kx                       (Kursveränderung auf der X-Achse)
//                LONG ky                       (Kursveränderung auf der Y-Achse)
//
// globale Var's: struct Raumer Fli[20]         (Array von Raumerstrukturen zur Verwaltung)
//

void SetzeKursGruen(LONG kx, LONG ky) {
  int i;
  BOOL Zahlen;

  for(i=0; i<10; i++) {
    if((Fli[i].Aktiv)&&(Fli[i].Typ!=Tot)&&(!Fli[i].Raucher)) {
      if(Fli[i].Befehl) {
        Fli[i].Befehl=Nichts;
        Zahlen=TRUE;
        }
      Fli[i].KursX+=(kx*48);
      Fli[i].KursY+=(ky*48);

      if(Fli[i].Typ<=SFighter) {
        if(Fli[i].KursX<-672) Fli[i].KursX=-672;
        if(Fli[i].KursX>672) Fli[i].KursX=672;
        if(Fli[i].KursY<-672) Fli[i].KursY=-672;
        if(Fli[i].KursY>672) Fli[i].KursY=672;
        }

      if(Fli[i].Typ>=Bomber) {
        if(Fli[i].KursX<-480) Fli[i].KursX=-480;
        if(Fli[i].KursX>480) Fli[i].KursX=480;
        if(Fli[i].KursY<-480) Fli[i].KursY=-480;
        if(Fli[i].KursY>480) Fli[i].KursY=480;
        }
      }
    }
  if(Zahlen) RefreshZahl();
  }

// ------------------------------------------------------------------------------------------------
// Verändert den Kurs aller aktivierten Raumer des blauen Spielers
//
// Parameter:     LONG kx                       (Kursveränderung auf der X-Achse)
//                LONG ky                       (Kursveränderung auf der Y-Achse)
//
// globale Var's: struct Raumer Fli[20]         (Array von Raumerstrukturen zur Verwaltung)

void SetzeKursBlau(LONG kx, LONG ky) {
  int i;
  BOOL Zahlen=FALSE;

  for(i=10; i<20; i++) {
    if((Fli[i].Aktiv)&&(Fli[i].Typ!=Tot)&&(!Fli[i].Raucher)) {
      if(Fli[i].Befehl) {
        Fli[i].Befehl=Nichts;
        Zahlen=TRUE;
        }

      Fli[i].KursX+=(kx*48);
      Fli[i].KursY+=(ky*48);

      if(Fli[i].Typ<=SFighter) {
        if(Fli[i].KursX<-672) Fli[i].KursX=-672;
        if(Fli[i].KursX>672) Fli[i].KursX=672;
        if(Fli[i].KursY<-672) Fli[i].KursY=-672;
        if(Fli[i].KursY>672) Fli[i].KursY=672;
        }

      if(Fli[i].Typ>=Bomber) {
        if(Fli[i].KursX<-480) Fli[i].KursX=-480;
        if(Fli[i].KursX>480) Fli[i].KursX=480;
        if(Fli[i].KursY<-480) Fli[i].KursY=-480;
        if(Fli[i].KursY>480) Fli[i].KursY=480;
        }
      }
    }
  if(Zahlen) RefreshZahl();
  }

// ------------------------------------------------------------------------------------------------
// Organisierung der Raumer, aller Arten und Größen
//
// Parameter:     -Nix-
//
// globale Var's: struct Raumer Fli[20]         (Array von Raumerstrukturen zur Verwaltung)
//

void MachMaRaumer() {
  UBYTE j;
  BOOL Zahlen=FALSE;
  LONG ax,ay;

  for(UBYTE i=0; i<20; i++) {
    if(Fli[i].Typ!=Tot) {
      // Alle Raumer weg vom Screen (nicht ganz weg, nur a bissel unsichtbar [Keine Angst])
      if(Fli[i].Seite==Blau) {
        if(Fli[i].Typ>=Bomber) RemoveGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 3, BlBomber);
        if(Fli[i].Typ<=SFighter) RemoveGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 5, BlFighter);
        }
      else {
        if(Fli[i].Typ>=Bomber) RemoveGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 3, GrBomber);
        if(Fli[i].Typ<=SFighter) RemoveGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 5, GrFighter);
        }

      // Jetzt organisieren wie blöde

      // Als erstes prüfen, ob der Raumer einen Befehl hat

      if(Fli[i].Befehl==Anhalten) {
        if(Fli[i].KursX<0) Fli[i].KursX+=48;
        if(Fli[i].KursX>0) Fli[i].KursX-=48;
        if(Fli[i].KursY<0) Fli[i].KursY+=48;
        if(Fli[i].KursY>0) Fli[i].KursY-=48;

        if((Fli[i].KursX==0)&&(Fli[i].KursY==0)) {
          Fli[i].Befehl=Nichts;
          Zahlen=TRUE;
          }
        }

      // Befehl: Heimweg über Umweg, 1. Etappe
      if((Fli[i].Befehl==Umweg)&&(Fli[i].Raucher==FALSE)) {
        LONG zx,zy;         // Zielkoordinaten, Vergleichskoordinaten

        // Zielkoordinaten ca. 50 Pixel vor jeweiliger LandePos
        if(Fli[i].Seite==Gruen) {
          zx=70<<8; zy=(380+i*8)<<8;
          }
        else {
          zx=560<<8; zy=(-20+i*8)<<8;
          }

        // Auf Zielkurs beschleunigen
        if(Fli[i].RealX<zx-1024) Fli[i].KursX+=48;
        else if(Fli[i].RealX>zx+1024) Fli[i].KursX-=48;
        else {
         if(Fli[i].KursX<0) Fli[i].KursX+=96;
         if(Fli[i].KursX>0) Fli[i].KursX-=96;
         }

        if(Fli[i].RealY<zy-1024) Fli[i].KursY+=48;
        else if(Fli[i].RealY>zy+1024) Fli[i].KursY-=48;
        else {
         if(Fli[i].KursY<0) Fli[i].KursY+=96;
         if(Fli[i].KursY>0) Fli[i].KursY-=96;
         }


        // MaxTempo einhalten
        if(Fli[i].Typ<=SFighter) {
          if(Fli[i].KursX<-672) Fli[i].KursX=-672;
          if(Fli[i].KursX>672) Fli[i].KursX=672;
          if(Fli[i].KursY<-672) Fli[i].KursY=-672;
          if(Fli[i].KursY>672) Fli[i].KursY=672;
          }

        if(Fli[i].Typ>=Bomber) {
          if(Fli[i].KursX<-480) Fli[i].KursX=-480;
          if(Fli[i].KursX>480) Fli[i].KursX=480;
          if(Fli[i].KursY<-480) Fli[i].KursY=-480;
          if(Fli[i].KursY>480) Fli[i].KursY=480;
          }

        // Im Zielbereich?
        ax = (Fli[i].RealX-zx)>>8; ay = (Fli[i].RealY-zy)>>8;
        if((ax>-8)&&(ax<8)&&(ay>-8)&&(ay<8)) Fli[i].Befehl=Heimwaerts; // Dann Rest des Weges direkt
        }

      // Befehl: Heimflug ohne Umweg/ Heimflug mit Umweg, 2. Etappe
      if((Fli[i].Befehl==Heimwaerts)&&(Fli[i].Raucher==FALSE)) {
        LONG zx,zy;         // Zielkoordinaten

        // Zielkoords: die LandePos
        if(Fli[i].Seite==Gruen) {
          zx=12<<8; zy=(385+i*8)<<8;
          }
        else {
          zx=628<<8; zy=(-40+i*8)<<8;
          }

        // Gen Ziel beschleunigen
        if(Fli[i].RealX<zx-1024) Fli[i].KursX+=48;
        else if(Fli[i].RealX>zx+1024) Fli[i].KursX-=48;
        else {
         if(Fli[i].KursX<0) Fli[i].KursX+=96;
         if(Fli[i].KursX>0) Fli[i].KursX-=96;
         }

        if(Fli[i].RealY<zy-1024) Fli[i].KursY+=48;
        else if(Fli[i].RealY>zy+1024) Fli[i].KursY-=48;
        else {
         if(Fli[i].KursY<0) Fli[i].KursY+=96;
         if(Fli[i].KursY>0) Fli[i].KursY-=96;
         }

        // MaxTempo
        if(Fli[i].Typ<=SFighter) {
          if(Fli[i].KursX<-672) Fli[i].KursX=-672;
          if(Fli[i].KursX>672) Fli[i].KursX=672;
          if(Fli[i].KursY<-672) Fli[i].KursY=-672;
          if(Fli[i].KursY>672) Fli[i].KursY=672;
          }

        if(Fli[i].Typ>=Bomber) {
          if(Fli[i].KursX<-480) Fli[i].KursX=-480;
          if(Fli[i].KursX>480) Fli[i].KursX=480;
          if(Fli[i].KursY<-480) Fli[i].KursY=-480;
          if(Fli[i].KursY>480) Fli[i].KursY=480;
          }

        // Da?
        if(Fli[i].Seite==Gruen) {
          if(Fli[i].RealX<30<<8) {
            Fli[i].Befehl=Nichts;
            Fli[i].Aktiv=FALSE;
            Zahlen=TRUE;
            }
          }
        else {
          if(Fli[i].RealX>610<<8) {
            Fli[i].Befehl=Nichts;
            Fli[i].Aktiv=FALSE;
            Zahlen=TRUE;
            }
          }
        }


      // Koordinaten neu berechnen

      Fli[i].RealX+=Fli[i].KursX;
      Fli[i].RealY+=Fli[i].KursY;

      // Kollisionen mit Mauern prüfen

      if((Fli[i].RealX<44<<8)&&(Basis[0]==100)) {
        if((Fli[i].RealY>371<<8)&&(Fli[i].RealY<378<<8)) {
          Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
          Fli[i].Raucher=FALSE;
          Fli[i].Typ=Tot;
          Zahlen=TRUE;
          SNDFetz=TRUE;
          }

        if(Fli[i].RealY>471<<8) {
          Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
          Fli[i].Raucher=FALSE;
          Fli[i].Typ=Tot;
          Zahlen=TRUE;
          SNDFetz=TRUE;
          }
        }

      if((Fli[i].RealX>596<<8)&&(Basis[1]==100)) {
        if((Fli[i].RealY>125<<8)&&(Fli[i].RealY<135<<8)) {
          Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
          Fli[i].Raucher=FALSE;
          Fli[i].Typ=Tot;
          Zahlen=TRUE;
          SNDFetz=TRUE;
          }

        if(Fli[i].RealY<32<<8) {
          Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
          Fli[i].Raucher=FALSE;
          Fli[i].Typ=Tot;
          Zahlen=TRUE;
          SNDFetz=TRUE;
          }
        }
    //Kollisionen mit Laserstationen
    for (j=0; j<4; j++) {
      ax=(Fli[i].RealX>>8)-LS[j].RealX;
      ay=(Fli[i].RealY>>8)-LS[j].RealY;
      if((ax>-5)&&(ax<5)&&((j>>1)!=Fli[i].Seite)) {
        if((ay>-5)&&(ay<5)) {
          Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
          LS[j].Energie-=30;
          if(LS[j].Energie<0) LS[j].Energie=0;
          Fli[i].Raucher=FALSE;
          Fli[i].Typ=Tot;
          Zahlen=TRUE;
          SNDFetz=TRUE;
          }
        }
      }

      // Kollisionen mit anderen Raumern prüfen

      if(Fli[i].Seite==Gruen) {
        for(j=10; j<20; j++) {
          if(Fli[j].Typ!=Tot) {
            register LONG fl=0;
            ax=Fli[i].RealX-Fli[j].RealX;
            ay=Fli[i].RealY-Fli[j].RealY;

            if((ax>-512)&&(ax<512)) fl=3;
            if((ay>-512)&&(ay<512)&&(fl==3)) {
              Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
              Fli[i].Raucher=FALSE;
              Fli[i].Typ=Tot;
              Fli[j].Raucher=FALSE;
              Fli[j].Typ=Tot;
              Zahlen=TRUE;
              SNDFetz=TRUE;
              }
            }
          }
        }

      if(Fli[i].Typ!=Tot) {
        if(Fli[i].Seite==Blau) {
          for(j=0; j<10; j++) {
            if(Fli[j].Typ!=Tot) {
              register LONG fl=0;
              ax=Fli[i].RealX-Fli[j].RealX;
              ay=Fli[i].RealY-Fli[j].RealY;

              if((ax>-512)&&(ax<512)) fl=3;
              if((ay>-512)&&(ay<512)&&(fl==3)) {
                Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
                Fli[i].Raucher=FALSE;
                Fli[i].Typ=Tot;
                Fli[j].Raucher=FALSE;
                Fli[j].Typ=Tot;
                Zahlen=TRUE;
                SNDFetz=TRUE;
                }
              }
            }
          }
        }

      // Landemanöver einleiten! (Y-Kurs beschränken in Basis)

      if(!Fli[i].Raucher) {
        if(Fli[i].Seite==Blau) {
          if((Fli[i].RealY<32512)&&(Fli[i].RealX>155904)) {
            if(Fli[i].KursY<0) Fli[i].KursY+=48;
            if(Fli[i].KursY>0) Fli[i].KursY-=48;
            if(Fli[i].RealX>156160&&Fli[i].KursX>0) Fli[i].KursX-=48;
            if(Fli[i].KursY>-48&&Fli[i].KursY<48) Fli[i].KursY=0;
            if(Fli[i].KursX>-48&&Fli[i].KursX<48) Fli[i].KursX=0;
            if((Fli[i].KursX==0)&&(Fli[i].KursY==0)) {
              if(Fli[i].Energie<Fli[i].MaxEnergie) {
                if (Basis[1]==100) {
                  if ((GlobTime&3)==0) {
                    Fli[i].Energie++;
                    Zahlen=TRUE;
                    }
                  }
                else {
                  if ((GlobTime&31)==0) {
                    Fli[i].Energie++;
                    Zahlen=TRUE;
                    }
                  }
                }
              else {
                if(Basis[1]==100) Fli[i].Ballern=TRUE;
                }
              }
            }
          else {
            if((Fli[i].Energie<Fli[i].MaxEnergie)&&((GlobTime&31)==0)) {
              if((Fli[i].KursX==0)&&(Fli[i].KursY==0)) {
                Fli[i].Energie++;
                Zahlen=TRUE;
                }
              }
            }
          }
        else {
          if((Fli[i].RealY>96768)&&(Fli[i].RealX<7680)) {
            if(Fli[i].KursY<0) Fli[i].KursY+=48;
            if(Fli[i].KursY>0) Fli[i].KursY-=48;
            if(Fli[i].RealX<7680&&Fli[i].KursX<0) Fli[i].KursX+=48;
            if(Fli[i].KursY>-48&&Fli[i].KursY<48) Fli[i].KursY=0;
            if(Fli[i].KursX>-48&&Fli[i].KursX<48) Fli[i].KursX=0;
            if((Fli[i].KursX==0)&&(Fli[i].KursY==0)) {
              if(Fli[i].Energie<Fli[i].MaxEnergie) {
                if (Basis[0]==100) {
                  if ((GlobTime&3)==0) {
                    Fli[i].Energie++;
                    Zahlen=TRUE;
                    }
                  }
                else {
                  if ((GlobTime&31)==0) {
                    Fli[i].Energie++;
                    Zahlen=TRUE;
                    }
                  }
                }
              else {
                if(Basis[0]==100) Fli[i].Ballern=TRUE; // Bomber wieder aufladen
                }
              }
            }
          else {
            if((Fli[i].Energie<Fli[i].MaxEnergie)&&((GlobTime&31)==0)) {
              if((Fli[i].KursX==0)&&(Fli[i].KursY==0)) {
                Fli[i].Energie++;
                Zahlen=TRUE;
                }
              }
            }
          }
        }

      // Raucht das Rind schon? (-> Stirbt gleich)

      if(Fli[i].Raucher) {
        Fli[i].MaxEnergie--;
        if(Fli[i].MaxEnergie==0) {
          Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
          SNDFetz=TRUE;
          Fli[i].Raucher=FALSE;
          Fli[i].Typ=Tot;
          Zahlen=TRUE;
          }
        if((Fli[i].MaxEnergie&1)==1) {
          NeuesObjekt(Rauch, Fli[i].RealX>>8, Fli[i].RealY>>8, 0, 0, 0);
          }

        }

      // Ist er außerhalb der SBZ ? (Schwerumkämpfte BesatzungsZone)
      if((Fli[i].RealX<4<<8)||(Fli[i].RealX>636<<8)||(Fli[i].RealY<28<<8)||(Fli[i].RealY)>473<<8) {
        // Dann machen wir ihn wech.
        Fli[i].Typ=Tot;
        SNDFetz=TRUE;
        Fli[i].Raucher=FALSE;
        Kawomm(Fli[i].RealX>>8, Fli[i].RealY>>8, Winzig);
        Zahlen=TRUE;
        }

      // Jetzt wieder herzaubern

      if(Fli[i].Typ!=Tot) {
        if(Fli[i].Seite==Blau) {
          if(Fli[i].Typ>=Bomber) PasteGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 3, BlBomber);
          if(Fli[i].Typ<=SFighter) PasteGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 5, BlFighter);
          }
        else {
          if(Fli[i].Typ>=Bomber) PasteGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 3, GrBomber);
          if(Fli[i].Typ<=SFighter) PasteGfx(Fli[i].RealX>>8, Fli[i].RealY>>8, 3, 5, GrFighter);
          }
        }
      }
    }
  if(Zahlen) {
    RefreshZahl();
    RefreshREnerg();
    Zahlen=FALSE;
    }
  }

// ------------------------------------------------------------------------------------------------
// Refresht die Energieanzeige der Raumer (ob aktiv oder nich)
//
// Parameter:     -Keine-
//
// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)
//                struct Raumer Fli[20]         (Array von Raumerstrukturen für Verwaltung)

void RefreshREnerg(void) {
  int i;

  for(i=0; i<10; i++) {
    if((Fli[i].Typ!=Tot)&&(!Fli[i].Raucher)) {
      if((Fli[i].Typ==SBomber)||(Fli[i].Typ==SFighter))
        PasteGfxNoMask2(10+(i*15), 17, 10, 5, EnergZahl+(50*(20-(Fli[i].Energie*2))));
      else
        PasteGfxNoMask2(10+(i*15), 17, 10, 5, EnergZahl+(50*(20-Fli[i].Energie)));
      }
    else {
      Schwarz(5+(i*15), 13, 15+(i*15), 22);
      }
    }

  for(i=0; i<10; i++) {
    if((Fli[i+10].Typ!=Tot)&&(!Fli[i+10].Raucher)) {
      if((Fli[i+10].Typ==SBomber)||(Fli[i+10].Typ==SFighter))
        PasteGfxNoMask2(480+(i*15), 17, 10, 5, EnergZahl+(50*(20-(Fli[i+10].Energie*2))));
      else
        PasteGfxNoMask2(480+(i*15), 17, 10, 5, EnergZahl+(50*(20-Fli[i+10].Energie)));
      }
    else {
      Schwarz(475+(i*15), 13, 485+(i*15), 22);
      }
    }

  if(LS[0].Energie>0) {
    PasteGfxNoMask2(280, 7, 6, 6, GrLaser);
    PasteGfxNoMask2(280, 17, 10, 5, EnergZahl+(50*(20-(LS[0].Energie/4))));
    }
  else {
    Schwarz(273, 0, 287, 22);
    }

  if(LS[1].Energie>0) {
    PasteGfxNoMask2(300, 7, 6, 6, Schild);
    PasteGfxNoMask2(300, 17, 10, 5, EnergZahl+(50*(20-(LS[1].Energie/4))));
    }
  else {
    Schwarz(293, 0, 307, 22);
    }

  if(LS[2].Energie>0) {
    PasteGfxNoMask2(340, 7, 6, 6, BlLaser);
    PasteGfxNoMask2(340, 17, 10, 5, EnergZahl+(50*(20-(LS[2].Energie/4))));
    }
  else {
    Schwarz(333, 0, 347, 22);
    }
  if(LS[3].Energie>0) {
    PasteGfxNoMask2(360, 7, 6, 6, Schild);
    PasteGfxNoMask2(360, 17, 10, 5, EnergZahl+(50*(20-(LS[3].Energie/4))));
    }
  else {
    Schwarz(353, 0, 367, 22);
    }


  }

// ------------------------------------------------------------------------------------------------
// Refresht die Zahlen der Raumer (ob aktiv oder nich)
//
// Parameter:     -Keine-
//
// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)
//                struct Raumer Fli[20]         (Array von Raumerstrukturen für Verwaltung)

void RefreshZahl(void) {
  int i;

  for(i=0; i<10; i++) {
    if(Fli[i].Aktiv) PasteGfxNoMask2(10+(i*15), 6, 10, 10, (GfxTab+(3701+(100*i))));
    else if(Fli[i].Befehl) PasteGfxNoMask2(10+(i*15), 6, 10, 10, (GfxTab+(4701+(100*i))));
    else if(!Fli[i].Aktiv) PasteGfxNoMask2(10+(i*15), 6, 10, 10, (GfxTab+(2701+(100*i))));
    if(Fli[i].Typ==Tot) Schwarz(5+(i*15), 0, 15+(i*15), 11);

    if(Fli[i+10].Aktiv) PasteGfxNoMask2(480+(i*15), 6, 10, 10, GfxTab+(3701+(100*i)));
    else if(Fli[i+10].Befehl) PasteGfxNoMask2(480+(i*15), 6, 10, 10, GfxTab+(4701+(100*i)));
    else if(!Fli[i+10].Aktiv) PasteGfxNoMask2(480+(i*15), 6, 10, 10, GfxTab+(2701+(100*i)));
    if(Fli[i+10].Typ==Tot) Schwarz(475+(i*15), 0, 485+(i*15), 11);
    }
  }

// ------------------------------------------------------------------------------------------------
// Initialisiert den ganzen Kuddelmuddel
//
// Parameter:     -Keine-
//
// globale Var's: -ziemlich alle-

void InitAlles(void) {
  LONG i;

  // AHI initialisieren
  if(!OpenAHI()) {
    Printf("OpenAHI() failed. (AHI V4)\n");
    AllesZu(65535);
    }

  if(!AllocAudio()) {
    Printf("AllocAudio() failed.\n");
    AllesZu(65535);
    }

  // Alle Samples einladen

  SND_StatLaser  = LoadSample("Daten/snd1", AHIST_M8S);
  SND_BombExplo  = LoadSample("Daten/snd2", AHIST_M8S);
  SND_RaumerExplo= LoadSample("Daten/snd3", AHIST_M8S);
  SND_FightLaser = LoadSample("Daten/snd4", AHIST_M8S);
  SND_SFightLaser= LoadSample("Daten/snd5", AHIST_M8S);
  SND_BombShot   = LoadSample("Daten/snd6", AHIST_M8S);
  SND_Schaf      = LoadSample("Daten/snd7", AHIST_M8S);
  SND_Knaller    = LoadSample("Daten/snd8", AHIST_M8S);

  for(i=0; i<MAXSAMPLES; i++) {
    if(SmpID[i]==AHI_NOSOUND) {
      Printf("LoadSample() failed.\n");
      AllesZu(65535);
      }
    }

  if(AHI_ControlAudio(actrl, AHIC_Play, TRUE, TAG_DONE)) {
    Printf("AHI_ControlAudio() failed. \n");
    AllesZu(65535);
    }

  // RTGMaster initialisieren
  RTGMasterBase=(struct Library *)OpenLibrary("rtgmaster.library",40);
  LowLevelBase=(struct Library *)OpenLibrary("lowlevel.library",40);

  if (!RTGMasterBase) {
      Printf("OpenLibrary() failed. (rtgmaster.library V40)\n");
      AllesZu(65535);
      }

  if (!LowLevelBase) {
      Printf("OpenLibrary() failed. (lowlevel.library V40)\n");
      AllesZu(65535);
      }

  // Screenmoderequester
  #ifndef __PPC__
      sr=RtgScreenModeReq(rtag);
  #else
      sr=PPCRtgScreenModeReq(rtag);
  #endif

  if (!sr) {
      Printf("RtgScreenModeReq() failed.\n");
      AllesZu(65535);
      }

  // Open Screen
  #ifndef __PPC__
      RScreen = OpenRtgScreen(sr,tacks);
  #else
      RScreen = PPCOpenRtgScreen(sr,tacks);
  #endif

  if (!RScreen) {
      Printf("OpenRtgScreen() failed.\n");
      AllesZu(65535);
      }

  // Screendaten holen
  #ifndef __PPC__
      MapA=(UBYTE *)GetBufAdr(RScreen,0);
      GetRtgScreenData(RScreen,gtag);
  #else
      MapA=(UBYTE *)PPCGetBufAdr(RScreen,0);
      PPCGetRtgScreenData(RScreen,gtag);
  #endif

  // Speicher reservieren

  Palette = (LONG *) AllocMem(4000, MEMF_FAST|MEMF_CLEAR);       // Speicher für Palette
  Wurzel  = (ULONG *) AllocMem(160000, MEMF_FAST|MEMF_CLEAR);    // Speicher für Wurzeltabellen
  Buffer  = (UBYTE *) AllocMem(4000, MEMF_FAST|MEMF_CLEAR);      // Speicher zum Einladen und konvertieren der Palette
  GameScr = (UBYTE *) AllocMem(340000, MEMF_FAST|MEMF_CLEAR);    // Speicher für den GameScreen
  GfxTab  = (UBYTE *) AllocMem(20000, MEMF_FAST|MEMF_CLEAR);     // Speicher für die Grafiken
  Titel   = (UBYTE *) AllocMem(60000, MEMF_FAST|MEMF_CLEAR);     // Speicher für die Titel-Optik
  Pause   = (UBYTE *) AllocMem(1000, MEMF_FAST|MEMF_CLEAR);      // Speicher für Pause-Schrift
  Schaf   = (UBYTE *) AllocMem(20000, MEMF_FAST|MEMF_CLEAR);      // Speicher für Schaf-Anims

  if((!Palette)||(!Buffer)||(!GameScr)||(!GfxTab)||(!Wurzel)||(!Titel)||(!Pause)) {
    Printf("AllocMem() failed. (~1MB unfragmented FastRAM needed).\n");
    AllesZu(65535);
    }

  // Laden des ganzen Kuddelmuddel's

  LadeFile("Daten/Pal", Buffer, 4000);
  LadeFile("Daten/Gfx", GfxTab, 20000);
  LadeFile("Daten/sqr", Wurzel, 160000);
  LadeFile("Daten/gfx2", Titel, 60000);
  LadeFile("Daten/gfx3", Pause, 1000);
  LadeFile("Daten/specialgfx", Schaf, 20000);

  // Farbpalette initialisieren

  *Palette = 0x00200000;
  for(i=0; i<95; i++) {
    *(Palette+1+i)=*(Buffer+48+i)*0x01010101;
    }
  LoadRGBRtg(RScreen, Palette);

  // Keyboard-Abfragen initialisieren

  for(i=0; i<20; i++) {
    kq[i].kq_Pressed=FALSE;
    if(i<10) kq[i].kq_KeyCode=80+i;
    }

  kq[19].kq_KeyCode=15;  // Numerische Taste 0
  kq[10].kq_KeyCode=29;  // Numerische Taste 1
  kq[11].kq_KeyCode=30;  // Numerische Taste 2
  kq[12].kq_KeyCode=31;  // Numerische Taste 3
  kq[13].kq_KeyCode=45;  // Numerische Taste 4
  kq[14].kq_KeyCode=46;  // Numerische Taste 5
  kq[15].kq_KeyCode=47;  // Numerische Taste 6
  kq[16].kq_KeyCode=61;  // Numerische Taste 7
  kq[17].kq_KeyCode=62;  // Numerische Taste 8
  kq[18].kq_KeyCode=63;  // Numerische Taste 9
  kq[20].kq_KeyCode=76;  // Pfeiltaste Hoch
  kq[21].kq_KeyCode=77;  // Pfeiltaste Runter
  kq[22].kq_KeyCode=78;  // Pfeiltaste Rechts
  kq[23].kq_KeyCode=79;  // Pfeiltaste Links
  kq[24].kq_KeyCode=39;  // Taste "k"


  for(i=0; i<640; i++) {
    *(MapA+(23*640)+i)=21;
    *(MapA+(24*640)+i)=23;
    *(MapA+(478*640)+i)=23;
    }

  for(i=0; i<23; i++) {
    *(MapA+(i*640)+318)=23;
    *(MapA+(i*640)+319)=21;
    *(MapA+(i*640)+320)=23;
    }

  for(i=24; i<480; i++) {
    *(MapA+(i*640))=23;
    *(MapA+(i*640)+639)=23;
    }

  RefreshZahl();
  RefreshREnerg();
  RefreshWand();
  }

// ------------------------------------------------------------------------------------------------
// Refresht den Game-Screen (zeigt fertiges Bild an)
//
// Parameter:     -Keine-
//
// globale Var's: struct RTGScreen *RScreen     (initialisierter Zeiger auf einen RTGScreen)
//                UBYTE *MapA                   (initialisierter Zeiger auf Pufferadresse des RTGScreens)
//                UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void Klatsch() {
  #ifndef __PPC__
    CopyRtgBlit(RScreen,MapA,GameScr,0,0,0,640,480,640,480,0,0);
  #else
    PPCCopyRtgBlit(RScreen,MapA,GameScr,0,0,0,640,480,640,480,0,0);
  #endif
  }

// ------------------------------------------------------------------------------------------------
// Erzeugt eine Explosion mit Feuer, Funkenflug etc. mit variabler Größe
//
// Parameter:     LONG x                        (X-Koordinate der zu erstellenden Explosion)
//                LONG y                        (Y-Koordinate der zu erstellenden Explosion)
//                UBYTE Dicke                   (Größe der Explosion [siehe Definition: Explosionsgrößen)
//
// globale Var's: struct Raumer Fli[20]         (Array von Raumerstrukturen für Verwaltung)

void Kawomm(LONG x, LONG y, UBYTE Dicke) {
  register UBYTE i, j, k;
  register LONG zx, zy, x2, y2, t;

  if(Dicke==Mini) {
    for(i=0; i<6; i++) {
      zx=(-768+(rand()%1536));
      zy=(-768+(rand()%1536));
      NeuesObjekt(Funke, x, y, zx, zy, 0);
      }
    }


  if(Dicke==Winzig) {
    for(k=0; k<20; k++) {
      if((Fli[k].Typ!=Tot)&&(!Fli[k].Raucher)) {
        zx=x-(Fli[k].RealX>>8);
        zy=y-(Fli[k].RealY>>8);

        t=((zx*zx)+(zy*zy));
        if(t<400) {
          Fli[k].Energie-=((20-*(Wurzel+t))>>1);
          if(Fli[k].Energie<1) {
            Fli[k].Raucher=TRUE;
            Fli[k].MaxEnergie=40+Fli[k].Energie;
            }
          }
        }
      }
    // Laserstationen betroffen?
    for(k=0; k<4; k++) {
      zx=x-LS[k].RealX;
      zy=y-LS[k].RealY;
      t=((zx*zx)+(zy*zy));
      if(t<400) {
        LS[k].Energie-=((20-*(Wurzel+t))>>1);
        if((LS[k].Energie<0)&&(LS[k].Energie!=-20)) LS[k].Energie=0;
        }
      }

    NeuesObjekt(Explosion, x, y, 0, 0, 0);


    for(i=0; i<20; i++) {
      zx=(-768+(rand()%1536))*2;
      zy=(-768+(rand()%1536))*2;
      NeuesObjekt(Funke, x, y, zx, zy, 0);
      }
    }

  if(Dicke==Mittel) {
    for(k=0; k<20; k++) {
      if((Fli[k].Typ!=Tot)&&(!Fli[k].Raucher)) {
        zx=x-(Fli[k].RealX>>8);
        zy=y-(Fli[k].RealY>>8);

        t=((zx*zx)+(zy*zy));
        if(t<1600) {
          Fli[k].Energie-=(40-*(Wurzel+t));
          if(Fli[k].Energie<1) {
            Fli[k].Raucher=TRUE;
            Fli[k].MaxEnergie=40+Fli[k].Energie;
            }
          }
        }
      }
    // Laserstationen betroffen?
    for(k=0; k<4; k++) {
      zx=x-LS[k].RealX;
      zy=y-LS[k].RealY;
      t=((zx*zx)+(zy*zy));
      if(t<1600) {
        LS[k].Energie-=(40-*(Wurzel+t));
        if((LS[k].Energie<0)&&(LS[k].Energie!=-20)) LS[k].Energie=0;
        }
      }

    for(i=0; i<20; i++) {

      zx=(x-30)+(rand()%60);
      zy=(y-30)+(rand()%60);

      NeuesObjekt(Explosion, zx, zy, 0, 0, *(Wurzel + ((zx-x)*(zx-x)+(zy-y)*(zy-y)))/5);
      }

    for(i=0; i<20; i++) {
      zx=(-768+(rand()%1536))*2;
      zy=(-768+(rand()%1536))*2;
      NeuesObjekt(Funke, x, y, zx, zy, 0);
      }
    }

  if(Dicke==Gross) {
    for(k=0; k<20; k++) {
      if((Fli[k].Typ!=Tot)&&(!Fli[k].Raucher)) {
        zx=x-(Fli[k].RealX>>8);
        zy=y-(Fli[k].RealY>>8);

        t=((zx*zx)+(zy*zy));
        if(t<2500) {
          Fli[k].Energie-=(50-*(Wurzel+t));
          if(Fli[k].Energie<1) {
            Fli[k].Raucher=TRUE;
            Fli[k].MaxEnergie=40+(Fli[k].Energie>>1);
            }
          }
        }
      }
    // Laserstationen betroffen?
    for(k=0; k<4; k++) {
      zx=x-LS[k].RealX;
      zy=y-LS[k].RealY;
      t=((zx*zx)+(zy*zy));
      if(t<2500) {
        LS[k].Energie-=(50-*(Wurzel+t));
        if((LS[k].Energie<0)&&(LS[k].Energie!=-20)) LS[k].Energie=0;
        }
      }

    for(i=0; i<35; i++) {
      zx=(x-35)+(rand()%70);
      zy=(y-35)+(rand()%70);

      NeuesObjekt(Explosion, zx, zy, 0, 0, *(Wurzel + ((zx-x)*(zx-x)+(zy-y)*(zy-y)))/7);
      }

    for(i=0; i<40; i++) {
      zx=(-768+(rand()%1536))*4;
      zy=(-768+(rand()%1536))*4;
      NeuesObjekt(Funke, x, y, zx, zy, 0);
      }
    }

  if(Dicke==GeradezuUnglaublich) {
    for(i=0; i<10; i++) {
      x2=(x-20)+(rand()%40);
      y2=(y-50)+(rand()%100);

      if((x2>0)&&(x2<639)&&(y2>0)&&(y2<479)) Kawomm(x2, y2, Mittel);
      }
    }
  RefreshREnerg();
  }

// ------------------------------------------------------------------------------------------------
// Erzeugt eine neues Objekt (Explosion, Rauch, Funken) in der Arena
//
// Parameter:     UBYTE Type                    (Objekttyp [siehe Objektdefinitionen und struct Objekt])
//                LONG x                        (X-Koordinate des zu erzeugenden Objekts)
//                LONG y                        (Y-Koordinate des zu erzeugenden Objekts)
//                LONG rx                       (Kurs in X-Richtung des zu erzeugenden Objekts)
//                LONG ry                       (Kurs in Y-Richtung des zu erzeugenden Objekts)
//
// globale Var's: struct Objekt Obj[500]        (Array von Objektstrukturen zur Objektverwaltung)

void NeuesObjekt(UBYTE Type, LONG x, LONG y, LONG rx, LONG ry, LONG Pause) {
  int Zahl=0;

  while((Obj[Zahl].Typ!=Frei)&&(Zahl<500)) { Zahl++; }   // freies Objekt suchen
  if(Zahl>498) return;  // kein freies mehr da --> Pech gehabt

  // den ganzen Quatsch initialisieren

  Obj[Zahl].Typ=Type;
  if(Type==Funke) Obj[Zahl].MaxZeit=LBStFunken;
  if(Type==Explosion) Obj[Zahl].MaxZeit=LBStExplo;
  if(Type==Rauch) Obj[Zahl].MaxZeit=LBStSmoke;
  Obj[Zahl].Zeit=Obj[Zahl].MaxZeit;
  Obj[Zahl].RealX=x<<8;
  Obj[Zahl].RealY=y<<8;
  Obj[Zahl].KursX=rx;
  Obj[Zahl].KursY=ry;
  Obj[Zahl].Pause=Pause;
  }

// ------------------------------------------------------------------------------------------------
// Verwaltet alle Objekte (Explosionen, Rauch, Funken)
//
// Parameter:     -Keine-
//
// globale Var's: struct Objekt Obj[500]        (Array von Objektstrukturen zur Objektverwaltung)
//                UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void MachMaObjekte() {
  int ObjNr;

  for(ObjNr=0; ObjNr<500; ObjNr++) {
    if(Obj[ObjNr].Typ!=Frei) {
      if (Obj[ObjNr].Pause>0) {
        Obj[ObjNr].Pause--;
        }
      else
        {

        // Alle Objekte erstmal weg vom Screen
        if(Obj[ObjNr].Typ==Funke) {
          if((Obj[ObjNr].RealX>1<<8)&&(Obj[ObjNr].RealX<639<<8)&&(Obj[ObjNr].RealY>25<<8)&&(Obj[ObjNr].RealY<478<<8)) {
            *(MapA+((Obj[ObjNr].RealY>>8)*640)+(Obj[ObjNr].RealX>>8))=0;
            }
          }

        if(Obj[ObjNr].Typ==Explosion) {
          if(Obj[ObjNr].Zeit==6) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr3);
          if(Obj[ObjNr].Zeit==5) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr1);
          if(Obj[ObjNr].Zeit==4) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr1);
          if(Obj[ObjNr].Zeit==3) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr2);
          if(Obj[ObjNr].Zeit==2) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr3);
          if(Obj[ObjNr].Zeit==1) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr4);
          }

        if(Obj[ObjNr].Typ==Rauch) {
          if(Obj[ObjNr].Zeit==5) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 3, 3, SmokeFr1);
          if(Obj[ObjNr].Zeit==4) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 3, 3, SmokeFr2);
          if(Obj[ObjNr].Zeit==3) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 5, 5, SmokeFr3);
          if(Obj[ObjNr].Zeit==2) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 7, 7, SmokeFr4);
          if(Obj[ObjNr].Zeit==1) RemoveGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 7, 7, SmokeFr5);
          }

        // Jetzt rechnen und organisieren und gucken und bla und bla und bla

        Obj[ObjNr].Zeit--;

        if((Obj[ObjNr].Zeit<1)||(Obj[ObjNr].Zeit>15)) {
          Obj[ObjNr].Typ=Frei; }
        else {
          Obj[ObjNr].RealX+=Obj[ObjNr].KursX;
          Obj[ObjNr].RealY+=Obj[ObjNr].KursY;
          }

        if((Obj[ObjNr].RealX<-512)||(Obj[ObjNr].RealX>640<<8)||(Obj[ObjNr].RealY<24<<8)||(Obj[ObjNr].RealY>480<<8)) Obj[ObjNr].Typ=Frei;

        // Jetzt wieder alles gnadenlos auf den Screen zaubern

        if(Obj[ObjNr].Typ==Funke) {
          if((Obj[ObjNr].RealX>1<<8)&&(Obj[ObjNr].RealX<639<<8)&&(Obj[ObjNr].RealY>25<<8)&&(Obj[ObjNr].RealY<478<<8)) {
            *(MapA+((Obj[ObjNr].RealY>>8)*640)+(Obj[ObjNr].RealX>>8))=(15-Obj[ObjNr].Zeit);
            }
          }

        if(Obj[ObjNr].Typ==Explosion) {
          if(Obj[ObjNr].Zeit==6) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr3);
          if(Obj[ObjNr].Zeit==5) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr1);
          if(Obj[ObjNr].Zeit==4) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr1);
          if(Obj[ObjNr].Zeit==3) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr2);
          if(Obj[ObjNr].Zeit==2) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr3);
          if(Obj[ObjNr].Zeit==1) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 18, 18, ExploFr4);
          }
        if(Obj[ObjNr].Typ==Rauch) {
          if(Obj[ObjNr].Zeit==5) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 3, 3, SmokeFr1);
          if(Obj[ObjNr].Zeit==4) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 3, 3, SmokeFr2);
          if(Obj[ObjNr].Zeit==3) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 5, 5, SmokeFr3);
          if(Obj[ObjNr].Zeit==2) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 7, 7, SmokeFr4);
          if(Obj[ObjNr].Zeit==1) PasteGfx(Obj[ObjNr].RealX>>8, Obj[ObjNr].RealY>>8, 7, 7, SmokeFr5);
          }
        }
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Lädt eine Datei in den RAM
//
// Parameter:     STRPTR Datei                  (STRPTR auf den Dateinamen)
//                APTR ZielBuffer               (Pointer auf die Zieladresse)
//                LONG Laenge                   (Länge der einzuladenden Datei)
//
// globale Var's: -Keine-

void LadeFile(STRPTR Datei, APTR ZielBuffer, LONG Laenge) {
  LONG file=NULL;

  file=Open(Datei, MODE_OLDFILE);
  if(file==NULL) {
    Printf("Open() failed. (file <%s>).\n", Datei);
    AllesZu(65535);
    }
  Read(file, ZielBuffer, Laenge);
  Close(file);
  }

// ------------------------------------------------------------------------------------------------
// Schließt allen Müll und gibt den RAM endlich wieder frei für sinnvolle Zwecke
//
// Parameter:     LONG FehlerCode               (FehlerCode, der beim Verlassen des Progs den User stört)
//
// globale Var's: -das werde ich mir jetzt mal großzügig sparen-

void AllesZu(LONG FehlerCode) {
  // AHI aufhalten und niederringen

  if(actrl) AHI_ControlAudio(actrl, AHIC_Play, FALSE, TAG_DONE);
  for(UBYTE d=0; d<MAXSAMPLES; d++) UnloadSample(d);
  FreeAudio();
  CloseAHI();

  // Speicher freigeben

  if(GameScr) FreeMem(GameScr, 340000);
  if(Palette) FreeMem(Palette, 4000);
  if(Buffer)  FreeMem(Buffer , 4000);
  if(GfxTab)  FreeMem(GfxTab , 20000);
  if(Wurzel)  FreeMem(Wurzel , 160000);
  if(Titel)   FreeMem(Titel  , 60000);
  if(Pause)   FreeMem(Pause  , 1000);
  if(Schaf)   FreeMem(Schaf  , 20000);

  // RTGMaster zurückrufen  (Ruuuuuhig, Brauner! Ist ja nur 'n Gewitter.)

  #ifndef __PPC__
      if (RScreen) CloseRtgScreen(RScreen);
      if (sr) FreeRtgScreenModeReq(sr);
  #else
      if (RScreen) PPCCloseRtgScreen(RScreen);
      if (sr) PPCFreeRtgScreenModeReq(sr);
  #endif

  // Librarys schließen

  if (RTGMasterBase) CloseLibrary((struct Library *) RTGMasterBase);
  if (LowLevelBase) CloseLibrary((struct Library *) LowLevelBase);

  // Jetzt ist Schulz

  if(FehlerCode>0) Printf("Game killed.\n");
  exit(FehlerCode);
  }

// ------------------------------------------------------------------------------------------------
// Schreibt Umriß mit angegebener Farbe
//
// Parameter:     LONG ZielX                    (X-Koordinate des Zielpunktes der Grafik)
//                LONG ZielY                    (Y-Koordinate des Zielpunktes der Grafik)
//                LONG Breite                   (Breite der anzuzeigenden Grafik)
//                LONG Hoehe                    (Höhe der anzuzeigenden Grafik)
//                UBYTE *GfxData                (Zeiger auf die Grafikdaten im Chunky-Format)
//                UBYTE Farbe

// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void Umriss(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData, UBYTE Farbe) {
  ZielY-=(Hoehe>>1); ZielX-=(Breite>>1);
  UBYTE *TempPtr;

  for(UWORD i=0; i<Hoehe; i++) {
    TempPtr=MapA+((ZielY+i)*640)+ZielX;
    for(UWORD j=0; j<Breite; j++) {
      if(*GfxData) *TempPtr=Farbe;
      GfxData++; TempPtr++;
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Schreibt Grafik auf den Game-Screen zur späteren Anzeige per Klatsch() (Mittelpunkt angeben !!!!)
//
// Parameter:     LONG ZielX                    (X-Koordinate des Zielpunktes der Grafik)
//                LONG ZielY                    (Y-Koordinate des Zielpunktes der Grafik)
//                LONG Breite                   (Breite der anzuzeigenden Grafik)
//                LONG Hoehe                    (Höhe der anzuzeigenden Grafik)
//                UBYTE *GfxData                (Zeiger auf die Grafikdaten im Chunky-Format)
//
// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void PasteGfx(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData) {
  ZielY-=(Hoehe>>1); ZielX-=(Breite>>1);
  UBYTE *TempPtr;

  if((ZielX>1)&&(ZielY>25)&&((ZielX+Breite)<638)&&((ZielY+Hoehe)<477)) {
    for(UWORD i=0; i<Hoehe; i++) {
      TempPtr=MapA+((ZielY+i)*640)+ZielX;
      for(UWORD j=0; j<Breite; j++) {
        if(*GfxData) *TempPtr=*GfxData;
        GfxData++; TempPtr++;
        }
      }
    }
  else {
    for(UWORD i=0; i<Hoehe; i++) {
      TempPtr=MapA+((ZielY+i)*640)+ZielX;
      for(UWORD j=0; j<Breite; j++) {
        if(*GfxData) {
          if((ZielY+i>25)&&(ZielX+j>1)&&(ZielX+j<638)&&(ZielY+i<477)) *TempPtr=*GfxData;
          }
        GfxData++; TempPtr++;
        }
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Schreibt Grafik auf den Game-Screen (Diesmal ohne Maske, auch Schwarze werden gemalt) (Mittelpunkt!!!!!!!)
//
// Parameter:     LONG ZielX                    (X-Koordinate des Zielpunktes der Grafik)
//                LONG ZielY                    (Y-Koordinate des Zielpunktes der Grafik)
//                LONG Breite                   (Breite der anzuzeigenden Grafik)
//                LONG Hoehe                    (Höhe der anzuzeigenden Grafik)
//                UBYTE *GfxData                (Zeiger auf die Grafikdaten im Chunky-Format)
//
// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void PasteGfxNoMask(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData) {
  ZielY-=(Hoehe>>1); ZielX-=(Breite>>1);
  UBYTE *TempPtr;

  for(UWORD i=0; i<Hoehe; i++) {
    TempPtr=MapA+((ZielY+i)*640)+ZielX;
    for(UWORD j=0; j<Breite; j++) {
      *TempPtr=*GfxData;
      GfxData++; TempPtr++;
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Wie PasteGfxNoMask() jedoch kann hier schon ab Zeile 0 gemalt werden, und nicht erst ab 25
//
// Parameter:     LONG ZielX                    (X-Koordinate des Zielpunktes der Grafik)
//                LONG ZielY                    (Y-Koordinate des Zielpunktes der Grafik)
//                LONG Breite                   (Breite der anzuzeigenden Grafik)
//                LONG Hoehe                    (Höhe der anzuzeigenden Grafik)
//                UBYTE *GfxData                (Zeiger auf die Grafikdaten im Chunky-Format)
//
// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void PasteGfxNoMask2(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData) {
  ZielY-=(Hoehe>>1); ZielX-=(Breite>>1);
  UBYTE *TempPtr;

  for(UWORD i=0; i<Hoehe; i++) {
    TempPtr=MapA+((ZielY+i)*640)+ZielX;
    for(UWORD j=0; j<Breite; j++) {
      *TempPtr=*GfxData;
      GfxData++; TempPtr++;
      }
    }
  }


// ------------------------------------------------------------------------------------------------
// Löscht eine Grafik vom Game-Screen (wieder den Mittelpunkt angeben !!!!)
//
// Parameter:     LONG ZielX                    (X-Koordinate des Zielpunktes der Grafik)
//                LONG ZielY                    (Y-Koordinate des Zielpunktes der Grafik)
//                LONG Breite                   (Breite der zu löschenden Grafik)
//                LONG Hoehe                    (Höhe der zu löschenden Grafik)
//                UBYTE *GfxData                (Zeiger auf die Grafikdaten im Chunky-Format)
//
// globale Var's: UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void RemoveGfx(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData) {
  ZielY-=(Hoehe>>1); ZielX-=(Breite>>1);
  UBYTE *TempPtr;

  if((ZielX>1)&&(ZielY>25)&&((ZielX+Breite)<638)&&((ZielY+Hoehe)<477)) {
    for(UWORD i=0; i<Hoehe; i++) {
      TempPtr=MapA+((ZielY+i)*640)+ZielX;
      for(UWORD j=0; j<Breite; j++) {
        if(*GfxData) *TempPtr=0;
        GfxData++; TempPtr++;
        }
      }
    }
  else {
    for(UWORD i=0; i<Hoehe; i++) {
      TempPtr=MapA+((ZielY+i)*640)+ZielX;
      for(UWORD j=0; j<Breite; j++) {
        if(*GfxData) {
          if((ZielY+i>25)&&(ZielX+j>1)&&(ZielX+j<638)&&(ZielY+i<477)) *TempPtr=0;
          }
        GfxData++; TempPtr++;
        }
      }
    }

  }

// ------------------------------------------------------------------------------------------------
// Schwärzt (Nullt) eine rechteckige Fläche
//
// Parameter:     LONG x1                       (X-Koordinate der linken, oberen Ecke)
//                LONG y1                       (Y-Koordinate der linken, oberen Ecke)
//                LONG x2                       (X-Koordinate der rechten, unteren Ecke)
//                LONG y2                       (Y-Koordinate der rechten, unteren Ecke)
//
// globale Var's: UBYTE *GameScr;               (initialisierter Zeiger auf anzuzeigendes Bild)

void Schwarz(LONG x1, LONG y1, LONG x2, LONG y2) {
  UBYTE *TempPtr;

  if(x1<1) x1=1;
  if(x2>638) x2=638;

  for(LONG y=y1; y<y2; y++) {
    TempPtr=MapA+(y*640)+x1;
    for(LONG x=x1; x<x2; x++) {
      *TempPtr=0;
      TempPtr++;
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Initialisiert eine neue Bombe
//
// Parameter:     LONG  x                       (StartX)
//                LONG  y                       (StartY)
//                LONG  rx                      (KursX)
//                LONG  ry                      (KursY)
//                UBYTE Typ                     (Bombentyp)
//                UBYTE Besitzer                (abfeuerndes Team)
//
// globale Var's: struct Bombe Bo[10]           (Array von Bombenstrukturen)

void NeueBombe(LONG x, LONG y, LONG rx, LONG ry, UBYTE Typ, UBYTE Seite) {
  LONG Zahl=0;

  // Leeres Bombenfeld finden
  while ((Bo[Zahl].Typ>0)&&(Zahl<10)) { Zahl++}

  if (Zahl<10) {
    Bo[Zahl].Typ = Typ;
    Bo[Zahl].Dauer = 25;
    Bo[Zahl].Seite = Seite;
    Bo[Zahl].RealX = x;
    Bo[Zahl].RealY = y;
    Bo[Zahl].KursX = rx;
    Bo[Zahl].KursY = ry;
    SNDBomm=TRUE;
    }
  }

// ------------------------------------------------------------------------------------------------
// Läßt Bomben fliegen (und explodieren)
//
// Parameter:     - keine -
//
// globale Var's: struct Bombe  Bo[10]          (Array von Bombenstrukturen)
//                struct Raumer Fli[20]         (Array von Raumerstrukturen)
//                UBYTE *GameScr                (initialisierter Zeiger auf anzuzeigendes Bild)

void MachMaBombe() {
  LONG i,j,ax,ay, fl=0;
  BOOL BUMM=FALSE;
  for (i=0; i<10; i++) {
    if (Bo[i].Typ) {

      // Kollisionsabfrage gegen Wände
      if((Bo[i].RealX<44<<8)&&(Basis[0]==100)) {
        if((Bo[i].RealY>371<<8)&&(Bo[i].RealY<380<<8)) BUMM = TRUE;
        if(Bo[i].RealY>471<<8) BUMM = TRUE;
        }

      if((Bo[i].RealX>596<<8)&&(Basis[1]==100)) {
        if((Bo[i].RealY>125<<8)&&(Bo[i].RealY<135<<8)) BUMM = TRUE;
        if(Bo[i].RealY<32<<8) BUMM = TRUE;
        }

      //Kollisionen mit Laserstationen
      for (j=0; j<4; j++) {
        ax=(Bo[i].RealX>>8)-LS[j].RealX;
        ay=(Bo[i].RealY>>8)-LS[j].RealY;
        if((ax>-5)&&(ax<5)) {
          if((ay>-5)&&(ay<5)) BUMM=TRUE;
          }
        }

      // Kollisionsabfrage gegen feindliche Raumer
      if(Bo[i].Seite==Gruen) {
        for(j=10; j<20; j++) {
          if(Fli[j].Typ!=Tot) {
            fl=0;
            ax=Bo[i].RealX-Fli[j].RealX;
            ay=Bo[i].RealY-Fli[j].RealY;

            if((ax>-1024)&&(ax<1024)) fl=3;
            if((ay>-1024)&&(ay<1024)&&(fl==3)) BUMM = TRUE;
            }
          }
        }
      else {
        for(j=0; j<10; j++) {
          if(Fli[j].Typ!=Tot) {
            fl=0;
            ax=Bo[i].RealX-Fli[j].RealX;
            ay=Bo[i].RealY-Fli[j].RealY;

            if((ax>-1024)&&(ax<1024)) fl=3;
            if((ay>-1024)&&(ay<1024)&&(fl==3)) BUMM = TRUE;
            }
          }
        }

      // Kollision mit Bildschirmrand
      if ((Bo[i].RealX<1<<8)||(Bo[i].RealX>638<<8)||(Bo[i].RealY<25<<8)||(Bo[i].RealY>477<<8)) BUMM=TRUE;

      // Kollidiert oder Zeit zu Ende
      if ((BUMM==TRUE)||(Bo[i].Dauer<1)) {

        if (Bo[i].Typ==BoNormal) {
          Kawomm((Bo[i].RealX>>8),(Bo[i].RealY>>8), Mittel);
          }
        else {
          Kawomm((Bo[i].RealX>>8),(Bo[i].RealY>>8), Gross);
          }
        SNDRungs=TRUE;
        Bo[i].Typ = Nichts;
        BUMM=FALSE;
        }

      // Bombe wegmachen
      if ((Bo[i].RealX>1<<8)&&(Bo[i].RealX<639<<8)&&(Bo[i].RealY>24<<8)&&(Bo[i].RealY<478<<8)) *(MapA + (Bo[i].RealX >> 8) + (Bo[i].RealY >> 8) * 640) = 0;

      if (Bo[i].Typ) {
        // Weiterbewegen
        Bo[i].RealX += Bo[i].KursX;
        Bo[i].RealY += Bo[i].KursY;

        // Lebensdauer schrumpfen
        Bo[i].Dauer--;

        // Bombe neuzeichnen
        if ((Bo[i].RealX>1<<8)&&(Bo[i].RealX<639<<8)&&(Bo[i].RealY>24<<8)&&(Bo[i].RealY<478<<8)) *(MapA + (Bo[i].RealX >> 8) + (Bo[i].RealY >> 8) * 640) = 22;
        }
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Initialisiert neuen Laser
//
// Parameter:     UBYTE Typ                     Stark oder Normal
//                LONG  sx                      X-Startkoordinate
//                LONG  sy                      Y-Startkoordinate
//                LONG  zx                      X-Zielkoordinate
//                LONG  zy                      Y-Zielkoordinate
//
// globale Var's: struct Laser  Bo[20]          (Array von Bombenstrukturen)

void NeuerLaser(UBYTE Typ, LONG sx, LONG sy, LONG zx, LONG zy) {
  LONG Zahl=0;

  while ((La[Zahl].Typ!=0)&&(Zahl<20)) { Zahl++; }

  if(Zahl<20) {
    La[Zahl].Typ=Typ;
    La[Zahl].Frame=0;
    La[Zahl].StartX=sx;
    La[Zahl].StartY=sy;
    La[Zahl].ZielX=zx;
    La[Zahl].ZielY=zy;
    }
  }

// ------------------------------------------------------------------------------------------------
// Verarbeitet alle Laserschüsse
//
// Parameter:     - keine -
//
// globale Var's: struct Laser  La[10]          (Array von Laserstrukturen)
//                *UBYTE MapA                   (Zeiger auf Bild in der Grafikkarte)
//                struct RTGScreen RScreen      (Struktur des RTGScreens)

void MachMaLaser() {
  LONG i;

  for (i=0; i<20; i++) {
    if(La[i].Typ) {
      La[i].Frame++;
      // Letztes Frame setzt la.Frame auf -irgendwas
      if((La[i].Frame<0)&&(La[i].Typ==LA_Stark)) La[i].Typ=Nichts;
      if((La[i].Frame<0)&&(La[i].Typ==LA_Normal)) La[i].Typ=Nichts;

      // Letztes Frame ist Schwarz
      if((La[i].Frame==LA_DaStark)&&(La[i].Typ==LA_Stark)) La[i].Frame=-26;
      if((La[i].Frame==LA_DaNormal)&&(La[i].Typ==LA_Normal)) La[i].Frame=-29;

      if(La[i].Typ!=Nichts) {
        if(La[i].Typ==LA_Stark) {
          DrawRtgLine(RScreen, MapA, 26+La[i].Frame, La[i].StartX, La[i].StartY, La[i].ZielX, La[i].ZielY);
          }
        if(La[i].Typ==LA_Normal) {
          DrawRtgLine(RScreen, MapA, 29+La[i].Frame, La[i].StartX, La[i].StartY, La[i].ZielX, La[i].ZielY);
          }
        }
      }
    }
  }

// ------------------------------------------------------------------------------------------------
// Sucht nahstes Ziel
//
// Parameter:     LONG x                        (X-Koordinate, von der aus gesucht wird)
//                LONG y                        (Y-Koordinate, von der aus gesucht wird)
//                UBYTE Seite                   (Wer greift an? (Grün/Blau))
//                LONG MaxEntf                  (Maximale Entfernung zum Zielobjekt)
//
// globale Var's: struct Raumer Fli[20]         (Array von Raumerstrukturen)
//

UBYTE SucheZiel(LONG x, LONG y, UBYTE Seite, LONG MaxEntf) {
  UBYTE t=99;
  MaxEntf*=MaxEntf;

  if(Seite==Gruen) {
    LONG ax, ay, ent, g;

    for(g=10; g<20; g++) {
      ax=x-(Fli[g].RealX>>8);
      ay=y-(Fli[g].RealY>>8);

      ent=(ax*ax+ay*ay);

      if((ent<MaxEntf)&&(Fli[g].Typ)&&(!Fli[g].Raucher)) {
        MaxEntf=ent;
        t=g;
        }
      }

    // Laserstationen in der Nähe?
    for(g=0; g<2; g++) {
      ax=x-LS[g+2].RealX; ay=y-LS[g+2].RealY;
      ent=(ax*ax+ay*ay);
      if(ent<MaxEntf) {
        MaxEntf=ent;
        t=22+g;
        }
      }
    }
  else {
    LONG ax, ay, ent, g;

    for(g=0; g<10; g++) {
      ax=x-(Fli[g].RealX>>8);
      ay=y-(Fli[g].RealY>>8);

      ent=(ax*ax+ay*ay);

      if((ent<MaxEntf)&&(Fli[g].Typ)&&(!Fli[g].Raucher)) {
        MaxEntf=ent;
        t=g;
        }
      }
    // Laserstationen in der Nähe?
    for(g=0; g<2; g++) {
      ax=x-LS[g].RealX; ay=y-LS[g].RealY;
      ent=(ax*ax+ay*ay);
      if(ent<MaxEntf) {
        MaxEntf=ent;
        t=20+g;
        }
      }
    }
  return(t);
  }

// ------------------------------------------------------------------------------------------------
// Arbeitet alle Laserstationen ab
//
// Parameter:     - keine -
//
// globale Var's: struct Raumer Fli[20]         (Array von Raumerstrukturen)
//                struct LaserSt LS[4]          (Array der Laserstationen)

BOOL MachMaLaserSt() {
  UBYTE zg, i;
  BOOL Zahlen;

  for(i=0; i<4; i++) {
    if(LS[i].Energie>-20) {
      if((LS[i].Energie<LS_kaputt)&&(LS[i].Energie>0)) {
        if((GlobTime&3)==0) Kawomm(LS[i].RealX, LS[i].RealY, Mini);
        }
      if((LS[i].Energie<LS_MaxEnergie)&&((GlobTime&31)==0)&&(LS[i].Energie>0)) LS[i].Energie++;
      if((LS[i].Energie<5)&&(LS[i].RealX>-100)) {
        LS[i].Energie=-20;
        Kawomm(LS[i].RealX, LS[i].RealY, Mittel);
        SNDFetz=TRUE;
        LS[i].RealX=-200;
        LS[i].RealY=-200;
        if(((i&1)==1)&&(Basis[i>>1]==100)) Basis[i>>1]=70;
        }

      if((i&1)==0) {
        zg=SucheZiel(LS[i].RealX, LS[i].RealY, i>>1, LS_SchussEntf);

        if((LS[i].Pause==0)&&(LS[i].Energie>=LS_kaputt)) {
          if((i<2)&&(zg>9)&&(zg<20)) {
            NeuerLaser(LA_Stark, LS[i].RealX, LS[i].RealY, Fli[zg].RealX>>8, Fli[zg].RealY>>8);
            Fli[zg].Energie-=5;
            LS[i].Pause=8;
            SNDStation=TRUE;
            Kawomm(Fli[zg].RealX>>8,Fli[zg].RealY>>8,Mini);
            if(Fli[zg].Energie<1) {
              Fli[zg].Raucher=TRUE;
              Fli[zg].Aktiv=FALSE;
              Fli[zg].MaxEnergie=20+(rand()&15);
              }
            Zahlen=TRUE;
            }

          if((i>1)&&(zg<10)) {
            NeuerLaser(LA_Stark, LS[i].RealX, LS[i].RealY, Fli[zg].RealX>>8, Fli[zg].RealY>>8);
            Fli[zg].Energie-=5;
            LS[i].Pause=8;
            SNDStation=TRUE;
            Kawomm(Fli[zg].RealX>>8,Fli[zg].RealY>>8,Mini);
            if(Fli[zg].Energie<1) {
              Fli[zg].Raucher=TRUE;
              Fli[zg].Aktiv=FALSE;
              Fli[zg].MaxEnergie=20+(rand()&15);
              }
            Zahlen=TRUE;
            }
          }
        if(LS[i].Pause>0) LS[i].Pause--;
        }

      if(i==0) PasteGfx(LS[i].RealX, LS[i].RealY, 6, 6, GrLaser);
      if(i==1) PasteGfx(LS[i].RealX, LS[i].RealY, 6, 6, Schild);
      if(i==2) PasteGfx(LS[i].RealX, LS[i].RealY, 6, 6, BlLaser);
      if(i==3) PasteGfx(LS[i].RealX, LS[i].RealY, 6, 6, Schild);
      }
    }

  return(Zahlen);
  }

// ------------------------------------------------------------------------------------------------
// Arbeitet beide Basen ab (Explosionen und blabla)
//
// Parameter:     - keine -
//
// globale Var's: LONG Basis[2]                 (Array der Basen)
//

void MachMaBasis() {
  LONG i;
  for (i=0; i<2; i++) {
    if ((Basis[i]<100)&&(Basis[i]>0)) {
      if ((Basis[i]>1)&&((Basis[i]&1)==0)) {
        if (i==0) Kawomm((rand()%35)+3,(rand()%100)+375,Winzig);
        if (i==1) Kawomm((rand()%35)+600,(rand()%100)+28,Winzig);
        SNDRungs=TRUE;
        }
      if (Basis[i]==1) {
        if (i==0) Kawomm(20,425,GeradezuUnglaublich);
        if (i==1) Kawomm(620,78,GeradezuUnglaublich);
        SNDRungs=TRUE;
        SNDFetz=TRUE;
        }
      Basis[i]--;
      }
    }
  }


// ------------------------------------------------------------------------------------------------
// Öffnet und initialisiert AHI
//
// Parameter:     - keine -
//
// globale Var's: - hab jetzt keinen Bock -
//

BOOL OpenAHI() {

  if(AHImp = CreateMsgPort()) {
    if(AHIio = (struct AHIRequest *)CreateIORequest(AHImp,sizeof(struct AHIRequest))) {

      AHIio->ahir_Version = 4;

      if(!(AHIDevice = OpenDevice(AHINAME, AHI_NO_UNIT, (struct IORequest *) AHIio,NULL))) {
        AHIBase = (struct Library *) AHIio->ahir_Std.io_Device;
        return TRUE;
      }
    }
  }
  FreeAudio();
  return FALSE;
}


// ------------------------------------------------------------------------------------------------
// Schließt AHI wieder
//
// Parameter:     - keine -
//
// globale Var's: - wie oben -
//

void CloseAHI() {

  if(!AHIDevice) CloseDevice((struct IORequest *)AHIio);

  AHIDevice=-1;

  if(AHIio) DeleteIORequest((struct IORequest *)AHIio);
  AHIio=NULL;

  if(AHImp) DeleteMsgPort(AHImp);
  AHImp=NULL;
}

// ------------------------------------------------------------------------------------------------
// Öffnet AHI-Requester und allokiert die Audiokanäle
//
// Parameter:     - keine -
//
// globale Var's: - siehe oben -
//

BOOL AllocAudio() {
  struct AHIAudioModeRequester *req;
  BOOL   rc = FALSE;

  // Requester öffnen
  req = AHI_AllocAudioRequest(AHIR_PubScreenName, NULL,
                              AHIR_TitleText,     "choose AHI-blahblah",
                              AHIR_DoMixFreq,     TRUE,
                              TAG_DONE);

  if(req) {          // erfolgreich?
    if(AHI_AudioRequest(req, TAG_DONE)) {
      actrl = AHI_AllocAudio(                          //Wenn ja, dann reserviere mal
          AHIA_AudioID,         req->ahiam_AudioID,
          AHIA_MixFreq,         req->ahiam_MixFreq,
          AHIA_Channels,        CHANNELS,
          AHIA_Sounds,          MAXSAMPLES,
          AHIA_PlayerFunc,      NULL,
          AHIA_PlayerFreq,      INT_FREQ<<16,
          AHIA_MinPlayerFreq,   INT_FREQ<<16,
          AHIA_MaxPlayerFreq,   INT_FREQ<<16,
          TAG_DONE);

      if(actrl) {      // Hat's geklappt?
        AHI_ControlAudio(actrl, AHIC_MixFreq_Query, &mixfreq, TAG_DONE);  //Dann ev. Mixen initialisieren
        rc = TRUE;
      }
    }
    AHI_FreeAudioRequest(req);  // Und Requester freigeben
  }
  return rc;
}

// ------------------------------------------------------------------------------------------------
// Gibt die Audiokanäle wieder frei
//
// Parameter:     - keine -
//
// globale Var's: - siehe eins drüber -
//

void FreeAudio() {

  if(actrl) AHI_FreeAudio(actrl);
  actrl = NULL;
}

// ------------------------------------------------------------------------------------------------
// Lädt ein Sample ein (!!RAW!! 8Bit oder 16Bit), gibt dann SampleID zurück, oder AHI_NOSOUND, wenn
// es schiefgeht
//
// Parameter:     STRPTR filename               (Dateiname des einzuladenden Samples)
//                ULONG type                    (Typ des Samples (meist RAW 8Bit))
//
// globale Var's: - siehe eins drüber -
//

UWORD LoadSample(STRPTR filename, ULONG type) {
  struct AHISampleInfo sample;
  APTR *samplearray = samples;
  UWORD id = 0, rc = AHI_NOSOUND;
  ULONG file;

  // Sucht ein freies Sample

  while(*samplearray) {
    id++;
    samplearray++;
    if(id >= MAXSAMPLES) {
      return AHI_NOSOUND;
    }
  }

  file = Open(filename, MODE_OLDFILE);

  if(file) {
    int length;

    Seek(file, 0, OFFSET_END);
    length = Seek(file, 0, OFFSET_BEGINNING);
    *samplearray = AllocVec(length, MEMF_PUBLIC);
    if(*samplearray) {
      Read(file, *samplearray, length);

      sample.ahisi_Type = type;
      sample.ahisi_Address = *samplearray;
      sample.ahisi_Length = length / AHI_SampleFrameSize(type);

      if(! AHI_LoadSound(id, AHIST_SAMPLE, &sample, actrl)) {
        rc = id;
      }
    }
    Close(file);
  }
  return rc;
}

// ------------------------------------------------------------------------------------------------
// Wirft ein Sample im hohen Bogen aus dem RAM (die Var zur Höhe des Bogens hab' ich jetzt
// mal rausgelassen)
//
// Parameter:     id                            (ID des rauszuwerfenden Samples)
//
// globale Var's: - siehe eins drüber -
//

void UnloadSample(UWORD id) {

  AHI_UnloadSound(id, actrl);
  FreeVec(samples[id]);
  samples[id] = NULL;
}

// ------------------------------------------------------------------------------------------------
// Spielt ein Sample ab (auf 8300 Hertz)
//
// Parameter:     WORD SampleID                 (ID des Samples (siehe Sample-Definitionen))
//
// globale Var's: - siehe eins drüber -
//

void  SpielMaSample(WORD SampleID) {
  Kanal++; Kanal&=3;

  AHI_Play(actrl, AHIP_BeginChannel,  Kanal,
                  AHIP_Freq,          8300,
                  AHIP_Vol,           0x10000,
                  AHIP_Pan,           0xc000,
                  AHIP_Sound,         SampleID,
                  AHIP_LoopSound,     AHI_NOSOUND,
                  AHIP_EndChannel,    NULL,
                  TAG_DONE,           NULL);
  }


// ------------------------------------------------------------------------------------------------
// Spielt ein Sample ab (auf beliebigen Herzen)
//
// Parameter:     WORD SampleID                 (ID des Samples (siehe Sample-Definitionen))
//                LONG Freq                     (Anzahl der Herzen)
//
// globale Var's: - siehe eins drüber -
//

void  SpielMaSample2(WORD SampleID, LONG Freq) {
  Kanal++; Kanal&=3;

  AHI_Play(actrl, AHIP_BeginChannel,  Kanal,
                  AHIP_Freq,          Freq,
                  AHIP_Vol,           0x10000,
                  AHIP_Pan,           0xc000,
                  AHIP_Sound,         SampleID,
                  AHIP_LoopSound,     AHI_NOSOUND,
                  AHIP_EndChannel,    NULL,
                  TAG_DONE,           NULL);
  }


// ------------------------------------------------------------------------------------------------
// Überprüft, welche Samples des Users Ohr erfreuen sollen und erfreut dann
//
// Parameter:     - Keine -
//
// globale Var's: - die ganzen Sound-BOOLs -
//

void  MachMaSounds() {
  if(SNDStation) {
    SNDStation=FALSE;
    SpielMaSample(SND_StatLaser);
    }

  if(SNDRungs) {
    SNDRungs=FALSE;
    SpielMaSample(SND_BombExplo);
    }

  if(SNDFetz) {
    SNDFetz=FALSE;
    SpielMaSample(SND_RaumerExplo);
    }

  if(SNDMiniLaser) {
    SNDMiniLaser=FALSE;
    SpielMaSample(SND_FightLaser);
    }

  if(SNDBigLaser) {
    SNDBigLaser=FALSE;
    SpielMaSample(SND_SFightLaser);
    }

  if(SNDBomm) {
    SNDBomm=FALSE;
    SpielMaSample(SND_BombShot);
    }
  }


