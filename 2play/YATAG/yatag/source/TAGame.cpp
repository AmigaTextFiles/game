// Das ultimative TaktikActionGame - JETZT NEU mit dem Plus an Taktik!
// (simples Nachmachen von Heiko Müller's BattleXII)
// ©1998 Dreamworlds Development / Stefan Schulze / Thomas Schulze

// In diesem Moment erscheint Engelchen und Teufelchen auf der linken und
// rechten Schulter von Stefan Schulze.

// Engelchen:  "Du klaust dem armen Mann einfach seine Spielidee?"
// Teufelchen: "Ach lass den quatschen. Alles wird heutzutage abgekupfert."
// Engelchen:  "Gar nicht wahr! Warum sollte er jetzt anfangen zu klauen? Stefan ist
//             sonst ein SO einfallsreiches Genie."
// Teufelchen: "Da gebe ich Dir recht, aber Stefan ist auch faul. Und außerdem sind der Hauptgrund
//             des Neuprogrammierens wohl eher die kleinen Ungereimheiten des BattleXIIWB"
// Engelchen:  "Na und? Das kann man ja auch anders regeln!"
// Teufelchen: "Quatsch nich sauer!" (Er holt einen Baseball-Schläger hervor und holt probeweise damit aus)
//             (Engelchen nimmt eine große Gabel aus der Tasche und schwingt sie prüfend hin und her)
// Engelchen:  "Das kann er doch gar nicht mit seinem Gewissen verein...." ("Doch, kann ich." murmelt Stefan
//             und Engelchen wird mit einem leisem "Uuuaaah" von der Schulter geschnipst.)

// So, wo war ich stehen geblieben... ?

#include <stdlib.h>
#include <time.h>

#include <exec/types.h>
#include <clib/exec_protos.h>
#include <clib/lowlevel_protos.h>
#include <clib/dos_protos.h>
#include <clib/rtgmaster_protos.h>
#include <rtgmaster/rtgmaster.h>
#include <rtgmaster/rtgsublibs.h>

#include "defines.h"

// ------------------------------------------------------------------------------------------------

extern void  InitAlles();
extern void  LadeFile(STRPTR Datei, APTR ZielBuffer, LONG Laenge);
extern void  AllesZu(LONG FehlerCode);
extern void  Schwarz(LONG x1, LONG y1, LONG x2, LONG y2);
extern void  Umriss(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData, UBYTE Farbe);
extern void  PasteGfx(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
extern void  PasteGfxNoMask(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
extern void  PasteGfxNoMask2(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
extern void  RemoveGfx(LONG ZielX, LONG ZielY, LONG Breite, LONG Hoehe, UBYTE *GfxData);
extern void  Klatsch();
extern void  NeuesObjekt(UBYTE Type, LONG x, LONG y, LONG rx, LONG ry, LONG Pause);
extern void  MachMaObjekte();
extern void  Kawomm(LONG x, LONG y, UBYTE Dicke);
extern void  RefreshZahl();
extern void  RefreshREnerg();
extern void  MachMaRaumer();
extern void  SetzeKursGruen(LONG kx, LONG ky);
extern void  SetzeKursBlau(LONG kx, LONG ky);
extern void  RefreshWand();
extern void  NeueBombe(LONG x, LONG y, LONG rx, LONG ry, UBYTE Typ, UBYTE Seite);
extern void  MachMaBombe();
extern void  NeuerLaser(UBYTE Typ, LONG sx, LONG sy, LONG zx, LONG zy);
extern void  MachMaLaser();
extern UBYTE SucheZiel(LONG x, LONG y, UBYTE Seite, LONG MaxEntf);
extern BOOL  MachMaLaserSt();
extern void  MachMaBasis();
extern BOOL  OpenAHI();
extern void  CloseAHI();
extern BOOL  AllocAudio();
extern void  FreeAudio();
extern UWORD LoadSample(STRPTR filename, ULONG type);
extern void  UnloadSample(UWORD id);
extern void  SpielMaSample(WORD SampleID, ULONG Frequenz);
extern void  SpielMaSample2(WORD SampleID, LONG Freq);
extern void  MachMaSounds();

// ------------------------------------------------------------------------------------------------

struct Library *RTGMasterBase=NULL;
struct Library *LowLevelBase=NULL;

struct ScreenReq *sr=NULL;
struct RtgScreen *RScreen=NULL;
UBYTE *MapA;
int format=0;
LONG GlobTime = NULL;

LONG *Palette = NULL;
ULONG *Wurzel = NULL;
UBYTE *Buffer = NULL, *GameScr = NULL, *GfxTab = NULL, *Titel = NULL, *Pause = NULL, *Schaf=NULL;

struct Objekt Obj[500]={0};
struct Raumer Fli[20]={0};
struct KeyQuery kq[25]={0};
struct Bombe Bo[10]={0};
struct Laser La[20]={0};
struct LaserSt LS[4]={0};
LONG  Basis[2]={100, 100}; // Basis-Zustand: 100 klappt, 99-2 kleine Explosionen, 1 ganz große Ex, 0 tot

WORD SmpID[16]={0};

APTR samples[MAXSAMPLES]={0};
BOOL SNDStation=FALSE, SNDRungs=FALSE, SNDFetz=FALSE, SNDMiniLaser=FALSE, SNDBigLaser=FALSE, SNDBomm=FALSE;
UBYTE Kanal;

struct Library      *AHIBase;
struct MsgPort      *AHImp     = NULL;
struct AHIRequest   *AHIio     = NULL;
BYTE                 AHIDevice = -1;
struct AHIAudioCtrl *actrl     = NULL;

LONG mixfreq = 0;

// ------------------------------------------------------------------------------------------------

int main(void) {
    InitAlles();

    // Hier gehts los
    BOOL Schulz=FALSE, Zahlen=FALSE, Neustart=FALSE, GruenTot=FALSE, BlauTot=FALSE, KeySteuer=TRUE, FirstStart=TRUE;
    ULONG Freude1, Freude2, Taste, i, KeySteuerPause=0;
    LONG wf=0, cl1, cl2;

    while (!Schulz) {
      Neustart=FALSE;
      // Raumer initialisieren
      for(i=0; i<10; i++) {
        Fli[i].MaxEnergie=20;      // Jeder kriegt 20 Energie

        if(i<5) Fli[i].Typ=Fighter; else Fli[i].Typ=Bomber;

        if(i==0||i==4) {
          Fli[i].Typ=SFighter;
          Fli[i].MaxEnergie=10;    // Die Superfighter ein bißchen weniger
          }

        if(i==5||i==9) {
          Fli[i].Typ=SBomber;
          Fli[i].MaxEnergie=10;    // Die Superbomber auch
          }

        // die grünen Raumer

        Fli[i].Seite=Gruen;
        Fli[i].KursX=0;
        Fli[i].KursY=0;
        Fli[i].RealX=8<<8;
        Fli[i].RealY=(385+(i*8))<<8;
        Fli[i].Energie=Fli[i].MaxEnergie;
        Fli[i].Aktiv=FALSE;
        Fli[i].GerAktiv=0;
        Fli[i].Raucher=FALSE;
        Fli[i].Ballern=TRUE;
        Fli[i].Befehl=Nichts;

        // die blauen Raumer werden größtenteils kopiert

        Fli[i+10].Typ=Fli[i].Typ;
        Fli[i+10].Seite=Blau;
        Fli[i+10].KursX=0;
        Fli[i+10].KursY=0;
        Fli[i+10].RealX=632<<8;
        Fli[i+10].RealY=(40+(i*8))<<8;
        Fli[i+10].Energie=Fli[i].Energie;
        Fli[i+10].MaxEnergie=Fli[i].MaxEnergie;
        Fli[i+10].Aktiv=FALSE;
        Fli[i+10].GerAktiv=0;
        Fli[i+10].Raucher=FALSE;
        Fli[i+10].Ballern=TRUE;
        Fli[i+10].Befehl=Nichts;
      }

      // Stationen initialisieren

      LS[0].RealX=120;             // NICHT!!! in 256steln
      LS[0].RealY=330;
      LS[0].Energie=LS_MaxEnergie;
      LS[0].Pause=0;
      LS[1].RealX=45;             // NICHT!!! in 256steln
      LS[1].RealY=475;
      LS[1].Energie=LS_MaxEnergie;
      LS[1].Pause=0;
      LS[2].RealX=520;             // NICHT!!! in 256steln
      LS[2].RealY=175;
      LS[2].Energie=LS_MaxEnergie;
      LS[2].Pause=0;
      LS[3].RealX=595;             // NICHT!!! in 256steln
      LS[3].RealY=28;
      LS[3].Energie=LS_MaxEnergie;
      LS[3].Pause=0;


      for(i=0; i<10; i++) Bo[i].Typ=Nichts;
      for(i=0; i<500; i++) Obj[i].Typ=Nichts;
      for(i=0; i<20; i++) La[i].Typ=Nichts;
      Basis[0]=100; Basis[1]=100;

      RefreshZahl();
      RefreshREnerg();
      Schwarz(1,26,639,478);
      GruenTot=FALSE; BlauTot=FALSE;
      wf=0;

      MachMaLaserSt();
      RefreshWand();
      MachMaRaumer();
      PasteGfx(320, 240, 420, 120, Titel);
      if(FirstStart) {
        FirstStart=FALSE;
        SpielMaSample2(SND_Knaller, 22050);
        Delay(140);
        }

      //Klatsch();

      LONG SchafZ=0;
      while(!GruenTot) {
        LONG SchafX, SchafY, SchafA, Tilt;
        if(SchafZ<10000) SchafZ++;
        if(SchafZ==200) {    // 8 Sekunden
          SchafZ=10000;
          SchafX=660;
          SchafY=479-16;
          SchafA=0;
          }

        if(SchafZ==10000) {
          RemoveGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (SchafA*1024)));
          SchafX-=2;
          SchafA=(SchafA+1)&1;
          PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (SchafA*1024)));

          if(SchafX==320) {
            SchafZ=10001;
            PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (2*1024)));
            }

          Tilt=rand()&63;
          if(Tilt==12) SpielMaSample2(SND_Schaf, 7500+(rand()&4095));
          }

        if(SchafZ==10030) {
          SchafY++;
          Schwarz(300, 400, 350, 477);
          PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + 5*1024));

          if(SchafY==498) SchafZ=0;
          }

        if((SchafZ>10002)&&(SchafZ<10030)) {
          SchafZ++;
          Schwarz(SchafX-16, SchafY-16, SchafX+16, SchafY+15);
          PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (5*1024)));
          }

        if((SchafZ==10010)||(SchafZ==10014)||(SchafZ==10025)) {
          Schwarz(SchafX-16, SchafY-16, SchafX+16, SchafY+15);
          PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (6*1024)));
          }

        if(SchafZ==10002) {
          SchafZ++;
          Schwarz(SchafX-16, SchafY-16, SchafX+16, SchafY+15);
          PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (4*1024)));
          }

        if(SchafZ==10001) {
          SchafZ++;
          Schwarz(SchafX-16, SchafY-16, SchafX+16, SchafY+15);
          PasteGfx(SchafX, SchafY, 32, 32, (UBYTE *)(Schaf + (3*1024)));
          }

        //Klatsch();

        Freude1=ReadJoyPort(1);
        Freude2=ReadJoyPort(0);
        Taste=GetKey();
        if(Freude1&JPF_BUTTON_RED) GruenTot=TRUE;
        if(Freude2&JPF_BUTTON_RED) GruenTot=TRUE;
        if(Taste&0x200000) GruenTot=TRUE;
        if(Taste==69) {
          GruenTot=TRUE;
          Schulz=TRUE;
          }
        Delay(2);
        }

      RemoveGfx(320, 240, 420, 120, Titel);
      Schwarz(200, 440, 638, 477);
      GruenTot=FALSE;
      cl1=clock();

      while((!Schulz)&&(!Neustart)) {
        Freude1=ReadJoyPort(1);
        Freude2=ReadJoyPort(0);
        QueryKeys(kq, 25);
        Taste=GetKey();         

        if((Taste==19)||(Taste==0x5F)) {
          BOOL PauseZuEnde = FALSE;
          ULONG z;
          for (z=14; z>0; z--) {
            Umriss(320, 240, 49, 17, Pause, z);
            //Klatsch();
            }
          while(!PauseZuEnde) {
//            Freude1=ReadJoyPort(1);
//            Freude2=ReadJoyPort(0);
            Taste=GetKey();         
            if(Taste==64) PauseZuEnde=TRUE;
            }
          for (z=1; z<15; z++) {
            Umriss(320, 240, 49, 17, Pause, z);
            //Klatsch();
            }
          RemoveGfx(320, 240, 49, 17, Pause);
          }

        // Player Grün bewegen
        if(Freude1&JPF_LEFT) SetzeKursGruen(-1, 0);
        if(Freude1&JPF_RIGHT) SetzeKursGruen(1, 0);
        if(Freude1&JPF_UP) SetzeKursGruen(0, -1);
        if(Freude1&JPF_DOWN) SetzeKursGruen(0, 1);

        // Player Blau bewegen
        if (KeySteuer) {
          if(kq[23].kq_Pressed) SetzeKursBlau(-1, 0);
          if(kq[22].kq_Pressed) SetzeKursBlau(1, 0);
          if(kq[20].kq_Pressed) SetzeKursBlau(0, -1);
          if(kq[21].kq_Pressed) SetzeKursBlau(0, 1);
          }
        else {
          if(Freude2&JPF_LEFT) SetzeKursBlau(-1, 0);
          if(Freude2&JPF_RIGHT) SetzeKursBlau(1, 0);
          if(Freude2&JPF_UP) SetzeKursBlau(0, -1);
          if(Freude2&JPF_DOWN) SetzeKursBlau(0, 1);
          }

        //Feuer Grün
        if(Freude1&JPF_BUTTON_RED) {
          for (i=0; i<10; i++) {
            if ((Fli[i].Typ)&&(Fli[i].Aktiv)&&(!Fli[i].Raucher)) {
              // Bomber?
              if ((Fli[i].RealX>30<<8)||(Fli[i].RealY<371)) {
                if ((Fli[i].Typ==Bomber)&&(Fli[i].Ballern)) {
                  NeueBombe(Fli[i].RealX,Fli[i].RealY,(Fli[i].KursX<<2),(Fli[i].KursY<<2),BoNormal, Gruen);
                  Fli[i].Ballern = FALSE;
                  }
                if ((Fli[i].Typ==SBomber)&&(Fli[i].Ballern)) {
                  NeueBombe(Fli[i].RealX,Fli[i].RealY,(Fli[i].KursX<<2),(Fli[i].KursY<<2),BoSuper, Gruen);
                  Fli[i].Ballern = FALSE;
                  }
                }
              // Fighter?
              if((Fli[i].Typ==Fighter)&&(!Fli[i].GerBall)) {
                UBYTE zg;
                zg=SucheZiel(Fli[i].RealX>>8, Fli[i].RealY>>8, Gruen, 40);
                if((zg>9)&&(zg<20)) {
                  Fli[zg].Energie--;
                  SNDMiniLaser=TRUE;
                  Zahlen=TRUE;
                  Fli[i].GerBall=3;
                  Kawomm(Fli[zg].RealX>>8,Fli[zg].RealY>>8,Mini);

                  if(Fli[zg].Energie<1) {
                    Fli[zg].Raucher=TRUE;
                    Fli[zg].Aktiv=FALSE;
                    Fli[zg].MaxEnergie=20+(rand()&15);
                    }
                  NeuerLaser(LA_Normal, Fli[i].RealX>>8, Fli[i].RealY>>8, Fli[zg].RealX>>8, Fli[zg].RealY>>8);
                  }
                if((zg==22)||(zg==23)) {
                  LS[zg-20].Energie--;
                  if(LS[zg-20].Energie<0) LS[zg-20].Energie=0;
                  Zahlen=TRUE; Fli[i].GerBall=3;
                  SNDMiniLaser=TRUE;
                  NeuerLaser(LA_Normal, Fli[i].RealX>>8, Fli[i].RealY>>8, LS[zg-20].RealX, LS[zg-20].RealY);
                  }
                }
              // Superfighter?
              if((Fli[i].Typ==SFighter)&&(!Fli[i].GerBall)) {
                UBYTE zg;
                zg=SucheZiel(Fli[i].RealX>>8, Fli[i].RealY>>8, Gruen, 50);
                if((zg>9)&&(zg<20)) {
                  Fli[zg].Energie-=3;
                  Zahlen=TRUE;
                  SNDBigLaser=TRUE;
                  Fli[i].GerBall=5;
                  Kawomm(Fli[zg].RealX>>8,Fli[zg].RealY>>8,Mini);

                  if(Fli[zg].Energie<1) {
                    Fli[zg].Raucher=TRUE;
                    Fli[zg].Aktiv=FALSE;
                    Fli[zg].MaxEnergie=20+(rand()&15);
                    }
                  NeuerLaser(LA_Stark, Fli[i].RealX>>8, Fli[i].RealY>>8, Fli[zg].RealX>>8, Fli[zg].RealY>>8);
                  }
                if((zg==22)||(zg==23)) {
                  LS[zg-20].Energie--;
                  if(LS[zg-20].Energie<0) LS[zg-20].Energie=0;
                  Zahlen=TRUE; Fli[i].GerBall=5;
                  SNDBigLaser=TRUE;
                  NeuerLaser(LA_Stark, Fli[i].RealX>>8, Fli[i].RealY>>8, LS[zg-20].RealX, LS[zg-20].RealY);
                  }
                }
              }
            }
          }

        //Feuer Blau
        if((Freude2&JPF_BUTTON_RED)||(Taste&0x200000)) {
          for (i=10; i<20; i++) {
            if ((Fli[i].Typ)&&(Fli[i].Aktiv)&&(!Fli[i].Raucher)) {
              // Bomber?
              if ((Fli[i].RealX<610<<8)||(Fli[i].RealY>127<<8)) {
                if ((Fli[i].Typ==Bomber)&&(Fli[i].Ballern))  {
                  NeueBombe(Fli[i].RealX,Fli[i].RealY,(Fli[i].KursX<<2),(Fli[i].KursY<<2),BoNormal, Blau);
                  Fli[i].Ballern = FALSE;
                  }
                if ((Fli[i].Typ==SBomber)&&(Fli[i].Ballern))  {
                  NeueBombe(Fli[i].RealX,Fli[i].RealY,(Fli[i].KursX<<2),(Fli[i].KursY<<2),BoSuper, Blau);
                  Fli[i].Ballern = FALSE;
                  }
                }
              // Fighter?
              if((Fli[i].Typ==Fighter)&&(!Fli[i].GerBall)) {
                UBYTE zg;
                zg=SucheZiel(Fli[i].RealX>>8, Fli[i].RealY>>8, Blau, 40);
                if(zg<10) {  // Fighter gefunden
                  Fli[zg].Energie--;
                  Zahlen=TRUE;
                  Fli[i].GerBall=3;
                  SNDMiniLaser=TRUE;
                  Kawomm(Fli[zg].RealX>>8,Fli[zg].RealY>>8,Mini);

                  if(Fli[zg].Energie<1) {
                    Fli[zg].Raucher=TRUE;
                    Fli[zg].Aktiv=FALSE;
                    Fli[zg].MaxEnergie=20+(rand()&15);
                    }
                  NeuerLaser(LA_Normal, Fli[i].RealX>>8, Fli[i].RealY>>8, Fli[zg].RealX>>8, Fli[zg].RealY>>8);
                  }
                if((zg==20)||(zg==21)) {
                  LS[zg-20].Energie--;
                  if(LS[zg-20].Energie<0) LS[zg-20].Energie=0;
                  Zahlen=TRUE; Fli[i].GerBall=3;
                  SNDMiniLaser=TRUE;
                  NeuerLaser(LA_Normal, Fli[i].RealX>>8, Fli[i].RealY>>8, LS[zg-20].RealX, LS[zg-20].RealY);
                  }
                }
              // Superfighter?
              if((Fli[i].Typ==SFighter)&&(!Fli[i].GerBall)) {
                UBYTE zg;
                zg=SucheZiel(Fli[i].RealX>>8, Fli[i].RealY>>8, Blau, 50);
                if(zg<10) {
                  Fli[zg].Energie-=3;
                  Zahlen=TRUE;
                  Fli[i].GerBall=5;
                  SNDBigLaser=TRUE;
                  Kawomm(Fli[zg].RealX>>8,Fli[zg].RealY>>8,Mini);

                  if(Fli[zg].Energie<1) {
                    Fli[zg].Raucher=TRUE;
                    Fli[zg].Aktiv=FALSE;
                    Fli[zg].MaxEnergie=20+(rand()&15);
                    }
                  NeuerLaser(LA_Stark, Fli[i].RealX>>8, Fli[i].RealY>>8, Fli[zg].RealX>>8, Fli[zg].RealY>>8);
                  }
                if((zg==20)||(zg==21)) {
                  LS[zg-20].Energie-=3;
                  if(LS[zg-20].Energie<0) LS[zg-20].Energie=0;
                  Zahlen=TRUE; Fli[i].GerBall=5;
                  SNDBigLaser=TRUE;
                  NeuerLaser(LA_Stark, Fli[i].RealX>>8, Fli[i].RealY>>8, LS[zg-20].RealX, LS[zg-20].RealY);
                  }
                }
              }
            }
          }

        for(i=0; i<20; i++) {
          if(Fli[i].GerBall>0) Fli[i].GerBall--;
          }

        // Abfragen, ob Befehle gegeben wurden

        // Hier, ob Grün anhalten soll
        if(Taste&0x00010000) {
          for(i=0; i<10; i++) {
            if(Fli[i].Aktiv) {
              Fli[i].Aktiv=FALSE;
              Fli[i].Befehl=Anhalten;
              Zahlen=TRUE;
              }
            }
          }

        // Hier, ob Blau anhalten soll
        if(Taste&0x00020000) {
          for(i=10; i<20; i++) {
            if(Fli[i].Aktiv) {
              Fli[i].Aktiv=FALSE;
              Fli[i].Befehl=Anhalten;
              Zahlen=TRUE;
              }
            }
          }

        // Hier, ob Grün heimfahren soll
        if(Taste&0x00400000) {
          for(i=0; i<10; i++) {
            if(Fli[i].Aktiv) {
              Fli[i].Aktiv=FALSE;
              if ((Fli[i].RealY>378<<8)&&(Fli[i].RealX+Fli[i].RealY>420<<8)) {
                Fli[i].Befehl=Heimwaerts;
                }
              else {
                Fli[i].Befehl=Umweg;
                }
              Zahlen=TRUE;
              }
            }
          }

        // Hier, ob Blau anhalten soll
        if(Taste&0x00800000) {
          for(i=10; i<20; i++) {
            if(Fli[i].Aktiv) {
              Fli[i].Aktiv=FALSE;
              if ((Fli[i].RealY<127<<8)&&(Fli[i].RealX+Fli[i].RealY<725<<8)) {
                Fli[i].Befehl=Heimwaerts;
                }
              else {
                Fli[i].Befehl=Umweg;
                }
              Zahlen=TRUE;
              }
            }
          }

        // Umschalten zwischen Tastatursteuerung oder über Joystick / Schaltpause
        if (KeySteuerPause>0) KeySteuerPause--;

        if((kq[24].kq_Pressed)&&(KeySteuerPause==0)) {
          if(KeySteuer) KeySteuer=FALSE; else KeySteuer=TRUE;
          KeySteuerPause=5;
          }

        // Aktivierung der Raumer & Aktivierungspause
        for(i=0; i<20; i++) {
          if((kq[i].kq_Pressed)&&(Fli[i].GerAktiv==0)) {
            if(Fli[i].Aktiv) Fli[i].Aktiv=FALSE; else Fli[i].Aktiv=TRUE;
            Fli[i].GerAktiv=4;
            Zahlen=TRUE;
            }
          if(Fli[i].GerAktiv>0) Fli[i].GerAktiv--;
          }

        if((GruenTot)||(BlauTot)) {
          if(wf>200) {
            Schwarz(285+(wf-200), 220, 355+(wf-200), 240);
            Schwarz(285-(wf-200), 240, 355-(wf-200), 260);
            }
          else {
            Schwarz(285, 220, 355, 240);
            Schwarz(285, 240, 355, 260);
            }
          }

        if(MachMaLaserSt()) Zahlen=TRUE;

        MachMaBasis();
        MachMaObjekte();
        MachMaRaumer();
        MachMaBombe();
        MachMaSounds();
        RefreshWand();

        if(Zahlen) {
          Zahlen=FALSE;
          RefreshZahl();
          RefreshREnerg();
          }

        // Jetzt nachprüfen, ob eine Seite bereits ausgerottet wurde
        // Erst für Grün

        if(!GruenTot) {
          UBYTE e=0;
          for(i=0; i<10; i++) {
            if((Fli[i].Typ==Tot)||(Fli[i].Raucher)) e++;
            }
          if(e==10) {
            GruenTot=TRUE;
            if(!BlauTot) wf=500;
            }
          }

        // Dann Blau

        if(!BlauTot) {
          UBYTE e=0;
          for(i=10; i<20; i++) {
            if((Fli[i].Typ==Tot)||(Fli[i].Raucher)) e++;
            }
          if(e==10) {
            BlauTot=TRUE;
            if(!GruenTot) wf=500;
            }
          }

        // Läuft die Nachspielzeit schon?
        if((GruenTot)||(BlauTot)) {
          if(wf>0) wf-=4; else Neustart=TRUE;

          if((GruenTot)&&(BlauTot)) {
            PasteGfx(320, 240, 92, 17, DrawGame);
            }
          else {
            if(GruenTot) {
              if(wf>200) {
                PasteGfx(320+(wf-200), 230, 62, 17, BlWinner);
                PasteGfx(320-(wf-200), 250, 59, 17, GrLooser);
                }
              else {
                PasteGfx(320, 230, 62, 17, BlWinner);
                PasteGfx(320, 250, 59, 17, GrLooser);
                }
              }
            else {
              if(wf>200) {
                PasteGfx(320+(wf-200), 230, 59, 17, BlLooser);
                PasteGfx(320-(wf-200), 250, 62, 17, GrWinner);
                }
              else {
                PasteGfx(320, 230, 59, 17, BlLooser);
                PasteGfx(320, 250, 62, 17, GrWinner);
                }
              }
            }
          }

        //Klatsch();
        MachMaLaser();

        if(Taste==69) Schulz=TRUE;
        GlobTime++;

        // Timing
        cl2=clock()-cl1;
        if(cl2<Timing) Delay(Timing-cl2);
        cl1+=cl2;
//        RtgWaitTOF( RScreen);

        }
      }
    // Hier ist Schluß
    AllesZu(0);
    }

